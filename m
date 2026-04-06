Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D8D2848A7;
	Mon,  6 Apr 2026 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775488890; cv=none; b=GG7W0tevWBdYJVueexXqqGg8sX7XfTsMMm0JBYlr5OtE1nrZ1KfV6WhfYsjUWR3+t/xoleMfxYeRQmSYnZEX/l7pozKty2r6t/niHDpsI/kNxBwOgPwah7obmQ6gv7qP+QWzJZv0Lm/6TpFY60sW8m9tFLZk5OyaXVJSA0gq0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775488890; c=relaxed/simple;
	bh=AmZYcerWKHbuE4vZQY4m001zSLq4zCukR86yFGvK8Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQ1Mx8wiHanUnAqaaIdCABjoUo6G7Wo6w5/KxQPnDH8NfnQOlEAnuA51tMbTbcdSTPHd2EElEBgWJJ66TX81YfUk444mlOKhdry4XIA9kjb7J492826YdpPjSizqLT7K7Wzqd0en4G7Z58gUXCSZmo+x4ojpWWWxgQjN7Lwd6Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hD4oWrvZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hD4oWrvZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bBJZcdrlq6njuZ7NtPDabSD9D0aHosSv5qGTTQbgaxo=; b=hD4oWrvZTqW+JLAdmVXNbiDHuN
	PRjQIOPUjUVxbnnSYrgtmvxTFzeVQDs4Z0HLjn2PjLA9HXZUF51FvtC2fMIffwDBTlRncTizAnJdV
	/j1UY50dSz9fJehfjBQRBNf+DYHFco9rPxj+D/goe6HgAdMMBozLKTqxFNxkbiaqZSKc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w9llL-00F0Eo-Kr; Mon, 06 Apr 2026 17:21:15 +0200
Date: Mon, 6 Apr 2026 17:21:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
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
Message-ID: <8e12f0ac-be0d-4664-a533-df3bd1efb34a@lunn.ch>
References: <3597433c-ce26-43c6-9a5f-e942a3db5340@lunn.ch>
 <20260406144324.4007913-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406144324.4007913-1-github@szelinsky.de>

On Mon, Apr 06, 2026 at 04:43:24PM +0200, Carlo Szelinsky wrote:
> Hi Andrew, Oleksij,
> 
> Thanks for pushing me in the right direction here.
> 
> So if I understand correctly, I should move the PSE control lookup
> from fwnode_mdiobus_register_phy() into phy_probe(). That way the PHY
> just defers like any other device if the PSE controller isn't there
> yet, and the bus scan keeps going for the other PHYs.

Ah, yes. That is the correct fix.

	Andrew
