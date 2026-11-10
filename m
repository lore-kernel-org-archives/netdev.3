Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299494;
	b=YzkQ9muHXyJ4HzAL+kI96zNKnlyoBeetC1DfZ1YImAqxLC3pOi8ABKnZdpSRnxL1J1HR
	 BvQ6ArL1efplqh1epwAswga1rtpumk3Gji84KqZDugd1j5y29f/KhOblafflsYzNu3YDa
	 4oCWO2igs+ch9zb0kWm+7CbdNmtNzsHt3WWDg8uNNGsvFJOiE5wwbmI9lFFf841V2cGRL
	 DsHfSbgXEBd04tTbEPjQL2prgGRw5pp8z1aY/ZGw603WnGJ7dK4iXN2B2E7wZVczUSjfw
	 3/xN/4XN8R2D1yNNWmENhWyBvpiqmC2bx6HjW9LkrfsCg85MzVE/5pwU92X90kaDVMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299494;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8ZQbE7xbgGHd5rSqzpLHSRaLZ3RAI7UfOG38tZ91rS8=;
	b=xA8IZGwvmc94fCrUrteYO99vAHVlzT2/XkwAFVOkryaThKSESelPxKeAnHWe8vQ7mesg
	 6WgQWo5lVmICVvzHtl+8THFTS+IZb1W7K/Mxz4hy9kcujKng8lQy9IWWqmrQlCmQehoS4
	 gf7GEsT+fMB+WCg5c0qjiKx4z1EGj0E7jD1swlIo5ZO5EkhTlPgjDixBNKBAMDbxPapjO
	 L1my/WgCJfNo6CCxKH5dqBsJHqqdgJOReQqsv02NTQhNSfgPitgXgffEDvtL0u17XdsXo
	 NeXB1tUwAaam89xSlp0FgVc6EZK+fTygXJm3ta3I0aoAJHyEqxvsoWK3bxAZr8Qw3hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=AVEUWYHk;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56C0606D030;
	Tue, 10 Nov 2026 08:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D56C0606D030
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=AVEUWYHk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=AVEUWYHk8UXxEpbpRVBJhJRMsb1RbbXt0cLwGeLrX3prowvizxEDjK1hZfCCTkdIL75Ot5+yXto3p
	 xgpDVg9Nv8MV6mMAZ3ypk2jo7AB34lQTiGlWz2VIrOpFo+K3uA5Nifldtyo2lrBbhdhTD6L8c/1Edv
	 av+h2CYVnTfbYFx4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66af2d663eac-99a50;
	Tue, 10 Nov 2026 16:31:31 +0800 (CST)
X-RM-TRANSID:2ee66af2d663eac-99a50
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af2d6503b8-ae1ce;
	Tue, 10 Nov 2026 16:31:31 +0800 (CST)
X-RM-TRANSID:2ee76af2d6503b8-ae1ce
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: yanhaishuang@cmss.chinamobile.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	almasrymina@google.com,
	daniel@iogearbox.net,
	willemb@google.com,
	willemdebruijn.kernel@gmail.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	narcisav.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/2] net: add a KUnit test for the alloc_skb_with_frags() tail split
Date: Wed, 11 Nov 2026 01:24:18 +0900
Message-ID: <20261110162418.28322-3-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110162418.28322-1-yanhaishuang@cmss.chinamobile.com>
References: <20261110162418.28322-1-yanhaishuang@cmss.chinamobile.com>
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
-ENOBUFS before "net: do not run out of frags in
alloc_skb_with_frags()".

If the allocation fails and no order-3 page can be had either, skip the
test instead of failing it, so that a host with fragmented memory does
not report this as a regression.

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 net/core/net_test.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/net/core/net_test.c b/net/core/net_test.c
index 2b5080c226636..de4d246f2f7ab 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -1721,7 +1721,42 @@ static void netmem_ref_test_tcp_devmem_recv(struct kunit *test)
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
+	if (!skb) {
+		struct page *page;
+
+		/* Don't report a lack of high-order pages as a failure. */
+		page = alloc_pages(GFP_KERNEL | __GFP_NOWARN | __GFP_NORETRY,
+				   PAGE_ALLOC_COSTLY_ORDER);
+		if (!page)
+			kunit_skip(test, "no order-%d pages",
+				   PAGE_ALLOC_COSTLY_ORDER);
+		__free_pages(page, PAGE_ALLOC_COSTLY_ORDER);
+	}
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



