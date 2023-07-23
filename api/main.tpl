package main

import (
"flag"
"fmt"
"github.com/ory/graceful"
"github.com/estatie/pet/pkg/zero"
"github.com/zeromicro/go-zero/rest/httpx"
{{.importPackages}}
)

var configFile = flag.String("f", "etc/{{.serviceName}}.yaml", "the config file")

func main() {

config := Config()
service := svc.NewServiceContext(config)

// async if server mode enabled
// blocking if only worker mode enabled
err := Worker(service)

// blocking if server mode enabled
Server(service)

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

// provide middlewares
server.Use(zero.RequestIDMiddleware)

// register handlers
web.RegisterHandlers(server, service)
httpx.SetErrorHandlerCtx(zero.NewErrorHandler(log.New().Named(cfg.Name)).Handle)

// start server
fmt.Printf("Starting server at %s:%d...\n", cfg.Host, cfg.Port)
server.StartWithOpts(func(svr *http.Server) {
svr.RegisterOnShutdown(func() {
_ = service.Shutdown(context.Background())
})
})
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

// if only worker mode enabled
start := func() error {
// start scheduler blocking
service.Scheduler(ctx).StartBlocking()
return nil
}

// supposed service.Shutdown stops the scheduler
return graceful.Graceful(start, service.Shutdown)
}
