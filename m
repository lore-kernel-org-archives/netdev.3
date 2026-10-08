Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7A0495AF4
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455736; cv=none; b=HQv4JRFjzlb6xDs1mACNIAKcNTEsNaZ9R4e6WZW8Q0sr0Z87pDjruus3B5tyc1P4pU+qXEKkbb8yD8/l7jUWWNu6hNRrMK8Hdnw5kWJ/yUGoAQSI7huEV16EBjYkVDq8/1xkCEzMGguc4MLb93dm+mu7p9r186j7Jkz95LnA2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455736; c=relaxed/simple;
	bh=8Qt4h11lvIE2A7XUDXKgSrzsGycrgEBeGx3uKams5rM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Br+BkjZ7sioA8NRlKDCwb0G9ecu7Nf3uHWjpF2j0wlkGz1tDDT4EUo2e6brSwsbPdOEx4TlG5J8OmkOUY8+xAOfFco0LLGLfWf6hzagHZ5O67Zyu+qJa0V+Xv1sRfOqR4v2Z5Cqy9gWzHqDiri8SPXD+8tYdomGBd6mo3mh7H7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Victor Nogueira
 <victor@mojatatu.com>, moeller0@gmx.de, cake@lists.bufferbloat.net,
 Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v5] net/sched: cap the accounted backlog before
 it can wrap
In-Reply-To: <QDISC-BA27.v5.20261007171509@mojatatu.com>
References: <QDISC-BA27.v5.20261007171509@mojatatu.com>
Date: Thu, 08 Oct 2026 11:49:32 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87a4oottcj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> This is a follow-up to an issue found by Sashiko (nipa) during review of
> commit d9ebd8f9aa8b ("net/sched: fq_codel: clamp default quantum and
> mtu"), part of the quantum/mtu overflow series merged as a687f2ae995f.
> Clamping the per-flow quantum and the CoDel mtu does not bound the
> accounted backlog, so the per-flow backlog wrap the review flagged
> remained.

This, and the rest of the commit message is obtuse LLM vomit, and close
to unreadable. Please rewrite the commit message without the verbosity,
so it's actually something a human reader can comprehend. For the cake
bits in particular:

[..]

> CAKE's SPLIT_GSO path accounts the sum of the segment lengths, which a
> stab recomputes from skb->len and can exceed the pre-split
> qdisc_pkt_len(). The list is summed before any segment is linked and
> rejected as a whole before any flow state is resolved: the flow/host keys
> are computed from the unsegmented packet, but the set-associative
> resolution that commits q->tags[], the flow host indices, the way
> counters and the host bulk-flow counts runs only after the whole
> segment-sum admission test passes. A packet rejected by that test
> therefore leaves no persistent state behind. The whole list is dropped
> via to_free so the tail segment's sock_wfree() never runs under the qdisc
> lock. A fraglist GSO is the exception: skb_segment_list() returns the
> original skb as the list head carrying an extra reference, so segs ==
> skb; dropping the caller's reference and queueing the list once avoids
> self-linking *to_free, which would otherwise free the same skb repeatedly
> in the deferred teardown.

I read this paragraph multiple times, and it's still not clear to me
what it's trying to say.

Also:

>  net/sched/sch_cake.c      | 198 ++++++++++++++++++++++++++++----------

You're changing hundreds of lines of code which is partly a refactor,
partly a fix for the actual overflow issue, and partly unrelated
changes. Please split them into separate patches.

[..]

> +/* Compute the flow/host hash keys from the packet as received. Must run
> + * before skb_gso_segment(), which rewrites an encapsulated GSO packet's
> + * headers to the inner ones and would change the keys. Reads only the skb
> + * and commits no qdisc state, so it may run before admission is known.
> + */

And drop the weird LLM comments, please. If you split the series
properly they are not needed.

[..]
> -		skb_list_walk_safe(segs, segs, nskb) {
> -			skb_mark_not_on_list(segs);
> -			qdisc_skb_cb(segs)->pkt_len = segs->len;
> -			qdisc_skb_cb(segs)->pkt_segs = 1;
> -			cobalt_set_enqueue_time(segs, now);
> -			get_cobalt_cb(segs)->adjusted_len = cake_overhead(q,
> -									  segs);
> -			flow_queue_add(flow, segs);
> +		skb_list_walk_safe(segs, seg, nskb) {

The skb_list_walk_safe(segs, segs) thing is admittedly a bit weird, and
fixing it is fine. But that's the "separate fix" I was referring to
above, so split it out; it's just making the actual fix harder to
comprehend here.

-Toke

pw-bot: cr
