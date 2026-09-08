Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8C458495C
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883046; cv=none; b=LDntrVxIDFuz9ywhcF1o0KoftTwixm9fUNEiKJ1FdH9z2T3i0FE+yGVD1QsNAgX9CO9Eco63+c/5OdA35Ciy6qzBNxK+6qKumV3+u41s7V27gH1IizuccAHj8gFsOwMW1s1u+gNhZS6fB+uN4hvZcjOGQ8k4wPXRj5rY5ZUVx80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883046; c=relaxed/simple;
	bh=Ao/8J7UTQtuDshYKUS2qutRCBUl/5UwBjXZJzZrvRTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c98migGRbIR3fASgiHTXSfip4NlA9yQwyGS0yM09J2yqz41/YYIieocESF0tgO6IAvnN/3CAVVIzGjbVMm30cj4aKp2xSbDLGkx7B3A9+cRdpGIqbq3itlkkEV2qSJSkP9xIx3ZAqFByAKTyqKoNHVXRuaYl5MkLbT7cLhwetKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=O5jGAtem; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="O5jGAtem"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-482f2ee53e7so3621221f8f.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788883039; x=1789487839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IkXgniOUiPREmfv+HSLCD0A+Drz8mQTli5pp/XRi4lU=;
        b=O5jGAtem1X0xWtsWWYm3IPNpReci4RiqBP3igoHMhUqKGtVokYbla+tLhFw3mWk+RM
         fVf179wiSR01HmM6nPqSPpfim9rrPX/pjDCi5YCKcq1ulknXdXcKHPQ4QUfCG9yj0nl6
         Z4q8kuWHZ2147r/NymgZzLe7qYJ4Eyc6RdCny6N5VbGv3eve+QjszYrvtFAdsWxMI9v6
         cmM1+Zn2ZxGXQDAjdQMH2fx4C62WFTlcjgSYnyWFpxTx3V0llP/tutZT+wcsYeYHMC/Y
         dT40XxWlnBaR+JGe0T5HGpMlkma7yxOZx48K+TUAeXUeE8WLfupHs9sEm7T4MSQIE8+S
         2QXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883039; x=1789487839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IkXgniOUiPREmfv+HSLCD0A+Drz8mQTli5pp/XRi4lU=;
        b=eFq0kfTUdrBPmrvOIAGpmIuEvipGn8MJOEm0TWbP5D1fcJZR4f7SUaUUd126uXMP5v
         JTx3hqAvMkYudKcpWsLmFkPrt5Ks5xwNJlAls7TwEkdz8BSyHHFejGqEPGfBREdnFbdT
         pB/ZzHiBMJXyGNm49q00HCvF6TQuP3b3F6BasVOFSRx8Hdkq7q6jK7m7zKND91SRlMbR
         NkeWdeLI9wD1XqqAaaBKDryqdRQ9HkEiE8od5fu6twL0QZU9HFiT1Kli8zI2w+f7tS+8
         lwL5pi+aFl+RexxRLNk1MVs2Fum8x0WdkIbbok4ghQpGSGSM4o9Y/Cqw0gqi9DBEY+d4
         K6bA==
X-Forwarded-Encrypted: i=1; AKwUvBzUmcXtnKwKj+0AifRjy8otcTfVv+qLzc+fVZYOUh5o2z1ZxBmHpB8WNye0O33YMRpZ+QL+upo=@vger.kernel.org
X-Gm-Message-State: AFuF++lRSPrBJ+UejRxrVV9noG+jdVVy3Xsjoiz2rFyDv7uCUDDVj1fT
	uRx0jdJayldqvFONbM6a+obm3pXRPI1JothkQvfWHKR7lRnGoj9e2TCXjE2iQmWwH9o=
X-Gm-Gg: AYBFou2ZFDBMTgTsGmqLWvr12KfijPEzz9kMKO3ZGS6yAIi5D9wUFUxM8XZO1g6nrlM
	RVsrhk+FMfZPVNwMtnJG6org3v1qeH32mUBOGbOlwdU1IX2TPgSFy4YfiVT3gdErf+5AzrBJ87D
	X+TO0KMF6UeqI+9e5ZGuD7IE+5vpoMId1tAF4fgJzuv192HUjazjsqKw0fYC+crxk7TzOvQDdN2
	TAMSjbkSvgh3HG9KRKxRXguEPCmOIm+HX4HyB/qFevKw20v3SRCH7BBkeHzVBXBNieTmYQvSsT2
	hwWKNQg6LBWY5Fq/KUx5SBdAB5dTGcOjvOEAGm6H8S1bK2AMOwSKwtcqvmqIZ9bPV7D0GlelHax
	gcYJ+fCIrJTzUdUe6A643jl/4U+DpWt0PGgC9a69ym9nGKXOl72IiAk3F84sbq62ByjnmTxB6CR
	036Ke2SgHBtWV3L+x6Cd1KEDlSJClv21L++5WSR9oq4mP82Hi4kW8=
X-Received: by 2002:a05:6000:490e:b0:485:82f9:44a4 with SMTP id ffacd0b85a97d-485872a010cmr36125987f8f.16.1788883039308;
        Tue, 08 Sep 2026 08:57:19 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be709sm37345704f8f.21.2026.09.08.08.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:57:18 -0700 (PDT)
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
Subject: [RFC PATCH net-next v2 6/7] net: mdio: add Airoha EN8811H MDIO device driver
Date: Tue,  8 Sep 2026 15:57:06 +0000
Message-ID: <20260908155707.4164559-7-f@lex.la>
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
deferral only parks the device until something else triggers the
pending list, which need not happen when the files appear. There is no
give-up path, since installing the firmware package on a running system
is a normal thing to do.

The reset line is claimed here rather than on the PHY node, and it is
cycled only while the MD32 does not report a running firmware: that
firmware lives in volatile RAM, so an assert on a running chip - such
as the one phy_detach() performs on a PHY-node reset - would wipe it. A
status read that fails says nothing about the firmware, so the line is
left alone unless it is already asserted, which is reason enough for
the chip not to have answered.

Resume repeats the reset decision and the download in line, since a
suspend that cut power leaves the MD32 back in its bootloader.

Nothing yet publishes a PHY: this driver takes the chip over, and the
bus that exposes it to the device tree is the next patch. Splitting
there keeps the download and its retry policy separate from what
registering a bus costs, which is its own failure mode with its own
backoff.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 MAINTAINERS                              |   2 +
 drivers/net/mdio/Kconfig                 |  13 ++
 drivers/net/mdio/Makefile                |   1 +
 drivers/net/mdio/mdio-airoha-en8811h.c   | 199 +++++++++++++++++++++++
 drivers/net/phy/air_phy_lib.h            |   9 +-
 include/linux/mdio/mdio-airoha-en8811h.h |  24 +++
 6 files changed, 241 insertions(+), 7 deletions(-)
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
index d44278f26fab..33efc6bc875f 100644
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
+	  firmware once it becomes readable, or adopts firmware a bootloader
+	  left running.
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
index 000000000000..d94d74d85f10
--- /dev/null
+++ b/drivers/net/mdio/mdio-airoha-en8811h.c
@@ -0,0 +1,199 @@
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
+	int ret;
+
+	ret = air_en8811h_fw_download(mcu->mdiodev, &mcu->fw_version);
+	if (ret >= 0) {
+		dev_dbg(dev, "firmware %08x running after %ums\n",
+			mcu->fw_version, mcu->waited_ms);
+		ret = firmware_request_cache(dev, EN8811H_MD32_DM) ?:
+		      firmware_request_cache(dev, EN8811H_MD32_DSP);
+		if (ret)
+			dev_dbg(dev, "not cached, resume will want the files: %pe\n",
+				ERR_PTR(ret));
+		return;
+	}
+
+	mcu->waited_ms += mcu->poll_ms;
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
+	mcu->poll_ms = min(mcu->poll_ms * 2, EN8811H_FW_POLL_MAX_MS);
+	queue_delayed_work(system_freezable_wq, &mcu->fw_poll,
+			   msecs_to_jiffies(mcu->poll_ms));
+}
+
+/* The firmware lives in volatile RAM: no reset while the MD32 reports ready. */
+static void en8811h_mcu_reset_if_dormant(struct en8811h_mcu *mcu)
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
+	/* A failed read is not a dormant chip, so do not touch a line that
+	 * is already deasserted. An asserted one is why the read failed.
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
+	en8811h_mcu_reset_if_dormant(mcu);
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
+
+	int ret;
+
+	/* Not on the workqueue: the child PHY's own resume calls
+	 * phy_init_hw() straight after this one and needs the firmware by
+	 * then. request_firmware() is answered from the cache the download
+	 * registered, so it does not wait for a filesystem.
+	 */
+	en8811h_mcu_reset_if_dormant(mcu);
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
diff --git a/drivers/net/phy/air_phy_lib.h b/drivers/net/phy/air_phy_lib.h
index 226dc9f2eb07..3391396aecd1 100644
--- a/drivers/net/phy/air_phy_lib.h
+++ b/drivers/net/phy/air_phy_lib.h
@@ -10,6 +10,8 @@
 
 #include <linux/phy.h>
 
+#include <linux/mdio/mdio-airoha-en8811h.h>
+
 #define AIR_EXT_PAGE_ACCESS		0x1f
 
 #define AIR_PHY_PAGE_STANDARD		0x0000
@@ -34,9 +36,6 @@
 #define AIR_BPBUS_RD_DATA_HIGH		0x17
 #define AIR_BPBUS_RD_DATA_LOW		0x18
 
-#define EN8811H_MD32_DM			"airoha/EthMD32.dm.bin"
-#define EN8811H_MD32_DSP		"airoha/EthMD32.DSP.bin"
-
 #define AIR_FW_ADDR_DM			0x00000000
 #define AIR_FW_ADDR_DSP			0x00100000
 
@@ -64,10 +63,6 @@ struct firmware;
 
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
index 000000000000..0d23811e90dc
--- /dev/null
+++ b/include/linux/mdio/mdio-airoha-en8811h.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Airoha Technology Corp.
+ * Copyright (C) 2026 Collabora Ltd.
+ *                    Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
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
+/* Returns 1 running, 0 dormant, negative on a failed status read. */
+int air_en8811h_mcu_running(struct mdio_device *mdiodev);
+/* Returns 1 when it adopted firmware that was already running. */
+int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version);
+
+#endif /* __LINUX_MDIO_AIROHA_EN8811H_H */
-- 
2.53.0

