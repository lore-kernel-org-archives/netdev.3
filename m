Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189282;
	b=HOH4Owh0HZfBd7gJWWcoqnm7HSy/stJFerhk/DZOnZWALZHeyV18ThPuYyEkqQYD8oEV
	 5QGb+Y6Zc9qPvfb6lzibqy7lafv2z5OmpcswUjxC+n2bDagavcE6GM4CUEHvx4RO8wcGX
	 J63BDd6DfajOXv0thzqasycG8nOxDySEIvaDhxitr0YQBZWmb7VsoSUZ0V/193/1l3s9u
	 EtubXOydvy9F3084gKSZGcL0Rbv2mz47FA5nLbWnpIS9xpy7XpCdEXfbOOdxsJXc+Y3jp
	 nY5Yhotg3xyGN+sOctr+7SNKUDR/9hFW4XTVM/oSDuB+jH5nx3KwFTAj5oIh+efPT0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189282;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=i6e9dyTu3EyPnfq4IJG0Z3eas29bFD8O0rKrA8tROtk=;
	b=p9y7LKkyTE+JO6YPydBMRTgo8OA1RlXSTKN04kAzRHC9hJku7a8B6MV7EI9xr6R6aX51
	 gqS1FjdRHn+CbdvArOWV28an5KY/LpMF3MAbv4mnU2mbvOm7osy71gEjG61Ce60pJF+Kd
	 oOuvGFDysZ+SjW85K6D3q7iNZYYVpqGRff1zJ6fU7Jo5jaGCkvO18nknh1GSU1Kr2E/l0
	 r1BvUuXwoIT5X/yG14ekVDwiJuLtJy5hrEerUGAWR/ny7XsoH2wBynC4xHuT/qnXzVLGx
	 xlI2a5qGXAuzGrU6LxiUL1www9oxKgETDcACupLVT17hNwgbHd4cBkJAAiBWC7o78bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CNMMsCBC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DA2606A322;
	Mon,  9 Nov 2026 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CNMMsCBC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15391F0089F;
	Mon,  9 Nov 2026 01:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794189281;
	bh=i6e9dyTu3EyPnfq4IJG0Z3eas29bFD8O0rKrA8tROtk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CNMMsCBCkhFqrX25Vkd4yuASiT/teP4r5pU+fWqc8y57yYRT/8Te/ziZC6PMYSVY3
	 9DcOiK1QKJgi2XWrBIadl6KoUhKQ26cB4F7fD9tK3s2AnNsfA0RnyCCzg0hsIve1rm
	 gqIUimZH0jGgUMUbxoXcbgkKyYnLjGexYUJa522eNY7PteFKFhCRltNaIfcwjIdT+I
	 Oe6YxpBLWKGwfH4eNgiZnBvIWxshrhk7MAzUJX9GZ2a59vh8a1wrYRqz5u826XbW4A
	 QHNIQs71258j+Zxpo9SzuabMD9bilJooNDUesvnZ7c7b+qYTqcnHuULza+5az0XaJQ
	 HXnWJ6bQ2qzLQ==
Subject: Re: [PATCH net v2] net: ethernet: adi: adin1110: mask the RX IRQ of
 the port being stopped
From: netdev-bot+sashiko@kernel.org
To: wuyuehong@cmss.chinamobile.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
 edumazet@kernel.org, pabeni@redhat.com, nichen@iscas.ac.cn,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 01:54:40 +0000
Message-ID: <179418928039.994134.15007957865161430391@kernel.org>
In-Reply-To: <20261104-adin1110-net-stop-v2-1-yuehongwu@cmss.chinamobile.com>
References: <20261104-adin1110-net-stop-v2-1-yuehongwu@cmss.chinamobile.com>
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

- [High] On ADIN2111, the patch's fix in adin1110_net_stop() stops
  working as soon as the other port is opened.

--

net: ethernet: adi: adin1110: mask the RX IRQ of the port being stopped

This commit swaps the RX-ready mask bits in adin1110_net_stop(), so the
port being stopped now masks its own RX interrupt. This matches the
mapping in adin1110_port_rx_ready(). The goal is to keep a stopped port
from re-raising its level-triggered interrupt when nothing drains its
FIFO.

> diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
> index 53fac3dc8be62..abdc16089c9e3 100644
> --- a/drivers/net/ethernet/adi/adin1110.c
> +++ b/drivers/net/ethernet/adi/adin1110.c
> @@ -945,7 +945,7 @@ static int adin1110_net_stop(struct net_device *net_dev)
>  	u32 mask;
>  	int ret;
>  
> -	mask = !port_priv->nr ? ADIN2111_RX_RDY_IRQ : ADIN1110_RX_RDY_IRQ;
> +	mask = !port_priv->nr ? ADIN1110_RX_RDY_IRQ : ADIN2111_RX_RDY_IRQ;
>  
>  	/* Disable RX RDY IRQs */
>  	mutex_lock(&priv->lock);

[Severity: High]
On ADIN2111, does this mask still hold once the peer port is opened?

adin1110_net_open() does not check which port is opening. It rewrites
the whole IMASK1 register and clears the RX_RDY mask bits of both ports:

drivers/net/ethernet/adi/adin1110.c:adin1110_net_open() {
    ...
	val = ADIN1110_TX_RDY_IRQ | ADIN1110_RX_RDY_IRQ | ADIN1110_SPI_ERR_IRQ;
	if (priv->cfg->id == ADIN2111_MAC)
		val |= ADIN2111_RX_RDY_IRQ;

	priv->irq_mask = val;
	ret = adin1110_write_reg(priv, ADIN1110_IMASK1, ~val);
    ...
}

Take this sequence:

  ip link set eth1 down  -> adin1110_net_stop() sets ADIN2111_RX_RDY_IRQ
  ip link set eth0 down
  ip link set eth0 up    -> adin1110_net_open() clears it again

After the last step, port 1's RX_RDY interrupt is unmasked while eth1 is
still down.

eth1's RX FIFO may still hold frames at that point. Frames can arrive
after the IMASK1 write but before phy_stop() in adin1110_net_stop(), and
frames can also be left over when the ADIN1110_MAX_FRAMES_READ budget
runs out. The handler skips them:

adin1110_irq()
    adin1110_port_rx_ready(priv->ports[1], status1)
        if (!netif_oper_up(port_priv->netdev))
            return false;
    adin1110_write_reg(priv, ADIN1110_STATUS1, priv->irq_mask);
    -> IRQ_HANDLED

The IRQ is requested with IRQF_TRIGGER_LOW | IRQF_ONESHOT. Wouldn't the
threaded handler then run again and again until eth1 is brought back
up? This assumes RX_RDY stays asserted while the FIFO is not empty. The
commit message relies on the same assumption.

This looks like the same "stopped port also keeps re-raising its
interrupt with nobody draining the FIFO" case the commit message
describes. The only difference is that the peer port's ndo_open
triggers it.

Should adin1110_net_open() also change so that it unmasks only the
opening port's RX_RDY bit, plus the shared TX_RDY and SPI_ERR bits? And
should priv->irq_mask include only ports that are up?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-adin1110-net-stop-v2-1-yuehongwu%40cmss.chinamobile.com
