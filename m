Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46303361DA9;
	Fri, 31 Jul 2026 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478477; cv=none; b=RlmOuBvKetSlKoXyKnlZtoq4JEBl3zUdwdAbj8RiTyLih1BnAw0WzU/wlhGOOWaUoVQ0HbspA5VaBeR4e+YainG2sp7TzSfb/hMCzpyWLuJQJ35WnBXLoew0TWdGcy22yBAiZSZXguN4/5OSs2SX8YGXxF0aEentESf3IzOzJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478477; c=relaxed/simple;
	bh=fdycObyi4RhYYWfQiewGw3wo2q/jfCeyYprabZjAP/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdr7AJT/RKz9VvvOx/gu4Pq4n4zH+AI0cakJa2BW1ziST7TNCcE+3Wjwb8NkCKlt/jWRk2GPq3PgbeGeHKtgRaFVtO1J5bQWKy8F8+wT380NRsI6l+/mh1WVvuUf9TWZW5sICD28YgaF7xPko5Ed4hw1JGy6CNnVQUjyG2G9mkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=YvNvOHSw; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="YvNvOHSw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785478454; x=1786083254;
	i=markus.stockhausen@gmx.de;
	bh=JgvYAuDBoTeJJ+4JSGV1AhTCrex9Rsq2wl13hL1L0SQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YvNvOHSwKHtEP6494qoquqXquyGIPD2G7lwfxQ6QPrQWRZRzajhS5W35WyVdElQ6
	 vBnHGMlnV2bhbYdh++7mE7xvLubrg1nlrPvaj48gULz7/wA5TlXn7DDCExCiHC7Jl
	 /zAMmS1+s43ZkZOxz0j+T9Ax2MhdhNCiYcGZhjUIJfrZpOxzcdV6wzV5lE/YBCNBR
	 6QlsynUEMnCO0Rw6dfShmqcrgLSB8A0tQjEzLHMuMgbwj9K5jFf7Fg24p/L4aKOek
	 lulx7bDkHkoMrIYT+zVm/o77NyvCI/E36MIAyfBRrDs5Ro6MeIHvtLqE4X/pFqwle
	 NJ92ELnMLOBq9fF0Rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpNy-1xPZYa1neM-00bZwd; Fri, 31
 Jul 2026 08:14:14 +0200
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
Subject: [PATCH net-next v10 03/10] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
Date: Fri, 31 Jul 2026 08:13:53 +0200
Message-ID: <20260731061400.78301-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731061400.78301-1-markus.stockhausen@gmx.de>
References: <20260731061400.78301-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MBYgLdQJB9AwpbOdIhoxpEJF00AodilitkmwpEMrWDD2/G4ddvJ
 HuHCfggg0crmgRpvpdcyl7G/A5iaWkEM+n7cSb9cyUjSrcwnFMfgnEHLWEchB+wPpGlDcGC
 CavOG9trMuzijgFIzAPcUF0qN8fzvfQ3hY5YmNq+tNQ/zvSk/WX+y6lWVRWnfjllat+ZE9q
 fLATRl/Tqbwy2jjI+XKbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jDz6vTQGHMs=;I+wAZZ1CKo1QKGebCok/np8N+nF
 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
 U2qCkeO4b4BzmZog==

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
 include/linux/phy.h          |  18 ++++
 2 files changed, 116 insertions(+), 82 deletions(-)

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

