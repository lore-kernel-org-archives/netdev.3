Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79CB4BE42D;
	Mon, 21 Sep 2026 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005257; cv=pass; b=nDz14PSrxmZpGWNEdw5U0aloLfiUaG33+8ZqQ29POOdZ/TCPm0ZEo/TIOAUMsw0dKurfjNvmHVs4YlzicLbSAeZ9git5ZmBmjMzBH08ZAS3vpJsVYQ8pe3gXUHd9b9iFIXLFjhtP2Z23dzSfpfCGmR+dp5x/KSKfn1yVhLV8Xmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005257; c=relaxed/simple;
	bh=b44Pff3uLY2lX+rbx/967AEIg8FwfREguwPl+xfrGq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fibA9S765GdYEDozGYuoMJZEmH1QKtg4/QeKtSqtMKrF079kR4ds/1z3+EY1ilzLKkM6X7GB3NaNF4mZ/MZ+rN4GnUfUC3C2tUyi9LAWxwpkHVJZC/cP8AhEasg00f3nyCRqFb5lFugNcc/25kf6WAFA1H0BZ2qX8MJotQFpzNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=BcWwnxYt; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="BcWwnxYt"
ARC-Seal: i=1; a=rsa-sha256; t=1790005218; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YuVBBelKV4Ix25JYWYRhLjBQP7prQkog2wM+2+YXBzIYekIfqO9ZleMIVaH3xpEKlR9X33zu6bR6VmHGkbbBMsb4B4IkBMTD7dXoK396OcPn8q6vVqRfalvkWJbuO2WCgiz1EDEgbKpbTKabyB7Kz3Ldgf74+cMJmwMPL84T6sw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790005218; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7BY4eyEDv83L2PkDaqg4uoC/543zeM+MlzUqQFasA0Q=; 
	b=Xhf/dmI8EE6e5ioajHFwIZZG0zT/RxEFBqgPbc8xyB1Br3sF2LD0z8NZ7+fvetyKzuJ0c0vmfZMsWeThBcM1uUXsfAX8uB89LC+IWmR9ch6WcDllFQAVcEom1ZsraoQ4x/EcCzjJS5F2YKLdPJIKus9mjC3H/KAbu4PXqkCduoI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790005218;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=7BY4eyEDv83L2PkDaqg4uoC/543zeM+MlzUqQFasA0Q=;
	b=BcWwnxYtUWjM1oH6RsI6qz7wMZunj4FHwQa6OzcZs16K+8E6Qd3vQnTWjxeI8tbe
	h2DEqY6eDBaloWEyiEfqPnzWhjvuqZ34MNaOWysnuYxU+yi3jUiUjOokthpe1CWXSVW
	oEuAaY5C3Cv7fTLhWZtL7H1hIW6X8M2dyuIBKtGI=
Received: by smtp.zohomail.com with SMTPS id 1790005217373622.0735486405825;
	Mon, 21 Sep 2026 08:40:17 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 21 Sep 2026 23:38:06 +0800
Subject: [PATCH v4 8/8] clk: sunxi-ng: a733: Add reset lines
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-a733-clk-v4-8-9c184ebe9ac1@pigmoral.tech>
References: <20260921-a733-clk-v4-0-9c184ebe9ac1@pigmoral.tech>
In-Reply-To: <20260921-a733-clk-v4-0-9c184ebe9ac1@pigmoral.tech>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 netdev@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>, 
 Enzo Adriano <enzo.adriano.code@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7014;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=b44Pff3uLY2lX+rbx/967AEIg8FwfREguwPl+xfrGq8=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLI2+jd73FJ+O+PFNVfFuvvLiqw93ptYWaf8u9IltSDp3
 2u931f8OkpZGMS4GGTFFFm4/MX/WevwfDsi0HofZg4rE8gQBi5OAZjIogOMDP9+H5cM1zm6c+ev
 b/MeNAYtqJ0pknk6REN3Kp/4OvscWU5GhoVhjrP5fy1Zee1fTo57tKdVyzSbbta+A2t0MrUsS6f
 vZgIA
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External

Add the reset lines for the Allwinner A733 SoC. These reset control bits
are integrated into the Bus Gate Reset (BGR) registers, typically
sharing the same register address with their corresponding bus clock
gates. Integrate them into the main CCU driver using the existing
sunxi-ng ccu_reset framework, allowing the CCU to also function as a
reset controller for the SoC.

Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 126 +++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
index 1543c2d3f305..cb4209dd8e76 100644
--- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
+++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
@@ -19,6 +19,7 @@
 #include <dt-bindings/reset/allwinner,sun60i-a733-ccu.h>
 
 #include "ccu_common.h"
+#include "ccu_reset.h"
 
 #include "ccu_div.h"
 #include "ccu_gate.h"
@@ -2181,11 +2182,136 @@ static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
 	.num	= CLK_FANOUT3 + 1,
 };
 
+static const struct ccu_reset_map sun60i_a733_ccu_resets[] = {
+	[RST_BUS_ITS_PCIE0]		= { 0x574, BIT(16) },
+	[RST_BUS_IOMMU0_SYS]		= { 0x58c, BIT(16) },
+	[RST_BUS_MSI_LITE0_AHB]		= { 0x594, BIT(16) },
+	[RST_BUS_MSI_LITE0_MBUS]	= { 0x594, BIT(17) },
+	[RST_BUS_MSI_LITE1_AHB]		= { 0x59c, BIT(16) },
+	[RST_BUS_MSI_LITE1_MBUS]	= { 0x59c, BIT(17) },
+	[RST_BUS_MSI_LITE2_AHB]		= { 0x5a4, BIT(16) },
+	[RST_BUS_MSI_LITE2_MBUS]	= { 0x5a4, BIT(17) },
+	[RST_BUS_IOMMU1_SYS]		= { 0x5b4, BIT(16) },
+	[RST_BUS_DMA0]			= { 0x704, BIT(16) },
+	[RST_BUS_DMA1]			= { 0x70c, BIT(16) },
+	[RST_BUS_SPINLOCK]		= { 0x724, BIT(16) },
+	[RST_BUS_MSGBOX]		= { 0x744, BIT(16) },
+	[RST_BUS_PWM0]			= { 0x784, BIT(16) },
+	[RST_BUS_PWM1]			= { 0x78c, BIT(16) },
+	[RST_BUS_DBG]			= { 0x7a4, BIT(16) },
+	[RST_BUS_SYSDAP]		= { 0x7ac, BIT(16) },
+	[RST_BUS_TIMER0]		= { 0x850, BIT(16) },
+	[RST_BUS_DE0]			= { 0xa04, BIT(16) },
+	[RST_BUS_DI]			= { 0xa24, BIT(16) },
+	[RST_BUS_G2D]			= { 0xa44, BIT(16) },
+	[RST_BUS_EINK]			= { 0xa6c, BIT(16) },
+	[RST_BUS_DE_SYS]		= { 0xa74, BIT(16) },
+	[RST_BUS_VE_ENC0]		= { 0xa8c, BIT(16) },
+	[RST_BUS_VE_DEC0]		= { 0xa8c, BIT(18) },
+	[RST_BUS_CE]			= { 0xac4, BIT(16) },
+	[RST_BUS_CE_SYS]		= { 0xac4, BIT(17) },
+	[RST_BUS_NPU_CORE]		= { 0xb04, BIT(16) },
+	[RST_BUS_NPU_AXI]		= { 0xb04, BIT(17) },
+	[RST_BUS_NPU_AHB]		= { 0xb04, BIT(18) },
+	[RST_BUS_NPU_SRAM]		= { 0xb04, BIT(19) },
+	[RST_BUS_GPU0]			= { 0xb24, BIT(16) },
+	[RST_BUS_DRAM0]			= { 0xc0c, BIT(16) },
+	[RST_BUS_NAND0]			= { 0xc8c, BIT(16) },
+	[RST_BUS_MMC0]			= { 0xd0c, BIT(16) },
+	[RST_BUS_MMC1]			= { 0xd1c, BIT(16) },
+	[RST_BUS_MMC2]			= { 0xd2c, BIT(16) },
+	[RST_BUS_MMC3]			= { 0xd3c, BIT(16) },
+	[RST_BUS_UFS_AHB]		= { 0xd8c, BIT(16) },
+	[RST_BUS_UFS_AXI]		= { 0xd8c, BIT(17) },
+	[RST_BUS_UFS_PHY]		= { 0xd8c, BIT(18) },
+	[RST_BUS_UFS_CORE]		= { 0xd8c, BIT(19) },
+	[RST_BUS_UART0]			= { 0xe00, BIT(16) },
+	[RST_BUS_UART1]			= { 0xe04, BIT(16) },
+	[RST_BUS_UART2]			= { 0xe08, BIT(16) },
+	[RST_BUS_UART3]			= { 0xe0c, BIT(16) },
+	[RST_BUS_UART4]			= { 0xe10, BIT(16) },
+	[RST_BUS_UART5]			= { 0xe14, BIT(16) },
+	[RST_BUS_UART6]			= { 0xe18, BIT(16) },
+	[RST_BUS_I2C0]			= { 0xe80, BIT(16) },
+	[RST_BUS_I2C1]			= { 0xe84, BIT(16) },
+	[RST_BUS_I2C2]			= { 0xe88, BIT(16) },
+	[RST_BUS_I2C3]			= { 0xe8c, BIT(16) },
+	[RST_BUS_I2C4]			= { 0xe90, BIT(16) },
+	[RST_BUS_I2C5]			= { 0xe94, BIT(16) },
+	[RST_BUS_I2C6]			= { 0xe98, BIT(16) },
+	[RST_BUS_I2C7]			= { 0xe9c, BIT(16) },
+	[RST_BUS_I2C8]			= { 0xea0, BIT(16) },
+	[RST_BUS_I2C9]			= { 0xea4, BIT(16) },
+	[RST_BUS_I2C10]			= { 0xea8, BIT(16) },
+	[RST_BUS_I2C11]			= { 0xeac, BIT(16) },
+	[RST_BUS_I2C12]			= { 0xeb0, BIT(16) },
+	[RST_BUS_SPI0]			= { 0xf04, BIT(16) },
+	[RST_BUS_SPI1]			= { 0xf0c, BIT(16) },
+	[RST_BUS_SPI2]			= { 0xf14, BIT(16) },
+	[RST_BUS_SPIF]			= { 0xf1c, BIT(16) },
+	[RST_BUS_SPI3]			= { 0xf24, BIT(16) },
+	[RST_BUS_SPI4]			= { 0xf2c, BIT(16) }, /* From the vendor kernel. */
+	[RST_BUS_GPADC0]		= { 0xfc4, BIT(16) },
+	[RST_BUS_THS0]			= { 0xfe4, BIT(16) },
+	[RST_BUS_IRRX]			= { 0x1004, BIT(16) },
+	[RST_BUS_IRTX]			= { 0x100c, BIT(16) },
+	[RST_BUS_LRADC]			= { 0x1024, BIT(16) },
+	[RST_BUS_SGPIO]			= { 0x1064, BIT(16) }, /* From the vendor kernel. */
+	[RST_BUS_LPC]			= { 0x1084, BIT(16) }, /* From the vendor kernel. */
+	[RST_BUS_I2SPCM0]		= { 0x120c, BIT(16) },
+	[RST_BUS_I2SPCM1]		= { 0x121c, BIT(16) },
+	[RST_BUS_I2SPCM2]		= { 0x122c, BIT(16) },
+	[RST_BUS_I2SPCM3]		= { 0x123c, BIT(16) },
+	[RST_BUS_I2SPCM4]		= { 0x124c, BIT(16) },
+	[RST_BUS_SPDIF]			= { 0x128c, BIT(16) },
+	[RST_BUS_DMIC]			= { 0x12cc, BIT(16) },
+	[RST_USB_PHY0]			= { 0x1300, BIT(30) },
+	[RST_BUS_OHCI0]			= { 0x1304, BIT(16) },
+	[RST_BUS_EHCI0]			= { 0x1304, BIT(20) },
+	[RST_BUS_OTG]			= { 0x1304, BIT(24) },
+	[RST_USB_PHY1]			= { 0x1308, BIT(30) },
+	[RST_BUS_OHCI1]			= { 0x130c, BIT(16) },
+	[RST_BUS_EHCI1]			= { 0x130c, BIT(20) },
+	[RST_BUS_USB2]			= { 0x135c, BIT(16) },
+	[RST_BUS_PCIE_PWRUP]		= { 0x138c, BIT(16) },
+	[RST_BUS_PCIE]			= { 0x138c, BIT(17) },
+	[RST_BUS_SERDES]		= { 0x13c4, BIT(16) },
+	[RST_BUS_GMAC0]			= { 0x141c, BIT(16) },
+	[RST_BUS_GMAC0_AXI]		= { 0x141c, BIT(17) },
+	[RST_BUS_GMAC1]			= { 0x142c, BIT(16) }, /* From the vendor kernel. */
+	[RST_BUS_GMAC1_AXI]		= { 0x142c, BIT(17) }, /* From the vendor kernel. */
+	[RST_BUS_TCON_LCD0]		= { 0x1504, BIT(16) },
+	[RST_BUS_TCON_LCD1]		= { 0x150c, BIT(16) },
+	[RST_BUS_TCON_LCD2]		= { 0x1514, BIT(16) }, /* From the vendor kernel. */
+	[RST_BUS_LVDS0]			= { 0x1544, BIT(16) },
+	[RST_BUS_LVDS1]			= { 0x154c, BIT(16) },
+	[RST_BUS_DSI0]			= { 0x1584, BIT(16) },
+	[RST_BUS_DSI1]			= { 0x158c, BIT(16) },
+	[RST_BUS_TCON_TV0]		= { 0x1604, BIT(16) },
+	[RST_BUS_TCON_TV1]		= { 0x160c, BIT(16) },
+	[RST_BUS_EDP]			= { 0x164c, BIT(16) },
+	[RST_BUS_HDMI_MAIN]		= { 0x168c, BIT(16) },
+	[RST_BUS_HDMI_SUB]		= { 0x168c, BIT(17) },
+	[RST_BUS_HDMI_HDCP]		= { 0x168c, BIT(18) },
+	[RST_BUS_DPSS_TOP0]		= { 0x16c4, BIT(16) },
+	[RST_BUS_DPSS_TOP1]		= { 0x16cc, BIT(16) },
+	[RST_BUS_VIDEO_OUT0]		= { 0x16e4, BIT(16) },
+	[RST_BUS_VIDEO_OUT1]		= { 0x16ec, BIT(16) },
+	[RST_BUS_LEDC]			= { 0x1704, BIT(16) },
+	[RST_BUS_DSC]			= { 0x1744, BIT(16) },
+	[RST_BUS_CSI]			= { 0x1844, BIT(16) },
+	[RST_BUS_VIDEO_IN]		= { 0x1884, BIT(16) },
+	[RST_BUS_APB2JTAG]		= { 0x1c04, BIT(16) },
+};
+
 static const struct sunxi_ccu_desc sun60i_a733_ccu_desc = {
 	.ccu_clks	= sun60i_a733_ccu_clks,
 	.num_ccu_clks	= ARRAY_SIZE(sun60i_a733_ccu_clks),
 
 	.hw_clks	= &sun60i_a733_hw_clks,
+
+	.resets		= sun60i_a733_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sun60i_a733_ccu_resets),
 };
 
 static const u32 pll_regs[] = {

-- 
2.55.0

