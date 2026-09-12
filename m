Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DD247DD48
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218292; cv=none; b=roD7WxabcqKV8lULbm1zIEszY1B0ThUkEIsmN+FbMdfTKjYWGknMYEDqB98Nj+NT/kz91fX2PLgaLeDf/Cr2JJeelRSn+Hw7nHd2Uh0Ky6EUPq9vB0qTAPjGPIzdqi4SSvEytMcANJNLR2rW1JRDWB3SBEt8tMBc7vl5VSI1zP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218292; c=relaxed/simple;
	bh=Ftirs6/ayPMY1If4qF6MlBmHCpROhxXe9tVg2E2pjgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7enekqu1Rdm5CWWQ4Ftw7JbqmnlNaLtmS323dXKM5BsjTHZ6uxqft+6hFJafzFqzwzZj8iPBxSn+mzqwY3YQWX5BI1Y46fOh97TRKtCsjPGidJqNJGm4V8mNncnmX3xo6bdQMjTnzO0RqYuGKW4hH60kTmy+fBsOwNTQzmC/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=H2X1pNjI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="H2X1pNjI"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49e63568bfbso14072205e9.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 06:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789218285; x=1789823085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AzYYCi2wC429RRKE9FxFr02zCF+c7miGEDqNGISzODc=;
        b=H2X1pNjItyep1hiI5GPckgp1aVz2KcIv/VRpYQt+KYAUZTEz1WhDU2mEzTuPke5qke
         /XOaRadroLiqX7r1vjlwyYufUs08J6nSuDOswwRXa1GUG2G7AOxC5nr5gbSpKoKf7hOT
         iiTdODc8wv1Gy1+zG9YellSG7UdB/7DL+hbHUsmKrgpCR011LFW7pqcSZNhUoP1sQgT+
         vG94u+LnUfjv33Gxrl2GXnAchANocc/5B9aEYKOxtC6WAg4/Oo62aJLJ2Z/uFH6P77Sg
         ULSy3voLspAeajk1jCKEvcTEbGjG2eKDoBSvcVQvstvL4ZYHf1zg2n9j5u9iK6p4xjJQ
         egOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789218285; x=1789823085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AzYYCi2wC429RRKE9FxFr02zCF+c7miGEDqNGISzODc=;
        b=mj4qD1mDdDC72h5NFNhPlBrrCTKxtzIXVWJgZP4Nphvq6LTJkVbCOhlBmI6aCcLwAW
         29wgLLSEFWCcLj7TR2hh9CHdx3vO+oxmN2JlNG3DZPeiSTS58ItrXgyInRQBwVuQ/hOa
         pIig/yhhHcpaAxaOP072It63jWkErhg9MPr419SbRjHB87vOAK6qLE7KBugp7yh9CRLT
         Y8eg80MiESI25slMcT8kTbAj0wsEBuvRBDWxfHg1MEkdAQz7nEwWi/0LrgZFWNeY/T6F
         cm7T63K7YypJ9RIHPOfuwxv8fpxNP9QeWfhWK+kN0NdLihAJBs+vzoSa4npqP9M4FHlF
         ZzIA==
X-Forwarded-Encrypted: i=1; AKwUvBx3Any97JX5iok7GH+cLw0qn0z0Nx8k1uNVpmaLgOjcnpi2IZmUsd9/hdSr5TmZLwEloLZYVfI=@vger.kernel.org
X-Gm-Message-State: AFuF++l9Yf7j9EAOKYuhECdgNFFLTjyy2qWOVIloJK/B8x54yOdvKPCM
	6mckeadNA2kDjlA+ek+ENP++REqhjEUQpx/MIzU8dYg8QSTrqpNunChumfNRoEuViWY=
X-Gm-Gg: AYBFou2/PR8EHaI6GbmloajqLTvECjMsMsZwTwMxMeue3GwWYUehlPgBr76o67GWPRu
	w6pC2+4A+VSbumPe4kVV6MAaowOiK3F6KkeUlTX5kB6R/y2a3CjIX71tjytBtY/8rqiOUzpwvfB
	knEwN+X3M4wBzASWAmeTuh37kuf/9ubd8NU5zBj/I/OUjCmW3UqCv2J48Ic4JmrAoNDmCruCiU7
	E0IFW+TPl24IGjv8lAkTUL1hs4MSwwogOJa6r/qn9eI9KQXtg1x17/uqyiN+WXPVv1GsERSX7Hz
	YjO3cGSo6i/hDGX2x/Xmc5KPIc7pxih/joPdwIFGpJ7kQuAj+Eos12SKt/9jFaml3IQfqtyeUTJ
	JRqYEqwTUv4rEzjq7/mzzkb7V4Ioy41Hiax1fRQ81pXD+9J/3Q7h8RS/c2hhZeqNCKvNHQF7CuR
	RBtSbP17p5AhnwdIL/G8aJ+5p28nmyrGwIB/ZTYTGKqdGxKGxknA==
X-Received: by 2002:a05:600c:34d5:b0:49e:6b7c:63b4 with SMTP id 5b1f17b1804b1-49e6b7c659dmr33857935e9.29.1789218285390;
        Sat, 12 Sep 2026 06:04:45 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6a06cfb8sm80985785e9.5.2026.09.12.06.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:04:45 -0700 (PDT)
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
Subject: [RFC PATCH net-next v3 6/6] net: mdio: en8811h: add the nested bus
Date: Sat, 12 Sep 2026 16:04:30 +0300
Message-ID: <20260912130430.2246285-7-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912130430.2246285-1-f@lex.la>
References: <20260912130430.2246285-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Registering the bus is what publishes the PHY, so it can only happen
once the MD32 runs its firmware. Giving the PHY a bus of its own rather
than the parent lets the device tree describe it normally, interrupt
included, and leaves the reset line owned by the MCU, where the PHY
cannot assert it. Only the address the MD32 answers on is passed
through.

That split puts the PHY driver and this one on two mutexes: the PHY
holds the child bus lock across a whole paged sequence while each frame
under it takes only the parent, so a chip access holding the parent
alone would land between two of those frames and step on the state the
PHY left mid-sequence - the buckpbus mode and address registers it had
already written. The library therefore holds the child lock across the
whole of its own chip access, and the caller hands it the bus to take or
nothing when there is none. Only the firmware read stays outside: those
files may have to come from a filesystem reached over that very PHY.

Registering the bus can fail on its own, so it becomes a second retry
phase. Where the wait for firmware files never gives up, this one does
once its minute is spent - except on a deferred probe, which nothing but
a retry resolves. A failed reload on resume goes back to that poller,
which restores the chip and not the port.

The sysfs bind attributes are suppressed, because unregistering this bus
while its PHY is attached leaves the consumer holding a phy_device whose
driver is gone, and this driver cannot tell a consumer it does not know
to let go. Module unload needs no such guard, since attaching a PHY
takes a reference on the child bus owner, which is this module. Removing
the parent MDIO bus still reaches this driver's remove and is not
covered; that wants a way for a bus to tell its PHYs' consumers to let
go.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    Why the registration phase gives up where the wait for firmware does
    not: every failed registration repeats a bus creation, a message from
    the MDIO core and a pair of uevents. Firmware files are the opposite
    case, since the package carrying them can be installed at any time.
    
    Why the deferral is exempt, since the default configuration hides the
    reason. fwnode_mdiobus_phy_device_register() runs fwnode_irq_get()'s
    deferral through driver_deferred_probe_check_state(), which answers
    -ETIMEDOUT once deferred_probe_timeout has expired, or -ENODEV when the
    kernel is built without modules; neither escapes, and the PHY is
    registered with the bus default that mdiobus_alloc() filled with
    PHY_POLL. So a PHY that asks for an interrupt gets one only while its
    controller can still defer the registration. With the timeout at its
    default of ten seconds this driver, which registers only once firmware
    files can be read, is always past that point and never sees a deferral
    at all. But the timeout is a kernel parameter: a negative value is
    documented as infinite, the timer is then never armed, and every
    successful driver registration restarts it while it is pending. Under
    either setting the deferral persists until the dependency shows up, and
    a driver that stopped retrying after a minute would leave the PHY absent
    until reboot, with fw_running still true so neither the poller nor
    resume tries again.
    
    Why a failed reload on resume restores the chip and not the port: the
    PHY below resumes next, its phy_init_hw() runs against a chip still in
    its bootloader and fails, and when the poller later gets the firmware
    back nothing runs that resume again.
    
    Both lock helpers in the library take mdio_lock directly rather than
    through phylib's phy_lock_mdio_bus(), which keys off a phy_device: this
    code runs before one exists for the chip, and the child bus never has
    one at all.

 drivers/net/mdio/mdio-airoha-en8811h.c   | 203 +++++++++++++++++++++--
 drivers/net/phy/air_en8811h.c            |   7 +-
 drivers/net/phy/air_phy_lib.c            |  89 +++++++---
 drivers/net/phy/air_phy_lib.h            |   5 +-
 include/linux/mdio/mdio-airoha-en8811h.h |  11 +-
 5 files changed, 271 insertions(+), 44 deletions(-)

diff --git a/drivers/net/mdio/mdio-airoha-en8811h.c b/drivers/net/mdio/mdio-airoha-en8811h.c
index b88e3c014d15..7785525c57a6 100644
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
@@ -28,12 +30,109 @@ struct en8811h_mcu {
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
+	if (parent->read && parent->write) {
+		bus->read = en8811h_mcu_read;
+		bus->write = en8811h_mcu_write;
+	}
+	if (parent->read_c45 && parent->write_c45) {
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
 static void en8811h_mcu_fw_poll(struct work_struct *work)
 {
 	struct en8811h_mcu *mcu = container_of(to_delayed_work(work),
@@ -41,8 +140,12 @@ static void en8811h_mcu_fw_poll(struct work_struct *work)
 	struct device *dev = &mcu->mdiodev->dev;
 	int cached, ret;
 
-	ret = air_en8811h_fw_download(mcu->mdiodev, &mcu->fw_version);
-	if (ret >= 0) {
+	if (!mcu->fw_running) {
+		ret = air_en8811h_fw_download(mcu->mdiodev, &mcu->fw_version,
+					      mcu->bus);
+		if (ret < 0)
+			goto retry;
+
 		dev_dbg(dev, "firmware %08x running after %ums\n",
 			mcu->fw_version, mcu->waited_ms);
 		cached = firmware_request_cache(dev, EN8811H_MD32_DM);
@@ -50,19 +153,38 @@ static void en8811h_mcu_fw_poll(struct work_struct *work)
 		if (ret)
 			dev_warn(dev, "not cached, resume will read the files off a filesystem: %pe\n",
 				 ERR_PTR(ret));
-		return;
+		mcu->fw_running = true;
+		mcu->poll_ms = EN8811H_FW_POLL_MIN_MS;
+		mcu->waited_ms = 0;
+		mcu->warned = false;
 	}
 
+	/* Resume re-runs the download, so the bus can already be here. */
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
+			dev_warn(dev, "still no PHY at address %d, %ums after the firmware started: %pe\n",
+				 mcu->mdiodev->addr, mcu->waited_ms,
 				 ERR_PTR(ret));
 		mcu->warned = true;
 	}
 
+	/* Registering again repeats the MDIO core's message and its uevents,
+	 * so this phase gives up - except on a deferral, which only a retry
+	 * resolves and which deferred_probe_timeout can make permanent.
+	 */
+	if (mcu->fw_running && ret != -EPROBE_DEFER &&
+	    mcu->waited_ms >= EN8811H_FW_WARN_MS)
+		return;
+
 	/* Count the sleep ahead: the first run was immediate. */
 	mcu->waited_ms += mcu->poll_ms;
 	queue_delayed_work(system_freezable_wq, &mcu->fw_poll,
@@ -78,7 +200,7 @@ static void en8811h_mcu_reset_unless_running(struct en8811h_mcu *mcu)
 	u32 assert_us = 0, deassert_us = 0;
 	int ret;
 
-	ret = air_en8811h_mcu_running(mdiodev);
+	ret = air_en8811h_mcu_running(mdiodev, mcu->bus);
 	if (ret > 0) {
 		dev_dbg(dev, "MD32 already running, leaving reset alone\n");
 		return;
@@ -117,6 +239,8 @@ static int en8811h_mcu_probe(struct mdio_device *mdiodev)
 {
 	struct device *dev = &mdiodev->dev;
 	struct en8811h_mcu *mcu;
+	struct device_node *np;
+	unsigned int phys = 0;
 
 	mcu = devm_kzalloc(dev, sizeof(*mcu), GFP_KERNEL);
 	if (!mcu)
@@ -125,6 +249,43 @@ static int en8811h_mcu_probe(struct mdio_device *mdiodev)
 	mcu->mdiodev = mdiodev;
 	mdiodev_set_drvdata(mdiodev, mcu);
 
+	/* Registration needs this only once the firmware runs, but a DT
+	 * hole should fail the bind now, not as a work-item error later.
+	 */
+	np = of_get_child_by_name(dev->of_node, "mdio");
+	if (!np || !of_device_is_available(np)) {
+		of_node_put(np);
+		return dev_err_probe(dev, -ENODEV,
+				     "no usable mdio node describing the PHY\n");
+	}
+
+	/* Only the address this core occupies on the parent bus is passed
+	 * through, so a node at any other one will never respond.
+	 */
+	for_each_available_child_of_node_scoped(np, child) {
+		u32 addr;
+
+		if (of_property_read_u32(child, "reg", &addr))
+			continue;
+		if (addr != mdiodev->addr) {
+			dev_err(dev, "%pOF: address %u is not answered here, only %u\n",
+				child, addr, mdiodev->addr);
+			of_node_put(np);
+			return -EINVAL;
+		}
+		phys++;
+	}
+	of_node_put(np);
+
+	if (!phys)
+		return dev_err_probe(dev, -ENODEV,
+				     "mdio node describes no PHY\n");
+
+	/* A truncated bus name loses the address that makes it unique. */
+	if (strlen(dev_name(dev)) >= MII_BUS_ID_SIZE)
+		return dev_err_probe(dev, -ENAMETOOLONG,
+				     "name does not fit an MDIO bus id\n");
+
 	/* The core claims reset-gpios only for devices flagged as PHYs. */
 	mcu->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS);
 	if (IS_ERR(mcu->reset_gpio))
@@ -151,6 +312,10 @@ static void en8811h_mcu_remove(struct mdio_device *mdiodev)
 	struct en8811h_mcu *mcu = mdiodev_get_drvdata(mdiodev);
 
 	cancel_delayed_work_sync(&mcu->fw_poll);
+	if (mcu->bus) {
+		mdiobus_unregister(mcu->bus);
+		mdiobus_free(mcu->bus);
+	}
 }
 
 static int en8811h_mcu_resume(struct device *dev)
@@ -158,13 +323,27 @@ static int en8811h_mcu_resume(struct device *dev)
 	struct en8811h_mcu *mcu = dev_get_drvdata(dev);
 	int ret;
 
+	/* Nothing to redo: the poll is armed and thaws with everything else. */
+	if (!mcu->fw_running)
+		return 0;
+
 	/* Synchronous: the poll's workqueue is freezable and thaws only
 	 * after the resume callbacks have run.
 	 */
 	en8811h_mcu_reset_unless_running(mcu);
-	ret = air_en8811h_fw_download(mcu->mdiodev, &mcu->fw_version);
-	if (ret < 0)
-		dev_err(dev, "firmware not restored: %pe\n", ERR_PTR(ret));
+	ret = air_en8811h_fw_download(mcu->mdiodev, &mcu->fw_version, mcu->bus);
+	if (ret < 0) {
+		dev_err(dev, "firmware not restored, reloading: %pe\n",
+			ERR_PTR(ret));
+		mcu->fw_running = false;
+		mcu->poll_ms = EN8811H_FW_POLL_MIN_MS;
+		mcu->waited_ms = 0;
+		mcu->warned = false;
+		/* The poll may already be pending on a long backoff, and
+		 * queue_delayed_work() would leave that timer alone.
+		 */
+		mod_delayed_work(system_freezable_wq, &mcu->fw_poll, 0);
+	}
 
 	return 0;
 }
@@ -184,6 +363,8 @@ static struct mdio_driver en8811h_mcu_driver = {
 		.name = "airoha-en8811h-mcu",
 		.of_match_table = en8811h_mcu_of_match,
 		.pm = pm_sleep_ptr(&en8811h_mcu_pm_ops),
+		/* No safe teardown under an attached PHY. */
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index c9b46cfc854f..940379e2737b 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -258,7 +258,7 @@ static int en8811h_wait_mcu_ready(struct phy_device *phydev)
 {
 	int ret;
 
-	ret = air_en8811h_wait_mcu_ready(&phydev->mdio);
+	ret = air_en8811h_wait_mcu_ready(&phydev->mdio, false);
 	if (ret < 0)
 		phydev_err(phydev, "MCU not ready: %pe\n", ERR_PTR(ret));
 
@@ -324,7 +324,7 @@ static int an8811hb_load_file(struct phy_device *phydev, const char *name,
 	if (ret < 0)
 		return ret;
 
-	ret = air_fw_write_buf(&phydev->mdio, address, fw);
+	ret = air_fw_write_buf(&phydev->mdio, address, fw, false);
 	release_firmware(fw);
 	return ret;
 }
@@ -423,7 +423,8 @@ static int en8811h_load_firmware(struct phy_device *phydev)
 	struct en8811h_priv *priv = phydev->priv;
 	int ret;
 
-	ret = air_en8811h_fw_download(&phydev->mdio, &priv->firmware_version);
+	ret = air_en8811h_fw_download(&phydev->mdio, &priv->firmware_version,
+				      NULL);
 	if (ret < 0)
 		phydev_err(phydev, "Load firmware failed: %d\n", ret);
 	else
diff --git a/drivers/net/phy/air_phy_lib.c b/drivers/net/phy/air_phy_lib.c
index c71322f16c21..5902a6ba3643 100644
--- a/drivers/net/phy/air_phy_lib.c
+++ b/drivers/net/phy/air_phy_lib.c
@@ -272,8 +272,31 @@ static int __air_mdio_restore_page(struct mdio_device *mdiodev,
 	return ret;
 }
 
+static void air_mdiodev_lock(struct mdio_device *mdiodev, bool nested)
+{
+	if (nested)
+		mutex_lock_nested(&mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
+	else
+		mutex_lock(&mdiodev->bus->mdio_lock);
+}
+
+/* The PHY below reaches these registers under this lock through
+ * phy_select_page(); the firmware read must stay outside it.
+ */
+static void air_child_bus_lock(struct mii_bus *child_bus)
+{
+	if (child_bus)
+		mutex_lock(&child_bus->mdio_lock);
+}
+
+static void air_child_bus_unlock(struct mii_bus *child_bus)
+{
+	if (child_bus)
+		mutex_unlock(&child_bus->mdio_lock);
+}
+
 int air_fw_write_buf(struct mdio_device *mdiodev, u32 address,
-		     const struct firmware *fw)
+		     const struct firmware *fw, bool nested)
 {
 	size_t chunk, done = 0;
 	int saved_page, ret;
@@ -287,7 +310,7 @@ int air_fw_write_buf(struct mdio_device *mdiodev, u32 address,
 	while (done < fw->size) {
 		chunk = min_t(size_t, fw->size - done, AIR_FW_CHUNK_BYTES);
 
-		mutex_lock(&mdiodev->bus->mdio_lock);
+		air_mdiodev_lock(mdiodev, nested);
 
 		saved_page = __air_mdio_select_page(mdiodev,
 						    AIR_PHY_PAGE_EXTENDED_4);
@@ -313,11 +336,12 @@ int air_fw_write_buf(struct mdio_device *mdiodev, u32 address,
 EXPORT_SYMBOL_GPL(air_fw_write_buf);
 
 static int air_mdio_buckpbus_reg_read(struct mdio_device *mdiodev,
-				      u32 pbus_address, u32 *pbus_data)
+				      u32 pbus_address, u32 *pbus_data,
+				      bool nested)
 {
 	int saved_page, ret;
 
-	mutex_lock(&mdiodev->bus->mdio_lock);
+	air_mdiodev_lock(mdiodev, nested);
 
 	saved_page = __air_mdio_select_page(mdiodev, AIR_PHY_PAGE_EXTENDED_4);
 	if (saved_page < 0) {
@@ -333,11 +357,12 @@ static int air_mdio_buckpbus_reg_read(struct mdio_device *mdiodev,
 }
 
 static int air_mdio_buckpbus_reg_write(struct mdio_device *mdiodev,
-				       u32 pbus_address, u32 pbus_data)
+				       u32 pbus_address, u32 pbus_data,
+				       bool nested)
 {
 	int saved_page, ret;
 
-	mutex_lock(&mdiodev->bus->mdio_lock);
+	air_mdiodev_lock(mdiodev, nested);
 
 	saved_page = __air_mdio_select_page(mdiodev, AIR_PHY_PAGE_EXTENDED_4);
 	if (saved_page < 0) {
@@ -354,11 +379,12 @@ static int air_mdio_buckpbus_reg_write(struct mdio_device *mdiodev,
 }
 
 static int air_mdio_buckpbus_reg_modify(struct mdio_device *mdiodev,
-					u32 pbus_address, u32 mask, u32 set)
+					u32 pbus_address, u32 mask, u32 set,
+					bool nested)
 {
 	int saved_page, ret;
 
-	mutex_lock(&mdiodev->bus->mdio_lock);
+	air_mdiodev_lock(mdiodev, nested);
 
 	saved_page = __air_mdio_select_page(mdiodev, AIR_PHY_PAGE_EXTENDED_4);
 	if (saved_page < 0) {
@@ -399,20 +425,25 @@ static int __air_mmd_read(struct mdio_device *mdiodev, u16 devad, u16 regnum)
 	return __mdiobus_read(bus, addr, MII_MMD_DATA);
 }
 
-static int air_mmd_status_read(struct mdio_device *mdiodev)
+static int air_mmd_status_read(struct mdio_device *mdiodev, bool nested)
 {
 	int ret;
 
-	mutex_lock(&mdiodev->bus->mdio_lock);
+	air_mdiodev_lock(mdiodev, nested);
 	ret = __air_mmd_read(mdiodev, MDIO_MMD_VEND1, EN8811H_PHY_FW_STATUS);
 	mutex_unlock(&mdiodev->bus->mdio_lock);
 
 	return ret;
 }
 
-int air_en8811h_mcu_running(struct mdio_device *mdiodev)
+int air_en8811h_mcu_running(struct mdio_device *mdiodev,
+			    struct mii_bus *child_bus)
 {
-	int ret = air_mmd_status_read(mdiodev);
+	int ret;
+
+	air_child_bus_lock(child_bus);
+	ret = air_mmd_status_read(mdiodev, !!child_bus);
+	air_child_bus_unlock(child_bus);
 
 	if (ret < 0)
 		return ret;
@@ -421,12 +452,12 @@ int air_en8811h_mcu_running(struct mdio_device *mdiodev)
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
 
@@ -436,7 +467,7 @@ int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev)
 	ret = read_poll_timeout(air_mmd_status_read, reg_value,
 				reg_value < 0 ||
 				reg_value == EN8811H_PHY_READY,
-				20000, 7500000, true, mdiodev);
+				20000, 7500000, true, mdiodev, nested);
 	if (reg_value < 0)
 		return reg_value;
 	if (ret) {
@@ -448,19 +479,23 @@ int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev)
 }
 EXPORT_SYMBOL_GPL(air_en8811h_wait_mcu_ready);
 
-int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version)
+int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version,
+			    struct mii_bus *child_bus)
 {
 	struct device *dev = &mdiodev->dev;
 	const struct firmware *fw1, *fw2;
+	bool nested = !!child_bus;
 	int ret;
 
-	ret = air_en8811h_mcu_running(mdiodev);
+	ret = air_en8811h_mcu_running(mdiodev, child_bus);
 	if (ret < 0)
 		return ret;
 
 	if (ret) {
+		air_child_bus_lock(child_bus);
 		ret = air_mdio_buckpbus_reg_read(mdiodev, EN8811H_FW_VERSION,
-						 fw_version);
+						 fw_version, nested);
+		air_child_bus_unlock(child_bus);
 		if (ret < 0)
 			return ret;
 
@@ -475,38 +510,42 @@ int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version)
 	if (ret < 0)
 		goto air_fw_download_rel1;
 
+	air_child_bus_lock(child_bus);
+
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
 
 air_fw_download_out:
+	air_child_bus_unlock(child_bus);
 	release_firmware(fw2);
 
 air_fw_download_rel1:
diff --git a/drivers/net/phy/air_phy_lib.h b/drivers/net/phy/air_phy_lib.h
index 764f832a02a7..5f6f09446008 100644
--- a/drivers/net/phy/air_phy_lib.h
+++ b/drivers/net/phy/air_phy_lib.h
@@ -60,8 +60,9 @@ int air_phy_buckpbus_reg_write(struct phy_device *phydev, u32 pbus_address,
 int air_phy_read_page(struct phy_device *phydev);
 int air_phy_write_page(struct phy_device *phydev, int page);
 
+/* nested: the caller already holds the child bus this chip publishes. */
 int air_fw_write_buf(struct mdio_device *mdiodev, u32 address,
-		     const struct firmware *fw);
-int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev);
+		     const struct firmware *fw, bool nested);
+int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev, bool nested);
 
 #endif /* __AIR_PHY_LIB_H */
diff --git a/include/linux/mdio/mdio-airoha-en8811h.h b/include/linux/mdio/mdio-airoha-en8811h.h
index 8a073a1b7ee6..383ff4a7f6a1 100644
--- a/include/linux/mdio/mdio-airoha-en8811h.h
+++ b/include/linux/mdio/mdio-airoha-en8811h.h
@@ -10,15 +10,20 @@
 #include <linux/types.h>
 
 struct mdio_device;
+struct mii_bus;
 
 #define EN8811H_MD32_DM			"airoha/EthMD32.dm.bin"
 #define EN8811H_MD32_DSP		"airoha/EthMD32.DSP.bin"
 
-/* Returns 1 when the firmware runs, 0 when the MD32 is still in its
+/* child_bus is the bus this chip publishes below mdiodev, or NULL.
+ *
+ * Returns 1 when the firmware runs, 0 when the MD32 is still in its
  * bootloader, and negative on a failed status read.
  */
-int air_en8811h_mcu_running(struct mdio_device *mdiodev);
+int air_en8811h_mcu_running(struct mdio_device *mdiodev,
+			    struct mii_bus *child_bus);
 /* Returns 1 when firmware was already running and was left in place. */
-int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version);
+int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version,
+			    struct mii_bus *child_bus);
 
 #endif /* __LINUX_MDIO_AIROHA_EN8811H_H */
-- 
2.53.0

