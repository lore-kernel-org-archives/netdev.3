Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952983B19A0
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907751; cv=none; b=kQxTH4BKZc+qa8gZhfEvzgIo0Sdrz0tXEJOqTcDpG3MsHilkco2uZ2H2A3tRnKePbpQ4a1GzvxUhiqAe4ul7w1szFBEdjqNxvll4y6xvAqU8W6CBc/BkBGXinc9yM1qV3RJfROG8ZCfeg7aKJ7IRGP/gwoNrCObxj9t9m56jK30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907751; c=relaxed/simple;
	bh=MfOO+UXDkh4iMfhQ4pePWebky/zrnhsjByYn+uQzklU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jvfq9X0pxH2z+w7xoLqjdN00U4hjojKrMaTKnSmUZP9hZc7n0mI/JxtJs7Ag8iblhIM6KLa17E3YHtW4OyRftnT+53BluouZtAYZqo8Ty4PIDCIRoiMV908vZZHEj8seF6Q1EVXZSeqZKVg5Td3gUWpX5ZV6BzM3W08eAzX5hEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLwXVfV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLwXVfV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49AD1F00ACA;
	Tue,  8 Sep 2026 22:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907740;
	bh=CyA7n2nyP/zDFuq0KjKtktHZ2WYOVDgXX6fc4adJLOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OLwXVfV276r80VN3avC/XxdxpEAooXro5ZKOBIRwugyFbqoV3fWBcuvcxzeh97wiH
	 S67l9sL4Sqia1n3dNeFsTC1t7b/UjFQTKpEhJ1N9OsjYO2LauAkzyubqu55I4DDDQ8
	 OdlXSX5kpogwVPS5Q55VLyDvAX/gu8D7peWArd27D5aGwu44vTyUVyD09ezITYMk+S
	 87UvFiMZ/349Yu/cxssIPOZDdN6QpGD3UCGSQGaiaJhpRfgaR/N0zses8BZijS5RdU
	 qMRlpGkslc1+duG50CQ7kCBea3JOS+KU6j57e3FCgIUjiNb00rwuD8O8ZBtIW87lCN
	 5ElI0c7iYPDrA==
From: Jakub Kicinski <kuba@kernel.org>
To: steffen.klassert@secunet.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	netdev@vger.kernel.org
Subject: Re: [PATCH 08/12] xfrm: use hlist_del_init_rcu for state_cache and state_cache_input
Date: Tue,  8 Sep 2026 15:48:58 -0700
Message-ID: <20260908224858.1591267-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907093020.2228346-9-steffen.klassert@secunet.com>
References: <20260907093020.2228346-9-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
xfrm: use hlist_del_init_rcu for state_cache and state_cache_input

This switches the two remaining hlist_del_rcu() calls in
__xfrm_state_delete() (state_cache and state_cache_input) to
hlist_del_init_rcu(), so that all six unhash sites in that function leave
pprev == NULL.  The changelog describes this as closing a write
use-after-free that in turn produces a read use-after-free in
xfrm_input_state_lookup().

There are no Link: tags in the commit header.

Two questions below, one about the changelog and one about whether the
state_cache half of the change can have any effect.

> A second __xfrm_state_delete() therefore enters __hlist_del() on the
> already-deleted state_cache/state_cache_input nodes and does
> WRITE_ONCE(*pprev, next) through LIST_POISON2 — a write use-after-free
> once the slab is reused. The corruption can in turn cause a subsequent
> hlist_for_each_entry_rcu traversal to follow a dangling next pointer,
> producing the read use-after-free reported in xfrm_input_state_lookup().

[Severity: High]
Can a second __xfrm_state_delete() reach the unhash block at all?  The
whole body is gated on km.state, and the gate sets DEAD as its first
action:

net/xfrm/xfrm_state.c:__xfrm_state_delete() {
	if (x->km.state != XFRM_STATE_DEAD) {
		x->km.state = XFRM_STATE_DEAD;

		spin_lock(&net->xfrm.xfrm_state_lock);
		list_del(&x->km.all);
		hlist_del_init_rcu(&x->bydst);
		...
}

All four callers hold x->lock across that test-and-set:

	xfrm_state_delete()      spin_lock_bh(&x->lock) ... spin_unlock_bh()
	xfrm_timer_handler()     spin_lock(&x->lock), and also returns early
	                         on x->km.state == XFRM_STATE_DEAD
	xfrm_add_sa_expire()     spin_lock_bh(&x->lock) (net/xfrm/xfrm_user.c)
	xfrm_do_migrate_state()  spin_lock_bh(&x->lock) (net/xfrm/xfrm_user.c)

and no path resets km.state away from DEAD.  Wouldn't a second call
therefore return -ESRCH before touching any hlist?

Separately, is the described mechanism the one that would occur?  If the
gate were somehow bypassed, __hlist_del()'s very first store goes through
the poisoned pprev:

include/linux/list.h:__hlist_del() {
	struct hlist_node *next = n->next;
	struct hlist_node **pprev = n->pprev;

	WRITE_ONCE(*pprev, next);
	if (next)
		WRITE_ONCE(next->pprev, pprev);
}

Since hlist_del_rcu() leaves pprev == LIST_POISON2, which is a fixed
illegal address, isn't the result an immediate oops rather than "a write
use-after-free once the slab is reused"?  And as the store to
next->pprev is never reached, how would this corrupt a live chain so that
a later hlist_for_each_entry_rcu() follows a dangling next pointer?

If the read use-after-free in xfrm_input_state_lookup() is real, it looks
like it has some other cause (an xfrm_state still reachable from an RCU
list after being freed), which this change does not address.  Given the
two Fixes: tags and Cc: stable, could the changelog be reworded to
describe the change as consistency hardening, and could a Reported-by:,
Closes: or the KASAN splat/reproducer be included so the actual lifetime
bug can be tracked?

One more note on the stated threat model: if a double
__xfrm_state_delete() were possible, list_del(&x->km.all),
net->xfrm.state_num-- and xfrm_state_put(x) in the same body are still
non-idempotent, so would making only the hlist removals idempotent be
sufficient?  Turning the poisoned-pprev write into a silent no-op also
removes the oops that would point at the real problem.

> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index de097bba803b7..e45aa1ed5b965 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -826,9 +826,9 @@ int __xfrm_state_delete(struct xfrm_state *x)
>  		if (!hlist_unhashed(&x->byseq))
>  			hlist_del_init_rcu(&x->byseq);
>  		if (!hlist_unhashed(&x->state_cache))
> -			hlist_del_rcu(&x->state_cache);
> +			hlist_del_init_rcu(&x->state_cache);

[Severity: Medium]
Can !hlist_unhashed(&x->state_cache) ever be true here?  The only site in
the tree that hashes x->state_cache is at the tail of xfrm_state_find():

net/xfrm/xfrm_state.c:xfrm_state_find() {
	if (x && x->km.state == XFRM_STATE_VALID && !cached &&
	    (!(pol->flags & XFRM_POLICY_CPU_ACQUIRE) || x->pcpu_num == pcpu_id)) {
		spin_lock_bh(&net->xfrm.xfrm_state_lock);
		if (hlist_unhashed(&x->state_cache))
			hlist_add_head_rcu(&x->state_cache, &pol->state_cache_list);
		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
	}

but cached is set at a label that is also the fall-through of the second
state_cache_list loop:

cached:
	cached = true;
	if (best)
		goto found;
	else if (error)
		best = NULL;

The only jump to that label is the cache-hit case "if (best) goto cached;"
after the first loop, and all other paths simply fall into it, so isn't
cached unconditionally true by the time the tail check runs?  That would
make the hlist_add_head_rcu(&x->state_cache, &pol->state_cache_list) call
unreachable, leave pol->state_cache_list permanently empty (the loop in
xfrm_policy_kill() then also always walks an empty list), and mean the
guard above can never be true.

The cached = true placement comes from 0045e3d80613 ("xfrm: Cache used
outbound xfrm states at the policy.") rather than from this patch, but it
appears to make the state_cache half of this change inert and contradicts
the changelog's claim that the state_cache node can be double-deleted.
Would setting cached = true only on the cache-hit branch, instead of at a
label that is also fallen into, be the right fix?

>  		if (!hlist_unhashed(&x->state_cache_input))
> -			hlist_del_rcu(&x->state_cache_input);
> +			hlist_del_init_rcu(&x->state_cache_input);
>  
>  		if (!hlist_unhashed(&x->byspi))
>  			hlist_del_init_rcu(&x->byspi);
