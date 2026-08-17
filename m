Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DE4450401;
	Mon, 17 Aug 2026 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984041; cv=none; b=B1vTmKSrzkN8wkgz/0BMjU4Tec517fpf+crfyMA/cfCkWAAbh+nwZjslRv/o9fjuODAAMfPIShsiMmIljvxIpImeGU+LAacyyyJlhZ23ywmTXzayWldnqNiKWn5ioH1Sh4PvjBl7KKOWghEf7iUeG1AFJMQUE46FYsCtM9QptzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984041; c=relaxed/simple;
	bh=KlApjxw+M+B6l/S23HEinDHUcia3Fy9ixRDKnIrNwaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3jg0TZGdJNPwomU72VSZGnJrtPFEot7m098pSS/+OuDBXMwuITF5bjtHJi1UM0/jyJ05YY1CSH/qKpxrXS+rF9ZZ9kzbl6JQDi5DMu26O4BRucNS5Nl/Sh3s/m0oIQqkVtFvjzNoDun2/j0hUux3PowQ39ErL18omQpWOiKAj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=kDWRZ2QG; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="kDWRZ2QG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786984010; x=1787588810;
	i=markus.stockhausen@gmx.de;
	bh=4KS//c55pNeZsvQG2bp0ZXTfNAwn7Hf9cq3ocJD+e3U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kDWRZ2QGiqeSTIe6M7eNQ6o3yNeBAQcla1CHvJDc561JXPkhra05rI5iPtSJ0SgM
	 xL0Ap7KOyl/WuK+GjOj5fw19uj1d/ULzbyMXtjgQq27NX17OhzSAPGU17Ju9DH7M+
	 ro6xFZFre3yIVAUBUq+z2gRXD+AO9RyzukEPEb8vNVM4pDu94cNMgqV2pEgXCAFK9
	 04Ah/DplPtJMt5Upcx7Wz+5GmMSmdOyLMNExkxcD9Zx/uKNtFHJ8ob+hOLbPTVuej
	 hhjTmug9Pqn3iI8cWc/MG/HK0C89srGpWj3djFy0C3RemHEz9sSj5XoEs92cTZNz1
	 HAD2DKn90OwHWuN/CQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt79P-1wgXml0cXp-00x0on; Mon, 17
 Aug 2026 18:26:50 +0200
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
Subject: [PATCH net-next v14 04/13] net: phy: add phy_detach_internal() helper
Date: Mon, 17 Aug 2026 18:26:23 +0200
Message-ID: <20260817162632.1208891-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ydxYz8SKuYvNAcbQO2gzMwnvDliUoW36ifD/4k8XA/A7n+2sCKl
 GVCFI9zePnPNleCun0kyOywZyyzHjkEiEcFOGCoUgm2tpe0ZW6ShKSdsS+JCpAp76fVS+m+
 +zNRnCy53C2l4KlIPlmGGWsarzRIl719JFRv354MThMWnT6S0Qi0h2U9kAsMlqtB2LfXGjc
 O1VQOoSvmpHLejoI6Pujw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sMiQpP15+qs=;dstG+R/EbDHF04LH4LxVMlQcc2f
 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

For the upcoming MDIO bus notification enhancements the PHY detach path
needs to inform the bus about these actions. Until now phy_detach() is
called normally but also in the phy_direct_attch() cleanup parts. So in
the future there must be a clear indication if a notification is needed
(normal path) or not (cleanup path).

Carve out the phy_detach() code into a new helper phy_detach_internal()
and make phy_detach() a short stub that calls the new helper.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/phy/phy_device.c | 165 ++++++++++++++++++-----------------
 1 file changed, 85 insertions(+), 80 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..835d71306b4d 100644
=2D-- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1734,6 +1734,91 @@ static bool phy_drv_supports_irq(const struct phy_d=
river *phydrv)
 	return phydrv->config_intr && phydrv->handle_interrupt;
 }
=20
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
@@ -1906,86 +1991,6 @@ int phy_attach_direct(struct net_device *dev, struc=
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

