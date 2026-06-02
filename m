Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B501ACEDE
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413889; cv=none; b=JFKfYoWlSWpY7KwdbExWjFz4CtgGfjJcKZQIrsWout/JkadXAtm3Vn7e9d3FF7iHQzgV56VsxzARIClSQQTZFe5Yqpg9iusqNKHiusGSkhj7xzKzNOyQe5iGh3EJBjmxFEQ18yvzwzhhFkGQdrqtSOUiYRJ5m5KoH/x8Zvh6jJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413889; c=relaxed/simple;
	bh=efAxzLRSX1Gf9ZhKJsOjcElzro53EInBmQhH2kODPzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYxQZualgz9K3P1jVTl7H1mj2OJJVzqdpJJabGmPaLmcURWFbV1kjKKm++BZmpDB4YC/G77mvPsF2J3+oLnePnYI1mvcikfPV5qun9VkV0I8IQX5QZYGVBfqs1Ofbt89LJ91CDxmeS85aZJaLEvICQu7mNB/dPtuzEacZyQkCWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hlTZRCgl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hlTZRCgl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3jBkTG2xCPPreTQgiYvvXIX15YDDsEfI4b0wZYULBZ8=; b=hlTZRCglfYhO8HpuxQwEvu9dNC
	fckMXOVsd7+dtmTxJibsCOGQgXHet8OpLbl3wrs/aeeXG4l0ZE640X8uv2UU8lI6hFZ7mdFyLtTbj
	81CTJ4daXAMXzBi7upL4kU9sGZQaI/7jbGGq+Z+dy32TpGtxx7q8Nh2jle8oVfKqawfs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUQyt-005i7X-L1; Tue, 02 Jun 2026 17:24:39 +0200
Date: Tue, 2 Jun 2026 17:24:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH V2 2/2] net: phy: dp83822: Add optional external PHY clock
Message-ID: <83ad13f4-2db1-4316-8a62-8d122bb5e220@lunn.ch>
References: <20260528184642.33424-1-wahrenst@gmx.net>
 <20260528184642.33424-3-wahrenst@gmx.net>
 <20260601200122.17d1cea2@kernel.org>
 <9dc8482d-a4cf-42b1-b1c4-230f160af4b3@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dc8482d-a4cf-42b1-b1c4-230f160af4b3@gmx.net>

> > Did it really read the datasheet or is this a hallucination?
> I don't know where these 50 ms comes from, because I found under "7.7 Timing
> Requirements, Power-Up With Unstable XI Clock" a value of 10 us.

I guess it is an hallucination. There has been discussion about a
number of PHYs and how long a sleep is needed after releasing the
reset. It has maybe generalised that discussion and decided all PHYs
need 50ms?

> > FWIW it also says:
> > 
> >    Should this clock pointer be saved in the driver's private data
> >    structure (struct dp83822_private) instead of a local variable?
> > 
> >    Without storing it, the dp83822_suspend callback cannot disable the clock
> >    when Wake-on-LAN is disabled, which could prevent the clock provider from
> >    entering low-power states.
> I wasn't aware that additional power saving during runtime PM must be part
> of this change. So this is required?

The AI often points out issues outside the scope of a patchset. In
this case, i would say it is something which could be added later. The
power savings of a single clock is not that great, when just powering
down the PHY can save 1 watt.

     Andrew
