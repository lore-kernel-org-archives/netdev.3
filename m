Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684724;
	b=0496NpqA/4jf11joAY/vdZuMtfVw5lAbKVx48eMBhLuRvRqmOrvMxUs9H+kXBA2UQ90h
	 oTeWRRx5MJV4GZDYnK4IaqiM1YZMOhugeQ3FUwAXBIlPAZdUqzXX34d535s9EclxmPqjW
	 KVzA5PRdFNCnaawG1zDoO94/s9PwtcheIZP0CM5V/ZtZuWCbQbUJ04EA4ndzvVkwIEM/K
	 1rJJXaayLUyujX+yiSpbHq+6qpIHeZxNr8/+w5d+yN3CegCgnYFQMvJdMLyFFemsjhbIN
	 H9SKNhGKBcf/wUl9PSoiWuXW0Tq9ps9uCgILqoYDEARaa0XenCh0ecC5bRJQpE1vR8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=y7C37lkYJx3z+0BOHoOqBhwyueswG8B5c3uzYLhRKKU=;
	b=TrY96F89w5OJMryUZmGSBDomPiL5gg68jagdxGA9XOnV4tyLF7hM7i8Lg4akuY/2TZe+
	 WXPihO7njbyBNFcE2SNLvZGvAN0rXu4LYYeu5tTctKXddVaqC6zS7Hece3IF58wAG3zvy
	 MPYkg7/zJen1uE22TVaFV36ESnsveeUZ98Sw1JKcqXrOloZY4e9qArK2XG6+RFmGK60UG
	 xINDehRkjXr4RheT59s3PPq9LQExBaDMQOubZ95Xpade3j/wyYEgf9ZcVDEU0PvY8Y6qF
	 fUXTbul4FIg8q13WP98ZOUicuXxwSOu0w6+g5tkFHEK/MZLlf6/I2txClI+9mlcSbXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qy1jRaAa;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4492F606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4492F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qy1jRaAa
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4301e334ceso154373666b.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684722; x=1793289522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y7C37lkYJx3z+0BOHoOqBhwyueswG8B5c3uzYLhRKKU=;
        b=Qy1jRaAa3isiKDFBrrchK356IFswBJwe/Gwc+iG0Z8n1+srN/3A413LYWg2YUDnqfK
         l1YHuO9BaqzwG5S5drFLsJ9Y5TEwUnNHQg594uijRrse8AkuMXPF0iR+QVv6VjAMWtxe
         Vnt45aMTzgV7pQIqcaSp9gZyxrtwusGY/CIcfJSi+BwNAv/BXHDCDykoRYHeVsy4WcyR
         lnevgG6qjKaOEPhhT69xWwGpWjl15rIJz0eVpfddxCsfNbGMNn99yKVyWuuIw9gbz92l
         wlYsTU3mORu5Wf8MwCxVsF0IBZbdFaQiQCBq681mHbAbiLNr/lY0KTGPsfnT9XONG/mA
         tBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684722; x=1793289522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y7C37lkYJx3z+0BOHoOqBhwyueswG8B5c3uzYLhRKKU=;
        b=f8aYul1v5d1Cpd9r8qz7XPeRS7gmq8KBghGsBXdGaMry05EvwZDQIEWFEFYKa4LBHj
         8oTaOoh8awc8QrkJjPGB4l4GLyCnJ4evUUGEFfM8brJK2ZP3dD1edc1I3fDNEjuY7w0c
         CKtYigMiJCrtKrkQj9FMBm5gOK9Xovns+uwratMgHjKw0cmYtgNbGL38ksvYxS3FuMv+
         kMWEn2h8MTblyZqJJ1YRA3OIJf2kvplukOw8qZW9uyNOIq0cyPj/rDnMNoi1qKTFJffA
         Msam31T1Vgh8raTaUVuqprLzSNpPukqrU0rhfH3MVr3kxNpdXf1N/asvVHudStvuLQvk
         2Nzg==
X-Gm-Message-State: AFq9FYJL3KD1ohP2FfosRB2068Pk0kAkG8oLdJh+VzPns6++cbelOvXT
	3otGEhsELg2lYcmfl3VeE8EISGhXvsn2TawfetWrCIteBV46GTHrLPu0Wmsrd5bCzq8=
X-Gm-Gg: AYBFou1Dw5LOrSeL/3D41rR+F1oNL6ZDIIjww4ZexrV/jLn328mencpnqnk3VOWovtk
	z+c2sLR/z5spc/uQQ5tID703lSXTxgyk26AGjob6qKs1EIcCS9pjtFD8VOcNuOie4B7sJi6LINC
	IO1m3eQEuhdKtaHgplTzAOpX08+2eeCB8dX0Eha+vJGrA63HbhZKtS0IeVHE9WHce8/gNCp9G+1
	ov7qeV2fc+wvFzy/DqaqZSfIGMbRHxEiFmtZOrJqi7dZw+j/+nftoVwwoBN9BVYuWh4Nb+Ntd3n
	+dyJqfSZGxBOVAaEdb4FGV3Z1nVczNXSl8Nm/DaxV7EQAULRaSYh8IGrw/lRPskjaF+OmPGrewt
	WIN+6+u4ODZclGCcO3yQ4SmekBzvFb1JE1+ptK8BvKVr9h/MBsUhvq+AaeLl9dlbO6NiU2QSj7j
	WBNwam4yN+VwI1JEERODE1pjneRE+Vjyi+DK3QIjeSrFSeAqzgpXeUKIkhPE5VT9OlYL+bR5T6F
	YRjz1FD5dfzhLXjKlKiyKJqLTzrGCFLrmSaLhh86BMGhohThdbqVBKuWo/781gLj3NJLsDssx+f
	WDCyD5Xn7lGfotppvwYOShPsC4z14lbHGKG1UsXKiTuzLi5/woS1RkoCZhtF7ShWbDRa6cwoEEr
	W9ko=
X-Received: by 2002:a17:907:d40a:b0:c3e:f05:3dfa with SMTP id a640c23a62f3a-c46799be0ccmr597057766b.34.1792684721234;
        Thu, 22 Oct 2026 08:58:41 -0700 (PDT)
Received: from CCM-PC (31-208-243-52.cust.bredband2.com. [31.208.243.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46a5d17fabsm1427766b.86.2026.10.22.08.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:58:40 -0700 (PDT)
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
Subject: [PATCH net v7] net: dsa: qca8k: preserve port state across MTU changes
Date: Thu, 22 Oct 2026 17:58:37 +0200
Message-ID: <20261022155837.760-1-yongzhao.derek@gmail.com>
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
Mask partial status values before passing them to the regmap callback.

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

Fixes: 386228c694bf ("net: dsa: qca8k: reset cpu port on MTU change")
Assisted-by: LLM
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
---
v7:
- Address Sashiko's review of v6 [1]:
  - Mask cached PORT_STATUS values for partial writes. The qca8k regmap
    callbacks do not mask their value argument.
  - Track the successfully committed global frame size and return success
    for repeated requests. This covers DSA invoking the MTU callback for
    both CPU ports, including a pending restore failure after the first
    callback. Initialize the record from the setup write and update it
    only when a frame-size write succeeds.
- The tests now use the actual Ethernet RMW callback and DSA CPU-port
  iteration, which the v6 fixtures did not model correctly.

v6: https://lore.kernel.org/netdev/20261019173716.198475-1-yongzhao.derek@gmail.com/
v5: https://lore.kernel.org/netdev/20261015104550.43169-1-yongzhao.derek@gmail.com/

This remains the standalone net fix for existing ports 0 and 6. Internal
CPU support stays in the separate net-next series. The pre-existing NULL
PHY dereference noted in the review is outside this change.

The affected arm64 objects build with W=1, with CONFIG_PM_SLEEP enabled
and disabled. A userspace harness compiled the driver, Ethernet RMW and
DSA MTU functions with mocked transport, topology, netdev and workqueue
boundaries. It covered single and dual CPU ports, both traversal orders,
MTU growth and shrink, failed initial writes, duplicate callbacks, later
MTU changes, retries, callback interleavings and lifecycle handling.
The sent v6 and six deliberately broken variants fail the checks.
This revision has not been tested on hardware or with kernel lockdep.

The net base can still swallow MDIO write errors. The retry and committed
frame-size record handle only errors reported by the register API; they
cannot detect a write that falsely reports success or guarantee recovery
from a write whose completion is unknown.

Merge note: net-next has changed qca8k_port_set_status() to use
regmap_assign_bits(). This patch replaces that function body with the
serialized status-update helper, so that hunk needs manual resolution
when propagating the net fix to net-next.

[1] https://lore.kernel.org/netdev/179265824122.3135.15072303811434404600@kernel.org/

 drivers/net/dsa/qca/qca8k-8xxx.c   |  33 ++++++-
 drivers/net/dsa/qca/qca8k-common.c | 150 ++++++++++++++++++++++++-----
 drivers/net/dsa/qca/qca8k.h        |  15 +++
 3 files changed, 174 insertions(+), 24 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 4c928983b..f9ae0fe67 100644
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
@@ -1995,6 +1997,7 @@ qca8k_setup(struct dsa_switch *ds)
 
 	/* Setup our port MTUs to match power on defaults */
 	ret = qca8k_write(priv, QCA8K_MAX_FRAME_SIZE, ETH_FRAME_LEN + ETH_FCS_LEN);
+	priv->max_frame_size = ret ? 0 : ETH_FRAME_LEN + ETH_FCS_LEN;
 	if (ret)
 		dev_warn(priv->dev, "failed setting MTU settings");
 
@@ -2055,6 +2058,13 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
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
@@ -2116,6 +2126,11 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
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
@@ -2130,6 +2145,7 @@ qca8k_sw_remove(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
+	qca8k_port_status_stop(priv);
 	for (i = 0; i < QCA8K_NUM_PORTS; i++)
 		qca8k_port_set_status(priv, i, 0);
 
@@ -2143,6 +2159,7 @@ static void qca8k_sw_shutdown(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
+	qca8k_port_status_stop(priv);
 	dsa_switch_shutdown(priv->ds);
 
 	dev_set_drvdata(&mdiodev->dev, NULL);
@@ -2165,13 +2182,24 @@ qca8k_set_pm(struct qca8k_priv *priv, int enable)
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
@@ -2179,6 +2207,7 @@ static int qca8k_resume(struct device *dev)
 	struct qca8k_priv *priv = dev_get_drvdata(dev);
 
 	qca8k_set_pm(priv, 1);
+	qca8k_port_status_start(priv);
 
 	return dsa_switch_resume(priv->ds);
 }
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 13005f10e..d9db5e579 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -463,7 +463,7 @@ int qca8k_mib_init(struct qca8k_priv *priv)
 	return ret;
 }
 
-void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
+static u32 qca8k_port_status_mask(int port)
 {
 	u32 mask = QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
 
@@ -471,10 +471,77 @@ void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
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
@@ -751,8 +818,10 @@ int qca8k_port_enable(struct dsa_switch *ds, int port,
 {
 	struct qca8k_priv *priv = ds->priv;
 
-	qca8k_port_set_status(priv, port, 1);
+	mutex_lock(&priv->port_status_lock);
+	__qca8k_port_set_status(priv, port, 1);
 	priv->port_enabled_map |= BIT(port);
+	mutex_unlock(&priv->port_status_lock);
 
 	if (dsa_is_user_port(ds, port))
 		phy_support_asym_pause(phy);
@@ -764,14 +833,19 @@ void qca8k_port_disable(struct dsa_switch *ds, int port)
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
@@ -782,27 +856,59 @@ int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
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
 

base-commit: 78731b46967e3e7102b5cd5062bef185f3404b5c
-- 
2.43.0

