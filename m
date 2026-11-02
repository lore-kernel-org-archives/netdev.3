Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635119;
	b=LUR47IccN4ePPQgWqto64w13rIpk3CH+IMHusYU/cCMiDIPVDLiLnxljpA4Zt0T7q09Q
	 ZwklnkuJAlNH2p1JGAjC0mQRVmHTRHn8Ft5kFyUS7LVnXQDxQmKPR/TWDSD/G2yFMKlAa
	 UJMhzOy9PtwYRH0VfgWdIMNRJ6uH3DzbX2VwMlD0I3kDXdDC0j5Ni2JU8UO2AIn/85yuu
	 FiQaavgG36xWDgzlq5h3XqSRXGP87ZGTZOIyP5BQKtxsFQiNZkxK/9foLsAxgvqkeXuHo
	 zCYtBNr8/gSCk158HS88f5tZ9Z3Ewg6k5y5E5JDBheDqT7K94lrGogkfhtl/z6FWk5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5+sUQk+o1d/mIEpVQi06imOvdS1LrFveqd/a6VHMQv4=;
	b=kyrI48F1D+f9AfFdOmo6OIvKz8DKvzfdJu+LlMnk97cKc8kV7tRQhaUDHnfMzHn0WbAx
	 yH9N5eyxP1UE33DmDN5vLTl7Mnvgkq8voULtV6UV/9NdyPyXu7UuYCO9vXcF3Pyc7fH+O
	 6geqESKwYkSvPLi0J4TZ12D4l252TpowmZV8ICHyu3cmSOqSTrw4aN5PcbMYjGmgDMlir
	 4j5+xGLpgd4XeA90X+66zjaEaJx/BqDvtnErZm6wjfl4/N1rRkyN1eYeozezLy8Q9g//r
	 TTnoQJedOY/I8GcT/agzljUcKA1dfeG/MbaL87S/qR0bHg+Uj1IiDvtoYds9auo56QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CNzzRwTa;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA0660B9947
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BA0660B9947
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CNzzRwTa
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso1432519a91.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793635119; x=1794239919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5+sUQk+o1d/mIEpVQi06imOvdS1LrFveqd/a6VHMQv4=;
        b=CNzzRwTaUldx7czJ25oONpmluGlBBEjJugt9ypxZX/+zzfGFxLvQXzIvOsL8PPucIe
         i14oUjDF77XZOCNqUQS0Dy98OiUtEt7ulzBA4/InpjH39vnyfWjxLjvWYzgMyibjhuQ7
         86ePH0qhRnYgQI+SQB3tEYv1dMM6zNgRcejHKln1/llFmVcIfdF067ks0HJH6ZykLEdL
         qIvKu6dsvR5N7uWeERbYT5HZ0H3aq3kFhUZ+hgLeliNO9wo8CIfQClvrjDB3kCAqRC52
         SlMkb3dNQZ5C3QEWvKNxk7YV8pbvQzxbDssjHpUFTWnD/nhbgd9q1tdofoKS4cJ5nFQE
         KiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793635119; x=1794239919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5+sUQk+o1d/mIEpVQi06imOvdS1LrFveqd/a6VHMQv4=;
        b=MGCorgRNE0PrH1LRBRLITjEpYRTvBYhqSh5ozOfxBm2uhPcj58anZFYGA5X/ofQHOs
         dEf9yxmyccPR3fQyvcSR0jy8grACffppMRg8SlRgm3sg9Y/yEZ3fRq40VbnVqvCcBJsk
         QmX8p6I8NbN7Alw6nOKf6hVyXm3JmleK7IcPau8bOuz+w1l4aTwkRMd1nQTUQOYE9OxB
         a82ln8V8eMgBNx9fwIrGXk5h0hB6r2KS900QI3jm8FVsTIqRSDER8JBYJmaArphx8tdn
         hJRmQtoKQ5AnUznPa8R0vMQyFyeogCZtLDRx9go5mgKg5zpjA1nh3b1h4cyp87iD7WVw
         Jj9g==
X-Gm-Message-State: APuU4Z+lNVsgJFaBwTh3mExI2AxiomxU5HyI4353qFJrUc6MianmaQzi
	cmn/l5DnTwyb0t80K5vS4gvcIRjbKw0+S7IbgJwZnW6+/iFRSpYD2HgbD27QgQ==
X-Gm-Gg: AYBFou3DyaHrZekp8FeQEvddaInTDPqOcfDgiOQTJSGIFP2sC9rnsSgwBwfVmhdX5Yh
	EVjEsYIL0ir8/XYu3OepoqU4wnFGzx5M+YoKxZuShvgRYo7I6lWWzxJqtnqF12UPxlJrrGOwbmW
	vQpRnenRlvNqPeTRUnxwk3pKG/D3lrsCEl6/VfjYAf5saDohF726C4OxJqaFi2Bs/DeDenON9UX
	NNI/7uWLP64sjZNVWN0hL/6QpsQ4K2MPGeoMVjGbn/EYsaiUiXxYYMPWnK80EZNf2NQY4m3r66E
	8yaQpdGJYCL7PnSLLAed+oOgJt8Kr4fU/K7I/FE010y45JvaejRQUWQfkQjBEFFKTcwUmgnIP1S
	BBXS4iukID46/etODhbxsHdN3k/TqpOm4qzeB/NcN7vpy0TFqL0EZ85fNHLGYQgmQIepOKP/t6O
	6RrBWWrOWcE8MiXw107Vb8LqxP603/KsfCtHm1UpyqN9djnUxsAQPmbq0vlEgvWNx5XiOKi0jVY
	61tcvdG5rQPp6XolOD/MAxbXwT38NZc2M04/XXh7NpwFpyvDtVsUs28XMFXIAh88JNYmL5imI3H
	qiYfHV9qQcDpBdUtoCs0b+C7RfsRvqmK52lGvrvKnzJwaK/q6tNi
X-Received: by 2002:a17:90b:17cd:b0:3ac:97bc:4c98 with SMTP id 98e67ed59e1d1-3ae8986e762mr7960402a91.64.1793635118775;
        Mon, 02 Nov 2026 07:58:38 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d429fsm19183949a91.2.2026.11.02.07.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:58:38 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/6] net: dsa: motorcomm: Add BR_FLOOD and BR_MCAST_FLOOD support
Date: Mon,  2 Nov 2026 23:56:35 +0800
Message-ID: <20261102155641.3682626-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102155641.3682626-1-mmyangfl@gmail.com>
References: <20261102155641.3682626-1-mmyangfl@gmail.com>
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
 drivers/net/dsa/motorcomm/chip.c | 173 ++++++++++++++++++++++++-------
 drivers/net/dsa/motorcomm/chip.h |   4 +
 2 files changed, 138 insertions(+), 39 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index fb993cc9607c..907f7a5b0687 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -1160,6 +1160,7 @@ yt921x_dsa_port_vlan_add(struct dsa_switch *ds, int port,
 
 static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
 {
+	struct yt921x_port *pp = &priv->ports[port];
 	u32 mask;
 	u32 ctrl;
 	int res;
@@ -1190,6 +1191,17 @@ static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
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
@@ -1268,6 +1294,63 @@ static int yt921x_bridge(struct yt921x_priv *priv, u16 ports_mask)
 	return 0;
 }
 
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
+		if (!(flood_ports_xor & ~BIT(port)))
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
+	/* ACT_UNK is TRAP everywhere but the CPU port, which DROPs; see
+	 * yt921x_chip_setup_dsa()
+	 */
+
+	return 0;
+}
+
+static int yt921x_bridge_flood_set(struct yt921x_priv *priv, u16 ports_mask)
+{
+	int res;
+
+	for (int type = 0; type < 2; type++) {
+		res = yt921x_bridge_flood_set_type(priv, ports_mask, type);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
 static int yt921x_bridge_leave(struct yt921x_priv *priv, int port)
 {
 	int res;
@@ -1280,14 +1363,24 @@ static int yt921x_bridge_leave(struct yt921x_priv *priv, int port)
 	if (res)
 		return res;
 
+	/* By the time port_bridge_leave() is called, the port is already
+	 * unbridged, thus we cannot recompute flood flags for the affected
+	 * bridge. This leaves some sub-optimality, but the flood will still
+	 * be handled (by the CPU).
+	 */
+
 	return 0;
 }
 
-static int
-yt921x_bridge_join(struct yt921x_priv *priv, int port, u16 ports_mask)
+static int yt921x_bridge_join(struct yt921x_priv *priv, int port)
 {
+	u16 ports_mask;
 	int res;
 
+	ports_mask = yt921x_port_dest(priv, port);
+	if (!ports_mask)
+		return 0;
+
 	res = yt921x_userport_bridge(priv, port);
 	if (res)
 		return res;
@@ -1296,6 +1389,10 @@ yt921x_bridge_join(struct yt921x_priv *priv, int port, u16 ports_mask)
 	if (res)
 		return res;
 
+	res = yt921x_bridge_flood_set(priv, ports_mask);
+	if (res)
+		return res;
+
 	return 0;
 }
 
@@ -1304,7 +1401,9 @@ yt921x_bridge_flags(struct yt921x_priv *priv, int port,
 		    struct switchdev_brport_flags flags)
 {
 	struct yt921x_port *pp = &priv->ports[port];
-	bool do_flush;
+	bool change_isolated;
+	bool change_flood;
+	u32 ports_mask;
 	u32 mask;
 	int res;
 
@@ -1318,36 +1417,44 @@ yt921x_bridge_flags(struct yt921x_priv *priv, int port,
 			return res;
 	}
 
-	/* BR_FLOOD, BR_MCAST_FLOOD: see the comment where ACT_UNK_ACTn_TRAP
-	 * is set
-	 */
-
 	/* BR_BCAST_FLOOD: we can filter bcast, but cannot trap them */
 
-	do_flush = false;
+	change_isolated = false;
 	if (flags.mask & BR_HAIRPIN_MODE) {
 		pp->hairpin = flags.val & BR_HAIRPIN_MODE;
-		do_flush = true;
+		change_isolated = true;
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
+	change_flood = false;
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
@@ -1408,17 +1515,13 @@ yt921x_dsa_port_bridge_join(struct dsa_switch *ds, int port,
 			    struct netlink_ext_ack *extack)
 {
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
-	u16 ports_mask;
 	int res;
 
 	if (dsa_is_cpu_port(ds, port))
 		return 0;
 
-	ports_mask = dsa_bridge_ports(ds, bridge.dev);
-	ports_mask |= priv->cpu_ports_mask;
-
 	mutex_lock(&priv->reg_lock);
-	res = yt921x_bridge_join(priv, port, ports_mask);
+	res = yt921x_bridge_join(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
 	return res;
@@ -2275,14 +2378,6 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
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
@@ -2291,9 +2386,9 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
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

