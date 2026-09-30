Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699AA44E046
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807162; cv=none; b=R6j4OwjG8oA3M4sLEVgO1BH7Na350OrWJ57Mmd6kBLaFYq7u921XyCLMT0kaayYdt0nrc0OaNnjsrAtaSND7Si+mPwtxoCuqjLzeZKxkO0US+qslGD2V8kxNxzOM1wNaz+Ki9UMQIrskePBM1yhYQ2JZFYSfLlvjy5vg54v4BFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807162; c=relaxed/simple;
	bh=jyr6lDgNOJ4Jnsu4OOCO8e8oUEiSkA/dEsG/3suN1w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OO+rwTAWHi44cQInOdOPOsazLWmeiIoKzgeXdaARgxGBfvKDzlGLAYn0Be5BhjHlpm7JdIT0zNj+XuaM/9SNPRxOs0UjRtRuGYx8oYhTaVQigHCyuWn+0r1DFOtG2NlqDl9gJa8rO7OIFwPlLYeGsVlwP9NsVu5av60F9xAM2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bZEb/OQh; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bZEb/OQh"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso60528415e9.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1790807158; x=1791411958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=an0vUs4hK6pCIjIep2sFxJmPmB2s7bPib4hJ3LbZrck=;
        b=bZEb/OQh2gQSi8wbY6ZLfA9ywcab8Za4l/VrCdlcpXO9zhZkrf4Q0XMawEdVzLcOdS
         ja4OcJq3irG3ewbzwsBX1Lh2WjWH5Rg7FK1GHOuXDBmH75NRvc5QzJC02WyIUWl0WxwQ
         N1zY+0Dwxg17p4PLhEVQIzgsEZ50OrXCvh22ar0qnLLdWeZ7pEKm596mB30cnv9yYqXz
         QzaChOSLAR6TgkVPMq5F9jmDQPsUa5btLq5eGjhXX8g0lqmK1nEgSI7TNlG0EjpgTcGE
         HvmN8lcgL1MJbCoUxQxgpzPSH9FwvCdeX15QOqD4bMlvPReP6R/5vXAO2A3G2dlAV9PN
         wlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790807158; x=1791411958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=an0vUs4hK6pCIjIep2sFxJmPmB2s7bPib4hJ3LbZrck=;
        b=nJKyX5k+59c+0JPX271WUKuujdb8h9KcdWm5Yr3L131K+cEFIXBdOoYYgqA/0SolCB
         6YjNPC5Y1TbonII7r5iZ1/kjw3tVnhrMvKp53YfSK9wMSaVDiiEi7pqBl+bIx1AuqS9u
         PiKF16Oxf10wbaKFEBjhTZK2T7bVNx5enzcDr78UC6ZbUecrs+RVaWsxoHWgDuCAxPbI
         9WVkwqAuJeE1z9pp6uVzHkP1TvoiHsbD7o7Y/GQ6IMPAx/VeOlPS0tU5s3gwaiDXlREw
         h0TRSgvj9Dlup/kf+E8o+Is0V6G9NVS+90a5Yo+r3qnNbBsRe/op/4H8UEUxZjLSMshP
         T4gg==
X-Gm-Message-State: AFuF++lwmRdN0dZdFGnQ422eTArKLhNjM0Q0Sd/dntwDp0qGmknijjDM
	92VjhrPELX6RwNRhoGHlZ+l9QnxPeUiHobB/5w5Kv12/uu8f/PvQqmthQysKbz8OSi2AwCKYUMz
	3hArWWgMiip4YNsoQ7ptlpRGxMWo02P+dkjMYhNoXJ9YyZzu2clwkoWUND6s0n2YsF0s=
X-Gm-Gg: AYBFou0iuDuVykTMmq5I8X2y2GDHXwly6if59bK/5bF4pGZfUsxXdvtmZdSPq0S+rvv
	nocNw9jiz6XxckxC6FfF5cPmTxmWrVrYroBlyZLyrjcVT1PUzzUofvGrm43C7todUXRtRVES8mF
	+fWazifpxWujR7gd1M1hQFCo+42kTKbqL6PLJjKeC1BEMalWyaxOGTvRgsNpNOb08+oZ6z2f+jA
	+654q/Quu2hIA6v6ecIvbxfj8yx7Eg/DaFfBdrOxRa+J9wHlmGHRXOtY9euiV+MiJAjHOyAIZiE
	vcD8FgW6yalXKMp6ocAFa0slNJ9lp6xxqnhny1gMno4QP6xbblT5tk02jINTcbyVS9NRhq1zAKZ
	UtsJIXRuLX+3PcC6DogyiA/eSZ+EQXOzWNo8aeqd0Kz/B5bqYL1at6Ql0Nz1Lkm66UKpTEJjf9q
	jzNJ5kZAg919nWVS7pMXKfYOZHzbT2goS+fpnuG8Cz+hNxVF5uyHClAlB8AV39sguv9Zr1zu5OD
	bD5rJuKM/W3
X-Received: by 2002:a05:600c:4f8b:b0:4a0:1f58:1772 with SMTP id 5b1f17b1804b1-4a01f581948mr7771785e9.21.1790807158376;
        Wed, 30 Sep 2026 15:25:58 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:5892:feba:7b41:58fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f979c05sm24433095e9.3.2026.09.30.15.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 15:25:56 -0700 (PDT)
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
Date: Thu,  1 Oct 2026 00:25:39 +0200
Message-ID: <20260930222542.3839327-6-antonio@openvpn.net>
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
 tools/testing/selftests/net/ovpn/common.sh          | 13 +++++++++++++
 .../testing/selftests/net/ovpn/test-close-socket.sh |  2 ++
 tools/testing/selftests/net/ovpn/test.sh            |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 2f7851b82343..96b40742eddf 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -264,6 +264,7 @@ ovpn_add_peer() {
 						1 0 ${OVPN_ALG} 0 data64.key
 				done
 			}) &
+			OVPN_TCP_KEYS_PID=$!
 			sleep 5
 		else
 			peer_ns="ovpn_peer${1}"
@@ -281,6 +282,18 @@ ovpn_add_peer() {
 	fi
 }
 
+# In TCP mode the server accepts the peers and installs their data keys from a
+# background subshell. "listen" only returns once every peer has connected, so
+# the key installation necessarily runs after ovpn_add_peer() has been called
+# for the last peer. Wait for that subshell to finish before generating any
+# traffic, otherwise the first packets may race the key installation and get
+# dropped for lack of a key.
+ovpn_wait_tcp_keys() {
+	[ -n "${OVPN_TCP_KEYS_PID:-}" ] || return 0
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

