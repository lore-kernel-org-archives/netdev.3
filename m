Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173443;
	b=o5aKK+cR6ovV7M5oNK/u9bSZaMosRkIeQO/nh/HcyHyhM2n4470+wwxD4+usMBaRvG3r
	 ZI+Fn4AsXU//VflYSU59slmXLifu7oMp5pKCFcCcX0ejqPLVI+BA5ZqowXH+m4fYjZdKw
	 c5siKZU+XmhtXB2SCrNzUbaS6notkGn7Qya7hYyh3iqVawSATOBFK2so+OM9MaLiFqKHa
	 FZb2ghtS1JJDlYS/WXUtD6tgYjCb7O1dUcQ8bhEXR6auJ5YySik+v83Blf+dms6AIhpMC
	 P0tuFnaVcKtvpDcF/KX3slCyht2RLfddH0Q66ij581gR08JYwwSFsd1ZiSjZcwspxdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173443;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Jw+/Fkc20+Qp4XR5VO/LxheUCUIT4ctMVUZLv2aVJAc=;
	b=3+q4wt45roLs49WtnmigBxx5AcdrE7Ffqyv/ca4DCTe88WDeDf3h7UH7T8f+Z61OYwWT
	 321/NVX3lzMu1LxTHI8y6VCC8OboiC/CZF7qrLCGz4SeFW2bZgOGbptMLpNUECHIkwk0i
	 FeNWfPj8phm94HEOvgYkTtM9nA9PCrU7YcZE5V4brIXWYxauDzUKraBRWjpEiAqZPULqS
	 HkY7dBdNaEsrs//o+vAvAJEq2eYE+ldlmwvBJKeDkoS2ZEgx0rQVaFEZOlYO+mrYtl1xQ
	 C3UZnabNH2lxT3dw67GNaMfSYeGTKoskoqxYwmOIrh5pjHwxxSnWMPOebsrRq83Zaew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7FxV7XM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CB3606A31C;
	Sun,  8 Nov 2026 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7FxV7XM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663951F0089F;
	Sun,  8 Nov 2026 21:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794173443;
	bh=Jw+/Fkc20+Qp4XR5VO/LxheUCUIT4ctMVUZLv2aVJAc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j7FxV7XMRjRBVBjDNqZB72oA6jNKCIgXW5mW9v9+7afoWjL/Y4/xiKO+32hlJypep
	 ql2qzXBguSaxKXlPqwF0qxBYD2YhHmjOAWVuUxc9IHQ+pPSBj9VJee+3nfHiMZi4LY
	 BWEV6CTemNlAcLukfktIV7W6dFicWad8WWkJwe7ae7k8BSaqaQbF6JfIBohwQehv1c
	 GIVnSnk1jkaHCMKtKD02iB1H0vrjNO9heeqYwwpgsRij9HwVtNFPUM3VaDMc8mvISc
	 31NUc/hyZ9vuaARvFnTbQE50pvjtlD7AL7RecIVu3DcX2RiNR5i3jYqCwUnbC/WZSc
	 2Fq+v9gYLlPSQ==
Subject: Re: [PATCH net 1/2] net: macb: credit unsent frames to BQL in
 macb_tx_error_task()
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 sean.anderson@linux.dev, robert.hancock@calian.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 21:30:41 +0000
Message-ID: <179417344193.994134.16378845352525630728@kernel.org>
In-Reply-To: <20261107-nb-macb-tx-error-task-net-v1-1-a2aac5d64d52@tipi-net.de>
References: <20261107-nb-macb-tx-error-task-net-v1-1-a2aac5d64d52@tipi-net.de>
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

- [High] The fix leaves a second site with the same bug.

--

net: macb: credit unsent frames to BQL in macb_tx_error_task()

This commit moves the BQL packets/bytes accounting in macb_tx_error_task()
out of the "TX complete" branch. Every frame removed from the ring is now
credited through netdev_tx_completed_queue(), whether it was sent or not.
This stops the DQL in-flight count from leaking on each TX error.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index f087f278f9e56..b6105f915fe35 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -1428,6 +1426,12 @@ static void macb_tx_error_task(struct work_struct *work)
>  			desc->ctrl = ctrl | MACB_BIT(TX_USED);
>  		}
>  
> +		/* BQL has to see every frame leaving the ring, sent or not */
> +		if (skb) {
> +			packets++;
> +			bytes += skb->len;
> +		}
> +
>  		macb_tx_unmap(&bp->info, tx_skb, 0);
>  	}
>  

[Severity: High]
The commit message describes the problem in general terms: "The frames
dropped on a TX error are never returned to BQL." Does
macb_hresp_error_task() leak in the same way?

macb_interrupt_misc() queues it as BH work when the hardware reports
HRESP:

macb_interrupt_misc() {
    ...
	if (status & MACB_BIT(HRESP)) {
		queue_work(system_bh_wq, &bp->hresp_err_bh_work);
    ...
}

It then resets the TX rings and restarts the queues. It never calls
netdev_tx_completed_queue() or netdev_tx_reset_queue():

macb_hresp_error_task() {
    ...
	netif_tx_stop_all_queues(netdev);
	netif_carrier_off(netdev);

	bp->macbgem_ops.mog_init_rings(ctx);

	/* Initialize TX and RX buffers */
	macb_init_buffers(bp);
    ...
	netif_carrier_on(netdev);
	netif_tx_start_all_queues(netdev);
}

gem_init_rings() and macb_init_rings() mark every TX descriptor TX_USED
and set txq->head = txq->tail = 0. Every frame between tail and head was
already charged in macb_start_xmit():

	netdev_tx_sent_queue(netdev_get_tx_queue(bp->netdev, q),
			     skb->len);

So DQL would count those bytes as in flight forever. After enough HRESP
events, the queue would stay stopped with an empty ring. Only
macb_close() would recover it, through netdev_tx_reset_queue().

This commit carries the same Fixes: tag as the BQL introduction, and that
commit missed both paths. Could the HRESP ring reset path be covered here
too, or in a companion patch, so that backports get both fixes?

On a side note, this HRESP path also seems to reset head and tail
without unmapping the DMA buffers or freeing the tx_skb->skb entries. Are
those skbs and DMA mappings leaked as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107-nb-macb-tx-error-task-net-v1-0-a2aac5d64d52%40tipi-net.de
