Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6A5A0AC4;
	Tue,  8 Sep 2026 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895259; cv=none; b=sKsMHGlqNdDHZBM7GbsJdBv7wQSBf5fY5dikjFgMAKc3kO7ag0SZY7p/wILgbhNaa9wJf2fcZxmU3bjRBJnK0n+aU22rmFNQZr7Rs9G2mwPTV9yKVjAI6oQI5GBvn+gGE74AUWjpVE/LDoydWarhwSEuwDRgQX9F4yVIUyk/gco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895259; c=relaxed/simple;
	bh=aQUa9aKF8CtmeoDK5dRmE9BjmxLpEF6OovuLdCkIxEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dghyg4B+jECPscVqrxWoFMEEWGh5OKVC0UzUpTi6qfMWRqFMqK6aQZQNQOPyhrSayhJEzhfYo0sg3XAIZSCvrrHyiPYYusagR6gp5yjUm2zKfSKV3pzgSkV4LFgINDk/FxCcONfgDK3HpemwvQRWUbr24lFOMNKrfavFuPL6Xxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KDTMT22W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KDTMT22W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gsLhRwtGeeSFdXPNmciMr//60asuRArRQy1EmH7htYA=; b=KDTMT22WEJnE+iHCiIBdei5gW/
	duk9WkY0ZE8ivLEkIBeX30cT6K0tM0PFOC1wOW2rEQTIxY7+aqRDxNkZGXQipHLVf8Of7pXIc+OKL
	PQV62GSsoMRc8SoTQMalJoOxk6kPJAth47ALQl3MVCHFVRhDUNO7uL60SS7QReYG4D5s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x41N5-003yJR-UV; Tue, 08 Sep 2026 21:20:43 +0200
Date: Tue, 8 Sep 2026 21:20:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v2 4/4] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
Message-ID: <5c955c96-7883-4e59-97ef-9fc3b63abf58@lunn.ch>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
 <3c2c5b39-6a7d-4cb2-af1c-b5015b6bf1e8@lunn.ch>
 <db26d5c9262069a11e5cbe00e176b81e40baebeb.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db26d5c9262069a11e5cbe00e176b81e40baebeb.camel@linutronix.de>

> > What is the MDIO master?
> 
> It refers to the switch-integrated MDIO controller: one shared set of
> MMIO transaction registers serving multiple selectable MDIO buses. The
> switch documentation calls it an MDIO bridge. I will rename "master" to
> "controller".

In Linux, we have the concept of MDIO muxes. You have one true MDIO
bus master, and then logic gates to connect it to many MDIO
busses. Generally, the MDIO data line has a set of analogue switches
to mux it to one of the many MDIO busses.

Having only one true MDIO bus master means you cannot do transactions
in parallel.

It seems like this is how this hardware works. The question is, should
we model it this way. Take a look at mdio-mux-mmioreg.c. Maybe the
MDIO bus driver can be placed into drivers/net/mdio, and a
mdio-mux-mmioreg stacked on top of it to provide the per port MDIO
busses. That will make the locking simpler, and remove a lot of code.

	Andrew
