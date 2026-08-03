Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6B1345CAF
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776293; cv=none; b=V3IG7IiR8RKZR4/9vOhF0rYaoNnJ/sTLKXv4VNSxl26rHtdZzl900TXCoHzVSkuccELnw/34pPfvOLNXMeAIQnkUCTwm/gwKigMOFsUt1EPxdmLmSUDuwdMaYzt1nJqkTMMxAzUUxc2/tdJAnc1TJ2NjFfCiubnLo36y8M7Qx54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776293; c=relaxed/simple;
	bh=USEkZNZk3AVkAZt6EMONhp0KPwf0n8eY8IyOgs0CRA0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMae7XrAdEbIm2AGNvzH3oqKHX24E1lNppuvQMSgQtr5CgKp/g65evpR2snRzbfuPNjEDgWlB6y8b1i9gTBmdRw9uixO4vqQ5EfTLcCCoMEALYjchS8gSS9Cmv23TJ0HzYg3/A2rKvsq0zN+ljvE4RYxiA96DV3KROjW/E5uK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=RIuGVKmX; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="RIuGVKmX"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EB80120754;
	Mon,  3 Aug 2026 18:58:08 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EUH7s_0Y_oOH; Mon,  3 Aug 2026 18:58:08 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 025CF2067A;
	Mon,  3 Aug 2026 18:58:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 025CF2067A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785776288;
	bh=YVbayqDqMfWNHQggRBfSV06NBP7dZeQGdxrry6z4+xA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=RIuGVKmXkdScZmw8A0p97k0yyNQ3KRW1KuGCs/p7Iv4pPGdotK/enr3hOszNkYWw/
	 VkXuWyXH9EUwYgIUgQtXKSjo2/P7Sah9fyVUF/ixb3V6oR/l1/jWyB/Xl+YS37vuhb
	 ETaw7h3qaik6M4H/h7dEGPiEI59A7VyIH49xpNGhBkAIxzq3m95XP4S4nxXVxUy8FT
	 fOVbVHMnFNAIJmulNwi/cU1kz4gstuHRNbNwIX8R1xFTugW2+W6ej9VyU06n/n26PA
	 mJel/x41Rt6SwrE9dsDGb+5JZwXBzMvpoKjibsYA9LIkVYo3zXeIPA0dj495rk2BH5
	 RKTgsHDVC6Vuw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 18:58:07 +0200
Received: (nullmailer pid 2444417 invoked by uid 1000);
	Mon, 03 Aug 2026 16:58:06 -0000
Date: Mon, 3 Aug 2026 18:58:06 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>, Zihan Xi <xizh2024@lzu.edu.cn>
CC: <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH 5/8] xfrm: avoid lock inversion in nat keepalive work
Message-ID: <anDIno_XWtKMM0Wc@secunet.com>
References: <20260729065035.1591985-6-steffen.klassert@secunet.com>
 <20260731021546.789147-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260731021546.789147-1-kuba@kernel.org>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

Zihan, please looks at this review of your patch.

Thanks!

On Thu, Jul 30, 2026 at 07:15:46PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> --- Patch [5]: [PATCH 5/8] xfrm: avoid lock inversion in nat keepalive work ---
> commit 550991d4355a9993b144d945cc62ff754d14ede8
> Author: Zihan Xi <xizh2024@lzu.edu.cn>
> 
> xfrm: avoid lock inversion in nat keepalive work
> 
> This splits nat_keepalive_work() into two phases: the xfrm_state_walk()
> callback now only collects candidate states and takes a reference on each,
> and the actual keepalive processing (which takes x->lock) happens after the
> walk has dropped net->xfrm.xfrm_state_lock.
> 
> > diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
> > index eb1b6f67739e1..8679c68c10a16 100644
> > --- a/net/xfrm/xfrm_nat_keepalive.c
> > +++ b/net/xfrm/xfrm_nat_keepalive.c
> > @@ -156,24 +156,51 @@ static void nat_keepalive_send(struct nat_keepalive *ka)
> >  }
> >  
> >  struct nat_keepalive_work_ctx {
> > +	struct list_head states;
> >  	time64_t next_run;
> >  	time64_t now;
> >  };
> >  
> > -static int nat_keepalive_work_single(struct xfrm_state *x, int count, void *ptr)
> > +struct nat_keepalive_state {
> > +	struct list_head list;
> > +	struct xfrm_state *x;
> > +};
> > +
> > +static int nat_keepalive_work_collect(struct xfrm_state *x, int count, void *ptr)
> >  {
> >  	struct nat_keepalive_work_ctx *ctx = ptr;
> > +	struct nat_keepalive_state *state;
> > +
> > +	if (!READ_ONCE(x->nat_keepalive_interval))
> > +		return 0;
> > +
> > +	state = kmalloc_obj(*state, GFP_ATOMIC);
> > +	if (!state)
> > +		return -ENOMEM;
> 
> [Severity: Medium]
> [Finding: main-1-1]
> [Sources: opus-5]
> Does the allocation footprint here scale with the number of SAs in a way
> that is a concern?  nat_keepalive_work_collect() runs as the
> xfrm_state_walk() callback, so it executes under
> spin_lock_bh(&net->xfrm.xfrm_state_lock), which forces GFP_ATOMIC.
> 
> One node is allocated from the __GFP_HIGH reserves, and one
> xfrm_state_hold() is taken, for every ESP SA with nat_keepalive_interval
> set.  On a gateway with a large number of keepalive SAs that is a single
> burst of tens or hundreds of thousands of GFP_ATOMIC allocations per
> round, and a single failure aborts the entire round (see below).
> 
> For reference, the lock hold time itself is not a regression here: the
> baseline callback already did alloc_skb(GFP_ATOMIC) and transmitted under
> the same lock, so that part is if anything improved.  The concerns are the
> new per-SA reserve draw, the new abort-on-ENOMEM failure mode, and the
> batch-wide reference pinning.
> 
> Was a non-allocating variant considered, for example READ_ONCE/WRITE_ONCE
> or a dedicated lock for the three shared fields x->lastused,
> x->nat_keepalive_interval and x->nat_keepalive_expiration, a persistent
> struct xfrm_state_walk using the walk's stop/resume support, a per-net list
> of keepalive-enabled SAs, or a bounded pre-allocated chunk?
> 
> [Severity: Low]
> [Finding: main-1-2]
> [Sources: opus-5]
> This isn't a bug, but the patch carries:
> 
>     Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
>     Cc: stable@vger.kernel.org
> 
> while using kmalloc_obj(), which is a recent addition in include/linux/slab.h:
> 
>     #define kmalloc_obj(VAR_OR_TYPE, ...) \
>         __alloc_objs(kmalloc, default_gfp(__VA_ARGS__), typeof(VAR_OR_TYPE), 1)
> 
> Stable branches containing f531d13bdfe3 do not have that macro, so the
> backport will not build without manual conversion.  Would plain
> kmalloc(sizeof(*state), GFP_ATOMIC) be preferable, since the macro buys
> nothing here?
> 
> > +
> > +	xfrm_state_hold(x);
> > +	state->x = x;
> > +	list_add_tail(&state->list, &ctx->states);
> > +	return 0;
> > +}
> > +
> > +static void nat_keepalive_work_single(struct xfrm_state *x,
> > +				      struct nat_keepalive_work_ctx *ctx)
> > +{
> >  	bool send_keepalive = false;
> >  	struct nat_keepalive ka;
> > -	time64_t next_run;
> > +	time64_t next_run = 0;
> >  	u32 interval;
> >  	int delta;
> >  
> > +	spin_lock_bh(&x->lock);
> > +
> > +	if (x->km.state == XFRM_STATE_DEAD)
> > +		goto out;
> > +
> >  	interval = x->nat_keepalive_interval;
> >  	if (!interval)
> > -		return 0;
> > -
> > -	spin_lock(&x->lock);
> > +		goto out;
> >  
> >  	delta = (int)(ctx->now - x->lastused);
> >  	if (delta < interval) {
> > @@ -187,29 +214,41 @@ static int nat_keepalive_work_single(struct xfrm_state *x, int count, void *ptr)
> >  		send_keepalive = true;
> >  	}
> >  
> > -	spin_unlock(&x->lock);
> > +out:
> > +	spin_unlock_bh(&x->lock);
> >  
> >  	if (send_keepalive)
> >  		nat_keepalive_send(&ka);
> 
> [Severity: High]
> [Finding: main-3-5]
> [Sources: opus-5]
> Is nat_keepalive_send() still called from a softirq/BH-disabled context
> after this change?  spin_unlock_bh() re-enables softirqs, and the phase-two
> drain loop in nat_keepalive_work() has no local_bh_disable(), so this call
> now runs from fully preemptible process context.
> 
> nat_keepalive_send() ends up in nat_keepalive_send_ipv4() and
> nat_keepalive_send_ipv6(), both of which do:
> 
>     local_lock_nested_bh(&nat_keepalive_sk_ipv4.bh_lock);
>     sk = this_cpu_read(nat_keepalive_sk_ipv4.sock);
>     sock_net_set(sk, net);
>     ...
>     sock_net_set(sk, &init_net);
>     local_unlock_nested_bh(&nat_keepalive_sk_ipv4.bh_lock);
> 
> and local_lock_nested_bh() starts with an assertion:
> 
>     #define __local_lock_nested_bh(lock)                    \
>         do {                                                \
>             lockdep_assert_in_softirq();                    \
>             local_lock_acquire((lock));                     \
> 
> Before this patch nat_keepalive_work_single() was itself the
> xfrm_state_walk() callback and therefore always ran with
> spin_lock_bh(&net->xfrm.xfrm_state_lock) held, so in_softirq() was true.
> 
> Does every keepalive transmission now hit that WARN_ON_ONCE, replacing the
> lockdep splat the changelog aims to fix with a different one?
> 
> Beyond the warning, is the exclusion for the per-CPU socket still there?
> On !PREEMPT_RT __local_lock_nested_bh() is lockdep bookkeeping only, so
> with BHs enabled nothing serializes the
> this_cpu_read(sock)/sock_net_set(sk, net)/xmit/sock_net_set(sk, &init_net)
> window.  Can a preempted or migrated worker let another netns' keepalive
> work clobber the same per-CPU sk, so a keepalive is emitted with the
> socket's net pointing at init_net or another netns?
> 
> On PREEMPT_RT, local_lock_nested_bh() and local_unlock_nested_bh() each
> resolve __this_cpu_local_lock() and take/release a real spinlock with no
> migrate_disable().  Without BHs disabled, can the task migrate between
> acquire and release and unlock a different CPU's lock, leaving the original
> one held forever?
> 
> Would wrapping the nat_keepalive_send(&ka) call, or the whole phase-two
> loop, in local_bh_disable()/local_bh_enable() be enough?
> 
> >  
> > -	if (!ctx->next_run || next_run < ctx->next_run)
> > +	if (next_run && (!ctx->next_run || next_run < ctx->next_run))
> >  		ctx->next_run = next_run;
> > -	return 0;
> >  }
> >  
> >  static void nat_keepalive_work(struct work_struct *work)
> >  {
> > +	struct nat_keepalive_state *state, *tmp;
> >  	struct nat_keepalive_work_ctx ctx;
> >  	struct xfrm_state_walk walk;
> >  	struct net *net;
> > +	int err;
> >  
> > +	INIT_LIST_HEAD(&ctx.states);
> >  	ctx.next_run = 0;
> >  	ctx.now = ktime_get_real_seconds();
> >  
> >  	net = container_of(work, struct net, xfrm.nat_keepalive_work.work);
> >  	xfrm_state_walk_init(&walk, IPPROTO_ESP, NULL);
> > -	xfrm_state_walk(net, &walk, nat_keepalive_work_single, &ctx);
> > +	err = xfrm_state_walk(net, &walk, nat_keepalive_work_collect, &ctx);
> >  	xfrm_state_walk_done(&walk, net);
> > +	list_for_each_entry_safe(state, tmp, &ctx.states, list) {
> > +		nat_keepalive_work_single(state->x, &ctx);
> > +		xfrm_state_put(state->x);
> > +		kfree(state);
> > +	}
> > +	if (err == -ENOMEM) {
> > +		schedule_delayed_work(&net->xfrm.nat_keepalive_work, 0);
> > +		return;
> > +	}
> 
> [Severity: High]
> [Finding: main-1-0]
> [Sources: opus-5]
> Can this retry path make forward progress?
> 
> xfrm_state_walk() aborts the walk on any non-zero callback return and only
> records a resume cursor in walk:
> 
>     err = func(state, walk->seq, data);
>     if (err) {
>         list_move_tail(&walk->all, &x->all);
>         goto out;
>     }
> 
> but xfrm_state_walk_done(&walk, net) is called unconditionally right after,
> and it does list_del(&walk->all), throwing that cursor away.  walk is a
> stack variable that xfrm_state_walk_init() re-initialises on every
> invocation.
> 
> Since WORK_STRUCT_PENDING is cleared before the handler runs, the
> schedule_delayed_work(..., 0) here succeeds and the work re-executes
> essentially immediately, restarting from the head of net->xfrm.state_all
> and failing at the same point while the atomic reserves are still
> depleted.  There is no backoff and no retry bound, and nothing is retired
> between attempts.
> 
> Does this also duplicate keepalive packets?  The send branch in
> nat_keepalive_work_single():
> 
>     } else {
>         next_run = ctx->now + interval;
>         nat_keepalive_init(&ka, x);
>         send_keepalive = true;
>     }
> 
> computes a local next_run but never updates x->nat_keepalive_expiration, so
> on each immediate retry within the same second every SA before the failure
> point still satisfies delta >= interval and
> x->nat_keepalive_expiration <= ctx->now, and sends again.
> 
> And do SAs positioned after the failure point ever get serviced, given the
> walk always restarts from the head and the ctx.next_run schedule computed
> for the states that were processed is discarded by the early return?
> 
> Would returning 0 from nat_keepalive_work_collect() to skip the
> unallocatable entry (keeping the normal ctx.next_run schedule), or resuming
> the saved walk cursor with a bounded backoff, be preferable?
> 
> The changelog describes this as a locking-order fix only and does not
> mention the new retry behaviour.  Could it be documented there?
> 
> >  	if (ctx.next_run)
> >  		schedule_delayed_work(&net->xfrm.nat_keepalive_work,
> >  				      (ctx.next_run - ctx.now) * HZ);
