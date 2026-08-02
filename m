Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA203812EC;
	Sun,  2 Aug 2026 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659749; cv=none; b=aFkeKooZPxr6jHcsr6VPkfm00/hOc5lzW8sUOk08eysuiD0nwvsP62QVKSNgj1j646Z0JL8wA8YyIyROKw8tqRbE4T3vxOG7gWFHnf6kDZ2hEhfzsUzGAwZRxtL9D2xcrYD8nmxy5YPfh/3ORmetT6Tjf2mQpnbkhN3uSAT6pPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659749; c=relaxed/simple;
	bh=R26HaHyZQDCfcHigEZQ1V4jCbKdR+dIfv97FxcPxIyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIWmA5S8fkdnL4tUTezhg68PfDjvzRs6CzRpOLA6twC/5Bbcr2Lw7AIn98SPBb57X1+T9iWDjE444GoOMUTbaWeJKYm4DaQ42jytNgfP+yb6m9MtcsWK/z+5zBnabE69vLems+/AsnjX8+5oHnkwVYtEE8gzZ6Rb2o+G/TkIknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Ru8KFEv9; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="Ru8KFEv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785659745; x=1786264545;
	i=markus.stockhausen@gmx.de;
	bh=FcWABjFsU7Tv+TgFXgO6dSt98IOGwkregSZYqc0d31U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ru8KFEv972Jwj/VVpuv+AAgKoAWMueD2BPLTHlaeANcOUK8w0ZqZzfRmPNB2Vjhy
	 N/nxAHSLGP2O72UB5G5w7CKTc9tUcwjoBozPCyExuzgrzrTxEiAmuUNDP7iVNXFf6
	 /w3tFeiV5M7TH4vM08qQWPETUfC30Oxe1E4Laabuyxye0AGDdQusFz8FTVsiOVLPW
	 F5Bez46wmgTUyYeIJhFQEgCwUIWP+XE57dGU9Cd8pfFmI9pv3PuEHJWEbHyQHiyit
	 Neic+ygZa0YU+LzHi6X+P7w3OEMMNE3N0H9QvuNcB62FpijgT0XHcCh1PjGEe/9Yc
	 7ld8jdjClNNlxT/veA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNct-1xQ5Ta0ExT-00f9sm; Sun, 02
 Aug 2026 10:35:45 +0200
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
Subject: [PATCH net-next v11 04/10] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
Date: Sun,  2 Aug 2026 10:35:22 +0200
Message-ID: <20260802083528.490216-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802083528.490216-1-markus.stockhausen@gmx.de>
References: <20260802083528.490216-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wQ11k0bhxLGAIg8+1DLMIPJB353L3e/Ju91cxtGOdFk7PfsKYBQ
 kDTcFvmFRRk7Ld2r/SutK56E0kiQMSDsOriGpVOn3n8HgSJHyKfMKruQsKN78u7NI9Np4ap
 sU/bP2QKO9eD3rjGG+IarXywDwDOF61+YABEEPHD6KOTwjcwyARCrdNbW7CXjfGL/x1VJOI
 BLV/0klJ2tTj8L4XAmhDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hWHyUaBmuP0=;uZawmPWj7+mg4gW8xZ1TUClAj/Z
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
index 11092c3175b3..fef0c6a3e27f 100644
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

