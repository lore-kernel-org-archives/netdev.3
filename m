Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCAE420484;
	Wed, 15 Jul 2026 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784121422; cv=none; b=FEcc47zLw8XJV3vVrmcSICh/47KhcoEJqgbyain/FqE6nQJzfqKK6bEs8OQZ/Yir4ki5R62YIEJVO7h2rIY4LfUi/wlKKRCtdKkHvLjbHHDLL15NHDtY2akDqJhN38E3eD0YkiBAnpe3k04bbNUIXh6EvvB1yxwcP/gaDfgYsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784121422; c=relaxed/simple;
	bh=4eaAqsSLPMaUmn+JdNb8R6a5uiy/n6kgKCAMJJi8wjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm1fyl5z8JYWfPixHyD7gMuwHQriZds+TMY7zUAXQ3G7UXlQNWBPVNlmd8TbrdQUoXLV9Op4WiSSUrRoL82Br0RhU7O4n8a/8tYsri/+DnpdfZTUdfM5pkyhsop98TzLgF2jkAjlFNEna0ceHIqjN7+3lrIQKdLKbSxxDaBf+oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N+JeHcYT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N+JeHcYT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5OjemBGFq0xEiP8gGEzlXdfctLtRgmgpTuRIB16Swlo=; b=N+JeHcYT7NGUQsD+NdqVHjyJxz
	aUGBaW29loxZrbq4GO6zEPuHaVTxaHBKMAqS8oJaAEpzieDOf0ixoLwmh9YF8sdNP4u7edYx7oWnP
	z9FTLhCT2ZnKzmBmLIOS9wQOi8V3e631G8SU1B61Z5tl1Rv73I7BnMjct0HsFhnE8LOI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjzTo-00CME5-BL; Wed, 15 Jul 2026 15:16:52 +0200
Date: Wed, 15 Jul 2026 15:16:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: at803x: Use a helper to check for phy
 reset existence
Message-ID: <f4c935be-7b4d-4852-bca4-2d04d342af4d@lunn.ch>
References: <20260715101355.88536-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715101355.88536-1-maxime.chevallier@bootlin.com>

On Wed, Jul 15, 2026 at 12:13:54PM +0200, Maxime Chevallier wrote:
> The at803x family of devices are subjected to an errata that requires
> hard-reseting the PHY upon link change.
> 
> That can only work if there's a physical reset line wired to the PHY,
> which the driver checks by looking if there's a reset GPIO configured
> for the MDIO device.
> 
> The reset may however be controlled through a reset controller, which
> isn't accounted for in the errata handling.
> 
> Besides that, PHY drivers aren't expected to directly access the
> mdiodev's resources directly, let's therefore wrap this with a phylib
> helper, that uses a similar mdio helper to check for reset existence.
> 
> This was found in preparation for bus-level resource management for
> better mdio scan support.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
