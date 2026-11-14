Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794629397;
	b=rRe2tjZLOvtzohZKVddfACF7BkPnxnzUnuyzR1qYMpW0Odf1uhJ9GSGnuoHT4ckz3wuG
	 7cucPPgQuxHB9vGUFNeC2VCKhFPJ51Y9EFwpO0W8a+yg3t0kzt+FbmD3brpTssNsH9rZ6
	 36IE3h1NzZZYmSHj+TorlMh/LeTd5Bwbhykn1BiniXnxtIsmYGdctBIIP6wHca4nTucjw
	 gj853IBLhskNDqHnDNEFU7JRStbH2U6VzJkK42HoYV/qeYjswcgq8U8r89sLogqHXDS+S
	 ZNhgZCM0duFQ99Qe9Q7ZnxVeCBgIuCN3hJ9HyxRSoosSTgT4QP2Z17kPPC+0hMI71+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794629397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JQ9pWmTzRU2aDakRqvN5/kHHIhXbN1ax/IQYt/5jaU0=;
	b=bkB82rMdG3cJk/mqT8wvVMVjxfTd4dvzp0F+8djw+kMDvQmMwNEzvnFoYvMJR/ri6jHA
	 F1R3nKkRQ0AEQwJQtIzBbldMcf1w1GITk2ZbPoZuSGfCgoL2+YWajhGvD3T8INPqqjWrC
	 T01IH6rWD+mfraRQaRUOIy+VI6VqZMqWgaW/L0tnjfrCk6cvw/9JyIFG0cZnk75d424Yb
	 Ae3yXdoBkHzt4ZhC7aqqmTmBknOU8JtXBz3IJzzUGeiRSIH1o78LRQcTv/sz8bsBJndbJ
	 YOBZULpa13fQvUjL3ZyFzoH2I5hBYyb2uWck8OZoH+m2L5pk82ccZ3ULWw+x+yQ+pBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qOU97C23;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3147606A33E
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 04:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3147606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qOU97C23
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-491971ac844so1728072f8f.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794629395; x=1795234195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JQ9pWmTzRU2aDakRqvN5/kHHIhXbN1ax/IQYt/5jaU0=;
        b=qOU97C23tJrVXbI/6rw5qBPMW271Ogm8mDnbk0068t8ehxGrqfWxGKPdV5iDVsEuOY
         /otzUFgB/lnVgdGGUVPn0kNvOVnlsQbKlZ7rh7aPbvtbEzroP5VjXri15H8FxA56Xtix
         rYKp0XCljVfdiY3FA/yruinXLQIz7a50DfxSktrzVNEGPps+AfUskrb2RT+NiBdatpLA
         rCli+CynfPtzhRPwTzhebhynei6uarIAhKoP0enE5TUx5EBdTKibI9wL4Us59KSaHYlF
         PyJhSXIYTZ7KCr30N32wjnV91KjB0MWIhaPCkjFO6qEzwXLNuAXnpAagtYjlmbDrPUO/
         IFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794629395; x=1795234195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JQ9pWmTzRU2aDakRqvN5/kHHIhXbN1ax/IQYt/5jaU0=;
        b=keGbacL9BG0boURDx0dWbcxficS2QZLD+izHpLnTrQNUAiM6hyHbVI3nQ4lI6c3sbU
         hj0QITC3kOMPYOxZNowFPunJ8Z5yoOcXTsC8iGfldMtr+rTkX+fyXUc4Q2EdYP0MOVvv
         h/T8FTiRvsXwfUG17IXbldpl9AK71BA79QZEwhBhShVoonrIv7B4lGFlQ9LipAAjGyJj
         Ynzn8FeaHZBiqMSeH4T0rUnEkvU8dvNtZg/f+MIsDScKr7QqQnmg8bCvGU1hZIYPS7PR
         gC4piwuxAZBmTuqW4mcHOzAfsUb8nipqJljoJ7+OXyghiLZ1tmcgqkhGwezam9pMJU2G
         DHZQ==
X-Forwarded-Encrypted: i=1; AL+hErGLZ4LntAoKrv1mZWg7dl203EvhY/F7nqKVazUWm8/58JlfjVKzWruFFjIK87jU3mAk20U9KE8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qAUFLkmtuMRNBo+Of5d/wrwe6aB9be/SIO9JRzIgHf5IUdCm6
	2mrYy2dp/QLWp3r0JzbQMpJeVxKIAn1gEZOi8+r7CkXBWS/Iz1jKa1IL
X-Gm-Gg: AYBFou0v3w4apMwMgCBOrGQmf67GsC4dtFWBUZ61ELjFI4QwjuIOJiE40Dvz91ch39z
	X3ChSy3lr7RDFnY8mn69BVniS8K6kv3uOG4KXKJ+QJqGe442CZW+3RScf8KVsGMykKk7ZYiFzfC
	CrknCTQRFd/uyZpGGVfdcjJKe1+ku6Q7I8LMtkcwiWV7nWvZNh0piKC+qj6Rix0SQrw2KnTeE18
	9eeEfzqxAiS0MdPxXP5W5aARMBWcpYTPe7U+4WfEVYNh02tJOtDka3+JddZnINIJYD1Jnd3NXVo
	QMq3dOSLzrD2VvSmj8NdPg9gXTNypj0zl5UmoMqXUx1q2P6XH3U9KDoypj7RY3YYZxxF+aSxige
	AryHJ7hYvjDZ203HTrj1arftURwCn6ae6tC0VR9i2CHK7xl28u2qJ9awVVk6U0xAAFxbfWiSlxs
	AMcGe/yPPQn3aTN4evHRc2aXNTXMJtbkYR9OEJvAFdNVyn9to+GvUIDieRJNsBIsLXu/xJ0VUjP
	v2UNTb6ncFSNs3B6FsxkDfEti1sUxrJVa0oIAAEO27/wtk4QGW6OPSmDT+Tz1wefwJbwoPIlGJo
	w779JtAZA5O2HXkhvYUZCElhFg4/TmRwfhQ2VWjxTuf7dJ11rhMRx/3/EahhcRc=
X-Received: by 2002:a05:6000:25ec:b0:493:803e:800f with SMTP id ffacd0b85a97d-49c725e5749mr9765352f8f.29.1794629395288;
        Fri, 13 Nov 2026 20:09:55 -0800 (PST)
Received: from demian.play.pl (83-175-177-170.dynamic.play.pl. [83.175.177.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c602dsm8488670f8f.46.2026.11.13.20.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 20:09:53 -0800 (PST)
From: Demian Shulhan <demyansh@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	David Laight <david.laight.linux@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Saeed Bishara <saeed.bishara.os@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marco Elver <elver@google.com>,
	David Gow <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] lib/tests: checksum: Add KUnit tests for csum_partial_copy_nocheck()
Date: Sat, 14 Nov 2026 03:57:01 +0000
Message-ID: <20261114040943.219870-3-demyansh@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114040943.219870-1-demyansh@gmail.com>
References: <20261114040943.219870-1-demyansh@gmail.com>
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

Extend the checksum KUnit test suite to cover csum_partial_copy_nocheck()
across alignments, tail lengths, bit patterns, vmalloc() guard pages with
canary checks, and concurrent task/softirq/hardirq execution.

Compare folded checksums against both a standalone C reference and
csum_partial(), canonicalizing 0xffff (-0) to 0x0000 (+0) after
csum_fold() so zero and all-zero inputs match across architectures such
as x86_64.

Also add an optional throughput benchmark gated behind
CONFIG_CHECKSUM_KUNIT_BENCHMARK (default n).

Signed-off-by: Demian Shulhan <demyansh@gmail.com>
---
 lib/Kconfig.debug          |  10 +
 lib/tests/checksum_kunit.c | 410 +++++++++++++++++++++++++++++++++++++
 2 files changed, 420 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2d22638ec13a..588343ced260 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2770,6 +2770,16 @@ config CHECKSUM_KUNIT
 
 	  If unsure, say N.
 
+config CHECKSUM_KUNIT_BENCHMARK
+	bool "Benchmark for the checksum functions"
+	depends on CHECKSUM_KUNIT
+	help
+	  Include a benchmark of csum_partial_copy_nocheck() against
+	  memcpy() followed by csum_partial() in the checksum KUnit test
+	  suite, for a range of buffer lengths and misalignments. The
+	  throughput of both is logged as test output. Only meaningful on
+	  real hardware and is not intended for production builds.
+
 config UTIL_MACROS_KUNIT
 	tristate "KUnit test util_macros.h functions at runtime" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/tests/checksum_kunit.c b/lib/tests/checksum_kunit.c
index be04aa42125c..69611daa7c0c 100644
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
@@ -619,18 +626,421 @@ static void test_csum_ipv6_magic(struct kunit *test)
 	}
 }
 
+/*
+ * csum_partial_copy_nocheck() tests: verify copied bytes, folded checksum
+ * against a standalone reference and csum_partial(), canary/guard-page
+ * bounds, and concurrent task/softirq/hardirq execution.
+ */
+#define COPY_MAX_OFF 16
+#define COPY_MAX_LEN 4352
+#define COPY_BENCH_MAX_LEN 16384
+#define COPY_GUARD 128 /* canary span on each side of dst */
+#define COPY_CANARY 0xa5
+#define COPY_SEED 0x5eed
+
+static struct rnd_state copy_rng;
+/* vmalloc()ed with a page-aligned length, so each is followed by a guard page */
+static u8 *copy_src_area;
+static u8 *copy_dst_area;
+static u8 *copy_shadow; /* expected contents of copy_src_area */
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
+/* Place @len bytes at misalignment @off as close as possible to the guard page. */
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
+		memcpy(&word, buf + i, sizeof(word)); /* native endian */
+		sum += word;
+	}
+	if (len & 1) {
+		u8 pad[2] = { buf[len - 1], 0 };
+
+		memcpy(&word, pad, sizeof(word)); /* LE: low byte, BE: high byte */
+		sum += word;
+	}
+	while (sum >> 16)
+		sum = (sum & 0xffff) + (sum >> 16);
+
+	sum = ~sum & 0xffff;
+	return sum == 0xffff ? 0 : sum;
+}
+
+/*
+ * RFC 1071: 0xffff (-0) and 0x0000 (+0) are equivalent. Canonicalize to 0 so
+ * ~0U-seeded archs (e.g. x86_64) match 0-seeded refs on zero/all-zero inputs.
+ */
+static u16 fold_csum(__wsum csum)
+{
+	u16 sum = (__force u16)csum_fold(csum);
+
+	return sum == 0xffff ? 0 : sum;
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
+/* Verify one csum_partial_copy_nocheck() call with @before/@after canaries. */
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
+	got = fold_csum(csum_partial_copy_nocheck(src, dst, len));
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
+			    fold_csum(csum_partial(src, len, 0)),
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
+/* Representative source offsets used with all 16 destination offsets. */
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
+/* Large unaligned buffers exercising multi-block strides and GSO/MTU lengths. */
+static void test_csum_copy_large_unaligned(struct kunit *test)
+{
+	static const int extra_lens[] = {
+		1368, 1448, 1500, 2033, 2034, 2035, 2039, 2040, 2041, 2047,
+		2048, 2049, 2055, 2056, 2057, 2062, 2063, 3072, 4095, 4096,
+		4097, 4352,
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
+/* Patterns stressing carries, zero/MSB bytes, and odd-offset byte order. */
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
+		{ NULL, 0 }, /* random */
+	};
+	static const int lens[] = {
+		1, 2, 3, 7, 8, 15, 16, 17, 31, 32, 33, 63, 64, 65, 127, 128,
+		255, 256, 511, 512, 1023, 1024, 1025, 1368, 1448, 1500, 2048,
+		4095, 4096, 4352,
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
+/* Place dst against its trailing guard page so any over-write faults. */
+static void test_csum_copy_dst_guard_page(struct kunit *test)
+{
+	static const int lens[] = {
+		1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
+		31, 32, 33, 63, 64, 65, 79, 80, 81, 127, 128, 129, 1023, 1024,
+		1025, 1368, 1448, 1500, 2048, 4095, 4096, 4097,
+	};
+	int l, src_off, dst_off;
+
+	copy_fill_random();
+	for (l = 0; l < ARRAY_SIZE(lens); l++)
+		for (dst_off = 0; dst_off < COPY_MAX_OFF; dst_off++) {
+			u8 *dst = copy_place_at_end(copy_dst_area, dst_off, lens[l]);
+			int after = copy_dst_area + copy_area_len - (dst + lens[l]);
+
+			src_off = (dst_off * 7 + lens[l]) & (COPY_MAX_OFF - 1);
+			check_csum_copy_at(test,
+					   copy_place_at_end(copy_src_area,
+							     src_off, lens[l]),
+					   dst, lens[l], COPY_GUARD, after);
+		}
+}
+
+/* len == 0: folded checksum must be zero and dst must not be touched. */
+static void test_csum_copy_zero_len(struct kunit *test)
+{
+	u8 *dst = copy_dst_area + COPY_GUARD;
+	__wsum sum;
+
+	copy_fill_random();
+	memset(copy_dst_area, COPY_CANARY, 2 * COPY_GUARD);
+	sum = csum_partial_copy_nocheck(copy_src_area, dst, 0);
+	KUNIT_EXPECT_EQ(test, fold_csum(sum), 0);
+	KUNIT_EXPECT_EQ(test, first_non_canary(copy_dst_area, 2 * COPY_GUARD), -1);
+}
+
+/* Concurrent execution across task, softirq, and hardirq contexts. */
+#define COPY_IRQ_NUM_MSGS 3
+#define COPY_IRQ_NUM_CTX 3 /* task, softirq, hardirq */
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
+	got = fold_csum(csum_partial_copy_nocheck(src, dst, len));
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
+/* Optional throughput benchmark vs memcpy() + csum_partial(). */
+static void test_csum_copy_benchmark(struct kunit *test)
+{
+	static const int lens[] = {
+		16, 40, 64, 128, 256, 512, 1000, 1024, 1368, 1448, 1500,
+		2048, 4096, 16384,
+	};
+	static const int offs[][2] = { { 0, 0 }, { 1, 3 } };
+	int l, o, i, len, num_iters;
+	u64 t, t_fused, t_split;
+	u32 acc = 0; /* keeps every call alive via OPTIMIZER_HIDE_VAR() */
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
+				   div64_u64((u64)len * num_iters * 1000,
+					     max_t(u64, t_fused, 1)),
+				   div64_u64((u64)len * num_iters * 1000,
+					     max_t(u64, t_split, 1)));
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
2.53.0

