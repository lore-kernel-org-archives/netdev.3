Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C89481AAE;
	Wed, 14 Oct 2026 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962145; cv=none; b=KuAp6wRTdQa4fctDsjfQhR+k27cC+neK2mZRzpRQvLSYsdOINzZC4dLo/Y6w0bKuNTcM/JGYEoLHU49wr6pRP8czE+RkzCe1Nt1F0E7kVmjTDHqB2nZzAgZbH9NHwEuds9k8SFmITRw9HlZgI5uYGpRuH8eBq+Bs+CA4rR/g2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962145; c=relaxed/simple;
	bh=K+f8WLpUrGziB3jE6nrp82KYl73LPQxVQjFPNxSQL7Q=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=E82++B/wbBVJQowDJZZfqzAnFBrUlVRtKlF2CU2KgFGTz0Nn8FGvoegXnw9Aa0pviOkaMg6ZnGjkuMRhKX3iTQp2DbqXKjFmdlmB1xKRKzcn6pAhfXClpuVCi/0ps7YWNGzaT9sEuoCtYsm5FSm0pbH7fZFo88ps7aGN24c3VUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j4MtN65l8z4yjjW;
	Wed, 14 Oct 2026 15:15:40 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4j4Mt765mRz57HS2;
	Wed, 14 Oct 2026 15:15:27 +0800 (CST)
Received: from njb2app07.zte.com.cn ([10.55.22.95])
	by mse-fl1.zte.com.cn with SMTP id 69E7FIZG008528;
	Wed, 14 Oct 2026 15:15:18 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njy2app02[null])
	by mapi (Zmail) with MAPI id mid204;
	Wed, 14 Oct 2026 15:15:20 +0800 (CST)
X-Zmail-TransId: 2afa6acf2c08e40-ee686
X-Mailer: Zmail v1.0
Message-ID: <20261014151520214vlXLCh0n7cyLViOvFGDOP@zte.com.cn>
In-Reply-To: <20261014151200489685SCIlolykW0NGfL5EtQ@zte.com.cn>
References: 20261014151200489685SCIlolykW0NGfL5EtQ@zte.com.cn
Date: Wed, 14 Oct 2026 15:15:20 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHY1IDEvM10gZGluZ2hhaTogYWRkIGZpcm13YXJlIHZlcnNpb24gY2hlY2sgYW5kCiBSSVNDLVYgcmVhZGluZXNzIHBvbGxpbmc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 69E7FIZG008528
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 192.168.251.13 unknown Wed, 14 Oct 2026 15:15:40 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ACF2C1C.000/4j4MtN65l8z4yjjW

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
