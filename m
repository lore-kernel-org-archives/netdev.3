Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB86938236F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812312; cv=none; b=l0pKHklaxDG8ArFko5JTHWPOcTO59eR82/MtHic+UVAzqOkyF/II0qd2LKEPgiT7EqdDd+emlVUlrUkU288Lj2/xBdHGkVsHqTdWOuYTN/YKsjZsthFaFSTBKhigrM+RBXltQG2jwqrAV7MYr8V4zEj7Qfuo6k0VCwhwNS52QV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812312; c=relaxed/simple;
	bh=qfiumRZNOOBxIt4Wjx5A36lXwPtN5VGYVsEoCNH8XkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KL0bOTNO3C/OHE3D3WiqXukYt7Plfte/WqSlGv1NzRatxSgXHqsgcDxURcSVpIvfkjNttLBxgWTAoSP9W5reoV22Z71a4WznaIVs/22aLrhROWAvc0n/BuoKk4XB4xmGd2fNlODjTAHeENbfXFtDSYv4qjDIrSNXuFrCswTdGrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GdXg0klI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GdXg0klI"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso16437165e9.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791812309; x=1792417109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qi3jX1jPZHI08TqJ9Qu8FPH3+mnh+RCVzu67BT8aUCE=;
        b=GdXg0klIqmEbw5Xh/GLKUHSUWQSSHYO3rn5DCgfWmHkPkDmj8JhhQKAmYxF8lTYw+O
         MrR4F60n5ZVQXchxJ9S69G3ilcnPq184kud96K/BE1suKVRLreN1IVhpEpYIEVwfeOPK
         hSMGMmqluiAuMEGVGkKO/U1mNrYeyNvLxzqbpkCJjBd/JMQHL7fQCQh4hnNwIFy1IsCr
         OqltZGtxmluJyDV9pZf5tv67rFex7rxjSZG9wC5cImvWv7D9h5FklFAXtG5wBmH+sk/B
         2lyJNN6wAEAyZl1GRGF/ZrblgZS2LkXldcFM8GaJ51eRJyZINV/mghGPlSe7xnSFVCtF
         70WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812309; x=1792417109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qi3jX1jPZHI08TqJ9Qu8FPH3+mnh+RCVzu67BT8aUCE=;
        b=LnnZzcrdQZk5AWINp2Cx+LTm40AlnfMjufLBjmOqtmPiuK7Pk3zsRtfVLYbG7Vj3B3
         JqiByt9vC+SaPpJ/UvTf4GSut2iPNkbJ/HO5fqIuiWgc+vfpRfMM7ulYCEKbgj9kRcjX
         MWFOYV8P0EqLBF70/5V9VRzcneIQbtAOgGBp9mBPb4VwwvDXhtxZjo8ZPWX6979E4G3+
         D1h0MOuyehHWeFGJyE+5fLa46ahIawQMY93Iq7mjx57koS54f7QVCI7QWOCSkef3Ezx2
         UwVxKVVP1nHxYphQn7xN7CzaME76RPDMWV6a87hJMyT9jQnW06qwBiBz37wzOed+dicT
         jTFA==
X-Gm-Message-State: AFq9FYISlBc+lbmUDBsppcbNLJK0/4I18PvUgSZnZR4aoB9cX3lIGtYN
	Xv1WUpxmsSa2mxdKoKExq4u1HpPMOp+JH6dXCCf8F8KER5DxPWae9hdXU88XJ9rhPuAC98t3nuO
	C6weNEgr7O5YQoJrpJTa4VSBu0vA0lNIubJic/5bPOf1vVetymVLY4ND8KjEt716xDtg=
X-Gm-Gg: AYBFou15Cs8apMocjytx1U0XOMzP14Cy0/X/j0VCFsLNZ1d5qHXu9t5yRGeLFyubEPn
	AS4OHeKQASGSVD9N4eZzTBv0/8TipwMwHyzZSBsE7Fd/2YQ+QTSujEwvlXKL3Aeriyx/O7GJaGO
	PWd5sxJqN8w5buywJnykiZ86nmiAbnLY8iCfCozXelIK2Ue3dy+jTeYa3bTLyIth1MB/yVjy2ug
	1MCX+56TQB0yzJVj/QX0jytwGbJH8ol+ZCh5AG7Q30P/jmzChg5KkU/lq3ROOf91jmcskpCspAn
	48vgweynu/j2OvVodrBiR+2Cn0+NzD0jf2w+PNhDlAOfa9mwOGc9/PRGrYAoO42+PZOIFTjuJid
	1QksYtWJfYSk9J4aofMukDfL3p3tEpje9HPrW3yBcMrju5qHW+/zMsuzgsaQWmZQeCI6jWGZujT
	WO/eTIjeQmcTf2GbYDbiOz65Wuk7e46ugfY1mFNfgYOCQTLtE19MIl41QCjzdSpcsiHIENj9nWk
	VgSVI+BJuo=
X-Received: by 2002:a05:600c:154c:b0:4a1:7c7d:8881 with SMTP id 5b1f17b1804b1-4a18e4a9b88mr202098395e9.13.1791812307553;
        Mon, 12 Oct 2026 06:38:27 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:2e28:6511:e6d6:deef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm418114735e9.9.2026.10.12.06.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:38:27 -0700 (PDT)
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
	Neal Cardwell <ncardwell@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 4/6] selftests: ovpn: enable TCP_NODELAY on TCP sockets
Date: Mon, 12 Oct 2026 15:38:01 +0200
Message-ID: <20261012133809.2477063-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012133809.2477063-1-antonio@openvpn.net>
References: <20261012133809.2477063-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Baffo <marco@mandelbit.com>

Since openvpn 2.7.6, userspace unconditionally sets TCP_NODELAY on its
TCP sockets. Do the same in ovpn-cli by default, so that the TCP
selftests match that configuration.

Peers running 2.7.0 to 2.7.5 still leave Nagle enabled, and
mixed-version deployments will keep doing so for a while, so the option
can be turned off with OVPN_TCP_NODELAY=0. test-tcp-nagle.sh uses it to
keep running the TCP suite in that configuration.

The TCP peer ID capture assumes that every TCP segment starts with an
ovpn length prefix followed by a data header. TCP does not preserve
record boundaries, and enabling TCP_NODELAY makes this check unreliable.
Restrict the capture-based peer ID check to UDP.

Suggested-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Marco Baffo <marco@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/Makefile     |  1 +
 tools/testing/selftests/net/ovpn/common.sh    | 20 +++----
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 39 ++++++++++++++
 .../selftests/net/ovpn/test-tcp-nagle.sh      | 12 +++++
 tools/testing/selftests/net/ovpn/test.sh      | 54 +++++++++----------
 5 files changed, 86 insertions(+), 40 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-tcp-nagle.sh

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index 169f0464ac3a..35e4c9d4fc68 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -42,6 +42,7 @@ TEST_PROGS := \
 	test-symmetric-id-float.sh \
 	test-symmetric-id-tcp.sh \
 	test-symmetric-id.sh \
+	test-tcp-nagle.sh \
 	test-tcp.sh \
 	test.sh \
 # end of TEST_PROGS
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
index 3b612a8a18fe..00b80bc5157f 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -8,6 +8,7 @@
 
 #include <stdint.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <inttypes.h>
 #include <stdbool.h>
 #include <string.h>
@@ -16,6 +17,7 @@
 #include <arpa/inet.h>
 #include <net/if.h>
 #include <netinet/in.h>
+#include <netinet/tcp.h>
 #include <time.h>
 
 #include <linux/ovpn.h>
@@ -470,6 +472,33 @@ static int ovpn_parse_key_direction(const char *dir, struct ovpn_ctx *ctx)
 	return 0;
 }
 
+/* openvpn 2.7.6 and later always set TCP_NODELAY, so mirror that by
+ * default. Peers running 2.7.0 to 2.7.5 still leave Nagle enabled, and
+ * mixed-version deployments will keep doing so for a while, so let the
+ * selftests exercise that configuration too by setting OVPN_TCP_NODELAY=0.
+ */
+static bool ovpn_tcp_nodelay_wanted(void)
+{
+	const char *env = getenv("OVPN_TCP_NODELAY");
+
+	return !env || strcmp(env, "0");
+}
+
+static int ovpn_tcp_nodelay(int socket)
+{
+	int opt = 1;
+	int ret;
+
+	if (!ovpn_tcp_nodelay_wanted())
+		return 0;
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
@@ -606,6 +635,12 @@ static int ovpn_accept(struct ovpn_ctx *ctx)
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
@@ -623,6 +658,10 @@ static int ovpn_connect(struct ovpn_ctx *ovpn)
 		return -1;
 	}
 
+	ret = ovpn_tcp_nodelay(s);
+	if (ret < 0)
+		goto err;
+
 	switch (ovpn->remote.in4.sin_family) {
 	case AF_INET:
 		socklen = sizeof(struct sockaddr_in);
diff --git a/tools/testing/selftests/net/ovpn/test-tcp-nagle.sh b/tools/testing/selftests/net/ovpn/test-tcp-nagle.sh
new file mode 100755
index 000000000000..2d94d8e14d3d
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-tcp-nagle.sh
@@ -0,0 +1,12 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025 OpenVPN, Inc.
+#
+#  Author:	Antonio Quartulli <antonio@openvpn.net>
+
+# Peers running openvpn 2.7.0 to 2.7.5 leave Nagle enabled on their TCP
+# sockets. Keep exercising that configuration so it does not silently break.
+OVPN_PROTO="TCP"
+export OVPN_TCP_NODELAY=0
+
+source test.sh
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

