Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714491;
	b=YTrsX2IbaQIRKQrL5NbSz4j0t9001qt3+qHNz8Ot0RtNT+d1KJJTvcI9CQCfPV4YuHSR
	 vwBDal3S2DgnTK7vv8pXHXvF+hYtcICEdJp0AAbdJCjpxd8L6sqpTbjH9dHdJyLOR1ELA
	 Jj3m/XVw9YI5b4NtSPUTgFu+ciTSiSzeuN0zhqGy/VeKqmuTh++Z0sB0SDcdZaPc0TQkK
	 PKbSEkhbkdIrd+bZe0CoIyw0iViGcra63ORsRCXyEkblPbt9yQlTfVFJk17Pg2FmFnaND
	 MtYevD+x5AeI1EedIUwaZrWRmMCkk9SQyDWm+050KreCu/oPHyVzAw70ayLqMyUYIVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7MfNYEtrIfLel/DBrfF37BJY92qVcXz0JfY6JPeH1dE=;
	b=hSVHlo+lV7WUP+qHOg9RXpsPGSCVplYGTnERnb1qSEfXK6o0rDqfi5EVfCFg+DXYURYg
	 fzvJApaHMMhZpVKDYKQEHmxbu9o+B1HcLB0DQYZSBzbGqGyByQTMH/nDgVFF5NS14akqB
	 tTWlGtiRewlO73Gq7NMCN/AULASf6S5oJJoVnEyHTSBIFdL4nBQx1jnvx5VtIlTYWB4jG
	 k6wvn3E4ptJJ5PXHzQyBB0tmt4o0RqgAg0a+/ees2u7D7GcIh6j7jzMzfjEynXjg3F/3H
	 ++Vw84i7qhFx2YgtHgZN/MISFmOwn+rPyUeQ08Ccy9S1nzGo++3qITsTX3Phdix8gBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dk5J+RDY;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D0D608361E
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77D0D608361E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dk5J+RDY
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so1996577a12.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793714491; x=1794319291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7MfNYEtrIfLel/DBrfF37BJY92qVcXz0JfY6JPeH1dE=;
        b=dk5J+RDYJvVEQhfwxd7K+jRcphgJdbCnDPzDi3ajhTbFhaJsWHzQBoVS5TH1LINBEk
         qBuTc1GuDObk1jc6/rPjBt5thE/c/qoUp9+dngnhaLlXoBhzjwH0Qam/9vA9/ZwAJf+I
         NajrzdoVxy/Ztq8TJOaASRYtuZ5RQ59dy+LqBlX1cj28jApeqDDFINtHmbeLQFxvNsVC
         JhGeP8dmA72szRbPm5anGlhud+eI//QGqIYfpjH7MN7NLrZGNshRcAIphJZYghQ+hPvF
         byebKZzTqTgkPLPXcOarsaB07XlPBeBs5ARwhdl3jHcm5tA4p/nUERNoGCgLg7AMy5H+
         oY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714491; x=1794319291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7MfNYEtrIfLel/DBrfF37BJY92qVcXz0JfY6JPeH1dE=;
        b=zN4BwDSgleN+0ao3aytc8kEpd3tgyD5CssCcOgn7oLbH487IK9WtM769+ubCvlGjdW
         ys36auiScDLoKtxG/9FQpvUFhaGm4sZJhQh72SZMbRqEqe7YIEQs69/z9QBZ7yTq1GB4
         X1RfOrKFzBQ2JJqBAABMXBWO1cP+UPOAtIJHH5nNjQemisWqZJO05mTRZjpcCKNzU+Ph
         WDejxLbFgazsFssJusokwg6LMWouI4vmZxps4wIuTHdmX0qh1EBHA03xpYPMoxecxOfe
         wf50kPAX9PL8V88Tz0ifmkComedeE74GLgKEAtvO1Zqh+2JdOrWh5HVXJIiAjlvHlrgM
         udzA==
X-Gm-Message-State: APuU4Z92XJPf0MnYJ9ANCTTmtAuY9gLeZowO5cl3Fi0J/n3MzFPoYkK3
	T/RrICLzKu1OgojiZ9gN/7MDM2oWhiTOdvteJ3atqHuqs49gZXgSaQHAENCF9A==
X-Gm-Gg: AYBFou1scIV91WQhWOUTzL6g/f+60NELNG2nhRMpYJi/TgYVvrRA2cjjJndrqTEPzFp
	xqVVf9oVveqGdl2VpX/wNO10ccUtsPcMF2pNpcqkk4R3XKE1kUkjl8dSmgQT4F81KWq5WLfiCZj
	SFuCNh/0U6lirlpr/ivFiO2W1KvbrGNV7ilD89t/+mYNHaRdBHDxc9/rsC25Hy4m/FKMtvYmSwW
	PQF7bsVpVUGXfuSeCZX8ZzyyohWPTVPzmJLwKbKJyubmvTzoXYEZfKarIL/jg0IY13br2PXQSGJ
	sgf5MEWvsTmu35ZfX7FFKtWMgF9kfQh0OaDUq+cT73vH+YN8U75NVI/uaNVPFLl/JAwuzFr3qNO
	CP5AD+1EljibE03qKLzme3lVia304f/tk9F2oROVv3+XJKV0zMiuFoT4uPEdflJ9TyivZxSsCsv
	ulSvw+5FeVRTJGTA49T4yjDR1DC01twYne4h4thgDQjCdrpsWq5qZWdyn/lh0eSKPjsh05yJm7y
	o0OKv8iQ98pZr2ESsLSlDS19sC/bN0UUbDqhQBQtPqt0LB3ws51mblZTY0mMV9iuBVsX2VjERkM
	EG3thFVYrfGX2/Gh03VEPWzdcFxwHjmYgzcKuaCEQsZD6rpsiYZO
X-Received: by 2002:a17:90a:d603:b0:3a7:a463:54bf with SMTP id 98e67ed59e1d1-3ae897d63a7mr9508630a91.33.1793714490463;
        Tue, 03 Nov 2026 06:01:30 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c8460acsm4722104a91.7.2026.11.03.06.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:01:30 -0800 (PST)
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
Subject: [PATCH net-next v3 3/3] net: dsa: motorcomm: Add BR_FLOOD and BR_MCAST_FLOOD support
Date: Tue,  3 Nov 2026 22:01:07 +0800
Message-ID: <20261103140109.874443-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103140109.874443-1-mmyangfl@gmail.com>
References: <20261103140109.874443-1-mmyangfl@gmail.com>
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

Let the hardware flood the unknown unicast / multicast if all other
ports in the bridge have BR_FLOOD / BR_MCAST_FLOOD enabled.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 177 ++++++++++++++++++++++++-------
 drivers/net/dsa/motorcomm/chip.h |   4 +
 2 files changed, 145 insertions(+), 36 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index fb993cc9607c..247446c6466e 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -1160,6 +1160,7 @@ yt921x_dsa_port_vlan_add(struct dsa_switch *ds, int port,
 
 static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
 {
+	struct yt921x_port *pp = &priv->ports[port];
 	u32 mask;
 	u32 ctrl;
 	int res;
@@ -1183,13 +1184,24 @@ static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
 	if (res)
 		return res;
 
-	/* Unrelated since learning is off and all packets are trapped;
-	 * set it anyway
+	/* Unrelated since learning is off and there is only one possible
+	 * destination; set it anyway
 	 */
 	res = yt921x_port_set_pvid(priv, port, YT921X_VID_UNWARE);
 	if (res)
 		return res;
 
+	mask = BIT(port);
+	res = yt921x_reg_clear_bits(priv, YT921X_FILTER_UNK_UCAST, mask);
+	if (res)
+		return res;
+	res = yt921x_reg_clear_bits(priv, YT921X_FILTER_UNK_MCAST, mask);
+	if (res)
+		return res;
+
+	pp->flood = true;
+	pp->mcast_flood = true;
+
 	return 0;
 }
 
@@ -1225,6 +1237,20 @@ static int yt921x_isolate(struct yt921x_priv *priv, int port)
 	return 0;
 }
 
+static u16 yt921x_port_dest(struct yt921x_priv *priv, int port)
+{
+	struct dsa_switch *ds = &priv->ds;
+	struct net_device *bdev;
+	struct dsa_port *dp;
+
+	dp = dsa_to_port(ds, port);
+	bdev = dsa_port_bridge_dev_get(dp);
+	if (!bdev)
+		return 0;
+
+	return dsa_bridge_ports(ds, bdev) | priv->cpu_ports_mask;
+}
+
 /* Make sure to include the CPU port in ports_mask, or your bridge will
  * not have it.
  */
@@ -1268,7 +1294,72 @@ static int yt921x_bridge(struct yt921x_priv *priv, u16 ports_mask)
 	return 0;
 }
 
-static int yt921x_bridge_leave(struct yt921x_priv *priv, int port)
+static int
+yt921x_bridge_flood_set_type(struct yt921x_priv *priv, u16 ports_mask, int type)
+{
+	unsigned long targets_mask;
+	u16 flood_ports_xor;
+	u32 filter_ctrl;
+	u16 flood_mask;
+	u32 addr;
+	int port;
+	int res;
+
+	ports_mask &= ~priv->cpu_ports_mask;
+
+	flood_mask = 0;
+	targets_mask = ports_mask;
+	for_each_set_bit(port, &targets_mask, YT921X_PORT_NUM) {
+		struct yt921x_port *pp = &priv->ports[port];
+
+		if (!type ? pp->flood : pp->mcast_flood)
+			flood_mask |= BIT(port);
+	}
+
+	flood_ports_xor = flood_mask ^ ports_mask;
+	filter_ctrl = 0;
+	targets_mask = ports_mask;
+	for_each_set_bit(port, &targets_mask, YT921X_PORT_NUM) {
+		struct yt921x_port *pp = &priv->ports[port];
+
+		/* Hardware never floods back to its own ingress port, keep
+		 * hairpin port trapped: the software bridge does deliver a
+		 * flood there.
+		 */
+		if (!pp->hairpin && !(flood_ports_xor & ~BIT(port)))
+			continue;
+
+		filter_ctrl |= BIT(port);
+	}
+
+	addr = !type ? YT921X_FILTER_UNK_UCAST : YT921X_FILTER_UNK_MCAST;
+	res = yt921x_reg_update_bits(priv, addr, ports_mask, filter_ctrl);
+	if (res)
+		return res;
+
+	/* ACT_UNK is fixed to TRAP for every port, see yt921x_chip_setup_dsa().
+	 */
+
+	return 0;
+}
+
+static int yt921x_bridge_flood_set(struct yt921x_priv *priv, u16 ports_mask)
+{
+	int res;
+	int ret;
+
+	ret = 0;
+	for (int type = 0; type < 2; type++) {
+		res = yt921x_bridge_flood_set_type(priv, ports_mask, type);
+		if (res)
+			ret = res;
+	}
+
+	return ret;
+}
+
+static int
+yt921x_bridge_leave(struct yt921x_priv *priv, int port, u16 other_ports_mask)
 {
 	int res;
 
@@ -1280,6 +1371,10 @@ static int yt921x_bridge_leave(struct yt921x_priv *priv, int port)
 	if (res)
 		return res;
 
+	res = yt921x_bridge_flood_set(priv, other_ports_mask);
+	if (res)
+		return res;
+
 	return 0;
 }
 
@@ -1296,6 +1391,10 @@ yt921x_bridge_join(struct yt921x_priv *priv, int port, u16 ports_mask)
 	if (res)
 		return res;
 
+	res = yt921x_bridge_flood_set(priv, ports_mask);
+	if (res)
+		return res;
+
 	return 0;
 }
 
@@ -1304,7 +1403,9 @@ yt921x_bridge_flags(struct yt921x_priv *priv, int port,
 		    struct switchdev_brport_flags flags)
 {
 	struct yt921x_port *pp = &priv->ports[port];
-	bool do_flush;
+	bool change_isolated = false;
+	bool change_flood = false;
+	u32 ports_mask;
 	u32 mask;
 	int res;
 
@@ -1318,36 +1419,44 @@ yt921x_bridge_flags(struct yt921x_priv *priv, int port,
 			return res;
 	}
 
-	/* BR_FLOOD, BR_MCAST_FLOOD: see the comment where ACT_UNK_ACTn_TRAP
-	 * is set
-	 */
-
 	/* BR_BCAST_FLOOD: we can filter bcast, but cannot trap them */
 
-	do_flush = false;
 	if (flags.mask & BR_HAIRPIN_MODE) {
 		pp->hairpin = flags.val & BR_HAIRPIN_MODE;
-		do_flush = true;
+		change_isolated = true;
+		/* Hairpin also affects flood flags */
+		change_flood = true;
 	}
 	if (flags.mask & BR_ISOLATED) {
 		pp->isolated = flags.val & BR_ISOLATED;
-		do_flush = true;
+		change_isolated = true;
 	}
-	if (do_flush) {
-		struct dsa_switch *ds = &priv->ds;
-		struct dsa_port *dp = dsa_to_port(ds, port);
-		struct net_device *bdev;
 
-		bdev = dsa_port_bridge_dev_get(dp);
-		if (bdev) {
-			u32 ports_mask;
+	if (flags.mask & BR_FLOOD) {
+		pp->flood = flags.val & BR_FLOOD;
+		change_flood = true;
+	}
+	if (flags.mask & BR_MCAST_FLOOD) {
+		pp->mcast_flood = flags.val & BR_MCAST_FLOOD;
+		change_flood = true;
+	}
 
-			ports_mask = dsa_bridge_ports(ds, bdev);
-			ports_mask |= priv->cpu_ports_mask;
-			res = yt921x_bridge(priv, ports_mask);
-			if (res)
-				return res;
-		}
+	if (!change_isolated && !change_flood)
+		return 0;
+
+	ports_mask = yt921x_port_dest(priv, port);
+	if (!ports_mask)
+		return 0;
+
+	if (change_isolated) {
+		res = yt921x_bridge(priv, ports_mask);
+		if (res)
+			return res;
+	}
+	if (change_flood) {
+		res = yt921x_bridge_flood_set(priv, ports_mask);
+		if (res)
+			return res;
 	}
 
 	return 0;
@@ -1388,13 +1497,17 @@ yt921x_dsa_port_bridge_leave(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct device *dev = yt921x_priv_to_device(priv);
+	u16 ports_mask;
 	int res;
 
 	if (dsa_is_cpu_port(ds, port))
 		return;
 
+	ports_mask = dsa_bridge_ports(ds, bridge.dev);
+	ports_mask |= priv->cpu_ports_mask;
+
 	mutex_lock(&priv->reg_lock);
-	res = yt921x_bridge_leave(priv, port);
+	res = yt921x_bridge_leave(priv, port, ports_mask);
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
@@ -2275,14 +2388,6 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
-	ctrl = GENMASK(10, 0) & ~priv->cpu_ports_mask;
-	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
-	if (res)
-		return res;
-	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_MCAST, ctrl);
-	if (res)
-		return res;
-
 	/* YT921x does not support native DSA port bridging, so we use port
 	 * isolation to emulate it. However, be especially careful that port
 	 * isolation takes _after_ FDB lookups, i.e. if an FDB entry (from
@@ -2291,9 +2396,9 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	 * the "bridged" ports, thus we need to trap and handle those packets by
 	 * software.
 	 *
-	 * If there is no more than one bridge, we might be able to drop them
-	 * directly given some conditions are met, but we trap them in all cases
-	 * for now.
+	 * In some cases, we may offload the flood action to the hardware. This
+	 * is done by fixing UNK_ACT to TRAP, and toggling the FILTER_UNK on the
+	 * appropriate ports.
 	 */
 	ctrl = 0;
 	for (int i = 0; i < YT921X_PORT_NUM; i++)
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index fc315f1d8f87..842fd8f83903 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -461,6 +461,10 @@ struct yt921x_port {
 	bool hairpin:1;
 	/* BR_ISOLATED */
 	bool isolated:1;
+	/* BR_FLOOD */
+	bool flood:1;
+	/* BR_MCAST_FLOOD */
+	bool mcast_flood:1;
 
 	unsigned short acl_cnt;
 
-- 
2.53.0

