Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756525;
	b=aJu6JYnGpbV2QkeJILj9g/lp6rWIjPazgZSiEEaenlL9j5y4Pe9kITl6DrAfTA66R6cL
	 QHaDe5LQFmsFA+kyt895VheaTTQdcmeXFLekcl4tFVtcgyVkfnH3SRyvyPNzZEKHVN92Q
	 EeaTFfEC5mQxiD7+TxGU+RvULvW+Y1eV6ozlMkvjOs8kSAidBUClWrCXF6r5ZjKYhP8vd
	 v9j4mvxu1kIv2SP78DzRcax2y1jt9yFm7ZiIvqYFlu2VdxMDGTEcp6N/poi8jpzH4whiK
	 8h1bGTZemqyY6DEeuzc/7juKufX53kSLJhw6KNYb/PSMhTP9TT76nOYa3GCesSCyPDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756525;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+J7+chlUKksNinAiql6F9+R5z+c+bp9wJK80EKeQE34=;
	b=4EcrlQcwJ3d+4I/5E8TIRCTdDJndxobr4CMZYYkWmrEwbS2g6l1Ernetz5nJkNOwPeiW
	 Bb2CiTQGSZAaSfOdLgiZ4RAPGE31TgX18axD1ciNgFFZ8TlHDxHwz78sQJJBmGiTaTMfm
	 BvQ81aGEdX+E306aVoxQk/Wy1DYervZyq28Rd2vB/XTN8Ciai9gigBlkmkFuAhM+HM82z
	 nntgOp6aEhYW5GzgXCCFuRWGuOB/WajSmg8hBYfRwENUqSVjNPrfA+oHsYakIbTEtU/XW
	 I8ogUNuJ5cBVjxnbL+zaiII8HofP2RMwFqqn/XaeKpeSHsXcP/Zr5sIA35+FTe9X9jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jA4GCHio;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906A9606A31A;
	Fri, 23 Oct 2026 11:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jA4GCHio
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9CD1F01825;
	Fri, 23 Oct 2026 11:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792756524;
	bh=+J7+chlUKksNinAiql6F9+R5z+c+bp9wJK80EKeQE34=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jA4GCHioLnh8Xr96QIIHVW+nN3iIN9GRl4f76JqeEBvqLVpvwXgRFeaiB1r+znXPq
	 AXdRUQd5XdeQNp+vd6CgHfyy3cJLjNAZcgymBNUKwfNpfj1sXK7sFHEkI6GKWnr6KB
	 QYejAVCiKvRGaL9YDPFukoWioRAkbhRbz3YN5Fk0vuw1RsiU77DUKr7OR0TRripnZW
	 Vm68A7xcYknYArvvsw393lu0cH2tyctvdPaYrV5PsNd9QIHmUbdH/j9l1BzKi8sOW1
	 C/yVB2b7OU3DWxOTs2uuWPHuGBAyVYTsLQeD1SbOaPLNF4rC5znMLzHxYHi3C/HbWw
	 xrW4QKU6Umpcw==
Subject: Re: [PATCH net v3 1/2] net: bcmgenet: recover from a failed resume
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 justin.chen@broadcom.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 23 Oct 2026 11:55:23 +0000
Message-ID: <179275652332.3134.3420351260504788140@kernel.org>
In-Reply-To: <20261022-nb-genet-fini-dma-net-v3-1-6e9fc89c0156@tipi-net.de>
References: <20261022-nb-genet-fini-dma-net-v3-1-6e9fc89c0156@tipi-net.de>
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

- [Medium] After a failed non-WoL resume, the next non-WoL system suspend
  leaves the external PHY powered and linked.

--

net: bcmgenet: recover from a failed resume

This commit lets bcmgenet cope with a resume that fails in
bcmgenet_init_dma(). The driver now sets rx_cbs and tx_cbs to NULL when
it frees them, so they show whether a datapath exists, and the failure
path no longer disables the clock. Close, suspend and the WoL resume now
check that state, so they skip the datapath teardown that was already
done.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index f4cfbff49a1b..e7dec73d5b1c 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -4320,8 +4337,9 @@ static int bcmgenet_resume(struct device *d)
>  	/* Reinitialize TDMA and RDMA and SW housekeeping */
>  	ret = bcmgenet_init_dma(priv, false);
>  	if (ret) {
> +		/* Leave the block clocked, close and suspend tear it down */
>  		netdev_err(dev, "failed to initialize DMA\n");
> -		goto out_clk_disable;
> +		return ret;
>  	}

[ ... ]

>  static int bcmgenet_suspend(struct device *d)
>  {
>  	struct net_device *dev = dev_get_drvdata(d);
>  	struct bcmgenet_priv *priv = netdev_priv(dev);
> -	struct bcmgenet_rxnfc_rule *rule;
> -	u32 reg, hfb_enable = 0;
>
>  	if (!netif_running(dev))
>  		return 0;
>
> +	/* A failed resume has torn the datapath down already. Resume still
> +	 * enables irq1 on the WoL path, so it has to be disabled here.
> +	 */
> +	if (!priv->tx_cbs) {
> +		if (device_may_wakeup(d) && priv->wolopts) {
> +			bcmgenet_wol_arm_filters(priv);
> +			disable_irq(priv->irq1);
> +		}
> +		return 0;
> +	}

[Severity: Medium]

After a failed non-WoL resume, can the next non-WoL suspend leave an
external PHY powered up with its link active?

On the normal non-WoL path, bcmgenet_suspend() halts and suspends the
PHY:

bcmgenet_netif_stop(dev, true)
  phy_stop()
    PHY_HALTED -> phy_suspend()   (BMCR power-down)

The failed resume has already done this before bcmgenet_init_dma()
fails:

bcmgenet_resume()
  phy_init_hw()          drv->soft_reset() clears BMCR_PDOWN and sets
                         phydev->suspended = 0
  genphy_config_aneg()   restarts autoneg
  bcmgenet_init_dma()    fails -> return ret
                         (phy_resume() is never reached)

This new early return then skips any PHY power-down. Calling phy_stop()
here would not work either, because the PHY is still in PHY_HALTED.

Nothing else seems to power the PHY down. bcmgenet_mii_probe() sets
mac_managed_pm = true, so mdio_bus_phy_suspend() returns early, and
bcmgenet_suspend_noirq() only powers down an internal GPHY via
GENET_POWER_PASSIVE.

So an external PHY whose driver has both .soft_reset and .suspend (for
example genphy_soft_reset with genphy_suspend) would stay powered with
its link up through system sleep.

This would not show up with the bcm54xx PHY on CM4, which has no
.soft_reset, or with the Generic PHY driver.

Does the !priv->tx_cbs path need a phy_suspend() call (or similar) when
WoL is not in use?

>
>  	netif_device_detach(dev);
>
>  	if (device_may_wakeup(d) && priv->wolopts) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022-nb-genet-fini-dma-net-v3-0-6e9fc89c0156%40tipi-net.de
