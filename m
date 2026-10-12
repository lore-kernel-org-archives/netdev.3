Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD744A400
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792955; cv=none; b=hMkWt8C+Mn7lb9/F35/IQJ5USbiW0U+fsbPQuqkMY1u+AuP2B32dtxbYpIR9Cfu8J8ERHH+jQ25Wo5QEi6eyv2KywwIoloW3L6VrtubL1pqfGDtoWrJYVP2DiFYP1LcJ/Ayb+DeJRfsLIVZSdQIitJjaAMp1cn3F/9UETYuJ/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792955; c=relaxed/simple;
	bh=ek9+Z6XXlFj732Y5gKP3la4jx3ftOdIzxtQQ0yZOkIU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BrStC0nBNbHeL8OLd/qk8pE9y/MEzZRBmGuB7LkKEpCUtKnP6uQBEHPcAkW7V9m7k6Y38iEML+UE7Gihbjg3L6hnCEs3Efdyp/4uiJjbRXphwyKuLFFLmkNePMPn3/1POUOues2uWB9jugLXWGxtk1skLCDc6ESdJJvQMJjZGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/GyCllJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/GyCllJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6721A1F0089C;
	Mon, 12 Oct 2026 08:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791792954;
	bh=bYnLKZ4Jyzi+2xKFahIav0LtJz6GbA1FxUVDRYszYes=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D/GyCllJygbrVbOgHPlZugaDlrBl/dL5LxSU5CO2HnlNomfsFZqjY4mNJmEGW2ibX
	 4hCGwzEgFS/TtNtUPexusaSc/7SVgkOnxiOOdnmyBV0Gpw140mdT41t5ihzcxn3QAc
	 DWtDo0o8XlJDftvdq0+FbSzfG1nMZMcfkL+SfVbj6wXiGDE07OyA0CTHZU7AaHJMcx
	 1qwnsWcMjq5YnfGcTuswvxlDeZnOCxoLdYU2v++vAJ159EZaOl4yXJL72fJCpmYtmi
	 gPTBGFvkgizfmvzAkDYYFsim6VGWtO+THx80ksc322hgm6rxUJL8Mw64ATwSsY/nSx
	 kUzwL6ilZ94bA==
Subject: Re: [PATCH net-next 3/4] net/sched/sch_cake: widen buffer_used to u64
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, toke@toke.dk, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, victor@mojatatu.com, cake@lists.bufferbloat.net
Date: Mon, 12 Oct 2026 08:15:52 +0000
Message-ID: <179179295297.434549.16953478712242899575@kernel.org>
In-Reply-To: <QDISC-5RTM.v1.20261007130704-4@mojatatu.com>
References: <QDISC-5RTM.v1.20261007130704-4@mojatatu.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch widens cake_sched_data.buffer_max_used to u64, but
  cake_dump_stats() still exports it with PUT_STAT_U32(MEMORY_USED,…
- [Low] The commit fixes a user-visible bug: with a large memlimit, the
  u32 cake_sched_data.buffer_used wraps, the memory-limit drop loop in…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the memory-
  limit drop loop in cake_enqueue() can spin forever when a populated…

--

net/sched/sch_cake: widen buffer_used to u64

This patch widens cake_sched_data.buffer_used and buffer_max_used from u32
to u64. CAKE's truesize accounting can then no longer wrap past 2^32 and
skip the memory-limit drop loop in cake_enqueue(). The patch also splits
the ACK-filter replacement accounting into a separate add and subtract, so
a wrapped u32 delta does not stay in the wider counter.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818095927.15901-1-jhs@mojatatu.com
Link: https://lore.kernel.org/netdev/20260818095927.15901-1-jhs@mojatatu.com/

> Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260818095927.15901-1-jhs@mojatatu.com
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818095927.15901-1-jhs@mojatatu.com
> Link: https://lore.kernel.org/netdev/20260818095927.15901-1-jhs@mojatatu.com/
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
Should this patch have a Fixes: tag?

The u32 buffer_used, buffer_max_used and buffer_limit fields all seem to
come from the original CAKE commit. The related fix this patch follows,
4c660ee8c809, has a Fixes: tag. Without one, stable backporters may miss
this OOM fix. Perhaps:

Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) qdisc")

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index 2bad0b6eb13fd..4caf9718c9bda 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -234,8 +234,9 @@ struct cake_sched_data {
>  	u16		tin_cnt;
>  
>  	/* resource tracking */
> -	u32		buffer_used;
> -	u32		buffer_max_used;
> +
> +	u64		buffer_max_used;

[Severity: Medium]
With buffer_max_used now u64, can the memory-used stat get truncated?
cake_dump_stats() still exports it as a u32:

net/sched/sch_cake.c:cake_dump_stats() {
    ...
	PUT_STAT_U32(MEMORY_LIMIT, READ_ONCE(q->buffer_limit));
	PUT_STAT_U32(MEMORY_USED, READ_ONCE(q->buffer_max_used));
    ...
}

Documentation/netlink/specs/tc.yaml also declares memory-used in
cake-stats-attrs as u32.

cake_enqueue() records the high-water mark before the drop loop runs:

	if (q->buffer_used > q->buffer_max_used)
		WRITE_ONCE(q->buffer_max_used, q->buffer_used);

	if (q->buffer_used <= q->buffer_limit)
		return NET_XMIT_SUCCESS;
	...
	while (q->buffer_used > q->buffer_limit) {

With memlimit 4294967295, buffer_limit is U32_MAX. Once about 4 GiB of
truesize is queued, the next enqueue pushes buffer_used past 2^32. It
overshoots by up to that skb's truesize, or by the whole segmented GSO
aggregate with split-gso. The commit message says this case can happen:
"the counter passes the limit without wrapping".

Nothing ever lowers buffer_max_used. After that, nla_put_u32() reports
memory-used as peak - 2^32, which is a few KB, for the rest of the qdisc's
life. The final patch in the series does not change this.

Could the value be clamped, e.g. with min_t(u64, ..., U32_MAX)? Or could
it be exported through a new 64-bit attribute, the way CAPACITY_ESTIMATE64
uses PUT_STAT_U64 with TCA_CAKE_STATS_PAD?

> +	u64		buffer_used;
>  	u32		buffer_limit;

[Severity: High]
This issue is pre-existing and was not introduced by this patch. Can the
memory-limit drop loop in cake_enqueue() spin forever when a flow's u32
backlog wraps to 0?

The heap uses per-flow byte counters as keys to pick drop victims, and
those counters are still u32:

struct cake_tin_data {
    ...
	u32	backlogs[CAKE_QUEUES];
    ...
};

A size table can push qdisc_pkt_len() as high as QDISC_PKT_LEN_MAX
(1 << 20). For example, with tsize=0 and overhead >= 1 MiB,
__qdisc_calculate_pkt_len() clamps the length to that value.

If 4096 such non-GSO packets sit in one flow, backlogs[idx] wraps to
exactly 0. Those packets use only a few MB of real truesize. If that
truesize is above a small memlimit, every heap key is now 0.

cake_drop() rebuilds the heap, but cake_heapify() only swaps when it finds
a strictly larger backlog:

		if (lb > mb) {
			m  = l;
			mb = lb;
		}

So the root stays at the initial tin0/flow0 entry, or at a flow that was
already drained. The root flow is empty, so cake_drop() returns without
lowering buffer_used:

	skb = dequeue_head(flow);
	if (unlikely(!skb)) {
		/* heap has gone wrong, rebuild it next time */
		q->overflow_timeout = 0;
		return idx + (tin << 16);
	}

The caller in cake_enqueue() has no other way out of the loop:

	while (q->buffer_used > q->buffer_limit) {
		drop_id = cake_drop(sch, to_free);
		...
	}

This loop runs in the xmit path with the qdisc root lock held and BH
disabled. A CAP_NET_ADMIN user in a user namespace can set it up with a
stopped tun TX ring, as in the commit message's reproducer.

This patch widens buffer_used but leaves backlogs[], tin_backlog and the
heap keys at u32. The final patch in the series does not change this
either.

Should the drop loop also stop when cake_drop() makes no progress?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-5RTM.v1.20261007130704%40mojatatu.com
