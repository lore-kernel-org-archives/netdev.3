Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C93D1CA8
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792319332; cv=none; b=kF0lincA9CmjxED6KFD4b1OdJL0XbYxlg4iS2kS9DEMmbdUX7BqMfuR1IjCVMf3+GDTm4bB3UUq9vdhG3WDw4VWPebG4YwklERddwedtTkl0CLXPwPYmVpzJlurMBgmmsIZc2WDV0ua3PqA3QFCBVg1lL+NsngGkhnVtTHXFYwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792319332; c=relaxed/simple;
	bh=yUsmO2KM8N56nILLzzrWIA6Po0g5HQQU5b8SRSyhX+w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oGvz9G7HD5RubuDLXllpiRdf15puzBnZ6CRf/mSC4S3Q7td0iYj8xUqBUHKYQeqcIMHkZKc2N8D1qM/A5VWlhVkN59tHKR8CaYtmXRAmHcrPm11T4kz921W9y4gFWCrp2Kv0RuSR0XRwLy0os55VjD7ft1xVGpGzchbPAd+8o2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRDdtOoK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRDdtOoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03EE1F000C5;
	Sun, 18 Oct 2026 10:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792319330;
	bh=r6e13Bm/017uRSWmJEW19cOj1UubRGRwJs85lOXpHXQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JRDdtOoK/nHYMQ/ZoEdlngsd32eVCtPBliZsqFrp/VpSvPQuz+i8e8+k8qE5hhk0m
	 AADPgv9ogGwgpu01yTTQCwYyUvRPDh8kVpvicrpb9N9RSssjbA5klj8YeKZpPFrvht
	 fO9oyldCgjnbwrCv6guw/K6BR38N2YzVzfJ1tbxJHSPh/GKUWnmrQ+fQ73PjtamYw4
	 JS7JXw0wtYYwMIdsu5a337+sVLaMazY0U27Q51P7LPDhFW6JdUOd4W7G+WZNCdgIQK
	 82cqalCu0+CCYkkMzmjbX5yFWzTy2N1bR8GAeoDTcoU2c/yCgUBCwa/g9wM2Ae8B/l
	 tXY5GOSvFsFew==
Subject: Re: [PATCH net-next v6 3/4] net/sched: cap the accounted backlog
 before it can wrap
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, toke@toke.dk, sashiko-bot@kernel.org
Date: Sun, 18 Oct 2026 10:28:49 +0000
Message-ID: <179231932946.3135.7497478990186385688@kernel.org>
In-Reply-To: <QDISC-BA27.v6.r0.20261014054826-3@mojatatu.com>
References: <QDISC-BA27.v6.r0.20261014054826-3@mojatatu.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] qdisc_pkt_len_segs_init() in net/core/dev.c now clamps
  qdisc_skb_cb(skb)->pkt_len to QDISC_PKT_LEN_MAX on every path,…
- [Low] In net/sched/sch_cake.c, cake_enqueue() checks
  qdisc_backlog_at_max() only once, before the CAKE_FLAG_SPLIT_GSO…
- [Low] The commit fixes a crash that unprivileged users in a namespace
  can trigger (wrapped backlogs, wrong AQM drops, and a NULL flow->head…

--

net/sched: cap the accounted backlog before it can wrap

This patch makes several qdiscs drop at enqueue once the 32-bit
sch->qstats.backlog is within QDISC_PKT_LEN_MAX of wrapping. The check is
done by a new helper, qdisc_backlog_at_max(). The patch also clamps
qdisc_skb_cb(skb)->pkt_len to QDISC_PKT_LEN_MAX in
qdisc_pkt_len_segs_init(), and in RED it accounts the backlog before
handing the packet to the child.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
Link: https://lore.kernel.org/netdev/CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CANn89i+GOFH_8g+vSV0jUj0aBqLYVWuFOrHuDggZu9kPC_m6tQ@mail.gmail.com/
Link: https://lore.kernel.org/netdev/87a4oottcj.fsf@toke.dk/
Link: https://lore.kernel.org/netdev/87pkxks68f.fsf@toke.dk/

> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/

[Severity: Low]
Should this have a Fixes: tag?

The commit message describes a bug that an unprivileged user in a
namespace can reach: wrapped backlogs, wrong AQM drop decisions, and a
NULL flow->head dereference in fq_codel_drop(). Without a Fixes: tag,
stable maintainers have no automatic way to route the patch.

The fix also relies on the existing QDISC_PKT_LEN_MAX clamp in
__qdisc_calculate_pkt_len() for stab-adjusted lengths. Nothing in the
commit declares that dependency for backporters. Could it be noted?

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 8eb9bf1ff9eb6..9d15d0028a9e6 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4285,7 +4285,12 @@ static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
>  	unsigned int hdr_len, tlen;
>  	u16 gso_segs;
>  
> -	qdisc_skb_cb(skb)->pkt_len = skb->len;
> +	/* Clamp from the start: the non-GSO and missing-transport-header
> +	 * returns below leave pkt_len at this value, and a stabless skb
> +	 * larger than QDISC_PKT_LEN_MAX would otherwise bypass the guard.
> +	 */
> +	qdisc_skb_cb(skb)->pkt_len =
> +		min_t(unsigned int, skb->len, QDISC_PKT_LEN_MAX);
>  	if (!shinfo->gso_size) {
>  		qdisc_skb_cb(skb)->pkt_segs = 1;
>  		return SKB_NOT_DROPPED_YET;
> @@ -4338,6 +4343,14 @@ static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
>  		qdisc_skb_cb(skb)->pkt_segs = gso_segs;
>  	}
>  	qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
> +	/* (gso_segs - 1) * hdr_len can exceed QDISC_PKT_LEN_MAX for a dodgy
> +	 * GSO skb, so clamp the accounted length as a size table does in
> +	 * __qdisc_calculate_pkt_len(), keeping the backlog within one
> +	 * stab-clamped packet of U32_MAX.
> +	 */
> +	qdisc_skb_cb(skb)->pkt_len = min_t(unsigned int,
> +					   qdisc_skb_cb(skb)->pkt_len,
> +					   QDISC_PKT_LEN_MAX);
>  	return SKB_NOT_DROPPED_YET;
>  }

[Severity: Medium]
Does clamping here change pkt_len for consumers other than the qdisc
backlog?

Both clamps now apply on every path through qdisc_pkt_len_segs_init(),
including when no size table is attached. Before this patch a stabless
skb kept the full estimate:

    skb->len + (gso_segs - 1) * hdr_len

qdisc_skb_cb(skb)->pkt_len is read in several other places:

  - BPF exposes it as the uAPI field __sk_buff.wire_len, through
    bpf_convert_ctx_access() in net/core/filter.c
  - qdisc byte stats count it
  - tcf_police_act() in net/sched/act_police.c, and the HTB/TBF
    shapers, charge tokens by qdisc_pkt_len()

A SKB_GSO_DODGY skb from tun or vhost can pair a tiny gso_size with long
but valid IPv6 extension-header chains. ipv6_gso_pull_exthdrs()
replicates those headers per segment. The real post-segmentation size of
such an skb can be far above 1 MiB, but it would now be reported to BPF
as 1 MiB and charged as 1 MiB.

Only the backlog accounting needed the bound. Would it work better to
reject such skbs here, or to clamp only where the backlog is accounted,
so the value stays the same for the other consumers?

[ ... ]

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index 0d13c4b0bfe3c..adfe11737c66d 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1777,6 +1777,16 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  		return ret;
>  	}
>  
> +	/* Drop before hash/shaper state so a rejected packet disturbs
> +	 * neither; the QDISC_MAX_BACKLOG margin leaves room for one more
> +	 * stab-clamped packet.
> +	 */
> +	if (unlikely(qdisc_backlog_at_max(sch))) {
> +		qdisc_qstats_overlimit(sch);
> +		return qdisc_drop_reason(skb, sch, to_free,
> +					 QDISC_DROP_OVERLIMIT);
> +	}
> +

[Severity: Low]
At this commit, does this single check cover the CAKE_FLAG_SPLIT_GSO path
in cake_enqueue()? Split GSO is on by default.

That path sums seg->len over every segment and adds the total to three
u32 counters, with no bound on the sum:

net/sched/sch_cake.c:cake_enqueue() {
    ...
	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
		...
		skb_list_walk_safe(segs, seg, nskb) {
			...
			slen += seg->len;
			...
		}

		/* stats */
		qstats_backlog_add(sch, slen);
		...
		WRITE_ONCE(b->tin_backlog, b->tin_backlog + slen);
		WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + slen);
    ...
}

slen is the raw segment sum, not the clamped qdisc_pkt_len(). It can
exceed the 1 MiB headroom that qdisc_backlog_at_max() reserves, so
sch->qstats.backlog, b->tin_backlog and b->backlogs[idx] can still wrap.

The next patch in the series, "net/sched: cake: hash before segmenting
and reject an overlong split", fixes this. It sums the segments first and
rejects the whole list when (u64)sch->qstats.backlog + slen exceeds
QDISC_MAX_BACKLOG, so the series as a whole is not affected. The gap only
matters if this commit is bisected to, or backported without that
companion patch.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-BA27.v6.r0.20261014054826%40mojatatu.com
