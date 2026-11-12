Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501227;
	b=GFYTGEdD3KDy1EfJym2LCj938BW2V4Fnu3h4pGxwyMDg0/dwSbtWB4fGMaksAxFgPRG4
	 /suAUjcW9iK/S99l1Eo8FfyqaNU8eA5awvZwkaoruRXokfOC5iYnDn9w7f2Yss5wstdGF
	 VzwDYMIDPjjAQn9nDBrwuyaRCMBv4K1X8BDpE07jYX3P3EQaAwgcuAxIW6JmjODx/lQP0
	 L+8jb59YHfBM+vcWquE4HfSXefJM+V3++XqXPL+8zprKPJTGLTIU+kAbxptOZE1kYzEVs
	 sFbA95tKM8agJmN1Rxo2hL76awqhEcjTKhcTbwcGuDyVZKNtr3umwaJt3oe4rAixiKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Fq2Tsxhf5rFExqtMe5i2fmiOO7MCidBfvMh2Y6TVSf4=;
	b=ZrSHOQjA6LW1CClbXBFZ3DFmZ76GWfis2HCZL1JtGtKwnCEN26luVU5NHyU/PCbzAeKS
	 SnsM57YJI6pLKrp9EwGEUvlpDkl5adt6Wd4TI5JodWr3dGsaf6HVK4aF25h/lMvqNbB4x
	 3eeGFtcBWQwE+tB79Tlb7sP4toOQkIsImup+eTGzSWAfox32lUaxJxc/im62BlMY8xAV7
	 4R68la2KuaT16rxZOKG6KsEXcQHE69EJPIsALpOgeOLwBkCLJPhazCuDTThKZbpPEiRDt
	 unJTfp7a7VQ5hyeJNP0hHRwlCAID26CJ21lBDgeLTtaRZQYvRmKamwz4lQrfQsxvzTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gbxi3VQ6;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7179606AB03
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7179606AB03
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gbxi3VQ6
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-37198ed3727so1339560eec.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794501226; x=1795106026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fq2Tsxhf5rFExqtMe5i2fmiOO7MCidBfvMh2Y6TVSf4=;
        b=Gbxi3VQ6FZ4SKA8SpkY+K+CI/ecuWylsppICb+x8IPsxjVU/Hmbl+EXZdNBHoVdA31
         IWXVcAJT5Kar6Ymq21q9MyjUeqDq9dkUIS3agnXxAhujjtYt2p6QF+hoWiFi7+epcJss
         ej0SvU3DyZd3hsjtjd/S4xMxqfmBS2oztn7Lsz4PQ/yxRzFRNG37KNPCSVMhv8s7ir8j
         bXfbI+x2u64n56WsUVv7eU69fv8vfnAn1EOrppcnYK4yeDsMLS4vzb7JskBHn/OtyJf9
         gqCqFUmOgqcfIW+ioD+KuSukPQrdUsJlBvA4CqGZASxMD0tkzVDQuBSG67gkRBqSRtlt
         mBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501226; x=1795106026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fq2Tsxhf5rFExqtMe5i2fmiOO7MCidBfvMh2Y6TVSf4=;
        b=mSMMvHKol7Wng6W04X/4RLVDz+a7rbj1m9kfmJfjQchE4KkjYuH21gFhJMn+wYhDJB
         riaNRecuoQ3FVBWAbh2dvsYeQSZeITTu4co3vowpejvuKeTCil9JubqK7d8VSR+wnpgI
         HCJPUTa2Vv/nSXXM4w3QeprbKMGog5QSRBG8uap5RpNYPD/EtWywIrHNc4MMmVgbxCB0
         E6uvVTuIpQhNb5u7b21X9YQ84BCD1WX0liXQTjrq7uTX036jJJmnMXIk3CDKtNc9tlDV
         LeB/FFSbtwp6AKTFeqhcOuEcfQtZP/3j+CMpb0MCSnVQQAliBWCkF3V6WNStHpnW/aA5
         ndQw==
X-Gm-Message-State: APuU4Z9sdTtmRNbfyiXG38MJJgokPowzxbPy6IESBgj22Zb4GH096ydQ
	cgmjZWldyTZN02Oad3iMByp+HqUKBlXEfLqBiLlnORsujXjierSIHjN6KEE9CAd0
X-Gm-Gg: AYBFou2cn4HfUN8NutPG14alBqPF/NQX/QQbHrfi23yui99ylw/IzKT44qGKMVg9Y8i
	XnzEUyRJo65Nv9L2uT0KjzdsamC49x73HZx68MWoTOK0VH4hftPfDnBEt0sOy+TRBAf+4whLo9Z
	GeBTbW9aPBZi36kVE9NVnxxGzkkrw9M9v7/HPKP0KfnPFN071UUTa9t2d2uFjRzOPJf8dUhigpf
	Wlj8hyLNb9hI+csReD7ZmMZVvG9Ea20sybX0LsuPA8+P7eYDoiK/6qGax9jfClkUiBP0D21VZLf
	1U/RWgb1InLpXP9SElmvkBEq3WNb9CooERgezfwkHv7u8IzIpNZJiou8MmFwesZmW6X7y8aphkc
	Jf6DsFT5fhsjVtSxsCLwqlcK7gr8GWK/QWZ95G2fa4oJUEuzYEByZLovc1PFOOuB6LRatNJ4hyd
	wY/oBjjXLGmb6OEBRhHGxgQjYWGKIYXW/BfQxFAhgcfdbuT3Gai/V3+wgZAVlxNgOEOU7rO5x2S
	fjgq6SW+G4b1Q3AOqq47MR2lLtt3STwacDwp7S/cbMK0hCta+vSscmq6onNBbLQTPrYKYvE+49O
	GUGg5qEbj/MebwFtkyfaT+P3HMoqth8yoKXi5q4N2rRYr+obMvtEDFpXV7j0UNGStCT125lr4n2
	gnSfHEtwYaVHl/CTZ7Tx9iS/V/6WGz4ANTOtDXZl8nblTThEq21jx//mRTKfXYYjEIc7PPaM9
X-Received: by 2002:a05:701b:4294:10b0:1b3:b3d5:566f with SMTP id a92af1059eb24-1b5030990dbmr88896c88.11.1794501225666;
        Thu, 12 Nov 2026 08:33:45 -0800 (PST)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50300e5dcsm230248c88.0.2026.11.12.08.33.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 08:33:45 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 2/3] i2c: xiic: add KUnit coverage for register access modes
Date: Thu, 12 Nov 2026 08:33:31 -0800
Message-ID: <20261112163333.12523-3-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112163333.12523-1-ahmadexp@gmail.com>
References: <20261112163333.12523-1-ahmadexp@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise the driver's private register accessors with memory-backed
registers instead of physical hardware. Cover native byte/halfword and
forced 32-bit accesses in both register byte orders, across 22 register
offsets. Check payload truncation, high-bit values and neighboring
sentinels. These tests do not validate physical bus transaction widths
or hardware interrupt behavior.

Include the tests in the driver translation unit so no accessors need
to become exported interfaces. Require built-in KUnit to avoid a
built-in driver depending on a modular test framework. The tests follow
the driver into either its built-in image or module.

The four parameterized cases passed in an isolated x86-64 QEMU boot
with networking disabled and no physical-device passthrough.

Tool-origin disclosure, as required by generated-content.rst: Codex was
used to implement this test suite, run the KUnit build/boot and draft
this changelog, in response to a request for upstream-quality testing.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 MAINTAINERS                               |  1 +
 drivers/i2c/busses/Kconfig                | 14 ++++
 drivers/i2c/busses/i2c-xiic.c             |  4 +
 drivers/i2c/busses/tests/i2c_xiic_kunit.c | 91 +++++++++++++++++++++++
 4 files changed, 110 insertions(+)
 create mode 100644 drivers/i2c/busses/tests/i2c_xiic_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 893b0670a..64fa74c40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4018,6 +4018,7 @@ F:	drivers/cpuidle/cpuidle-zynq.c
 F:	drivers/edac/synopsys_edac.c
 F:	drivers/i2c/busses/i2c-cadence.c
 F:	drivers/i2c/busses/i2c-xiic.c
+F:	drivers/i2c/busses/tests/i2c_xiic_kunit.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
 N:	zynq
 N:	xilinx
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 275aaa7f3..014281fa2 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1322,6 +1322,20 @@ config I2C_XILINX
 	  This driver can also be built as a module.  If so, the module
 	  will be called xilinx_i2c.
 
+config I2C_XILINX_KUNIT_TEST
+	bool "KUnit tests for Xilinx I2C register accesses" if !KUNIT_ALL_TESTS
+	depends on I2C_XILINX && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Test the Xilinx I2C driver's register accessors with both byte orders
+	  and with native-width or forced 32-bit accesses. KUnit is a kernel
+	  unit testing framework. These tests use memory-backed registers and
+	  do not require an I2C controller.
+
+	  The tests are compiled into the driver to exercise its private
+	  accessors, and follow the driver's built-in or module configuration.
+	  If unsure, say N.
+
 config I2C_XLP9XX
 	tristate "Cavium ThunderX2 I2C support"
 	depends on ARCH_THUNDER2 || COMPILE_TEST
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 8425a540f..6c0f04aaa 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1650,3 +1650,7 @@ MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("info@mocean-labs.com");
 MODULE_DESCRIPTION("Xilinx I2C bus driver");
 MODULE_LICENSE("GPL v2");
+
+#if IS_ENABLED(CONFIG_I2C_XILINX_KUNIT_TEST)
+#include "tests/i2c_xiic_kunit.c"
+#endif
diff --git a/drivers/i2c/busses/tests/i2c_xiic_kunit.c b/drivers/i2c/busses/tests/i2c_xiic_kunit.c
new file mode 100644
index 000000000..b4c818d8b
--- /dev/null
+++ b/drivers/i2c/busses/tests/i2c_xiic_kunit.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Included by i2c-xiic.c to exercise the driver's private accessors. */
+#include <kunit/test.h>
+
+struct xiic_access_param {
+	const char *name;
+	enum xiic_endian endianness;
+	bool force_32bit_access;
+};
+
+static const struct xiic_access_param xiic_access_params[] = {
+	{ "native_little_endian", LITTLE, false },
+	{ "native_big_endian", BIG, false },
+	{ "word_little_endian", LITTLE, true },
+	{ "word_big_endian", BIG, true },
+};
+
+KUNIT_ARRAY_PARAM_DESC(xiic_access, xiic_access_params, name);
+
+static void xiic_register_access(struct kunit *test)
+{
+	static const int offsets[] = {
+		XIIC_DGIER_OFFSET, XIIC_IISR_OFFSET, XIIC_IIER_OFFSET,
+		XIIC_RESETR_OFFSET, XIIC_CR_REG_OFFSET, XIIC_SR_REG_OFFSET,
+		XIIC_DTR_REG_OFFSET, XIIC_DRR_REG_OFFSET, XIIC_ADR_REG_OFFSET,
+		XIIC_TFO_REG_OFFSET, XIIC_RFO_REG_OFFSET, XIIC_TBA_REG_OFFSET,
+		XIIC_RFD_REG_OFFSET, XIIC_GPO_REG_OFFSET,
+		XIIC_TSUSTA_REG_OFFSET, XIIC_TSUSTO_REG_OFFSET,
+		XIIC_THDSTA_REG_OFFSET,
+		XIIC_TSUDAT_REG_OFFSET, XIIC_TBUF_REG_OFFSET,
+		XIIC_THIGH_REG_OFFSET, XIIC_TLOW_REG_OFFSET,
+		XIIC_THDDAT_REG_OFFSET,
+	};
+	const struct xiic_access_param *param = test->param_value;
+	struct xiic_i2c *i2c;
+	u32 expected;
+	u8 *mem;
+	size_t i;
+	int reg;
+
+	i2c = kunit_kzalloc(test, sizeof(*i2c), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, i2c);
+	mem = kunit_kmalloc(test, 0x200, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mem);
+	/* Aligned RAM stands in for MMIO. No hardware is accessed. */
+	i2c->base = (void __force __iomem *)(mem + sizeof(u32));
+	i2c->endianness = param->endianness;
+	i2c->force_32bit_access = param->force_32bit_access;
+
+	for (i = 0; i < ARRAY_SIZE(offsets); i++) {
+		reg = offsets[i];
+		memset(mem, 0xa5, 0x200);
+
+		xiic_setreg8(i2c, reg, 0xc0);
+		expected = param->force_32bit_access ? 0xc0 : 0xa5a5a5c0;
+		KUNIT_EXPECT_EQ(test, (u32)xiic_getreg32(i2c, reg), expected);
+		KUNIT_EXPECT_EQ(test, xiic_getreg8(i2c, reg), (u8)0xc0);
+
+		xiic_setreg16(i2c, reg, 0x03ff);
+		expected = param->force_32bit_access ? 0x03ff : 0xa5a503ff;
+		KUNIT_EXPECT_EQ(test, (u32)xiic_getreg32(i2c, reg), expected);
+		KUNIT_EXPECT_EQ(test, xiic_getreg8(i2c, reg), (u8)0xff);
+
+		xiic_setreg32(i2c, reg, 0x12345678);
+		KUNIT_EXPECT_EQ(test, (u32)xiic_getreg32(i2c, reg),
+				0x12345678U);
+		KUNIT_EXPECT_EQ(test, xiic_getreg8(i2c, reg), (u8)0x78);
+		KUNIT_EXPECT_EQ(test, mem[reg + sizeof(u32)],
+				(u8)(param->endianness == BIG ? 0x12 : 0x78));
+		KUNIT_EXPECT_EQ(test, mem[reg + sizeof(u32) + 3],
+				(u8)(param->endianness == BIG ? 0x78 : 0x12));
+		xiic_setreg32(i2c, reg, 0x89abcdefU);
+		KUNIT_EXPECT_EQ(test, (u32)xiic_getreg32(i2c, reg),
+				0x89abcdefU);
+		KUNIT_EXPECT_EQ(test, xiic_getreg8(i2c, reg), (u8)0xef);
+		KUNIT_EXPECT_EQ(test, mem[reg + sizeof(u32) - 1], (u8)0xa5);
+		KUNIT_EXPECT_EQ(test, mem[reg + 2 * sizeof(u32)], (u8)0xa5);
+	}
+}
+
+static struct kunit_case xiic_access_test_cases[] = {
+	KUNIT_CASE_PARAM(xiic_register_access, xiic_access_gen_params),
+	{}
+};
+
+static struct kunit_suite xiic_access_test_suite = {
+	.name = "i2c_xiic",
+	.test_cases = xiic_access_test_cases,
+};
+
+kunit_test_suite(xiic_access_test_suite);
