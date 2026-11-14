Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794629393;
	b=4vPWBZoIkqMQoOigR7QCUUulpKg5EZcDfI9akq9fKpoaAISbA/u10BNQyAvGjZVKlDlf
	 JsBfFzop18+9KXWviq5Ga1vrnmw1gdgl7V8x5HamxmUnWvt1vLQ7OIpCKY1g9KtS296p5
	 9H3lbzUhuHa4cdy8H8j75mZ6GJQBNlz27swhdh/8/RQNcBOumrd0Ca8wV0Vr6H20hmRTx
	 RedbX8HLfgdLK9bGdd0Dwaur0ThDuH8j53wSxhC/oblf+xGh6Rq/OEXCkB1Is8E8NBIgx
	 fIlKTRSL7sgJXTJ9dmcJk1G8rI9Itp+dQRLhBTXGMdOGZCXZDk5tH4rJNE2x7fb52Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794629393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Aug5HYuUexp65lrDsNz0aPnl/1iCDZSOI0eqGOeKB/Q=;
	b=nSB2QYazeuFonfwYjBJtlmBD53Kqd0apXNKa/5WOjzj8ajlpDtuFLDrAZvaYZeOg5Kap
	 88AatBdo/M7wMZubuhcSjzXmLzgYJJq1pDOyZHk+/c2HhB9cxLnyk7erL24xqosDCXMyL
	 YFQNFmDCZK1uCrwK83Dv91hhNNPxffCB6Ng9KaiyCaaVwdP5M6yJmgouLziYFIVeFhu/6
	 i+EUwad7V9/qcIpwZT3rYivPZjyOyKOWa/jp0CDQigwStSeYNTtCn+G2yrTwFMgaFv/GR
	 pIkr6xEEbfcaoGDJff+sDVwzBIiis3Csp3WAYo3dgv4DCO782E3tsPY09BcEOshzEYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pCcuU7rt;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C1606A330
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 04:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B8C1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pCcuU7rt
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4918c2d727fso816376f8f.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794629392; x=1795234192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Aug5HYuUexp65lrDsNz0aPnl/1iCDZSOI0eqGOeKB/Q=;
        b=pCcuU7rtvVEVR7ck5sqalvIz2Gyn9Z37WacUtLrd/PED12Hx7Jh393W/1AqAXyUSfP
         +0VAaAUEANN5p/+/K2PGcvJ6TMvyv73o0u2BQx7nN+x1lHk1LPh79HNbKUJe77Kf8qSr
         W4YMusWo5a9KMaupPm7QKUn2jZCr7G2YcJ99zXHHzuSVgpRehlXBFBG8IOuu/zneoXVs
         8p7Hqy/zhuGPZOpsJV/O5kTaumLG/w/n0wer06lwN9hZIJrIOXf3CwsXlbkCxl/3rPnf
         rJLqLGc7buDhpk2vuxM2Wo+YkX+lgPRTUvIIl9CnSyStIcsWPcBbbtVBarfxCRCL/Rm0
         CJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794629392; x=1795234192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Aug5HYuUexp65lrDsNz0aPnl/1iCDZSOI0eqGOeKB/Q=;
        b=BIBnZHQ2YgI69WZQX9Dz4h9wausD6vU4cJgx8QZik7TavgjexXE/7v86xn4axJJLDa
         bKbxnLSIvu5HmQslLjZz4AU74M9jUqPwi6J+Gg+4bMBZR4X/tuou/t0Gh7NFcDo2iUHQ
         aCituN8/iOjYN2ZEywDehXbz6yh/lFIPW+4kKkaL33Zh5q9/CtSbOK1Ssa7dlr/Qg7Oj
         aXKkJGI8VdIjK3LkrvoxPjLiOEXC7PCyhd1ULbtooEiHRrnrRwXvKCilUrzQjOSFYGTH
         aKd7dmUr33u+z+MYuikL2w7m/DI8MGH4T8YtrShsOKnGb/l8wmaBNp4moKGWbMlppX3v
         D7MA==
X-Forwarded-Encrypted: i=1; AL+hErEtNG0vg2fgBx8Euba9HCS9/QEAlt/uTPF3bIckQaLCv1XC3mY4FCe82n+kA9XijOoHzDAZAPM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XLhBgViTLSnHDoXEUJqcF6M6oAO+vFaoq6ePbsTEm30LWBnTu
	x5TOPRbozJm+1LmEDgkM7g9dnoOHJqtYIIyxImEWY3aj4KEfyF/gtU8S
X-Gm-Gg: AYBFou2L8BYB+4As8OUYphj+fQ53ipRcM7QS0PhUYYz20VfTBch0tC5nxBlhP9hFhKb
	Ai7CXo535uYvTvYDt6M0n7zxOjUbTJEVAerIe/VDPNile/6rEhll/HX/YIPs+YYSxCd3GrtuviS
	1aGtN+pReys3vG/8GWYBnyAJOnRE2YD751hmaUGEXt8k3zY2Fa95u3HPnmq5aIbS6SpowXTKFVa
	xaZg+ex1puuVD3w9kADp7o44bT5LrRhtkMf9FWxqvSbDjfYX7gd2e6QiT4MXc4icM3elJJzLRmN
	6bYpPKG6W/+pmVJ5v0ZdmNhTsyb4+Sw+kjvt0mW8pHwbpR8zFtra7pxnPlCcPKUo+EIFgkSzDPb
	rd/rtBuBCdoVDG4NQDqU22RtkXSulBrBNK/fI/io6PtzNsGRs6h94nDCjruTjmnT1azVXLoPnMl
	G7UJFA4S4JC7ymz9mDplkvrCBQeJXzTyM30fWR6e4zftyQOeptW3A+uRp1RnTtLmgHS3IFKN5NL
	DT6pGbGA9ccJvF6IgMZP115jXmM3y4DZL4TSY7yciVGMVkIxx+rKN1dlYquDNLk6WmGjJkBaQ/T
	sQ9v/KLtWvkBEHNuBS+1PH/B7PSqL4XNlIoBnyaOLX7JhbGTmfJTLb6ePP0sj/W+prhFcjScKb4
	ZubugUSGd
X-Received: by 2002:a05:6000:2411:b0:493:59c9:ebcf with SMTP id ffacd0b85a97d-49c7335112dmr9072910f8f.57.1794629391616;
        Fri, 13 Nov 2026 20:09:51 -0800 (PST)
Received: from demian.play.pl (83-175-177-170.dynamic.play.pl. [83.175.177.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c602dsm8488670f8f.46.2026.11.13.20.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 20:09:51 -0800 (PST)
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
Subject: [PATCH v2 1/2] arm64: csum: Add fused copy and Internet checksum
Date: Sat, 14 Nov 2026 03:57:00 +0000
Message-ID: <20261114040943.219870-2-demyansh@gmail.com>
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

arm64 currently falls back to the generic csum_partial_copy_nocheck() in
lib/checksum.c, which performs memcpy() followed by a second pass in
csum_partial(). This double pass is hit on software GSO paths
(skb_segment() without SG or TX checksum offload, e.g. TCP over
WireGuard) and UDP/ICMP replies.

Implement a single-pass csum_partial_copy_nocheck() in
arch/arm64/lib/csum.c using four independent __uint128_t accumulators
over a 32-byte stride, followed by 16/8/4/2/1-byte tail handling. Each
word is read once into a GPR before storing and summing, emitting paired
ldp/stp and adds/cinc carry propagation with no stack frame.

Throughput on ARM Neoverse-V2 (Google Axion, 3.0 GHz, GCC 15.2 -O2,
warm L1 cache):

   len   memcpy + do_csum   csum_partial_copy_nocheck   speedup
  ----   ----------------   -------------------------   -------
    64         10245 MB/s                  15902 MB/s    +55.2%
   256         18851 MB/s                  26026 MB/s    +38.1%
   512         22465 MB/s                  28421 MB/s    +26.5%
  1024         24330 MB/s                  29900 MB/s    +22.9%
  1368         24192 MB/s                  30221 MB/s    +24.9%
  1448         24188 MB/s                  30279 MB/s    +25.2%
  1500         24165 MB/s                  30096 MB/s    +24.5%
  4096         25299 MB/s                  29946 MB/s    +18.4%

Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Demian Shulhan <demyansh@gmail.com>
---
 arch/arm64/include/asm/checksum.h |   3 +
 arch/arm64/lib/csum.c             | 100 ++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

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
diff --git a/arch/arm64/lib/csum.c b/arch/arm64/lib/csum.c
index 75db718e5b6a..a9617cde28c1 100644
--- a/arch/arm64/lib/csum.c
+++ b/arch/arm64/lib/csum.c
@@ -2,8 +2,10 @@
 // Copyright (C) 2019-2020 Arm Ltd.
 
 #include <linux/compiler.h>
+#include <linux/export.h>
 #include <linux/kasan-checks.h>
 #include <linux/kernel.h>
+#include <linux/unaligned.h>
 
 #include <net/checksum.h>
 
@@ -116,6 +118,104 @@ unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
 	return sum >> 16;
 }
 
+static __always_inline __wsum csum_fold128(__uint128_t sum)
+{
+	u64 s;
+
+	sum += (sum >> 64) | (sum << 64);
+	s = sum >> 64;
+	s += (s >> 32) | (s << 32);
+	return (__force __wsum)(u32)(s >> 32);
+}
+
+/*
+ * Single-pass copy and ones' complement sum. Each word is read once into a
+ * GPR before storing and summing, so the returned sum always matches @dst
+ * even if @src is concurrently modified.
+ */
+__wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
+{
+	const u8 *s = src;
+	u8 *d = dst;
+	__uint128_t sum0 = 0, sum1 = 0, sum2 = 0, sum3 = 0;
+	unsigned int n;
+
+	if (unlikely(len <= 0))
+		return 0;
+
+	n = (unsigned int)len >> 5;
+	if (n) {
+		do {
+			u64 v0, v1;
+
+			v0 = get_unaligned((const u64 *)s);
+			v1 = get_unaligned((const u64 *)(s + 8));
+			put_unaligned(v0, (u64 *)d);
+			put_unaligned(v1, (u64 *)(d + 8));
+			sum0 += v0;
+			sum1 += v1;
+
+			v0 = get_unaligned((const u64 *)(s + 16));
+			v1 = get_unaligned((const u64 *)(s + 24));
+			put_unaligned(v0, (u64 *)(d + 16));
+			put_unaligned(v1, (u64 *)(d + 24));
+			sum2 += v0;
+			sum3 += v1;
+
+			s += 32;
+			d += 32;
+		} while (--n);
+
+		sum0 += sum2;
+		sum1 += sum3;
+	}
+
+	if (len & 16) {
+		u64 v0 = get_unaligned((const u64 *)s);
+		u64 v1 = get_unaligned((const u64 *)(s + 8));
+
+		put_unaligned(v0, (u64 *)d);
+		put_unaligned(v1, (u64 *)(d + 8));
+		sum0 += v0;
+		sum1 += v1;
+		s += 16;
+		d += 16;
+	}
+	if (len & 8) {
+		u64 v = get_unaligned((const u64 *)s);
+
+		put_unaligned(v, (u64 *)d);
+		sum0 += v;
+		s += 8;
+		d += 8;
+	}
+	if (len & 4) {
+		u32 v = get_unaligned((const u32 *)s);
+
+		put_unaligned(v, (u32 *)d);
+		sum1 += v;
+		s += 4;
+		d += 4;
+	}
+	if (len & 2) {
+		u16 v = get_unaligned((const u16 *)s);
+
+		put_unaligned(v, (u16 *)d);
+		sum0 += v;
+		s += 2;
+		d += 2;
+	}
+	if (len & 1) {
+		u8 v = *s;
+
+		*d = v;
+		sum1 += v;
+	}
+
+	return csum_fold128(sum0 + sum1);
+}
+EXPORT_SYMBOL(csum_partial_copy_nocheck);
+
 __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 			const struct in6_addr *daddr,
 			__u32 len, __u8 proto, __wsum csum)
-- 
2.53.0

