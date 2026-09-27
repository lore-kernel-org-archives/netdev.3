Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF43A5421
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 05:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790486282; cv=none; b=XU4K5D+EcrqdP2VovFjhqgnl+m5tcvFshwFJd7ZmxLqngKsqJ2d0E+3+Bnmi7GcGQD2jIPHxN3rtdjJBsEvU8jtHPK44UhxUNvT/xLbWGoIv66WjU6BlXQW7EJr+Kr01ZObV3zk7IIyjycAKLiLE+w3WtyATIzz+HTqwqBFIUs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790486282; c=relaxed/simple;
	bh=Hm+Rfd07PTWP+RwHDDYycR3SR/UZFPd+pTnr9hqK9mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejUJzgbajEM8q3pzTsRfV6o7rcNTmjIt3ZH5FI1MFZX1tFHLIXxL2+P6PzTLCRnJ3pSRG4bai/nfxpOli9dzq0JFvdlkY8E4vHs7drHGoTK14inWasgX8h5OZIHsvhOGMDIbiHz3RYWkjSuv3eFCOGAWIvu9wkTG0qd0Bo/0xXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/d186Zo; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/d186Zo"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d5303884so1253187eec.3
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 22:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790486280; x=1791091080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p6CMkaUdvwoCltKp8CBb1kLGKbwHaDaQSBZtzitEc0Q=;
        b=F/d186ZoDdsRbkIlvXnEU7bIHTGnmlEVTd4ISuT7aFwQMH0qr0FsYtUVfy9WoKavxu
         9poiKo0nbZIL2ygtXF9VZqb6DsJFLQEho/t+CJAwk8F3ldxcKvmeg0OGp4KFSUaMb/7M
         7UfhHs8epwWDCP1xb6L2wmG1re0sBO3aZ5UVNxcGBjplf09B7+nOFFdCYx3X2J9ubOBM
         1l598sNewZklCm/elm6zLPIyGLzd0TDYSDjv7npO6rxjlizWvfpo34aeXPCY/7i4DHT/
         jEbysAQhnW4239XY4XYFjH7s+XCqWOEHt4aTp3BTO3HI6qtl2Po1aUWwC5zbCOi0FwDu
         OOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790486280; x=1791091080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p6CMkaUdvwoCltKp8CBb1kLGKbwHaDaQSBZtzitEc0Q=;
        b=MpWc6AatvvJ9o58Ix7aF3j6XdaM30Qq1F2cubTRPaCuig/L/5NxM6LuIir+OLPN4xV
         Y/1/u1TcpXMJVVgIRFVw7x2/tZnfzCDu2p35aqHWOjvdwINavvJPPpOfOABMhe15ARjP
         bcTipUMdYYJEsL1GB62XVLMJfs90WDGOQ8MzkJ/RZdZP/cPAEWu/1SegQY2VGcveAP+R
         ClKVz1tFJ3vgvoNfW6EHfrJZnvzq5mhbhuRZaSha8HlBraCIExH0XowM3VlzpeeRvz4K
         7hnc8Bz1kUnwmBS0aVBUYEI41qmBmjRhmgfT0AAYMg9dAU1nZ1xjSJqAy39RfCKK/D9i
         foiA==
X-Gm-Message-State: AFq9FYIub0oG/SX2+LLHCx60W4VChShpkuoCK1BvIGiTs2/9Fh2l3fBP
	MGx2HVsycE1YEt87tyL9VovNpsy3nBZWVURc3/7lVaGx+4hXak9pHFQp
X-Gm-Gg: AYBFou2VAqQHmnOzxCdcfL1V4Qa5qcZ6MjcQnhfCaGs+HD2h+jUfbW/udcF89ZwVFRl
	jVN9i5dHELaiYBjlnxpMPATeWi2bcpmAobUkx21LOoJSBMaidjIlZEYIKnXMlbQ2uQPjt90pFtM
	TZlwrNkrIf+2/6ZZH14qOhJnYTT7vlFzAZnggdFDbH4CbC3f6HjeH/5h4jNcDdfI9H8+3Tudy8g
	KXS4ExpTcMxJwUgxBu8mQYRGaCk5ES5XkhSYIA7tN4wfBFRjtLWf3GGA5m6xY7Dk/R8GlYnLbQN
	X1xZHcW03MoBJrNWwpEywoegZohFK8RiXR+ipdMj2k0jipcyWYtswOARkaijWeehk8N7HNqVd67
	EJ+DzOZLU2SN16KHWGWfQuV04ChPYH24tT9VWx8HPQW1iERIiVqJoLU2p3Pp+wPuXjYqUSLxbOK
	0GISbKc4gJ63fx3oYm1BnxtJYUossZTtyRL3noXjn85sWVe9XZPWDF19psT6YSS/beRMuryhiBm
	v3SvrmbTRBRlGipHO2DlnR3PsulonOoWfZDvbLImkhxGmgBiteWP4kS5zOqXSLti5tKFMm8jpwn
	yJLsdyQbFYdd22L7gTa3PQXdsXQ+eM6i8lG39sxV07aVD3+/zfNhzTFkH5QgrF14qXVZ0s44Bg=
	=
X-Received: by 2002:a05:7300:e01c:b0:33b:f40b:3c6e with SMTP id 5a478bee46e88-3426c9efa63mr4238786eec.0.1790486279324;
        Sat, 26 Sep 2026 22:17:59 -0700 (PDT)
Received: from FT6N242TWK ([223.181.116.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144f4eb9esm18602721eec.19.2026.09.26.22.17.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 22:17:58 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Tal Gilboa <talgi@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] lib/dim: add KUnit test for dim_calc_stats()
Date: Sun, 27 Sep 2026 10:47:43 +0530
Message-ID: <20260927051743.71460-3-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260927051743.71460-1-jain.sm@gmail.com>
References: <20260927051743.71460-1-jain.sm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a KUnit suite for the DIM library that checks the packet, byte,
event and completion rates computed by dim_calc_stats(), including
counter wraparound and windows whose byte or packet count times
USEC_PER_MSEC does not fit in 32 bits. The latter cases fail on 32-bit
architectures without the previous commit.

Assisted-by: LLM
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
---
 lib/Kconfig.debug   |  15 ++++++
 lib/dim/Makefile    |   2 +
 lib/dim/dim_kunit.c | 126 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 lib/dim/dim_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 134b15a44625..6b24a2c89b84 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2906,6 +2906,21 @@ config LIVEUPDATE_TEST
 
 	  If unsure, say N
 
+config DIMLIB_KUNIT_TEST
+	tristate "KUnit test for the DIM library" if !KUNIT_ALL_TESTS
+	depends on KUNIT && NET
+	select DIMLIB
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the KUnit test for the Dynamic Interrupt Moderation
+	  library (lib/dim/), which checks the rate statistics computed by
+	  dim_calc_stats().
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config CMDLINE_KUNIT_TEST
 	tristate "KUnit test for cmdline API" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/dim/Makefile b/lib/dim/Makefile
index 5b9bfaac7ac1..47e1c36230e4 100644
--- a/lib/dim/Makefile
+++ b/lib/dim/Makefile
@@ -5,3 +5,5 @@
 obj-$(CONFIG_DIMLIB) += dimlib.o
 
 dimlib-y := dim.o net_dim.o rdma_dim.o
+
+obj-$(CONFIG_DIMLIB_KUNIT_TEST) += dim_kunit.o
diff --git a/lib/dim/dim_kunit.c b/lib/dim/dim_kunit.c
new file mode 100644
index 000000000000..2e984f6b9fe4
--- /dev/null
+++ b/lib/dim/dim_kunit.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the Dynamic Interrupt Moderation library
+ */
+
+#include <kunit/test.h>
+#include <linux/dim.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+
+struct dim_calc_stats_case {
+	const char *name;
+	u32 delta_us;
+	u32 start_pkts, end_pkts;
+	u32 start_bytes, end_bytes;
+	u32 start_comps, end_comps;
+	int ppms, bpms, cpms;
+};
+
+static const struct dim_calc_stats_case dim_calc_stats_cases[] = {
+	{
+		.name = "small",
+		.delta_us = 1000,
+		.end_pkts = 640, .end_bytes = 640 * 1500, .end_comps = 64,
+		.ppms = 640, .bpms = 960000, .cpms = 64,
+	},
+	{
+		.name = "round_up",
+		.delta_us = 3000,
+		.end_pkts = 10, .end_bytes = 10, .end_comps = 1,
+		.ppms = 4, .bpms = 4, .cpms = 1,
+	},
+	{
+		.name = "counter_wrap",
+		.delta_us = 1000,
+		.start_pkts = 0xffffff00, .end_pkts = 0x100,
+		.start_bytes = 0xfffff000, .end_bytes = 0x1000,
+		.start_comps = 0xfffffff0, .end_comps = 0x10,
+		.ppms = 0x200, .bpms = 0x2000, .cpms = 0x20,
+	},
+	{
+		/* 30 MB in 10 ms (24 Gbit/s): nbytes * 1000 exceeds 32 bits */
+		.name = "many_bytes",
+		.delta_us = 10000,
+		.end_pkts = 20000, .end_bytes = 30000000, .end_comps = 64,
+		.ppms = 2000, .bpms = 3000000, .cpms = 7,
+	},
+	{
+		/* 4.3 MB in 16 ms (2.15 Gbit/s), just above the 32-bit limit */
+		.name = "bytes_32bit_limit",
+		.delta_us = 16000,
+		.end_pkts = 2900, .end_bytes = 4300000, .end_comps = 64,
+		.ppms = 182, .bpms = 268750, .cpms = 4,
+	},
+	{
+		/* 5 MB in 40 ms: a 1 Gbit/s link at line rate */
+		.name = "gigabit",
+		.delta_us = 40000,
+		.end_pkts = 3300, .end_bytes = 5000000, .end_comps = 64,
+		.ppms = 83, .bpms = 125000, .cpms = 2,
+	},
+	{
+		/* 5 million packets and completions in 2 s */
+		.name = "many_packets",
+		.delta_us = 2000000,
+		.end_pkts = 5000000, .end_bytes = 5000000, .end_comps = 5000000,
+		.ppms = 2500, .bpms = 2500, .cpms = 2500,
+	},
+};
+
+static void dim_calc_stats_case_desc(const struct dim_calc_stats_case *t,
+				     char *desc)
+{
+	strscpy(desc, t->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(dim_calc_stats, dim_calc_stats_cases,
+		  dim_calc_stats_case_desc);
+
+static void dim_calc_stats_test(struct kunit *test)
+{
+	const struct dim_calc_stats_case *t = test->param_value;
+	struct dim_sample start = {}, end = {};
+	struct dim_stats stats = {};
+
+	dim_update_sample_with_comps(0, t->start_pkts, t->start_bytes,
+				     t->start_comps, &start);
+	dim_update_sample_with_comps(DIM_NEVENTS, t->end_pkts, t->end_bytes,
+				     t->end_comps, &end);
+	/* dim_update_sample() stamps ktime_get(); use fixed times instead */
+	start.time = ktime_set(1000, 0);
+	end.time = ktime_add_us(start.time, t->delta_us);
+
+	KUNIT_ASSERT_TRUE(test, dim_calc_stats(&start, &end, &stats));
+	KUNIT_EXPECT_EQ(test, stats.ppms, t->ppms);
+	KUNIT_EXPECT_EQ(test, stats.bpms, t->bpms);
+	KUNIT_EXPECT_EQ(test, stats.cpms, t->cpms);
+	KUNIT_EXPECT_EQ(test, stats.epms,
+			(int)DIV_ROUND_UP(DIM_NEVENTS * USEC_PER_MSEC,
+					  t->delta_us));
+}
+
+static void dim_calc_stats_no_time_test(struct kunit *test)
+{
+	struct dim_sample sample = {};
+	struct dim_stats stats = {};
+
+	dim_update_sample_with_comps(0, 100, 1000, 10, &sample);
+	KUNIT_EXPECT_FALSE(test, dim_calc_stats(&sample, &sample, &stats));
+}
+
+static struct kunit_case dim_test_cases[] = {
+	KUNIT_CASE_PARAM(dim_calc_stats_test, dim_calc_stats_gen_params),
+	KUNIT_CASE(dim_calc_stats_no_time_test),
+	{}
+};
+
+static struct kunit_suite dim_test_suite = {
+	.name = "dim",
+	.test_cases = dim_test_cases,
+};
+
+kunit_test_suite(dim_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the DIM library");
+MODULE_LICENSE("GPL");
-- 
2.43.0

