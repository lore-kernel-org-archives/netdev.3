Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98CE3346BE;
	Fri,  4 Sep 2026 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540500; cv=pass; b=JENG4FF5lEyJ2HD9dKXKySGNQvt67DjmylvnjE/jRve4rAtvz6LdrlEt9t6UbauckcM6VovR8MBHWNwXxyF8INA7ngzNK8GXLGf7oopkE2bXnSx1oYBnNz/jqG/a+hOKU1wviJApF9q32+n3U+8HHdTfy9s3CQ60WOrc1+5Agpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540500; c=relaxed/simple;
	bh=KmUZH4oUV351SQ4q/erHygPZFRXiLS0OXAE1BPP3dRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHOKW45YBv4NgfQmSNpwP6aTMm3X5izcfgZOK6z3jqJG94gcgFfAqNrhBo6qdJvVFOOVZYn3mHUtDxWpNcmXU526GvyINXUQuzCMal/R0tKEBST82w4kKXxhbsm0yxhG/W36XFhe2CLyCKcTIcTmD9FsNwD6lBk/ub7iccbpWMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=FPYSkFD8; arc=pass smtp.client-ip=165.173.180.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="FPYSkFD8"
ARC-Seal: i=1; a=rsa-sha256; t=1788540470; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q7zMF6tU76XFbKfmDd83j/YprT37JnFxJn8hWUcQFR+LT64kl5n9qQ/ynJNaxE6gDv2yIyEFbS9hIsbqBfjMU6hAmOkMPc7d/U5EWCseyC+IRIKW2zVzGxcD0dy+X6z1CQ/IByVTXUSqmdTnCh2NNTQbtT/kEZczkabUdBMwIGY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788540470; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=S6nkLCFHb4iZgJB2QxxuEXLgVf0ukEtQlCfSX/H4f80=; 
	b=H+7q0rrl3F3X6bbaZiQbqgeqgXQmpa6h0jj3THGSCECFkrc1N+DEZ2YBpZnXkx2ZD9aoZN+Uk+LQGTJdLYsoomr/ReQoYpJPZho1aIV503rylVzwVGVAvQYJvp2kT7v943lSG5fpDlXP5umnEbCfwdrRxcWYrCNkQufohrLGx1g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788540470;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=S6nkLCFHb4iZgJB2QxxuEXLgVf0ukEtQlCfSX/H4f80=;
	b=FPYSkFD81ASSjlTF3n/xEM5+3an8HxijN3gwG3NLmUK9lQ8fGqDXtpgwdrlHv2Py
	b4Slre+ZO6N9jgpALcVg8eZ26wr6Q4el5w/RdTvgnTDqNoGxyq7ZzTSDBFtx1xfv2Rq
	Cc6SIPQozki7TZdvjngMtMQ9urRU+psm1dR3dJyk=
Received: by mx.zohomail.com with SMTPS id 1788540467420828.3975615370953;
	Fri, 4 Sep 2026 09:47:47 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Sat, 05 Sep 2026 00:45:34 +0800
Subject: [PATCH v3 5/8] clk: sunxi-ng: a733: Add bus clocks support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-a733-clk-v3-5-50f238f39c78@pigmoral.tech>
References: <20260905-a733-clk-v3-0-50f238f39c78@pigmoral.tech>
In-Reply-To: <20260905-a733-clk-v3-0-50f238f39c78@pigmoral.tech>
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
 Enzo Adriano <enzo.adriano.code@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5508;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=KmUZH4oUV351SQ4q/erHygPZFRXiLS0OXAE1BPP3dRk=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLJmfb1oltbLsln/4lWBuapOSoutVsUVGDitu2gpMNlbo
 N1nateKjlIWBjEuBlkxRRYuf/F/1jo8344ItN6HmcPKBDKEgYtTACbC8I6RYeXXelvZYo/eqEV/
 7j68bjV12mMTda59MaeFjFsuSJwwzWT4n7v3WUJgTiqH+zf1XRFV0SWPIvJcz4a5bKz8obeFbeN
 jfgA=
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External

Add the essential bus clocks in the Allwinner A733 CCU, including AHB,
APB0, APB1, APB_UART, and MBUS. These buses are necessary for many other
functional modules. An additional trace clock is also added as it falls
within the register address range of the bus clocks, even though it is
not strictly a bus clock.

The MBUS clock is marked as critical to ensure the memory bus remains
operational at all times. And the hardware requires an update bit
(bit 27) to be set so that the configuration takes effect and the
updated parameters can be correctly read back for the MBUS clock.

Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 91 ++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
index 430a535919c6..3a25c349f11b 100644
--- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
+++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
@@ -18,6 +18,7 @@
 
 #include "ccu_div.h"
 #include "ccu_gate.h"
+#include "ccu_mp.h"
 #include "ccu_mult.h"
 #include "ccu_nkmp.h"
 #include "ccu_nm.h"
@@ -68,6 +69,16 @@ static const struct clk_hw *pll_ref_hws[] = {
 	&pll_ref_clk.common.hw
 };
 
+/*
+ * There is a non-software-configurable mux selecting between the DCXO and the
+ * PLL_REF in hardware, whose output is fed to the sys-24M clock. Although both
+ * sys-24M and pll-ref are fixed at 24 MHz, define a 1:1 fixed factor clock to
+ * provide logical separation:
+ * - pll-ref is dedicated to feeding other PLLs
+ * - sys-24M serves as reference clock for downstream functional modules
+ */
+static CLK_FIXED_FACTOR_HWS(sys_24M_clk, "sys-24M", pll_ref_hws, 1, 1, 0);
+
 #define SUN60I_A733_PLL_DDR_REG		0x020
 static struct ccu_nkmp pll_ddr_clk = {
 	.enable		= BIT(27),
@@ -414,6 +425,73 @@ static SUNXI_CCU_M_HWS_WITH_GATE(pll_de_3x_clk, "pll-de-3x", pll_de_hws,
 				 SUN60I_A733_PLL_DE_REG,
 				 16, 3, BIT(26), 0);
 
+/**************************************************************************
+ *                           bus clocks                                   *
+ **************************************************************************/
+
+static const struct clk_parent_data ahb_apb_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .hw = &pll_periph0_600M_clk.hw },
+};
+
+static SUNXI_CCU_M_DATA_WITH_MUX(ahb_clk, "ahb", ahb_apb_parents, 0x500,
+				 0, 5,		/* M */
+				 24, 2,		/* mux */
+				 0);
+
+static SUNXI_CCU_M_DATA_WITH_MUX(apb0_clk, "apb0", ahb_apb_parents, 0x510,
+				 0, 5,		/* M */
+				 24, 2,		/* mux */
+				 0);
+
+static SUNXI_CCU_M_DATA_WITH_MUX(apb1_clk, "apb1", ahb_apb_parents, 0x518,
+				 0, 5,		/* M */
+				 24, 2,		/* mux */
+				 0);
+
+static const struct clk_parent_data apb_uart_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .hw = &pll_periph0_600M_clk.hw },
+	{ .hw = &pll_periph0_480M_clk.common.hw },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX(apb_uart_clk, "apb-uart", apb_uart_parents, 0x538,
+				 0, 5,		/* M */
+				 24, 3,		/* mux */
+				 0);
+
+static const struct clk_parent_data trace_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .hw = &pll_periph0_300M_clk.hw },
+	{ .hw = &pll_periph0_400M_clk.hw },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(trace_clk, "trace", trace_parents, 0x540,
+				 0, 5,		/* M */
+				 24, 3,		/* mux */
+				 BIT(31),	/* gate */
+				 0);
+
+static const struct clk_parent_data mbus_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .hw = &pll_periph1_600M_clk.hw },
+	{ .hw = &pll_ddr_clk.common.hw },
+	{ .hw = &pll_periph1_480M_clk.common.hw },
+	{ .hw = &pll_periph1_400M_clk.hw },
+	{ .hw = &pll_npu_clk.common.hw },
+};
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(mbus_clk, "mbus", mbus_parents, 0x588,
+					    0, 5,	/* M */
+					    0, 0,	/* no P */
+					    24, 3,	/* mux */
+					    BIT(31),	/* gate */
+					    CLK_IS_CRITICAL,
+					    CCU_FEATURE_UPDATE_BIT);
+
 /*
  * Contains all clocks that are controlled by a hardware register. They
  * have a (sunxi) .common member, which needs to be initialised by the common
@@ -448,11 +526,18 @@ static struct ccu_common *sun60i_a733_ccu_clks[] = {
 	&pll_de_clk.common,
 	&pll_de_4x_clk.common,
 	&pll_de_3x_clk.common,
+	&ahb_clk.common,
+	&apb0_clk.common,
+	&apb1_clk.common,
+	&apb_uart_clk.common,
+	&trace_clk.common,
+	&mbus_clk.common,
 };
 
 static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
 	.hws	= {
 		[CLK_PLL_REF]		= &pll_ref_clk.common.hw,
+		[CLK_SYS_24M]		= &sys_24M_clk.hw,
 		[CLK_PLL_DDR]		= &pll_ddr_clk.common.hw,
 		[CLK_PLL_PERIPH0_4X]	= &pll_periph0_4x_clk.common.hw,
 		[CLK_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.common.hw,
@@ -494,6 +579,12 @@ static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
 		[CLK_PLL_DE]		= &pll_de_clk.common.hw,
 		[CLK_PLL_DE_4X]		= &pll_de_4x_clk.common.hw,
 		[CLK_PLL_DE_3X]		= &pll_de_3x_clk.common.hw,
+		[CLK_AHB]		= &ahb_clk.common.hw,
+		[CLK_APB0]		= &apb0_clk.common.hw,
+		[CLK_APB1]		= &apb1_clk.common.hw,
+		[CLK_APB_UART]		= &apb_uart_clk.common.hw,
+		[CLK_TRACE]		= &trace_clk.common.hw,
+		[CLK_MBUS]		= &mbus_clk.common.hw,
 	},
 	.num	= CLK_FANOUT3 + 1,
 };

-- 
2.55.0

