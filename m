Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792863040;
	b=f/nErdhikphotoLoLf/n1kukUohUn76gdvcKJRTwnQt8sKS7KkaPvaxaQHwuYVFTfI/E
	 b3K8++zBloMM7fUhXz/s/1tNvf5BSsEFuvEs9LGudgwg0dtcBbqXRaKCh8+rNyiXY1ym3
	 uaUCTN7hopnOKj0wO3cu269reHZ4gNh89iP0fDREu46XNhfqxENXaQUbN2hGnGC7+kSvf
	 kueT30tDP8/g7Im0CTVgpvShp2r0o8XsxWiAOj192QaU2go1CnRM33wz0utuKY+pMGWFQ
	 HBQHZ5a5h2YwlgNMRD1ZY+BC3vooc87MgeISoDrOtgqhmqmHgbX/lefyQPuxv3WQW/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792863040;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vbiGdGifJI25J1ktQA8m+IDo+99FoGcOOd/GahePnVk=;
	b=1SPDPVU+LiUJZ6CvmGY3c522pWZclCtKw3wxwfuYA/ekmrF9B079hS4BczvnXGJQR61X
	 atyoc9Si8nJ3plcLBN01Aj3L0in52M9UFXGIYFxwFdCnMPSz50p/s0Fis/xe60TekW7Er
	 55E0voTCEbY+EImSF2uFThq47diFfoSSx3Xe7qZo3tY3OMtxGvRpMO8Bh6lqrewGYBKtJ
	 jjIVMFWeH2GOv4NkcCxgTT5VhHOU0GjLoeoi0vl7Ahtke/UifRgB3uyXkTmtfEmuu8Q+r
	 SoTocEO1wLjrDY6T1IWIuD1Lx5KCrIHXERkuz3iQ5CEcG++mr7KrteGWkYwH9z/Qqfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ao5w8EAR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4036606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ao5w8EAR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47A61F01825;
	Sat, 24 Oct 2026 17:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792863039;
	bh=vbiGdGifJI25J1ktQA8m+IDo+99FoGcOOd/GahePnVk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ao5w8EARMiK8PjS357+cXcFCPdpXfUABVDKXS4o+9gdFvaKlLJ+rB/EXaN59/PTJj
	 jnz5z5gN1ZuGH3Hp0ry/19n2J1O8obJXoKe+A+s65nqJw1AMgjNJ0fxWCkbAprgnk2
	 pHEU3EZESkhZAF1Pj/Xm6R9zGrboRmf0vjowmac6MVLCawF23RRG4LEFxLIehemCBI
	 tMwtGXz0nf3xt9pjxumZluu21HDzdovDIJgcHMEvPH5890tdGHcWWQFMYpY2/x15YJ
	 PMq+TrByGwEUOW92WNNEfPXEhCwGVDQYH9EEx0U2hv3tERPlpJaFUOSn6vEMY6NdW6
	 ecAcCPz8c0viQ==
Subject: Re: [PATCH net-next v8 1/4] net/sched: cake: return the classifier
 result to the caller
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, toke@toke.dk, bjorn@kernel.org, sashiko-bot@kernel.org
Date: Sat, 24 Oct 2026 17:30:38 +0000
Message-ID: <179286303840.3134.16646155289449371572@kernel.org>
In-Reply-To: <QDISC-BA27.v8.r0.20261020063241-1@mojatatu.com>
References: <QDISC-BA27.v8.r0.20261020063241-1@mojatatu.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Two new comments in net/sched/sch_cake.c say the TC action has
  consumed the packet when the helper returns true.

--

net/sched: cake: return the classifier result to the caller

This commit splits the external classifier out of cake_classify() into a
new helper, cake_tcf_classify(). The helper now returns the filter's
flow and host overrides, and cake_enqueue() does the tin selection and
flow hashing itself. It is described as preparation for later
accounting changes, with no change to classification behaviour.

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index dc93267029e70..6432d10c992e5 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1712,18 +1712,24 @@ static struct cake_tin_data *cake_select_tin(struct Qdisc *sch,
>  	return &qd->tins[tin];
>  }
>  
> -static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
> -			 struct sk_buff *skb, int flow_mode, int *qerr)
> +/* Run the qdisc's optional external classifier. Returns true when a
> + * terminal TC action consumed the packet, with the reason in *qerr;
> + * otherwise *flow and *host hold the filter's overrides (0 if none).
> + */

[Severity: Low]
This isn't a bug, but is "consumed the packet" accurate here?

For TC_ACT_SHOT the action does not take ownership of the skb.
tcf_gact_act() in net/sched/act_gact.c only updates its stats and
returns the verdict:

	if (action == TC_ACT_SHOT)
		tcf_action_inc_drop_qstats(&gact->common);

	tcf_lastuse_update(&gact->tcf_tm);

	return action;

Even so, cake_tcf_classify() returns true for it. The
STOLEN/QUEUED/TRAP cases work the same way, because the qdisc still
drops its own reference.

[ ... ]

> @@ -1758,20 +1762,25 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,

[ ... ]

> -	/* choose flow to insert into */
> -	idx = cake_classify(sch, &b, skb, q->config->flow_mode, &ret);
> -	if (idx == 0) {
> +	/* Classify first: a terminal TC action consumes the packet. */
> +	if (cake_tcf_classify(sch, skb, &flow_override, &host_override, &ret)) {
>  		if (ret & __NET_XMIT_BYPASS)
>  			qdisc_qstats_drop(sch);
>  		__qdisc_drop(skb, to_free);
>  		return ret;
>  	}

[Severity: Low]
This comment has the same wording. The very next lines still have to
free the skb with __qdisc_drop(skb, to_free), so the action has not
consumed it.

A true return really means "do not enqueue, the caller must drop the
skb". Could both comments say that instead?

If a later caller trusted the current wording, it could skip the free
and leak the skb. Both comments are unchanged at the end of the
series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-BA27.v8.r0.20261020063241%40mojatatu.com
