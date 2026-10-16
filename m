Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E734E541E7C
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169931; cv=none; b=CLuMZG6SAdyNFz7jS6+mzzn1ri9YPDXH2qQ1z9cDV0diCi8jrycWtF4NUSQO/ZONd9y7RWdeEd3tGsX9fiezsFvo+DZH8jousGGvvJXRAwqH2NLcyCQTU6KXSm6a1HRsAugyPtzf4u7iSD0VjJujDXwBkuCIM9grQfpWA5ODQrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169931; c=relaxed/simple;
	bh=V9uL86fh+01YYVaVpVoMosSW/lM8bNdP5qvuChJlfM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ckrfGoV/XMJBqAe25l8UDNhws5sy936AIMNdl+ntgDXGW8EVBMgAc6jB+AxPB8D7oZfDPqO0mfHi2C/a9uDUeoiG79berHMMACdCBFQf4sM39YcpGOIeyVgs0haJJDzLwIkAPnhoI7robekaruO4o7HkoMzkYO6vgKF1sZJCfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2RftzPju; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2RftzPju"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 762721A1253;
	Fri, 16 Oct 2026 16:58:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 49AE06075D;
	Fri, 16 Oct 2026 16:58:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B53010328C52;
	Fri, 16 Oct 2026 18:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792169920; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=x9Rrj2JVjDaRfPgck2ssmtwiaXE9gpz16p75IAXvAZg=;
	b=2RftzPjuRvSKFViSEDpXUP+cZROxfFQ0Kc2mPMd07/PZVsZnNrTB4nWZrTP6ITLWZx0C3q
	ic+NneFB8CuPdfA6Uy6TqkqV14XR6Jvr2rHorFFTF7ADrpYxNuEyu/5A7k8LIdoqvVXmhN
	FZOLZ/feuLi2ZrcnDY8NgZ9VUSKj+o9Z7gLb24Zq+Jrdi1ZS+d8yMJvs3veKWj60lJaYb1
	+OH8w3o1d9FujqEMwRSBFaLfo1dvdqZHH6l1We67E8Hj51RtT4hc5s+10rEvIhKOtHpdpw
	15jDNblmeupKlFdhR+Xne1fnpaRMSPSiAHYfnqFAkMTzMWz5Ay3mAmHxpFjEiA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 16 Oct 2026 18:58:17 +0200
Subject: [PATCH net-next v5 3/3] net: macb: distribute evenly Tx SRAM
 segments
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261016-macb-set-channels-v5-3-90ce0c0b8e75@bootlin.com>
References: <20261016-macb-set-channels-v5-0-90ce0c0b8e75@bootlin.com>
In-Reply-To: <20261016-macb-set-channels-v5-0-90ce0c0b8e75@bootlin.com>
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, Paolo Valerio <pvalerio@redhat.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15-dev
X-Last-TLS-Session-Version: TLSv1.3

GEM has registers to configure the Tx SRAM segments distribution across
queues. The reset value is apprioriate (even spread) but we need to
care if/when number of active queues is modified (or if we inherited
unevenly initialised hardware from bootloader).

To distribute segments, we take as input the number of queues
(bp->num_queues) and the number of segments (found inside DCFG6).
Its output is a number of segments for each queue, formatted as
powers-of-two (eg 2 for queue 0 means it has 2^2=4 segments).

As the distribution logic is quite complex (at least its initial
versions had bugs), it is kunit-tested in macb_kunit.c and the
implementation lives in macb_utils.c. To test:

⟩ env --unset=CROSS_COMPILE make ARCH=um mrproper
⟩ env --unset=CROSS_COMPILE ./tools/testing/kunit/kunit.py run \
        --kconfig_add CONFIG_NET=y \
        --kconfig_add CONFIG_COMMON_CLK=y macb

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/Kconfig      | 12 +++++
 drivers/net/ethernet/cadence/Makefile     |  5 +-
 drivers/net/ethernet/cadence/macb.h       | 17 +++++++
 drivers/net/ethernet/cadence/macb_kunit.c | 78 +++++++++++++++++++++++++++++++
 drivers/net/ethernet/cadence/macb_main.c  | 19 +++++++-
 drivers/net/ethernet/cadence/macb_utils.c | 60 ++++++++++++++++++++++++
 6 files changed, 188 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/ethernet/cadence/Kconfig
index 5b2a461dfd28..a901f74fd4ab 100644
--- a/drivers/net/ethernet/cadence/Kconfig
+++ b/drivers/net/ethernet/cadence/Kconfig
@@ -51,4 +51,16 @@ config MACB_PCI
 	  To compile this driver as a module, choose M here: the module
 	  will be called macb_pci.
 
+config MACB_KUNIT_TEST
+	tristate "KUnit test for MACB" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Build KUnit tests for the MACB driver.
+
+	  For more information on KUnit and unit tests in general,
+	  please refer to the KUnit documentation.
+
+	  If unsure, say N.
+
 endif # NET_VENDOR_CADENCE
diff --git a/drivers/net/ethernet/cadence/Makefile b/drivers/net/ethernet/cadence/Makefile
index 1f33cdca9a3c..a0740da68649 100644
--- a/drivers/net/ethernet/cadence/Makefile
+++ b/drivers/net/ethernet/cadence/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for the Atmel network device drivers.
 #
-macb-y	:= macb_main.o
+macb-y	:= macb_main.o macb_utils.o
 
 ifeq ($(CONFIG_MACB_USE_HWSTAMP),y)
 macb-y	+= macb_ptp.o
@@ -10,3 +10,6 @@ endif
 
 obj-$(CONFIG_MACB) += macb.o
 obj-$(CONFIG_MACB_PCI) += macb_pci.o
+
+obj-$(CONFIG_MACB_KUNIT_TEST) += macb_test.o
+macb_test-y := macb_kunit.o macb_utils.o
diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 51835de0f2a1..60d61efbf3e4 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -194,6 +194,10 @@
 /* Screener Type 2 match registers */
 #define GEM_SCRT2		0x540
 
+/* Tx queue segment allocation */
+#define GEM_TXQSEGALLOC_LOWER	0x05A0
+#define GEM_TXQSEGALLOC_UPPER	0x05A4
+
 /* EtherType registers */
 #define GEM_ETHT		0x06E0
 
@@ -545,6 +549,8 @@
 #define GEM_PBUF_CUTTHRU_SIZE			1
 #define GEM_DAW64_OFFSET			23
 #define GEM_DAW64_SIZE				1
+#define GEM_SEGMENTS_BIT_SIZE_OFFSET		16
+#define GEM_SEGMENTS_BIT_SIZE_SIZE		3
 
 /* Bitfields in DCFG8. */
 #define GEM_T1SCR_OFFSET			24
@@ -657,6 +663,13 @@
 #define GEM_CMPCEN_OFFSET			30 /* Compare C Enable */
 #define GEM_CMPCEN_SIZE				1
 
+/* Bitfields in TXQSEGALLOC (Q0 at 2:0, Q1 at 6:4, etc.) */
+#define GEM_TXQSEGALLOC_MASK(q_) \
+	({ \
+		typeof(q_) q__ = (q_); \
+		GENMASK(4 * (q__) + 2, 4 * (q__)); \
+	})
+
 /* Bitfields in ETHT */
 #define GEM_ETHTCMP_OFFSET			0 /* EtherType compare value */
 #define GEM_ETHTCMP_SIZE			16
@@ -785,6 +798,7 @@
 #define MACB_CAPS_USRIO_HAS_MII			BIT(26)
 #define MACB_CAPS_USRIO_HAS_REFCLK_SOURCE	BIT(27)
 #define MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE	BIT(28)
+#define MACB_CAPS_TXQSEGALLOC			BIT(29)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
@@ -1511,4 +1525,7 @@ struct macb_queue_enst_config {
 	u32 off_time_bytes;
 };
 
+u32 gem_sram_distribute_segments(unsigned int num_queues,
+				 unsigned int num_segments);
+
 #endif /* _MACB_H */
diff --git a/drivers/net/ethernet/cadence/macb_kunit.c b/drivers/net/ethernet/cadence/macb_kunit.c
new file mode 100644
index 000000000000..9efafd34eeca
--- /dev/null
+++ b/drivers/net/ethernet/cadence/macb_kunit.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <kunit/test.h>
+#include <linux/netdevice.h>
+#include "macb.h"
+
+struct macb_sram_segments_case {
+	unsigned int num_queues, num_segments;
+};
+
+static void macb_sram_segments_test(struct kunit *test)
+{
+	const struct macb_sram_segments_case *p = test->param_value;
+	u32 val = gem_sram_distribute_segments(p->num_queues, p->num_segments);
+	unsigned int i, sum_segments = 0, max_assigned_segments;
+	unsigned int num_queues = min(p->num_queues, p->num_segments);
+
+	for (i = 0; i < num_queues; i++) {
+		unsigned int q_segments = field_get(GEM_TXQSEGALLOC_MASK(i),
+						    val);
+
+		q_segments = 1U << q_segments;
+		sum_segments += q_segments;
+		KUNIT_ASSERT_GT_MSG(test, q_segments, 0, "queue %d, val %#x",
+				    i, val);
+	}
+
+	for (i = num_queues; i < MACB_MAX_QUEUES; i++) {
+		unsigned int pow = field_get(GEM_TXQSEGALLOC_MASK(i), val);
+
+		KUNIT_ASSERT_EQ_MSG(test, pow, 0, "queue %d, val %#x", i, val);
+	}
+
+	max_assigned_segments = min(p->num_segments,
+				    MACB_MAX_QUEUES * num_queues);
+	KUNIT_ASSERT_EQ_MSG(test, sum_segments, max_assigned_segments,
+			    "val %#x", val);
+}
+
+struct macb_sram_segments_case macb_sram_segments_cases[] = {
+	/* num_segments can only be powers of two. */
+	{ .num_queues = 4,  .num_segments = 2 },
+	{ .num_queues = 1,  .num_segments = 16 },
+	{ .num_queues = 4,  .num_segments = 16 },
+	{ .num_queues = 5,  .num_segments = 16 },
+	{ .num_queues = 1,  .num_segments = 128 },
+	{ .num_queues = 8,  .num_segments = 128 },
+};
+
+static void macb_sram_segments_case_desc(struct macb_sram_segments_case *t,
+					 char *desc)
+{
+	u32 val = gem_sram_distribute_segments(t->num_queues, t->num_segments);
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
+		 "num_queues=%d num_segments=%d TXQSEGALLOC=%#x",
+		 t->num_queues, t->num_segments, val);
+}
+
+KUNIT_ARRAY_PARAM(macb_sram_segments,
+		  macb_sram_segments_cases,
+		  macb_sram_segments_case_desc);
+
+static struct kunit_case macb_test_cases[] = {
+	KUNIT_CASE_PARAM(macb_sram_segments_test,
+			 macb_sram_segments_gen_params),
+	{}
+};
+
+static struct kunit_suite macb_test_suite = {
+	.name = "macb",
+	.test_cases = macb_test_cases,
+};
+
+kunit_test_suite(macb_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cadence MACB/GEM Ethernet driver kunit tests");
+MODULE_AUTHOR("Théo Lebrun");
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 2d069454795b..b70b81f51161 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3163,6 +3163,20 @@ static void macb_init_hw(struct macb *bp)
 	if (bp->caps & MACB_CAPS_JUMBO)
 		bp->rx_frm_len_mask = MACB_RX_JFRMLEN_MASK;
 
+	/* Distribute Tx SRAM segments evenly based on active number of queues.
+	 * TXQSEGALLOC is only documented for some GEM integrations.
+	 */
+	if (bp->caps & MACB_CAPS_TXQSEGALLOC) {
+		unsigned int num_segments;
+		u32 val;
+
+		num_segments = 1U << GEM_BFEXT(SEGMENTS_BIT_SIZE,
+					       gem_readl(bp, DCFG6));
+		val = gem_sram_distribute_segments(bp->num_queues,
+						   num_segments);
+		gem_writel(bp, TXQSEGALLOC_LOWER, val);
+	}
+
 	macb_configure_dma(bp);
 
 	/* Enable RX partial store and forward and set watermark */
@@ -5854,6 +5868,7 @@ static const struct macb_config zynqmp_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
 		MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
+		MACB_CAPS_TXQSEGALLOC |
 		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
@@ -5906,7 +5921,7 @@ static const struct macb_config versal_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
 		MACB_CAPS_NEED_TSUCLK | MACB_CAPS_QUEUE_DISABLE |
-		MACB_CAPS_QBV |
+		MACB_CAPS_QBV | MACB_CAPS_TXQSEGALLOC |
 		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
@@ -5917,7 +5932,7 @@ static const struct macb_config versal_config = {
 static const struct macb_config eyeq5_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_QUEUE_DISABLE |
-		MACB_CAPS_NO_LSO | MACB_CAPS_EEE,
+		MACB_CAPS_NO_LSO | MACB_CAPS_EEE | MACB_CAPS_TXQSEGALLOC,
 	.dma_burst_length = 16,
 	.init = eyeq5_init,
 	.jumbo_max_len = 10240,
diff --git a/drivers/net/ethernet/cadence/macb_utils.c b/drivers/net/ethernet/cadence/macb_utils.c
new file mode 100644
index 000000000000..64ffba0c0522
--- /dev/null
+++ b/drivers/net/ethernet/cadence/macb_utils.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/netdevice.h>
+#include "macb.h"
+
+/*
+ * Distribute evenly available segments across queues. The computation is
+ * complex because (1) segments are counted in powers of two and (2) a queue
+ * can only use up to 8 segments. There are four types of cases:
+ *  - Sharing all segments equally is doable. Take num_queues=4 and
+ *    num_segments=16. Each queue will get 2^2=4 segments.
+ *  - Sharing all segments is doable. Take num_queues=5 and num_segments=16.
+ *    Three queues will get 2^2=4 segments and two will get 2^1=2 segments.
+ *  - Sharing all segments is not doable because not enough queues are
+ *    available. Take num_queues=1 and num_segments=16; queue 0 can only have 8
+ *    segments.
+ *  - Sharing all segments is not doable because not enough segments are
+ *    available. Take num_queues=4 and num_segments=2.
+ *
+ * We start by computing the power each queue will have. For num_queues=5 and
+ * num_segments=16, each queue will have at least 2^1 segments. That leaves us
+ * with remaining_segments=6. If we increase the power for a queue, we get a
+ * delta of 2 (2^2-2^1). The first three queues will therefore be advantaged
+ * and each have 2^2 segments. The remaining 2 queues will only have 2^1
+ * segments.
+ */
+u32 gem_sram_distribute_segments(unsigned int num_queues,
+				 unsigned int num_segments)
+{
+	unsigned int pow, remaining_segments, i;
+	unsigned int num_advantaged_queues = 0;
+	u32 val = 0;
+
+	/* When growing the max # of queues, make sure to return a u64 here and
+	 * to write into GEM_TXQSEGALLOC_UPPER.
+	 */
+	static_assert(MACB_MAX_QUEUES == 8);
+
+	/* pow=0 for all queues. ilog2(0) is dangerous. */
+	if (num_queues >= num_segments)
+		return 0;
+
+	pow = min_t(unsigned int, ilog2(num_segments / num_queues), 3);
+	remaining_segments = num_segments - num_queues * (1U << pow);
+
+	/* We can only distribute remaining segments if (1) there are remaining
+	 * segments and (2) we did not reach the max segments per queue (2^3).
+	 */
+	if (remaining_segments != 0 && pow != 3) {
+		unsigned int delta = (1U << (pow + 1)) - (1U << pow);
+
+		num_advantaged_queues = remaining_segments / delta;
+	}
+
+	for (i = 0; i < num_advantaged_queues; i++)
+		val |= field_prep(GEM_TXQSEGALLOC_MASK(i), pow + 1);
+	for (i = num_advantaged_queues; i < num_queues; i++)
+		val |= field_prep(GEM_TXQSEGALLOC_MASK(i), pow);
+
+	return val;
+}

-- 
2.56.0

