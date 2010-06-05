require "test/test_helper"
require "phusion_passenger/spawn_manager"

class PassengerTest < Test::Unit::TestCase
  def setup
    ActiveRecord::Base.connection.disconnect! # Otherwise AR metric tests fail
    @original = Vanity.playground.redis
    @server = PhusionPassenger::SpawnManager.new
    @server.start
    Thread.pass until @server.started?
    app_root = File.expand_path("myapp", File.dirname(__FILE__))
    @app = @server.spawn_application "app_root"=>app_root, "spawn_method"=>"smart-lv2"
  end

  def test_reconnect
    sleep 0.1
    socket = TCPSocket.new(*@app.listen_socket_name.split(":"))
    channel = PhusionPassenger::MessageChannel.new(socket)
    request = {"REQUEST_PATH"=>"/", "REQUEST_METHOD"=>"GET", "QUERY_STRING"=>" "}
    channel.write_scalar request.to_a.join("\0")
    response = socket.read.split("\r\n\r\n").last
    socket.close

    server, obj_id = response.split("\n")
    assert_equal @original.server, server
    assert_not_equal @original.object_id.to_s, obj_id
  end

  def teardown
    super
    @server.stop
  end

end
