Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749AA28B7DA;
	Fri, 23 Jan 2026 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769184709; cv=none; b=SQlK6zzC4n7pNy0qqUxynBEpnz5jLbFBW8GeS+3gZwqoRfwpwED4oNOa1BYLWb38RO7zbgXvJqMA374sHyp1f8ttVSEZUsm9aysoErb5kLrq0leKHJ87229oxV5243TA+fr5aCAiTk0FJ4+0IjMwiQ3zzsWbjKNapoarE/SRu4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769184709; c=relaxed/simple;
	bh=0z4+lbLVtB1Bl8VmUsNrMXf6ssJU5lPW4tWzM/A9ROw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2XkVBnw8MBV3MWTw0QMJx0YnPhAQ8/qHci04F+EBmKO+YOgyeG5Ss9f7eaHw9KVLNz49Mg+sTUy6u0Yar8uaR+gjTTbKk3Vufu8eFO+AvI3SXkcSoix6bokJKSjUjCYq7dDungwHdADH4m2BXeVt3dOcI62kLcF8D5D5xXXy0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PE+fRvek; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PE+fRvek"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4pd/6d9fQ4GtIOJwLKKuGDzNxeSuaDvXw0J0JlQNkO8=; b=PE+fRvekgjI0orvie0jo/6gKZN
	my/EMe3HNwU4fPZZ83wUkD0E92hgseNYwffwoNoYr6/S+GfNd/xEheHJ/WUXpzYgYaujA3ESKwA/U
	LI59JF1qQEe4RAtF5qylFTlzk9tYy+djO9bg5DrU1zTe9b/PjPaD3WcE2DdvFUsIN7mI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjJl0-004BmD-FD; Fri, 23 Jan 2026 17:11:34 +0100
Date: Fri, 23 Jan 2026 17:11:34 +0100
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
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for lan9645x
 internal phy
Message-ID: <6f80050b-558c-4be3-89a0-a242ee528ea9@lunn.ch>
References: <20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com>

> +static int lan9645x_config_intr(struct phy_device *phydev)
> +{
> +	int err;
> +
> +	/* enable / disable interrupts */
> +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
> +		/* This is an internal PHY of lan9645x and is not possible to
> +		 * change the polarity of irq sources in the OIC (CPU_INTR)
> +		 * found in lan9645x. Therefore change the polarity of the
> +		 * interrupt in the PHY from being active low instead of active
> +		 * high.
> +		 */
> +		phy_write(phydev, LAN8804_CONTROL,
> +			  LAN8804_CONTROL_INTR_POLARITY);
> +
> +		/* By default interrupt buffer is open-drain in which case the
> +		 * interrupt can be active only low. Therefore change the
> +		 * interrupt buffer to be push-pull to be able to change
> +		 * interrupt polarity.
> +		 */

It is not stated here, but i assume that there are multiple of these
PHYs in the switch, and each PHY has its own independent connection to
the parent interrupt controller? There is no interrupt sharing going
on, which is common with discreet PHYs.

	Andrew
