Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309816;
	b=Wmi7Ez/s1OoaHQ1iu0dzKkGWA99fwYZ3bhtgkhsjixZSeD6AMKML+Kaf1WjVreusRFkQ
	 3+f4GmRQKNJ/LSa230ld6OByOsMl7pSIf+g7ieaWhsakR/kzjHlkYNMm+kw3eG2lZEi9L
	 ELWDRoiFrcARyE4YQUSv64HDZqI7+oM3u3ghHQjGibToeBvS6SupUxiB1Lem2UH2WZcDA
	 OhLtbLzJwbgTCEE3dOnUfN4xqrFduYaWvwi6Iohg+DAG4utQOTUs41a0xwSdLBwvm40qL
	 CvmknQxI3C2o0tUQmtBkhL1JT4T/Ac/6hYMySDpWcpcV8AkOLj++HFiD1q0pgY3MtZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309816;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FRqMllTEOoXf38Ur+jEqpl2zFBttJn4Z0H2rz9zpLxE=;
	b=EQ8mYosPNkPs9kbcLzMBb3qAzLE1twmtEtuwG0qZLyHlg3JcvfjBVEUYjVYva9oJ6GAq
	 lqErNegMb6cuPpn/v//wmMh70yX/gZzLtJTVJsc2GcjQ0m17lvuE0JSq6y5WICpnYwt7V
	 FV8XB3lLJEGKYy49+mulCbghGe9tAARJ7JdB8AVQ7Y6Zsg776nqMhOIeI1qUIT4V4Rag2
	 oropJqoWr7QjrV81xXQOgFQ/gSwAlvjG2eEcBzI5U6GK/iKxkjU1eKjvDZowGBe7IQPDb
	 ve87LH9Ky2S3ZYqZK0ZrNGT2GV092Ab9AzPGthknd6YlYW/LfFM6jvHgq7EPLDs2+uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LhDCIGFM;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IOtlQFFT;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375D760A2627
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 375D760A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LhDCIGFM;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IOtlQFFT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794309815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRqMllTEOoXf38Ur+jEqpl2zFBttJn4Z0H2rz9zpLxE=;
	b=LhDCIGFMiGIv/SFxU/zB0H9OlW++9EoXoa8Rfn5kXOA8O7VwkK7yPJgo5AU5ikwLcThcSA
	GZv6M0WVUjRuGf1IyXkCkaX6oXPxxY78KyAHdinyUIO+UaPFKb8WVdLGXhGQnzB4fVCDnG
	wPrJTymyWCCYpThNQRbTZd/DDj7MWwo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-N0yk6aq7NjWm1ypieJLa3A-1; Tue, 10 Nov 2026 06:23:33 -0500
X-MC-Unique: N0yk6aq7NjWm1ypieJLa3A-1
X-Mimecast-MFC-AGG-ID: N0yk6aq7NjWm1ypieJLa3A_1794309813
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-94776ee7bf0so311132985a.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794309813; x=1794914613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FRqMllTEOoXf38Ur+jEqpl2zFBttJn4Z0H2rz9zpLxE=;
        b=IOtlQFFTPRypoQpqqtWsExkTtYKYL2sQY5dTaOdOnIBNjcYlnsvdoJmhgTQO1b2QU3
         NQbupWDdoIB1TdS/NiE83Szx48XQwt1qLFTvUyko+oGDQGOBMGwWC+LORGbFFdBKQrXg
         8i4WFp5ytwjVO9lay0H46S3QLuHGb2wpGbs+BBoOZBYgj5J8quZoN+NNI0R04xlXuXRb
         nw2LK4SkTcw+JTHiwFGqJR/nl3QUBgPSCK4XnYpfBX/9spRQ0SIveS65Ra2LFrRHFKyi
         7fNM/LK6KMOJqEO1eHzRg8fBJyJT+kgO7hAHix6+OH92+1BX5bgP6GF+JeOJ6djaVyOE
         LPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309813; x=1794914613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FRqMllTEOoXf38Ur+jEqpl2zFBttJn4Z0H2rz9zpLxE=;
        b=i8wNvrA7BfcYD0PQYhloCy7rxRGcNO4GLGiKgxYbkImylVDGljuK6hNT4mJk/SDwdA
         9FXrUzwkPbBoKxwWrIxUZ4BieMscUbP7ZQDDD49wXY9Gk+WMur0b7Qb74SyUEsQ9s8kS
         j+7AUfjMiA+ASxkis9BUOJmQhgC9JX7ZHEn5fkIKD8mKruP4fLMnSPF04pUPfeH+l405
         0uEuk3oHUirA82pYMpA/k7sOBuO37Jx6Mlzv7lE8v1ldOgfGGXiFevwLyQ0WqrShOQIQ
         5eC/QCMjK/mOYQ9AGud99nOT+V1BMKTlcC6hZGx1K1R7fxYBurrMdOpcTf7IHFr3hHgY
         GauQ==
X-Forwarded-Encrypted: i=1; AL+hErHBFvNjOu2ummDLk+8eMlxcc2nFaMBpdp+iZf+UywXJj0y2geQrzx1qlckhwQAqkssuBAoEYYk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9m8SaSrx2Fzc+4EWtp248CVio2P/yI3q3c9fIAIZDJ+s1MrUEr
	BV0gRtwi72R3qp17qqf4w8oZOmY6Zre22+Of+BY0RCNZHAxjWStq5ebWi1XtHsEFZp0R+CO11gj
	BX0Se8kHlBlFODt5XmdT8JqJmcm2fJytaUM2h9tdnUxzzNNQllUlesDJvpw==
X-Gm-Gg: AYBFou3VpjZUKmPh8DUQk6uFhXj11aFmh3QXm98c57C4JMSs/CMwNINhfH6XPoiUH0W
	d4StPto4mKMii6REXa3PsZAkAflvk8MHWrmAIB+BH9V1m8/Y6Bjv8uwYQf2UKs0YTzkfu5tEeuG
	M2SSvtjMnd97IPsVXU76II/3iXd1X86z3SPXeafGFwyaTd1XKfB9b7qyR+cTtbGvTcMvvHNhT+P
	K2ylgKYw/FWQvqMmRe5fxcDHKd/+unp+9aOEM/xJY9m+vy3dF1ZuEeLQ/5lEH5EwYhMCj4IacAu
	86CCtThMqO+E7uYBKoekeCwP43P7bJuklearuDQ0RgDeBoq8SsZOGCBp3l9pX+kVz5Fco3BRe1I
	sJjSxGqo1GQtQRAz5M1Z5IHP/oN1OW+E2LgfJoGqj45UfQlM+c21iAsSStOVkCq3fUGZ/u6uZNO
	h+41vyKP9bQxYr6s8K7GsDjJNGhzI8AOgCsnGzKpx5h1p4YYrzQujVO1thM3TNU3+puF+V7bfO2
	6KKmgZs6BM6Hb8kqgXLwWupquWKajSKucKRyQ42NLpY5QcrptH9
X-Received: by 2002:ac8:5e06:0:b0:535:a5fb:6459 with SMTP id d75a77b69052e-5552a06e5a8mr30912921cf.68.1794309813122;
        Tue, 10 Nov 2026 03:23:33 -0800 (PST)
X-Received: by 2002:ac8:5e06:0:b0:535:a5fb:6459 with SMTP id d75a77b69052e-5552a06e5a8mr30912491cf.68.1794309812421;
        Tue, 10 Nov 2026 03:23:32 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04e7315sm18569186d6.22.2026.11.10.03.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:23:32 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 3/4] net: skb_splice_from_iter(): walk ITER_BVEC segments directly
Date: Tue, 10 Nov 2026 11:23:24 +0000
Message-Id: <20261110112325.3263078-4-amarkuze@redhat.com>
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

ITER_BVEC already describes source pages and byte ranges. Walk its
segments directly instead of extracting a temporary page array and
reconstructing those ranges.

Split at folio and representation boundaries, retaining page-bounded
fragments on HIGHMEM. Reuse the fragment append and checksum helpers.
Advance only by appended bytes, leaving a short request's remainder
available for another skb. Compare a positive limit with the unsigned
iterator count before assigning the bounded result to ssize_t.

Other iterator types keep the page-extraction path.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 net/core/skbuff.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3a66a50513a3..189fe25293ac 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7550,6 +7550,75 @@ static void skb_splice_csum_range(struct sk_buff *skb, struct page *page,
 	}
 }
 
+/*
+ * Splice from an ITER_BVEC by walking its segments: there is no page array
+ * to fill.  Direct-mapped folio runs are split only at representation
+ * boundaries; CONFIG_HIGHMEM builds retain page-bounded fragments.
+ */
+static ssize_t skb_splice_from_bvec(struct sk_buff *skb, struct iov_iter *iter,
+				    ssize_t maxsize, size_t frag_limit)
+{
+	const struct bio_vec *bv = iter->bvec;
+	size_t skip = iter->iov_offset;
+	ssize_t spliced = 0, ret = 0;
+	unsigned long seg;
+
+	if (maxsize <= 0)
+		return 0;
+	maxsize = min_t(size_t, maxsize, iter->count);
+	for (seg = 0; seg < iter->nr_segs && maxsize > 0; seg++, skip = 0) {
+		size_t boff = bv[seg].bv_offset + skip;
+		size_t blen = min_t(size_t, bv[seg].bv_len - skip, maxsize);
+
+		while (blen) {
+			struct page *page, *fpage;
+			struct folio *folio;
+			size_t foff, part;
+
+			page = bv[seg].bv_page + (boff >> PAGE_SHIFT);
+			folio = page_folio(page);
+			if (IS_ENABLED(CONFIG_HIGHMEM)) {
+				fpage = page;
+				foff = offset_in_page(boff);
+				part = min_t(size_t, blen, PAGE_SIZE - foff);
+			} else {
+				struct skb_splice_frag range;
+				u64 pos = ((u64)folio_page_idx(folio, page) << PAGE_SHIFT) +
+					  offset_in_page(boff);
+
+				part = min_t(u64, blen, folio_size(folio) - pos);
+				range = skb_splice_frag_normalize(pos, part);
+				fpage = folio_page(folio, range.anchor >> PAGE_SHIFT);
+				foff = range.offset;
+				part = range.len;
+			}
+
+			ret = -EIO;
+			if (WARN_ON_ONCE(!sendpage_ok(fpage)))
+				goto out;
+
+			ret = skb_append_pagefrags(skb, fpage, foff, part, frag_limit);
+			if (ret < 0)
+				goto out;
+
+			if (skb->ip_summed == CHECKSUM_NONE)
+				skb_splice_csum_range(skb, page,
+						      offset_in_page(boff),
+						      part, skb->len + spliced);
+
+			boff += part;
+			blen -= part;
+			spliced += part;
+			maxsize -= part;
+		}
+	}
+
+out:
+	iov_iter_advance(iter, spliced);
+	skb_len_add(skb, spliced);
+	return spliced ?: ret;
+}
+
 /**
  * skb_splice_from_iter - Splice (or copy) pages to skbuff
  * @skb: The buffer to add pages to
@@ -7564,6 +7633,7 @@ static void skb_splice_csum_range(struct sk_buff *skb, struct page *page,
  * or a tail page of that folio and holds one reference on the folio either
  * way.  On CONFIG_HIGHMEM builds a fragment stays within one actual page
  * of the folio, because kmap_local_page() maps only one page.
+ * A bvec iterator is walked directly, without extracting a page array.
  *
  * Returns the amount of data spliced/copied or -EMSGSIZE if there's
  * insufficient space in the buffer to transfer anything.
@@ -7579,6 +7649,9 @@ ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 	if (!maxsize)
 		return 0;
 
+	if (iov_iter_is_bvec(iter))
+		return skb_splice_from_bvec(skb, iter, maxsize, frag_limit);
+
 	while (iter->count > 0) {
 		ssize_t space, nr, len;
 		size_t off;
-- 
2.34.1

