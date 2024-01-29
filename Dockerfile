###########################################################
# Dockerfile that builds a Palworld Gameserver
###########################################################
FROM cm2network/steamcmd

LABEL maintainer="saitcho@outlook.com"

ENV STEAMAPPID 2394010
ENV STEAMAPP palworld
ENV STEAMAPPDIR "/home/steam/palworld"
ENV DLURL https://raw.githubusercontent.com/dkirby-ms/palworld

RUN set -x \
	# Install, update & upgrade packages
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget=1.21-1+deb11u1 \
		ca-certificates=20210119 \
		iputils-ping=3:20210202-1 \
	# && mkdir -p "${STEAMAPPDIR}" \
	# Add entry script
	&& wget --max-redirect=30 "${DLURL}/master/scripts/entry.sh" -O "${STEAMAPPDIR}/entry.sh" \
	&& chmod +x "${STEAMAPPDIR}/entry.sh" \
	#&& chown -R "${USER}:${USER}" "${STEAMAPPDIR}/entry.sh" "${STEAMAPPDIR}" \
	# Clean up
	&& rm -rf /var/lib/apt/lists/*

ENV STEAMCMD_UPDATE_ARGS="" \
	ADDITIONAL_ARGS=""
    # SERVER_ADMINPW="replacethisyoumadlad" \
	# SERVER_PW="" \
	# SERVER_NAME="" \
	# SERVER_MAXPLAYERS=32 \
	# SERVER_TICKRATE=60 \
	# SERVER_PORT=7777 \
	

# Switch to user
USER ${USER}

WORKDIR ${STEAMAPPDIR}

CMD ["bash", "entry.sh"] 

# Expose ports
EXPOSE 14159/tcp \
	14159/udp