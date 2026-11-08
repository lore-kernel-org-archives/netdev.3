Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174330;
	b=F9Y12jc2DOKJycLP/mWGLT0bmNHLBRbSP9hw9i/GljXK+p4luCd+KIuDz81Wua6hogDn
	 Fx82DdRTxpeiEK7a6iBFO4LxkMkKge9jw4nLMLBW1AIhKlMWROnkGCv8IGWXemkZnJQfi
	 csRBEO/FmRjWxcQkXi1/0TFKN86eqmN5Z933wZ5bVPF00oTMKVC9qZd+ZUiIwoyj366HT
	 MM8ctTJvx+BmiV7haPnJ711p6oASxR5cmEaY0R5aCV4Nquy7a3zRUtp7CGE+CUiLuX/Sb
	 dEyYq+Zx3L8mWWVotA1NJ9y3lFlYqq9ddrzAKFW0SjEoMkKnyE8CLpO1KsQjtH7HPqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JUxUAMy16IVX6oKR7B7W9Pu+/Amfhkj4aAkm8I1TZU8=;
	b=YphowjZqGZzEYHZbNAMlHpEjBxB9DEmlXz0JaPKyqskPYVbhcE24l3Rh3G6Y6Leq3IvN
	 4lB0cjYKZU63yoG39hC46y2rM+Kv8m6CRBR0nHeyTGDsHGCwmWLWZtUcd0xNYHwC0TROp
	 oyE7Btv8bcnosZYGk1aN6cKiSHAPzxeapmduJGSD6yFLYcP28u4LzXE3Fhg+FSB2/PbA+
	 bZbjvFC2RnsqSWJw3dvU1ZUFygcyv25tkHjvK7izHd32Q92JwMIrpRzIK8iFVqJS9oka5
	 lWLv1++vlK6F6yH18NLq6LIMUhZ19ShO39oyjmChb20SKQv9Thsyha/IaqtEJWljjXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="t96MQh/f";
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF4606D839
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 21:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78FF4606D839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t96MQh/f
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso190259a91.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794174329; x=1794779129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JUxUAMy16IVX6oKR7B7W9Pu+/Amfhkj4aAkm8I1TZU8=;
        b=t96MQh/fvAozkfyI7tfGPF/kwaP9aGKoKEZtcA+xWx5nBBqs8tKDA9SiIQNJSGCupo
         5jHvQH5WoV1dlDfViMxihsnVMJ+hV6/fpo05K3UTvccatwWzMwRdzjS2E24VIqhCMZHg
         RbUabdCVR84KzNg+JLXbeb9St9iDT+apkearz8GaW0xdaXSLdaXXjMpeoUAPrwWk9FFi
         kagQ9dngm7Jk0witf0m7ymwyoDzoA1px+pQ3Clg4SXyVIVXj3eGNoV5EyTQKL4S80ULn
         vzCowjuk6V1xI7jgevjJV6+bPg1DcY78fdfrSjwOyj/UIEhdN19j/7LG4kxMdj9WW44H
         8+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794174329; x=1794779129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JUxUAMy16IVX6oKR7B7W9Pu+/Amfhkj4aAkm8I1TZU8=;
        b=LDKouqYg8Dr0zxkg7imAA+fK5ig45nHFW8nN4n+982X0RNaWt2+xeBuV+BsnpvlNIg
         kQR0SbuwsTUiClBoxcWabWGwGBLcCc5SGchrxDvS0YLZw4pM8iwVADhpN3OO2wsPWB/I
         fhIBbeQ1KrX4R29QcxfnfJr6AYRG/MU6bB2Rdu1LNAnxlhRmOZ6zf96JeMF3DTnLaSAl
         Pt02IfBhg8cRWDBkptQbWW61iFDGZeWekB2j8utfD9Odp0HLnvVadPqm6EnRGxyfdmv4
         htjRMIaKrvVRFw18JXtjy7rFbvKqvMo01+NOsAF86EyCV+OgL0gevROIjZdjBDczvYWz
         v3Pg==
X-Gm-Message-State: APuU4Z+LZANVNUFPMRL8Ixz+Y61Ri1hGtVzXciG/rYIaEwvmOT82DuO3
	EWeLeWh/BpWbZyhFsJlrLM5FxL2JFUQCTbdANmUEp58Age2aoQjL1u5UqULsZQ==
X-Gm-Gg: AYBFou1n6vPTxaOGhPScU2fO6xsDhNFFnfGeLL0+ZA1eRwhXB4uuq4lNmmDhrbm0tXZ
	k3+9CNbVGdQrq9YWjDgUCV/VjMwzDSRKAEHWHT2rDM3z1oTLM9VuBlfBf9qKBeuj/g0H8PIOI4N
	JH+HbagmbOluRt2m6YJxbFcyVVQjZzqQAW7yXJkUlOBh6Elh3Dapd6bIGNLHA8w83TqbJz4XoBm
	8Wf972BSVUH7oG7TAmV9KjyscAmFQHo0l3YWESOZ8XCdgNXRgSRSF4ISrecytEfCI4rUCKPRHNE
	e8o0so+Ai6aM2LsCDaS6XxgtDymoA6cUANalG6wWo6LjYdB0oV3dTM5PDNvXh1eS8Gg8CD8HosX
	jnmHjyuunW79IUxER5NDowLJW1aiaeslYsHn9rNtxilrMi2ug97zEmMtpKfVKDIes6+tTdQW8oe
	66lqdMDyAlHs9QIIwDlCFe+ru3SiAiAuzB1dQd3QDulKT0DlP2fQddDEUiyKbGghYlPWByOEMQQ
	4FAuBtKmGVKoe6RrjLZ2ylsxMb3jdd8RmvFmibOnalh29ru54/+6qGNw0+lCfLksFGAhKvuhte7
	OSWpUdm5iT8M+mSn0RXSKHcCuyV3qpq47eoo02aVnWQDBSW8KSNoOA==
X-Received: by 2002:a17:90b:384c:b0:3a5:147a:3b63 with SMTP id 98e67ed59e1d1-3b12d1027d4mr2233089a91.8.1794174328700;
        Sun, 08 Nov 2026 13:45:28 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1034718f8sm4619463a91.4.2026.11.08.13.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:45:28 -0800 (PST)
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
Subject: [PATCH net-next v5 7/7] net: dsa: motorcomm: Support BR_FLOOD and BR_MCAST_FLOOD offloading
Date: Mon,  9 Nov 2026 05:44:47 +0800
Message-ID: <20261108214450.1662362-8-mmyangfl@gmail.com>
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

Let the hardware flood the unknown unicast / multicast for the port if:

- the switch carries only one bridge, otherwise frames hitting FDB entry
  from another bridge will be dropped;
- all other ports in the bridge have BR_FLOOD / BR_MCAST_FLOOD enabled;
- the port is not hairpined, as the hardware never floods back to its
  ingress port.

This should cover most single-bridge usage. Other data paths remain
unchanged in terms of behavior.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 181 ++++++++++++++++++++++++++-----
 drivers/net/dsa/motorcomm/chip.h |  15 +++
 2 files changed, 170 insertions(+), 26 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 3d4aa79ac026..480203ac7c8e 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -1195,13 +1195,17 @@ static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
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
 
+	/* Also unrelated for FILTER_UNK_UCAST / FILTER_UNK_MCAST since all
+	 * packets are handled by software
+	 */
+
 	return 0;
 }
 
@@ -1218,6 +1222,97 @@ static int yt921x_userport_bridge(struct yt921x_priv *priv, int port)
 	return 0;
 }
 
+/* ports_mask is optional */
+static int yt921x_bridge_flood_set(struct yt921x_priv *priv, u16 ports_mask)
+{
+	struct dsa_bridge *bridges[YT921X_PORT_NUM];
+	struct dsa_switch *ds = &priv->ds;
+	struct dsa_port *dp;
+	unsigned int count;
+	u32 ctrl;
+	int res;
+	int ret;
+
+	/* Offloading is only enabled if there is at most 1 bridge - see the
+	 * cross-bridge FDB mismatch below. (0 does nothing, of course.)
+	 */
+	count = 0;
+	dsa_switch_for_each_user_port(dp, ds) {
+		unsigned int i;
+
+		if (!dp->bridge)
+			continue;
+
+		for (i = 0; i < count; i++)
+			if (bridges[i] == dp->bridge)
+				break;
+		if (i == count) {
+			bridges[count] = dp->bridge;
+			count++;
+		}
+	}
+
+	ret = 0;
+	if (count != 1) {
+		ctrl = YT921X_FILTER_PORTS_M;
+		res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
+		if (res)
+			ret = res;
+		res = yt921x_reg_write(priv, YT921X_FILTER_UNK_MCAST, ctrl);
+		if (res)
+			ret = res;
+		return ret;
+	}
+
+	if (ports_mask)
+		ports_mask &= ~dsa_cpu_ports(ds);
+	if (!ports_mask)
+		ports_mask = dsa_bridge_ports(ds, bridges[0]->dev);
+
+	for (int type = 0; type < 2; type++) {
+		unsigned long targets_mask = ports_mask;
+		u16 flood_mask;
+		u32 addr;
+		int port;
+
+		addr = !type ? YT921X_FILTER_UNK_UCAST :
+		       YT921X_FILTER_UNK_MCAST;
+
+		flood_mask = 0;
+		for_each_set_bit(port, &targets_mask, YT921X_PORT_NUM) {
+			struct yt921x_port *pp = &priv->ports[port];
+
+			if (!type ? pp->flood : pp->mcast_flood)
+				flood_mask |= BIT(port);
+		}
+
+		ctrl = 0;
+		for_each_set_bit(port, &targets_mask, YT921X_PORT_NUM) {
+			struct yt921x_port *pp = &priv->ports[port];
+
+			/* Hardware never floods back to its own ingress port,
+			 * keep hairpin port trapped: the software bridge does
+			 * deliver a flood there.
+			 */
+			if (!pp->hairpin && !((flood_mask ^ ports_mask) &
+					      ~BIT(port)))
+				continue;
+
+			ctrl |= BIT(port);
+		}
+
+		/* ACT_UNK is fixed to TRAP for every port, see
+		 * yt921x_chip_setup_dsa().
+		 */
+
+		res = yt921x_reg_update_bits(priv, addr, ports_mask, ctrl);
+		if (res)
+			ret = res;
+	}
+
+	return ret;
+}
+
 static int yt921x_isolate(struct yt921x_priv *priv, int port)
 {
 	u32 mask;
@@ -1292,6 +1387,10 @@ static int yt921x_bridge_leave(struct yt921x_priv *priv, int port)
 	if (res)
 		return res;
 
+	res = yt921x_bridge_flood_set(priv, 0);
+	if (res)
+		return res;
+
 	return 0;
 }
 
@@ -1308,6 +1407,10 @@ yt921x_bridge_join(struct yt921x_priv *priv, int port, u16 ports_mask)
 	if (res)
 		return res;
 
+	res = yt921x_bridge_flood_set(priv, ports_mask);
+	if (res)
+		return res;
+
 	return 0;
 }
 
@@ -1316,7 +1419,12 @@ yt921x_bridge_flags(struct yt921x_priv *priv, int port,
 		    struct switchdev_brport_flags flags)
 {
 	struct yt921x_port *pp = &priv->ports[port];
-	bool do_flush;
+	struct dsa_switch *ds = &priv->ds;
+	bool change_isolated = false;
+	bool change_flood = false;
+	struct net_device *bdev;
+	struct dsa_port *dp;
+	u32 ports_mask;
 	u32 mask;
 	int res;
 
@@ -1330,36 +1438,48 @@ yt921x_bridge_flags(struct yt921x_priv *priv, int port,
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
-			ports_mask |= dsa_cpu_ports(ds);
-			res = yt921x_bridge(priv, ports_mask);
-			if (res)
-				return res;
-		}
+	if (!change_isolated && !change_flood)
+		return 0;
+
+	dp = dsa_to_port(ds, port);
+	bdev = dsa_port_bridge_dev_get(dp);
+	if (!bdev)
+		return 0;
+
+	ports_mask = dsa_bridge_ports(ds, bdev);
+	ports_mask |= dsa_cpu_ports(ds);
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
@@ -2332,9 +2452,8 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	 * the "bridged" ports, thus we need to trap and handle those packets by
 	 * software.
 	 *
-	 * If there is no more than one bridge, we might be able to drop them
-	 * directly given some conditions are met, but we trap them in all cases
-	 * for now.
+	 * The flood action is offloaded to the hardware by fixing UNK_ACT to
+	 * TRAP and toggling the FILTER_UNK on the appropriate ports.
 	 */
 	ctrl = 0;
 	for (int i = 0; i < YT921X_PORT_NUM; i++)
@@ -2353,6 +2472,16 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
+	/* Capture RMA when offloading mcast flood to hardware */
+	for (int i = 0; i < 0x10; i++) {
+		/* Reuse unknown mcast code */
+		ctrl = YT921X_RMA_CTRL_CPU_CODE(0x1a) |
+		       YT921X_RMA_CTRL_COPY_TO_CPU | YT921X_RMA_CTRL_DROP;
+		res = yt921x_reg_write(priv, YT921X_RMA_CTRLn(i), ctrl);
+		if (res)
+			return res;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index ab6f28d057cb..12a7d1bf9f1d 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -329,6 +329,17 @@ enum yt921x_app_selector {
 #define YT921X_LAG_MEMBERnm(n, m)	(0x1805b0 + 4 * (4 * (n) + (m)))
 #define  YT921X_LAG_MEMBER_PORT_M		GENMASK(3, 0)
 #define   YT921X_LAG_MEMBER_PORT(x)			FIELD_PREP(YT921X_LAG_MEMBER_PORT_M, (x))
+#define YT921X_RMA_CTRLn(n)		(0x1805d0 + 4 * (n))
+#define  YT921X_RMA_CTRL_BYPASS_STORM		BIT(12)
+#define  YT921X_RMA_CTRL_BYPASS_FLOW_METER	BIT(11)
+#define  YT921X_RMA_CTRL_BYPASS_PORT_METER	BIT(10)
+#define  YT921X_RMA_CTRL_DROP			BIT(9)
+#define  YT921X_RMA_CTRL_COPY_TO_CPU		BIT(8)
+#define  YT921X_RMA_CTRL_IGNORE_VLAN		BIT(7)
+#define  YT921X_RMA_CTRL_IGNORE_PORT_ISOLATE	BIT(6)
+#define  YT921X_RMA_CTRL_CPU_CODE_M		GENMASK(5, 0)
+#define   YT921X_RMA_CTRL_CPU_CODE(x)			FIELD_PREP(YT921X_RMA_CTRL_CPU_CODE_M, (x))
+#define   YT921X_RMA_CTRL_CPU_CODE_DEFAULT		0x3f
 #define YT921X_CPU_COPY			0x180690
 #define  YT921X_CPU_COPY_FORCE_INT_PORT		BIT(2)
 #define  YT921X_CPU_COPY_TO_INT_CPU		BIT(1)
@@ -461,6 +472,10 @@ struct yt921x_port {
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

