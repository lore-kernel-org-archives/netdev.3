Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9033D3CF8;
	Wed, 21 Jan 2026 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769030342; cv=none; b=aKfeh6vAh73l1/1ryffQIIglRR6Z16o6EJ8kwosQJOp/LW31ivnxS6TuocK4Amvzh7gXdSpLE7B81ivygx+7ahiLx8HMLQagQ0nh7zdwJLS5cfM3mi5MZtiRvaiN4IxaV4vgu0Skx2nr5nVeXrXXZwXZE+5jnoRPEfVfVdMj//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769030342; c=relaxed/simple;
	bh=PRXUWYmg4UcNg6vhKjwLMwhXeWqRiK/BFD8FDFLx6SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gL7xKur/ayoLiysyAVEClw3PomlXfzJSefDQ9DXrRqh3jFTbxYBW2euEPS7CqQZLmTiBcGvG6qOA5MqI64w3F/abp2+buUp+JSC+M6cjGQEtJCHFXviF6YdylJcHt8ShS/S1vpCQbcSzXHZxjt824meh0TRFsqL0x3bD/OtpADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hHLvfm+u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hHLvfm+u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DF290Opdbh0ltll5io55LW+rxk8pQMxAdVfQaDoLsBE=; b=hHLvfm+u1ATkzJGK5mkMRywovj
	TBsGQ26De4YoNpIlkeOZp+xI7eMOZRTfylgzpKkEF9e24S+ulYRjEPK8lGqxXLFBDTx9z0FskjppH
	/FgwVRvM66hWq9cNvF8KLe6ajoMfQBrZOUKqrHzonnuvmzQ/7/mdfM/T6fINxKGGUI6s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vifb5-003sBe-Nz; Wed, 21 Jan 2026 22:18:39 +0100
Date: Wed, 21 Jan 2026 22:18:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: Re: [PATCH RFC net-next] net: phy: add (*register_phy)() hook to
 struct mii_bus
Message-ID: <ef74e8c8-01c9-4ebe-911e-54e84eecb6f5@lunn.ch>
References: <34ac2837b01f53ace02c613a57a03a74d9a056b0.1769029647.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34ac2837b01f53ace02c613a57a03a74d9a056b0.1769029647.git.daniel@makrotopia.org>

On Wed, Jan 21, 2026 at 09:12:56PM +0000, Daniel Golle wrote:
> Some MDIO busses require to program PHY polling registers depending on
> the PHY type. RealTek switch SoCs are the most prominent example of a
> DSA switch which doesn't allow to program MAC speed, duplex and
> flow-control settings without using PHY polling to do so.
> 
> Hence there is a need to inform the MDIO bus driver that a PHY has been
> registered on the bus, as otherwise the bus driver will have to reinvent
> and duplicate all the bus scanning logic for Clause-22 and Clause-45
> PHYs.
> 
> Provide a simple hook in struct mii_bus which is called right after a
> PHY has been registered on the bus.
> 
> Alternative ways which would allow to do the same things without
> having to change any kernel code would of course be very welcome.

You need to provide a user of this new API as part of the patchset. To
deciding if an API makes sense you often need to see both sides of it.

    Andrew

---
pw-bot: cr
