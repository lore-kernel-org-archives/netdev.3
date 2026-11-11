Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794440906;
	b=5Jz5MHZpGnBNuVacRJvqw4ILxq1Zy1BMR2tF9RuFIViKYtuI7KcFVuWwQ802Nzu64UW3
	 ZaU93xTb8XsCNOiV3amzS1whsvONnSZslLA1RFcg8etARGyz1K7v0lABDOZ2YRMDiNMIs
	 pcGLWoT/+T5KvY6PKKN6ZbHSSpjbCZ0A8kvU70cJ0Q4U8iIJ4/9jROqoWYGGW0GBi29FH
	 1pTrZjc7k8ObX2pThjKDycCZxG+UL0fdLw4mfNLhKK7J5dCaG6LJiIK3eNSuGavi7p109
	 8+LxFV1U8Ay0fyFDpw+M6qsaxMup0MUspLWnqM1Qtrzbk1ZXueQoN1Vpu+aqkRaW4jQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440906;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JhJ9HMPM2v301wpiiI2W0l1tPcAHouBl1zKqObUrzOo=;
	b=ijV8NAwZOdpjYZneylzK4wE9PBIevjhvfvicsFubMk8lCSWsRpxJG49d6/JXNiEzPlZX
	 uPC2y3A5Kb0/6oAs5izk4K+uSzKRJXlaHMoke4lSn+sT+YYvlhApN8Ncp8QPuO8DLrr3M
	 8DYO2ZrJCY4+rflJxI5wNVlQAQKkvHqk4ta87Ow9pL9xYvSC/yOpo1IeXxT8G801cMRfq
	 LZrBXEQi3UXimPAfPkb8hFufkMHVBqtHS6G2zlVKCZ1oNWrMwn8BMV2cIN0VLrXkxKa/G
	 OvEKzushRDt3sXdsCQdawAFrduUXNEAZ8dGyqjYxgYB/MZ2RxwmyzkoDZuZKwB5jHnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eCLjJFQ8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A6F606AE43;
	Wed, 11 Nov 2026 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eCLjJFQ8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794440906;
	b=00HE8o6cFVtunhORD8xA2eQud8EsofsLP5Y6JADRh7Y6viW+MFf8U6z8xGcNzvO2u5KO
	 K0avlCD6UltoiDQO2Zs1UKk+OO3WNHZeFMbIJBIvgoabrmumMndkzyuyccMuuK1J1OWmv
	 Tc6i3uRz+J4BK727h3M4mEjkLLMUR5xEHdea4UvDCuIZzyAeOoi78xRlLz//XKtCgaAfL
	 21lhrm4yL/FD7/owhwQCOyYtaHb7KB5troubDXWsd0UCcCVfzozQe6icuRHe72/i7mGI9
	 Ji90acU7rmEQstgUqbpjAqenLOzpFH6yIVmOMARqvC/xkoGBj+mQZwjAmaiSvQK2LgQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794440906;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JhJ9HMPM2v301wpiiI2W0l1tPcAHouBl1zKqObUrzOo=;
	b=zrYOcv8v/WKzmbZpL6bj/2l6ncxFyzLViR/uLHLj7pfZIgNx9J+Mtgq8VrJMBV8DanVX
	 +clOQmnWvS65Osrs1Sw4m82IT19mdcuthGVQcEr7dkEr/vq5BK0pHFFhG1WVWrI3fckYw
	 CcqySs/r+13L1OwBI8De02T8xtYJGbA6W6mMCPOl5c6RRS25Muj0/goU4nBJn3hvT39LK
	 496Wt5MuzcHm7FT61xRQQrvL3KZWV9QeSb8B8mmmCL7+31dY/qTYJkuWfPoNQ7KtlxcNR
	 nNohW/BsUWqLHbfk9tnY7HlSTIZS/g9HMmdAPhUjlKibeR8qsEZr99K2CFBC3aIeMRw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9F60A1F00A07;
	Wed, 11 Nov 2026 23:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440905;
	bh=JhJ9HMPM2v301wpiiI2W0l1tPcAHouBl1zKqObUrzOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=eCLjJFQ8UG+o/v40RCOGqdYkElISTcYcMkRhRDA+Gf/h/hscLHAtdHyFMgTi+RSDy
	 1uuKL4r5hvDhNhVqKNA6Rw/kizpkBKmxiidugZAOCHAviVOf1n/LuPPx1ncEPp/KcE
	 yfcafxwOCwP7Y0rXfmL3Iq4GQ/KgRAVoZOD7VBmuhh2gTXWsaFjiNGs/8RjItwVB3W
	 3SjFD5kRd6xUhWyrsarlZ1Ofbw5Wq6bSZtBkAbR/TY0DEeD4rKioBKvGVNEfsRucm2
	 g0THrCTJTNVDENN0OXnh/Tw/CV6v4t76R7U26Q3zTCqDvQX/OcSQ3zVkeEq4Y5jePo
	 lQmMLHFWSGoQQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 28ADE49185;
	Wed, 11 Nov 2026 23:48:24 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Wed, 11 Nov 2026 23:48:20 +0000
Subject: [PATCH net v5 2/4] net: phy: keep the line of a postponed PHY
 interrupt balanced
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
Message-Id: <20261111-b4-phylib-mac-pm-irq-v3-v5-2-bbfdb5afb7d3@iav.lv>
References: <20261111-b4-phylib-mac-pm-irq-v3-v5-0-bbfdb5afb7d3@iav.lv>
In-Reply-To: <20261111-b4-phylib-mac-pm-irq-v3-v5-0-bbfdb5afb7d3@iav.lv>
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
 Shenwei Wang <shenwei.wang@nxp.com>, 
 Haoning Cheng <Haoning.CHENG@cn.bosch.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8979; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=5qTzYGdDpJ6t1ZLB7gu9I6UtdFnjTDWLLfUJ5TD4NBc=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFlf/h09s2XNEZuDWhp6PwU/tLRHLZk4c4Yc35P03RpXP
 +2/W/xuYUcpC4MYF4OsmCLLhEMatzKWXP3r72H+AGYOKxPIEAYuTgGYSOhmRoblx5itqifVX1to
 d4x5b0f1i3kHpsZcd3ZYnX9KbL/c1xhlhr/ygjueFcmx8nbatvKLzqktkmtkDKtlue6yNIPFZI3
 JNyYA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

phy_interrupt() postpones interrupts during a system sleep transition:
it sets irq_rerun and disables the line, and mdio_bus_phy_resume()
re-enables the line once and reruns the handler. Two paths leave the
line unbalanced:

- On an edge-triggered line the IRQ core does not mask a ONESHOT
  interrupt, so an edge that arrives before disable_irq_nosync() runs
  the thread again. That second run disables the line again, and the
  line stays disabled after resume.
- phy_free_interrupt() can run between the postponed interrupt and
  mdio_bus_phy_resume() and leaves irq_rerun set. Other users of a
  shared line stay without interrupts until mdio_bus_phy_resume().
  Without other users, a new request starts the line at depth 0, and
  the enable_irq() in mdio_bus_phy_resume() is unbalanced.

MAC drivers that close the interface in their suspend callback, such as
cpsw, and ravb with Wake-on-LAN off, reach phy_free_interrupt() through
phy_disconnect(), and so does dev_close() in a kernel-internal reset of
the MAC such as stmmac_reset_subtask(), whose workqueue does not freeze.
These drivers set mac_managed_pm, which a later patch brings under
postponing.

Let only the run that sets irq_rerun disable the line. Let
phy_free_interrupt() consume irq_rerun after free_irq(), which waits for
the handler, and give the depth back with enable_irq() if a postponed
interrupt took it. Other users of a shared line get the line back. A
line the PHY was alone on is left alone: free_irq() has shut it down,
and the next request resets its depth. Re-enabling after free_irq(), not
before, leaves no PHY handler to run again on a source that
phy_disable_interrupts() did not clear.

Add irq_pm_lock, so that phy_free_interrupt() and the rerun after
resume do not both re-enable the line, and move the postponing and the
rerun into helpers. phy_interrupt() never takes the lock, so
synchronize_irq() and free_irq() can wait for the handler under it.
irq_rerun stays a plain bool: one thread runs the handler, and the
other two read it only under the lock, after free_irq() or
synchronize_irq(). Mark the irq_suspended accesses with READ_ONCE() and
WRITE_ONCE(): the handler reads it while the PM callbacks write it.

This does not keep close and open off the MDIO bus: on close,
phy_disconnect() calls phy_stop(), phy_disable_interrupts() and, in
phy_detach(), phy_suspend(); on open, phy_attach_direct() calls
phy_init_hw() and phy_request_interrupt() calls
phy_enable_interrupts(). A MAC driver that powers its MDIO bus down
during sleep must not close or open the interface until the bus is
back.

Fixes: 1758bde2e4aa ("net: phy: Don't trigger state machine while in suspend")
Signed-off-by: Igor Velkov <iav@iav.lv>
---
Haoning Cheng's Tested-by on v4 is not carried: this patch merges v4
patches 2 and 3 and reworks phy_free_interrupt().
---
 drivers/net/phy/phy.c        | 20 +++++++++++++---
 drivers/net/phy/phy_device.c | 56 +++++++++++++++++++++++++++-----------------
 include/linux/phy.h          |  7 ++++--
 3 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 9af303d60bd6..ea22ebb14a83 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1416,7 +1416,7 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 	/* Wakeup interrupts may occur during a system sleep transition.
 	 * Postpone handling until the PHY has resumed.
 	 */
-	if (IS_ENABLED(CONFIG_PM_SLEEP) && phydev->irq_suspended) {
+	if (IS_ENABLED(CONFIG_PM_SLEEP) && READ_ONCE(phydev->irq_suspended)) {
 		struct net_device *netdev = phydev->attached_dev;
 
 		if (netdev) {
@@ -1430,8 +1430,11 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 				pm_wakeup_dev_event(parent, 0, true);
 		}
 
-		phydev->irq_rerun = true;
-		disable_irq_nosync(irq);
+		/* Disable the line only once: an edge can rerun the thread. */
+		if (!phydev->irq_rerun) {
+			phydev->irq_rerun = true;
+			disable_irq_nosync(irq);
+		}
 		return IRQ_HANDLED;
 	}
 
@@ -1507,7 +1510,18 @@ EXPORT_SYMBOL(phy_request_interrupt);
 void phy_free_interrupt(struct phy_device *phydev)
 {
 	phy_disable_interrupts(phydev);
+
+	mutex_lock(&phydev->irq_pm_lock);
 	free_irq(phydev->irq, phydev);
+	/* Give the depth a postponed interrupt took back to the other users of
+	 * a shared line; requesting a line we were alone on resets its depth.
+	 */
+	if (phydev->irq_rerun) {
+		phydev->irq_rerun = false;
+		if (irq_has_action(phydev->irq))
+			enable_irq(phydev->irq);
+	}
+	mutex_unlock(&phydev->irq_pm_lock);
 }
 EXPORT_SYMBOL(phy_free_interrupt);
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f00086d72771..d3815ee21541 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -332,6 +332,38 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 	return !phydev->suspended;
 }
 
+/* Wakeup interrupts may occur during the system sleep transition when
+ * the PHY is inaccessible. Set flag to postpone handling until the PHY
+ * has resumed. Wait for concurrent interrupt handler to complete.
+ */
+static __maybe_unused void mdio_bus_phy_suspend_irq(struct phy_device *phydev)
+{
+	if (!phy_interrupt_is_valid(phydev))
+		return;
+
+	WRITE_ONCE(phydev->irq_suspended, true);
+	synchronize_irq(phydev->irq);
+}
+
+/* Rerun interrupts which were postponed by phy_interrupt()
+ * because they occurred during the system sleep transition.
+ */
+static __maybe_unused void mdio_bus_phy_resume_irq(struct phy_device *phydev)
+{
+	WRITE_ONCE(phydev->irq_suspended, false);
+	if (!phy_interrupt_is_valid(phydev))
+		return;
+
+	mutex_lock(&phydev->irq_pm_lock);
+	synchronize_irq(phydev->irq);
+	if (phydev->irq_rerun) {
+		phydev->irq_rerun = false;
+		enable_irq(phydev->irq);
+		irq_wake_thread(phydev->irq, phydev);
+	}
+	mutex_unlock(&phydev->irq_pm_lock);
+}
+
 static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 {
 	struct phy_device *phydev = to_phy_device(dev);
@@ -339,14 +371,7 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 	if (phydev->mac_managed_pm)
 		return 0;
 
-	/* Wakeup interrupts may occur during the system sleep transition when
-	 * the PHY is inaccessible. Set flag to postpone handling until the PHY
-	 * has resumed. Wait for concurrent interrupt handler to complete.
-	 */
-	if (phy_interrupt_is_valid(phydev)) {
-		phydev->irq_suspended = true;
-		synchronize_irq(phydev->irq);
-	}
+	mdio_bus_phy_suspend_irq(phydev);
 
 	/* We must stop the state machine manually, otherwise it stops out of
 	 * control, possibly with the phydev->lock held. Upon resume, netdev
@@ -393,19 +418,7 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
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
@@ -711,6 +724,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 	dev->max_n_ports = 1;
 
 	mutex_init(&dev->lock);
+	mutex_init(&dev->irq_pm_lock);
 	INIT_DELAYED_WORK(&dev->state_queue, phy_state_machine);
 
 	/* Request the appropriate module unconditionally; don't
diff --git a/include/linux/phy.h b/include/linux/phy.h
index bbe28ff97e51..a2a4d318e334 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -651,8 +651,9 @@ struct phy_oatc14_sqi_capability {
  * @interrupts: Flag interrupts have been enabled
  * @irq_suspended: Flag indicating PHY is suspended and therefore interrupt
  *                 handling shall be postponed until PHY has resumed
- * @irq_rerun: Flag indicating interrupts occurred while PHY was suspended,
- *             requiring a rerun of the interrupt handler after resume
+ * @irq_rerun: Set by the postponed interrupt that disabled the line
+ * @irq_pm_lock: Serializes phy_free_interrupt() against the rerun of a
+ *               postponed interrupt; never taken by phy_interrupt()
  * @default_timestamp: Flag indicating whether we are using the phy
  *		       timestamp as the default one
  * @interface: enum phy_interface_t value
@@ -729,6 +730,8 @@ struct phy_device {
 	/* Written without phydev->lock, so not bitfields */
 	bool irq_suspended;
 	bool irq_rerun;
+	/* Serializes phy_free_interrupt() against mdio_bus_phy_resume_irq() */
+	struct mutex irq_pm_lock;
 
 	unsigned default_timestamp:1;
 

-- 
2.43.0


