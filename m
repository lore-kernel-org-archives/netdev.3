Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793249906;
	b=asSoLl0neKeHDHO5izm0Tef/yYVAMRjQ6q4ryJq29kreaR3YB31h/ROLrB2HI9zJpX0W
	 t0KpazreKy+73QeADU5vKTRvoIjvQPbs5mIavSm2pNSxJQHJvGR2UL/AnWJNKeNg/d5tL
	 Gsg7j60WVxAt0q8LlOcBkARxOcZh6wzS8Dde3iOlw4EfBa6yX86nC7zMIxdQhGUZ5GsTm
	 Y5bec3xJjrtjzVoBurrGwGW/PodKRqhGiE/5id2cTvs+EUTY1GREEc21t+3y1M/pWusHi
	 YcHwIRsKiKxlF4Ijvmvb8hnA35htUROOR+lPQyUwsM1+qfvVNt2rMYdgxw/QgJw3lvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249906;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hGj9xNbM2GFslo+ZFYRgCXDmsxZkpM82Vucp42K6W14=;
	b=Jc163j4OkbZMProoNZ0DgvJ3sjHj0TUNEdTeE/tDwRSwwNOM8ONtHcOMajqBMZzAgZgs
	 L5vWrEa8u4dHxbtf5wRCLBrLhFDJb6tP+3FrO4uCkG89UD5SpJz+pH+EDDOvhTrIeVGj6
	 LF9BZ7c8fiujk7PZrYyr3TA8Oxjfhd80sW6ubZZ0W2GRhXnzp0uqco6U+VXtLnUUruU7H
	 oAsKA2cVrBgLLvGIFNEO7JnWcU3AN6RP1Qtm9Hs6uFKvppLc6zS2+9qBvJpkrGSvSUsvI
	 wI9cTG5SPpHAHHfBxLQa7gOZ3BQy8ZAKJdqd6GrG7Ox54tgHkvRVUmzzvByZYfMeIWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GM76O1Po;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053D606A31F;
	Thu, 29 Oct 2026 04:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GM76O1Po
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793249906;
	b=hnEPWLyK1skOTMfJeDIF30O1Kgr2riEbwpsg7zkEUipJ3ei35jYI1wULvAvBeSKLkPJR
	 viU1CbkyQQAZvXACUPExKOL2BU5y1IYm4Qy3c+Ro6vafVTORVk7j9tTUo0YDZCArqYFRZ
	 FkiBrUGUFfV32Q2d+C2XEH1xVRtWjPXeC1247EzjlxeyMz7NxXCD1yNPKjjXDDG4sEeiP
	 PBxhIQ4fX92y3dQ1yXwtepPOvPVLBJvA6MtVYrXHzY7kVfhhd1RoLZQtQSPc7xzV7CRI1
	 HSixv/KAKgVvbhwVCsLh/LFDLA5bOesZrghCSrOOFAPJJxEz1iiXwVk5/p1cspOUJZA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793249906;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hGj9xNbM2GFslo+ZFYRgCXDmsxZkpM82Vucp42K6W14=;
	b=RzetP4edLDSvLZ4eXijqolG8jGzrmqDejPhCQ0H2+cgDrPDIxY+8YJbc3/F7LP+ONmWW
	 fp/+TAPOLI4Op3Kwkenly51R5MhUWAtREtFhiXmCmW+1aRDLg4jwRL8/I66e6S1fEPus1
	 tGm0v7sMJEk0fovahVjutl9X8UsGwUOLHYioVwIY41L9tFzeVEerF/7AWOur45VH0j48h
	 HzfKI9XqW/snnR7aDBauPYvotAwF6dANlBhVuggEjpdOdaWQoJYgaTgDcgduHYNAbu94V
	 UjZhYzyKwhLwb1OCdRfduMzAF35KkfTzL7PdsTde24TJsb7RIh9ObuzAAXJNOzqNW4g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2E5471F01829;
	Thu, 29 Oct 2026 04:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793249906;
	bh=hGj9xNbM2GFslo+ZFYRgCXDmsxZkpM82Vucp42K6W14=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GM76O1PosO3kScH9dR4qIS+DSwPUQ7f8E19L677yQ9NAzxzXx2MNd2Uec9AmpLdR9
	 uJ0x/lT8kX64pZnLQ93i6txV+KOURiFPio9FN7kzZGQqTT/XjnBlD3aVOzGA6D0OBx
	 qbSg2cjUf5Ddj1LutQfdj/OXXEMCHfdoNrOH1+PAkb6mIeQEMEmQ7PUSJffWqI+/ib
	 VZxK5patpz2Uxm1ivJ82QFiMAFlbQZyo7Amp2dTfssTnNsdNIcBMUM7D1ypR86eExm
	 rm/jric32JZ+00yB4LY/rwIm5QfpxR0rT/lfl5umZmtsmhoRIfhxm/KmYaiEson0jU
	 zjaB7KBBq2woA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B644C45712;
	Thu, 29 Oct 2026 04:58:24 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Thu, 29 Oct 2026 04:58:22 +0000
Subject: [PATCH net v3 2/2] net: phy: postpone PHY interrupts during sleep
 with MAC-managed PM
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261029-b4-phylib-mac-pm-irq-v3-v3-2-5907045f3210@iav.lv>
References: <20261029-b4-phylib-mac-pm-irq-v3-v3-0-5907045f3210@iav.lv>
In-Reply-To: <20261029-b4-phylib-mac-pm-irq-v3-v3-0-5907045f3210@iav.lv>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Lukas Wunner <lukas@wunner.de>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Wei Fang <wei.fang@nxp.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Paul Barker <paul@pbarker.dev>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Doug Berger <opendmb@gmail.com>, 
 Thangaraj Samynathan <Thangaraj.S@microchip.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7353; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=0jzCIm6lJ2Yfq40Vke+VWeHqxr3HXaFj0zXIYFJcMKg=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFmPLuW7t64JS/wouEtVRsxlgreRyNKEN4Ephcl5wn4+i
 1mqRV06SlkYxLgYZMUUWSYc0riVseTqX38P8wcwc1iZQIYwcHEKwETaehgZ9jknf1te5tCpZLJ6
 6/6eV8o8fuazu6Zn+n/QesbXLbZ8MsN//y9/tsetfy2x5ts25waGq0nFbwt0+mLy0x5x6R6+WFr
 DCAA=
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

mdio_bus_phy_suspend() and mdio_bus_phy_resume() return early when the
MAC driver manages PHY PM, so the PHY never gets irq_suspended and
phy_interrupt() runs the PHY driver's handler at any point of the sleep
transition. If the MAC driver powers the MDIO bus down, the MDIO access
in that handler can stall the CPU. This happens on both sides:

- suspend: the MAC's suspend callback stops the PHY, the link goes
  down, and the handler runs while the MAC powers down;
- resume: resume_device_irqs() re-enables a pending interrupt before
  the MAC resumes.

On Helios64 (dwmac-rk, RTL8211F with its interrupt line described in
DT) both hang the board: the handler reads INSR while the GMAC clocks
are off, after rk_gmac_suspend() or before rk_gmac_resume().

Set irq_suspended for these PHYs too. The PHY device is a child of its
MDIO bus, so mdio_bus_phy_resume() runs after the bus is back (with
stmmac, after the MAC) and replays the postponed interrupt then.
phy_suspend(), phy_resume() and the state machine stay with the MAC
driver. An interrupt in that window signals a wakeup event only if
Wake-on-LAN is enabled: the MAC powers the PHY down itself, and the
link interrupt that follows must not abort suspend just because the MAC
device may wake the system.

MAC drivers that close the interface in suspend free the interrupt
before the PHY resumes. The PHY is still reachable there, so
phy_free_interrupt() stops postponing and re-enables a line left
disabled by a postponed interrupt before it frees its handler.

Tested on Helios64 with 7.3, s2idle with the link up:
- no Wake-on-LAN, GMAC clocks off in suspend: 10 of 10 cycles suspended
  and resumed; without this series the same test hung or reset the
  board after the link went down 10 of 10 times;
- MAC power/wakeup enabled, no Wake-on-LAN: 3 of 3 slept;
- Wake-on-LAN in the PHY: a magic packet woke the board 3 of 3 times.

Fixes: 1758bde2e4aa ("net: phy: Don't trigger state machine while in suspend")
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/net/phy/phy.c        | 19 +++++++++++++++++--
 drivers/net/phy/phy_device.c | 44 +++++++++++++++++++++++++++-----------------
 include/linux/phy.h          |  5 +++--
 3 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 9af303d60bd6..c3863a72a5da 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1421,12 +1421,16 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 
 		if (netdev) {
 			struct device *parent = netdev->dev.parent;
+			/* Without WoL, a MAC that manages PHY PM takes the
+			 * link down itself: that interrupt is not a wakeup.
+			 */
+			bool may_wake = !phydev->mac_managed_pm;
 
 			if (netdev->ethtool->wol_enabled)
 				pm_system_wakeup();
-			else if (device_may_wakeup(&netdev->dev))
+			else if (may_wake && device_may_wakeup(&netdev->dev))
 				pm_wakeup_dev_event(&netdev->dev, 0, true);
-			else if (parent && device_may_wakeup(parent))
+			else if (may_wake && parent && device_may_wakeup(parent))
 				pm_wakeup_dev_event(parent, 0, true);
 		}
 
@@ -1507,6 +1511,17 @@ EXPORT_SYMBOL(phy_request_interrupt);
 void phy_free_interrupt(struct phy_device *phydev)
 {
 	phy_disable_interrupts(phydev);
+
+	/* The PHY is reachable: stop postponing, and while our handler is still
+	 * registered re-enable a line that a postponed interrupt left disabled.
+	 */
+	phydev->irq_suspended = false;
+	synchronize_irq(phydev->irq);
+	if (phydev->irq_rerun) {
+		phydev->irq_rerun = false;
+		enable_irq(phydev->irq);
+	}
+
 	free_irq(phydev->irq, phydev);
 }
 EXPORT_SYMBOL(phy_free_interrupt);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 79dba43d703a..7d1486185070 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -336,18 +336,20 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 {
 	struct phy_device *phydev = to_phy_device(dev);
 
-	if (phydev->mac_managed_pm)
-		return 0;
-
 	/* Wakeup interrupts may occur during the system sleep transition when
 	 * the PHY is inaccessible. Set flag to postpone handling until the PHY
 	 * has resumed. Wait for concurrent interrupt handler to complete.
+	 * This holds when the MAC manages PHY PM too: an interrupt can still
+	 * fire while the MAC has the MDIO bus powered down.
 	 */
 	if (phy_interrupt_is_valid(phydev)) {
 		phydev->irq_suspended = true;
 		synchronize_irq(phydev->irq);
 	}
 
+	if (phydev->mac_managed_pm)
+		return 0;
+
 	/* We must stop the state machine manually, otherwise it stops out of
 	 * control, possibly with the phydev->lock held. Upon resume, netdev
 	 * may call phy routines that try to grab the same lock, and that may
@@ -364,13 +366,33 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 	return phy_suspend(phydev);
 }
 
+static __maybe_unused void mdio_bus_phy_resume_irq(struct phy_device *phydev)
+{
+	if (!phy_interrupt_is_valid(phydev))
+		return;
+
+	phydev->irq_suspended = false;
+	synchronize_irq(phydev->irq);
+
+	/* Rerun interrupts which were postponed by phy_interrupt()
+	 * because they occurred during the system sleep transition.
+	 */
+	if (phydev->irq_rerun) {
+		phydev->irq_rerun = false;
+		enable_irq(phydev->irq);
+		irq_wake_thread(phydev->irq, phydev);
+	}
+}
+
 static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 {
 	struct phy_device *phydev = to_phy_device(dev);
 	int ret;
 
-	if (phydev->mac_managed_pm)
+	if (phydev->mac_managed_pm) {
+		mdio_bus_phy_resume_irq(phydev);
 		return 0;
+	}
 
 	if (!phydev->suspended_by_mdio_bus)
 		goto no_resume;
@@ -393,19 +415,7 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 no_resume:
-	if (phy_interrupt_is_valid(phydev)) {
-		phydev->irq_suspended = false;
-		synchronize_irq(phydev->irq);
-
-		/* Rerun interrupts which were postponed by phy_interrupt()
-		 * because they occurred during the system sleep transition.
-		 */
-		if (phydev->irq_rerun) {
-			phydev->irq_rerun = false;
-			enable_irq(phydev->irq);
-			irq_wake_thread(phydev->irq, phydev);
-		}
-	}
+	mdio_bus_phy_resume_irq(phydev);
 
 	if (phy_uses_state_machine(phydev))
 		phy_start_machine(phydev);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 0e0066186ba2..bb62a80d6a30 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -649,8 +649,9 @@ struct phy_oatc14_sqi_capability {
  * @mdix_ctrl: User setting of crossover
  * @pma_extable: Cached value of PMA/PMD Extended Abilities Register
  * @interrupts: Flag interrupts have been enabled
- * @irq_suspended: Flag indicating PHY is suspended and therefore interrupt
- *                 handling shall be postponed until PHY has resumed
+ * @irq_suspended: Flag indicating a system sleep transition in progress, so
+ *                 interrupt handling shall be postponed until
+ *                 mdio_bus_phy_resume()
  * @irq_rerun: Flag indicating interrupts occurred while PHY was suspended,
  *             requiring a rerun of the interrupt handler after resume
  * @default_timestamp: Flag indicating whether we are using the phy

-- 
2.43.0


