Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B6C51474A
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548611; cv=none; b=l2jA/gDBqiWNqqqvQwxoBBgLhwipFk3mz2WrzoJ5No7lDWigyVBb+am7eFjELMbjqfyFhKQs8crT5ob+/Px6Zed1ovF97NXLVdHEBlR9pSFyv1LKdD5Sa4IBrV7ux5t8jCavm6OQQobd0MwsP/eo0EwRbZsvYvs2yG4OVdOXg0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548611; c=relaxed/simple;
	bh=JBz2NQi/Bv+zFtP/6/uWkbFU+cjjjMSWIux6M1Takzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3MY3sGbwFNOec1hDNovQl0fgYjSDiqfHbV2NbJBKYyPP51gVjxIiZ6MjBZzM8A342EKBm9GyIoZqxYJkNu/0KjuQuFtaebfkWcSx8BOZI5GmRy0P+NyoFbawCyyfDVA0hpE+Fw9nhMcZ9/v9HECqWm3s5VvyEclZopIXKJXCZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=W8/CKSqg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="W8/CKSqg"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49cd9add88aso9745325e9.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 12:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788548598; x=1789153398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0/1c+HSbaGv+gRPu7wfaFP7mAOnMXFXKdtCxWbULAdA=;
        b=W8/CKSqgE+uTj0HpQPV0h5Ogg737/dlEsYYWy4oZRQXTiPJSW5Fr9Y99c65MvXLUcm
         Y1SEIToIEQqdUXgqlvjCFApp4tvXRXEdnTdxgoyzh/BbIhU1zMW7FWQGslonu859WFOF
         CqKcLxL5de6snWk/zYRb+wib4X2kpBn2q+hPACAEH6JMERTMrAUUPhB14u1PTpTQ7HCq
         ysmF2wDd1OHSNLH79p/X1Pv7n9oqP+eRcsZXeMyom7N7FDn9HDGJ6yqUUnjeO/mpPcCo
         cWmq4fOKcMaM0ZbmdU5TphCYT2pYphkesieozQGgrCjjjNDDHICN0Js6ZvCFPBm5JmOy
         Q4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788548598; x=1789153398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0/1c+HSbaGv+gRPu7wfaFP7mAOnMXFXKdtCxWbULAdA=;
        b=UM8ldp19xxDaMoOnrLhgJFPrgVO9WvmkEd7R9Ap/nOeLFfYlChCLMAAxcG/QzTpij/
         w7VCXbg581YzFgez4MluwF/UAbk3OLAy2LFIjTutAJ/uORVJ4zaf3RwQXbWXSUpPCr09
         tCZaQrS1EfRldQqclckB0Droh2xxaHd0eXZvQ+pg2Q7XOFvOR15lYXAJYu/741I0Z3XO
         /8tY0/hlX3HCOverPOkdSpnZohTJ2CvY9qKfh1E+VwwIA2tX1NfE9W3WXzW4+OUFBg4F
         0UyKFvUezOy/qQPUPesaZ9vY748zghufCU7Fb2c/I+SKu9K7p5QT6VYhCT/N5TTxSDN2
         dbrw==
X-Forwarded-Encrypted: i=1; AKwUvByb3lvxM2VyR7uTNoOI4HB0sdYhf6bUQM0LskpAb0c4aftdCdrOaC4dJA3GnKVKFybsJWks8WM=@vger.kernel.org
X-Gm-Message-State: AFuF++nf+W7HryPKT3+KHbg48B1KnpYT/+ialmJYzUKfiiZHVR3B+yLQ
	w2GAHzWbrjtnnUc179kzp7/Cvkh3OAXHeFUG+4kPLZFffpFOA6w+3nQLPLLXWBku+Us=
X-Gm-Gg: AYBFou1HIjEMGCoZ64iwqcqwfQgqqkL2hy/lNmHNCsa67aWW6RIidPkMK7c4qh+98Ik
	pJBA08Y1/J2ObjlNdt1dszSYQKJ31LSfJa6IDoOCUcD9otsBXLJ4zaD8UojFZVcHA1zTVdfU34g
	mxNXixaTnGqoqFVUbdTF5t0gwoXzuPtQ8KKhGi+H9IUM1e+HIXj37EMVOeOrtSOg4OwHWD58Gc8
	slvKurCOzw7h5V71xvju1QyajpS195fOfXmDWh5MPefzPqu3qN3MrWrGiUlOoAJgIeidQmh7w3N
	G80gvspKWWulPYlnHoQ+97+VJsUoh/lhV3z7ZjPFl3KotkmdA/BmlTOp74ypSDovHXA0JWQ8Q0i
	ird3qigaKg6eZ5w33CPDSjaR6wUpOpfWsO9GUO2yBOszA8BD3+rbosDuDoaFFbkEVGLLgI5OSwS
	i/eaTPRDXy3hPRb4ZMjJvHVU52+kFrIrXFLDmaMjY=
X-Received: by 2002:a05:600c:1914:b0:49c:ff23:a6d5 with SMTP id 5b1f17b1804b1-49cff23a70bmr35293945e9.0.1788548597648;
        Fri, 04 Sep 2026 12:03:17 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d8a6sm172195485e9.10.2026.09.04.12.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:03:17 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next v2 08/10] net: mdio: en8811h: add the nested pass-through bus
Date: Fri,  4 Sep 2026 19:03:02 +0000
Message-ID: <9fefcf920098876766f6ce7ce0f6646e89ea3181.1788548229.git.f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788548229.git.f@lex.la>
References: <cover.1788548229.git.f@lex.la>
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
the reset line the PHY must not touch.

Only the address the MD32 answers on is passed through; every other
address returns -ENODEV, so scanning this bus cannot produce anything
but this chip's PHY. phy_mask would express the same thing but is not
usable here: of_mdiobus_register() overwrites it before walking the
children. The parent's interrupt for that address is carried over,
since a parent that fills irq[] from its own interrupt domain - a
switch, say - would otherwise leave the PHY polling; an interrupts
property on the PHY's node still wins.

Reach the parent through the mdiobus_*_nested() accessors, which take
its lock at MDIO_MUTEX_NESTED, the way the DSA drivers reach through a
child bus into their parent.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/mdio/mdio-airoha-en8811h.c | 134 +++++++++++++++++++++++--
 1 file changed, 128 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mdio/mdio-airoha-en8811h.c b/drivers/net/mdio/mdio-airoha-en8811h.c
index 595b1b72bc01..222aa4b11b95 100644
--- a/drivers/net/mdio/mdio-airoha-en8811h.c
+++ b/drivers/net/mdio/mdio-airoha-en8811h.c
@@ -13,6 +13,8 @@
 #include <linux/mdio.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
 #include <linux/property.h>
 #include <linux/workqueue.h>
 
@@ -26,12 +28,104 @@ struct en8811h_mcu {
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
+	struct device *dev = &mcu->mdiodev->dev;
+	struct mii_bus *parent = mcu->mdiodev->bus;
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
+	bus->irq[mcu->mdiodev->addr] = parent->irq[mcu->mdiodev->addr];
+
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
@@ -39,21 +133,35 @@ static void en8811h_mcu_fw_poll(struct work_struct *work)
 	struct device *dev = &mcu->mdiodev->dev;
 	int ret;
 
-	ret = air_en8811h_fw_download(mcu->mdiodev, &mcu->fw_version);
-	if (ret >= 0) {
+	if (!mcu->fw_running) {
+		ret = air_en8811h_fw_download(mcu->mdiodev, &mcu->fw_version);
+		if (ret < 0)
+			goto retry;
+
 		dev_dbg(dev, "firmware %08x running after %ums\n",
 			mcu->fw_version, mcu->waited_ms);
-		return;
+		/* Registration is a new phase: its own backoff and warning. */
+		mcu->fw_running = true;
+		mcu->poll_ms = EN8811H_FW_POLL_MIN_MS;
+		mcu->warned = false;
 	}
 
+	/* fwnode_mdio defers while the PHY node's interrupt controller is
+	 * missing, so a failure here is not necessarily permanent.
+	 */
+	ret = en8811h_mcu_bus_register(mcu);
+	if (!ret)
+		return;
+
+retry:
 	mcu->waited_ms += mcu->poll_ms;
 	if (!mcu->warned && mcu->waited_ms >= EN8811H_FW_WARN_MS) {
-		if (ret == -ENOENT)
+		if (!mcu->fw_running && ret == -ENOENT)
 			dev_warn(dev, "still waiting for %s and %s\n",
 				 EN8811H_MD32_DM, EN8811H_MD32_DSP);
 		else
-			dev_warn(dev, "firmware download keeps failing: %pe\n",
-				 ERR_PTR(ret));
+			dev_warn(dev, "PHY not up after %ums: %pe\n",
+				 mcu->waited_ms, ERR_PTR(ret));
 		mcu->warned = true;
 	}
 
@@ -99,6 +207,7 @@ static int en8811h_mcu_probe(struct mdio_device *mdiodev)
 {
 	struct device *dev = &mdiodev->dev;
 	struct en8811h_mcu *mcu;
+	struct device_node *np;
 
 	mcu = devm_kzalloc(dev, sizeof(*mcu), GFP_KERNEL);
 	if (!mcu)
@@ -107,6 +216,15 @@ static int en8811h_mcu_probe(struct mdio_device *mdiodev)
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
@@ -133,6 +251,10 @@ static void en8811h_mcu_remove(struct mdio_device *mdiodev)
 	struct en8811h_mcu *mcu = mdiodev_get_drvdata(mdiodev);
 
 	cancel_delayed_work_sync(&mcu->fw_poll);
+	if (mcu->bus) {
+		mdiobus_unregister(mcu->bus);
+		mdiobus_free(mcu->bus);
+	}
 }
 
 static const struct of_device_id en8811h_mcu_of_match[] = {
-- 
2.53.0

