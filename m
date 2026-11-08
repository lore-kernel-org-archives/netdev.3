Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174318;
	b=mLgjZwKH/k0Gv5JijzWid+LI+9ZpoIjEFEEU7WgrjXgfniUGnRZeQ1MCKUTHKq8nSgeS
	 IEs4g2cctAh1A8e8u1g/nRUe46ErUgmOC6O1AtYwDe/4UK3JCuQtV1tdZhPUO+3Vj+dhT
	 L8mchH6Q/JbOJx3lbvz+GjSF0RXwwdoGMhXOcrE8i1JdB8Cq8IfMD+vrA7Ba8zfr9BVh7
	 GR2lT1kIl8PYoj1pgGL9P3nnSnf/NplrfdHOu8k9gZLKYgf62e5QXEakqMoyvlfQ1FZdS
	 tJv2CJhO7ceH55P0UqMvj0PdyIHYRHe01P+TLbjB9gN8owl1UqU/mOKI2+47WtoTN5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JbZ6+DyycjbPuDbJzaygdIrYKEd+hBunbN6mQjd7eLk=;
	b=1j7RAYz+Ev1vNypfqXvRPRgkBLoGiJqrdV9GmfUotaj6AKK24fERUb8SZfRGkHh4ivpy
	 viTIxVl8NcdH/hgk5LTkg/QAqrhOpWq0ZUKJO0Qmy6+7zd5eNKW6wzNbxFe4DHmh+yKbz
	 3X0Grkq+/7li/eOQ1PCRLXxdi6AfvMWTfTNhCslP/6ICQIgQZv48vLJoc1XJ3/BXWUW6P
	 OSlW9mFV+aWyf1p0OhFmsrRKwPjebtOYOkQ5YZDP3qWTwctFoaDXETaeqdkeZDNbtACDS
	 1+2fQiZHx6OT+39QhCjdaP2cy6uBjxE/lQYHR395IO7g7YVktEmvaeianRTD1cUamTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y2Bbmbtv;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D3606D803
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 21:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A48D3606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y2Bbmbtv
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b147e06befso67764a91.2
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794174317; x=1794779117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JbZ6+DyycjbPuDbJzaygdIrYKEd+hBunbN6mQjd7eLk=;
        b=y2Bbmbtvaew/ZIdq9cDw24k24iIVWG3hnhzWIY99yvqojwerluYunKfTefO18Knauh
         JB4BMHHMbRjIy4zYPRN4HH9HIlxSwny9MpGKwpRSFMPQkqq2XjY6oaKwvEbp1GE/rBeH
         HDR+UhqnpuHAQc/Jah9FyQ8pvSPKsqCZrZkJv/ehBeXnPCWfQdBn1pRs8yTr/BQMqidA
         i9LDdlkn/UXOG+DiK39jcpDsqgTapCaObpqMsUDL0a5GX3bDC9HloFxRBxBTHPaGvd+U
         EXalVfQg1SHOVcpzICmyaHLDkJ+vfwTlQr1oviLej1s+hqscgoecltdWsi5qGcecCK6C
         ASTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794174317; x=1794779117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JbZ6+DyycjbPuDbJzaygdIrYKEd+hBunbN6mQjd7eLk=;
        b=jz69onluiTl1oGYjl2nwylYMlY8/eNzuzAsXOPWS3lPg8x8enkUJBRb0Xlpcc2YuHl
         BJXcyBUtUY8GC4Rdzy5+afGFNGDgCMelxZBdrItM8DznRIJ4cWZ2pNSB9lkptnVOPfMz
         Wi6/Hz22xP6CzAMxGRqQD4KqpgHvikWB0OJbrkaWB/JWT80nEHQ0Zb3JPm06zJSbwsil
         dY/AWBV0rGhzjgies8vgs6x13TuLwfH856Hh+hfhVeDS7hethAFdJCu7WD+suqGVjtbN
         n9HfpA0J4YHSMbMR5MS9oG1MeQmMit7MtkBMkZofifcYvPW3Whqqn1t4OiGZPa5dfHcZ
         sY8w==
X-Gm-Message-State: APuU4Z/CpQnhrrBtCb6wya8hiy06Dx2ofs6QvR1Kt5gvfdm3mzYqeSbB
	IjONf3Aifx2bemMbjcx0xSUWSJJXqJdoYMtAEJQPdoPPJLxq0Cb0tQshueTHQg==
X-Gm-Gg: AYBFou2L2fOJKvcNjz7IFIJSDWh2G+1w+YQqJX2VZi8TcbM5ySZoZGaA7gMeOrWUOMJ
	n2G9qxG9C+nOz6aOvyDRRtGhTFmIiDSW1Di/ya8eS8ATClX5zO2W47Y0gm+FC4HibMu0ZFAUQIG
	xDnlIwEk23Z3JoVvsxTO36Y8kRHz20+Hyg6//0dde00xA/t0t44A7pvOkzJfQ+4296dMZeNHaV2
	1lCH4yq1L4Td6UVF8IVa2ekzj2pFXBZCHJkXASlUrA8TTT3s9qXC+fcilFTX6sUtotmRC8kor9S
	8T80KSmcP32XXf399jU87qIdvcr4E8t2weCf6xekU1sjv72tIW5w/buBJJfvbHCSllcPjpe8l82
	ZKxawuqhzDU67CVzo7yY5ttysHs4kpqJbCn/eFBz27p6+xImqP5bff63QbNnARHzZZyLi4e2y/n
	uuIckHsBbvOpRL881iUK5eGIMiA0IjIjx5Fw9mfv5drVBypCpgiseZIrdTUULteK0cgjG/LqGYH
	9Mj2KWeFWnSRrcNSz7bRmchuV1fL3zWh6cOjWJgCRzZhE4AkeYZVWg4j+v8sFiFsb7+jKoPsUcK
	5sTCimI9FLwMcK2ppiJ+ng+i38gEuo4dhnRRi+UA/UaYZEY1Mf19tA==
X-Received: by 2002:a17:90b:288a:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3b12d0e7384mr1887659a91.6.1794174316858;
        Sun, 08 Nov 2026 13:45:16 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1034718f8sm4619463a91.4.2026.11.08.13.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:45:16 -0800 (PST)
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
Subject: [PATCH net-next v5 3/7] net: dsa: motorcomm: Remove local cpu_ports_mask
Date: Mon,  9 Nov 2026 05:44:43 +0800
Message-ID: <20261108214450.1662362-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108214450.1662362-1-mmyangfl@gmail.com>
References: <20261108214450.1662362-1-mmyangfl@gmail.com>
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

Use dsa_cpu_ports() or dsa_is_cpu_port() instead for a clearer view of
code.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 18 +++++++++---------
 drivers/net/dsa/motorcomm/chip.h |  2 --
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 47f06945b8c4..7686995b803f 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -1003,7 +1003,7 @@ yt921x_vlan_add(struct yt921x_priv *priv, int port, u16 vid, bool untagged)
 	u32 ctrls[2];
 
 	masks[0] = YT921X_VLAN_CTRLa_PORTn(port) |
-		   YT921X_VLAN_CTRLa_PORTS(priv->cpu_ports_mask);
+		   YT921X_VLAN_CTRLa_PORTS(dsa_cpu_ports(&priv->ds));
 	ctrls[0] = masks[0];
 
 	masks[1] = YT921X_VLAN_CTRLb_UNTAG_PORTn(port);
@@ -1158,11 +1158,12 @@ yt921x_dsa_port_vlan_add(struct dsa_switch *ds, int port,
 
 static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
 {
+	struct dsa_switch *ds = &priv->ds;
 	u32 mask;
 	u32 ctrl;
 	int res;
 
-	ctrl = ~priv->cpu_ports_mask;
+	ctrl = ~dsa_cpu_ports(ds);
 	res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port), ctrl);
 	if (res)
 		return res;
@@ -1208,7 +1209,7 @@ static int yt921x_isolate(struct yt921x_priv *priv, int port)
 
 	mask = BIT(port);
 	for (int i = 0; i < YT921X_PORT_NUM; i++) {
-		if ((BIT(i) & priv->cpu_ports_mask) || i == port)
+		if (dsa_is_cpu_port(&priv->ds, i) || i == port)
 			continue;
 
 		res = yt921x_reg_set_bits(priv, YT921X_PORTn_ISOLATION(i),
@@ -1225,7 +1226,7 @@ static int yt921x_isolate(struct yt921x_priv *priv, int port)
  */
 static int yt921x_bridge(struct yt921x_priv *priv, u16 ports_mask)
 {
-	unsigned long targets_mask = ports_mask & ~priv->cpu_ports_mask;
+	unsigned long targets_mask = ports_mask & ~dsa_cpu_ports(&priv->ds);
 	u32 isolated_mask;
 	u32 ctrl;
 	int port;
@@ -1338,7 +1339,7 @@ yt921x_bridge_flags(struct yt921x_priv *priv, int port,
 			u32 ports_mask;
 
 			ports_mask = dsa_bridge_ports(ds, bdev);
-			ports_mask |= priv->cpu_ports_mask;
+			ports_mask |= dsa_cpu_ports(ds);
 			res = yt921x_bridge(priv, ports_mask);
 			if (res)
 				return res;
@@ -1410,7 +1411,7 @@ yt921x_dsa_port_bridge_join(struct dsa_switch *ds, int port,
 		return 0;
 
 	ports_mask = dsa_bridge_ports(ds, bridge.dev);
-	ports_mask |= priv->cpu_ports_mask;
+	ports_mask |= dsa_cpu_ports(ds);
 
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_bridge_join(priv, port, ports_mask);
@@ -2268,10 +2269,10 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	int res;
 
 	/* Enable DSA */
-	priv->cpu_ports_mask = dsa_cpu_ports(ds);
+	cpu_ports_mask = dsa_cpu_ports(ds);
 
 	ctrl = YT921X_EXT_CPU_PORT_TAG_EN | YT921X_EXT_CPU_PORT_PORT_EN |
-	       YT921X_EXT_CPU_PORT_PORT(__ffs(priv->cpu_ports_mask));
+	       YT921X_EXT_CPU_PORT_PORT(__ffs(cpu_ports_mask));
 	res = yt921x_reg_write(priv, YT921X_EXT_CPU_PORT, ctrl);
 	if (res)
 		return res;
@@ -2308,7 +2309,6 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	/* Except for CPU ports, if any packets are sent via CPU ports without
 	 * tag, they should be dropped.
 	 */
-	cpu_ports_mask = priv->cpu_ports_mask;
 	for_each_set_bit(port, &cpu_ports_mask, YT921X_PORT_NUM) {
 		ctrl &= ~YT921X_ACT_UNK_ACTn_M(port);
 		ctrl |= YT921X_ACT_UNK_ACTn_DROP(port);
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index d9425afc7bce..ab6f28d057cb 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -509,8 +509,6 @@ struct yt921x_priv {
 	const struct yt921x_info *info;
 	unsigned int meter_slot_ns;
 	unsigned int port_shape_slot_ns;
-	/* cache of dsa_cpu_ports(ds) */
-	u16 cpu_ports_mask;
 	unsigned char cycle_ns;
 
 	/* protect the access to the switch registers */
-- 
2.53.0

