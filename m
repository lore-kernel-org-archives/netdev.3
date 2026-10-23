Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792751698;
	b=rU+ZI4iwqEtm/8yiqziAEIi1yzJKAkfVllT+EvT0xheZMGKSDCICRQ5MvoRyfG2vaadG
	 /7niYkr36J4w7Dg0jZO+ESs3K7Cnag4wpvdx2OB0v6xZnI720xVF8B9MUT9JEQzFlrtOk
	 eRYraeeBTABNHBrFEwgmjkRzx9aCdpMnA/TU8FeysutUGUe/9c2EFLkooNqPSwdY7O7BS
	 mpyBzmWIvLw3pghQdQ+sw1YNk0NgSsp+B2ZCV5lbgnFSTNpwf1nn3aKUYems5Rv0kZIJa
	 KcD82n8yZ9QyqIRZgpzXL9GMUsdQsIA6VfKRaPWFUoe/FaECXbSXecc+H1mdFAZg5yw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792751698;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=/WQ4vID/mN8x91/Hin8+gAfqOnZUVOATpdd7pB1ex1o=;
	b=fp6pnOVuwAdI3yZYEYgpK7psHrmbxoqNk7RGixKMXdPP5M6mWP3c4/N0CxmoxmQig9PA
	 /Q9EQ/EtaNMP6+42+YZ+WIPea76qhUO06hp6CfeRJUUy3bgtJSlS6t3kzrrzEvLzgOu1l
	 vxulUZuNzyQG/PGqiRPX0KCQNUzMvKyPu7ma1WculIbWnzhdjyEE6JMgTN5Tn/Yy0SEnJ
	 GqVjStkM9S3pE9aDqegtB1Qda9nMXPYFq7CatOsCQVfyD3n16FMIr8jBLu7wUP3x4LEkU
	 QU5Tc1FPqw8ZZXec/0xSn6Kevp8xpyBkx21QF5VcWbpjsi99KvBpvNzQJNPGH0YmF0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQvDIONv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C15606A31A;
	Fri, 23 Oct 2026 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQvDIONv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792751697;
	b=vtTrQqlYoAfgpVKTRkfeNKiKaJkFMM4+0mYLxRpMP79gjW4kpquyxDAAzpX1639J6/vY
	 EJzzwiC5qtHqi4G26gcArnpw1yW5Lkg2XXQ6IQTCSD8yWwkPTTiz/Z+lrtUZSuY9DO2Zj
	 Bf+W3p0QElqQdDrHLYTa2CzDW5n5GA3BF66GrMWYmj4qqSwOSj2NPw2Xrzn/DV92T4Q1Z
	 rdWr+nB1GYReOJ8envjDp1x6qHHFEyprLm48KQbnWG/vsoxX+Tf37Oo7VDhdOQYLgKtFQ
	 T0V6Pm7MEcRsKYRdxiAcRbVKNs/oJc8jXsVsNxfDTFbE1eIY8coGTGJ0UVBH2A0IEKA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792751697;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=/WQ4vID/mN8x91/Hin8+gAfqOnZUVOATpdd7pB1ex1o=;
	b=kPH6/RT871st26BgefQ2FLPJIc+8ZvQfLZXkWQ+xa6vG50XJjzvxxsTh30fLCpthMTS+
	 BTA98cTBx9RCzx9OA1cvgXBWigUHwoRoPvj5w3dngjgPNaJ1DWB51i7D20q6hVRaNdpyN
	 yQOfdXOdesnU0TKfyXSSmf06ROCxNfap3uPfdeTdy/zfBbTHNhpRspwVC7AOiJUY1aky2
	 xB042Oh7d1iL1wlcoaB2Jewhu4uPLr4PaiDRkz1mDlTjrJm0K5duROqps2ToBfFOjJgtC
	 G9PKeB67mXDXLtEL/Z1svJVQswtBnK7vt23OmLzdoqNH9A5qHezU6pxFvpjJFK208vw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C93751F031E0;
	Fri, 23 Oct 2026 10:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792751697;
	bh=/WQ4vID/mN8x91/Hin8+gAfqOnZUVOATpdd7pB1ex1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PQvDIONvMj41mtezMZcnAqxwIFpMfVAFjUo97f60wbYO2e0dqA7KZ1DG4ZWcGUPuO
	 RBk9kF+lzgj2h9QwRj68aVUprIT0XNXOQ9rglYyYX77G0JbFGgDb0970eZwzgMJOJ/
	 CeValCdn29Y+EPa6OLyGVlyP/pfIPRIBIT1UnPEAS2cWmrMy6wv6VEvzSCnpoHD0E3
	 8d4XOWWqE2Jki6YB26lJKcbX9Jsv9wiWKZeJTEwEwd1InL6xWOew8r7vrP9dOdr3MC
	 8Up5YaFQ1TV6w4uxQp5RC2PnAHeS2D+bElu5lcPYB9rC+QaafIEp+xs/1L4LfW4ncB
	 vZK3epHc2WZow==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 39F12444B6;
	Fri, 23 Oct 2026 10:34:56 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Fri, 23 Oct 2026 18:33:48 +0800
Subject: [PATCH v2 2/3] clk: rockchip: Add internal support for 24-bit
 fractional dividers
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
Message-Id: <20261023-add-board-ok3572-c-clk-v2-2-90b98836be6e@qq.com>
References: <20261023-add-board-ok3572-c-clk-v2-0-90b98836be6e@qq.com>
In-Reply-To: <20261023-add-board-ok3572-c-clk-v2-0-90b98836be6e@qq.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Cunhao Lu <1579567540@qq.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792751694; l=14090;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=g4og6gXFCPqPOvWzSj01unU/KsfsRvRArrypYhCzl8U=;
 b=RRvtNqgLAb19LEIJVSXou9PQY+KG1dFJhkJIGfO2mM0bwXfdftTNFbgCBEStM6TtdRbyK1jYd
 gPn+chBCYyaD6zDIoHn2DRQXiPbI1XuCEOleXOkrGrDwclGRgufN4o+
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com

From: Elaine Zhang <zhangqing@rock-chips.com>

Some Rockchip clocks split each 24-bit numerator and denominator between
a low register containing 16 bits of each value and a high register
containing the remaining 8 bits.

Import the vendor fractional-divider-v2 implementation and add a Rockchip
clock branch type for these clocks. Retain the vendor rational
approximation, small-numerator handling, and register access order. Adapt
the rate callback to the determine_rate API and keep registration local to
the Rockchip clock driver. This prerequisite does not add a public clock
API or DT clock ID.

The implementation is ported from the Rockchip vendor driver and includes
a subsequent copyright spelling correction.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/clk/rockchip/Makefile                    |   1 +
 drivers/clk/rockchip/clk-fractional-divider-v2.c | 339 +++++++++++++++++++++++
 drivers/clk/rockchip/clk.c                       |  10 +
 drivers/clk/rockchip/clk.h                       |  25 ++
 4 files changed, 375 insertions(+)

diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index 554b7eb83dc91..91d4ea4837e3e 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -10,6 +10,7 @@ clk-rockchip-y += clk-pll.o
 clk-rockchip-y += clk-cpu.o
 clk-rockchip-y += clk-gate-grf.o
 clk-rockchip-y += clk-half-divider.o
+clk-rockchip-y += clk-fractional-divider-v2.o
 clk-rockchip-y += clk-inverter.o
 clk-rockchip-y += clk-mmc-phase.o
 clk-rockchip-y += clk-muxgrf.o
diff --git a/drivers/clk/rockchip/clk-fractional-divider-v2.c b/drivers/clk/rockchip/clk-fractional-divider-v2.c
new file mode 100644
index 0000000000000..5ab2c43180661
--- /dev/null
+++ b/drivers/clk/rockchip/clk-fractional-divider-v2.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
+ *
+ * Adjustable fractional divider clock implementation.
+ * Uses rational best approximation algorithm.
+ *
+ * Output is calculated as
+ *
+ *	rate = (m / n) * parent_rate				(1)
+ *
+ * This is useful when we have a prescaler block which asks for
+ * m (numerator) and n (denominator) values to be provided to satisfy
+ * the (1) as much as possible.
+ *
+ * Since m and n have the limitation by a range, e.g.
+ *
+ *	n >= 1, n < N_width, where N_width = 2^nwidth		(2)
+ *
+ * for some cases the output may be saturated. Hence, from (1) and (2),
+ * assuming the worst case when m = 1, the inequality
+ *
+ *	floor(log2(parent_rate / rate)) <= nwidth		(3)
+ *
+ * may be derived. Thus, in cases when
+ *
+ *	(parent_rate / rate) >> N_width				(4)
+ *
+ * we might scale up the rate by 2^scale (see the description of
+ * CLK_FRAC_DIVIDER_POWER_OF_TWO_PS for additional information), where
+ *
+ *	scale = floor(log2(parent_rate / rate)) - nwidth	(5)
+ *
+ * and assume that the IP, that needs m and n, has also its own
+ * prescaler, which is capable to divide by 2^scale. In this way
+ * we get the denominator to satisfy the desired range (2) and
+ * at the same time a much better result of m and n than simple
+ * saturated values.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/rational.h>
+#include "clk.h"
+
+struct clk_fractional_divider_v2 {
+	struct clk_hw	hw;
+	void __iomem	*reg;
+	void __iomem	*high_reg;
+	u8		mshift;
+	u8		mwidth;
+	u32		mmask;
+	u8		nshift;
+	u8		nwidth;
+	u32		nmask;
+	u8		high_mshift;
+	u8		high_mwidth;
+	u32		high_mmask;
+	u8		high_nshift;
+	u8		high_nwidth;
+	u32		high_nmask;
+	u8		flags;
+	void		(*approximation)(struct clk_hw *hw,
+					 unsigned long rate,
+					 unsigned long *parent_rate,
+					 unsigned long *m, unsigned long *n);
+	spinlock_t	*lock; /* Protects the low and high register pair. */
+};
+
+#define to_clk_fd_v2(_hw) container_of(_hw, struct clk_fractional_divider_v2, hw)
+
+static inline u32 clk_fd_v2_readl(struct clk_fractional_divider_v2 *fd,
+				  void __iomem *reg)
+{
+	return readl(reg);
+}
+
+static inline void clk_fd_v2_writel(struct clk_fractional_divider_v2 *fd,
+				    void __iomem *reg, u32 val)
+{
+	writel(val, reg);
+}
+
+static unsigned long clk_fd_v2_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct clk_fractional_divider_v2 *fd = to_clk_fd_v2(hw);
+	unsigned long flags = 0;
+	unsigned long m_low, n_low, m_high, n_high, m, n;
+	u32 val_low, val_high;
+	u64 ret;
+
+	if (fd->lock)
+		spin_lock_irqsave(fd->lock, flags);
+	else
+		__acquire(fd->lock);
+
+	val_low = clk_fd_v2_readl(fd, fd->reg);
+	val_high = clk_fd_v2_readl(fd, fd->high_reg);
+
+	if (fd->lock)
+		spin_unlock_irqrestore(fd->lock, flags);
+	else
+		__release(fd->lock);
+
+	m_low = (val_low & fd->mmask) >> fd->mshift;
+	n_low = (val_low & fd->nmask) >> fd->nshift;
+	m_high = (val_high & fd->high_mmask) >> fd->high_mshift;
+	n_high = (val_high & fd->high_nmask) >> fd->high_nshift;
+	m = (m_high << 16) | m_low;
+	n = (n_high << 16) | n_low;
+
+	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
+		m++;
+		n++;
+	}
+
+	if (!n || !m)
+		return parent_rate;
+
+	ret = (u64)parent_rate * m;
+	do_div(ret, n);
+
+	return ret;
+}
+
+static void clk_fractional_divider_general_approximation_v2(struct clk_hw *hw,
+							    unsigned long rate,
+							    unsigned long *parent_rate,
+							    unsigned long *m, unsigned long *n)
+{
+	struct clk_fractional_divider_v2 *fd = to_clk_fd_v2(hw);
+	unsigned long scale;
+
+	/*
+	 * Get rate closer to *parent_rate to guarantee there is no overflow
+	 * for m and n. In the result it will be the nearest rate left shifted
+	 * by (scale - fd->nwidth) bits.
+	 *
+	 * For the detailed explanation see the top comment in this file.
+	 */
+	scale = fls_long(*parent_rate / rate - 1);
+	if (scale > fd->nwidth)
+		rate <<= scale - fd->nwidth;
+
+	rational_best_approximation(rate, *parent_rate,
+				    GENMASK(fd->mwidth - 1, 0),
+				    GENMASK(fd->nwidth - 1, 0),
+				    m, n);
+}
+
+static int clk_fd_v2_determine_rate(struct clk_hw *hw,
+				    struct clk_rate_request *req)
+{
+	struct clk_fractional_divider_v2 *fd = to_clk_fd_v2(hw);
+	unsigned long m, n;
+	u64 ret;
+
+	if (!req->rate || req->rate >= req->best_parent_rate) {
+		req->rate = req->best_parent_rate;
+		return 0;
+	}
+
+	if (fd->approximation)
+		fd->approximation(hw, req->rate, &req->best_parent_rate, &m, &n);
+	else
+		clk_fractional_divider_general_approximation_v2(hw, req->rate,
+								&req->best_parent_rate,
+								&m, &n);
+
+	ret = (u64)req->best_parent_rate * m;
+	do_div(ret, n);
+	req->rate = ret;
+
+	return 0;
+}
+
+static int clk_fd_v2_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct clk_fractional_divider_v2 *fd = to_clk_fd_v2(hw);
+	unsigned long flags = 0;
+	unsigned long m, n, m_low, n_low, m_high, n_high;
+	u32 val, val_high;
+
+	rational_best_approximation(rate, parent_rate,
+				    GENMASK(fd->mwidth - 1, 0),
+				    GENMASK(fd->nwidth - 1, 0),
+				    &m, &n);
+
+	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
+		m--;
+		n--;
+	}
+	/*
+	 * When compensation the fractional divider,
+	 * the [1:0] bits of the numerator register are omitted,
+	 * which will lead to a large deviation in the result.
+	 * Therefore, it is required that the numerator must
+	 * be greater than 4.
+	 *
+	 * Note that there are some exceptions here:
+	 * If there is an even frac div, we need to keep the original
+	 * numerator(<4) and denominator. Otherwise, it may cause the
+	 * issue that the duty ratio is not 50%.
+	 */
+	if (m < 4 && m != 0) {
+		if (n % 2 == 0)
+			val = 1;
+		else
+			val = DIV_ROUND_UP(4, m);
+
+		n *= val;
+		m *= val;
+		if (n > GENMASK(fd->nwidth + fd->high_nwidth - 1, 0)) {
+			pr_debug("%s n(%ld) is overflow, use mask value\n",
+				 __func__, n);
+			n = GENMASK(fd->nwidth + fd->high_nwidth - 1, 0);
+		}
+	}
+
+	if (fd->lock)
+		spin_lock_irqsave(fd->lock, flags);
+	else
+		__acquire(fd->lock);
+
+	m_low = m & fd->nmask;
+	n_low = n & fd->nmask;
+	m_high = (m & GENMASK(fd->mwidth - 1, (fd->mwidth - fd->high_mwidth))) >>
+		 (fd->mwidth - fd->high_mwidth);
+	n_high = (n & GENMASK(fd->nwidth - 1, (fd->nwidth - fd->high_nwidth))) >>
+		 (fd->nwidth - fd->high_nwidth);
+
+	val_high = clk_fd_v2_readl(fd, fd->high_reg);
+	val_high &= ~(fd->high_mmask | fd->high_nmask);
+	val_high |= (m_high << fd->high_mshift) | (n_high << fd->high_nshift);
+
+	clk_fd_v2_writel(fd, fd->high_reg, val_high);
+
+	val = clk_fd_v2_readl(fd, fd->reg);
+	val &= ~(fd->mmask | fd->nmask);
+	val |= (m_low << fd->mshift) | (n_low << fd->nshift);
+	clk_fd_v2_writel(fd, fd->reg, val);
+
+	if (fd->lock)
+		spin_unlock_irqrestore(fd->lock, flags);
+	else
+		__release(fd->lock);
+
+	return 0;
+}
+
+static const struct clk_ops clk_fractional_divider_ops_v2 = {
+	.recalc_rate = clk_fd_v2_recalc_rate,
+	.determine_rate = clk_fd_v2_determine_rate,
+	.set_rate = clk_fd_v2_set_rate,
+};
+
+static struct clk_hw *clk_hw_register_fractional_divider_v2(struct device *dev,
+							    const char *name,
+							    const char *parent_name,
+							    unsigned long flags,
+							    void __iomem *reg,
+							    u8 mshift, u8 mwidth,
+							    u8 nshift, u8 nwidth,
+							    void __iomem *high_reg,
+							    u8 high_mshift, u8 high_mwidth,
+							    u8 high_nshift, u8 high_nwidth,
+							    u8 clk_divider_flags,
+							    spinlock_t *lock)
+{
+	struct clk_fractional_divider_v2 *fd;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
+
+	fd = kzalloc_obj(*fd);
+	if (!fd)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_fractional_divider_ops_v2;
+	init.flags = flags;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+
+	fd->reg = reg;
+	fd->mshift = mshift;
+	fd->mwidth = mwidth + high_mwidth;
+	fd->mmask = GENMASK(mwidth - 1, 0) << mshift;
+	fd->nshift = nshift;
+	fd->nwidth = nwidth + high_nwidth;
+	fd->nmask = GENMASK(nwidth - 1, 0) << nshift;
+	fd->high_reg = high_reg;
+	fd->high_mshift = high_mshift;
+	fd->high_mwidth = high_mwidth;
+	fd->high_mmask = GENMASK(high_mwidth - 1, 0) << high_mshift;
+	fd->high_nshift = high_nshift;
+	fd->high_nwidth = high_nwidth;
+	fd->high_nmask = GENMASK(high_nwidth - 1, 0) << high_nshift;
+	fd->flags = clk_divider_flags;
+	fd->lock = lock;
+	fd->hw.init = &init;
+
+	hw = &fd->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(fd);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+
+struct clk *rockchip_clk_register_frac_v2(struct device *dev,
+					  const char *name,
+					  const char *parent_name,
+					  unsigned long flags,
+					  void __iomem *reg,
+					  u8 mshift, u8 width,
+					  void __iomem *high_reg,
+					  u8 high_mshift, u8 high_width,
+					  u8 clk_divider_flags,
+					  spinlock_t *lock)
+{
+	struct clk_hw *hw;
+
+	hw = clk_hw_register_fractional_divider_v2(dev, name, parent_name, flags,
+						   reg, mshift, width, 0, width,
+						   high_reg, high_mshift, high_width,
+						   0, high_width,
+						   clk_divider_flags,
+						   lock);
+	if (IS_ERR(hw))
+		return ERR_CAST(hw);
+	return hw->clk;
+}
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index ee8c79b938d3c..0646a2e6af0a8 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -589,6 +589,16 @@ void rockchip_clk_register_branches(struct rockchip_clk_provider *ctx,
 				list->gate_flags, flags, list->child,
 				&ctx->lock);
 			break;
+		case branch_fraction_divider_v2:
+			clk = rockchip_clk_register_frac_v2(NULL, list->name,
+							    list->parent_names[0], flags,
+							    ctx->reg_base + list->muxdiv_offset,
+							    list->mux_shift, list->mux_width,
+							    ctx->reg_base + list->div_offset,
+							    list->div_shift, list->div_width,
+							    list->div_flags,
+							    &ctx->lock);
+			break;
 		case branch_half_divider:
 			clk = rockchip_clk_register_halfdiv(list->name,
 				list->parent_names, list->num_parents,
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 72b36bba31523..dce4db3f67b04 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -781,6 +781,13 @@ struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
 					 int ddr_flags, void __iomem *reg_base,
 					 spinlock_t *lock);
 
+struct clk *rockchip_clk_register_frac_v2(struct device *dev,
+					  const char *name, const char *parent_name,
+					  unsigned long flags, void __iomem *reg,
+					  u8 mshift, u8 width,
+					  void __iomem *high_reg, u8 high_mshift, u8 high_width,
+					  u8 clk_divider_flags, spinlock_t *lock);
+
 #define ROCKCHIP_INVERTER_HIWORD_MASK	BIT(0)
 
 struct clk *rockchip_clk_register_inverter(const char *name,
@@ -806,6 +813,7 @@ enum rockchip_clk_branch_type {
 	branch_grf_mux,
 	branch_divider,
 	branch_fraction_divider,
+	branch_fraction_divider_v2,
 	branch_gate,
 	branch_grf_gate,
 	branch_linked_gate,
@@ -1014,6 +1022,23 @@ struct rockchip_clk_branch {
 		.child		= ch,				\
 	}
 
+#define COMPOSITE_FRAC_V2(_id, cname, pname, f, mo, ms, mw, do, ds, dw, df)\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_fraction_divider_v2,	\
+		.name		= cname,			\
+		.parent_names	= (const char *[]){ pname },	\
+		.num_parents	= 1,				\
+		.flags		= f,				\
+		.muxdiv_offset	= mo,				\
+		.mux_shift	= ms,				\
+		.mux_width	= mw,				\
+		.div_offset	= do,				\
+		.div_shift	= ds,				\
+		.div_width	= dw,				\
+		.div_flags	= df,				\
+	}
+
 #define COMPOSITE_FRACMUX_NOGATE(_id, cname, pname, f, mo, df, ch) \
 	{							\
 		.id		= _id,				\

-- 
2.34.1


