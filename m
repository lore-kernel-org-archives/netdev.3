Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6B6372046;
	Mon,  3 Aug 2026 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750775; cv=none; b=QjJNXDVpAKMs9fKg7vHNrzo+UEFR5sdeJfNJyNfa1QiSwGvnqt+jAVdnnM5ArMlHE0lh4jKRMP/zpuKbsdVM6/dbsQj9o181sLo2Lnj1oXU01U5PTHwfQRH4i2mXTa4fFK6G5fNZesFKor7W0Ib61UM0M/qUxLcthkUw5giStso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750775; c=relaxed/simple;
	bh=cSrYqjbfzb5Rd3cbGL+m0q3WkekwZBgDC0HrHX0YklY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKFKQyyIqt5p9BpFiaYp74UNv4E8hy9i1b838Nc+p8eu1sX+7bQPopmoerH0r6Zz+8eDwlTa3ZOlZcT15rKpagQEPChaHuA7u00EjDhJkGFLdbCg9Wba/HazllC9M72sYfHQn2heenAr/B/N4SNNxWBJaQ5Q6OspJUCZPFA8DDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=izRu5izQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mRAOynRC; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="izRu5izQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mRAOynRC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C9037EC00CA;
	Mon,  3 Aug 2026 05:52:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 03 Aug 2026 05:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785750772;
	 x=1785837172; bh=Y9NMGgUEgcADFnguDLhrcTld3f/bP67UQewOn3U0EEE=; b=
	izRu5izQUAfL/yj2IaXlnKVPoz5P35d3yZ/vYVcueChzyMFqnSsnavYxhu3/LLMc
	JbXwQZWD+4cm2q9nN5CfsGlZtFG88sXJ01fSROFLxgQ469Kyw55heg21e4KsEwWk
	aegcObiZiRSDnosC7r+tz2QHQ1F0FlX1OFFciAFlsHr6HfwnLDsEC7bVKk9JuOik
	mUg/npVPczOXY2AClYxQOml9l9ZHmd/LnnpTjFNHUJr6YXAyaLIIBhmK+HInHkhv
	4d0nEya1LRwZx2X8Fwpo1p5ZIDEzm3YGDPXN6o+uQRJFEeAebp6M5vPCxTfxh6e0
	7QdB7wbLiYeYU8Ru6UQF+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785750772; x=
	1785837172; bh=Y9NMGgUEgcADFnguDLhrcTld3f/bP67UQewOn3U0EEE=; b=m
	RAOynRCxcsIOW1vZowOU/TjsSyS+aUoHyBSqZK2RTpJR1ApoMvjT3x++O2ciFyNS
	h0nJzB+pOxJYj7dp4PG3VECFtwjns+eiwtapgIdf2ZD5NFeez6Xnp4ZGQb7fxA6n
	op4m5b9Imp8jMElv9vqdCYTfqbuU0YEZGX9We3eGveg4OtSa4iAA7ww5duG1r7+g
	5gWs6WwPsNRfWKQKnJYZ4Iitt+8royi8Elhq5ZHMpzb6se+P46f/HGR71fmix7bc
	z5Lf51xK6I7e86p67TPZvZl4xMfdLbh6hGJGgHWEmMHtStW5NNvyjifq5OapyeN7
	QwwOa5r5O3BWRIuhZYiKA==
X-ME-Sender: <xms:9GRwamJWh49rUcn-r6ILKryChrsqZxG3XWNbcZlKVpqM7-VpHp3Uhw>
    <xme:9GRwaqedFQDp9ewbNz3IxaC_8wdDco4PxyHixm4zOloYe-pQNsc3-QKzyFMq5AG7Z
    kjZz6o_iuRWfawSjq7AQzqqaKPnmkQSCqSFmn611oVizb96TtQj4Mms>
X-ME-Received: <xmr:9GRwaoXMwVb8xVeLIHloaqAe6t49bRKnLSDDkA2KkxYnznJr-ZMIklymcwjjqdv50-uO3r9590jw8OeWL_AIJ3FUl53WkYc>
X-ME-Proxy-Cause: dmFkZTGaw2MGFH1ODEzDSV7dl184Z6QAfIVegXYtNYr963CDtgLgyB05+35lhv3YdYSKYU
    IHw2UQe3VxMvsWZvaKOEjyWLCQEKT8NsqdDh08tQAfOQIrPWaaXT0CeDd0nKMVKOT80FSu
    UPEqkMCAE9s/QSnFvu3ZS/JeI4QEATCw5nwIjvx4oJziPmZi6BW4D4q3UQXzTmH6yBBQOQ
    h8IEpQnejeV+GpT/NAIkU4l8mISC0TdnLSXqUuStwq50Rzt+8wApMGWppeADSPXgRSsFmk
    ImrK9LEsyNDTOb+19GQcAO6irFncRSPaGoUA1OBm4lZ8j8ftwj0T5xnvZsscO3AKOKMijR
    U17P8odQv07qke2fQ6oYBwou7cQCDWHIXS/Wv6TUdGvBLyKaqfen8yEIXN+tiNKQED1zFV
    YGMXnF2PnAGUYjiA4sLFveoLbQD5QicdJCIClC3Pqmw4rBWgxg8hZKNFxuLRTwTGZSkuUC
    gp1YX43xdCfGz/xMUi026BMhJIaYpSJKplqL7SvqRoTb1n+G9BY8OB5JX+el/1jkpHXwGj
    6/pBpTB90K23XNs+wiWB6WhiXI6ZI05TJywxglqr4r9TVR7UKOUEufo+lMcYQlbZT/aLCn
    2zOsosGQBCIDusbyLiBYSfAS9a7R04wI24SLAOJUDfkssnd+9/JwO4M35IfQ
X-ME-Proxy: <xmx:9GRwaohRJDgWl5MJLcNDWPelQJblqWADU4CAhw97hHqfdJSgQZVq4w>
    <xmx:9GRwaiiD-GSdMt2cEbuBYbTpDO6XeIwqO3RigImZXQMuUcapNIowag>
    <xmx:9GRwatugK_9fbI1FYUN9poG5LsHGOdXVE8ZLiFAcIHjENm346giRWg>
    <xmx:9GRwagvyuxj8p1e2JCHJdBETBbFBmejLarvBwwWuVUccFhgvI09rTw>
    <xmx:9GRwaiLV5wcZn6C7S4lOSrrnUAjhJAS86CJcgboqcOgZSbUXjtvp0Fsh>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 05:52:52 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v6 2/3] ptp: Add driver for R-Car Gen4
Date: Mon,  3 Aug 2026 11:52:31 +0200
Message-ID: <20260803095232.3527111-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803095232.3527111-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260803095232.3527111-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add driver for the gPTP timer found on R-Car Gen4 devices. The timer is
system-wide and shared by different Ethernet devices on each Gen4
platform. The operation of the timer is however not completely in
depended of the systems Ethernet devices.

  - On R-Car S4 is gated by the RSWITCH Ethernet module clock.

  - On R-Car V4H is gated by the RTSN Ethernet module clock.

  - On R-Car V4M is gated by its own module clock, the system have
    neither RTSN or RSWITCH device. But the module clock is the same as
    RTSN on V4H and the documentation referees to it as tsn (EtherTSN).

The gPTP device do have its own register space on all three platforms.
But on S4 and V4H it will share its clock and reset property with
RSWITCH or RTSN, respectively.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
* Changes since v5
- Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync().

* Changes since v4
- Drop mod_devicetable.h include.
- Remove clap of register value as .max_adj prevents any overflow.

* Changes since v3
- Clamp increment calculated to register limitations.
- Check return value of clk_get_rate().
- Disable PM if ptp_clock_register() fails.
---
 MAINTAINERS                 |   1 +
 drivers/ptp/Kconfig         |  12 ++
 drivers/ptp/Makefile        |   1 +
 drivers/ptp/ptp_rcar_gen4.c | 225 ++++++++++++++++++++++++++++++++++++
 4 files changed, 239 insertions(+)
 create mode 100644 drivers/ptp/ptp_rcar_gen4.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ba83c5792c8c..7b95b4ca41c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22946,6 +22946,7 @@ M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
 L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/ptp/renesas,rcar-gen4-gptp.yaml
+F:	drivers/ptp/ptp_rcar_gen4.c
 
 RENESAS R-CAR GYROADC DRIVER
 M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index b93640ca08b7..3593fd9da92a 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -263,4 +263,16 @@ config PTP_NETC_V4_TIMER
 	  synchronization. It also supports periodic output signal (e.g. PPS)
 	  and external trigger timestamping.
 
+config PTP_RCAR_GEN4
+	tristate "Renesas R-Car Gen4 PTP Driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on PTP_1588_CLOCK
+	help
+	  This driver adds support for using the Renesas R-Car Gen4 gPTP timer
+	  as a PTP clock, the clock can then be used by Gen4 Ethernet drivers
+	  for PTP time synchronization.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_rcar_gen4.
+
 endmenu
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index bdc47e284f14..0464a586bed2 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
 obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
 obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
 obj-$(CONFIG_PTP_NETC_V4_TIMER)		+= ptp_netc.o
+obj-$(CONFIG_PTP_RCAR_GEN4)		+= ptp_rcar_gen4.o
diff --git a/drivers/ptp/ptp_rcar_gen4.c b/drivers/ptp/ptp_rcar_gen4.c
new file mode 100644
index 000000000000..e82b6c5abc30
--- /dev/null
+++ b/drivers/ptp/ptp_rcar_gen4.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Renesas R-Car Gen4 gPTP device driver
+ *
+ * Copyright (C) 2026 Renesas Electronics Corporation
+ * Copyright (C) 2026 Niklas Söderlund <niklas.soderlund@ragnatech.se>
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/types.h>
+
+#define PTPTMEC_REG		0x0010
+#define PTPTMDC_REG		0x0014
+#define PTPTIVC0_REG		0x0020
+#define PTPTOVC00_REG		0x0030
+#define PTPTOVC10_REG		0x0034
+#define PTPTOVC20_REG		0x0038
+#define PTPGPTPTM00_REG		0x0050
+#define PTPGPTPTM10_REG		0x0054
+#define PTPGPTPTM20_REG		0x0058
+
+struct ptp_rcar_gen4_priv {
+	void __iomem *base;
+	struct clk *clk;
+
+	struct ptp_clock *clock;
+	struct ptp_clock_info info;
+
+	spinlock_t lock;	/* Registers access. */
+	s64 default_addend;
+};
+
+#define ptp_to_priv(ptp) container_of(ptp, struct ptp_rcar_gen4_priv, info)
+
+static int ptp_rcar_gen4_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
+	s64 addend = priv->default_addend;
+	bool neg_adj = scaled_ppm < 0;
+	unsigned long flags;
+	s64 diff;
+
+	if (neg_adj)
+		scaled_ppm = -scaled_ppm;
+	diff = div_s64(addend * scaled_ppm_to_ppb(scaled_ppm), NSEC_PER_SEC);
+	addend = neg_adj ? addend - diff : addend + diff;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	iowrite32(addend, priv->base + PTPTIVC0_REG);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static void _ptp_rcar_gen4_gettime(struct ptp_clock_info *ptp,
+				   struct timespec64 *ts)
+{
+	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
+
+	lockdep_assert_held(&priv->lock);
+
+	ts->tv_nsec = ioread32(priv->base + PTPGPTPTM00_REG);
+	ts->tv_sec = ioread32(priv->base + PTPGPTPTM10_REG) |
+		((s64)ioread32(priv->base + PTPGPTPTM20_REG) << 32);
+}
+
+static int ptp_rcar_gen4_gettime(struct ptp_clock_info *ptp,
+				 struct timespec64 *ts)
+{
+	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	_ptp_rcar_gen4_gettime(ptp, ts);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static void _ptp_rcar_gen4_settime(struct ptp_clock_info *ptp,
+				   const struct timespec64 *ts)
+{
+	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
+
+	lockdep_assert_held(&priv->lock);
+
+	iowrite32(1, priv->base + PTPTMDC_REG);
+	iowrite32(0, priv->base + PTPTOVC20_REG);
+	iowrite32(0, priv->base + PTPTOVC10_REG);
+	iowrite32(0, priv->base + PTPTOVC00_REG);
+	iowrite32(1, priv->base + PTPTMEC_REG);
+	iowrite32(ts->tv_sec >> 32, priv->base + PTPTOVC20_REG);
+	iowrite32(ts->tv_sec, priv->base + PTPTOVC10_REG);
+	iowrite32(ts->tv_nsec, priv->base + PTPTOVC00_REG);
+}
+
+static int ptp_rcar_gen4_settime(struct ptp_clock_info *ptp,
+				 const struct timespec64 *ts)
+{
+	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	_ptp_rcar_gen4_settime(ptp, ts);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int ptp_rcar_gen4_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
+	struct timespec64 ts;
+	unsigned long flags;
+	s64 now;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	_ptp_rcar_gen4_gettime(ptp, &ts);
+	now = ktime_to_ns(timespec64_to_ktime(ts));
+	ts = ns_to_timespec64(now + delta);
+	_ptp_rcar_gen4_settime(ptp, &ts);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static struct ptp_clock_info ptp_rcar_gen4_info = {
+	.owner = THIS_MODULE,
+	.name = "R-Car Gen4 gPTP",
+	.max_adj = 50000000,
+	.adjfine = ptp_rcar_gen4_adjfine,
+	.adjtime = ptp_rcar_gen4_adjtime,
+	.gettime64 = ptp_rcar_gen4_gettime,
+	.settime64 = ptp_rcar_gen4_settime,
+};
+
+static int ptp_rcar_gen4_probe(struct platform_device *pdev)
+{
+	struct ptp_rcar_gen4_priv *priv;
+	struct device *dev = &pdev->dev;
+	unsigned long rate;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	rate = clk_get_rate(priv->clk);
+	if (!rate)
+		return -ENODEV;
+
+	spin_lock_init(&priv->lock);
+
+	priv->info = ptp_rcar_gen4_info;
+
+	/* Default timer increment in ns.
+	 * bit[31:27] - integer
+	 * bit[26:0]  - decimal
+	 * increment[ns] = perid[ns] * 2^27 => (1ns * 2^27) / rate[hz]
+	 */
+
+	priv->default_addend = div_s64(1000000000LL << 27, rate);
+
+	pm_runtime_enable(dev);
+	pm_runtime_resume_and_get(dev);
+
+	iowrite32(priv->default_addend, priv->base + PTPTIVC0_REG);
+	iowrite32(1, priv->base + PTPTMEC_REG);
+
+	priv->clock = ptp_clock_register(&priv->info, dev);
+	if (IS_ERR(priv->clock)) {
+		pm_runtime_put_sync(dev);
+		pm_runtime_disable(dev);
+		return PTR_ERR(priv->clock);
+	}
+
+	return 0;
+}
+
+static void ptp_rcar_gen4_remove(struct platform_device *pdev)
+{
+	struct ptp_rcar_gen4_priv *priv = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	ptp_clock_unregister(priv->clock);
+
+	iowrite32(1, priv->base + PTPTMDC_REG);
+
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+}
+
+static const struct of_device_id ptp_rcar_gen4_of_match[] = {
+	{ .compatible = "renesas,rcar-gen4-gptp", },
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ptp_rcar_gen4_of_match);
+
+static struct platform_driver ptp_rcar_gen4_driver = {
+	.driver = {
+		.name = "ptp-rcar-gen4",
+		.of_match_table = ptp_rcar_gen4_of_match,
+	},
+	.probe    = ptp_rcar_gen4_probe,
+	.remove   = ptp_rcar_gen4_remove,
+};
+module_platform_driver(ptp_rcar_gen4_driver);
+
+MODULE_AUTHOR("Niklas Söderlund");
+MODULE_DESCRIPTION("Renesas R-Car Gen4 gPTP driver");
+MODULE_LICENSE("GPL");
-- 
2.55.0

