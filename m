Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248759;
	b=wi9lp8dJqYyMHptyIRJckfeytYeAAIO+i88T2ecqnJqCacBnqPFeOI/5vSYRGq7pk6Qa
	 1z2gzM2YqKTfv2Ycroin11LMZsdmBUVsBh7TVpu1q9/FSreZT+6MOagPSsirOLniPRn1y
	 +eS0/wNpseluJJMTV9PzieIRo2J6QzyeZx/2Jik5gFWB+vC3PlhglfeReEbrWDwhU9RAG
	 XHSsxu+MeyK7xnf+uQywQ797J8O/8pcEtFG311dboYoZVn25SX+ojAN08YLW+Q4ndtXjV
	 fQ5rCBKScQuBH6JWaMDpG1fKrU9cZ92K11vVXkj6eCQT+jP2HKmHqQYHVLYmiJktFDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+CkU7K8AN4V+yWUdhaz7RzC7M7eZI1Az06smW8kAgic=;
	b=FpFksUDMFP/jKQJ22ht4AoaQlI7mWGTPADxFfZp5fnk+KElIgcx6mLKRmXhxEvjyPMNc
	 G91iEXImFF4oAdeB2LhB0smLry8CWWd28aZF2kuRmtfvi6QFQECpePkxyMk2PFsHnzBM9
	 +5/y7eMAE4zC6DDMm7VU0D/b2c+5XCWaLPGvVchpMtz2+rpuxeb1S49UCL2qfgqCBaLN4
	 BZwOhRqPRA1zAllTX8AUs+Otr9peXFb1hDUr1YxcW2u+uXGvYVU6VeVVeDzssD7I7DUPX
	 dgqRM5Ak9Ct6PyvQjGnnMncpKtwYCC1JjPnGYzmLSnIFC82EHhqKbtq4el5bsY5cbGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R6OAKMoz;
	arc=none smtp.remote-ip=209.85.208.69
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3C9606F389
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 18:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E3C9606F389
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R6OAKMoz
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b57668479aso1342015a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 10:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248758; x=1794853558; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+CkU7K8AN4V+yWUdhaz7RzC7M7eZI1Az06smW8kAgic=;
        b=R6OAKMozRhsfHxc8EcFZ+huhXHTUifLuDNzp7irGIsSVjqGoEY8d3mnCj8nZacKwCK
         tQjHTykFoNlf0UYBL86bFR60Ft9ii0rZNy4AnXfoDNBGCqinPb8lYiDputfVY37esCod
         Stwu2HR69qRmwMRHsFxx8NkupoLJfp0s88yuwKkYT6rme4ICe+iHCiInAXkwoeeA1+w9
         cyYPFkxgZipGbELGJqF72MWVZUUT2EMNcvjMhAApgAV39wIcFHgte86waciFObzQGRye
         PybV+ZHUA42kHm/FA1V+PTrZ3xqif6+W415XsAU3kHv7W3f/6IF+E3bwaxK/V6n9F11+
         RtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248758; x=1794853558;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+CkU7K8AN4V+yWUdhaz7RzC7M7eZI1Az06smW8kAgic=;
        b=r8mWPEjNhoJKhWi7X+QErFrYcQ9MKsEzMxFaW0zI7UB0JlVfiQ+xWqrsP5k6z4Z5bV
         S524OHmu84s3/HpBljz4zMhBqfP+a61ym6TmM7Ko8P4p8M4yMSKQqNwJ35CxJkMzJNnw
         p61/lKD10manF816UMs0J+ezTBRselWBU5ySVTK/J1P9gHGL9ctoEsEPiROHNlpX9KV0
         nqGrPairGGyoaPpYlMLF43eoWueZ7dyDdqpl6a6JDndqDzYB+DHeCkTExgMdxU3t38iU
         TpDEz9hbl/SHz+rcHYJT6322b8HrxhqbTsfV27FcvlUK0J75FZn9C4G/q7lfxsuvovBB
         1Jtw==
X-Forwarded-Encrypted: i=1; AL+hErHA0Aj0Hn5JOgMws481MvkPu6bLGhU4fYA1VVZ5ZGcBOcvFBuePAXVWWhpCcASMrtfmaMefQ4E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dHTV7953JV3frfGStFJmYisPfRaiI65pj3/uQAjTpSgatwO52
	P5ME/fc2bqKGvKaoKivopWp80yz7Hbv13eQoXVGgZkVsuLQs78+RxfZeC65ksIsMFaPkO5zmWCS
	1JKlvOA==
X-Received: from edqs3.prod.google.com ([2002:aa7:d783:0:b0:6b6:fa4d:3bb9])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:1f05:b0:6b5:7872:3905
 with SMTP id 4fb4d7f45d1cf-6b756afbbd0mr357136a12.31.1794248757581; Mon, 09
 Nov 2026 10:25:57 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:28 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261109182533.3594984-21-lrizzo@google.com>
Subject: [RFC PATCH v2 20/25] net/libeth: Use GFP_KERNEL when pre-filling RX rings
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

libeth_rx_alloc() is called both when pre-filling RX fill queues in
process context (for indices 0 .. fq->count - 2, when buf->truesize is
still 0) and when refilling RX buffers from NAPI softirq.

Use GFP_KERNEL during the initial process-context ring fill so page_pool
and PISA page allocations (including set_memory_decrypted() under CoCo)
are not forced into GFP_ATOMIC context.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/net/libeth/rx.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 0e736846c5e8a..de1e5fe44aa40 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -106,10 +106,17 @@ void libeth_rx_fq_destroy(struct libeth_fq *fq);
 static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
 {
 	struct libeth_fqe *buf = &fq->fqes[i];
+	/* fq->fqes is zero-allocated and pre-filled in process context for
+	 * indices [0 .. fq->count - 2]; slot fq->count - 1 is first allocated
+	 * in NAPI. Use GFP_KERNEL for initial pre-fill and GFP_ATOMIC after.
+	 */
+	gfp_t gfp = (buf->truesize || i == fq->count - 1) ?
+		    GFP_ATOMIC : GFP_KERNEL;
 
 	buf->truesize = fq->truesize;
-	buf->netmem = page_pool_dev_alloc_netmem(fq->pp, &buf->offset,
-						 &buf->truesize);
+	buf->netmem = page_pool_alloc_netmem(fq->pp, &buf->offset,
+					     &buf->truesize,
+					     gfp | __GFP_NOWARN);
 	if (unlikely(!buf->netmem))
 		return DMA_MAPPING_ERROR;
 
-- 
2.56.0.542.g3ef89b7020-goog

