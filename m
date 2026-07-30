Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252E3AB26A;
	Thu, 30 Jul 2026 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447277; cv=none; b=SJOHRL0gfzEh6s/UQ/5c20uYVeVOZY0pN6+9OOthjEt+fd8jRCP0LZznoLEKF6rESb+S2jJ1hY/d/hKQ9ljM6kTDQhnU393w1GyQ0wXzvI+SigC4psx/U95rpEYK5yheOVNvUd79lnyX5irTQr3I+G7eZzoT38FzDmAlVzOrTsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447277; c=relaxed/simple;
	bh=jk1fT6uDE8TQmR1hyw4ZXqonFpeRp2zCIEmdrQvZ5w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OO+E7/4G/9pUq7nuSR+24w7pLsRMwqdN0gC2nsMdFGmjOjGaUURJ8BDA2za/ipLqKUS49HsOcxDeVGaIGe6p3Tj5UZ8vSf6W+6kQgWACoNbMjK25eSUMY1NeEH2AbONeJr0tr9TeQfftZDa6D++RLhcUWarlGzbVs8sHpacnTQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qwIvmDBI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qwIvmDBI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mWb+AwONS+dKqECsEDPai4TCm5S4TQL9clAHW/SIh/c=; b=qwIvmDBIt0fDRn4KiiUnGJrHV4
	EclMQWZcD3hhYwNNJqEu/Y5qv0woK3ppstSQO1EgbHghy0OKzqGkY3TD90pPYtCFLfPGGsrJBLcgz
	L9OwjXe0/D/IYppPzXcaClxuG12CKecXnx8SklCbQOFF19XkKZIaNboWCzB0m7T6jnk4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wpYOW-00F482-Gx; Thu, 30 Jul 2026 23:34:24 +0200
Date: Thu, 30 Jul 2026 23:34:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/5] net: dsa: mxl862xx: recover switch stuck
 in MCUboot rescue mode
Message-ID: <f270d6dd-fd8c-48f8-a360-b699f20ac860@lunn.ch>
References: <cover.1784945329.git.daniel@makrotopia.org>
 <f1621f3578126598009313fa21446045e522c062.1784945329.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1621f3578126598009313fa21446045e522c062.1784945329.git.daniel@makrotopia.org>

> +static int mxl862xx_sb_pdi_poll_drain(struct mxl862xx_priv *priv,
> +				      unsigned long timeout_ms)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
> +	int ret;
> +
> +	do {
> +		ret = mxl862xx_smdio_read(priv, MXL862XX_SB_PDI_STAT);
> +		if (ret < 0)
> +			return ret;
> +		if ((u16)ret == MXL862XX_SB_PDI_READY)
> +			return MXL862XX_DRAIN_READY;
> +		if ((u16)ret == 0)
> +			return MXL862XX_DRAIN_FEED;
> +		usleep_range(50, 150);
> +	} while (time_before(jiffies, timeout));

Again, iopoll.h should be better.

       Andrew
