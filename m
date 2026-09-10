Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED923577E41;
	Thu, 10 Sep 2026 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064029; cv=none; b=HYHPJv9y5DJULGHV4nbQh2cIpI8to/PCZTn2dRpfVNEduVXNbxM4jYjmZ1PGjRfzbELlX0KflPlreYHvyErvco2nsqPJEE/WIcyGo5Sk6/mDwWQ7FwKOl2gTxq1Qd1XhlZYchB6cQ+Q9MLVEk0iU9UFTIKcdQxsehDceZp72DPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064029; c=relaxed/simple;
	bh=OcPO9o1L0plLzOC4UoYCvzl+lxwSVa6Jg/rTnMrHvSs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qLJ5AtjWtGsO0A+YDfMh7eHVYsfxA2erAWBECTxJtBwz9qeMHLIfp+HI9QPQ1T9U4+DAFMC3lagtbFis7/3kTJvJIOma/5fKOSe3EhnyHcHVaL7OP/AACySDHumnlhbxqOKPCWoNTMyWusMHeI7HPBbDcu+wO8r9eivY+r1F9ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=AJ4z/JRx; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="AJ4z/JRx"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F04CCA0580;
	Thu, 10 Sep 2026 20:13:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789064019; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NCSCPPuYHaQkAspiPMvoQKxLvMSwoarAK+y1e0lenDw=;
	b=AJ4z/JRxku+KUEDMbabI7GEjsv6B5Tzpbt7Q1vurzT6b1NHk7IgI5EkN2k5KncP9WSnDS6
	IlYvdO8bku7rTDKct2ndEl/pqAhm6jlwW65ovQshFnm/TzUDVxGCRT7pl2cOhqTRPJ2sz7
	c1xrLFzWV8oNQeTvjJhtk59aWwc+nqL4Zz7i5z/8blsDwQj3ogg8pAJpJi+mswfDnQ3kH7
	2qobBEX2cSULtfGcZCIaDWs3Y2o1w1OXHnr+p64KL51JNnfj2iha1pJtBm0VE24m7VV091
	WeDWyC0lHSSlQwF7/hZnYlPLWAgsgt1CxzVMNU41pyWCJZ2iGacf4STZIwWpdw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 20:13:37 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Emil Renner Berthing
 <kernel@esmil.dk>, Minda Chen <minda.chen@starfivetech.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Jan Petrous <jan.petrous@oss.nxp.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Jose.Abreu@synopsys.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de, David Laight
 <david.laight.linux@gmail.com>
Subject: Re: [PATCH net v2 4/6] net: stmmac: selftests: Capture all packets
 for vlan checks
In-Reply-To: <20260910151404.976753-5-maxime.chevallier@bootlin.com>
References: <20260910151404.976753-1-maxime.chevallier@bootlin.com>
 <20260910151404.976753-5-maxime.chevallier@bootlin.com>
Message-ID: <ffa7e2ca24b7a0d6a66d8213a8fb5daf@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10.9.2026 17:14, Maxime Chevallier wrote:
> While we use vlan_vid_add to trigger the tag filtering machinery
> in the driver, there's no netdev associated to the VLAN. This causes 
> the
> skb to arrive with empty skb->vlan_tci fields, as the packet is marked
> OTHERHOST in __netif_receive_skb_core(), and we fail our validation.
> 
> Let's use the proxy mechanism introduced for DSA, that registers a
> ETH_P_ALL packet handler that runs earlier, before the vlan netdev
> lookup, then filters for the correct ethertype before passing an skb
> clone to our validation function.
> 
> Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c 
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> index f3a533bc6bb6..ec56ee0031ab 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> @@ -241,6 +241,7 @@ struct stmmac_test_priv {
>  	__be16 packet_type;
>  	int (*func)(struct sk_buff *skb, struct net_device *ndev,
>  		    struct packet_type *pt, struct net_device *orig_ndev);
> +	bool capture_all;
>  	int double_vlan;
>  	int vlan_id;
>  	int ok;
> @@ -343,7 +344,7 @@ static void stmmac_sft_add_pack(struct packet_type 
> *pt)
>  {
>  	struct stmmac_test_priv *tpriv = pt->af_packet_priv;
> 
> -	if (netdev_uses_dsa(tpriv->pt.dev)) {
> +	if (netdev_uses_dsa(tpriv->pt.dev) || tpriv->capture_all) {
>  		tpriv->packet_type = tpriv->pt.type;
>  		tpriv->func = tpriv->pt.func;
> 
> @@ -994,6 +995,7 @@ static int __stmmac_test_vlanfilt(struct 
> stmmac_priv *priv)
>  	tpriv->pt.dev = priv->dev;
>  	tpriv->pt.af_packet_priv = tpriv;
>  	tpriv->packet = &attr;
> +	tpriv->capture_all = true;
> 
>  	/*
>  	 * As we use HASH filtering, false positives may appear. This is a
> @@ -1088,6 +1090,7 @@ static int __stmmac_test_dvlanfilt(struct 
> stmmac_priv *priv)
>  	tpriv->pt.dev = priv->dev;
>  	tpriv->pt.af_packet_priv = tpriv;
>  	tpriv->packet = &attr;
> +	tpriv->capture_all = true;
> 
>  	/*
>  	 * As we use HASH filtering, false positives may appear. This is a
> @@ -1366,6 +1369,7 @@ static int stmmac_test_vlanoff_common(struct 
> stmmac_priv *priv, bool svlan)
>  	tpriv->pt.af_packet_priv = tpriv;
>  	tpriv->packet = &attr;
>  	tpriv->vlan_id = 0x123;
> +	tpriv->capture_all = true;
>  	stmmac_sft_add_pack(&tpriv->pt);
> 
>  	ret = vlan_vid_add(priv->dev, htons(proto), tpriv->vlan_id);

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
