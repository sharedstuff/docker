# https://docs.docker.com/build/building/multi-stage/

# https://hub.docker.com/r/traefik/whoami
ARG baseRespository="traefik/whoami"
ARG baseTag="latest"

# https://hub.docker.com/_/alpine/
ARG releaseRepository="alpine"
ARG releaseTag="latest"

FROM ${baseRespository}:${baseTag} AS base

FROM ${releaseRepository}:${releaseTag}
COPY --from=base /whoami /

ENTRYPOINT [ "/whoami" ]

EXPOSE 80

HEALTHCHECK --interval=15s --timeout=5s --start-period=5s --retries=3 CMD [ "wget", "--spider", "localhost" ]
