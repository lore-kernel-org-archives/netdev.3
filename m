Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6AB3CF04C;
	Fri, 24 Jul 2026 23:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935178; cv=none; b=OYSCI9t4tcUYYr3oWwbVHwa+dCa6sm2ZIRc/dotD5evVlhMlYXTy/08doVSZ1xzs6w7FI9KC0iXNdNy5cHLAoZJhXeIWMIUt5rJ001Czm3HlGla043loUarHW5LK41WTkR7+MXMOntYgA3fq17dnBYnxFpJtvYKhyorT8cjHa5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935178; c=relaxed/simple;
	bh=byP6E+C5yret6uvlxqO7JBBS5JecCfLId98rSGC9/zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuOmJ0N9E9T80KG3SN1TAWBI9jmWEEQUsCDTt/OCnCCiJe7qzdJz0OINzLgl0PWclyyichGXCixjgXpgDCJbfK8m/pO3Npyf4xKWEfJsY5Gb554hjVPBMfSshd4iV0hc4X4n1s/NEg6LvNxCmNhIZGq5cLll+M4t+zgOgWLmI2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY3h89lr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY3h89lr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49CC1F000E9;
	Fri, 24 Jul 2026 23:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784935177;
	bh=vHVjXxHM8OPpRQcJ6J4a9vv/vh5T/8GIkntcPnBWkaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SY3h89lrKeVGWjf5hIUFpdHqr2iVyetefj6WGpdfXci1amdfSB6jzaI9UHEfXU0a5
	 95zvQ8X92q0sIR1HLG06sK3pQ0VMMKewVXKYyQn8t9zd71G2r+40WrS9v9thW5Hrtr
	 OJG50NYI/B7Uhtd4Ukuz0dSSYbtyAcs6f7qoGo+8OUHOboQlelpxS1F5uuX/W+qken
	 CpPgTn2WYEMUu5VEPcRXNGi27Nryc+dpyZhF9wUFD3pfetfzFe0hFi51J+gTZJu8fR
	 cIXalZCiEKVkCP1wEX65Bv/eQEnYUUHqdJW50KcWLgGFA1rf9HUTg227DKkR92Gv8T
	 diUbbjDniRlOA==
From: Jakub Kicinski <kuba@kernel.org>
To: kusuma.vasana@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	radhey.shyam.pandey@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	michal.simek@amd.com,
	Kusuma.Vasana@amd.com,
	git@amd.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next V2] net: axienet: Clear stale AXI DMA TX/RX status before re-enabling interrupts
Date: Fri, 24 Jul 2026 16:19:34 -0700
Message-ID: <20260724231934.1679801-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716124841.2761722-1-kusuma.vasana@amd.com>
References: <20260716124841.2761722-1-kusuma.vasana@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: axienet: Clear stale AXI DMA TX/RX status before re-enabling interrupts

This patch clears the AXI DMA IOC/DELAY status bits at the end of the TX
and RX NAPI poll handlers to avoid a redundant stale interrupt caused by
IOC/DELAY bits latched into the status register while interrupts were
masked in the control register during NAPI. The clear is performed
unconditionally, before the napi_complete_done() / CR re-enable step.

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index fcf517069d16..29050c8d04e2 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1018,6 +1018,13 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
>  			netif_wake_queue(ndev);
>  	}
>  
> +	/* Clear stale IOC/DELAY bits that may have latched during the
> +	 * poll window to prevent a stale interrupt when there is no
> +	 * work pending.
> +	 */
> +	axienet_dma_out32(lp, XAXIDMA_TX_SR_OFFSET,
> +			  XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
> +
>  	if (packets < budget && napi_complete_done(napi, packets)) {
>  		/* Re-enable TX completion interrupts. This should
>  		 * cause an immediate interrupt if any TX packets are

[High]
Can this sequence race with a late completion arriving after the poll
loop has exited but before the SR write?

The AXI DMA engine writes cur_p->status and latches SR.IOC asynchronously
from CPU execution. The poll loop's exit condition reads cur_p->status,
and between that read and the unconditional SR IOC/DELAY clear that this
hunk adds, the hardware can set COMPLETE_MASK on the next BD and latch
SR.IOC for it. That legitimate notification would then be wiped by the
new W1C write.

Since napi_schedule() is only called from the ISR, and the ISR only fires
when the IRQ line asserts, napi_complete_done() will succeed here even
though a new completion has appeared. The subsequent CR re-enable would
then observe SR.IOC=0, so the level-sensitive line does not re-assert,
and the completed BD is stranded until the next unrelated completion or
DELAY-timer expiry moves things forward.

Before this patch, any SR bit latched during the poll window (whether
stale or from a late completion) re-asserted the IRQ line after CR
re-enable, which the changelog frames purely as an unnecessary stale
interrupt:

    After NAPI completion, re-enabling interrupts immediately
    re-asserts the IRQ line due to these stale status register bits,
    even when no new work is pending.

Did that same behavior also serve as the recovery path for a completion
that lands in the SR-clear/CR-reenable window? If so, would it be worth
either re-checking cur_p->status after the SR clear and skipping
napi_complete_done() when new work has appeared, or performing the CR
re-enable before the SR clear so a late latch still asserts the line?

NAPIF_STATE_MISSED does not appear to help here because it requires a
napi_schedule() call, which only the ISR performs.

For configurations where axienet_calc_cr() does arm the DELAY timer
(coalesce count > 1), the stranded BD is recovered when DELAY expires:

    /* Only set interrupt delay timer if not generating an interrupt on
     * every packet
     */

Under DIM with low traffic the coalesce count can settle at 1, in which
case DELAY is not armed and there is no bounded recovery for the last
BD of a burst until another packet arrives. Is that concern valid, or is
there another mechanism that ensures the last BD is drained?

> @@ -1293,6 +1300,13 @@ static int axienet_rx_poll(struct napi_struct *napi, int budget)
>  		cur_p = &lp->rx_bd_v[lp->rx_bd_ci];
>  	}
>  
> +	/* Clear stale IOC/DELAY bits that may have latched during the
> +	 * poll window to prevent a stale interrupt when there is no
> +	 * work pending.
> +	 */
> +	axienet_dma_out32(lp, XAXIDMA_RX_SR_OFFSET,
> +			  XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
> +

The same question applies to the RX path: a completion arriving after
the while loop's cur_p->status check but before this SR write would have
its SR.IOC latch cleared, and the subsequent CR re-enable would then not
re-assert the line. Is there a reason the RX path is not exposed to the
same race?
-- 
pw-bot: cr
