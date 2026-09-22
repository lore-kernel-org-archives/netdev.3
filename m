Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00C64E73D9
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110079; cv=none; b=W7ux+X7KKLEImqMClZU0kP6ap9T2CQ2E+uafrz1Q4UxQ+CayyKfKzPF8Bsxgr8IKFA83WxUIxx/nkLNes7JuQxJjaMHtWCAGSM+1HlNgenk4qYULObRUISvCINhXmyZsUeqeWzfIDJJEPcaInMOuW87YqBORVVTFr3gbdiMTIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110079; c=relaxed/simple;
	bh=sq3e6uiy+IP4EDpy0ZZwpI2pGouZssnnQSW2A9x83Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qv0QddotNWpaeESUhdK1WTVQFOSQMU4IekXeekDaz1MPXzJBNoeGU0cgTp/ZkJcOdHtSML2ee1UNXKSQVrvMgcpMGev2s2ldpWUNmQcRAyckq7u0zJuWl3ILWSEq4GmAKfV2rQbGFUSBvPl4yGsnOa1YvSIrpyz4ErZ9B+kQA9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cpwFUDof; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cpwFUDof"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AA444C21A95;
	Tue, 22 Sep 2026 20:48:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CDE7960580;
	Tue, 22 Sep 2026 20:47:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC954103293A2;
	Tue, 22 Sep 2026 22:47:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790110051; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=XpaQDgz3fdEzNjsK4nSLNvmrPAQ15E8c22RyFXzvB9g=;
	b=cpwFUDofdzjge+jC7MWGP4O6tv1sPoJgGONwidu7fJCgaiPEmMktrtp2NYxJtk7gT7QeJ/
	9T/JgUaCWBgAbYeMcFILw4XknTYCE4vBnI0w05obw/uaRjN0tmnWN3MCb7t3iEMTwkRggf
	L74BmAo2fvSpgQsc8cGHBHiy6h2abagQZL7OuIryc+vRRoDaSjdB8vaQ1BiAlwGSNB5/gj
	9R8ds+0RElWW6EqScwBMErxGOmmk9mdwksKMHdShDTI+Ahn8xvZHnUcZe3UubQOQFtCjW+
	EBcb4it9Yp8TzhTgFtPXDtlwm1NLBJCbjHgX8NbEcXpgHpZIEZj3PhvHa+kf3Q==
Message-ID: <cccfc8a4-22ca-4501-9cd8-4e6b5dfa6a21@bootlin.com>
Date: Tue, 22 Sep 2026 22:47:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: emac: move setting of netops to fix crash
To: Christian Lamparter <chunkeey@gmail.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 jacob.e.keller@intel.com, nb@tipi-net.de, edumazet@google.com
References: <49cd7343bc0e507c022071f3e2b5662b053dca73.1790007431.git.chunkeey@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <49cd7343bc0e507c022071f3e2b5662b053dca73.1790007431.git.chunkeey@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/21/26 18:28, Christian Lamparter wrote:
> fixes the following crash on driver initialization:
> 
> |BUG: Kernel NULL pointer dereference on read at 0x00000158
> |Faulting instruction address: 0xc0566b40
> |Oops: Kernel access of bad area, sig: 11 [#1]
> |BE PAGE_SIZE=4K  PowerPC 44x Platform
> |Modules linked in:
> |CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: GW 7.3.0-rc3+ #1
> |Tainted: [W]=WARN
> |Hardware name: MyBook Live APM821XX 0x12c41c83 PowerPC 44x Platform
> |NIP:  c0566b40 LR: c05648f8 CTR: c04c1e9c
> |REGS: c1053a20 TRAP: 0300   Tainted: GW  (7.3.0-rc3+)
> |MSR:  0002b000 <CE,EE,FP,ME>  CR: 24008808  XER: 00000000
> |DEAR: 00000158 ESR: 00000000
> |GPR00: c05648f8 c1053b10 c1063600 c1030000 c5ab3000 00000000 [...]
> |GPR08: 00000002 00000000 00000000 c1053b40 84002808 00000000 [...]
> |GPR16: cfffd210 00000002 c0beafcc cfffc960 00000000 c1030644 [...]
> |GPR24: c0beafbc c1037000 00000000 0000000a 00000000 c1030000 [...]
> |NIP [c0566b40] phy_link_topo_add_phy+0x2c/0x1d0
> |LR [c05648f8] phy_attach_direct+0x1a4/0x368
> |Call Trace:
> |[c1053b10] [c0811e04] klist_put+0x54/0xb4 (unreliable)
> |[c1053b40] [c05648f8] phy_attach_direct+0x1a4/0x368
> |[c1053b70] [c0564ae8] phy_connect_direct+0x2c/0x60
> |[c1053b90] [c056c7a8] of_phy_connect+0x50/0x74
> |[c1053bc0] [c0572a88] emac_probe+0xd50/0x119c
> |[c1053c90] [c04cb770] platform_probe+0x74/0xa4
> |[c1053cb0] [c04c8f08] really_probe+0x120/0x2b0
> |[c1053cd0] [c04c9254] __driver_probe_device+0x1bc/0x1fc
> |[c1053d00] [c04c9334] driver_probe_device+0x38/0xa8
> |[c1053d30] [c04c9560] __driver_attach+0xf4/0x10c
> |[c1053d50] [c04c6af8] bus_for_each_dev+0x68/0xd0
> |[c1053d90] [c04c7c34] bus_add_driver+0xcc/0x1ec
> |[c1053dc0] [c04c9f6c] driver_register+0xcc/0x110
> |[c1053de0] [c0aa3f40] emac_init+0x1c4/0x200
> 
> This bug showed up starting with v7.3-rc1. At the NIP in
> phy_link_topo_add_phy() is a netdev_need_ops_lock() check.
> This was added by the following
> commit ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking assertion")
> 
> The bug shows up because at the time of_phy_connect() was called, the
> netdev_ops were *not yet* determined. My fix is to move the code that
> sets netdev_ops+commac.ops+ethtool_ops further up as emac_init_config()
> derives that by looking at the device-tree and sets the required
> dev->phy_mode accordingly.
> 
> During review, the Sashiko bot's AI stated that the commac assignment
> became a dead store. Great catch! To keep the original behavior as-is,
> one mentioned option "set dev->commac.ops = &emac_commac_ops only in
> the non-gige case?" sounded like a great plan. So the dev->commac.ops
> assignment for the non-gige-case moves into the else block.
> 
> This patch was tested on a WD MyBook Live (RGMII). the device now works again.
> 
> Fixes: ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking assertion")
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> 
> v2:
>   - "set dev->commac.ops = &emac_commac_ops only in the non-gige case"
>   - reworded commit message to include commac_ops and Sashiko
> v1: https://lore.kernel.org/all/178999551085.2160803.13630958553679103031@kernel.org/
> ---
>  drivers/net/ethernet/ibm/emac/core.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index 1d46cf6c2c12..e7043523457c 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -3044,6 +3044,15 @@ static int emac_probe(struct platform_device *ofdev)
>  	if (err)
>  		goto err_gone;
>  
> +	if (emac_phy_supports_gige(dev->phy_mode)) {
> +		ndev->netdev_ops = &emac_gige_netdev_ops;
> +		dev->commac.ops = &emac_commac_sg_ops;
> +	} else {
> +		ndev->netdev_ops = &emac_netdev_ops;
> +		dev->commac.ops = &emac_commac_ops;
> +	}
> +	ndev->ethtool_ops = &emac_ethtool_ops;
> +
>  	dev->emacp = devm_platform_ioremap_resource(ofdev, 0);
>  	if (IS_ERR(dev->emacp)) {
>  		err = PTR_ERR(dev->emacp);
> @@ -3076,7 +3085,6 @@ static int emac_probe(struct platform_device *ofdev)
>  		dev->mdio_instance = platform_get_drvdata(dev->mdio_dev);
>  
>  	/* Register with MAL */
> -	dev->commac.ops = &emac_commac_ops;
>  	dev->commac.dev = dev;
>  	dev->commac.tx_chan_mask = MAL_CHAN_MASK(dev->mal_tx_chan);
>  	dev->commac.rx_chan_mask = MAL_CHAN_MASK(dev->mal_rx_chan);
> @@ -3144,12 +3152,6 @@ static int emac_probe(struct platform_device *ofdev)
>  		ndev->features |= ndev->hw_features | NETIF_F_RXCSUM;
>  	}
>  	ndev->watchdog_timeo = 5 * HZ;
> -	if (emac_phy_supports_gige(dev->phy_mode)) {
> -		ndev->netdev_ops = &emac_gige_netdev_ops;
> -		dev->commac.ops = &emac_commac_sg_ops;
> -	} else
> -		ndev->netdev_ops = &emac_netdev_ops;
> -	ndev->ethtool_ops = &emac_ethtool_ops;
>  
>  	/* MTU range: 46 - 1500 or whatever is in OF */
>  	ndev->min_mtu = EMAC_MIN_MTU;

