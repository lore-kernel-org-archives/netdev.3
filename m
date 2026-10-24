Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792863041;
	b=5IE1GmVUhicIRObWj5ZFyKtQUJeKE9DmJsX8dvTqCRYko+ZfJH2sj9ALUwHApOqIxR+L
	 0N+Kf3BHqTkWucng/HKcY22g1M0BY2JT1sdS536cD2EXD/gzf5SS/DlFJz3q/3auiFRAr
	 AnN+pb4Cxao+52+MzEB6LoqZb/Hn6g4Kgl60EA8Q+xWEbMmIvqExcMFf5HXb6WGvsbDju
	 xBm2wu+jcQZTlMg1ZRAbBHfK65HxdWFoi9TLk7cx+eyPufQztUAgoFeQe9LQE4RvFp0Mb
	 8vqY9k15SrYWzdLJkIGaSRq1+iVhrwmFE9bwybC4FZugSoEfZK4GiH+33PFtPZ7BKxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792863041;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=S6O11M/nEeawo7L/QfyWeMzLy9qSnn2lQRRLMOD5NKM=;
	b=SdpZtHE7W7IiNmgsugkPI/32OZXFzt3w66Vi/EoldUA5owRu7C9NhZCLPldw2RdL4cSK
	 oe9/HEWkRYM05Xn7AV+R3AUDMFKfe1G2nwsd81GvKJb28aa+se+k+ED6oDPSzzmxtrkHo
	 9qvXTlrb2PNTuAcrCVQVUwQ5G7QJ02X78MMUAJpAoFrgvlxdTbxIMs3JV4oQ5Ks6IukJO
	 twzDLg6LDT5xEMC5fNQyjiqysW3jVH0+l7Onw3vM6VId9kkfgtAinfxr/1Svu9embHsMI
	 NBemvclLavMS3vm4NQZffBbALWbzEaz6I0BtjyTgh5pCh4O38K5tybeJCXCmwG5kE7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtNvs9+o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EBA606A321
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtNvs9+o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC791F01828;
	Sat, 24 Oct 2026 17:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792863040;
	bh=S6O11M/nEeawo7L/QfyWeMzLy9qSnn2lQRRLMOD5NKM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UtNvs9+on1/OYk5Dr2rSeIIKXazxBalWwpb3nScr5BVu5n/auIGurG73CQqFBSXQK
	 aWQzLPTuiRdFGw/SYynmP0TpPRVRrrAWXXRtK7CYiWGBuj+JtC1BMimGOnV9KUJI23
	 KNGgln7znAPdUGE1FZw/vsXtI/SHVy3QnEz8zvF5dRaxnrmpb7HNRm3s9rY33IbCFe
	 9skTp7ln2obbDWtP42iTevXSxG5/5E/G3DEzj1m6zeas/AuZ74Iibif7+/4eOJpEoF
	 k0zO9I/jSxpsFcHfpIcQ2Ni/sQk2DCeLztcZRJRLLsZs9Vd4gQX+Gj4HAYrdkYTx2X
	 VgYzJLzf7dSnw==
Subject: Re: [PATCH net-next v8 3/4] net/sched: cap the accounted backlog
 before it can wrap
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, toke@toke.dk, bjorn@kernel.org, sashiko-bot@kernel.org
Date: Sat, 24 Oct 2026 17:30:39 +0000
Message-ID: <179286303962.3134.14454362298038358802@kernel.org>
In-Reply-To: <QDISC-BA27.v8.r0.20261020063241-3@mojatatu.com>
References: <QDISC-BA27.v8.r0.20261020063241-3@mojatatu.com>
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

- [Medium] At this commit, cake_enqueue() in net/sched/sch_cake.c checks
  only the original skb with qdisc_backlog_overflow(sch, skb) (line…
- [Low] The commit "net/sched: cap the accounted backlog before it can
  wrap" fixes a bug users can see.

--

net/sched: cap the accounted backlog before it can wrap

This adds qdisc_backlog_overflow() to sch_generic.h. It drops packets at
enqueue once the u32 sch->qstats.backlog can no longer hold the incoming
packet's qdisc_pkt_len(). The guard is added to fq_codel, cake, codel,
pie, fq_pie, dualpi2, RED, pfifo, plug and gred, and RED now reserves the
backlog before handing the packet to its child.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
Link: https://lore.kernel.org/netdev/CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CANn89i+GOFH_8g+vSV0jUj0aBqLYVWuFOrHuDggZu9kPC_m6tQ@mail.gmail.com/
Link: https://lore.kernel.org/netdev/87a4oottcj.fsf@toke.dk/
Link: https://lore.kernel.org/netdev/87pkxks68f.fsf@toke.dk/
Link: https://lore.kernel.org/netdev/179231932946.3135.7497478990186385688@kernel.org/

> This is a followup of commit 709f34f7c28d ("net/sched: fq: add overflow
> bounds to quantum and initial quantum") as reported by Sashiko.

[Severity: Low]
Should this have a Fixes: tag? The commit message describes a NULL
dereference of flow->head in fq_codel_drop() and corrupted AQM backlog
state. The trailers include Reported-by: and Closes:, but there is no
Fixes: or Cc: stable.

According to git blame, the stab length computation in
__qdisc_calculate_pkt_len() comes from commit 175f9c1bba9b
("net_sched: Add size table for packets on the scheduler"):

net/sched/sch_api.c:__qdisc_calculate_pkt_len() {
    ...
	pkt_len = skb->len + stab->szopts.overhead;
    ...
}

The later 1 MiB clamp (8f735d64382d) made the per-packet maximum smaller,
but the counter can still wrap.

Stable tooling does not pick up "followup of" wording. Would a Fixes:
tag pointing at the origin of the wrap be more appropriate here?

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index 0d13c4b0bfe3c..91c33295b30b4 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1777,6 +1777,13 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  		return ret;
>  	}
>  
> +	/* Drop before touching the hash or shaper state. */
> +	if (unlikely(qdisc_backlog_overflow(sch, skb))) {
> +		qdisc_qstats_overlimit(sch);
> +		return qdisc_drop_reason(skb, sch, to_free,
> +					 QDISC_DROP_OVERLIMIT);
> +	}
> +

[Severity: Medium]
Does this check cover what the CAKE_FLAG_SPLIT_GSO path adds to the
backlog later in cake_enqueue()?

The guard checks qdisc_pkt_len() of the skb before it is split. With a
size table, __qdisc_calculate_pkt_len() derives that value from skb->len
and clamps it:

net/sched/sch_api.c:__qdisc_calculate_pkt_len() {
    ...
	pkt_len = clamp_t(int, pkt_len, 1, QDISC_PKT_LEN_MAX);
    ...
}

So for a GSO aggregate, qdisc_backlog_overflow() takes the standing
ceiling branch and only checks backlog > QDISC_MAX_BACKLOG.

The split path then adds slen, the sum of the real segment lengths
including the headers copied into each segment. Nothing checks slen
first:

net/sched/sch_cake.c:cake_enqueue() {
    ...
		/* stats */
		qstats_backlog_add(sch, slen);
		q->avg_window_bytes += slen;
		WRITE_ONCE(b->bytes, b->bytes + slen);
		WRITE_ONCE(b->tin_backlog, b->tin_backlog + slen);
		WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + slen);
    ...
}

Suppose the backlog is just under QDISC_MAX_BACKLOG. A split aggregate
can then have slen larger than U32_MAX - backlog, for example a dodgy
tun GSO skb with a small gso_size. Can sch->qstats.backlog,
b->tin_backlog and b->backlogs[idx] wrap here?

The later commit in this series, "net/sched: cake: hash before
segmenting and reject an overlong split", appears to close this gap. It
sums the segments and runs this check before linking any segment:

	if (unlikely((u64)sch->qstats.backlog + slen > QDISC_MAX_BACKLOG)) {

That means only this intermediate commit is affected, for example during
a bisect. The commit message still lists cake as covered by this patch,
though. Could that check be folded into this patch?

>  	/* choose flow to insert into */
>  	b = cake_select_tin(sch, skb);
>  	idx = cake_hash(b, skb, q->config->flow_mode, flow_override,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-BA27.v8.r0.20261020063241%40mojatatu.com
