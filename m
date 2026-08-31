Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE084A2A44;
	Mon, 31 Aug 2026 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186911; cv=none; b=gYjaDjRS67uPk77pcgbMuMBSKiy/uE7GE/risYfL0Ggn2VE0AKPF8CYlgR0pMzRxkrQXsTSEhQ+BygzdWYNpy/FnTLvX0b+rTMGCEscLntGhw2uPNb31V5gF5EekkK/aesorPengeDB5uia94HiP3Hr+eVkfXGSDh/qrzYAFOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186911; c=relaxed/simple;
	bh=khWR67ud9+7KTtsn5KwDrhDXHINRjfLz7mFHM9RADs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYX7OCLJ5BGoBiJ7Aj8+bw+d0e5jVY+YnYfg7Lpfe2KMEiXjqqWny2z1RZCYo2t3LST0r6fKO3WdyylGoOYOaE/k7HjTV89UXpw7pej4LbWKo2DMy0JEH4YyzHB4r2CwRSKkNUmU+4TbuUia+Ue4vB4f051zFmwdZCccql3Zw1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=J0c9ZEk/; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="J0c9ZEk/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788186897; x=1788791697;
	i=markus.stockhausen@gmx.de;
	bh=UVebYqVvl0/4aB9xSeYzkX+77AKWyk+BTQ0VcqLAsGM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=J0c9ZEk/uhxH9S2KqMgiermTuGwBjiffaUCPrhG3sgwmecF3Ba+49OF6aVClkAgP
	 ti41+dqwVZZ9qhmHBc1UXrK2pYKkeCJTSnZ1X0LV4olli/orWhcavmBWII7jAwkIM
	 DIIMsOS9yns+6+M3nkUedCju1TY0fYOhUDizWZ2gj7z/MwS92+asrgkQbThrrS3hL
	 0wvTVziBV71EERvICvL0/Ph0E4tZfiYQnc/5gOWKkQAqAxXF1GY8ldMvQ48ABec7h
	 X0dQhHw1/ux7bgx4MkTtt5289LHoaz2AxEMOLurVORp5ayZ3p1U3y6dgjqVOVmeHH
	 0FSZWtUYG9c0Nrj54A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2mFi-1wtKST1nTg-014Edk; Mon, 31
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
Subject: [PATCH net-next v15 05/13] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
Date: Mon, 31 Aug 2026 16:34:31 +0200
Message-ID: <20260831143439.2404484-6-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:OfX1BUpoLO+zoIhYyAs4QxHCw4rSkKIY+E1RQ66Z6VP2yL6PWGs
 6LN2P6jdi2DZp3/N22DCXcmPZZ0PBLfOsSHmYkfMVFNOAw1WH07YVOxliBtaROuduK1+lf4
 Vj2MKwTB8i9osCQAQufNmAG1fGB/LxVEbmUDeDtp/L2fyTgJhlbzZ0i2zXdFI9zgDoLEAkR
 iBHlumdNJ1jMGoAZkQ+Fw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ajWL8S/hgVU=;C76NmurardZ4d2KBnydNwDddI+J
 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
 jChN3CyUK2tDO79CA2PoQaLV8q9LI0B2Oaiw==

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
possible symmetric implementation. An unconditional call of
notify_phy_detach() was favoured [3].

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
 drivers/net/phy/phy_device.c | 20 ++++++++++++++++----
 include/linux/phy.h          | 18 ++++++++++++++++++
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2827d2226d6a..de59d864b060 100644
=2D-- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1737,11 +1737,12 @@ static bool phy_drv_supports_irq(const struct phy_=
driver *phydrv)
 /**
  * phy_detach_internal - detach a PHY device from its network device
  * @phydev: target phy_device struct
+ * @notify_bus: whether to notify the MDIO bus about the PHY detach
  *
  * This detaches the phy device from its network device and the phy
  * driver, and drops the reference count taken in phy_attach_direct().
  */
-static void phy_detach_internal(struct phy_device *phydev)
+static void phy_detach_internal(struct phy_device *phydev, bool notify_bu=
s)
 {
 	struct net_device *dev =3D phydev->attached_dev;
 	struct module *ndev_owner =3D NULL;
@@ -1763,6 +1764,10 @@ static void phy_detach_internal(struct phy_device *=
phydev)
 				  &dev_attr_phy_standalone.attr);
=20
 	phy_suspend(phydev);
+
+	if (notify_bus && phydev->mdio.bus->notify_phy_detach)
+		phydev->mdio.bus->notify_phy_detach(phydev);
+
 	if (dev) {
 		struct hwtstamp_provider *hwprov;
=20
@@ -1822,7 +1827,8 @@ static void phy_detach_internal(struct phy_device *p=
hydev)
  */
 void phy_detach(struct phy_device *phydev)
 {
-	phy_detach_internal(phydev);
+	/* cleanup including bus notification */
+	phy_detach_internal(phydev, true);
 }
 EXPORT_SYMBOL(phy_detach);
=20
@@ -1968,6 +1974,12 @@ int phy_attach_direct(struct net_device *dev, struc=
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
@@ -1982,8 +1994,8 @@ int phy_attach_direct(struct net_device *dev, struct=
 phy_device *phydev,
 	return err;
=20
 error:
-	/* phy_detach() does all of the cleanup below */
-	phy_detach(phydev);
+	/* phy_detach_internal() does all of the cleanup below */
+	phy_detach_internal(phydev, false);
 	return err;
=20
 error_module_put:
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

