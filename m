Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA7F31F986;
	Fri,  2 Oct 2026 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790915790; cv=pass; b=esxBoZsmPJ2murCF34OeH61LMIPbX7fWQFl7N8LuyhFTeMh6iGEQxepCFXdWqfKH3n1CYnhLaE4RtaK7r2dEuMZIAg9/4fPk357Ea5T+J422sIhCFMKSAl1CBE+mstfbadL5bu3o9GRNfuLalQxSvUeszfj/7ay8FzEOlSxEd4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790915790; c=relaxed/simple;
	bh=tjARIWWXAKrPOpLAAgvWWBlYpWM/A3w0XsQnzs/AgeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kPalJJJdvSf1CaBR5VEIl3wgijSpdx+Z0SuDZjQdsjELzyl31gggRlFd3qDb4cJEr5UgralKpgKzN7mltJBUoTWbOh7pIHcjNCzKr2iVYteNj07Xnuu4xfZAZXpzUfspLcca/YkknUpxdgfz/JALmEZWPioSyJcw+m4s2JMtP0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=d57IANdL; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="d57IANdL"
ARC-Seal: i=1; a=rsa-sha256; t=1790915753; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=FCQVotBVCBiiaAfA/DPaJ5dDH2RHi7k6GuPf/WAwWMcsf/FddZLJBR9bE5k5QkSFgumA7lcRGdO7vUfu7x/Qv9z6bzX8ujsP9R5Wz8Qy0QacZOwXDmmCdbE8tQmSmx5HzW9xN8VYe1tv88BQuBmU7vetka5G1PfB3fwLbBaCK+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1790915753; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LYH3lrtmd382qLFN+8gpL2fIcmxWlunJLTu7qnrvylg=; 
	b=FECdSruecwVP2FW65//3qMJ7qXZ6r/91Tlk7M1R4Y35P8qI7qt/NYJbzIRUvl5nHMwfRO98VCv7GqUG+hB4fTBtsDQ1bkWSogPqC5SceCxAKi9484QE0LbYD9ZNwVT59UWvRIx+ZFlIQebMjau6XctK4gy19+UKu/frqUM55WZo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790915753;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=LYH3lrtmd382qLFN+8gpL2fIcmxWlunJLTu7qnrvylg=;
	b=d57IANdLUIYOjZoibmMbfzA0XBZPPDnzBNOC9SkPOXGA9sX6ycno7ycj4rJCZNOy
	DBk4udazWUXvhUlYKq8mlWHdbvMIlXXls+XLx5dXt7xqGlFha/nMnSKUPDBI2TjZYsR
	pD1prcKHgEqxazJbwWGHYL8JpcN0Jz+rAq4nl/80=
Received: by smtp.zoho.eu with SMTPS id 1790915750257965.242228430571;
	Fri, 2 Oct 2026 06:35:50 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: postpone PHY interrupts during sleep with MAC-managed PM
Date: Fri,  2 Oct 2026 07:35:48 +0300
Message-ID: <20261002043548.1302145-1-iav@iav.lv>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mdio_bus_phy_suspend() and mdio_bus_phy_resume() return early when the
MAC driver manages PHY PM, so the PHY never gets irq_suspended. A PHY
interrupt that wakes the system fires as soon as resume_device_irqs()
re-enables the line, before the MAC driver resumes, and phy_interrupt()
runs the PHY driver's handler at once. If the MDIO bus was powered down
in suspend, the MDIO access in that handler stalls the CPU.

On Helios64 (dwmac-rk, RTL8211F with an interrupt line, Wake-on-LAN in
the PHY) the wake interrupt reads INSR while the GMAC clocks are off,
and the board hangs within a few suspend cycles.

Set irq_suspended for these PHYs too. The PHY device is a child of its
MDIO bus, so mdio_bus_phy_resume() runs after the bus is back (with
stmmac, after the MAC) and replays the postponed interrupt then.
phy_suspend(), phy_resume() and the state machine stay with the MAC
driver.

Drop a pending rerun when the interrupt is freed: MAC drivers that close
the interface in suspend free and request it again before the PHY
resumes.

Tested on Helios64 with 7.3-rc5, the GMAC powered down in suspend and
Wake-on-LAN in the PHY: 20 of 20 magic-packet wakes. Without it the
same setup hung within 1 to 7 cycles in 14 of 16 runs, some on
instrumented builds; one run passed 25 cycles. ODROID-HC4
(dwmac-meson8b, RTL8211F with an interrupt line): 10 of 10.

Fixes: 1758bde2e4aa ("net: phy: Don't trigger state machine while in suspend")
Assisted-by: LLM
Signed-off-by: Igor Velkov <iav@iav.lv>
---
This replaces the dwmac-rk change that kept the GMAC powered instead:
https://lore.kernel.org/r/20260930-dwmac-rk-phy-wol-v1-1-9fdc50bd9ae4@iav.lv

Build-tested on net: allmodconfig and allyesconfig with W=1, no new
warnings.

 drivers/net/phy/phy.c        |  2 ++
 drivers/net/phy/phy_device.c | 43 ++++++++++++++++++++++--------------
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index fce9bc7be330..cd189ecee55e 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1507,6 +1507,8 @@ EXPORT_SYMBOL(phy_request_interrupt);
 void phy_free_interrupt(struct phy_device *phydev)
 {
 	phy_disable_interrupts(phydev);
+	/* A freed interrupt has nothing left to rerun on resume. */
+	phydev->irq_rerun = 0;
 	free_irq(phydev->irq, phydev);
 }
 EXPORT_SYMBOL(phy_free_interrupt);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..948818964841 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -347,18 +347,19 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 {
 	struct phy_device *phydev = to_phy_device(dev);
 
-	if (phydev->mac_managed_pm)
-		return 0;
-
 	/* Wakeup interrupts may occur during the system sleep transition when
 	 * the PHY is inaccessible. Set flag to postpone handling until the PHY
 	 * has resumed. Wait for concurrent interrupt handler to complete.
+	 * The MDIO bus may be powered down even when the MAC manages PHY PM.
 	 */
 	if (phy_interrupt_is_valid(phydev)) {
 		phydev->irq_suspended = 1;
 		synchronize_irq(phydev->irq);
 	}
 
+	if (phydev->mac_managed_pm)
+		return 0;
+
 	/* We must stop the state machine manually, otherwise it stops out of
 	 * control, possibly with the phydev->lock held. Upon resume, netdev
 	 * may call phy routines that try to grab the same lock, and that may
@@ -375,13 +376,33 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 	return phy_suspend(phydev);
 }
 
+static __maybe_unused void mdio_bus_phy_resume_irq(struct phy_device *phydev)
+{
+	if (!phy_interrupt_is_valid(phydev))
+		return;
+
+	phydev->irq_suspended = 0;
+	synchronize_irq(phydev->irq);
+
+	/* Rerun interrupts which were postponed by phy_interrupt()
+	 * because they occurred during the system sleep transition.
+	 */
+	if (phydev->irq_rerun) {
+		phydev->irq_rerun = 0;
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
@@ -404,19 +425,7 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 no_resume:
-	if (phy_interrupt_is_valid(phydev)) {
-		phydev->irq_suspended = 0;
-		synchronize_irq(phydev->irq);
-
-		/* Rerun interrupts which were postponed by phy_interrupt()
-		 * because they occurred during the system sleep transition.
-		 */
-		if (phydev->irq_rerun) {
-			phydev->irq_rerun = 0;
-			enable_irq(phydev->irq);
-			irq_wake_thread(phydev->irq, phydev);
-		}
-	}
+	mdio_bus_phy_resume_irq(phydev);
 
 	if (phy_uses_state_machine(phydev))
 		phy_start_machine(phydev);
-- 
2.43.0

