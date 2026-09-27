Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C013F164E
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790515211; cv=none; b=fIj/UgMEbG78n69bhnZX57QdSUiELh+dghv+bfFMjc+wUeoTupQCvMN6lwuyRgb6I225uBX3bDujNgNAP0KsHlk3VTJf70PFomyt1oqMViRgWc/ZKG+72gn6Movng8itGLORDpes29yzoj4rqwa9c9D1kcH9B7nD6ax38CzTOT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790515211; c=relaxed/simple;
	bh=E6Dvz9tCqJ11l4RDgYhGOBwleWZgaLcdePtwDWTwQK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCO86q4k2LvPc01SqdasSWaWlapKy0ccF03a79q7WonsWC/QhkjFBZ21+9bG88p9ul2yOchxUyu1FVJ2B7PvhD7N0f7bs2hhbTzOomqbvAVkq0vctUg0ohzLir2CpRx9rqL86EMab+JIE3aXBF8nvYS7s2cFFAKsTf7wIQcQ0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=odf7/TJW; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odf7/TJW"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so11862205e9.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 06:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790515206; x=1791120006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IiBKKcMjz4Wfq7KTfPIyvhC/l5/TV2pe/RIx8EZztg0=;
        b=odf7/TJWkKVpGOO8rcd/16/XsEX7lPDsJ6HYNtoG4/ATDlHcQr+lHCMpZRJwOtIYE2
         rV/d0eWs+qHfckom9/XSLke6CQERKVIHavxwsCWAsckNr4uUDM4SX3Wg8tHqn+PmqFdp
         vcmmpACwjXsfVb52zmiPGDPvsv0gidrlY0+x15C1yHL0TN3fK1UJNa8Ew3JIZpQKmRz9
         ADNcODRSUfvc0OplS01YJ0UKltm31TNx61hNtdCtPbmKuPHIeFGQn2zkMX+o+FiluWwP
         HjF5ycuKHVJRD9KSFwjPe24+XEI8zFC5VuTNZHP9TQBrSFjMV81mi9xuo+Qt2DjZO8Wh
         aS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790515206; x=1791120006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IiBKKcMjz4Wfq7KTfPIyvhC/l5/TV2pe/RIx8EZztg0=;
        b=EBvQsfMukAPYDUPkXBe4oj1sXs5z1/w2SR6E1PMthLX8UcJJtKnAjGcUHTnGWHAOsy
         bGP0zJ9i0T23Z5QM4DcwdAJXGhTomLk6csq25ETPrthkalxV8Jgk91WykRUOSmZxD2wc
         UAx/iWBTO/7w5mlgS0T5qtd67mA58svKdJag6ZkbpQBDbVIK4v9IDK8/QKRoqWyM2i+L
         p6fxj4D4Cgqd0wKOYeF/DGSdRq0weA2N9BeiDHXeQ/vk9Xr/DfaKJnbW28Z644vuTbip
         6hGE25kJ7/5b956u5HQupeZUwk1jAeX9VjscpyuCSgXthXO0MrFMADa3tVh59NgUkr/+
         KMfg==
X-Forwarded-Encrypted: i=1; AKwUvBwxSjRp1NcoFhpO/DX7iyAHwzpj9L5jYh7dHqsXUn5W5NcjlqANeziVweYZ8xPwH+zJeRl0uwc=@vger.kernel.org
X-Gm-Message-State: AFuF++nf7QEF0tXLQhCRdHiMwtjdIPJZQHyhO9plqV29mnfc3+0m9NnU
	YMLErDdFlsuKLmbpqDgW/G2HZKjz/kkEMs8hP/XDT9CNSQKRRa7+6xy9
X-Gm-Gg: AYBFou1WK3BxfsGrhPVzDLCe0ulGkFRxQA5RcMwaEa/MM6WY1FOETS6piB44OekwGJk
	LRx5WyRCwCCJspENtvXfFJWnfpOKKXv+Qp+it9gPZyAkcmJzhYLGxix9+xFd7ZIQkHdaL6LFTDe
	vwhQJd/c7gIOThmENatJwRUsFu5oR4qnAe59u6g9fJU53NZu+pE8CPfjABy5m7G/uhjca2+KgV6
	Kmo9xmnvxtgTWYIb8T7r/Tg1LBwAUFvFt/AsD/92fvT3mgSjLW1ZQpr0apsD+AyLul5N9W1fbNo
	PTJ4IpWy2jWWEKWuh3A2/1sP6AHmaFAhnFG+43boAuVVUrdcd9w24ybZRoZa0obO+Mky+iHQ7ZG
	stEJxOl1KwJv2d4j3ZijNfF+V3QdF8gdRwyCc9ZcLtNeEmxWS/Xb3Jc1TBlpkPR+ewC8qYS+Rdt
	NrUJFVJl2iR1/YS7YYvAyK8ov3MrHaOtJfgfckaUJwiuRvK3ULKn3qXIRIwqIURP++4JTl48mXV
	PSip5fbadZRcnnI2wrpbMTdiFGFYNYX1UeNACw=
X-Received: by 2002:a05:600c:5488:b0:4a0:5b:7bc0 with SMTP id 5b1f17b1804b1-4a0005b7e33mr31276285e9.21.1790515206275;
        Sun, 27 Sep 2026 06:20:06 -0700 (PDT)
Received: from lima-dev.. (89-67-112-196.dynamic.play.pl. [89.67.112.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0019057cfsm73615905e9.11.2026.09.27.06.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 06:20:05 -0700 (PDT)
From: Demian Shulhan <demyansh@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Demian Shulhan <demyansh@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marco Elver <elver@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Gow <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 2/2] lib/tests: checksum: Add KUnit tests for csum_partial_copy_nocheck()
Date: Sun, 27 Sep 2026 15:17:58 +0200
Message-ID: <20260927131838.6774-3-demyansh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927131838.6774-1-demyansh@gmail.com>
References: <20260927131838.6774-1-demyansh@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing checksum KUnit suite covers csum_partial(), csum_fold(),
ip_fast_csum(), and csum_ipv6_magic(), but lacks coverage for
csum_partial_copy_nocheck().

Add tests to exercise the public csum_partial_copy_nocheck() API. The
length and misalignment sweeps are structured to reach all internal
branches of the arm64 implementation (scalar ladder, NEON switch-over,
unaligned heads/tails) without requiring arch-specific #ifdefs.

Test cases include:
- 0..64 bytes with all 16x16 src/dst misalignments.
- Threshold boundary lengths (1008..1040) and overlapping tail
  combinations (1024..1103).
- Data patterns stressing carries (all ones), zero carries, and
  byte-swap sensitivity.
- Concurrent execution from task, softirq, and hardirq contexts to
  exercise may_use_simd() fallbacks.
- Throughput benchmark against memcpy() + csum_partial() (gated by
  CONFIG_CHECKSUM_KUNIT_BENCHMARK).

Buffers are vmalloc()ed with page-aligned lengths. The source is placed
flush against the guard page to catch over-reads;
test_csum_copy_dst_guard_page() does the same for the destination.
Each call is checked against an independent naive reference checksum,
the destination is compared with the source, and canary bytes on both
sides are verified untouched.

Tested under QEMU on arm64 with CONFIG_CHECKSUM_KUNIT built-in, with
CONFIG_KASAN=y and with CONFIG_PREEMPT_RT=y (all tests pass); the file
also builds as a module (CONFIG_KUNIT=m) with gcc 13 and clang 18 at
W=1.

Signed-off-by: Demian Shulhan <demyansh@gmail.com>
---
 lib/Kconfig.debug          |  10 +
 lib/tests/checksum_kunit.c | 463 +++++++++++++++++++++++++++++++++++++
 2 files changed, 473 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 134b15a44625..c56fe16f7dd9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2736,6 +2736,16 @@ config CHECKSUM_KUNIT
 
 	  If unsure, say N.
 
+config CHECKSUM_KUNIT_BENCHMARK
+	bool "Benchmark for the checksum functions"
+	depends on CHECKSUM_KUNIT
+	help
+	  Include a benchmark of csum_partial_copy_nocheck() against
+	  memcpy() followed by csum_partial() in the checksum KUnit test
+	  suite, for a range of buffer lengths and misalignments. The
+	  throughput of both is logged as test output. Only meaningful on
+	  real hardware; not intended for production builds.
+
 config UTIL_MACROS_KUNIT
 	tristate "KUnit test util_macros.h functions at runtime" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/tests/checksum_kunit.c b/lib/tests/checksum_kunit.c
index be04aa42125c..77d9d0992203 100644
--- a/lib/tests/checksum_kunit.c
+++ b/lib/tests/checksum_kunit.c
@@ -3,8 +3,15 @@
  * Test cases csum_partial, csum_fold, ip_fast_csum, csum_ipv6_magic
  */
 
+#include <kunit/run-in-irq-context.h>
 #include <kunit/test.h>
+#include <linux/math64.h>
+#include <linux/prandom.h>
+#include <linux/preempt.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
 #include <asm/checksum.h>
+#include <net/checksum.h>
 #include <net/ip6_checksum.h>
 
 #define MAX_LEN 512
@@ -619,18 +626,474 @@ static void test_csum_ipv6_magic(struct kunit *test)
 	}
 }
 
+/*
+ * csum_partial_copy_nocheck() tests.
+ *
+ * Only the public entry point is exercised, so the tests work unchanged
+ * against every architecture's implementation and need neither arch #ifdefs
+ * nor access to non-exported internals. The fused copy+checksum is compared
+ * against a deliberately naive C reference (16-bit words accumulated into a
+ * u64, odd trailing byte zero-padded, folded at the end) that shares no code
+ * with csum_partial(). Every call is additionally checked for:
+ *   - dst == src over [0, len)
+ *   - canary bytes before dst and after dst + len untouched
+ *   - src untouched
+ *   - agreement with csum_fold(csum_partial(src, len, 0))
+ *
+ * The source is always placed so that src + len sits as close as possible
+ * to the guard page that follows its vmalloc() area, flush against it
+ * whenever (src_off + len) % 16 == 0, so a single byte of over-read faults
+ * instead of going unnoticed. Over-writes are caught by the canaries and, in
+ * test_csum_copy_dst_guard_page(), by the destination's guard page.
+ *
+ * The length and misalignment sweeps are dense enough to reach every branch
+ * of the arm64 implementation through its dispatcher: the scalar path and
+ * its 16/8/4/2/1-byte tail ladder below 1024 bytes, the switch to NEON at
+ * 1024, the 1..15-byte head that aligns dst, the 32/16-byte remainder
+ * blocks and the 1..15-byte overlapping tail. The interrupt context test
+ * reaches the scalar fallback for large lengths from hardirq context, and
+ * the nested kernel-mode NEON case from softirq context.
+ */
+#define COPY_MAX_OFF		16
+#define COPY_MAX_LEN		4352
+#define COPY_BENCH_MAX_LEN	16384
+#define COPY_GUARD		128	/* canary span on each side of dst */
+#define COPY_CANARY		0xa5
+#define COPY_SEED		0x5eed
+
+static struct rnd_state copy_rng;
+/* vmalloc()ed with a page-aligned length, so each is followed by a guard page */
+static u8 *copy_src_area;
+static u8 *copy_dst_area;
+static u8 *copy_shadow;			/* expected contents of copy_src_area */
+static size_t copy_area_len;
+
+static int checksum_suite_init(struct kunit_suite *suite)
+{
+	copy_area_len = round_up(COPY_BENCH_MAX_LEN + COPY_MAX_OFF, PAGE_SIZE);
+	copy_src_area = vmalloc(copy_area_len);
+	copy_dst_area = vmalloc(copy_area_len);
+	copy_shadow = vmalloc(copy_area_len);
+	if (!copy_src_area || !copy_dst_area || !copy_shadow) {
+		vfree(copy_src_area);
+		vfree(copy_dst_area);
+		vfree(copy_shadow);
+		return -ENOMEM;
+	}
+	prandom_seed_state(&copy_rng, COPY_SEED);
+	return 0;
+}
+
+static void checksum_suite_exit(struct kunit_suite *suite)
+{
+	vfree(copy_src_area);
+	vfree(copy_dst_area);
+	vfree(copy_shadow);
+}
+
+static void copy_fill_random(void)
+{
+	prandom_bytes_state(&copy_rng, copy_src_area, copy_area_len);
+	memcpy(copy_shadow, copy_src_area, copy_area_len);
+}
+
+static void copy_fill_bytes(const u8 *pattern, int pattern_len)
+{
+	size_t i;
+
+	for (i = 0; i < copy_area_len; i++)
+		copy_src_area[i] = pattern[i % pattern_len];
+	memcpy(copy_shadow, copy_src_area, copy_area_len);
+}
+
+/*
+ * Place @len bytes in @area (of copy_area_len bytes) with misalignment @off
+ * and the end as close as possible to the trailing guard page: exactly at
+ * it when (@off + @len) % 16 == 0, otherwise within 15 bytes of it.
+ */
+static u8 *copy_place_at_end(u8 *area, int off, int len)
+{
+	u8 *end = area + copy_area_len;
+	int pad = ((unsigned long)(end - len) - off) & (COPY_MAX_OFF - 1);
+
+	return end - len - pad;
+}
+
+/* Naive reference: folded ones' complement sum, same semantics as csum_fold(). */
+static u16 ref_csum_fold(const u8 *buf, int len)
+{
+	u64 sum = 0;
+	u16 word;
+	int i;
+
+	for (i = 0; i + 1 < len; i += 2) {
+		memcpy(&word, buf + i, sizeof(word));	/* native endian */
+		sum += word;
+	}
+	if (len & 1) {
+		u8 pad[2] = { buf[len - 1], 0 };
+
+		memcpy(&word, pad, sizeof(word));	/* LE: low byte, BE: high byte */
+		sum += word;
+	}
+	while (sum >> 16)
+		sum = (sum & 0xffff) + (sum >> 16);
+
+	return ~sum & 0xffff;
+}
+
+static int first_non_canary(const u8 *p, int n)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		if (p[i] != COPY_CANARY)
+			return i;
+	return -1;
+}
+
+/*
+ * One call of csum_partial_copy_nocheck(src, dst, len) with @before canary
+ * bytes ahead of @dst and @after canary bytes behind dst + len.
+ */
+static void check_csum_copy_at(struct kunit *test, const u8 *src, u8 *dst,
+			       int len, int before, int after)
+{
+	unsigned long src_off = (unsigned long)src & (COPY_MAX_OFF - 1);
+	unsigned long dst_off = (unsigned long)dst & (COPY_MAX_OFF - 1);
+	const u8 *lo, *hi;
+	u16 expect, got;
+	int bad;
+
+	memset(dst - before, COPY_CANARY, before + len + after);
+	expect = ref_csum_fold(src, len);
+
+	got = (__force u16)csum_fold(csum_partial_copy_nocheck(src, dst, len));
+
+	KUNIT_ASSERT_EQ_MSG(test, got, expect,
+			    "checksum mismatch src_off=%lu dst_off=%lu len=%d",
+			    src_off, dst_off, len);
+	KUNIT_ASSERT_EQ_MSG(test, memcmp(src, dst, len), 0,
+			    "copied data mismatch src_off=%lu dst_off=%lu len=%d",
+			    src_off, dst_off, len);
+
+	bad = first_non_canary(dst - before, before);
+	KUNIT_ASSERT_EQ_MSG(test, bad, -1,
+			    "wrote %d bytes before dst (src_off=%lu dst_off=%lu len=%d)",
+			    before - bad, src_off, dst_off, len);
+
+	bad = first_non_canary(dst + len, after);
+	KUNIT_ASSERT_EQ_MSG(test, bad, -1,
+			    "wrote at dst+len+%d (src_off=%lu dst_off=%lu len=%d)",
+			    bad, src_off, dst_off, len);
+
+	/* Source untouched, including a margin on either side. */
+	lo = max(src - COPY_GUARD, (const u8 *)copy_src_area);
+	hi = min(src + len + COPY_GUARD, (const u8 *)copy_src_area + copy_area_len);
+	KUNIT_ASSERT_EQ_MSG(test,
+			    memcmp(lo, copy_shadow + (lo - copy_src_area), hi - lo), 0,
+			    "source buffer modified (src_off=%lu dst_off=%lu len=%d)",
+			    src_off, dst_off, len);
+
+	/* Must be interchangeable with the arch csum_partial() semantics. */
+	KUNIT_EXPECT_EQ_MSG(test, got,
+			    (__force u16)csum_fold(csum_partial(src, len, 0)),
+			    "disagrees with csum_partial() src_off=%lu dst_off=%lu len=%d",
+			    src_off, dst_off, len);
+}
+
+/* Source against its guard page, destination between canaries. */
+static void check_csum_copy(struct kunit *test, int src_off, int dst_off,
+			    int len)
+{
+	KUNIT_ASSERT_TRUE(test, src_off >= 0 && src_off < COPY_MAX_OFF);
+	KUNIT_ASSERT_TRUE(test, dst_off >= 0 && dst_off < COPY_MAX_OFF);
+	KUNIT_ASSERT_TRUE(test, len >= 0 && len <= COPY_MAX_LEN);
+
+	check_csum_copy_at(test, copy_place_at_end(copy_src_area, src_off, len),
+			   copy_dst_area + COPY_GUARD + dst_off, len,
+			   COPY_GUARD, COPY_GUARD);
+}
+
+/*
+ * Source misalignments used by the longer sweeps. Destination misalignment
+ * is what an implementation's head handling depends on, so those sweeps
+ * still cover all 16 of them.
+ */
+static const int copy_src_offs[] = { 0, 1, 3, 8, 15 };
+
+/* Every len 0..64 with every src/dst misalignment: the scalar tail ladder. */
+static void test_csum_copy_small_all_alignments(struct kunit *test)
+{
+	int len, src_off, dst_off;
+
+	copy_fill_random();
+	for (len = 0; len <= 64; len++)
+		for (src_off = 0; src_off < COPY_MAX_OFF; src_off++)
+			for (dst_off = 0; dst_off < COPY_MAX_OFF; dst_off++)
+				check_csum_copy(test, src_off, dst_off, len);
+}
+
+/* Lengths straddling the arm64 scalar/NEON switch-over at 1024. */
+static void test_csum_copy_around_1024(struct kunit *test)
+{
+	int len, i, dst_off;
+
+	copy_fill_random();
+	for (len = 1024 - 16; len <= 1024 + 16; len++)
+		for (i = 0; i < ARRAY_SIZE(copy_src_offs); i++)
+			for (dst_off = 0; dst_off < COPY_MAX_OFF; dst_off++)
+				check_csum_copy(test, copy_src_offs[i], dst_off,
+						len);
+}
+
+/*
+ * Large buffers with unaligned src and dst. dst_off drives the 16-byte head
+ * (odd and even heads), len drives the 32/16-byte remainder blocks and the
+ * 1..15-byte overlapping tail: 1024..1103 covers every combination.
+ */
+static void test_csum_copy_large_unaligned(struct kunit *test)
+{
+	static const int extra_lens[] = {
+		1500, 2033, 2034, 2035, 2039, 2040, 2041, 2047, 2048, 2049,
+		2055, 2056, 2057, 2062, 2063, 3072, 4095, 4096, 4097, 4352,
+	};
+	int len, i, j, dst_off;
+
+	copy_fill_random();
+	for (len = 1024; len < 1024 + 80; len++)
+		for (i = 0; i < ARRAY_SIZE(copy_src_offs); i++)
+			for (dst_off = 0; dst_off < COPY_MAX_OFF; dst_off++)
+				check_csum_copy(test, copy_src_offs[i], dst_off,
+						len);
+
+	for (j = 0; j < ARRAY_SIZE(extra_lens); j++)
+		for (i = 0; i < ARRAY_SIZE(copy_src_offs); i++)
+			for (dst_off = 0; dst_off < COPY_MAX_OFF; dst_off++)
+				check_csum_copy(test, copy_src_offs[i], dst_off,
+						extra_lens[j]);
+}
+
+/*
+ * Data patterns that stress carries (all ones), the absence of carries,
+ * the top bit of every byte, and byte-swap sensitivity (odd-head/odd-tail
+ * fix-ups are only observable when adjacent bytes differ).
+ */
+static void test_csum_copy_patterns(struct kunit *test)
+{
+	static const u8 pat_ff[] = { 0xff };
+	static const u8 pat_00[] = { 0x00 };
+	static const u8 pat_80[] = { 0x80 };
+	static const u8 pat_ff00[] = { 0xff, 0x00 };
+	static const u8 pat_ramp[] = { 0x01, 0x02, 0x04, 0x08,
+				       0x10, 0x20, 0x40, 0x80 };
+	static const struct {
+		const u8 *pat;
+		int len;
+	} patterns[] = {
+		{ pat_ff, ARRAY_SIZE(pat_ff) },
+		{ pat_00, ARRAY_SIZE(pat_00) },
+		{ pat_80, ARRAY_SIZE(pat_80) },
+		{ pat_ff00, ARRAY_SIZE(pat_ff00) },
+		{ pat_ramp, ARRAY_SIZE(pat_ramp) },
+		{ NULL, 0 },	/* random */
+	};
+	static const int lens[] = {
+		1, 2, 3, 7, 8, 15, 16, 17, 31, 32, 33, 63, 64, 65, 127, 128,
+		255, 256, 511, 512, 1023, 1024, 1025, 1039, 1040, 1041, 1087,
+		1088, 1089, 1500, 2048, 4095, 4096, 4352,
+	};
+	static const int offs[][2] = {
+		{ 0, 0 }, { 1, 0 }, { 0, 1 }, { 1, 1 }, { 3, 7 }, { 7, 3 },
+		{ 9, 5 }, { 15, 15 },
+	};
+	int p, l, o;
+
+	for (p = 0; p < ARRAY_SIZE(patterns); p++) {
+		if (patterns[p].pat)
+			copy_fill_bytes(patterns[p].pat, patterns[p].len);
+		else
+			copy_fill_random();
+
+		for (l = 0; l < ARRAY_SIZE(lens); l++)
+			for (o = 0; o < ARRAY_SIZE(offs); o++)
+				check_csum_copy(test, offs[o][0], offs[o][1],
+						lens[l]);
+	}
+}
+
+/*
+ * Destination flush against its guard page (for (dst_off + len) % 16 == 0;
+ * within 15 bytes of it otherwise), so that over-writes fault rather than
+ * relying on the canaries. Lengths around every block size and switch-over.
+ */
+static void test_csum_copy_dst_guard_page(struct kunit *test)
+{
+	static const int lens[] = {
+		1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
+		31, 32, 33, 63, 64, 65, 79, 80, 81, 127, 128, 129, 1023, 1024,
+		1025, 1039, 1040, 1041, 1055, 1056, 1057, 1087, 1088, 1089,
+		1500, 2048, 4095, 4096, 4097,
+	};
+	int l, src_off, dst_off;
+
+	copy_fill_random();
+	for (l = 0; l < ARRAY_SIZE(lens); l++)
+		for (dst_off = 0; dst_off < COPY_MAX_OFF; dst_off++) {
+			src_off = (dst_off * 7 + lens[l]) & (COPY_MAX_OFF - 1);
+			check_csum_copy_at(test,
+					   copy_place_at_end(copy_src_area,
+							     src_off, lens[l]),
+					   copy_place_at_end(copy_dst_area,
+							     dst_off, lens[l]),
+					   lens[l], COPY_GUARD, 0);
+		}
+}
+
+/* len == 0: return 0 and touch nothing. */
+static void test_csum_copy_zero_len(struct kunit *test)
+{
+	u8 *dst = copy_dst_area + COPY_GUARD;
+
+	copy_fill_random();
+	memset(copy_dst_area, COPY_CANARY, 2 * COPY_GUARD);
+	CHECK_EQ(csum_partial_copy_nocheck(copy_src_area, dst, 0), 0);
+	CHECK_EQ(first_non_canary(copy_dst_area, 2 * COPY_GUARD), -1);
+}
+
+/*
+ * Interrupt context: csum_partial_copy_nocheck() is called from task,
+ * softirq and hardirq context concurrently. Each context has its own
+ * destination (so concurrent copies do not interfere) and the calls cycle
+ * through a few source messages of different lengths, including ones that
+ * an arch's SIMD path would normally handle so that the fallback path is
+ * reached from hardirq context and the nested SIMD case from softirq.
+ */
+#define COPY_IRQ_NUM_MSGS	3
+#define COPY_IRQ_NUM_CTX	3	/* task, softirq, hardirq */
+
+static const int copy_irq_lens[COPY_IRQ_NUM_MSGS] = { 100, 1500, 4097 };
+
+struct copy_irq_test_state {
+	const u8 *src[COPY_IRQ_NUM_MSGS];
+	u16 expected[COPY_IRQ_NUM_MSGS];
+	u8 *dst[COPY_IRQ_NUM_CTX];
+	atomic_t seqno;
+};
+
+static bool copy_irq_test_func(void *state_)
+{
+	struct copy_irq_test_state *state = state_;
+	u32 i = (u32)atomic_inc_return(&state->seqno) % COPY_IRQ_NUM_MSGS;
+	int ctx = in_hardirq() ? 2 : in_serving_softirq() ? 1 : 0;
+	const u8 *src = state->src[i];
+	u8 *dst = state->dst[ctx];
+	int len = copy_irq_lens[i];
+	u16 got;
+
+	got = (__force u16)csum_fold(csum_partial_copy_nocheck(src, dst, len));
+	return got == state->expected[i] && memcmp(src, dst, len) == 0;
+}
+
+static void test_csum_copy_interrupt_context(struct kunit *test)
+{
+	struct copy_irq_test_state state = { };
+	int i;
+
+	copy_fill_random();
+	for (i = 0; i < COPY_IRQ_NUM_MSGS; i++) {
+		/* Distinct, misaligned messages. */
+		state.src[i] = copy_src_area + i * (COPY_MAX_LEN + 64) + 2 * i + 1;
+		state.expected[i] = ref_csum_fold(state.src[i], copy_irq_lens[i]);
+	}
+	for (i = 0; i < COPY_IRQ_NUM_CTX; i++)
+		state.dst[i] = copy_dst_area + i * (COPY_MAX_LEN + 64) + 2 * i + 1;
+
+	kunit_run_irq_test(test, copy_irq_test_func, 100000, &state);
+}
+
+/*
+ * Throughput of csum_partial_copy_nocheck() versus the pre-existing generic
+ * form, memcpy() followed by csum_partial(), for aligned and for misaligned
+ * buffers. Only run if CONFIG_CHECKSUM_KUNIT_BENCHMARK is set.
+ */
+static void test_csum_copy_benchmark(struct kunit *test)
+{
+	static const int lens[] = {
+		16, 40, 64, 128, 256, 512, 1000, 1024, 1500, 2048, 4096, 16384,
+	};
+	static const int offs[][2] = { { 0, 0 }, { 1, 3 } };
+	int l, o, i, len, num_iters;
+	u64 t, t_fused, t_split;
+	u32 acc = 0;	/* keeps every call alive; see OPTIMIZER_HIDE_VAR() */
+
+	if (!IS_ENABLED(CONFIG_CHECKSUM_KUNIT_BENCHMARK))
+		kunit_skip(test, "not enabled");
+
+	copy_fill_random();
+
+	/* warm-up */
+	for (i = 0; i < 10000000; i += COPY_BENCH_MAX_LEN)
+		acc ^= (__force u32)csum_partial_copy_nocheck(copy_src_area,
+							      copy_dst_area,
+							      COPY_BENCH_MAX_LEN);
+	OPTIMIZER_HIDE_VAR(acc);
+
+	for (o = 0; o < ARRAY_SIZE(offs); o++) {
+		const u8 *src = copy_src_area + offs[o][0];
+		u8 *dst = copy_dst_area + offs[o][1];
+
+		for (l = 0; l < ARRAY_SIZE(lens); l++) {
+			len = lens[l];
+			num_iters = 10000000 / (len + 128);
+
+			preempt_disable();
+			t = ktime_get_ns();
+			for (i = 0; i < num_iters; i++)
+				acc ^= (__force u32)csum_partial_copy_nocheck(src, dst, len);
+			t_fused = ktime_get_ns() - t;
+			OPTIMIZER_HIDE_VAR(acc);
+
+			t = ktime_get_ns();
+			for (i = 0; i < num_iters; i++) {
+				memcpy(dst, src, len);
+				acc ^= (__force u32)csum_partial(dst, len, 0);
+			}
+			t_split = ktime_get_ns() - t;
+			OPTIMIZER_HIDE_VAR(acc);
+			preempt_enable();
+
+			kunit_info(test,
+				   "src+%d dst+%d len=%5d: csum_partial_copy_nocheck %6llu MB/s, memcpy+csum_partial %6llu MB/s\n",
+				   offs[o][0], offs[o][1], len,
+				   div64_u64((u64)len * num_iters * 1000, t_fused),
+				   div64_u64((u64)len * num_iters * 1000, t_split));
+		}
+	}
+}
+
 static struct kunit_case __refdata checksum_test_cases[] = {
 	KUNIT_CASE(test_csum_fixed_random_inputs),
 	KUNIT_CASE(test_csum_all_carry_inputs),
 	KUNIT_CASE(test_csum_no_carry_inputs),
 	KUNIT_CASE(test_ip_fast_csum),
 	KUNIT_CASE(test_csum_ipv6_magic),
+	KUNIT_CASE(test_csum_copy_small_all_alignments),
+	KUNIT_CASE(test_csum_copy_around_1024),
+	KUNIT_CASE(test_csum_copy_large_unaligned),
+	KUNIT_CASE(test_csum_copy_patterns),
+	KUNIT_CASE(test_csum_copy_dst_guard_page),
+	KUNIT_CASE(test_csum_copy_zero_len),
+	KUNIT_CASE(test_csum_copy_interrupt_context),
+	KUNIT_CASE(test_csum_copy_benchmark),
 	{}
 };
 
 static struct kunit_suite checksum_test_suite = {
 	.name = "checksum",
 	.test_cases = checksum_test_cases,
+	.suite_init = checksum_suite_init,
+	.suite_exit = checksum_suite_exit,
 };
 
 kunit_test_suites(&checksum_test_suite);
-- 
2.43.0

