Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF76EEC3;
	Sun, 18 Oct 2026 00:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792283671; cv=none; b=RDhtFFDLmLbpesPo3vMsZq34mGCNIkIxWl4iqQH/2lIC1NAY+YYMOC9JgzV7BO0NDM6uUj5RhnEg6/YvFaAXYGKCAGPDvnbC/mO+V3EqHpoCGxUreouqviGSb9NVp9a8vbsuJsk7hwc+JkFjcqLUDYAr9/dqASBdYfozM9btWfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792283671; c=relaxed/simple;
	bh=UYPpbP4nFK6ceslGDzIqrAT8MFcO7eO3JD0xuvgBleI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vt3bPECJfYxMGCHwFw6mv+nTppoiDn5d1MLHby/qXY7vStFhr/y6DujHiN3wJj/4dBTQZLZIjd1mvV9Ave8e7IB2VbqQbcUoydkD53Q/IB9J+9vu9tF0Ppy3RLznxQ396pi7bp5D0rfwzhi+yDZjGPH/bapAeRlzwIdnA/fceck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecd/pnKc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecd/pnKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1620C1F000C4;
	Sun, 18 Oct 2026 00:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792283669;
	bh=bX9gSNnUKh5XRvA9DSlfPu+q4h3qCfDbS72aOLJfGFI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ecd/pnKczMRBCfFbTkJNAJyB2Ra9GuTFlhq+YLC3EY69CegYrx//Ol6lOfY1oFAdA
	 mIxnOeVoXNvM7HPqozYoAwmnYZAkSMHv7RjDO+gqoGpweINsPR27aWTFWeawnWqd0n
	 rvQ6K5ROqyi+zF8Fxde/ODN7CLG32m3LwLtWHJ3OwSqhS0Esv2Y0QzXeiNPEIf4lWk
	 c7cW4A7X0p5p7/+KF6cLJ5mRIldBfvL1/f+64880uY05i0L88amhZmwp786v25ga9A
	 rjI93tm7KXpQK/epxlTDCylRA7V4ZacEXyOJUmN3ijzoX+5MtJjsrYSu+P+GhHP5dB
	 ixcKMoBgAHc0w==
Subject: Re: [PATCH net] net: bgmac: don't process RX with a zero NAPI budget
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sun, 18 Oct 2026 00:34:28 +0000
Message-ID: <179228366859.3135.9158616222630607774@kernel.org>
In-Reply-To: <20261014001912.141532-1-rosenp@gmail.com>
References: <20261014001912.141532-1-rosenp@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In drivers/net/ethernet/broadcom/bgmac.c, bgmac_poll() still
  acknowledges every interrupt source, including BGMAC_IS_RX, with…

--

net: bgmac: don't process RX with a zero NAPI budget

When bgmac_poll() is called with a zero budget, this patch makes it
return right after TX completion cleanup. The goal is to stop netpoll
from processing an RX frame and tripping the "exceeded budget in poll"
WARN_ONCE() in poll_one_napi().

> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index 3e9c57196a397..a545c0cc25977 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -1154,6 +1154,11 @@ static int bgmac_poll(struct napi_struct *napi, int weight)
>  	bgmac_write(bgmac, BGMAC_INT_STATUS, ~0);
>  
>  	bgmac_dma_tx_free(bgmac, &bgmac->tx_ring[0]);
> +
> +	/* A zero budget (netpoll) means only TX may be cleaned */
> +	if (unlikely(!weight))
> +		return 0;

[Severity: Medium]
Can this leave received frames stuck in the RX ring?

Before it reaches the new zero budget return, bgmac_poll() still clears
every interrupt status bit, including BGMAC_IS_RX, with a write-1-clear:

    bgmac_write(bgmac, BGMAC_INT_STATUS, ~0);

The commit message says:

    NAPI stays scheduled, so the pending RX frames are picked up by the
    next regular poll.

Is that guaranteed?

poll_napi() calls poll_one_napi() for every NAPI on dev->napi_list
whose poll_owner it can take. poll_one_napi() then calls
napi->poll(napi, 0) without checking NAPI_STATE_SCHED.

bgmac_netdev_ops has no ndo_poll_controller, so bgmac_interrupt() is not
run first. As a result, bgmac_poll(napi, 0) can run while the NAPI is
idle and chip interrupts are on.

Suppose a frame arrives while netpoll is transmitting. One example is
__netpoll_send_skb() running with IRQs disabled while the TX queue is
stopped. The sequence would be:

netpoll_poll_dev()->poll_napi()->poll_one_napi()->bgmac_poll(napi, 0)
    bgmac_write(bgmac, BGMAC_INT_STATUS, ~0);   /* clears BGMAC_IS_RX */
    bgmac_dma_tx_free(bgmac, &bgmac->tx_ring[0]);
    return 0;                                   /* NAPI not scheduled */

After that, bgmac_interrupt() finds nothing pending:

    u32 int_status = bgmac_read(bgmac, BGMAC_INT_STATUS);
    int_status &= bgmac->int_mask;

    if (!int_status)
        return IRQ_NONE;

bgmac_interrupt() is the only caller of napi_schedule() here. Frames
already in the RX ring would sit there until another frame raises
BGMAC_IS_RX. On a quiet link, for example after a single ARP or ping
reply, that wait has no upper bound.

The unconditional ack existed before this patch. However, one RX slot
used to be processed in this window, and now none are.

Would it work to ack only BGMAC_IS_TX0 when the budget is 0? That would
leave BGMAC_IS_RX set, so the interrupt handler still schedules NAPI.

The new comment says "only TX may be cleaned". The NAPI documentation
says a zero budget means processing "only skb Tx completions and no Rx".
This path still consumes RX interrupt state, which doesn't match either
statement.

> +
>  	handled += bgmac_dma_rx_read(bgmac, &bgmac->rx_ring[0], weight);
>  
>  	/* Poll again if more events arrived in the meantime */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014001912.141532-1-rosenp%40gmail.com
