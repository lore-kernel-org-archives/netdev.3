Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062054;
	b=NaHBtfp1CWAxl7LXU+ewAit0JIv0smpJvSshruTklqyvtRDSkXZWxdlg7AgGx27LObXf
	 iSrfOANgiSf13tTxcsGgasZFrzNddOxjLbuVUrsM65y+kapDG0gJt8pyG+Uy9bgK1eqcJ
	 XN8uI/HP850uo0KNuHiciS4HPqbc8Uy3rPoqa3gPttvPBo4GI7Wi5Sfnm4NFUaLsBQLSB
	 CBPKR9BFdGgW0Pso0HtwrxbXIShUm89S37KeQl+0nqLcXLIozoogFKx0x/4B6YKsBS6w9
	 QQMqtr/JouWmCr9DcaXp9xBzUXSA81iWSbeD+Oug2+70IdtY+PaSxkTufA5G49/+fHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062054;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ooMpLLI6XN4Ow1z0b2jGvivbcReoXWTuSem8zxU6oD0=;
	b=TNAOTc95wMzBYg9Ubu/od5fjxkYK+v5LZ3LAvY+IxUnAhy8fxXlJc5Wnf5M30lt90rwX
	 U4kYUjeAJJ66Zcmm1ZNJxei0kayrDQstAKXga0fqoetElTXNzhP9fNfN9Rx+HYf3O69AK
	 Yvgv8pffGcQEK8fbzL+KmAfgxlWyemYiDObTwODBpOVyrReiSFBguuvo7iNrx6ifi+AaZ
	 JJE/d2pOTDNsInJj0I48AZrRWNEJQZXhrJ7ewob7ureYGzOSmEH8Otu7Sfnnjd5DYcWza
	 BnI7bI3yzTSZ20VburEKDNlWq+Id+n54R7pkQEdIDF6haUPNmZ3XU81g9zbRAOs+0Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cBLCHJ8q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBB0606A335;
	Sat,  7 Nov 2026 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cBLCHJ8q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1BA1F008A1;
	Sat,  7 Nov 2026 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794062054;
	bh=ooMpLLI6XN4Ow1z0b2jGvivbcReoXWTuSem8zxU6oD0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cBLCHJ8q/lpUaXnrNwsHxFX5FpDkt/5Lb3TEPDV/bH18woT78r0BxKk+jugamxQ7z
	 S5vO0JgjGbw9fCwEcm+MteQuky+8aZa66QBw5vxr4FyeAMb5IQsKBFXCuSBN6cd6Ix
	 W7WMiSvR04lpFzLzxapJ3d2aNo/NC5d7GqW3qiDnVDhkNuPb8XFUuc1jeWoqAXqIvW
	 utvXq11cigJsD05hnFzff0vnFXuJEV/Gsp5QicsKI0uTgv3KXXVzK9JTLnsnDSZxa5
	 i7RaYsm06wIWtMuaTJNjgRjRQRdVNjJsgObHNPQ6FGTr/lQKjRFSlnLuYBNxWg9i4k
	 W7g0Bzc81pJKw==
Subject: Re: [PATCH net] net: ethernet: adi: adin1110: mask the RX IRQ of the
 port being stopped
From: netdev-bot+sashiko@kernel.org
To: wuyuehong@cmss.chinamobile.com
Cc: netdev@vger.kernel.org, alexandru.tachici@analog.com,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Sat, 07 Nov 2026 14:34:13 +0000
Message-ID: <179406205322.994134.9029665354316624384@kernel.org>
In-Reply-To: <20261103-adin1110-net-stop-1-yuehongwu@cmss.chinamobile.com>
References: <20261103-adin1110-net-stop-1-yuehongwu@cmss.chinamobile.com>
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

- [High] The fix is incomplete: the peer port's ndo_open can re-arm the
  RX-ready interrupt of a port that is still down.

--

net: ethernet: adi: adin1110: mask the RX IRQ of the port being stopped

This patch swaps the two RX_RDY bits in adin1110_net_stop(). Each port
now masks its own RX-ready interrupt in IMASK1 when it is stopped, which
matches the bit mapping in adin1110_port_rx_ready().

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
Is this fix complete? The peer port's open path looks like it can unmask
this bit again while this port is still down.

adin1110_net_stop() masks the bit with a read-modify-write.
adin1110_net_open() does not. It rebuilds IMASK1 from scratch and
unmasks RX_RDY for both ports:

drivers/net/ethernet/adi/adin1110.c:adin1110_net_open() {
    ...
	val = ADIN1110_TX_RDY_IRQ | ADIN1110_RX_RDY_IRQ | ADIN1110_SPI_ERR_IRQ;
	if (priv->cfg->id == ADIN2111_MAC)
		val |= ADIN2111_RX_RDY_IRQ;

	priv->irq_mask = val;
	ret = adin1110_write_reg(priv, ADIN1110_IMASK1, ~val);
    ...
}

On ADIN2111, take this sequence:

  ip link set eth1 down    -> adin1110_net_stop() masks ADIN2111_RX_RDY_IRQ
  ip link set eth0 down
  ip link set eth0 up      -> adin1110_net_open() clears that mask again

eth1 is still down at this point, but its RX_RDY interrupt is enabled
again. A port that was never opened also gets its RX_RDY unmasked as soon
as the other port opens.

For the down port, adin1110_port_rx_ready() returns false:

	if (!netif_oper_up(port_priv->netdev))
		return false;

So adin1110_irq() never drains that port's FIFO. It only writes STATUS1
with priv->irq_mask and returns IRQ_HANDLED.

The interrupt is requested with IRQF_TRIGGER_LOW. Frames can be left in
the FIFO, for example frames that arrive between the IMASK1 write and
phy_stop(). The commit message describes this exact state: "the stopped
port also keeps re-raising its interrupt with nobody draining the FIFO".
Wouldn't that state still be reachable after this patch?

The handler always returns IRQ_HANDLED, so the spurious IRQ detector
would not disable the line. The threaded handler would keep running SPI
transactions under priv->lock.

Also, priv->irq_mask is overwritten in adin1110_net_open() and never
updated in adin1110_net_stop(). The driver therefore does not track which
ports have RX_RDY masked.

Should adin1110_net_open() unmask only the opening port's RX_RDY bit with
a per-port read-modify-write, like adin1110_net_stop() does? Should the
stopped port's RX FIFO also be drained or flushed on stop?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103-adin1110-net-stop-1-yuehongwu%40cmss.chinamobile.com
