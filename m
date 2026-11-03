Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793720106;
	b=cBl4jj1hq/jUG9POy5eLx18vMXOFTTm7oHc/lsEYsPxW4WA0fms9HUDPsCKlOVkRD8ni
	 ndp0A4NHAizEBCoOCkrpEfkk3E1hktLRuncML2KXQh8b3Js9I6lQibhv8AJ3XT4wBVy69
	 MdkztCZTBM3BnqcF00Q1/f2l1uCFT3hgvrrKzJZOy+WbyXyVyyrNDe6dAFSAfOhohPN4i
	 4LaiXThOUrqRGEpFPjaC+Gmz0+MHyP9J2qUF/UcpaIVIuB3Vds3ks9NDrQ4Tgoz8Hb/Q8
	 ybIe0tqTnb9+86r475qYK/kmpaUFnR/LuR1gjejXOXqU9TuWdyqUZA7CymPn0m9rG4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720106;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ByBzsTjtu0Xeucw6XaWPjQk6GwvLDzsSeav4CJzelcI=;
	b=ZmVO9XQd7dZshlLDSE7Wgak61zwbQZZ4fuFxmm3yoGhswQ3wOHurAGF9cLmbRItlTC9J
	 88YYfNTOZ48AacN50WPWyVvjilFSJ0aI2S8GJuwQFtI/sgSA0Hc3dTK+4Eqgtd9DLJpmI
	 GA77QqPyHLlqab1Pyp/UeAD1kuMcnMcqidoRmg+G8VFOHTbZNc+glWoY4F8wUWfzLJbfb
	 TChb/4F5BVt3aXOUo8ocyGHY5iQkzyLm2Y4PU+Id10pZYveNsLMlM6bIe6o919dZ+RvOs
	 6tKBEouE/HPcBaOqtbs8rDebLk12W5w/LkHTm8GM0/5VBiPW9E8PyzU4ggg3/qVCp5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghzLsjgy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B5606D826
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghzLsjgy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F681F000C1;
	Tue,  3 Nov 2026 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793720105;
	bh=ByBzsTjtu0Xeucw6XaWPjQk6GwvLDzsSeav4CJzelcI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ghzLsjgycrk6mRPELqXR7lVyRh8pNQT/LQATm48SuyJgVqTuSDO49MHnj84DgpcE4
	 z9iE3pBrZcUNniSD7vGtmFotKWKeLd0IgO7dlLdVaFLojOtJ9V6ysRFp9rD/cu+xbF
	 NB8GirfeMHji6Sph6Jwu0W5zCwNYk9I1DXikUcQ+HBrWiTdMqaMQG9TSqc3K8fc7fY
	 FjRpSS5+6fhwiboNUUF7QrB+fYU+1f8QlozSuaZdR8F4lpbxIecKWxoG5wmywc+0GC
	 k1gfxAB4TG2j2aGuvP1iRwkmkYwjGNBEuc22ias9VYp9J70vfQyC8pE4IqpDj14S49
	 pDieX4QB76lqA==
Subject: Re: [PATCH net v2] tun: bound the NAPI receive queue
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Date: Tue, 03 Nov 2026 15:35:04 +0000
Message-ID: <179372010482.488856.5577526079290532497@kernel.org>
In-Reply-To: <20261030152540.1409884-1-antonio@mandelbit.com>
References: <20261030152540.1409884-1-antonio@mandelbit.com>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new limit does not hold while a NAPI poll is running.
- [High] Incomplete fix: tun_xdp_one() also adds to the NAPI queue and
  has no limit.
- [Medium] The new early drop can leave a tun NAPI queue stuck for good.
- [Medium] The commit message says "The sendmsg() path, whose callers
  pass zerocopy buffers, is left alone", but the code does not do that.
- [Medium] The capacity check in tun_get_user() is lockless (tun.c:1865)
  and is not repeated under queue->lock before __skb_queue_tail()…
- [Low] The new comment says the queue is bounded 'like the per-CPU
  backlog', but the comparison differs by one.

--

tun: bound the NAPI receive queue

This patch adds a check to tun_get_user() for IFF_NAPI tun queues. When
sk_write_queue already holds netdev_max_backlog skbs, newly written
packets are dropped before allocation and counted as rx_dropped. The aim
is to stop an unprivileged user from growing the NAPI queue until the
system runs out of memory.

> Drop packets written while netdev_max_backlog of them are queued,
> before allocating them, and count them as rx_dropped. The sendmsg()
> path, whose callers pass zerocopy buffers, is left alone.

[Severity: Medium]
Does the code match this description? The exemption depends only on
!msg_control, and tun_sendmsg() passes:

	ret = tun_get_user(tun, tfile, ctl ? ctl->ptr : NULL, &m->msg_iter,

So every sendmsg() without a control message reaches the new drop. That
includes single-packet sends from handle_tx_copy() in vhost-net, and
non-zcopy packets from handle_tx_zerocopy(). Both set
msg.msg_control = NULL, and neither passes zerocopy buffers.

Only TUN_MSG_UBUF callers are actually exempt. The batched TUN_MSG_PTR
case gets no limit at all (see below).

These vhost-net sends are now dropped silently. tun_get_user() still
returns the full length, so vhost treats them as sent.

Could the commit message say which callers are actually affected?

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e6011..6e9ce707a2f9c 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -1856,6 +1857,17 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			zerocopy = true;
>  	}
>  
> +	/* In NAPI mode packets are queued here and processed by the NAPI
> +	 * poll, possibly in a kthread or ksoftirqd. Bound that queue like
> +	 * the per-CPU backlog, and drop before allocating and copying.
> +	 */
> +	if (tfile->napi_enabled && !frags && !msg_control &&
> +	    unlikely(skb_queue_len_lockless(&tfile->sk.sk_write_queue) >=
> +		     READ_ONCE(net_hotdata.max_backlog))) {

[Severity: High]
Does this check still bound the queue while a NAPI poll is running?

Before processing, tun_napi_receive() moves the whole sk_write_queue onto
an on-stack list, which resets qlen to 0:

drivers/net/tun.c:tun_napi_receive() {
    ...
	spin_lock(&queue->lock);
	skb_queue_splice_tail_init(queue, &process_queue);
	spin_unlock(&queue->lock);

	while (received < budget && (skb = __skb_dequeue(&process_queue))) {
		napi_gro_receive(napi, skb);
		++received;
	}

	if (!skb_queue_empty(&process_queue)) {
		spin_lock(&queue->lock);
		skb_queue_splice(&process_queue, queue);
		spin_unlock(&queue->lock);
	}
    ...
}

While the poll works through its budget of 64 skbs, writers on other
CPUs see qlen counting up from 0. They can add up to netdev_max_backlog
new skbs (call that W). If the poll started with Q skbs, qlen after the
splice back is (Q - 64) + W.

The poll used its full budget, so it is repolled right away and the
queue is emptied onto the private list again. Can each pass add up to
max_backlog - 64 skbs, so the total keeps growing whenever the writer is
faster than the poll?

That is the case the commit message describes. The skbs are still not
charged to the writer's memcg, so the global OOM looks reachable. The
user can slow the receive path from its own netns, for example by
turning off GRO or adding nft/tc ingress rules.

Could the fix count the skbs the poll holds privately, for example with
an in-flight counter? Another option is to have tun_napi_receive()
dequeue only budget skbs, instead of relying on sk_write_queue.qlen
alone.

[Severity: Medium]
Can concurrent writers push the queue past the limit here?

The check is lockless, and it is not repeated under queue->lock before
the enqueue later in tun_get_user():

		spin_lock_bh(&queue->lock);
		...
		__skb_queue_tail(queue, skb);
		queue_len = skb_queue_len(queue);
		spin_unlock(&queue->lock);

tun_chr_write_iter() takes no per-file lock. Several threads writing to
the same tun fd can all see qlen < max_backlog, then each allocate, copy
and enqueue a packet. The queue can then go over the limit by up to the
number of concurrent writers, and each of those skbs can be large.

enqueue_to_backlog(), which the comment names as the model, checks
again under the backlog lock:

net/core/dev.c:enqueue_to_backlog() {
    ...
	qlen = skb_queue_len_lockless(&sd->input_pkt_queue);
	max_backlog = READ_ONCE(net_hotdata.max_backlog);
	if (unlikely(qlen > max_backlog) ||
	    skb_flow_limit(skb, qlen, max_backlog))
		goto cpu_backlog_drop;
	backlog_lock_irq_save(sd, &flags);
	qlen = skb_queue_len(&sd->input_pkt_queue);
	if (likely(qlen <= max_backlog)) {
    ...
}

Should tun_get_user() check the limit again under queue->lock before
__skb_queue_tail()?

[Severity: Low]
The comment says the queue is bounded like the per-CPU backlog, but this
check uses >=. enqueue_to_backlog() above only drops when
qlen > max_backlog, and gro_cells_receive() also uses >:

	if (skb_queue_len(&cell->napi_skbs) > READ_ONCE(net_hotdata.max_backlog)) {

So the tun queue holds one packet fewer than the per-CPU backlog. With
net.core.netdev_max_backlog set to 0, which proc_dointvec accepts, the
per-CPU backlog and gro_cells still let one packet through at a time.
Here, every write() to an IFF_NAPI tun queue would be dropped.

Is >= intended, or should this use > like the code the comment refers
to?

[Severity: High]
Does tun_xdp_one() also need this limit? It adds to the same NAPI queue
without checking its length:

drivers/net/tun.c:tun_xdp_one() {
    ...
	if (tfile->napi_enabled) {
		queue = &tfile->sk.sk_write_queue;
		spin_lock(&queue->lock);
		...
		__skb_queue_tail(queue, skb);
		spin_unlock(&queue->lock);
		ret = 1;
    ...
}

For TUN_MSG_PTR batches, tun_sendmsg() calls it in a loop and then
schedules NAPI, without going through tun_get_user():

		for (i = 0; i < n; i++) {
			xdp = &((struct xdp_buff *)ctl->ptr)[i];
			ret = tun_xdp_one(tun, tfile, xdp, &flush, &tpage);
			if (ret > 0)
				queued += ret;
		}
		...
		if (tfile->napi_enabled && queued > 0)
			napi_schedule(&tfile->napi);

The commit message says sendmsg() is left alone because its callers
pass zerocopy buffers. For TUN_MSG_PTR that isn't the case:
vhost_net_build_xdp() copies guest data into page frags.

vhost-net takes this batched path whenever sock_can_batch is true:

drivers/vhost/net.c:handle_tx_copy() {
    ...
	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
    ...
}

INT_MAX is tun's default sndbuf.

/dev/vhost-net needs no capability, and common udev rules give it the
same mode as the KVM device, often 0666. A user in its own userns/netns
could then do this:

- create an IFF_NAPI tap
- attach it with VHOST_NET_SET_BACKEND
- feed small packets through the TX ring

Can sk_write_queue then grow without bound through this path while the
threaded NAPI poll falls behind?

> +		dev_core_stats_rx_dropped_inc(tun->dev);
> +		return total_len;

[Severity: Medium]
Can this early return leave the queue stuck with NAPI never scheduled?

On this path NAPI is only kicked after an enqueue:

		if (!more || queue_len > NAPI_POLL_WEIGHT)
			napi_schedule(&tfile->napi);

netdev_max_backlog is a plain proc_dointvec with no lower bound, so
values of 64 or less are accepted. With such a value, queue_len can
never exceed NAPI_POLL_WEIGHT. A run of MSG_MORE packets can then fill
the queue to max_backlog without napi_schedule() ever being called.

>From then on, every packet takes this early return, including the !more
packet that ends the batch and would have kicked NAPI. Nothing else
drains sk_write_queue on this path. Would RX on this queue then stay
dead until detach, with every packet counted as rx_dropped?

vhost-net reaches tun_get_user() with msg_control == NULL and MSG_MORE
set in two places: handle_tx_copy() when sndbuf != INT_MAX, and
handle_tx_zerocopy() for non-zcopy packets. Before this patch, the
!more packet was always queued and scheduled NAPI.

> +	}
> +
>  	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030152540.1409884-1-antonio%40mandelbit.com
