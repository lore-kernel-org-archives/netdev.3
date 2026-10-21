Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.19.144.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792610318;
	b=ov1y/4PIykBVvXKSh7em2dCsDqCYplQMAupq1TnHxGxDSsH5OCn6MpIxTbNbWAYeUdpS
	 NxcgcrPVKKNZCJ+qp4mQWUnJb/bYClMU6MJyubSyIuURWTWSAJqsO/gil4foMo722DXMj
	 a5YC7eYsV+iX9i3HgMhBFNdyDMlU9K2s6LuuSjtMz21Co2vbxFkLmf+KpKMi4LEz8D06Z
	 eWOJc1DLX7aSLea9ot2YtDpuOMSeuaVHU7c43PzY9gOMUCIdjN6KDZlglBMSiRK6VsZqi
	 n0m4r82igrAcKyKAssFMKcTiMk9V7otDAyo0ahsGYa95I4kvQ3FcW9Mn+bKzYhqQQCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792610318;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WigrYeX8rfIc0uBYkqlaE73MENE+ioOdixBQzIPPQ94=;
	b=HVNrXrVsAg0/SzKh1cwK0tmH20IFcTDOPqRcSYO11oMDgNIxMOCr0OSUwMDRcyVjMSWX
	 Yw0YYuKo2LPSQT1WgNSYYnpMriM5GfQdc/hZ0yNFZgpIq/DpJ/08hw8ats2Qj3XSbDBXd
	 FnbtT4GbI3R5+0S8EqfV1J56DKpGMZQwRE07cIRqbKkhe2NifVhKQPsQABR0bNPQO7v/x
	 ozeWwE73UZ9HhAOuxdklkAo5rntjImM/3tLCcUCnX9IH+MfyfFn6edbOluz3LRHTRveDN
	 kAe775Eb0AUXYLqHosN18htsD6HRWfYyxGnPwmpcMBq2Ct2ZX9XKvU+IvSaANd/Z1mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=lOfxcXcx;
	arc=none smtp.remote-ip=192.19.144.205
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp10.broadcom.com [192.19.144.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E1606A319;
	Wed, 21 Oct 2026 19:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 941E1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=lOfxcXcx
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 63828C0003CA;
	Wed, 21 Oct 2026 12:18:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 63828C0003CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1792610316;
	bh=UA06XtKwvW301MunTYXVgIQROZG16Q00vtmejpXylmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lOfxcXcxKfjJpJvbmzPlfgYT3ojF2V+BYDSRldIrStWX01FX7uBh6TWARTVvJN0pT
	 k4Am1Sg6A6SDVnoXHs70wYwdEe4rvK6nHfrdEl3kHAoGnImlBQdWAYM/YeTvMxa6Si
	 l2nHInNqeKa2MDlfyBBU5YcOSlL2HuXAMK+QA3a8=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 7EA35AEA3;
	Wed, 21 Oct 2026 15:18:35 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 5/6] net: dsa: b53: report link state through the PCS
Date: Wed, 21 Oct 2026 12:18:23 -0700
Message-ID: <20261021191824.752309-6-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021191824.752309-1-florian.fainelli@broadcom.com>
References: <20261021191824.752309-1-florian.fainelli@broadcom.com>
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

Decode the Clause 22 BMSR and link partner word with the phylink helper.
This respects the negotiation mode, reports the partner advertisement,
and resolves Clause 37 pause from the configured advertisement instead
of unconditionally accepting the vendor status register's result.

Notify phylink through phylink_pcs_change() from the SerDes port interrupt,
using live PCS status rather than MAC link status, which can be overridden
by mac_link_up/down(). Remove the now unused MAC notification helper.

Enable PCS polling as a fallback for optional port interrupts and for
negotiation completion after the initial link-change interrupt.

Fixes: 79396934e289 ("net: dsa: b53: convert to phylink_pcs")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 12 ------
 drivers/net/dsa/b53/b53_priv.h   |  1 -
 drivers/net/dsa/b53/b53_serdes.c | 72 +++++++++++++++-----------------
 drivers/net/dsa/b53/b53_serdes.h |  5 +++
 drivers/net/dsa/b53/b53_srab.c   |  2 +-
 5 files changed, 40 insertions(+), 52 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 09de3520e71a..b04f9d5f0525 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1522,18 +1522,6 @@ static void b53_adjust_5325_mii(struct dsa_switch *ds, int port)
 	}
 }
 
-void b53_port_event(struct dsa_switch *ds, int port)
-{
-	struct b53_device *dev = ds->priv;
-	bool link;
-	u16 sts;
-
-	b53_read16(dev, B53_STAT_PAGE, B53_LINK_STAT, &sts);
-	link = !!(sts & BIT(port));
-	dsa_port_phylink_mac_change(ds, port, link);
-}
-EXPORT_SYMBOL(b53_port_event);
-
 static void b53_phylink_get_caps(struct dsa_switch *ds, int port,
 				 struct phylink_config *config)
 {
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index cebbebe4ae0f..6028440e1358 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -519,7 +519,6 @@ int b53_br_flags(struct dsa_switch *ds, int port,
 		 struct switchdev_brport_flags flags,
 		 struct netlink_ext_ack *extack);
 int b53_setup_devlink_resources(struct dsa_switch *ds);
-void b53_port_event(struct dsa_switch *ds, int port);
 int b53_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
 		       struct netlink_ext_ack *extack);
 int b53_vlan_add(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/b53/b53_serdes.c b/drivers/net/dsa/b53/b53_serdes.c
index fc20e211e67e..c7f3e131f2de 100644
--- a/drivers/net/dsa/b53/b53_serdes.c
+++ b/drivers/net/dsa/b53/b53_serdes.c
@@ -291,50 +291,44 @@ static void b53_serdes_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 static void b53_serdes_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 				 struct phylink_link_state *state)
 {
-	struct b53_device *dev = pcs_to_b53_pcs(pcs)->dev;
-	u8 lane = pcs_to_b53_pcs(pcs)->lane;
-	int dig, bmsr;
-
-	dig = b53_serdes_read(dev, lane, B53_SERDES_DIGITAL_STATUS,
-			      SERDES_DIGITAL_BLK);
-	if (dig < 0) {
-		state->link = false;
-		b53_serdes_error(dev, lane, dig);
-		return;
-	}
+	struct b53_pcs *priv = pcs_to_b53_pcs(pcs);
+	struct b53_device *dev = priv->dev;
+	u8 lane = priv->lane;
+	int bmsr, lpa;
 
 	bmsr = b53_serdes_read(dev, lane, B53_SERDES_MII_REG(MII_BMSR),
 			       SERDES_MII_BLK);
-	if (bmsr < 0) {
-		state->link = false;
-		b53_serdes_error(dev, lane, bmsr);
-		return;
-	}
+	if (bmsr < 0)
+		goto error;
 
-	switch ((dig >> SPEED_STATUS_SHIFT) & SPEED_STATUS_MASK) {
-	case SPEED_STATUS_10:
-		state->speed = SPEED_10;
-		break;
-	case SPEED_STATUS_100:
-		state->speed = SPEED_100;
-		break;
-	case SPEED_STATUS_1000:
-		state->speed = SPEED_1000;
-		break;
-	default:
-	case SPEED_STATUS_2500:
-		state->speed = SPEED_2500;
-		break;
-	}
+	lpa = b53_serdes_read(dev, lane, B53_SERDES_MII_REG(MII_LPA),
+			      SERDES_MII_BLK);
+	if (lpa < 0)
+		goto error;
+
+	phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr, lpa);
+	return;
+error:
+	state->link = false;
+	state->an_complete = false;
+	b53_serdes_error(dev, lane, bmsr < 0 ? bmsr : lpa);
+}
+
+void b53_serdes_link_change(struct b53_device *dev, int port)
+{
+	u8 lane = b53_serdes_map_lane(dev, port);
+	int dig;
 
-	state->duplex = dig & DUPLEX_STATUS ? DUPLEX_FULL : DUPLEX_HALF;
-	state->an_complete = !!(bmsr & BMSR_ANEGCOMPLETE);
-	state->link = !!(dig & LINK_STATUS);
-	if (dig & PAUSE_RESOLUTION_RX_SIDE)
-		state->pause |= MLO_PAUSE_RX;
-	if (dig & PAUSE_RESOLUTION_TX_SIDE)
-		state->pause |= MLO_PAUSE_TX;
+	if (lane >= B53_N_PCS || !dev->pcs[lane].dev)
+		return;
+
+	/* Use the live PCS status, not latched BMSR or MAC override status. */
+	dig = b53_serdes_read(dev, lane, B53_SERDES_DIGITAL_STATUS,
+			      SERDES_DIGITAL_BLK);
+	b53_serdes_error(dev, lane, dig);
+	phylink_pcs_change(&dev->pcs[lane].pcs, dig >= 0 && (dig & LINK_STATUS));
 }
+EXPORT_SYMBOL(b53_serdes_link_change);
 
 static int b53_serdes_enable(struct phylink_pcs *pcs)
 {
@@ -440,6 +434,8 @@ int b53_serdes_init(struct b53_device *dev, int port)
 	pcs->dev = dev;
 	pcs->lane = lane;
 	pcs->pcs.ops = &b53_pcs_ops;
+	/* Port interrupts are optional and may precede AN completion. */
+	pcs->pcs.poll = true;
 	__set_bit(PHY_INTERFACE_MODE_SGMII, pcs->pcs.supported_interfaces);
 	__set_bit(PHY_INTERFACE_MODE_1000BASEX, pcs->pcs.supported_interfaces);
 
diff --git a/drivers/net/dsa/b53/b53_serdes.h b/drivers/net/dsa/b53/b53_serdes.h
index 2c2aa5eaa985..4016b24bcda4 100644
--- a/drivers/net/dsa/b53/b53_serdes.h
+++ b/drivers/net/dsa/b53/b53_serdes.h
@@ -119,8 +119,13 @@ struct phylink_pcs *b53_serdes_phylink_mac_select_pcs(struct b53_device *dev,
 void b53_serdes_phylink_get_caps(struct b53_device *dev, int port,
 				 struct phylink_config *config);
 #if IS_ENABLED(CONFIG_B53_SERDES)
+void b53_serdes_link_change(struct b53_device *dev, int port);
 int b53_serdes_init(struct b53_device *dev, int port);
 #else
+static inline void b53_serdes_link_change(struct b53_device *dev, int port)
+{
+}
+
 static inline int b53_serdes_init(struct b53_device *dev, int port)
 {
 	return -ENODEV;
diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index 77e81e1a414a..56da3dbaf997 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -374,7 +374,7 @@ static irqreturn_t b53_srab_port_thread(int irq, void *dev_id)
 	struct b53_device *dev = port->dev;
 
 	if (port->mode == PHY_INTERFACE_MODE_SGMII)
-		b53_port_event(dev->ds, port->num);
+		b53_serdes_link_change(dev, port->num);
 
 	return IRQ_HANDLED;
 }
-- 
2.53.0

