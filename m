Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F5736A370
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 05:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787981170; cv=none; b=tsTRsHH+1jUEqXJVE87UiRcl+NMfJJ4X7n3gBmesFwTV6ushVfhsH+KR6GxCElVRUqTRVgStos5skkr9htdd7cyZzAdxcCUd8x5wH9NmAOhDN7+yqHLk/pEFIe2scwPx1BdVKtSqJimEawN8ESPpzXHz46IlY/7YSoF1vL2/0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787981170; c=relaxed/simple;
	bh=Om+yIyvp/xVStaLNsNIgsppojGwd8GST4HOKkpGWTXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXFaUR45BELMMcaa8xe/m+DjbargfvtujnezR3QpVJ2NeqmOM8tTUJzoaDk22HUwbAAA8bTExoKS6P6DdMQX44IFmc3v3wosu9j829ySmrao6IGJIbz6yuX6PDZ7yqeWdOV1A7A5/mhsrShkbcWDH271abYlZENKQiDpzfVF/DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=en5xdvWR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="en5xdvWR"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a5e971c970so4548202a12.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 22:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787981164; x=1788585964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c0I5nG104BUKVRo1dyKSBLkUWSIlwrG3+PtH9GTY9co=;
        b=en5xdvWRhJ9Htp2xLuSOtMsRzECxVZLyrqah+Gb1GwjHYzXyF0PkmDW/Jv3PlAE67L
         hkoub2sIkfG0gktlTSWMBZwEUVqiDlL4jjl5dTNYnVgVugCBVmAp/Vy/e0ZJ3iBdGXaN
         kjh+JmGSe4XrIdFZs3QUIsa4SfrqL9puZGdsP5uZVoT0WETSnhNqDIn/6xConuAJPfJ8
         GSuctYj2+dm0LPBgfAvC7RKubU8iHMLSbHwLCv7Q0wLmzB2hqgT67v7uM+JiXsHHVCDZ
         jyD3TS2uI4ffFYvEc2rhqrVXRMCHxRNW2CxDAlHVvAkEy8Wokywk4PN8TiFBuz6A3lNx
         yHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787981164; x=1788585964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c0I5nG104BUKVRo1dyKSBLkUWSIlwrG3+PtH9GTY9co=;
        b=jtojcx5BjuJLswDHpJKMf4SoSZXIGhXJY1wdLIzW3ZWlacHHi589RXlzkwfXhzva4u
         jmLC6XAQS1IyeGXKWyyiZpR6WdS9+ZUt3yWVqgeWP6PqDqd4IsxOCZ1r3ZUm2RaSkP3J
         XIxR99wlnj3gBm9rpfu0kgCo/qJ3G0mVE5SufUhzwCl5WJNvU+aeH6jTN67J1t5w762Q
         O2gmCrntFr/vf8SoUZBlqXsbuh9WAGrkjPt6ZEXu+SkwmEDmsJ/rKFnafoExY4IsTzkg
         90oBo1ZjtJFf6XyWwAAhJDx0dSXGd2Hg0zrCzJPm6OuOLXzDR9UmegPMHiBzJoDX04LB
         1eAA==
X-Gm-Message-State: AFuF++naFjV/K1+pio4XeeG7yQrAYbMOhmncYheLH3dGCc7tRQzQBBO4
	w+eWnHh3ivJTrALLJim7g7aScI+1aKChW6BSyXpFpaaq1xnpknR9aVtZhu8Z0dhUbxDAsK1qAKF
	oXKkwsR5PAA==
X-Gm-Gg: AR+sD12nKOw8r35S6u2Sl4at8gHzh84qvJ3ePoq2vrMv4uhhFk4hPEmXS/e5JgPskXQ
	hLHnBd9ZFJ8mtLCW2F2WBLxMJZKlO4yxaTa7ETJFnjGTagyHuqQJUo499lUkrXsUxP4Q3MfeDaJ
	BVZZ4+halD6gCOJs+AaHQ0huU6NQayqiDmzmp/I/PALIVwbgUqi9zjgbQbshCW2PLgNnxwX1agx
	uD4J3NWRsxjy9/CfQ5tOAaLrK4n/XLvu5LS2ke3fPebuiV0V5x4e3gs7qFEB7V6z1+MiVyOHaCv
	b8rLHBkFd6gVaLI4bQ3mpv9mC3OMBNK+hFMmdy1GwCpCRUuxc+7FzUgbxkdG5jeL+ml/rX/mmTT
	INow6qsbm4qLZya6uht03l3HsnVpRv5A6xmkjjX8ZarOh8ePREeAYaTAtmrFwlT513LYN056WcD
	aIe+yw+PvIt2/+XdMRxp2gd+2VphGJbu9vQxWJqlfF2SEyR+vhzv0K
X-Received: by 2002:a17:907:805:b0:c16:6dac:a008 with SMTP id a640c23a62f3a-c256dda941emr293670266b.8.1787981164124;
        Fri, 28 Aug 2026 22:26:04 -0700 (PDT)
Received: from remote-01 ([45.85.105.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee75a36sm163750666b.28.2026.08.28.22.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 22:26:03 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [RFC PATCH net-next 6/9] net: mdio: add Airoha EN8811H MDIO device driver
Date: Sat, 29 Aug 2026 05:25:43 +0000
Message-ID: <20260829052546.1152446-7-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829052546.1152446-1-f@lex.la>
References: <20260829052546.1152446-1-f@lex.la>
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

Describe the chip as an MDIO device. The driver polls for the
firmware files with backoff and downloads through the shared library
helper once they can be read; a chip whose firmware was left running
by the bootloader is adopted as-is through the helper's running
check. There is no give-up path: installing the firmware package on a
running system is a normal thing to do, and a driver that had stopped
looking would turn that into a needless reboot.

The reset line is claimed here rather than on the PHY node, and it is
cycled only when the MD32 sits in its bootloader: the firmware lives
in volatile RAM, so an assert on a running chip - such as the one
phy_detach() performs on a PHY-node reset - would wipe it.

Polling is used rather than deferred probing because
request_firmware_direct() has no usermode-helper fallback: an
unmounted rootfs fails immediately and would keep the deferred-probe
list spinning for the whole mount window.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 MAINTAINERS                            |   7 +
 drivers/net/mdio/Kconfig               |  11 ++
 drivers/net/mdio/Makefile              |   1 +
 drivers/net/mdio/mdio-airoha-en8811h.c | 172 +++++++++++++++++++++++++
 4 files changed, 191 insertions(+)
 create mode 100644 drivers/net/mdio/mdio-airoha-en8811h.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 460cb7268845..21d39049e692 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -759,6 +759,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 F:	drivers/net/ethernet/airoha/
 
+AIROHA EN8811H MCU MDIO DRIVER
+M:	Aleksei Sviridkin <f@lex.la>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml
+F:	drivers/net/mdio/mdio-airoha-en8811h.c
+
 AIROHA PCIE PHY DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index a05229838cb4..d46bebd05cc8 100644
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
index 000000000000..e16211da3d70
--- /dev/null
+++ b/drivers/net/mdio/mdio-airoha-en8811h.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Airoha EN8811H MDIO device driver
+ *
+ * Until its firmware has been downloaded the EN8811H is not an Ethernet PHY,
+ * it is an MD32 microcontroller waiting in its bootloader. Describing it as a
+ * plain MDIO device lets the firmware be downloaded as soon as the files can
+ * be read - in practice, once the filesystem holding them has been mounted -
+ * and lets the PHY appear only after the chip is able to act as one.
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
+#include <linux/property.h>
+#include <linux/workqueue.h>
+
+#include "../phy/air_phy_lib.h"
+
+/*
+ * Poll rather than defer probing: request_firmware_direct() has no usermode
+ * helper fallback, so a rootfs that is not mounted yet fails immediately and
+ * would keep the deferred-probe list spinning for the whole mount window.
+ *
+ * Never give up. The firmware can arrive arbitrarily late and still be worth
+ * waiting for - installing the firmware package on a running system is a
+ * normal thing to do - and a driver that had stopped looking would turn that
+ * into a needless reboot. Back off to a slow poll instead, and leave a single
+ * breadcrumb for the system that simply does not have the files.
+ */
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
+	/* The chip enumerates as a C22 PHY; MMD access is indirect */
+	ret = air_en8811h_fw_download(mcu->mdiodev->bus, mcu->mdiodev->addr,
+				      false, dev, &mcu->fw_version);
+	if (!ret) {
+		dev_dbg(dev, "firmware %08x running after %ums\n",
+			mcu->fw_version, mcu->waited_ms);
+		return;
+	}
+
+	mcu->waited_ms += mcu->poll_ms;
+	if (!mcu->warned && mcu->waited_ms >= EN8811H_FW_WARN_MS) {
+		/* Missing files resolve by themselves once installed; a bus
+		 * or register error will not, and deserves its own message.
+		 */
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
+static int en8811h_mcu_probe(struct mdio_device *mdiodev)
+{
+	struct device *dev = &mdiodev->dev;
+	struct en8811h_mcu *mcu;
+	u32 deassert_us = 0;
+
+	mcu = devm_kzalloc(dev, sizeof(*mcu), GFP_KERNEL);
+	if (!mcu)
+		return -ENOMEM;
+
+	mcu->mdiodev = mdiodev;
+	mdiodev_set_drvdata(mdiodev, mcu);
+
+	/*
+	 * The core only claims reset-gpios for devices flagged as PHYs
+	 * (mdiobus_register_device()), so claim it here. Owning it at this
+	 * level is the point: phy_detach() asserts the reset of the PHY it
+	 * detaches, which would wipe firmware the MD32 holds in RAM.
+	 */
+	mcu->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS);
+	if (IS_ERR(mcu->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(mcu->reset_gpio),
+				     "failed to get reset GPIO\n");
+
+	if (mcu->reset_gpio)
+		gpiod_set_consumer_name(mcu->reset_gpio, "EN8811H reset");
+
+	/*
+	 * Firmware left running by the bootloader, or by a previous bind,
+	 * lives in volatile RAM: the reset line must not be touched then.
+	 * Only a chip still in its bootloader gets the clean reset cycle.
+	 */
+	if (air_en8811h_mcu_running(mdiodev->bus, mdiodev->addr, false)) {
+		dev_dbg(dev, "MD32 already running, adopting it\n");
+	} else if (mcu->reset_gpio) {
+		u32 assert_us = 0;
+
+		device_property_read_u32(dev, "reset-assert-us", &assert_us);
+		device_property_read_u32(dev, "reset-deassert-us",
+					 &deassert_us);
+
+		gpiod_direction_output(mcu->reset_gpio, 1);
+		if (assert_us)
+			fsleep(assert_us);
+
+		gpiod_set_value_cansleep(mcu->reset_gpio, 0);
+		if (deassert_us)
+			fsleep(deassert_us);
+	}
+
+	mcu->poll_ms = EN8811H_FW_POLL_MIN_MS;
+	INIT_DELAYED_WORK(&mcu->fw_poll, en8811h_mcu_fw_poll);
+	/* Freezable, so neither the file lookup nor the ~144KB MDIO
+	 * download can land on a bus that is suspending. The download is
+	 * long for a bound worker, but it runs once per firmware arrival.
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
+MODULE_DESCRIPTION("Airoha EN8811H MDIO device driver");
+MODULE_AUTHOR("Aleksei Sviridkin <f@lex.la>");
+MODULE_LICENSE("GPL");
-- 
2.53.0

