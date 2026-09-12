Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7383747ECEB
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218289; cv=none; b=tXZVmAieSMj7QEljINZf/pUJeM9DBM3FN8XCT9D18KTuhxHXDAvgg87QXTKIWroSxbr9ntRXh6a3nonrb0WQxXI7Z29l/ua1tfuVlcvivtqsMi8LEEzJ3TBlWn9+AoI/zyIFS73KcVEz+LKxZ5FXvS7l6+17y3KgE6/TiDkaVUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218289; c=relaxed/simple;
	bh=XAoueMXgvCKdDmh9hu+fwEppagChbFelaFT9vHw64Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6WkWsZ5+5uCCnBFFy6saUcTGC3f2Xn3J1AjF83gvCCnlNimpjuNmLFpQDb2PkG+3/2ZKQDgb/2ID5/vFau190vqrJj8aTSy4RlKRoTC/dzighVwTy2PV2NhvdUiLrVLqJrDHt5MQpqgiSB7GnjefFLzN62m/wa17i9OdcNna0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=X+PfcoD4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="X+PfcoD4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so13706625e9.3
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 06:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789218284; x=1789823084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rdBss+NKC17hYBCRngZWh8I9bnRJtJ0u4Ve5Alj1nxA=;
        b=X+PfcoD4L7HWqjJkQKy+8mYzPklhFYYKXLU4v97xXAgqy1Xo8me9A1oNKZNmxwzdGw
         7uMkyCSUXRKi+fE3ko+4c+8caiTzDr/rRF1wgU7VLhSdNLQtG8Mc5vk9b8faqYQJBv8Q
         oie2TOoBYCiMtP0cHA3FbnfFem82HKtDMrJThQOluTYc+eyYWCjoN3I1sIct/3nI1bRq
         i4ceX2esExHNGwHjJYkjKZp0vIGIxMkgoiuuOKw3mVgZim3b6YAmCjpes5YJp/TWiDD2
         yHAJlAZjiytm8/ieyZs9nqsqnVPxmqHVOilgpOFUqSKJ6lvvPyapxwdg3maLI8m2exk2
         kAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789218284; x=1789823084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rdBss+NKC17hYBCRngZWh8I9bnRJtJ0u4Ve5Alj1nxA=;
        b=lZR57OPaT/SiOGxzBo+uIjKrIpMyZYPPPgh4mns6DBKjLzeCi0p/P91SLJU/VUrM4f
         s7uoochvo5023tBdOv4GJShrgXT/Fas/YYb3p58C3gKMANSoE2MIa/c2eVttSTpGSw49
         oASmd0pQ18bYo+l1TF7ZikjrCCrG7JSVNqIJtUCtGLT0/Rc9J3Sb6cStcKI+/fzrppJm
         HOxxKAslgvNV0SUwGD1lLjnYujo0574JqMqEgorIPLcKwg4hybug0SeTX2PuS6jwYQAN
         pEFMnpongYMffTyf3mwaRM8CSO4ESDp6VCngx23RFjbCO3iHvXovlTEEXf41xVhOSX+I
         MlnQ==
X-Forwarded-Encrypted: i=1; AKwUvBykKwWOWj+8aGoRw8ePhiaLqzjoqMFUK/V85qjle8Fjapf+UT9+BrJh7kOnZzHNc4ltnN/Hcj8=@vger.kernel.org
X-Gm-Message-State: AFuF++kQAGKtdw6YNXTyvUzuwYDzoSxD9pAd9H58u9hfHDmJa2bZUVM4
	TcyM3nvFzwyKdQTkQbSNWVcvZQKnYBYn1VKZdBgu2KpztdzclP80AXifSrhanexI11k=
X-Gm-Gg: AYBFou22D6XT2M0bcGSbKIMYxfFuKxQKozoOMbu1JCy5/7F1YyFcxdpQKiL7QxdUs6m
	IbA86hheXEskBJF7eEJyzPnu2RsNmkFg/cFeguR8Rc7z7ShBnsS/GCAEel6RLme0kwLxQ2uRsp4
	Gfhic6KA9ASvwJZv3OxoNMOhKZPhBxJT39UR/opCMfIZDojmVs0OCoqJkE/IFlWdTWXcckRLqMJ
	RQpMjYybs7Yq0qtHeTE/kzAj8rTHrgf6ZsnrsmSJHz5cxI7KvZm9DPp87DyRYfXT8HJoJOnFZbY
	hC9SsWMFuhld3rSPBNTeWoA4qaBOtjBbF/iVrusDAGnAB7x3nJi1tSNvkzl7IzjRoRCKXQjdrFI
	05kEisr2ORurYlfORcbC47diFj2QEbQjYe/fGSDfZ3qfNaCTitbfo3OLLSWEG/NyJdDI3P/5gdi
	uHVylyfrGgR+1q686LnIit4QGtuLJs9/T6OJaFU4j/kri7XeaZvw8bgYl0BBUw
X-Received: by 2002:a05:600c:8705:b0:49d:17a8:211a with SMTP id 5b1f17b1804b1-49e619d89a7mr105000865e9.28.1789218283881;
        Sat, 12 Sep 2026 06:04:43 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6a06cfb8sm80985785e9.5.2026.09.12.06.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:04:43 -0700 (PDT)
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
Subject: [RFC PATCH net-next v3 5/6] net: mdio: add Airoha EN8811H MDIO device driver
Date: Sat, 12 Sep 2026 16:04:29 +0300
Message-ID: <20260912130430.2246285-6-f@lex.la>
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

Until its firmware has been downloaded the EN8811H is not an Ethernet
PHY, it is an MD32 microcontroller waiting in its bootloader. On
systems that keep the firmware files in a filesystem, the files become
readable long after the MDIO bus was scanned, and the PHY driver's
probe-time download then cannot work at boot.

Describe the chip as an MDIO device that polls for the files and
downloads through the shared library helper once they can be read; a
chip left running by the bootloader is adopted as-is. Polling rather
than deferred probing because request_firmware_direct() has no
usermode-helper fallback: an unmounted rootfs fails at once, and a
deferral only leaves the device on the deferred-probe list until
something else retries it, which need not happen when the files
appear. There is no give-up path, since installing the firmware
package on a running system is a normal thing to do.

The reset line is claimed here rather than on the PHY node, and it is
cycled only while the MD32 does not report a running firmware: that
firmware lives in volatile RAM, so an assert on a running chip - such
as the one phy_detach() performs on a PHY-node reset - would wipe it.

Resume repeats the reset decision and the download in line, since a
suspend that cut power leaves the MD32 back in its bootloader.

Nothing yet publishes a PHY: this driver takes the chip over, and the
bus that exposes it to the device tree is the next patch.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    Splitting the series there keeps the download and its retry policy
    separate from what registering a bus costs, which is its own failure
    mode with its own backoff.
    
    A status read that fails says nothing about the firmware, so the reset
    line is left alone unless it is already asserted; clearing an asserted
    one is worth a try, since nothing answers through it.
    
    The download registers both blobs with the firmware cache, so the reload
    on resume reaches a filesystem only if that registration failed. On the
    download path that registration is already done: request_firmware_direct()
    passes no FW_OPT_NOCACHE, so assign_fw() has called fw_add_devm_name()
    for both names. It is the adoption path, which never calls
    request_firmware at all, that needs it.
    
    The reload on resume is not cheap: 144 KB over MDIO is about two seconds,
    and the readiness poll after it allows another seven and a half. The rest
    of the resume chain waits for it, which is the price of having the
    firmware back before the PHY below runs its own resume.

 MAINTAINERS                              |   2 +
 drivers/net/mdio/Kconfig                 |  13 ++
 drivers/net/mdio/Makefile                |   1 +
 drivers/net/mdio/mdio-airoha-en8811h.c   | 197 +++++++++++++++++++++++
 drivers/net/phy/air_phy_lib.c            |   1 +
 drivers/net/phy/air_phy_lib.h            |   8 +-
 include/linux/mdio/mdio-airoha-en8811h.h |  24 +++
 7 files changed, 239 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/mdio/mdio-airoha-en8811h.c
 create mode 100644 include/linux/mdio/mdio-airoha-en8811h.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ca19275f4d0..3bd86df2be57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -755,6 +755,8 @@ M:	Aleksei Sviridkin <f@lex.la>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml
+F:	drivers/net/mdio/mdio-airoha-en8811h.c
+F:	include/linux/mdio/mdio-airoha-en8811h.h
 
 AIROHA ETHERNET DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index d44278f26fab..57c83bfd4090 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -29,6 +29,19 @@ config MDIO_AIROHA
 	  This module provides a driver for the MDIO busses found in the
 	  Airoha AN7583 SoC's.
 
+config MDIO_AIROHA_EN8811H
+	tristate "Airoha EN8811H MDIO device support"
+	depends on OF_MDIO
+	depends on FW_LOADER
+	select AIR_NET_PHYLIB
+	imply AIR_EN8811H_PHY
+	help
+	  This module provides a driver for the Airoha EN8811H, which is an
+	  MD32 microcontroller until firmware is downloaded into it and only
+	  becomes an Ethernet PHY afterwards. The driver downloads that
+	  firmware once it becomes readable, or leaves in place firmware a
+	  bootloader already started.
+
 config MDIO_SUN4I
 	tristate "Allwinner sun4i MDIO interface support"
 	depends on ARCH_SUNXI || COMPILE_TEST
diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
index 048586746026..06d096675dac 100644
--- a/drivers/net/mdio/Makefile
+++ b/drivers/net/mdio/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_FWNODE_MDIO)	+= fwnode_mdio.o
 obj-$(CONFIG_OF_MDIO)		+= of_mdio.o
 
 obj-$(CONFIG_MDIO_AIROHA)		+= mdio-airoha.o
+obj-$(CONFIG_MDIO_AIROHA_EN8811H)	+= mdio-airoha-en8811h.o
 obj-$(CONFIG_MDIO_ASPEED)		+= mdio-aspeed.o
 obj-$(CONFIG_MDIO_BCM_IPROC)		+= mdio-bcm-iproc.o
 obj-$(CONFIG_MDIO_BCM_UNIMAC)		+= mdio-bcm-unimac.o
diff --git a/drivers/net/mdio/mdio-airoha-en8811h.c b/drivers/net/mdio/mdio-airoha-en8811h.c
new file mode 100644
index 000000000000..b88e3c014d15
--- /dev/null
+++ b/drivers/net/mdio/mdio-airoha-en8811h.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Airoha EN8811H MDIO device driver
+ *
+ * The EN8811H is an MD32 microcontroller until firmware is downloaded into
+ * it, and only then an Ethernet PHY.
+ *
+ * Copyright (C) 2026 Aleksei Sviridkin <f@lex.la>
+ */
+
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mdio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm.h>
+#include <linux/property.h>
+#include <linux/workqueue.h>
+
+#include <linux/mdio/mdio-airoha-en8811h.h>
+
+#define EN8811H_FW_POLL_MIN_MS	1000
+#define EN8811H_FW_POLL_MAX_MS	30000
+#define EN8811H_FW_WARN_MS	60000
+
+struct en8811h_mcu {
+	struct mdio_device *mdiodev;
+	struct gpio_desc *reset_gpio;
+	struct delayed_work fw_poll;
+	unsigned int poll_ms;
+	unsigned int waited_ms;
+	u32 fw_version;
+	bool warned;
+};
+
+static void en8811h_mcu_fw_poll(struct work_struct *work)
+{
+	struct en8811h_mcu *mcu = container_of(to_delayed_work(work),
+					       struct en8811h_mcu, fw_poll);
+	struct device *dev = &mcu->mdiodev->dev;
+	int cached, ret;
+
+	ret = air_en8811h_fw_download(mcu->mdiodev, &mcu->fw_version);
+	if (ret >= 0) {
+		dev_dbg(dev, "firmware %08x running after %ums\n",
+			mcu->fw_version, mcu->waited_ms);
+		cached = firmware_request_cache(dev, EN8811H_MD32_DM);
+		ret = firmware_request_cache(dev, EN8811H_MD32_DSP) ?: cached;
+		if (ret)
+			dev_warn(dev, "not cached, resume will read the files off a filesystem: %pe\n",
+				 ERR_PTR(ret));
+		return;
+	}
+
+	if (!mcu->warned && mcu->waited_ms >= EN8811H_FW_WARN_MS) {
+		if (ret == -ENOENT)
+			dev_warn(dev, "still waiting for %s and %s\n",
+				 EN8811H_MD32_DM, EN8811H_MD32_DSP);
+		else
+			dev_warn(dev, "firmware download keeps failing: %pe\n",
+				 ERR_PTR(ret));
+		mcu->warned = true;
+	}
+
+	/* Count the sleep ahead: the first run was immediate. */
+	mcu->waited_ms += mcu->poll_ms;
+	queue_delayed_work(system_freezable_wq, &mcu->fw_poll,
+			   msecs_to_jiffies(mcu->poll_ms));
+	mcu->poll_ms = min(mcu->poll_ms * 2, EN8811H_FW_POLL_MAX_MS);
+}
+
+/* The firmware lives in volatile RAM: no reset while the MD32 reports ready. */
+static void en8811h_mcu_reset_unless_running(struct en8811h_mcu *mcu)
+{
+	struct mdio_device *mdiodev = mcu->mdiodev;
+	struct device *dev = &mdiodev->dev;
+	u32 assert_us = 0, deassert_us = 0;
+	int ret;
+
+	ret = air_en8811h_mcu_running(mdiodev);
+	if (ret > 0) {
+		dev_dbg(dev, "MD32 already running, leaving reset alone\n");
+		return;
+	}
+
+	if (!mcu->reset_gpio)
+		return;
+
+	/* A failed read does not mean the firmware is gone: leave a
+	 * deasserted line alone, and clear an asserted one before giving up.
+	 */
+	if (ret < 0 && gpiod_get_value_cansleep(mcu->reset_gpio) <= 0) {
+		dev_dbg(dev, "MD32 state unknown (%d), leaving reset alone\n",
+			ret);
+		return;
+	}
+
+	device_property_read_u32(dev, "reset-assert-us", &assert_us);
+	device_property_read_u32(dev, "reset-deassert-us", &deassert_us);
+
+	ret = gpiod_direction_output(mcu->reset_gpio, 1);
+	if (ret) {
+		dev_warn(dev, "reset not asserted: %pe\n", ERR_PTR(ret));
+		return;
+	}
+
+	if (assert_us)
+		fsleep(assert_us);
+
+	gpiod_set_value_cansleep(mcu->reset_gpio, 0);
+	if (deassert_us)
+		fsleep(deassert_us);
+}
+
+static int en8811h_mcu_probe(struct mdio_device *mdiodev)
+{
+	struct device *dev = &mdiodev->dev;
+	struct en8811h_mcu *mcu;
+
+	mcu = devm_kzalloc(dev, sizeof(*mcu), GFP_KERNEL);
+	if (!mcu)
+		return -ENOMEM;
+
+	mcu->mdiodev = mdiodev;
+	mdiodev_set_drvdata(mdiodev, mcu);
+
+	/* The core claims reset-gpios only for devices flagged as PHYs. */
+	mcu->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS);
+	if (IS_ERR(mcu->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(mcu->reset_gpio),
+				     "failed to get reset GPIO\n");
+
+	if (mcu->reset_gpio)
+		gpiod_set_consumer_name(mcu->reset_gpio, "EN8811H reset");
+
+	en8811h_mcu_reset_unless_running(mcu);
+
+	mcu->poll_ms = EN8811H_FW_POLL_MIN_MS;
+	INIT_DELAYED_WORK(&mcu->fw_poll, en8811h_mcu_fw_poll);
+	/* Freezable: neither the file lookup nor the download may land on
+	 * a suspending bus.
+	 */
+	queue_delayed_work(system_freezable_wq, &mcu->fw_poll, 0);
+
+	return 0;
+}
+
+static void en8811h_mcu_remove(struct mdio_device *mdiodev)
+{
+	struct en8811h_mcu *mcu = mdiodev_get_drvdata(mdiodev);
+
+	cancel_delayed_work_sync(&mcu->fw_poll);
+}
+
+static int en8811h_mcu_resume(struct device *dev)
+{
+	struct en8811h_mcu *mcu = dev_get_drvdata(dev);
+	int ret;
+
+	/* Synchronous: the poll's workqueue is freezable and thaws only
+	 * after the resume callbacks have run.
+	 */
+	en8811h_mcu_reset_unless_running(mcu);
+	ret = air_en8811h_fw_download(mcu->mdiodev, &mcu->fw_version);
+	if (ret < 0)
+		dev_err(dev, "firmware not restored: %pe\n", ERR_PTR(ret));
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(en8811h_mcu_pm_ops, NULL, en8811h_mcu_resume);
+
+static const struct of_device_id en8811h_mcu_of_match[] = {
+	{ .compatible = "airoha,en8811h-mcu" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, en8811h_mcu_of_match);
+
+static struct mdio_driver en8811h_mcu_driver = {
+	.probe = en8811h_mcu_probe,
+	.remove = en8811h_mcu_remove,
+	.mdiodrv.driver = {
+		.name = "airoha-en8811h-mcu",
+		.of_match_table = en8811h_mcu_of_match,
+		.pm = pm_sleep_ptr(&en8811h_mcu_pm_ops),
+	},
+};
+
+mdio_module_driver(en8811h_mcu_driver);
+
+MODULE_FIRMWARE(EN8811H_MD32_DM);
+MODULE_FIRMWARE(EN8811H_MD32_DSP);
+
+MODULE_DESCRIPTION("Airoha EN8811H MDIO device driver");
+MODULE_AUTHOR("Aleksei Sviridkin <f@lex.la>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/phy/air_phy_lib.c b/drivers/net/phy/air_phy_lib.c
index 2b1a73beca8d..c71322f16c21 100644
--- a/drivers/net/phy/air_phy_lib.c
+++ b/drivers/net/phy/air_phy_lib.c
@@ -419,6 +419,7 @@ int air_en8811h_mcu_running(struct mdio_device *mdiodev)
 
 	return ret == EN8811H_PHY_READY;
 }
+EXPORT_SYMBOL_GPL(air_en8811h_mcu_running);
 
 int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev)
 {
diff --git a/drivers/net/phy/air_phy_lib.h b/drivers/net/phy/air_phy_lib.h
index 47b4bd0b7c1e..764f832a02a7 100644
--- a/drivers/net/phy/air_phy_lib.h
+++ b/drivers/net/phy/air_phy_lib.h
@@ -8,6 +8,7 @@
 #ifndef __AIR_PHY_LIB_H
 #define __AIR_PHY_LIB_H
 
+#include <linux/mdio/mdio-airoha-en8811h.h>
 #include <linux/phy.h>
 
 struct firmware;
@@ -36,9 +37,6 @@ struct firmware;
 #define AIR_BPBUS_RD_DATA_HIGH		0x17
 #define AIR_BPBUS_RD_DATA_LOW		0x18
 
-#define EN8811H_MD32_DM			"airoha/EthMD32.dm.bin"
-#define EN8811H_MD32_DSP		"airoha/EthMD32.DSP.bin"
-
 #define AIR_FW_ADDR_DM			0x00000000
 #define AIR_FW_ADDR_DSP			0x00100000
 
@@ -64,10 +62,6 @@ int air_phy_write_page(struct phy_device *phydev, int page);
 
 int air_fw_write_buf(struct mdio_device *mdiodev, u32 address,
 		     const struct firmware *fw);
-/* Returns 1 running, 0 dormant, negative on a failed status read. */
-int air_en8811h_mcu_running(struct mdio_device *mdiodev);
 int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev);
-/* Returns 1 when it adopted firmware that was already running. */
-int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version);
 
 #endif /* __AIR_PHY_LIB_H */
diff --git a/include/linux/mdio/mdio-airoha-en8811h.h b/include/linux/mdio/mdio-airoha-en8811h.h
new file mode 100644
index 000000000000..8a073a1b7ee6
--- /dev/null
+++ b/include/linux/mdio/mdio-airoha-en8811h.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023, 2026 Airoha Technology Corp.
+ * Copyright (C) 2026 Aleksei Sviridkin <f@lex.la>
+ */
+
+#ifndef __LINUX_MDIO_AIROHA_EN8811H_H
+#define __LINUX_MDIO_AIROHA_EN8811H_H
+
+#include <linux/types.h>
+
+struct mdio_device;
+
+#define EN8811H_MD32_DM			"airoha/EthMD32.dm.bin"
+#define EN8811H_MD32_DSP		"airoha/EthMD32.DSP.bin"
+
+/* Returns 1 when the firmware runs, 0 when the MD32 is still in its
+ * bootloader, and negative on a failed status read.
+ */
+int air_en8811h_mcu_running(struct mdio_device *mdiodev);
+/* Returns 1 when firmware was already running and was left in place. */
+int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version);
+
+#endif /* __LINUX_MDIO_AIROHA_EN8811H_H */
-- 
2.53.0

