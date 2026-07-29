Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125A24EA395;
	Wed, 29 Jul 2026 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340996; cv=none; b=Unk3K2AavMR4w7K+2nqcRd3H//w6NZzFS1DbsVSpr9x7Y8xW1EtV8IWVTAffor46dwAvS9thkdhM4CHAzOvNnpA/v4d416dc03itEPLnJkSmRUgGdYWIHNLaOozWRYhBZQMoE+EsmBTmeg8miqKxxQ9JrfT1yfIDAkf24DfLPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340996; c=relaxed/simple;
	bh=fdycObyi4RhYYWfQiewGw3wo2q/jfCeyYprabZjAP/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwMjiT3aJaiaxfHaxxU/puSiR4F0AS3+TObLR5vs3esdh78pYAJtUM9g0uXiC4we+5uFyRqya+5KEmGtlJbvA/A06VE4XrscgKuAvDyB70cWh8X5gVuNcUIQyzVmf9YrebgKns6G4O3dkElVeMgUlkZZ3E5M7HGL3I93JTTyI70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=KfWpt9wv; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="KfWpt9wv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785340966; x=1785945766;
	i=markus.stockhausen@gmx.de;
	bh=JgvYAuDBoTeJJ+4JSGV1AhTCrex9Rsq2wl13hL1L0SQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KfWpt9wv8njPS0chpFeeavKRcwR1yPGnJenTDqT9i/PVsQ/m37BYkPHklsr4KZxL
	 JI5sjeyiWI83U/ot+gB49f6hPpZ1wNeocEgBOqPAwMnLV2QGEvLQV/apB3c7gelNe
	 xSBRr6mVajq2RIwPc+B0gd1ns+x5Z6PlRQOL2Wvvmol0CpWkuBqdDjtQOn9rmnWmb
	 miA/dbOyo2lwdXt3RbxLExwd/QMTtCY1J78qiWvI1vDtLVpQ65uW8pXULcSRZwOPp
	 BwY6/4yLyABt1M4OyxyamzEDDgt0mZSh3smnQSW+vNmy7/LFUDXOnx+vzmR3AcJeR
	 VnFqFhKav1Tw2JAh9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUZ4-1xIvmM0tvI-00ep4h; Wed, 29
 Jul 2026 18:02:46 +0200
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
Subject: [PATCH net-next v8 3/9] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
Date: Wed, 29 Jul 2026 18:02:21 +0200
Message-ID: <20260729160227.155613-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729160227.155613-1-markus.stockhausen@gmx.de>
References: <20260729160227.155613-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uGRtrblFPAegXOHkxQHVMMAGqeAiPm98+Z94/FjaT018KXuPftz
 RMip0V21HbstDkLpUjXAI+RGteLVXNLtoEpj5LK4DP7W6f4gGqI2VDzRlWimkF8ZX8iccMM
 v466HjxADh8Iug6A4wpMkugAwtldZ1Sdx0PRDdzB+uxj+Rgw+erutJU/bRwpLTVgLz0WkXd
 BZAzgbINrAOdbgJo0tAag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QMdq3AiM2nE=;+TlnHZhRUBvEhxwxe8Sw0QSDAVw
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

