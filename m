Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548528;
	b=MPs6Z2iRiPiK1/3hpeAv/D1BIHFUzQg+3khq5Hv2mNau7ViLTmqvq6Xz++pNY6dATDmY
	 twthmcsw5BnGYXlL9rEZ/hsNK9JI4P0/+HrcYpJOncX04LFdBt4uqSGF2GdqbFGTRhTGj
	 Ucki3kwlQdjpYoYGz7pFQYmFDAGPlJOFERe85PtUT6cKvuHjKR2Nglq0+9/NBDB+xQwp1
	 MJJYDTjVbUvqby9zyIm2OWdopTGH84fRIrUC0Z1lOsKoP+oOYZjWPYHZhdfak5Ea7S802
	 pFec48zQPnYGU1bhhr68gVG4OxidVaCbMbB/sXPlLSsLa3PE9HlIrBtENhnci6HwJAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548528;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wYQ86IrqCEYFidi3JltAUJ5H9jZ/KCecM76Tgh7IV3k=;
	b=e1uOiIpujknyxLe9S/PbeYHJjsvDiW0vIYMtVtCJkrO9HpTKOKf7DJ47Qtq59d3WQCm4
	 SORUV6thhKhUjJXMRvG8TtwanIumZM2TLfOgf1MHQ/q0JIdlupT//tspHGgrM4G44YlhS
	 0N2zxfr3wu1sRvoq7F1X5xdr/cOv9M2hujzoX5kCkrnJLqqmINiVwWXUc3818QGRgL3S9
	 FBhjByZ3WSKWbXgPDz9x3BDQ81bh6DUo0jErOWAHGGi4RVi4PVxM7hKlc4E+SR1pAcB2u
	 YtlsuMAnY3hk6IxqBGtHJlFMbKbIXkvh1p5cxQ47p3g1vYZU2Rm/95mQoi70wMLqHig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWRCKn6u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F4606A32A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWRCKn6u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B961F000C5;
	Fri, 13 Nov 2026 05:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794548528;
	bh=wYQ86IrqCEYFidi3JltAUJ5H9jZ/KCecM76Tgh7IV3k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PWRCKn6uYxLcoP9lM0eatNA9at2/k23CL24922wFKtiMy3ytMNsck8YxEhO+6kT0M
	 f0CW5m0nG5chHgG3dUuTfIFk2WbKgqbIkqR0XsHCq5tGWC5j9dEVR/z99JT8qZobCp
	 qgML6VLn+oflxRQN51QwgWeSE3sNunjZ+YyagrGASTSLRGhKisHNi2QEP9cymjCYII
	 lvM2S6HY6HM5lnDyrk365vfSwKKDj8mnh8OyS5WjnqNMDFOi736GX9mZx4vwOzE71J
	 2IMQd/wVW7o/rtZQfVrh5Jelet8ABcPRvWnXYy+sVhDi5g1D2/1dLEyr2WwaiQGoBX
	 EYSdXEH5e6AdA==
Subject: Re: [PATCH net-next v9 4/4] net/sched: cake: hash before segmenting
 and reject an overlong split
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, toke@toke.dk, bjorn@kernel.org, sashiko-bot@kernel.org
Date: Fri, 13 Nov 2026 05:42:07 +0000
Message-ID: <179454852744.2199510.15568282439128864247@kernel.org>
In-Reply-To: <QDISC-BA27.v9.r0.20261108195325-4@mojatatu.com>
References: <QDISC-BA27.v9.r0.20261108195325-4@mojatatu.com>
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

- [Low] Parts of the commit message do not match the code.
- [Low] The patch is presented as a fix ("The Fix:") but has no Fixes:
  tag.
- [Low] The new split-GSO admission check in cake_enqueue() treats
  QDISC_MAX_BACKLOG as a limit on the backlog after the add:…

Pre-existing issues:
- [Low] This problem was not introduced by this patch.

--

net/sched: cake: hash before segmenting and reject an overlong split

This patch splits cake_hash() into two parts. cake_hash_keys() has no side
effects. cake_hash_resolve() commits the set-associative state and now runs
only after the packet is admitted. The split-GSO segmentation moves ahead of
flow resolution, and the whole segment list is rejected when the segment sum
would pass QDISC_MAX_BACKLOG. cake_enqueue() also reads
q->config->flow_mode once with READ_ONCE().

Link: https://lore.kernel.org/netdev/179231933068.3135.80340792633077986@kernel.org/
Link: https://lore.kernel.org/netdev/179269577270.3135.16072065138845192450@kernel.org/

> Conditions to recreate the bug:
>   ip tuntap add tun0 mode tun
>   ip link set tun0 txqueuelen 32 up
>   ip addr add 10.99.0.1/24 dev tun0
>   # hold the tun fd open without reading so the backlog persists; a stab
>   # overhead of 1048468 accounts each 92-byte packet at 1048560 bytes, so
>   # 4095 queued packets leave 65519 bytes below QDISC_MAX_BACKLOG.  A
>   # 65000-byte UDP_SEGMENT payload with a 1400-byte segment size then has
>   # a segment sum past the remaining headroom, and cake rejects the whole
>   # split.  Setup needs CAP_NET_ADMIN; the payload itself does not.
>   tc qdisc add dev tun0 root handle 1: stab overhead 1048468 \
>       cake split-gso memlimit 512Mb

[Severity: Low]
Does this recipe show a failure on the tree just before this patch?

With a stab overhead of 1048468, each 92-byte packet is accounted at
1048560 bytes. After 4095 packets the backlog is 4293853200.

For the 65000-byte UDP_SEGMENT skb, __qdisc_calculate_pkt_len() clamps
qdisc_pkt_len() to QDISC_PKT_LEN_MAX. qdisc_backlog_overflow() then sees
4293853200 <= QDISC_MAX_BACKLOG and admits the skb.

The 47 segments add up to 65000 + 47 * 28 = 66316 bytes. The old split
path would take the backlog to 4293919516, which is still about 1 MiB
below U32_MAX. After that, qdisc_backlog_overflow() refuses every later
packet.

So on an unfixed kernel nothing wraps, and the recipe only reaches the new
rejection. The message also doesn't say what goes wrong without the new
check. Presumably it is the u32 sch->qstats.backlog, b->tin_backlog and
b->backlogs[idx] wrapping. That needs a segment sum larger than the 1 MiB
headroom.

The subject and the opening paragraph also present "hash before
segmenting" as the fix. But the removed lines in cake_enqueue() already
call cake_hash() before skb_gso_segment(). Isn't the actual change that
the set-associative resolution and the shaper-state refresh now run only
after admission?

Finally, "tagging only the head left the rest with GSO scratch" seems to
describe an earlier revision of this patch. The code being replaced had
no rejection path and did not tag any segment.

> Link: https://lore.kernel.org/netdev/179269577270.3135.16072065138845192450@kernel.org/
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
The message calls this "The Fix:", but there is no Fixes: tag. This patch
fixes three things:

- state committed before the drop when skb_gso_segment() fails
- the wrong drop reason for that drop
- no bound on the split segment sum

All of these appear to come from the original split-GSO code. Would
something like this be appropriate?

Fixes: 0c850344d388 ("sch_cake: Conditionally split GSO segments")

The hash-before-split ordering comes from 046f6fd5daef ("sched: Add Common
Applications Kept Enhanced (cake) qdisc").

Stable backporters would also need to know that this patch depends on
QDISC_MAX_BACKLOG and qdisc_backlog_overflow() from the previous patch in
the series.

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index 3fd13bf6f3cec..74e2b09971eea 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c

[ ... ]

> @@ -1788,12 +1815,50 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,

[ ... ]

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
> +			return qdisc_drop_reason(skb, sch, to_free,
> +						 QDISC_DROP_GENERIC);
> +
> +		/* we never use the original skb after splitting */
> +		consume_skb(skb);
> +		skb = NULL;
> +
> +		/* The split path accounts the segment sum, not the
> +		 * stab-adjusted qdisc_pkt_len(), so check it here.
> +		 */
> +		skb_list_walk_safe(segs, seg, nskb)
> +			slen += seg->len;
> +
> +		if (unlikely((u64)sch->qstats.backlog + slen > QDISC_MAX_BACKLOG)) {

[Severity: Low]
Is QDISC_MAX_BACKLOG the right bound for this check? The header defines it
as a limit on the backlog before the add:

include/net/sch_generic.h:
/* Largest backlog that still has room for one more 1 MiB packet. */
#define QDISC_MAX_BACKLOG	(U32_MAX - QDISC_PKT_LEN_MAX)

qdisc_backlog_overflow() rejects only when the add would actually wrap:

	if (likely(len <= QDISC_PKT_LEN_MAX))
		return backlog > QDISC_MAX_BACKLOG;
	return len > U32_MAX - backlog;

Here the backlog after the add is compared against that constant. Take a
split GSO skb that has just passed qdisc_backlog_overflow() with a stab
clamping qdisc_pkt_len() to 1 MiB. If the backlog is in
(QDISC_MAX_BACKLOG - slen, QDISC_MAX_BACKLOG], the skb is dropped as
QDISC_DROP_OVERLIMIT even though backlog + slen would not wrap. Small
packets are still admitted in that window.

The recipe in the commit message is such a case: 4293919516 is about 1 MiB
below U32_MAX.

Would something like slen > U32_MAX - sch->qstats.backlog match the
helper's semantics?

> +			qdisc_qstats_overlimit(sch);

[ ... ]

> @@ -1958,8 +2016,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  		WRITE_ONCE(b->sparse_flow_count, b->sparse_flow_count - 1);
>  		WRITE_ONCE(b->bulk_flow_count, b->bulk_flow_count + 1);
>  
> -		cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
> -		cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
> +		cake_inc_srchost_bulk_flow_count(b, flow, flow_mode);
> +		cake_inc_dsthost_bulk_flow_count(b, flow, flow_mode);

[Severity: Low]
This isn't a bug introduced by this patch, but cake_dequeue() still reads
q->config->flow_mode with a separate plain load at each call:

net/sched/sch_cake.c:cake_dequeue() {
    ...
				cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
				cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
    ...
			   flow->deficit + cake_get_flow_quantum(b, flow, q->config->flow_mode));
    ...
					cake_dec_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
					cake_dec_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
    ...
}

With cake_mq, cake_mq_change()->cake_config_change() does
WRITE_ONCE(q->flow_mode, flow_mode) on the shared config before any child
sch_tree_lock() is taken.

Can a reconfiguration during dequeue make the src and dst bulk-count
updates for the same flow use different modes? The plain reads racing
with that WRITE_ONCE() also look like something KCSAN would report.
Indexing stays in bounds, because the inc helpers cap at CAKE_QUEUES and
the dec helpers check for zero.

Should cake_dequeue() use the same READ_ONCE() snapshot that this patch
adds to cake_enqueue()?

>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-BA27.v9.r0.20261108195325%40mojatatu.com
