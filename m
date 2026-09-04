Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5838251D504
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548603; cv=none; b=pi/jFLPEQ+4veBqrhc+knwVlDbJxfjRMuuNW3oAN3Zggc5c+5uJuIfMsSL/sMmXKAtMXk3uTFzzu6L+5bA6WsAhgA6voaKkadsQpdAUYnsUQVcS1hKpN3v1xCqitc99w8H0ydn2y/PL+uKx5cjESmT2vPx/bNK2g8otdtUz3qvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548603; c=relaxed/simple;
	bh=TvmNZ9HIJUKKHCevEGQssxkyOTUK9Y/loRcLTRaueq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcWqRcjkDTAAWZOQjAsWueFn/GYS/7Ajp/Ak1Y1w4WW4eCm7OL0b8h2YvqwDzm2PUMM4RULkCBpyynPcn3WytVFxSgvmNqU3Y21kKGqtUuWX1pXO9t6KLmLdcKwLdXq7FcQWrGGLTqPVVE7HTfIXxqnz58JPHJ5tJUblCdqCmAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=SB21ioUz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="SB21ioUz"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49cd9add88aso9745095e9.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 12:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788548596; x=1789153396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RNxSPYrqovDI7t4DpXzHkhI1wWnUmO156W7Ben/xlVc=;
        b=SB21ioUzboW+Kdj9yoks0tS3FgXgnTig2SurLTXAvJh4G9tXQ+24+GscT32zeNwu3J
         n9Pzu/munStI6d5Yo+q67Mb7l5iwDk9gxE7yH8orGnrUH5re24mfWT0PAIGKxX3gHL69
         LfatcvBLRTWGkao/8sPOP+v4dBtAsTA14cqxCtI6lBmM9IKX9nrRGaOgUPv8ZLLxoxgZ
         DfDVe/SRNKRDl8HlobBxOypQoP6PcJNC7b5J08XgWxEcsi3e/yvJ0H5AqHzUZnolFcPB
         MLbEZWyTJIyfm6TMWjLgPKCeR4TGI12SKxYKx42DGi2oRmYvSyRLG1+qly7Upl5gPlJF
         0pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788548596; x=1789153396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RNxSPYrqovDI7t4DpXzHkhI1wWnUmO156W7Ben/xlVc=;
        b=O0nn0lhndX1XMUzY1GAFWmeGKZgLILPb8U39qhspjthz+hkuKrKgc1W6v8p2mHoqRX
         BGS7cPR8VqSdQtoITDSDqOxG6b6u+cENBSxuw5w3WxUwDFl+FVF9J288p9aOZnRatOdf
         ogzvtkrkFHITcCUIpF4EZRXtOlaaY/Bz58bhY5kdbGP4tsPB5uPOYyAAKSo4mh3iXGTu
         yvk9TejMd641tgzICtrgge5hfbEHoEKbpQqfEGF9WeOcSnknlpruE+bs2WwYllOq6YMS
         qUO8+v1u0FX2aXEtQ2xKwvUiNf/MK3G6LdV3qV4Mb6TdyFmfgM135rJZTWPOQVHJSD31
         A3OQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUNKtFjn3TuP3nJkrWRbRanR5i9ZG8gyA6/EAjOJj9WKy2IKkD7xgQxYSk/X93QzSrFsSP3EA=@vger.kernel.org
X-Gm-Message-State: AFuF++nEw8jcvSjXEjI3SNMIzF27G3F3BBViqx62bTJ8DlDVJLhEhnDv
	Q2IoM3NC0z029V+JXDXTslPkv9pWOkvRLZbotyWUyrywvreMQfPJd1oddihQGyv/m+M=
X-Gm-Gg: AYBFou3YIvwpwYJNXEZgM0haHl8lMfyGMYhQGXUv1x5fvhVZ3FumhB8j3XPr/QnNt28
	vlpHiVacVWmopLIomIJuvh3tZ2/FbVulMGC4tMjbJjMl3WRp76ia2Y42rlr9QyFQx94NifrG1GW
	JUfGQeltaF+42o/a3KzW4qMr1Vswd68KdyYMCvavP2bYU61pjMG0EH2WFrbFgSamzOC1gkHbWi4
	u/a6Re6G0P7usFWFo5o54Fc2T/XAA6GkKkoHemgiIuyex9t95EdgSGgG1FuoL7+2pIyQTb0fAwf
	+OUYBhnZcRPAAC47owerfFhXXYqKJR4HZXrRC5L+aNLNWC4vk/f4bhUPS/Us2dhh0Hwv5bx9AJx
	1iv5ysQaKB+kplfdM4jqiaEJ+J4nPxG7HR3eFs9dm7QK4P7KHOgyjTnkwRa73/QYBZQhY3fM982
	Td10FcaWH6JVncM7Rh+NMTRWJDuvW0J3R4UMaKz4Y=
X-Received: by 2002:a05:600c:34c9:b0:49c:f729:d757 with SMTP id 5b1f17b1804b1-49cf824f757mr87221345e9.11.1788548596255;
        Fri, 04 Sep 2026 12:03:16 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d8a6sm172195485e9.10.2026.09.04.12.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:03:15 -0700 (PDT)
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
Subject: [RFC PATCH net-next v2 07/10] net: mdio: add Airoha EN8811H MDIO device driver
Date: Fri,  4 Sep 2026 19:03:01 +0000
Message-ID: <886ca87eb45b4dc94c6542dd80ce23dc76cfbf1c.1788548229.git.f@lex.la>
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

Until its firmware has been downloaded the EN8811H is not an Ethernet
PHY, it is an MD32 microcontroller waiting in its bootloader. On
systems that keep the firmware files in a filesystem, the files become
readable long after the MDIO bus was scanned, and the PHY driver's
probe-time download then cannot work at boot.

Describe the chip as an MDIO device that polls for the files and
downloads through the shared library helper once they can be read; a
chip left running by the bootloader is adopted as-is. Polling rather
than deferred probing because request_firmware_direct() has no
usermode-helper fallback: an unmounted rootfs fails at once and would
keep the deferred-probe list spinning for the whole mount window.
There is no give-up path, since installing the firmware package on a
running system is a normal thing to do. The stall warning is gated on
a per-device flag rather than dev_warn_once(), which is per call site:
a board can carry two of these chips.

The reset line is claimed here rather than on the PHY node, and it is
cycled only while the MD32 does not report a running firmware: that
firmware lives in volatile RAM, so an assert on a running chip - such
as the one phy_detach() performs on a PHY-node reset - would wipe it.

The chip's MDIO slave implements the Clause 22 MMD indirection and the
firmware data path is pure Clause 22 by design, so the library reaches
the status register the same way. That poll is one register read
behind three address writes, where the indirection costs nothing
measurable, and whether the chip decodes Clause 45 frames before its
firmware runs is unverified on any board.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 MAINTAINERS                            |   7 ++
 drivers/net/mdio/Kconfig               |  11 ++
 drivers/net/mdio/Makefile              |   1 +
 drivers/net/mdio/mdio-airoha-en8811h.c | 160 +++++++++++++++++++++++++
 drivers/net/phy/air_phy_lib.h          |   8 +-
 include/net/phy/air_phy.h              |  23 ++++
 6 files changed, 204 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/mdio/mdio-airoha-en8811h.c
 create mode 100644 include/net/phy/air_phy.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b23fb6f2f4ef..2d2748c44c77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -750,6 +750,13 @@ S:	Supported
 F:	fs/aio.c
 F:	include/linux/*aio*.h
 
+AIROHA EN8811H MCU MDIO DRIVER
+M:	Aleksei Sviridkin <f@lex.la>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml
+F:	drivers/net/mdio/mdio-airoha-en8811h.c
+
 AIROHA ETHERNET DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index d44278f26fab..10cea4235b42 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -29,6 +29,17 @@ config MDIO_AIROHA
 	  This module provides a driver for the MDIO busses found in the
 	  Airoha AN7583 SoC's.
 
+config MDIO_AIROHA_EN8811H
+	tristate "Airoha EN8811H MDIO device support"
+	depends on OF_MDIO
+	select AIR_NET_PHYLIB
+	help
+	  This module provides a driver for the Airoha EN8811H, which is an
+	  MD32 microcontroller until firmware is downloaded into it and only
+	  becomes an Ethernet PHY afterwards. The driver downloads that
+	  firmware once it becomes readable, or adopts firmware a bootloader
+	  left running, before letting the PHY be probed.
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
index 000000000000..595b1b72bc01
--- /dev/null
+++ b/drivers/net/mdio/mdio-airoha-en8811h.c
@@ -0,0 +1,160 @@
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
+#include <linux/gpio/consumer.h>
+#include <linux/mdio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/property.h>
+#include <linux/workqueue.h>
+
+#include <net/phy/air_phy.h>
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
+	if (air_en8811h_mcu_running(mdiodev)) {
+		dev_dbg(dev, "MD32 already running, adopting it\n");
+		return;
+	}
+
+	if (!mcu->reset_gpio)
+		return;
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
index 6823812c8fd5..a8329223dd4f 100644
--- a/drivers/net/phy/air_phy_lib.h
+++ b/drivers/net/phy/air_phy_lib.h
@@ -10,6 +10,8 @@
 
 #include <linux/phy.h>
 
+#include <net/phy/air_phy.h>
+
 #define AIR_EXT_PAGE_ACCESS		0x1f
 
 #define AIR_PHY_PAGE_STANDARD		0x0000
@@ -29,9 +31,6 @@
 #define AIR_BPBUS_RD_DATA_HIGH		0x17
 #define AIR_BPBUS_RD_DATA_LOW		0x18
 
-#define EN8811H_MD32_DM			"airoha/EthMD32.dm.bin"
-#define EN8811H_MD32_DSP		"airoha/EthMD32.DSP.bin"
-
 #define AIR_FW_ADDR_DM			0x00000000
 #define AIR_FW_ADDR_DSP			0x00100000
 
@@ -59,9 +58,6 @@ struct firmware;
 
 int air_fw_write_buf(struct mdio_device *mdiodev, u32 address,
 		     const struct firmware *fw);
-bool air_en8811h_mcu_running(struct mdio_device *mdiodev);
 int air_en8811h_wait_mcu_ready(struct mdio_device *mdiodev);
-/* Returns 1 when it adopted firmware that was already running. */
-int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version);
 
 #endif /* __AIR_PHY_LIB_H */
diff --git a/include/net/phy/air_phy.h b/include/net/phy/air_phy.h
new file mode 100644
index 000000000000..03cb3465ef8d
--- /dev/null
+++ b/include/net/phy/air_phy.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Airoha Technology Corp.
+ * Copyright (C) 2026 Collabora Ltd.
+ *                    Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
+ * Copyright (C) 2026 Aleksei Sviridkin <f@lex.la>
+ */
+
+#ifndef __NET_PHY_AIR_PHY_H
+#define __NET_PHY_AIR_PHY_H
+
+#include <linux/types.h>
+
+struct mdio_device;
+
+#define EN8811H_MD32_DM			"airoha/EthMD32.dm.bin"
+#define EN8811H_MD32_DSP		"airoha/EthMD32.DSP.bin"
+
+bool air_en8811h_mcu_running(struct mdio_device *mdiodev);
+/* Returns 1 when it adopted firmware that was already running. */
+int air_en8811h_fw_download(struct mdio_device *mdiodev, u32 *fw_version);
+
+#endif /* __NET_PHY_AIR_PHY_H */
-- 
2.53.0

