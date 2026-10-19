Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431443;
	b=uRZrZ6yRxQaw6lnP8/+5immRKp3TD3nQ1UoKaM8ro971EMN4ZXvg/UZ8pQjRR3Ub68M0
	 8AgxduuhMf8ldVtbtQtxBY+/AHxIFub5ifcahD0ULzd1BJd04hgBgPk4vB+Rca6rLCoXQ
	 1Vskn3yBJfFdnTLoHDRSbXJjNJKmDOiKfU4yksdgya0BBzSBkckMI0pyVhn+yb8kZ4sx7
	 XcP/Nqi/TLeb/TpDzJJHxMHv4OnbpUD39eTOyzXckuepc/gx2+lQdad2PNvmWJJHF49Br
	 PYmWCYl0UwOlgqBVp/Adou+RPuJrznwGO9q1vToyxkGMo0FzSWmUTladfYkEk619InQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7RSHaPoP9YSBSntLHKe2xa96843gQ4wTzs2WF+LMiLc=;
	b=mkq9VbVyDqy6TUK5o3NEnEBs9FpFmpFrVabAlnqhMt8Q7Gy9oe3NWZgAoCgPvkc75yEJ
	 vwLNz12E7WKIWlAkzgeGFQucxJgjrANU40Y1DduhrMROAmQE/QdfAqJowddHiCejuo1B2
	 66IxMIlosVUgzZICaPuJNN3ztsKy9aeETI5V6WFSVNO9zzunPC7rBnzMB1dYqUhAlu69V
	 vDN1l+bKWgYmW+JIIYT6+q8iWwsBInsgOtflxveUcqHheAhOSISyPpMlk3bQd2pmlSb9N
	 ruQY/3vHbqFtepjhP3jvSz4ItXe5zhRmiodDp0+kBu6cLOd79eVbunHfmDgc5TOaOsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="MK3xm/SU";
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590BD606A31A
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 590BD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MK3xm/SU
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1cc392d8bso2864395a12.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792431442; x=1793036242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7RSHaPoP9YSBSntLHKe2xa96843gQ4wTzs2WF+LMiLc=;
        b=MK3xm/SUOdLDzBdaRq2PXA3VIW0+0udZBkJa5LYHuZM49P12KjJcKl4YmX/Q872ZVT
         07wa1Ab8+8HQOAHgIS7vOaH8O55aHmpebCWdGRw7b2QhgcT7vejUE436Lbq0j9LjjQkT
         4d0vi69/aoXNV9Tu4MyWRHylZg8c0/Ld6/qr75Z9JXbdF/xwEnXhMVX8d1pLYuNxGlgb
         oiqJT7YIl7WwZYZ94zmWGncvs3ESQJqgeDacVeZc4pHmUWOf5URTRZWnGi4QPVLf3nWL
         iQ9N51/u5ect2utDW6WwxVrBhOwms9zl8mGMbkqp2vezeSUklqiHeBY5Ryfao6hk9TEt
         OEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792431442; x=1793036242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7RSHaPoP9YSBSntLHKe2xa96843gQ4wTzs2WF+LMiLc=;
        b=ZxcKAIhZ+/498MmmxbsQ2OKRptN99IWaN1IQmBPcRSQ6V276ia1/yk425vRd82pX08
         VofcLSeuo8gerzI+C/9SkoahhpEJ0r2K05ORkDjWwA5RJ/nIuAMnpmf4eB0GD9AUWr1W
         ATsGU9xpp714TWTvM0uM95t+h0oP0b56okcWQEzmD5yxPN3FbBAx07k3LYejvJbgMBq/
         VevE3MO1M7JKYPgfsuS/Std/jhjfTSFigQN/5GuobmAGVp2FzZpAAkE2XbvVUOp/CbIi
         jLrEpDn0wXhmQti3eT9hSoexsvHnpWBVT2qQesY2ZXL3umJwIDg4C2p3+FcG5DklGpJc
         AnFQ==
X-Gm-Message-State: AFq9FYJRkcOsb58E9UFidVQVpxpnW+YRRfujKDnxm60bSq/Z21y4+xRK
	i6r9K8VBAgYsIMTe09TKvQh3gmCwigD3l/+HLMaRobIR/EOFV9A1uVR+GobztZnFskZv2g==
X-Gm-Gg: AYBFou25p30HsedxedUVS/mvx5g4IPA7kKO9rDW+8+2jIMki/caXoFqdPLWfGLKLQeG
	b8DqTHrcjIuwsm8ayaJR3X9cTdJirQVK0NyiWkVC3U5pI1XvdTAysrAHQwBvG3AZzj8xfmTnnbX
	xUrQ2hJZ7Ir7cOkWZ7z8FsG+D1fY6vpFWjX4WDoH8zcMNdN8arBXSmMDgTpbsNTGzy/b9R3NOlO
	cZgGsgDtoXGr6rVsP4bBpVnQ9lXOf2D1TY1Q8/+CM5LFxXan55ONsyr32u7CnrtB1kYy/DOvB/4
	admhkQCZ5OFs866+GEP3RrjC7gkL5OVMpIxdZLSn4Tb3Qwq3G5QaeH+HGD45o3/MKR55wlPjl9+
	T+Bq5uu6/Q1TnphUY2kjkHkY0LFRartGAxrshj0oWmV9vNeVOo6Pd6uistE/wwgl0AjMiouVLXs
	yyhPlWALItMsZGFYxuVh2fyJCUInNMBJVT2UCfWEBRf0iNCUa2JRK8OqNU4eoJ2yrUf/b356Dhc
	g2B1rGYxNjXQgvA4ISVCAng2tP+M4Szl0O8mUInfnLJ0zovMszwVnVXt0IyeLw7zJupb/F+l/Xx
	25Q=
X-Received: by 2002:a17:907:c819:b0:c29:60b7:3f14 with SMTP id a640c23a62f3a-c41a16a6f18mr576942566b.46.1792431441403;
        Mon, 19 Oct 2026 10:37:21 -0700 (PDT)
Received: from CCM-PC (94-255-221-162.cust.bredband2.com. [94.255.221.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4465eb0c67sm119225666b.12.2026.10.19.10.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:37:21 -0700 (PDT)
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
Subject: [PATCH net v6] net: dsa: qca8k: preserve port state across MTU changes
Date: Mon, 19 Oct 2026 19:37:16 +0200
Message-ID: <20261019173716.198475-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

Return the result of the frame-size write even if a later port restore
fails: DSA does not roll back the switch's frame size when the CPU MTU
callback returns an error. Retain failed status writes and retry them
every second, because a fixed-link port may receive no further link-up
callback. Merge newer port decisions into the pending target, and
recover pending writes on ports 0 and 6 before taking another MTU
snapshot. Disable and drain retries for suspend, shutdown and removal,
with managed cleanup on probe failure.

Fixes: 386228c694bf ("net: dsa: qca8k: reset cpu port on MTU change")
Assisted-by: LLM
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
---
v6:
- Address Sashiko's review [1]:
  - Keep the MTU result once MAX_FRAME_SIZE is committed.
  - Retain failed PORT_STATUS targets and retry them without requiring
    a fixed-link transition. Newer MAC decisions supersede pending bits.
  - Recover pending writes before the next MTU snapshot, so a failed
    restore is not saved as MAC-off state. This includes a failed
    disable whose port_enabled_map bit has already been cleared.
- Disable and drain the retry work for suspend and device teardown;
  retry pending writes after resume or a failed suspend.

v5: https://lore.kernel.org/netdev/20261015104550.43169-1-yongzhao.derek@gmail.com/
v4: https://lore.kernel.org/netdev/20260928220811.1880-3-yongzhao.derek@gmail.com/

This remains the standalone net fix for existing ports 0 and 6. Internal
CPU support stays in the separate net-next series. The defects were found
by code inspection; this revision has not been tested on hardware.

The affected arm64 objects build with W=1, with CONFIG_PM_SLEEP both
enabled and disabled. A userspace harness compiles the driver functions
and dsa_user_change_mtu(), with mocked register, notifier and workqueue
boundaries. It checks MTU shrink, restore failures and retries without a
new link event, superseding callbacks, callback interleavings and lifecycle
control. The sent v5 and six deliberately broken variants of this patch
fail these checks.

The net base can still swallow MDIO write errors. The retry handles only
errors reported by the register API; it cannot detect a write that
falsely reports success.

[1] https://lore.kernel.org/netdev/179240775070.3135.2434822808609533404@kernel.org/

 drivers/net/dsa/qca/qca8k-8xxx.c   |  32 ++++++-
 drivers/net/dsa/qca/qca8k-common.c | 136 ++++++++++++++++++++++++-----
 drivers/net/dsa/qca/qca8k.h        |  13 +++
 3 files changed, 159 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 4c928983b..4e6dc04ca 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1483,7 +1483,9 @@ qca8k_phylink_mac_link_up(struct phylink_config *config,
 
 	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
 
-	qca8k_write(priv, QCA8K_REG_PORT_STATUS(port), reg);
+	mutex_lock(&priv->port_status_lock);
+	qca8k_port_status_update(priv, port, U32_MAX, reg);
+	mutex_unlock(&priv->port_status_lock);
 }
 
 static struct qca8k_pcs *pcs_to_qca8k_pcs(struct phylink_pcs *pcs)
@@ -2055,6 +2057,13 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
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
@@ -2116,6 +2125,11 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
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
@@ -2130,6 +2144,7 @@ qca8k_sw_remove(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
+	qca8k_port_status_stop(priv);
 	for (i = 0; i < QCA8K_NUM_PORTS; i++)
 		qca8k_port_set_status(priv, i, 0);
 
@@ -2143,6 +2158,7 @@ static void qca8k_sw_shutdown(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
+	qca8k_port_status_stop(priv);
 	dsa_switch_shutdown(priv->ds);
 
 	dev_set_drvdata(&mdiodev->dev, NULL);
@@ -2165,13 +2181,24 @@ qca8k_set_pm(struct qca8k_priv *priv, int enable)
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
@@ -2179,6 +2206,7 @@ static int qca8k_resume(struct device *dev)
 	struct qca8k_priv *priv = dev_get_drvdata(dev);
 
 	qca8k_set_pm(priv, 1);
+	qca8k_port_status_start(priv);
 
 	return dsa_switch_resume(priv->ds);
 }
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 13005f10e..04001c345 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -463,7 +463,7 @@ int qca8k_mib_init(struct qca8k_priv *priv)
 	return ret;
 }
 
-void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
+static u32 qca8k_port_status_mask(int port)
 {
 	u32 mask = QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
 
@@ -471,10 +471,74 @@ void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
 	if (port > 0 && port < 6)
 		mask |= QCA8K_PORT_STATUS_LINK_AUTO;
 
-	if (enable)
-		regmap_set_bits(priv->regmap, QCA8K_REG_PORT_STATUS(port), mask);
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
 	else
-		regmap_clear_bits(priv->regmap, QCA8K_REG_PORT_STATUS(port), mask);
+		ret = regmap_update_bits(priv->regmap, QCA8K_REG_PORT_STATUS(port),
+					 mask, priv->port_status_value[port]);
+	if (ret) {
+		dev_err_ratelimited(priv->dev, "failed to restore port %d status: %d\n",
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
+	/* A newer decision supersedes the pending bits, even if it fails too. */
+	priv->port_status_value[port] &= ~mask;
+	priv->port_status_value[port] |= val & mask;
+	priv->port_status_mask[port] |= mask;
+	qca8k_port_status_restore(priv, port);
+}
+
+void qca8k_port_status_work(struct work_struct *work)
+{
+	struct qca8k_priv *priv = container_of(to_delayed_work(work),
+					     struct qca8k_priv, port_status_work);
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
@@ -751,8 +815,10 @@ int qca8k_port_enable(struct dsa_switch *ds, int port,
 {
 	struct qca8k_priv *priv = ds->priv;
 
-	qca8k_port_set_status(priv, port, 1);
+	mutex_lock(&priv->port_status_lock);
+	__qca8k_port_set_status(priv, port, 1);
 	priv->port_enabled_map |= BIT(port);
+	mutex_unlock(&priv->port_status_lock);
 
 	if (dsa_is_user_port(ds, port))
 		phy_support_asym_pause(phy);
@@ -764,14 +830,18 @@ void qca8k_port_disable(struct dsa_switch *ds, int port)
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
+	int ret, i;
 
 	/* We have only have a general MTU setting.
 	 * DSA always set the CPU port's MTU to the largest MTU of the user
@@ -782,27 +852,53 @@ int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
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
+	ports = BIT(0) | BIT(6);
+
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
 
-	if (priv->port_enabled_map & BIT(6))
-		qca8k_port_set_status(priv, 6, 0);
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
+	/* A restore failure must not report a committed frame size as rejected. */
+	for_each_set_bit(i, &stopped, QCA8K_NUM_PORTS)
+		qca8k_port_status_update(priv, i, qca8k_port_status_mask(i),
+					 status[i]);
 
+unlock:
+	mutex_unlock(&priv->port_status_lock);
 	return ret;
 }
 
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 956338893..e2d2e63fb 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -10,6 +10,7 @@
 
 #include <linux/delay.h>
 #include <linux/regmap.h>
+#include <linux/workqueue.h>
 #include <linux/gpio/consumer.h>
 #include <linux/leds.h>
 #include <linux/dsa/tag_qca.h>
@@ -459,6 +460,15 @@ struct qca8k_priv {
 	struct mii_bus *internal_mdio_bus;
 	struct dsa_switch *ds;
 	struct mutex reg_mutex;
+	/* Serializes writes to QCA8K_REG_PORT_STATUS and the MTU update. Taken
+	 * from phylink MAC callbacks: do not access a PHY or call into phylink
+	 * with it held.
+	 */
+	struct mutex port_status_lock;
+	struct delayed_work port_status_work;
+	/* Nonzero masks identify pending writes, protected by port_status_lock. */
+	u32 port_status_mask[QCA8K_NUM_PORTS];
+	u32 port_status_value[QCA8K_NUM_PORTS];
 	struct device *dev;
 	struct gpio_desc *reset_gpio;
 	struct net_device *mgmt_conduit; /* Track if mdio/mib Ethernet is available */
@@ -502,6 +512,9 @@ static inline u32 qca8k_port_to_phy(int port)
 extern const struct qca8k_mib_desc ar8327_mib[];
 extern const struct regmap_access_table qca8k_readable_table;
 int qca8k_mib_init(struct qca8k_priv *priv);
+void qca8k_port_status_work(struct work_struct *work);
+void qca8k_port_status_update(struct qca8k_priv *priv, int port,
+			      u32 mask, u32 val);
 void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable);
 int qca8k_read_switch_id(struct qca8k_priv *priv);
 

base-commit: 78731b46967e3e7102b5cd5062bef185f3404b5c
-- 
2.43.0
