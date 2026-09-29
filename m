Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17249547043
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 00:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640284; cv=none; b=FuYTKzXv0+RXgCLz/Ud49MXbSKcUubC4MFu5+9pfSJ8EQq9xdN5kKgDJXUUkJ4OPemc+67rHTe9tEKq7dxjh8EQaqI6myz/+itjGlF8aKZDOmkdaCXLThrAvoqFpbTtmeiI6pjKg63LD+0AZyA5DtCuHwS66dlft4iSuuqIP8d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640284; c=relaxed/simple;
	bh=YGanT9EiDPeKoeIuLOH6eIgeqw3LDS9D/gwuU2z9aS8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eY5N7u+0FOvf5ulVQakPtuA+F89d9FaSPkDCovYUPISzfiWdE2J4X7wqgFnxJ6T76r5Mm6fwORmKqll1ok4uliCFOAgfS8m2cg3sRE4CAcbLcBLhiCtYSskMx7WEAmtCtZD2kYbDp4uNq54gIpiYHnBUK2qq8YbUX67itFQeCHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJv/CDtJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJv/CDtJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289BB1F000FF;
	Tue, 29 Sep 2026 00:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790640282;
	bh=VP7wqsEoOoHlIDQnfxWv1Men8qQuWnZKQ8KSvfUHJqI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VJv/CDtJ4oPRWrEcD18ZIae1zNFvmrxOdau5kjcgDwDPPHpZyYQgYr39YsG3YaaRJ
	 5dHl/XaCot6fRb0am56qpGebYANZJ0Quzbb0v+DBckmPUkxmFpc6VUb0q1WRndI7je
	 s/ckaOuZ0UeFIksuMHr2KcZg+dElmO5+0OnpcjvjG2d4YxTsOWbelLQq6mVHeZlP3k
	 5Q3mR4ujPoYwUiT3Q81jUdrGwgkYf0XbDozQLpNWqWGxkyBtvHbd+AkEYzk9CNBlUt
	 mTIwQrTeiPNJg8PwjGkAB25edzKPPyscfn7UxN50GppInc30pEYbpOgTSlcXLjQG5c
	 Hz9zHAwEC4iWg==
Subject: Re: [PATCH net 1/2] net/sched: fq_codel: match the no-drop threshold
 to the packet size
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, hybris@mojatatu.ai, sashiko-bot@kernel.org
Date: Tue, 29 Sep 2026 00:04:41 +0000
Message-ID: <179064028170.3145.2835498788970195236@kernel.org>
In-Reply-To: <QDISC-34MS.v1.20260925165535@mojatatu.com>
References: <QDISC-34MS.v1.20260925165535@mojatatu.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] sch_codel has the same 256-byte floor on the CoDel no-drop
  threshold.

--

net/sched: fq_codel: match the no-drop threshold to the packet size

This patch splits the clamp in fq_codel_init(). q->quantum keeps the
[256, FQ_CODEL_QUANTUM_MAX] range. q->cparams.mtu now follows psched_mtu()
with only the upper bound, so CoDel's no-drop threshold matches the real
packet size on links where the MTU plus hard_header_len is below 256.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260819143136.57350-1-jhs@mojatatu.com

> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> index 969b2510b0b86..e6c87a32950f9 100644
> --- a/net/sched/sch_fq_codel.c
> +++ b/net/sched/sch_fq_codel.c
> @@ -517,8 +517,8 @@ static int fq_codel_init(struct Qdisc *sch, struct nlattr *opt,
>  	q->flows_cnt = 1024;
>  	q->memory_limit = 32 << 20; /* 32 MBytes */
>  	q->drop_batch_size = 64;
> -	mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 256, FQ_CODEL_QUANTUM_MAX);
> -	q->quantum = mtu;
> +	mtu = min_t(u32, psched_mtu(qdisc_dev(sch)), FQ_CODEL_QUANTUM_MAX);
> +	q->quantum = clamp_t(u32, mtu, 256, FQ_CODEL_QUANTUM_MAX);

[Severity: Medium]
Should the plain codel qdisc get the same change? At this commit,
codel_init() in net/sched/sch_codel.c still puts the 256 floor on the
CoDel no-drop threshold:

net/sched/sch_codel.c:codel_init() {
    ...
	q->params.mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 256, 1 << 20);
    ...
}

Both qdiscs use the same exemption in codel_should_drop()
(include/net/codel_impl.h):

    *backlog <= params->mtu

So if a codel qdisc is attached to a device where psched_mtu() is below
256 (e.g. a CAN interface), the path codel_init() ->
__codel_qdisc_dequeue() -> codel_should_drop() still exempts more than one
packet of backlog. That is the same delay in drop or mark eligibility that
this patch describes for fq_codel.

It looks like the next patch in this series, "net/sched: sch_codel: match
the no-drop threshold to the packet size", fixes this by changing the line
to:

	q->params.mtu = min_t(u32, psched_mtu(qdisc_dev(sch)), 1 << 20);

That means the gap is only present between the two commits.

>  	INIT_LIST_HEAD(&q->new_flows);
>  	INIT_LIST_HEAD(&q->old_flows);
>  	codel_params_init(&q->cparams);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-34MS.v1.20260925165535%40mojatatu.com
