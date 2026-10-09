Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE7395ACE;
	Fri,  9 Oct 2026 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561240; cv=pass; b=McLq2n5PRJtwdEkIsWzmKGjthU8QhbkkroTmfy02xmJU6xS73N1u/5JOxtZ2FOknx0mTF+76HALtlNIkAXIZ8nD2lYyYfcTHcAlFFUmbUKAgIXpm24cGekgLmx0xeOBhrDfWpubhSc9QAv5sYxZzlwMiJ/Py6C1QNas2SJBKIM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561240; c=relaxed/simple;
	bh=8+TlToDAGMcLtBebw/bk3jKYfg+eVBbCP5TQM9k92rA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iM7WwZjXiLCcwDxBiYqvqfYQ91SXPUgkcaB1TX1Y8e1mt9qXAvo42NTZa6UfhxGT8fKIrRPW03ISPvhwOjVlAb58IRmhsk+Y5WaNwzerLr5bGgJtP4U+DYMEn63oSTnl+6Bywm7DR1/4IGvJxySM6YBT6Z6NXC5MVfduBpmY1sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=JsdTYW2d; arc=pass smtp.client-ip=165.173.182.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="JsdTYW2d"
ARC-Seal: i=1; a=rsa-sha256; t=1791561204; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WogVgt/pwX8Jc3DBK5ZkpHcq7NGOHZMJAkZP4tpKog6qhQqG8gpoUPJ7TMiRquGtvBQ+PRb0qzz1vkupXyQxMOzWeWYPwYrMy5iGQ/yl+FRS/JJPZknEP7O9l1d1slHKVQ/Trw1H45FPHYeH9e201T884iJwKD5AeZ66TtlZ2X8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791561204; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y9NwEbyVjw2WwQhh/YiuNnChv3bZnD+ix5wp8QNDx/U=; 
	b=FV+eKgvhsmwxW/Eh8F0++XZE+2oBefbj0au5ZBgqb6mm0OZuX1EUJrO+Bwq8WSxEppSb3elbSmQjeeM+L5AFpU6hrftufgjedOXWTpJbsixE7wtSOssUhEe2FhJ46xxkhb4PZx21HHHVfqZqYpXPoA/oeQfTwuxMADUCB0076PA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791561204;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Y9NwEbyVjw2WwQhh/YiuNnChv3bZnD+ix5wp8QNDx/U=;
	b=JsdTYW2dequyeySQjmlil78mdr8ImTeHmCECLcssOVO1owUc0c5Ut4Ytt7QZ0ZUd
	uYvdpNK13g5PnznUYSbBpyovO6gDegX7OljohROcdVY2TEZdkP4pfctv1hj6vl31gPj
	iDr9FH6cHxsV/fytfCw8Ars/gGh9tYKJwH/NIBRw=
Received: by smtp.zohomail.com with SMTPS id 1791561203109815.1569086105898;
	Fri, 9 Oct 2026 08:53:23 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Fri, 09 Oct 2026 23:52:07 +0800
Subject: [PATCH v6 2/8] clk: sunxi-ng: sdm: Add dual patterns support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-a733-clk-v6-2-ae8178fce7e8@pigmoral.tech>
References: <20261009-a733-clk-v6-0-ae8178fce7e8@pigmoral.tech>
In-Reply-To: <20261009-a733-clk-v6-0-ae8178fce7e8@pigmoral.tech>
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
 Andre Przywara <andre.przywara@arm.com>, Norman Herms <dockseed@proton.me>, 
 Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5991;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=8+TlToDAGMcLtBebw/bk3jKYfg+eVBbCP5TQM9k92rA=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLJO8u5q47+f/rCpxWde3vrJDC9fFhmqhBgFBqr4iCpkT
 tQqUC7rKGVhEONikBVTZOHyF/9nrcPz7YhA632YOaxMIEMYuDgFYCJNwowMS8/azez7+OB32lWt
 i9tTa849fNm06tNGk4qta1wfOB0rcmP4xWQwS6p/5mP3G02O094svhoy/d+W3gABe4P0rJkX+lm
 WcgMA
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External

On newer Allwinner platforms like the A733, the Sigma-Delta Modulation
(SDM) control logic is more complex. The SDM enable bit, which was
previously located in the PLL register, is now moved to a second
pattern register (PATTERN1).

To support this, rename the existing "tuning" members to "pattern0" to
align with the datasheet, and introduce the _SUNXI_CCU_SDM_DUAL_PAT
macro to provide pattern1 register support. Related operations are also
updated.

Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/sunxi-ng/ccu_sdm.c | 52 ++++++++++++++++++++++++++++++------------
 drivers/clk/sunxi-ng/ccu_sdm.h | 29 ++++++++++++++---------
 2 files changed, 55 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_sdm.c b/drivers/clk/sunxi-ng/ccu_sdm.c
index c564e5f9e610..7e13ffd246d3 100644
--- a/drivers/clk/sunxi-ng/ccu_sdm.c
+++ b/drivers/clk/sunxi-ng/ccu_sdm.c
@@ -18,7 +18,11 @@ bool ccu_sdm_helper_is_enabled(struct ccu_common *common,
 	if (sdm->enable && !(readl(common->base + common->reg) & sdm->enable))
 		return false;
 
-	return !!(readl(common->base + sdm->tuning_reg) & sdm->tuning_enable);
+	if (sdm->pat1_enable &&
+	    (readl(common->base + sdm->pat1_reg) & sdm->pat1_enable) != sdm->pat1_enable)
+		return false;
+
+	return !!(readl(common->base + sdm->pat0_reg) & sdm->pat0_enable);
 }
 EXPORT_SYMBOL_NS_GPL(ccu_sdm_helper_is_enabled, "SUNXI_CCU");
 
@@ -37,18 +41,27 @@ void ccu_sdm_helper_enable(struct ccu_common *common,
 	for (i = 0; i < sdm->table_size; i++)
 		if (sdm->table[i].rate == rate)
 			writel(sdm->table[i].pattern,
-			       common->base + sdm->tuning_reg);
+			       common->base + sdm->pat0_reg);
 
 	/* Make sure SDM is enabled */
 	spin_lock_irqsave(common->lock, flags);
-	reg = readl(common->base + sdm->tuning_reg);
-	writel(reg | sdm->tuning_enable, common->base + sdm->tuning_reg);
+	reg = readl(common->base + sdm->pat0_reg);
+	writel(reg | sdm->pat0_enable, common->base + sdm->pat0_reg);
 	spin_unlock_irqrestore(common->lock, flags);
 
-	spin_lock_irqsave(common->lock, flags);
-	reg = readl(common->base + common->reg);
-	writel(reg | sdm->enable, common->base + common->reg);
-	spin_unlock_irqrestore(common->lock, flags);
+	if (sdm->enable) {
+		spin_lock_irqsave(common->lock, flags);
+		reg = readl(common->base + common->reg);
+		writel(reg | sdm->enable, common->base + common->reg);
+		spin_unlock_irqrestore(common->lock, flags);
+	}
+
+	if (sdm->pat1_enable) {
+		spin_lock_irqsave(common->lock, flags);
+		reg = readl(common->base + sdm->pat1_reg);
+		writel(reg | sdm->pat1_enable, common->base + sdm->pat1_reg);
+		spin_unlock_irqrestore(common->lock, flags);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(ccu_sdm_helper_enable, "SUNXI_CCU");
 
@@ -61,14 +74,23 @@ void ccu_sdm_helper_disable(struct ccu_common *common,
 	if (!(common->features & CCU_FEATURE_SIGMA_DELTA_MOD))
 		return;
 
-	spin_lock_irqsave(common->lock, flags);
-	reg = readl(common->base + common->reg);
-	writel(reg & ~sdm->enable, common->base + common->reg);
-	spin_unlock_irqrestore(common->lock, flags);
+	if (sdm->enable) {
+		spin_lock_irqsave(common->lock, flags);
+		reg = readl(common->base + common->reg);
+		writel(reg & ~sdm->enable, common->base + common->reg);
+		spin_unlock_irqrestore(common->lock, flags);
+	}
+
+	if (sdm->pat1_enable) {
+		spin_lock_irqsave(common->lock, flags);
+		reg = readl(common->base + sdm->pat1_reg);
+		writel(reg & ~sdm->pat1_enable, common->base + sdm->pat1_reg);
+		spin_unlock_irqrestore(common->lock, flags);
+	}
 
 	spin_lock_irqsave(common->lock, flags);
-	reg = readl(common->base + sdm->tuning_reg);
-	writel(reg & ~sdm->tuning_enable, common->base + sdm->tuning_reg);
+	reg = readl(common->base + sdm->pat0_reg);
+	writel(reg & ~sdm->pat0_enable, common->base + sdm->pat0_reg);
 	spin_unlock_irqrestore(common->lock, flags);
 }
 EXPORT_SYMBOL_NS_GPL(ccu_sdm_helper_disable, "SUNXI_CCU");
@@ -123,7 +145,7 @@ unsigned long ccu_sdm_helper_read_rate(struct ccu_common *common,
 	pr_debug("%s: clock is sigma-delta modulated\n",
 		 clk_hw_get_name(&common->hw));
 
-	reg = readl(common->base + sdm->tuning_reg);
+	reg = readl(common->base + sdm->pat0_reg);
 
 	pr_debug("%s: pattern reg is 0x%x",
 		 clk_hw_get_name(&common->hw), reg);
diff --git a/drivers/clk/sunxi-ng/ccu_sdm.h b/drivers/clk/sunxi-ng/ccu_sdm.h
index c1a7159b89c3..e94cef141c7d 100644
--- a/drivers/clk/sunxi-ng/ccu_sdm.h
+++ b/drivers/clk/sunxi-ng/ccu_sdm.h
@@ -33,21 +33,28 @@ struct ccu_sdm_internal {
 	u32		table_size;
 	/* early SoCs don't have the SDM enable bit in the PLL register */
 	u32		enable;
-	/* second enable bit in tuning register */
-	u32		tuning_enable;
-	u16		tuning_reg;
+	/* second enable bit in pattern0 register */
+	u32		pat0_enable;
+	u16		pat0_reg;
+	/* on some platforms, the sdm enable bit in pattern1 register */
+	u32		pat1_enable;
+	u16		pat1_reg;
 };
 
-#define _SUNXI_CCU_SDM(_table, _enable,			\
-		       _reg, _reg_enable)		\
-	{						\
-		.table		= _table,		\
-		.table_size	= ARRAY_SIZE(_table),	\
-		.enable		= _enable,		\
-		.tuning_enable	= _reg_enable,		\
-		.tuning_reg	= _reg,			\
+#define _SUNXI_CCU_SDM_DUAL_PAT(_table, _enable, _pat0, _pat0_enable, _pat1, _pat1_enable) \
+	{								\
+		.table			= _table,			\
+		.table_size		= ARRAY_SIZE(_table),		\
+		.enable			= _enable,			\
+		.pat0_enable		= _pat0_enable,			\
+		.pat0_reg		= _pat0,			\
+		.pat1_enable		= _pat1_enable,			\
+		.pat1_reg		= _pat1,			\
 	}
 
+#define _SUNXI_CCU_SDM(_table, _enable, _pat0, _pat0_enable)	\
+	_SUNXI_CCU_SDM_DUAL_PAT(_table, _enable, _pat0, _pat0_enable, 0, 0)
+
 bool ccu_sdm_helper_is_enabled(struct ccu_common *common,
 			       struct ccu_sdm_internal *sdm);
 void ccu_sdm_helper_enable(struct ccu_common *common,

-- 
2.55.0

