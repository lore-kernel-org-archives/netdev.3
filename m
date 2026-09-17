Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE16E382F1F;
	Thu, 17 Sep 2026 04:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618379; cv=none; b=SKE/B+QL9lcZ1yAxZATFOyv3GEl3AcDKCSyEzZnRKrEw1p0TYAJEus45rdSsCfL+5h7YRvBd9JT5kYsb92vlEnlbrJvPtLBor3wKu4EoqpwZkjMyOIEiiDevPs47rEATVup++qxQRiNcQyjcN7BSuBclc7wdkng1wVI0CFP6qnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618379; c=relaxed/simple;
	bh=6njN13yX6r+d2M/ABtbrtuC1aQBtqMg2AFveqNA1WRo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ShVU12Aes31bjUakygUGT4wHf1dubClqD3guIxt+pSm9Fh1zgfJ5shJAjXvuZueHZgsOiOwZcz58kWJ8Af4smEfyozAUL96quklLAIKwrpV56XRk3uyGiZNa2BnA8TjI+MEZpxZD2zFR8nhn2P+Gvl9xAJ0XmQ+TVV23WmV4VIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIcp6wUZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIcp6wUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC061F00893;
	Thu, 17 Sep 2026 04:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618377;
	bh=cV1F3LtYToxlQSbZ9RjgYpx2CicFPC9xkiqrdXHuV50=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HIcp6wUZuQkXw72mob38yNkwiTw0Sq9VqRzPz/q+AaaWLB256owAxpoDG3NDIAHHj
	 +phyzInASqJkdzUV/f/B44ufLqMnWQJg9xUEOZlMmw+HVc8ywV5e8AH3QcJr5Jkcv7
	 uya2PpRh/dbMsUNZJ7zlS2fKBdxRwUdZXRUkUsxXdHQ0L2WgWJyAHLzLIPC3YwZhyi
	 TmWPiVDr68e/YCvZeJdUc5Ij/xWu8hXvcJHLOm64bbza9tz/BD+nBzp3xa5hNmKUAw
	 Do1sN6VYwWfx/YWUZRtHqaxFdyFHiER87soOykps1+8VfaM4S50VFW/Ra8awcIsphN
	 P++fowwxejSyA==
Subject: Re: [PATCH net] netpoll: bound the deferred transmit queue
From: netdev-bot+sashiko@kernel.org
To: zack.gomez@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, leitao@debian.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 04:12:56 +0000
Message-ID: <178961837641.22033.14382026890378144120@kernel.org>
In-Reply-To: <20260914041221.1028092-1-zack.gomez@gmail.com>
References: <20260914041221.1028092-1-zack.gomez@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] In stacked netpoll configurations the new tail drop in
  `__netpoll_send_skb()` (net/core/netpoll.c:325-327) is completely…
- [Low] The new cap in `__netpoll_send_skb()` reads `npinfo->txq.qlen`
  via `skb_queue_len()` (a plain, unannotated load,…

--

netpoll: bound the deferred transmit queue

Adds a NETPOLL_TXQ_MAX cap of 1024 skbs on npinfo->txq and makes
__netpoll_send_skb() free the new skb and return NET_XMIT_DROP once the
queue is at that length, instead of letting the deferred queue grow until
the machine runs out of memory.

Link: https://lore.kernel.org/netdev/20061026225645.482978803@osdl.org/

> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index fe1e0cda5d6bf..8fd640955e463 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c

[ ... ]

> @@ -314,6 +322,10 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
>  	}
>  
>  	if (!dev_xmit_complete(status)) {
> +		if (skb_queue_len(&npinfo->txq) >= NETPOLL_TXQ_MAX) {
> +			dev_kfree_skb_irq(skb);
> +			goto out;
> +		}

[Severity: Medium]

The commit message says:

  "netconsole already counts NET_XMIT_DROP in its per-target
   xmit_drop_count, so the loss is visible in configfs."

Does that hold when the netconsole target sits on a stacked device such as
a bond, bridge, team, VLAN or macvlan?

In that case the queue that fills and gets capped is the lower device's
npinfo->txq, reached through a nested netpoll_send_skb().  For a bond:

net/core/netpoll.c:__netpoll_send_skb()   /* np->dev == bond0 */
  netpoll_start_xmit()
    bond_start_xmit()
      bond_dev_queue_xmit()
        if (unlikely(netpoll_tx_running(bond->dev)))
                return bond_netpoll_send_skb(...);
          netpoll_send_skb(slave->np)
            __netpoll_send_skb()          /* slave's txq hits the cap */
              ret = NET_XMIT_DROP;

The nested NET_XMIT_DROP is then propagated back as status in the outer
__netpoll_send_skb(), and NET_XMIT_DROP is 1:

include/linux/netdevice.h:dev_xmit_complete() {
	if (likely(rc < NET_XMIT_MASK))
		return true;
}

so the outer frame treats the drop as a completed transmit, skips the
!dev_xmit_complete(status) block, and falls through to:

	ret = NETDEV_TX_OK;
out:
	rcu_read_unlock();
	return ret;

drivers/net/netconsole.c:send_udp() only counts the drop when
result == NET_XMIT_DROP reaches it, so xmit_drop_count (configfs
transmit_errors) stays at zero for these setups.

The bridge and team wrappers are worse in this respect, since the return
value is dropped on the floor entirely:

net/bridge/br_private.h:
static inline void br_netpoll_send_skb(const struct net_bridge_port *p,
				       struct sk_buff *skb)
{
	netpoll_send_skb(p->np, skb);
}

Could either the commit message be narrowed to a target bound directly to a
physical device, or the drop path get its own accounting (for example
dev_core_stats_tx_dropped_inc()) so the loss is observable in the stacked
cases too?

[Severity: Low]

Is the cap intended to be a hard bound?  The length is read outside
npinfo->txq.lock, while the enqueue takes that lock on its own:

include/linux/skbuff.h:skb_queue_len() {
	return list_->qlen;
}

net/core/skbuff.c:skb_queue_tail() {
	spin_lock_irqsave(&list->lock, flags);
	__skb_queue_tail(list, newsk);
	spin_unlock_irqrestore(&list->lock, flags);
}

Since check and enqueue are not one critical section, can N CPUs each
observe qlen == 1023 and all enqueue, leaving the queue at 1023 + N?

The read is also a plain load racing with skb_queue_tail() from other
producers and with skb_dequeue()/skb_queue_head() in queue_process(),
which looks KCSAN-reportable.  Would skb_queue_len_lockless(), or doing the
test and the __skb_queue_tail() under a single
spin_lock_irqsave(&npinfo->txq.lock, flags), be preferable here?

The existing skb_queue_len(&npinfo->txq) == 0 test earlier in
__netpoll_send_skb() has the same annotation question, so that part is
pre-existing and not introduced by this patch; this patch adds a second
instance and bases the memory bound on it.

>  		skb_queue_tail(&npinfo->txq, skb);
>  		schedule_delayed_work(&npinfo->tx_work,0);
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914041221.1028092-1-zack.gomez%40gmail.com
