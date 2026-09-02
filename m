Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75362868B5;
	Wed,  2 Sep 2026 00:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308179; cv=none; b=UzUhuaCIT/3+XLW8GFBbI7WkiIp/dhqwQkGZGJOB4SnEU95jFFq4CsPaCQ5bjOKuNGKA0/8ACtlcR4p0KQ+JcylnzpkvoNyq4p3uVDVkIXM+mKhjjHeHBZYPNmkaAyu3bmDC/crYOVXnnb5Q5VXDVGMeMcyJUb/exz+CXJg3IRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308179; c=relaxed/simple;
	bh=SpS8SxtsgQy6RtGqEjtAyABITQJR7jDznV65nLJeKk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plUpq3+YOtvfex4z52bxJ+TRPo86VqTSmnAveogC0MfYm4l16pqCALOYZdG7ooGYZmH2Wk67bakMKcovOZnq9w9BTQZXAihoVQhQJ6DFY8/8LUHj8ZrcFGQvshyia3fTRL/J71IWjYIxI5z6eXaqCG4N8E7DiK+74VrVChugb4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xsqirk+2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xsqirk+2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CPeTIDu6FgBKe9+z7gFBAQ7RvAo7N9zD5ys9T7ZuggU=; b=xsqirk+2ABi7LvvxujY/0hBxNP
	lc8xRLoLaEVrzKrMKxIUTb5heJKUnMwFTNZmvUK4pw0lYUPBECuTwNgK410+r4gfQEUTtfSsObDn3
	mFZ9cM2kaZuJI2swV5A9ramG0ubobly0m4edMEW2Cq5hdXMokM0Uriklnp0UObosk8ao=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1Ye2-002Rbj-DW; Wed, 02 Sep 2026 02:16:02 +0200
Date: Wed, 2 Sep 2026 02:16:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v15 08/13] net: mdio: realtek-rtl9300: Add page
 tracking
Message-ID: <756f8e8f-324d-4dfd-b944-1c71cac73403@lunn.ch>
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
 <20260831143439.2404484-9-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831143439.2404484-9-markus.stockhausen@gmx.de>

On Mon, Aug 31, 2026 at 04:34:34PM +0200, Markus Stockhausen wrote:
61;8001;1c> The hardware polling unit of the Realtek switches has a very special
> handling for c22 PHY register 31 (aka Realtek page register) in place.
> 
> - On the RTL838x it is permanently reset to zero.
> - On other devices there is some magic saving/restoring (aka parking)
>   in the background in place.
> 
> This makes access to PHYs a gamble.
> 
> It is vital to keep the polling alive so the MAC layer can rely on
> consistent data. Intercept access to c22 register 31 and handle it
> internally. Store the desired value for each port in the driver. When
> issuing hardware access to other registers add the page to the command
> towards the controller. Given this, the hardware will run two c22
> commands that are not interrupted by polling.
> 
>   ... hardware poll ...
>   phy_write(phy, 31, page)
>   phy_write(phy, reg, value)
>   ... hardware poll ...
> 
> Looking at this implementation one might argue that disabling/enabling
> polling might be a cleaner solution. But one must remember that
> 
> - This driver differentiates clearly between C22 and C45 buses. During
>   probing it enables only one of the protocols for a bus.
> - All known devices run RTL8218 (B/D/E) or RTL8214FC on 1G
> - RTL839x gives link flapping when deactivating polling for a port
> 
> So a solution for a Realtek-only ecosystem is required. This commit
> copies the downstream-proven driver-only page handling patch without
> any new MDIO callbacks and is the lowest common denominator. If a
> non-Realtek PHY is identified on a c22 bus the attachment aborts. It
> should be noted that bus scan runs with the page handling already in
> place before the check in notify_phy_attach(). This is accepted for
> now.
> 
> Remark: To keep this simple, writes to register 31 are only accepted
> if they are lower than the device specific raw page - 0..4094/8190.
> Otherwise -EINVAL is returned. Under the above assumption (Only 1G
> Realtek PHYs on a c22 bus) this is no limitation.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
