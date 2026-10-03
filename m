Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C48339872;
	Sat,  3 Oct 2026 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791042721; cv=none; b=GIqg59oAgOChtxA4eAipsxtcq2K0IxNJSV4OUigdq9xJkVZCfIaZFtHwbTN99J820hXFIGRI64e4fGqIek5zQHNGC0e/GVVa4rbIsdTcBoGqewz/s8wLFMUu+9oUkoWNBg/pQYtqUS/3bikJ4ooeh8Hc7WBLgXqECdrdMPM17x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791042721; c=relaxed/simple;
	bh=qO+fmdmr6QNl5LeoXf/3TJkWNd7H7cQy4oDx1mMbw/s=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXDiTFYFhjYqL1g+41t1CW1ZehyJc8eYlw56J+QNujNk0o5F/5TB1Rwj51i3xIIlTpk2gqJr26Yvld7jmteUfhApp2nCg/v+YZHVwpMmjKSlsOShDQBbhwIMR/oV2ghgBfvPwtAH1MHRRCt2Q2DeWk/rl4vts8uT4Ocx7vP0sRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xD21j-000000001Gg-1fvh;
	Sat, 03 Oct 2026 15:51:55 +0000
Date: Sat, 3 Oct 2026 16:51:52 +0100
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
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH net-next v19 2/6] net: dsa: mxl862xx: add SMDIO clause-22
 register access
Message-ID: <8fbcfd5ceef8cb1da98145491399d8f4cfd7497a.1791035885.git.daniel@makrotopia.org>
References: <cover.1791035885.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791035885.git.daniel@makrotopia.org>

Add mxl862xx_smdio_read() and mxl862xx_smdio_write() for clause-22
SMDIO register access. The switch's MCUboot bootloader exposes only
clause-22 registers; the clause-45 MMD interface needs the running
firmware and is unavailable while the switch is in MCUboot. The MDIO
bus lock is held per-transaction (not across polls) so that SB PDI
polling during flash erase does not starve other non-switch users of
the same MDIO bus, such as separate PHYs providing WAN or management
interfaces.

mxl862xx_api_wrap() takes the bus lock with MDIO_MUTEX_NESTED because
it can be entered from the accessors of the switch-internal MDIO bus
while that bus's lock of the same lock class is already held. The
SMDIO helpers take it with a plain mutex_lock(): they run where no
other MDIO bus lock is held, from probe, the devlink flash path and
the rescue recovery work.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v19: commit message and comment: name the rescue recovery work among the
     callers, state the locking of each path on its own, and say that no
     MDIO bus lock at all may be held, as every bus shares the lock class
     (found by Sashiko AI review and a local review)
v18: no changes
v17: no changes
v16: no changes
v15: no changes
v14: no changes
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

 drivers/net/dsa/mxl862xx/mxl862xx-host.c | 41 ++++++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-host.h |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
index 4acd216f7cc00..6fc04a38675ae 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -495,6 +495,47 @@ int mxl862xx_reset(struct mxl862xx_priv *priv)
 	return ret;
 }
 
+#define MXL862XX_SMDIO_ADDR_REG		0x1f
+#define MXL862XX_SMDIO_PAGE_MASK	0xfff0
+#define MXL862XX_SMDIO_OFF_MASK		0x000f
+
+/* Paged clause-22 window: the page goes into MII register 0x1f, the low nibble
+ * of addr selects one of the 16 registers within it. Both helpers take the MDIO
+ * bus lock per transaction with a plain mutex_lock(), so the caller may hold
+ * no MDIO bus lock at all, every bus sharing the lock class;
+ * mxl862xx_api_wrap() holds this one across a whole firmware command.
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
index 66d6ae198aff4..4e054c6e4c0e4 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.h
@@ -18,5 +18,7 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *data, u16 size,
 	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true, true)
 
 int mxl862xx_reset(struct mxl862xx_priv *priv);
+int mxl862xx_smdio_read(struct mxl862xx_priv *priv, u32 addr);
+int mxl862xx_smdio_write(struct mxl862xx_priv *priv, u32 addr, u16 val);
 
 #endif /* __MXL862XX_HOST_H */
-- 
2.56.0
