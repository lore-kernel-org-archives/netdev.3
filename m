Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794103619;
	b=i5UXHYIgCpZJzHhMBlNYn1+zuQwplBE1qTYSDnPZWq99XIKG7fxU+zR2iPA+2DClozS3
	 r4Eo1qyZuoO8eOlt0FMGdUVOOMKg3kqrBjPOb8/z9Ys+HN0qAq6qiLyGB29Bx7cVZl80i
	 F+lAu/DZTAeEzw9ddv0noXMkNP0SEXZuGjN2SHNYPYB3n+fuK3dQMfHbxVBNzCqJrWcZO
	 dKrEbvcoEXtWndKn6GYNIzno0hSVQnJkd6RXXk4YCUPhCsEmQxBpsfiggBz4bPY8XxIDe
	 tenW57qDFWRQw4aFJJ0mTgJ3II72gDZD1zN7Mn8zFp8wIYZBF6mjVPxPGwcN/RwD7iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794103619;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2/D69VEzPM7Q/+SVKhU5ORcgYn8HSMO73uMCYp751oY=;
	b=Caj8u4OW7839QniJGi1+pcTwiatCuvwjqEo/L6ROt4FB8M3iuFp/eCRpQyTVEEivtXX6
	 1E702VWk70L1u6r/ijuGyXuEbjJgz+Q+d1O3lyQsn67nGmmJ0MIcV8m9BIe4X/IpuR/QP
	 awxXmz4gTu4X/Vd57697Qk8umS9z5UhjTdWKSjuwvwSZWdvwUuFR6S9RQ8giqzloWKG/E
	 R7BHMVtUnJB3q+cZ5yg3O0IQ4fNz/N90/UvocT66aCDtm/V3Ia+0u8h1uwefqCXfh1Cm/
	 SyDBqSqgNoaOG37X6iqSC9UktDe/ctwQbv0Uwu9strG9DUXodhkM/LBENGX0hti1mYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=MALCRar1;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3BC606A331;
	Sun,  8 Nov 2026 02:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B3BC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=MALCRar1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=MALCRar1X88OK8ITtk1PjF/ZBkUMbOoqCFBGWMXDO+c/84HKmVy1AcOycZ8IdVhXM3sqUbTLMy7iS
	 5mCxKm2lSm6w+5XefiT4sop7JHRUBsle6QVjI77e21YpYQVUYRiXy/PX8X1raoGdFmGLIGBQ52xtTT
	 Eyz+P00yKI04LkXM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16aefd93dfdc-952a1;
	Sun, 08 Nov 2026 10:06:55 +0800 (CST)
X-RM-TRANSID:2ee16aefd93dfdc-952a1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56aefd91c07a-59b0f;
	Sun, 08 Nov 2026 10:06:54 +0800 (CST)
X-RM-TRANSID:2ee56aefd91c07a-59b0f
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org,
	Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH net 2/2] net: add a KUnit test for the alloc_skb_with_frags() tail split
Date: Sun,  8 Nov 2026 19:06:17 +0900
Message-ID: <20261108100617.23840-3-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108100617.23840-1-yanhaishuang@cmss.chinamobile.com>
References: <20261108100617.23840-1-yanhaishuang@cmss.chinamobile.com>
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

Allocate MAX_SKB_FRAGS - 2 full chunks of PAGE_ALLOC_COSTLY_ORDER plus
a 7 page tail. Rounding the tail down to 4 + 2 + 1 pages would need
one frag more than MAX_SKB_FRAGS, which made the allocation fail with
-ENOBUFS before the previous patch.

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 net/core/net_test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/core/net_test.c b/net/core/net_test.c
index 2b5080c22663..5a451aaf37c9 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -1721,7 +1721,31 @@ static void netmem_ref_test_tcp_devmem_recv(struct kunit *test)
 #endif
 #endif
 
+static void alloc_skb_with_frags_test_tail(struct kunit *test)
+{
+	/* MAX_SKB_FRAGS - 2 full chunks plus a 7 page tail: rounding the
+	 * tail down to 4 + 2 + 1 pages would need one frag too many.
+	 */
+	unsigned long len = (MAX_SKB_FRAGS - 2) *
+			    (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER) +
+			    7 * PAGE_SIZE;
+	unsigned long frags_len = 0;
+	struct sk_buff *skb;
+	int err, i;
+
+	skb = alloc_skb_with_frags(0, len, PAGE_ALLOC_COSTLY_ORDER, &err,
+				   GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL_MSG(test, skb, "err %d", err);
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
+		frags_len += skb_frag_size(&skb_shinfo(skb)->frags[i]);
+	KUNIT_EXPECT_EQ(test, frags_len, len);
+
+	kfree_skb(skb);
+}
+
 static struct kunit_case net_test_cases[] = {
+	KUNIT_CASE(alloc_skb_with_frags_test_tail),
 	KUNIT_CASE_PARAM(gso_test_func, gso_test_gen_params),
 	KUNIT_CASE_PARAM(ip_tunnel_flags_test_run,
 			 ip_tunnel_flags_test_gen_params),
-- 
2.43.0



