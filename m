Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF2383C85;
	Sun, 23 Aug 2026 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787513746; cv=none; b=aznEDjvXBcwPCjqPWdMoSbHnSong5Lu2r0lFRIrrAKwe4yX2JF4CpnSLiPtYZPQa0tYgr+38H7efa44SirdFByAKWeP18TrgfaqMiRD8KtfxB9r7CB/mrJTfRGChcSNElf3Np7rCue9mJi5Gtsfl3LrRSZnkLqSufK7jPVuM4Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787513746; c=relaxed/simple;
	bh=i8m8Zm44SiLLp/+YfQXWpzXz3v1kX0ua9zOKSWvMcoM=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=ZRZXmV2ehhV4dOxrONCEMN6okcBeeYO2RIphYBewweu97vodih4fkBGk8nsnqXU2H9hgtfIU2owymZYRbXnXOEIUdZKVcBX6Cpb444KDeDGtZ4EmB3bC/bUF/0xxyZcmBIBU2kIbUQ0oHMaMnmX4PIRFcEY22JiiNPaM0wJUEZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hSkmG41SCz8Xrkn;
	Mon, 24 Aug 2026 03:35:42 +0800 (CST)
Received: from njy2app03.zte.com.cn ([10.40.13.14])
	by mse-fl1.zte.com.cn with SMTP id 67NJZXic085811;
	Mon, 24 Aug 2026 03:35:33 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njy2app03[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 24 Aug 2026 03:35:38 +0800 (CST)
X-Zmail-TransId: 2afb6a8b4b8ae6c-27878
X-Mailer: Zmail v1.0
Message-ID: <20260824033538020rXU4GiMrh05w37DWs5k7v@zte.com.cn>
In-Reply-To: <20260824033249934VsArgTPOU_qew94PPABbD@zte.com.cn>
References: 20260824033249934VsArgTPOU_qew94PPABbD@zte.com.cn
Date: Mon, 24 Aug 2026 03:35:38 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHYxIDEvM10gZGluZ2hhaTogYWRkIGZpcm13YXJlIHZlcnNpb24gY2hlY2sgYW5kCiBSSVNDLVYgcmVhZGluZXNzIHBvbGxpbmc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 67NJZXic085811
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 24 Aug 2026 03:35:42 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A8B4B8E.000/4hSkmG41SCz8Xrkn

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
 drivers/net/ethernet/zte/dinghai/en_pf.c | 103 +++++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h |  46 ++++++++++
 2 files changed, 149 insertions(+)

diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
index 86d437408820..232d95420d2e 100644
--- a/drivers/net/ethernet/zte/dinghai/en_pf.c
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.c
@@ -6,6 +6,8 @@

 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/io.h>
 #include <net/devlink.h>
 #include <linux/dma-mapping.h>
 #include "en_pf.h"
@@ -369,6 +371,95 @@ int zxdh_pf_modern_cfg_init(struct zxdh_core_dev *zxdh_dev)
 	return ret;
 }

+/* Read the firmware version block and verify the driver/firmware
+ * version contract.
+ */
+static int zxdh_pf_fw_compat_check(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
+	struct zxdh_fw_compat *fw_compat;
+	void __iomem *compat_base;
+	int i;
+
+	fw_compat = &pf_dev->fw_compat;
+	compat_base = pf_dev->pci_ioremap_addr[0] + ZXDH_FW_COMPAT_OFFSET;
+
+	/* The region reads as all ones until the firmware populates it at
+	 * the end of its boot; allow up to 200 s for a cold boot.
+	 */
+	for (i = 0; i < ZXDH_FW_COMPAT_TIMEOUT_SEC; i++) {
+		if (ioread32(compat_base) != 0xffffffffU)
+			break;
+		msleep(MSEC_PER_SEC);
+	}
+
+	/* Firmware predating the compatibility region keeps the erased
+	 * pattern, which fails the module id check below and defers the
+	 * decision to the readiness wait.
+	 */
+	ioread32_rep(compat_base, fw_compat, sizeof(*fw_compat) / 4);
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
+	int i;
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
+	for (i = 0; i < ZXDH_RISCV_READY_TIMEOUT_SEC; i++) {
+		if (ioread8(&hb->riscv_power_on) == 1)
+			return 0;
+		msleep(MSEC_PER_SEC);
+	}
+
+	dev_err(zxdh_dev->device, "timed out waiting for riscv power on\n");
+	return -ETIMEDOUT;
+}
+
 static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct zxdh_core_dev *zxdh_dev;
@@ -405,6 +496,18 @@ static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
index 7373dee8d1a9..a1e2b24d861d 100644
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
+ * Copied out with ioread32_rep(), which converts from little-endian.
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
