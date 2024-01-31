###########################################################
# Dockerfile that builds a Palworld Gameserver
###########################################################
FROM cm2network/steamcmd:root

LABEL maintainer="saitcho@outlook.com"

ENV USER steam
ENV STEAMAPPID 2394010
ENV STEAMAPP palworld
ENV STEAMAPPDIR "/data/palworld"
ENV DLURL https://raw.githubusercontent.com/dkirby-ms/palworld

RUN set -x \
	# Install, update & upgrade packages
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget=1.21-1+deb11u1 \
		ca-certificates=20210119 \
		iputils-ping=3:20210202-1 \
	# Add entry script
	&& wget --max-redirect=30 "${DLURL}/master/scripts/entry.sh" -O "entry.sh" \
	&& chmod +x "entry.sh" \
	&& chown -R "${USER}:${USER}" "entry.sh" \
	# Clean up
	&& rm -rf /var/lib/apt/lists/*

ENV STEAMCMD_UPDATE_ARGS="" \
	ADDITIONAL_ARGS=""

# Switch to user
USER ${USER}

WORKDIR ${STEAMAPPDIR}

CMD ["bash", "entry.sh"] 

# Expose ports
EXPOSE 14159/tcp \
	14159/udp