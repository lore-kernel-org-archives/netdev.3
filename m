Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793713;
	b=E8VjSX74nY99pucmmO62EQjazZCT3j+0JhDqlnrM57kVqzTWWDrZDdoYzgHdX57DCKbV
	 vSC8Gi/5lUF5c/9yZfirCQ8jDXbYCPg3I9d9VHgxLMQgMFOyunDxCa91C9bGhoQIqg6cC
	 mFza/39gzHAK6FmhqzygcR3NY++IwqdHIS61AbH5skpUp0XZbP5ZEHR3OsWFnzUsxgCBd
	 1Xoyme9C6Ps2dvNiDp9OXDuEzQfJCuUH0J4XKf0IAoAsn2qNWmr2FggwSW8Wyxzzchfdb
	 7Tn72SLiN0hr/UZZ4X5p2KiNDIgJYOMGD8LK/JrydQgcY2WehVloUOCYqP2IV+1kAwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nweua5KETOjw8J/R+xI+C1Tz01cC/wXWeqnv2+QsjL4=;
	b=AGtmLsEpGPnV14QhRamrizBnEf9iVhw4kCVMWUE7fR+X/lB4tmgWAOLXCIBqS6o9k9eH
	 gXN0Ic+h36pbsFX6bUBCxB8BrlgjPPdmmdnoLsUrenYkgVW+1oqR7YcrUPerGyq87rlcC
	 Ehl8/VhvfAOmJWYdFC0wKnzUYGBOQ3klZ/Z2t1Lh0owZpJp9cx1rfh743ufyaFBtmygK7
	 jX1zQoQkZAjQtMbRaK6UY0wXhgA65ty0yJzAocXGBJyQWGEq+toWjGP7YNhO6XuoKjrQ9
	 AtlQOH3IxBToCMMQKk/JRI4TWU8vjHBBCrnl4h2bNCpK13DnHjgiejjUxh/FH/06kFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iXW/QgBA";
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7119B606D804
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 12:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7119B606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iXW/QgBA
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c445c95d553so84367466b.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 04:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793793700; x=1794398500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nweua5KETOjw8J/R+xI+C1Tz01cC/wXWeqnv2+QsjL4=;
        b=iXW/QgBAfI7aZ5QodXojGZyYQcQYBD5U0ZqoNGN+VDNCkuA4YbZgSKZ5RtsANGVv92
         YnZ7NapjvI5oLv2rCzvVTgOUfeLZHx1Rdr2C+v+CZMxVitISpIN6uxIaMH2KVN6+t3pt
         Fnh+MDrCrOU+3mxIscm6SfU32ntCH1/XO+UV0TBEK5GGStlEK5RqfdRaUiIL108dcD+9
         3zt8d7Atpv3QtaruWf1w2qc2CjKLVW48ZwS1CktHI9p2GlwbYTLrxeTmK9RpPwD9PVOF
         i385dVMklu9xm+98cVlgnh75IFVBHmT4yI/hBBLKU4b8R4USJtgr1lgUsnd4kUGIlhKM
         7tOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793793700; x=1794398500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nweua5KETOjw8J/R+xI+C1Tz01cC/wXWeqnv2+QsjL4=;
        b=Kx8h7gUoblnSsDrEZ6QJ2kPAF31JVcbNTMpy/6esO0fpWc6m01kgRKbZVKrKmjfoLl
         0xlAlyqnrS82g1lTNpga3tNDdUoFRustrkNtIC5H9nC8t0TRik3sCieHjC00f+Jv2RkL
         x4I70+PXJ6/EP6uuHtvyXjJgKL6mxAizO519SZIlkRsU8bHOBi2ey5e4t0nsp49DK1Ul
         gRDmWD8IVcxo5mfz3YEYObKUr5tYAFHkwjWDkoscAbAxERlP+5nk+NMRy7Y1RRyClKRK
         im49wO/JmzpFo/8tGZA2HlosCwDpE1cCsvXAHams4eOrg5IRceLBAkQ4RmcK+82UXR/c
         JZ1g==
X-Gm-Message-State: APuU4Z/Q1YbzVniQraVYVs7lBi4L2g8BmHhLSrZW4iDAQ0OxZt+QUxBM
	HyDGrttrdL5nMt+oC69qqmhsyenAXoE5Dxw1h2zdXM3Xm9QNN6yx3vGTKArB6mMbKcY=
X-Gm-Gg: AYBFou1WOjunyCPsh+mC43ZRhq4RDWqcykC8mSGf1waIEdC3x98nCUM6oQ1sN/5wi2S
	ZqSmfeOTajo4hQhZgLx9Qhm4JMt9wbmNdp5mRg6qDDtA5594f/THqRFJO7z/d4asuAY5nnNe83E
	ggSA2wrIOdkTAEGQE+Eb0ArroV0tTI4qDoDFFNKlZz7aXQN1MbF51jRwYFb0uZzxT7AnI6DzIKb
	CV3OTipExWXcwpe8MUdndzGFgIN3abiQ4ACf5el3Qs2/6+i/pj1wNTNlwS2db8etX87L4ed18Ld
	lzp0qi+tZITSnKZ1ZKJm68rehpl+XYAKcy63MpBfMJzSVHSPLPXFT79TB5FtyiNN8GuFt1eWNN1
	8s9BQ0EjoVJqPEGn3FBL5qggii9Tt9O/mglMm4UogEt2CKfU6m2cKmioptbN5rfk0io31XEt1sS
	5djPD/ONAQNXWpm6glwhJX0LJ8rRqFhbdIyiMslM5ObhjDRrjgGo/PM0Z8towviNmVZ0AlIetmi
	be8J9s+5Kjqj9cdMAldSo1LO8ReT30Hib/5fpu86WTLsexLgqq41yZBs3PZ5r4k9qvMnWDUEwbd
	suH1kvA2393flmYJs/al3ttWc9p79k47RkH+mnYG2t3jtYROQuCKFnlW3VJJavQRGBAmput2n5c
	J6yqL9gqWyS8JKmKy14ULFekSch9OdGVB1w==
X-Received: by 2002:a17:907:c5ce:b0:c29:5d41:dfe8 with SMTP id a640c23a62f3a-c4ca7ae82f3mr1371389766b.43.1793793699432;
        Wed, 04 Nov 2026 04:01:39 -0800 (PST)
Received: from CCM-PC (83-233-221-133.cust.bredband2.com. [83.233.221.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e424f94sm60940966b.24.2026.11.04.04.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:01:38 -0800 (PST)
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
	Ziyang Huang <hzyitc@outlook.com>,
	Stanislaw Pal <kuncy7@gmail.com>
Subject: [PATCH net-next v8 2/2] net: dsa: qca8k: preserve port state across MTU changes
Date: Wed,  4 Nov 2026 13:01:29 +0100
Message-ID: <20261104120130.48455-3-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261104120130.48455-1-yongzhao.derek@gmail.com>
References: <20261104120130.48455-1-yongzhao.derek@gmail.com>
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

The MTU update pauses enabled ports 0 and 6 and then unconditionally
enables their MACs. This can undo a phylink link-down decision. Phylink
callbacks also run without RTNL and can enable a MAC during the update.
Changing MAX_FRAME_SIZE with a CPU MAC running can stop the switch from
sending packets until reset, as described in commit 386228c694bf.

Serialize the MTU transaction and PORT_STATUS writers with a dedicated
mutex. Save and restore the MAC bits, abort before the frame-size write
on detected snapshot or pause errors, and restore every touched port.
Mask partial status values before passing them to the regmap callback.
The saved state depends on regmap serializing register access, because
readers such as the PCS poll do not take the new mutex.

Return the result of the frame-size write even if a later port restore
fails: DSA does not roll back the switch's frame size when the CPU MTU
callback returns an error. Record successful frame-size writes and skip
requests for the same value. DSA invokes the callback for every CPU port,
so a second invocation must not reject an already committed global value.

Retain failed status writes and retry them every second, because a
fixed-link port may receive no further link-up callback. Merge newer port
decisions into the pending target, and recover pending writes on ports 0
and 6 before changing the frame size again. Disable and drain retries for
suspend, shutdown and removal, with managed cleanup on probe failure.

The problem was found during development by an LLM-assisted review. It
has been reproduced only in test harnesses, not on hardware.

Fixes: 386228c694bf ("net: dsa: qca8k: reset cpu port on MTU change")
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c   |  33 ++++++-
 drivers/net/dsa/qca/qca8k-common.c | 149 +++++++++++++++++++++++++----
 drivers/net/dsa/qca/qca8k.h        |  15 +++
 3 files changed, 175 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 1e4f83e9e..288cfab81 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1494,7 +1494,9 @@ qca8k_phylink_mac_link_up(struct phylink_config *config,
 
 	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
 
-	qca8k_write(priv, QCA8K_REG_PORT_STATUS(port), reg);
+	mutex_lock(&priv->port_status_lock);
+	qca8k_port_status_update(priv, port, U32_MAX, reg);
+	mutex_unlock(&priv->port_status_lock);
 }
 
 static struct qca8k_pcs *pcs_to_qca8k_pcs(struct phylink_pcs *pcs)
@@ -2006,6 +2008,7 @@ qca8k_setup(struct dsa_switch *ds)
 
 	/* Setup our port MTUs to match power on defaults */
 	ret = qca8k_write(priv, QCA8K_MAX_FRAME_SIZE, ETH_FRAME_LEN + ETH_FCS_LEN);
+	priv->max_frame_size = ret ? 0 : ETH_FRAME_LEN + ETH_FCS_LEN;
 	if (ret)
 		dev_warn(priv->dev, "failed setting MTU settings");
 
@@ -2066,6 +2069,13 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
 	.connect_tag_protocol	= qca8k_connect_tag_protocol,
 };
 
+static void qca8k_port_status_stop(void *data)
+{
+	struct qca8k_priv *priv = data;
+
+	disable_delayed_work_sync(&priv->port_status_work);
+}
+
 static int
 qca8k_sw_probe(struct mdio_device *mdiodev)
 {
@@ -2127,6 +2137,11 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
 	priv->ds->ops = &qca8k_switch_ops;
 	priv->ds->phylink_mac_ops = &qca8k_phylink_mac_ops;
 	mutex_init(&priv->reg_mutex);
+	mutex_init(&priv->port_status_lock);
+	INIT_DELAYED_WORK(&priv->port_status_work, qca8k_port_status_work);
+	ret = devm_add_action_or_reset(priv->dev, qca8k_port_status_stop, priv);
+	if (ret)
+		return ret;
 	dev_set_drvdata(&mdiodev->dev, priv);
 
 	return dsa_register_switch(priv->ds);
@@ -2141,6 +2156,7 @@ qca8k_sw_remove(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
+	qca8k_port_status_stop(priv);
 	for (i = 0; i < QCA8K_NUM_PORTS; i++)
 		qca8k_port_set_status(priv, i, 0);
 
@@ -2154,6 +2170,7 @@ static void qca8k_sw_shutdown(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
+	qca8k_port_status_stop(priv);
 	dsa_switch_shutdown(priv->ds);
 
 	dev_set_drvdata(&mdiodev->dev, NULL);
@@ -2176,13 +2193,24 @@ qca8k_set_pm(struct qca8k_priv *priv, int enable)
 	}
 }
 
+static void qca8k_port_status_start(struct qca8k_priv *priv)
+{
+	enable_delayed_work(&priv->port_status_work);
+	schedule_delayed_work(&priv->port_status_work, 0);
+}
+
 static int qca8k_suspend(struct device *dev)
 {
 	struct qca8k_priv *priv = dev_get_drvdata(dev);
+	int ret;
 
+	qca8k_port_status_stop(priv);
 	qca8k_set_pm(priv, 0);
+	ret = dsa_switch_suspend(priv->ds);
+	if (ret)
+		qca8k_port_status_start(priv);
 
-	return dsa_switch_suspend(priv->ds);
+	return ret;
 }
 
 static int qca8k_resume(struct device *dev)
@@ -2190,6 +2218,7 @@ static int qca8k_resume(struct device *dev)
 	struct qca8k_priv *priv = dev_get_drvdata(dev);
 
 	qca8k_set_pm(priv, 1);
+	qca8k_port_status_start(priv);
 
 	return dsa_switch_resume(priv->ds);
 }
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index ab978cc83..d1fc46f88 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -463,7 +463,7 @@ int qca8k_mib_init(struct qca8k_priv *priv)
 	return ret;
 }
 
-void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
+static u32 qca8k_port_status_mask(int port)
 {
 	u32 mask = QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
 
@@ -471,7 +471,77 @@ void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
 	if (port > 0 && port < 6)
 		mask |= QCA8K_PORT_STATUS_LINK_AUTO;
 
-	regmap_assign_bits(priv->regmap, QCA8K_REG_PORT_STATUS(port), mask, enable);
+	return mask;
+}
+
+static int qca8k_port_status_restore(struct qca8k_priv *priv, int port)
+{
+	u32 mask = priv->port_status_mask[port];
+	int ret;
+
+	lockdep_assert_held(&priv->port_status_lock);
+
+	if (!mask)
+		return 0;
+
+	if (mask == U32_MAX)
+		ret = qca8k_write(priv, QCA8K_REG_PORT_STATUS(port),
+				  priv->port_status_value[port]);
+	else
+		ret = regmap_update_bits(priv->regmap,
+					 QCA8K_REG_PORT_STATUS(port), mask,
+					 priv->port_status_value[port] & mask);
+	if (ret) {
+		dev_err_ratelimited(priv->dev,
+				    "failed to restore port %d status: %d\n",
+				    port, ret);
+		schedule_delayed_work(&priv->port_status_work, HZ);
+	} else {
+		priv->port_status_mask[port] = 0;
+	}
+
+	return ret;
+}
+
+void qca8k_port_status_update(struct qca8k_priv *priv, int port,
+			      u32 mask, u32 val)
+{
+	lockdep_assert_held(&priv->port_status_lock);
+
+	/* A newer decision supersedes pending bits, even if it fails too. */
+	priv->port_status_value[port] &= ~mask;
+	priv->port_status_value[port] |= val & mask;
+	priv->port_status_mask[port] |= mask;
+	qca8k_port_status_restore(priv, port);
+}
+
+void qca8k_port_status_work(struct work_struct *work)
+{
+	struct qca8k_priv *priv = container_of(to_delayed_work(work),
+					       struct qca8k_priv,
+					       port_status_work);
+	int port;
+
+	mutex_lock(&priv->port_status_lock);
+	for (port = 0; port < QCA8K_NUM_PORTS; port++)
+		qca8k_port_status_restore(priv, port);
+	mutex_unlock(&priv->port_status_lock);
+}
+
+static void __qca8k_port_set_status(struct qca8k_priv *priv, int port,
+				    int enable)
+{
+	u32 mask = qca8k_port_status_mask(port);
+
+	lockdep_assert_held(&priv->port_status_lock);
+	qca8k_port_status_update(priv, port, mask, enable ? mask : 0);
+}
+
+void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
+{
+	mutex_lock(&priv->port_status_lock);
+	__qca8k_port_set_status(priv, port, enable);
+	mutex_unlock(&priv->port_status_lock);
 }
 
 void qca8k_get_strings(struct dsa_switch *ds, int port, u32 stringset,
@@ -742,8 +812,10 @@ int qca8k_port_enable(struct dsa_switch *ds, int port,
 {
 	struct qca8k_priv *priv = ds->priv;
 
-	qca8k_port_set_status(priv, port, 1);
+	mutex_lock(&priv->port_status_lock);
+	__qca8k_port_set_status(priv, port, 1);
 	priv->port_enabled_map |= BIT(port);
+	mutex_unlock(&priv->port_status_lock);
 
 	if (dsa_is_user_port(ds, port))
 		phy_support_asym_pause(phy);
@@ -755,14 +827,19 @@ void qca8k_port_disable(struct dsa_switch *ds, int port)
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
+	u32 frame_size = new_mtu + ETH_HLEN + ETH_FCS_LEN;
+	u32 status[QCA8K_NUM_PORTS] = { 0 };
 	struct qca8k_priv *priv = ds->priv;
-	int ret;
+	unsigned long ports, stopped = 0;
+	int ret, i;
 
 	/* We have only have a general MTU setting.
 	 * DSA always set the CPU port's MTU to the largest MTU of the user
@@ -773,27 +850,59 @@ int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
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
+	/* DSA calls us for every CPU port, but the frame size is global. */
+	if (priv->max_frame_size == frame_size) {
+		ret = 0;
+		goto unlock;
+	}
 
-	if (priv->port_enabled_map & BIT(6))
-		qca8k_port_set_status(priv, 6, 0);
+	ports = BIT(0) | BIT(6);
 
-	/* Include L2 header / FCS length */
-	ret = qca8k_write(priv, QCA8K_MAX_FRAME_SIZE, new_mtu +
-			  ETH_HLEN + ETH_FCS_LEN);
+	/* Do not mistake a failed restore for a new link-down decision. */
+	for_each_set_bit(i, &ports, QCA8K_NUM_PORTS) {
+		ret = qca8k_port_status_restore(priv, i);
+		if (ret)
+			goto unlock;
+	}
+
+	ports &= priv->port_enabled_map;
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
 
-	if (priv->port_enabled_map & BIT(0))
-		qca8k_port_set_status(priv, 0, 1);
+	ret = qca8k_write(priv, QCA8K_MAX_FRAME_SIZE, frame_size);
+	if (!ret)
+		priv->max_frame_size = frame_size;
 
-	if (priv->port_enabled_map & BIT(6))
-		qca8k_port_set_status(priv, 6, 1);
+restore:
+	/* A failed restore must not reject a committed frame size. */
+	for_each_set_bit(i, &stopped, QCA8K_NUM_PORTS)
+		qca8k_port_status_update(priv, i, qca8k_port_status_mask(i),
+					 status[i]);
 
+unlock:
+	mutex_unlock(&priv->port_status_lock);
 	return ret;
 }
 
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 956338893..f4ab46475 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -10,6 +10,7 @@
 
 #include <linux/delay.h>
 #include <linux/regmap.h>
+#include <linux/workqueue.h>
 #include <linux/gpio/consumer.h>
 #include <linux/leds.h>
 #include <linux/dsa/tag_qca.h>
@@ -459,6 +460,17 @@ struct qca8k_priv {
 	struct mii_bus *internal_mdio_bus;
 	struct dsa_switch *ds;
 	struct mutex reg_mutex;
+	/* Serializes writes to QCA8K_REG_PORT_STATUS and the MTU update. Taken
+	 * from phylink MAC callbacks: do not access a PHY or call into phylink
+	 * with it held.
+	 */
+	struct mutex port_status_lock;
+	/* Committed frame size, 0 if unknown; protected by port_status_lock. */
+	u32 max_frame_size;
+	struct delayed_work port_status_work;
+	/* Nonzero masks mark pending writes; protected by port_status_lock. */
+	u32 port_status_mask[QCA8K_NUM_PORTS];
+	u32 port_status_value[QCA8K_NUM_PORTS];
 	struct device *dev;
 	struct gpio_desc *reset_gpio;
 	struct net_device *mgmt_conduit; /* Track if mdio/mib Ethernet is available */
@@ -502,6 +514,9 @@ static inline u32 qca8k_port_to_phy(int port)
 extern const struct qca8k_mib_desc ar8327_mib[];
 extern const struct regmap_access_table qca8k_readable_table;
 int qca8k_mib_init(struct qca8k_priv *priv);
+void qca8k_port_status_work(struct work_struct *work);
+void qca8k_port_status_update(struct qca8k_priv *priv, int port,
+			      u32 mask, u32 val);
 void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable);
 int qca8k_read_switch_id(struct qca8k_priv *priv);
 
-- 
2.43.0

