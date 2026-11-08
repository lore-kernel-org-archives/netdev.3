Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794149837;
	b=bUAeE/tpx+AVdlhHoR42LWWaUdZyUdZ/0MlX0ydm8kcPLrowd5Wp93/7XbLQDix91gVW
	 /2XO8vvUSgxu4tXy+zlSYL0GtJpMfqUuh0ViECDpUFguIXI1/GSex9V1rJb03FCmPYgec
	 Yp65zFOGjGRQk8QlUm0IjseCUyN/fh99UP8mnNXDe+bD8d7IyzZ73uU8qSa7Tp7k/cqRw
	 GpTnnLrN6B+3b4OzuvX7c5tjaf7Ic/5ycg9MUPk/GadZ1K8T9q/fT22zxLH64p+WMiQaM
	 pzxDu+sYjVQvUzfY9+geKa8QFRlR79AXrFOe9+134UZZ+N6KG1HvFTKJfIOvL9jUmjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794149837;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=T1xqFI46TZ+mtvS3n6y3UunwZQfedeCvMgjPKPnTZLc=;
	b=Uq29A8MQrWNfLHSrt1iXzfVgIO/CSd/kVzNnhlRmq6aMvFLhEzl33PuE2TqhhtX2Vegg
	 8Pv7ibZQIyjZUQc5Rprh0P2GqL1Fj+QNB9vRSJW6l6an2sQdyA/Qi0Ob7B9pLpslETtR2
	 MCG5X+vuTBMIOuEy68hGbIGlRs/1vxxP7fGFB+5vDPRKTi1gikYJLYiwC3HPm4oda/FjE
	 3Jjl4EWxVAxrOw1ghHlN8R12jCngDIXHeTkTMIH+X4EPnfnz0B7+DIwzsY7V62ZaF030Q
	 fF9gIVig6Qpn3VOHSi2VevY/Wn4rWd064W6x/qbkCN/YO1E7AHdAWCFCTX99NdzQv8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiKjZIWS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F3606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiKjZIWS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E861F0089F;
	Sun,  8 Nov 2026 14:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794149836;
	bh=T1xqFI46TZ+mtvS3n6y3UunwZQfedeCvMgjPKPnTZLc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NiKjZIWSFt1jyYVmfYyjp+nvnzNhIg6mxwVsJaW94wPtir86XzVpjq2tyDaOdK0gF
	 hdD6h6WpiD+rCqctmueuCIIHGrOzgDgtTXcDKZICnyS3Bff7aBjksxSMG4rvzobofb
	 k27/GNpqo3n5pJfd+j3a/jZPAh2L4Jd2tyId3D/L1/cBCrZZrtG7XdAJd0F/oETCnK
	 gadD2Bm8uhetmgCwNG2vgnYF7gTCzFkRckieCWg53oWSX5ENrGzU/K7Ii/FHwgrs+8
	 D7gbJ4WPK0vtIcsV6SmYCMX2/dGgOboWDCn+PRJvWOz++XnhY3RkMIEMQx7mSbxSxg
	 YC96OtFf6eHqw==
Subject: Re: [PATCH net] net/sched: etf: propagate dequeue drops to parents
From: netdev-bot+sashiko@kernel.org
To: security@copperfault.com
Cc: vinicius.gomes@intel.com, netdev@vger.kernel.org, kuba@kernel.org
Date: Sun, 08 Nov 2026 14:57:15 +0000
Message-ID: <179414983550.994134.16842767568883283385@kernel.org>
In-Reply-To: <20261104135707.725-1-me@riley.kitchen>
References: <20261104135707.725-1-me@riley.kitchen>
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] This patch adds a call to qdisc_tree_reduce_backlog() inside
  ETF's ->dequeue().
- [High] net/sched: etf: timesortedlist_drop() corrupts parent
  qfq_dequeue() state
- [Medium] The fix does not reach taprio, which is the usual parent for
  software-mode ETF, so taprio keeps counting packets that no longer…

Pre-existing issues:
- [Medium] When QFQ sits between ETF and another classful qdisc (DRR, ETS
  or HFSC above QFQ), the grandparent is never told that QFQ became…

--

net/sched: etf: propagate dequeue drops to parents

This patch makes timesortedlist_drop() count the expired packets and
bytes it drops on ETF's dequeue path. It then calls
qdisc_tree_reduce_backlog() so that classful parents update their qlen
and backlog. The goal is to fix a NULL dereference in qfq_peek_skb() when
ETF sits below QFQ.

> diff --git a/net/sched/sch_etf.c b/net/sched/sch_etf.c
> index aaafcf640bc7e..7e7532ea099eb 100644
> --- a/net/sched/sch_etf.c
> +++ b/net/sched/sch_etf.c

[ ... ]

> @@ -227,6 +230,7 @@ static void timesortedlist_drop(struct Qdisc *sch, struct sk_buff *skb,
>  	}
>  
>  	kfree_skb_list(to_free);
> +	qdisc_tree_reduce_backlog(sch, dropped_pkts, dropped_bytes);
>  }

[Severity: High]
Does this fully close the qfq_peek_skb() NULL dereference, or does it
only move it to other QFQ topologies? The new call runs from inside
the parent's dequeue. qfq_dequeue() in net/sched/sch_qfq.c does not
expect its own qlen and aggregate state to change underneath it.

The first problem is that qfq_dequeue() lowers its qlen around the
child dequeue:

	qdisc_qlen_dec(sch);

	skb = agg_dequeue(in_serv_agg, cl, len);

	if (!skb) {
		qdisc_qlen_inc(sch);
		return NULL;
	}

Take Root_QFQ -> Child_QFQ -> ETF. ETF holds one expired packet and
one packet whose txtime is in the future, so both QFQ instances have
qlen == 2. Root_QFQ peeks Child_QFQ through qdisc_peek_dequeued(),
which runs qfq_dequeue() on Child_QFQ. etf_peek_timesortedlist()
returns the expired head without looking at its txtime, so Child_QFQ
sees len > 0 and continues:

qfq_dequeue(Root_QFQ)
  qfq_peek_skb()
    qdisc_peek_dequeued(Child_QFQ)
      qfq_dequeue(Child_QFQ)        /* Child qlen 2 -> 1 */
        agg_dequeue()
          etf_dequeue_timesortedlist()
            timesortedlist_drop()
              qdisc_tree_reduce_backlog()
                                    /* Child qlen 1 -> 0 */
                qfq_qlen_notify()   /* deactivates Child's class */
                                    /* Root qlen 2 -> 1 */
      qdisc_qlen_inc()              /* Child qlen 0 -> 1 */

Child_QFQ still holds the future packet. However, notify was computed
from its temporarily lowered qlen, so Root_QFQ deactivated the class
anyway, and qfq_deactivate_agg() set q->in_serv_agg to NULL. Root_QFQ
is left with qlen == 1 and no active aggregate.

Back in Root_QFQ's qfq_dequeue(), len is 0 and the active list of the
local in_serv_agg is empty. The "sch->q.qlen == 0" early return is
skipped, qfq_choose_next_agg() returns NULL, and qfq_peek_skb()
dereferences it. That is the panic the commit message describes, one
level further up.

The reverse happens when the drops empty Child_QFQ. Its qlen wraps to
0xFFFFFFFF during the walk, so notify is false at the next level and
the ancestor keeps an empty class active.

The second problem is the local in_serv_agg in qfq_dequeue(). Take an
intermediate qdisc that uses qdisc_peek_dequeued(), for example
QFQ -> TBF -> ETF. There the drop happens during QFQ's own
qfq_peek_skb() instead of inside agg_dequeue().

Suppose that drop drains TBF and the in-service aggregate agg1.
qfq_qlen_notify() then reaches qfq_deactivate_agg(), which already
moves q->in_serv_agg to the next aggregate, agg2, through
qfq_choose_next_agg(). qfq_dequeue() still has agg1 in its local
variable. It sees len == 0, an empty active list and a nonzero qlen,
so it calls qfq_choose_next_agg() a second time. agg2 has already been
removed from the schedule. Without a third aggregate this call returns
NULL, and the next qfq_peek_skb() dereferences it.

The same unprivileged user can build both topologies in its own
namespaces, just like QFQ -> ETF. Should qfq_dequeue() be changed to
cope with drops reported from inside a child's dequeue or peek? For
example, it could lower qlen only after agg_dequeue() succeeds and
reload q->in_serv_agg after qfq_peek_skb(). Or should ETF report these
drops in a way that does not re-enter the parent while the parent is
in the middle of its own dequeue?

[Severity: Critical]
This call now runs from inside ETF's ->dequeue(). If the drops leave ETF
empty, the parent's qlen_notify runs while the parent is still inside its
own dequeue. Can this make htb_dequeue_tree() in net/sched/sch_htb.c loop
forever?

Take two HTB leaf classes, A and B, in the same row (level 0, same prio,
HTB_CAN_SEND). Each has an ETF child. All of A's packets have expired
(delta=0 guarantees this). B holds one packet with a txtime far in the
future. hprio->ptr points at A.

htb_dequeue_tree() picks start once:

	start = cl = htb_lookup_leaf(hprio, prio);

A's qlen is nonzero, so the "fix start if we just deleted it" branch is
skipped. HTB then calls A's dequeue:

htb_dequeue_tree()
  etf_dequeue_timesortedlist()
    timesortedlist_drop()
      qdisc_tree_reduce_backlog()      /* ETF qlen is 0, notify = true */
        htb_qlen_notify()
          htb_deactivate()
            htb_deactivate_prios()
              htb_remove_class_from_row()   /* A is erased from the row */

ETF returns NULL. HTB advances ptr, and htb_lookup_leaf() returns B. B's
ETF also returns NULL because its packet is not yet eligible. ptr then
reaches NULL, and htb_lookup_leaf() goes back to the leftmost class, which
is B again.

A is no longer in the row, so this condition never becomes false:

	} while (cl != start);

The loop holds the root qdisc lock with BH disabled. It only ends when B's
head packet becomes eligible, and is_packet_valid() puts no upper limit on
txtime.

Before this patch, A stayed in the row during the walk. The loop went
A -> B -> A == start and exited.

The commit message says an unprivileged user can put ETF under a classful
parent inside its own namespaces. Doesn't that make this HTB lockup
reachable in the same way as the QFQ NULL dereference being fixed?

In principle, other children that notify from dequeue (the codel family)
can hit the same HTB pattern. Codel rarely empties its queue through drops,
though, while ETF does so every time under these conditions.

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. Does the
walk still miss the grandparent when QFQ is the intermediate qdisc, for
example DRR -> QFQ -> ETF?

qfq_dequeue() temporarily lowers its own qlen around the child dequeue:

	qdisc_qlen_dec(sch);

	skb = agg_dequeue(in_serv_agg, cl, len);

	if (!skb) {
		qdisc_qlen_inc(sch);
		return NULL;
	}

Suppose ETF's expired packets are all of QFQ's backlog (QFQ qlen == n).
qdisc_tree_reduce_backlog() then notifies QFQ correctly and sets QFQ's qlen
to (n - 1) - n = 0xFFFFFFFF. On the next hop it computes:

	notify = !sch->q.qlen;

which is false. The grandparent's qlen and backlog are reduced, but it gets
no qlen_notify. After qfq_dequeue() puts QFQ's qlen back to 0, the
grandparent still has the QFQ class on its active list.

drr_dequeue() peeks the first active class and qfq_dequeue() returns NULL,
so the code takes the goto out path:

	skb = cl->qdisc->ops->peek(cl->qdisc);
	if (skb == NULL) {
		qdisc_warn_nonwc(__func__, cl->qdisc);
		goto out;
	}

The other DRR classes with queued packets then starve until new traffic
reaches the QFQ class. ETS non-strict bands and HFSC appear to stall on the
stale class in the same way.

ETF did not notify the grandparent before this patch either, so the
behaviour is no worse. Does the statement "so classful ancestors see the
removal" still hold when QFQ is in the middle?

[Severity: Medium]
Does this new call reach taprio, which is the usual parent for
software-mode ETF?

taprio_graft() always sets TCQ_F_NOPARENT on the child, including in
software and txtime-assist mode:

	new->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;

In those modes, taprio_enqueue_one() increments taprio's own qlen and
backlog. taprio_dequeue_from_txq() decrements them only when the child
returns an skb:

	skb = qdisc_dequeue_peeked(child);
	if (unlikely(!skb))
		return NULL;

	qdisc_bstats_update(sch, skb);
	qdisc_qstats_backlog_dec(sch, skb);
	qdisc_qlen_dec(sch);

When timesortedlist_drop() runs under taprio, the new walk stops at once in
qdisc_tree_reduce_backlog():

	if (sch->flags & TCQ_F_NOPARENT)
		break;

ETF then returns NULL, so taprio's sch->q.qlen and qstats.backlog grow with
every expired packet. The visible result is wrong tc statistics, not a
crash, because taprio does not use its qlen for scheduling.

The commit message says a parent will no longer "keep accounting packets
that no longer exist". Would taprio need a change too, such as not setting
TCQ_F_NOPARENT in software mode, or computing taprio's qlen from its
children instead of keeping a separate count?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104135707.725-1-me%40riley.kitchen
