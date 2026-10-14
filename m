Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA953EC684;
	Wed, 14 Oct 2026 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004243; cv=none; b=ly5CgGj6YcwxnRBZJ0DlMFJ8sKiQlRvCx6Z435qt9PTok0VZN86gIB1OZwQzIOpYyTrF31RW43wlV7yisuxejVSkZirwLF1wqYtMsRMtLllpAqpn1S6aqmILz/BnnnFK3oyFQS7chhJBxOZb/XgxzZAzQoZNIhgQZFJdHjlawYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004243; c=relaxed/simple;
	bh=WmNcsA5G711yUOhv3vRumoM3sNXabGcZCFbLELV1ebE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvYcDGVFE7UEru9vZvBy+piWNEOpjU8BPyTS0JNCpn2+2VhnEvylZMziLxb2nxtAG9NC07J4RHWLj1IkGGejJTwKnYrc8FUyYpwkKoV09NtMioNRRvifSSy8WLG4G1k58TRCxGNSb9D/0sq4HM297ahfkxTHulPTEguwpcrPf6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4F521D7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4F521D7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314031F000C4;
	Wed, 14 Oct 2026 18:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792004241;
	bh=CvWOaTUlMXOEn3tnxgA4QdZqJ3etpFx5xwMvPC1gXq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G4F521D7LiiIZZCqQVxHOB/nZBiu4tBxIrJQIPczjUHE+9a4ljcAa5OTOC19AOt/M
	 rGoKmaMxA+wiyvhsWOZZEmMlyGxP3Fht7DONoGYHa8rKGnJNPOBU7hqGwasqMppiDD
	 lj4CXohfxWrglWa+txVDNBw+bPCOdgEhQTckY2zfH0ZHgR0L/WNgTXn5Zeh/5QgqxV
	 NQTLBjMv2/0kf0itpRvtcPZcdOJMQYdLblZtfduOYIvb2NT7t0hKKaPc4AedK6EZLm
	 sCYsf901oGif3DjXDGjJHt6feyuSnqKqJoGw1fNebhvxz0Rnprqy5WN4zEg1AFqjcX
	 mLR9Es3GE/qkw==
Date: Wed, 14 Oct 2026 19:57:16 +0100
From: Simon Horman <horms@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: netdev@vger.kernel.org, radhey.shyam.pandey@amd.com,
	michal.simek@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	daniel@iogearbox.net, jacob.e.keller@intel.com, joe@dama.to,
	suraj.gupta2@amd.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: axienet: free outstanding TX buffers in
 axienet_dma_bd_release()
Message-ID: <20261014185716.GD83879@horms.kernel.org>
References: <20261004083759.1016519-1-maimon.sagi@gmail.com>
 <20261007034620.1360542-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007034620.1360542-1-maimon.sagi@gmail.com>

On Wed, Oct 07, 2026 at 06:46:20AM +0300, Sagi Maimon wrote:
> axienet_dma_bd_release() walks the RX ring to unmap and free every
> receive buffer before releasing it, but frees the TX descriptor ring
> with dma_free_coherent() alone.  Any descriptor that
> axienet_free_tx_chain() had not yet reclaimed still holds its skb and
> its streaming DMA mapping, and both are lost.
> 
> axienet_stop() disables TX NAPI and stops the DMA engine before calling
> it, so nothing reclaims those descriptors afterwards.  Bringing the
> interface down while frames are in flight therefore leaks up to
> lp->tx_bd_num skbs and mappings each time.
> 
> axienet_dma_err_handler() already walks the TX ring this way before it
> restarts the DMA engine: it unmaps every descriptor whose cntrl is still
> set - axienet_free_tx_chain() clears it on reclaim - frees any skb still
> attached, and clears the descriptor.  Move that loop into a helper,
> axienet_free_tx_bufs(), and call it from axienet_dma_bd_release() too.
> This relies on axienet_stop() having stopped the DMA engine first, as
> the RX walk in the same function already does.  The helper frees the
> skbs with dev_kfree_skb_any(), as drops: in the error handler, which
> runs from a workqueue, that frees them directly rather than deferring
> them to softirq as dev_kfree_skb_irq() did.
> 
> The walk must not run on a ring that is not there.  axienet_open() does
> not check the result of the reset that runs axienet_dma_bd_init(), so
> when that reset fails tx_bd_v is either still NULL or, after an earlier
> close, points at the ring that close freed.  Clear tx_bd_v and rx_bd_v
> once their rings are freed, and skip the walk when tx_bd_v is NULL.
> That also ends the second dma_free_coherent() of a stale ring which the
> same path already did.  On the axienet_dma_bd_init() error path the TX
> ring has just been allocated zeroed, so the walk does nothing.
> 
> This was reported by the Sashiko AI review bot.
> 
> Tested on the AXI Ethernet MAC of an ADVA TimeCard X2 (PCIe card, with
> the built-in AXI DMA): traffic passes, and after each of ten down/up
> cycles and five module reloads, all made with traffic running and each
> running axienet_dma_bd_release(), traffic resumes and nothing is logged.
> The leak itself was not measured, and neither the failed-reset paths nor
> axienet_dma_err_handler() were exercised.
> 
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> Reviewed-by: Joe Damato <joe@dama.to>
> Assisted-by: LLM sparse
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

In future please post new patch revisions as new email threads,
not as a reply to an earlier revision.

Thanks!

