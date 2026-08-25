Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C43032E12E;
	Tue, 25 Aug 2026 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681110; cv=none; b=mX955sPZdQXNEDfgmNJ3qI4BZ6Qrsb5lTtB9mXpFrS0QgNQlylpbAJeqhslF3e/HX2m6o9HMp8LiHNFtYK7RZQvuto73AiGI/RXSF/1B9Lujcpi/qBBYudx1te5u7tXtUUzSh/LWijAtIIeSiAfew/NkmxV18K3UYLfifxvpHoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681110; c=relaxed/simple;
	bh=eU/hiRJSKsiWXUU+LSOpru5wFvnpSPfvI28oOYuULXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NXZcpotNmcLOGjV+o3zzWewTQV9oaTBwf3bENot00fvvHByiPBMqtcHNw3a//AayTZ9euOBpIZ3oqZql1mkiZ5GMvq/VZhANPf7uWXibBAtqG9J8ZXq+xXPlwYUiz+6gnYBlIjXZzqYUXS0z11wmO8eYwp5pwdpQarFAfZ5Gyzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=RVdU9wSL; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="RVdU9wSL"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A42601BD641;
	Tue, 25 Aug 2026 20:04:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1787681098; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=NNgKTV5BAQZHXM4m0j6UpVZtJf2itfOicSCRbOzjkzA=;
	b=RVdU9wSLQbJcUK8+LC1P3L6F1qjWWBH0c/QqtBRd1hob3pzDahjDelTztcfUfIDF1CBNgx
	TU2VYbw+X/x3QkHjV2GADLCa3itZKZuzsdh1GMnCjxfVdPww2WWljrBlCsEi4AIEK0BwTk
	lSoQNpa+YRhntzGM42LkEF9op3p6qbbShpZc/BrhtMaXFFUp2AF+A2+N+7rHP6K4yj1KL/
	c5gVusANmghCCpef7ZqPQQ+47xeU/PldnD0SI2Nb5bvaYMidXBJWtsrS4mzGdRJOoRG1H/
	kFnxw6xMevOwTJUrxrpC9dWHM/oRSiAP1NwophgpH0DMNkiKR0RNY415IpUKWQ==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	daniel@makrotopia.org,
	naseefkm@gmail.com,
	joey@tinyisr.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH net-next] net: phy: mediatek: add driver for EcoNet Fast Ethernet SoC PHYs
Date: Tue, 25 Aug 2026 18:04:21 +0000
Message-Id: <20260825180421.1804729-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add support for the Fast Ethernet PHYs found in EcoNet SoCs based on
the EN7526C variant. This includes the reasonably popular EN7526F SoC.
This PHY bears the ID 03a2.9414 is sometimes referred to as "7522",
though that is not a published product name.

Also provide support for the older EN7512 Fast Ethernet SoC PHYs found
in EN751221 chips with do not have the MCM switch. That is chips which
do not have a "G" in the name. As these PHYs bear the ID 03a2.9412
which collides with MTK_GPHY_ID_MT7530 gigabit PHY, do not match them
and instead rely on the user to override the PHY ID in the device tree
if they wish to use this driver.

Tested on EN7526C but not EN7512.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 MAINTAINERS                              |   6 +
 drivers/net/phy/mediatek/Kconfig         |  15 +
 drivers/net/phy/mediatek/Makefile        |   1 +
 drivers/net/phy/mediatek/econet-fe-soc.c | 632 +++++++++++++++++++++++
 4 files changed, 654 insertions(+)
 create mode 100644 drivers/net/phy/mediatek/econet-fe-soc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 460cb7268845..7ca3d8d08c69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9253,6 +9253,12 @@ W:	https://linuxtv.org
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/ec100*
 
+ECONET ETHERNET PHY DRIVER
+M:	Caleb James DeLisle <cjd@cjdns.fr>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/phy/mediatek/econet-fe-soc.c
+
 ECONET MIPS PLATFORM
 M:	Caleb James DeLisle <cjd@cjdns.fr>
 L:	linux-mips@vger.kernel.org
diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index 3b9cf82c0cb2..64abf5b695ab 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -1,4 +1,19 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config ECONET_FE_SOC_PHY
+	tristate "EcoNet 10/100 SoC Ethernet PHYs"
+	depends on ECONET || COMPILE_TEST
+	select MTK_NET_PHYLIB
+	select PHY_PACKAGE
+	help
+	  Supports EcoNet SoC built-in 10/100 Ethernet PHYs.
+
+	  Include support for built-in Ethernet PHYs which are present in
+	  EN7526C based SoCs (including EN7526F). It can also work with
+	  legacy EN7512 FE PHYs which identify as 03a2.9412, but since this
+	  ID is used by MEDIATEK_GE_PHY, users wanting to force this driver
+	  must override the ID to 03a2.9414 in the device tree.
+
 config MEDIATEK_2P5GE_PHY
 	tristate "MediaTek 2.5Gb Ethernet PHYs"
 	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/Makefile
index 6f9cacf7f906..71239e92aa58 100644
--- a/drivers/net/phy/mediatek/Makefile
+++ b/drivers/net/phy/mediatek/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_ECONET_FE_SOC_PHY)		+= econet-fe-soc.o
 obj-$(CONFIG_MEDIATEK_2P5GE_PHY)	+= mtk-2p5ge.o
 obj-$(CONFIG_MEDIATEK_FE_SOC_PHY)	+= mtk-fe-soc.o
 obj-$(CONFIG_MEDIATEK_GE_PHY)		+= mtk-ge.o
diff --git a/drivers/net/phy/mediatek/econet-fe-soc.c b/drivers/net/phy/mediatek/econet-fe-soc.c
new file mode 100644
index 000000000000..c5dbb32a5d1a
--- /dev/null
+++ b/drivers/net/phy/mediatek/econet-fe-soc.c
@@ -0,0 +1,632 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <linux/bits.h>
+#include <linux/module.h>
+#include <linux/phy.h>
+#include <linux/types.h>
+
+#include "../phylib.h"
+#include "mtk.h"
+
+/*
+ * An older version of this PHY hardware uses the ID 03a2.9412.
+ * This driver does not match on it because it collides with
+ * MTK_GPHY_ID_MT7530, so users wanting to use this driver should
+ * override the PHY ID in the device tree to 03a2.9414.
+ */
+#define ECONET_FEPHY_ID_EN7526C		0x03a29414
+
+#define ECONET_PG_G1			0x1000
+#define ECONET_PG_G2			0x2000
+#define ECONET_PG_G3			0x3000
+#define ECONET_PG_G4			0x4000
+#define ECONET_PG_G5			0x5000
+#define ECONET_PG_G6			0x6000
+#define ECONET_PG_G7			0x7000
+
+#define ECONET_PG_L0			0x8000
+#define ECONET_PG_L1			0x9000
+#define ECONET_PG_L2			0xa000
+#define ECONET_PG_L3			0xb000
+#define ECONET_PG_L4			0xc000
+
+/* 4 ports (8,9,10,11) or 3 ports (9,10,11) */
+#define ECONET_LEGACY_PORT0_ADDR	8
+#define ECONET_EN7526C_PORT0_ADDR	9
+
+/*
+ * Calibration polling does not complete until ECONET_CAL_MIN_CYCLES
+ * consecutive "done" results are received. See: poll_cal_complete
+ */
+#define ECONET_CAL_MIN_CYCLES		10
+
+/*
+ * Microseconds per calibration poll cycle, calibration takes approximately
+ * ECONET_CAL_CYCLE_US * ECONET_CAL_MIN_CYCLES. Total setup time is usually
+ * less than 150x this number.
+ */
+#define ECONET_CAL_CYCLE_US		10
+
+/* Total time allowed for calibration polling before error is returned. */
+#define ECONET_CAL_TIMEOUT_US		100000
+
+/*
+ * Note: These register definitions were written without the benefit of the
+ *       hardware specification, so names are given only where the meaning is
+ *       fairly obvious.
+ */
+
+/* G7R24 */
+#define ECONET_CAL_TYPE_MASK		GENMASK(14, 12)
+#define   ECONET_CAL_TYPE_R50		FIELD_PREP(ECONET_CAL_TYPE_MASK, 0x6)
+#define   ECONET_CAL_TYPE_TXOS		FIELD_PREP(ECONET_CAL_TYPE_MASK, 0x3)
+#define   ECONET_CAL_TYPE_TXAMP		FIELD_PREP(ECONET_CAL_TYPE_MASK, 0x7)
+#define ECONET_R50_ZCAL_MASK		GENMASK(11, 6)
+#define ECONET_CALIN_EN7526C		BIT(4)
+#define ECONET_CAL_DONE_EN7526C		BIT(1)
+#define ECONET_CAL_OUT_EN7526C		BIT(0)
+
+/* L4R23 */
+#define ECONET_CALIN_LEGACY		BIT(2)
+#define ECONET_CAL_DONE_LEGACY		BIT(6)
+#define ECONET_CAL_OUT_LEGACY		BIT(4)
+
+#define ECONET_DAC_IN_2V		0x0f0
+
+/* L4R17 */
+#define ECONET_TXOS_SIGN		BIT(13)
+#define ECONET_TXOS_MAG			GENMASK(12, 8)
+
+#define ECONET_TXOS_DEFAULT		0
+#define ECONET_TXOS_MAX			31
+#define ECONET_TXOS_MIN			-31
+
+#define ECONET_R50_ZCAL_DEFAULT		0x20
+#define ECONET_R50_ZCAL_MAX		0x3f
+
+/* L4R22 */
+#define ECONET_R50_TXCAL_MASK		GENMASK(15, 8)
+#define ECONET_R50_RXCAL_MASK		GENMASK(7, 0)
+
+#define ECONET_TXAMP_DEFAULT		0x12
+#define ECONET_TXAMP_MAX		0x3f
+
+/* ZCAL compensation table per chip, per phy, RX + TX */
+struct compensation {
+	s8 zcal_tx;
+	s8 zcal_rx;
+	s8 txos;
+	s8 amp;
+};
+
+static const struct compensation en751221_comp[2][4] = {
+	{
+		/* Legacy */
+		{ .zcal_tx = 2,  .zcal_rx = -4, .txos = 0, .amp = 1 }, /*  8 */
+		{ .zcal_tx = 2,  .zcal_rx = -4, .txos = 1, .amp = 2 }, /*  9 */
+		{ .zcal_tx = 2,  .zcal_rx = -4, .txos = 1, .amp = 1 }, /* 10 */
+		{ .zcal_tx = -2, .zcal_rx = -8, .txos = 1, .amp = 1 }, /* 11 */
+	},
+	{
+		/* EN7526C */
+		{ .zcal_tx = 3,  .zcal_rx = 6, .txos = 1, .amp = 0 }, /*  9 */
+		{ .zcal_tx = 2,  .zcal_rx = 5, .txos = 1, .amp = -1 }, /* 10 */
+		{ .zcal_tx = 6,  .zcal_rx = 6, .txos = 1, .amp = -1 }, /* 11 */
+		{ }, /* Unused */
+	}
+};
+
+static const u8 zcal_to_r50ohm[64] = {
+	127, 127, 127, 127, 127, 127, 126, 123, 120, 117, 114, 112, 110, 107, 105, 103,
+	101,  99,  97,  79,  77,  75,  74,  72,  70,  69,  67,  66,  65,  47,  46,  45,
+	 43,  42,  41,  40,  39,  38,  37,  36,  34,  34,  33,  32,  15,  14,  13,  12,
+	 11,  10,  10,   9,   8,   7,   7,   6,   5,   4,   4,   3,   2,   2,   1,   1
+};
+
+struct econet_socphy_shared {
+	struct phy_device *phydev_p0;
+};
+
+static struct compensation get_ctab(struct phy_device *phydev)
+{
+	struct econet_socphy_shared *shared = phy_package_get_priv(phydev);
+	u8 phy_offset;
+
+	phy_offset = phydev->mdio.addr - shared->phydev_p0->mdio.addr;
+
+	if (WARN_ON_ONCE(phy_offset >= ARRAY_SIZE(en751221_comp[0])))
+		return (struct compensation) {};
+
+	return en751221_comp[phydev->phy_id == ECONET_FEPHY_ID_EN7526C][phy_offset];
+}
+
+static void set_calin_flag(struct phy_device *phydev, bool enabled)
+{
+	struct econet_socphy_shared *shared = phy_package_get_priv(phydev);
+	u16 set;
+
+	if (phydev->phy_id == ECONET_FEPHY_ID_EN7526C) {
+		/* G7R24 is shared so phy_modify_paged is required */
+		set = enabled ? ECONET_CALIN_EN7526C : 0;
+		phy_modify_paged(phydev, ECONET_PG_G7, 24,
+				 ECONET_CALIN_EN7526C, set);
+	} else {
+		set = enabled ? ECONET_CALIN_LEGACY : 0;
+		phy_write_paged(shared->phydev_p0, ECONET_PG_L4, 23, set);
+	}
+}
+
+struct cal_complete_ctx {
+	u16 consecutive_trues	: 15;
+	bool started		: 1;
+	bool observed_false	: 1;
+	u16 aborted_tries	: 7;
+};
+
+/**
+ * poll_cal_complete - poll for calibration completion.
+ *
+ * Because some legacy chips are known to be unreliable (false positives),
+ * reference code adds 10,000us of fixed delay per calibration cycle.
+ * Practically, there are about 10-50 calibration cycles for each of the
+ * three tunables, so adding a significant fixed delay is costly.
+ *
+ * This implementation instead starts with CALIN disabled, polls for
+ * done status false, then enables CALIN and polls until a true done
+ * status is recorded ECONET_CAL_MIN_CYCLES times consecutively.
+ *
+ * @returns:
+ *   < 0 on error
+ *   0 not yet complete
+ *   1 complete false
+ *   2 complete true
+ */
+static int poll_cal_complete(struct phy_device *phydev,
+			     struct cal_complete_ctx *ctx)
+{
+	struct econet_socphy_shared *shared = phy_package_get_priv(phydev);
+	int done_mask;
+	int out_mask;
+	int ret;
+
+	if (phydev->phy_id == ECONET_FEPHY_ID_EN7526C) {
+		ret = phy_read_paged(phydev, ECONET_PG_G7, 24);
+		done_mask = ECONET_CAL_DONE_EN7526C;
+		out_mask = ECONET_CAL_OUT_EN7526C;
+	} else {
+		ret = phy_read_paged(shared->phydev_p0, ECONET_PG_L4, 23);
+		done_mask = ECONET_CAL_DONE_LEGACY;
+		out_mask = ECONET_CAL_OUT_LEGACY;
+	}
+	if (ret < 0)
+		return ret;
+
+	if ((ret & done_mask) == 0) {
+		ctx->observed_false = true;
+		ctx->aborted_tries += (ctx->consecutive_trues > 0);
+		ctx->consecutive_trues = 0;
+
+		if (!ctx->started) {
+			set_calin_flag(phydev, true);
+			ctx->started = true;
+			return poll_cal_complete(phydev, ctx);
+		}
+
+		return 0;
+	}
+
+	ctx->consecutive_trues++;
+
+	if (ctx->consecutive_trues < ECONET_CAL_MIN_CYCLES || !ctx->observed_false)
+		return 0;
+
+	if (ctx->aborted_tries)
+		phydev_warn(phydev, "Calibration cycle %d false positives\n",
+			    ctx->aborted_tries);
+
+	return ((ret & out_mask) != 0) ? 2 : 1;
+}
+
+/**
+ * poll_cal_complete - check for calibration register
+ * @returns: -error or 1 if calibration result is true.
+ */
+static int en751221_fephy_cal_cycle(struct phy_device *phydev)
+{
+	struct cal_complete_ctx cctx = {};
+	int out;
+	int ret;
+
+	set_calin_flag(phydev, false);
+
+	ret = read_poll_timeout(poll_cal_complete, out, out != 0,
+				ECONET_CAL_CYCLE_US, ECONET_CAL_TIMEOUT_US,
+				false, phydev, &cctx);
+
+	if (ret < 0) {
+		phydev_err(phydev, "Calibration timeout %d (%d / %d / %d / %d)\n",
+			   ret, cctx.consecutive_trues, cctx.observed_false,
+			   cctx.aborted_tries, cctx.started);
+	} else if (out < 0) {
+		phydev_err(phydev, "Calibration error %d\n", out);
+		ret = out;
+	} else {
+		ret = out > 1;
+	}
+
+	set_calin_flag(phydev, false);
+	return ret;
+}
+
+static int en751221_fephy_r50(struct phy_device *phydev)
+{
+	struct econet_socphy_shared *shared = phy_package_get_priv(phydev);
+	struct compensation ctab = get_ctab(phydev);
+	int zcal_sz = ARRAY_SIZE(zcal_to_r50ohm);
+	u8 rg_zcal_ctrl = ECONET_R50_ZCAL_DEFAULT;
+	int initial_comp_out;
+	int polarity = 0;
+	int comp_out;
+	int ret = 0;
+	u16 rxcal;
+	u16 txcal;
+
+	if (phydev->phy_id == ECONET_FEPHY_ID_EN7526C)
+		phy_write_paged(phydev, ECONET_PG_G7, 24, ECONET_CAL_TYPE_R50);
+	else
+		phy_write_paged(shared->phydev_p0, ECONET_PG_L3, 25, 0xc000);
+
+	phy_modify_paged(phydev, ECONET_PG_L3, 25, 0x1000, 0x1000);
+
+	for (;;) {
+		if (phydev->phy_id == ECONET_FEPHY_ID_EN7526C)
+			phy_modify_paged(phydev, ECONET_PG_G7, 24,
+					 ECONET_R50_ZCAL_MASK,
+					 FIELD_PREP(ECONET_R50_ZCAL_MASK,
+						    rg_zcal_ctrl));
+		else
+			phy_write_paged(shared->phydev_p0, ECONET_PG_L3, 26,
+					rg_zcal_ctrl);
+
+		comp_out = en751221_fephy_cal_cycle(phydev);
+		if (comp_out < 0) {
+			ret = comp_out;
+			goto out;
+		}
+
+		if (polarity == 0) {
+			/* First cycle */
+			initial_comp_out = comp_out;
+			polarity = comp_out ? -1 : 1;
+		} else if (initial_comp_out != comp_out) {
+			/* Found */
+			break;
+		}
+
+		rg_zcal_ctrl += polarity;
+
+		if (rg_zcal_ctrl > ECONET_R50_ZCAL_MAX) {
+			ret = 1;
+			goto out;
+		}
+	}
+
+	rxcal = max(0, min(zcal_sz - 1, ctab.zcal_rx + rg_zcal_ctrl));
+	txcal = max(0, min(zcal_sz - 1, ctab.zcal_tx + rg_zcal_ctrl));
+
+	phy_write_paged(phydev, ECONET_PG_L4, 22,
+			FIELD_PREP(ECONET_R50_TXCAL_MASK, txcal) |
+			FIELD_PREP(ECONET_R50_RXCAL_MASK, rxcal));
+
+out:
+	/* Zero out registers */
+	phy_write_paged(phydev, ECONET_PG_L3, 25, 0x0000);
+
+	if (phydev->phy_id == ECONET_FEPHY_ID_EN7526C)
+		phy_write_paged(phydev, ECONET_PG_G7, 24, 0x0000);
+	else
+		phy_write_paged(shared->phydev_p0, ECONET_PG_L3, 25, 0xc000);
+
+	phy_write_paged(phydev, ECONET_PG_L3, 25, 0x0000);
+
+	return ret;
+}
+
+static int en751221_fephy_tx_offset(struct phy_device *phydev)
+{
+	struct econet_socphy_shared *shared = phy_package_get_priv(phydev);
+	struct compensation ctab = get_ctab(phydev);
+	int initial_comp_out;
+	int polarity = 0;
+	int offset = ECONET_TXOS_DEFAULT;
+	u16 offset_bin;
+	int comp_out;
+	int ret = 0;
+
+	phy_write_paged(phydev, ECONET_PG_L0, 0, 0x2100);
+	phy_write_paged(phydev, ECONET_PG_L0, 26, 0x5200); /* fix MDI */
+
+	if (phydev->phy_id == ECONET_FEPHY_ID_EN7526C) {
+		phy_write_paged(phydev, ECONET_PG_G7, 24, ECONET_CAL_TYPE_TXOS);
+		phy_write_paged(phydev, ECONET_PG_L3, 25, 0x0400);
+	} else {
+		phy_write_paged(shared->phydev_p0, ECONET_PG_L3, 25, 0x4800);
+		phy_write_paged(phydev, ECONET_PG_L3, 25, 0x4c00);
+	}
+
+	phy_modify_paged(phydev, ECONET_PG_G4, 21, 0x0800, 0x0800);
+
+	phy_modify_paged(phydev, ECONET_PG_L0, 30, 0x02c0, 0x02c0);
+
+	phy_write_paged(phydev, ECONET_PG_G1, 26, 0x8000);
+
+	for (;;) {
+		offset_bin = FIELD_PREP(ECONET_TXOS_MAG, abs(offset));
+		if (offset < 0)
+			offset_bin |= ECONET_TXOS_SIGN;
+
+		phy_write_paged(phydev, ECONET_PG_L4, 17, offset_bin);
+
+		comp_out = en751221_fephy_cal_cycle(phydev);
+		if (comp_out < 0) {
+			ret = comp_out;
+			goto out;
+		}
+
+		if (polarity == 0) {
+			/* First cycle */
+			initial_comp_out = comp_out;
+			polarity = comp_out ? -1 : 1;
+		} else if (initial_comp_out != comp_out) {
+			/* Found */
+			break;
+		}
+
+		offset += polarity;
+
+		if (offset > ECONET_TXOS_MAX || offset < ECONET_TXOS_MIN) {
+			ret = 1;
+			offset = 0;
+			goto set_val;
+		}
+	}
+
+	offset += ctab.txos * polarity;
+
+	if (offset > ECONET_TXOS_MAX || offset < ECONET_TXOS_MIN)
+		offset -= ctab.txos * polarity;
+
+set_val:
+	offset_bin = FIELD_PREP(ECONET_TXOS_MAG, abs(offset));
+	if (offset < 0)
+		offset_bin |= ECONET_TXOS_SIGN;
+	phy_write_paged(phydev, ECONET_PG_L4, 17, offset_bin);
+
+out:
+	if (phydev->phy_id == ECONET_FEPHY_ID_EN7526C)
+		phy_write_paged(phydev, ECONET_PG_G7, 24, 0x0000);
+	else
+		phy_write_paged(shared->phydev_p0, ECONET_PG_L3, 25, 0x0000);
+
+	phy_write_paged(phydev, ECONET_PG_L3, 25, 0x0000);
+
+	return ret;
+}
+
+static int en751221_fephy_tx_amp(struct phy_device *phydev)
+{
+	struct econet_socphy_shared *shared = phy_package_get_priv(phydev);
+	struct compensation ctab = get_ctab(phydev);
+	int initial_comp_out;
+	u8 tx_amp = ECONET_TXAMP_DEFAULT;
+	int polarity = 0;
+	int comp_out;
+	int ret = 0;
+
+	phy_write_paged(phydev, ECONET_PG_L0, 0, 0x2100);
+	phy_write_paged(phydev, ECONET_PG_L0, 26, 0x5203);
+	phy_write_paged(phydev, ECONET_PG_G2, 25, 0x10c0);
+
+	phy_write_paged(phydev, ECONET_PG_G1, 26, 0x8000 | ECONET_DAC_IN_2V);
+	phy_write_paged(phydev, ECONET_PG_G4, 21, 0x0800);
+	phy_write_paged(phydev, ECONET_PG_L0, 30, 0x02c0);
+	phy_write_paged(phydev, ECONET_PG_L4, 21, 0x0000);
+
+	if (phydev->phy_id == ECONET_FEPHY_ID_EN7526C) {
+		phy_write_paged(phydev, ECONET_PG_G7, 24, ECONET_CAL_TYPE_TXAMP);
+		phy_write_paged(phydev, ECONET_PG_L3, 25, 0x0600);
+	} else {
+		phy_write_paged(shared->phydev_p0, ECONET_PG_L3, 25, 0xca00);
+		phy_write_paged(phydev, ECONET_PG_L3, 25, 0xca00 | 0x0400);
+	}
+
+	for (;;) {
+		phy_write_paged(phydev, ECONET_PG_L2, 23, tx_amp);
+
+		comp_out = en751221_fephy_cal_cycle(phydev);
+		if (comp_out < 0) {
+			ret = comp_out;
+			goto out;
+		}
+
+		if (polarity == 0) {
+			/* First cycle */
+			initial_comp_out = comp_out;
+			polarity = comp_out ? -1 : 1;
+		} else if (initial_comp_out != comp_out) {
+			/* Found */
+			break;
+		}
+
+		tx_amp += polarity;
+
+		if (tx_amp > ECONET_TXAMP_MAX) {
+			ret = 1;
+			tx_amp = ECONET_TXAMP_DEFAULT;
+			goto set_val;
+		}
+	}
+
+	if (tx_amp + ctab.amp < ECONET_TXAMP_MAX)
+		tx_amp += ctab.amp;
+
+set_val:
+	phy_write_paged(phydev, ECONET_PG_L2, 23, tx_amp);
+
+out:
+	if (phydev->phy_id == ECONET_FEPHY_ID_EN7526C) {
+		phy_write_paged(phydev, ECONET_PG_G7, 24, 0x0000);
+		phy_write_paged(phydev, ECONET_PG_L0, 30, 0x0000);
+	} else {
+		phy_write_paged(shared->phydev_p0, ECONET_PG_L3, 25, 0x0000);
+	}
+
+	phy_write_paged(phydev, ECONET_PG_L3, 25, 0x0000);
+
+	return ret;
+}
+
+static int en751221_fephy_config_init(struct phy_device *phydev)
+{
+	struct econet_socphy_shared *shared = phy_package_get_priv(phydev);
+	u16 l0r26_temp;
+	int ret;
+	int i;
+
+	if (!shared->phydev_p0) {
+		phydev_err(phydev, "Port zero must be configured\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (phydev->mdio.addr < shared->phydev_p0->mdio.addr)
+		return -EOPNOTSUPP;
+
+	/* Global registers */
+	phy_write_paged(phydev, ECONET_PG_G4, 26, 0x8044);
+	phy_write_paged(phydev, ECONET_PG_G5, 21, 0x00ea);
+	phy_write_paged(phydev, ECONET_PG_G5, 27, 0x02f0);
+
+	/* Local registers */
+	phy_write_paged(phydev, ECONET_PG_L0, 30, 0xa000);
+	phy_write_paged(phydev, ECONET_PG_L1, 22, 0xf000);
+	phy_write_paged(phydev, ECONET_PG_L2, 22, 0x4444);
+	phy_write_paged(phydev, ECONET_PG_L2, 24, 0x0c0c);
+	phy_write_paged(phydev, ECONET_PG_L2, 28, 0x7c44);
+	phy_write_paged(phydev, ECONET_PG_L2, 30, 0x0005);
+	phy_write_paged(phydev, ECONET_PG_L3, 17, 0x0000);
+
+	/* For E1/E2, E3 requires 0x2220, but no known EN751221 E3 chips exist */
+	phy_write_paged(phydev, ECONET_PG_L0, 30, 0x2200);
+
+	if (phydev->phy_id == ECONET_FEPHY_ID_EN7526C) {
+		 /* 100Mb tx p2z_mid, z2n_mid, z2n_ovs_post, n2z_mid */
+		phy_write_paged(phydev, ECONET_PG_G5, 22, 0x0030);
+		phy_write_paged(phydev, ECONET_PG_G5, 25, 0x0248);
+		phy_write_paged(phydev, ECONET_PG_G5, 27, 0x02f0);
+		phy_write_paged(phydev, ECONET_PG_G5, 28, 0x0230);
+	}
+
+	ret = phy_read_paged(phydev, ECONET_PG_L0, 26);
+	if (ret < 0)
+		return ret;
+
+	l0r26_temp = ret;
+
+	/* BG voltage */
+	phy_write_paged(phydev, ECONET_PG_G2, 25, 0x10c0);
+
+	/* MDI */
+	phy_write_paged(phydev, ECONET_PG_L0, 26, 0x5603);
+
+	/* disable tx slew control */
+	phy_write_paged(phydev, ECONET_PG_L4, 21, 0x0000);
+
+	phy_write_paged(phydev, ECONET_PG_L0, 0, 0x2100);
+
+	for (i = 0; i < 5; i++) {
+		ret = en751221_fephy_r50(phydev);
+		if (!ret)
+			break;
+	}
+	if (ret)
+		return ret;
+
+	for (i = 0; i < 5; i++) {
+		ret = en751221_fephy_tx_offset(phydev);
+		if (!ret)
+			break;
+	}
+	if (ret)
+		return ret;
+
+	for (i = 0; i < 5; i++) {
+		ret = en751221_fephy_tx_amp(phydev);
+		if (!ret)
+			break;
+	}
+	if (ret)
+		return ret;
+
+	phy_write_paged(phydev, ECONET_PG_G1, 26, 0x0000);
+	phy_write_paged(phydev, ECONET_PG_L0, 26, l0r26_temp);
+	phy_write_paged(phydev, ECONET_PG_G1, 26, 0x0000);
+
+	phy_write_paged(phydev, ECONET_PG_L2, 22, 0x4444);
+	phy_write_paged(phydev, ECONET_PG_L0, 0, 0x3100);
+
+	return 0;
+}
+
+static int en751221_fephy_probe(struct phy_device *phydev)
+{
+	int port0 = ECONET_EN7526C_PORT0_ADDR;
+	struct econet_socphy_shared *shared;
+	struct mtk_socphy_priv *priv;
+	int ret;
+
+	if (phydev->phy_id != ECONET_FEPHY_ID_EN7526C)
+		port0 = ECONET_LEGACY_PORT0_ADDR;
+
+	ret = devm_phy_package_join(&phydev->mdio.dev, phydev, port0,
+				    sizeof(struct econet_socphy_shared));
+	if (ret)
+		return ret;
+
+	shared = phy_package_get_priv(phydev);
+
+	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	if (phydev->mdio.addr == port0)
+		shared->phydev_p0 = phydev;
+
+	phydev->priv = priv;
+
+	return 0;
+}
+
+static struct phy_driver en751221_fephy_driver[] = {
+	{
+		PHY_ID_MATCH_EXACT(ECONET_FEPHY_ID_EN7526C),
+		.name		= "EcoNet EN751221 FEPHY",
+		.config_init	= en751221_fephy_config_init,
+		.config_intr	= genphy_no_config_intr,
+		.handle_interrupt = genphy_handle_interrupt_no_ack,
+		.probe		= en751221_fephy_probe,
+		.read_page	= mtk_phy_read_page,
+		.write_page	= mtk_phy_write_page,
+	}
+};
+
+module_phy_driver(en751221_fephy_driver);
+
+static const struct mdio_device_id __maybe_unused en751221_fephy_tbl[] = {
+	{ PHY_ID_MATCH_EXACT(ECONET_FEPHY_ID_EN7526C) },
+	{ }
+};
+
+MODULE_DESCRIPTION("EcoNet SoC 10/100 Ethernet PHY driver");
+MODULE_AUTHOR("Caleb James DeLisle <cjd@cjdns.fr>");
+MODULE_LICENSE("GPL");
+
+MODULE_DEVICE_TABLE(mdio, en751221_fephy_tbl);
-- 
2.39.5

