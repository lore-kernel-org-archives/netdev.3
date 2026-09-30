Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBAA46D095
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807159; cv=none; b=cNR+0doD9LVShPMRFtAcp7Hclnl400h5bjHDyFHlKIu18JTNo9Ar2YPOwLV6tlJ80vfXc0qiYokADWccKUm5gBCsXcoP8p6zaQnxqgmaDbAEB3eU/Ykw8lZiaI28LMX2r6FuY8A9rUGAuN1JZwEfCTrDt89K2pweKPPmVJvM74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807159; c=relaxed/simple;
	bh=56V6nsIOZeWnT9HU++ArhhiamILEQEL/mOIjWEC0yGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbrkFzu6am4RYwlPPo2m0Gd6/2XYlaFuND4/0slnWDPRX4fGeL9SAB+eRoyGJTfPokSkmJz/uAzvoUmwl3bkL9Us1OuXMhuPL5ErIpeR2KdCm4cWvFfuoVqvgja5vRS00jtK+5ZkZQPJlkmcV130OjlcPEbDLFD6ePavmUfDzUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=QVL5alO/; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="QVL5alO/"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so34756765e9.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1790807155; x=1791411955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PvCr0KW1XMvGSZfvlcy7YAwrTWE/tQeQZtQA2Y6abNM=;
        b=QVL5alO/gWuJeaalBvH67ZEEoxIsNaLskxtohl0gI4bUFPz4Ab3uLYzF3Uny5V9bms
         pU7OUsfLSJP7buoOoF1jaT+ag29Kg/mBZ1jl0Dq64nMrXSvbdz2YmTYVlDvlT6K/iiL3
         lfDc4tDEyl6I3B08ugkG1C4NmhLWyTtxluHJi7r9LxzeOeMHfQG/MAbAF22kUjp97UKf
         7d5193f7LycGpCU+Fig0HxejO7tqiUdrO+n8ZvtkELggktXChK9rEU4U8mFEUW07XZiq
         td12WX7Q2Z3g/hPW19VfyBvgeHw5U934AM3wlQwgLWp9KdDb8B2yXPXiUoiJqMN6fb11
         iSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790807155; x=1791411955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PvCr0KW1XMvGSZfvlcy7YAwrTWE/tQeQZtQA2Y6abNM=;
        b=mRz6GnK7C6QV5Qtygj1WeFULpcqLTvzgQ580ft+XGAZ/CePoyGnTOw355Y2Mfh5Hiw
         dJArY0kTa9I9cHvtzWJYPdx07oizICWo8b6yCk4Xl0H5eYTUEHCZXV+qcp/4/1dvGdBk
         mo/XQpybUx+mU9X1yqpqFQySNFupJ56KBrBFIJdDIv3cw02735HMmPENphfzQDAp/KNg
         jSco9OKnuGhKVPNkpOcxYoodKDk5OoFV4Iv7XL3Fx0hhjMUOyHzs7b/sUaPHcKBgJVN2
         TTP+O6buEWWTSR4IlgoN3t3CQXncZItKlbUCcJBtkJ9F+wvUgB0j4Wh6+I6WMZLWvmBc
         3R3w==
X-Gm-Message-State: AFuF++mr1PX6ryyNk3c2ZAUvJrSXk9HvY+J9LSiKwGAS4Rzk1Dazlkoq
	AdwhXGX4TJifmoI/YcEEGTp2dTfDzNiqW0RVA0CR2jSOIoUhwJfcSSnJcIEmTt8Asio6zsEkoPd
	jkAPy4EV3+Mh/yxGn9QYbGWaxcmjiZZn6L1R9whjOqVd+eqpbivFqkcamnhx6SiJPgLc=
X-Gm-Gg: AYBFou3fvt1BgfH7kLWMhTrVkThgHqS3tN4af/IHixohoZsSnN0cjBRJjlQSXwtj5uF
	T6oTqCM7W2h2yULhU+OdwwGltQ8bCTOK0CBBYd0NXycKIdfWeUS1YuBgEIRflfGVNUYpFHdNGFA
	fCYIYZ7w1w9OB2uHxvAEsiQMhAO/2ozwFzGCGPciVLj/Y5Cf8dtr8OMkjYeNPHaE2vOdXFe5ChU
	VXe4mzu62ZsZJAkRrPsSkCVo0vsU/ba/xfBsFKBH3O75JZiwFtVp/QK2BaUqY+fOqE9o/3EM1ED
	Ziz5gZOoBIifkAM0Mv2uZpNGNDbbXO4ZspHwaIjPG/e8b8u5JlzOqETq/fGul8VOE09/TYEaN/S
	rV2pFBfhLPZQmxLUicJwJ+FGTRfovg1iYr+uh1+q60wNUTzoTIPd8FX+oeYFrgfbSpuXEDwp9QU
	FsZkRKyNRrik8c6Js1TWiPd3qLhYULMm57edVRK0fqrbgkXLlSu6xKixDTeMcQ8nhBuByZOjo+y
	6+pzf5LKYfXEArT2TEbfA==
X-Received: by 2002:a05:600c:c162:b0:4a0:18bc:3b94 with SMTP id 5b1f17b1804b1-4a01affb798mr42323765e9.18.1790807155480;
        Wed, 30 Sep 2026 15:25:55 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:5892:feba:7b41:58fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f979c05sm24433095e9.3.2026.09.30.15.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 15:25:54 -0700 (PDT)
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
Date: Thu,  1 Oct 2026 00:25:38 +0200
Message-ID: <20260930222542.3839327-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930222542.3839327-1-antonio@openvpn.net>
References: <20260930222542.3839327-1-antonio@openvpn.net>
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

