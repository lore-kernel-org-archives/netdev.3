Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54263E275F;
	Thu,  4 Jun 2026 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575132; cv=none; b=jR+M7Pg3+tUop1TqLpJROToigszPTVnN/BxHp7qkIj/NgYC/dvJYEowfAsJYXNzpo9o8T9rrb76IRcyvjOIs0y6dipDZJqOLWD9bZJffqFWqf+RJD80e0KUP4VFPq180uF4IHgHrKPdRGNoKAcbs9ZynobxEQ258KEOLxxeCeqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575132; c=relaxed/simple;
	bh=bTaX4i/RX4ACFAzrRgnPAPGlzAIVvnWFoJQBnbLN/vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPtlgpOT51HVScKhAi70rnfydQY0/b3rJeEe4H7XvmQkTjVspnw7G/56aVVhQMfOTsw92JLss8J2hhjCI3x83VuKfDMTdEqg3kCQ+iXNIaitjX6YsJ/bANDn60li+Uuo9MBB8jSZ9Li5h/OgpxY9hJNdhbZyAmX4gpMMETVDSE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X1GUEf7o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X1GUEf7o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1AnpqOOGCSERVKBQiDuHYbU7BPpirRbksOmqLRqLHA0=; b=X1GUEf7oxPrFYVA8cckhb9yF1g
	Esq4lVk9jOQyK8T2U5FVZe7R5ApK5uzkcygR5d/5SpDYvggfvYa98oMdx+T20hHDbPTNcPldAgKiT
	mRRmMzNiTb/gSxuwIquuF4NLbHKkZxk/bLbgSl3BjPdjaGLq0ir7ZHx7yW6i4QqjZ7Mw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wV6vQ-0062Tk-IP; Thu, 04 Jun 2026 14:11:52 +0200
Date: Thu, 4 Jun 2026 14:11:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: lawson.fidelio@gmail.com, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	marex@denx.de, maxime.chevallier@bootlin.com, horms@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	Tristram.Ha@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, nb@tipi-net.de,
	fidelio.lawson@exotec.com, marex@nabladev.com
Subject: Re: [PATCH net-next v9 2/3] net: ethtool: add KSZ87xx low-loss cable
 PHY tunables
Message-ID: <0be0b8e6-8aa7-440f-9214-2951187a80b6@lunn.ch>
References: <20260601-ksz87xx_errata_low_loss_connections-v9-2-fdbbb15592cb@exotec.com>
 <20260604114119.170747-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604114119.170747-1-pabeni@redhat.com>

On Thu, Jun 04, 2026 at 01:41:19PM +0200, Paolo Abeni wrote:
> From: AI Reviewer <ai@example.com>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/
> ---
> net: ethtool: add KSZ87xx low-loss cable PHY tunables
> 
> Introduce vendor-specific PHY tunable identifiers to control the
> KSZ87xx low-loss cable erratum handling through the ethtool PHY
> tunable interface.
> 
> > diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> > index 1cdfb8341df24..a2091d4e00f3f 100644
> > --- a/include/uapi/linux/ethtool.h
> > +++ b/include/uapi/linux/ethtool.h
> > @@ -291,6 +291,9 @@ enum phy_tunable_id {
> >  	ETHTOOL_PHY_DOWNSHIFT,
> >  	ETHTOOL_PHY_FAST_LINK_DOWN,
> >  	ETHTOOL_PHY_EDPD,
> > +	ETHTOOL_PHY_SHORT_CABLE_PRESET,
> > +	ETHTOOL_PHY_LPF_BW,
> > +	ETHTOOL_PHY_DSP_EQ_INIT_VALUE,
> 
> [Severity: High]
> Are these vendor-specific hardware erratum tunables appropriate for the 
> generic global ethtool UAPI? 
> 
> These tunables use generic names for device-specific KSZ87xx workarounds. 
> Since UAPI is permanent, adding hardware-tied erratum parameters without a 
> vendor prefix or standard abstraction could lead to namespace pollution. Would 
> devlink param or device tree properties be a better fit for this?

Devlink is currently not used with PHYs. I could be, but it seems
overkill when we already have PHY tunables.

Device Tree properties don't make sense, because it is the cable which
matters here. It is 1m to the next rack, or 100m? DT does not cover
this.

The concepts are generic, but the specific values for the setting
could be per device. But i also doubt this is going to get much use,
and anybody actually using it and just going to try values until it
works.

I don't see any issues here we need to address.

	Andrew
