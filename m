Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DA539CCE7;
	Mon, 31 Aug 2026 23:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788218212; cv=none; b=dyoE3/E3xM3QItgLrEICBGnPtSrmGhpD8J4cGUowj2SQ7alEeiykZKVg9FsPwmYz3Pm5vTMNjrfo4Wd0n0U7thmOfgM4JZuByLEe0quxZXOEcKsNwZUh5SNmwX/Bx6FLKHhqzV6p6ORF2QKPMprSHrdmpltZpZoktOD0J7alxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788218212; c=relaxed/simple;
	bh=CG3xpNUx1GON7vzrSUlj4xrH6Vmu/ys2Eow6nbv2b4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILts5aK2KxI19+oa9CX0bbAzrvcs1mhzKorjzi4yQ3c6QOrHJKW6mLZvypZYcRlIW2ojx+nX5/ke8AD8M6P70wGIs+1gI2DE9LSCAXV+CUUUi/V1kkcFsy8HFqaHUl5YV58sBFpxr9VO9pl0R6tIbRCz2CQl3RFZ+ui2Bxwc/J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nPqth0AR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nPqth0AR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=R7AyZ+CbhB+gfj26PMQzoe2eUr3XSPphrQVFTAUnT80=; b=nPqth0ARPSTjuzaM3WR6Yql4iY
	maCwNcLsqvesqn1nM9adkOFR8WwWcekXatEK/emldeGUmPnADyJ5F/D6WSjjoOwS5EthHK/8IwLt7
	HQBcC872v6FImVD9DT4uXTD5cehQ/bXiFwhybFxxgi+pEJjp/V4uThlb9k1vcz6Q5liw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1BEu-002GlZ-9p; Tue, 01 Sep 2026 01:16:32 +0200
Date: Tue, 1 Sep 2026 01:16:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: phy: restore the interrupt after a
 generic-driver bind cycle
Message-ID: <73c89796-3ee7-4ccf-ae93-926411218702@lunn.ch>
References: <20260827211638.63395-1-f@lex.la>
 <20260827211638.63395-3-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827211638.63395-3-f@lex.la>

> +/* Give back the interrupt phy_probe() parked when a driver with no interrupt
> + * callbacks bound. mdiobus_alloc() defaults bus->irq[] to PHY_POLL and the
> + * bind cycle does not touch the table, so whatever the bus recorded there
> + * still stands. Only the parking is undone: any other value the PHY carries
> + * was put there by someone else.

Please read this again and think about the use of park. "parking is
undone'. What parking?

    Andrew

---
pw-bot: cr
