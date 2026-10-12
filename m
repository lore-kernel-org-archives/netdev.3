Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29433EAC8D
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820284; cv=none; b=ELDZ6y1+yMHTKkgVCC8kiaSkK8kbyVU8hl2H+joZT7/ZEnqoiZ991RhVIW52BvLSohPIIZFTPkCdScUJflB/KhBOnhL0F9sUxsVs52Nt5YUED9IRF2lDXVc7Opb2V18mreTGT3LAiF4TjxRp3aymHPoEE4HpDCpc0HDlgXZ1GUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820284; c=relaxed/simple;
	bh=AICv0O8xXVY+JWUlTxyAs4b9ZGbDg9RunStv7r4FYbU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F8CGoW48NXzhWRMkAXJw0pIs2i4imX0+6bTxsQCNLPRdadVHaiz0Ux/jc4qwd0oWGSvvEiX9Jsfd5iYkeUTV1xXEtFffIgno8gdZY4NGOhn7PBZ4lZooz7hLPEWjbj1uDJ6lDYferjo6Dix/hIbYg33ilqi5A0+8Pb/vpwYhGQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gxfyb67i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gxfyb67i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0AA1F0089B;
	Mon, 12 Oct 2026 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791820282;
	bh=kku2nVARqVLF7w0zRne+MFDh7+RroHoy7RapMOu354o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Gxfyb67i5NoOdhWlNFNAQh77Wq3EtFz/92o3C2w/L3vJc8sbL1UqBaT8GHz22LYIj
	 hevoFxMIaJgbkIfspQvcggbGrE7cySddYtRWOF3hXkZ0is1fD36E7sdIMFmnTkZDRu
	 qOoP5N7QCqpOEzziSuXz6PDiwK/MdaVlbX7YmeCvGgJc7YY5E64T6pu8DsSBkyM2BB
	 L08yLcG89XHprwSRu8RnUUxoLvSI4iAZZIzQIVlN63m3i4o/FGnxxGsMMfZ8RU+kdc
	 YHeV8sWxDYp+eqSPlrL+CulWga3mlVlDZnvps6gGyjfrp390vcvo+7w95Pl8/fVptf
	 OxEnkcp03zBCA==
Subject: Re: [PATCH net-next 1/2] net/sched: skip empty rounds in the
 deficit-refill dequeue loops
From: netdev-bot+sashiko@kernel.org
To: victor@mojatatu.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 horms@kernel.org, sashiko-bot@kernel.org, shuah@kernel.org
Date: Mon, 12 Oct 2026 15:51:21 +0000
Message-ID: <179182028153.434549.4854377793269282267@kernel.org>
In-Reply-To: <QDISC-TIAE.v1.20261008110502@mojatatu.com>
References: <QDISC-TIAE.v1.20261008110502@mojatatu.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 4 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In fq_dequeue() and __fq_codel_dequeue(), the bulk skip runs at
  most once per dequeue call.
- [High] The commit message lists the qdiscs that share the 'refill-and-
  rotate shape' (fq_codel, fq_pie, fq, sfq) and bounds them, but…
- [High] In __fq_codel_dequeue() and fq_pie_qdisc_dequeue(), and per band
  in fq_dequeue(), the bulk refill never fires when every flow waiting…
- [High] In fq_dequeue(), the round sentinel `first` assumes that a flow
  refilled through `fq_flow_add_tail(q, f, OLD_FLOW)` stays on the…
- [Medium] In fq_dequeue(), __fq_codel_dequeue() and
  fq_pie_qdisc_dequeue(), the scan that sizes `rounds` skips empty flows…
- [Medium] In fq_dequeue(), __fq_codel_dequeue() and
  fq_pie_qdisc_dequeue(), the sentinel is set with `if (!first) first =…
- [Low] The patch fixes a BH-off stall under the qdisc lock that, per its
  own reproducer, can be triggered from an unprivileged user namespace…
- [Low] drr_dequeue() and ets_qdisc_dequeue() now read each class's
  quantum twice.

--

net/sched: skip empty rounds in the deficit-refill dequeue loops

This patch bounds the deficit-refill dequeue loops in drr, ets, fq,
fq_codel, fq_pie and sfq. After one full round in which no class or flow
becomes eligible, it computes the minimum number of rounds needed and
applies that many quantum refills to every class or flow at once.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260819143213.57401-1-jhs@mojatatu.com

> The same refill-and-rotate shape is shared by fq_codel, fq_pie, fq and
> sfq, so bound those at the same time.

[Severity: High]
Should sch_cake be on this list too? cake_dequeue() has the same
refill-and-rotate loop, and this patch leaves it unchanged:

net/sched/sch_cake.c:cake_dequeue() {
    ...
		WRITE_ONCE(flow->deficit,
			   flow->deficit + cake_get_flow_quantum(b, flow, q->config->flow_mode));
		list_move_tail(&flow->flowchain, &b->old_flows);

		goto retry;
    ...
}

The deficit is charged with the length from cake_overhead(), which starts
from qdisc_pkt_len(). The same crafted stab can therefore push it to
QDISC_PKT_LEN_MAX.

The quantum added per refill also shrinks as host_load grows:

net/sched/sch_cake.c:cake_get_flow_quantum() {
    ...
	return (q->flow_quantum * quantum_div[host_load] +
		get_random_u16()) >> 16;
}

flow_quantum is clamped to 300..1514 and quantum_div[i] is 65535 / i. In
the default triple-isolate mode, host_load can reach CAKE_QUEUES (1024), so
the average refill can be well under one byte.

Could a 1 MiB charge then take millions of refills per flow? That would
apply to up to 1024 flows per tin, all under the qdisc lock with BH off.

> It is not a regression and is not marked for stable: the walk has been
> linear in the number of classes times the per-class refill count (up to
> 4096 with a crafted size table) since these schedulers were introduced,
> so there is no regression commit to blame and no narrow fix to
> backport.

[Severity: Low]
Does this match how the predecessor was tagged? Commit 8f735d64382d
("net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup") covers the
same bug class with the same unshare -Urn reproduction path, and it
carries:

    Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Without a Fixes: tag here, stable kernels get the 1 MiB cap but keep the
N * 4096 multi-class stall. The reproducer above shows that stall can be
triggered with namespace-local CAP_NET_ADMIN.

> diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
> index 8621d057edd9f..27d216b777f24 100644
> --- a/net/sched/sch_drr.c
> +++ b/net/sched/sch_drr.c

[ ... ]

> @@ -402,6 +403,45 @@ static struct sk_buff *drr_dequeue(struct Qdisc *sch)
>  			return skb;
>  		}
>  
> +		/* The head cannot dequeue. Once a full round passes with
> +		 * no class becoming eligible, skip the remaining empty
> +		 * rounds in a single bulk refill.
> +		 */
> +		if (!scanned && cl == first) {
> +			unsigned int rounds = UINT_MAX;
> +			struct drr_class *iter;
> +			bool skip = true;
> +
> +			scanned = true;
> +			list_for_each_entry(iter, &q->active, alist) {

[ ... ]

> +				rounds = min(rounds,
> +					     DIV_ROUND_UP(pkt_len - iter->deficit,
> +							  READ_ONCE(iter->quantum)));
> +			}
> +			if (skip && rounds != UINT_MAX) {
> +				list_for_each_entry(iter, &q->active, alist)
> +					WRITE_ONCE(iter->deficit,
> +						   iter->deficit + rounds *
> +						   READ_ONCE(iter->quantum));

[Severity: Low]
Can a concurrent quantum change over-credit a class here? quantum is read
once to size rounds and again to apply it.

drr_change_class() updates an existing class while holding only RTNL, not
the root qdisc lock:

	if (tb[TCA_DRR_QUANTUM])
		WRITE_ONCE(cl->quantum, quantum);

Suppose the quantum goes from 256 to 1 << 20 between the two reads while
rounds is about 4094. The class then gets roughly 4 GiB of deficit at
once, while the one-quantum walk could give at most pkt_len plus the new
quantum. That class could then dequeue a long run of packets while the
other active classes starve.

ets_qdisc_dequeue() has the same double read, with ets_class_change() as
the writer.

> +				continue;
> +			}
> +		}

[ ... ]

> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index a282812c192ee..125c6bf836b9f 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c

[ ... ]

> @@ -782,6 +792,45 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
>  	f = head->first;
>  	retry = 0;
>  	if (f->credit <= 0) {
> +		/* The head cannot dequeue. Once a full round passes with
> +		 * no flow becoming eligible, skip the remaining empty
> +		 * rounds in a single bulk refill.
> +		 */
> +		if (!scanned && f == first) {
> +			unsigned int rounds = UINT_MAX;
> +			struct fq_flow *iter;
> +
> +			scanned = true;
> +			/* A completed round leaves new_flows empty, so
> +			 * only old_flows still holds flows awaiting a
> +			 * refill.
> +			 */
> +			for (iter = pband->old_flows.first; iter;
> +			     iter = iter->next) {
> +				/* A flow that cannot dequeue next round
> +				 * (empty queue) is removed instead, so it
> +				 * neither arms nor sizes the skip.
> +				 */
> +				if (!fq_peek(iter))
> +					continue;
> +				if (iter->credit > 0) {
> +					rounds = 0;
> +					break;
> +				}
> +				rounds = min(rounds,
> +					     DIV_ROUND_UP(1 - iter->credit,
> +							  q->quantum));
> +			}
> +			if (rounds && rounds != UINT_MAX) {
> +				for (iter = pband->old_flows.first; iter;
> +				     iter = iter->next)
> +					iter->credit += rounds * q->quantum;

[Severity: Medium]
Does this refill over-credit empty flows? The scan skips flows with no
packet, but the refill loop adds rounds * q->quantum to every flow on
old_flows, including the empty ones.

In the one-quantum walk, an empty flow with credit <= 0 is refilled only
until it turns positive. It is then detached with credit in (0, quantum].
An empty flow that already had credit > 0 is never refilled at all.

Here, an empty flow that needed fewer rounds than rounds (or none) can be
left with up to about (rounds - r) * quantum of extra credit, where r is
the number of rounds that flow needed itself.

fq_enqueue() keeps that credit across detach and re-attach:

	if (fq_flow_is_detached(f)) {
		fq_flow_add_tail(q, f, NEW_FLOW);
		if (time_after(jiffies, f->age + q->flow_refill_delay))
			f->credit = max_t(u32, f->credit, q->quantum);
	}

so the flow can burst above its fair share in its next active period.

__fq_codel_dequeue() and fq_pie_qdisc_dequeue() have the same mismatch. In
those, the deficit is reset only when the flow was unlinked:

	if (list_empty(&flow->flowchain)) {
		list_add_tail(&flow->flowchain, &q->new_flows);
		q->new_flow_count++;
		WRITE_ONCE(flow->deficit, q->quantum);
	}

Suppose the flow that dequeues comes before the empty flow in list order.
The empty flow is then still linked when its next packet arrives. It keeps
the inflated deficit and is not promoted to new_flows.

This seems to contradict the comment that empty flows "neither arm nor
size the skip". It also seems to contradict the commit message's claim
that "each class ends with the same deficit the one-quantum loop converged
to". Is that intended?

> +				goto begin;
> +			}
> +		}
> +
> +		if (!first)
> +			first = f;
>  		f->credit += q->quantum;
>  		head->first = f->next;
>  		fq_flow_add_tail(q, f, OLD_FLOW);

[Severity: High]
Can the sentinel leave this band's list here? fq_flow_add_tail() picks
the destination list from flow->band:

	struct fq_perband_flows *pband = &q->band_flows[flow->band];

fq_enqueue() sets the band on every enqueue, even when the flow is already
linked on another band's list:

		f->band = band;
		q->band_pkt_count[band]++;
		fq_skb_cb(skb)->band = band;

Suppose the sentinel flow got a later packet whose priority maps to
another band, for example after a SO_PRIORITY change on the same socket.
This refill then moves it onto that band's old_flows. first is not
cleared, so f == first never matches again during this pband walk. The
scan never runs, and the walk falls back to one quantum per iteration.

The throttle and detach exits re-arm first, but this path does not.
Should it?

> @@ -796,6 +845,11 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
>  		if (now + offload_horizon < time_next_packet) {
>  			head->first = f->next;
>  			f->time_next_packet = time_next_packet;
> +			/* first would point at an off-list flow and
> +			 * the scan would never arm; re-arm it.
> +			 */
> +			if (f == first)
> +				first = NULL;
>  			fq_flow_set_throttled(q, f);
>  			goto begin;
>  		}

[Severity: High]
Does re-arming first help once the scan has already run? The scan is
gated on "!scanned && f == first", and scanned is reset only on a band
switch. After one scan, clearing first here only picks a new sentinel
that can never trigger another scan.

The scan treats every flow with fq_peek() != NULL as able to dequeue. It
does not look at time_to_send or time_next_packet.

Take a paced or SO_TXTIME flow that becomes eligible, either through the
bulk refill or by turning positive in the first round (which makes the
scan abort with rounds = 0). It then reaches the head with credit > 0 and
is throttled here without dequeuing.

The remaining flows go back to one quantum per iteration for all their
remaining rounds. That is the N * 4096 walk under the qdisc lock with BH
off.

__fq_codel_dequeue() has the same problem. codel_dequeue() can drop every
remaining packet of the eligible flow, because codel_should_drop() looks
at the whole qdisc backlog. The flow is then list_del_init()'d while
scanned is already true.

Is the commit message's claim that "neither case can silently disable the
bound" still accurate once the scan has been used?

[ ... ]

> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> index e6c87a32950f9..79f1f25525e74 100644
> --- a/net/sched/sch_fq_codel.c
> +++ b/net/sched/sch_fq_codel.c

[ ... ]

> @@ -298,6 +300,47 @@ static struct sk_buff *__fq_codel_dequeue(struct Qdisc *sch)
>  	flow = list_first_entry(head, struct fq_codel_flow, flowchain);
>  
>  	if (flow->deficit <= 0) {

[ ... ]

> +			list_for_each_entry(iter, &q->old_flows, flowchain) {
> +				unsigned int r;
> +
> +				/* An empty flow cannot dequeue next round
> +				 * (it is removed instead), so it neither
> +				 * arms nor sizes the skip.
> +				 */
> +				if (!iter->head)
> +					continue;
> +				if (iter->deficit > 0) {
> +					skip = false;
> +					break;
> +				}
> +				r = DIV_ROUND_UP(1 - iter->deficit, q->quantum);
> +				rounds = min(rounds, r);
> +			}
> +			if (skip && rounds != UINT_MAX) {

[Severity: High]
What happens when every flow on old_flows is empty? rounds stays UINT_MAX
and the code falls through to the one-quantum walk.

The comment also does not match how empty flows are handled. An empty
flow with deficit <= 0 is refilled and rotated. It is removed only once
its deficit turns positive.

For example, N flows each send one packet with a 1 MiB stab-inflated
pkt_len, at quantum 256. Each flow is drained and left on old_flows with a
deficit of about quantum - 1 MiB.

Neither fq_codel_dequeue() nor fq_pie_qdisc_dequeue() checks qlen, and
dequeue_skb() calls q->dequeue() without checking it either. The next
dequeue call then does about 4096 refills per flow before each flow is
list_del_init()'d, and it returns no packet.

Isn't that the same N * 4096 walk under the qdisc lock that this patch is
meant to bound?

fq_pie_qdisc_dequeue() has the same structure. fq_dequeue() checks
sch->q.qlen, but the same per-band walk can happen in two cases: the
serviced band's old_flows are all empty with negative credit, and another
band still holds packets.

> +				list_for_each_entry(iter, &q->old_flows, flowchain)
> +					WRITE_ONCE(iter->deficit,
> +						   iter->deficit +
> +						   rounds * q->quantum);
> +				goto begin;
> +			}
> +		}
> +
> +		if (!first)
> +			first = flow;
>  		WRITE_ONCE(flow->deficit, flow->deficit + q->quantum);
>  		list_move_tail(&flow->flowchain, &q->old_flows);
>  		goto begin;

[Severity: Medium]
Can a run of empty flows stop the scan from ever running? The sentinel is
chosen without checking whether the flow holds a packet.

Consider old_flows ordered as empty flows E1..Ek, where Ei has deficit
1 - i * Q, followed by M backlogged flows with deficit 1 - (k + 1) * Q:

  E1 becomes first and turns positive after one refill.
  On its next visit, E1 takes the list_del_init() path, which clears
  first.
  E2 becomes the sentinel and turns positive at its next refill, and so
  on.

No sentinel is ever revisited with a non-positive deficit, so the scan
never runs. Each backlogged flow takes about k single refills. That is
O(k * (M + k)) visits under the qdisc lock.

The same pattern applies to fq_pie_qdisc_dequeue(), and to fq_dequeue()
through the fq_flow_set_detached() path. I have not confirmed that
userspace can reliably build this staggered-deficit ordering, though.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-TIAE.v1.20261008110502%40mojatatu.com
