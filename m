Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5B73F411B
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108844; cv=none; b=U9lE2KeaM1q3U+021Na8Ej6aLpGN8cTLXeUl4G1TcAX5EuoIcNmgKpXjy6DkyRYkUOP8qDYH7JYGg7LiHPvcI0aW9KAfIB6SiHHVrac+2ifS8ygV/gBFGTjx7xo3VcrnSTY4C3rl96Ps4r79pZsRcknVa7CdUgWWq1ZIWX4mkGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108844; c=relaxed/simple;
	bh=YcKT9EsOtWDdZRRQYQDqhQRwdef3pj0nyuaJ4MJUb4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i533l0ATlTGE4X4EIiUS6p8Kfq6kQa1M99nbasBeLEyRt3i7QrccxMcEqN2uI2cq0uJngree1jdtAz/YLI0zc3hFJyJi3ZhJsQKa+ftPcZlyfeMPrSGFGzFiSzxFSAPyvuybhkdL0UiTgGhZHAkBLypXJ78yJSWrd+DPTodMn6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XK/VZ4td; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK/VZ4td"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa650c8so37359566b.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790108830; x=1790713630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HhvMNPpw1KlVt9otvNzV2DWv3RwJ+IXwKK2BxBGCwN0=;
        b=XK/VZ4tdyLq4i3HAAidBSEtbHGbfuL8vL1PpqbjAWmn6dp0rhhNJ67dTnXE6k0dR7j
         wDmOJYwNWqwjpSIsOdGoiWHPkjwL+SalRYZliKK7bMio5QVMMeNjDaYLduKJ61/CHXpN
         MUQt2TOnX4sAs6pWlenC47yx2pWFFf3QFkfWTImtfxjQrA0jRfC59COQpnQobu7PMBH4
         s6iBbV8p7ukajBT/mVIv6x0R9Ujn4AWCVEkdgA8wjP6c9ZiaLJuqhtRsJ4Cjo3sPMxrv
         cE1/igRv1jKNvy7OMY+/2DtYUptvQFRVDehCXkwAJHqeNYmb7gcIZ6ftz0u0o3DSUhwk
         9ZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108830; x=1790713630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HhvMNPpw1KlVt9otvNzV2DWv3RwJ+IXwKK2BxBGCwN0=;
        b=sY4pEputt1EW56jvXnnxih56vEohDcTNTirrXPdBqTqCnPts971NB4nwt/aeUgqmqe
         WOh1v2AA5P8s/cjSOwdiWnDN0HiD+inquTEJPrYtUJugKaIRfEBLK0GUiaIhYjOR1bMG
         rI5OWoDyVCiDppr9hfWhQHcbzbOXWAaAOv6jEcm+02VJvZJgOSyulR2nN7CoX5+AsUC3
         oFl0hkjp9896CVLXKkz3SZiH8JKcQZyo2Aa1KbWvP0Ffpj3bcF3qJUAo1iWuKomXog9V
         4yRc97xZWW6UH5hQWHdGfObZ8lPgbbkCdym6hQCTw9+3JstfdEXSpy5y7ml11amoMw1a
         jqYw==
X-Gm-Message-State: AFuF++lkmHpAvqvaQUN/x8pvvAhe85dGz0U8torMoabQLhdw0fAOK9SF
	xTs+4p2qSI4WA8K5ILW2dL8bjPQdupNLI+LlTEK40YWHOO9bCTM11dUYL6Vk3Dc5ozQ=
X-Gm-Gg: AYBFou3l50OPxiOyf31fI2Z4TKBHwOJJN00XlReiW6W/c439i8FdD8cBAWJvBZlMWlh
	tkx7rCRihN61CAaz9fp9lEx+YukYVVMUs9ZrZfY5NiA9pwwISWmRJeeOrzVnxW8+ewKMyexhaas
	eqjhdsgv1gnuaUm7qjbY0T2BPXmx3NfbSnuieXWIpNygEHm9ZP8RmeNMUe2wy4zjs7ezGYWnUyl
	rstVIsHJMoaJ4FCdexo8L1BVCZNlvnD0mnfuiygwJCqc7/Kb+cq8iKqguBDAYiqbRb8plVa0oPf
	elUcCYRFTRdTfnAbF4recy06Pn2Mfv7y57c2sATcqVD5D447bbwOhG5nuNLhhltNWbjDkp1W3jL
	l76cNonx6QFkfNgl9Q2BG2X8shnfC3vhqECfOacJNZUFR3TVUsb8WHNazvNAF2/e+IrBxJSAAR2
	NCGvXdY127NdreQqg07/u8p6BbucBicoKJIbVhTxx7VEMWYptadZQEm2w4DFR7YspN7s0F6Jfhq
	sdEWYp9fxLuj416LbroFNAafmStBGA7WzvAfoyQGE1Fvc233ngLwYb+8C8yTdWah0XYh2ZnolJG
	xXNQTYsHqiY1oJoPLP9Z
X-Received: by 2002:a17:907:9728:b0:c12:e178:9e68 with SMTP id a640c23a62f3a-c2aae1964d8mr27199366b.19.1790108829620;
        Tue, 22 Sep 2026 13:27:09 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-25.cust.bredband2.com. [83.233.130.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c6f5asm11080466b.15.2026.09.22.13.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:27:09 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	ansuelsmth@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	hzyitc@outlook.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Yongzhao Chen <yongzhao.derek@gmail.com>
Subject: [RFC PATCH net-next v2 3/5] net: dsa: qca8k: serialize CPU MAC pause during MTU changes
Date: Tue, 22 Sep 2026 22:26:51 +0200
Message-ID: <20260922202653.1153-4-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20260922202653.1153-1-yongzhao.derek@gmail.com>
References: <20260922202653.1153-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global maximum frame size must be changed with CPU MACs disabled.
The old sequence only handled ports 0 and 6, leaving an internal PHY CPU
port enabled while the register was updated.

Include enabled internal CPU ports in the pause. Serialize the whole MTU
update with port enable/disable and phylink link-up/down callbacks, so a
link-up cannot re-enable a CPU MAC during the frame-size write. Read and
restore each port's original TXMAC/RXMAC bits instead of enabling both
unconditionally; a link-down port remains down and LINK_AUTO is preserved.

Abort before updating the frame size if a status read or MAC pause fails,
attempt to restore any port already touched, and report a restore error
when the frame-size write itself succeeded.

Keep the existing treatment of ports 0 and 6, including when either is a
user port.

Assisted-by: LLM
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c   |  3 ++
 drivers/net/dsa/qca/qca8k-common.c | 79 ++++++++++++++++++++++++------
 drivers/net/dsa/qca/qca8k.h        |  2 +
 3 files changed, 69 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 17704cb53..787f30495 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1486,7 +1486,9 @@ qca8k_phylink_mac_link_up(struct phylink_config *config,
 
 	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
 
+	mutex_lock(&priv->port_status_mutex);
 	qca8k_write(priv, QCA8K_REG_PORT_STATUS(port), reg);
+	mutex_unlock(&priv->port_status_mutex);
 }
 
 static struct qca8k_pcs *pcs_to_qca8k_pcs(struct phylink_pcs *pcs)
@@ -2119,6 +2121,7 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
 	priv->ds->ops = &qca8k_switch_ops;
 	priv->ds->phylink_mac_ops = &qca8k_phylink_mac_ops;
 	mutex_init(&priv->reg_mutex);
+	mutex_init(&priv->port_status_mutex);
 	dev_set_drvdata(&mdiodev->dev, priv);
 
 	return dsa_register_switch(priv->ds);
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 13005f10e..a584ddf72 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -463,7 +463,8 @@ int qca8k_mib_init(struct qca8k_priv *priv)
 	return ret;
 }
 
-void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
+static void qca8k_port_set_status_locked(struct qca8k_priv *priv, int port,
+					 int enable)
 {
 	u32 mask = QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
 
@@ -477,6 +478,13 @@ void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
 		regmap_clear_bits(priv->regmap, QCA8K_REG_PORT_STATUS(port), mask);
 }
 
+void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
+{
+	mutex_lock(&priv->port_status_mutex);
+	qca8k_port_set_status_locked(priv, port, enable);
+	mutex_unlock(&priv->port_status_mutex);
+}
+
 void qca8k_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		       uint8_t *data)
 {
@@ -751,8 +759,10 @@ int qca8k_port_enable(struct dsa_switch *ds, int port,
 {
 	struct qca8k_priv *priv = ds->priv;
 
-	qca8k_port_set_status(priv, port, 1);
+	mutex_lock(&priv->port_status_mutex);
+	qca8k_port_set_status_locked(priv, port, 1);
 	priv->port_enabled_map |= BIT(port);
+	mutex_unlock(&priv->port_status_mutex);
 
 	if (dsa_is_user_port(ds, port))
 		phy_support_asym_pause(phy);
@@ -764,14 +774,20 @@ void qca8k_port_disable(struct dsa_switch *ds, int port)
 {
 	struct qca8k_priv *priv = ds->priv;
 
-	qca8k_port_set_status(priv, port, 0);
+	mutex_lock(&priv->port_status_mutex);
+	qca8k_port_set_status_locked(priv, port, 0);
 	priv->port_enabled_map &= ~BIT(port);
+	mutex_unlock(&priv->port_status_mutex);
 }
 
 int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 {
 	struct qca8k_priv *priv = ds->priv;
-	int ret;
+	u32 mask = QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
+	u32 status[QCA8K_NUM_PORTS] = { 0 };
+	u32 ports;
+	u32 stopped = 0;
+	int ret, restore_ret, i;
 
 	/* We have only have a general MTU setting.
 	 * DSA always set the CPU port's MTU to the largest MTU of the user
@@ -784,25 +800,58 @@ int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 
 	/* To change the MAX_FRAME_SIZE the cpu ports must be off or
 	 * the switch panics.
-	 * Turn off both cpu ports before applying the new value to prevent
-	 * this.
+	 * Include internal PHY CPU ports as well as the two MAC-only ports.
+	 * Toggle only MAC enables, preserving the phylink link-control mode.
 	 */
-	if (priv->port_enabled_map & BIT(0))
-		qca8k_port_set_status(priv, 0, 0);
+	ports = BIT(0) | BIT(6);
+	for (i = 1; i < 6; i++)
+		if (dsa_is_cpu_port(ds, i))
+			ports |= BIT(i);
 
-	if (priv->port_enabled_map & BIT(6))
-		qca8k_port_set_status(priv, 6, 0);
+	mutex_lock(&priv->port_status_mutex);
+	ports &= priv->port_enabled_map;
+
+	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
+		if (!(ports & BIT(i)))
+			continue;
+
+		ret = regmap_read(priv->regmap, QCA8K_REG_PORT_STATUS(i),
+				  &status[i]);
+		if (ret)
+			goto unlock;
+	}
+
+	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
+		if (!(ports & BIT(i)) || !(status[i] & mask))
+			continue;
+
+		stopped |= BIT(i);
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
+	for (i = 0; i < QCA8K_NUM_PORTS; i++)
+		if (stopped & BIT(i)) {
+			restore_ret = regmap_update_bits(priv->regmap,
+							 QCA8K_REG_PORT_STATUS(i),
+							 mask, status[i] & mask);
+			if (restore_ret) {
+				dev_err(priv->dev, "failed to restore MAC state on port %d: %d\n",
+					i, restore_ret);
+				if (!ret)
+					ret = restore_ret;
+			}
+		}
 
+unlock:
+	mutex_unlock(&priv->port_status_mutex);
 	return ret;
 }
 
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 956338893..6cb060204 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -459,6 +459,8 @@ struct qca8k_priv {
 	struct mii_bus *internal_mdio_bus;
 	struct dsa_switch *ds;
 	struct mutex reg_mutex;
+	/* Serializes port MAC state changes with global MTU updates. */
+	struct mutex port_status_mutex;
 	struct device *dev;
 	struct gpio_desc *reset_gpio;
 	struct net_device *mgmt_conduit; /* Track if mdio/mib Ethernet is available */
-- 
2.43.0
