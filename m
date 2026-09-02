Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22693409272
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374231; cv=none; b=Vlf0HsLPmdA83df11Zu3E6bWyg+sDV9S4wyaSAlAzWK+idJT/ZI7MdioECqWv3xIuESIK8JOv84rw5NNvcgmsBT5pfdBuHOB57RTEdZfghuZheKa+ac+/ey1d2TIjSEcjJi1vr3Kp18FnNe+YHrjjTcc/dGlWYFtJ03koeGIDKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374231; c=relaxed/simple;
	bh=GbmP64OGbvrjZbnj/TLMFjCYNj6An3pir6aMRZgAZX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjN7uaK8zgPzg2vrmXADp7vWCgTjaKjM3FGkSdsHBHgHiS59i/Fc73tQQDNWQkwZVhEpqIms4dndENM/KUh0Pk31zSCWRVHEKh3GAIgF0J/cnttJODaeW/mT2W4XCyoUB0OFNBGMhdYeuaOWIqrKo3ksDzSkUS3GEDEsgs0SDjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C26znzUT; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C26znzUT"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-38de693676dso871198a91.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 11:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788374226; x=1788979026; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tPLgiEVK7nQvQr/HKbT4zYwd4jF4IYbAeRSY+P/L0WA=;
        b=C26znzUTtkDfLlLix5dz78HGkmcPojVTvFMLjkmjKlP1EobKOrhg1ErTzO6q+g9ML3
         y17TTYGTlAbDjoH0ArIDScOV4yhDsVyntqPl7VnHmoIHxCHVwCl+ni9wxRSCEoU3c8yj
         wxg0FkuKtcNKzvSodVcvxAiIafmoHerKQOIchiHVE2vR1muBhql86SsSqW1MLOcvyo/k
         1g8lubpuOdmyh0HI/Wy2D1uzwhf1rS1mq/z49ex399joWO7udNEbFs4KA/qHpyeTmFJy
         RNVcDlcZkNDHOuEApMKLAILQA6Im6K9GA9H6fs0ohz2YrEzdl0XL9mnJPLEPihtaADxG
         EFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788374226; x=1788979026;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tPLgiEVK7nQvQr/HKbT4zYwd4jF4IYbAeRSY+P/L0WA=;
        b=hxN5SwO6Qz4AipF4eHEv5HnkkUFl8KoaPfhJoK675cV24+XFpqagGrO/ictXsnIQjf
         R0QNkImv/PVGsU/5kuhVgKsD53oMiqOICvONtvXemNbFavbLd1fuHX8ua6OEmujtBjkW
         8ceSNMny9fXM+uJ1XuqjsH2koE0IYkV0LZ8+YyEqcxhQM28uq9gPRgvGO8IqqnjryhGM
         d/hpOhSFQdiRDKInPGUcL3sEm8a9sjENIl4rVN9zdYCFKEFDaDhMlO3LpOqUZaPMa+Oj
         SwAHZxAZSVUfBpek473IdKkKkAvekVp8swAYvezgGw44hR9eHT34e+KWD5iXJQfL3ExH
         9rUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBKnPVh3PcYky8EOKZovPS9ZuMcXG6TA2Wt+PBTT9PK7o5jpG04LNdUSd6Or0BBOUD8iyGGzE=@vger.kernel.org
X-Gm-Message-State: AFuF++mBf/ZwuZ/F+o3xsKJAu8NqRhDNjyKh0J3PS6uc83yT44W6hUan
	y/pxWpIuhfpBFEVOaZ3b+HL+wwkkluEFJPUgGqVt/wxXNZiDCZ8AO6ua
X-Gm-Gg: AYBFou2gYU970rdEQwDYg+mm+5G7pNuVsHUVKuMwbiaWElGIB6tcQNe6SCTnVxZ7/vo
	isY3R49F21G5TdNOy+lzV0+jdpOmV58D7TZbUSWLrkEJ0Q11JNAgxhhZB2i7XoLReIjDItFhXwu
	pqb8vw1DzRZaTsJrP0u7m0mjF5y+/d0b2Kwusgc7ROAMuQiZXicdnOIWCo0TPnkrsTUni23BqiY
	a7P8BMlGa2d9xjUBJKR81TdEeoBdEQCTk/UoMV8FzDF6i3+cnv/Z5mdjYS6ELHoIigmorvI12sk
	vhYe6fjpuv6/tMqOtAtnK2nFdJah2/Eu9NU789Ga6R4Ym24bzUVqxWjbloNgtFaCvaOgD1P0AQe
	bPvrkzoszKlnjqHjlzCRsxZ18yJgbve7iPF6Yn4nYajPGl0yCIag9DeQp66DuVEUi4xLlYK6hxU
	LgfXiIufS4vx3xibFyiJcZTOs0qsbSBMnR8mI9dytDxewz56NIJG0ZBytYHZZdDGes
X-Received: by 2002:a17:90b:3985:b0:398:bc52:825b with SMTP id 98e67ed59e1d1-39aee22218dmr8158353a91.21.1788374226348;
        Wed, 02 Sep 2026 11:37:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d0d845sm638297a91.17.2026.09.02.11.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:37:05 -0700 (PDT)
Date: Wed, 2 Sep 2026 11:36:59 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Kaifeng Wang <kaifengw@google.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, sdf@fomichev.me, bobbyeshleman@meta.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: devmem: remove gen_pool from dma-buf
 allocations
Message-ID: <aphk-b52PGfESvjL@devvm7509.cco0.facebook.com>
References: <20260831183529.2517322-1-sdf@fomichev.me>
 <CAHS8izM5+CrZG77PxKpfG9k5kEWYMgN=uAuYvy21aabyztBt0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izM5+CrZG77PxKpfG9k5kEWYMgN=uAuYvy21aabyztBt0w@mail.gmail.com>

On 08/31, Mina Almasry wrote:
> On Mon, Aug 31, 2026 at 11:35 AM Stanislav Fomichev
> <sdf.kernel@gmail.com> wrote:
> >
> > Replace devmem's gen_pool based fixed-size allocator with a binding-level
> > freelist similar to the one used by io_uring zero-copy receive.
> >
> > This is motivated by allocation latency observed in the NAPI receive path:
> >
> >   [ 1036.228913]  ? gen_pool_create+0x90/0x90
> >   [ 1036.228915]  net_devmem_alloc_dmabuf+0x1f/0x60
> >   [ 1036.228918]  mp_dmabuf_devmem_alloc_netmems+0x17/0x80
> >   [ 1036.228920]  mlx5e_post_rx_mpwqes+0xdbe/0xdd0
> >   [ 1036.228926]  mlx5e_napi_poll+0x113/0x830
> >   [ 1036.228928]  ? sched_clock+0x5/0x10
> >   [ 1036.228931]  ? wake_up_process+0x778/0x14b0
> >   [ 1036.228933]  net_rx_action+0x15d/0x570
> >   [ 1036.228934]  ? update_rq_clock+0x31/0x240
> >   [ 1036.228937]  ? __napi_schedule+0x55/0xa0
> >   [ 1036.228938]  ? mlx5_eq_comp_int+0x137/0x230
> >   [ 1036.228940]  ? atomic_notifier_call_chain+0x36/0x90
> >   [ 1036.228943]  ? sched_clock+0x5/0x10
> >   [ 1036.228944]  ? sched_clock_cpu+0xc/0x170
> >   [ 1036.228947]  irq_exit_rcu+0x12b/0x370
> >   [ 1036.228950]  common_interrupt+0x85/0x90
> >
> > udmabuf can create a very large number of SG entries. In the worst case,
> > devmem ends up adding one gen_pool chunk for each net_iov allocation
> > unit backed by those entries. The gen_pool allocation path then has to
> > traverse a linked list that can become too long for this hot path.
> >
> > Patch 1 removes the gen_pool and replaces it with a simple freelist of
> > net_iov pointers protected by the same spin_lock_bh() pattern used by
> > io_uring zcrx. Patch 2 removes the now-unnecessary chunk owner wrapper by
> > embedding the net_iov_area directly in the dma-buf binding.
> >
> 
> Oh boy, this is going to be a bit tricky.
> 
> I ran into this exact horrible perf bug (sorry for it in the first
> place), but my solution was different. My solution [1] was to coalesce
> the SG entries that are contigious (and they usually are in practice),
> and I got 'acceptable' perf after that. Kaifeng is actually working on
> cleaning up my hacky patch up to send it upstream now.

As you mention, coalescing might happen to work or it might not :-(
I'd like us to have something that's less probabilistic.

> Now I don't know which approach is better. Thinking about the pros and
> cons of your approach:
> 
> + your approach is much simpler, and removes gen_pool overheads for a
> single queue case. It should be (much?) faster for that case.
> - your approach adds a lock and allocations from multiple queues in
> parallel will contend on this lock. There should be some value of # of
> queues N where your approach starts to completely trash. gen_pool is
> lockless so I wouldn't expect it to degrade significantly in the
> multi-queue case.
> 
> The question for me is what the performance is for a real use case
> (NCCL all-to-all for example) over a realistic number of shared queues
> (it's 4-8 for me). I need that perf data to be honest before judging
> this.
> 
> The io_uring zcrx comparision is not completely valid. io_uring zcrx
> is built from the ground up to be one-buffer-is-bound-to-one-rx-queue,
> and devmem tcp is built from the ground up to be
> one-buffer-can-be-bound-to-N-rx-queues.

What if we add batching similar to io_pp_zc_alloc_netmems? So we don't
have to spin lock on every netmem (and move PP_ALLOC_CACHE_REFILL-worth
of chunks). Untested, on top of this series:


diff --git a/net/core/devmem.c b/net/core/devmem.c
index 84d6c30516c8..5a1c996ba515 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -58,25 +58,25 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 	kfree(binding);
 }
 
-struct net_iov *
-net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
+static unsigned int
+net_devmem_alloc_dmabuf_bulk(struct net_devmem_dmabuf_binding *binding,
+			     netmem_ref *netmems, unsigned int count)
 {
-	struct net_iov *niov;
+	unsigned int i;
+
 	spin_lock_bh(&binding->freelist_lock);
-	if (unlikely(!binding->free_count)) {
-		spin_unlock_bh(&binding->freelist_lock);
-		return NULL;
+
+	count = min_t(size_t, count, binding->free_count);
+	for (i = 0; i < count; i++) {
+		struct net_iov *niov = binding->freelist[--binding->free_count];
+
+		binding->freelist[binding->free_count] = NULL;
+		netmems[i] = net_iov_to_netmem(niov);
 	}
 
-	niov = binding->freelist[--binding->free_count];
-	binding->freelist[binding->free_count] = NULL;
 	spin_unlock_bh(&binding->freelist_lock);
 
-	niov->desc.pp_magic = 0;
-	niov->desc.pp = NULL;
-	atomic_long_set(&niov->desc.pp_ref_count, 0);
-
-	return niov;
+	return count;
 }
 
 void net_devmem_free_dmabuf(struct net_iov *niov)
@@ -433,20 +433,35 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
 netmem_ref mp_dmabuf_devmem_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 {
 	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
-	struct net_iov *niov;
-	netmem_ref netmem;
+	netmem_ref *netmems = pool->alloc.cache;
+	unsigned int allocated, i;
+
+	if (WARN_ON_ONCE(pool->alloc.count))
+		return 0;
 
-	niov = net_devmem_alloc_dmabuf(binding);
-	if (!niov)
+	allocated = net_devmem_alloc_dmabuf_bulk(binding, netmems,
+						 PP_ALLOC_CACHE_REFILL);
+	if (unlikely(!allocated))
 		return 0;
 
-	netmem = net_iov_to_netmem(niov);
+	for (i = 0; i < allocated; i++) {
+		struct net_iov *niov = netmem_to_net_iov(netmems[i]);
 
-	page_pool_set_pp_info(pool, netmem);
+		niov->desc.pp_magic = 0;
+		niov->desc.pp = NULL;
+		atomic_long_set(&niov->desc.pp_ref_count, 0);
+
+		page_pool_set_pp_info(pool, netmems[i]);
+
+		pool->pages_state_hold_cnt++;
+		trace_page_pool_state_hold(pool, netmems[i],
+					   pool->pages_state_hold_cnt);
+	}
 
-	pool->pages_state_hold_cnt++;
-	trace_page_pool_state_hold(pool, netmem, pool->pages_state_hold_cnt);
-	return netmem;
+	/* Return the last one, the rest stay in the page_pool cache. */
+	allocated--;
+	pool->alloc.count = allocated;
+	return netmems[allocated];
 }
 
 void mp_dmabuf_devmem_destroy(struct page_pool *pool)
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 20a3eb90ea7f..7195769b8bd1 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -133,8 +133,6 @@ net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
 void net_devmem_get_net_iov(struct net_iov *niov);
 void net_devmem_put_net_iov(struct net_iov *niov);
 
-struct net_iov *
-net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
 void net_devmem_free_dmabuf(struct net_iov *ppiov);
 
 
@@ -191,12 +189,6 @@ net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	return -EOPNOTSUPP;
 }
 
-static inline struct net_iov *
-net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
-{
-	return NULL;
-}
-
 static inline void net_devmem_free_dmabuf(struct net_iov *ppiov)
 {
 }


> Are you able to get NCCL all-to-all tests for N=4/8 yourself?
> Otherwise please wait for me to backport this to my release kernel and
> test it. ETA sometime this week, I hope.

I can definitely wait for you to access the perf impact on your side. Wonder
if we need to have a selftest to do that properly in NIPA. Doesn't have to
be a red/green signal, but some number for humans to compare
before-after (specifically this bind one dmabuf to multiple queues and pass
a lot of traffic). I can probably sketch something..
