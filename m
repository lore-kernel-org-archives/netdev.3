Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254223385A7;
	Thu, 27 Aug 2026 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853691; cv=none; b=HXZUsExePCqRidNDOuU9CHsxioHb0tzjwEwVmIGIOW18T9vxZ4BhzKwF+wfZYc1tph0tp3ll6iTVdxj4+zhQN8Lc3PDauOrf4VEcEPF4wXO8AqBkSuhdnZcnQrbo9PT7zh0H+dXMUhBVvrQUHasEJYR+ySS+ekJwB1R/vqSY4v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853691; c=relaxed/simple;
	bh=xjHYTvVAPdXcWgMEaLOW7GTLXIyc+D3i5uaF2zA5uQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohV7ppdEGR4YWQIFkfOM9oXoc2D4Id2Ox93HSjk6nhhtNho3quD94F//08Tvzi5t6EF8inmE/jspkXaBQlvQZbaboxHPDJdEqd8fC50iYtGcrWpADjlvUaHSUvI7GUrIpOINemm6/sgYBjDK+PZcu49Cm1tjFg9zjSM1pYNkev4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SkO8uxbG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SkO8uxbG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iPYQvuqGHB61UwA5cNaGH9WbzQWQgMRHVbwMB+DXyVQ=; b=SkO8uxbG/3AGPp1lq9tr0aFqVZ
	PFIX9z9IbI6i7X27gJKsb3+JRV6uF2viGN1EM2FGrGfayUPMX8Y/HjLSJY6CeNl4BakFKKvQLCmFX
	24qLbs2lvBifT2BLE7HP2EoButgW881KmpPT3Cy/LsqfJdafoay8rJA6dfvtEw+89Y9A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzePa-001hei-DZ; Thu, 27 Aug 2026 20:01:14 +0200
Date: Thu, 27 Aug 2026 20:01:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Weiting Lee <weiting.lee@airoha.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: air_en8811h: select LED GPIO pins based on
 AN8811HB package variant
Message-ID: <8530a501-705b-45b2-b876-68855955bccd@lunn.ch>
References: <20260827054156.2681908-1-weiting.lee@airoha.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827054156.2681908-1-weiting.lee@airoha.com>

On Thu, Aug 27, 2026 at 01:41:55PM +0800, Weiting Lee wrote:
> The AN8811HB comes in two package variants, AN8811HBCN and AN8811HBN,
> which use different GPIO pins to drive LED outputs. AN8811HBCN uses
> GPIOs 0, 1, and 15, while AN8811HBN uses GPIOs 3, 4, and 5. Using a
> fixed GPIO assignment causes incorrect LED behavior on one of the
> variants.
> 
> Read the package variant from hardware strap register AN8811HB_HWTRAP2

Just for conformation, this is not an actually strap pin you connect a
resistor to, pull high/low, but a read only silicon bit.

Also, you called it a strap registers, yet the #define is TRAP?

> @@ -202,6 +214,7 @@ struct en8811h_priv {
>  	struct phy_device	*phydev;
>  	unsigned int		cko_is_enabled;
>  	struct mdio_device	*pbusdev;
> +	unsigned int		pkg_sel;

bool?

Also, is_an8811hbcn would be a better name. It is hard to know what
true/false means for pkg_sel.

> +	phydev_info(phydev, "%s detected\n",
> +		    priv->pkg_sel ? "AN8811HBCN" : "AN8811HBN");

No need to spam the log.

    Andrew

---
pw-bot: cr

