Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE97237713;
	Mon,  3 Aug 2026 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775771; cv=none; b=Qrnsx1PW2HBVIcwhZ7YECQtbeQvT2nqTkGOdaTrWy1vSQCjrcZ90GNscQlBkfhZmlMaJPZrbGemFlzOmY9kyRx09ecr20FtX0cY/fQoIP8ETHb4juhl90Yd1oZj+tMY+KEOsB9jpisVCHMkdx3CHcw90q/fJOXX0icrmwhMrhAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775771; c=relaxed/simple;
	bh=XRslH+ds/XEmRs/mI27Lty7v5b9whUZvYbha/qDkt6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGVBRPK8ZUgiy+RaI3FpZcPQw3HSIQUrpy1sAA92LmiHoNHvXpXHlr7C88+VYNQ2ZDdLvYtLm618CZhBXsz+xWlTUeO3BiSLNNCp7ymI3UO8NDFBTnb9Tuc7n9zrlW5MzyWEByJEVQoP7+djsH4YH9VAxeqyIPiOrdZ212f3sNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=19i8IK/c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="19i8IK/c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YQ7ugXHM89P+ZpYBYZd1EkFIhNDujOCisPw+4orVrxw=; b=19i8IK/cMs0rIkjtGJAvvhzsvk
	LEmOaOpnwyd+brsGoXqlDYZYXk/FcTW3u6tqMgbMEI4dc9fV2MZtYeeHoMj+Uw+Ms9a6Pva7yknth
	uvsFa141Xj8vadBeTSffof4t91/PDDP/GU3FtOrhW6GRs2GnUpj83qtdNGpFQQtDt5OM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqvqr-00Fm97-9D; Mon, 03 Aug 2026 18:49:21 +0200
Date: Mon, 3 Aug 2026 18:49:21 +0200
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
	Martin Kaistra <martin.kaistra@linutronix.de>
Subject: Re: [PATCH 4/4] net: dsa: soce: Add initial driver support for MRS
 switches
Message-ID: <653d9c23-6087-4e7f-ac01-fcb01ade405c@lunn.ch>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <20260729-devel-vstrassheim-soce-dsa-ml-v1-4-be569dae1b20@linutronix.de>
 <f17d3a62-456f-4580-90bd-c54a30dceddc@lunn.ch>
 <cee2e05d931a977d0db938ada0964d05885949a5.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cee2e05d931a977d0db938ada0964d05885949a5.camel@linutronix.de>

On Mon, Aug 03, 2026 at 06:01:23PM +0200, Vasilij Strassheim wrote:
> On Wed, 2026-07-29 at 22:05 +0200, Andrew Lunn wrote:
> > > +static u8 soce_map_stp_state(u8 state)
> > > +{
> > > +	switch (state) {
> > > +	case BR_STATE_DISABLED:
> > > +	case BR_STATE_BLOCKING:
> > > +	case BR_STATE_LISTENING:
> > > +		return 0;
> > > +	case BR_STATE_LEARNING:
> > > +		return 1;
> > > +	case BR_STATE_FORWARDING:
> > > +	default:
> > > +		return 3;
> > 
> > #defines for 0, 1 and 3.
> > 
> > What does 2 mean?
> > 
> > Since you don't implement bridge offload, i'm not sure having STP
> > states makes any sense.
> 
> I tested bridge and STP and observed the callback calls with something like
> this (reduced setup):
> # ip link add name br0 type bridge
> # ip link set dev port0 master br0
> # ip link set dev port1 master br0
> # brctl stp br0 on
> 
> That probably wasn't enough. I'll take a closer look at it and either fix it
> or remove it for the next version.

For a really minimal DSA driver, look at mv88e6060. But it is also
really old, and does not always follow best practices, e.g. .phy_read
and .phy_write which should be replaced by a Linux MDIO driver.

	Andrew
