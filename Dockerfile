#### Versão não otimizada ~ 846MB ####

#FROM  golang:1.20.3

#WORKDIR /app

#COPY go.mod ./
#COPY main.go ./

#RUN go build -o /server

# liberar a porta 8080
#EXPOSE 8080 

#CMD ["/server"]


# docker build . -t nome-para-imagem



#### Versão otimizada (multi-stage build) ~ 25.9MB ####

FROM golang:1.20.3 AS build

WORKDIR /app

COPY go.mod ./
COPY main.go ./

RUN go build -o /server

# Imagens distroless são minúsculas, utilizadas apenas para rodar binários.

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /server /server

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT [ "/server" ]