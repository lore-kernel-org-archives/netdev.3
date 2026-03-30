Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3B53BD654;
	Mon, 30 Mar 2026 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774879905; cv=none; b=VjXsqY8R401N3Bmwin2TRxaKl4+H0lxmtWlcBDUnH9qEmqV5OEYGZ19Hf9VryLKi/0yq3CjVcOYtMi660qeY8K0rgfUMnaHD2p9fy1AWLk4awIBX2UaKkVtMQFb5OjwnDk18N4ZNfVhHfQvwmnFI4V+w0tEMqGJFEEpJYo8v/QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774879905; c=relaxed/simple;
	bh=/qNKfL04owZX2gziD5etRAnBI41FRDVk+5J2uKICMRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezDToSNTnTqfZUhNa6YkTx2BpNHvi6gogRfCWwc0tIySEWHIVSNlB3XC4UDM789RhjcNF4xwc4REz/IZUCRVjEI+PSZkTr6/Ai3B0oOuVlAwy8YssZ1BQtw4PgMabULRllV0TafDM53funNlefMoCZmCRvHrX4I2KCEgfzXRmuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XAnwjqGM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XAnwjqGM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rnYdruBnHlsjyOSlM6GbHyKdjYmgAe0JBFYfEHt7Q/U=; b=XAnwjqGMUoh9zwkeA9cijsfPRI
	NBSbT9AeMSaBJA6xKqJkl2dfAbm6EWuNDOWakTWoNMq5926VIJJuMeeMnB8eKSRDdbt+hkfcL2lMa
	1bN6HJRSPTaq2lBZ9TWp4TvYdnmrMqzNEsFw5+WL0QzLA5gvvK2zGFPPcvMKY6hDdfC0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7DKv-00E2hz-02; Mon, 30 Mar 2026 16:11:25 +0200
Date: Mon, 30 Mar 2026 16:11:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as
 non-fatal during PHY registration
Message-ID: <61561526-1e8c-4d0c-a0ff-56da25ee6531@lunn.ch>
References: <20260329161014.2908509-1-github@szelinsky.de>
 <20260330132952.2950531-1-github@szelinsky.de>
 <20260330132952.2950531-4-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330132952.2950531-4-github@szelinsky.de>

> Treat -EPROBE_DEFER as non-fatal, allowing the PHY to register
> successfully with psec=NULL. The PSE control can be resolved lazily
> when first needed.

Is there a reason not to do lazily resolution all the time?

   Andrew
