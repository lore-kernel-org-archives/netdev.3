Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D049B461
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379848; cv=none; b=FnO2OHBbzNE3VU188o0/FqGysxMr69ud9AWmnyssQLgEBg00LMjmtdTUg+L5LIWlrDJyOw9HVOSk6BK5T6hgo/gpbzE3YxJYV3uenOC0KZkEtREBwAWu4nrj/NH9r7nxZWFclgwjHyYHveAWmt9T2GqeNOt42XGrGRSgU0sUamo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379848; c=relaxed/simple;
	bh=56V6nsIOZeWnT9HU++ArhhiamILEQEL/mOIjWEC0yGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMdDMCF95LeQyz0PQiZAyqufmG4AIpvOg8K9kCRYY+K7fbdsk/xEgCLt3TVl6KxiabNvG3ErZ9VezVmuqXyPyp1SRaOKuhQqE8fOI3vPP3YySA4xttbKiOlL49rR9NhJzsFQ8oH1eAGEucR2lh5X1/dVDaFNUe7lo0azg0eNcn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=eZZkNt4o; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="eZZkNt4o"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso35331175e9.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 06:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791379829; x=1791984629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PvCr0KW1XMvGSZfvlcy7YAwrTWE/tQeQZtQA2Y6abNM=;
        b=eZZkNt4oEZwQbe5GznkmtK2P1s0AHVsntrg8htE3LWzMZEqB+zJNsh70RtdAbklFoz
         /AUxaQcKs3v3wZcANT5qsq0B3ws+d4i3KsQ9juF/zArrSKEPW1PrAHi8XP4j/YUO31LY
         7RNpkjTA9cE0T+migJNKOKk67sb2BKUqhBoApqUqS0M3DcV0mFBOBOzEUKrOV58GivNQ
         zoTD/BUicUovVEVcvDZeynjgkyps/81Hur5bQ/cHih4c6h6K4/Yh+z/4cHhhjvnmlYdZ
         s1ntB1kwGmLPIVbCTdSxJ6gVOWydykON/LFfurM9lsVypDXJPPkcjey8bytn8FTHLFYD
         wLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791379829; x=1791984629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PvCr0KW1XMvGSZfvlcy7YAwrTWE/tQeQZtQA2Y6abNM=;
        b=BjVl0arHXw9qfjYpgEa1HIMATsDbXAhoEsBT+4bHyApiK80k1OM29ipIagThPVKnBI
         baGF7yr63dY+ScQgvajt2YIlMLSQ/C4KpF8pceLwXWx6uhfZz96jkrjv6mq5uunqG+/i
         NxTW6Y+KzdFzoWVUvre/lfp0i9cNt0hrK8m5Oq0JKxC762aMmzikl8tV3zW7Mi/1Hht/
         EVXK3v2wHKh+/ZMRJrB9rdoSrYJSE05Xi5JrJUqzasBjqNnSBt1vn1yMyhq/mER+Mbzr
         yToJUV5h/vUYnepoY+SZ6gdQULOXIil/keyrBCmnkpgXmGBbwvK0qDUXxIXx3NbiyAoi
         MRKw==
X-Gm-Message-State: AFuF++krLDgk6yOMdIijQLCWrSkt0/kV0t1LNJTa8cs7jXrf2jj+aU2X
	EhiBI68JX97B9qCkyBPi8juIA4lfkeA/hGMmS+TE9MwK8IlFxIG7By+gtmTpHXjLKL7g1ipsn6g
	kv831BsCxoamQuzz9GhqHeYrivxO0mwKrkF9IN3zVdXLm2KSg4gLfOViSfFVS4gyT
X-Gm-Gg: AYBFou2KPKXVEpt57E+5RxUt1PDqepRFDpzaIzkmYjtoteqp8xJZ1Si4qi4KAKEjtuz
	hrZpBbsGPAXxe97LlaptnsJIEpkpJn7hDe3Kg2sli+0R+jgSIbF0f1s2C9fI0GUlqTky/T81bkd
	aUhI9XWaAN01qpxp/WX+MUHnC/oSJuqYPZy+CycSDhKj4OMeqE1+WN7TmJHEmgboSH4O++hwXxY
	TH+c10vwbh8LrCk1sUJGJooxowhQw/LDWZjbldpFT8MNaEhADOuG+jBqR7aN9qqYpL5HkJUdmwB
	Hy+4x95A9yPMxa9mcCD6y6sXkOajgeySTdMzD5/QWwu7SCdZT600IdDZD6CbWzk6S/9WBE6gRv/
	RU8V9OPVdlsKzvrfGAmnXbJ8ZTQB5czQu8VcKG3s59APFVy0gGV6lQWiwo+fqWzMO4hYiKU68dR
	Fj0Q4SAczvGgnpNyrFEFyP0NGTRsWzn5k3iXsiG86du5yWJlGGzwdRmL66NprENcHaV80aFboc9
	42Kyp6pu0I=
X-Received: by 2002:a05:600c:8b54:b0:49c:fc6e:8caf with SMTP id 5b1f17b1804b1-4a18043c9b9mr38396635e9.19.1791379828754;
        Wed, 07 Oct 2026 06:30:28 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:7fc5:5cc8:bac1:5ef3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17a0fc2e4sm150356145e9.3.2026.10.07.06.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:30:27 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Marco Baffo <marco@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 4/7] selftests: ovpn: enable TCP_NODELAY on TCP sockets
Date: Wed,  7 Oct 2026 15:30:13 +0200
Message-ID: <20261007133018.1451958-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007133018.1451958-1-antonio@openvpn.net>
References: <20261007133018.1451958-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Baffo <marco@mandelbit.com>

Userspace now enables TCP_NODELAY by default. Enable it for
ovpn-cli's TCP sockets too.

The TCP peer ID capture assumes that every TCP segment starts with an
ovpn length prefix followed by a data header. TCP does not preserve
record boundaries, and enabling TCP_NODELAY makes this check unreliable.
Restrict the capture-based peer ID check to UDP.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/common.sh  | 20 +++-----
 tools/testing/selftests/net/ovpn/ovpn-cli.c | 23 +++++++++
 tools/testing/selftests/net/ovpn/test.sh    | 54 ++++++++++-----------
 3 files changed, 57 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 5e9c81e885e6..2f7851b82343 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -191,20 +191,14 @@ ovpn_setup_ns() {
 
 ovpn_build_capture_filter() {
 	# match the first four bytes of the openvpn data payload
-	if [ "${OVPN_PROTO}" == "UDP" ]; then
-		# For UDP, libpcap transport indexing only works for IPv4, so
-		# use an explicit IPv4 or IPv6 expression based on the peer
-		# address. The IPv6 branch assumes there are no extension
-		# headers in the outer packet.
-		if [[ "${2}" == *:* ]]; then
-			printf "ip6 and ip6[6] = 17 and ip6[48:4] = %s" "${1}"
-		else
-			printf "ip and udp[8:4] = %s" "${1}"
-		fi
+	# For UDP, libpcap transport indexing only works for IPv4, so
+	# use an explicit IPv4 or IPv6 expression based on the peer
+	# address. The IPv6 branch assumes there are no extension
+	# headers in the outer packet.
+	if [[ "${2}" == *:* ]]; then
+		printf "ip6 and ip6[6] = 17 and ip6[48:4] = %s" "${1}"
 	else
-		# openvpn over TCP prepends a 2-byte packet length ahead of the
-		# DATA_V2 opcode, so skip it before matching the payload header
-		printf "ip and tcp[(((tcp[12] & 0xf0) >> 2) + 2):4] = %s" "${1}"
+		printf "ip and udp[8:4] = %s" "${1}"
 	fi
 }
 
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 3b612a8a18fe..33f623d6b242 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -16,6 +16,7 @@
 #include <arpa/inet.h>
 #include <net/if.h>
 #include <netinet/in.h>
+#include <netinet/tcp.h>
 #include <time.h>
 
 #include <linux/ovpn.h>
@@ -470,6 +471,18 @@ static int ovpn_parse_key_direction(const char *dir, struct ovpn_ctx *ctx)
 	return 0;
 }
 
+static int ovpn_tcp_nodelay(int socket)
+{
+	int opt = 1;
+	int ret;
+
+	ret = setsockopt(socket, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));
+	if (ret < 0)
+		perror("setsockopt for TCP_NODELAY");
+
+	return ret;
+}
+
 static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int proto)
 {
 	struct sockaddr_storage local_sock = { 0 };
@@ -606,6 +619,12 @@ static int ovpn_accept(struct ovpn_ctx *ctx)
 		goto err;
 	}
 
+	if (ovpn_tcp_nodelay(ret) < 0) {
+		close(ret);
+		ret = -1;
+		goto err;
+	}
+
 	return ret;
 err:
 	close(ctx->socket);
@@ -623,6 +642,10 @@ static int ovpn_connect(struct ovpn_ctx *ovpn)
 		return -1;
 	}
 
+	ret = ovpn_tcp_nodelay(s);
+	if (ret < 0)
+		goto err;
+
 	switch (ovpn->remote.in4.sin_family) {
 	case AF_INET:
 		socklen = sizeof(struct sockaddr_in);
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index 392109d5e14e..e2e6ffdd29bb 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -137,35 +137,33 @@ ovpn_run_basic_traffic() {
 	local tcpdump_timeout="1.5s"
 
 	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-		# The first part of the data packet header consists of:
-		# - TCP only: 2 bytes for the packet length
-		# - 5 bits for opcode ("9" for DATA_V2)
-		# - 3 bits for key-id ("0" at this point)
-		# - 12 bytes for peer-id:
-		#     - with asymmetric ID: "${p}" one way and "${p} + 9" the
-		#	other way
-		#     - with symmetric ID: "${p}" both ways
-		header1=$(printf "0x4800000%x" ${p})
-		header2=$(printf "0x4800000%x" $((p + OVPN_ID_OFFSET)))
-		raddr=""
 		if [ "${OVPN_PROTO}" == "UDP" ]; then
+			# The first part of the data packet header consists of:
+			# - 5 bits for opcode ("9" for DATA_V2)
+			# - 3 bits for key-id ("0" at this point)
+			# - 3 bytes for peer-id:
+			#     - with asymmetric ID: "${p}" one way and "${p} + 9" the
+			#	other way
+			#     - with symmetric ID: "${p}" both ways
+			header1=$(printf "0x4800000%x" ${p})
+			header2=$(printf "0x4800000%x" $((p + OVPN_ID_OFFSET)))
 			raddr=$(awk "NR == ${p} {print \$3}" \
 				"${OVPN_UDP_PEERS_FILE}")
+			peer_ns="ovpn_peer${p}"
+
+			timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
+				tcpdump --immediate-mode -p -ni veth${p} -c 1 \
+				"$(ovpn_build_capture_filter "${header1}" "${raddr}")" \
+				>/dev/null 2>&1 &
+			tcpdump_pid1=$!
+			timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
+				tcpdump --immediate-mode -p -ni veth${p} -c 1 \
+				"$(ovpn_build_capture_filter "${header2}" "${raddr}")" \
+				>/dev/null 2>&1 &
+			tcpdump_pid2=$!
+
+			sleep 0.3
 		fi
-		peer_ns="ovpn_peer${p}"
-
-		timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
-			tcpdump --immediate-mode -p -ni veth${p} -c 1 \
-			"$(ovpn_build_capture_filter "${header1}" "${raddr}")" \
-			>/dev/null 2>&1 &
-		tcpdump_pid1=$!
-		timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
-			tcpdump --immediate-mode -p -ni veth${p} -c 1 \
-			"$(ovpn_build_capture_filter "${header2}" "${raddr}")" \
-			>/dev/null 2>&1 &
-		tcpdump_pid2=$!
-
-		sleep 0.3
 		ovpn_cmd_ok "send baseline traffic to peer ${p}" \
 			ip netns exec ovpn_peer0 \
 			ping -qfc 100 -w 3 5.5.5.$((p + 1))
@@ -173,8 +171,10 @@ ovpn_run_basic_traffic() {
 			ip netns exec ovpn_peer0 \
 			ping -qfc 100 -s 3000 -w 3 5.5.5.$((p + 1))
 
-		wait "${tcpdump_pid1}" || return 1
-		wait "${tcpdump_pid2}" || return 1
+		if [ "${OVPN_PROTO}" == "UDP" ]; then
+			wait "${tcpdump_pid1}" || return 1
+			wait "${tcpdump_pid2}" || return 1
+		fi
 	done
 }
 
-- 
2.55.0

