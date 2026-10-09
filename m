Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2934F402B
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569168; cv=none; b=IWQIXPQKTfn3alGhV+1P7i3xc50w7Vmw8lx6f90iIzRh29wDq7PKIfo3MntwU6CFO6LESL9XUGcRwnLGm9E+m6r5q7dH7wDFXOSAyvi1b4eR8vugufsseO3NT5LeKKc44AYfDVPwAj5z2x0VO7u70JQEy8QRQ0brIM5MmhEDI3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569168; c=relaxed/simple;
	bh=bsf8TxF7WdL5O6WNyvZ/kcjCgsQy1HF8zNK4J52zy7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9Q5N07q1Rrj0qch4vX4kgDnOvyMfN5IqMqO9tYhjFvJoYtKrilgPnBIGiFQ3BWoXExDxw2qCcaTBX/wyz257BHEv9tPsz7qxi5LEezB/tPiHsEIZJuiuGO1KIpUV+zqO8yBQy6RxQVLUCMVlYrCoh1CL3GVeVHf946Wirp3sCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=fPmEPyu3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="fPmEPyu3"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so902755e9.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1791569165; x=1792173965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WGNA0/QZCrfB7QLLTaLeaXo+rC65bpP9iitE8k+9l10=;
        b=fPmEPyu3RAQvPHwTr/P9NovKHYsEZ0/JqI7DUNWStk6/X9ADyAEa2hVuY9+HMUUf6i
         J8YjVp/DCiHMbjFE2F5kVsfNSZwRVc7gJtk9twrAfK4e4BZXBuT2w9aF/v5vv8Oa/WZS
         ePdO9LHg16Qb0SFJ21KQHDF/004Y63wn2Z6yzOilX3pZ0Ur/VqPvo6jYY7NxY3scMLtX
         SbDelFZXEy9b9RITDCEJm11GcLOEySIIlYUApiwppauywEU4SqLTWXecghKsE7B7XvuF
         CjRrEYyo4L1LegHnVwmI/ooFwX1TEzQDpzhXoiTCIB4F2Cqmvi0TZ8jcsHD7Eqar2QR3
         WLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791569165; x=1792173965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WGNA0/QZCrfB7QLLTaLeaXo+rC65bpP9iitE8k+9l10=;
        b=TfZjjbG9oKMGaFLWJLvD3qIQsjKM5OZ+opvenEXIUTkGAfvqULXsC2Dmko3acBq5qH
         wjiPjNu/IH9dp/LzbHS7qsOe5ZNVND0deRTLNYtK/mujm28tvXGjjpkO2cfpmbfFBe9o
         p8KLoLAG7miDzSN7kg2QzKZeFoEhdAAFV5+Zp9NH1B1q8UkBwD2w3yUF5ICo8ToR5hlk
         VsO1nv30pT7cPYyz7eRoK03bnsndNQ9K9S9Hyswt1UMFEhw4b687PT1X82CYNRpY7SHa
         ykziv/KHtnQNYt6mXCB29QFOIrE9doEgKSlB6v7m7r/U0MJIcFTOzumwZvSH0eDM8Bbg
         4xHw==
X-Forwarded-Encrypted: i=1; AKwUvBxOd2htu2nqzfj/zJjb5gVyawjIvmgEzmOnIrnVdk2ZQ3cn2lyQDdB68mxeL6+yZ8DBIQpk2QE=@vger.kernel.org
X-Gm-Message-State: AFuF++lW/VxhkX73Ep+xOND3/rRFaTgSiea0zjAqICw13NFeAOHDNdUU
	43nBA4iZVA56j7OJOXRGQu+9vmy+hO8vrMs+kMBLFvd5qMRZBUnrY8euHJvRWLMQygI=
X-Gm-Gg: AYBFou1YgTlh8RsAVovmOM1bcjTeax9CcUaTSHcO4717Y1pgsvBhF5G4vgsQKkX9CH/
	e7HHJ4qU8ocrMbPg1/byswS9EPCSe3rdH4pZWsp+nR3DXXzfltjYBhITNpL7B2QSrvZRZRmqXDg
	lywKBgGoMot/Cig/Glzkl0LR7QCrKWXyidnxpE5uZoANw7OcoUocEyym0HyeEOq3K2kXHEbK9qF
	71NeMpd+1DIvmP5sDv4C0TRv6NSo/1Rj0uPOQY1vWmk+yg4aCvFp++5S2zjM7EJkdNRW4kY2H7D
	Y04HUx4Nze2u0ZloXVwC6dz4rIIROmLnBrWH/JHQ1xFUlGE/ND8KjKSbF6QzyyJ1e4Bu6SaXMnO
	ySTFlyRegHXKnIOyrf5q2TIOTqLeO/B2e895cdKy2LANRwr5mXyG401XM2kLLpK2XFdThGJ/74R
	puC19xV5WyazgT5OyQwoZtK8ahy1tQSy9NSRYrk4xpkC7iWHRLKQ==
X-Received: by 2002:a05:600c:3111:b0:4a1:811c:8069 with SMTP id 5b1f17b1804b1-4a18e49d640mr51938095e9.8.1791569164821;
        Fri, 09 Oct 2026 11:06:04 -0700 (PDT)
Received: from remote-01 ([84.17.55.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf21276sm118184915e9.8.2026.10.09.11.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:06:04 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v5 4/4] net: phy: make an unbind wait for the attached consumer to detach
Date: Fri,  9 Oct 2026 21:05:50 +0300
Message-ID: <20261009180551.1234107-5-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009180551.1234107-1-f@lex.la>
References: <20261009180551.1234107-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With attach serialised against unbind, the unbind that loses the race
waits for the attach and then removes the driver from a PHY that is now
attached. phylink uses phydev->drv right after the attach returns, and
phylib uses it again in later phy_start(), phy_stop() and state machine
runs.

Found on the same KN-1012 by repeating the wan race on a kernel with
the previous patch. The attach completed, the unbind then removed the
driver, and phylink faulted one frame up:

  Unable to handle kernel access to user memory outside uaccess
  routines at virtual address 00000000000000a0
  Comm: ip
  Call trace:
   phylink_bringup_phy+0x680/0x784 (P)
   phylink_fwnode_phy_connect+0x1b8/0x27c
   phylink_of_phy_connect+0x18/0x20
   mtk_open+0x38/0xb70

A DSA port gets there without any race, and did on the same board
before this series: unbinding the lan4 PHY driver returns at once, and
with lan4 up, tearing the switch down later faults in
_phy_state_machine(), called by phy_stop() from dsa_user_close().

The driver core gives a driver no way to refuse an unbind, so make
phy_remove() wait until phy_detach() has run. An unbind of a PHY in use
now blocks until the consumer lets go: ifdown for a MAC that connects
in ndo_open, the switch teardown for DSA, which connects at probe.
A reboot behind such an unbind hangs: device_shutdown() takes the
device lock the waiting unbind holds.
Detach clears the attached flag in the section where it clears
phy_link_change, so it cannot overwrite the flag of an attach that
comes right after. For the same reason, the restore of phydev->irq
for a PHY on the generic driver moves ahead of that section.

Deleting the PHY device through phy_device_remove(), as
mdiobus_unregister() does, keeps today's behaviour and does not wait,
and it releases an unbind that is already waiting. Some MAC drivers
unregister their MDIO bus with the PHY still attached and never detach
it (greth), so waiting there would hang their removal for good.

One case is known to wait for good and is untested: when the PHY and
its MAC or switch are managed device-link consumers of one supplier,
unbinding the supplier can unbind the PHY first, and phy_remove() then
waits for a detach that only the same thread would run later.

Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling ethernet drivers to remain as ignorant as is reasonable of the connected PHY's design and operation details.")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Changes in v5:
- READ_ONCE()/WRITE_ONCE() on attached. Detach clears it in the
  bind_lock section that clears phy_link_change, then wakes the waiter.
- Rebased on net-next: the interrupt restore in phy_detach_internal()
  now comes before the bind_lock section that lets a new attach in, so
  it cannot land on that attach.
- The message names the device-link case where the wait never ends.
- The comment on bind_lock names every flag it protects.
- The message says that a reboot behind a waiting unbind hangs.
- WRITE_ONCE() on removing as well.

 drivers/net/phy/phy_device.c | 34 +++++++++++++++++++++++++++++++---
 include/linux/phy.h          |  6 +++++-
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0ffaa456a308..a271fe76c3f8 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1065,6 +1065,13 @@ void phy_device_remove(struct phy_device *phydev)
 	unregister_mii_timestamper(phydev->mii_ts);
 	pse_control_put(phydev->psec);
 
+	mutex_lock(&phydev->bind_lock);
+	WRITE_ONCE(phydev->removing, true);
+	mutex_unlock(&phydev->bind_lock);
+	/* Order the store before waking an unbind waiting in phy_remove() */
+	smp_mb();
+	wake_up_var(&phydev->attached);
+
 	device_del(&phydev->mdio.dev);
 
 	/* Assert the reset signal */
@@ -1734,25 +1741,33 @@ static void phy_detach_internal(struct phy_device *phydev, bool notify_bus)
 
 	phydev->phylink = NULL;
 
+	/* Before phy_link_change is cleared, so it cannot land on a new attach */
+	if (phydev->is_genphy_driven)
+		phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];
+
 	/* A new attach may pass its "already attached" test as soon as
-	 * phy_link_change is clear, so take the owner in the same section.
+	 * phy_link_change is clear, so take the owner and clear attached in
+	 * the same section.
 	 */
 	mutex_lock(&phydev->bind_lock);
 	phydev->phy_link_change = NULL;
 	drv_owner = phydev->drv_owner;
 	phydev->drv_owner = NULL;
+	WRITE_ONCE(phydev->attached, false);
 	mutex_unlock(&phydev->bind_lock);
 
 	module_put(drv_owner);
 
+	/* Order the store before waking an unbind waiting in phy_remove() */
+	smp_mb();
+	wake_up_var(&phydev->attached);
+
 	/* If the device had no specific driver before (i.e. - it
 	 * was using the generic driver), we unbind the device
 	 * from the generic driver so that there's a chance a
 	 * real driver could be loaded
 	 */
 	if (phydev->is_genphy_driven) {
-		/* The release below lets phy_probe() write this field. */
-		phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];
 		device_release_driver(&phydev->mdio.dev);
 		phydev->is_genphy_driven = 0;
 	}
@@ -1954,6 +1969,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 	phy_resume(phydev);
 
+	WRITE_ONCE(phydev->attached, true);
 	mutex_unlock(&phydev->bind_lock);
 
 	/**
@@ -3858,11 +3874,23 @@ static int phy_probe(struct device *dev)
 static int phy_remove(struct device *dev)
 {
 	struct phy_device *phydev = to_phy_device(dev);
+	bool attached;
 
 	mutex_lock(&phydev->bind_lock);
 	phydev->bound = false;
+	attached = READ_ONCE(phydev->attached) && !phydev->removing;
 	mutex_unlock(&phydev->bind_lock);
 
+	/* The driver core cannot refuse an unbind, and the consumer keeps
+	 * using phydev->drv until it detaches.
+	 */
+	if (attached) {
+		phydev_warn(phydev, "unbind waits for the PHY to be detached\n");
+		wait_var_event(&phydev->attached,
+			       !READ_ONCE(phydev->attached) ||
+			       READ_ONCE(phydev->removing));
+	}
+
 	cancel_delayed_work_sync(&phydev->state_queue);
 
 	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev))
diff --git a/include/linux/phy.h b/include/linux/phy.h
index db7c8696743c..8fa3685b24e6 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -673,6 +673,8 @@ struct phy_oatc14_sqi_capability {
  * @lock:  Mutex for serialization access to PHY
  * @bind_lock: Serialises attach and detach with phy_probe() and phy_remove()
  * @bound: A driver has finished probing and is not being removed
+ * @attached: phy_attach_direct() succeeded and phy_detach() has not run
+ * @removing: phy_device_remove() is deleting the device
  * @state_queue: Work queue for state machine
  * @link_down_events: Number of times link was lost
  * @shared: Pointer to private data shared by phys in one package
@@ -804,9 +806,11 @@ struct phy_device {
 
 	struct mutex lock;
 
-	/* Protects bound */
+	/* Protects bound, attached and removing */
 	struct mutex bind_lock;
 	bool bound;
+	bool attached;
+	bool removing;
 
 	/* This may be modified under the rtnl lock */
 	bool sfp_bus_attached;
-- 
2.53.0

