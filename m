Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830161E32D6;
	Sun, 26 Jul 2026 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050293; cv=none; b=l0vNBb8g/FLhf2DXy2k0GhnQi7g7euXv+AuYTkm6bT4p99j7CLWTFeqQr/RjGGvy833u/NXK5mhkBC/p+RnREB16YeE7L8n3ydkJin+Mvvk287TMl/M/b53+3qQQk/kdprzM7Jw/DFLYSgdT8ZI3oWrGTVZK9u216WnX/mdsiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050293; c=relaxed/simple;
	bh=OYjl+hBb8YBf7OJwpPXz3L7vcRYDIP9+BH5voLpjG9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3DnRik1+fr0v3+1Y/9j/7HE6fG2X362JCNKBuFjeTI5fXF7/jR9g6se1maSawUFaTniy+tAVwpTRNVcNOoAlmvLPxftfzEeQFyMkP91wJ2qFbmkcPn0sMzh0t2kZbFcwaKRWPsT8TJ4qbTaHSYF+HjE3S+23YJ9DUrDVNGaSwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=E69MhmSD; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="E69MhmSD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785050288; x=1785655088;
	i=markus.stockhausen@gmx.de;
	bh=eEvkSkfsAmKcie4IwQhUor4c+KrLVJxhnMNxehEcHB4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E69MhmSD975V3ScoG3gXXcKCpJgW/KS3YDH3vELzIbuoUCh0vKPG1gkNtoW1IGX3
	 o0gvqNwvkpzDYJiqOxyzxJvsXDJEA2lTpSps584J+LInSqSOOcieQWj6/yBEbIj3r
	 Dgfu6wohlE/zeIt7hnGqEABKa7hvnPM+UoYuGH6+IWaQRLNBv84duRIrEFEawDceC
	 5cdZWblxsKxOjvMo6FkzLFS1eDP8QkHdkID3lQE1APQejIs8fBKds0kEIQkq2J91i
	 7+33XjG5X3MBq9zs9UjCGjRzItsju9ezSDCU/y4ouLyENAKUAuHtd8GXrlRC0fmJW
	 m3SWjkwEByl4MiBWeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9uK-1wWuVG1w9q-00Wn7U; Sun, 26
 Jul 2026 09:18:08 +0200
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
Subject: [PATCH net-next v7 3/8] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
Date: Sun, 26 Jul 2026 09:17:46 +0200
Message-ID: <20260726071751.1359156-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726071751.1359156-1-markus.stockhausen@gmx.de>
References: <20260726071751.1359156-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kLwHIUqmsJC4e4+YpN1Kxga3lconh49OR0KmWtszF9tHThy3I4P
 jXzsqAu39unCKNjs/yyaquGUuGr7MDTZdPSANmeMoHgpGErngeIL156Ibkysmb775rakMv/
 nf3worVqBDcvtSZYwwBZbk3BT027ao/t7qEUropQShhm6JyUjkqSb0I8MeV/ZWs5d6hEgAp
 QVK2c+xGGyA84BzfRPg1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xN7X98pF7Ug=;1Q85x8lWL/5MTk4+TmKVwWtRbVV
 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

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

- notify_phy_attach(): called in phy_attach_direct() after PHY
  hardware has been initialized and just before PHY is resumed.
- notify_phy_detach(): called in phy_detach() right after PHY
  has been suspended.

Worth to notice: As of now phy_detach() is not 100% LIFO symmetric
to phy_attach_direct(). E.g. sysfs links are teared down before
suspend while being created before resume. Without reordering of the
detach function the above mentioned notifier placement is the best
possible symmetric implementation. For this

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
 drivers/net/phy/phy_device.c | 180 +++++++++++++++++++----------------
 include/linux/phy.h          |  14 +++
 2 files changed, 112 insertions(+), 82 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..233622e9ba61 100644
=2D-- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1734,6 +1734,96 @@ static bool phy_drv_supports_irq(const struct phy_d=
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
+	__phy_detach(phydev, true);
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
+	__phy_detach(phydev, false);
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
index 11092c3175b3..71405283bc6e 100644
=2D-- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -376,6 +376,20 @@ struct mii_bus {
 			 int regnum, u16 val);
 	/** @reset: Perform a reset of the bus */
 	int (*reset)(struct mii_bus *bus);
+	/**
+	 * @notify_phy_attach: Perform post-attach handling for MDIO bus
+	 *   drivers. Called in phy_attach_direct() right before phy_resume().
+	 *   Runs in process context and may sleep. Return 0 on success or a
+	 *   negative errno on failure (which aborts the attach sequence).
+	 */
+	int (*notify_phy_attach)(struct phy_device *phydev);
+	/**
+	 * @notify_phy_detach: Perform pre-detach handling for MDIO bus
+	 *   drivers. Called in phy_detach() right after phy_suspend().
+	 *   Runs in process context and may sleep. Only invoked if
+	 *   @notify_phy_attach was previously called and succeeded.
+	 */
+	void (*notify_phy_detach)(struct phy_device *phydev);
=20
 	/** @stats: Statistic counters per device on the bus */
 	struct mdio_bus_stats stats[PHY_MAX_ADDR];
=2D-=20
2.55.0

