Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E233A0E99;
	Tue, 13 Oct 2026 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900820; cv=none; b=losf3I3peD3CYBij8mz8LtNZQJpS6XqyPfwd6PrvQp3wAjliyhJ1gqL2XMmJbkcCUwa3FP863bJeZd64linc06/GU9zfMT/vOuGi7wieUDZ+bLGSgPgwXCD2GMQ9BK5oSYRx5at/26IfZOnWLjAW4ATqdMOj4gFMxKByMqoBufU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900820; c=relaxed/simple;
	bh=v4mdWSRQmdouN3FvCm74IoF/lSogCcUszFtOYKuRE2g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=KJloSzr0DiJQlhWYwDWE/DKdfmIWvEPS7Kt8nKvRPcpEo3yf+GyHet0yRxDelo3WUOEDxUFEJlJa2O9Krcbz1qkIBMdXAj04d960MpKJs67SDRonSnA8GNmvCd06AWmR38W2Z+tzzoUSOKFKl4eBYaSU/rB/VY1b+TvkInFbHKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LepIpYqi; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LepIpYqi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C8C634E41209;
	Tue, 13 Oct 2026 14:13:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8F4E360362;
	Tue, 13 Oct 2026 14:13:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D4E5D11D7168B;
	Tue, 13 Oct 2026 16:13:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791900813; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=awNliGQwJKixK8txiY10MDkuXxZh6hJ4eG3VtAOAvEg=;
	b=LepIpYqiALC3oiAUHqCSQNbwP1qvBgpX1g/XrL851PdPpZ+2RNChvm/ATk/Gyv0rgOy7Xl
	mOOlrcrLojn+rBK3+yBmM/DjpcDGpSPkJ6EZbxT1z2dbkGMSvi7ZTubSsUAA7QNl5RkY1x
	BdwzyzY0Zefx4li4FJ/V7nm5Jbicz6bGUUV762KzhA0TLPKEkpHHRMgFow0FDT6OZadxCQ
	47THhrNTUndIk4V0Y5EI0JSeKNmgKGtYQh/+2p0dhDrUDKxS6g0bYtoZSB8dL9OuVXRsZ6
	UAzO0EtMgaFh9+NkdvPEhKXalslq/GGtUAxxJR0RjMOqSEtZC6T4BD+mk/PYrg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 16:13:28 +0200
Message-Id: <DM3RTNBIVWWY.TCIDB638Z1FP@bootlin.com>
Subject: Re: [PATCH net-next v10 7/8] net: macb: use context swapping in
 .set_ringparam()
Cc: <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <richardcochran@gmail.com>, <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <pvalerio@redhat.com>, <nb@tipi-net.de>,
 <vladimir.kondratiev@mobileye.com>, <gregory.clement@bootlin.com>,
 <benoit.monin@bootlin.com>, <tawfik.bayouk@mobileye.com>,
 <thomas.petazzoni@bootlin.com>
To: <netdev-bot+sashiko@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261001-macb-context-v10-7-beb541bbb7df@bootlin.com>
 <179115680572.434549.1016291990685937691@kernel.org>
In-Reply-To: <179115680572.434549.1016291990685937691@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello netdev-bot+sashiko,

On Mon Oct 5, 2026 at 1:33 AM CEST,  wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] Use-after-free in the new live context swap.
>
> --
>
> net: macb: use context swapping in .set_ringparam()
>
> This patch reworks macb_set_ringparam(). It now allocates a new context
> before stopping the interface, swaps it in and then frees the old one,
> instead of doing a full close/open. The generic swap logic is split into
> macb_context_swap_start() and macb_context_swap_end(), and a new
> mac_cfg_lock mutex serialises the swap against the phylink MAC callbacks.
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index 69873966a9890..93049b399d783 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>
> [ ... ]
>
>> @@ -3217,6 +3255,112 @@ static void macb_configure_dma(struct macb *bp)
>>  	}
>>  }
>> =20
>> +static void macb_context_swap_start(struct macb *bp)
>> +{
>> +	struct macb_queue *queue;
>> +	unsigned long flags;
>> +	unsigned int q;
>> +	u32 ctrl;
>> +
>> +	mutex_lock(&bp->mac_cfg_lock);
>> +
>> +	macb_quiesce_start(bp);
>
> [ ... ]
>
>> +static void macb_context_swap_end(struct macb *bp,
>> +				  struct macb_context *new_ctx)
>> +{
>
> [ ... ]
>
>> +	old_ctx =3D bp->ctx;
>> +	WRITE_ONCE(bp->ctx, new_ctx);
>> +	wmb(); /* ensure IRQ enabled below read the new context */
>> +	macb_init_buffers(bp);
>
> [ ... ]
>
>> +	mutex_unlock(&bp->mac_cfg_lock);
>> +
>> +	/* Free old context. */
>> +
>> +	macb_free(old_ctx);
>> +	kfree(old_ctx);
>> +}
>
> [Severity: High]
> Can a NAPI poll still be reading old_ctx when it gets freed here?
>
> The swap depends on macb_quiesce_start() calling napi_disable() to drain
> NAPI. However, napi_disable() only waits for NAPIF_STATE_SCHED and
> NAPIF_STATE_NPSVC to clear, and napi_complete_done() clears SCHED before
> the poll callback returns. Documentation/networking/napi.rst notes that
> napi_disable() only waits for the ownership of the instance to be
> released, not for the poll method to exit.
>
> Both poll functions keep reading the context after napi_complete_done()
> succeeds. In macb_rx_poll():
>
> 	if (work_done < budget && napi_complete_done(napi, work_done)) {
> 		queue_writel(queue, IER, bp->rx_intr_mask);
> 		...
> 		if (macb_rx_pending(queue)) {
>
> and macb_rx_pending() does:
>
> 	struct macb_context *ctx =3D queue->bp->ctx;
> 	struct macb_rxq *rxq =3D macb_rxq(queue);
> 	...
> 	entry =3D macb_rx_ring_wrap(ctx, rxq->tail);
> 	desc =3D macb_rx_desc(ctx, q, entry);
> 	...
> 	return (desc->addr & MACB_BIT(RX_USED)) !=3D 0;
>
> macb_tx_poll() does the same through macb_tx_complete_pending(). That
> function reads queue->bp->ctx and the TX ring under tx_ptr_lock. The swap
> and free path takes neither tx_ptr_lock nor any other lock or RCU grace
> period that these helpers respect.
>
> This looks like a possible interleaving:
>
> poll CPU
> macb_rx_poll()
>   napi_complete_done()   /* clears SCHED */
>   macb_rx_pending()
>     ctx =3D queue->bp->ctx;   /* old ctx */
>     <delayed>
>
> ethtool CPU
> macb_set_ringparam()
>   macb_context_swap_start()
>     macb_quiesce_start()
>       napi_disable()   /* returns, SCHED already clear */
>   macb_context_swap_end()
>     WRITE_ONCE(bp->ctx, new_ctx);
>     ...
>     macb_free(old_ctx);   /* rings NULLed and dma_free_coherent()ed */
>     kfree(old_ctx);
>
> poll CPU
>     desc =3D macb_rx_desc(ctx, q, entry);   /* freed memory */
>
> Here the poll CPU would dereference the kfree()d context, a NULL ring
> pointer, or freed coherent DMA memory. The delay could come from threaded
> NAPI, softirq preemption on PREEMPT_RT, interrupts or vCPU preemption.
> This can be triggered with ethtool -G while traffic is flowing.
>
> The new irq_quiesced check in macb_tx_restart() does not seem to cover
> this. That helper runs before napi_complete_done() and is already
> protected by NAPI ownership.
>
> macb_close() uses the same napi_disable-then-free pattern. This patch add=
s
> a new free-while-running site that is reachable during normal operation.
> The later patch "net: macb: use context swapping in .ndo_change_mtu()"
> reuses these helpers without adding any extra synchronization.
>
> Would a synchronize_net() (or an equivalent grace period) before
> macb_free(old_ctx) be enough to close this window? Alternatively, the
> post-completion helpers could be made to check for an ongoing swap.

Technically this is possible. To get it in practice, you would have to
 - have no phylink attached
 - be running a PREEMPT_RT kernel would help a lot
 - be unlucky

I'm fixing it with the recommended synchronize_net(), after having
checked that we are not the first ones. A few commits do justify the
same bug for using synchronize_net().

Looked through the results from

   =E2=9F=A9 git log -S synchronize_net net-next/main drivers/net/ethernet/

For example, here is the simplest precedent I could find:

commit eb41a264a3a576dc040ee37c3d9d6b7e2d9be968
Author: Carolina Jubran <cjubran@nvidia.com>
Date:   Thu Jul 10 16:53:43 2025 +0300

    net/mlx5e: Fix race between DIM disable and net_dim()

    There's a race between disabling DIM and NAPI callbacks using the dim
    pointer on the RQ or SQ.

    If NAPI checks the DIM state bit and sees it still set, it assumes
    `rq->dim` or `sq->dim` is valid. But if DIM gets disabled right after
    that check, the pointer might already be set to NULL, leading to a NULL
    pointer dereference in net_dim().

    Fix this by calling `synchronize_net()` before freeing the DIM context.
    This ensures all in-progress NAPI callbacks are finished before the
    pointer is cleared.

    Kernel log:

    BUG: kernel NULL pointer dereference, address: 0000000000000000
    [...]

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c b/drivers/net=
/ethernet/mellanox/mlx5/core/en_dim.c
index 298bb74ec5e9..d1d629697e28 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
@@ -113,7 +113,7 @@ int mlx5e_dim_rx_change(struct mlx5e_rq *rq, bool enabl=
e)
      __set_bit(MLX5E_RQ_STATE_DIM, &rq->state);
   } else {
      __clear_bit(MLX5E_RQ_STATE_DIM, &rq->state);
-
+     synchronize_net();
      mlx5e_dim_disable(rq->dim);
      rq->dim =3D NULL;
   }
@@ -140,7 +140,7 @@ int mlx5e_dim_tx_change(struct mlx5e_txqsq *sq, bool en=
able)
      __set_bit(MLX5E_SQ_STATE_DIM, &sq->state);
   } else {
      __clear_bit(MLX5E_SQ_STATE_DIM, &sq->state);
-
+     synchronize_net();
      mlx5e_dim_disable(sq->dim);
      sq->dim =3D NULL;
   }

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

