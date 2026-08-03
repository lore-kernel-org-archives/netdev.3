Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6EF35A384;
	Mon,  3 Aug 2026 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777560; cv=none; b=E9guwuzvG5OQnu5I/69jsXue2Y8TmXAM93lZIa08vi8zRLs1q4o/ud0t33P+roWZbu0fz2Y9EPw7uzY4MP2ROvk3OzJrmUE6S7I5+KYql1KPKB6pAw06bKWYNMDQAPugyWTqw9HHzfinudQVhLxdNrm/czexGZwfSYJGRZzA6pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777560; c=relaxed/simple;
	bh=nNPpJ3jgJ4vZhS3npXKGNYuoRWuJPMaRt/U62ygLjk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/EG6hqOtI/hArWkoQks5qCawdRcfdbbu4jVXwYAoziOLoJnwPDP/hGoO/26JU0gjjrII2z5EMFkiJx06zSh53zYrBE4BoPixxP9M+EF3TF1rkR+3273yNvH+pzmqJEacYd37nkX8N2/4liIAYnPQG8NQKmGIVSXG2jhOPrbcK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=X2Gyc6j1; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="X2Gyc6j1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785777552; x=1786382352;
	i=markus.stockhausen@gmx.de;
	bh=k35fzHH3PkUCZPD9+NAIfJV1MZe3RheAlrYYUkwppgs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X2Gyc6j1QMJlc19TeP/EI7yygkULyHfGkafd2q5LV6oU1BHDKZqyVCISyE4h7dBA
	 fQkG7seIXJ5I1boGHQJwq475kxrLOcqKRguqrJfLPggFhA+TjsBbZvK15AYL0/Wc3
	 LF3NQZio3GtxLxB6Zrdu0Mxr5mEWqvtsYt/1bNJlAgjINt7jQS0HU77tfsNRb4SiL
	 cdBLk6Yrt6pPuYLg+A8C9OSD48LSpjReASlsuUZngDXFEbdIyt7Dk/euVxoMPFhjS
	 NUsuDIE+MdBDjVc0kVS5BoX6I2NyNusD2kBMomC8sKgJRTqRd8GFDa+2VGhJX/H2+
	 NF5HDETJ6vg1HPQn1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ3t-1wNUiI3V4P-00Z16X; Mon, 03
 Aug 2026 19:19:11 +0200
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
Subject: [PATCH net-next v12 03/11] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
Date: Mon,  3 Aug 2026 19:18:45 +0200
Message-ID: <20260803171853.507506-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803171853.507506-1-markus.stockhausen@gmx.de>
References: <20260803171853.507506-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CJp3T8oax01uPA7E/d771SYzQYncUXJ3a3vLnk25FrcrtGa+ict
 2ryFEeTH4j1xFOrzqnyrIxhTUy2QGjmJf5ZuvuwnNxI4x44TOXH7BQJtpqCot5h3OwWRnhl
 5atl/s+UMmlsTfh3T1chKFGhGx1AvgDvRSQULNoeTPKPClo88PYStjvXefea+haEwrqEaZs
 g6wS1v+6jOacFP0By1oGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZRet0aI1zA8=;ADMq46xI/GKOLo/odllh65Ja7Nt
 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

From: Daniel Golle <daniel@makrotopia.org>

Some MDIO buses require programming PHY polling registers depending
on the PHY type. RealTek switch SoCs are the most prominent example
of a DSA switch which doesn't allow to program MAC speed, duplex and
flow-control settings without using PHY polling to do so [1].

Avoid a half-baked solution in the MDIO bus driver because

- it must reinvent the bus scanning to determine the PHYs and
- it must anticipate the right point in time (e.g. deferred PHYs).

Hence there is a need to inform the MDIO bus driver that a PHY is
being attached or detached. Provide two hooks in struct mii_bus

- notify_phy_attach(): called in phy_attach_direct() after PHY
  hardware has been initialized and just before PHY is resumed.
- notify_phy_detach(): called in phy_detach() right after PHY
  has been suspended.

Worth to notice: As of now phy_detach() is not 100% LIFO symmetric
to phy_attach_direct(). E.g. sysfs links are torn down before
suspend while being created before resume. Without reordering of the
detach function the above mentioned notifier placement is the best
possible symmetric implementation. For this

- Relocate code from phy_detach() into phy_detach_internal(). This
  naming was selected to avoid confusion with "unlocked" helper that
  usually start with two underscores.
- The helper takes an additional parameter notify_bus that decides
  if the bus notification should be sent or not.
- Call the helper with notification from slimmed down version of
  phy_detach() and without notification from phy_attach_direct()
  error path.
- An unconditional notify_phy_detach() was favoured [3]

Remark! A slightly different version of this patch was part of a
former series [2]. The discussion already showed that an initialization
hook should be placed somewhere late during the whole setup. This
commit implants it right after phy_init_hw() as suggested. On top of
this it adds the detach hook.

[1] https://github.com/openwrt/openwrt/pull/21515#discussion_r2714069716
[2] https://lore.kernel.org/netdev/cover.1769053496.git.daniel@makrotopia.=
org/
[3] https://lore.kernel.org/netdev/9e40f50b-357a-4a93-9f59-94847850835d@lu=
nn.ch/#t

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/phy/phy_device.c | 180 +++++++++++++++++++----------------
 include/linux/phy.h          |  18 ++++
 2 files changed, 116 insertions(+), 82 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..1a43fec022aa 100644
=2D-- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1734,6 +1734,96 @@ static bool phy_drv_supports_irq(const struct phy_d=
river *phydrv)
 	return phydrv->config_intr && phydrv->handle_interrupt;
 }
=20
+static void phy_detach_internal(struct phy_device *phydev, bool notify_bu=
s)
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
+
+	if (notify_bus && phydev->mdio.bus->notify_phy_detach)
+		phydev->mdio.bus->notify_phy_detach(phydev);
+
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
+	/* cleanup including bus notification */
+	phy_detach_internal(phydev, true);
+}
+EXPORT_SYMBOL(phy_detach);
+
 /**
  * phy_attach_direct - attach a network device to a given PHY device poin=
ter
  * @dev: network device to attach
@@ -1876,6 +1966,12 @@ int phy_attach_direct(struct net_device *dev, struc=
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
@@ -1890,8 +1986,8 @@ int phy_attach_direct(struct net_device *dev, struct=
 phy_device *phydev,
 	return err;
=20
 error:
-	/* phy_detach() does all of the cleanup below */
-	phy_detach(phydev);
+	/* cleanup without bus notification */
+	phy_detach_internal(phydev, false);
 	return err;
=20
 error_module_put:
@@ -1906,86 +2002,6 @@ int phy_attach_direct(struct net_device *dev, struc=
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
index 5f8d65868e0f..3d8afe6b7f1c 100644
=2D-- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -376,6 +376,24 @@ struct mii_bus {
 			 int regnum, u16 val);
 	/** @reset: Perform a reset of the bus */
 	int (*reset)(struct mii_bus *bus);
+	/**
+	 * @notify_phy_attach: Perform post-attach handling for MDIO bus
+	 * drivers. Optional and independent of @notify_phy_detach. Called
+	 * in phy_attach_direct() right before phy_resume(). Runs in process
+	 * context, may sleep and may be called with RTNL held. Must not
+	 * acquire or rely on RTNL. Returns 0 on success or negative errno
+	 * on failure. Must unwind its own state on error as attachment is
+	 * aborted.
+	 */
+	int (*notify_phy_attach)(struct phy_device *phydev);
+	/**
+	 * @notify_phy_detach: Perform pre-detach handling for MDIO bus
+	 * drivers. Optional and independent of @notify_phy_attach. Called
+	 * in phy_detach() right after phy_suspend(). Runs in process context,
+	 * may sleep and may be called with RTNL held. Must not acquire or
+	 * rely on RTNL.
+	 */
+	void (*notify_phy_detach)(struct phy_device *phydev);
=20
 	/** @stats: Statistic counters per device on the bus */
 	struct mdio_bus_stats stats[PHY_MAX_ADDR];
=2D-=20
2.55.0

