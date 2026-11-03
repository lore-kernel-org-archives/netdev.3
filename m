Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704427;
	b=feTmHgDQFNG84IGkRC1u26vJ0tUVsLpnNo8N8yx/nIsoTy3eZ/fBxR/QdZT0rka1v1Jl
	 bWOQnwyIWG5WOntBeqS9/PKAeEkppbQGqVO8Ld4DY9vgnINMLawhDouD4xTKsV0kMNkJY
	 7cS1GluXajyOaLb18Il/frncse3h2yOsKHisv/soVqha8ARBJfJyFiu7j4/V3J9O86YiU
	 /UxoR8oRGu8zaVUd4XneAUGiv+i8+dXB8NxzpPwymd8TXTV3eohCIymf8DJX6tI0LSfeD
	 TL4TKe7JtkCVmESugaxR9oUu2sVRIeMq/6dW2dsWA/tZIQKwYzLV9GIE6Of5HPkrclA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704427;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy;
	bh=gbGGtMwJXv+vrGtAiCEgOhxLzkIGc2hi/IZq1J6btIY=;
	b=ON07NwrzbnaJReA94OnXgcjdeYGOeh1BhPS9Gb9C2YBgl54g8KEOROcWMsinVajZhxh8
	 DJYydeuv62RlGFbFGpnZj/fSnpHMuEdOkpd1y0RbuHNldVraRw6nhAnmwgQc/HTwSima8
	 edzFwVUwrHm1lxy8s8CZU3xwD6C4OPr05loAReGzbUcU2xJcKHMc5aMd2uL+vJ2ZI38Pg
	 tffdq4hOYJVuW6Fec67A00CkvO0KdMzmPpAqfZw24NgMKf86hNoh8/7dw4cieSJpYQ1Az
	 qCuSCEQlLnz2hWyH2zuYQiOk/620DGZO4jd3BxeMsPoVCpACcyXKxpDeZZH3iY/J/rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=FEVQEDOP;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4807D606C5C9
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 11:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4807D606C5C9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=FEVQEDOP
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 61B9A2050A;
	Tue,  3 Nov 2026 12:13:43 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GXbpQV9b-62C; Tue,  3 Nov 2026 12:13:42 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 885D9201AA;
	Tue,  3 Nov 2026 12:13:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 885D9201AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793704422;
	bh=gbGGtMwJXv+vrGtAiCEgOhxLzkIGc2hi/IZq1J6btIY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=FEVQEDOPUBDdJz0IzijqTu4CZ06GzzvMa38CsrxQ7W0V1hiH45W7dqnoP0Gq+Q1E/
	 AcAI+SEzBTH8hV/7ocSjlzUgtMzKKpPz6m0WHrqJ/bEstZiYrmRPopY9B+Q6ghjOgP
	 stcJncyOIWLWic6XnLTpJiJvr3gb/D50PUDTuMDnQeAhxBy3Cfg2VaZTUSjz4mwOwd
	 k7+D+4vaSbTaD+xAQn2FVw/ROL1Vr6kg9S6ruwm/uQYUosm4uFQeK7wPGoTMU8Y8EV
	 27fCdPTvgsL1G2sNcyraMuz7JZlpNHW3EX6GJQCG+i1Fql7XOBYNbvLXpGoBhsSQsS
	 whi4uuCYMBWlw==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 3 Nov
 2026 12:13:41 +0100
Received: (nullmailer pid 3813398 invoked by uid 1000);
	Tue, 03 Nov 2026 11:13:40 -0000
Date: Tue, 3 Nov 2026 12:13:40 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, Antony Antony <antony.antony@secunet.com>
Subject: Re: [PATCH 11/14] xfrm: include mark in MIGRATE_STATE SA collision
 check
Message-ID: <aunB5Kc0Naqn4lx8@gauss4>
References: <20261102100451.2505200-12-steffen.klassert@secunet.com>
 <179369310574.488856.7247083630566929798@kernel.org>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179369310574.488856.7247083630566929798@kernel.org>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Nov 03, 2026 at 08:05:05AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 0 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] MIGRATE_STATE checks for a collision with one key and installs
>   with another, so for non-SPI protocols (e.g. IPPROTO_IPIP) the…
> - [Medium] The new xfrm_state_mark_collides() checks for collisions
>   without the state lock.
> 
> Pre-existing issues:
> - [Low] Discarded: the issue predates this patch and a later patch in
>   this series fixes it.
> 
> --
> 
> xfrm: include mark in MIGRATE_STATE SA collision check
> 
> This commit makes XFRM_MSG_MIGRATE_STATE take the SA mark into account
> when it checks the new tuple for collisions. It adds
> xfrm_state_mark_collides(), which walks the SPI hash bucket for the target
> tuple and skips the state being migrated. It also makes
> xfrm_state_migrate_install() use xfrm_state_add() instead of
> xfrm_state_insert() when the mark changes.
> 
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index f1e04df8d5011..65663c7ba836a 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -2202,10 +2202,12 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
> >  			       struct netlink_ext_ack *extack)
> >  {
> >  	if (m->new_family == m->old_family &&
> > -	    xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
> > +	    xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family) &&
> > +	    xc->mark.v == x->mark.v && xc->mark.m == x->mark.m) {
> 
> [Severity: Medium]
> 
> With the added mark comparison, a migration that changes the mark but
> keeps the same daddr now goes through xfrm_state_add() instead of
> xfrm_state_insert(). For protocols that don't use the SPI for lookup, can
> this fail after the original SA has already been deleted?
> 
> xfrm_do_migrate_state() doesn't restrict um->id.proto. The pre-check in
> xfrm_state_mark_collides() always walks the byspi bucket for (new_daddr,
> spi, proto, family).
> 
> For IPPROTO_IPIP, use_spi is false in xfrm_state_add(), so
> __xfrm_state_locate() calls __xfrm_state_lookup_byaddr() with (daddr,
> saddr, proto, mark).
> 
> IPIP states created by ipcomp_tunnel_create() have a non-zero SPI:
> 
>     t->id.spi = x->props.saddr.a4;
> 
> That puts them in byspi, so xfrm_state_lookup_exact() can find them. Take
> these two states:
> 
>   state A: IPIP, src SA, dst D, spi SA, mark 1/0xff
>   state B: IPIP, src SB, dst D, spi SB, mark 2/0xff
> 
> and migrate A with new_saddr=SB, new_daddr=D and XFRMA_MARK=2/0xff:
> 
> xfrm_do_migrate_state()
>   xfrm_state_mark_collides()     /* only the (D, spi SA) bucket, misses B */
>   xfrm_state_migrate_create()    /* ipip_init_state() accepts the clone */
>   __xfrm_state_delete(x)         /* A is unhashed */
>   xfrm_state_migrate_install()
>     xfrm_state_add(xc)
>       __xfrm_state_locate()      /* use_spi == 0 */
>         __xfrm_state_lookup_byaddr()   /* finds B */
>       returns -EEXIST
> 
> A is gone, the clone is dropped, and userspace gets -EEXIST. That case
> contradicts the "Should not occur" comment in xfrm_do_migrate_state(). It
> also contradicts the series documentation, which says the old SA stays
> intact and the operation is safe to retry.
> 
> Should the pre-check use the same key that xfrm_state_add() uses for
> non-SPI protocols? Alternatively, should MIGRATE_STATE reject protocols
> that don't use the SPI for lookup?

Both is possible, I'd leave that to Antony for a followup patch.

> 
> >  		/*
> > -		 * Care is needed when the destination address of the state is
> > -		 * to be updated as it is a part of triplet.
> > +		 * Care is needed when the destination address or mark of the
> > +		 * state is to be updated, as they are part of the lookup
> > +		 * triplet.
> >  		 */
> >  		xfrm_state_insert(xc);
> >  	} else {
> > @@ -2440,6 +2442,38 @@ xfrm_state_lookup_exact(struct net *net, const struct xfrm_mark *mark,
> >  }
> >  EXPORT_SYMBOL(xfrm_state_lookup_exact);
> >  
> > +/* True if some OTHER state at this tuple would wildcard-match "mark".
> > + * Used by MIGRATE_STATE, which must exclude the state being migrated.
> > + */
> > +bool xfrm_state_mark_collides(struct net *net, u32 mark,
> > +			      const xfrm_address_t *daddr, __be32 spi,
> > +			      u8 proto, unsigned short family,
> > +			      const struct xfrm_state *self)
> > +{
> > +	struct xfrm_hash_state_ptrs state_ptrs;
> > +	unsigned int h;
> > +	struct xfrm_state *x;
> > +	bool collides = false;
> > +
> > +	rcu_read_lock();
> > +	xfrm_hash_ptrs_get(net, &state_ptrs);
> > +	h = __xfrm_spi_hash(daddr, spi, proto, family, state_ptrs.hmask);
> > +
> > +	hlist_for_each_entry_rcu(x, state_ptrs.byspi + h, byspi) {
> > +		if (x != self && x->props.family == family &&
> > +		    x->id.spi == spi && x->id.proto == proto &&
> > +		    xfrm_addr_equal(&x->id.daddr, daddr, family) &&
> > +		    (mark & x->mark.m) == x->mark.v) {
> > +			collides = true;
> > +			break;
> > +		}
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	return collides;
> 
> [Severity: Medium]
> 
> This walk runs under rcu_read_lock() only. The result is stale as soon as
> the RCU lock is dropped, but xfrm_do_migrate_state() treats it as
> authoritative. The check that actually decides the outcome, in
> xfrm_state_add(), only runs after __xfrm_state_delete(x). Is that
> ordering safe?
> 
> xfrm_hash_ptrs_get() takes a seqcount-protected snapshot of the table
> pointers. The bucket walk itself is not covered by the seqcount, and
> nothing re-checks the generation afterwards.
> 
> The comment in xfrm_do_migrate_state() relies on xfrm_cfg_mutex. At least
> two byspi writers don't take that mutex.
> 
> The first is xfrm_hash_resize(). It runs from a work item and holds only
> xfrm_state_lock and the hash generation seqcount. xfrm_hash_transfer()
> relinks every node into the new tables, so a reader in the old bucket can
> follow a rewritten next pointer and skip the colliding entry.
> 
> The second is xfrm_state_find() on the packet path. When the template has
> a static SPI, it inserts ACQ states into byspi under xfrm_state_lock only:
> 
>     if (x->id.spi) {
>         h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, encap_family);
>         XFRM_STATE_INSERT(byspi, &x->byspi, ...
>     }
> 
> __xfrm_state_lookup() doesn't filter out ACQ states, so xfrm_state_add()
> would hit one that was inserted after the pre-check.
> 
> If either race happens:
> 
> xfrm_do_migrate_state()
>   xfrm_state_mark_collides()      /* returns false */
>   xfrm_state_migrate_create()     /* allocations, xfrm_init_state(), offload */
>   __xfrm_state_delete(x)
>   xfrm_state_migrate_install()
>     xfrm_state_add(xc)            /* returns -EEXIST */
>   xfrm_state_put(xc)
> 
> both the original SA and the clone are lost.
> 
> Before this patch, mark-only migrations used xfrm_state_insert(), which
> can't fail. They now reach this path too. The same lockless pre-check
> followed by a destructive install already existed for daddr and family
> changes.

This looks valid. But as this issue is not new (daddr and family changes
have it already), I think we should fix that all together with a
followup. Antony?

Btw. none of these issues were flaged by sashiko on the original
patchset submittion.
