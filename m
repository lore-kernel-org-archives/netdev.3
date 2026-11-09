Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266873;
	b=DS4jCVY28YFbu+TmgnKGZCj9KJFS5psivsrk2OSWzG8CMZQt4rWeO5XRiHAXIcdRLTAI
	 gRV9UC5b/qVGVfuqX2UQ6G1NcXaHWRcZNqoEbqzYxE+4hYPpGcyPoxKRCQ3BS2sJQjhC4
	 tclVHqNQeyF2pT+zfKhK5Jg1rRcnsYrd++b6JXchIyWRrXNGrUx6kzovZKj57PuJM2K1y
	 7fMG4UMGo0UzNTEqnjD/S9dH4u8RcCqBwxRmB5/nI9Tb2aDSRBTYYzSo9mMK52a71DT8h
	 jPM/BerasXSTW6Gxc8mFmz3Q6xNvedDiffYzH+halmInL6A93gxI3+sOJST7EiLvsng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266873;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pxieaRF+DEmHDZqBYUPaxBs1kvnt1y8Mjbqb6MFwtFQ=;
	b=kecAjHydaGbEwUNxD4LJbwkCSHEYgYunjfy5EHrTYr2ARd05p6TxbAc3Vta3X7gSAaUl
	 SkffDxEEeyoUyvm9ov+Tdv7RPlunKp8g1EcepixFZlh+BHXWDc2WAmcwxLAFZ0S1SNHx3
	 PReydcF0KRQhDgErbtKSQeMJadmRMm9SiREpJyG7+oMIkK1p2SGD+F318Pp2GzdmYEiSh
	 U4RTwUpTAWdHEQuwMaLf5mJ2mfuLqSXC1jZE6fk/3ztmFlbOYGZA089vscd6c4xizt7Jh
	 OXKH2hQbRb89eNhAG4R3T6BnwGCmowddwr+ODhZXvXB59v/IneUe+CRiWQ53SvrN6fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sys5P63d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5212D606A31C;
	Mon,  9 Nov 2026 23:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sys5P63d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E92E1F0089F;
	Mon,  9 Nov 2026 23:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794266872;
	bh=pxieaRF+DEmHDZqBYUPaxBs1kvnt1y8Mjbqb6MFwtFQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Sys5P63dPMA9ugIubxhhxprGv7JEAzMdd1Sro4pFmA7+v2xn7f5rzQ7yTXbKlFJuM
	 Qko3aQuCuf8OmuafbUjLU8gBB7++J8a0bc9hk/oEOfFL9sr9U/yKI+d+S+/m5qrd5i
	 cs1h7blDbRWPiMd0eirn6wdV7lCwSmiYwAZ7pK8/kTAqPgjEz8ThB4tTlaCidXGW2f
	 /oyflR5gxEMTg4sNvkk8+nUv025GKZmthsR9/E856CL9k0CfaOE0RQUDMwhwL5wvn/
	 1JQz6+cYUxWajeBvMzqL2fWeN2Fv0oD5tq5i0+0ui9h0as6tPEc6P0dF5uEwNGXLxC
	 Km5wwoJBVj4TA==
Subject: Re: [PATCH net] net: ibm: emac: fix TX skb double free in
 emac_full_tx_reset()
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 david@gibson.dropbear.id.au, jeff@garzik.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 23:27:51 +0000
Message-ID: <179426687184.994134.17421592671496655124@kernel.org>
In-Reply-To: <20261105231516.120321-1-rosenp@gmail.com>
References: <20261105231516.120321-1-rosenp@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch fixes only one of the two emac_clean_tx_ring()
  callers, so the same TX skb double free can still happen in…

--

net: ibm: emac: fix TX skb double free in emac_full_tx_reset()

This patch takes netif_tx_lock_bh() around emac_clean_tx_ring() and the
tx_cnt/tx_slot/ack_slot reset in emac_full_tx_reset(). This keeps
emac_poll_tx() from freeing skbs a second time after the ring has been
cleaned. mal_poll() still calls emac_poll_tx() while polling of this EMAC
is disabled.

> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index 640618c0a09e9..377755af835cc 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -745,8 +745,15 @@ static void emac_full_tx_reset(struct emac_instance *dev)
>  
>  	emac_tx_disable(dev);
>  	mal_disable_tx_channel(dev->mal, dev->mal_tx_chan);
> +
> +	/* MAL NAPI runs emac_poll_tx() even while polling of this EMAC is
> +	 * disabled. A cleaned descriptor reads as completed, so clean the
> +	 * ring under the TX lock or emac_poll_tx() frees the skbs again.
> +	 */
> +	netif_tx_lock_bh(dev->ndev);
>  	emac_clean_tx_ring(dev);
>  	dev->tx_cnt = dev->tx_slot = dev->ack_slot = 0;
> +	netif_tx_unlock_bh(dev->ndev);

[Severity: High]
This covers emac_full_tx_reset(). Can the same TX skb double free still
happen through the other caller of emac_clean_tx_ring()? That caller is
emac_close() in drivers/net/ethernet/ibm/emac/core.c, and it still cleans
the ring without the TX lock:

drivers/net/ethernet/ibm/emac/core.c:emac_close() {
    ...
	mal_disable_tx_channel(dev->mal, dev->mal_tx_chan);
	mal_poll_del(dev->mal, &dev->commac);

	emac_clean_tx_ring(dev);
	emac_clean_rx_ring(dev);
    ...
}

On this path, the only NAPI synchronization is one napi_synchronize() call
in mal_poll_disable(), reached through emac_netif_stop(). The MAL NAPI
instance is shared, so mal_poll() can be scheduled again after that. It
could be triggered by:

  - TX EOB interrupts raised while emac_tx_disable() waits for in-flight
    frames
  - another EMAC on the same MAL
  - mal_poll_enable()
  - the rotting-packet path

mal_poll() then calls poll_tx for every commac on the list. It does this
without mal->lock and without checking MAL_COMMAC_POLL_DISABLED:

drivers/net/ethernet/ibm/emac/mal.c:mal_poll() {
    ...
	list_for_each(l, &mal->poll_list) {
		struct mal_commac *mc =
			list_entry(l, struct mal_commac, poll_list);
		mc->ops->poll_tx(mc->dev);
	}
    ...
}

mal_poll_del() only does a list_del() under mal->lock, and mal_poll()
never takes that lock. Nothing waits for an in-progress poll afterwards.

On SMP, this interleaving looks possible. One example is the dual-CPU
476GTR described in akebono.dts with an ibm,emac4sync EMAC:

CPU1 (emac_close)                  CPU2 (mal_poll()->emac_poll_tx())
mal_poll_del()
                                   netif_tx_lock_bh(dev->ndev);
                                   ctrl = dev->tx_desc[slot].ctrl;
                                   /* READY clear */
                                   skb = dev->tx_skb[slot];
emac_clean_tx_ring()
  dev_kfree_skb(dev->tx_skb[i]);
  dev->tx_skb[i] = NULL;
  dev->tx_desc[i].ctrl = 0;
                                   dev_kfree_skb(skb);

This is the same "cleaned descriptor reads as completed" double free that
the commit message and the new comment describe. Neither the commit message
nor the new comment mentions the close path.

There is also a related issue at the same spot. list_del() in
mal_poll_del() poisons commac->poll_list.next, and a concurrent
list_for_each() in mal_poll() may still follow that pointer.

Would it make sense to also take netif_tx_lock_bh() around
emac_clean_tx_ring() in emac_close()? Another option is to call
napi_synchronize() after the list_del() in mal_poll_del(). The second
option would also stop mal_poll() from following the poisoned pointer.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105231516.120321-1-rosenp%40gmail.com
