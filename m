Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7137548593D;
	Sun, 20 Sep 2026 22:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941741; cv=none; b=thCFNX8ZVpRz09a3HHH1ORzxXOKU3/ZweAohBJmoF4B7ZWSSchLgMvvoHYtF6JF/mrrQ+SmaRBAwOHKfd05is69Taz9dBfJjGYagkAVQ20ZFhzTnd935auO5t7gTy7yxjOSzYMNM26fGHpengRKPMk8R808PlKJWec9I4vhJhw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941741; c=relaxed/simple;
	bh=whe/jJD7ZhGx7Lkyxt3sc+oOBKHibaZYjQ2JeOugW2Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YDnHykaz412ByerD4RLnngxkEYOwRZX3dREVJD7iCif9brGEJzJgDNoCIjuXZ3+VZ9qchTfcQo+wH+RxAnunHXojv9oXAas+wnyvSnulnvzCOOc6KNw0ANrkLuYCR5hJdq7xVevBh5UxEdj2GCKqyAsHHRNFE4j09MwTnhtob+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7tI3ZJi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7tI3ZJi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797671F000FF;
	Sun, 20 Sep 2026 22:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789941737;
	bh=mcH/2CoilWb5yf1bTDcpI3MHFwLrBsVmYXHDDLL8lF4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=W7tI3ZJilG83VMDElJNxgaZN0QjP4MQTyx7+Dv+AhsRNF4/foNY9zF0lK8X98ju/H
	 Sg/KZtjyxNSQjLYCMynK6CPFG/tfaZiabhCbIFPs4tPSFbl5WLGuB6RwMbo93nKGxJ
	 xfcwLw7Xeozgoukx13S1L9WxmoppiP5TDE3ejjOfFYNb0zF3InS0CKhxJznuwvR9X7
	 mhM41m/84FX2pGvOu2ciMynv0GX/KlW3mpPW9x9x+NIPFlh3DgDg5X9TwBh/kSsulH
	 tkAwh4pzhqwlka4wOCJrB3tn86TQirr8fkA5WhkSnTESOtmLy9QGVyTTevZDIPdBTq
	 D/IysqZiHEw9A==
Subject: Re: [PATCH net] net: tun: fix race condition between tun_attach and
 tun_get_user with XDP
From: netdev-bot+sashiko@kernel.org
To: xietangxin@h-partners.com
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, huyizhen2@huawei.com,
 gaoxingwang1@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 22:02:16 +0000
Message-ID: <178994173600.2160803.3871616651372705060@kernel.org>
In-Reply-To: <20260917074149.1799437-1-xietangxin@h-partners.com>
References: <20260917074149.1799437-1-xietangxin@h-partners.com>
X-sashiko-severity: High
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

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] tun_attach() now publishes the increased queue count (and
  dev->real_num_{tx,rx}_queues) BEFORE publishing the backing queue…
- [High] The patch's mechanism (update the queue count before publishing
  tfile->tun) does not close the race for the reattach case, because for…
- [Medium] tun_set_real_num_queues() (drivers/net/tun.c:527-530) discards
  the return values of netif_set_real_num_tx_queues() and…

--

net: tun: fix race condition between tun_attach and tun_get_user with XDP

This moves the tun->numqueues increment and the tun_set_real_num_queues()
call in tun_attach() to before tfile->tun is published, so that
dev->real_num_rx_queues is raised before a concurrent tun_get_user() can
observe the attached queue.  The tfiles[] publication index is adjusted to
tun->numqueues - 1 to compensate.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 5a302709a68aa..2fb8df036d8c0 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -807,15 +807,16 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  	 * refcnt.
>  	 */
>  
> +	WRITE_ONCE(tun->numqueues, tun->numqueues + 1);
> +	tun_set_real_num_queues(tun);
> +

[Severity: High]
This inverts the ordering that lockless readers of tun->tfiles[] rely on:
the count is now raised before the slot it counts is populated.  Between
the WRITE_ONCE() here and the rcu_assign_pointer() at the end of
tun_attach(), tun->tfiles[N] is still NULL (the array is zeroed at alloc,
and __tun_detach() explicitly stores NULL into
tun->tfiles[tun->numqueues - 1]).  Can readers observe numqueues == N + 1
with a NULL slot at index N?

For tun_xdp_xmit() the retry does not appear able to make progress:

drivers/net/tun.c:tun_xdp_xmit() {
	...
resample:
	numqueues = READ_ONCE(tun->numqueues);
	...
	tfile = rcu_dereference(tun->tfiles[smp_processor_id() %
					    numqueues]);
	if (unlikely(!tfile))
		goto resample;
	...
}

numqueues and smp_processor_id() are both unchanged on the retry, so the
recomputed index is identical and the loop spins inside rcu_read_lock() in
softirq context until tun_attach() publishes the slot.  If that softirq
fired on the CPU running the attaching task, can this loop ever terminate?

tun_net_xmit() has a milder version of the same exposure:

drivers/net/tun.c:tun_net_xmit() {
	...
	tfile = rcu_dereference(tun->tfiles[txq]);

	/* Drop packet if interface is not attached */
	if (!tfile) {
		drop_reason = SKB_DROP_REASON_DEV_READY;
		goto drop;
	}
	...
}

Packets steered to the newly advertised queue index are dropped for the
duration of the window.

The window is also not just a couple of instructions.  For a registered
device netif_set_real_num_tx_queues() and netif_set_real_num_rx_queues()
call into the sysfs kobject helpers:

net/core/dev.c:netif_set_real_num_tx_queues() {
	...
	if (dev->reg_state == NETREG_REGISTERED ||
	    dev->reg_state == NETREG_UNREGISTERING) {
		netdev_assert_locked_ops_compat(dev);

		rc = netdev_queue_update_kobjects(dev, dev->real_num_tx_queues,
						  txq);
	...
}

which perform GFP_KERNEL allocations and can sleep, so the counted-but-NULL
state spans sleeping work.  Would publishing tun->tfiles[tun->numqueues]
first and only then bumping numqueues / calling tun_set_real_num_queues()
keep both invariants?

[Severity: Medium]
The correctness of the new ordering now depends on tun_set_real_num_queues()
actually having taken effect, but its return values are discarded:

drivers/net/tun.c:tun_set_real_num_queues() {
	netif_set_real_num_tx_queues(tun->dev, tun->numqueues);
	netif_set_real_num_rx_queues(tun->dev, tun->numqueues);
}

Both helpers leave dev->real_num_{tx,rx}_queues unchanged on failure:

net/core/dev.c:netif_set_real_num_rx_queues() {
	...
		rc = net_rx_queue_update_kobjects(dev, dev->real_num_rx_queues,
						  rxq);
		if (rc)
			return rc;
	}

	dev->real_num_rx_queues = rxq;
	...
}

and that failure is reachable without memory pressure:

net/core/net-sysfs.c:rx_queue_add_kobject() {
	...
	if (unlikely(kobj->state_initialized)) {
		netdev_warn_once(dev, "Cannot re-add rx queues before their removal completed");
		return -EAGAIN;
	}
	...
}

The void wrapper isn't new, but with the counter bump and the publication
now unconditional and tun_attach() returning 0, doesn't a failed setter
leave the attached queue permanently at queue_index == N while
dev->real_num_rx_queues stays N?  A plain write()/sendmsg() with an XDP
program attached would then hit skb_record_rx_queue() -> do_xdp_generic()
-> netif_get_rxqueue() and trip the same WARN_ONCE this patch is fixing,
with no race involved:

net/core/dev.c:netif_get_rxqueue() {
	...
			WARN_ONCE(dev->real_num_rx_queues > 1,
				  "%s received packet on queue %u, but number "
				  "of RX queues is %u\n",
	...
}

If only one of the two setters fails, tun->numqueues,
real_num_tx_queues and real_num_rx_queues all disagree and nothing is
reported to userspace.  Should the error be propagated, with the numqueues
bump unwound and the successful setter rolled back?

>  	/* Publish tfile->tun and tun->tfiles only after we've fully
>  	 * initialized tfile; otherwise we risk using half-initialized
>  	 * object.
>  	 */
>  	if (publish_tun)
>  		rcu_assign_pointer(tfile->tun, tun);
> -	rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
> -	WRITE_ONCE(tun->numqueues, tun->numqueues + 1);
> -	tun_set_real_num_queues(tun);
> +	rcu_assign_pointer(tun->tfiles[tun->numqueues - 1], tfile);

[Severity: High]
Does gating on the tfile->tun publication actually cover the reattach case?
For a queue disabled with TUNSETQUEUE|IFF_DETACH_QUEUE, __tun_detach() only
takes the disable path and never clears tfile->tun:

drivers/net/tun.c:__tun_detach() {
	...
		} else {
			tun_disable_queue(tun, tfile);
			tun_napi_disable(tfile);
		}
	...
}

so tun_get() on that fd keeps succeeding across the detach.  On the
following TUNSETQUEUE|IFF_ATTACH_QUEUE, tun_attach() makes the new, higher
index visible on that already-published tfile well before the relocated
tun_set_real_num_queues():

drivers/net/tun.c:tun_attach() {
	...
	spin_lock(&tfile->tx_ring.consumer_lock);
	tfile->queue_index = tun->numqueues;
	spin_unlock(&tfile->tx_ring.consumer_lock);
	...
}

A concurrent write() on the same fd then reads that index and enters
generic XDP:

drivers/net/tun.c:tun_get_user() {
	...
	skb_record_rx_queue(skb, tfile->queue_index);

	if (skb_xdp) {
		...
			ret = do_xdp_generic(xdp_prog, &skb);
	...
}

With 3 queues, detach then reattach gives tfile->queue_index == 2 while
dev->real_num_rx_queues is still 2, which is the same WARN_ONCE in
netif_get_rxqueue() described in the commit message.  The write path takes
neither rtnl nor tfile->tx_ring.consumer_lock, and the only
tfile->detached check in tun_get_user() happens after the XDP step and only
for the napi path.  Is the reattach path meant to be covered by this fix?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917074149.1799437-1-xietangxin%40h-partners.com
