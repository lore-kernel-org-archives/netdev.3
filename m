Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793776958;
	b=5bunka6Awogiy8WtIJ9Uis0FjLFGJyf3SFGo7GWdCybYXE+DHTuhu1gOSO78GQK4DATy
	 wjKpqQvdoJEOW4m7KmWExLTGrq6OLJp78I/9jQlA5uHlBkvNR4F3Zqp7ln6wGH8+g5It4
	 AWHf4aHNc/2RxQhlNktt2RaFhbNYIIzM8/AYBTpyUKalTIm0FkvSirohDGF82uAgiIg9q
	 mNrdFrfyhB1Ld9j5U2Juegw0mK8CmpmfQcYuqk97s+Q4xNlfw5MU/mibkdoStvQzY/Xlz
	 E49fpyoNXr6Y1lSt+5JlpA/OvN1OnPh9etTOrwA8zM2KUgrZSE9I8qK+ALSj5l9YAEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776958;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+GbNXE2OKSpfiymsMCiP6K1WI9mnIw+koHm8m7DPYFU=;
	b=06qmnrk0k6TTUWdZ82y1cuTSIkr/gj3Nkcw9UvnoAfpczvdUHGiMDSHxVSyfH0QcCUEM
	 wXq1DcCzxJBnh8ejJjYC5h5nfnaj4GOYdh0fIvht22Faq9lC3LueWOVNabM8fEXU3kTsC
	 C83d+t/oLCYZ4Jx9PpLGCfl1+CaIpqIAABn++sVZZg97tUBU9pwxDFk9msZc0uk92fBoO
	 99nBBDKQjit3klNjU4vPiWn6DozUrHZwnJWVDxXg33LWF5ug5C10mZ+E0Q9ZrQLvIVDTd
	 fsYGwz572P/6m0iJ241qTnCFlPo4DCPJI9ReDJhHshemcptZvw/zdUyyfuZIUvTZv9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k/7o6rd6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00EA606A33C;
	Wed,  4 Nov 2026 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k/7o6rd6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793776957;
	b=ib+xvdXqlt41x6pHjow+Zs/+PBOHophyl88Wkn3BC7potLnfEgi27VY1fSlQ2EYA/srd
	 Sq7/J53qxepT2uOqL+htsPAaoKYazYqYD8p2xDhSmnMrwd0kzc8q1hxAYYHrPihdh9Z5y
	 t5s3Y8/S0fVTNjbz+8i4fJ2lovmhTCpio7PO2KlzBbHp6YQJthgFRwcHkq39aOLFTWRyh
	 M0rUyOJPfdNysKP5W2G28G0jBjZYOu+PLxNO48mMv9cQAPH1oUMGCwj1kW36IlCs2ImON
	 0T5XzXvjkJkQZEcYiW9fV7SIWKe3o+1+68pWhez3RNsSPp8E6JwrObRTXLill5J65aQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793776957;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+GbNXE2OKSpfiymsMCiP6K1WI9mnIw+koHm8m7DPYFU=;
	b=yHagdHvE7jMVICMxdt0qd9ujZHzjuvEBMDSMeJGRQVIG8lFMsgP+Yjv+SCg7qQDFez6R
	 Pl/iazYcboGOIdNl+aZC/ZPN1HYO/7Q7MQ57kwDh4M548HcFjJyot6liN6kmBFlVOQvcB
	 tOxaI0FdSuogbCzLh+2dd7lnYHYmNBWbELOyHMaKknR4eXRcM5hcHCXkEUmW5RDQgK/UH
	 +LIpvxMWPj9/7t0R2vMPPfFV3JieCkxSGNJRhUoMUy8wI8+F7cQqDmq4vbw4gUfgg+hk5
	 I7RTgeZaytOFip+Xhuwkm3A+5z1q1uhZEHZwX77lVjCUNkpIXKi4E22ZI03rdBffAPQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AC6401F00919;
	Wed,  4 Nov 2026 07:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776957;
	bh=+GbNXE2OKSpfiymsMCiP6K1WI9mnIw+koHm8m7DPYFU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=k/7o6rd6P3OVdIhPRjl4G+eBY+qKkedG6SuXCDDXvk33+2gTxOv+FCuti24RGxnNS
	 ys2janPGkz7XPcJG0U6xCEDVrQlWI/vUlhTrMJl6xILK8VQZIHQPyDCqui6Tuj3MYo
	 yWIN1I/gNJurS3MtCnYKcN+wSuMhcFbdYbynte1nvmt9t6IGMy9baaAixGKgupG1Bz
	 Wa61qtUWkx12omhlDZ2fufLcZSUEDnS8zBKO8NE/FsXbhTk1Wt/d82Kg3nmDAEVPVm
	 eBQlm7Lra14EUZm0yzZQNWA+cH1IoD913j/3WJYPE4utgYU4SgBz5+ejbNAODrVrxf
	 +1lo4nGUOVB5Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4212A46D29;
	Wed,  4 Nov 2026 07:22:36 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Wed, 04 Nov 2026 02:22:25 -0500
Subject: [PATCH net-next 2/2] net: stmmac: Add Siflower SF19A2890 glue
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261104-sf19a2890-gmac-v1-2-a15965a49574@telaak.dev>
References: <20261104-sf19a2890-gmac-v1-0-a15965a49574@telaak.dev>
In-Reply-To: <20261104-sf19a2890-gmac-v1-0-a15965a49574@telaak.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Chuanhong Guo <gch981213@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, linux-mips@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793776955; l=7370;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=hGknORcyS13q476eRjeiLb2Zk79yxcwVkAwdDao7hjM=;
 b=UvDJj2152rYIwPD7Z3ui+hy0XsRXl/XtWJZT2wuvysTP0yV80ZWuhg84HkKP6S0iVQDH9jeeM
 yjTs6z8sxxMCAoA0eGxIX/bIje2O84rwfXy7wSm8cTtZtP16aqguaye
X-Developer-Key: i=joseph@telaak.dev; a=ed25519;
 pk=oQI+UfddlZ0wK2ac4WKOGNjUl1ZEN8j9ZVFSqEDoNP0=
X-Endpoint-Received: by B4 Relay for joseph@telaak.dev/20261104 with
 auth_id=1404
X-Original-From: Joseph Telaak <joseph@telaak.dev>
Reply-To: joseph@telaak.dev
Content-Transfer-Encoding: 7bit

From: Joseph Telaak <joseph@telaak.dev>

Add the glue for the DesignWare GMAC of the Siflower SF19A2890. The
interface type is set in the GMAC's configuration block through the
set_phy_intf_sel hook, and so are the RGMII clock delays, which the
MAC adds only where rx-internal-delay-ps or tx-internal-delay-ps is
present.

The delay line's step is not documented. Sweeping each delay over its
whole range with the link at 1000 Mb/s, the working windows repeat every
145 steps, one 8 ns clock period, so a step is about 55 ps; the driver
rounds to the nearest step.

Based on Chuanhong Guo's driver from OpenWrt and his siflower-7.1
branch, which read the delays from a factory flash cell in the delay
line's own units and always applied them. That driver also set
STMMAC_FLAG_HAS_INTEGRATED_PCS, because the core reports a PCS that
does not work in RGMII mode; stmmac now uses the integrated PCS only
for SGMII, and the flag is gone.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |  11 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile       |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-sf19a2890.c  | 158 +++++++++++++++++++++
 3 files changed, 170 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index c6559e749..78efe7859 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -201,6 +201,17 @@ config DWMAC_S32
 	  SOCs GMAC ethernet controller, ie. S32G2xx, S32G3xx and
 	  S32R45.
 
+config DWMAC_SF19A2890
+	tristate "Siflower SF19A2890 GMAC support"
+	default MACH_SIFLOWER_MIPS
+	depends on OF && (MACH_SIFLOWER_MIPS || COMPILE_TEST)
+	help
+	  Support for the Ethernet controller of the Siflower SF19A2890 SoC.
+
+	  This selects the SF19A2890 glue layer support for the stmmac
+	  device driver. It sets the interface type and the RGMII clock
+	  delays in the GMAC's configuration block.
+
 config DWMAC_SOCFPGA
 	tristate "SOCFPGA dwmac support"
 	default ARCH_INTEL_SOCFPGA
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index b16a456b7..9330de094 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_DWMAC_RENESAS_GBETH) += dwmac-renesas-gbeth.o
 obj-$(CONFIG_DWMAC_ROCKCHIP)	+= dwmac-rk.o
 obj-$(CONFIG_DWMAC_RZN1)	+= dwmac-rzn1.o
 obj-$(CONFIG_DWMAC_S32)		+= dwmac-s32.o
+obj-$(CONFIG_DWMAC_SF19A2890)	+= dwmac-sf19a2890.o
 obj-$(CONFIG_DWMAC_SOCFPGA)	+= dwmac-altr-socfpga.o
 obj-$(CONFIG_DWMAC_SOPHGO)	+= dwmac-sophgo.o
 obj-$(CONFIG_DWMAC_SPACEMIT)	+= dwmac-spacemit.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sf19a2890.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sf19a2890.c
new file mode 100644
index 000000000..41bfe7a4a
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sf19a2890.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Siflower SF19A2890 GMAC glue
+ *
+ * The SF19A2890 has a DWMAC 3.73a. Its interface type and RGMII clock
+ * delays are set in a register block of their own.
+ *
+ * Based on the driver by Chuanhong Guo <gch981213@gmail.com>.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/stmmac.h>
+
+#include "stmmac_platform.h"
+
+/* GMAC configuration block */
+#define SF19A2890_GMAC_MISC		0x0
+#define  SF19A2890_PHY_INTF_SEL		GENMASK(2, 0)
+#define SF19A2890_GMAC_TX_DELAY		0x4
+#define SF19A2890_GMAC_RX_DELAY		0x8
+#define SF19A2890_GMAC_RX_DELAY_EN	0xc
+#define  SF19A2890_DELAY_MAX		0xff
+
+/*
+ * The delay line's step is not documented. Sweeping a full 8 ns RGMII clock
+ * period at 1000 Mb/s takes 145 steps, so one step is about 55 ps.
+ */
+#define SF19A2890_DELAY_STEP_PS		55
+
+struct sf19a2890_gmac {
+	struct device *dev;
+	void __iomem *cfg;
+};
+
+static int sf19a2890_gmac_set_phy_intf_sel(void *bsp_priv, u8 phy_intf_sel)
+{
+	struct sf19a2890_gmac *gmac = bsp_priv;
+	u32 val;
+
+	if (phy_intf_sel != PHY_INTF_SEL_GMII_MII &&
+	    phy_intf_sel != PHY_INTF_SEL_RGMII &&
+	    phy_intf_sel != PHY_INTF_SEL_RMII)
+		return -EINVAL;
+
+	val = readl(gmac->cfg + SF19A2890_GMAC_MISC);
+	val &= ~SF19A2890_PHY_INTF_SEL;
+	val |= FIELD_PREP(SF19A2890_PHY_INTF_SEL, phy_intf_sel);
+	writel(val, gmac->cfg + SF19A2890_GMAC_MISC);
+
+	return 0;
+}
+
+static int sf19a2890_gmac_get_delay(struct sf19a2890_gmac *gmac,
+				    const char *prop, u32 *steps)
+{
+	u32 ps;
+
+	*steps = 0;
+	if (of_property_read_u32(gmac->dev->of_node, prop, &ps))
+		return 0;
+
+	*steps = DIV_ROUND_CLOSEST(ps, SF19A2890_DELAY_STEP_PS);
+	if (*steps > SF19A2890_DELAY_MAX)
+		return dev_err_probe(gmac->dev, -EINVAL,
+				     "%s too large: %u\n", prop, ps);
+
+	return 0;
+}
+
+/* The MAC adds an RGMII delay only where the device tree asks for one */
+static int sf19a2890_gmac_set_delays(struct sf19a2890_gmac *gmac)
+{
+	u32 tx, rx;
+	int ret;
+
+	ret = sf19a2890_gmac_get_delay(gmac, "tx-internal-delay-ps", &tx);
+	if (ret)
+		return ret;
+
+	ret = sf19a2890_gmac_get_delay(gmac, "rx-internal-delay-ps", &rx);
+	if (ret)
+		return ret;
+
+	writel(tx, gmac->cfg + SF19A2890_GMAC_TX_DELAY);
+	writel(rx, gmac->cfg + SF19A2890_GMAC_RX_DELAY);
+	writel(!!rx, gmac->cfg + SF19A2890_GMAC_RX_DELAY_EN);
+
+	return 0;
+}
+
+static int sf19a2890_gmac_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	struct device *dev = &pdev->dev;
+	struct sf19a2890_gmac *gmac;
+	struct clk *clk;
+	int ret;
+
+	gmac = devm_kzalloc(dev, sizeof(*gmac), GFP_KERNEL);
+	if (!gmac)
+		return -ENOMEM;
+
+	gmac->dev = dev;
+
+	gmac->cfg = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(gmac->cfg))
+		return dev_err_probe(dev, PTR_ERR(gmac->cfg),
+				     "failed to map the configuration block\n");
+
+	clk = devm_clk_get_enabled(dev, "byp_ref");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "failed to enable the byp_ref clock\n");
+
+	ret = sf19a2890_gmac_set_delays(gmac);
+	if (ret)
+		return ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return ret;
+
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR(plat_dat))
+		return PTR_ERR(plat_dat);
+
+	plat_dat->bsp_priv = gmac;
+	plat_dat->set_phy_intf_sel = sf19a2890_gmac_set_phy_intf_sel;
+
+	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
+}
+
+static const struct of_device_id sf19a2890_gmac_match[] = {
+	{ .compatible = "siflower,sf19a2890-gmac" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sf19a2890_gmac_match);
+
+static struct platform_driver sf19a2890_gmac_driver = {
+	.probe = sf19a2890_gmac_probe,
+	.remove = stmmac_pltfr_remove,
+	.driver = {
+		.name = "sf19a2890-gmac",
+		.pm = &stmmac_pltfr_pm_ops,
+		.of_match_table = sf19a2890_gmac_match,
+	},
+};
+module_platform_driver(sf19a2890_gmac_driver);
+
+MODULE_DESCRIPTION("Siflower SF19A2890 GMAC glue");
+MODULE_LICENSE("GPL");

-- 
Git-155)


