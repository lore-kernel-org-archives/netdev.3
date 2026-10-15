Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC0E4BF924
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061160; cv=none; b=OE/yLyMzdNy8Jajxxs4N6cPOjJCEJ7gaSXSdQt7Kpw26vHq67pFc9P8rOE2ycfuBE57AAsB1UbZEHCehnEk79I6819d/M5NvXUMl/m14isbBBTKu/+XgRM+oYfChVFNAKpc0Y/p1+WnYMuIHqFqmJPlTlfxPcVODg+Tv5RXBRK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061160; c=relaxed/simple;
	bh=XjqFGGhWxnBM68o8iILc1Q0NMdOJ1sFt4q4gXSkvrng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QMwUFpYRuRYUtmhW6oOHmgn/lLk31csfoswAzO7tq4WNw8oc/HO1GQUAArSZIoD09bRaKQ16Qtxuz09iTJVUB5R263YGn+BnUoVFRM3NW5Z76mAu5ZiqrdEp1Kw58O0U4dVWs2QPwR9uf6s5vvqlpya9vjKlqkWxO4El2jxUOYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StcT1t1K; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StcT1t1K"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1aa29e06bso3243935a12.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 03:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792061156; x=1792665956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IxFWoN5ur3EbIeo6PfJtMrMZmQs9N78gDIkfe6qxWGs=;
        b=StcT1t1KAUyBiA36owktkGhkaLI+NebzE7CtCXvh2CyxvYAxu9CTOlgXHo54ooJFkd
         ng4qPyGxL98jCONYQ09Bd5JK0ArYJWF4C+2K1dw+eK9ILq7p9Ska13MeF/JaN1AgJ5Ev
         TXjQkuMogWvKcYGzegn0BhOKc8A/V/vXlTkk1lHlxiJDuEE3/XaFsMHABTOfjzrVH63k
         XkUtjmc0m/r5eYJrrWqDNBigUAZqaMolKOA3Vb9EDvP4r0bAFs0sekLxEPs9TXDcT0UC
         e7T7X2TtQr6Lxh/+oEesptp74ghahNKRVfYt+25ydMYT9GiecE2ia4TL/11hr8KHroGf
         r6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792061156; x=1792665956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IxFWoN5ur3EbIeo6PfJtMrMZmQs9N78gDIkfe6qxWGs=;
        b=l5+BTQaWm0GbqhVE+4OfBN89RWVsF6hgQYzfg5K0AK9wSGqZpekK5K9kIhTcLOGhJS
         awOxSGtzefbAknCSy4jJ2U4fbhRC5cKA9VeX0/rLk51pqr1bmVI7/lIncd1b1iYnpKEu
         wBnNUDeiJzgyiNlmfqqhkaPj6gZ5IEJWw3GCGNb/lH5ArVtMimL/yH3lJCIxDaTiZGnw
         73ld1+e1Kgy+o4b4UoYW7PB/hCn7vnxUdnRxkpOf2KHWdJU2M4i4eA1mfJSQRjumcUl2
         16oy1wM7iZaZgP45GihKUYqzOeHYOFI7DNNjCrBhg62GX/M6Bv/u1XExDOghYcy1Mjtb
         TFpA==
X-Gm-Message-State: AFq9FYIlTNeX/Zkolocgv6Lu88PrM8WNYqAzNpGikcdg+jRdijROcjaF
	oJCLF8KOTbyQ//E+2zTdWDGK/Xs5xzJ6G42jnzOQBWFH5Raj+GXopGG5OAqjwsHijsY=
X-Gm-Gg: AYBFou22oNcuhghdbcvwIIH5U4qYFUeG7yrsKKRt/B+nwoNwpc9amPFc1crn2kQeaBk
	GIlsOA2XMr0MSYh9DXQYKYo+WRyjpH5PzSssl4S/QK276ZUWSezE57OkMmEna/ZXJPZQ4Mc0ElP
	R13Msnd2nS91qdPSFWhPZcEbAPgIh3YbMLkYEJpDAQi2BK/mP11UplVk4P+70jpnCf5sqs8rEMc
	I7OM6znxT5+twj5wDmqxCX4gmqiKdbsEXZqR86ovjw3v6KnRwPRUgAP++oeg8jnfAggl5CrWYGZ
	oek/V4u+icsFWzdwjKR2rT3Kxzfg1qzw5BKcF1keToHZ/7uUiLlNgaL/YovpIcEZUffVf8HEVa5
	LwdzuhCKiBsNcXzlTUGiKbEIxdutUuQX6r8gv9FdpTTH7S+LJmZ1lKIsDXsRgvr+0oqcoc5jWEt
	ZvSJIlAc+HXSOlBBLXeuMT/m4C9bQ3g5jqVI5Mof7v47aj3K5oiJC2OXTM9ZwqF14sQKZTjsUxn
	rstK1WYeKqD00akhgUAN8228WFkuBJJcQQHBL26Jp8ZcDZ0VKfYfVyBt+cQ0VMxlPBqrzmi3lbV
	Mhk=
X-Received: by 2002:a05:6402:42c7:b0:6b1:cc39:28e5 with SMTP id 4fb4d7f45d1cf-6b1cc392c26mr9113407a12.40.1792061155641;
        Thu, 15 Oct 2026 03:45:55 -0700 (PDT)
Received: from CCM-PC (94-255-221-162.cust.bredband2.com. [94.255.221.162])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b203762b7bsm2416018a12.4.2026.10.15.03.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:45:54 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH net v5] net: dsa: qca8k: preserve port state across MTU changes
Date: Thu, 15 Oct 2026 12:45:50 +0200
Message-ID: <20261015104550.43169-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MTU update pauses enabled ports 0 and 6 and then unconditionally
enables their MACs. A port can remain enabled while phylink has disabled
its MAC after a link-down event, so an MTU change can undo that decision.

The sequence can also interleave with phylink MAC callbacks, which run
without RTNL. A link-up can re-enable a MAC before the frame-size write,
or the restore can overwrite a link-down. Commit 386228c694bf found that
changing MAX_FRAME_SIZE while a CPU port is on can stop the switch from
sending packets until it is reset; a MAC re-enabled by the link-up leaves
that window open. This can happen at boot, when the CPU port's first
link-up is still pending as DSA sets the user ports' MTU.

Serialize the MTU transaction and PORT_STATUS writers with a dedicated
mutex. Save and restore the MAC bits instead of forcing them on. Abort
on detected read or pause errors, attempt to restore every touched port,
and return the first error. Keep PHY and phylink calls outside the lock.

Fixes: 386228c694bf ("net: dsa: qca8k: reset cpu port on MTU change")
Assisted-by: LLM
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
---
v5 (split from net-next v4 2/3):
- Separate the existing port 0/6 fix from internal CPU port support and
  target net, with a Fixes tag for the pause/restore sequence.
- Use a dedicated port_status_lock, as Christian suggested [1].
- Keep the pause scope at enabled ports 0/6, including user ports.

My earlier reply ruled out races in port_enabled_map under RTNL, not
the MTU transaction defects fixed here. These were found by code
inspection, not from a port 0/6 hardware failure.

The net base still has MDIO accesses which can swallow write errors.
This patch handles errors returned by the register API; it does not fix
that transport limitation or depend on the MDIO series in net-next.

net-next has since switched qca8k_port_set_status() to
regmap_assign_bits(). When merging, keep that call in
__qca8k_port_set_status().

The affected arm64 objects build with W=1. A userspace harness compiles
the actual driver functions and checks saved-state restoration,
MTU/callback interleavings and detected-error recovery. The old code and
10 mutations fail the relevant checks. These are software checks; this
standalone revision has not been tested on hardware.

[1] https://lore.kernel.org/netdev/6abb535c.8fb0a6ce.10321.5538@mx.google.com/
v4: https://lore.kernel.org/netdev/20260928220811.1880-3-yongzhao.derek@gmail.com/

 drivers/net/dsa/qca/qca8k-8xxx.c   |  3 ++
 drivers/net/dsa/qca/qca8k-common.c | 88 ++++++++++++++++++++++++++++++--------
 drivers/net/dsa/qca/qca8k.h        |  5 +++
 3 files changed, 77 insertions(+), 19 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 4c928983b..9aadca8b9 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1483,7 +1483,9 @@ qca8k_phylink_mac_link_up(struct phylink_config *config,
 
 	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
 
+	mutex_lock(&priv->port_status_lock);
 	qca8k_write(priv, QCA8K_REG_PORT_STATUS(port), reg);
+	mutex_unlock(&priv->port_status_lock);
 }
 
 static struct qca8k_pcs *pcs_to_qca8k_pcs(struct phylink_pcs *pcs)
@@ -2116,6 +2118,7 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
 	priv->ds->ops = &qca8k_switch_ops;
 	priv->ds->phylink_mac_ops = &qca8k_phylink_mac_ops;
 	mutex_init(&priv->reg_mutex);
+	mutex_init(&priv->port_status_lock);
 	dev_set_drvdata(&mdiodev->dev, priv);
 
 	return dsa_register_switch(priv->ds);
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 13005f10e..084df92c5 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -463,7 +463,7 @@ int qca8k_mib_init(struct qca8k_priv *priv)
 	return ret;
 }
 
-void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
+static u32 qca8k_port_status_mask(int port)
 {
 	u32 mask = QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
 
@@ -471,10 +471,27 @@ void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
 	if (port > 0 && port < 6)
 		mask |= QCA8K_PORT_STATUS_LINK_AUTO;
 
+	return mask;
+}
+
+static void __qca8k_port_set_status(struct qca8k_priv *priv, int port,
+				    int enable)
+{
+	lockdep_assert_held(&priv->port_status_lock);
+
 	if (enable)
-		regmap_set_bits(priv->regmap, QCA8K_REG_PORT_STATUS(port), mask);
+		regmap_set_bits(priv->regmap, QCA8K_REG_PORT_STATUS(port),
+				qca8k_port_status_mask(port));
 	else
-		regmap_clear_bits(priv->regmap, QCA8K_REG_PORT_STATUS(port), mask);
+		regmap_clear_bits(priv->regmap, QCA8K_REG_PORT_STATUS(port),
+				  qca8k_port_status_mask(port));
+}
+
+void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
+{
+	mutex_lock(&priv->port_status_lock);
+	__qca8k_port_set_status(priv, port, enable);
+	mutex_unlock(&priv->port_status_lock);
 }
 
 void qca8k_get_strings(struct dsa_switch *ds, int port, u32 stringset,
@@ -751,8 +768,10 @@ int qca8k_port_enable(struct dsa_switch *ds, int port,
 {
 	struct qca8k_priv *priv = ds->priv;
 
-	qca8k_port_set_status(priv, port, 1);
+	mutex_lock(&priv->port_status_lock);
+	__qca8k_port_set_status(priv, port, 1);
 	priv->port_enabled_map |= BIT(port);
+	mutex_unlock(&priv->port_status_lock);
 
 	if (dsa_is_user_port(ds, port))
 		phy_support_asym_pause(phy);
@@ -764,14 +783,18 @@ void qca8k_port_disable(struct dsa_switch *ds, int port)
 {
 	struct qca8k_priv *priv = ds->priv;
 
-	qca8k_port_set_status(priv, port, 0);
+	mutex_lock(&priv->port_status_lock);
+	__qca8k_port_set_status(priv, port, 0);
 	priv->port_enabled_map &= ~BIT(port);
+	mutex_unlock(&priv->port_status_lock);
 }
 
 int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 {
+	u32 status[QCA8K_NUM_PORTS] = { 0 };
 	struct qca8k_priv *priv = ds->priv;
-	int ret;
+	unsigned long ports, stopped = 0;
+	int ret, restore_ret, i;
 
 	/* We have only have a general MTU setting.
 	 * DSA always set the CPU port's MTU to the largest MTU of the user
@@ -782,27 +805,54 @@ int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	if (!dsa_is_cpu_port(ds, port))
 		return 0;
 
-	/* To change the MAX_FRAME_SIZE the cpu ports must be off or
-	 * the switch panics.
-	 * Turn off both cpu ports before applying the new value to prevent
-	 * this.
+	/* To change MAX_FRAME_SIZE, pause enabled ports 0 and 6.
+	 * Serialize with phylink and restore the saved MAC state.
 	 */
-	if (priv->port_enabled_map & BIT(0))
-		qca8k_port_set_status(priv, 0, 0);
+	mutex_lock(&priv->port_status_lock);
+
+	ports = (BIT(0) | BIT(6)) & priv->port_enabled_map;
 
-	if (priv->port_enabled_map & BIT(6))
-		qca8k_port_set_status(priv, 6, 0);
+	for_each_set_bit(i, &ports, QCA8K_NUM_PORTS) {
+		ret = regmap_read(priv->regmap, QCA8K_REG_PORT_STATUS(i),
+				  &status[i]);
+		if (ret)
+			goto unlock;
+	}
+
+	for_each_set_bit(i, &ports, QCA8K_NUM_PORTS) {
+		u32 mask = qca8k_port_status_mask(i);
+
+		if (!(status[i] & mask))
+			continue;
+
+		__set_bit(i, &stopped);
+		ret = regmap_clear_bits(priv->regmap, QCA8K_REG_PORT_STATUS(i),
+					mask);
+		if (ret)
+			goto restore;
+	}
 
 	/* Include L2 header / FCS length */
 	ret = qca8k_write(priv, QCA8K_MAX_FRAME_SIZE, new_mtu +
 			  ETH_HLEN + ETH_FCS_LEN);
 
-	if (priv->port_enabled_map & BIT(0))
-		qca8k_port_set_status(priv, 0, 1);
-
-	if (priv->port_enabled_map & BIT(6))
-		qca8k_port_set_status(priv, 6, 1);
+restore:
+	for_each_set_bit(i, &stopped, QCA8K_NUM_PORTS) {
+		u32 mask = qca8k_port_status_mask(i);
+
+		restore_ret = regmap_update_bits(priv->regmap,
+						 QCA8K_REG_PORT_STATUS(i),
+						 mask, status[i] & mask);
+		if (restore_ret) {
+			dev_err(priv->dev, "failed to restore MAC state on port %d: %d\n",
+				i, restore_ret);
+			if (!ret)
+				ret = restore_ret;
+		}
+	}
 
+unlock:
+	mutex_unlock(&priv->port_status_lock);
 	return ret;
 }
 
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 956338893..9225f4c40 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -459,6 +459,11 @@ struct qca8k_priv {
 	struct mii_bus *internal_mdio_bus;
 	struct dsa_switch *ds;
 	struct mutex reg_mutex;
+	/* Serializes writes to QCA8K_REG_PORT_STATUS and the MTU update. Taken
+	 * from phylink MAC callbacks: do not access a PHY or call into phylink
+	 * with it held.
+	 */
+	struct mutex port_status_lock;
 	struct device *dev;
 	struct gpio_desc *reset_gpio;
 	struct net_device *mgmt_conduit; /* Track if mdio/mib Ethernet is available */
base-commit: f88bb3606e4bd11ee035b682cddc2999e604609a
-- 
2.43.0
