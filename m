Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794157346;
	b=k17dOTMNgeIpOggT+srUlEOKOfIk9mMvGVzkmFomla9lFXa43uBaMSBl/H+jMfEXJrLF
	 SdYrzjeJQrEQyhRLqb4F+RENffYujljFrS41a5oSn3lV5k19u2qtzz0vltyhUrUe9W/sN
	 vZfk0GqcfZeEJZZO/pLyjoGhDUgqFuRWsb/kEU3ElfY4a33r/QPdR8KHvI4fvCaJhAXPz
	 TUnP/p/qinnDPtaQDC17ZS35ZU6HT7l0suN5JjntqCV6jkKsD5zvZSMha3JHX9tcongpO
	 GEIP6AzCOsPfPmNk8bBSXrSjlHHcr1z4ddkJM+y3Jkar1TIyXY5f6jd021ZTlJ8vnpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794157346;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=B3OFhFaD9Cip7KMo015kSeNJt+uJfckFsdDq5kntSPs=;
	b=YMbCc5hQDbroUL+xOynfBxMuyOrtN1uVq64ekU6QS7slQyXyPp8ytdWbAHdRL1cxtZ0v
	 cSbW3ODqv8yCwIaH0A5/o2ykoRU3BZxB8aSgN5bwnY2ymJK/YpovGCo0yBw9udqa7owDH
	 wobhiOIzoM9EEySpSinr7o+z1dCTSUnnoUhuOQt5j6RcNhHlNFWaK6zKOooeyZEo+9ej+
	 L4QbdHafvI5ok860yNTWeX90MCHrroVX1hWRfabewE+Ncexv9R/h+G7/OHVe5GpKmQPC7
	 8aUoBxiw67giZL6Y2gJU/4o5UcQjotextywrHeBjOAe3VVml5ZxyKPGnBr23ljf0KhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VvUq5ruV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67357606A321;
	Sun,  8 Nov 2026 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VvUq5ruV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762A21F0089F;
	Sun,  8 Nov 2026 17:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794157346;
	bh=B3OFhFaD9Cip7KMo015kSeNJt+uJfckFsdDq5kntSPs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VvUq5ruVLCHh/XdhKKKvm7KjwnL75VqvffEVIBYmKMfaR7z6+webvJ8DWnDsGoiu3
	 S0JQxUBFu0UhO7d3+im66z9SQUN102TvEyqZd5DG0ypzb4riwTeoBjOIPQlR1VLhql
	 kW4KfNxFJZPU8K7trUkoFYixvcX9hr4HR6XrDTK0gyYrFOQeFzLr5Z82Mj/pgfnhMy
	 Bvlz3t/lzJ3uWXEFkPi0Yjn2StY4lyMorFdZXQQYc692kXHiJVNDl2B3hUpJAoHwLx
	 mrJ/bCI4P/hsrn5IPXbzvwejRK0w+6KUZv3xeWRa3vfbw2Dl3aKqJzvsqO5EfL1NzW
	 iIHcQIWgw6JDw==
Subject:
 Re: [PATCH net] tun: delete the flow entries of the moved queue on detach
From: netdev-bot+sashiko@kernel.org
To: umangpokhriyall@gmail.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 17:02:25 +0000
Message-ID: <179415734502.994134.10139593761656069984@kernel.org>
In-Reply-To: <20261104174240.138491-1-umangpokhriyall@gmail.com>
References: <20261104174240.138491-1-umangpokhriyall@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix is incomplete.

--

tun: delete the flow entries of the moved queue on detach

When __tun_detach() moves the last queue into the freed slot, it is
supposed to delete the flow entries that still point at the moved queue's
old index. Before this patch it passed tun->numqueues + 1, an index that
never exists, so nothing was deleted. The patch passes tun->numqueues
instead.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e6011..3b292bce4438c 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -615,7 +615,7 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
>  		}
>  
>  		synchronize_net();
> -		tun_flow_delete_by_queue(tun, tun->numqueues + 1);
> +		tun_flow_delete_by_queue(tun, tun->numqueues);

[Severity: Medium]
This removes the case where every learned flow was misdirected on each
detach. Can a concurrent write() still put back an entry that points at
the old index after this delete has run?

tun_flow_update() reads the queue index before its own rcu_read_lock().
It does not take tun->lock, rtnl, or the consumer_lock that __tun_detach()
uses when it rewrites ntfile->queue_index:

drivers/net/tun.c:tun_flow_update() {
	...
	u16 queue_index = tfile->queue_index;

	head = &tun->flows[tun_hashfn(rxhash)];

	rcu_read_lock();

	e = tun_flow_find(head, rxhash);
	if (likely(e)) {
		/* TODO: keep queueing to old queue until it's empty? */
		if (READ_ONCE(e->queue_index) != queue_index)
			WRITE_ONCE(e->queue_index, queue_index);
	...
	} else {
		spin_lock_bh(&tun->lock);
		...
			tun_flow_create(tun, head, rxhash, queue_index);
	...
}

tun_get_user() also calls it only after it has left its RCU section:

	rcu_read_unlock();

	preempt_disable();
	dev_sw_netstats_rx_add(tun->dev, len);
	preempt_enable();

	if (rxhash)
		tun_flow_update(tun, rxhash, tfile);

So the synchronize_net() before the delete does not seem to wait for this
writer. Here N is the queue count before the detach. One possible
sequence, with write() on the moved queue (ntfile):

CPU1 (write() on ntfile)            CPU2 (__tun_detach())
tun_flow_update()
  queue_index = tfile->queue_index;
  /* N-1 */
  <preempted>
                                    ntfile->queue_index = index;
                                    WRITE_ONCE(tun->numqueues, N-1);
                                    synchronize_net();
                                    tun_flow_delete_by_queue(tun, N-1);
  rcu_read_lock();
  WRITE_ONCE(e->queue_index, N-1);
  /* or tun_flow_create(..., N-1) */

A second sequence: the queue being detached is the last one (index is N-1,
so ntfile == tfile) and the detach is IFF_DETACH_QUEUE. A write() that
passed the !tfile->detached check in tun_get_user() before
tun_disable_queue() can reach tun_flow_update() after the delete. It still
carries queue_index N-1, and nothing rewrites that.

In both cases tun_automq_select_queue() returns the stored index without
checking it against numqueues:

	if (e) {
		tun_flow_save_rps_rxhash(e, txq);
		txq = e->queue_index;
	} else {
		txq = reciprocal_scale(txq, numqueues);
	}

Before tun_set_real_num_queues() runs, tfiles[N-1] is NULL, so
tun_net_xmit() drops the packet. After it runs, netdev_cap_txqueue() sends
the packet to queue 0 and prints the same "selects TX queue N-1, but real
number of TX queues is N-1" warning quoted in the commit message. This
lasts until the flow is written again from a live queue or ages out.

The vhost path (tun_sendmsg()->tun_xdp_one()->tun_flow_update()) runs
inside the rcu_read_lock() taken in tun_sendmsg(), so only the write()
path appears to be affected.

The plain read of e->queue_index in tun_flow_delete_by_queue() also races
with the lockless WRITE_ONCE() in tun_flow_update().

There are two possible fixes. One is to read tfile->queue_index and update
e->queue_index under tun->lock. The other is to have
tun_automq_select_queue() fall back to reciprocal_scale() when
e->queue_index >= numqueues. Would either of these work here?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104174240.138491-1-umangpokhriyall%40gmail.com
