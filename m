Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120723E5A09;
	Fri, 11 Sep 2026 03:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789099188; cv=none; b=cmLajCcsLJwjY7EZyHZZ9AN7PRYiwtRXsqLyxXFpTpU+tLTKhAElzYHYzGPXgXGDiztPVFQ64cikjausRIMA7u+F/X9tiifd6mmXfbAInfUS92Jmi/LIjbWcsQyn53cIJNgpEMxPY37tr0MoXeooHR9xa9K4i2MmMH9FRAgpLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789099188; c=relaxed/simple;
	bh=scYRCW1PmMF7LMvqbjKMAR0tIErTtjSSnYOfgR1MZtA=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=WMUF39q83R4V62EvK3MdcPJ/xib4qfg66GYRkrNcMYKeO2jJTbOeYbyyW+XrfAIzenKC+AfSLTElu8sCbVkvc9yTNvLor9IAhJCRQu7m1Y0k0aQAtFQuoXLuMKnMRHugUaDpXpDsuNJ7DJ2qi+yZgtDESKh5giK2HFjC4udbyQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4hh15L4841z58fdL;
	Fri, 11 Sep 2026 11:59:34 +0800 (CST)
Received: from njy2app04.zte.com.cn ([10.40.12.64])
	by mse-fl2.zte.com.cn with SMTP id 68B3xSIq019649;
	Fri, 11 Sep 2026 11:59:28 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njy2app04[null])
	by mapi (Zmail) with MAPI id mid204;
	Fri, 11 Sep 2026 11:59:29 +0800 (CST)
X-Zmail-TransId: 2afc6aa37ca1f49-8c66b
X-Mailer: Zmail v1.0
Message-ID: <20260911115929435mXJzcTF08xlUAdjnT8qqm@zte.com.cn>
In-Reply-To: <20260911115632342CS2YMSVejTTmnYEU3XbRs@zte.com.cn>
References: 20260911115632342CS2YMSVejTTmnYEU3XbRs@zte.com.cn
Date: Fri, 11 Sep 2026 11:59:29 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <han.junyang@zte.com.cn>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <han.junyang@zte.com.cn>, <ran.ming@zte.com.cn>,
        <han.chengfei@zte.com.cn>, <zhang.yanze@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHYyIDEvM10gZGluZ2hhaTogYWRkIGZpcm13YXJlIHZlcnNpb24gY2hlY2sgYW5kwqBSSVNDLVYgcmVhZGluZXNzIHBvbGxpbmc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 68B3xSIq019649
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 11 Sep 2026 11:59:34 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AA37CA6.000/4hh15L4841z58fdL

From: Junyang Han <han.junyang@zte.com.cn>

The DingHai firmware publishes a version compatibility block and a
RISC-V health buffer at fixed offsets within BAR 0.

After the PCI capabilities are mapped, poll the compatibility block
until the firmware populates it (the region reads as all ones until
then) and verify the driver/firmware version contract. Then wait for
the RISC-V management core to set its power-on flag in the health
buffer before the rest of the probe continues.

Firmware images predating the health buffer protocol (health version
other than 1 and patch level below ZXDH_HPIRQ_PATCH) skip the
readiness wait.

Signed-off-by: Junyang Han <han.junyang@zte.com.cn>
---
 drivers/net/ethernet/zte/dinghai/en_pf.c | 107 +++++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h |  46 ++++++++++
 2 files changed, 153 insertions(+)

diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
index 86d437408820..d257d8e9b612 100644
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
@@ -369,6 +371,99 @@ int zxdh_pf_modern_cfg_init(struct zxdh_core_dev *zxdh_dev)
 	return ret;
 }

+/* Read the firmware version block and verify the driver/firmware
+ * version contract.
+ */
+static int zxdh_pf_fw_compat_check(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
+	struct zxdh_fw_compat __iomem *compat;
+	struct zxdh_fw_compat *fw_compat;
+	u32 erased;
+
+	fw_compat = &pf_dev->fw_compat;
+	compat = pf_dev->pci_ioremap_addr[0] + ZXDH_FW_COMPAT_OFFSET;
+
+	/* The region reads as all ones until the firmware populates it at
+	 * the end of its boot; allow up to 200 s for a cold boot.
+	 */
+	readx_poll_timeout(ioread32, compat, erased, erased != 0xffffffffU,
+			   USEC_PER_SEC,
+			   ZXDH_FW_COMPAT_TIMEOUT_SEC * USEC_PER_SEC);
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
+			"firmware fw_minor %d older than required %u\n",
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
+	/* Firmware predating the health buffer protocol has neither a
+	 * valid version byte nor a power-on flag to wait for.
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
@@ -405,6 +500,18 @@ static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_cfg_init;
 	}

+	ret = zxdh_pf_fw_compat_check(zxdh_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "zxdh_pf_fw_compat_check failed: %d\n", ret);
+		goto err_cfg_init;
+	}
+
+	ret = zxdh_pf_wait_riscv_ready(zxdh_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "zxdh_pf_wait_riscv_ready failed: %d\n", ret);
+		goto err_cfg_init;
+	}
+
 	devlink_register(devlink);

 	return 0;
diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.h b/drivers/net/ethernet/zte/dinghai/en_pf.h
index 7373dee8d1a9..bc275ddd75b8 100644
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
+/* Firmware patch level that introduced the health buffer protocol. */
+#define ZXDH_HPIRQ_PATCH	4
+
+#define ZXDH_FW_COMPAT_TIMEOUT_SEC	200
+#define ZXDH_RISCV_READY_TIMEOUT_SEC	40
+
+/* Firmware version compatibility block at ZXDH_FW_COMPAT_OFFSET.
+ * Fields are read through ioread*(), which converts from little-endian.
+ */
+struct zxdh_fw_compat {
+	u8 module_id;
+	u8 major;
+	s8 fw_minor;
+	u8 drv_minor;
+	u16 patch;
+	u16 rsv;
+} __packed;
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
+	u8 health_version;	/* Health buffer protocol version. */
+	u8 rsv1[30];
+} __packed;
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
