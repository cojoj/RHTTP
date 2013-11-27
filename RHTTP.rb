require 'socket'
require 'uri'

# Initializing new local server on given port
server = TCPServer.new 3000

# Root directory for web server
# Files from this dir will be reachable
WEB_ROOT = './web/public'

# Providing hash with common content types served through the web
CONTENT_TYPE = {
  'html'  => 'text/html',
  'txt'   => 'text/plain',
  'png'   => 'image/png',
  'jpg'   => 'image/jpeg',
  'css'   => 'text/css'
}

# If we don't find content type in hash above we assume that it is a byte code
DEFAULT_CONTENT_TYPE  = 'application/octet-stream'

# Method which searches for file extension
def content_type(path)
  # Getting file extension from the path given as a method argument
  extension = File.extname(path).split(".").last
  
  CONTENT_TYPE.fetch(extension, DEFAULT_CONTENT_TYPE)
end

def requested_file(request_line)
  
end

loop do
  Thread.start(server.accept) do |client|
    
    # Getting request-line and displaying it
    request = client.gets
    puts request
  
    # Getting the path of the resource server is asked for
    path = requested_file(request)
    
    # Checking if file exists and is not a directory
    if File.exists?(path) && !File.directory?(path)
      File.open(path, "rb") do |file| 
        client.print "HTTP/1.1 200 OK\r\n" +
                     "Content-Type: #{content_type(file)}\r\n" +
                     "Content-Length: #{file.size}\r\n" +
                     "Connection: close\r\n"
        client.print "\r\n" 
        
        # Copying the content of file to the client (socket)
        IO.copy_stream(file, client)
      end
    else
      message = "File not found\n"
      
      # Giving 404 error if file wasn't found in root directory
      client.print "HTTP/1.1 404 Not Found\r\n" +
                   "Content-Type: text/plain\r\n" +
                   "Content-Length: #{message.size}\r\n" +
                   "Connection: close\r\n"
      client.print "\r\n"
      
      client.print message            
    end
    # Closing the sessions with client (socket)
    client.close
  end
end