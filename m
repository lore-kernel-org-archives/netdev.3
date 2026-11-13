Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529318;
	b=4dvrcxecrxf8VsZYZjkXdpke2ao/gYRphrAw0gqfrKsoPhWrjjmFen/Tkz1O/sgxs3uN
	 R0swYG3ZVjxEvH6C/6zVJqS3e6ZU8BG4e+VUaGVodXb+j5awQE9Bcl+P46+hsEOhhSDxV
	 vG8NNccbwgpcnmYQoQPkTxRT9Nz/eYUP7V6uMNyZF7sfXWzuJYCzsUXO4JoHDv5cjBjvu
	 oHULa02/P1xLWZKGc8hiGx7ups8gAwmTnQWJ7EKqmseAAhN6THcb+WgyEQBsJbzjjctC3
	 m0f9cQbH1T3CjFYoFxJcAQoQ2zW/imNXwAtHsoxWYcBRzD6uaV5RsvnSldcpLN3GA/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=wZ1/3O+YhfcbbkY1C0wb89FLdQ6Dd2GFrUXFxWyv+4Y=;
	b=FiXhQ2UBehRtSPNlbc8ATGQOyy8m6DoU3FQeOn+aSRG6NLlOkVdxs69alZMbbir56qSN
	 8uN4k3y3NohWkVK2nLkS156YlVnXo3xLCuFdHSknWoqe8hNyo18HJsmcYJDlRLn7DmroE
	 EpVER5mS+a7qPuKHYf6od/Is7C907/pXGkIGJ9BYQXByqVBKPVaKw/uWWwnivkMCm2jwu
	 /C2cDxm9a235Cxl9g14vnIoYEbKadgZG3NWvLqq9W/WuA7ykCF+t7O4yOwZUKwdJLVCMR
	 Xz+vKePU9YqxYCK1HF2AFRuTwfPwzv59Ssz1DCP/YvPRExWLbBRdABnlqXdXP3XW0yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=MdVTWTSw;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495D5606A32A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 495D5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=MdVTWTSw
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso7754946d6.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794529317; x=1795134117; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wZ1/3O+YhfcbbkY1C0wb89FLdQ6Dd2GFrUXFxWyv+4Y=;
        b=MdVTWTSwzPcV7FJOC1gXTGPcVuaHygS1YAxX3jbDddl/ny0pebmDaVKkbb3qSwLymi
         Z46IyyTGyqPg0JYlsKtLrwk8EGSmiy4hB7ltDARGddaxiHndU70Eg3odzayJ218ojZVH
         bsQpAjm4F3GmTBiAs00A+rkT/ANyxUEULCz6isICBW/Ab/VR7MbgSorD7gTqZjLFnowE
         45Ol4eUT3xbR5I2sb+qFDr/fKqLu/NQsxnwS0pxS0cxlEY0ilekqKeww1XW51kT2zSae
         OiIDR7XQRXhlKJVC9mGR4IZ5VuHre2elEhFf74cIA8zArNUgkaeQ7/0HIgf+tEPhMAUx
         e1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794529317; x=1795134117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wZ1/3O+YhfcbbkY1C0wb89FLdQ6Dd2GFrUXFxWyv+4Y=;
        b=FNsvXJ2vPaKWyQHqZ3IzKtnaG+R/tlDldxM7Rs31mzfIZtLIBxnF/fHX7h5Q9d1X9T
         5fakMsTofYop+NatAeA1sTKMF7sjVHLLb0HMM2UwvijYwSuATnUTgvB0XOJFnekVRwlO
         G37vtYJr7h4Fdwv22ZU2vZIAx+V6jixfjceRzAaYwYdW5lNhDksX2ArIFFvBTQfXS7K5
         wIgQTFqIuBbzuIWBX6fsfGsmraJeagdZeiHTdDvBHNWaCX2VNSSCgtQD4ML7RAm6zTTI
         tfaS/z9n995Rx2DJqh0YieiDIO1OqI/184Xp2aDaKRVqKZK5NQ56VfetfMvG7pYYNKCH
         tyBg==
X-Forwarded-Encrypted: i=1; AL+hErEotGWnkLP9QYPLwshBTHQFb01+bBM26iYO1UkoBuKZOFCb2Az+aGsyBy5T9D+l8Zprx5K8bK4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fzMc0UGa97k1ghVbCzV+DrImLnYnl3m29JH5ao4pgJ0efSjXv
	Bhzdmy9380IQYc0R3AVs5HbUciaPm/YLJV1fV3c8+cDBttL7JyaKScKxXnRUHp2hZaU=
X-Gm-Gg: AYBFou2QrwRlNViciGiWSqd0h1DydRl63sS6HgnttCfy5sbVEJW86UDzByktVewbAE3
	cantzAVmMvUE2LVA6tuWk11PtLdn1yyozl74xEPAGlXio9bXa5cPZIw9vqa+qof2b8sXLMapwnh
	LnFnLhbr4UCRzPa0U8fKri5LD3CCaE+BSOPq77rE1g43YGugTcz5OaZUbP9Y6LpkTzDyi4D+5xI
	WK14kXmRgkOk2CTFhPo4rLxSE+4A9B2hSPYTuQHIKIu56JnNkq93j93MfoInuR8oDqy4WVIlxAw
	MBmGvR3y9/NfaXKvfbe+aUk1vU2xmoRphf9tLlP7m2z68vkNJiLpap2wSXSEv90f8Hd+XZ6ug4f
	Nhq0kS1+hRBpSG2nzQ8pYdgSn1uTYQNDhWu5MNxCJ/gXfPOK9G6LW8M4aDRop8IibkBUFyiKuC4
	qge6XJ5DF92JCm2HJ9R+7P3dhg0HfNxQX4rgXBOtp51QepT0NXjocVuesmjHJiXlWx0jUzls0pT
	179zjhrJQSDUJSqUR980kWSBo0AQTAgkmTmvJiH0acUx1xjL/5y0p+k0cqKt8d92viWdpiT/NLM
	Vh3Fw2XAO5NOfo4KDzOXShQ3DxM7FuAvPfUIwl9jzjBsJw==
X-Received: by 2002:a05:6214:124f:b0:91c:7a68:2ab3 with SMTP id 6a1803df08f44-91f241b7377mr17078796d6.37.1794529317372;
        Thu, 12 Nov 2026 16:21:57 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d458fdsm7951056d6.9.2026.11.12.16.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:21:56 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 13 Nov 2026 00:21:30 +0000
Subject: [PATCH net-next 3/4] net: compare the payload in the GSO KUnit
 test
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-b4-skb-segment-clone-fixes-v1-3-f777fb06f3e7@toxicpanda.com>
References: <20261113-b4-skb-segment-clone-fixes-v1-0-f777fb06f3e7@toxicpanda.com>
In-Reply-To: <20261113-b4-skb-segment-clone-fixes-v1-0-f777fb06f3e7@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794529294; l=5268;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=WgwtlwnZ8cCkffRanrwjZJd7eTtSyIFHtx5ARy8FpQI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOtiBPTLcF+KoxQNbkn8/Q+x39X9ciHfvUPk7I7H0mw7rmWf2468nSZ8nhHd3YQX96xA6i81YaM
 Vvx6Bx9BLKQk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The GSO KUnit test only compares the lengths of the segments, so it
passes if skb_segment() puts the wrong data into a segment of the right
length.

Fill the skb with bytes that depend on their place in the payload, and
compare the payload of the segments with that pattern.  Also check that
the segments add up to the whole payload.

Turn the assertions on the segments into expectations.  A failed
assertion ends the test at once and leaks the skb and the segments that
are left.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/net_test.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/net/core/net_test.c b/net/core/net_test.c
index 976d14896251..6a1aebac5874 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -372,12 +372,26 @@ static void gso_test_case_to_desc(struct gso_test_case *t, char *desc)
 
 KUNIT_ARRAY_PARAM(gso_test, cases, gso_test_case_to_desc);
 
+/* Each byte depends on its place in the payload, so that data from the wrong
+ * offset of the right piece doesn't compare equal.  251 is prime, so the
+ * pattern doesn't repeat in step with GSO_TEST_SIZE.
+ */
+static void gso_test_fill(void *data, unsigned int len, unsigned int *pos)
+{
+	u8 *p = data;
+
+	while (len--)
+		*p++ = (*pos)++ % 251;
+}
+
 static void gso_test_func(struct kunit *test)
 {
 	const int shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	struct sk_buff *skb, *segs, *cur, *next, *last;
+	unsigned int payload_len, fill = 0, off = 0;
 	const struct gso_test_case *tcase;
 	netdev_features_t features;
+	u8 *payload, *seg_payload;
 	struct page *page;
 	int i;
 
@@ -394,6 +408,7 @@ static void gso_test_func(struct kunit *test)
 	__skb_put(skb, sizeof(hdr) + tcase->linear_len);
 
 	__init_skb(skb);
+	gso_test_fill(skb->data, tcase->linear_len, &fill);
 	skb_shinfo(skb)->gso_type = tcase->gso_type;
 
 	if (tcase->nr_frags) {
@@ -409,6 +424,7 @@ static void gso_test_func(struct kunit *test)
 		}
 
 		KUNIT_ASSERT_LE(test, pg_off, PAGE_SIZE);
+		gso_test_fill(page_address(page), pg_off, &fill);
 
 		skb->data_len = pg_off;
 		skb->len += skb->data_len;
@@ -432,13 +448,16 @@ static void gso_test_func(struct kunit *test)
 						     frag_size + shinfo_size);
 			}
 			KUNIT_ASSERT_NOT_NULL(test, frag_skb);
-			__skb_put(frag_skb, frag_size);
+			gso_test_fill(__skb_put(frag_skb, frag_size), frag_size,
+				      &fill);
 
 			frag_len = tcase->frag_skb_frags ? tcase->frag_skb_frags[i] : 0;
 			if (frag_len) {
+				KUNIT_ASSERT_LE(test, frag_len, PAGE_SIZE);
 				page = alloc_page(GFP_KERNEL);
 				KUNIT_ASSERT_NOT_NULL(test, page);
 				skb_fill_page_desc(frag_skb, 0, page, 0, frag_len);
+				gso_test_fill(page_address(page), frag_len, &fill);
 
 				frag_skb->data_len = frag_len;
 				frag_skb->len += frag_len;
@@ -502,6 +521,18 @@ static void gso_test_func(struct kunit *test)
 		goto free_gso_skb;
 	}
 
+	/* the segments have to hold the bytes of the fill, in its order */
+	payload_len = skb->len;
+	KUNIT_EXPECT_EQ(test, fill, payload_len);
+	payload = kunit_kmalloc(test, payload_len, GFP_KERNEL);
+	seg_payload = kunit_kmalloc(test, payload_len, GFP_KERNEL);
+	if (!payload || !seg_payload) {
+		KUNIT_FAIL(test, "no memory for the payload");
+		goto free_gso_skb;
+	}
+	fill = 0;
+	gso_test_fill(payload, payload_len, &fill);
+
 	segs = skb_segment(skb, features);
 	if (IS_ERR(segs)) {
 		KUNIT_FAIL(test, "segs error %pe", segs);
@@ -518,14 +549,26 @@ static void gso_test_func(struct kunit *test)
 		if (i >= tcase->nr_segs)
 			goto consume;
 
-		KUNIT_ASSERT_EQ(test, cur->len, sizeof(hdr) + tcase->segs[i]);
+		KUNIT_EXPECT_EQ(test, cur->len, sizeof(hdr) + tcase->segs[i]);
 
 		/* segs have skb->data pointing to the mac header */
-		KUNIT_ASSERT_PTR_EQ(test, skb_mac_header(cur), cur->data);
-		KUNIT_ASSERT_PTR_EQ(test, skb_network_header(cur), cur->data + sizeof(hdr));
+		KUNIT_EXPECT_PTR_EQ(test, skb_mac_header(cur), cur->data);
+		KUNIT_EXPECT_PTR_EQ(test, skb_network_header(cur), cur->data + sizeof(hdr));
 
 		/* header was copied to all segs */
-		KUNIT_ASSERT_EQ(test, memcmp(skb_mac_header(cur), hdr, sizeof(hdr)), 0);
+		KUNIT_EXPECT_EQ(test, memcmp(skb_mac_header(cur), hdr, sizeof(hdr)), 0);
+
+		if (off + tcase->segs[i] > payload_len ||
+		    skb_copy_bits(cur, sizeof(hdr), seg_payload,
+				  tcase->segs[i])) {
+			KUNIT_FAIL(test, "can't copy segment %d", i);
+			kfree_skb_list(cur);
+			goto free_gso_skb;
+		}
+		KUNIT_EXPECT_MEMEQ(test, seg_payload, payload + off,
+				   tcase->segs[i]);
+		off += tcase->segs[i];
+
 		if (tcase->gso_segs) {
 			unsigned int gso_segs = tcase->gso_segs[i];
 
@@ -542,13 +585,14 @@ static void gso_test_func(struct kunit *test)
 
 		/* last seg can be found through segs->prev pointer */
 		if (!next)
-			KUNIT_ASSERT_PTR_EQ(test, cur, last);
+			KUNIT_EXPECT_PTR_EQ(test, cur, last);
 
 consume:
 		consume_skb(cur);
 	}
 
-	KUNIT_ASSERT_EQ(test, i, tcase->nr_segs);
+	KUNIT_EXPECT_EQ(test, off, payload_len);
+	KUNIT_EXPECT_EQ(test, i, tcase->nr_segs);
 
 free_gso_skb:
 	consume_skb(skb);

-- 
2.55.0

