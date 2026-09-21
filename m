Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DBB388891;
	Mon, 21 Sep 2026 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973836; cv=none; b=j4NfbKk5jUmIevTgYBYADto66Zmq1s3H7hM+XGBDtXBtF0s2v6ykseMUfKf4Eo7QQava8UyGu/V4ZyU+lU58XGxdaRBvWMUg/cN81cTqG/Kl540IJsubREJB21h8whK8q0hvESrC7NgZazYJ5e8Z8xHJZvCCZ2wZEiDRR3XCbC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973836; c=relaxed/simple;
	bh=3XjpHcm6i1dagWH7iXnSk4O2CnytZU7aj2Zi8WixLzk=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=ojubZakCu1z7OMIaafuotgmzJe12U7nzqcLaDF6GmuPrZDFzxVdknujylTA9iA81GyRPee6ABKet14gjS59QUFLcEI9y9Qy1eXAbb5oJEqPddBnypeo76KLW8oDBgWdIvB8HHe6uABg0GYazj9y/BmQuuAP/CeVswkOUoQGY9gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hpDYM5Xy2z5BNS0;
	Mon, 21 Sep 2026 14:56:55 +0800 (CST)
Received: from njb2app06.zte.com.cn ([10.55.23.119])
	by mse-fl1.zte.com.cn with SMTP id 68L6ugkO039172;
	Mon, 21 Sep 2026 14:56:42 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njb2app07[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 21 Sep 2026 14:56:44 +0800 (CST)
X-Zmail-TransId: 2aff6ab0d52cc14-7ad89
X-Mailer: Zmail v1.0
Message-ID: <202609211456442872LYTVrDg_UG7l6DJ0Slmt@zte.com.cn>
In-Reply-To: <202609211451400236_aZ55Ox3y7NW8MQnYImM@zte.com.cn>
References: 202609211451400236_aZ55Ox3y7NW8MQnYImM@zte.com.cn
Date: Mon, 21 Sep 2026 14:56:44 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHYzIDEvM10gZGluZ2hhaTogYWRkIGZpcm13YXJlIHZlcnNpb24gY2hlY2sgYW5kCiBSSVNDLVYgcmVhZGluZXNzIHBvbGxpbmc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 68L6ugkO039172
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 21 Sep 2026 14:56:55 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AB0D537.001/4hpDYM5Xy2z5BNS0

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
 drivers/net/ethernet/zte/dinghai/en_pf.c | 113 +++++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h |  46 +++++++++
 2 files changed, 159 insertions(+)

diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
index 86d437408820..7c991e0951a8 100644
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
@@ -369,6 +371,103 @@ int zxdh_pf_modern_cfg_init(struct zxdh_core_dev *zxdh_dev)
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
@@ -405,10 +504,24 @@ static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
index 7373dee8d1a9..d917f0147269 100644
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
+	u8 fw_minor;
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
