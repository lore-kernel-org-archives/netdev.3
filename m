Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.19.144.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792610313;
	b=Egokz3rPcK7IDUlLTw8KNHTEsgYFtXq/lJgGWCRmb+jgkWCZGehUUuqKOOrROXffRk4i
	 iC37bf29NF4tSU/iXvccFgLUbIHcdJiTQRDHga3cnYA567AY/tI752lvwT+Qt/X1rVEcZ
	 n9ceUMLBnFCynJkzU0LKLcSnVfiNOj8z2eksiFl+kbKM+svzCl06S5r8e7V+xu2vXMJga
	 w/QlY6aAZDTWBsyj4JFCDS+sS50VB/gBIZOBi27lsKccTN7+NsWL1YSLVuiYTHhbarQVR
	 OLe3+agnyec0ieYvFaju/Lucc4QtEP/IqjdtIogqjNnD/ay/0qwx9QnLnCl4F0+xefA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792610313;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h8gPfI9JeQ9XOUZVTcwz6/7mOX9l24c3JGDHItgBJZ0=;
	b=gZeB7b8GSBp7rAg+178XglHwUsRfQB9B/gCWmXWnRVX14mbsf2DD6RfWjsOjwQLSOSaW
	 gmWfBd/fG0ZjyQRsfvhR+L3cYHq49u0DROJ/OKT44+4eCzh+6/gnONqSzkrrq1xlIlIBw
	 JDbLZLq6K9x3TloGd2EOQnJZKBfYdnykACRdzm7UF43sbBC3x+qisQYnN8Nxi7Sw+6v/T
	 C+Yq4YVNKc/30SQM6us0dN6tmY86Aw5fzD1xgbmlZSjNffIFftStnrzMpdePP94RYF3sV
	 61h6YkjygZ3kVXxrCmTJDobeqOCBTTXvUlrVFRly3XQhNPsA8cnBw6kK/1aL3XqIUfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=lbl7iq1k;
	arc=none smtp.remote-ip=192.19.144.207
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45850606A31A;
	Wed, 21 Oct 2026 19:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45850606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=lbl7iq1k
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 4EA08C0003DB;
	Wed, 21 Oct 2026 12:18:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4EA08C0003DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1792610312;
	bh=iiLnhPyF8ngmJEZdGAisLAAWwlZV4iqQ9LtHOUPIS3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbl7iq1k5b8BAH5Jfcr8u+z/03Gi1tLIDYLny6HPl0+wa1r/cc45g9yq3eUDJjvYw
	 RDmrtqtJFLjEKi80xSQEXjcaRzj/9f1ThpKjpW/jyjVcnuCtTDJgtIVcWe4PWHx5Kp
	 /2i95iKL03qCEEInmUn87eFKP/uCn4mr2v1h5MPc=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 69644AEA3;
	Wed, 21 Oct 2026 15:18:31 -0400 (EDT)
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
Subject: [PATCH net 1/6] net: dsa: b53: serialize SerDes register transactions
Date: Wed, 21 Oct 2026 12:18:19 -0700
Message-ID: <20261021191824.752309-2-florian.fainelli@broadcom.com>
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

The lane and block selectors are shared by both SerDes lanes. Taking
reg_mutex separately for each register access allows another port to
change either selector before the data access. Hold the mutex across the
complete transaction and use the raw bus operations while it is held.

Propagate bus errors instead of returning uninitialized register contents,
only cache a successfully selected lane, and invalidate the cache after
failed accesses. Make the PCS callbacks fail configuration or report link
down on read errors, and reject out-of-range lane indices at discovery.

Fixes: 0e01491de646 ("net: dsa: b53: Add SerDes support")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c |   1 +
 drivers/net/dsa/b53/b53_serdes.c | 148 ++++++++++++++++++++++++-------
 2 files changed, 115 insertions(+), 34 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0880310c9ce3..3f8f956aab82 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -3203,6 +3203,7 @@ struct b53_device *b53_switch_alloc(struct device *base,
 	dev->ds = ds;
 	dev->priv = priv;
 	dev->ops = ops;
+	dev->serdes_lane = B53_INVALID_LANE;
 	ds->ops = &b53_switch_ops;
 	ds->phylink_mac_ops = &b53_phylink_mac_ops;
 	dev->vlan_enabled = true;
diff --git a/drivers/net/dsa/b53/b53_serdes.c b/drivers/net/dsa/b53/b53_serdes.c
index 7460122f6abc..c90894877626 100644
--- a/drivers/net/dsa/b53/b53_serdes.c
+++ b/drivers/net/dsa/b53/b53_serdes.c
@@ -22,47 +22,96 @@ static inline struct b53_pcs *pcs_to_b53_pcs(struct phylink_pcs *pcs)
 	return container_of(pcs, struct b53_pcs, pcs);
 }
 
-static void b53_serdes_write_blk(struct b53_device *dev, u8 offset, u16 block,
-				 u16 value)
+/* The caller holds reg_mutex across lane, block and data accesses. */
+static int b53_serdes_write_blk(struct b53_device *dev, u8 offset, u16 block,
+				u16 value)
 {
-	b53_write16(dev, B53_SERDES_PAGE, B53_SERDES_BLKADDR, block);
-	b53_write16(dev, B53_SERDES_PAGE, offset, value);
+	int ret;
+
+	lockdep_assert_held(&dev->reg_mutex);
+
+	ret = dev->ops->write16(dev, B53_SERDES_PAGE, B53_SERDES_BLKADDR,
+				block);
+	if (ret)
+		return ret;
+
+	return dev->ops->write16(dev, B53_SERDES_PAGE, offset, value);
 }
 
-static u16 b53_serdes_read_blk(struct b53_device *dev, u8 offset, u16 block)
+static int b53_serdes_read_blk(struct b53_device *dev, u8 offset, u16 block)
 {
 	u16 value;
+	int ret;
+
+	lockdep_assert_held(&dev->reg_mutex);
 
-	b53_write16(dev, B53_SERDES_PAGE, B53_SERDES_BLKADDR, block);
-	b53_read16(dev, B53_SERDES_PAGE, offset, &value);
+	ret = dev->ops->write16(dev, B53_SERDES_PAGE, B53_SERDES_BLKADDR,
+				block);
+	if (ret)
+		return ret;
 
-	return value;
+	ret = dev->ops->read16(dev, B53_SERDES_PAGE, offset, &value);
+	return ret ? ret : value;
 }
 
-static void b53_serdes_set_lane(struct b53_device *dev, u8 lane)
+static int b53_serdes_set_lane(struct b53_device *dev, u8 lane)
 {
+	int ret;
+
+	lockdep_assert_held(&dev->reg_mutex);
+
+	if (lane >= B53_N_PCS)
+		return -EINVAL;
+
 	if (dev->serdes_lane == lane)
-		return;
+		return 0;
 
-	WARN_ON(lane > 1);
+	ret = b53_serdes_write_blk(dev, B53_SERDES_LANE,
+				   SERDES_XGXSBLK0_BLOCKADDRESS, lane);
+	if (ret)
+		return ret;
 
-	b53_serdes_write_blk(dev, B53_SERDES_LANE,
-			     SERDES_XGXSBLK0_BLOCKADDRESS, lane);
 	dev->serdes_lane = lane;
+	return 0;
 }
 
-static void b53_serdes_write(struct b53_device *dev, u8 lane,
-			     u8 offset, u16 block, u16 value)
+static int b53_serdes_write(struct b53_device *dev, u8 lane,
+			    u8 offset, u16 block, u16 value)
 {
-	b53_serdes_set_lane(dev, lane);
-	b53_serdes_write_blk(dev, offset, block, value);
+	int ret;
+
+	mutex_lock(&dev->reg_mutex);
+	ret = b53_serdes_set_lane(dev, lane);
+	if (!ret)
+		ret = b53_serdes_write_blk(dev, offset, block, value);
+	if (ret)
+		dev->serdes_lane = B53_INVALID_LANE;
+	mutex_unlock(&dev->reg_mutex);
+
+	return ret;
 }
 
-static u16 b53_serdes_read(struct b53_device *dev, u8 lane,
+static int b53_serdes_read(struct b53_device *dev, u8 lane,
 			   u8 offset, u16 block)
 {
-	b53_serdes_set_lane(dev, lane);
-	return b53_serdes_read_blk(dev, offset, block);
+	int ret;
+
+	mutex_lock(&dev->reg_mutex);
+	ret = b53_serdes_set_lane(dev, lane);
+	if (!ret)
+		ret = b53_serdes_read_blk(dev, offset, block);
+	if (ret < 0)
+		dev->serdes_lane = B53_INVALID_LANE;
+	mutex_unlock(&dev->reg_mutex);
+
+	return ret;
+}
+
+static void b53_serdes_error(struct b53_device *dev, u8 lane, int ret)
+{
+	if (ret < 0)
+		dev_err_ratelimited(dev->dev, "SerDes lane %u access failed: %pe\n",
+				    lane, ERR_PTR(ret));
 }
 
 static int b53_serdes_config(struct phylink_pcs *pcs, unsigned int neg_mode,
@@ -72,31 +121,37 @@ static int b53_serdes_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 {
 	struct b53_device *dev = pcs_to_b53_pcs(pcs)->dev;
 	u8 lane = pcs_to_b53_pcs(pcs)->lane;
-	u16 reg;
+	int reg;
 
 	reg = b53_serdes_read(dev, lane, B53_SERDES_DIGITAL_CONTROL(1),
 			      SERDES_DIGITAL_BLK);
+	if (reg < 0)
+		return reg;
+
 	if (interface == PHY_INTERFACE_MODE_1000BASEX)
 		reg |= FIBER_MODE_1000X;
 	else
 		reg &= ~FIBER_MODE_1000X;
-	b53_serdes_write(dev, lane, B53_SERDES_DIGITAL_CONTROL(1),
-			 SERDES_DIGITAL_BLK, reg);
-
-	return 0;
+	return b53_serdes_write(dev, lane, B53_SERDES_DIGITAL_CONTROL(1),
+				SERDES_DIGITAL_BLK, reg);
 }
 
 static void b53_serdes_an_restart(struct phylink_pcs *pcs)
 {
 	struct b53_device *dev = pcs_to_b53_pcs(pcs)->dev;
 	u8 lane = pcs_to_b53_pcs(pcs)->lane;
-	u16 reg;
+	int reg;
 
 	reg = b53_serdes_read(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
 			      SERDES_MII_BLK);
+	if (reg < 0)
+		goto out;
+
 	reg |= BMCR_ANRESTART;
-	b53_serdes_write(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
-			 SERDES_MII_BLK, reg);
+	reg = b53_serdes_write(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
+			       SERDES_MII_BLK, reg);
+out:
+	b53_serdes_error(dev, lane, reg);
 }
 
 static void b53_serdes_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
@@ -104,12 +159,23 @@ static void b53_serdes_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 {
 	struct b53_device *dev = pcs_to_b53_pcs(pcs)->dev;
 	u8 lane = pcs_to_b53_pcs(pcs)->lane;
-	u16 dig, bmsr;
+	int dig, bmsr;
 
 	dig = b53_serdes_read(dev, lane, B53_SERDES_DIGITAL_STATUS,
 			      SERDES_DIGITAL_BLK);
+	if (dig < 0) {
+		state->link = false;
+		b53_serdes_error(dev, lane, dig);
+		return;
+	}
+
 	bmsr = b53_serdes_read(dev, lane, B53_SERDES_MII_REG(MII_BMSR),
 			       SERDES_MII_BLK);
+	if (bmsr < 0) {
+		state->link = false;
+		b53_serdes_error(dev, lane, bmsr);
+		return;
+	}
 
 	switch ((dig >> SPEED_STATUS_SHIFT) & SPEED_STATUS_MASK) {
 	case SPEED_STATUS_10:
@@ -140,19 +206,24 @@ void b53_serdes_link_set(struct b53_device *dev, int port, unsigned int mode,
 			 phy_interface_t interface, bool link_up)
 {
 	u8 lane = b53_serdes_map_lane(dev, port);
-	u16 reg;
+	int reg;
 
 	if (lane == B53_INVALID_LANE)
 		return;
 
 	reg = b53_serdes_read(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
 			      SERDES_MII_BLK);
+	if (reg < 0)
+		goto out;
+
 	if (link_up)
 		reg &= ~BMCR_PDOWN;
 	else
 		reg |= BMCR_PDOWN;
-	b53_serdes_write(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
-			 SERDES_MII_BLK, reg);
+	reg = b53_serdes_write(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
+			       SERDES_MII_BLK, reg);
+out:
+	b53_serdes_error(dev, lane, reg);
 }
 EXPORT_SYMBOL(b53_serdes_link_set);
 
@@ -213,16 +284,25 @@ int b53_serdes_init(struct b53_device *dev, int port)
 {
 	u8 lane = b53_serdes_map_lane(dev, port);
 	struct b53_pcs *pcs;
-	u16 id0, msb, lsb;
+	int id0, msb, lsb;
 
-	if (lane == B53_INVALID_LANE)
+	if (lane >= B53_N_PCS)
 		return -EINVAL;
 
 	id0 = b53_serdes_read(dev, lane, B53_SERDES_ID0, SERDES_ID0);
+	if (id0 < 0)
+		return id0;
+
 	msb = b53_serdes_read(dev, lane, B53_SERDES_MII_REG(MII_PHYSID1),
 			      SERDES_MII_BLK);
+	if (msb < 0)
+		return msb;
+
 	lsb = b53_serdes_read(dev, lane, B53_SERDES_MII_REG(MII_PHYSID2),
 			      SERDES_MII_BLK);
+	if (lsb < 0)
+		return lsb;
+
 	if (id0 == 0 || id0 == 0xffff) {
 		dev_err(dev->dev, "SerDes not initialized, check settings\n");
 		return -ENODEV;
-- 
2.53.0

