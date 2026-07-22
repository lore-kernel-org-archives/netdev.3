Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B511C33F5B8;
	Wed, 22 Jul 2026 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701457; cv=none; b=fS01AJxbFeX3uuFC7TKBDRXrxpmeNoNh/X1AJy27K1/WMmBrmXQLOwKGl+NMhTSH+DTSxC4/qD9XBMhHfdxZaSWRzrU1owudnfikzdsVKRuHVTNbZJb8wd1ZbshmdnBaFHiKFVt0cdQIL6YZA2SmEh35DH469GlHXg+OF/ik8fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701457; c=relaxed/simple;
	bh=NMLftYZhvuRqipkPYyQZNYV+dAwIQUm/keCnKCTuPY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqsL4vGO7OInfW7PEXdK5ZHvg/82HpT2yqRNJzMbGttXxQglZpKh+aZOatPNP/h6+M21v7qY50HzNY0Ae4EdWsznfNjk7SDKS5ZIhQzUVAGANWj/krDwBChmHj2zm6GrcPWOGlrbkb5AZuBd3WsbMRQXNgv0q+6BBzr/jvcKNQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=E104/3SI; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="E104/3SI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784701448; x=1785306248;
	i=markus.stockhausen@gmx.de;
	bh=mfA3WiQfpPHeR/HWP6XsZzRCY4IekBYoJStSr7xpgso=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E104/3SImM0iaCcX6Ok8vIboSKwV5a+7qoh6wblD8Xd3Kslo8NHWTuJzjS5gC4MK
	 GlskRr+UyGhgZXY25loPc8C7fCAx2tYB5eeKo0B5djx9RHK2a3Vp4jMHn2yaQxTuC
	 I3ZdlOAV8swAeXimQNdagCosTyKHy0NHa5CZ/ahYCvZcmYf12LsrfBsKqK+j8NyIk
	 r7OErP3x2EB9xboM4TasqKLqaRFaOqEj+Tvw4jfnrdkRWmx37cBaa77BfvYkr9ywV
	 fZEEc2JBQ1kPeFowseFKUFwTaqntEA0jF7QIHRFbNKkNvfRZecfYG7scufWz2iFHv
	 E4iRotCglGasqyUsIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MoO24-1xJYHI1Oci-00nf2U; Wed, 22
 Jul 2026 08:24:08 +0200
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
Subject: [PATCH net-next v5 3/8] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
Date: Wed, 22 Jul 2026 08:23:51 +0200
Message-ID: <20260722062356.12291-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722062356.12291-1-markus.stockhausen@gmx.de>
References: <20260722062356.12291-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yi0QJjLF5/Xg/WCALYJ+AmXVwACALF7+RAwfv7BSF6ctmtGIY0K
 NziBFgGcTc5kCwTRGATe5QusCS+KbcKa4p5+gjzqFWmPZCKrgZWG4/SnTYABYywPhQYV3x/
 BC/Uou5fJe2OK3KwXkWP06Uq3gpFGsr4Fo04tYOt51HO89nvCf0v7oBfMGhErkgeoPhVk6j
 yKDJsxjyVEL3gmZ0pWBxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0y9AukyRYXM=;jlb56+Zy8fK3Og1C5t7vScKcdM3
 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
 oEX4M4SW0zh+hu0myNHFip74M1Hl46ldRA==

From: Daniel Golle <daniel@makrotopia.org>

Some MDIO buses require to program PHY polling registers depending on
the PHY type. RealTek switch SoCs are the most prominent example of a
DSA switch which doesn't allow to program MAC speed, duplex and
flow-control settings without using PHY polling to do so [1].

Avoid a half-baked solution in the MDIO bus driver because

- it must reinvent the bus scanning to determine the PHYs and
- it must anticipate the right point in time (e.g. deferred PHYs).

Hence there is a need to inform the MDIO bus driver that a PHY is
being attached or detached. Provide two simple hooks in struct
mii_bus which are called

- right after a PHY has been attached
- just before the PHY is going to be detached

The implementation is symmetric so that the detach notifier is only
called when the attach notification succeeded.

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
 drivers/net/phy/phy_device.c | 11 +++++++++++
 include/linux/phy.h          | 19 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..a62c2ff6c2aa 100644
=2D-- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1876,6 +1876,13 @@ int phy_attach_direct(struct net_device *dev, struc=
t phy_device *phydev,
 	if (err)
 		goto error;
=20
+	if (phydev->mdio.bus->notify_phy_attach) {
+		err =3D phydev->mdio.bus->notify_phy_attach(phydev);
+		if (err)
+			goto error;
+		phydev->mdio_bus_notified =3D true;
+	}
+
 	phy_resume(phydev);
=20
 	/**
@@ -1919,6 +1926,10 @@ void phy_detach(struct phy_device *phydev)
 	struct module *ndev_owner =3D NULL;
 	struct mii_bus *bus;
=20
+	if (phydev->mdio_bus_notified && phydev->mdio.bus->notify_phy_detach)
+		phydev->mdio.bus->notify_phy_detach(phydev);
+	phydev->mdio_bus_notified =3D false;
+
 	if (phydev->devlink) {
 		device_link_del(phydev->devlink);
 		phydev->devlink =3D NULL;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 11092c3175b3..2d30e087a233 100644
=2D-- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -376,6 +376,23 @@ struct mii_bus {
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
+	 *   drivers. Called in phy_detach() before device links and resources
+	 *   are cleaned up. Runs in process context and may sleep. Only
+	 *   invoked if @notify_phy_attach was previously called and succeeded.
+	 */
+	void (*notify_phy_detach)(struct phy_device *phydev);
=20
 	/** @stats: Statistic counters per device on the bus */
 	struct mdio_bus_stats stats[PHY_MAX_ADDR];
@@ -574,6 +591,7 @@ struct phy_oatc14_sqi_capability {
  * @has_fixups: Set to true if this PHY has fixups/quirks.
  * @suspended: Set to true if this PHY has been suspended successfully.
  * @suspended_by_mdio_bus: Set to true if this PHY was suspended by MDIO =
bus.
+ * @mdio_bus_notified: Set to true if post-attach bus notificaton succeed=
ed.
  * @sysfs_links: Internal boolean tracking sysfs symbolic links setup/rem=
oval.
  * @loopback_enabled: Set true if this PHY has been loopbacked successful=
ly.
  * @downshifted_rate: Set true if link speed has been downshifted.
@@ -685,6 +703,7 @@ struct phy_device {
 	unsigned has_fixups:1;
 	unsigned suspended:1;
 	unsigned suspended_by_mdio_bus:1;
+	unsigned mdio_bus_notified:1;
 	unsigned sysfs_links:1;
 	unsigned loopback_enabled:1;
 	unsigned downshifted_rate:1;
=2D-=20
2.55.0

