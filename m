Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF21739184C;
	Mon,  7 Sep 2026 06:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761682; cv=none; b=UhdYNuv3+vcfCW62lx3uk1ROHTlHQ03yQn1UNH6U64ypU0MNcPV1irJR3x3fkhpLVqw0PRl5mnOnLkhdsQup1rYlD5kpicFf/zqLUwcFGPRGjH74M15Doc2cS4v8QWTD1mnguQ2VpP6YJeiQbToH8Vq01T79WPCrWBy7rewCNeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761682; c=relaxed/simple;
	bh=TiVHv/STHBIw8eR5i80gmB9GwLFXKqEbVozeatIRsEI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jtb+71Z7cuZ2MlmN41DSKAKDOvb8vvovVZjJ9gDVLX9WOjasGFDfQHwf9AV9ssnjWSXe7s8k4U6OIx5B0DmuOOyvcdfqL3meM8C5YWXqF7vI0YEb7JZOYL9OUVEPkG/HxQ7DSLXWTeJE6AFy6yzLfhhhiu+NVlgJuf2RYDmKwBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9/ITiTQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9/ITiTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA4B1F00A3A;
	Mon,  7 Sep 2026 06:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788761680;
	bh=JZTKe9MJ+8Ne0cG3esO2PW7HkDItB6o5bu1JnsMRmlI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c9/ITiTQoZ6Qlw4geQCT+G4Suuaf8253KOUsEFb7F2SmRxb6U7fzBqToA2GuohsXI
	 H/xUg/CtyQpn2KA9o4kJgzBW1MXPDmtUG2a7CstATKAnybGL42Ti/DNWk8/9GKU25q
	 v9rxWpcPELC5M4k3Bpy+nHllrJ9bsuID0DNvdGlwwW3rCssx7YyJ46gDYDv6aET64y
	 9ni9j1IOzqq4W8R/i2Wf4izxHDslIYi8Fy0f5VeRv51Dq6oDrDdcsFVhgDLg1ZPAuO
	 p6pQi3BNQZlU34NqFNXECU1LZ/06KQXRE0taVlrdN/l6VkM+sWJ2v3vAIJBnsxneRF
	 hfGvEElztxAQw==
Subject: Re: [PATCH net] wireguard: wait for per-peer crypto during removal
From: netdev-bot+sashiko@kernel.org
To: carges@cloudflare.com
Cc: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Date: Mon, 07 Sep 2026 06:14:39 +0000
Message-ID: <178876167936.219967.11338017664970925838@kernel.org>
In-Reply-To: <20260902-fix-wg-peer-removal-v1-1-7a0190f5cdb1@cloudflare.com>
References: <20260902-fix-wg-peer-removal-v1-1-7a0190f5cdb1@cloudflare.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] Teardown can strand decrypted packets in `peer->rx_queue`,
  permanently leaking the skbs and the peer.

--

wireguard: wait for per-peer crypto during removal

This replaces the two device-wide flush_workqueue(packet_crypt_wq) calls and
the flush_workqueue(handshake_send_wq) call in peer_remove_after_dead() with
a new per-peer packet_crypt_pending counter plus flush_work() on the peer's
own transmit_packet_work and transmit_handshake_work.

> diff --git a/drivers/net/wireguard/peer.c b/drivers/net/wireguard/peer.c
> index 1cb502a932e0..f7a9c437b5b8 100644
> --- a/drivers/net/wireguard/peer.c
> +++ b/drivers/net/wireguard/peer.c

[ ... ]

> @@ -105,28 +108,27 @@ static void peer_remove_after_dead(struct wg_peer *peer)
>  	 */
>  	wg_timers_stop(peer);
>  
> -	/* The transition between packet encryption/decryption queues isn't
> -	 * guarded by is_dead, but each reference's life is strictly bounded by
> -	 * two generations: once for parallel crypto and once for serial
> -	 * ingestion, so we can simply flush twice, and be sure that we no
> -	 * longer have references inside these queues.
> +	/* Lookup removal and is_dead prevent new packets from entering the
> +	 * parallel crypto queues after synchronize_net() waits for pre-existing
> +	 * submission paths. Drop the initial count and wait for existing packets
> +	 * to finish scheduling their serial TX work or RX NAPI processing.
>  	 */
> +	atomic_dec(&peer->packet_crypt_pending);
> +	wait_var_event(&peer->packet_crypt_pending,
> +		       !atomic_read_acquire(&peer->packet_crypt_pending));
> +
> +	flush_work(&peer->transmit_packet_work);
>  
> -	/* a) For encrypt/decrypt. */
> -	flush_workqueue(peer->device->packet_crypt_wq);
> -	/* b.1) For send (but not receive, since that's napi). */
> -	flush_workqueue(peer->device->packet_crypt_wq);
> -	/* b.2.1) For receive (but not send, since that's wq). */
>  	napi_disable(&peer->napi);

[Severity: High]
Can this leave entries in peer->rx_queue when the peer is torn down, and
leak both the skbs and the wg_peer itself?

The new counter is decremented in wg_queue_enqueue_per_peer_rx() only after
the packet has been put on peer->rx_queue and NAPI has been scheduled:

drivers/net/wireguard/queueing.h:wg_queue_enqueue_per_peer_rx() {
	atomic_set_release(&PACKET_CB(skb)->state, state);
	napi_schedule(&peer->napi);
	if (atomic_dec_and_test(&peer->packet_crypt_pending))
		wake_up_var(&peer->packet_crypt_pending);
	wg_peer_put(peer);
}

So packet_crypt_pending reaching zero means "handoff done, NAPI scheduled",
not "rx_queue drained".  For an rx-only peer flush_work(&peer->transmit_packet_work)
is a no-op, so napi_disable() can now run immediately after the last decrypt
handoff while up to MAX_QUEUED_PACKETS entries are still queued.

If wg_packet_rx_poll() consumes exactly budget entries it breaks out without
calling napi_complete_done():

drivers/net/wireguard/receive.c:wg_packet_rx_poll() {
	...
		if (++work_done >= budget)
			break;
	}

	if (work_done < budget)
		napi_complete_done(napi, work_done);

	return work_done;
}

and __napi_poll() then takes the completion path rather than a repoll,
because napi_disable_locked() has already set the disable-pending state:

net/core/dev.c:__napi_poll() {
	...
	if (unlikely(napi_disable_pending(n))) {
		napi_complete(n);
		return work;
	}

so napi_disable()/netif_napi_del() finish with a non-empty rx_queue, and
is_dead plus the completed counter wait mean nothing schedules the NAPI
again.

Each stranded skb still holds the peer reference taken by
wg_peer_get_maybe_zero() in wg_packet_consume_data() and a keypair
reference, and those are only dropped at the next: label of
wg_packet_rx_poll():

next:
		wg_noise_keypair_put(keypair, false);
		wg_peer_put(peer);

Is there any other consumer of peer->rx_queue that could drain it?  If not,
the peer kref never reaches zero, so kref_release()/rcu_release() never run
and the skbs, the wg_peer, its dst_cache and the staged queue are never
freed.  That also means the existing safety net in rcu_release():

	WARN_ON(wg_prev_queue_peek(&peer->tx_queue) || wg_prev_queue_peek(&peer->rx_queue));

can never fire to report it.

The pre-patch code did not strictly guarantee the drain either, but the two
flush_workqueue(peer->device->packet_crypt_wq) calls being removed blocked
for as long as the shared crypt workers kept running, which is exactly the
heavy-traffic case where rx_queue gets deep, and in practice gave the NAPI
softirq time to drain it.  Would it make sense to have the teardown path
wait for the rx_queue to actually empty (or purge it explicitly) rather
than only for the handoff counter?

> -	/* b.2.1) It's now safe to remove the napi struct, which must be done
> +	/* It's now safe to remove the napi struct, which must be done
>  	 * here from process context.
>  	 */
>  	netif_napi_del(&peer->napi);

[ ... ]

> diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
> index 79b6d70de236..fdd34f0f15a6 100644
> --- a/drivers/net/wireguard/queueing.h
> +++ b/drivers/net/wireguard/queueing.h

[ ... ]

> @@ -194,6 +198,8 @@ static inline void wg_queue_enqueue_per_peer_rx(struct sk_buff *skb, enum packet
>  
>  	atomic_set_release(&PACKET_CB(skb)->state, state);
>  	napi_schedule(&peer->napi);
> +	if (atomic_dec_and_test(&peer->packet_crypt_pending))
> +		wake_up_var(&peer->packet_crypt_pending);
>  	wg_peer_put(peer);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902-fix-wg-peer-removal-v1-1-7a0190f5cdb1%40cloudflare.com
