Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501CB78C9C
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585380; cv=none; b=ttIGrnU+TAoD8GX3zLlsqatmB+y+BY8+LeA+1XKaha92eJGUqJslsL1D0HJhlpaeakHHxz8YMo9rv/QnLuVmZbC33KaGkADEd8PxdYEXeLUjdhzzTmZN/wOBj/6zSDwd41P5HCxyPu2Bqw2KP8fLyyT++mcTwfCF7IMrDjBsTm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585380; c=relaxed/simple;
	bh=AF4HTC8QR9q7AHiC+guyM5ToXRdlXVo2uDB8PfeVh/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z5cKV2eCa6xsDtY//bPuRcc2Qi4js8m2a1xIMstW+ALoEVx9r6DvaBbB+bPabz/mIW+/pQjXxKJ/nIlry+zrB7QGTy1jeYHjG8zqAC3pBPaEtg+wFdJDHtHhxCVWuC0YBSnEAFF3MP/txEi8VS812e8Ao8TQ7m3n4kgzjDdgfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=icP10a6L; arc=none smtp.client-ip=209.85.218.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icP10a6L"
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c1f3117bc6bso328260866b.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787585375; x=1788190175; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4S+Q+WbZhfdTv2oIAFNepA3QU93t9DANybxh3vuKjoU=;
        b=icP10a6Lg5Z+eDeyJoWJCdJBeuaDiPTmC0Lw+pk20JP+RbZkIChfH6Z235IplbCt54
         B+gI8GUrQoV+P6jYvuZk7LOIlxq+dNYzjDggB7Ad8gvLIe6+izCfH5mbdN0q2Qq4+/yb
         2POu2l2tn7qL6QoIw1qF15LHPQYki+QEYCyYa0CmV4Thh9ipsQqY1RI4TV2SBRmexJBY
         YtMwtgIFZYcma+3BNXeFTspIIJ3PQvUN7a9s56SGh/yFUpHJm7Mraa+t4kbcb+9WzUFc
         Q/jDuxaqpBobpdd2qLNXsxzTF9N+jyCLd0XN4jZwzkZ1SICoHBJlTt3QRWOyW5uddTf7
         9GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585375; x=1788190175;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4S+Q+WbZhfdTv2oIAFNepA3QU93t9DANybxh3vuKjoU=;
        b=sPMwxXNqkC2rX2H/xq6HCpL/bnP5bEamEvacMpeVMjCxQt78dNV7dbnr+1pzXQQvxw
         BqcbFX1GKAiLri61SbDMhkbmU55yVabQ4gKGfzMWFcdqmaeAObOsDvNK2S7cHNIMbDPB
         fD6qvE3mbUZWZvny5kXnvEkwvAqExWMlVcT3t6ChfxEW69grObhJxZamxMYOsUpec3t5
         SmWwdlaSHJPeNOsi91igsRI761chiNqUtJjhTf3ljGRtlaSmaw7VI1bJcxoQb8ZxhRYq
         GiMB2Wl4IcXT5aRXbk9AH9Rk+l5dS5MyZotbAWDn83EVSeSRrApf/aVuOtUo2vxi+OWK
         pyRg==
X-Forwarded-Encrypted: i=1; AHgh+Rq2taCVzizgN5P7FpR4ajDJpqpDmwFtvcFKKBZ3cqkz4iP2n9FOUcDb/jRmzTgazONprdFzkaA=@vger.kernel.org
X-Gm-Message-State: AFuF++nksU12CE1XPJp8EmpxOag2aV6vIWO260NoYj6ASJ4+HabRF7+l
	GoKD85cDyCCNISeBja1e8+V/zFo/eDW5u+1i9anvCZ9iaiY+UINlCqdKs0K6tP5sBU3EWpyjyzd
	I181fDA==
X-Received: from ejcdi21.prod.google.com ([2002:a17:906:7315:b0:c12:8b42:7bfd])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:1caa:b0:c20:53c7:488d
 with SMTP id a640c23a62f3a-c246a5f7664mr2951802166b.14.1787585375128; Mon, 24
 Aug 2026 08:29:35 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:29:27 +0000
In-Reply-To: <20260615234220.3946885-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615234220.3946885-1-lrizzo@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824152932.1583506-1-lrizzo@google.com>
Subject: [PATCH v2 0/5] swiotlb: avoid swiotlb copy on network sockets
From: Luigi Rizzo <lrizzo@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Luigi Rizzo <lrizzo@google.com>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dragos Tatulea <dtatulea@nvidia.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The use of swiotlb, common in Confidential Computing, causes an extra
data copy on each I/O. Focusing on network sockets:
- on tx, the copy has a high chance of happening in the tx softirq handler
  (especially with greedy senders where the device queue is often full)
- on rx, it is guaranteed to happen in the rx softirq handler.
Thus, on top of the copy cost, swiotlb concentrates the overhead on an
already constrained resource (CPUs processing network interrupts).

Reduce or remove the extra copy by conditionally allocating socket buffers
directly from the swiotlb buffer pool.

The feature is controlled by runtime parameters to set the percentage of 
swiotlb buffers that can be used for this purpose. This avoids stranding
the entire swiotlb pool in socket buffers.

The implementation is made of four main parts:
- introduce a swiotlb page allocator that can be used instead of
  regular pages, and teach __free_frozen_pages(), free_unref_folio()
  how to handle them
- dynamically track the leaf device for each tx network socket,
  so we can tell at copy_from_user() time whether we need to use
  swiotlb for this socket
- modify skb_page_frag_refill() to allocate from swiotlb if needed.
  This implements the copy elision for the transmit path
- modify __page_pool_alloc_page_order() to allocate from swiotlb if needed.
  This implements the copy elision for the receive path.

The savings are especially visible with fewer queues. In synthetic
benchmarks, senders with 1-2 queues would cap around 50Gbps with
conventional swiotlb, and reach over 170Gbps with the feature enabled.

OPEN ISSUES

Currently the swiotlb allocator looks for free slots using an
approximately linear scan of each pool (with some hints to likely
candidates) and then does a linear scan of subsequent pools.
This works extremely well when the number of pools matches the number of
CPUs, and there is plenty of memory available. In fact, it is almost
unbeatable by any more complex strategy.

Under high load or buffer fragmentation, a CPU might repeatedly do a
full scan of its starting pool before finding a suitable candidate.
Even worse, with multiple tx/rx queues, what happens is that multiple CPUs
will trail each other on the same sequence of pools. The effect is that
some allocations will end up costing O(100us) and more.

I have tried to implement two improvements:
- a buddy allocator on top of each pool, so to make it quicker to find a
  candidate of the requested size
- make each CPU use a different sequence to explore other pools in case
  one is full, so they will not end up queueing one after the other
While they are very effective on the tails, for low load scenarios the
current linear allocators is better. Thus this will take more
investigation.

---
v1 -> v2:

- split components into separate commits
- simplified allocator, no need for a new page type
- many code cleanups
- also implement the rx side

Luigi Rizzo (5):
  swiotlb: enforce pool nareas and nslabs invariants
  swiotlb/mm: Implement SWIOTLB nocopy page allocator
  net/swiotlb: Track bounce device per socket
  net: Divert socket allocations to SWIOTLB for nocopy TX
  swiotlb: Implement RX nocopy with fast recycling eviction

 drivers/base/core.c       |   1 +
 drivers/iommu/dma-iommu.c |   9 +-
 include/linux/netdevice.h |  21 +++
 include/linux/skbuff.h    |   7 +-
 include/linux/swiotlb.h   |  63 ++++++++
 include/net/sock.h        |  46 ++++++
 kernel/dma/direct.h       |  11 ++
 kernel/dma/swiotlb.c      | 296 ++++++++++++++++++++++++++++++++++++--
 mm/page_alloc.c           |  61 +++++++-
 net/core/page_pool.c      |  25 +++-
 net/core/sock.c           | 101 +++++++++++--
 11 files changed, 617 insertions(+), 24 deletions(-)

-- 
2.55.0.766.g2966f0265a-goog
