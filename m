Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486682248A5;
	Tue,  6 Oct 2026 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791267077; cv=none; b=uwjc28/R3dF4qYikgUKJL1+Sq192Rp+/jyLTg9S8ZWy18W50aDQMg+hdx82gM34vXKzp7z1Uu4LWgLIndpSudINBO91w1rxY0RNENZYVhHj5vMmIsruZONg4JIv8AHcyg/k0WNopR7Ty1OXOlKoi07JEHQySHVc8Fw9DdbsavMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791267077; c=relaxed/simple;
	bh=HfrOCLCos8pvCpwh2VRr8eGgdKwA0DFIXhXuj7Az7vU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nI/mDNM859ttSh4q4+AeYu1n1vBMfpUHgkH1U7ncpQ6tIaK1QPFzVpbcz8zWFay5RfymkUPHahLeBN8Ccr55gBPWpVKksKaek3HFHesOqMsCk88V4JwxWkr8ziFyUq+iEb82wh2DpEHzG/mBuZOaw8su507OwVQzyi70BsVyMks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Ie5wANbw; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Ie5wANbw"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 68368A012B;
	Tue,  6 Oct 2026 08:11:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791267073; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QEqiKEHKarFBBNj7EInhCi1Qac+F8ajzAZ5Uck5ighE=;
	b=Ie5wANbwdKEGXszo8EQjyZgNwM1u745GFqrntFnuP7l+Yz7JEb0hGCv/uycRvxYKMoIRZz
	khoIhFvpMCPrLAbYmCe/YBv7qcNRzMN+VUe2yAIny4KBZ0+flg6y8EBNVnzz3lYNfhiI5c
	CtHeIfb55a7rArfJ+Ud1pan81doBUoQOqNWXIPMWxN0F9/EHLdVwLvEsjpwkx3H++AkavQ
	fTv5hYlMUJQvTEpR1UuP4gggaGP/TLjYnnk8dPymZurry6fuAXNzAzq+BAld5ure9T5CO6
	zftsrhjIGkjxYzJyCtdbsnt7TcOJAsc2RiIZCizacET5pEgkiQCf2g6Ot0TFng==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 08:11:11 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Christian Marangi <ansuelsmth@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: leave the datapath running for
 normal-size MTU changes
In-Reply-To: <20260930-stmmac-mtu-fastpath-v1-1-fd73f378c071@gmail.com>
References: <20260930-stmmac-mtu-fastpath-v1-1-fd73f378c071@gmail.com>
Message-ID: <f0cbb31213093859821d467971d604a9@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi James

On 1.10.2026 06:39, James Hilliard wrote:
> When both MTUs are at most ETH_DATA_LEN, the receive buffer size and 
> MAC
> receive limit do not change. Update the MTU without restarting the
> datapath.
> 
> This also avoids rebinding a live AF_XDP pool to a temporary RXQ. XDP
> rejects jumbo MTUs, so all supported XDP MTU changes take this path.
> Jumbo transitions remain on the reopen path until the rollback change.
> 
> Fixes: 3470079687448 ("net: ethernet: stmicro: stmmac: permit MTU 
> change with interface up")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c 
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3f34d491c959..03cd14d10356 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6161,7 +6161,12 @@ static int stmmac_change_mtu(struct net_device 
> *dev, int new_mtu)
>  	if ((txfifosz < new_mtu) || (new_mtu > BUF_SIZE_16KiB))
>  		return -EINVAL;
> 
> -	if (netif_running(dev)) {
> +	/* Normal-size frames use the same buffers and MAC receive limits.
> +	 * In particular, do not disturb a live AF_XDP pool: XDP does not
> +	 * support jumbo frames, so it never needs the ring replacement 
> below.
> +	 */
> +	if (netif_running(dev) &&
> +	    (dev->mtu > ETH_DATA_LEN || mtu > ETH_DATA_LEN)) {
>  		netdev_dbg(priv->dev, "restarting interface to change its MTU\n");
>  		/* Try to allocate the new DMA conf with the new mtu */
>  		dma_conf = stmmac_setup_dma_desc(priv, mtu);
> 
> ---
> base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
> change-id: 20260930-stmmac-mtu-fastpath-68813ead3b90
> 
> Best regards,
> --
> James Hilliard <james.hilliard1@gmail.com>

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
