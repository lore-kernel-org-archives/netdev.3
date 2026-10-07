Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBFF4AD4BA
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379850; cv=none; b=TVGHctsh+XU34v9Ri6CIP5rTOnn89ileLrMNgpJA5cMP5wXhNBCY3fWOl0TfmzaQTRJqopbwDg+LlFIG1foWSdvbnoK2dwgUPxqyD2CH89X0TBOIfwTvcm2U42VP9bZpgHGWkIJy8cdl407dgL76Ix+zEykbllpjkx1CSrzxdw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379850; c=relaxed/simple;
	bh=OP4UczG7RhbrIKDJVVTqU95XYOsB7aui8QHW4jKbSsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ep3h0BJ+0ydoqUs47EGbDKD8VmVH8k1NccKvTjc2+l32CKm48cjo0EhDKaeODoIvCUPh2K94UUkdVAlF8kkXQ0hBXMDxywIADK0TaHiAhCPOZjIyRKyXgTGJrGLIZKChvUPPh+NauPe54E4hM/siuA+iQY3TFLDwzy7wPf4Zq24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=btC5rPY/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="btC5rPY/"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49ff680331aso42980775e9.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791379830; x=1791984630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NwCj5wuDGukY1wD/aQvGGuKOC8RlSIeZidaiO4gUwx0=;
        b=btC5rPY/LKYeM5qgTfzzZKYdk0ZscdLDhorD9QH3N+hBBDgEA2M9iT2xp3MK0sx8S/
         bukfwR+yNQ61LHqMvHw04b1Iggjmg+E2Vux4bM9WxJEmvtPE3A1kq6bWFYO5KvAWNRPh
         /55zS5CnomIRTsCkzSEalh5sX4VJ+NEbCyeZpGyGtcMZv2YIAShAClxLMNkWNdQtXvmc
         7sIGorSZATNraL/DDihrbgTAiEadziK9x7Myo3iGmHRANSYUJwaBd+W/w7GG0V2n3Zsy
         dhm8vMjQNKLOZIdApP37gq2NdYWkMP0H/BGWGY/Q8CRfv5yl+ecd3o01on5wJM2BIMIB
         WY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791379830; x=1791984630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NwCj5wuDGukY1wD/aQvGGuKOC8RlSIeZidaiO4gUwx0=;
        b=gO2fTwGZeF7yS7iA3Fwf/hc+eDyz1jHl5tiEIq6fLqPLoFW+mvQch3WiGzEIRhZAh2
         kBxH7UxoYRKrAGTbIjoR5y4mG8CseT3BMFCnuYL1oY2LR0uK2zlKLh40qYWyb5ZCGbVg
         a/WZQbbXRC6SWre+ivAnz8WqMeZTm2aa5Q0kSyiuC3k4Vk8whNj8jO1qBPp6/oc2s+ra
         RufxhdEffX1fJlPo0Zx9U26EHFtFcvPN+cUUV/mPKIon13h/NpkBQF0aRQlzAEws+5n0
         ia8nWEVvWULiYoODD3nvlvBIP0BEy+uXnqb7sQuG8V9ioklkoRY03OSuRwQ7XvFgA8zC
         ElvQ==
X-Gm-Message-State: AFuF++kkipbkHXT05OAjct2X2RpaC0BpdbQ8Jm3gYUxTgSlSm5naji+I
	TCVfPouRj5SZBq7UMcjWOyAt3UagdvwAkbqs91NmxmsapkJrDAYzM6RHtgP8Pt/HZdPh9pLJvDg
	9lnRCnFWyxySWxJA8T/V+HDEYVcxCjUXCkt2fAMEVm2v3n23OUbQzQzTxvT3AnT1h
X-Gm-Gg: AYBFou0ZRU3e2QSSr8fFQczulM6Pf6wT8IMOZA1VEFX3FgBYBStgs7aKIjSUz6ieqGT
	tfqBZC/1MYJgKs6TS3WH0wl9lpTUcw9DXYtbKYSpk/zlApfhDSSE3gl9LIs2oXzMndNNdQmjOWV
	wK0JDAH+g6JXftfSUFDlX+Rw9OFW8NBPUc+Z3rPbBrRQa/qrwRTHHiJooi5aVmk38nbDeUcre57
	xhh4NoemXvzueszXARBUqTE+o8iaTml8BkO2lZXpQwueS9xL1NsHFmFybydc7Hl7kBy2l4VTTnH
	g6MUJRT1u570eLOsMDGSfxuylMLcCzkWzIa99a4Vks9EkuEKBabzVPyk+UDBl7V63Qoq2e+wJ2k
	C0tBkRNt85GV288S0joeXybLEDTLFospGf4nwj6XjOymKn5b8u9IFcHmLHvyDB62GVT3+uxNX7A
	2Zj7X3k2SXEsolMP3C8RR7anPn9YDJ6j5Bbf6fg2cOFQCHk2r7K7MZluxSCbxWHpTZVtL/AXpaM
	cIeYAzb8Kk=
X-Received: by 2002:a05:600c:8708:b0:4a0:5b:7bc0 with SMTP id 5b1f17b1804b1-4a18066104fmr33841735e9.21.1791379830118;
        Wed, 07 Oct 2026 06:30:30 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:7fc5:5cc8:bac1:5ef3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17a0fc2e4sm150356145e9.3.2026.10.07.06.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:30:29 -0700 (PDT)
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
Subject: [PATCH net-next 5/7] selftests: ovpn: wait for the TCP server key setup before traffic
Date: Wed,  7 Oct 2026 15:30:14 +0200
Message-ID: <20261007133018.1451958-6-antonio@openvpn.net>
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
 tools/testing/selftests/net/ovpn/common.sh    | 39 ++++++++++++++++++-
 .../selftests/net/ovpn/test-close-socket.sh   |  2 +
 tools/testing/selftests/net/ovpn/test.sh      |  2 +
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 2f7851b82343..e33b1fe26522 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -258,12 +258,16 @@ ovpn_add_peer() {
 		if [ ${1} -eq 0 ]; then
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
+				exit ${rc}
 			}) &
+			OVPN_TCP_KEYS_PID=$!
 			sleep 5
 		else
 			peer_ns="ovpn_peer${1}"
@@ -281,6 +285,39 @@ ovpn_add_peer() {
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
+	local deadline
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
+			return 1
+		fi
+		sleep 0.2
+	done
+
+	wait "${OVPN_TCP_KEYS_PID}"
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

