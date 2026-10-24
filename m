Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792863042;
	b=OjDm+tNqriGSQZD938Plr8XnnsLrZzJEIQzjvboM/Jx7MEIo33dFgsSJVjNs3sNXbVxF
	 K6At3asTNnH6rG4fQHKSKZULUWTCOXwF/GAsv68LX6/0RXrZPmNUvi7WR9UWRhXdHX6nU
	 krkSzxddnwHj6e0wajq5UTCbaYnf8Vi8ZZ2z3j7UvaZSKv48DboiF8iFqhS8IUo/z5yKg
	 zApppPOiDs7XpvUD7JOOM7mXB739Imc+uji9+WlM8IXfHXfPCsWPK72M43OdyQISY5r5F
	 Od8dV56GdqwPQw0+3anzdNPXXtRHwi68qSo71vawn9V3pfLjxr4pVmygZCcG19/K18A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792863042;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hLJA0K15EYcYSs8KNBQ3DyMOiCMV9o1tX6RLGScLy1w=;
	b=x1DYV9YsQ6NwvINR2oOxArPKVHNvpj1QmkdVWz/x8KdRr0SeMeXI5quSfmdUsL/Ckbb/
	 6Bat+NeornUMoCKaXEUj0N+hBtZIMTG5TYcgGN+8xD1lPrNfgtV7/1d9tcPQHrv/s/vz8
	 3XhBOMjQv1zYQ4FTHw/W9VuIZ18qsR7spa32aVqKMQjCo+3Ld/tyxMeOKvqAR2aEd8bqE
	 FsFPNXVivOaeGs4140OrMDk1RZnhcknaCXIrfNaGzNfMDu87GYQG4H7TSTnMFiJvxVgTS
	 RaJjS77i21eTNu1QGYEPqxCEPoaANLUE0bn61JNovHqREbOAET5DILu640VfmLgEBcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVxQ2ZI0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE9606A320
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVxQ2ZI0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCA81F01825;
	Sat, 24 Oct 2026 17:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792863041;
	bh=hLJA0K15EYcYSs8KNBQ3DyMOiCMV9o1tX6RLGScLy1w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SVxQ2ZI0VPhSxRTXjXutpNi2uKI8Z8DZ3L0rhLCgQN63yJn17GSW74s/rM+ec9gJ/
	 atXCat1iC5BAxl3FLahFpQchHgKgPs4peAPURlm7UZuAZjVswR5h3mYW5DlGYDssYf
	 2plKqxoheC55L7IeEowW9PGx8Nz0+TTlTXgcMExeSNXTw1+Yjh86+py632yy9Trtpy
	 5zYevl+DCjmVOjJWz0oZKSPRRO3ghGqwcUxNIOewvZnHa/eWEQGeASaNn7+ovKfnFT
	 q9lZjVLXNj/LOrBFhSyO3zUW5TA46QNfokEfjppyJ43KWcy81juaHmniW1Ap4Z30Fc
	 1UlXWaj3yOIBA==
Subject: Re: [PATCH net-next v8 4/4] net/sched: cake: hash before segmenting
 and reject an overlong split
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, toke@toke.dk, bjorn@kernel.org, sashiko-bot@kernel.org
Date: Sat, 24 Oct 2026 17:30:40 +0000
Message-ID: <179286304080.3134.13197757888201893950@kernel.org>
In-Reply-To: <QDISC-BA27.v8.r0.20261020063241-4@mojatatu.com>
References: <QDISC-BA27.v8.r0.20261020063241-4@mojatatu.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In cake_enqueue() (net/sched/sch_cake.c:1825-1827), the split-
  GSO path drops the original skb with plain qdisc_drop() when…
- [Low] The commit message calls this patch a fix and describes a defect
  that has been in released kernels since cake was merged: with…

--

net/sched: cake: hash before segmenting and reject an overlong split

This splits cake_hash() into two parts. cake_hash_keys() has no side
effects and runs on the unsegmented skb. cake_hash_resolve() runs only
once the packet is admitted.

Split-GSO segmentation now happens before the resolution. The summed
segment length is checked against QDISC_MAX_BACKLOG, and the whole list
is dropped if it is rejected. flow_mode is read once with READ_ONCE() so
that both halves use the same mode.

Link: https://lore.kernel.org/netdev/179231933068.3135.80340792633077986@kernel.org/

> The Fix:
> with CAKE_FLAG_SPLIT_GSO, cake computes the flow/host hash keys, then
> splits a GSO skb into segments it accounts individually. Key extraction
> must run on the unsegmented skb -- skb_gso_segment() can rewrite an
> encapsulated packet's headers to the inner ones -- and the resolution
> must wait until the packet is admitted, since it commits the
> set-associative tags, host indices and way counters that a later
> rejection would leave mutated (a GSO skb whose segmentation fails was
> dropped with that state already committed).

[ ... ]

> Link: https://lore.kernel.org/netdev/179231933068.3135.80340792633077986@kernel.org/
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
Should this have a Fixes: tag?

The commit message calls this a fix. The defect it describes has been in
released kernels for a long time. With CAKE_FLAG_SPLIT_GSO, cake_hash()
commits all of this before a failed skb_gso_segment() drops the packet:

  - q->tags[]
  - host tag and index assignments
  - bulk count changes on the collision path
  - the way_hits, way_misses and way_collisions counters

Blame on the baseline points to these two commits:

  046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) qdisc")
  0c850344d388 ("sch_cake: Conditionally split GSO segments")

The overlong-split rejection only closes a gap opened by the earlier
"net/sched: cap the accounted backlog before it can wrap" patch in this
series, so that part doesn't need a Fixes: tag. The state-before-drop
ordering looks like it does.

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index 91c33295b30b4..79d6f6f76dbc8 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c

[ ... ]

> @@ -1784,12 +1811,49 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  					 QDISC_DROP_OVERLIMIT);
>  	}
>  
> -	/* choose flow to insert into */
> +	/* Select the tin and extract the keys before segmenting:
> +	 * skb_gso_segment() rewrites encapsulated headers, which
> +	 * changes the keys.
> +	 */
>  	b = cake_select_tin(sch, skb);
> -	idx = cake_hash(b, skb, q->config->flow_mode, flow_override,
> -			host_override) + 1;
> +	cake_hash_keys(skb, flow_mode, flow_override, host_override, &keys);
> +
> +	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
> +		netdev_features_t features = netif_skb_features(skb);
> +		struct sk_buff *nskb, *seg;
> +
> +		segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
> +		if (IS_ERR_OR_NULL(segs))
> +			return qdisc_drop(skb, sch, to_free);

[Severity: Medium]
Can this qdisc_drop() report a bogus drop reason for the original skb?

__dev_xmit_skb() stores QDISC_DROP_GENERIC in tc_skb_cb(skb)->drop_reason,
which is at cb offset 32. __skb_gso_segment() then writes SKB_GSO_CB at
the same offset before it tries to segment:

net/core/gso.c:__skb_gso_segment() {
    ...
	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
	SKB_GSO_CB(skb)->encap_level = 0;
	SKB_GSO_CB(skb)->recursion_counter = 0;
	SKB_GSO_CB(skb)->max_segs = min(max_segs, U8_MAX);
    ...
	segs = skb_mac_gso_segment(skb, features);
    ...
}

The cb is not restored when skb_mac_gso_segment() fails or returns NULL.
It can fail with -EINVAL for malformed headers, -EPROTONOSUPPORT when
there is no gso handler, or -ENOMEM from skb_segment().

The skb is then freed through this path:

  qdisc_drop()->__qdisc_drop()->to_free->__tcf_kfree_skb_list()

__tcf_kfree_skb_list() reads the headroom value as drop_reason. That
value has no qdisc subsystem bits, so two things go wrong:

  - trace_qdisc_drop is skipped
  - kfree_skb_reason() gets an unrelated core skb_drop_reason equal to
    the headroom

A headroom of 1 would even be reported as SKB_CONSUMED.

The commit message describes this aliasing, and the patch re-tags every
segment on the overlimit branch just below. The same qdisc_drop() was
already in the block before it was moved. Should this path use
qdisc_drop_reason(skb, sch, to_free, ...) with an explicit reason as
well?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-BA27.v8.r0.20261020063241%40mojatatu.com
