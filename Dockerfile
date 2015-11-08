# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang

# Pull down the resourced source and dep source.
RUN go get github.com/jmmcatee/cracklord/cmd/resourced

# Build the outyet command inside the container.
# (You may fetch or manage dependencies here,
# either manually or with a tool like "godep".)
RUN go build github.com/jmmcatee/cracklord/cmd/resourced

# Move the configuration file and required keys over.
# These should be in the same directory as your dockerfile.
ADD ./resourced.conf /go/
ADD ./cracklord_ca.pem /go/cracklord_ca.pem
ADD ./resourced.crt /go/resourced.crt
ADD ./resourced.key /go/resourced.key

# Run resourced command by default when the container starts.
ENTRYPOINT /go/resourced -conf /go/resourced.conf

# Allow access to the service on port 8080.
EXPOSE 8080

# build your docker with something like
# docker build -t resourced .
#
# then run your docker with something like
# docker run resourced --publish 9443:8080
