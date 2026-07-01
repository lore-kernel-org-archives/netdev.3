Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31B535200D
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917667; cv=none; b=JKBsnRG+Q4UzBTLjd0tCtlNuW0WejVZBZgRCa3aMPltzQ10bipqhaoUAOpDxqHIWc+0R4Dp9fRtATeZURtnQ5lpGy/HMR8rxWU2JMG+II9bK81vmLBS96S609J0tIhpjglFaXLRbtk/XO7wnlBQbol0CEu63N6EL31igvc7+f34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917667; c=relaxed/simple;
	bh=6WsiYY7Yuh4V3BiyQgLCPCmp0ZegI+9PTpK9K+M22jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aru4Y36u8CrRV4ngaaSWhuyu6O00z2uob91Hvguap2Md/BQLCK8G/YnM8bofuevjVX0YPbeSwIfVq0vpjAL9bnKoVXDvd0h8Pqz2PvxAdXt6ZSr/+/oy7VarQyPVEnx58WiZaoxn/UQLc76R7GthV0D9dg18nD5XPh+QigNDA5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Gdn7HtEm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Gdn7HtEm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lw/Pr5lLrRdlWXDOCu198oxf1Z0xLB5sJLAaQ70oEz0=; b=Gdn7HtEmYHfWvM37+TNWC/Y76G
	C5OGjXe2izppaFXKHDCFHIO7rtmCxuqtvo1o/EFOTq0cdosAr8aKk3+UZjEiLVNnUGuMm9AxHjeB4
	8Co+HafWu9o005dFht5k9CXgA/7+M69XSHNkuqlzUJIdJNsbjwkaila4KNm2BINkzuLc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wewKV-00ABXA-Le; Wed, 01 Jul 2026 16:54:23 +0200
Date: Wed, 1 Jul 2026 16:54:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com
Subject: Re: [PATCH] net: stmmac: recalibrate CBS idle slope when EST is
 enabled
Message-ID: <7e8fe62b-9f08-47d5-90e3-3b610e30ca95@lunn.ch>
References: <20260701053244.17172-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701053244.17172-1-muhammad.nazim.amirul.nazle.asmade@altera.com>

On Tue, Jun 30, 2026 at 10:32:44PM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Hi Nazim

Please take a read of

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

It would be good to get the Subject line correct, and there are maybe
a few other things in there you currently don't know.

> +	/* If EST is not enabled, no need to recalibrate idle slope */
> +	if (!priv->est)
> +		goto config_cbs;
> +	if (!priv->est->enable)
> +		goto config_cbs;
> +
> +	cycle_time_ns = (priv->est->ctr[1] * NSEC_PER_SEC) +
> +			 priv->est->ctr[0];
> +	if (!cycle_time_ns)
> +		goto config_cbs;

The use of goto like this suggests it is time to refactor this code
into some helpers, so making the structure clearer. Otherwise this is
going to turning into spaghetti.

    Andrew

---
pw-bot: cr
