Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BBE37C0ED
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812314; cv=none; b=pDcRe9oMA3oSKzzueTg1LVEV0J/iMYq7RDhJud4/HN2r4ILRKlC67kikzvqTE/RpYuVbYpMdiznmKAIOd7TyWM9EpXUDYyA0MCBTlXd3ARvq1e0PN8rYBhwaPJmMH0GBtqt7ANMFI/3P1C9aOcKq7JCRyMFlQWxmFcG7P5PiiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812314; c=relaxed/simple;
	bh=6MnWt8hZofU7TQz+e/z+mA04eU6Cjnjha55xILFMLGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfYqzMT+BVhshNEa+Vk/UcAbO5NB27mQMrMSQn9nwIyF2yg+wBkyz7hnrlGx/jSYfINT9eJNRqjUz7cG8eO8iMag/W5HTvJY52B/1Cc9J6LtmaYc1ktjK+fR8thSBiQbfbkJnchdCZlhT6lwXkGwUqeWLa8dCNcEFIlThA3ax+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HlCuja/0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HlCuja/0"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a0e1b0681bso13669035e9.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791812310; x=1792417110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yzm+aRvM2r2tsptMsSy1YlJZH0jS3sjpLdKXQX6Qbu0=;
        b=HlCuja/0maqq4xzuRP4hkX/SHrt9LNFXixiHsERd4Aa4MX+XubN0RqwA/zYRAWUqGS
         rzCEwZlSx5RMmTb9RttJWHnuSgcEVOqQ5GU5mTnhHsd81eAe4OZf0flze1dQX6p5KDFF
         3ZM8vuQXB4+R8kchURUGNxKlkS3vm8fK0NbTEc89YkGJEde7Yz6VoGMOORHGQR0VpHBP
         s6L7zgvk0vTfUb9QLPgp62lGtCqqymrxXzw4MtVRdFt1qkj2boUOMzKbWp3KdWhZPgHX
         M4DxjqiilirkJaIUsd6Ei7DgGjFgZR3gfMNRTpVKmVw+i8nnfXWVMjzlFIfopJ2Vr84C
         A6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812310; x=1792417110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yzm+aRvM2r2tsptMsSy1YlJZH0jS3sjpLdKXQX6Qbu0=;
        b=JRQFFYB7z2LM91DRFO5Lu81XIBTIf75SVsSqG81CvP32E5x6f1kAAmijsm9UtiT7M6
         Huk+QKb/uC+NJ0VwUkbAZxO+WEQsLAySpPTAKTnn7kMImAv6xxYHx0rLO8WR7W0nZfd+
         Jg5paswU2fR6kabCss0zWhic/ujK9i1isvANuZH6VU+YopRVr4Ex8hUpQ+yNUB4KfrRc
         1Sb0zN29tFzu9lpEZ7q/hmsN5/TtCDfEtZlyt3bkw7ZsDhkaWf3+Uq4L2vZdgSvMPIfS
         JQywSpNUb62r+1e/mMapHCMKaZjGYGxwteqOgr4AKAdFiiLeoafvk2PUscbk59Ktkq1X
         6FKQ==
X-Gm-Message-State: AFq9FYLdj7gayYodK7YGBKpw1VsUKfGzD4drczfPYInnSpne3jA5Jq9c
	bPhig3erJU7AqrHHgCbLh0YMbHhzqLwjkaLxYCGB0BQ1BPJXVyM3iCUcmzvhPQUcMMwvcs47YjB
	D/s5C6ShfoTYhP0kdPbj1kOTJ1jLLTMO0IKl2qqM8QaGRuMXbKbp1z/3622nOG2Y8/I8=
X-Gm-Gg: AYBFou3p/OdvKuooKl95lQkpdG0p0Ywk8HjDNjnE0GRyfSFGmZwql6obRm+rPBh+ZAU
	3Iz+NIDNEw2cMqqbQn13/OElYpXpBK2MlCqvxjm07LQ/eYN6d24qbk2UJRDtpGlEs8vXzjNQUWi
	N2gvwhWxxas+EyqcAFgEFCDH/1WVQl6GC2lmWBvVcoYRPOLIFQyop/XhvgK+B6zidXHu8b9gehi
	GOAwlF7m6CXdQuUs0+nKPwhQdgvJZVLWpVN1RTtSJUCe3B6TmEWwbdcG2hIVya4qqnpJ3vSSOdd
	8rJFRjNXcJx2ff+NvMw9X1WuugvQInmX3AlLKD1ZzN2vvIScoBeVKdklDsXJDA8YmLSlW/jpV19
	X4waNoi9G5trFyT4ajuUtepwJVEp8ZNUYbEtR6HGon36yfUuaj88CWJIkIs4RWkBMHFnV0Lf9vX
	W57nuW7m+ZAU7eFQ5LsVRvE3wfbEnv4QxojtVDF7yItQRS5swK3R3pWS3qpUdaWHunq71HTVxm5
	oTQhuo/rk1QHhldqfGHeQ==
X-Received: by 2002:a05:600c:4685:b0:4a0:27eb:49b with SMTP id 5b1f17b1804b1-4a18e4ae6fcmr196873945e9.30.1791812308665;
        Mon, 12 Oct 2026 06:38:28 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:2e28:6511:e6d6:deef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm418114735e9.9.2026.10.12.06.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:38:28 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next 5/6] selftests: ovpn: wait for the TCP server key setup before traffic
Date: Mon, 12 Oct 2026 15:38:02 +0200
Message-ID: <20261012133809.2477063-6-antonio@openvpn.net>
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

In TCP mode ovpn_add_peer() starts the server side from a background
subshell that first listens for the incoming connections and then
installs the data key of every peer. The subshell PID is discarded, so
nothing synchronizes the test against the key installation.

The sleep 5 that follows does not cover it: it elapses while "listen" is
still waiting for connections, and the peers only connect in the
subsequent ovpn_add_peer() iterations, so the key loop starts well after
that sleep has expired. Until now the test happened to work because of
the unrelated delays that ran in between.

Record the PID of the background subshell and wait for it once all the
peers have been registered, which is the earliest point at which
"listen" can have returned. A peer that was not given a key yet would
otherwise drop the server-to-client packets and make the first ping
fail.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/common.sh    | 61 ++++++++++++++++++-
 .../selftests/net/ovpn/test-close-socket.sh   |  2 +
 tools/testing/selftests/net/ovpn/test.sh      |  2 +
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 2f7851b82343..da732c64ffea 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -256,14 +256,19 @@ ovpn_add_peer() {
 		fi
 	else
 		if [ ${1} -eq 0 ]; then
+			OVPN_TCP_KEYS_LOG=$(mktemp)
 			(ip netns exec "${server_ns}" ${OVPN_CLI} listen tun0 \
 				1 ${M_ID} ${OVPN_TCP_PEERS_FILE} && {
+				rc=0
 				for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 					ip netns exec "${server_ns}" \
 						${OVPN_CLI} new_key tun0 ${p} \
-						1 0 ${OVPN_ALG} 0 data64.key
+						1 0 ${OVPN_ALG} 0 data64.key \
+						|| rc=1
 				done
-			}) &
+				exit ${rc}
+			}) >"${OVPN_TCP_KEYS_LOG}" 2>&1 &
+			OVPN_TCP_KEYS_PID=$!
 			sleep 5
 		else
 			peer_ns="ovpn_peer${1}"
@@ -281,6 +286,58 @@ ovpn_add_peer() {
 	fi
 }
 
+# In TCP mode the server accepts the peers and installs their data keys from a
+# background subshell. "listen" returns once a connection has been accepted for
+# every entry of the peers file, so the key installation runs after the last
+# ovpn_add_peer() call. Wait for that subshell before generating any traffic,
+# otherwise the first packets may race the key installation and get dropped for
+# lack of a key.
+#
+# The wait is bounded: both the accept loop and the subsequent receive in
+# ovpn-cli are unbounded, so a peer that never connects (for instance when
+# OVPN_NUM_PEERS is smaller than the number of entries in the peers file) would
+# otherwise hang the whole test instead of failing.
+OVPN_TCP_KEYS_TIMEOUT=${OVPN_TCP_KEYS_TIMEOUT:-30}
+
+ovpn_wait_tcp_keys() {
+	local deadline rc
+
+	[ -n "${OVPN_TCP_KEYS_PID:-}" ] || return 0
+
+	deadline=$((SECONDS + OVPN_TCP_KEYS_TIMEOUT))
+	while kill -0 "${OVPN_TCP_KEYS_PID}" 2>/dev/null; do
+		if [ "${SECONDS}" -ge "${deadline}" ]; then
+			printf '%s\n' \
+				"server-side key setup still running after ${OVPN_TCP_KEYS_TIMEOUT}s"
+			kill "${OVPN_TCP_KEYS_PID}" 2>/dev/null
+			wait "${OVPN_TCP_KEYS_PID}" 2>/dev/null
+			ovpn_dump_tcp_keys_log
+			return 1
+		fi
+		sleep 0.2
+	done
+
+	wait "${OVPN_TCP_KEYS_PID}"
+	rc=$?
+
+	# ovpn_cmd_run() has already removed the temporary file this subshell
+	# inherited, so without this its output would be lost and a failed
+	# new_key would only show up later as a ping failure.
+	if [ "${rc}" -ne 0 ]; then
+		ovpn_dump_tcp_keys_log
+	fi
+	rm -f "${OVPN_TCP_KEYS_LOG}"
+
+	return "${rc}"
+}
+
+ovpn_dump_tcp_keys_log() {
+	[ -s "${OVPN_TCP_KEYS_LOG:-}" ] || return 0
+
+	printf '%s\n' "--- server-side key setup output ---"
+	cat "${OVPN_TCP_KEYS_LOG}"
+}
+
 ovpn_compare_ntfs() {
 	local diff_rc=0
 	local diff_file
diff --git a/tools/testing/selftests/net/ovpn/test-close-socket.sh b/tools/testing/selftests/net/ovpn/test-close-socket.sh
index ec9a51bbf3c9..142dc14e2606 100755
--- a/tools/testing/selftests/net/ovpn/test-close-socket.sh
+++ b/tools/testing/selftests/net/ovpn/test-close-socket.sh
@@ -37,6 +37,8 @@ ovpn_prepare_network() {
 		ovpn_cmd_ok "register peer${p} in overlay" ovpn_add_peer "${p}"
 	done
 
+	ovpn_cmd_ok "wait for server-side key setup" ovpn_wait_tcp_keys
+
 	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 		peer_ns="ovpn_peer${p}"
 		ovpn_cmd_ok "set peer0 timeout for peer ${p}" \
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index e2e6ffdd29bb..0762fa83e4b5 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -45,6 +45,8 @@ ovpn_prepare_network() {
 		ovpn_cmd_ok "register peer${p} in overlay" ovpn_add_peer "${p}"
 	done
 
+	ovpn_cmd_ok "wait for server-side key setup" ovpn_wait_tcp_keys
+
 	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 		peer_ns="ovpn_peer${p}"
 		ovpn_cmd_ok "set peer0 timeout for peer ${p}" \
-- 
2.55.0

