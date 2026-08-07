Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D8E277818;
	Fri,  7 Aug 2026 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122694; cv=none; b=Zd/+jIZvGtwFHBK3/cdRCGS5liuUsf53XXKZ4PkjFkt+dR2ddwGk9X156rbzJj6ImoYjkV1bv+EdsyArUv7D5/GyNjnKh4fHCNVuJzB68neys2cykJYZhN98r7qdBy0a8U3dA3wbzIsjpIQYjhs1diIlZPc3cabX5m77Zypeozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122694; c=relaxed/simple;
	bh=nNPpJ3jgJ4vZhS3npXKGNYuoRWuJPMaRt/U62ygLjk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=so0xlCe8x04HiIY4O/bai0He15WFp+Wqp4aJL/ZTvWPkAHzr6l4lb5d9n0tAjpopCtxO4DL/5fP5ZJDM9g+BwQwX3/rv2IgxTiuchmxJ7EBslQ1t/vZVWkw7J3avwpQATWxjTyCMSgsDg4CnPd/61oVIdR2cJuXub3wmADHFUV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=P3OKl6KH; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="P3OKl6KH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786122672; x=1786727472;
	i=markus.stockhausen@gmx.de;
	bh=k35fzHH3PkUCZPD9+NAIfJV1MZe3RheAlrYYUkwppgs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=P3OKl6KHcCfQT2AnzJRZUtNK7h+27LcLjiuis+TztuPVVrahgTDESn1WrDMoJVhJ
	 YzC6XLVmU0DPYl/yqLAU1i+v4Sf8OE9MgkvEbtmS5NBG9T1h4uHBKTbkxSpmLWXbG
	 JUPVueKcDPdocn5tDQ4xBf4GIBA4228hK6KUbEcKeLGfYziJh6WMveNPI5RGFlh6H
	 1JXZ+BRwDSVCJNm7o9G6n5VZ171+G4PXsIAw9b53uW2nUb3R14aHmH+J5p7zWF5o4
	 raeoUJgkzW6MTSgMqdoo0A6mVnOOW9dt/DUv88EeeqiLQm0El6Vptgx11v2RaHmg1
	 9fa78VKcTFvOKIaVzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6sn7-1wxqil0rfz-00zmN5; Fri, 07
 Aug 2026 19:11:12 +0200
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
Subject: [PATCH net-next v13 03/11] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
Date: Fri,  7 Aug 2026 19:10:50 +0200
Message-ID: <20260807171058.522833-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807171058.522833-1-markus.stockhausen@gmx.de>
References: <20260807171058.522833-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mM7/8JvtJ22PstXC/qVDk7t/1jEk3cViBECqZcIA/Hi0/0NwzMv
 KnI62v3tDZM3q6lJk0dwnX7L4k9+gZOWNQ6wZpkyiOEkw27s9HQ17gNTLgRiAx/+3e5fhDR
 t8iGzeACh5f0vS6XWN+oCP7b23CA/u1xtGnw4hwpo1aXTNBmvhMe0vLQm7taX07oG8qGhaX
 ekpKKb1OY3ySelKSHTnBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vz1dwYAuKJU=;xDIlt3a77C2tts+PMObWFqc+gnp
 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
 U6Fqz0Qhtw33AXAJTDhdp+Ok8Luz0Pl

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

