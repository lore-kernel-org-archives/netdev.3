Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD1842123F;
	Mon,  7 Sep 2026 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767259; cv=none; b=GPSkADOh/hW73m31FblmTvUXiOeu3H7QjPiyXA1f1CQuRwxcKDtGzRamjmV1TwTbtdpgouh3Mg4ZCDWS2n31QBa6wMlmrCUARRro0zNOjFoGzy4AsBSdX8eT7GsBcpZui3c2U8Rd/syWeAKLySFiafoMA3vCdV9b+nYuHz6r4sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767259; c=relaxed/simple;
	bh=yTRJ3O2vGzuKktzCTO2ExXjbMgtp5fK54GThI+QzDJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C9MgwLFVt0qGQQP+d/h06zMvfGE7vyne/CAeBlNlbBG8MpO54DfBr2fXWDYA9xKxVeKyDhoKGP8Crmk5jtvkWbg24Ecx3DFb+whvOsopH1zUrqXZN6s62lDLxB8jdMXXSCVShtq8IWnZ2oKGwIuQxLxIfDnFcWHs10oRtyIVR88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=qQMDxo0u; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="qQMDxo0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=atDrDIj1PcjKidTFHnL55UaKYtXCuL3
	hBASpWFdruY8=; b=qQMDxo0uhM2xATPD9kUqsI4XafS8ffqKSBddZagzdL0h2d2
	6P7SY7IchW58qpVRciRM+eTJsooa30zDKgCwwTid4xQmmgcGLwxJvwV2VVJ2oqe0
	G/FMFMP9DrxNJR1kJmHof6c5zFcpHnrDhnwoZ55Zpvt8B02ESsmCEqmNC1dg=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDHQAf_a55qnlUAAA--.364S7;
	Mon, 07 Sep 2026 15:47:26 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Mon, 07 Sep 2026 15:46:54 +0800
Subject: [PATCH net-next v2 5/5] net: stmmac: Add UltraRISC DP1000 GMAC
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-dwmac-ultrarisc-v2-5-9a39bf8db313@ultrarisc.com>
References: <20260907-dwmac-ultrarisc-v2-0-9a39bf8db313@ultrarisc.com>
In-Reply-To: <20260907-dwmac-ultrarisc-v2-0-9a39bf8db313@ultrarisc.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Chen Wang <chen.wang@linux.dev>, 
 Inochi Amaoto <inochiama@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, Jia Wang <wangjia@ultrarisc.com>, 
 sophgo@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788767221; l=4434;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=yTRJ3O2vGzuKktzCTO2ExXjbMgtp5fK54GThI+QzDJk=;
 b=wDw1qcKWmwEtubwcSkYU+uZyIRt7R2Vkdkz38DrQgy66mEEWAge3zp5nn9c9vAPbSQU5CpG/I
 kgS/iquNGGWBE+DZWk4Stnw5XECEOF0zPWM0Aa6MW2Q7u19Dye9CpZv
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwDHQAf_a55qnlUAAA--.364S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZr43JFy7CFWrtF4xZw15CFg_yoWruF4DpF
	WDCa43Zr97Jr43Ka1fJw1kuF95tay8trW7WFyfKwnaqFZ0yryYqr9rK3y5AF1DGrWDXFy2
	yr4UCwnrCan0v37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
	Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
	IIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRiF4iUUUUU=
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQACEWqdDaQAAQAVsY

The UltraRISC DP1000 GMAC provides fixed internal delays on both TX and RX
RGMII clock paths.

Add a platform glue driver and describe both delay capabilities through
the common stmmac platform data. This lets the common RGMII delay handling
adjust the interface mode passed to the PHY and reject incompatible RGMII
modes.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 MAINTAINERS                                        |  1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig        | 11 +++++
 drivers/net/ethernet/stmicro/stmmac/Makefile       |  1 +
 .../net/ethernet/stmicro/stmmac/dwmac-ultrarisc.c  | 52 ++++++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01597d1df270..d6fb876227e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27999,6 +27999,7 @@ ULTRARISC DP1000 DWMAC GLUE LAYER
 M:	Jia Wang <wangjia@ultrarisc.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/ultrarisc,dp1000-gmac.yaml
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-ultrarisc.c
 
 ULTRARISC DP1000 PINCTRL DRIVER
 M:	Jia Wang <wangjia@ultrarisc.com>
diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index e3dd5adda5ac..ab3c4cf96423 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -319,6 +319,17 @@ config DWMAC_THEAD
 	  the stmmac device driver. This driver is used for T-HEAD TH1520
 	  ethernet controller.
 
+config DWMAC_ULTRARISC
+	tristate "UltraRISC DWMAC support"
+	default ARCH_ULTRARISC
+	depends on OF && (ARCH_ULTRARISC || COMPILE_TEST)
+	help
+	  Support for the Ethernet controller on the UltraRISC DP1000 SoC.
+
+	  This selects the UltraRISC platform specific glue layer support
+	  for the stmmac device driver. This driver is used for the DP1000
+	  GMAC Ethernet controller.
+
 config DWMAC_IMX8
 	tristate "NXP IMX8 DWMAC support"
 	default ARCH_MXC
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index a1cea2f57252..b16a456b730e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_DWMAC_SUNXI)	+= dwmac-sunxi.o
 obj-$(CONFIG_DWMAC_SUN8I)	+= dwmac-sun8i.o
 obj-$(CONFIG_DWMAC_SUN55I)	+= dwmac-sun55i.o
 obj-$(CONFIG_DWMAC_THEAD)	+= dwmac-thead.o
+obj-$(CONFIG_DWMAC_ULTRARISC)	+= dwmac-ultrarisc.o
 obj-$(CONFIG_DWMAC_DWC_QOS_ETH)	+= dwmac-dwc-qos-eth.o
 obj-$(CONFIG_DWMAC_INTEL_PLAT)	+= dwmac-intel-plat.o
 obj-$(CONFIG_DWMAC_LOONGSON1)	+= dwmac-loongson1.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ultrarisc.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ultrarisc.c
new file mode 100644
index 000000000000..0b62a75b782a
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ultrarisc.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UltraRISC DWMAC platform driver
+ *
+ * Copyright (C) 2026 UltraRISC Technology (Shanghai) Co., Ltd.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "stmmac_platform.h"
+
+static int ultrarisc_dwmac_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get resources\n");
+
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR(plat_dat))
+		return dev_err_probe(dev, PTR_ERR(plat_dat),
+				     "failed to parse DT parameters\n");
+
+	plat_dat->has_internal_tx_delay = true;
+	plat_dat->has_internal_rx_delay = true;
+
+	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
+}
+
+static const struct of_device_id ultrarisc_dwmac_match[] = {
+	{ .compatible = "ultrarisc,dp1000-gmac" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ultrarisc_dwmac_match);
+
+static struct platform_driver ultrarisc_dwmac_driver = {
+	.probe = ultrarisc_dwmac_probe,
+	.driver = {
+		.name = "ultrarisc-dwmac",
+		.pm = &stmmac_pltfr_pm_ops,
+		.of_match_table = ultrarisc_dwmac_match,
+	},
+};
+module_platform_driver(ultrarisc_dwmac_driver);
+
+MODULE_DESCRIPTION("UltraRISC DWMAC platform driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

