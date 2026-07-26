Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D412EEE8D;
	Sun, 26 Jul 2026 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785089722; cv=none; b=fEogl1ZmEDp+LqDbE925B7yEB8+uzSLxm+B/FrBj3YPp0Ii8/KbC06Z1VFBQL5g7z/j8dsYtahoA7Z4Qpx6sxeYm/NNn+hMSKsD30xbR6kKMeTTZJCx1PAgVc1+hrjs6W2Bde85tVSVbPTrP+j3N+TKjT2PdV+8w+MSZaOMgs+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785089722; c=relaxed/simple;
	bh=oghlc+c3I2qloSZrij5YUM7gHVK6z/tEhKJVgTPETs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDbUaQnAV2qtKI+Yf24Fqk/EQH/8mqnJbZ8wFMHH2mBYiNHCeNTwbAa4h/bl6TB3pzePKWqPb1wHQfgPbNUtuUrYqHa4II0TyljYKjVszklgIDbGhJ0TAEHTCbNtTlvgAoXrJYkirTR0bzAdKtUzXa4OsvURhqfI8HC0xiRZ1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IvDW9TsU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IvDW9TsU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MaEQKMeEjvfpA5VB/sHKsrGgnnBG0BlVfrQAWBNdC64=; b=IvDW9TsUa3rEoKYK2ssfe1XfcZ
	Z81q9POuAvYV/TeQHVOGEVPdZdB8vCujEEQPoTA+E3+pLsyfLLyJOT8y4vo1rLnCnsxtT+BhMQuKe
	7OEqGaULT9viDXcyNr/DK9AMFE7B3LARmTUHTk5kMWFCztjVErfXyW071tBM4+HeLC1M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wo3NT-00EK83-Na; Sun, 26 Jul 2026 20:15:07 +0200
Date: Sun, 26 Jul 2026 20:15:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: dev.taqnialabs@gmail.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: enable MAC rx/tx after DMA start
Message-ID: <ee639271-60dd-49f7-9e77-0ae47841754d@lunn.ch>
References: <20260726-stmmac-rx-fifo-block-v1-1-45ab094b6c02@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726-stmmac-rx-fifo-block-v1-1-45ab094b6c02@gmail.com>

> @@ -3692,9 +3692,6 @@ static int stmmac_hw_setup(struct net_device *dev)
>  		priv->hw->rx_csum = 0;
>  	}
>  
> -	/* Enable the MAC Rx/Tx */
> -	stmmac_mac_set(priv, priv->ioaddr, true);
> -
>  	/* Set the HW DMA mode and the COE */
>  	stmmac_dma_operation_mode(priv);
>  
> @@ -3750,6 +3747,9 @@ static int stmmac_hw_setup(struct net_device *dev)
>  	/* Start the ball rolling... */
>  	stmmac_start_all_dma(priv);
>  
> +	/* Enable the MAC Rx/Tx */
> +	stmmac_mac_set(priv, priv->ioaddr, true);
> +

There should be a function which is the opposite of stmmac_hw_setup(),
which tears it down. What order are things done there? tear down is
generally done in the opposite order to setup, so does the "Disable
the MAC Rx/Tx" also need to move?

> @@ -7189,12 +7189,12 @@ int stmmac_xdp_open(struct net_device *dev)
>  		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	}
>  
> -	/* Enable the MAC Rx/Tx */
> -	stmmac_mac_set(priv, priv->ioaddr, true);
> -
>  	/* Start Rx & Tx DMA Channels */
>  	stmmac_start_all_dma(priv);
>  
> +	/* Enable the MAC Rx/Tx */
> +	stmmac_mac_set(priv, priv->ioaddr, true);
> +
>  	ret = stmmac_request_irq(dev);
>  	if (ret)
>  		goto irq_error;

Same comment for the opposite of stmmac_xdp_open().

     Andrew
