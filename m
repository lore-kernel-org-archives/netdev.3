Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A783E9F8B;
	Thu, 26 Feb 2026 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118021; cv=none; b=rZmw5nrmwUCJ4em+VXmGQfI+7CQ97qQu6sZK7MQUK76QLLLcGvSBw3L8qwNcB0ZgygpAQwGzKw1rbN0x9Lh8w1wnEebf5sEJ+iBgdwedK/wn5u1/RJB38CMWoUH9qUn9Yqw2koJY4FGBLQQan9j2sWMCf8Pfu4hG2s3Ks757238=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118021; c=relaxed/simple;
	bh=jskO49a5eXiUucT5UDGF2xPMQGAos0220kVEPq/nDec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJboYFBbyFEYmNPfCp+5jjUzfztgn6ZyRWYKwb1ZgMVCXjoKNMKztYy1uzfw0j8M5+er4qZBRs0+kksNTYC55Q/8AXlCNXRsBO9K1XlsLwIlyO5koTuK3hE1QyI+51VZYpPl/+UOwF63EZXTqIk6+SZ8cJ3vlftuX1EVwQQp87A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uLAqvIVd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uLAqvIVd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=q2+1MyIGYsoB1ABEVPdjV2Oghj1fcXPNqjDpJXG8D6E=; b=uL
	AqvIVdGyVMaqpKzriuNmCud31nvoZKTNzTv8pD1SloauulDAvdRDHVS2MxCdqv+R91h5O/ggp2fPP
	dRK48qIxfHszMzlwAcZaD7/OrQEDbh62hYIsCQoXgg6hXaVyo4gqwExN496ZNkO7Dvf7WytP4DekE
	bESypaCeX093mrU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vvcqG-008to0-9E; Thu, 26 Feb 2026 15:59:52 +0100
Date: Thu, 26 Feb 2026 15:59:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	o.rempel@pengutronix.de,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: phy: micrel: Add support for lan9645x
 internal phy
Message-ID: <eaffa59d-bf06-4c06-8368-b619189b2f89@lunn.ch>
References: <20260226-phy_micrel_add_support_for_lan9645x_internal_phy-v3-1-1fe82379962b@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226-phy_micrel_add_support_for_lan9645x_internal_phy-v3-1-1fe82379962b@microchip.com>

On Thu, Feb 26, 2026 at 09:24:19AM +0100, Jens Emil Schulz Østergaard wrote:
> LAN9645X is a family of switch chips with 5 internal copper phys. The
> internal PHY is based on parts of LAN8832. This is a low-power, single
> port triple-speed (10BASE-T/100BASE-TX/1000BASE-T) ethernet physical
> layer transceiver (PHY) that supports transmission and reception of data
> on standard CAT-5, as well as CAT-5e and CAT-6 Unshielded Twisted
> Pair (UTP) cables.
> 
> Add support for the internal PHY of the lan9645x chip family.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
> Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
