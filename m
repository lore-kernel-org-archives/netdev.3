Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794467667;
	b=FSqChhjNljNlE1JJD1N0S+W0QN4FCETh+hummg+DrC+qb/OtyC/vdrjJ5NTXjCGCTWTn
	 YCqWiCTXA4CshDnaTMuSdtiq/d+olFnZ6avbl+MNCnIG6/YYVLgn+6v4KaYMhI7xw3tXS
	 4juDldSRjc2OuWXjs8xJEf946VF8zAyATZc1K5/RN1AelVgZWt5pdpV3BRpFyKvtjbP9P
	 P1p/1DVlWY0IKBVveObi0jMpdv2Xo96KtuVrm4rQTQUjbVSOc5qfSn4dljgXAZY8hER43
	 e1mVYr1ewyeJmMX68S13plflel1XTND51/P7XM8ybslm19mcflM6q+Gmnp8QGQJQXOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467667;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ZohoMailClient;
	bh=PTmWYRjZfP9gtAisAbUYIagZROMvNeOJ1Og3GOSujJA=;
	b=AyfkPmULGeD0uJrccZL7h2znCW6g6gQEE0hMU7mVgWAQi0ZBLEblR3P0M7ljDn9HU9n7
	 g0s5eY1hhnck7akqWaeY4nf4XmU1BHYC3cml8BDaYNkXbNLicyNnSMZJ+cSKm2DRIZCuM
	 KEhE38Uvc45YkNsSCuHgWpaJUcjzHjr9adGA6eIOPszsbJAF/gZHtC5DdBPejcofXzj4J
	 Mdwx+ocrSqW5HB0J/ZY0hT859PygZJWrSg0uia/pkhMcDpbvAqzuOWogDCBxLUVpFgAZ8
	 26EgZ1cvV6XT5of4xvR1ZNFK9Gl/YfiIQ3e8CQCBdJp6nhXbP7VVqU+Dp2fBDjlmqNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pigmoral.tech;
	spf=pass smtp.mailfrom=pigmoral.tech;
	dkim=pass header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=FPlzk+1X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD77606A323;
	Thu, 12 Nov 2026 07:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFD77606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=FPlzk+1X
ARC-Seal: i=1; a=rsa-sha256; t=1794467630; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E8G0fyEVy6B2a4iKiSdG2Zq7esdsoiZ9TF6jDcln5xC1+yi8QXe3qF6Svj0RCmr/wz570EsJl8C1TiQMDNBvoi0V8HULcF5LkCwnGpSfqgay3HOJuz2c2GxTT8iYouMFZbgDgCyE0SK98jPHwQnQ+E1xK5t+o7V+qTzzM7dK65s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794467630; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PTmWYRjZfP9gtAisAbUYIagZROMvNeOJ1Og3GOSujJA=; 
	b=TgH1dse1V5oSf0qsms+01IKzXfhOMFbdI2P3Ol81L/lwjklj3j7O8IqEN+wJZazbW63ROtiTgwxWxRI1jhMS1j6JP3v84VfRwrDUcHN3bgHhtOeWBAnSlntoqfN9ijoRhiLWj3G7xHOTOm6Nw01ppPCBSCHNlrccDoCJ4jUU3ic=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: a=rsa-sha256; b=FPlzk+1XNykOTPpO72A4BTNwdPrPqLADgh6s5Oa6/2bd79LnAE2bTk5VUb7p3tkUaj85TOmDAfI5hnV2aYCvnlGXINCrOVDVhwdJ7X7Zor6dXtkaXNrhn8Hb38fmjlk08p21WohN5dWvC7ii8ESXgbtP1rDMjAaNsyIjbcmmq7k=; c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1; bh=PTmWYRjZfP9gtAisAbUYIagZROMvNeOJ1Og3GOSujJA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794467628553119.12183427709397;
	Wed, 11 Nov 2026 23:13:48 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Thu, 12 Nov 2026 15:11:51 +0800
Subject: [PATCH v7 2/8] clk: sunxi-ng: sdm: Add dual patterns support
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-a733-clk-v7-2-db7c5451ffa2@pigmoral.tech>
References: <20261112-a733-clk-v7-0-db7c5451ffa2@pigmoral.tech>
In-Reply-To: <20261112-a733-clk-v7-0-db7c5451ffa2@pigmoral.tech>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6057;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=87fr1BLvgSvLwrEFU09cqp4EWYygEGrfj2+1OZ0tcqA=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLK+pj26bTojXePRpNbzVyeIzlPX8RdXYuG+6rny3pGup
 b8+GBUJdZSyMIhxMciKKbJw+Yv/s9bh+XZEoPU+zBxWJpAhDFycAjCR3ZMYGTYf2nJlzoWScJ//
 TpnSr+bfsy3I+OTJzpyuIPfZTv2wsBQjwzQzKSPvw6HOOecFQx/fepl7KH9hjHpiVuC5Dc/L7c4
 s5QIA
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
Tested-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
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
2.56.0

