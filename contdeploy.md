# Continuous Deployment Exercise

There are two examples on continuous deployment setups included.  The first is a basic integrity-gitosis setup allowing integrity to run on a standard linux server.  The second is an Engine Yard specific setup that uses chef and integrity on the EY cloud environment.

## Integrity with Continuous Deployment Notifier

In these examples we used Integrity as our continuous integration server.  We have added a custom notifier that will let you run a deploy command upon a successful build.  To make this easy to install we forked Integrity and added the CD notifier to it.  I recommend you look over the commits to see what we did to add the notifier in case you want to repeat this for your own fork of Integrity.

    http://github.com/mghaught/integrity-cd

## Deploy Command

Before you can turn on your CD environment you'll need to determine what deploy command you want to use.  For the flingr example I used the following command:

    cap deploy && cap deploy:migrate

I made sure that the CI server had capistrano and all the permissions/ssh access to run all commands to the target server.  In my particular case both CI and the flingr app live on the same server.  It was a bit strange to have cap ssh to the same box but by setting up ssh keys it worked fine.  You may need to make more complicated deploy commands but this should be good enough to get your started.

## Install Instructions for Integrity-Gitosis

These instructions use Gitosis.  It would be easy enough to swap out another git based solution with post commit hooks to notify Integrity.  Integrity already has instructions on triggering the build from Github and other popular hosting services.  Please replace the yourdomain and yourapp references with the appropriate values for your project.

1. Install integrity under apache/passenger

    Install apache and passenger and configure to run integrity-cd rack app.

        <VirtualHost *:80>
          ServerName ci.yourdomain.com
          DocumentRoot /path/to/integrity-cd
        </VirtualHost>

    Checkout the deploy branch of integrity-cd.

        $ cd /path/to
        $ git clone git://github.com/mghaught/integrity-cd.git
        $ cd integrity-cd
        $ git branch --track deploy origin/deploy
        $ git checkout deploy

    Install bundled gems and create the sqlite database.

        $ bundle install --relock
        $ rake db

    Configure base_url

        $ vi init.rb
        . . .
        c.base_url = http://ci.yourdomain.com
        . . .

2. Setup your app's build in integrity

    - Name: Your App Name
    - Repo: <path to git repo>
    - Branch: master
    - Build: rake db:migrate && rake
    - Public: yes
    - Deploy notifications: yes
    - Deploy script: cap deploy && cap deploy:migrate

    Create dev and test databases according to database.yml
    
    Use integrity to manually fetch and build the app

3. Add webhook to gitosis

    Edit your git repository post-receive hook.

        $ sudo -u git vi /var/git/repositories/repo_name/hooks/post-receive
 
    Add Integrity build trigger and output for the 'pusher'
 
        . . .
        curl -s -d "" http://ci.yourdomain.com/yourapp/builds
        echo "Triggering build at http://ci.yourdomain.com/yourapp"
        . . .
 
    Make script executable

        $ chmod 755 post-receive

    Commit and push to your app's repo, see if the build triggers
 

 
# EngineYard CI/CD deploy details

Our project's application is already running at EY, so we just need to get Integrity set up for CI and CD.  We cloned integrity-cd and created an engineyard branch to contain the following configuration changes.

## Update init.rb for EY, commit, and push

        Integrity.configure do |c|
          c.database "sqlite3:../../shared/integrity.db"
          c.directory "../../shared/builds"
          c.base_url "http://ci.yourdomain.com"
          c.github "SECRET"
          # c.build_all!
          c.builder :threaded, 1
        end

## Install Integrity at EY

Use the dashboard to configure and deploy the integrity app.

- Application settings
    - repository: git://github.com/mghaught/integrity-cd.git
    - stack: rack 1.1.0
    - hostname: ci.yourdomain.com
    - add engineyard 0.3.2, bundler 0.9.25 gems

- Deploy settings
    - deploy checked
    - migrate with: rake db
    - git branch: engineyard

## The EY deploy user needs to be able to self-deploy yourproject

Make sure you get EY's beta command line tools enabled for your account.

1. set up the api key (one time)

    Log into EY instance and run:

        $ ey environments
        user: ey_user
        pass: ey_pass

2. Generate ssh key so deploy can ssh to himself (one time)

    Run ssh-keygen on the instance.

    Use EY dashboard to add the new public key.

    Associate the new key to your environment (click the pencil and check the new key).

    Rebuild the environment.

## A little bit of chef

EY's deploy process overwrites the user's `~/.ssh/config` file, so we also wrote a chef script to make sure the new key is recognized.  We won't cover the details of deploying and running custom EY chef scripts, but the recipe itself is super simple:

        execute "add_key_to_identity_files" do
          command %Q{
            echo "IdentityFile ~/.ssh/id_rsa" >> /home/deploy/.ssh/config
          }
        end

## Configure CI and CD for yourproject

Browse to http://ci.yourdomain.com and add a new project:

- Name: Project
- Repository URI: git@yourdomain.com:yourproject.git
- Branch to track: master
- Build script: bundle install --relock > bundle_install.log && rake ey_integrity
- Deploy notifications: on
- Deploy script: ey deploy your_ey_environment master

Your build script and notification configuration will vary.  You can find your_ey_environment by running the 'ey environments' command.

There is one very EY specific hack going on here, and it involves the way database.yml files are magically generated for you during deploys.  When we do the CI build, we aren't using EY to deploy the app and this magic doesn't happen.

Instead the ey_integrity rake task generates an appropriate database.yml file before testing the project.  It bases the new database.yml file on the one belonging to the parent integrity app.  The ey_integrity task then triggers the default 'test' task.
 