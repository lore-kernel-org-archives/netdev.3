Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75B525A76;
	Mon,  7 Sep 2026 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788806278; cv=none; b=RKsAPe68jQfQ62MSVam6WjYUAVkjoFqbQQ+NAyBLmMX300pPC6L7fOHMygWty9f35XB7GzmnefYajzc0xOIE9Ua5cCUVRQqMg25dTgS7Pu4k91iMSz2yjJTEe6EjPyhSIZx8DsLvvWZ6RsoHunsuv66X3bCiGRlLsJ12jy6bySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788806278; c=relaxed/simple;
	bh=mhVAZ5bq+GWmlneKXb9ldHE+C/o5/8JIYJKp1IEQow8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shOrlNwOEjaJVHPeIFjX137zbAfdr16jvDs3gn1jJRQSwEdUS3CjRn+8VBZ8SZTSydelEsF3VTi35LeSLNFqI55RA9e0oqDHco5zX3KpCuILDokry1lJUceu++7wc76F5GxbcpkDf35bxlJJjU309800bAmSvKVFIRUH5ZeDYJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x3eE2-000000004el-1n3V;
	Mon, 07 Sep 2026 18:37:50 +0000
Date: Mon, 7 Sep 2026 19:37:47 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>,
	John Crispin <john@phrozen.org>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Subject: [PATCH net-next v13 2/6] net: dsa: mxl862xx: add SMDIO clause-22
 register access
Message-ID: <9bae011badf6d15e3a857fa6965126728031cd43.1788783126.git.daniel@makrotopia.org>
References: <cover.1788783126.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1788783126.git.daniel@makrotopia.org>

Add mxl862xx_smdio_read() and mxl862xx_smdio_write() for clause-22
SMDIO register access. The switch's MCUboot bootloader exposes only
clause-22 registers; the clause-45 MMD interface needs the running
firmware and is unavailable while the switch is in MCUboot. The MDIO
bus lock is held per-transaction (not across polls) so that SB PDI
polling during flash erase does not starve other non-switch users of
the same MDIO bus, such as separate PHYs providing WAN or management
interfaces.

Unlike mxl862xx_api_wrap(), which takes the bus lock with
MDIO_MUTEX_NESTED because it can be entered from the accessors of
the switch-internal MDIO bus while that bus's lock of the same lock
class is already held, the SMDIO helpers take it with a plain
mutex_lock(). They are only called from probe and devlink flash
contexts where no other MDIO bus lock can be held.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v13: no changes
v12: no changes
v11: no changes
v10: no changes
v9: no changes, picked up Andrew's v5 Reviewed-by
v8: document the paged register window and the per-transaction bus
    locking next to the helpers, rather than only in this changelog
    (found by Sashiko AI review)
v7: no changes
v6: no changes
v5: no changes
v4: no changes
v3: explain the plain mutex_lock() vs MDIO_MUTEX_NESTED choice in
    the commit message
v2: clarify in the commit message that the per-transaction bus
    locking is about unrelated non-switch devices on the same MDIO
    bus (Andrew Lunn)

 drivers/net/dsa/mxl862xx/mxl862xx-host.c | 40 ++++++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-host.h |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
index 4acd216f7cc0..11759fa6069b 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -495,6 +495,46 @@ int mxl862xx_reset(struct mxl862xx_priv *priv)
 	return ret;
 }
 
+#define MXL862XX_SMDIO_ADDR_REG		0x1f
+#define MXL862XX_SMDIO_PAGE_MASK	0xfff0
+#define MXL862XX_SMDIO_OFF_MASK		0x000f
+
+/* Paged clause-22 window: the page goes into MII register 0x1f, the low nibble
+ * of addr selects one of the 16 registers within it. Both helpers take the MDIO
+ * bus lock per transaction, so callers must not already hold it -- unlike
+ * mxl862xx_api_wrap(), which holds it across a whole firmware command.
+ */
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
