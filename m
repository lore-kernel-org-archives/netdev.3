Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792990495;
	b=Qbqke2JArIB81KoZwoUqS+x2JLzUUvD1uXkAruq3iArm/lkqAajI9CoQetj3Vuvt3RVa
	 R5YjB4AAS8yVCR6JuwCVGbt+YZuYF4EFyZd1d8iWfyaFyOgfN2RVyQE3pUIsgKhQZyF26
	 fEXwyRFJ84uR28TLPB2/xTDu25AIQYmGveY6fxqCf5b1BXfkxzuRlCyDfYFxyiSas7skz
	 kt+d+iyk2fxyWw6315qHN5k5gmwGldsGNZ9kvCxfU2Kz3tabAo1MKYUijnhGXZWJXvgCs
	 QBfPhHOlnKre7omj+TJ7V7YdW3sY1uzo/bCWgXkYO0bQpX94udZznXblhW5z07qc/RA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792990495;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1B67bd36Pnf8qzGqrytuX93TJqsxVxqzw/Os2fTeuz4=;
	b=PJmtH2vRwqglWoo/G9Abo5dsfKoJd63mLDSlmfy6feXJctjbVEnSoxBTCE8PIuNB/vow
	 DxBgGlQyk7O6BPg5UDz72XYXc6+e/lAe6nhxj+Eg2kQncYydohku4wHCCuMnvxibPstRN
	 MTb51saB0sL1yjQ8Ki92eJcQBhKsk9eF7wM6/+rp2JYOP9BkT3N7Y7a1hgW1uLs4jilhK
	 weCWmO2NHgNxA8e4ZTqXuH5ipAQns/hqqb1iTCXe4c81nIEZy5ypHd6tdcXaQl20XAzPg
	 31uPV5gvjOJKuomMcLmVjC6N6jdkDcGXOCum90rqo7TDqr1V9lx5AZElqJvjwdoL3BA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=ebjDbegg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB25E606A31A;
	Mon, 26 Oct 2026 04:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB25E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=ebjDbegg
ARC-Seal: i=1; a=rsa-sha256; t=1792990460; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=TSa1CqlN+RW/8/i+4FqED9x93b38/nY6vYNP9GCe0laDtnRSwAq/BvWA3OYyZ4YF+XyN6JGi6V2P76v4y+xwulvg3XTnM4xuPMEbBObWfacoSfTAgAj2EAHZ0Nm0dHQ5LtwmZ7di3FBb4heU4xtorH1agWZuMhighuiYytjdpfI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1792990460; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1B67bd36Pnf8qzGqrytuX93TJqsxVxqzw/Os2fTeuz4=; 
	b=Nc9dOQjogpufqXoQjGFrXX+H5u4znFC04oaOPlTADRjiOqPxzNEl4XbCTAbEp455XExDMl03m0qrJlUaPy4qs2qpORyMa1Fj3/64DU+YOINA4T/abZaXYNZDJDdvfMxPuag5Ow0kJ7hGKnKaBArvwxANDpQxR0igME7bzeZKvho=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792990460;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1B67bd36Pnf8qzGqrytuX93TJqsxVxqzw/Os2fTeuz4=;
	b=ebjDbeggtTCHT+N06YPzwGrtJbB7UIdAeWw4Qvn5ZjNjEf51tH/NuP96fWuqApIh
	8Oj04Af8VEPPQefy4MgEUg/WtZ9DOCdRiM9m5UIBKrMQMhN19sNdXeDgHQKQbilJkr/
	C3PzV23PLMJKcRXKc+VWwpjTRl36lRpyMg2RL7EI=
Received: by smtp.zoho.eu with SMTPS id 1792990458380265.63495947933006;
	Mon, 26 Oct 2026 05:54:18 +0100 (CET)
From: Igor Velkov <iav@iav.lv>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Wei Fang <wei.fang@nxp.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Igor Velkov <iav@iav.lv>
Subject: [PATCH net v2 2/2] net: phy: postpone PHY interrupts during sleep with MAC-managed PM
Date: Mon, 26 Oct 2026 06:53:43 +0200
Message-ID: <20261026045343.837889-3-iav@iav.lv>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026045343.837889-1-iav@iav.lv>
References: <20261026045343.837889-1-iav@iav.lv>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
driver. As for other PHYs, an interrupt in that window now signals a
wakeup event if Wake-on-LAN is enabled or the device may wake the
system.

MAC drivers that close the interface in suspend free the interrupt
before the PHY resumes, so phy_free_interrupt() re-enables a line left
disabled by a postponed interrupt if other handlers still share it.

Tested on Helios64 with 7.3, s2idle without Wake-on-LAN, GMAC clocks
off in suspend: 10 of 10 cycles got through suspend, 4 of them then
hit a separate PCIe error on resume. The same kernel without these
changes hung or reset after the link went down in 10 of 10.

Fixes: 1758bde2e4aa ("net: phy: Don't trigger state machine while in suspend")
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/net/phy/phy.c        |  9 ++++++++
 drivers/net/phy/phy_device.c | 44 ++++++++++++++++++++++--------------
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index fce9bc7be330..00aa48e807a5 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1508,6 +1508,15 @@ void phy_free_interrupt(struct phy_device *phydev)
 {
 	phy_disable_interrupts(phydev);
 	free_irq(phydev->irq, phydev);
+
+	/* Undo the disable_irq_nosync() of a postponed interrupt if the line
+	 * is still shared; otherwise the next irq_startup() resets the depth.
+	 */
+	if (phydev->irq_rerun) {
+		phydev->irq_rerun = 0;
+		if (irq_has_action(phydev->irq))
+			enable_irq(phydev->irq);
+	}
 }
 EXPORT_SYMBOL(phy_free_interrupt);
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 5d4508bcfbe9..e2807e08e436 100644
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
+	 * fire while the MAC has the PHY or the MDIO bus powered down.
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
@@ -364,13 +366,33 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
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
@@ -393,19 +415,7 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
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

