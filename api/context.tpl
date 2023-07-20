package svc

import (
    "context"
    "github.com/estatie/id/pkg/auth/jwt"
    "github.com/zeromicro/go-zero/rest"
)

type ServiceContext struct {
	Config Config
	{{.middleware}}
	UserAgentMiddleware rest.Middleware
	AccessMiddleware    rest.Middleware
	RefreshMiddleware   rest.Middleware
	VerifyMiddleware    rest.Middleware
}

func NewServiceContext(c Config) *ServiceContext {
	return &ServiceContext{
		Config: c,
		{{.middlewareAssignment}}
        UserAgent: jwt.UserAgentMiddleware,
        Access:    jwt.AccessMiddleware,
        Refresh:   jwt.RefreshMiddleware,
        Verify:    jwt.VerifyMiddleware(jwt.NewJWTAuth(c.JwtSecret)),
	}
}
