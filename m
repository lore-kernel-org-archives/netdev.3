Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774DE46A5FB
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931923; cv=none; b=HGvoQsuSgNxeVJm8JFvnuhpAntem0BTkgaw5qWv0b8dgKlVsOABkQqgLYRMbCtkVR6X45go+v3GcF8aMbQPm8W8PGt9AYWpfnXUyJOPeIDUkzw/gagoo5ll5T2FXF8C547ggCwx+6qY2/8R4MA4qSkXjyTEM+IWPD8VB5rasgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931923; c=relaxed/simple;
	bh=t9BfsbZCJT+EvsOCeOBWvQXqkfUzucDJ1OkiCv9oJVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxYtiJajffKP5DT/DeKoWspqwgEWPsdA+WiNONXAMqna4xGapDkhgD7YTMSN2JeEQRajgjKc3aabwPdOMVWRo0JzepK1rfJNKjUmybqvIUH1wTaePTC1KxPxOMkOtwRpQV4SFpkV9kRWLoUndHgzU5oGo1oY8ex9od2C157QpNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gXff4Vvh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gXff4Vvh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DUZM7QluoCDrhFXWVYc80R/O6OlcUpvq7LURqImPb4k=; b=gXff4VvhU5tUVZx52Uu9miNmqs
	kPcpUqmk0W2tlciaryivnpu4k3PxwrkKxI8sq0ufRF43HyEBZRhZr7ft7Hgz39E4JSZo3FsImqSdA
	B9Dj3Nrdjb+AwiUmfnLiC7qt+AXs+yFsBolHfNv3JH3fC7prnXxoaDkXwBoKaDMP3Ks8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wraTN-00GACk-7S; Wed, 05 Aug 2026 14:11:49 +0200
Date: Wed, 5 Aug 2026 14:11:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: xuanqiang.luo@linux.dev
Cc: kuba@kernel.org, richardcochran@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v3] net: phy: dp83640: fix per-bus clock lifetime
Message-ID: <19f04c24-cf3d-4730-ae15-ab7f2f7bc3f1@lunn.ch>
References: <20260805072725.169431-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805072725.169431-1-xuanqiang.luo@linux.dev>

> +static void dp83640_clock_init(struct dp83640_clock *clock)
>  {
> -	INIT_LIST_HEAD(&clock->list);
> -	clock->bus = bus;
>  	mutex_init(&clock->extreg_lock);
>  	mutex_init(&clock->clock_lock);
>  	INIT_LIST_HEAD(&clock->phylist);
> +	clock->caps.pin_config = clock->pin_config;

Can this patch be split up a bit? It is not clear to my why this is
needed. If you have lots of small patches, each with good commit
messages, you can explain "Why?" this is needed.

>  	clock->caps.owner = THIS_MODULE;
>  	sprintf(clock->caps.name, "dp83640 timer");
>  	clock->caps.max_adj	= 1953124;
> @@ -977,14 +971,8 @@ static void dp83640_clock_init(struct dp83640_clock *clock, struct mii_bus *bus)
>  	clock->caps.settime64	= ptp_dp83640_settime;
>  	clock->caps.enable	= ptp_dp83640_enable;
>  	clock->caps.verify	= ptp_dp83640_verify;
> -	/*
> -	 * Convert the module param defaults into a dynamic pin configuration.
> -	 */
> +	/* Convert the module param defaults into the pin configuration. */
>  	dp83640_gpio_defaults(clock->caps.pin_config);

Why is this no longer dynamic?

> +	clock = phy_package_get_priv(phydev);
> +	/* Ensure other PHY probes wait for shared clock initialization. */
> +	mutex_lock(&phydev->mdio.bus->shared_lock);

Please add phy_package_lock() and phy_package_unlock().


    Andrew

---
pw-bot: cr
