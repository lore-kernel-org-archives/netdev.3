Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2875B4E3247;
	Wed, 30 Sep 2026 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773914; cv=none; b=CiQ+rZ48DicoB1ruJz2qPOf5z8sGwgkbY2cKA3zUqGhQiUcX623C+YVxDnDf3lloCq7eE1ScbBBzWA4M0dbzwSXuIkTqWwEAoc2qMk8n89YrU2C7fpQd/DsDBVolJhpahzgsHl9ZlY6Y5iR+wvZOgtWdPlZQC6aeOhmjJ8q/l/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773914; c=relaxed/simple;
	bh=ww8M/QnA9OPPQElHyvnBWa+YoAUC18Cqvz6wJTSWbFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fus6z+tJSrkW6sMBYcu2thwfRhW0VV9e5slQKwL5fm8NskHdSIRKKQ8cl05Ns3ig5yYdk2ZV4epe1LV025NmWWtDQ656vQrK11sCHVIxIRLAU7fo8J57RRAc2+6LuiQWERqSGYL5gzMtg0ItcOWR2Q/aEHDcw3S5KdrwJv32cHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BT3gTff2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BT3gTff2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RQmSvA6LECXzyDxWy2pOxmNQIrvr7sbOLRWYdtXIe7E=; b=BT3gTff2xdZdqJ/ds6f2QZOkfR
	qx8uNzIL2UB4MOUTvhdUndl7i2i9BUJsIUKdevGCqr8qDkcVGWpHWwxEj/4AN9SiuL1RVfTsMK0e9
	64YaMddz0cMbTzdSQAu3/Q91ZSWLkhUow86+9JRyPTSjsJjlu8/r3vOHoUlmWwMG06GM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBu5m-008A5e-Hq; Wed, 30 Sep 2026 15:11:26 +0200
Date: Wed, 30 Sep 2026 15:11:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: Marek Vasut <marex@nabladev.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
Message-ID: <c09f289e-4831-4171-abba-4f1d006b3532@lunn.ch>
References: <20260924180607.60932-1-marex@nabladev.com>
 <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
 <AS4PR04MB933887CA9C646F0359D8E61A888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4PR04MB933887CA9C646F0359D8E61A888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>

> No, we typically hardcode the clock frequency in the driver based on the NETC
> version. Another simple method is to set the divisor to 166 instead of 66, which
> will not cause any problems for using a 400MHz NETC.

There are use cases where you want the MDIO bus running at the 802.3
speed, or higher.

Some PHYs need firmware download because the OEM saved $0.02 by not
putting on an EEPROM. I've seen boards take 10s of seconds to download
the firmware on boot.

The Marvell PHYs allow you access to the raw TDR cable testing values,
which is a lot of data. Getting it faster allows nicer and more
responsive tools.

There might be an MDIO managed switch hanging off the MDIO bus, so
again, lots of traffic.

So please look at setting the divisor correctly to achieve 2.5Mhz, and
maybe consider implementing the device tree property:

  clock-frequency:
    description:
      Desired MDIO bus clock frequency in Hz. Values greater than IEEE 802.3
      defined 2.5MHz should only be used when all devices on the bus support
      the given clock speed.

so it can be overclocked.

   Andrew
