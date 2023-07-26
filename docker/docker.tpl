FROM golang:{{.Version}}alpine AS builder
ARG GIT_AUTH_TOKEN

LABEL stage=gobuilder

ENV CGO_ENABLED 0
RUN apk update --no-cache && apk add --no-cache git ca-certificates openssh-client {{if .HasTimezone -}}tzdata{{ end -}}

WORKDIR /build

ADD go.mod .
ADD go.sum .
RUN go mod download
COPY . .
{{if .Argument}}COPY {{.GoRelPath}}/etc /app/etc{{end}}

# we use another one with similar input and output filenames
RUN go build -ldflags="-s -w" -o /app/{{.ExeFile}} {{.GoFile}}

# compose final image
FROM {{.BaseImage}}

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
{{if .HasTimezone}}
COPY --from=builder /usr/share/zoneinfo/{{.Timezone}} /usr/share/zoneinfo/{{.Timezone}}
ENV TZ {{.Timezone}}
{{end}}
WORKDIR /app
COPY --from=builder /app/{{.ExeFile}} /app/{{.ExeFile}}
{{if .Argument}}COPY --from=builder /app/etc /app/etc{{end}}
{{if .HasPort}}EXPOSE {{.Port}}{{end}}
CMD ["./{{.ExeFile}}"{{.Argument}}]
