Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8605537F33D;
	Fri, 24 Jul 2026 05:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872605; cv=none; b=rsFuVtgvRyNcotHoZY113XvWpcTmMaK8efhXk9HWNdOkPViyyEF10m8I5EPTGA+z3kXbJyBQtwdRmOOx/a/fW7Qjq5UELhIxXkm/439g8EPk0YBcHpmIgDFMZp5n5+dUrx5j4JJLKUwp70brLTyYnivXwTTGII8wZB5+2dxZakk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872605; c=relaxed/simple;
	bh=nCh6jR7Fd6ZuBKhnX2LXdiMfPtw5dByGUNSbs/zWwYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7odhW1X6gWvF8h+7/T92UFZ1+Ys8Jn6xOEsfBxT8dC+7UTTh6Um+gydNvZBrXEL8MjU+X7WMex/cuw8sZ4v/IF+bOj/8UoomdTZH6XlmjE1vT8/Oc8hI8mdxG1ojTxDwbYZ5SPam0nCLI41fyISl2QuY3GxwEqgNJ08KgAOJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=H5P1uiLY; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="H5P1uiLY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784872585; x=1785477385;
	i=markus.stockhausen@gmx.de;
	bh=Zu5DTffIaBfhWSZ6aPF3EZOrH3ru1sgJbVH4ONvRlpI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H5P1uiLYQkAyZzU3KXYcEF4et/IBxq8PeAPCXu9PDrDQF6hMwBmBXajVBREx4ew3
	 5/IGxB6u9JysK6YDTD2TKiF8HXDnmudj9EiZqUIoZzyxMUX4gphe675ill/uP7JrJ
	 gPKKoN+yZj1HaoCUOxhHYONVoxPHIwNka1be0/to8TTDp0vyfY2Vn+bWFjEuzp9nn
	 Hvrt4YTPkIcnv4rsIQQ9KTVyGWs7C7bhSU2tOwb+QntIG8km7nGp74Q6XfYCa69si
	 waOCeTjDoWM6CXlQFR5lUjIgsYUo7y0jAJ5eGX+6vPM/R1JPStjQ9TP2a9Xh/aKsy
	 50CD1MK1b0CDhOlLlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq24-1x6j4r29iC-00s9Gs; Fri, 24
 Jul 2026 07:56:25 +0200
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
Subject: [PATCH net-next v6 3/8] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
Date: Fri, 24 Jul 2026 07:56:06 +0200
Message-ID: <20260724055611.1008577-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724055611.1008577-1-markus.stockhausen@gmx.de>
References: <20260724055611.1008577-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OQqq/v2Z27c3SQ83L7knAfkcnF5azT5ODQuG19bepH6BP7ESNu+
 QRcwpmQ54P6tNEzfnF4awU/xH8JRu/Oy2S/qhvYuSBZ4oEj6SLMqKPobQUK17w6Os+r8esB
 ubu2fKCjxSGTUak1UIBLFxg1+FJtgcHf1S1wC8hbKwZkj1NGzTmWxmWPIflanUzWYdXMdEH
 t9W0oqHLg/zIbn6+WcfYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L/rqg6bnSNU=;jHXGzyoKclVzAUbLsPZkkbmN3jB
 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
 +8N2gdsioENK

From: Daniel Golle <daniel@makrotopia.org>

Some MDIO buses require programiming PHY polling registers depending
on the PHY type. RealTek switch SoCs are the most prominent example
of a DSA switch which doesn't allow to program MAC speed, duplex and
flow-control settings without using PHY polling to do so [1].

Avoid a half-baked solution in the MDIO bus driver because

- it must reinvent the bus scanning to determine the PHYs and
- it must anticipate the right point in time (e.g. deferred PHYs).

Hence there is a need to inform the MDIO bus driver that a PHY is
being attached or detached. Provide two hooks in struct mii_bus

- notify_phy_attach(): called in phy_attach_direct() right after
  PHY hardware has been initialized and before PHY is resumed.
- notify_phy_detach(): called in phy_detach() right after PHY
  has been suspended.

The implementation is symmetric and follows LIFO teardown. The
detach notifier is only called when the attach notification
succeeded. For this

- Relocate code from phy_detach() into a new helper __phy_detach()
- The helper takes an additional parameter notify_bus that decides
  if the bus notification should be sent or not.
- Call the helper with notification from slimmed down version of
  phy_detach() and without notification from phy_attach_direct()
  error path.

Remark! A slightly different version of this patch was part of a
former series [2]. The discussion already showed that an initialization
hook should be placed somewhere late during the whole setup. This
commit implants it right after phy_init_hw() as suggested. On top of
this it adds the detach hook.

[1] https://github.com/openwrt/openwrt/pull/21515#discussion_r2714069716
[2] https://lore.kernel.org/netdev/cover.1769053496.git.daniel@makrotopia.=
org/

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/phy/phy_device.c | 179 +++++++++++++++++++----------------
 include/linux/phy.h          |  18 ++++
 2 files changed, 115 insertions(+), 82 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..38b31fc272d7 100644
=2D-- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1734,6 +1734,95 @@ static bool phy_drv_supports_irq(const struct phy_d=
river *phydrv)
 	return phydrv->config_intr && phydrv->handle_interrupt;
 }
=20
+static void __phy_detach(struct phy_device *phydev, bool notify_bus)
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
+	if (notify_bus && phydev->mdio.bus->notify_phy_detach)
+		phydev->mdio.bus->notify_phy_detach(phydev);
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
+	/* cleanup including bus notification */
+	__phy_detach(phydev, true);
+}
+EXPORT_SYMBOL(phy_detach);
+
 /**
  * phy_attach_direct - attach a network device to a given PHY device poin=
ter
  * @dev: network device to attach
@@ -1876,6 +1965,12 @@ int phy_attach_direct(struct net_device *dev, struc=
t phy_device *phydev,
 	if (err)
 		goto error;
=20
+	if (phydev->mdio.bus->notify_phy_attach) {
+		err =3D phydev->mdio.bus->notify_phy_attach(phydev);
+		if (err)
+			goto error;
+	}
+
 	phy_resume(phydev);
=20
 	/**
@@ -1890,8 +1985,8 @@ int phy_attach_direct(struct net_device *dev, struct=
 phy_device *phydev,
 	return err;
=20
 error:
-	/* phy_detach() does all of the cleanup below */
-	phy_detach(phydev);
+	/* cleanup without bus notification */
+	__phy_detach(phydev, false);
 	return err;
=20
 error_module_put:
@@ -1906,86 +2001,6 @@ int phy_attach_direct(struct net_device *dev, struc=
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
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 11092c3175b3..849dd43a11b4 100644
=2D-- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -376,6 +376,24 @@ struct mii_bus {
 			 int regnum, u16 val);
 	/** @reset: Perform a reset of the bus */
 	int (*reset)(struct mii_bus *bus);
+	/**
+	 * @notify_phy_attach: Perform post-attach handling for MDIO bus
+	 *   drivers. Called in phy_attach_direct() right after phy_init_hw()
+	 *   and before phy_resume(). At this point, the PHY is still
+	 *   suspended, and @phydev->attached_dev may be NULL (e.g. for
+	 *   standalone PHYs). Runs in process context and may sleep. Return
+	 *   0 on success or a negative errno on failure (which aborts the
+	 *   attach sequence).
+	 */
+	int (*notify_phy_attach)(struct phy_device *phydev);
+	/**
+	 * @notify_phy_detach: Perform pre-detach handling for MDIO bus
+	 *   drivers. Called in phy_detach() after phy_suspend() and link
+	 *   cleanup, but before driver unbind and device reference release.
+	 *   Runs in process context and may sleep. Only invoked if
+	 *   @notify_phy_attach was previously called and succeeded.
+	 */
+	void (*notify_phy_detach)(struct phy_device *phydev);
=20
 	/** @stats: Statistic counters per device on the bus */
 	struct mdio_bus_stats stats[PHY_MAX_ADDR];
=2D-=20
2.55.0

