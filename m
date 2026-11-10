Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309818;
	b=ofwq+TraEqMIEHu1hSbVMdc0grsHAMSpyMN/diip6EF4cpz8lyRHxqXopVNRh++lkOpR
	 bzGQFKv/gRHFhZyHnetN2JwIa0k2aVmve8hRolYntzBcJSru+ngnT8gXNHf0RnkIxorFe
	 70uCN4uF+j4MBgQceXa0vIOR0as/KvHJitoOqSAY+kq0sVCr1mDJMdH2EaBewoG00V2kj
	 8MAdQrWDEP248UqTHNnfjM/cSSXwDW2hqSdxWq7823Hgj3ux721IPWRk1KEoXsNbOC7AM
	 8OGllBCxwVsW8IoLNfheaN87Exi5i8u7AeGwhKBPO1n4PoWu51X4C0QUtlTKrCiYCLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309818;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4VJcYhCNPCtRBv/DHhtqAYLeQVZj55bW9jLRi4lVOq4=;
	b=RhCczpBHqgl3Zd29iiB1dlhh0zPu3PHbgpoEYLItO7dKjG+arX2SoBCkGWwT0Dhw62cB
	 34e6dtjIS5kddVnvCd3u0sy4ssgyTzfpFErKyuP5qW54ZPqB+hRjnPI66rd6+mALvkPd0
	 jhXqx+yV5F2H2RxFLVjCeXqdjsT5jllDBwQ/wW5C/bXhlB8iwqi6SKnNhKGAyZycnnkCq
	 Ec7jNAnLrEZCBuAgTMrtjZE/UPg1Xuel8yo1TOU5jGOb/8GMCgwxCJTPKZDv14vnL+ol+
	 eLOl5V5ByNNV0ct6xWMVUMWkwS/9j9Quayx3y4ZK87ziigxP7B7lj8iuxatgItbzDgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fVi4BJmf;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YsPaqJPb;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5FF606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD5FF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fVi4BJmf;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YsPaqJPb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794309816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VJcYhCNPCtRBv/DHhtqAYLeQVZj55bW9jLRi4lVOq4=;
	b=fVi4BJmfUeWdGCT7Bnziou8YOPD1JF8oG8BSONW9QUDjbN1T5LcOt84W2snOPsrB/Ph+wP
	8sVDGCBZNrtNNFscUr+wopR6qr85AqRPSG5TWopPGIyXeDsc6ox0RQrb2yKIwC/i1R5hgX
	9Pb4Bd7hNyx85JG7hqLEVpQwP7tjQEA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-p8SqPnxvMO-EndgS6zLuJw-1; Tue, 10 Nov 2026 06:23:35 -0500
X-MC-Unique: p8SqPnxvMO-EndgS6zLuJw-1
X-Mimecast-MFC-AGG-ID: p8SqPnxvMO-EndgS6zLuJw_1794309815
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91ea864ee9cso52877326d6.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794309815; x=1794914615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4VJcYhCNPCtRBv/DHhtqAYLeQVZj55bW9jLRi4lVOq4=;
        b=YsPaqJPbk/QkqWDJUlEOrPcCCsHHhqYKpPagE+xTr7ZKYIrkxW876B6heyX6cO/Yai
         KgrycaPJX0xuvtjC/Fab4727dBaG98/1s/BAgzBm3fcl/Q9CWX2HKPw5JNvFrXi3JrGg
         6ADH9hTaCbI1Lv+v90d4cqpw8a+iQRTIY9HBE+c1Tpisf32UIFEUjIEs4IC/j80pzVsg
         98Im11lCYzggHWTiwqsLE9+hTEGuakRM/U/wEoPKTJ+qcpdb04/Cxx9uiTL6nw+rrwj3
         v5UNtno2UHifsjrf/7cIUConAV7cmsVY6x/75RZIxjmgm+8DtenEJ5ArpuqO7d55PRGF
         Su7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309815; x=1794914615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4VJcYhCNPCtRBv/DHhtqAYLeQVZj55bW9jLRi4lVOq4=;
        b=jHv4Zg3TEi6mRokWzI8jP1lgMM4yA+GnKJQpQ2mRRf6kD6TXFzQVBTHn/6SHv8IXy1
         9lV3erXrKPdYJOlH91L4Ogyt4QZyripJ8vXH/W+HYDZHNWR1sDI6xfzZbUO48P7Tvq12
         yQblXm2xCouffO25dTrwjjB+fbQoZTv4zPIzyAlI0mc/M1Sw/LlQUi1GmXojj79t89/J
         Ch20n7hrz3aRSIQaKbT+OWdmrxdlJY8aRwJUli27RHtASoh7tH2yLspeZfYTUsU77IIf
         EawcM2mI+QA2JKxNy2djLdR8TNtJSdLsYuBS1km4GxWZQmIxmyopmHY1OKU+eRg9GtbP
         EbGg==
X-Forwarded-Encrypted: i=1; AL+hErGA+o0ACukOb8TsgVvTYqIdiXTTkUaXXeHxq+3BvgM4wvrpotB3r1oeCW0v0f7xBjLlgrYBWyU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MfXUgdNOXrUNYjyIuQCmKb7GqBP+4cFsHIIJSKQtUDynzcuTd
	83FgHC9QCFVRLua+uV1wnJrn57TgkNnoJMNmuhl6Z7kZfoDorFfWXPV7C2GNCMR7p/rv5so+T8F
	gFFT61cdeYMRr8F4lND94GSv9Q3ShILxraFMZVNO8cVhZtnq7uWZ9pTZF1w==
X-Gm-Gg: AYBFou1ZUBh3qfx0O38KRreYDYNWH2F78TW7ChRciHLP29eFhQUA2a4BVWjoU+qZfj8
	knnX+qqvNTikq/CdqFLfLLfLgRaFFbaeJ2kXj5ZhYZHohR+08cbfbhWTiowS8bCFx2edQMcA/oh
	iHnE1AOXln7Pfc4KOfrT0cop0mCnCplZ/dmedJT4SShhPb3g3WSxyzlRDu0TG1pErykx0oi40rB
	/2aC0kdTJkjLWBb/KixKqMc/4ju62JomGQQsqS3rBbd0raQMa1n476FuYyzOtYoJ79CLlIk9yps
	1DX5jEaL9WbR8PlJjK2y5lATWzE/xv0FLZ92otQrjEWT6vBXeD0W2ZwIzT9P27qmu9jreU9Z/QY
	WBdOor+5tBlnKIUgAL/Ne5K65TykLn6X9lD9A4GbgF2z9ytJgikRpUW7AXjiIMbH8b6whyh7gsP
	ePyOqfyBpeu3ecNajpGrYs+/1bgrtFUPfsGJkfN3W3uyJ52um0UuneykFC3VRtU5FnIs2vuMGib
	i14vaEn2udgJ6uAL7BTeqGBzE5jSrh6mjVF0sX3sLgOGWxd2pTQ
X-Received: by 2002:a05:6214:62d0:10b0:91e:f174:bc36 with SMTP id 6a1803df08f44-91ef174c14amr19800036d6.26.1794309814649;
        Tue, 10 Nov 2026 03:23:34 -0800 (PST)
X-Received: by 2002:a05:6214:62d0:10b0:91e:f174:bc36 with SMTP id 6a1803df08f44-91ef174c14amr19799816d6.26.1794309814015;
        Tue, 10 Nov 2026 03:23:34 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04e7315sm18569186d6.22.2026.11.10.03.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:23:33 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 4/4] net: add basic splice KUnit tests
Date: Tue, 10 Nov 2026 11:23:25 +0000
Message-Id: <20261110112325.3263078-5-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110112325.3263078-1-amarkuze@redhat.com>
References: <20261110112325.3263078-1-amarkuze@redhat.com>
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

Add small KUnit checks for the generic extraction and direct BVEC paths.
Exercise a multi-page folio over short appends and resumption, checking
payload, checksum, fragment count and ordinary references through release.

Check zero-length requests and rejected-page rollback with and without an
accepted prefix, comparing iterator position as well as remaining length.
Use separate valid and rejected segments, without a mapping fixture.
These are basic helper regressions, not an exhaustive ownership,
arithmetic-boundary or device test suite.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 net/core/net_test.c | 170 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/net/core/net_test.c b/net/core/net_test.c
index 2b5080c22663..c295560afbd4 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -1721,7 +1721,177 @@ static void netmem_ref_test_tcp_devmem_recv(struct kunit *test)
 #endif
 #endif
 
+/* skb_splice_from_iter() */
+
+#include <linux/bvec.h>
+#include <net/checksum.h>
+#include <net/hotdata.h>
+
+struct splice_basic {
+	struct sk_buff *skb;
+	struct folio *folio;
+};
+
+static void splice_basic_free_skb(struct splice_basic *c)
+{
+	int refs, nr;
+
+	if (!c->skb)
+		return;
+	nr = skb_shinfo(c->skb)->nr_frags;
+	refs = folio_ref_count(c->folio);
+	/* Keep the owner alive during cleanup of a missing-reference failure. */
+	if (refs <= nr)
+		folio_ref_add(c->folio, nr + 1 - refs);
+	kfree_skb(c->skb);
+	c->skb = NULL;
+}
+
+static void splice_basic_release(void *data)
+{
+	struct splice_basic *c = data;
+
+	splice_basic_free_skb(c);
+	if (c->folio)
+		folio_put(c->folio);
+}
+
+static struct splice_basic *splice_basic_new(struct kunit *test)
+{
+	struct splice_basic *c = kunit_kzalloc(test, sizeof(*c), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, c);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, splice_basic_release, c), 0);
+	c->folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, 1);
+	KUNIT_ASSERT_NOT_NULL(test, c->folio);
+	c->skb = alloc_skb(64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, c->skb);
+	return c;
+}
+
+static void splice_basic_iter(struct iov_iter *iter, struct bio_vec *bv,
+			      struct kvec *kv, unsigned int nr, bool bvec)
+{
+	size_t len = 0;
+	unsigned int i;
+
+	for (i = 0; i < nr; i++) {
+		kv[i].iov_base = page_address(bv[i].bv_page) + bv[i].bv_offset;
+		kv[i].iov_len = bv[i].bv_len;
+		len += bv[i].bv_len;
+	}
+	if (bvec)
+		iov_iter_bvec(iter, ITER_SOURCE, bv, nr, len);
+	else
+		iov_iter_kvec(iter, ITER_SOURCE, kv, nr, len);
+}
+
+static void splice_basic_expect_iter(struct kunit *test, struct iov_iter *iter,
+				     const struct iov_iter *want)
+{
+	KUNIT_EXPECT_EQ(test, iov_iter_count(iter), iov_iter_count(want));
+	KUNIT_EXPECT_EQ(test, iter->iov_offset, want->iov_offset);
+	KUNIT_EXPECT_EQ(test, iter->nr_segs, want->nr_segs);
+	KUNIT_EXPECT_PTR_EQ(test,
+			    iov_iter_is_bvec(iter) ? (const void *)iter->bvec : iter->kvec,
+			    iov_iter_is_bvec(want) ? (const void *)want->bvec : want->kvec);
+}
+
+static void skb_splice_basic_append(struct kunit *test)
+{
+	unsigned int bvec;
+
+	if (IS_ENABLED(CONFIG_HIGHMEM) &&
+	    READ_ONCE(net_hotdata.sysctl_max_skb_frags) < 2)
+		kunit_skip(test, "two page-bounded fragments need two slots");
+	for (bvec = 0; bvec < 2; bvec++) {
+		struct splice_basic *c = splice_basic_new(test);
+		size_t len = PAGE_SIZE + 64, first = PAGE_SIZE - 27;
+		unsigned int nr = IS_ENABLED(CONFIG_HIGHMEM) ? 2 : 1;
+		u8 *data = folio_address(c->folio) + 17;
+		u8 *copy = kunit_kmalloc(test, len, GFP_KERNEL);
+		struct bio_vec bv[2];
+		struct iov_iter iter;
+		struct kvec kv[2];
+		size_t i;
+
+		KUNIT_ASSERT_NOT_NULL(test, copy);
+		for (i = 0; i < len; i++)
+			data[i] = (u8)(i * 13 + 7);
+		bvec_set_page(&bv[0], &c->folio->page, PAGE_SIZE - 17, 17);
+		bvec_set_page(&bv[1], folio_page(c->folio, 1), 81, 0);
+		splice_basic_iter(&iter, bv, kv, 2, bvec);
+		KUNIT_ASSERT_EQ(test, skb_splice_from_iter(c->skb, &iter, first),
+				(ssize_t)first);
+		KUNIT_EXPECT_EQ(test, iov_iter_count(&iter), len - first);
+		KUNIT_ASSERT_EQ(test, skb_splice_from_iter(c->skb, &iter, len),
+				(ssize_t)(len - first));
+		KUNIT_EXPECT_EQ(test, iov_iter_count(&iter), 0UL);
+		KUNIT_EXPECT_EQ(test, c->skb->len, (unsigned int)len);
+		KUNIT_EXPECT_EQ(test, skb_shinfo(c->skb)->nr_frags, nr);
+		KUNIT_EXPECT_EQ(test, folio_ref_count(c->folio), (int)nr + 1);
+		KUNIT_ASSERT_EQ(test, skb_copy_bits(c->skb, 0, copy, len), 0);
+		KUNIT_EXPECT_MEMEQ(test, copy, data, len);
+		KUNIT_EXPECT_EQ(test, (__force u16)csum_fold(c->skb->csum),
+				(__force u16)csum_fold(csum_partial(data, len, 0)));
+		splice_basic_free_skb(c);
+		KUNIT_EXPECT_EQ(test, folio_ref_count(c->folio), 1);
+	}
+}
+
+static void skb_splice_basic_progress(struct kunit *test)
+{
+	unsigned int bvec;
+
+	for (bvec = 0; bvec < 2; bvec++) {
+		struct splice_basic *c = splice_basic_new(test);
+		void *bad = kunit_kmalloc(test, 16, GFP_KERNEL);
+		struct bio_vec bv[2];
+		struct iov_iter iter, expected;
+		struct kvec kv[2];
+		ssize_t ret = 0;
+
+		KUNIT_ASSERT_NOT_NULL(test, bad);
+		KUNIT_ASSERT_TRUE(test, PageSlab(virt_to_page(bad)));
+		bvec_set_page(&bv[0], &c->folio->page, PAGE_SIZE, 0);
+		splice_basic_iter(&iter, bv, kv, 1, bvec);
+		expected = iter;
+		KUNIT_EXPECT_EQ(test, skb_splice_from_iter(c->skb, &iter, 0), 0);
+		splice_basic_expect_iter(test, &iter, &expected);
+		KUNIT_EXPECT_EQ(test, c->skb->len, 0U);
+		KUNIT_EXPECT_EQ(test, folio_ref_count(c->folio), 1);
+
+		bvec_set_page(&bv[0], virt_to_page(bad), 16, offset_in_page(bad));
+		splice_basic_iter(&iter, bv, kv, 1, bvec);
+		expected = iter;
+		kunit_warning_suppress(test) {
+			ret = skb_splice_from_iter(c->skb, &iter, 16);
+		}
+		KUNIT_EXPECT_EQ(test, ret, (ssize_t)-EIO);
+		splice_basic_expect_iter(test, &iter, &expected);
+		KUNIT_ASSERT_EQ(test, skb_shinfo(c->skb)->nr_frags, 0);
+
+		bvec_set_page(&bv[0], &c->folio->page, PAGE_SIZE, 0);
+		bvec_set_page(&bv[1], virt_to_page(bad), 16, offset_in_page(bad));
+		splice_basic_iter(&iter, bv, kv, 2, bvec);
+		expected = iter;
+		iov_iter_advance(&expected, PAGE_SIZE);
+		kunit_warning_suppress(test) {
+			ret = skb_splice_from_iter(c->skb, &iter, PAGE_SIZE + 16);
+		}
+		KUNIT_EXPECT_EQ(test, ret, (ssize_t)PAGE_SIZE);
+		splice_basic_expect_iter(test, &iter, &expected);
+		KUNIT_EXPECT_EQ(test, c->skb->len, (unsigned int)PAGE_SIZE);
+		KUNIT_EXPECT_EQ(test, folio_ref_count(c->folio), 2);
+		splice_basic_free_skb(c);
+		KUNIT_EXPECT_EQ(test, folio_ref_count(c->folio), 1);
+	}
+}
+
 static struct kunit_case net_test_cases[] = {
+	KUNIT_CASE(skb_splice_basic_append),
+	KUNIT_CASE(skb_splice_basic_progress),
 	KUNIT_CASE_PARAM(gso_test_func, gso_test_gen_params),
 	KUNIT_CASE_PARAM(ip_tunnel_flags_test_run,
 			 ip_tunnel_flags_test_gen_params),
-- 
2.34.1

