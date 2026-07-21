Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35783672BF;
	Tue, 21 Jul 2026 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640656; cv=none; b=ON8WlcWjGrJOxCgjywA3uAG1v0TiKhjXUMIaQwqLMp89IJukcKsfkMD9p9vftxMRd/0Hmt5SfVBZiRYyuvHZweaObUQBfucAHdeWlk1+8y/S0gnBEYX6CI+4Mccq6FgoTfdQZs+BrNnR9YuwRu9NoqRuxha/kPBhk/on8EDY2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640656; c=relaxed/simple;
	bh=TzsI65UIv2Q+dXETfAE7YMTPG9tK8D2HBUNEYZtYWC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0SZ6zRje7CShDWr5toxp38U7A5TCdbRMCPZqqWD6anEwN2mAlL4XXkb+2Jcmih9loXUrrKlHOwa0r0P25ipsLQq0NMdXMuAiWH8MtdwcS/w7Xkjo6cE1ksjsasb3lQ8C3QmcgM3e9UjeleuFsSC1oCmKCdhw6jPV/tnXAFZOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=lS7RHKOi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U5xE98AU; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="lS7RHKOi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U5xE98AU"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 129D51400138;
	Tue, 21 Jul 2026 09:30:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 21 Jul 2026 09:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784640653;
	 x=1784727053; bh=ukHffcywcgJVKCTf46tEeRaEOkSD/6rYbBN3ueUycFQ=; b=
	lS7RHKOiFaKQca23sTVQ7bLcihWhkCgJtGhFdylTaPpHhjHy6iK8ltFCGfGTlghp
	jh6eHfa9BaES+mBEngBp9XZEWB4Cu0PQaLqL5GXFk3LOlpjZUaD9cRLNB+sREht0
	z9Bk+z1l/GIm58VpJk7BlUb/9RL5CrA8evJwFjprT3b7eSGhEkBrk1S3TOlaSw4G
	YuKGHejxQHSZU66KI9L2CPPLHxB0VvOnRYpHKeyT2LxUq2kLa0m9h9eGDb+YN3eX
	/XivjJQV589PFZcAEBk8G9Zh2nOfbiehvZCXo2rLiHJfA7Nquf6hF+XRIvQIorWK
	5nufMtaVLd70btK+ExPOEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784640653; x=
	1784727053; bh=ukHffcywcgJVKCTf46tEeRaEOkSD/6rYbBN3ueUycFQ=; b=U
	5xE98AUz62OpWQK38rDZgAOaM0hUY9SLwazo9IN71UN6XJoCK34kRnwN0lwy1eZB
	Xo36g6st3+jM2OMXpU85l7VOqxdcgTfn5PESfFgBW7qea10bmrE0dRUX3+rrWL2G
	PWzOE/k5UpX9rlZMoqBkEl2RrZZM4FKa0KP6UIdtvXdwdoP/eZXbzOX0mPm2PvZx
	IgPNqJ7m+2L4ZbTnWZNIiUX5EcoNnPEyLUbLHof8DH2+T0HQ+vaD1RNsYKczlPMc
	MEv7JLuWdRYI9/DPR+vMTfRycai10kYO4LKIiLEjw1NjIEN64NmQKV6xkJ25vqG/
	f9QciwGRku6wE4m98wuiQ==
X-ME-Sender: <xms:jHRfavm2QXvFE8tXlaQZ6Lp4NZIpaPrnGjMOZyUGF7EdEX5j9scR0A>
    <xme:jHRfavJnbM57iSc2_1407yod6pWlbvDajmePVORTO2kacgrT5emTOKtPhm8TRE6Og
    Vrtadu46OxMch_UpLFKoE8b4UnPJdxtion1xZhd_TK_cdbCKn0k5ZA>
X-ME-Received: <xmr:jHRfanRQmbIvjfBbmc0Q7njBREsYNj7YGsOeAcAH7rSbImJk0QNX_76OWgTua784ZSnrfdX7kak9jkQoQsVFNnZVGoDYG7g>
X-ME-Proxy-Cause: dmFkZTEO3WiW2LIZLndKegBRYU0lkj8LPXXrU7k/eTpMP6MrtWem9XD25WSFWTvj8a4EXg
    7oDvcV+vOC3s5C4OOqoJrqtS+o4+j0lhZ8rSj7kzonTXQhMwUs0TJYkHFth4dAgSbspN1k
    9hKP3SH9NQiB+80sbUry1B0r14t/x2fF89JheM81FigP81auMM1NND24BmsGmP0B+82Dnm
    +YIXsuwgIWXyUPB7Kh9Zn1oxdduKxHoFzyut8PXlZ3YPBYeWZ+xjCaPogk5m9/bD2jWCQj
    Fqoh5JnGuPvCmpzwCPXXaIPX1pdKfxb5AWLzDcBTapyX/R1lpznCzk//xJUVNJmn8jL1ti
    2+cnC5syzB8/fuTif9yJ7mce7Y1iolhe1qgfWHEBQuu5CmCD+I2I8TyQ66pXWPCkx3/Q1I
    6ak1VAZT2nh77bvrQoRSESWTaiTOM1YCbx4JHJFSPFFgjbDoeOmQdgKvBdMTPn1LU/eDoM
    Xv2sOCm3QaZCKdGqLevsI8zWnRSidagwcFNTz5skNFUPL7fcD9hMjtQchNeBQFyTehqq2E
    Uw3oDYOE4nudkbTrzhd841JAN4X5iepnUilyslWumBYq90UrL3nI7gMfHAICjRXrBysXIR
    UFC4QbXyxyDChhkQFj+Qn8liqa92Kr036o0fTAMeEA/6EK3dpUZlrqlvjxJg
X-ME-Proxy: <xmx:jHRfaks4xNW7689XfDaBmdq-9UHeCJiiByhouEY1HGr0WFXTUCNKKg>
    <xmx:jHRfai_2JAGcqpWgFC-kT4AmGUzZXO2Tejl1IWCzfyCKNFiJ-DmQGg>
    <xmx:jHRfatbk5ImMZdi3ymfhP_cAr6r2B--4IHXmT6GwhpUo-MSTH4bPvw>
    <xmx:jHRfauplFfL83rbA558-CBqbMNR5bWithCWFVbjBSTvyVIYEyFxc8Q>
    <xmx:jXRfaq0vEIWvOafAirCdUYeqYBQJBbbIhYcliSlDic1UGcusFjM29yyx>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 09:30:51 -0400 (EDT)
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
Subject: [PATCH net-next v5 2/3] ptp: Add driver for R-Car Gen4
Date: Tue, 21 Jul 2026 15:29:35 +0200
Message-ID: <20260721132936.1331318-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721132936.1331318-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260721132936.1331318-1-niklas.soderlund+renesas@ragnatech.se>
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
---
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
index 4e1c4ed038c5..ed54ac3cf550 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22919,6 +22919,7 @@ M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
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
index 000000000000..8072d5f2b72d
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
+	pm_runtime_get_sync(dev);
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

