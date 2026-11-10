Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287893;
	b=q0TGf2dWO4ZZDpjRjCXUaSuMMbOauKBN3JXK4pHTq3xqPFhsY8knFWVYofQ1E0syBuAv
	 KuKlbNeaBIT/dnEyTruA5G7Dmn/zRGCKhJJu6p65ABowo6epUW2sI+gsbzx3Eu1B70g67
	 icBmgOiPLQc9IRiGFYDCzoMjeRlrv6vVWgfHTuiKzN7ipQlZ2+wrtfmcvrSo5cUKnmy9n
	 HthPSvW5iHZ8TWj4M1jwYsXHbuGeTqzHKcPwi7yzaNv/GJYRp0KRyKJpNKj3pr6Mz5YG6
	 CEhZZFZfh5a/VoQ3OlACkIr9GpNoIF7TcTZN2VE0qzSI67QYq6bJGiVDbAjAsBVS6ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287893;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RYuj0RbzDVYqd9a5QRRV4ncCL0piQYBzmAGWnsVK4O0=;
	b=ChGVbwu9RjJvYYXYOIQEsxeVk72s/6od3Gx4TXndn8F25eNxk0DSyP/q4A+4uMmrdY/n
	 dPulVfFiwk/OMnK4hmAgTxiK8iC/8HabWRQofCW0j5QIZaK7kr+TW7Se9x16VKppucA07
	 yc7sbUCp8Qvrj1esYbwv5aF7xRb2i6qPlBjTXj3e2KfMluPX2oCS4/AM1ElFw5upCt9Zi
	 q51ABUeGaFyBvvyIVIZBdRId8SCWW4swDSFQvZfrCAxisZyulzV6LKB4oauQUSSZvSi1v
	 hi7GND1W0YLAKU9QzVE6i2PFi0rmQ1wFG9HPBI3jB6zb3kNt0XCLM4vAYh8I01GraiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqcJKQwi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB46B606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 05:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqcJKQwi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C261F0089F;
	Tue, 10 Nov 2026 05:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794287892;
	bh=RYuj0RbzDVYqd9a5QRRV4ncCL0piQYBzmAGWnsVK4O0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fqcJKQwiqVZXKMWIUogO9YtL3Q4u69tKE1qT3AjidGNOPx7m+yeJw2SqbBYZY5sE2
	 qm/uKqLO0se2F5SMCDTF7UhZRw+hqwEcW8Fm/hzz0uuF7OCJ1qUnICZh8mdPFJLjWv
	 EVA37w/4iC4b4+g07t0Dou0LYWyfvJjvHVyCsC3sK9OkiKTTseBWgTweAkpgmZhe4J
	 nBwmlRXpkDQ0tFu7skmdl5JRTZqzufVBEh4K8KQjt007HjVXr60QRHbsrO9hBafxZu
	 +68k4KEb5Oy8T+dkT/zu5gzrWQ7bfUR7zgytd0zaP5jjtdB9rxP94NLqqiIIJXDVQp
	 S2g0KQkIZbzLQ==
Subject: Re: [PATCH net] net/sched: hold the tree lock while resetting a qdisc
 being destroyed
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us
Date: Tue, 10 Nov 2026 05:18:11 +0000
Message-ID: <179428789134.994134.1074259658602861219@kernel.org>
In-Reply-To: <20261106161455.2412769-1-edumazet@kernel.org>
References: <20261106161455.2412769-1-edumazet@kernel.org>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new sch_tree_lock(qdisc) in __qdisc_destroy()
  (net/sched/sch_generic.c:1161-1163) does not reliably exclude the…
- [Medium] In the common case where a destroyed qdisc's
  dev_queue->qdisc_sleeping is already &noop_qdisc, the new…
- [Medium] net/sched: qdisc_reset() after parent unlinking races with
  sfq_rehash()
- [Medium] net/sched: taprio_reset() in __qdisc_destroy() misses per-
  queue locks

--

net/sched: hold the tree lock while resetting a qdisc being destroyed

Graft operations no longer purge the qdisc they remove. Because of
that, __qdisc_destroy() can call qdisc_reset() on a non-empty qdisc
while its timers, such as sfq_perturbation(), are still running. This
patch takes sch_tree_lock() around qdisc_reset() in __qdisc_destroy()
and updates the qdisc_reset() comment to match.

> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index d2e0d20f3ba1c..e39745d58bfcd 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c

[ ... ]

> @@ -1154,8 +1154,13 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
>  #endif
>  	gen_kill_estimator(&qdisc->rate_est);
>  
> +	/* A detached qdisc can still hold packets, and its timers
> +	 * (sfq_perturbation(), ...) may run until ops->destroy() stops
> +	 * them. They hold the sleeping root lock, take it here as well.
> +	 */
> +	sch_tree_lock(qdisc);
> +	qdisc_reset(qdisc);
> +	sch_tree_unlock(qdisc);

[Severity: Medium]
Does sch_tree_lock() cover everything that qdisc_reset() touches
when the qdisc is a fully offloaded taprio root?

In full offload mode, taprio_attach() grafts each q->qdiscs[ntx]
directly as the qdisc_sleeping of TX queue ntx. The taprio root does
not set TCQ_F_MQROOT. So sch_tree_lock() on the root takes the lock
of TX queue 0's sleeping qdisc, which is q->qdiscs[0].

Suppose the taprio root is replaced by a qdisc with ops->attach,
such as mq, mqprio, taprio or htb. qdisc_graft() then jumps to skip
and destroys the old root before the new one attaches:

net/sched/sch_api.c:qdisc_graft() {
	...
	notify_and_destroy(net, skb, n, classid, old, new, extack);

	if (new && new->ops->attach)
		new->ops->attach(new);
	...
}

So the taprio children are still the sleeping qdiscs of their TX
queues when __qdisc_destroy() runs qdisc_reset() on the root. That
reset walks all of them:

net/sched/sch_taprio.c:taprio_reset() {
	...
	if (q->qdiscs) {
		for (i = 0; i < dev->num_tx_queues; i++)
			if (q->qdiscs[i])
				qdisc_reset(q->qdiscs[i]);
	}
}

For i > 0, a timer in that queue's hierarchy takes the lock of TX
queue i's sleeping qdisc, not the lock of q->qdiscs[0]. One example
is sfq_perturbation() on an sfq grafted to taprio class i. The rehash
and taprio_reset() can then work on the same skb lists under
different locks. That is the corruption this patch is meant to fix.

This needs a device with TC_SETUP_QDISC_TAPRIO full offload. On such
a device, a plain tc qdisc replace of the root is enough.

Would it work for taprio_reset() to take each child's root lock
around its reset when full offload is enabled? Or should the
per-queue children be left to be reset later under their own locks?

[Severity: Medium]
The new lock orders qdisc_reset() against the timers. Can they still
run on the detached, non-empty hierarchy before the reset is reached?
Before 47e8dbb6e763 the old qdisc was purged before it was unlinked,
so sfq_perturbation() found q->tail == NULL and skipped sfq_rehash().

With the changelog's tbf + sfq setup, qdisc_graft() replaces
dev->qdisc first. notify_and_destroy() then runs qdisc_notify() and
qdisc_put(). __qdisc_destroy() then runs qdisc_hash_del(),
qdisc_put_stab() and gen_kill_estimator(), and the last of these can
wait in timer_shutdown_sync(). Only after that is the hierarchy
reset.

If sfq_perturbation() fires in that window, sfq_rehash() calls
qdisc_tree_reduce_backlog(), which walks up through sch->parent:

net/sched/sch_api.c:qdisc_tree_reduce_backlog() {
	...
	sch = qdisc_lookup_rcu(qdisc_dev(sch), TC_H_MAJ(parentid));
	if (sch == NULL) {
		WARN_ON_ONCE(parentid != TC_H_ROOT);
		break;
	}
	...
}

The tbf parent can no longer be reached from dev->qdisc or from the
qdisc hash. After tc qdisc del, the lookup returns NULL and the
WARN_ON_ONCE() fires. After tc qdisc replace with the same 1:
handle, the lookup finds the new root instead. qlen_notify() can then
run on one of its classes. Its q.qlen, qstats.backlog and drops are
reduced by packets that sfq_rehash() dropped, which the new root
never held.

The same applies under mq or mqprio. There, qdisc_hash_del() at the
top of __qdisc_destroy() unlinks the sfq's parent before the reset.

Should the hierarchy be emptied, or its timers stopped, before the
qdisc is unlinked, as the graft-time purge did before 47e8dbb6e763?

[Severity: High]
Is this the same lock that a running timer is holding?

For a qdisc without TCQ_F_MQROOT, sch_tree_lock() looks up the lock at
the moment it is called:

	spin_lock_bh(qdisc_root_sleeping_lock(q));

That lock is qdisc_lock(q->dev_queue->qdisc_sleeping). For a detached
qdisc, dev_graft_qdisc() has already pointed qdisc_sleeping at the new
root or at &noop_qdisc before __qdisc_destroy() runs:

net/sched/sch_generic.c:dev_graft_qdisc() {
	root_lock = qdisc_lock(oqdisc);
	spin_lock_bh(root_lock);
	...
	rcu_assign_pointer(dev_queue->qdisc_sleeping, qdisc);
	rcu_assign_pointer(dev_queue->qdisc, &noop_qdisc);

	spin_unlock_bh(root_lock);
}

The timers read the pointer and then take the lock as two separate
steps. They never check the pointer again after locking:

net/sched/sch_sfq.c:sfq_perturbation() {
	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
	spin_lock(root_lock);
	q->perturbation = nkey;
	if (!q->filter_list && q->tail)
		sfq_rehash(sch);
	spin_unlock(root_lock);
}

Take the changelog's reproducer: a tbf root, an sfq child with perturb
set, then tc qdisc del dev $d root. Can this sequence happen?

CPU0 (sfq_perturbation)          CPU1 (qdisc_graft)
                                 dev_graft_qdisc()
                                   spin_lock_bh(&tbf->q.lock)
root_lock = &tbf->q.lock
spin_lock(root_lock) spins
                                   qdisc_sleeping = &noop_qdisc
                                   spin_unlock_bh(&tbf->q.lock)
spin_lock(root_lock) succeeds
sfq_rehash()                     notify_and_destroy()
                                   __qdisc_destroy(tbf)
                                     sch_tree_lock(tbf)
                                       takes noop_qdisc.q.lock
                                     qdisc_reset(tbf)
                                       tbf_reset()
                                         qdisc_reset(sfq)
                                           sfq_reset() frees skbs

In that case sfq_rehash() and sfq_reset() work on the same skb lists
while holding two different spinlocks. That looks like the same
use-after-free this patch is trying to fix.

Nothing in qdisc_graft() puts an RCU grace period between
dev_graft_qdisc() and __qdisc_destroy(). The synchronize_net() in
dev_deactivate() runs before the graft.

The timer can also wait on the old root lock for a while. One example
is an htb root with several sfq leaves, where one leaf's rehash holds
the root lock while dev_graft_qdisc() and a sibling's timer both wait.
On PREEMPT_RT the timer can also be preempted between reading the
pointer and calling spin_lock().

red_adaptative_timer(), pie_timer(), fq_pie_timer() and dualpi2_timer()
read and then lock in the same way.

mq_graft() has the same mismatch. The old mq child's timer may hold
the child's own lock, while __qdisc_destroy() takes the lock of the
new child or of noop_qdisc.

Would it work better to stop the timers before the reset, to do the
reset under the old root lock before the graft, or to have the timers
check the lock again after taking it?

[Severity: Medium]
qdisc_sleeping is often already &noop_qdisc when we get here: after tc
qdisc del ... root, when ingress or clsact is deleted, and in
dev_shutdown(). In those cases, does sch_tree_lock(qdisc) end up
taking noop_qdisc.q.lock?

That is one static spinlock, shared by every device in every netns:

net/sched/sch_generic.c:noop_qdisc
	.q.lock		=	__SPIN_LOCK_UNLOCKED(noop_qdisc.q.lock),

With this patch, that lock is held with BH disabled for the whole
qdisc_reset()->ops->reset() walk over the hierarchy being destroyed.
The cost grows with the configured backlog; the changelog's
reproducer uses limit 100000.

Other code takes the same lock:

- __dev_xmit_skb() takes qdisc_lock(q) for every TX queue whose qdisc
  is &noop_qdisc. One example is a carrier-down or deactivated device
  in another netns that still receives IP or AF_PACKET traffic.
- Timers of other detached qdiscs whose qdisc_sleeping is noop.
- dev_graft_qdisc() calls whose old sleeping qdisc is noop.

Before this patch the reset here ran without any lock. The earlier
purge in dev_reset_queue() only took the old qdisc's own per-device
lock.

Can transmits on unrelated devices and namespaces now spin behind the
purge of another device's queues?

The lock taken here also doesn't belong to the hierarchy being
destroyed, which is the same mismatch as in the race above.

>  
>  	if (ops->destroy)
>  		ops->destroy(qdisc);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106161455.2412769-1-edumazet%40kernel.org
