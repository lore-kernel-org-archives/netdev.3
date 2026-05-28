Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD223394A;
	Thu, 28 May 2026 01:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779933517; cv=none; b=OOBLMKBlAHV+PxE2Cl1xLmblqhHj/fRC8i8HbLCOuAM4k9hXth/Oz/beSqIWF1AHdL7cOfqmyz3PumjW++Xlc+DHGSpu7+6WNoZjcymzt/rdsCoXc+/Aub7+tyEJ7EXPhVI4fGl8ixnC9wUlgk4cXUNRPjdVJirAZ0QKxamAvbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779933517; c=relaxed/simple;
	bh=rzSTTeVkBA2TWFt9EmYOLCwUcNWt64fJ0EkBsW5tdqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cF7/PYJAQrYE4hTXM3cE1dc/NYFlClfYJKmrBhCjHYt6i+miFxrYfMGVaI2fjOLyY2Y3+LH8QTTNYMCUYfNV2ZM4qZJtIUmc4vNgCS7WRCadao0MMUm5d4NEH8E1n46YVTVIeOAUWE5YquM4eBGMuROPs58kDuP53yYHrSQMXHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UJv8Nm5W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UJv8Nm5W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F5xpMV+AO1CKUrIiHxmrwoh1nrbemlBJIcVD/F1YUvI=; b=UJv8Nm5WktK8TNlR51sdYFfnq4
	U5X45/lWKA9m5eQxfTd1jDw9F7MY4tI7XFQgWdqBgz/ZBUIJVdIWGGmsS6CtSdhZGYLLD9fEYcGyO
	D+7758T0EZKkB8iUO+KgIq15euwfq2ei8TlvkBGqAvjp+5P7Wkm4zK0EVXk3LalpOO6s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSQ0u-004q8p-CU; Thu, 28 May 2026 03:58:24 +0200
Date: Thu, 28 May 2026 03:58:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: Improve Tx timer arm logic further
Message-ID: <a0cdbac8-c7b2-4dc2-b08c-7fae99a73e93@lunn.ch>
References: <20260527023359.18876-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527023359.18876-1-muhammad.nazim.amirul.nazle.asmade@altera.com>

> pre-patch behaviour. The meaning of tx_coal_timer is unchanged.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3591755ea30b..35da51c26248 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3341,12 +3341,14 @@ static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue)
>  	 * Try to cancel any timer if napi is scheduled, timer will be armed
>  	 * again in the next scheduled napi.
>  	 */
> -	if (unlikely(!napi_is_scheduled(napi)))
> -		hrtimer_start(&tx_q->txtimer,
> -			      STMMAC_COAL_TIMER(tx_coal_timer),
> -			      HRTIMER_MODE_REL);
> -	else

With this code, the timer is always tx_coal_timer in the future.


> +	if (unlikely(!napi_is_scheduled(napi))) {
> +		if (unlikely(!(hrtimer_active(&tx_q->txtimer))))
> +			hrtimer_start(&tx_q->txtimer,
> +				      STMMAC_COAL_TIMER(tx_coal_timer),
> +				      HRTIMER_MODE_REL);

If the timer is not active, it is set to tx_coal_timer in the
future. However, if the timer is active, meaning it is already
counting down, it is left alone, so is less than tx_coal_timer in the
future.

Do i have this right?

Doesn't that change the meaning of the timer. It now actually goes off
sooner?

This is somewhat academic. The point of coalescence is to reduce
overheads. The increase in performance shows that this change does
reduce overheads.

	Andrew
