Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B968C1E51D
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756849983; cv=none; b=gd0Ah/0y9X/vP9lnIr3ElmbWU91GbA7GDH4OKh5gCNeztKAbqCT9Lj/KBQnuqqluN8XJYMdgi4sijpB5RDIsMdUfMvOoQrAn2U2a89TbbQ/TvGS4qG7vik0w4fVzUGKwsoSNJEzAGw3Yp8/NYy+17uPmMoVKwswFq1sUntOHYSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756849983; c=relaxed/simple;
	bh=TB8e3cDfP16WOsQtTR5vTNkTWNYiXzhMeHeO6sQKiFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF6sL8ijUnwlMZTqshcR8qUmxNPhpnKpn7VIhrbrzxqHm2UXCkeAhxt2X7T+ai7fe2LGMu6NciWYLtfPvfqQ3GQlrHgWTUeX2WkBiaHWGfwDT+zB6vQ6JeHDIlYokB0kkM/fiIKKoljG1q02JSzIcCLaYGY5NOaDemXFiVuwOdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vryX3XCu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vryX3XCu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=McrrxurPjiqwpb8sV8sduf36e0UGnFG9j0KyN2oC5JU=; b=vryX3XCuC+PBn44MqRK09wZ6az
	4AN4Lkfr3NST2A48BCd5GTWPULfxpPx5W3I2hUA8gMCRxdnpkSMHl515dUcRo04pIo4BakFBGU/An
	wugv0AC9ReQtckQV78ptvMDG9VQwFQhwuqv3/kcEdqzuaNWbZTZ6hLivyEg/nQDBxdw4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1utYvu-006wC9-MZ; Tue, 02 Sep 2025 23:52:54 +0200
Date: Tue, 2 Sep 2025 23:52:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mathew McBride <matt@traverse.com.au>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 2/3] net: phylink: provide phylink_get_inband_type()
Message-ID: <62f94e80-fa6a-4779-be75-34ae1f314b1f@lunn.ch>
References: <aLSHmddAqiCISeK3@shell.armlinux.org.uk>
 <E1uslws-00000001SP5-1R2R@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uslws-00000001SP5-1R2R@rmk-PC.armlinux.org.uk>

On Sun, Aug 31, 2025 at 06:34:38PM +0100, Russell King (Oracle) wrote:
> Provide a function to get the type of the inband signalling used for
> a PHY interface type. This will be used in the subsequent patch to
> address problems with 10G optical modules.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
