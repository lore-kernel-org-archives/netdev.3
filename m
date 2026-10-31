Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793433680;
	b=Kt9/Yyz0ms1gcF+U8AZ7SkNK14+Fwus3Z8qmqRBPiLnUKRK3Js3d6sSb1MEzvmGxm1Tk
	 10VqRj8SEOi+uZ/A4vgz3O0zs3Vzjqd22iGMhkfX5sZgVUnUDcpaLsEpUbZOnSzDBtoJK
	 4iYYpTCsXyJWTlG/Nit4NJNA6S/e+uI7odLXPlmOMKbeyHq9KnMADSoJwkA4bUX8lvuW9
	 oVeXi6lbo5T07L7ZaNuE+/YZKzF+IvD5v0SFNmnNzZk/a4YHljU41/uiZkVYE0gUl0QrI
	 0zDCE6mT0Wn7stO++IKoG5UovCQN3/ezD92v+Ky3odswlNvFDlwra48nyrfDXpTb5Eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793433680;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=B0zElpoMmDFgRpMlF/zQ5HPh8WxV1hAT1TBACJeKFmQ=;
	b=V6+dBHI6XF5v0NuGWDDsfsTTB852KT6NbHCZgHFSZ+2j9R71Z4xcQ9LJJvYxT2zrKn+d
	 cOSsLOv2cDp/ihinGOLdT2d4xHSkfadcsynqyKXjy3mqNSgu/pEv2genHYh89WR5SveNE
	 ZH4qKMC+RTOegiEyzFJdSKZ8wrr+eKgGWoek37qexl4hGc2jcL3D1n/PZ+xUzCfX94egI
	 3oEqeI7EWA2YOx4vbbjYwHxBIv92P3umrBYsM+WZ3zeZ5CLBYkZrJX4ZDlup5IFlE43tU
	 ZjuDhJiD6vtzXx2rCViYLjBMUWnRFzsqAjXbJIYFCf4B3KPzXz4vGoliAP4cGbM2FDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fIvbAowK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13724606A32C;
	Sat, 31 Oct 2026 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fIvbAowK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793433680;
	b=cyl4AzuW3ugBCgbjxwUo/nr9wPV0Y8UAiL05CA1MhxaNDqT6WIAkEZnBzhE/TqKu4AjF
	 25NivG4n+eMRb3C8CCqEcK3hFSEPShOk0NJvJmQmmyc2A5Sei1TmzyRlHA3HD0nyoINtG
	 9DFDtijUEqd1nHZL3iBwFOroCMyjAda2Okfi4XDW3Ut1Q58MVreGVPqIfQt9bS3V59NZj
	 IFuHyiyF3i+nQpIs6HHZFNAZVMmZsF+phfjS20u0tE+QNpsmMQQkm0kKvlzl/lbdcWxOu
	 uL758LqXgsUqrTO+zVFQ7Zc81OgFkwfZOGsmLjuszOwLvqp6qyINLxmNWVm9T75RJug==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793433680;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=B0zElpoMmDFgRpMlF/zQ5HPh8WxV1hAT1TBACJeKFmQ=;
	b=0BFnptqod+WAHqNQ53UjeUFikAEn9guy3A2YSSonBpOLBU3meCSIX2/4VdCXyry1lX7o
	 hOLd22lhPOvaVq07YOpjhMqUfX2CeRCupq1YykXxpBJ7n42FqCI2vF8lhyzkbwuY2Z7f5
	 KMAWwu7QzJrnIYqTKWh8j6utcSmV5xHe7755BsDTgNnrXneG3a8TWEKu/1NTc2/PxSmQX
	 pOG8as6d0iNsYCox+rNtB+7KjOfYN1seLA/++u1heVHP4MfkvZ5Jk9H7UCRDJTLo6/gLd
	 /CKTr7SGFUnKnJbUfPA3HaPcSMx8juB57/Na3f0MPdG5lB/DjHrxzQpsfbdbBKayo1Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 17D0A1F00A16;
	Sat, 31 Oct 2026 08:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793433679;
	bh=B0zElpoMmDFgRpMlF/zQ5HPh8WxV1hAT1TBACJeKFmQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=fIvbAowKOF1+dLD09O0DAeO1aaog/dLfz31fbjokOZlydgtLpwhC0p6vJYGVStjGs
	 SNDoJ6fWqWF8qQpP0t9S1o4dqBYzGJv1GwMYdGWrQS24xwGgprjnXTP4JhYjWQND3b
	 t5aQTom28u1gvQQuODOvfAV2Vb1JyQ+ilz8E0P48WYw2JiecfIs4599uX0VpTp6AB5
	 w8H10f13F0PZ24ge8PGXjMs/kSxl/ie7jTUojj8FXtKXyv2TM8FeGQEA0RUVE6Iaok
	 N4NuFQT4Be6RMGEBFrFLTwO62P56soy84S5txDDCbu0UcOawH7zFYRkqcx5svGyKAp
	 5Tg5s5oOEiHww==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8C15E45E5A;
	Sat, 31 Oct 2026 08:01:17 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sat, 31 Oct 2026 08:01:16 +0000
Subject: [PATCH net v4 5/5] net: phy: postpone PHY interrupts during sleep
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
Message-Id: <20261031-b4-phylib-mac-pm-irq-v3-v4-5-5ba23b3ff9a4@iav.lv>
References: <20261031-b4-phylib-mac-pm-irq-v3-v4-0-5ba23b3ff9a4@iav.lv>
In-Reply-To: <20261031-b4-phylib-mac-pm-irq-v3-v4-0-5ba23b3ff9a4@iav.lv>
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
 Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
 Shenwei Wang <shenwei.wang@nxp.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9826; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=GlPE3pa4DqG4h8I7fl50Q/gULjP8mQ+5tWHoRPvD1l8=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFlPF/iUfdi5KTjt7crS9cuNP/79bOw0S11354pbzjvec
 +gp37co7ChlYRDjYpAVU2SZcEjjVsaSq3/9PcwfwMxhZQIZwsDFKQATadBk+GfHcj1dqSn//sV/
 fbMP3LCx2DhputZhtda6Q2rLc2V3R3gxMrSt4P80zdHms9pOY69LnsfuHAkU64pWPHBQcm+QiJ1
 2NBsA
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
are off, after rk_gmac_suspend() or before rk_gmac_resume(). stmmac
has set mac_managed_pm since the commit in the Fixes tag, which took
its PHYs out of the postponing added by commit 1758bde2e4aa ("net: phy:
Don't trigger state machine while in suspend").

Set irq_suspended for these PHYs too. The PHY device is a child of its
MDIO bus, so mdio_bus_phy_resume() runs after the resume callbacks of
the bus and its parents (with stmmac, the MAC) and replays the
postponed interrupt then. The PM core resumes children of a device
whose resume callback failed, and phylib cannot tell: if the MAC fails
to power the bus up, the replay still reaches the bus. phy_suspend(),
phy_resume() and the state machine stay with the MAC driver, and no
MAC driver needs a change: macb, for one, calls phylink_stop() and
pm_runtime_force_suspend() from its own suspend callback, not
phylink_suspend().

A postponed interrupt cannot ask the PHY whether Wake-on-LAN is
enabled: phy_may_wakeup() may read the PHY over MDIO. Decide that in
mdio_bus_phy_suspend() instead, which runs before the suspend callback
of the device that owns the MDIO bus, and store the wakeup event to
report. For a PHY whose MAC manages PHY PM, this MDIO access in the
suspend path is new; phy_suspend() makes the same one for other PHYs.
For a suspended PHY without driver-model wakeup, use the wol_enabled
that phy_suspend() stored, and do not read the PHY.

Any PHY reports a system wakeup when Wake-on-LAN is set through ethtool
or reported by phy_may_wakeup(), the two sources phy_suspend() counts.
Without it, a MAC that manages PHY PM stops the PHY itself, and the
link interrupt that follows is not a wakeup: it must not abort suspend
just because the MAC device may wake the system.

Tested on Helios64 with 7.3.1, s2idle with the link up:
- no Wake-on-LAN, GMAC clocks off in suspend: 10 of 10 cycles suspended
  and resumed; on 7.3 without this series the same test hung or reset
  the board after the link went down 10 of 10 times;
- MAC power/wakeup enabled, no Wake-on-LAN: 3 of 3 slept;
- Wake-on-LAN in the PHY: a magic packet woke the board 4 of 4 times,
  no suspend aborted.

Fixes: f151c147b3af ("net: stmmac: Enable mac_managed_pm phylink config")
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/net/phy/phy.c        | 27 +++++++++++++++--------
 drivers/net/phy/phy_device.c | 52 ++++++++++++++++++++++++++++++++++++++++----
 include/linux/phy.h          | 22 +++++++++++++++++--
 3 files changed, 86 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 49098b481388..54c099f96b4b 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1411,23 +1411,32 @@ int phy_disable_interrupts(struct phy_device *phydev)
 static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 {
 	struct phy_device *phydev = phy_dat;
+	bool postponed;
 	irqreturn_t ret;
 
+	/* Pairs with smp_store_release() in mdio_bus_phy_suspend_irq() */
+	postponed = smp_load_acquire(&phydev->irq_suspended);
+
 	/* Wakeup interrupts may occur during a system sleep transition.
 	 * Postpone handling until the PHY has resumed.
 	 */
-	if (IS_ENABLED(CONFIG_PM_SLEEP) && READ_ONCE(phydev->irq_suspended)) {
+	if (IS_ENABLED(CONFIG_PM_SLEEP) && postponed) {
 		struct net_device *netdev = phydev->attached_dev;
 
-		if (netdev) {
-			struct device *parent = netdev->dev.parent;
-
-			if (netdev->ethtool->wol_enabled)
-				pm_system_wakeup();
-			else if (device_may_wakeup(&netdev->dev))
+		switch (phydev->irq_wake) {
+		case PHY_IRQ_WAKE_SYSTEM:
+			pm_system_wakeup();
+			break;
+		case PHY_IRQ_WAKE_NETDEV:
+			if (netdev)
 				pm_wakeup_dev_event(&netdev->dev, 0, true);
-			else if (parent && device_may_wakeup(parent))
-				pm_wakeup_dev_event(parent, 0, true);
+			break;
+		case PHY_IRQ_WAKE_PARENT:
+			if (netdev && netdev->dev.parent)
+				pm_wakeup_dev_event(netdev->dev.parent, 0, true);
+			break;
+		case PHY_IRQ_WAKE_NONE:
+			break;
 		}
 
 		/* Disable the line only once: an edge can rerun the thread, and
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 390069ec13ca..ebcbae86f902 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -332,16 +332,55 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 	return !phydev->suspended;
 }
 
+static __maybe_unused enum phy_irq_wake
+phy_irq_wake_source(struct phy_device *phydev)
+{
+	struct net_device *netdev = phydev->attached_dev;
+	bool phy_wol;
+
+	if (!netdev)
+		return PHY_IRQ_WAKE_NONE;
+
+	/* phy_suspend() cached the answer of a suspended PHY, which may
+	 * not be reachable over MDIO.
+	 */
+	if (phydev->suspended && !phy_can_wakeup(phydev))
+		phy_wol = phydev->wol_enabled;
+	else
+		phy_wol = phy_may_wakeup(phydev);
+
+	if (netdev->ethtool->wol_enabled || phy_wol)
+		return PHY_IRQ_WAKE_SYSTEM;
+
+	/* A MAC that manages PHY PM stops the PHY itself: the link
+	 * interrupt that follows is not a wakeup.
+	 */
+	if (phydev->mac_managed_pm)
+		return PHY_IRQ_WAKE_NONE;
+
+	if (device_may_wakeup(&netdev->dev))
+		return PHY_IRQ_WAKE_NETDEV;
+
+	if (netdev->dev.parent && device_may_wakeup(netdev->dev.parent))
+		return PHY_IRQ_WAKE_PARENT;
+
+	return PHY_IRQ_WAKE_NONE;
+}
+
 /* Wakeup interrupts may occur during the system sleep transition when
  * the PHY is inaccessible. Set flag to postpone handling until the PHY
  * has resumed. Wait for concurrent interrupt handler to complete.
+ * Decide which wakeup event a postponed interrupt reports now, while
+ * the PHY can still be read.
  */
 static __maybe_unused void mdio_bus_phy_suspend_irq(struct phy_device *phydev)
 {
 	if (!phy_interrupt_is_valid(phydev))
 		return;
 
-	WRITE_ONCE(phydev->irq_suspended, true);
+	phydev->irq_wake = phy_irq_wake_source(phydev);
+	/* Pairs with smp_load_acquire() in phy_interrupt() */
+	smp_store_release(&phydev->irq_suspended, true);
 	synchronize_irq(phydev->irq);
 }
 
@@ -368,11 +407,14 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 	struct phy_device *phydev = to_phy_device(dev);
 	int ret;
 
+	/* An interrupt can fire while the MAC has the MDIO bus powered
+	 * down, whether or not the MAC manages PHY PM.
+	 */
+	mdio_bus_phy_suspend_irq(phydev);
+
 	if (phydev->mac_managed_pm)
 		return 0;
 
-	mdio_bus_phy_suspend_irq(phydev);
-
 	/* We must stop the state machine manually, otherwise it stops out of
 	 * control, possibly with the phydev->lock held. Upon resume, netdev
 	 * may call phy routines that try to grab the same lock, and that may
@@ -405,8 +447,10 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 	struct phy_device *phydev = to_phy_device(dev);
 	int ret;
 
-	if (phydev->mac_managed_pm)
+	if (phydev->mac_managed_pm) {
+		mdio_bus_phy_resume_irq(phydev);
 		return 0;
+	}
 
 	if (!phydev->suspended_by_mdio_bus)
 		goto no_resume;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 04916fc29ed7..c2e09963c003 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -573,6 +573,20 @@ struct phy_oatc14_sqi_capability {
 	u8 sqiplus_bits;
 };
 
+/**
+ * enum phy_irq_wake - wakeup event a postponed PHY interrupt reports
+ * @PHY_IRQ_WAKE_NONE: none
+ * @PHY_IRQ_WAKE_SYSTEM: pm_system_wakeup(), Wake-on-LAN is enabled
+ * @PHY_IRQ_WAKE_NETDEV: pm_wakeup_dev_event() for the attached netdev
+ * @PHY_IRQ_WAKE_PARENT: pm_wakeup_dev_event() for the netdev's parent
+ */
+enum phy_irq_wake {
+	PHY_IRQ_WAKE_NONE,
+	PHY_IRQ_WAKE_SYSTEM,
+	PHY_IRQ_WAKE_NETDEV,
+	PHY_IRQ_WAKE_PARENT,
+};
+
 /**
  * struct phy_device - An instance of a PHY
  *
@@ -649,10 +663,13 @@ struct phy_oatc14_sqi_capability {
  * @mdix_ctrl: User setting of crossover
  * @pma_extable: Cached value of PMA/PMD Extended Abilities Register
  * @interrupts: Flag interrupts have been enabled
- * @irq_suspended: Flag indicating PHY is suspended and therefore interrupt
- *                 handling shall be postponed until PHY has resumed
+ * @irq_suspended: Flag indicating a system sleep transition in progress, so
+ *                 interrupt handling shall be postponed until
+ *                 mdio_bus_phy_resume()
  * @irq_rerun: Set by the postponed interrupt that disabled the line, and
  *             by phy_free_interrupt() to keep the line enabled
+ * @irq_wake: Wakeup event a postponed interrupt reports, decided by
+ *            mdio_bus_phy_suspend()
  * @irq_pm_lock: Serializes phy_free_interrupt() against the rerun of a
  *               postponed interrupt, so that only one of them re-enables
  *               the line; never taken by phy_interrupt()
@@ -732,6 +749,7 @@ struct phy_device {
 	/* Written without phydev->lock, so not bitfields */
 	bool irq_suspended;
 	atomic_t irq_rerun;
+	enum phy_irq_wake irq_wake;
 	/* Serializes phy_free_interrupt() against mdio_bus_phy_resume_irq() */
 	struct mutex irq_pm_lock;
 

-- 
2.43.0


