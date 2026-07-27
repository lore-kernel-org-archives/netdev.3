Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A13C4B68;
	Mon, 27 Jul 2026 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179790; cv=none; b=HFOoehAVBeSFfx120UlrxkJxyxt+JKqp7HfIgp+1Ghb0gwAEvAdES161lLpjznkPE7s0UOKVo3JKe3xbwRUlcNylwVHZjUnVoooMSwhO3aJbeffBZcbmeoLmrdl5Uy4YVSBy5XeYegXzTU6aY6VtoUsxnCoiJKOYsxOnP7qrJV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179790; c=relaxed/simple;
	bh=OYjl+hBb8YBf7OJwpPXz3L7vcRYDIP9+BH5voLpjG9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqTCrq91bklwhHLuPsl593FIgH41DBgTNx4ibvaRPeY6PQWJCv1N61x9P6N1hqG3pwgaf0bhbsWUbFFsbvZqfdkdmJOUoy7tGoNgx/8/YFVkJhvgAP7uuFUN22Sat8Gi1EHUt5sOOj+iNgUuRTo4zmYFl3FUXPMK/RCbIIw63GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=eIjjDph/; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="eIjjDph/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785179773; x=1785784573;
	i=markus.stockhausen@gmx.de;
	bh=eEvkSkfsAmKcie4IwQhUor4c+KrLVJxhnMNxehEcHB4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eIjjDph/kbVNKhRb+HjSb39bh+dzZy00P5k5tN8mPTq1TmEEWmUGeuObsAvkz4ao
	 GghJiyLM7HfofvEg/iOfEgWo5jLMc1DHN1+We1ccLsSIUwB1SSpbHvLMILSBarknw
	 s9Mk5pxUWM79np0k9Dmm16UH4DscfbiK+s6QrCXmUq01S8FlKQAUKtZKh9Vg/JCyM
	 16LKUkXkx8ZGhfGE9lpc9n0BWeAOWTgk9skxdbsihRwQlikaSaThKqbVaHlm7fOKo
	 pWhs/ovqX2sUHXc3dxgNHo8VZL6mnbaC8VGJQGxSOZMnydpZ5zo/Hvrvg9RLV8wYi
	 D5yATyWnr/bnA4RoUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1OXZ-1wyUdC0K6d-00z0GK; Mon, 27
 Jul 2026 21:16:13 +0200
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
Date: Mon, 27 Jul 2026 21:15:53 +0200
Message-ID: <20260727191559.19617-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727191559.19617-1-markus.stockhausen@gmx.de>
References: <20260727191559.19617-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y+uvDWTLiNuWIFn89KJV42Bl2B7bY/oXAQvkS5Kry+Y8AYTeCzJ
 tlapnAfX0mG1adxq/mrQcO8PTci+3yL/FRhiUfM9P4hAR8EpywnaY+w/eHgtXRDMqtvWyeb
 eyTdJav0j7IsOBhtVBWlql2ll3HAiDbXJeW/ooHjQfcLrnKisSrhyWV746DvmGSnPTSZfcr
 HhEleHqoVHyOAIKB6WRfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kQbcjdzoM6s=;pZyqTj42E5NCdT925WUulKwVwmj
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

