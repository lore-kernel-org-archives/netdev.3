Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826411;
	b=ZHkDON/HOdb9bO7JIh77NAzLRocbPvjrKfIn1ZIhRiKG7ox45UYx+c2zYRJESE101pXC
	 VgFSFEZR58a0LAK8OxaXNvtJ7RzWjmAWg6RMpulrz9EX08ss9AE6rZNPCRqOVPMkFKTqR
	 v0nyIhEVBpNNCgHb36n9yIGUJcAp++pZd2EJNhPPCL/R+8D4CkXcHae5Wf08jaTHE6sSq
	 hagV//Q+y77gf91Z4EAlo4txeUGMKvhCwHVRoreGywQmqYFP0P7RVxjjgZ+Uh8skQkh8W
	 I+Y30DRgMUq/FaRWabjCjSYdWIQhS9PPjU/yCaadUgGCknA8gsjjTT2JIpL/BE4ookA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826411;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=bmyZRAr/fzqETDf7KUmFNioNYdP8sCPB2LYnaAnEY1M=;
	b=GcHjYpWI3Myh3+3nGdzHjrajlIllN6vsaOyQ1djyVIq+12rQNmtSnTpDrdanbKFvGrJl
	 eG3UqpY5PZYk9t7kcS+Y+hyMFuC3Bhy++LEanjs8md0/wiQaxagPUuO/tx/faR3WN9FzP
	 iuK+3svll5VI6vadfoYMrK1TEllMq4eqZ1cFO/vtXOGFN8kANt+IB3bvVwaYdOZ1AVj/E
	 hT54wkJvRSknGCs5w0N8Bvbl3GZMImWB7TvO7m8q3tFoP42teQXEm1G7bf+Lc9NNABKVW
	 GrpYBgOIeLsqATe3TRDZksGteEVKX9fFfgZIqTIGC4oFTUUbFbFKxzmhgNLyP8BJK+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=3w3rUZun;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335CA606D834;
	Wed,  4 Nov 2026 21:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 335CA606D834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=3w3rUZun
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=bmyZRAr/fzqETDf7KUmFNioNYdP8sCPB2LYnaAnEY1M=; b=3w
	3rUZun2YsXj23IZuBmoF5mP9RNEn61KLtokMC95mGNYEVmeQ5LRKM+EeStHEnK/IahlJq6rJk4JS5
	u9i8JRW4Z3Cmv2BTLGhRRCi/90aK5wR3KhyUb8/hWW9L/IeqvrkgkfEQyOKeOnmz7ZNDh9u0jPmov
	2cFKQnwvTUdSdJ4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOiBs-00EO5q-Cx; Wed, 04 Nov 2026 22:06:40 +0100
Date: Wed, 4 Nov 2026 22:06:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: Iustin Stolniceanu <iustin.stolniceanu@analog.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ciprian Regus <ciprian.regus@analog.com>
Subject: Re: [PATCH net-next 4/5] net: ethernet: adi: adin1110: Add OA TC6
 protocol support for ADIN1110
Message-ID: <5ef1e25b-2d6d-4cb1-8030-756d60c37c47@lunn.ch>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
 <20261103160918.409701-5-iustin.stolniceanu@analog.com>
 <aus-LdkVRPxR6lFu@analog.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aus-LdkVRPxR6lFu@analog.com>

> > +static int adin1110_set_rx_mode_tc6(struct net_device *dev,
> > +				    struct netdev_hw_addr_list *uc,
> > +				    struct netdev_hw_addr_list *mc)
> > +{
> > +	struct adin1110_port_priv *port_priv = netdev_priv(dev);
> > +	struct adin1110_priv *priv = port_priv->priv;
> > +	int ret;
> > +
> > +	mutex_lock(&priv->lock);
> 
> guard(mutex)(&priv->lock)?

netdev Maintainers have a strong dislike for this sort of guard. Not
in this case, but often it protects too much, since the end of the
function is frequently passed the end of the critical section.

The scoped variant can be used, since that explicitly marks the end of
the critical section.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Using device-managed and cleanup.h constructs

Netdev remains skeptical about promises of all “auto-cleanup” APIs,
including even devm_ helpers, historically. They are not the preferred
style of implementation, merely an acceptable one.

Use of guard() is discouraged within any function longer than 20
lines, scoped_guard() is considered more readable. Using normal
lock/unlock is still (weakly) preferred.

	Andrew
