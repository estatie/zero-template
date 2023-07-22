package main

import (
"flag"
"fmt"
"github.com/ory/graceful"
{{.importPackages}}
)

var configFile = flag.String("f", "etc/{{.serviceName}}.yaml", "the config file")

func main() {

config := Config()
service := svc.NewServiceContext(config)

start := func() error {
// async if server mode enabled
// blocking if only worker mode enabled
err := Worker(service)
// blocking if server mode enabled
Server(service)
return err
}

err := graceful.Graceful(start, service.Shutdown)
if err != nil {
fmt.Println(err)
}
}

func Config() svc.Config {
flag.Parse()
var c svc.Config
conf.MustLoad(*configFile, &c)
return c
}

func Server(service *svc.ServiceContext) {

// it is not a server instance
if !service.Config.Instance.Server {
return
}

// create server
cfg := service.Config
server := rest.MustNewServer(cfg.RestConf)
defer server.Stop()

// register handlers
web.RegisterHandlers(server, service)

// start server
fmt.Printf("Starting server at %s:%d...\n", cfg.Host, cfg.Port)
server.Start()
fmt.Println("Server stopped.")
}

func Worker(service *svc.ServiceContext) error {

ctx := context.Background()
instance := service.Config.Instance

// it is not a worker instance
if !instance.Worker {
return nil
}

// there is no scheduler defined
if service.Scheduler(ctx) == nil {
return nil
}

// if server mode enabled, start scheduler async
if instance.Server {
service.Scheduler(ctx).StartAsync()
return nil
}

// if only worker mode enabled, start scheduler blocking
service.Scheduler(ctx).StartBlocking()

return nil
}
