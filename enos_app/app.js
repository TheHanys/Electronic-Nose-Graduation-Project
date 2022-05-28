const server = require("http").createServer();
const port = process.env.port||5000;
var io=require("socket.io")(server);

io.on("connection",(Socket)=>{
    //autoConnect=true;
    console.log(Socket.id,"has Connected");



    Socket.on("Alert",(msg)=>{
        console.log(msg);
        
        //send alert to all clients except sender
        Socket.broadcast.emit("Alert",msg);
  

    });
});

server.listen(port,()=>{
    console.log("server started");
});