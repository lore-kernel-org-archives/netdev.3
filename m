Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693106;
	b=bnYJg2u2darHy9WOzp6CZ9jO6hCJiml1Qa10/sGosJ4XhQCIRo6L2Yoy2DCFKmJIHeMF
	 YsFA1lMSkX9bMzKOZkaU2qGj9RxnoLHu+CV6R72X1YPL97A9hp0p4Jbl3froJPK7AM04P
	 zqDFZhSYsptdTTz4WCjupDYlc5hCJppyqSM8B6YeOb1SM+T8uynQVizlqpARaAuLpPicl
	 DJCc8h74ULXj2iMPK3/46V9LZsw00zUm6jMJDqs4HygehejczMxCAj1o6uMij69Nr6EMc
	 o+ftrUYVbaTTQAYHbAnMryEAWTi25oMEOhXFxCMqBIgE0xLLuacS8RACYIW+irRq9Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693106;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=L8o2cBi6346Y3GtnLbYS5N1jSqKd0LwqvM1KjPOPqTs=;
	b=gtMyTpICEa/ZSxvSjQjix/dgk4yCS6jptLYoU16oD7qrrEAbm6kdDE/Yii6MiyNGQ/Ap
	 e4YkXd/TXRKJ5zYdQaHKKHroaQPYKl/AiK/5y9Z5bJbjtWLPjydCu9bjJSMXNIMKhZu4A
	 Em8/cDhArjCnSNzHrM6NP9dHuYQATQ3AZOU+62KELAas5oNNdzCmaySlb1VK7NcXk2N50
	 0QO7u2ooQlXawn+zOUfmkGvUFJFtLrh7VY20gQiBw6WDIOkGVDExpHt4fKnIrhG4ERADm
	 qGXhzrzqHFQ6JJS6iLDWNGJBIx0rat8xehb5MgVCRZRd8ymQyHFRXe8o7nw0g+7CqcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FE5h80p5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08EC606A333
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FE5h80p5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426901F000C1;
	Tue,  3 Nov 2026 08:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793693105;
	bh=L8o2cBi6346Y3GtnLbYS5N1jSqKd0LwqvM1KjPOPqTs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FE5h80p5uQ0F4iLWr462/hAjN1wo2tFa4JYHzfDzWKOJq3J/RHQEB5r3Oz6fGYKmi
	 Q2P3oR8VboXiObSVG/CsK+vou2HdnnfRD4GovA7s6QW58NxTs5dVH+PNFfO0qZbdvL
	 51aZMyO5hA5xHrmFQCGoZcL6uqgzQB1MMnZYgnxOiAtMkrkUBALo75KyG6OBO+Baf3
	 IqCkmVGe93+ys4b/Lt5RzXu+LXqKyLXD1xCasY8MnutUZg6EN1BpUzKYFTNaefZc9S
	 H3x9p3uQPWmmra0W62+m2rmx/TgcQedyiTC7Tggn0a1f9QoRFKnXoAJrApOR3b20sZ
	 M6fTMHebXLUxw==
Subject: Re: [PATCH 08/14] xfrm: state: exact mark/mask match for SPI-keyed
 control-plane SA lookups
From: netdev-bot+sashiko@kernel.org
To: steffen.klassert@secunet.com
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org
Date: Tue, 03 Nov 2026 08:05:04 +0000
Message-ID: <179369310478.488856.2697392451062168303@kernel.org>
In-Reply-To: <20261102100451.2505200-9-steffen.klassert@secunet.com>
References: <20261102100451.2505200-9-steffen.klassert@secunet.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch changes netlink request semantics without saying so.
- [Medium] The commit says ALLOCSPI larval states may be unmarked (0/0)
  and keeps UPDSA on the wildcard match for that reason.
- [Medium] UPDSA (xfrm_state_update()) still finds its target through
  __xfrm_state_locate(), which calls the wildcard…
- [Medium] The commit says it wires exact matching into DELSA/GETSA, but
  xfrm_user_state_lookup() converts only the SPI branch.
- [Low] At this commit,
  Documentation/networking/xfrm/xfrm_migrate_state.rst still says…

--

xfrm: state: exact mark/mask match for SPI-keyed control-plane SA lookups

This adds xfrm_state_lookup_exact(), which matches an SA only when both
the mark value and the mask are identical. It is used for the SPI-keyed
lookups in DELSA/GETSA, GETAE/NEWAE, EXPIRE and MIGRATE_STATE. UPDSA
keeps the wildcard match so that unmarked ALLOCSPI larval states can
still be found.

> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 602404ffc4d4b..f1e04df8d5011 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1177,11 +1177,19 @@ static struct xfrm_state *__xfrm_state_lookup_all(const struct xfrm_hash_state_p
>  	return NULL;
>  }
>
> -static struct xfrm_state *__xfrm_state_lookup(const struct xfrm_hash_state_ptrs *state_ptrs,
> -					      u32 mark,
> -					      const xfrm_address_t *daddr,
> -					      __be32 spi, u8 proto,
> -					      unsigned short family)
> +static bool xfrm_state_mark_matches(const struct xfrm_state *x, u32 mark, u32 mask, bool exact)
> +{
> +	if (exact)
> +		return x->mark.v == mark && x->mark.m == mask;

[Severity: Medium]
Does this change the netlink request semantics for existing userspace?

Before this patch, DELSA, GETSA, GETAE, NEWAE, EXPIRE and MIGRATE_STATE
matched an SA when ((m.v & m.m) & x->mark.m) == x->mark.v. The exact
branch now requires x->mark.v == m.v && x->mark.m == m.m. Requests that
used to work can now fail with -ESRCH, or -ENOENT for EXPIRE.

Two examples:

An SA is added with mark 0x10 mask 0xf0, followed by "ip xfrm state
get/delete ... mark 0x10". iproute2 sets mask 0xffffffff when none is
given. The old key was 0x10, and 0x10 & 0xf0 == 0x10, so this matched.
With the exact branch it does not.

An SA is added with mark 0 (0/0xffffffff), followed by DELSA/GETSA with
no XFRMA_MARK (0/0). That used to match and now fails.

The commit message lists the converted handlers. It does not say which
wrong-SA selection is being fixed, or that userspace must now pass the
SA's exact (v, m) pair.

The patch also carries a bare "Fixes: 3d6acfa7641f", so it qualifies for
automatic stable backport. Other ABI-changing patches in this series were
tagged "Cc: <stable+noautosel@kernel.org> # avoid breaking existing
userspace ABI".

Should this patch be tagged the same way? Should the commit message
describe the change that userspace will see?

> +	return (mark & x->mark.m) == x->mark.v;
> +}

[ ... ]

> @@ -1283,7 +1302,7 @@ static struct xfrm_state *__xfrm_state_lookup_byaddr(const struct xfrm_hash_stat
>  	return NULL;
>  }
>
> -static inline struct xfrm_state *
> +static struct xfrm_state *
>  __xfrm_state_locate(struct xfrm_state *x, int use_spi, int family)
>  {
>  	struct xfrm_hash_state_ptrs state_ptrs;
> @@ -1293,7 +1312,7 @@ __xfrm_state_locate(struct xfrm_state *x, int use_spi, int family)
>  	xfrm_hash_ptrs_get(net, &state_ptrs);
>
>  	if (use_spi)
> -		return __xfrm_state_lookup(&state_ptrs, mark, &x->id.daddr,
> +		return __xfrm_state_lookup(&state_ptrs, mark, 0, false, &x->id.daddr,
>  					   x->id.spi, x->id.proto, family);

[Severity: Medium]
UPDSA still picks its target through this wildcard lookup. Can
xfrm_state_update() still update the wrong SA when the states are VALID?

Overlapping SAs can coexist. The duplicate check in xfrm_state_add()
also goes through __xfrm_state_locate(), so the result depends on
insertion order:

  NEWSA A {mark 5, mask 0xff}
  NEWSA B {mark 0, mask 0}, same daddr/spi/proto
    key is 0, (0 & 0xff) != 5, so the add succeeds

XFRM_STATE_INSERT puts newer software states ahead of older ones in the
byspi chain, so B sits before A. Then:

  UPDSA with XFRMA_MARK 5/0xff
    xfrm_add_sa()->xfrm_state_update()->__xfrm_state_locate()
      key is 5, B matches first since (5 & 0) == 0

In the VALID branch, xfrm_state_update() then overwrites B's encap,
coaddr, lifetimes, smark and if_id, and restarts B's timer. A, the SA
named in the request, stays unchanged.

The commit message gives unmarked ALLOCSPI larval states as the reason
to keep the wildcard here. That reason only covers XFRM_STATE_ACQ
states.

Would it work to try an exact match first, and fall back to the wildcard
only for XFRM_STATE_ACQ larval states?

[ ... ]

> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index c1571c7a23153..5a9f729b4fcb0 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -1109,11 +1109,12 @@ static struct xfrm_state *xfrm_user_state_lookup(struct net *net,
>  	struct xfrm_state *x = NULL;
>  	struct xfrm_mark m;
>  	int err;
> -	u32 mark = xfrm_mark_get(attrs, &m);
> +
> +	xfrm_mark_get(attrs, &m);
>
>  	if (xfrm_id_proto_match(p->proto, IPSEC_PROTO_ANY)) {
>  		err = -ESRCH;
> -		x = xfrm_state_lookup(net, mark, &p->daddr, p->spi, p->proto, p->family);
> +		x = xfrm_state_lookup_exact(net, &m, &p->daddr, p->spi, p->proto, p->family);

[Severity: Medium]
The commit message says ALLOCSPI larval states may be unmarked (0/0).
Can DELSA still find those larval states after this change?

xfrm_alloc_userspi() passes the request's mark to xfrm_find_acq(), and
__find_acq_core() copies it into the new ACQ state:

net/xfrm/xfrm_state.c:__find_acq_core() {
    ...
		x->mark.v = m->v;
		x->mark.m = m->m;
    ...
}

So an ALLOCSPI without XFRMA_MARK creates a 0/0 larval state that holds
the allocated SPI.

Suppose negotiation fails, or the CHILD_SA is torn down before UPDSA. An
IKE daemon then sends DELSA for that SPI with its configured inbound
mark, for example 5/0xffffffff. strongSwan behaves this way: its
ALLOCSPI carries no mark, and its child_sa destroy deletes my_spi with
mark_in.

Before this patch the key was 5. Since (5 & 0) == 0, the larval state
was found and deleted.

Now xfrm_del_sa()->xfrm_user_state_lookup()->xfrm_state_lookup_exact()
requires v == 5 && m == 0xffffffff, so DELSA returns -ESRCH. No delete
notification is sent. The larval state keeps the SPI reserved until its
acquire hard timer (sysctl_acq_expires) fires.

>  	} else {
>  		xfrm_address_t *saddr = NULL;
>
> @@ -1124,7 +1125,7 @@ static struct xfrm_state *xfrm_user_state_lookup(struct net *net,
>  		}
>
>  		err = -ESRCH;
> -		x = xfrm_state_lookup_byaddr(net, mark,
> +		x = xfrm_state_lookup_byaddr(net, m.v & m.m,
>  					     &p->daddr, saddr,
>  					     p->proto, p->family);

[Severity: Medium]
The commit message says DELSA/GETSA now use exact matching. This branch
still does a wildcard lookup and drops the request's mask. Should the
non-SPI path be converted as well?

This branch handles protocols where xfrm_id_proto_match(p->proto,
IPSEC_PROTO_ANY) is false, such as MIPv6 IPPROTO_ROUTING and
IPPROTO_DSTOPTS states. __xfrm_state_lookup_byaddr() still does:

		if ((mark & x->mark.m) != x->mark.v)
			continue;

Overlapping states can coexist here too:

  NEWSA A {mark 5, mask 0xff}
  NEWSA B {mark 0, mask 0}, same daddr/saddr/proto
    duplicate check key is 0, (0 & 0xff) != 5, so the add succeeds

XFRM_STATE_INSERT puts B ahead of A in the bysrc chain. Then:

  DELSA with XFRMA_MARK 5/0xff and XFRMA_SRCADDR
    xfrm_del_sa()->xfrm_user_state_lookup()->xfrm_state_lookup_byaddr()
      key is 5, B matches first since (5 & 0) == 0
    xfrm_state_delete(B)

As a result B is deleted, not the SA named in the request. GETSA returns
the wrong SA in the same way.

[ ... ]

> @@ -3402,9 +3403,9 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
>
>  	copy_from_user_migrate_state(&m, um);
>
> -	x = xfrm_state_lookup(net, m.old_mark.v & m.old_mark.m,
> -			      &um->id.daddr, um->id.spi,
> -			      um->id.proto, um->id.family);
> +	x = xfrm_state_lookup_exact(net, &m.old_mark,
> +				    &um->id.daddr, um->id.spi,
> +				    um->id.proto, um->id.family);

[Severity: Low]
At this commit, Documentation/networking/xfrm/xfrm_migrate_state.rst
still describes the old lookup. It says the SA is found with
xfrm_state_lookup() using old_mark.v & old_mark.m as the mark key. The
struct comment there reads:

        struct xfrm_mark       old_mark; /* SA lookup: key = v & m */

xfrm_do_migrate_state() now needs an exact {v, m} match.

A later patch in this series, "docs: xfrm: include mark in
XFRM_MSG_MIGRATE_STATE EEXIST tuple", rewrites this section to describe
xfrm_state_lookup_exact(). It changes the comment to "/* SA lookup key
(exact v/m match) */", so the mismatch is gone by the end of the series.

Could the documentation update be folded into this patch, so that code
and docs agree at every commit?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102100451.2505200-2-steffen.klassert%40secunet.com
