package svc

import (
    "context"
    "github.com/estatie/id/pkg/auth/jwt"
    "github.com/zeromicro/go-zero/rest"
)

type ServiceContext struct {
	Config Config
	{{.middleware}}
}

func NewServiceContext(c Config) *ServiceContext {
	return &ServiceContext{
		Config: c,
		{{.middlewareAssignment}}
	}
}
