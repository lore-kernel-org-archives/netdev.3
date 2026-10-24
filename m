Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852846;
	b=K345z8a1caJB9hXl+HP7SuQuobY3VD8WErZI1SuVJqRpNkVoSG1HIkn1AbP/b8fGvDgs
	 V0NiOAhRg+gRJei9SPAeX+TCLKiID96qDkqoUrsSmc/Ne8eqFax36RRDfehgdcOvUIjhL
	 35D9jY9dlnfTnt86lBvyPSigG/8VUHFjXRi0ZCIv/jdVnP/jhwpTmTYK75peQ0StCVTHz
	 9RC7wXa0tiAsU7kKwj3oKdLsF2qFwIq4+C886/E3tReKK5ErPhrMAb2njTM9qflehUNvn
	 Q8l6xnz7V8SNRZelqRwGw0QEj+amZiXMt9HkLjnY96zoYBdIwhCbmWFj55A8cMu+uzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UMCW9KMFviFrZMbcsiEVVmmLV6m2nQyWTUUSuyYETI4=;
	b=3a9cfpb4rTknrmh6xTdgV96hXLUPixAI79SI2N0Vb9ZpL5ZKJHkcJxWU+AANuu6CTHaP
	 r/YTSIhRbCuMY8gT3heC6Gvf5tiEK19xcETaJEBuwPp+qGKQI6kT+EUzZe8MlTIJtAh4I
	 nlw65oLViDyWie1YXdO/y1ukGB+s1Fw1g6jHddxSk7Uc7CXRejjPRhbMMZCvF7RZv2pAc
	 6pn5pnIB/lRmQ8uvkK0jLrq5J/3lb2bErrBsEfXR3KqqosjGYSCe+YAI2bm9iDNyPSG42
	 1onuMQAy67m0GEu+KHcAerLnP1iCV5z5IcqvdXdaDEQRsOy7ZoXfrtgDfF52FVpe0Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=spL3Ckb7;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1425606A31B
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 14:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1425606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=spL3Ckb7
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so857557a91.3
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 07:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792852845; x=1793457645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UMCW9KMFviFrZMbcsiEVVmmLV6m2nQyWTUUSuyYETI4=;
        b=spL3Ckb7csO6ZzHNYpTHnI4ICzIzAgO64oB3o9VXkCZ8QvUn7cQtuzjgXjOSKpq0TD
         NgWHVFGcni02/eCQq91UXt9h3cNZt8SBtU/tgCy2MVFsx98eYelJKF2MSbzWvK8okmmA
         teCDD9/CxCT1tykPIWG7UNagd2Gak4FcNkiRSbRzwamLLFZU6imjdgNu8700sqba2aUc
         ydc239QXbjjUEA/Ul5FPGnQ5fDyXT6J+I4UmOi1n6B2hQHncmTX4HH6bPPMnKEaYmmtX
         mHuO6JyIoN0OCSLGDvh4XImDCl8jolPJVkoi/L9jvV1KDqbXoIMyp6hLiSGO8x8rwFFM
         tOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852845; x=1793457645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UMCW9KMFviFrZMbcsiEVVmmLV6m2nQyWTUUSuyYETI4=;
        b=EY1zWwkVM8t4UDY8RCKCi691RfDN20EQZCEHujHpmZFjA4rKMFbe/XW7whAbF5KYjM
         UYYbbd8Fy8qa9epwLqXaIvdtXo8BgmzCUi54v0+KcQFmKI9e567e/Qc6gA6loO9wIE/+
         5f5C10ReJEdfgL2HPrjFuh+l7tVpCURh8PPjLvrRrs6aHS0KtPzWt+tZ6mAS8YDpuRxX
         Q7m5U0hdXXIQr/5aeqKulOfJltj9N/qyd1qlcQIDZiLoAF4w8Dj0bd+F8nmu5pd1KXNB
         5WmlL76UL/PBI9KjVv5u0BSsuSiIwRiuEWqtgHyZGrH7ynMbTYFFfzBwqNaeQ3peKwBQ
         Bssg==
X-Gm-Message-State: AFq9FYJXb2GnNYm4+97zzn2Q96irioGi+n3rK/oSs1DzpvAjlsW24uCz
	n/qpBlSDPRR8JbvSbJZZgJIQ9yo/q/PIRVgmxUucSOxnw3kIvO5Fn8JTl+PFR9S7rKo=
X-Gm-Gg: AYBFou3feYs+hJXHAtkEABTqqQAk+CmrlxLr67w14tbu2s+NBysPiZxxFMtFcjD1b/v
	VY7Ik5vAK1DGKlVRhnPlH9PgvsuyQ5V74+d5HgnBNS6lVq0+4MF4786MQVjdpfUtA37OG5UutDE
	BohtDSJ8lqz/OQ/HioY4K4Bfi5++jQImNXEb6YwhWbQcun9XP+Olwo7EIIuCjFUW1vBN9zafojn
	H1hEF+iLHRzaeDa/xsGa2NGqHMe7kjJbSgH4ae/kHlsLHgCiQKly2fA8UBuizROzDuDg79Hr7ja
	zW4yltVHYcDJ4CMEBMCwKpX6Esa1zPgak+mnQGNtq7pfiRlex/0UdGFMpUYzR46VaUkDxorBz4A
	/e6BISI821ffO0ceJ0Hz/NLF5yOymFNzmhEq2NYeIrCua+FrTmuvYfomg6IdlSz95KCK4HGdV5c
	+ybCL56Qm7269PmC8WQkKpdXiJfVm6KY2YcgtzX9GLjfdqz1IUA3KMbzxdsvs5V2PFGBjPIG53h
	k7FlzcOQ8wloIW0d788+SgmnsiXlpbTiMrsEC8j63V39Dx9pe54HB6z/G1SMT0uxILLMuS2jBc7
	K9ihY6eUZQuC6akBSf3fx7704lZd
X-Received: by 2002:a17:90b:2642:b0:3ac:b867:81df with SMTP id 98e67ed59e1d1-3adead4c63emr1965774a91.39.1792852844862;
        Sat, 24 Oct 2026 07:40:44 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6216:1250::1d3:c4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb29031sm1877918a91.4.2026.10.24.07.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:40:44 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: motorcomm: Isolate all ports during chip setup
Date: Sat, 24 Oct 2026 22:40:21 +0800
Message-ID: <20261024144023.1010237-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The chip setup only blocked unknown unicast and unknown multicast
frames, known multicast and broadcast were left open (though the former
cannot appear while the FDB is still empty). Before port_setup() runs,
this leaks in two ways: frames pumped untagged into the conduit port
reach the fabric and loop back to the CPU, where the tag driver warns
about and drops them; and broadcast frames received on a user port flood
out of the other user ports.

Close the window by fully isolating every port right after the hardware
reset. The CPU port one-way isolation is also applied during chip setup
instead of port_setup(), and yt921x_userport_standalone(), which
port_setup() also runs for CPU ports, keeps it intact.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 56 ++++++++++++--------------------
 1 file changed, 20 insertions(+), 36 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index d4fc20c52a58..f1762273dd6a 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -1164,10 +1164,13 @@ static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
 	u32 ctrl;
 	int res;
 
-	ctrl = ~priv->cpu_ports_mask;
-	res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port), ctrl);
-	if (res)
-		return res;
+	if (!(BIT(port) & priv->cpu_ports_mask)) {
+		ctrl = ~priv->cpu_ports_mask;
+		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
+				       ctrl);
+		if (res)
+			return res;
+	}
 
 	/* Turn off FDB learning to prevent FDB pollution */
 	mask = YT921X_PORT_LEARN_DIS;
@@ -1942,8 +1945,6 @@ yt921x_dsa_phylink_get_caps(struct dsa_switch *ds, int port,
 
 static int yt921x_port_setup(struct yt921x_priv *priv, int port)
 {
-	struct dsa_switch *ds = &priv->ds;
-	u32 ctrl;
 	int res;
 
 	res = yt921x_userport_standalone(priv, port);
@@ -1957,27 +1958,6 @@ static int yt921x_port_setup(struct yt921x_priv *priv, int port)
 	if (res)
 		return res;
 
-	if (dsa_is_cpu_port(ds, port)) {
-		/* Egress of CPU port is supposed to be completely controlled
-		 * via tagging, so set to oneway isolated (drop all packets
-		 * without tag).
-		 */
-		ctrl = ~(u32)0;
-		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
-				       ctrl);
-		if (res)
-			return res;
-
-		/* To simplify FDB "isolation" simulation, we also disable
-		 * learning on the CPU port, and let software identify packets
-		 * towarding CPU (either trapped or a static FDB entry is
-		 * matched, no matter which bridge that entry is for), which is
-		 * already done by yt921x_userport_standalone(). As a result,
-		 * VLAN-awareness becomes unrelated on the CPU port (set to
-		 * VLAN-unaware by the way).
-		 */
-	}
-
 	return 0;
 }
 
@@ -2221,6 +2201,7 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 {
 	struct device *dev = yt921x_priv_to_device(priv);
 	u16 eth_p_tag;
+	u32 ctrl;
 	u32 val;
 	int res;
 
@@ -2258,6 +2239,17 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 		return -EINVAL;
 	}
 
+	/* Block all traffic as soon as we reset the hardware since it now acts
+	 * as a dump switch.
+	 */
+	for (int port = 0; port < YT921X_PORT_NUM; port++) {
+		ctrl = ~(u32)0;
+		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
+				       ctrl);
+		if (res)
+			return res;
+	}
+
 	return 0;
 }
 
@@ -2285,7 +2277,7 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
-	ctrl = GENMASK(10, 0);
+	ctrl = GENMASK(10, 0) & ~priv->cpu_ports_mask;
 	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
 	if (res)
 		return res;
@@ -2308,14 +2300,6 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	ctrl = 0;
 	for (int i = 0; i < YT921X_PORT_NUM; i++)
 		ctrl |= YT921X_ACT_UNK_ACTn_TRAP(i);
-	/* Except for CPU ports, if any packets are sent via CPU ports without
-	 * tag, they should be dropped.
-	 */
-	cpu_ports_mask = priv->cpu_ports_mask;
-	for_each_set_bit(port, &cpu_ports_mask, YT921X_PORT_NUM) {
-		ctrl &= ~YT921X_ACT_UNK_ACTn_M(port);
-		ctrl |= YT921X_ACT_UNK_ACTn_DROP(port);
-	}
 	res = yt921x_reg_write(priv, YT921X_ACT_UNK_UCAST, ctrl);
 	if (res)
 		return res;
-- 
2.53.0

