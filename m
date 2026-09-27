Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9C3EEAF4
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790515210; cv=none; b=MlB7vtlnIm8h4XZHfxwMaoQeh5WsqYBIQqtGphlJZS8+09Gv0DiQr657FoVYvgIDOPtZz/ntZw/vVFu5A7sARdO/Vytsys4s4PxcEDk2MvlQA/cgvhxUYhHx6IsLT1ss24A3xqLT3fpOKy+5tQKysMBzjerQ4e2IIto+G3OnuAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790515210; c=relaxed/simple;
	bh=4kYXFn9p35ErVsdes+HTfNgLkBmDOzBf4NCxq2Ky3dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXebOtI3y60M+KsF3CsXGE7jnsvPlHFzk7EUd30eysQgv0L1fU24K3uavD+v783eMYx9xTg6t+dxs9B2qfQjureDhOohDnH6bGz4gEJP6dnfOTT9RBeEvyMJbp/+0uAh4qjV+ytDdDJD4ReSUL5q2okKydfNasfRmHQEpS6pE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN2CF9N8; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN2CF9N8"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so11862115e9.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790515204; x=1791120004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QvblxTf130pEr+aN5KzOnZF1yiby+Y7hAcUN5DJQn9c=;
        b=HN2CF9N8enMFpyJSXTJCbk+v0qjafPUy8Kff637F3Zmb2JIhbSRDGPONYp1QlGCLAz
         09i5XYy+jRPNN8FbCTPNM7rTdFY7mUcKvi9nc3aRoIQ3TMISzuuNN9MAujUFGi3bew/7
         38uI2vxOq5TpaGSpAN8+UdWsVNQl6s8JFCo+FJkC++PzYok74RDG9UNAZemCLqes6U5k
         5Du3QGadGjvLEDaQ7cqQBWElTMno5uP/+tWPwWr/iK8vnpC2H+wE88lA1ZrIwWuyu/nn
         zxrQDu9ESF9MVbjJBffq9YeqYFscZNWZ1FNt897M7pMP7SSXa2hqNN3iV7wqa3vziTRc
         ZViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790515204; x=1791120004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QvblxTf130pEr+aN5KzOnZF1yiby+Y7hAcUN5DJQn9c=;
        b=kNOJTlMC60vBpwSBofdEhA7BwmVxfitLY4QTo4sIOCSaJW/+lpbCEQeekfQLzRohvD
         f8BGImpMrq0NcnXjP5oxEnfaN6L6nfcJl/IHqe8zrtgAkf9x506l/TWrwGBp7YajHx+z
         5o/W0i5D6Ia7OD8O0qarbUN+9I3AV3SIi12xHYRwPfJgMEBr4HOG1OFqI7C2G+mO2EyO
         JGCkNGcL58cwjTQgIgavkbINoEbsmhWv/TGPTFiQaqE0PtyXqYPYrOJb23eGYUY5yqwJ
         As20A7MQMdk0vUz9q57uZFJqxsI61Yvw0EHPPYD20Ar7CSxfPnrjzPpuFBk9kXUZxqUV
         l06Q==
X-Forwarded-Encrypted: i=1; AKwUvBxosKhM4JNlW7l3A372I7g6aMQ/ahtbnvVpQ+rWgTNwYQs5TCirQNRAPn/BjjLOP6I1jHP7b9E=@vger.kernel.org
X-Gm-Message-State: AFuF++mZ+xI67wbbBZbFEV/i7lPmSHoKYmbd+dd7L2pt5nY2Wf4oLKud
	naFG+LjnlrzKTsGcmw61ZiyjkJD2Fpus/qKOkxxm4AcfwpP+YvOkZbAX
X-Gm-Gg: AYBFou1XInrM37omJ7fe+wbxYGxjSUl/W0ossuA3J+jpiyHPJKXlgDfKXOZiJ5gDKB2
	Lc4zOlofctZVxxLzbk6jAFHcGWUZjThgxZYzq/859MvIwODZVHa0PS5SoLt525fJmkpX/YbPmVw
	GNFNeIbCzPLFBhDF/M1R8JMYxfDzBDQJPFXyQdtm+epHDz/HOpio3VE4kHUnBA3VwqdRanvTWyg
	gP9DczEI63mexo9nkGTp4UOFpcE7b4uA+Rrw3bdmhwV2Ev5v405Cxnh2lrRiSidN2ggWfqPOXOr
	RQJSpw3FgA3QvcpM5sOWwEe1O7Z1L2vOlz0Bzm9w9ZJHXiJPcHItwaxGTd7h5vUeSe6BDeGVBn+
	E+8AI6M/+UlUED6WzQiVvNF2R+DO9BmU+Hr+F8XZKG53uoKx6LZrkwe3tkiAJPqsIfyKcfN6iuE
	ieP0MB3nUWZ/bwLm/r1vZCZkf5x6y4pLVpGotTfLEPEA8Gq7o7EI64PhE4hCvhhBuPy+dlUQsXP
	HZXeJZqVWceM1fDkBCqdK8bORu2fvGGEHBUovE=
X-Received: by 2002:a05:600c:468f:b0:49d:1df8:156d with SMTP id 5b1f17b1804b1-49fe66e6438mr192157985e9.18.1790515204330;
        Sun, 27 Sep 2026 06:20:04 -0700 (PDT)
Received: from lima-dev.. (89-67-112-196.dynamic.play.pl. [89.67.112.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0019057cfsm73615905e9.11.2026.09.27.06.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 06:20:03 -0700 (PDT)
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
Subject: [PATCH 1/2] arm64: csum: Add fused copy and Internet checksum
Date: Sun, 27 Sep 2026 15:17:57 +0200
Message-ID: <20260927131838.6774-2-demyansh@gmail.com>
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

arm64 currently falls back to the generic csum_partial_copy_nocheck(),
requiring two passes over the data (memcpy + csum_partial).

Replace it with a single-pass implementation. The implementation
provides two paths handling any src/dst alignment:

1. __csum_partial_copy_scalar(): Uses general-purpose registers,
   processing 32 bytes per iteration through four independent ones'
   complement accumulators. Used below the NEON threshold or when
   may_use_simd() is false.

2. __csum_partial_copy_neon(): Uses UADDLP/UADALP accumulating into
   two 64-bit accumulators, processing 64 bytes per iteration.

The NEON threshold is fixed at 1024 bytes (CSUM_COPY_NEON_MIN_LEN).
Boot-time calibration is avoided due to measurement noise and
big.LITTLE asymmetries. 1024 bytes ensures MTU-sized buffers utilize
the NEON path while avoiding kernel_neon_begin() overhead for small
payloads.

All loads remain within [src, src + len) and stores within [dst, dst +
len), requiring no KASAN annotations. To guarantee the returned checksum
matches dst even under concurrent source modification (e.g.,
MSG_ZEROCOPY), overlapping tail bytes are deliberately copied before the
body.

Performance:

1) Ampere Altra (Neoverse-N1, MIDR part 0xd0c), GCP t2a-standard-2,
Ubuntu 24.04, kernel 7.0.0-1011-gcp, gcc 13.3.
Measured in-kernel (minimum over 20000 calls, ns per call):

  align            len | generic |   new | speedup
  aligned           64 |    14.7 |  11.0 |  1.33x
  aligned          128 |    18.7 |  13.8 |  1.36x
  aligned          256 |    27.7 |  19.4 |  1.42x
  aligned          512 |    42.9 |  31.5 |  1.36x
  aligned         1000 |    72.0 |  54.9 |  1.31x
  aligned         1023 |    73.8 |  57.9 |  1.27x
  aligned         1024 |    73.0 |  59.8 |  1.21x
  aligned         1500 |   102.1 |  73.8 |  1.38x
  aligned         2048 |   134.6 |  91.2 |  1.47x
  aligned         4096 |   257.1 | 153.4 |  1.67x
  src+1/dst+0     1500 |   118.2 |  78.9 |  1.49x
  src+1/dst+0     4096 |   300.8 | 164.3 |  1.83x
  src+0/dst+1     1500 |   117.6 |  79.7 |  1.47x
  src+0/dst+1     4096 |   303.8 | 167.4 |  1.81x
  src+15/dst+15     64 |    16.0 |  11.0 |  1.44x
  src+15/dst+15    512 |    42.9 |  33.1 |  1.29x
  src+15/dst+15   1023 |    71.5 |  61.3 |  1.16x
  src+15/dst+15   1024 |    72.5 |  61.9 |  1.17x
  src+15/dst+15   1500 |    99.7 |  77.1 |  1.29x
  src+15/dst+15   4096 |   255.5 | 156.3 |  1.63x

Scalar vs NEON break-even on the same core (NEON includes
kernel_neon_begin()/end()):

  align            len | scalar | neon+begin/end
  aligned          512 |   29.6 |   40.6
  aligned          768 |   42.2 |   48.8
  aligned         1024 |   54.9 |   56.6
  aligned         1280 |   67.4 |   64.6

2) Apple M-series core (MIDR implementer 0x61).
Userspace harness, fixed CPU affinity, minimum over 3 runs x 9 batches
(ns per call):

  align           len | generic  scalar    neon |    new | speedup
  aligned          20 |     2.8     1.8       - |    1.8 |  1.56x
  aligned          40 |     2.8     1.7       - |    1.7 |  1.65x
  aligned          64 |     3.0     2.0       - |    2.0 |  1.50x
  aligned         128 |     4.6     3.1     2.5 |    3.1 |  1.48x
  aligned         256 |    14.8     5.1     3.4 |    5.1 |  2.90x
  aligned         512 |    12.8     9.6     5.3 |    9.6 |  1.33x
  aligned        1000 |    26.6    20.7     8.2 |   20.7 |  1.29x
  aligned        1024 |    24.4    18.9     8.2 |   15.2 |  1.61x
  aligned        1500 |    35.2    30.7    13.0 |   20.0 |  1.76x
  aligned        2048 |    53.1    41.7    17.3 |   24.3 |  2.19x
  aligned        4096 |   104.1    85.6    37.9 |   44.9 |  2.32x

Testing: All sizes and alignments cross-checked against
memcpy()+csum_partial() (0 mismatches). Concurrent-writer test confirms
checksum(dst) == returned sum under source modification (2M iterations,
0 mismatches). Builds clean with gcc 13 and clang 18 at W=1;
checkpatch --strict clean.

Signed-off-by: Demian Shulhan <demyansh@gmail.com>
---
 arch/arm64/include/asm/checksum.h |   3 +
 arch/arm64/lib/Makefile           |   7 +-
 arch/arm64/lib/csum-copy-neon.c   | 168 ++++++++++++++++++++++++++++++
 arch/arm64/lib/csum-copy.c        | 108 +++++++++++++++++++
 arch/arm64/lib/csum-copy.h        |  84 +++++++++++++++
 arch/arm64/lib/csum.c             |  54 ++++++++++
 6 files changed, 423 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/lib/csum-copy-neon.c
 create mode 100644 arch/arm64/lib/csum-copy.c
 create mode 100644 arch/arm64/lib/csum-copy.h

diff --git a/arch/arm64/include/asm/checksum.h b/arch/arm64/include/asm/checksum.h
index dc52b733675d..9f766db01152 100644
--- a/arch/arm64/include/asm/checksum.h
+++ b/arch/arm64/include/asm/checksum.h
@@ -44,6 +44,9 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 extern unsigned int do_csum(const unsigned char *buff, int len);
 #define do_csum do_csum
 
+#define _HAVE_ARCH_CSUM_AND_COPY
+__wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
+
 #include <asm-generic/checksum.h>
 
 #endif	/* __ASM_CHECKSUM_H */
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index b33e1ca4a781..5e1024c31f67 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -5,10 +5,15 @@ KCSAN_SANITIZE_delay.o := n
 
 lib-y		:= clear_user.o delay.o copy_from_user.o		\
 		   copy_to_user.o copy_page.o				\
-		   clear_page.o csum.o insn.o memchr.o memcpy.o		\
+		   clear_page.o csum.o csum-copy.o csum-copy-neon.o	\
+		   insn.o memchr.o memcpy.o				\
 		   memset.o memcmp.o strcmp.o strncmp.o strlen.o	\
 		   strnlen.o strchr.o strrchr.o tishift.o
 
+# NEON intrinsics; only ever called between kernel_neon_begin()/end().
+CFLAGS_csum-copy-neon.o		+= $(CC_FLAGS_FPU)
+CFLAGS_REMOVE_csum-copy-neon.o	+= $(CC_FLAGS_NO_FPU)
+
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
diff --git a/arch/arm64/lib/csum-copy-neon.c b/arch/arm64/lib/csum-copy-neon.c
new file mode 100644
index 000000000000..bfeaf2beba39
--- /dev/null
+++ b/arch/arm64/lib/csum-copy-neon.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Fused copy + Internet checksum for arm64: NEON path
+ *
+ * Copyright (C) 2026 Demian Shulhan <demyansh@gmail.com>
+ *
+ * This file is compiled with CC_FLAGS_FPU (see Makefile) and must only be
+ * entered between kernel_neon_begin() and kernel_neon_end(). Everything
+ * else about the contract is in csum-copy.h.
+ *
+ * The routine runs to completion without chunking or yielding regardless
+ * of @len. In task context kernel-mode NEON is preemptible (the caller's
+ * FPSIMD state lives in a caller-provided buffer that is switched with the
+ * task). In softirq context preemption is off, but the lengths that reach
+ * this function are bounded by a single skb fragment or iov segment, i.e.
+ * tens of KiB at the very most, which is a few microseconds here and well
+ * within what the surrounding network softirq processing already spends.
+ *
+ * Main loop: 64 bytes per iteration. Each 16-byte vector is reduced with
+ * UADDLP (8x16 -> 4x32); pairs of vectors share a 32-bit accumulator via
+ * UADALP, which is then drained into a 64-bit accumulator. This is six
+ * vector ALU operations per iteration; giving every vector its own 64-bit
+ * accumulator would need eight and measures ~10% slower, as the loop is
+ * bound by vector ALU throughput rather than by dependency latency. A
+ * 32-bit lane only ever holds the sum of four 16-bit words, so it cannot
+ * overflow, and the 64-bit lanes cannot overflow for any 'int' length.
+ * Two independent 64-bit accumulators keep the loop-carried dependency to
+ * a single UADALP each. The dispatcher only enters this path for
+ * len >= CSUM_COPY_NEON_MIN_LEN, so the loop is entered unconditionally.
+ *
+ * Head: misaligned 16-byte stores are markedly more expensive than
+ * misaligned loads, so @dst is aligned to 16 bytes first by copying one
+ * full vector and masking the checksum contribution down to the leading
+ * 'head' bytes. The main loop then runs on the byte grid starting at
+ * @src + head; if head is odd, that grid is offset from the 16-bit word
+ * grid of the buffer. Rather than fixing up every loop vector, the head
+ * vector is byte-swapped within each lane (REV16) to match the loop grid
+ * and the final folded 16-bit sum is rotated by 8 bits, which is exact for
+ * ones' complement sums (the same trick as csum_block_add()/do_csum()).
+ *
+ * Tail (1..15 bytes): rather than dribbling bytes through GPRs, copy the
+ * last 16 bytes of the buffer as one vector and mask off the bytes that
+ * belong to the body. That vector overlaps up to 15 body bytes, so it is
+ * copied *before* the body: the body's stores then overwrite the overlap
+ * with the very bytes that were summed, and the destination always matches
+ * the returned checksum even if the source is modified concurrently. If the
+ * tail length is odd the tail vector is offset by one byte from the loop
+ * grid, which is again corrected with REV16.
+ *
+ * Data is handled as uint8x16_t throughout: that is how it sits in memory,
+ * and masking and REV16 are byte operations. The 16-bit word view only
+ * appears in the two pairwise-add helpers.
+ */
+
+#include <linux/types.h>
+#include <asm/neon-intrinsics.h>
+
+#include "csum-copy.h"
+
+/*
+ * Byte mask table. A 16-byte load at offset n (1..15) yields (16 - n) zero
+ * bytes followed by n 0xff bytes, selecting the last n bytes of a vector;
+ * a load at offset 32 - n yields n 0xff bytes followed by zeros, selecting
+ * the first n bytes. One unaligned load, no lane-index compare.
+ */
+static const u8 csum_copy_mask[48] __aligned(16) = {
+	[16 ... 31] = 0xff,
+};
+
+/* Adjacent 16-bit words of @v summed into 32-bit lanes (UADDLP). */
+static __always_inline uint32x4_t words_sum(uint8x16_t v)
+{
+	return vpaddlq_u16(vreinterpretq_u16_u8(v));
+}
+
+/* @acc += adjacent 16-bit words of @v (UADALP). */
+static __always_inline uint32x4_t words_add(uint32x4_t acc, uint8x16_t v)
+{
+	return vpadalq_u16(acc, vreinterpretq_u16_u8(v));
+}
+
+__wsum __csum_partial_copy_neon(const void *src, void *dst, int len)
+{
+	const u8 *s = src;
+	u8 *d = dst;
+	uint64x2_t acc0 = { }, acc1 = { };
+	unsigned int head = -(unsigned long)d & 15;
+	unsigned int tail = (len - head) & 15;
+	u32 sum;
+
+	if (tail) {
+		/* Final vector, ending exactly at the buffer end; see above */
+		uint8x16_t v = vld1q_u8(s + len - 16);
+
+		vst1q_u8(d + len - 16, v);
+		v &= vld1q_u8(csum_copy_mask + tail);
+		if (tail & 1)
+			v = vrev16q_u8(v);	/* odd tail: match loop grid */
+		acc1 = vpadalq_u32(acc1, words_sum(v));
+	}
+
+	if (head) {
+		uint8x16_t v = vld1q_u8(s);
+
+		vst1q_u8(d, v);
+		v &= vld1q_u8(csum_copy_mask + 32 - head);
+		if (head & 1)
+			v = vrev16q_u8(v);	/* odd head: match loop grid */
+		acc0 = vpadalq_u32(acc0, words_sum(v));
+
+		s += head;
+		d += head;
+		len -= head;
+	}
+
+	do {
+		uint8x16_t v0 = vld1q_u8(s);
+		uint8x16_t v1 = vld1q_u8(s + 16);
+		uint8x16_t v2 = vld1q_u8(s + 32);
+		uint8x16_t v3 = vld1q_u8(s + 48);
+		uint32x4_t t0, t1;
+
+		vst1q_u8(d, v0);
+		vst1q_u8(d + 16, v1);
+		vst1q_u8(d + 32, v2);
+		vst1q_u8(d + 48, v3);
+
+		t0 = words_sum(v0);
+		t1 = words_sum(v1);
+		t0 = words_add(t0, v2);
+		t1 = words_add(t1, v3);
+		acc0 = vpadalq_u32(acc0, t0);
+		acc1 = vpadalq_u32(acc1, t1);
+
+		s += 64;
+		d += 64;
+		len -= 64;
+	} while (len >= 64);
+
+	if (len & 32) {
+		uint8x16_t v0 = vld1q_u8(s);
+		uint8x16_t v1 = vld1q_u8(s + 16);
+
+		vst1q_u8(d, v0);
+		vst1q_u8(d + 16, v1);
+		acc0 = vpadalq_u32(acc0, words_add(words_sum(v0), v1));
+
+		s += 32;
+		d += 32;
+	}
+	if (len & 16) {
+		uint8x16_t v = vld1q_u8(s);
+
+		vst1q_u8(d, v);
+		acc1 = vpadalq_u32(acc1, words_sum(v));
+	}
+
+	sum = (__force u32)csum_fold64(vaddvq_u64(acc0 + acc1));
+
+	if (head & 1) {
+		/* Fold to 16 bits and rotate back onto the buffer's word grid */
+		sum = (sum & 0xffff) + (sum >> 16);
+		sum = (sum & 0xffff) + (sum >> 16);
+		sum = ((sum & 0xff) << 8) | (sum >> 8);
+	}
+
+	return (__force __wsum)sum;
+}
diff --git a/arch/arm64/lib/csum-copy.c b/arch/arm64/lib/csum-copy.c
new file mode 100644
index 000000000000..d384b6be0abf
--- /dev/null
+++ b/arch/arm64/lib/csum-copy.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Fused copy + Internet checksum for arm64: general-purpose register path
+ *
+ * Copyright (C) 2026 Demian Shulhan <demyansh@gmail.com>
+ *
+ * Used for buffers too small to amortise kernel_neon_begin()/end(), and
+ * whenever may_use_simd() is false (hardirq/NMI, or FPSIMD not usable).
+ * See csum-copy.h for the contract.
+ */
+
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#include "csum-copy.h"
+
+/*
+ * Ones' complement add: 64-bit add with end-around carry. Same result as
+ * accumulate() in csum.c; written with a compare rather than __uint128_t
+ * so that the carry chains of the four accumulators below stay independent.
+ */
+static __always_inline u64 csum_add64(u64 sum, u64 data)
+{
+	u64 res = sum + data;
+
+	return res + (res < data);
+}
+
+__wsum __csum_partial_copy_scalar(const void *src, void *dst, int len)
+{
+	const u8 *s = src;
+	u8 *d = dst;
+	u64 sum0 = 0, sum1 = 0, sum2 = 0, sum3 = 0;
+
+	/*
+	 * 32 bytes per iteration into four independent accumulators. A single
+	 * accumulator would serialise every word on both the register and the
+	 * carry flag (one 64-bit word per cycle at best); with independent
+	 * chains the loop becomes store-bound on out-of-order cores.
+	 */
+	while (len >= 32) {
+		u64 a = get_unaligned((const u64 *)s);
+		u64 b = get_unaligned((const u64 *)(s + 8));
+		u64 c = get_unaligned((const u64 *)(s + 16));
+		u64 e = get_unaligned((const u64 *)(s + 24));
+
+		put_unaligned(a, (u64 *)d);
+		put_unaligned(b, (u64 *)(d + 8));
+		put_unaligned(c, (u64 *)(d + 16));
+		put_unaligned(e, (u64 *)(d + 24));
+
+		sum0 = csum_add64(sum0, a);
+		sum1 = csum_add64(sum1, b);
+		sum2 = csum_add64(sum2, c);
+		sum3 = csum_add64(sum3, e);
+
+		s += 32;
+		d += 32;
+		len -= 32;
+	}
+
+	if (len & 16) {
+		u64 a = get_unaligned((const u64 *)s);
+		u64 b = get_unaligned((const u64 *)(s + 8));
+
+		put_unaligned(a, (u64 *)d);
+		put_unaligned(b, (u64 *)(d + 8));
+		sum0 = csum_add64(sum0, a);
+		sum1 = csum_add64(sum1, b);
+		s += 16;
+		d += 16;
+	}
+	if (len & 8) {
+		u64 a = get_unaligned((const u64 *)s);
+
+		put_unaligned(a, (u64 *)d);
+		sum2 = csum_add64(sum2, a);
+		s += 8;
+		d += 8;
+	}
+	if (len & 4) {
+		u32 w = get_unaligned((const u32 *)s);
+
+		put_unaligned(w, (u32 *)d);
+		sum3 = csum_add64(sum3, w);
+		s += 4;
+		d += 4;
+	}
+	if (len & 2) {
+		u16 h = get_unaligned((const u16 *)s);
+
+		put_unaligned(h, (u16 *)d);
+		sum0 = csum_add64(sum0, h);
+		s += 2;
+		d += 2;
+	}
+	if (len & 1) {
+		u8 b = *s;
+
+		*d = b;
+		/* Zero-padded final word: the byte is its low half */
+		sum1 = csum_add64(sum1, b);
+	}
+
+	sum0 = csum_add64(sum0, sum1);
+	sum2 = csum_add64(sum2, sum3);
+	return csum_fold64(csum_add64(sum0, sum2));
+}
diff --git a/arch/arm64/lib/csum-copy.h b/arch/arm64/lib/csum-copy.h
new file mode 100644
index 000000000000..cd4c9238be38
--- /dev/null
+++ b/arch/arm64/lib/csum-copy.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Fused copy + Internet checksum for arm64: internals shared between the
+ * general-purpose register and NEON implementations and their dispatcher.
+ *
+ * Copyright (C) 2026 Demian Shulhan <demyansh@gmail.com>
+ */
+#ifndef __ARM64_LIB_CSUM_COPY_H
+#define __ARM64_LIB_CSUM_COPY_H
+
+#include <linux/build_bug.h>
+#include <linux/types.h>
+
+/*
+ * Both implement
+ *
+ *	__wsum fn(const void *src, void *dst, int len)
+ *
+ * copying @len bytes from @src to @dst while accumulating the ones'
+ * complement sum of the data, and return a 32-bit unfolded __wsum.
+ *
+ * The sum is taken over the data as laid out in memory, i.e. over 16-bit
+ * little-endian words starting at @src (arm64 Linux is little-endian only:
+ * CONFIG_CPU_BIG_ENDIAN depends on BROKEN), with a trailing odd byte
+ * treated as the low half of a final zero-padded word. This is what
+ * csum_partial() computes, so the result can be fed straight into
+ * csum_block_add()/csum_fold().
+ *
+ * @src and @dst may have any alignment but must not overlap (memcpy() on
+ * arm64 happens to be memmove()-safe; these routines are not). All loads
+ * stay within [src, src + len) and all stores within [dst, dst + len).
+ * Every byte of @dst is written from the very load that was summed, so the
+ * returned value is the checksum of @dst even if @src is modified
+ * concurrently.
+ *
+ * __csum_partial_copy_scalar() accepts any len >= 0.
+ * __csum_partial_copy_neon() requires len >= CSUM_COPY_NEON_MIN_LEN_HW and
+ * must be called between kernel_neon_begin() and kernel_neon_end().
+ */
+__wsum __csum_partial_copy_scalar(const void *src, void *dst, int len);
+__wsum __csum_partial_copy_neon(const void *src, void *dst, int len);
+
+/*
+ * Smallest length __csum_partial_copy_neon() can handle: up to 15 bytes to
+ * align @dst to 16 bytes, then one unconditional 64-byte main loop
+ * iteration.
+ */
+#define CSUM_COPY_NEON_MIN_LEN_HW	(15 + 64)
+
+/*
+ * Smallest length for which the dispatcher uses NEON at all. The fused
+ * scalar path is already a single pass over the data, so NEON only has to
+ * beat it by the fixed cost of kernel_neon_begin()/kernel_neon_end(): a
+ * local_bh_disable()/enable() pair plus, when the interrupted context's
+ * FPSIMD (or SVE/SME, when live) state has not been saved yet, that save
+ * and its deferred reload on return to userspace. Where the two paths
+ * break even depends on the core: ~512 bytes on an Apple M-series core,
+ * ~1.25 KiB on Neoverse-N1 (both with the FPSIMD state already saved).
+ * 1024 keeps MTU-sized buffers on the NEON path everywhere while costing
+ * at most ~10% against the scalar path in the 1024..1280 window on N1.
+ * The threshold is deliberately a constant rather than calibrated at boot:
+ * a boot-time measurement is noisy (cold caches, low initial clock, steal
+ * time in VMs), would differ between the core types of a big.LITTLE
+ * system and would make the kernel's behaviour vary from boot to boot,
+ * for a gain of a few percent in a narrow length window. See the commit
+ * message for numbers.
+ */
+#define CSUM_COPY_NEON_MIN_LEN		1024
+
+static_assert(CSUM_COPY_NEON_MIN_LEN >= CSUM_COPY_NEON_MIN_LEN_HW);
+
+/*
+ * Fold a 64-bit ones' complement accumulator to a 32-bit __wsum with
+ * end-around carry. The first add produces at most a 33-bit value, so the
+ * second add cannot carry again.
+ */
+static __always_inline __wsum csum_fold64(u64 sum)
+{
+	sum = (sum & 0xffffffff) + (sum >> 32);
+	sum = (sum & 0xffffffff) + (sum >> 32);
+	return (__force __wsum)(u32)sum;
+}
+
+#endif /* __ARM64_LIB_CSUM_COPY_H */
diff --git a/arch/arm64/lib/csum.c b/arch/arm64/lib/csum.c
index 2432683e48a6..4f949b7085b5 100644
--- a/arch/arm64/lib/csum.c
+++ b/arch/arm64/lib/csum.c
@@ -5,8 +5,12 @@
 #include <linux/kasan-checks.h>
 #include <linux/kernel.h>
 
+#include <asm/simd.h>
+
 #include <net/checksum.h>
 
+#include "csum-copy.h"
+
 /* Looks dumb, but generates nice-ish code */
 static u64 accumulate(u64 sum, u64 data)
 {
@@ -129,6 +133,56 @@ unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
 	return sum >> 16;
 }
 
+/*
+ * scoped_ksimd() puts the caller-provided FPSIMD state buffer (a 528-byte
+ * struct user_fpsimd_state) on the stack. Keep it out of line so that the
+ * common, short, scalar calls do not carry that frame, which matters for
+ * the deep softirq call chains csum_partial_copy_nocheck() is reached from.
+ */
+static noinline __wsum csum_partial_copy_neon(const void *src, void *dst,
+					      int len)
+{
+	__wsum sum;
+
+	scoped_ksimd()
+		sum = __csum_partial_copy_neon(src, dst, len);
+
+	return sum;
+}
+
+/**
+ * csum_partial_copy_nocheck - copy a buffer and compute its Internet checksum
+ * @src: source buffer
+ * @dst: destination buffer; must not overlap @src
+ * @len: number of bytes to copy; nothing is copied for len <= 0
+ *
+ * Copies @len bytes from @src to @dst in a single pass and returns the
+ * unfolded 32-bit ones' complement sum of the data, exactly as
+ * csum_partial(@src, @len, 0) would, so the result can be passed to
+ * csum_block_add() or csum_fold(). The returned sum is the checksum of the
+ * bytes written to @dst even if @src is concurrently modified.
+ *
+ * Callable from task and softirq context. For len >= CSUM_COPY_NEON_MIN_LEN
+ * the copy uses kernel-mode NEON when may_use_simd() allows it, so it must
+ * not be called from within another kernel_neon_begin()/kernel_neon_end()
+ * section in task context (kernel_neon_begin() only nests from softirq).
+ * From hardirq/NMI context, or when FPSIMD is not usable, the general
+ * purpose register implementation is used for any length.
+ *
+ * Return: the unfolded ones' complement sum of the copied data; 0 if len <= 0.
+ */
+__wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
+{
+	if (unlikely(len <= 0))
+		return 0;
+
+	if (len >= CSUM_COPY_NEON_MIN_LEN && likely(may_use_simd()))
+		return csum_partial_copy_neon(src, dst, len);
+
+	return __csum_partial_copy_scalar(src, dst, len);
+}
+EXPORT_SYMBOL(csum_partial_copy_nocheck);
+
 __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 			const struct in6_addr *daddr,
 			__u32 len, __u8 proto, __wsum csum)
-- 
2.43.0

