RHTTP
===========
RHTTP is an acronym for *Ruby HTTP*. It is a very simple and not suffisticated HTTP server for my Uni classes. It's written to show how HTTP server works and with ruby it is very easy to present.

It is using `socet` class for initialization of `TCPserver`. What is more important it is **multi-user** so it can handle many connections at the same time (at least it should).

Usage
-----------
To run this scrpit you simply go to the directory with `RHTTP.rb` file and type in your terminal `ruby RHTTP.rb`. And this is it... Now you are running HTTP server. If you want you can pass one argument to the script which is **port** eg. `ruby RHTTP.rb 8080` will start server on `8080` port. Default one is set to `3000`. 
From this time you can hit inside your browser address: `localhost:3000` and it should display the `index.html` file from `web/public` directory. If you want to display another file you have to provide browser with full path rg. `localhost:3000/thi/is/the/test/file.html`
