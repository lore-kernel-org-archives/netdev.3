Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4982C51B179;
	Tue, 22 Sep 2026 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790074080; cv=none; b=N0z3COP157stK+9LvzX/AUklojkFEfezWVLUh9cNlcCNgWwcyycvE+Sl0ySsJQmHY5aZK+f0r42gbiNEVhSFrM9U1KEOEPC3deYLXeUbA0HgXyZTgv4CqyIdwUg4agyP1z4h2kyaQ4oYX7pr0z1chhCvjhQenBzNLCWIi0IJ/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790074080; c=relaxed/simple;
	bh=vKFB3NSwjgBafsrlRaW7TmEcMz4QQq/m09nRlIbKfco=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nBIWj4XMEMkuwom36CwEUTHfO9OQJR5a2paXTLoA8IqNpMIId3TO5vehC8xiVHU9gTpoZu9fnuoZVvDT7i5zJ68km2qouwNXGdvBNZ3W+fcLqAIE0MQkvIGxV55JOXa4CdURhikcvRPfwryNVPpcwCPI8RjQRWWtj8K1OnyH9SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ABk4puBT; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ABk4puBT"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1C29A4A18;
	Tue, 22 Sep 2026 12:47:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790074076; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2wYvu4v9Jb4w5JqhM8ECA/NsBlshxfveVFXWY4IFPGo=;
	b=ABk4puBTBcArGjo51YQ+6yBzWxPTx+pKkq0wKqGAyYOM5M1+u5YqVhqXl9NhiKN6KQjbho
	RxNbf3x4x5vTa2BXjP0YmIo1PTxX9CCf0srAeUAieNNLEEF8sbvYcSER1hmEZ57thamnQj
	jWW06Ci54OqYxuT050ZPMCwgemN/wo2IKD39o5a8dwIzLLLO12eDsrs25XzU9nWR+9jbDz
	+B7QAMBQZzl4IYTlXSSqGJltzkithnnfReToCUoyPL3b8sJXFUmeZxGDyYd9XAN0xKVXG2
	uXkm/zPJ+06jClL6MOfk4Jwqi7vh05HJTp4ygjubAHlqmerv9S9WRrSuAg26Mg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 12:47:55 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: 5mghybrid@khu.ac.kr
Cc: netdev@vger.kernel.org, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, Rafal Ozieblo <rafalo@cadence.com>, Conor Dooley
 <conor.dooley@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: macb: Disable one-step mode when TX
 timestamping is off
In-Reply-To: <20260922-codex-macb-hwtstamp-submit-v1-3-9d1abaa53296@khu.ac.kr>
References: <20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296@khu.ac.kr>
 <20260922-codex-macb-hwtstamp-submit-v1-3-9d1abaa53296@khu.ac.kr>
Message-ID: <8795ff5872352a160eb71524e0c00f91@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.9.2026 11:10, Kim Wooseok via B4 Relay wrote:
> From: Kim Wooseok <5mghybrid@khu.ac.kr>
> 
> Switching from HWTSTAMP_TX_ONESTEP_SYNC to HWTSTAMP_TX_OFF turns off
> descriptor timestamping, but leaves NCR.OSSMODE set, so one-step mode
> remains enabled.
> 
> Update OSSMODE for every accepted TX mode and set it only for
> HWTSTAMP_TX_ONESTEP_SYNC. This also clears the previous one-step 
> setting
> when switching to OFF. Since the update mask now always includes
> OSSMODE, drop the check for an empty mask.
> 
> Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
> Assisted-by: GPT-6 Astra
> Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>
> ---
>  drivers/net/ethernet/cadence/macb_ptp.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c 
> b/drivers/net/ethernet/cadence/macb_ptp.c
> index b6d17fef4..6376b6631 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c
> @@ -390,7 +390,7 @@ int gem_set_hwtst(struct net_device *netdev,
>  		  struct kernel_hwtstamp_config *tstamp_config,
>  		  struct netlink_ext_ack *extack)
>  {
> -	u32 ncr_mask = 0;
> +	u32 ncr_mask = MACB_BIT(OSSMODE);
>  	enum macb_bd_control tx_bd_control = TSTAMP_DISABLED;
>  	enum macb_bd_control rx_bd_control = TSTAMP_DISABLED;
>  	int rx_filter = tstamp_config->rx_filter;
> @@ -409,7 +409,6 @@ int gem_set_hwtst(struct net_device *netdev,
>  		ncr_bits |= MACB_BIT(OSSMODE);
>  		fallthrough;
>  	case HWTSTAMP_TX_ON:
> -		ncr_mask |= MACB_BIT(OSSMODE);
>  		tx_bd_control = TSTAMP_ALL_FRAMES;
>  		break;
>  	default:
> @@ -445,11 +444,9 @@ int gem_set_hwtst(struct net_device *netdev,
>  	}
> 
>  	spin_lock_irqsave(&bp->lock, flags);
> -	if (ncr_mask) {
> -		regval = macb_readl(bp, NCR);
> -		regval = (regval & ~ncr_mask) | ncr_bits;
> -		macb_writel(bp, NCR, regval);
> -	}
> +	regval = macb_readl(bp, NCR);
> +	regval = (regval & ~ncr_mask) | ncr_bits;
> +	macb_writel(bp, NCR, regval);
> 
>  	gem_writel(bp, TXBDCTRL, GEM_BF(TXTSMODE, tx_bd_control));
>  	gem_writel(bp, RXBDCTRL, GEM_BF(RXTSMODE, rx_bd_control));

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
