Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A824F30CB;
	Mon, 31 Aug 2026 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186926; cv=none; b=P9yqX5BnCs0l4K/PMLJ52GwS/5N8en41XYKkH53xryDZB8Xq8yC6KxMPqBq4e1ZwLrwFw1AeE99uTlQVW/sfMEhgUZkIbNC0BpTof12y2kK6HIWFqz60XWJbLy6TbhSSM2MG8/GSYHzSLuv3ldW6jYBub9sL48tXuFTc4RbZC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186926; c=relaxed/simple;
	bh=luclH9wg0N4dKrwe/g1d3y9JXPAC0KeUxjQS5IOVTzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vw5L/s0W4h4NcZrujKBEKYPNZF43Mil0vKObb/DS4QDeB79dlC23pYCOGYPVW0Fg1IEUne2vpWSTlkLuftLPJQ6O3GhhTac9XT7LmJiV2K7vJhP8p4DhD7RYyD+CtYuH4FCeSr8GiPgxJ3AchzRjiL9MhI8Q3HBIvoRlwCKO9UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=dwKdmTVZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="dwKdmTVZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788186897; x=1788791697;
	i=markus.stockhausen@gmx.de;
	bh=SjtS6WWi6Y4UMG5dc9I6kGJtyu9JqpIbL9ACDkbQLCY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dwKdmTVZZ7VJzO333EHuf3uD70pxYCWzNG9u4vdVCW8QCPIMnIPlBa50B9gANKoe
	 4Tx48WOwhpLzSVekzQl+UtA7XoiIfzA6L/9qR423t37wxAF3wa3eK/OcP9EbiyZ6x
	 lpq9/YCg4WxoU1Jy4aBEeyze9i0GV7ZaAEDeNkwUwHc3gGPFr6LrOZd0F93sznnXL
	 DNgS2bkQfriOWuT5lZDWsR7lqHgIz0nLtkX5wgqvPxjNfElAcNkFsiv8b6floHur6
	 mhJTroPX5zP3/X38dEPXbS9L0XYnNQWrj7617frvlnRK2mYEzy+DQoPvjiIeHNZEV
	 53ILckTIuwfhoPTIsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9UE-1wiHpN03JU-00xf4S; Mon, 31
 Aug 2026 16:34:57 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v15 04/13] net: phy: add phy_detach_internal() helper
Date: Mon, 31 Aug 2026 16:34:30 +0200
Message-ID: <20260831143439.2404484-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TgyKi2N9b/F71miVINr8Wof0PyrLDzoeRRxlV/6BMOlLyqsv67u
 AVoGjAnHYtag0yK2JjvVls3hk8Ji+n9KD5jBy+Wy05L2LL8+u/on/0kLP0EMCCLGx1D7SKM
 demRn254yoelPTA6WEIG/k306zTl4qMXrFnRnlGl/IVUjqGM3HTtbtUR/vZ1qk56VE7o25O
 PqFantjgigALjpchHY85A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X4/wA6fPtI8=;AS9IJRl5mCambSStOzsD3iOHnNG
 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
 GDlIKCPhLD8kISYLCK5yh5f

For the upcoming MDIO bus notification enhancements the PHY detach path
needs to inform the bus about these actions. Until now phy_detach() is
used for the regular detach path as well as from the phy_attach_direct()
error paths So in the future there must be a clear indication if a
notification is needed (normal path) or not (cleanup path).

Carve out the phy_detach() code into a new helper phy_detach_internal()
and make phy_detach() a short stub that calls the new helper.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/phy/phy_device.c | 172 +++++++++++++++++++----------------
 1 file changed, 92 insertions(+), 80 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..2827d2226d6a 100644
=2D-- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1734,6 +1734,98 @@ static bool phy_drv_supports_irq(const struct phy_d=
river *phydrv)
 	return phydrv->config_intr && phydrv->handle_interrupt;
 }
=20
+/**
+ * phy_detach_internal - detach a PHY device from its network device
+ * @phydev: target phy_device struct
+ *
+ * This detaches the phy device from its network device and the phy
+ * driver, and drops the reference count taken in phy_attach_direct().
+ */
+static void phy_detach_internal(struct phy_device *phydev)
+{
+	struct net_device *dev =3D phydev->attached_dev;
+	struct module *ndev_owner =3D NULL;
+	struct mii_bus *bus;
+
+	if (phydev->devlink) {
+		device_link_del(phydev->devlink);
+		phydev->devlink =3D NULL;
+	}
+
+	if (phydev->sysfs_links) {
+		if (dev)
+			sysfs_remove_link(&dev->dev.kobj, "phydev");
+		sysfs_remove_link(&phydev->mdio.dev.kobj, "attached_dev");
+	}
+
+	if (!phydev->attached_dev)
+		sysfs_remove_file(&phydev->mdio.dev.kobj,
+				  &dev_attr_phy_standalone.attr);
+
+	phy_suspend(phydev);
+	if (dev) {
+		struct hwtstamp_provider *hwprov;
+
+		/* hwprov may technically be protected by ops lock but
+		 * not for devices with a phydev, see phy_link_topo_add_phy()
+		 */
+		hwprov =3D rtnl_dereference(dev->hwprov);
+		/* Disable timestamp if it is the one selected */
+		if (hwprov && hwprov->phydev =3D=3D phydev) {
+			rcu_assign_pointer(dev->hwprov, NULL);
+			kfree_rcu(hwprov, rcu_head);
+		}
+
+		phydev->attached_dev->phydev =3D NULL;
+		phydev->attached_dev =3D NULL;
+		phy_link_topo_del_phy(dev, phydev);
+	}
+
+	phydev->phy_link_change =3D NULL;
+	phydev->phylink =3D NULL;
+
+	if (phydev->mdio.dev.driver)
+		module_put(phydev->mdio.dev.driver->owner);
+
+	/* If the device had no specific driver before (i.e. - it
+	 * was using the generic driver), we unbind the device
+	 * from the generic driver so that there's a chance a
+	 * real driver could be loaded
+	 */
+	if (phydev->is_genphy_driven) {
+		device_release_driver(&phydev->mdio.dev);
+		phydev->is_genphy_driven =3D 0;
+	}
+
+	/* Assert the reset signal */
+	phy_device_reset(phydev, 1);
+
+	/*
+	 * The phydev might go away on the put_device() below, so avoid
+	 * a use-after-free bug by reading the underlying bus first.
+	 */
+	bus =3D phydev->mdio.bus;
+
+	put_device(&phydev->mdio.dev);
+	if (dev)
+		ndev_owner =3D dev->dev.parent->driver->owner;
+	if (ndev_owner !=3D bus->owner)
+		module_put(bus->owner);
+}
+
+/**
+ * phy_detach - detach a PHY device from its network device
+ * @phydev: target phy_device struct
+ *
+ * This detaches the phy device from its network device and the phy
+ * driver, and drops the reference count taken in phy_attach_direct().
+ */
+void phy_detach(struct phy_device *phydev)
+{
+	phy_detach_internal(phydev);
+}
+EXPORT_SYMBOL(phy_detach);
+
 /**
  * phy_attach_direct - attach a network device to a given PHY device poin=
ter
  * @dev: network device to attach
@@ -1906,86 +1998,6 @@ int phy_attach_direct(struct net_device *dev, struc=
t phy_device *phydev,
 }
 EXPORT_SYMBOL(phy_attach_direct);
=20
-/**
- * phy_detach - detach a PHY device from its network device
- * @phydev: target phy_device struct
- *
- * This detaches the phy device from its network device and the phy
- * driver, and drops the reference count taken in phy_attach_direct().
- */
-void phy_detach(struct phy_device *phydev)
-{
-	struct net_device *dev =3D phydev->attached_dev;
-	struct module *ndev_owner =3D NULL;
-	struct mii_bus *bus;
-
-	if (phydev->devlink) {
-		device_link_del(phydev->devlink);
-		phydev->devlink =3D NULL;
-	}
-
-	if (phydev->sysfs_links) {
-		if (dev)
-			sysfs_remove_link(&dev->dev.kobj, "phydev");
-		sysfs_remove_link(&phydev->mdio.dev.kobj, "attached_dev");
-	}
-
-	if (!phydev->attached_dev)
-		sysfs_remove_file(&phydev->mdio.dev.kobj,
-				  &dev_attr_phy_standalone.attr);
-
-	phy_suspend(phydev);
-	if (dev) {
-		struct hwtstamp_provider *hwprov;
-
-		/* hwprov may technically be protected by ops lock but
-		 * not for devices with a phydev, see phy_link_topo_add_phy()
-		 */
-		hwprov =3D rtnl_dereference(dev->hwprov);
-		/* Disable timestamp if it is the one selected */
-		if (hwprov && hwprov->phydev =3D=3D phydev) {
-			rcu_assign_pointer(dev->hwprov, NULL);
-			kfree_rcu(hwprov, rcu_head);
-		}
-
-		phydev->attached_dev->phydev =3D NULL;
-		phydev->attached_dev =3D NULL;
-		phy_link_topo_del_phy(dev, phydev);
-	}
-
-	phydev->phy_link_change =3D NULL;
-	phydev->phylink =3D NULL;
-
-	if (phydev->mdio.dev.driver)
-		module_put(phydev->mdio.dev.driver->owner);
-
-	/* If the device had no specific driver before (i.e. - it
-	 * was using the generic driver), we unbind the device
-	 * from the generic driver so that there's a chance a
-	 * real driver could be loaded
-	 */
-	if (phydev->is_genphy_driven) {
-		device_release_driver(&phydev->mdio.dev);
-		phydev->is_genphy_driven =3D 0;
-	}
-
-	/* Assert the reset signal */
-	phy_device_reset(phydev, 1);
-
-	/*
-	 * The phydev might go away on the put_device() below, so avoid
-	 * a use-after-free bug by reading the underlying bus first.
-	 */
-	bus =3D phydev->mdio.bus;
-
-	put_device(&phydev->mdio.dev);
-	if (dev)
-		ndev_owner =3D dev->dev.parent->driver->owner;
-	if (ndev_owner !=3D bus->owner)
-		module_put(bus->owner);
-}
-EXPORT_SYMBOL(phy_detach);
-
 int phy_suspend(struct phy_device *phydev)
 {
 	struct net_device *netdev =3D phydev->attached_dev;
=2D-=20
2.55.0

