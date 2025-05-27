FROM docker.io/alpine

RUN apk add git openssh; adduser -Dh /home/user -G root user
WORKDIR /home/user
COPY . .
RUN mkdir .ssh; \
echo "Host github.com" > .ssh/config; \
echo "    IdentityFile=~/.ssh/gitkey" >> .ssh/config; \
touch .ssh/gitkey .ssh/gitkey.pub; \
echo "github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl" > .ssh/known_hosts;
COPY gitkey.pub .ssh/
RUN chown user -R .

USER user
VOLUME /home/user/.ssh/gitkey
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["sh"]

