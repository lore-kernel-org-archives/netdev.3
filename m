Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693107;
	b=pBp/i/+24/SXNBzKGoMNeHhIlmVuysS1iXWZ6P0D6dDqO52h03xL6WJb/Th0/61/rzkC
	 ySxAavomQGATV5WUO77HbRSSwXzOglgZB143DbcaoltoeuLwN/GhGpqufuTO0mZVc4CA7
	 kWGxLh7xxZn3H5JHmxYmkrLvIy1Qj0OM2AFRDBIKGithYf5jLk97cwudGd0mmA6AVPIGM
	 NeRKIc2fGPs8eChcu+COmbxDZQIjjsEW0Yntq024iTN00OFBBSrh4v+uYVKyBWMSI5ef7
	 ZseSaCET3RS3GqdLyDmalqPUhnovI++HkR9y70WSje1nvkOPg+I0lK0DN/r9j2PhKTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693107;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ia4nzrs6QUNP7sfFAv9YjkXcesitbLcRpkJjr4jgsb4=;
	b=1maSjGgZZh4EFlsWRtKptHJfDiHOu17D4i4naQDlHJKrAW5xevtH5iwJ9FmS+cEZD9hc
	 oOVWhqCh+FfTDTruvFgoTUnoP58Gy922Mmqkezcn9gCXV9M1Fh/SQ7pd+ltXHXL1E068g
	 YK3B8n1vtC+eG7XZBz74GVKz7HKrhqTUAcjY+f2xIRt8CTtbA0EBx+AQveQp5W596XCQj
	 rXKUwbxOjvG9s/IMHsqXeyGUp83M7gClhVBzj9hZGPCOFwZXJcNeK3kD718SngLjc7Xv6
	 vVh/w5VBPS1LJRh8ZgAL1LSWmjD2aM7iF6DUKOyApr4rlu+lvhaukANbqhgsz57eBcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ogb9nX+A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB12B606A32E
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ogb9nX+A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284241F00A02;
	Tue,  3 Nov 2026 08:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793693106;
	bh=ia4nzrs6QUNP7sfFAv9YjkXcesitbLcRpkJjr4jgsb4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ogb9nX+AhOxuYc9DaRUlANezNSPVZpohx1p9OtFKgrQHW8TDjpWNse2lVctOiBxWc
	 EWxA6BULS3kqiL8bQRQuqSiS+Axh4gBYB8JrB2whiRu/p4OvtV6v4bgweBUSkNU2F8
	 oGwRxx9uVwZ9rd1yfq3jBK6grzH3YgREgmc813YHPFY9CapX823CZtCbTgqJStuVmc
	 K9heIrmTqt/UDPhWxWBuxTGQoh5wDAFWH9LzRPJBOlF6ZSxsE+Z7GJI/goZ/i/TOXn
	 z6h4eibF+K8yZn+lVensAwsxzwCMrZu1BTA6f9yM2CvZN6NKc3/YkKjQLj5xM7Mh8o
	 /PfDH5n8iyidQ==
Subject:
 Re: [PATCH 11/14] xfrm: include mark in MIGRATE_STATE SA collision check
From: netdev-bot+sashiko@kernel.org
To: steffen.klassert@secunet.com
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org
Date: Tue, 03 Nov 2026 08:05:05 +0000
Message-ID: <179369310574.488856.7247083630566929798@kernel.org>
In-Reply-To: <20261102100451.2505200-12-steffen.klassert@secunet.com>
References: <20261102100451.2505200-12-steffen.klassert@secunet.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] MIGRATE_STATE checks for a collision with one key and installs
  with another, so for non-SPI protocols (e.g. IPPROTO_IPIP) the…
- [Medium] The new xfrm_state_mark_collides() checks for collisions
  without the state lock.

Pre-existing issues:
- [Low] Discarded: the issue predates this patch and a later patch in
  this series fixes it.

--

xfrm: include mark in MIGRATE_STATE SA collision check

This commit makes XFRM_MSG_MIGRATE_STATE take the SA mark into account
when it checks the new tuple for collisions. It adds
xfrm_state_mark_collides(), which walks the SPI hash bucket for the target
tuple and skips the state being migrated. It also makes
xfrm_state_migrate_install() use xfrm_state_add() instead of
xfrm_state_insert() when the mark changes.

> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index f1e04df8d5011..65663c7ba836a 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -2202,10 +2202,12 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
>  			       struct netlink_ext_ack *extack)
>  {
>  	if (m->new_family == m->old_family &&
> -	    xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
> +	    xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family) &&
> +	    xc->mark.v == x->mark.v && xc->mark.m == x->mark.m) {

[Severity: Medium]

With the added mark comparison, a migration that changes the mark but
keeps the same daddr now goes through xfrm_state_add() instead of
xfrm_state_insert(). For protocols that don't use the SPI for lookup, can
this fail after the original SA has already been deleted?

xfrm_do_migrate_state() doesn't restrict um->id.proto. The pre-check in
xfrm_state_mark_collides() always walks the byspi bucket for (new_daddr,
spi, proto, family).

For IPPROTO_IPIP, use_spi is false in xfrm_state_add(), so
__xfrm_state_locate() calls __xfrm_state_lookup_byaddr() with (daddr,
saddr, proto, mark).

IPIP states created by ipcomp_tunnel_create() have a non-zero SPI:

    t->id.spi = x->props.saddr.a4;

That puts them in byspi, so xfrm_state_lookup_exact() can find them. Take
these two states:

  state A: IPIP, src SA, dst D, spi SA, mark 1/0xff
  state B: IPIP, src SB, dst D, spi SB, mark 2/0xff

and migrate A with new_saddr=SB, new_daddr=D and XFRMA_MARK=2/0xff:

xfrm_do_migrate_state()
  xfrm_state_mark_collides()     /* only the (D, spi SA) bucket, misses B */
  xfrm_state_migrate_create()    /* ipip_init_state() accepts the clone */
  __xfrm_state_delete(x)         /* A is unhashed */
  xfrm_state_migrate_install()
    xfrm_state_add(xc)
      __xfrm_state_locate()      /* use_spi == 0 */
        __xfrm_state_lookup_byaddr()   /* finds B */
      returns -EEXIST

A is gone, the clone is dropped, and userspace gets -EEXIST. That case
contradicts the "Should not occur" comment in xfrm_do_migrate_state(). It
also contradicts the series documentation, which says the old SA stays
intact and the operation is safe to retry.

Should the pre-check use the same key that xfrm_state_add() uses for
non-SPI protocols? Alternatively, should MIGRATE_STATE reject protocols
that don't use the SPI for lookup?

>  		/*
> -		 * Care is needed when the destination address of the state is
> -		 * to be updated as it is a part of triplet.
> +		 * Care is needed when the destination address or mark of the
> +		 * state is to be updated, as they are part of the lookup
> +		 * triplet.
>  		 */
>  		xfrm_state_insert(xc);
>  	} else {
> @@ -2440,6 +2442,38 @@ xfrm_state_lookup_exact(struct net *net, const struct xfrm_mark *mark,
>  }
>  EXPORT_SYMBOL(xfrm_state_lookup_exact);
>  
> +/* True if some OTHER state at this tuple would wildcard-match "mark".
> + * Used by MIGRATE_STATE, which must exclude the state being migrated.
> + */
> +bool xfrm_state_mark_collides(struct net *net, u32 mark,
> +			      const xfrm_address_t *daddr, __be32 spi,
> +			      u8 proto, unsigned short family,
> +			      const struct xfrm_state *self)
> +{
> +	struct xfrm_hash_state_ptrs state_ptrs;
> +	unsigned int h;
> +	struct xfrm_state *x;
> +	bool collides = false;
> +
> +	rcu_read_lock();
> +	xfrm_hash_ptrs_get(net, &state_ptrs);
> +	h = __xfrm_spi_hash(daddr, spi, proto, family, state_ptrs.hmask);
> +
> +	hlist_for_each_entry_rcu(x, state_ptrs.byspi + h, byspi) {
> +		if (x != self && x->props.family == family &&
> +		    x->id.spi == spi && x->id.proto == proto &&
> +		    xfrm_addr_equal(&x->id.daddr, daddr, family) &&
> +		    (mark & x->mark.m) == x->mark.v) {
> +			collides = true;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return collides;

[Severity: Medium]

This walk runs under rcu_read_lock() only. The result is stale as soon as
the RCU lock is dropped, but xfrm_do_migrate_state() treats it as
authoritative. The check that actually decides the outcome, in
xfrm_state_add(), only runs after __xfrm_state_delete(x). Is that
ordering safe?

xfrm_hash_ptrs_get() takes a seqcount-protected snapshot of the table
pointers. The bucket walk itself is not covered by the seqcount, and
nothing re-checks the generation afterwards.

The comment in xfrm_do_migrate_state() relies on xfrm_cfg_mutex. At least
two byspi writers don't take that mutex.

The first is xfrm_hash_resize(). It runs from a work item and holds only
xfrm_state_lock and the hash generation seqcount. xfrm_hash_transfer()
relinks every node into the new tables, so a reader in the old bucket can
follow a rewritten next pointer and skip the colliding entry.

The second is xfrm_state_find() on the packet path. When the template has
a static SPI, it inserts ACQ states into byspi under xfrm_state_lock only:

    if (x->id.spi) {
        h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, encap_family);
        XFRM_STATE_INSERT(byspi, &x->byspi, ...
    }

__xfrm_state_lookup() doesn't filter out ACQ states, so xfrm_state_add()
would hit one that was inserted after the pre-check.

If either race happens:

xfrm_do_migrate_state()
  xfrm_state_mark_collides()      /* returns false */
  xfrm_state_migrate_create()     /* allocations, xfrm_init_state(), offload */
  __xfrm_state_delete(x)
  xfrm_state_migrate_install()
    xfrm_state_add(xc)            /* returns -EEXIST */
  xfrm_state_put(xc)

both the original SA and the clone are lost.

Before this patch, mark-only migrations used xfrm_state_insert(), which
can't fail. They now reach this path too. The same lockless pre-check
followed by a destructive install already existed for daddr and family
changes.

Could the final collision check and the removal of x happen within the
same xfrm_state_lock section?

> +}
> +EXPORT_SYMBOL(xfrm_state_mark_collides);
> +

[ ... ]

> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 4de8c401eb442..a5fbe38839c49 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -3476,15 +3476,14 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
>  						       x->nat_keepalive_interval);
>  
>  	if (m.new_family != um->id.family ||
> -	    !xfrm_addr_equal(&m.new_daddr, &um->id.daddr, um->id.family)) {
> -		u32 new_mark_key = m.new_mark ? m.new_mark->v & m.new_mark->m :
> -						m.old_mark.v & m.old_mark.m;
> -		struct xfrm_state *x_new;
> -
> -		x_new = xfrm_state_lookup(net, new_mark_key, &m.new_daddr,
> -					  um->id.spi, um->id.proto, m.new_family);
> -		if (x_new) {
> -			xfrm_state_put(x_new);
> +	    !xfrm_addr_equal(&m.new_daddr, &um->id.daddr, um->id.family) ||
> +	    (m.new_mark && (m.new_mark->v != x->mark.v ||
> +			   m.new_mark->m != x->mark.m))) {
> +		const struct xfrm_mark *new_mark = m.new_mark ? m.new_mark : &x->mark;

[Severity: Low]

This isn't a bug introduced by this patch, but the SA Identification
section of Documentation/networking/xfrm/xfrm_migrate_state.rst is out of
date at this commit. It says the SA is looked up with xfrm_state_lookup(),
using old_mark.v & old_mark.m as the mark key. That is a wildcard match.

xfrm_do_migrate_state() actually does an exact lookup:

	x = xfrm_state_lookup_exact(net, &m.old_mark,
				    &um->id.daddr, um->id.spi,
				    um->id.proto, um->id.family);

xfrm_state_clone_and_setup() sets xc->mark from m->old_mark. The &x->mark
fallback here matches xc->mark only because that lookup is exact. So the
code is consistent, and only the documentation is stale.

A later commit in the series, "docs: xfrm: include mark in
XFRM_MSG_MIGRATE_STATE EEXIST tuple", appears to fix this. It rewrites the
section to describe xfrm_state_lookup_exact() with an exact match against
old_mark.v and old_mark.m.

> +
> +		if (xfrm_state_mark_collides(net, new_mark->v & new_mark->m,
> +					     &m.new_daddr, um->id.spi,
> +					     um->id.proto, m.new_family, x)) {
>  			NL_SET_ERR_MSG(extack, "New SA tuple already occupied");
>  			err = -EEXIST;
>  			goto out;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102100451.2505200-2-steffen.klassert%40secunet.com
