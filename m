Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3946757266E
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883052; cv=none; b=oAHvqOcVtpaeswn19V5kAAJbZ8VcB/9NnJ+Mi6FqQWaLKOVA8djIcbYZzFTyHBaCNb01mkBMYFgqXO3xPNHFEiHjWP7mzY0j4on6UhqxGXUuz47fhQuMFDN52qCJRl2sM0Iw1ue73u+eaDNQH+bTYK2Qkdw15Oa2zbX/iNYs8v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883052; c=relaxed/simple;
	bh=1OQN2hlqiJhxyXGllQ5L8EqTRRM5exxJTPl6s+WACzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEBV0RaF+aQw48VM5Kz1T4RP/0BtUMGvdHAyd633iHRpMOP5Zs014zq9dTBqVCfpsVNIKUSts2IJdaOVn2GCVjynTLxserQU+yT/MOJtkunAqIzYtO5LZRnd4AfpxcQ9B5ldw1olk/NsSlo2lTFF+8qjzO9dnvCaNfEzaISYMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=OjUcsGH1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="OjUcsGH1"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-485850cf499so3185050f8f.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788883041; x=1789487841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sY8q/8ZX78MYp+GbZ3CoGJbwlETSUAbbscvAdY9eIl8=;
        b=OjUcsGH1SIYtbRcgrBQ0HvKrjF8acTrOtTvNyKTdU9e3jwdBfe1Rl1Y+M4Lz7/UZDy
         em8rwWzIvIPVJBU57n9s8rK2Ugdq8A1+L55R5uHkUOfyZSFIbAv6cM2yCDpneBw02A+t
         BG66oYeH13WS7GIuIec/gJBGgu6FJpUd0g4MaR/U5alB+TTCKFMWFAi/+/eUThNyrLXl
         rGk7mIMxSm/Wu4HgPqEzBp1DNETrcsHavPAWtwOAxGfG44Pb7Aec/tksgwmIc0XNU2lu
         lrdszomW18n82Tikzybm1k5il/corz3OZYntIIPkq3aB1CDMZ6PkGUPo6a0xUqRLEy70
         JAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883041; x=1789487841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sY8q/8ZX78MYp+GbZ3CoGJbwlETSUAbbscvAdY9eIl8=;
        b=SfZPNbfnp2zXr82j8HfXp7AT3Q91LyKX86aMfvKfRlSVkthQNJIGqdzxEeTEyWoigu
         zDs8CVlW8desntK3mCFTESEJIlvDitgPO7JBYPhk2IbspuI2E+KTRGTGFb2iSzrRxolH
         10qgVsAdMUMj5+SEk3+h0lgY6dzj07kqXsV8MdKXy5zFBsiFjbbZwKVV55yO7xFcqem1
         L8649EuWctns3Kfn8mOw125A8FLofD0FEYu2YMVoqORb/TIbzTkQCPjxauFZzBZH2/cj
         dG59gOuGlJPHom2IChNsB9mvLJX2VXESxEhIdPhjIvEprx6ocqL+xMzYT3ObD2/WkyPF
         CcWg==
X-Forwarded-Encrypted: i=1; AKwUvBxuYdZUZO9ep7a5tMHWQpiGsquMQwF+KmngjagTi3bNTVmOMynHh9/2ytqqj9D/uWKXu3fixUg=@vger.kernel.org
X-Gm-Message-State: AFuF++m1Um+dwyI3d0niCzPBVAIUjx5nYDCc+Lv56Rmm8v8jwiNSaY5l
	r/4Q6DyzrosmejPOGtexZRdttxfPzHq64nzCC/XRMB/ekaWLjo/BtxHRfOeD4/OQLFw=
X-Gm-Gg: AYBFou3k9wW+YZhlH4KprZ3+1jJgiL+DYhtk+48uHYEozBTA2AE1sXDgcMuRB6OFiD9
	SW1YNgYsQ9t79vuCbTcDyQPAtmKOEoHZK35m33+87cElKGN40ReAQm3isJHjLbHz0qvysCXMjnc
	8qGtLI+XTKjg/99/1kJ+4haJaRt0ygq2BevlDouveyMCR++e3ntxFCUdYkVO/Potkhzn0IZVP+4
	TOYLTjNN60rjGDU9I2rOnMnoFyASgbu5b7j6ePzRJNPtC89gqQSwbMaNWajN79B47Stx9DiMvM2
	GFg1hzHS2oWSJjp01RAPlCmVl3PKEum9K7/Cn2NHpeMRCrVU7EXXEt/sbZkNSOIHGivPAWehhN+
	kiSnsuxiTWcYT33Lmw+kISYedp0cCCulTdnAgOSZ+VnvhHV1IJ21SA6Kv2Gh148o/7M1uDDPokR
	ueUNXY3IF2ZWDW13Ano0ROgp/Qb9IbUvBaDWCxZwM=
X-Received: by 2002:a5d:5f52:0:b0:485:9233:a5ae with SMTP id ffacd0b85a97d-4859233aaf2mr21075663f8f.3.1788883040918;
        Tue, 08 Sep 2026 08:57:20 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be709sm37345704f8f.21.2026.09.08.08.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:57:20 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: ericwouds@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [RFC PATCH net-next v2 7/7] net: mdio: en8811h: add the nested bus
Date: Tue,  8 Sep 2026 15:57:07 +0000
Message-ID: <20260908155707.4164559-8-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908155707.4164559-1-f@lex.la>
References: <20260908155707.4164559-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Registering the bus is what publishes the PHY, so it must happen only
once the MD32 is running its firmware. Put the PHY on a bus of its own
rather than on the parent so that the device tree can describe it
normally, interrupts included, and so that the MCU keeps ownership of
the reset line the PHY must not touch. Only the address the MD32
answers on is passed through.

Publishing the PHY there splits the two agents that drive this chip
onto two mutexes: the PHY holds the child bus lock across a whole paged
sequence while each frame under it takes the parent alone, so a
download holding only the parent would land between two of those frames
and leave the PHY writing to a page it did not select. This driver
therefore takes the child bus lock around its own chip access once the
bus exists, and the library beneath it takes the parent one level down.
The level cannot be baked into the library: reached from here the
parent sits below a lock already held, while reached from the PHY
driver on this same bus the library takes the child itself. The caller
passes it down. MDIO_MUTEX_NESTED is what the child bus's own accessors
already use for the parent, so this adds no edge lockdep did not have;
the enum's remaining value belongs to mdio-mux, so a bus stacked under
another nested bus would want a new one.

The download becomes the first of two phases, since registering the bus
can fail on its own and wants its own backoff and warning. That second
phase gives up once its minute is spent, where the first does not:
firmware files can be installed at any time, but a registration that
keeps failing repeats a bus creation, a message from the MDIO core and
a pair of uevents on every retry, and only a deferred probe resolves by
itself. A driver that stopped there needs to be unbound and bound
again. Resume now
puts a failed reload back to the poller rather than leaving it, but
that restores the chip and not the port: the PHY below has run its own
resume by then and failed, and nothing calls phy_init_hw() a second
time, so it stays unconfigured until its driver is rebound. Telling a
consumer to re-initialise is the same mechanism this driver lacks for
telling one to let go, and it is not invented here.

The sysfs bind attributes are suppressed, because unregistering this
bus while its PHY is attached leaves the consumer holding a phy_device
whose driver is gone, and the driver cannot disconnect a consumer it
does not know. Module unload was already refused, since attaching a PHY
takes a reference on the bus owner. Removing the parent MDIO bus still
reaches this driver's remove and is not covered; that wants a way for a
bus to tell its PHYs' consumers to let go.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/mdio/mdio-airoha-en8811h.c   | 223 +++++++++++++++++++++--
 drivers/net/phy/air_en8811h.c            |   7 +-
 drivers/net/phy/air_phy_lib.c            |  64 ++++---
 drivers/net/phy/air_phy_lib.h            |   4 +-
 include/linux/mdio/mdio-airoha-en8811h.h |   5 +-
 5 files changed, 251 insertions(+), 52 deletions(-)

diff --git a/drivers/net/mdio/mdio-airoha-en8811h.c b/drivers/net/mdio/mdio-airoha-en8811h.c
index d94d74d85f10..722455891472 100644
--- a/drivers/net/mdio/mdio-airoha-en8811h.c
+++ b/drivers/net/mdio/mdio-airoha-en8811h.c
@@ -14,6 +14,8 @@
 #include <linux/mdio.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/workqueue.h>
@@ -28,21 +30,144 @@ struct en8811h_mcu {
 	struct mdio_device *mdiodev;
 	struct gpio_desc *reset_gpio;
 	struct delayed_work fw_poll;
+	struct mii_bus *bus;
 	unsigned int poll_ms;
 	unsigned int waited_ms;
 	u32 fw_version;
 	bool warned;
+	bool fw_running;
 };
 
+static int en8811h_mcu_read(struct mii_bus *bus, int addr, int regnum)
+{
+	struct en8811h_mcu *mcu = bus->priv;
+
+	if (addr != mcu->mdiodev->addr)
+		return -ENODEV;
+
+	return mdiobus_read_nested(mcu->mdiodev->bus, addr, regnum);
+}
+
+static int en8811h_mcu_write(struct mii_bus *bus, int addr, int regnum, u16 val)
+{
+	struct en8811h_mcu *mcu = bus->priv;
+
+	if (addr != mcu->mdiodev->addr)
+		return -ENODEV;
+
+	return mdiobus_write_nested(mcu->mdiodev->bus, addr, regnum, val);
+}
+
+static int en8811h_mcu_read_c45(struct mii_bus *bus, int addr, int devad,
+				int regnum)
+{
+	struct en8811h_mcu *mcu = bus->priv;
+
+	if (addr != mcu->mdiodev->addr)
+		return -ENODEV;
+
+	return mdiobus_c45_read_nested(mcu->mdiodev->bus, addr, devad, regnum);
+}
+
+static int en8811h_mcu_write_c45(struct mii_bus *bus, int addr, int devad,
+				 int regnum, u16 val)
+{
+	struct en8811h_mcu *mcu = bus->priv;
+
+	if (addr != mcu->mdiodev->addr)
+		return -ENODEV;
+
+	return mdiobus_c45_write_nested(mcu->mdiodev->bus, addr, devad, regnum,
+					val);
+}
+
+static int en8811h_mcu_bus_register(struct en8811h_mcu *mcu)
+{
+	struct mii_bus *parent = mcu->mdiodev->bus;
+	struct device *dev = &mcu->mdiodev->dev;
+	struct device_node *np;
+	struct mii_bus *bus;
+	int ret;
+
+	np = of_get_child_by_name(dev->of_node, "mdio");
+	if (!np)
+		return -ENODEV;
+
+	/* Not devm: this is retried, and a devm bus would only be freed at
+	 * detach.
+	 */
+	bus = mdiobus_alloc();
+	if (!bus) {
+		of_node_put(np);
+		return -ENOMEM;
+	}
+
+	bus->name = "airoha-en8811h";
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
+	bus->priv = mcu;
+	bus->parent = dev;
+	if (parent->read) {
+		bus->read = en8811h_mcu_read;
+		bus->write = en8811h_mcu_write;
+	}
+	if (parent->read_c45) {
+		bus->read_c45 = en8811h_mcu_read_c45;
+		bus->write_c45 = en8811h_mcu_write_c45;
+	}
+
+	ret = of_mdiobus_register(bus, np);
+	of_node_put(np);
+	if (!ret && !mdiobus_get_phy(bus, mcu->mdiodev->addr)) {
+		/* An ID read that failed leaves the bus registered and the
+		 * PHY absent; of_mdiobus_register() returns 0 either way.
+		 */
+		mdiobus_unregister(bus);
+		ret = -ENODEV;
+	}
+	if (ret) {
+		mdiobus_free(bus);
+		return ret;
+	}
+
+	mcu->bus = bus;
+	return 0;
+}
+
+/* Serialise with the PHY below, which reaches the same registers under
+ * this lock through phy_select_page().
+ */
+static struct mii_bus *en8811h_mcu_chip_lock(struct en8811h_mcu *mcu)
+{
+	struct mii_bus *bus = mcu->bus;
+
+	if (bus)
+		mutex_lock(&bus->mdio_lock);
+
+	return bus;
+}
+
+static void en8811h_mcu_chip_unlock(struct mii_bus *bus)
+{
+	if (bus)
+		mutex_unlock(&bus->mdio_lock);
+}
+
 static void en8811h_mcu_fw_poll(struct work_struct *work)
 {
 	struct en8811h_mcu *mcu = container_of(to_delayed_work(work),
 					       struct en8811h_mcu, fw_poll);
 	struct device *dev = &mcu->mdiodev->dev;
+	struct mii_bus *chip;
 	int ret;
 
-	ret = air_en8811h_fw_download(mcu->mdiodev, &mcu->fw_version);
-	if (ret >= 0) {
+	if (!mcu->fw_running) {
+		chip = en8811h_mcu_chip_lock(mcu);
+		ret = air_en8811h_fw_download(mcu->mdiodev, &mcu->fw_version,
+					      !!chip);
+		en8811h_mcu_chip_unlock(chip);
+		if (ret < 0)
+			goto retry;
+
 		dev_dbg(dev, "firmware %08x running after %ums\n",
 			mcu->fw_version, mcu->waited_ms);
 		ret = firmware_request_cache(dev, EN8811H_MD32_DM) ?:
@@ -50,34 +175,58 @@ static void en8811h_mcu_fw_poll(struct work_struct *work)
 		if (ret)
 			dev_dbg(dev, "not cached, resume will want the files: %pe\n",
 				ERR_PTR(ret));
-		return;
+		mcu->fw_running = true;
+		mcu->poll_ms = EN8811H_FW_POLL_MIN_MS;
+		mcu->waited_ms = 0;
+		mcu->warned = false;
 	}
 
-	mcu->waited_ms += mcu->poll_ms;
+	/* Resume re-runs the download, so the bus can already be here, and
+	 * fwnode_mdio defers while the PHY node's interrupt controller is
+	 * missing, so a failure is not necessarily permanent.
+	 */
+	ret = mcu->bus ? 0 : en8811h_mcu_bus_register(mcu);
+	if (!ret)
+		return;
+
+retry:
 	if (!mcu->warned && mcu->waited_ms >= EN8811H_FW_WARN_MS) {
-		if (ret == -ENOENT)
-			dev_warn(dev, "still waiting for %s and %s\n",
-				 EN8811H_MD32_DM, EN8811H_MD32_DSP);
+		if (!mcu->fw_running)
+			dev_warn(dev, "no firmware after %ums of waiting for %s and %s: %pe\n",
+				 mcu->waited_ms, EN8811H_MD32_DM,
+				 EN8811H_MD32_DSP, ERR_PTR(ret));
 		else
-			dev_warn(dev, "firmware download keeps failing: %pe\n",
+			dev_warn(dev, "no PHY at address %d, %ums after the firmware started: %pe\n",
+				 mcu->mdiodev->addr, mcu->waited_ms,
 				 ERR_PTR(ret));
 		mcu->warned = true;
 	}
 
+	/* Past its budget, only a deferral will change on its own: every
+	 * other error repeats a bus registration, its message from the MDIO
+	 * core and its uevents for the uptime. Firmware files are the
+	 * exception, since they can be installed at any time.
+	 */
+	if (mcu->fw_running && ret != -EPROBE_DEFER &&
+	    mcu->waited_ms >= EN8811H_FW_WARN_MS)
+		return;
+
 	mcu->poll_ms = min(mcu->poll_ms * 2, EN8811H_FW_POLL_MAX_MS);
+	/* Count the sleep ahead: the first run was immediate. */
+	mcu->waited_ms += mcu->poll_ms;
 	queue_delayed_work(system_freezable_wq, &mcu->fw_poll,
 			   msecs_to_jiffies(mcu->poll_ms));
 }
 
 /* The firmware lives in volatile RAM: no reset while the MD32 reports ready. */
-static void en8811h_mcu_reset_if_dormant(struct en8811h_mcu *mcu)
+static void en8811h_mcu_reset_if_dormant(struct en8811h_mcu *mcu, bool nested)
 {
 	struct mdio_device *mdiodev = mcu->mdiodev;
 	struct device *dev = &mdiodev->dev;
 	u32 assert_us = 0, deassert_us = 0;
 	int ret;
 
-	ret = air_en8811h_mcu_running(mdiodev);
+	ret = air_en8811h_mcu_running(mdiodev, nested);
 	if (ret > 0) {
 		dev_dbg(dev, "MD32 already running, leaving reset alone\n");
 		return;
@@ -116,6 +265,7 @@ static int en8811h_mcu_probe(struct mdio_device *mdiodev)
 {
 	struct device *dev = &mdiodev->dev;
 	struct en8811h_mcu *mcu;
+	struct device_node *np;
 
 	mcu = devm_kzalloc(dev, sizeof(*mcu), GFP_KERNEL);
 	if (!mcu)
@@ -124,6 +274,15 @@ static int en8811h_mcu_probe(struct mdio_device *mdiodev)
 	mcu->mdiodev = mdiodev;
 	mdiodev_set_drvdata(mdiodev, mcu);
 
+	/* Registration needs this only once the firmware runs, but a DT
+	 * hole should fail the bind now, not as a work-item error later.
+	 */
+	np = of_get_child_by_name(dev->of_node, "mdio");
+	if (!np)
+		return dev_err_probe(dev, -ENODEV,
+				     "no mdio node describing the PHY\n");
+	of_node_put(np);
+
 	/* The core claims reset-gpios only for devices flagged as PHYs. */
 	mcu->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS);
 	if (IS_ERR(mcu->reset_gpio))
@@ -133,7 +292,7 @@ static int en8811h_mcu_probe(struct mdio_device *mdiodev)
 	if (mcu->reset_gpio)
 		gpiod_set_consumer_name(mcu->reset_gpio, "EN8811H reset");
 
-	en8811h_mcu_reset_if_dormant(mcu);
+	en8811h_mcu_reset_if_dormant(mcu, false);
 
 	mcu->poll_ms = EN8811H_FW_POLL_MIN_MS;
 	INIT_DELAYED_WORK(&mcu->fw_poll, en8811h_mcu_fw_poll);
@@ -150,23 +309,43 @@ static void en8811h_mcu_remove(struct mdio_device *mdiodev)
 	struct en8811h_mcu *mcu = mdiodev_get_drvdata(mdiodev);
 
 	cancel_delayed_work_sync(&mcu->fw_poll);
+	if (mcu->bus) {
+		mdiobus_unregister(mcu->bus);
+		mdiobus_free(mcu->bus);
+		mcu->bus = NULL;
+	}
 }
 
 static int en8811h_mcu_resume(struct device *dev)
 {
 	struct en8811h_mcu *mcu = dev_get_drvdata(dev);
-
+	struct mii_bus *chip;
 	int ret;
 
-	/* Not on the workqueue: the child PHY's own resume calls
-	 * phy_init_hw() straight after this one and needs the firmware by
-	 * then. request_firmware() is answered from the cache the download
-	 * registered, so it does not wait for a filesystem.
+	/* Nothing to redo: the poll is armed and thaws with everything else. */
+	if (!mcu->fw_running)
+		return 0;
+
+	/* Not on the workqueue: a DSA port's PHY resumes right after this
+	 * one and calls phy_init_hw(), which needs the firmware by then.
 	 */
-	en8811h_mcu_reset_if_dormant(mcu);
-	ret = air_en8811h_fw_download(mcu->mdiodev, &mcu->fw_version);
-	if (ret < 0)
-		dev_err(dev, "firmware not restored: %pe\n", ERR_PTR(ret));
+	chip = en8811h_mcu_chip_lock(mcu);
+	en8811h_mcu_reset_if_dormant(mcu, !!chip);
+	ret = air_en8811h_fw_download(mcu->mdiodev, &mcu->fw_version, !!chip);
+	en8811h_mcu_chip_unlock(chip);
+	if (ret < 0) {
+		/* The reload restores this chip, not the PHY below it: its
+		 * own resume has already failed by then and nothing calls
+		 * phy_init_hw() twice.
+		 */
+		dev_err(dev, "firmware not restored, reloading: %pe\n",
+			ERR_PTR(ret));
+		mcu->fw_running = false;
+		mcu->poll_ms = EN8811H_FW_POLL_MIN_MS;
+		mcu->waited_ms = 0;
+		mcu->warned = false;
+		queue_delayed_work(system_freezable_wq, &mcu->fw_poll, 0);
+	}
 
 	return 0;
 }
@@ -186,6 +365,10 @@ static struct mdio_driver en8811h_mcu_driver = {
 		.name = "airoha-en8811h-mcu",
 		.of_match_table = en8811h_mcu_of_match,
 		.pm = pm_sleep_ptr(&en8811h_mcu_pm_ops),
+		/* Tearing the child bus down under an attached PHY is not
+		 * something this driver can make safe on its own.
+		 */
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index d1c7c472f0e9..65fa1707f57d 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -256,7 +256,7 @@ static int __air_pbus_reg_write(struct mdio_device *mdiodev,
 
 static int en8811h_wait_mcu_ready(struct phy_device *phydev)
 {
-	int ret = air_en8811h_wait_mcu_ready(&phydev->mdio);
+	int ret = air_en8811h_wait_mcu_ready(&phydev->mdio, false);
 
 	if (ret < 0)
 		phydev_err(phydev, "MCU not ready: %pe\n", ERR_PTR(ret));
@@ -323,7 +323,7 @@ static int an8811hb_load_file(struct phy_device *phydev, const char *name,
 	if (ret < 0)
 		return ret;
 
-	ret = air_fw_write_buf(&phydev->mdio, address, fw);
+	ret = air_fw_write_buf(&phydev->mdio, address, fw, false);
 	release_firmware(fw);
 	return ret;
 }
@@ -422,7 +422,8 @@ static int en8811h_load_firmware(struct phy_device *phydev)
 	struct en8811h_priv *priv = phydev->priv;
 	int ret;
 
-	ret = air_en8811h_fw_download(&phydev->mdio, &priv->firmware_version);
+	ret = air_en8811h_fw_download(&phydev->mdio, &priv->firmware_version,
+				      false);
 	if (ret < 0)
 		phydev_err(phydev, "Load firmware failed: %d\n", ret);
 
diff --git a/drivers/net/phy/air_phy_lib.c b/drivers/net/phy/air_phy_lib.c
index a5b6b3606bec..7f7530273601 100644
--- a/drivers/net/phy/air_phy_lib.c
+++ b/drivers/net/phy/air_phy_lib.c
@@ -272,8 +272,17 @@ static int __air_mdio_restore_page(struct mdio_device *mdiodev,
 	return ret;
 }
 
+/* Nested when the caller already holds the bus this chip hangs below. */
+static void air_mdiodev_lock(struct mdio_device *mdiodev, bool nested)
+{
+	if (nested)
+		mdiodev_lock_nested(mdiodev);
+	else
+		mdiodev_lock(mdiodev);
+}
+
 int air_fw_write_buf(struct mdio_device *mdiodev, u32 address,
-		     const struct firmware *fw)
+		     const struct firmware *fw, bool nested)
 {
 	size_t chunk, done = 0;
 	int saved_page, ret;
@@ -287,7 +296,7 @@ int air_fw_write_buf(struct mdio_device *mdiodev, u32 address,
 	while (done < fw->size) {
 		chunk = min_t(size_t, fw->size - done, AIR_FW_CHUNK_BYTES);
 
-		mdiodev_lock(mdiodev);
+		air_mdiodev_lock(mdiodev, nested);
 
 		saved_page = __air_mdio_select_page(mdiodev,
 						    AIR_PHY_PAGE_EXTENDED_4);
@@ -313,11 +322,12 @@ int air_fw_write_buf(struct mdio_device *mdiodev, u32 address,
 EXPORT_SYMBOL_GPL(air_fw_write_buf);
 
 static int air_mdio_buckpbus_reg_read(struct mdio_device *mdiodev,
-				      u32 pbus_address, u32 *pbus_data)
+				      u32 pbus_address, u32 *pbus_data,
+				      bool nested)
 {
 	int saved_page, ret;
 
-	mdiodev_lock(mdiodev);
+	air_mdiodev_lock(mdiodev, nested);
 
 	saved_page = __air_mdio_select_page(mdiodev, AIR_PHY_PAGE_EXTENDED_4);
 	if (saved_page < 0) {
@@ -333,11 +343,12 @@ static int air_mdio_buckpbus_reg_read(struct mdio_device *mdiodev,
 }
 
 static int air_mdio_buckpbus_reg_write(struct mdio_device *mdiodev,
-				       u32 pbus_address, u32 pbus_data)
+				       u32 pbus_address, u32 pbus_data,
+				       bool nested)
 {
 	int saved_page, ret;
 
-	mdiodev_lock(mdiodev);
+	air_mdiodev_lock(mdiodev, nested);
 
 	saved_page = __air_mdio_select_page(mdiodev, AIR_PHY_PAGE_EXTENDED_4);
 	if (saved_page < 0) {
@@ -354,11 +365,12 @@ static int air_mdio_buckpbus_reg_write(struct mdio_device *mdiodev,
 }
 
 static int air_mdio_buckpbus_reg_modify(struct mdio_device *mdiodev,
-					u32 pbus_address, u32 mask, u32 set)
+					u32 pbus_address, u32 mask, u32 set,
+					bool nested)
 {
 	int saved_page, ret;
 
-	mdiodev_lock(mdiodev);
+	air_mdiodev_lock(mdiodev, nested);
 
 	saved_page = __air_mdio_select_page(mdiodev, AIR_PHY_PAGE_EXTENDED_4);
 	if (saved_page < 0) {
@@ -399,20 +411,20 @@ static int __air_mmd_read(struct mdio_device *mdiodev, u16 devad, u16 regnum)
 	return __mdiobus_read(bus, addr, MII_MMD_DATA);
 }
 
-static int air_mmd_status_read(struct mdio_device *mdiodev)
+static int air_mmd_status_read(struct mdio_device *mdiodev, bool nested)
 {
 	int ret;
 
-	mdiodev_lock(mdiodev);
+	air_mdiodev_lock(mdiodev, nested);
 	ret = __air_mmd_read(mdiodev, MDIO_MMD_VEND1, EN8811H_PHY_FW_STATUS);
 	mdiodev_unlock(mdiodev);
 
 	return ret;
 }
 
-int air_en8811h_mcu_running(struct mdio_device *mdiodev)
+int air_en8811h_mcu_running(struct mdio_device *mdiodev, bool nested)
 {
-	int ret = air_mmd_status_read(mdiodev);
+	int ret = air_mmd_status_read(mdiodev, nested);
 
 	if (ret < 0)
 		return ret;
@@ -421,12 +433,12 @@ int air_en8811h_mcu_running(struct mdio_device *mdiodev)
 }
 EXPORT_SYMBOL_GPL(air_en8811h_mcu_running);
 
-int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev)
+int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev, bool nested)
 {
 	int ret, reg_value;
 
 	ret = air_mdio_buckpbus_reg_write(mdiodev, EN8811H_FW_CTRL_1,
-					  EN8811H_FW_CTRL_1_FINISH);
+					  EN8811H_FW_CTRL_1_FINISH, nested);
 	if (ret)
 		return ret;
 
@@ -436,7 +448,7 @@ int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev)
 	ret = read_poll_timeout(air_mmd_status_read, reg_value,
 				reg_value < 0 ||
 				reg_value == EN8811H_PHY_READY,
-				20000, 7500000, true, mdiodev);
+				20000, 7500000, true, mdiodev, nested);
 	if (reg_value < 0)
 		return reg_value;
 	if (ret) {
@@ -448,19 +460,20 @@ int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev)
 }
 EXPORT_SYMBOL_GPL(air_en8811h_wait_mcu_ready);
 
-int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version)
+int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version,
+			    bool nested)
 {
 	const struct firmware *fw1, *fw2;
 	struct device *dev = &mdiodev->dev;
 	int ret;
 
-	ret = air_en8811h_mcu_running(mdiodev);
+	ret = air_en8811h_mcu_running(mdiodev, nested);
 	if (ret < 0)
 		return ret;
 
 	if (ret) {
 		ret = air_mdio_buckpbus_reg_read(mdiodev, EN8811H_FW_VERSION,
-						 fw_version);
+						 fw_version, nested);
 		if (ret < 0)
 			return ret;
 
@@ -478,35 +491,36 @@ int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version)
 		goto air_fw_download_rel1;
 
 	ret = air_mdio_buckpbus_reg_write(mdiodev, EN8811H_FW_CTRL_1,
-					  EN8811H_FW_CTRL_1_START);
+					  EN8811H_FW_CTRL_1_START, nested);
 	if (ret < 0)
 		goto air_fw_download_out;
 
 	ret = air_mdio_buckpbus_reg_modify(mdiodev, EN8811H_FW_CTRL_2,
 					   EN8811H_FW_CTRL_2_LOADING,
-					   EN8811H_FW_CTRL_2_LOADING);
+					   EN8811H_FW_CTRL_2_LOADING, nested);
 	if (ret < 0)
 		goto air_fw_download_out;
 
-	ret = air_fw_write_buf(mdiodev, AIR_FW_ADDR_DM, fw1);
+	ret = air_fw_write_buf(mdiodev, AIR_FW_ADDR_DM, fw1, nested);
 	if (ret < 0)
 		goto air_fw_download_out;
 
-	ret = air_fw_write_buf(mdiodev, AIR_FW_ADDR_DSP, fw2);
+	ret = air_fw_write_buf(mdiodev, AIR_FW_ADDR_DSP, fw2, nested);
 	if (ret < 0)
 		goto air_fw_download_out;
 
 	ret = air_mdio_buckpbus_reg_modify(mdiodev, EN8811H_FW_CTRL_2,
-					   EN8811H_FW_CTRL_2_LOADING, 0);
+					   EN8811H_FW_CTRL_2_LOADING, 0,
+					   nested);
 	if (ret < 0)
 		goto air_fw_download_out;
 
-	ret = air_en8811h_wait_mcu_ready(mdiodev);
+	ret = air_en8811h_wait_mcu_ready(mdiodev, nested);
 	if (ret < 0)
 		goto air_fw_download_out;
 
 	ret = air_mdio_buckpbus_reg_read(mdiodev, EN8811H_FW_VERSION,
-					 fw_version);
+					 fw_version, nested);
 	if (ret < 0)
 		goto air_fw_download_out;
 
diff --git a/drivers/net/phy/air_phy_lib.h b/drivers/net/phy/air_phy_lib.h
index 3391396aecd1..56ba987a68cc 100644
--- a/drivers/net/phy/air_phy_lib.h
+++ b/drivers/net/phy/air_phy_lib.h
@@ -62,7 +62,7 @@ int air_phy_write_page(struct phy_device *phydev, int page);
 struct firmware;
 
 int air_fw_write_buf(struct mdio_device *mdiodev, u32 address,
-		     const struct firmware *fw);
-int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev);
+		     const struct firmware *fw, bool nested);
+int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev, bool nested);
 
 #endif /* __AIR_PHY_LIB_H */
diff --git a/include/linux/mdio/mdio-airoha-en8811h.h b/include/linux/mdio/mdio-airoha-en8811h.h
index 0d23811e90dc..4494dc6c1022 100644
--- a/include/linux/mdio/mdio-airoha-en8811h.h
+++ b/include/linux/mdio/mdio-airoha-en8811h.h
@@ -17,8 +17,9 @@ struct mdio_device;
 #define EN8811H_MD32_DSP		"airoha/EthMD32.DSP.bin"
 
 /* Returns 1 running, 0 dormant, negative on a failed status read. */
-int air_en8811h_mcu_running(struct mdio_device *mdiodev);
+int air_en8811h_mcu_running(struct mdio_device *mdiodev, bool nested);
 /* Returns 1 when it adopted firmware that was already running. */
-int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version);
+int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version,
+			    bool nested);
 
 #endif /* __LINUX_MDIO_AIROHA_EN8811H_H */
-- 
2.53.0

