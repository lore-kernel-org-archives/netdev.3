Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793575383;
	b=xH+/GXFDQWX6HjSTv5LKrBaWSBZ0ybqIwzoUr1xvl0uK9i0pYmtoXp/Ue+5PH9fz8Of7
	 Rf+FtCmyAbv9uhqhehbUSpqpr2+sIZsZ2HNGkKIqpFA/oH/EDliUY/OJp5E3pn1Y1Myno
	 sgD0ygTfDTxwwvJ6MiAAK00fpJhOdMfrG6QtpPR4KX0wkmCFlMkTsOxeemRkXNbZLY1Ye
	 L8dB1e9sk9nF/4JKOY/4GSbNsPA2VY8xVDPgHRwuCQMM7Z2w11mPkE3xcjefSSY1dqxc4
	 r+6cVn/dSJVQCL55P4s+ewfjbrFvAyKBP8P0i+oZzXFPW2Iouai2FRWRUvrYjW2U38g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793575383;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=neA9HbOUFeZdfaIBf1NrRXdCi9YOxGphTdPUH8xzr5Y=;
	b=nPgMJmQjrGzuuxuFblcizV3J8tboSLfpz+KK6g8JYzXwiiGUFzlBdhzZ2EEhGnlrdLUi
	 JMqtfEkImBVH0ITe7MKEFsKhDtJtt2k0+cT4Jb7KQH5pIMSMLoO3Sl6w42r9StB1FRStq
	 9WwMoz6TZ9xayWA1RFFnem39rvjI1DCHpTlhKF6DkcQpwy/ibOtqwY3QlbWXo0k7y8KkN
	 OG+uwnPdmwjuyoyTvHCxnc/FdbOKfwuJ1n7mjKu4WHA/V9EKwp/JPzFJrl8BV2nsvEwb5
	 JrqXxmciK9gmjU51wzmdh3PTR/8uY7s2qXlU7GBFN0ZTEzdUE/dsx+Dd4qdXNcLhY/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZCcZyHL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB440606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZCcZyHL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCABE1F000C1;
	Sun,  1 Nov 2026 23:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793575382;
	bh=neA9HbOUFeZdfaIBf1NrRXdCi9YOxGphTdPUH8xzr5Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DZCcZyHLg7hXMopjpW377Ns2sTrXeDK0S8ACxcReMkhvrnNm960iRNES9cOe/ggjI
	 HLkehCMaZJYf12C9H07d0z39LFnYFPxZHRCXJRwP8/9uL8XX3i185zDDvu2DKj6lIr
	 vs2pjJl04/q0CrbBaqfFYCqy+zzOx9Nn9giyj3uJDImSz7TFHY5rJ9iENBqDHblnNl
	 tfoxXy/tTVt+A5e5edf1IXw6sDHo+4vXhtXgGVhaU9XP5ncYuC+Gia1GDQXMx7F72l
	 fXl2NJuamHl/oJqy8W/ywVRO+ZmCvcPFVyUMT+gwZwqYWryeMnTmJO29RpDIWmoDKq
	 xTku+ivuXi2aA==
Subject: Re: [PATCH net v3] tun: bound the NAPI receive queue
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Date: Sun, 01 Nov 2026 23:23:01 +0000
Message-ID: <179357538131.3131.13550708149751579907@kernel.org>
In-Reply-To: <20261031231444.1528758-1-antonio@mandelbit.com>
References: <20261031231444.1528758-1-antonio@mandelbit.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new limit does not bound the IFF_NAPI queue in the case the
  patch is meant to fix: a threaded NAPI poll on another CPU that is…
- [Medium] The new full-queue drop paths return before NAPI is scheduled,
  which can leave queued skbs stuck.

--

tun: bound the NAPI receive queue

In IFF_NAPI mode, packets written with write() or sendmsg() wait on the
tfile's sk_write_queue for the NAPI poll. That queue has had no limit.
This patch drops packets once more than netdev_max_backlog are queued.
The check runs before allocation and again under the queue lock, and
each dropped packet is counted as rx_dropped.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e6011..410efa8ce5d91 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -227,6 +228,15 @@ struct veth {
>  static void tun_flow_init(struct tun_struct *tun);
>  static void tun_flow_uninit(struct tun_struct *tun);
>  
> +/* In IFF_NAPI mode written packets wait in the tfile's sk_write_queue for the
> + * NAPI poll, which may run later in a kthread or ksoftirqd. Bound that queue
> + * like the per-CPU backlog of netif_rx().
> + */
> +static bool tun_napi_queue_full(const struct sk_buff_head *queue)
> +{
> +	return skb_queue_len_lockless(queue) > READ_ONCE(net_hotdata.max_backlog);
> +}

[Severity: High]
Does this bound the queue in the case the patch is meant to fix, where a
threaded NAPI poll on another CPU is slower than the writer?

tun_napi_queue_full() only looks at the length of sk_write_queue. But
tun_napi_receive() moves the whole queue out before it starts:

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

While the poll works through process_queue, the qlen of sk_write_queue
is 0. Writers in tun_get_user() and tun_xdp_one() can therefore queue up
to max_backlog + 1 new skbs. The poll then splices the unprocessed
leftovers back in front of them.

If L skbs are queued and W skbs are written during the poll, the queue
holds (L - 64) + W afterwards. Since received == budget, tun_napi_poll()
does not call napi_complete_done(). The next poll splices everything out
again right away and the window reopens.

Doesn't that let the backlog grow by up to about max_backlog + 1 - 64
skbs per poll, for as long as the writer is faster than the poll?

The commit message says:

    the NAPI poll splices the queue out while it runs so up to about
    twice the limit can be in flight

That 2x bound holds for enqueue_to_backlog() and process_backlog() in
net/core/dev.c. There, leftovers stay in sd->process_queue, and
input_pkt_queue is only spliced over once process_queue is empty. tun
puts its leftovers back on the shared queue, so does the statement
apply here?

Would the leftovers need to stay off sk_write_queue, or be counted
against the limit, for the bound to hold?

> +
>  static int tun_napi_receive(struct napi_struct *napi, int budget)
>  {
>  	struct tun_file *tfile = container_of(napi, struct tun_file, napi);
> @@ -1856,6 +1866,20 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			zerocopy = true;
>  	}
>  
> +	/* Drop before allocating and copying when the NAPI queue is full. The
> +	 * check is repeated under the queue lock before queueing.
> +	 */
> +	if (tfile->napi_enabled &&
> +	    unlikely(tun_napi_queue_full(&tfile->sk.sk_write_queue))) {
> +		if (msg_control) {
> +			struct ubuf_info *uarg = msg_control;
> +
> +			uarg->ops->complete(NULL, uarg, false);
> +		}
> +		dev_core_stats_rx_dropped_inc(tun->dev);
> +		return total_len;
> +	}

[ ... ]

> @@ -2045,6 +2069,14 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			goto free_skb;
>  		}
>  
> +		if (unlikely(tun_napi_queue_full(queue))) {
> +			spin_unlock_bh(&queue->lock);
> +			rcu_read_unlock();
> +			kfree_skb_reason(skb, SKB_DROP_REASON_FULL_RING);
> +			dev_core_stats_rx_dropped_inc(tun->dev);
> +			return total_len;
> +		}
> +
>  		__skb_queue_tail(queue, skb);
>  		queue_len = skb_queue_len(queue);
>  		spin_unlock(&queue->lock);

[Severity: Medium]
Can these early returns leave skbs on sk_write_queue with no NAPI
scheduled? In tun_get_user(), NAPI is only scheduled after a successful
enqueue:

	if (!more || queue_len > NAPI_POLL_WEIGHT)
		napi_schedule(&tfile->napi);

net.core.netdev_max_backlog is handled by proc_dointvec with no lower
bound. An admin can set it below NAPI_POLL_WEIGHT (64), or lower it at
runtime while skbs are already queued.

vhost-net sets MSG_MORE while batching (tx_can_batch()). So a vhost-net
sender can fill the queue to max_backlog + 1 skbs without queue_len
ever going above 64.

The send that ends the batch, without MSG_MORE, then hits either the
early check or this locked check. Both return total_len before the
napi_schedule() call, and every later send is dropped the same way.

The batch path has the same problem. tun_xdp_one() returns 0 on the new
drop, and tun_sendmsg() only schedules when something was queued:

	if (tfile->napi_enabled && queued > 0)
		napi_schedule(&tfile->napi);

So a batch in which every buffer is dropped never schedules NAPI
either.

Before this patch, the next send without MSG_MORE would queue a packet
and schedule NAPI. With the patch, does RX on that queue stop until the
queue is detached or purged?

With vhost-net zerocopy, the stuck skbs also keep their ubuf_info
references. vhost_net_flush()->vhost_net_ubuf_put_and_wait() does an
uninterruptible wait_event() on those references.
vhost_net_release() calls it before the sockfd_put() of the tx socket,
so the tun detach that would purge the queue cannot happen.

Could releasing or resetting the vhost backend then hang until the tun
device is deleted?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031231444.1528758-1-antonio%40mandelbit.com
