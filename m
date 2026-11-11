Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370758;
	b=rFoYtqLYZbyeyTUaVGHFkkZ51kmzRFQtHf/jf0DDPfxW/W5S6DkVX02ysZgkhG6uvqps
	 SElnboX5qxtaA/n7Ixhw2XblJ1G+Wo+wi5Ag9QHhs2rqIaeIzynTuExneXMUZUt+bDJxY
	 pohBBqU0qazvx+14tX+Ya2hwQjaw3DOy3zK14eM5NYPHRYAttNcu26r33b02demT1RCMO
	 VuEQCXZFA4s5dpk6he/512XKMV6IE1G+kmLiOof0I3GvRhzo2uVaTtjtdF5F0UrFtlU6X
	 fTEZWnhR103un7xZSp2VKLobC73d/0z1u8IKxHJv83ZnSTYFG0fh6zbuebrVqtgkpcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ppcz44YpOa+Rb6xSudMc3Cgx0KmX+T9PkTnsbJicNG8=;
	b=3WkeVj+Qb6mJXO6IRSZG6Ju0tMianbya3rcGbAPaGWL8+8SXi1huxGGmIpaUT0paVxl/
	 ko7oWTIPYpvTsVRJAvxVUk+SUGDW3nSXJmawL2iyBGHzN2vHpPfo+ldDTEddGvX0SphNA
	 MhwN1nl4CrwLfhpSNi2Uwa6iLD/hJ+5ZAi6PL/2RBCay4AkaPFJD3q+gIxZyN5G3v+Zfs
	 oUaKpEHmDtu3gLAFC62jVyyZ0aD9AwdEnLXkvcmFOBoKhdj4aQ4XjAp6PvnbjsjWMREz3
	 QIjxq/8HCpgqRUqz17H8gCkqskPNAe+2ddBZxnhJ/pwXbs5shkED1C24Buhw+ztK6ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dNSqWvvB;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE8460A2603
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 04:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CE8460A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dNSqWvvB
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so4785535eec.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794370757; x=1794975557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ppcz44YpOa+Rb6xSudMc3Cgx0KmX+T9PkTnsbJicNG8=;
        b=dNSqWvvB04Cd+ZZ6DWdGzYKh0mEMxbWZGmm07NNGWRiubzEQi61xrQgVqHrnJxw/gv
         7m+ZZeQuesfW6vp169N+FLN4UueNzhV/VKxMREeGbzFT0mS4x7GhYpY4HDyzj6WvvsaY
         zskQEWN+Il/PH4ACI0GyPDzM5hWGWbqCAG/QQ4812hkK85iUWPnVbE+0WcpdfQGX17v5
         3/v28z8RhRXJXoSdcELukEryz3JVm59wvLDMVKfrKEZKOUHCPUyVYQ+tzDnQcd3Hy8hU
         jrS2t7vC0sefec98hlYB1IPfwcVYXZR9sbdLsN/1Ha8ezgIBDI9lHXZRqCn0RGzmhiLr
         M/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794370757; x=1794975557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ppcz44YpOa+Rb6xSudMc3Cgx0KmX+T9PkTnsbJicNG8=;
        b=NMgY/U7kCSIfJOpAI8wkcev2FGF3hWfp8ycNgdW7UsteqvIKFpMWqmMh4qrzZhufH6
         zqUcEAEKvkv0txAypk0fEobJFFOr1qb6ZbUyTK9+KKqEdShkWYtTS7/q6ln3TRTKbuw/
         2uyhZLBrADKQ6LG77/SQ6WT2A5sJBXu3hSxVq67rsVJMwHojjOhvSkiNf3bOvKguxwYC
         PTwHeXKr5bR9qwOLUFSXF13xwaOsGILcedfK9rFgre52AwKjojurrRuc00oplPD9XjAS
         HaPoOBwubV/qJA9ysBmxm0gqVni+GOVrHEV4L8iFTCrC8mV0PtrSUKQPllgsJPEERTph
         ch7A==
X-Gm-Message-State: APuU4Z9Etj9vdLwEzg0D9To/NVnwUeNAupw6aFO9wV05kRKGFR00fyE0
	1MnxqPpDDLAvGCkT513LloHq8k3S8ve02Vx1hsENYHQmb2bGgAWddn13/CzTbgWTv/c=
X-Gm-Gg: AYBFou3cuXEobTY+xL/sUVRHwGDbGA+A3J7vh3Jyv9NQ6nL1Lgmi2W+6KcLdORpZZ4S
	N0Vzb0oDTZI3NM/et0bPptypgauhfg8RCsQJJ3TP4JUl5CgADbwhAGokGel3KJbHEFs0ciuZKBW
	YYZW9rxcasaWJ7EcXqjGdwMRTwifrm+QQfHSK4I5FrR4LOZUg2+los1wwM3lZccWA6s0uJQLiXr
	6q6X7R6XeXRLqFw97OtfliyGKd5MnnRIVcEiMjonvLS4YSEA4zvj6kS9sILsgoIOSks+/UmhpUm
	VFM7tukfw5S/ZX6SnvS+PiSOgefKlagubNkf2BB8cXIxuu5prV86/WhAwfKI2sfGnGY+lvN6Kbs
	OKwUVHTC3O1R6hQYhfZOOJYmnHnpKDFBtRXgyouz7eUARB1c/vHUK/gVP/VMF09YlH3bDMn/pf7
	SYkmT6iUHaNqb92+kSh9jO/+ajrXRj5cDpSxqtDkoSDFYhqrAWx7ud9Jqz2yn+lUEuaDrV4Q4MJ
	RvNOdUZz8h8QWXrK4Hb4RcnAG8/IijfD+tRhNnQh3dcaKul2L7tAi0AUC+dQ5VITOu8st/SixRj
	euzE01dKIV7h/FgCfQ+ZUNvkfafT/i93SKHmW9oTAqO/qIvGeM1Sj1C/D4GPSmo5xdyiNzQbG+e
	ySPJXZsZC1k5WOoDW/Vmyf3FouS+pwk4xQvir/ZBUzxSMeWFzJmGyw0lgjr6RywY3PHN3LqoY
X-Received: by 2002:a05:7300:f542:b0:376:98e7:eeae with SMTP id 5a478bee46e88-37698e7ef9dmr1582189eec.6.1794370756966;
        Tue, 10 Nov 2026 20:19:16 -0800 (PST)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060c4b6sm11820704eec.15.2026.11.10.20.19.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 20:19:16 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 2/3] i2c: xiic: add KUnit coverage for register access modes
Date: Tue, 10 Nov 2026 20:19:02 -0800
Message-ID: <20261111041904.48916-3-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111041904.48916-1-ahmadexp@gmail.com>
References: <20261111041904.48916-1-ahmadexp@gmail.com>
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
 drivers/i2c/busses/i2c-xiic.c             |  4 ++
 drivers/i2c/busses/tests/i2c_xiic_kunit.c | 88 +++++++++++++++++++++++
 4 files changed, 107 insertions(+)
 create mode 100644 drivers/i2c/busses/tests/i2c_xiic_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 76fb13c87..eb5777316 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4017,6 +4017,7 @@ F:	drivers/cpuidle/cpuidle-zynq.c
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
index d13cfb012..f2a77ca8d 100644
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
index 000000000..f8df88ca6
--- /dev/null
+++ b/drivers/i2c/busses/tests/i2c_xiic_kunit.c
@@ -0,0 +1,88 @@
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
+		XIIC_RFD_REG_OFFSET, XIIC_GPO_REG_OFFSET, XIIC_TSUSTA_REG_OFFSET,
+		XIIC_TSUSTO_REG_OFFSET, XIIC_THDSTA_REG_OFFSET,
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
+		KUNIT_EXPECT_EQ(test, (u32)xiic_getreg32(i2c, reg), 0x12345678U);
+		KUNIT_EXPECT_EQ(test, xiic_getreg8(i2c, reg), (u8)0x78);
+		KUNIT_EXPECT_EQ(test, mem[reg + sizeof(u32)],
+				(u8)(param->endianness == BIG ? 0x12 : 0x78));
+		KUNIT_EXPECT_EQ(test, mem[reg + sizeof(u32) + 3],
+				(u8)(param->endianness == BIG ? 0x78 : 0x12));
+		xiic_setreg32(i2c, reg, 0x89abcdefU);
+		KUNIT_EXPECT_EQ(test, (u32)xiic_getreg32(i2c, reg), 0x89abcdefU);
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
