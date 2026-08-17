Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790CE43E48A;
	Mon, 17 Aug 2026 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786978447; cv=none; b=BybUJSIYvdMUyxXg0eaL46GtV1FJj7/FfFbMo8+TG7WJVWe5JQDG6EFKVIjNSN7DzRajvmBhUKzfCj4hEMFtYBqdeEI/4uLuYWkt7b/TQiQfANLoggkz+Srfh7W0UJfhfUBNryMmnSr9A+wtwAlsBd5Cw4Zex9GBTkt5qDcdBFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786978447; c=relaxed/simple;
	bh=UFzLE1vzZeQIjdt9XIgTIGl0x6T6QF8WdPrXq9D1POE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5UzABt6t0mjY/9vj4Z3NdJns+Cd6k+UJe1zwUrgI2q97GEAhBFGGW2dc4PC1p5+TLDF75P2YoL95L5nYc9gaIh2OZ6nW1vCrOWSSaWZ+Wf/MEVMa5D2RdQak+idmY3vM5eSe4wLEAUBzBR3EsEnsEGWcPbv8s60dTW2ihBWm74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CzFmFiSF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CzFmFiSF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=v7MF3GK3CKX8dNELG9br75jWb76cxqBI+i+JqBxkNbk=; b=CzFmFiSFbx5in1kD5RN3H0fOiM
	a4M1jduswR9ag1oJShBNqVKFHOYdk9D8wbm4tV7DY8ZexAA67dQo+RXkb2qAmrOHB2SmQ4eRYPXtn
	Vdxs5CB0lw28TQXtW+E9cmtkGnh2WofV3gbzQnKPoZbz4z1UN4eB+0klJ4vbjUVl0IBE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wvyim-000KJb-JS; Mon, 17 Aug 2026 16:53:52 +0200
Date: Mon, 17 Aug 2026 16:53:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 2/2] net: dsa: realtek: rtl8365mb: add EEE
 support
Message-ID: <8be5a31d-55af-47ba-bd7b-4e581c3950bd@lunn.ch>
References: <20260817134758.4182833-1-o.rempel@pengutronix.de>
 <20260817134758.4182833-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817134758.4182833-3-o.rempel@pengutronix.de>

> +static int rtl8365mb_phylink_mac_enable_tx_lpi(struct phylink_config *config,
> +					       u32 timer, bool tx_clock_stop)
> +{
> +	/* The hardware manages LPI itself; there is no MAC-level LPI control.
> +	 * This callback only signals LPI awareness to phylink.
> +	 */
> +	return 0;
> +}
> +
> +static void rtl8365mb_phylink_mac_disable_tx_lpi(struct phylink_config *config)
> +{
> +}
> +

So what happens when i do:

ethtool --set-eee eth42 off

or

ethtool --set-eee eth42 tx-lpi on

I don't now what phylib does with advertise in these cases, but maybe
you need to go behind phylink/phylib back and set advertise to 0, so
that the MAC does the right thing?

Or you need to return -EOPNOTSUPP for these?

	Andrew
