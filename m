Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1593EDE5B;
	Thu, 14 May 2026 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766607; cv=none; b=J3FJBTieN+eiojQY1fAkRVwjUPh1XhyZw88I25owyMzjJ1NoCBN2Bzij0H585rbFKPLRnRItBOI22p3gOCqI9Gem9fCBbhBw477e7lxKsonG0LUqWeuW+LerJf8eHFI+fz1HEfLcOU7PwOVQEQM1UcCBUv13DUy1dBeWD3gJgFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766607; c=relaxed/simple;
	bh=JpnbtmlzYRpqcnYS60A5O/R90rB73HxkCxR/8t+RChM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShlzRxwb7459XMRg5Wd/CSWGfGbtUE8pal7m5POeaixqA8uqubwFQ+geaCpeDmwMk677kPrt3dmwO9dY6q7caW0hRbvDdI51WzqBc6skqLYfxDCELH0Nzrh+Vt2gz+12oAj2S7q4bhiRXFe0b7Uy9hdbtdfh+QaHH2ReiAlAL3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ygI8fOEQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ygI8fOEQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UbytFVbfO60+brh0gQ9j9DNfvN8/+BhkvW5hmOTx2Gc=; b=ygI8fOEQkGWoS5vrYP1WHHU2VG
	ygnYB9Fn0I0yqKTWuuJlx9JQac/fu8qMoyV8qnJDf8JERqWx0uD1K7huUhedmLcrZEwuXhuGD7jo7
	WaYkklby5V2gmQ1ky9sls1vk/Bd0RX3o8uZ2n1Ou/XWdjim32qbSDAGtvJRe1GAMmyl0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNWRr-002ubG-6X; Thu, 14 May 2026 15:49:59 +0200
Date: Thu, 14 May 2026 15:49:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>
Subject: Re: [PATCH net-next v10 5/9] net: phy: Represent PHY-less SFP
 modules with phy_port
Message-ID: <233de63c-f4a4-44cc-bb88-eb10d298b9b0@lunn.ch>
References: <20260513130521.1064094-1-maxime.chevallier@bootlin.com>
 <20260513130521.1064094-6-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513130521.1064094-6-maxime.chevallier@bootlin.com>

On Wed, May 13, 2026 at 03:05:16PM +0200, Maxime Chevallier wrote:
> Now that the SFP bus infrastructure notifies when PHY-less modules are
> connected, we can create a phy_port to represent it. Instead of letting
> the SFP subsystem handle that, the Bus' upstream is in charge of
> maintaining that phy_port and register it to the topology, as the
> upstream (in this case a phy device) is directly interacting with the
> underlying net_device.
> 
> Add a phy_caps helper to get the achievable modes on this module based
> on what the phy_port representing the bus supports.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
