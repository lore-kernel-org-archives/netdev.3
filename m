Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837793A4523
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 21:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818085; cv=none; b=QsoVWA2KXgawVICNC9/zCwoxrSVg+pM9uBehC0/9qs1xO646ZL5sqCM8HtiT3Y7552IdZ3/Bz7tqqkTk/DJkgY5OrDS7zRf5bTA+BET/LaTxxZjhB8xIb4EBx1g4eHim7LI5mxEOtBmeomF5LzTROYFTjj5ySGB6Gbvuk+IRXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818085; c=relaxed/simple;
	bh=j0DDQjd0eZ3nMQsdZ3f1Pa74wovJjaApzFKCeaNg59s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrJ40aH1NIVKlCaiGqQtu5OW24xjAiHF06Pwdtw7L9y3Uxf5WEhQ2knVKtV087eet+inb5XN2VVTrD/zuNwWRhSpyXUV5Peajb5TKyDmEcMO/SexJdByFhqydEbruU7c1LXSOpPUD84I/jO7dIvmRSv8smAe8ki0CHRFRUIwUJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDIEO8uy; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDIEO8uy"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-87ab6e5f91eso8064987b3.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788818082; x=1789422882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kt5vYk7oIJTAvWcYqFLR1526VYebZHALzcXyXv4GXys=;
        b=fDIEO8uyl1O4l8QZ+Hw+z3DESPGvz399XC3yrX0UXNA2IMQpMuRDCKzCwK3qH2p8D5
         hMRk06HzLlhGR/coF18S8S2NAj92p9EVOh6hT83WilXDafoS5HPEsqttFNTf3krFEOqQ
         zY4cquifbyoUWyKmMD9adaGbXSpJP/KyLFELKoaqWeRR6lzZBX23zU0AW0kiLgpcl6wX
         Uw8BT4krYyd8mYPzm5Hu8JDE1Sb9qMEHX+0jKZoQtfl+ZlONSA08tp0CG/D48PadTIAF
         R3Lna6sIx+2pjTPUhPzvVbA+74ajzF0Z/57uhr2jhtqaMKOFcwk/pJNa1bHcR5Gu1LA9
         7isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788818082; x=1789422882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kt5vYk7oIJTAvWcYqFLR1526VYebZHALzcXyXv4GXys=;
        b=pND3EnoVAq1Y6/dFNLbV2UPNwTXT0ffGSRxVOxqa0KDMFenB5Jl5ER5t8BcxPhRy51
         rSb1cmusfVsorWzejIHrN89Mrden0R4+mV/Q6CoqSHfF+IHyPrcOTavDqT2uZ2XwfYqS
         W7jeHCWcpcUz0AHJbBnFxEoP0RniN7re42GGPaW38ODZ3JdoWmdDNK6JRjmtJS85Fkgy
         l5sHPPomkpPHTvMK5JUP5E0Ly8WtIDCvqGIjMaPHJHLzuMVDghjh5d6GxXgFt9nSotuQ
         D38U4LPslf7uzOS12WmZzx31YL42SzjR+mGrykNd1pLclETvSdFuWfOgW4wWiYCqRtve
         H6bQ==
X-Forwarded-Encrypted: i=1; AKwUvBzty6dvHQgJogjLNYSM1xytv29DFL4j6fTZ/i5miv3sYtWOCuGU1DFlj7efG9CyQw9Edp2CRYw=@vger.kernel.org
X-Gm-Message-State: AFuF++lVEfvNho+L5k64uVypS1Of2mfrHVigWbDHwhyI1CjdH48l8Ry7
	epsD53CzlI80vJGgJ5RtrHZ6VRNZ98GTey68J8lKFhbLSdvqth416ITj
X-Gm-Gg: AYBFou3mem3k44gyl8Bv6oPratF3xwoUn41z2hKn2JXwApEpCj9NRYjT2TasCz7Eojp
	gMlsExpB+FkpVMlJLTZVV8xabj0kIUUAjcX/rqn9q7Sm+ofv1KCbiAf2IIjh3NFBY23N5Lsjt5c
	1FC0Aq7I+hNjG6G44tXuDqoRdBfzRGlDSvBnP4O1TREPuP6QXkIV5JSh+L8J1Fh39PZ2QG7z+bL
	iFyOcSVm9OUWbhLbjzfcbdFDFgPfPM1QmBd1EWkTYNuDD7FJsDsoxlay67mm8vMDvCMc2h2KgSM
	coKH8A1JhbRc8R/sF5QX0mkksTBl8bpKI6uNWSQX+5I5izQEtpB2PlIx52DpZLWUoHiInmHFRtE
	eV5TrzzaWl3h2tLTygalef4uHJgXr/bX9WBXWsQ4EJtt5JFNa9wjtZM9BXuNHPgHvdj8rvfKNjK
	xvzJnOicyJxgi008rczjuzVpOiOBzfViKDf3tkgDnKir96GShUP1r4ZpxT0LW2CElCeX26eQqkr
	MsLtiTvs2mSzBYbnA==
X-Received: by 2002:a05:690c:4f02:b0:81e:eebb:8e4a with SMTP id 00721157ae682-87123521b7fmr78031777b3.12.1788818082551;
        Mon, 07 Sep 2026 14:54:42 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714bb0efc1sm77847347b3.45.2026.09.07.14.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:54:42 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-usb@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/9] bitmap: add bitmap_and_and() and bitmap_and_andnot()
Date: Mon,  7 Sep 2026 17:54:30 -0400
Message-ID: <20260907215439.409858-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907215439.409858-1-ynorov@nvidia.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bitmap_and_and() and bitmap_and_andnot() to combine three bitmaps
in a single pass. Both helpers return whether the resulting bitmap is
non-empty.

Introduce BITMAP_OP() to share the word iteration with bitmap_and(),
and add tests for small constants, multiword bitmaps, aliases, tail
masking, empty results and zero-sized bitmaps.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/bitmap.h | 32 +++++++++++++++++
 lib/bitmap.c           | 46 +++++++++++++++++++------
 lib/test_bitmap.c      | 78 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+), 10 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 7df1573a409c..d524ef6b0300 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -44,6 +44,10 @@ struct device;
  *  bitmap_fill(dst, nbits)                     *dst = ~0UL
  *  bitmap_copy(dst, src, nbits)                *dst = *src
  *  bitmap_and(dst, src1, src2, nbits)          *dst = *src1 & *src2
+ *  bitmap_and_and(dst, src1, src2, src3, nbits)
+ *                                               *dst = *src1 & *src2 & *src3
+ *  bitmap_and_andnot(dst, src1, src2, src3, nbits)
+ *                                               *dst = *src1 & *src2 & ~(*src3)
  *  bitmap_or(dst, src1, src2, nbits)           *dst = *src1 | *src2
  *  bitmap_weighted_or(dst, src1, src2, nbits)	*dst = *src1 | *src2. Returns Hamming Weight of dst
  *  bitmap_weighted_xor(dst, src1, src2, nbits)	*dst = *src1 ^ *src2. Returns Hamming Weight of dst
@@ -166,6 +170,12 @@ void bitmap_cut(unsigned long *dst, const unsigned long *src,
 		unsigned int first, unsigned int cut, unsigned int nbits);
 bool __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int nbits);
+bool __bitmap_and_and(unsigned long *dst, const unsigned long *bitmap1,
+		      const unsigned long *bitmap2,
+		      const unsigned long *bitmap3, unsigned int nbits);
+bool __bitmap_and_andnot(unsigned long *dst, const unsigned long *bitmap1,
+			 const unsigned long *bitmap2,
+			 const unsigned long *bitmap3, unsigned int nbits);
 void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int nbits);
 unsigned int __bitmap_weighted_or(unsigned long *dst, const unsigned long *bitmap1,
@@ -337,6 +347,28 @@ bool bitmap_and(unsigned long *dst, const unsigned long *src1,
 	return __bitmap_and(dst, src1, src2, nbits);
 }
 
+static __always_inline
+bool bitmap_and_and(unsigned long *dst, const unsigned long *src1,
+		    const unsigned long *src2, const unsigned long *src3,
+		    unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return (*dst = *src1 & *src2 & *src3 &
+			       BITMAP_LAST_WORD_MASK(nbits)) != 0;
+	return __bitmap_and_and(dst, src1, src2, src3, nbits);
+}
+
+static __always_inline
+bool bitmap_and_andnot(unsigned long *dst, const unsigned long *src1,
+		       const unsigned long *src2, const unsigned long *src3,
+		       unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return (*dst = *src1 & *src2 & ~(*src3) &
+			       BITMAP_LAST_WORD_MASK(nbits)) != 0;
+	return __bitmap_and_andnot(dst, src1, src2, src3, nbits);
+}
+
 static __always_inline
 void bitmap_or(unsigned long *dst, const unsigned long *src1,
 	       const unsigned long *src2, unsigned int nbits)
diff --git a/lib/bitmap.c b/lib/bitmap.c
index ed685127a107..85ce3cbaa9ab 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -34,6 +34,25 @@
  * for the best explanations of this ordering.
  */
 
+/*
+ * Common helper for bitmap operations.
+ * @FETCH: The expression that fetches and combines each word of the bitmaps
+ * @bits: The bitmap size in bits
+ */
+#define BITMAP_OP(FETCH, bits)							\
+({										\
+	unsigned long idx, val, sz = (bits), result = 0;			\
+										\
+	for (idx = 0; idx * BITS_PER_LONG < sz; idx++) {			\
+		val = (FETCH);							\
+		if (sz - idx * BITS_PER_LONG < BITS_PER_LONG)		\
+			val &= BITMAP_LAST_WORD_MASK(sz);			\
+		result |= (dst[idx] = val);					\
+	}									\
+										\
+	result != 0;								\
+})
+
 bool __bitmap_equal(const unsigned long *bitmap1,
 		    const unsigned long *bitmap2, unsigned int bits)
 {
@@ -230,19 +249,26 @@ EXPORT_SYMBOL(bitmap_cut);
 bool __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 				const unsigned long *bitmap2, unsigned int bits)
 {
-	unsigned int k;
-	unsigned int lim = bits/BITS_PER_LONG;
-	unsigned long result = 0;
-
-	for (k = 0; k < lim; k++)
-		result |= (dst[k] = bitmap1[k] & bitmap2[k]);
-	if (bits % BITS_PER_LONG)
-		result |= (dst[k] = bitmap1[k] & bitmap2[k] &
-			   BITMAP_LAST_WORD_MASK(bits));
-	return result != 0;
+	return BITMAP_OP(bitmap1[idx] & bitmap2[idx], bits);
 }
 EXPORT_SYMBOL(__bitmap_and);
 
+bool __bitmap_and_and(unsigned long *dst, const unsigned long *bitmap1,
+		      const unsigned long *bitmap2,
+		      const unsigned long *bitmap3, unsigned int bits)
+{
+	return BITMAP_OP(bitmap1[idx] & bitmap2[idx] & bitmap3[idx], bits);
+}
+EXPORT_SYMBOL(__bitmap_and_and);
+
+bool __bitmap_and_andnot(unsigned long *dst, const unsigned long *bitmap1,
+			 const unsigned long *bitmap2,
+			 const unsigned long *bitmap3, unsigned int bits)
+{
+	return BITMAP_OP(bitmap1[idx] & bitmap2[idx] & ~bitmap3[idx], bits);
+}
+EXPORT_SYMBOL(__bitmap_and_andnot);
+
 void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 				const unsigned long *bitmap2, unsigned int bits)
 {
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 56bd23059b26..fbc46ed960a4 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -193,6 +193,81 @@ static void __init test_zero_clear(void)
 	expect_eq_pbl("", bmap, 1024);
 }
 
+static void __init test_bitmap_and(void)
+{
+	enum { nbits = BITS_PER_LONG + 13 };
+	DECLARE_BITMAP(src1, nbits);
+	DECLARE_BITMAP(src2, nbits);
+	DECLARE_BITMAP(src3, nbits);
+	DECLARE_BITMAP(dst, nbits);
+	DECLARE_BITMAP(expected, nbits);
+	unsigned long small_src1 = ~0UL;
+	unsigned long small_src2 = ~0UL;
+	unsigned long small_src3 = BIT(2);
+	unsigned long small_dst;
+	bool ret;
+
+	ret = bitmap_and_and(&small_dst, &small_src1, &small_src2,
+			     &small_src3, 4);
+	expect_eq_ulong(true, ret);
+	expect_eq_ulong(BIT(2), small_dst);
+
+	ret = bitmap_and_andnot(&small_dst, &small_src1, &small_src2,
+				&small_src3, 4);
+	expect_eq_ulong(true, ret);
+	expect_eq_ulong(GENMASK(3, 0) & ~BIT(2), small_dst);
+
+	bitmap_zero(src1, nbits);
+	bitmap_zero(src2, nbits);
+	bitmap_zero(src3, nbits);
+	bitmap_zero(expected, nbits);
+	__set_bit(1, src1);
+	__set_bit(2, src1);
+	__set_bit(BITS_PER_LONG + 1, src1);
+	__set_bit(BITS_PER_LONG + 12, src1);
+	__set_bit(BITS_PER_LONG + 13, src1);
+	__set_bit(1, src2);
+	__set_bit(BITS_PER_LONG + 1, src2);
+	__set_bit(BITS_PER_LONG + 12, src2);
+	__set_bit(BITS_PER_LONG + 13, src2);
+	__set_bit(BITS_PER_LONG + 1, src3);
+	__set_bit(1, expected);
+	__set_bit(BITS_PER_LONG + 1, expected);
+	__set_bit(BITS_PER_LONG + 12, expected);
+
+	ret = bitmap_and(dst, src1, src2, nbits);
+	expect_eq_ulong(true, ret);
+	expect_eq_bitmap(expected, dst, nbits);
+	expect_eq_ulong(BIT(1) | BIT(12), dst[1]);
+
+	bitmap_zero(expected, nbits);
+	__set_bit(BITS_PER_LONG + 1, expected);
+	ret = bitmap_and_and(dst, src1, src2, src3, nbits);
+	expect_eq_ulong(true, ret);
+	expect_eq_bitmap(expected, dst, nbits);
+	expect_eq_ulong(BIT(1), dst[1]);
+
+	bitmap_zero(expected, nbits);
+	__set_bit(1, expected);
+	__set_bit(2, expected);
+	__set_bit(BITS_PER_LONG + 12, expected);
+	ret = bitmap_andnot(dst, src1, src3, nbits);
+	expect_eq_ulong(true, ret);
+	expect_eq_bitmap(expected, dst, nbits);
+	expect_eq_ulong(BIT(12), dst[1]);
+
+	__clear_bit(2, expected);
+	ret = bitmap_and_andnot(src2, src1, src2, src3, nbits);
+	expect_eq_ulong(true, ret);
+	expect_eq_bitmap(expected, src2, nbits);
+	expect_eq_ulong(BIT(12), src2[1]);
+
+	bitmap_fill(src3, nbits);
+	ret = bitmap_and_andnot(src2, src1, src2, src3, nbits);
+	expect_eq_ulong(false, ret);
+	expect_eq_pbl("", src2, nbits);
+}
+
 static void __init test_find_nth_bit(void)
 {
 	unsigned long b, bit, cnt = 0;
@@ -1533,6 +1608,8 @@ static void __init test_zero_nbits(void)
 	bitmap_zero(NULL, 0);
 
 	ret = bitmap_and(NULL, NULL, NULL, 0);
+	ret = bitmap_and_and(NULL, NULL, NULL, NULL, 0);
+	ret = bitmap_and_andnot(NULL, NULL, NULL, NULL, 0);
 	ret = bitmap_empty(NULL, 0);
 	ret = bitmap_equal(NULL, NULL, 0);
 	ret = bitmap_full(NULL, 0);
@@ -1566,6 +1643,7 @@ static void __init test_zero_nbits(void)
 static void __init selftest(void)
 {
 	test_zero_clear();
+	test_bitmap_and();
 	test_fill_set();
 	test_copy();
 	test_bitmap_region();
-- 
2.53.0

