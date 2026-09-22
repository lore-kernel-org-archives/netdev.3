Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722164BB7E4
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107500; cv=none; b=Qd2/ikxIeNQy31hNpn/2whQMm7QXTLTM6EbkvCkL27JWIkL6NZosJkgPLuK+XxXLkh8xgzgdamm67aNvI/0QPibNpFIpvFuTYvW1F4gnw3mE3/Ehsj29SvqNb42fHxFVxSAdEOB5/9qTlUni01MK8mdaVZjfFcKlnBnMJX3DrJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107500; c=relaxed/simple;
	bh=/xICB2EjDC5FPGahSN2PB3TKG609TKdB8qfi7ZuBGRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvZbRUXTfIsKoQhARwMoJhXSwg1QQYgstdW8FGPYfmfFnv/LA5mdB8bvT4NMiPt18/lxfaT81w+xTA4azOJVEEzNkVtLhDXxuPU1PPmSVmm4yzbMXqj1vjqgAtNtWvlWhyylo7zWhdbkQOZa4+k64NPxkoyjjDtses5XUXywf1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMDk37wf; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMDk37wf"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2dae660f31bso1049895ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790107481; x=1790712281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fCXz6Xt3mPz+WufwUqHDBTXpyUqzwHqKx0ma6QVgw9U=;
        b=bMDk37wfGGLFl5jAfKnpwiX6f8RMMD1JO6NxJg3LHmdUYYkSEqosj6FS7hZ/WKddmR
         nnYt8rEHERh/4Bjl6juiJYSd1z/MlyDU+JRaH8M7+pe2TldOIGIdry0ffK9UYcoOdNhQ
         +s0ftF7Th8imIb2+fFkEGwi6wZWcYn7AFZFtWueBXbQCE8/3f7BVFI5hvdcePt9ZGizm
         FPuFM9lnvPqRcaNOgdkIp+gm25JyB57ek4GJ2Abu43gSVYtPgrQRs0j4EhcC9w/YOpDY
         OX0L0QvJa9rmgBHnPumIBvaVAdS+YSfvQj/ANEUDAw8L9JV5jHfhlhEf4lfBN6s7SOv+
         XaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107481; x=1790712281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fCXz6Xt3mPz+WufwUqHDBTXpyUqzwHqKx0ma6QVgw9U=;
        b=H/qej6wlORAhQJwUxaV/PWgsjlI9o9UkJY5gSm3r5jPDxnCxRch+tTCL+Kw3G+wlus
         gvVRGNTGi2Kr6EVHd425z61mXLEZIdJ0D0to60PTLyx1TVTne9gIKEZhlBoL3Z+HdEJV
         jP3lcEaOxmQ1oSiouMykG7NC+Fqi/8O5AEJWMS2yPdc1OhU3HRrSBN+1ECDKDFqyUvww
         Xqs703/nVs8R6hqRLZC5j/xJi3MXQjeBd1L1JxS04SuQaSCg2AQTnvkTMC+C4f8hlCrk
         W25EKK44ppo1yb7XNFbrdUYGfkdszlFWIJiyS6BiZo46NEk/OUUERpk9qCRXGRw+vHyr
         u6ZA==
X-Forwarded-Encrypted: i=1; AKwUvBzTgC2BBUeDpNqGUyo/xSMskqvGZLdfkQbIp6PQGEoHQrQjcpGbTBfNxgfuzLVV4o7wuIwA51U=@vger.kernel.org
X-Gm-Message-State: AFuF++mj4Q850bqTlewDFQf/dU8uVGknc2mmgty5ouK001mGcki+s9e6
	DzWxS6O+XYe1HL7nvi1CMblUm2mIC2WQQ5ktkqBVfvegk4M+GXcGKPnx
X-Gm-Gg: AYBFou37am6xGR2uTWCXK9+q8UykTz9Ps6/pcXhJbOnob3S8OU35eO5CSOX75mYa1yF
	D9Itwy6yksbfQjkkt1k6RDOqEdD5zjOHqvPxJhl4rhU53MUyWc+V3K6WKA+XhNJChbsQHHjz1V1
	F+e3ltSz0fO8gfD1y9UCsNPQ4Zes9wVzM3p25H50zM9Q6mT/4XwoIkYlZK84jF3y9jeOAdbIsI9
	2FuBdd/Q6uYa/42+k00DlyjTEYbUwskqcpB51Wveyw0+5paqEYhtSjGyZrrD5N9oFM9BHoNWyS5
	4D/i2D3VSnw/cftICdJm8vodeSFqRFPjvnfZUUbvOLNo/9DlIIT3tFomt31NKfm+js7jaEfvQqF
	Jg7zIvigjmKj0QUDN3lnLySXN+7QavT71SA7/MaNrSxQeLACpUEXk2dpNH69rVoF1dFdxiwXGuk
	wUZ03DIlms1y7PNV4GwvUk8vzDj+X9nA8TpOrQqoTUKpRhj7PRNWlKG245ZFjYFjBtx/HvLA==
X-Received: by 2002:a17:903:26d0:b0:2dd:ad73:5b70 with SMTP id d9443c01a7336-2df69d5fdddmr4305305ad.32.1790107481209;
        Tue, 22 Sep 2026 13:04:41 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5eea15sm654515ad.64.2026.09.22.13.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:04:40 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Coia Prant <coiaprant@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v10 07/11] net: pcs: xpcs: add Rockchip RK3568 platform glue driver
Date: Wed, 23 Sep 2026 04:03:31 +0800
Message-ID: <20260922200336.2201212-8-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922200336.2201212-1-coiaprant@gmail.com>
References: <20260922200336.2201212-1-coiaprant@gmail.com>
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

The XPCS block contains four MII ports (0..3), each of which can be
routed to GMAC0 or GMAC1 via the pcs-handle property in the MAC node.
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
PCS_XPCS_PLATFORM symbol.  The symbol defaults to PCS_XPCS, so existing
configurations keep the snps,dw-xpcs platform glue enabled without any
change.

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
 drivers/net/pcs/Kconfig         |  25 ++
 drivers/net/pcs/Makefile        |   5 +-
 drivers/net/pcs/pcs-xpcs-rk.c   | 619 ++++++++++++++++++++++++++++++++
 include/linux/pcs/pcs-xpcs-rk.h |  11 +
 4 files changed, 658 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/pcs/pcs-xpcs-rk.c
 create mode 100644 include/linux/pcs/pcs-xpcs-rk.h

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index e417fd66f660a..5382afcf95748 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -12,6 +12,31 @@ config PCS_XPCS
 	  This module provides a driver and helper functions for Synopsys
 	  DesignWare XPCS controllers.
 
+if PCS_XPCS
+
+config PCS_XPCS_PLATFORM
+	tristate "Generic XPCS controller support"
+	default PCS_XPCS
+	help
+	  Generic DWXPCS driver for platforms that don't require any
+	  platform specific code to function or is using platform
+	  data for setup.
+
+	  If you have a controller with this interface, say Y or M here.
+
+config PCS_XPCS_ROCKCHIP
+	tristate "Rockchip XPCS controller support"
+	default ARCH_ROCKCHIP
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
index 0000000000000..35ee980a759e5
--- /dev/null
+++ b/drivers/net/pcs/pcs-xpcs-rk.c
@@ -0,0 +1,619 @@
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
+static int xpcs_rk_mdio_read_remapping(int addr, int dev, int reg)
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
+	dev = xpcs_rk_mdio_read_remapping(addr, MDIO_MMD_VEND2, reg);
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
+	dev = xpcs_rk_mdio_read_remapping(addr, dev, reg);
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
+	pxpcs->serdes_phy = devm_phy_get(dev, "serdes");
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
+struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *np)
+{
+	struct platform_device *pdev;
+	struct device_node *pcs_np;
+	struct device_link *link;
+	struct dw_xpcs_rk *pxpcs;
+	struct dw_xpcs *xpcs;
+	u32 port;
+
+	if (!of_device_is_available(np))
+		return ERR_PTR(-ENODEV);
+
+	if (of_property_read_u32(np, "reg", &port))
+		return ERR_PTR(-EINVAL);
+
+	if (!xpcs_rk_mdio_addr_validate((int)port))
+		return ERR_PTR(-EINVAL);
+
+	/* The XPCS pdev is attached to the parent node */
+	pcs_np = of_get_parent(np);
+	if (!pcs_np)
+		return ERR_PTR(-ENODEV);
+
+	if (!of_device_is_available(pcs_np)) {
+		of_node_put(pcs_np);
+		return ERR_PTR(-ENODEV);
+	}
+
+	if (!of_match_node(xpcs_rk_of_ids, pcs_np)) {
+		of_node_put(pcs_np);
+		return ERR_PTR(-EINVAL);
+	}
+
+	pdev = of_find_device_by_node(pcs_np);
+	of_node_put(pcs_np);
+	if (!pdev)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	/*
+	 * Establish the device link before reading the supplier's drvdata.
+	 * device_link_add() does not fail on a supplier that is unbinding:
+	 * it creates the link in DL_STATE_SUPPLIER_UNBIND. Whether the link
+	 * actually protects the drvdata depends on the supplier's state at
+	 * creation time.
+	 *
+	 * Check link->supplier->links.status right after creation. If the
+	 * supplier was DL_DEV_DRIVER_BOUND, the link is in
+	 * DL_STATE_CONSUMER_PROBE and device_links_unbind_consumers() will
+	 * wait for this probe to finish before unbinding the supplier, so
+	 * the drvdata stays valid for the rest of the function. Any other
+	 * state means the supplier is not usable yet; defer and retry.
+	 *
+	 * The link is released automatically when the consumer device is
+	 * destroyed (DL_FLAG_AUTOREMOVE_CONSUMER), so no explicit
+	 * device_link_remove() is needed on the failure paths.
+	 */
+	link = device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+	if (!link) {
+		put_device(&pdev->dev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	if (READ_ONCE(link->supplier->links.status) != DL_DEV_DRIVER_BOUND) {
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
+	xpcs = xpcs_create_mdiodev(pxpcs->bus, (int)port);
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
index 0000000000000..28723d5bd75cc
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
+struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *np);
+
+#endif /* __LINUX_PCS_XPCS_ROCKCHIP_H */
-- 
2.47.3

