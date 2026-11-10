Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287079;
	b=lVsYrPirONJWkuZ4TRnPU/ZNqc+bHbSqDZ683fPsJcdNgG9A/tCGnGDTeWKnbmTUWOb4
	 fxl3ahAon3d9QhpnuxM5EFenoJODIXJMjC4lNJ6lk3fOxAXpdkRaJFSzP/JJWonmtkakS
	 +S1AvJbGMaWJgSM08kSC1PFrT5aDZ3pHfE5EV00QWd6nHJqEmhaHhO1fVhMKy4UxfhUcJ
	 Kj2Pjfu5zaIzDgdk5FTIqMta3AL1UOgFyRRv8OK/WLI2JcmBTdn8xYx6BLR/Q4PyAhFPV
	 Z1BMYuJdY7UKAw6Vecb10hZzNYf3yGeNN3QXaLb9lI61s4+YhX4aBTSgwBXphyIc4Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287079;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jXeGcKc5lyVio5sQ0M5A2Xgx0Qjt+eDjTJW1dRcHGgk=;
	b=wYXuF0LzBEyKc7wAj80aUw1WJs3k1jwLPwblNfry8tn29xJN7ctccoXQhPMXmfvBn/LJ
	 tuvcN7PxfVv1C9n0A1g2Xc6YCTyopNWaknctEPYpjguid+gfFECXJ7S6mO5K35FNf8JnU
	 mpa7iRaIy5AV4/gwaAujRbcA52u8os8T6VnUL6Bz3ED+Fve9IidHiVyLspK0XfoCcakNd
	 6MoVZGjFGboodZ8l8Yryl1wl5Rm7h+2+cfN/GWE3WUlJk+GPrUa2+V8oH+t3o6h1xvA6j
	 MtGVABztIMZRedCzwpgbe/n91XEwVouWjsV/u2dpEXVTxpAunLZvYGLWanSO1AzySxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7Co3OEs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26CA606C921;
	Tue, 10 Nov 2026 05:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7Co3OEs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77EC1F0089F;
	Tue, 10 Nov 2026 05:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794287078;
	bh=jXeGcKc5lyVio5sQ0M5A2Xgx0Qjt+eDjTJW1dRcHGgk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V7Co3OEscrdD3IQX/RzBMPRPPx/wNo8IJIk0scvADGHhxJq71tsuydntIZfdww4Fg
	 QQf4iMTfyYnoJawaRic10+jWLxlKqVZXQnCq8L+e75N+2zPLleiyUSJvCMUz/d4KYt
	 qQpNIDBM8JYK7Ms8JROPeHxaZ7X5Oc5KMo+NCRgXy33WQ8Npg44jX1lVh68ArLEzeG
	 Uk33bV3V1oQk6FGsGtTNYC8SOS8j23T0eXfxuuQOLrbhVofUIIy8lsSJ/HFNIlVTr0
	 kSG0KLj3MJvo87YxjTg98xcSJz+JAU9suLHMA6P8FpD9e2zpVuN5p9QZ+gL2+vgxQU
	 ww+Kl9BCIQ6ug==
Subject: Re: [PATCH net v3] net: ethernet: adi: adin1110: mask the RX IRQ of
 the port being stopped
From: netdev-bot+sashiko@kernel.org
To: wuyuehong@cmss.chinamobile.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, kees@kernel.org,
 nuno.sa@analog.com, hkallweit1@gmail.com, nichen@iscas.ac.cn,
 alexandru.tachici@analog.com, lennart@lfdomain.com,
 linux-kernel@vger.kernel.org
Date: Tue, 10 Nov 2026 05:04:37 +0000
Message-ID: <179428707736.994134.3917076046074725088@kernel.org>
In-Reply-To: <20261106-adin1110-net-stop-v3-1-yuehongwu@cmss.chinamobile.com>
References: <20261106-adin1110-net-stop-v3-1-yuehongwu@cmss.chinamobile.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch fixes the bit mapping in adin1110_net_stop(), but on
  ADIN2111 a stopped port's RX-ready interrupt can still end up unmasked.

--

net: ethernet: adi: adin1110: mask the RX IRQ of the port being stopped

This commit swaps the RX-ready interrupt bits used in adin1110_net_stop().
With the swap, the port being stopped masks its own RX interrupt in
ADIN1110_IMASK1 and no longer masks its peer's. The commit message says
the old mapping left the stopped port's interrupt unmasked, so it kept
firing with nobody draining the FIFO.

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

[Severity: Medium]
On ADIN2111, can a stopped port's RX-ready interrupt still be unmasked
again when the other port is opened?

The bit set here is only kept in hardware. Nothing records it per port,
and priv->irq_mask is not updated. adin1110_net_open() does not do a
per-port read-modify-write. It rewrites the whole register with both
ports' RX bits:

drivers/net/ethernet/adi/adin1110.c:adin1110_net_open() {
    ...
	val = ADIN1110_TX_RDY_IRQ | ADIN1110_RX_RDY_IRQ | ADIN1110_SPI_ERR_IRQ;
	if (priv->cfg->id == ADIN2111_MAC)
		val |= ADIN2111_RX_RDY_IRQ;

	priv->irq_mask = val;
	ret = adin1110_write_reg(priv, ADIN1110_IMASK1, ~val);
    ...
}

Here is one way to reach this:

  ip link set port0 down          (net_stop masks ADIN1110_RX_RDY_IRQ)
  ip link set port1 down
  ip link set port1 up            (net_open clears it again)

Port 0 is still down at the end, but its RX-ready source is unmasked.

Frames can reach port 0's RX FIFO between the IMASK1 write in
adin1110_net_stop() and phy_stop(). Once the port is no longer oper-up,
nothing drains those frames:

drivers/net/ethernet/adi/adin1110.c:adin1110_port_rx_ready() {
	if (!netif_oper_up(port_priv->netdev))
		return false;
    ...
}

After port 1's open unmasks the bit, the interrupt is requested with
IRQF_TRIGGER_LOW | IRQF_ONESHOT. Would adin1110_irq() then run over and
over? It skips port 0 and only acknowledges the status:

	adin1110_write_reg(priv, ADIN1110_STATUS1, priv->irq_mask);

This assumes STATUS1.RX_RDY stays asserted while the FIFO holds data,
which is how adin1110_read_frames() treats it.

If so, this is still reachable on ADIN2111 through the peer's open:

  "the stopped port also keeps re-raising its interrupt with nobody
  draining the FIFO"

Should adin1110_net_open() unmask only its own port's RX bit with a
read-modify-write, and keep priv->irq_mask consistent per port? On
ADIN1110 there is only one port, so the change looks complete there.

>  
>  	/* Disable RX RDY IRQs */
>  	mutex_lock(&priv->lock);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-adin1110-net-stop-v3-1-yuehongwu%40cmss.chinamobile.com
