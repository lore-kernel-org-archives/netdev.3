Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A43448391;
	Mon, 17 Aug 2026 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984021; cv=none; b=XOicVHWMlpkjfzii85v5HrPFifvT0xKWEdek69pmIugiGVKB7Bym6CGZJkjiXmqd8ov6e9pHQ2U9Ii2ackA7Cb6YDtW8bw0hlo4l7ay6ra+7o2/16PNiqrdxu0HE0oodeNDZuTMJCI9yJKsauYoTVbEHu9CFsBXRYLKzcALLJ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984021; c=relaxed/simple;
	bh=oLsLdPlHRnXV8c+LulySypEk1AwdDuB8a9aElPgQBk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lov3hbaxVwP0OvasFl6YneqlcJSkENJsEp2/HPrHLAcEVl/3EbLGOa9KR9WUY8pEAhFfFigJILmkLLz101P8j+99KTzdrFLt7CFhkOFDk4B/X2211SgzIkZH1TF6drlKhO56V6MvQ29uo+DdYCHW11+jfN8J++UkVpFPa/X+1n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=hRCE+/ZL; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="hRCE+/ZL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786984010; x=1787588810;
	i=markus.stockhausen@gmx.de;
	bh=ckXcvevd3PcHVmGbTOuVB6JyvNplPo4k9GsbZtdeLFc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hRCE+/ZLg5TA6iyvJVl+4PbWix9hLWV1zaCQyNe9dLBT/W5xrRQhVVCV+C4jbz35
	 9zlyyy4Q9dy0azifjBFS90GztJGDrvPysBmrDfOJrsaNFVZyYjzHou5H5PQaroT+o
	 LcUvgvShRCezauUC86M6XD8tlZwKgS+GYi4tfB8efTvUGe2GOCsJCgNxajlstKOWm
	 hQvIOx36kC6SNMzdJ1AETHwCKsZ83iZrejtqiOIaF2Qfslos4+XP03r6L8y6HI6gj
	 Vj8kB6aOvRhvWQs5GrL1PfS9yVXpCAcddVdYghcpg7jxTHC9A5RLNLBZFgNoZ16ah
	 SiDx9vyVmtWMJuZ1Fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42jK-1ww0Ak2400-008c1c; Mon, 17
 Aug 2026 18:26:50 +0200
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
Subject: [PATCH net-next v14 05/13] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
Date: Mon, 17 Aug 2026 18:26:24 +0200
Message-ID: <20260817162632.1208891-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N8VoO8Me8+p5c5H2VkkhAEQW3f4y64KWXfIkCnlX9N7Wxors5du
 SwIe5VZd2WQG9W8BUfkrRsNOVJJQP+wRXXnt+gotalDymnZRCv1Oz9RYG2KBXeL8rz668kv
 psbP9Vp/QH0kGt2OpJv5CZcJCOJVKpfi7A9gO1ObJIRcR6pMRoSTspodV9C9R6j/mPGcWNl
 9ty+kfUWkQt4U07PDgAng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cqr+sFSAhS0=;vwm/oSgZbEzhRgSCZ+k+dDqFAEv
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
 drivers/net/phy/phy_device.c | 19 +++++++++++++++----
 include/linux/phy.h          | 18 ++++++++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 835d71306b4d..1a43fec022aa 100644
=2D-- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1734,7 +1734,7 @@ static bool phy_drv_supports_irq(const struct phy_dr=
iver *phydrv)
 	return phydrv->config_intr && phydrv->handle_interrupt;
 }
=20
-static void phy_detach_internal(struct phy_device *phydev)
+static void phy_detach_internal(struct phy_device *phydev, bool notify_bu=
s)
 {
 	struct net_device *dev =3D phydev->attached_dev;
 	struct module *ndev_owner =3D NULL;
@@ -1756,6 +1756,10 @@ static void phy_detach_internal(struct phy_device *=
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
@@ -1815,7 +1819,8 @@ static void phy_detach_internal(struct phy_device *p=
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
@@ -1961,6 +1966,12 @@ int phy_attach_direct(struct net_device *dev, struc=
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
@@ -1975,8 +1986,8 @@ int phy_attach_direct(struct net_device *dev, struct=
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

