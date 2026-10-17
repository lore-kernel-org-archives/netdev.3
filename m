Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158393E714C
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 05:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215907; cv=none; b=i2ve8GXNsdwyY/341HKK40MdmqSos7IqAfxFtPtbsitE4PzpdOcJWDpWVgl1H4tj5yc+dgtUpWA473VvnMgz8p+9wSUe+KRp6EMWbHFm48kXsaoneSS3YUbrlvYMkj5PY8Zjtt3oPZKcKpQhVDftiCEX3504QDJwq78ZSnzg2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215907; c=relaxed/simple;
	bh=46ntJWSwFr8e27uuUcVK/q8xYXleD80MRuBTU/MK0pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvnFfY/KgKn5zkp3tFqOu+bpCXx4h6wgLopXcvM2qglOgWD2QYGQMTy9TmwBeEHiOa1SmcJMZnF9BCnqFju2/oVtRSug1db/ebTYsdpgZ1hzQ5pMxnuLu9ciOEaMGsOcHkyrX+PAzkjGIw8jvAksmCVZ5UtdGJ6HYDEhYkCP8bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjKWtxs7; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjKWtxs7"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3abe4821449so348474a91.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 22:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792215903; x=1792820703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K0GqQQk+9GyAw7oWlNGoSvLc6iKGfNVV5C8Ix0zpvmE=;
        b=RjKWtxs7sVANq1nVuVoevGOfJxT0+yDgLQGqV0klf1u+KXzqtLnPD1tckfe3ejwWDy
         BMpacuoxcVSWoR4KZhxSf0G83ARHD5nuVQSzKPa2MzbP7hjSYozguhZXCG45N6D3aG1n
         g9u+RBcmBofNfkv4sGJVDYLPUjB9VPO661dvkO647++h5yNizuZXv4u04ZsVhMbRdq/W
         LSP4UuOkYcoBYAsjKq8QNbKwNqXQPWvXDBGyaGsw0TdjKpXG/3YYPzcIuh+xGcUwIf1x
         nsueyj+EupF+gV4aaPIm8O/a8+VWXmomhTmyr8LwTiYvQKb13BbiSa7hondOcDLnbVSu
         7JIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792215903; x=1792820703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K0GqQQk+9GyAw7oWlNGoSvLc6iKGfNVV5C8Ix0zpvmE=;
        b=22X4pVNq29SfNSiOXzvTIxaXpsV997IVdwVrR9iQmXoeeXzYmaqaPOsbsAAXDcK6bU
         2+xjmuUMYGGSSWzTgFfv0fxBIWZu2F226MuxO8QBwp0ZMmDVbA4JbGys9lusYBjPkm2/
         cu2XLrJafU0aWHvxFWDOEKaLl3SV4IUjHHbR0HZ39/kZKkqUCnhJzsrfEWHmixGxUck1
         UdNZKIFoZenaYpYgb3wrInmzHMrhYt+bt/HNzBy61hIyRMmh5joSrWa96ec5mnZsoLtq
         lX9A2jA5MUuGqlt7hKePfZDHV9iygDFf0GV/kp4oguZgQvAqSytn0VjO8f/5ZTXFTXSy
         wMGQ==
X-Forwarded-Encrypted: i=1; AKwUvByDvFHHnNUL3vi+qfPtiDEmMR1h/yfJXTqynhls6wDoRwUMz6gKA3S8Q0/jc7usKNRWSw4P1o8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbxqbcdIE7gfHEZiIdkXbrfBVbiyMslyUlGc+kUhCh3azFaYC+
	l+G4LOhLpEtJiONDkCLcT2b7xL1A89SPSrBSfUoEnyrwD6SmQHHy9wH7
X-Gm-Gg: AYBFou1q38YwqAa4v1Q5CpFQ/e97VQAKOSK06nia0bRQxq9PN4ebWCjkULt+ZFRDvLB
	Ejy4gX3ZTtu3TDXzeoqA7b9avAkqIewq4MwtRMJyDhI8Y1ERFy9yrt9zdPqbd/j4B9hHSZtd2Kk
	Mfy3g0eXtrSE+zbpdVSnG+sf5JF13YcWVxK9D+cElv2lzaqq/1S+pREjBOchfmpQEAS2BJuvbC/
	U3eYfNXRXGjv5cxaVK6L8lK3F6aD1uAWJ6zaj6fhVaAqdy0/parehJ8D07awhHsnFSr7bP/6f9/
	siy2M2Bwy250QC9dzEPhOzpc1w9+9gZZM7zM92vjKBb6GuFwZpcmsEMKAmUN7U9vscHP+2ewhUk
	MQ58EuUe3X9cf11z23LUBFwuaoOOG/6X283sRGF10qtYJuVJVVeBlan3pXCZPc/D79xqTTE7kJn
	n98FGxyg3S3VtY2kObY1BHjW41deyjXGv0UNqcpJInNzCYoj5pQP3Bzty67CrHlVVEtLYk
X-Received: by 2002:a05:6a21:6e96:b0:3e1:65e8:c818 with SMTP id adf61e73a8af0-3e2260e7c99mr1371618637.54.1792215903308;
        Fri, 16 Oct 2026 22:45:03 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57269315sm1958225b3a.23.2026.10.16.22.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:45:01 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	David Wu <david.wu@rock-chips.com>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net-next v12 3/6] net: pcs: xpcs: add Rockchip RK3568 platform glue driver
Date: Sat, 17 Oct 2026 13:44:01 +0800
Message-ID: <20261017054406.1828061-4-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261017054406.1828061-1-coiaprant@gmail.com>
References: <20261017054406.1828061-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3568 SoC integrates a Synopsys DesignWare XPCS that is accessed
via APB3 memory-mapped registers.  This driver provides the glue logic
to make the XPCS accessible to the generic pcs-xpcs core.

The XPCS block contains four MII ports (0..3).  On RK3568 the MII port
used by SGMII follows the MAC it is routed to: GMAC0 maps to port 0 and
GMAC1 maps to port 1.  The glue driver receives the port index from the
MAC side and passes it to xpcs_create_mdiodev().

The hardware maps these ports to different MMDs:
  - port 0: MMD 7 (ROCKCHIP_MMD_MII)
  - port 1: MMD 2 (ROCKCHIP_MMD_MII1)
  - port 2: MMD 3 (ROCKCHIP_MMD_MII2)
  - port 3: MMD 4 (ROCKCHIP_MMD_MII3)

This driver creates a virtual MDIO bus that translates MDIO operations
to APB3 register accesses, with proper address remapping for each port.
The generic xpcs driver then creates a phylink_pcs instance on top of
this bus, allowing the MAC to use the PCS via the standard phylink API.

The generic XPCS platform glue (pcs-xpcs-plat.o) is split out of the
pcs_xpcs composite object into its own module, gated behind the new
PCS_XPCS_PLATFORM symbol.  There is no in-tree user of the generic
snps,dw-xpcs glue that would need it selected by default, so the symbol
has no default and platforms that need it select it explicitly.

PCS_XPCS_ROCKCHIP selects GENERIC_PHY and PM_GENERIC_DOMAINS.
ARCH_ROCKCHIP already selects PM, so the dependency of PM_GENERIC_DOMAINS
on PM is satisfied on the target platform.

The EEE multiplier is derived at runtime from the EEE clock rate instead
of being hardcoded, because the clock is muxed between gpll200 (200 MHz)
and cpll125 (125 MHz) and can be changed by the board or firmware.  A
64-bit intermediate avoids overflow on 32-bit builds, and the result is
clamped to the 4-bit DW_VR_MII_EEE_MULT_FACT_100NS field.

Power management
================
The XPCS, its SerDes PHY and the SATA/PCIe controllers share the PD_PIPE
power domain on RK3568.  genpd powers the domain down during system
suspend once every consumer is suspended, which also kills the SerDes
and the XPCS.

Boards that rely on MAC WoL need the PCS and SerDes alive to receive
magic packets, so PD_PIPE must stay powered across system suspend.  Keep
it on by marking the XPCS as part of the wakeup path via
device_set_wakeup_path().  genpd then leaves the domain powered, because
the Rockchip power domain driver sets GENPD_FLAG_ACTIVE_WAKEUP on
PD_PIPE, which makes genpd check the wakeup path of its consumers during
system suspend.

This is unconditional because the XPCS core currently has no platform
callback through which a consumer could convey the MAC WoL state, and
the state itself is dynamic: WoL is toggled at runtime via ethtool, so
a static DT property cannot express it either.  The affected hardware
is limited to RK3568 boards using SGMII, which are always-on routers
where system suspend is not a realistic use case; the extra power draw
is therefore acceptable.

Runtime PM is unaffected: the runtime callbacks only gate the CSR clock,
and dev_pm_genpd_rpm_always_on() already keeps PD_PIPE on at runtime.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 59, CRU_CLKSEL_CON29)
Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part2%20V1.1-20210301.pdf (Page 2078)
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/pcs/Kconfig         |  23 ++
 drivers/net/pcs/Makefile        |   5 +-
 drivers/net/pcs/pcs-xpcs-rk.c   | 598 ++++++++++++++++++++++++++++++++
 include/linux/pcs/pcs-xpcs-rk.h |  11 +
 4 files changed, 635 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/pcs/pcs-xpcs-rk.c
 create mode 100644 include/linux/pcs/pcs-xpcs-rk.h

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index e417fd66f660a..108d47257bee2 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -12,6 +12,29 @@ config PCS_XPCS
 	  This module provides a driver and helper functions for Synopsys
 	  DesignWare XPCS controllers.
 
+if PCS_XPCS
+
+config PCS_XPCS_PLATFORM
+	tristate "Generic XPCS controller support"
+	help
+	  Generic DWXPCS driver for platforms that don't require any
+	  platform specific code to function or is using platform
+	  data for setup.
+
+	  If you have a controller with this interface, say Y or M here.
+
+config PCS_XPCS_ROCKCHIP
+	tristate "Rockchip XPCS controller support"
+	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
+	select GENERIC_PHY
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  Support for XPCS controller on Rockchip RK356x SoC.
+
+	  If you have a Rockchip SoC with this interface, say Y or M here.
+
+endif # PCS_XPCS
+
 config PCS_LYNX
 	tristate
 	help
diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
index 4f7920618b900..f9f6cf2578d72 100644
--- a/drivers/net/pcs/Makefile
+++ b/drivers/net/pcs/Makefile
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for Linux PCS drivers
 
-pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-plat.o \
-				   pcs-xpcs-nxp.o pcs-xpcs-wx.o
+pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-nxp.o pcs-xpcs-wx.o
 
 obj-$(CONFIG_PCS_XPCS)		+= pcs_xpcs.o
+obj-$(CONFIG_PCS_XPCS_PLATFORM) += pcs-xpcs-plat.o
+obj-$(CONFIG_PCS_XPCS_ROCKCHIP) += pcs-xpcs-rk.o
 obj-$(CONFIG_PCS_LYNX)		+= pcs-lynx.o
 obj-$(CONFIG_PCS_MTK_LYNXI)	+= pcs-mtk-lynxi.o
 obj-$(CONFIG_PCS_RZN1_MIIC)	+= pcs-rzn1-miic.o
diff --git a/drivers/net/pcs/pcs-xpcs-rk.c b/drivers/net/pcs/pcs-xpcs-rk.c
new file mode 100644
index 0000000000000..698a43b753341
--- /dev/null
+++ b/drivers/net/pcs/pcs-xpcs-rk.c
@@ -0,0 +1,598 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Rockchip XPCS platform device driver
+ *
+ * Based on the Synopsys DesignWare XPCS platform driver.
+ * Copyright (C) 2024 Serge Semin
+ *
+ * Adapted for Rockchip SoCs, with reference to the Rockchip OEM driver.
+ * Copyright (C) 2026 Coia Prant
+ */
+
+#include <linux/atomic.h>
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/math.h>
+#include <linux/mdio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pcs/pcs-xpcs-rk.h>
+#include <linux/phy.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/sizes.h>
+#include <linux/time.h>
+
+#include "pcs-xpcs.h"
+
+struct dw_xpcs_rk {
+	struct platform_device *pdev;
+	struct mii_bus *bus;
+	void __iomem *reg_base;
+	struct phy *serdes_phy;
+	struct clk *csr_clk;
+	struct clk *eee_clk;
+	u8 eee_mult_fact;
+};
+
+static ptrdiff_t xpcs_rk_addr_format(int dev, int reg)
+{
+	return FIELD_PREP(0x70000, dev) | FIELD_PREP(0xffff, reg);
+}
+
+static int xpcs_rk_read_reg(struct dw_xpcs_rk *pxpcs, int dev, int reg)
+{
+	ptrdiff_t csr;
+	int ret;
+
+	csr = xpcs_rk_addr_format(dev, reg);
+
+	ret = pm_runtime_resume_and_get(&pxpcs->pdev->dev);
+	if (ret)
+		return ret;
+
+	ret = readl(pxpcs->reg_base + (csr << 2)) & 0xffff;
+
+	pm_runtime_put(&pxpcs->pdev->dev);
+	return ret;
+}
+
+static int xpcs_rk_write_reg(struct dw_xpcs_rk *pxpcs, int dev, int reg, u16 val)
+{
+	ptrdiff_t csr;
+	int ret;
+
+	csr = xpcs_rk_addr_format(dev, reg);
+
+	ret = pm_runtime_resume_and_get(&pxpcs->pdev->dev);
+	if (ret)
+		return ret;
+
+	writel(val, pxpcs->reg_base + (csr << 2));
+
+	pm_runtime_put(&pxpcs->pdev->dev);
+	return 0;
+}
+
+#define ROCKCHIP_MMD_MII1	2
+#define ROCKCHIP_MMD_MII2	3
+#define ROCKCHIP_MMD_MII3	4
+#define ROCKCHIP_MMD_PMAPMD	6
+#define ROCKCHIP_MMD_MII	7
+
+static bool xpcs_rk_mdio_addr_validate(int addr)
+{
+	return !(addr < 0 || addr > 3);
+}
+
+static int xpcs_rk_mdio_read_remapping(int addr, int dev)
+{
+	switch (dev) {
+	case MDIO_MMD_PMAPMD:
+		return ROCKCHIP_MMD_PMAPMD;
+	case MDIO_MMD_VEND2:
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	/*
+	 * Reads are redirected by hardware to the port's read-only mirror;
+	 * only writes have to be targeted at MII (see the write path).
+	 */
+	switch (addr) {
+	case 0:
+		return ROCKCHIP_MMD_MII;
+	case 1:
+		return ROCKCHIP_MMD_MII1;
+	case 2:
+		return ROCKCHIP_MMD_MII2;
+	case 3:
+		return ROCKCHIP_MMD_MII3;
+	default:
+		return -ENODEV;
+	}
+}
+
+static int xpcs_rk_mdio_write_remapping(int addr, int dev, int reg)
+{
+	switch (dev) {
+	case MDIO_MMD_PMAPMD:
+		return ROCKCHIP_MMD_PMAPMD;
+	case MDIO_MMD_VEND2:
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	/*
+	 * These registers physically live only in MII (the management port).
+	 * Ports 1-3 expose read-only mirrors of these bits, so writes must
+	 * always target MII; the read path remaps per address and the
+	 * hardware redirects to the port's mirror.
+	 */
+	switch (reg) {
+	case DW_VR_MII_AN_CTRL:
+	case DW_VR_MII_AN_INTR_STS:
+	case DW_VR_MII_EEE_MCTRL0:
+	case DW_VR_MII_EEE_MCTRL1:
+	case DW_VR_MII_DIG_CTRL2:
+		return ROCKCHIP_MMD_MII;
+	default:
+		break;
+	}
+
+	switch (addr) {
+	case 0:
+		return ROCKCHIP_MMD_MII;
+	case 1:
+		return ROCKCHIP_MMD_MII1;
+	case 2:
+		return ROCKCHIP_MMD_MII2;
+	case 3:
+		return ROCKCHIP_MMD_MII3;
+	default:
+		return -ENODEV;
+	}
+}
+
+static int xpcs_rk_read_c22(struct mii_bus *bus, int addr, int reg)
+{
+	struct dw_xpcs_rk *pxpcs = bus->priv;
+	int dev;
+
+	if (!xpcs_rk_mdio_addr_validate(addr))
+		return -ENODEV;
+
+	dev = xpcs_rk_mdio_read_remapping(addr, MDIO_MMD_VEND2);
+	if (dev < 0)
+		return 0xffff;
+
+	return xpcs_rk_read_reg(pxpcs, dev, reg);
+}
+
+static int xpcs_rk_write_c22(struct mii_bus *bus, int addr, int reg, u16 val)
+{
+	struct dw_xpcs_rk *pxpcs = bus->priv;
+	int dev;
+
+	if (!xpcs_rk_mdio_addr_validate(addr))
+		return -ENODEV;
+
+	dev = xpcs_rk_mdio_write_remapping(addr, MDIO_MMD_VEND2, reg);
+	if (dev < 0)
+		return 0;
+
+	return xpcs_rk_write_reg(pxpcs, dev, reg, val);
+}
+
+static int xpcs_rk_read_c45(struct mii_bus *bus, int addr, int dev, int reg)
+{
+	struct dw_xpcs_rk *pxpcs = bus->priv;
+
+	if (!xpcs_rk_mdio_addr_validate(addr))
+		return -ENODEV;
+
+	dev = xpcs_rk_mdio_read_remapping(addr, dev);
+	if (dev < 0)
+		return 0xffff;
+
+	return xpcs_rk_read_reg(pxpcs, dev, reg);
+}
+
+static int xpcs_rk_write_c45(struct mii_bus *bus, int addr, int dev, int reg, u16 val)
+{
+	struct dw_xpcs_rk *pxpcs = bus->priv;
+
+	if (!xpcs_rk_mdio_addr_validate(addr))
+		return -ENODEV;
+
+	dev = xpcs_rk_mdio_write_remapping(addr, dev, reg);
+	if (dev < 0)
+		return 0;
+
+	return xpcs_rk_write_reg(pxpcs, dev, reg, val);
+}
+
+static struct dw_xpcs_rk *xpcs_rk_create_data(struct platform_device *pdev)
+{
+	struct dw_xpcs_rk *pxpcs;
+
+	pxpcs = devm_kzalloc(&pdev->dev, sizeof(*pxpcs), GFP_KERNEL);
+	if (!pxpcs)
+		return ERR_PTR(-ENOMEM);
+
+	pxpcs->pdev = pdev;
+
+	dev_set_drvdata(&pdev->dev, pxpcs);
+
+	return pxpcs;
+}
+
+static int xpcs_rk_serdes_phy_init(struct dw_xpcs_rk *pxpcs)
+{
+	struct device *dev = &pxpcs->pdev->dev;
+
+	pxpcs->serdes_phy = devm_phy_get(dev, NULL);
+	if (IS_ERR(pxpcs->serdes_phy))
+		return dev_err_probe(dev, PTR_ERR(pxpcs->serdes_phy),
+					"Failed to get SerDes PHY\n");
+
+	return 0;
+}
+
+static void xpcs_rk_serdes_phy_poweroff(void *data)
+{
+	struct dw_xpcs_rk *pxpcs = data;
+	struct device *dev = &pxpcs->pdev->dev;
+
+	phy_power_off(pxpcs->serdes_phy);
+	phy_exit(pxpcs->serdes_phy);
+
+	dev_pm_genpd_rpm_always_on(dev, false);
+}
+
+static int xpcs_rk_serdes_phy_poweron(struct dw_xpcs_rk *pxpcs)
+{
+	struct device *dev = &pxpcs->pdev->dev;
+	int ret;
+
+	/*
+	 * The power domain is required and must be enabled, which allows us to
+	 * dynamically turn the CSR clock on/off using PM while keeping the PCS
+	 * powered on.
+	 */
+	ret = dev_pm_genpd_rpm_always_on(dev, true);
+	if (ret) {
+		dev_err(dev, "Failed to power on power-domains\n");
+		return ret;
+	}
+
+	ret = phy_init(pxpcs->serdes_phy);
+	if (ret) {
+		dev_err(dev, "Failed to init SerDes PHY\n");
+		goto pm_domain;
+	}
+
+	ret = phy_power_on(pxpcs->serdes_phy);
+	if (ret) {
+		dev_err(dev, "Failed to power on SerDes PHY\n");
+		goto serdes_phy;
+	}
+
+	ret = devm_add_action_or_reset(dev, xpcs_rk_serdes_phy_poweroff, pxpcs);
+	if (ret) {
+		dev_err(dev, "Failed to register devm for SerDes PHY: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+
+serdes_phy:
+	phy_exit(pxpcs->serdes_phy);
+pm_domain:
+	dev_pm_genpd_rpm_always_on(dev, false);
+	return ret;
+}
+
+static int xpcs_rk_init_res(struct dw_xpcs_rk *pxpcs)
+{
+	struct platform_device *pdev = pxpcs->pdev;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "No reg-space found\n");
+		return -EINVAL;
+	}
+
+	if (resource_size(res) < SZ_2M) {
+		dev_err(dev, "Invalid reg-space size\n");
+		return -EINVAL;
+	}
+
+	pxpcs->reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pxpcs->reg_base)) {
+		dev_err(dev, "Failed to map reg-space\n");
+		return PTR_ERR(pxpcs->reg_base);
+	}
+
+	return 0;
+}
+
+static void xpcs_rk_exit_clk(void *data)
+{
+	struct dw_xpcs_rk *pxpcs = data;
+	struct device *dev = &pxpcs->pdev->dev;
+
+	pm_runtime_force_suspend(dev);
+	clk_disable_unprepare(pxpcs->eee_clk);
+}
+
+static int xpcs_rk_init_clk(struct dw_xpcs_rk *pxpcs)
+{
+	struct device *dev = &pxpcs->pdev->dev;
+	unsigned long rate;
+	u64 mult;
+	int ret;
+
+	pxpcs->csr_clk = devm_clk_get(dev, "csr");
+	if (IS_ERR(pxpcs->csr_clk))
+		return dev_err_probe(dev, PTR_ERR(pxpcs->csr_clk),
+					 "Failed to get CSR clock\n");
+
+	pxpcs->eee_clk = devm_clk_get(dev, "eee");
+	if (IS_ERR(pxpcs->eee_clk))
+		return dev_err_probe(dev, PTR_ERR(pxpcs->eee_clk),
+					 "Failed to get EEE clock\n");
+
+	ret = clk_prepare_enable(pxpcs->eee_clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable EEE clock\n");
+		return ret;
+	}
+
+	pm_runtime_set_suspended(dev);
+	pm_runtime_enable(dev);
+
+	ret = devm_add_action_or_reset(dev, xpcs_rk_exit_clk, pxpcs);
+	if (ret) {
+		dev_err(dev, "Failed to register devm for EEE clock: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Compute the multiplier for the EEE clock so that
+	 * clk_eee_period * (mult_fact + 1) falls within 80..120 ns.
+	 *
+	 * On RK3568, clk_xpcs_eee is muxed between gpll200 (200 MHz, 5 ns)
+	 * and cpll125 (125 MHz, 8 ns), selected by CRU_CLKSEL_CON29 bit 13.
+	 * The reset value is 0 (200 MHz), but derive the value at runtime to
+	 * stay correct if the mux is changed by a board.
+	 *
+	 * Use a 64-bit intermediate: on 32-bit builds, 100 * 200000000
+	 * does not fit in unsigned long. Clamp to the 4-bit
+	 * DW_VR_MII_EEE_MULT_FACT_100NS field. The mux only provides
+	 * 125 MHz or 200 MHz, so the rate cannot drop below the 5 MHz
+	 * threshold where DIV_ROUND_CLOSEST_ULL() would return 0 and the
+	 * subtraction below would underflow.
+	 */
+	rate = clk_get_rate(pxpcs->eee_clk);
+	if (!rate)
+		return dev_err_probe(dev, -EINVAL, "Invalid EEE clock rate\n");
+
+	mult = DIV_ROUND_CLOSEST_ULL(100ULL * rate, NSEC_PER_SEC) - 1;
+	pxpcs->eee_mult_fact = min_t(u64, mult, 15);
+	return 0;
+}
+
+static int xpcs_rk_init_bus(struct dw_xpcs_rk *pxpcs)
+{
+	struct device *dev = &pxpcs->pdev->dev;
+	static atomic_t id = ATOMIC_INIT(-1);
+	struct mii_bus *bus;
+	int ret;
+
+	bus = devm_mdiobus_alloc_size(dev, 0);
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "Rockchip DW XPCS MCI/APB3";
+	bus->read = xpcs_rk_read_c22;
+	bus->write = xpcs_rk_write_c22;
+	bus->read_c45 = xpcs_rk_read_c45;
+	bus->write_c45 = xpcs_rk_write_c45;
+	bus->phy_mask = ~0;
+	bus->parent = dev;
+	bus->priv = pxpcs;
+
+	snprintf(bus->id, MII_BUS_ID_SIZE,
+		 "rockchip_dwxpcs-%x", atomic_inc_return(&id));
+
+	/*
+	 * MDIO-bus here serves as just a back-end engine abstracting out
+	 * the MDIO and MCI/APB3 IO interfaces utilized for the Rockchip DWXPCS CSRs
+	 * access.
+	 */
+	ret = devm_mdiobus_register(dev, bus);
+	if (ret) {
+		dev_err(dev, "Failed to create MDIO bus\n");
+		return ret;
+	}
+
+	pxpcs->bus = bus;
+	return 0;
+}
+
+static int xpcs_rk_probe(struct platform_device *pdev)
+{
+	struct dw_xpcs_rk *pxpcs;
+	int ret;
+
+	pxpcs = xpcs_rk_create_data(pdev);
+	if (IS_ERR(pxpcs))
+		return PTR_ERR(pxpcs);
+
+	/*
+	 * The XPCS lives in the PD_PIPE power domain. The domain must be
+	 * powered on before any register access, otherwise the SoC will
+	 * trigger a synchronous external abort (SError).
+	 *
+	 * Accessing the XPCS registers also requires a TX clock from the
+	 * SerDes, which is needed for the soft reset.
+	 */
+	ret = xpcs_rk_serdes_phy_init(pxpcs);
+	if (ret)
+		return ret;
+
+	ret = xpcs_rk_serdes_phy_poweron(pxpcs);
+	if (ret)
+		return ret;
+
+	ret = xpcs_rk_init_res(pxpcs);
+	if (ret)
+		return ret;
+
+	ret = xpcs_rk_init_clk(pxpcs);
+	if (ret)
+		return ret;
+
+	ret = xpcs_rk_init_bus(pxpcs);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id xpcs_rk_of_ids[] = {
+	{ .compatible = "rockchip,rk3568-xpcs" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, xpcs_rk_of_ids);
+
+struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *pcs, int port)
+{
+	struct platform_device *pdev;
+	struct dw_xpcs_rk *pxpcs;
+	struct dw_xpcs *xpcs;
+
+	if (!of_device_is_available(pcs))
+		return ERR_PTR(-ENODEV);
+
+	if (!of_match_node(xpcs_rk_of_ids, pcs))
+		return ERR_PTR(-EINVAL);
+
+	if (!xpcs_rk_mdio_addr_validate(port))
+		return ERR_PTR(-EINVAL);
+
+	pdev = of_find_device_by_node(pcs);
+	if (!pdev)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	/*
+	 * Establish the device link before reading the supplier's drvdata.
+	 * device_link_add() does not fail on a supplier that is unbinding;
+	 * it creates the link in DL_STATE_SUPPLIER_UNBIND.
+	 *
+	 * The check below only confirms that the supplier is bound at this
+	 * point. It does not fully protect against a concurrent unbind
+	 * between here and xpcs_create_mdiodev(); closing that window would
+	 * require reading a managed link's status or device_lock(), neither
+	 * of which is acceptable on this path. The window is small and
+	 * requires an explicit unbind from userspace. Discussed on
+	 * driver-core.
+	 *
+	 * The link is released automatically when the consumer device is
+	 * destroyed (DL_FLAG_AUTOREMOVE_CONSUMER), so no explicit
+	 * device_link_remove() is needed on the failure paths.
+	 */
+	if (!device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER)) {
+		put_device(&pdev->dev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	if (READ_ONCE(pdev->dev.links.status) != DL_DEV_DRIVER_BOUND) {
+		put_device(&pdev->dev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	pxpcs = platform_get_drvdata(pdev);
+	if (!pxpcs || !pxpcs->bus) {
+		put_device(&pdev->dev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	xpcs = xpcs_create_mdiodev(pxpcs->bus, port);
+	if (IS_ERR(xpcs)) {
+		put_device(&pdev->dev);
+		return xpcs;
+	}
+
+	xpcs_config_eee_mult_fact(xpcs, pxpcs->eee_mult_fact);
+	put_device(&pdev->dev);
+	return xpcs;
+}
+EXPORT_SYMBOL_GPL(xpcs_rk_create);
+
+static int xpcs_rk_pm_runtime_suspend(struct device *dev)
+{
+	struct dw_xpcs_rk *pxpcs = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(pxpcs->csr_clk);
+
+	return 0;
+}
+
+static int xpcs_rk_pm_runtime_resume(struct device *dev)
+{
+	struct dw_xpcs_rk *pxpcs = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(pxpcs->csr_clk);
+}
+
+static int xpcs_rk_system_suspend(struct device *dev)
+{
+	/*
+	 * Keep the PD_PIPE power domain on during system suspend.
+	 *
+	 * PD_PIPE is shared with SATA/PCIe and would be powered down by
+	 * genpd once all its consumers are suspended, killing the SerDes
+	 * and breaking MAC WoL.  Mark the XPCS as part of the wakeup path
+	 * so genpd keeps the domain on.  Unconditional because the XPCS
+	 * core has no callback to convey the MAC WoL state.
+	 */
+	device_set_wakeup_path(dev);
+	return 0;
+}
+
+static int xpcs_rk_system_resume(struct device *dev)
+{
+	return 0;
+}
+
+static _DEFINE_DEV_PM_OPS(xpcs_rk_pm_ops,
+			  xpcs_rk_system_suspend, xpcs_rk_system_resume,
+			  xpcs_rk_pm_runtime_suspend, xpcs_rk_pm_runtime_resume,
+			  NULL);
+
+static struct platform_driver xpcs_rk_driver = {
+	.probe = xpcs_rk_probe,
+	.driver = {
+		.name = "rk_xpcs-dwxpcs",
+		.pm = pm_ptr(&xpcs_rk_pm_ops),
+		.of_match_table = xpcs_rk_of_ids,
+	},
+};
+module_platform_driver(xpcs_rk_driver);
+
+MODULE_DESCRIPTION("Rockchip XPCS platform device driver");
+MODULE_AUTHOR("Coia Prant <coiaprant@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pcs/pcs-xpcs-rk.h b/include/linux/pcs/pcs-xpcs-rk.h
new file mode 100644
index 0000000000000..e3ca3d51f7c7e
--- /dev/null
+++ b/include/linux/pcs/pcs-xpcs-rk.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_PCS_XPCS_ROCKCHIP_H
+#define __LINUX_PCS_XPCS_ROCKCHIP_H
+
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/pcs/pcs-xpcs.h>
+
+struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *pcs, int port);
+
+#endif /* __LINUX_PCS_XPCS_ROCKCHIP_H */
-- 
2.47.3

