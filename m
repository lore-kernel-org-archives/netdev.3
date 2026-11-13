Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549048;
	b=Ez/LszK7wZ8NxbM6vCGzIsKO4Gc7g79ErXhJk6YFOrozq5RF8FoJAw54lFXzVU+A5M/V
	 bKRdKrEQe4RjcHV/hZ+rBeB4bCeoQy7KhB8LkdbyEJP7NJlf0xgN6yWuFs/ZrQvlahyi+
	 oCqKcaSElIv4XuRJ0wMmCgq+x1Pqr23asg7o5LUtBbKPyyoGCoUlXQoqrpWstm3HbZ9Hh
	 nUaAxaZjt1nFMWNKWbQPkkh2lBKMkZZgsUc5w9/nBuQELR70YjWHjlRxUU2nZ44toAqPm
	 WF1yybYe1X8PinKyHmnubdNhdl2e5AtWtH8fiW0ecinmAzN93cYEeJJskSUTaf3uIpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549048;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=DWpA+av4hZgz5PDtIeWvKUt7bf0U0e+13BSJEMQ5ieU=;
	b=XjkmHutDr858gmQEKlP0Hg8EB09Joz05G2zhbpE47Hjk6zCqzX59nY9px4Ql24/Wpdsd
	 734AcyWP1QuJCxnJ4PWIDwytvCtTRuA0xQIcgOPxzq6TRqCYg2PqLCqYw61ipMDpfD/Rx
	 ffcJHmw1mwT6VW5xVy9xpFa2KiMYTzufoH25+8kMzpTakgF0j2818xplkOKCTe6se6Dge
	 CHGLDqhb4FjSj+iGg8c8jzeMy4JjJg3A6BONnEE2klslJCc3vJfsifztnsluMa4b9tMLD
	 KXcQeH9HvAGrGaj/uOgxWUr9EdXh0al/4XyVEtv0EZruGrI1C5ANNBeSWElyjiS9D3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=sk4dCilW;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03D4606A32D;
	Fri, 13 Nov 2026 05:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D03D4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=sk4dCilW
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQmZZ1CG7z5BNS0;
	Fri, 13 Nov 2026 13:50:46 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794549046;
	bh=K+f8WLpUrGziB3jE6nrp82KYl73LPQxVQjFPNxSQL7Q=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=sk4dCilWSE81wiujYZsb/XtatXnjP6V85WEhYYgPOR0zSLinaKtZbceVQ+KNnFR1w
	 7Qh4t6bP6VoE1P47+vjlOZ4+nsTGZM+3WFf/PZvy8Ek8D0LjBtg8zV90d4uGVhjx1k
	 XvcP3azj7O4G7Lhl3hJIQX5oKB+BL7qvCxDW9fGwahXfLhjKHugj9YejdH0TwkjDPM
	 erC3MTbN2pYUsXNcRb6jb8lJoIYlGRpHC5lnw+9mHoVE7G9esAt3BwsS6cZJ2uZ1vK
	 OJSMqUbImRpcsBJQXWTr28wyLrKZGFg4Ne3PtGyY91q3fP7O3QTyTyZjkdLAxjhUYY
	 Hodc5D97p3c7g==
Received: from njy2app04.zte.com.cn ([10.40.12.64])
	by mse-fl2.zte.com.cn with SMTP id 6AD5oaVH099295;
	Fri, 13 Nov 2026 13:50:36 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njy2app01[null])
	by mapi (Zmail) with MAPI id mid204;
	Fri, 13 Nov 2026 13:50:38 +0800 (CST)
X-Zmail-TransId: 2af96af6a52eb7e-18bc0
X-Mailer: Zmail v1.0
Message-ID: <20261113135038394NowoSxTdiA32KKAPcTmCa@zte.com.cn>
In-Reply-To: <20261113134743145KUhKvpwU6uqR0QzymEP96@zte.com.cn>
References: 20261113134743145KUhKvpwU6uqR0QzymEP96@zte.com.cn
Date: Fri, 13 Nov 2026 13:50:38 +0800 (CST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <han.junyang@zte.com.cn>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <han.junyang@zte.com.cn>, <ran.ming@zte.com.cn>,
        <han.chengfei@zte.com.cn>, <zhang.yanze@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHY2IDEvM10gZGluZ2hhaTogYWRkIGZpcm13YXJlIHZlcnNpb24gY2hlY2sgYW5kCiBSSVNDLVYgcmVhZGluZXNzIHBvbGxpbmc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AD5oaVH099295
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 13 Nov 2026 13:50:46 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF6A536.000/4jQmZZ1CG7z5BNS0

From: Junyang Han <han.junyang@zte.com.cn>

The DingHai firmware publishes a version compatibility block and a
RISC-V health buffer at fixed offsets within BAR 0.

After the PCI capabilities are mapped, poll the compatibility block
until the firmware populates it (the region reads as all ones until
then) and verify the driver/firmware version contract. Then wait for
the RISC-V management core to set its power-on flag in the health
buffer before the rest of the probe continues.

Firmware images that support neither self-healing (health version
other than 1) nor hot-plug interrupts (patch level below
ZXDH_HPIRQ_PATCH) do not report the power-on flag and skip the
readiness wait.

Signed-off-by: Junyang Han <han.junyang@zte.com.cn>
---
 drivers/net/ethernet/zte/dinghai/en_pf.c | 130 +++++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h |  46 ++++++++
 2 files changed, 176 insertions(+)

diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
index 86d437408820..ddff9b0438fb 100644
--- a/drivers/net/ethernet/zte/dinghai/en_pf.c
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.c
@@ -6,6 +6,8 @@

 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
 #include <net/devlink.h>
 #include <linux/dma-mapping.h>
 #include "en_pf.h"
@@ -369,6 +371,120 @@ int zxdh_pf_modern_cfg_init(struct zxdh_core_dev *zxdh_dev)
 	return ret;
 }

+/* The firmware fills the compatibility block field by field, so it is
+ * only ready to be read once every field we consume has lost its
+ * erased value.
+ */
+static bool zxdh_pf_fw_compat_ready(struct zxdh_fw_compat __iomem *compat)
+{
+	return ioread8(&compat->module_id) != 0xffU &&
+	       ioread8(&compat->major) != 0xffU &&
+	       ioread8(&compat->fw_minor) != 0xffU &&
+	       ioread8(&compat->drv_minor) != 0xffU &&
+	       ioread16(&compat->patch) != 0xffffU;
+}
+
+/* Read the firmware version block and verify the driver/firmware
+ * version contract.
+ */
+static int zxdh_pf_fw_compat_check(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
+	struct zxdh_fw_compat __iomem *compat;
+	struct zxdh_fw_compat *fw_compat;
+	bool ready;
+	int err;
+
+	fw_compat = &pf_dev->fw_compat;
+	compat = pf_dev->pci_ioremap_addr[0] + ZXDH_FW_COMPAT_OFFSET;
+
+	/* The firmware publishes the block within 10 s of boot; wait twice
+	 * that to leave margin.
+	 */
+	err = readx_poll_timeout(zxdh_pf_fw_compat_ready, compat, ready,
+				 ready, USEC_PER_SEC,
+				 ZXDH_FW_COMPAT_TIMEOUT_SEC * USEC_PER_SEC);
+	if (err)
+		dev_info(zxdh_dev->device,
+			 "compat region not populated, assuming legacy firmware\n");
+
+	/* Firmware predating the compatibility region keeps the erased
+	 * pattern, which fails the module id check below and defers the
+	 * decision to the readiness wait.
+	 */
+	fw_compat->module_id = ioread8(&compat->module_id);
+	fw_compat->major = ioread8(&compat->major);
+	fw_compat->fw_minor = ioread8(&compat->fw_minor);
+	fw_compat->drv_minor = ioread8(&compat->drv_minor);
+	fw_compat->patch = ioread16(&compat->patch);
+
+	if (fw_compat->module_id != ZXDH_MODULE_ID) {
+		dev_info(zxdh_dev->device,
+			 "unknown module id %u, skip fw compat check\n",
+			 fw_compat->module_id);
+		/* Unknown firmware is treated as predating the HPIRQ
+		 * patch, so that the readiness wait is skipped.
+		 */
+		fw_compat->patch = 0;
+		return 0;
+	}
+
+	if (fw_compat->major != ZXDH_MAJOR) {
+		dev_err(zxdh_dev->device,
+			"driver major %u incompatible with firmware major %u\n",
+			ZXDH_MAJOR, fw_compat->major);
+		return -EINVAL;
+	}
+
+	if (fw_compat->fw_minor < ZXDH_FW_MINOR) {
+		dev_err(zxdh_dev->device,
+			"firmware fw_minor %u older than required %u\n",
+			fw_compat->fw_minor, ZXDH_FW_MINOR);
+		return -EINVAL;
+	}
+
+	if (fw_compat->drv_minor > ZXDH_DRV_MINOR) {
+		dev_err(zxdh_dev->device,
+			"driver drv_minor %u older than required by firmware %u\n",
+			ZXDH_DRV_MINOR, fw_compat->drv_minor);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Wait for the RISC-V management core of the firmware to finish
+ * booting, so that later probe steps can talk to it.
+ */
+static int zxdh_pf_wait_riscv_ready(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
+	struct zxdh_health_buffer __iomem *hb;
+	u8 health_version;
+	u8 power_on;
+	int err;
+
+	hb = pf_dev->pci_ioremap_addr[0] + ZXDH_RISCV_HB_OFFSET;
+	health_version = ioread8(&hb->health_version);
+
+	/* Firmware that supports neither self-healing nor hot-plug
+	 * interrupts does not report the power-on flag.
+	 */
+	if (health_version != 1 &&
+	    pf_dev->fw_compat.patch < ZXDH_HPIRQ_PATCH)
+		return 0;
+
+	err = readx_poll_timeout(ioread8, &hb->riscv_power_on, power_on,
+				 power_on == 1, USEC_PER_SEC,
+				 ZXDH_RISCV_READY_TIMEOUT_SEC * USEC_PER_SEC);
+	if (err) {
+		dev_err(zxdh_dev->device, "timed out waiting for riscv power on\n");
+		return err;
+	}
+
+	return 0;
+}
+
 static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct zxdh_core_dev *zxdh_dev;
@@ -405,10 +521,24 @@ static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_cfg_init;
 	}

+	ret = zxdh_pf_fw_compat_check(zxdh_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "zxdh_pf_fw_compat_check failed: %d\n", ret);
+		goto err_modern_cfg;
+	}
+
+	ret = zxdh_pf_wait_riscv_ready(zxdh_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "zxdh_pf_wait_riscv_ready failed: %d\n", ret);
+		goto err_modern_cfg;
+	}
+
 	devlink_register(devlink);

 	return 0;

+err_modern_cfg:
+	zxdh_pf_modern_cfg_uninit(zxdh_dev);
 err_cfg_init:
 	zxdh_pf_pci_close(zxdh_dev);
 err_pci_init:
diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.h b/drivers/net/ethernet/zte/dinghai/en_pf.h
index 7373dee8d1a9..730cb084a8ae 100644
--- a/drivers/net/ethernet/zte/dinghai/en_pf.h
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.h
@@ -29,6 +29,51 @@
 #define ZXDH_PF_ALIGN2			2
 #define ZXDH_PF_MAP_MINLEN2		2

+/* Fixed offsets of the firmware interface regions within BAR 0. */
+#define ZXDH_RISCV_HB_OFFSET	0x5300
+#define ZXDH_FW_COMPAT_OFFSET	0x5400
+
+/* Driver/firmware version contract. The firmware publishes its side of
+ * the contract in the region at ZXDH_FW_COMPAT_OFFSET.
+ */
+#define ZXDH_MODULE_ID		1
+#define ZXDH_MAJOR		1
+#define ZXDH_FW_MINOR		0
+#define ZXDH_DRV_MINOR		0
+/* Firmware patch level that introduced hot-plug IRQ support. */
+#define ZXDH_HPIRQ_PATCH	4
+
+#define ZXDH_FW_COMPAT_TIMEOUT_SEC	20
+#define ZXDH_RISCV_READY_TIMEOUT_SEC	40
+
+/* Firmware version compatibility block at ZXDH_FW_COMPAT_OFFSET.
+ * Fields are read through ioread*(), which converts from little-endian.
+ */
+struct zxdh_fw_compat {
+	u8 module_id;
+	u8 major;
+	u8 fw_minor;
+	u8 drv_minor;
+	u16 patch;
+	u16 rsv;
+};
+
+/* Health buffer at ZXDH_RISCV_HB_OFFSET, maintained by the RISC-V
+ * management core of the firmware. Fields are read through ioread*().
+ */
+struct zxdh_health_buffer {
+	u32 synd;		/* Bitmask of active syndrome flags. */
+	u32 health_counter;	/* Incremented heartbeat counter. */
+	u8 status;
+	u8 rfr;
+	u8 fw_exception;
+	u8 riscv_power_on;	/* Set to 1 once the core finished booting. */
+	u8 fw_version[32];
+	u8 pf_status[5];
+	u8 health_version;	/* 1 when the firmware supports self-healing. */
+	u8 rsv1[30];
+};
+
 struct zxdh_core_dev {
 	struct device *device;
 	struct pci_dev *pdev;
@@ -54,6 +99,7 @@ struct zxdh_pf_dev {
 	s32 modern_bars;
 	void __iomem *pci_ioremap_addr[6];
 	u32 dev_cfg_bar_off;
+	struct zxdh_fw_compat fw_compat;
 };

 void *zxdh_core_alloc_priv(struct zxdh_core_dev *zxdh_dev, size_t size);
-- 
2.27.0
