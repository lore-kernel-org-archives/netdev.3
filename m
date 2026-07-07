Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3590D375F80;
	Tue,  7 Jul 2026 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433780; cv=none; b=RViz+NHwLZ8Lb8x2N7tGLgNMHCOiALMb9fPGoZg41ZaM0indwjsOzCa7AjPdobasSK/dlqWDN8psvsbSXU+HdJ0ztbwg+NCsBtKMxXS+pj/mDyGJvrj7Y36XYhKFEdYMJFK3Jd1uKluCeFlpxAMImTKQleec/1rXhk4tmvwbvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433780; c=relaxed/simple;
	bh=CtInqgYaYPPYAPb+Q1dD3K6AQRXwhR/EmugxqI8k/Ig=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q6ORHw5MljlEUKOx1HgKCJF3gIKvG5iza3BwtQxWtf7SRAX3J68kY+RqYVeazJUp+gpNdJc2WzJhobWs78Fv70CQ1Jjy0oXW8lBDeyL6gt/ZP8VQbkeMiwPv1hZAbQu0ECkqBrE4W9PbfJKM9iLtZpcWu0Eg2xY/MUGAoGZEDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wh6as-000000008AX-41Ds;
	Tue, 07 Jul 2026 14:16:15 +0000
Date: Tue, 7 Jul 2026 16:16:07 +0200
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH RFC net-next 2/3] net: dsa: mxl862xx: add SMDIO clause-22
 register access
Message-ID: <ak0KJ6gUk2l_IwoI@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add mxl862xx_smdio_read() and mxl862xx_smdio_write() for clause-22
SMDIO register access. MCUboot rescue mode only exposes clause-22
registers; the existing clause-45 MMD interface is unavailable during
firmware transfer. The MDIO bus lock is held per-transaction (not
across polls) so that SB PDI polling during flash erase does not
starve other MDIO users.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mxl862xx/mxl862xx-host.c | 35 ++++++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-host.h |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
index 4acd216f7cc0..6e582caea1fa 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -495,6 +495,41 @@ int mxl862xx_reset(struct mxl862xx_priv *priv)
 	return ret;
 }
 
+#define MXL862XX_SMDIO_ADDR_REG		0x1f
+#define MXL862XX_SMDIO_PAGE_MASK	0xfff0
+#define MXL862XX_SMDIO_OFF_MASK		0x000f
+
+int mxl862xx_smdio_read(struct mxl862xx_priv *priv, u32 addr)
+{
+	struct mii_bus *bus = priv->mdiodev->bus;
+	int phy = priv->mdiodev->addr;
+	int ret;
+
+	mutex_lock(&bus->mdio_lock);
+	ret = __mdiobus_write(bus, phy, MXL862XX_SMDIO_ADDR_REG,
+			      addr & MXL862XX_SMDIO_PAGE_MASK);
+	if (ret >= 0)
+		ret = __mdiobus_read(bus, phy, addr & MXL862XX_SMDIO_OFF_MASK);
+	mutex_unlock(&bus->mdio_lock);
+	return ret;
+}
+
+int mxl862xx_smdio_write(struct mxl862xx_priv *priv, u32 addr, u16 val)
+{
+	struct mii_bus *bus = priv->mdiodev->bus;
+	int phy = priv->mdiodev->addr;
+	int ret;
+
+	mutex_lock(&bus->mdio_lock);
+	ret = __mdiobus_write(bus, phy, MXL862XX_SMDIO_ADDR_REG,
+			      addr & MXL862XX_SMDIO_PAGE_MASK);
+	if (ret >= 0)
+		ret = __mdiobus_write(bus, phy, addr & MXL862XX_SMDIO_OFF_MASK,
+				      val);
+	mutex_unlock(&bus->mdio_lock);
+	return ret;
+}
+
 void mxl862xx_host_init(struct mxl862xx_priv *priv)
 {
 	INIT_WORK(&priv->crc_err_work, mxl862xx_crc_err_work_fn);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.h b/drivers/net/dsa/mxl862xx/mxl862xx-host.h
index 66d6ae198aff..4e054c6e4c0e 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.h
@@ -18,5 +18,7 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *data, u16 size,
 	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true, true)
 
 int mxl862xx_reset(struct mxl862xx_priv *priv);
+int mxl862xx_smdio_read(struct mxl862xx_priv *priv, u32 addr);
+int mxl862xx_smdio_write(struct mxl862xx_priv *priv, u32 addr, u16 val);
 
 #endif /* __MXL862XX_HOST_H */
-- 
2.55.0
