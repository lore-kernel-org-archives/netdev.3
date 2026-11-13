Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794604002;
	b=QN3jCblIJoLvpI8HJGfkdNDvip9oKLK0n+ot/N0TctqBj0A2PboncHsp3qtjYcGdkymU
	 dGZ6oeoXsuyE1aW5NWt36ScOarlrL5AF8i7GnpBoQSHZiNOv4f987b2JYB7k8sMJ2fDNb
	 SD0DFPfYcB6IKDgZ6uBULXyjn+ZhL2LvkLMt6jZaEvROin0ZPOYuIOwoEhc0VSI+SNwoi
	 +/V4LZl0y+Vfv/3/O/ojq4s8F4S0Ywsf1fg7Ph+oqM60vedIAtKgMowEAxXTdJVmbBhiz
	 ETHrYrLNcdnxGtwk4G7fCJgHvc/o5phcXzi1wQRIIepuQBWyRLd5z+40cAckmNY2ugg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604002;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vXg2XMptD/ZrR/0Xri1h54OWX+8BpljQwFZ0ZnkL6l0=;
	b=mJWCcKQBmaWoE/rPLkO7mWMUGdDaDIwyR0IIwpEnpxBWpiAQBsYMx08d2nb4jrOLyA6S
	 FP/k4L0v+T66xa6vnYwlGgglyJL3RyPHdNHbru4vrEuDxz44EqFoAZyQ+aafwVYnuiuR2
	 07W1oS5cSQebHraFAYJ0VjO1bbeB9wqN2ErAZeR13DzPdL4Imjozt7fhWMaXKBqOWrsHm
	 JZueNIPSD8B7ZEddQrTwDNkfTmKxe1uagRxCZLl45UfCENjPg+N6Ur40SxnL88zzUpC4h
	 xFiwYyo3YFwNjWQI46CjJVpetmVYdET0P7MAruLQzKpPnXj6tY/wiRypJjNr0ZoAO1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H7yQPMtp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A80606A89C;
	Fri, 13 Nov 2026 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H7yQPMtp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794604002;
	b=LcaKymLm2f7FK/uXsAGZvivctDEvfGbzWUgfxhO0Sf3m1CkL+fUhAAGN574kGqreRIjq
	 NTewOz3k41HisLNPlQ/b8OLvKhadeNhOhD/WqDDApHfmMySwRlB5g6p/wYC1Mwf9mEyRo
	 WxnEVy6VXOsJTkd+HibG0SVFZorWtnyx911njLny348VIaqrTq1wNq3Jas2Io/q7VGqT/
	 oy5GM7SAX/59I0/d7A7HmfGSjBkM91B3YGgFKmGzWCGzqxACvJ98HmyDVSYsfkj3osyh+
	 mfuJEXpIdCWnXxMw1EV6Ms/dNYePajoLT3EogMMJLZ4UxzJzoBkBtT5j2r0efDxayMw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794604002;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vXg2XMptD/ZrR/0Xri1h54OWX+8BpljQwFZ0ZnkL6l0=;
	b=zbtxYjMXRih05EO0idBJu8sHcV/XxzZlwDpdcyTWhywzxVGHoHS2DX4c6ieVeeH0kHHp
	 zusWZ10XudPdjjWkUzgSFnCzVw7+CiEriDUzq7HZk0+hMrnTHFiY24OiGxGBOQFhkDYoh
	 1zjRhAnlsSEyeQzjR9SbE3wG/0z9f5sb/JClPGfdFeBxxFYFzsceI6fOFYGFVeldYUJBZ
	 g6DrLSF6yOWnn1V2kiDBfM14Br+Trxp5MsPETE3q9UMRBKF/oUunLrHMnGKzukXqCU3LK
	 m+4Y1/mD8bCZtNJfOHhQjTSU15U0ciUXWSxEHLb/RBNor1yqie0E0U0TJkmkWV7uHMg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CAB461F000C6;
	Fri, 13 Nov 2026 21:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604002;
	bh=vXg2XMptD/ZrR/0Xri1h54OWX+8BpljQwFZ0ZnkL6l0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=H7yQPMtps3YO2p7eo6XFSw8xUIG34E68Po2f5OqzSkUsnWFqifVdOfna5h+wrArb9
	 4cA8PBuNvV6nDot7ycXLJNQnweK+woxRFmDoEEAEIxQ354ryqr8NKSRPfF0+H8PT9E
	 2PJ2pPFS1Rf9D9EMxeQxcEWc2tFxkynCV73XLXLFmsZmlpkDYSnnZ3/gRzsnDoGw9B
	 zh7hDP39uLDKdrUaN1jv6KWEkVgdFbH1yzD5L7gQcLCX4KmtuGJquvy/LIhuAr2xR1
	 +VaVbmAOuP06diaGOeBSG3DaeRlC8azyv2ELvJZlqA1nBV4I9CpDqB2VJXZ66wf6jm
	 7KObXIKsWhNHA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5AA1D49AFA;
	Fri, 13 Nov 2026 21:06:40 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Fri, 13 Nov 2026 21:06:36 +0000
Subject: [PATCH net v6 2/4] net: phy: keep the line of a postponed PHY
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
Message-Id: <20261113-b4-phylib-mac-pm-irq-v3-v6-2-05af2503cb23@iav.lv>
References: <20261113-b4-phylib-mac-pm-irq-v3-v6-0-05af2503cb23@iav.lv>
In-Reply-To: <20261113-b4-phylib-mac-pm-irq-v3-v6-0-05af2503cb23@iav.lv>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9280; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=1tntGGa1pMhdf5R5eDyoZ/pZqUGJ2p0rmYR2oDGDlSQ=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFnfq++9ufNj3jYtKXa3u4/Kg5QnsLyZUnK0z2n5xhanG
 y2lCRuFOkpZGMS4GGTFFFkmHNK4lbHk6l9/D/MHMHNYmUCGMHBxCsBERMsYGWa/kU+8fGdLWG3S
 3o65v5YbsWf9PjjbKOr2ZhH5zyrVmgaMDGcMbqvxbAqKrrp/WeWv4malVee5eM1tCjKKzX7Hcnv
 v4gQA
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
  mdio_bus_phy_resume() and leaves irq_rerun set. If the PHY was alone
  on the line, a new request starts the line at depth 0, and the
  enable_irq() in mdio_bus_phy_resume() is unbalanced.

MAC drivers that close the interface in their suspend callback, such as
cpsw, and ravb with Wake-on-LAN off, reach phy_free_interrupt() through
phy_disconnect(), and so does dev_close() in a kernel-internal reset of
the MAC such as stmmac_reset_subtask(), whose workqueue does not freeze.
These drivers set mac_managed_pm, which a later patch brings under
postponing.

Let only the run that sets irq_rerun disable the line. Let
phy_free_interrupt() clear irq_rerun when free_irq() leaves the line
without users: free_irq() has shut it down, and the next request resets
its depth. A shared line keeps irq_rerun, and mdio_bus_phy_resume()
enables it, as before. Enabling it in phy_free_interrupt() instead would
unmask a source that phy_disable_interrupts() failed to clear, and
inside the noirq phase it would unbalance a wakeup line that
suspend_device_irqs() enabled (IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND).

Add irq_pm_lock, so that phy_free_interrupt() does not clear irq_rerun
between the check and the enable_irq() of the rerun after resume, and
move the postponing and the rerun into helpers. phy_interrupt() never
takes the lock, so synchronize_irq() and free_irq() can wait for the
handler under it. irq_rerun stays a plain bool: one thread runs the
handler, and the other two access it only under the lock, after
free_irq() or synchronize_irq(). Mark the irq_suspended accesses with
READ_ONCE() and WRITE_ONCE(): the handler reads it while the PM
callbacks write it.

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
Haoning Cheng's Tested-by on v5 is not carried: phy_free_interrupt()
no longer enables a shared line.
---
 drivers/net/phy/phy.c        | 17 +++++++++++---
 drivers/net/phy/phy_device.c | 56 +++++++++++++++++++++++++++-----------------
 include/linux/phy.h          |  7 ++++--
 3 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 9af303d60bd6..8e03c99fce8f 100644
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
 
@@ -1507,7 +1510,15 @@ EXPORT_SYMBOL(phy_request_interrupt);
 void phy_free_interrupt(struct phy_device *phydev)
 {
 	phy_disable_interrupts(phydev);
+
+	mutex_lock(&phydev->irq_pm_lock);
 	free_irq(phydev->irq, phydev);
+	/* free_irq() shuts down a line left without users and the next request
+	 * resets its depth; mdio_bus_phy_resume_irq() enables a shared line.
+	 */
+	if (!irq_has_action(phydev->irq))
+		phydev->irq_rerun = false;
+	mutex_unlock(&phydev->irq_pm_lock);
 }
 EXPORT_SYMBOL(phy_free_interrupt);
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 1791d578f4dd..573eb234dc79 100644
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
index 59c75296d535..96d14b6b544f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -651,8 +651,7 @@ struct phy_oatc14_sqi_capability {
  * @interrupts: Flag interrupts have been enabled
  * @irq_suspended: Flag indicating PHY is suspended and therefore interrupt
  *                 handling shall be postponed until PHY has resumed
- * @irq_rerun: Flag indicating interrupts occurred while PHY was suspended,
- *             requiring a rerun of the interrupt handler after resume
+ * @irq_rerun: Set by the postponed interrupt that disabled the line
  * @default_timestamp: Flag indicating whether we are using the phy
  *		       timestamp as the default one
  * @interface: enum phy_interface_t value
@@ -675,6 +674,8 @@ struct phy_oatc14_sqi_capability {
  * @n_ports: Number of ports currently attached to the PHY
  * @max_n_ports: Max number of ports this PHY can expose
  * @lock:  Mutex for serialization access to PHY
+ * @irq_pm_lock: Serializes phy_free_interrupt() against the rerun of a
+ *               postponed interrupt; phy_interrupt() never takes it
  * @state_queue: Work queue for state machine
  * @link_down_events: Number of times link was lost
  * @shared: Pointer to private data shared by phys in one package
@@ -808,6 +809,8 @@ struct phy_device {
 	struct delayed_work state_queue;
 
 	struct mutex lock;
+	/* Serializes phy_free_interrupt() against mdio_bus_phy_resume_irq() */
+	struct mutex irq_pm_lock;
 
 	/* This may be modified under the rtnl lock */
 	bool sfp_bus_attached;

-- 
2.43.0


