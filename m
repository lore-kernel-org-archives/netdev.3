Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA41288C0E;
	Sun, 26 Jul 2026 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785077526; cv=none; b=upo62inMwFq8IPjbZx5+GanrtvU+Bx+JL2jinkgN/HZcGBwiV8Kxx3tKwU7NdC4FhoVw/6zUoYw+m20h851rN6+YBbpsOiXUCx2mokaysvmikpGh81MgkmJxg2yKg9EBSSA2b3FqJN2NnoGg2Vx4vFVlBCFWOdtPkfQWZdPnMR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785077526; c=relaxed/simple;
	bh=wNDxlKfBMkNYHNmCd509rghz2fZpgybsHvPHuEJCo+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6tpBX7vOOesrjk26RMayB5o1jc93EZQiUHaUw9CV/X9xGexGFAubMkZrrCybHRQCGpMjwkByr7rDbpsqBLNCP5eyDayDpEDDq6CxUkQw7P2r6ZhUfCr2OtUrmbrmFe72GXuzCslBqSDUNNIYNlkYHUb/5UUeIl7HsnOKGz9rUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pCSx1kr4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pCSx1kr4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SS4ef3j0ebZLsZFKqWIf/cQ9BXjSq9uD/G8+mr2rA8g=; b=pCSx1kr4eJZkiGe01PMVVF7z1S
	kErocFY+Liq9eWS+Q9THpKsnOk+VPaSu/CLuXj6gT12vMQ/wVgUhbMEj6uweQhR1u/TGEo82/I8hb
	zFHaJ7fQ7v71K3PMVmACGB8PCde3WN35xC7MotQ9mohdM3oSjNTDnzJqog8pcXkqei0s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wo0Ci-00EIZi-GE; Sun, 26 Jul 2026 16:51:48 +0200
Date: Sun, 26 Jul 2026 16:51:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v5] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <b1f54c52-5719-414b-9bdd-3a0b0bc06252@lunn.ch>
References: <20260721114810.660718-1-kyle.switch@motor-comm.com>
 <d394347a-4162-49ea-b65a-c2e2bd3769aa@lunn.ch>
 <59cc79d4-cccb-4cc8-94d9-60c56e86b598@motor-comm.com>
 <c591a9b0-7fea-4953-93db-23f0f591e6ae@lunn.ch>
 <47d31704-e57b-4828-8c8d-0438ef43e49a@motor-comm.com>
 <ec6fb144-9b38-418c-ab6f-a02d5fb47b2b@lunn.ch>
 <4c4b9a41-cc54-4aa5-b302-631369e3c700@motor-comm.com>
 <87a4548f-ef0d-4ddc-9e87-155786cd5e31@lunn.ch>
 <638fda5b-ee2c-4f3c-94b6-37d689d48721@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <638fda5b-ee2c-4f3c-94b6-37d689d48721@motor-comm.com>

On Sun, Jul 26, 2026 at 11:24:16AM +0800, Kyle Switch wrote:
> 
> 
> On 7/24/26 21:18, Andrew Lunn wrote:
> >> Ans: It is different from the m88e1111 PHY, which may support UTP, fiber, 
> >>      or combo mode. However, the PHY8824 is only used with UTPs, and 
> >>      its structure is as follows, which includes UTP0, UTP1,UTP2,UTP3 and USXGMII.
> >>
> >>      RJ45 <----> UTP0 <------>
> >>      RJ45 <----> UTP1 <------>   USXGMII  <----->  USXGMII(the side of MAC)
> >>      RJ45 <----> UTP2 <------>
> >>      RJ45 <----> UTP3 <------>
> >>
> >>      It is similar to phy8821 driver in motorcomm.c, with the difference 
> >>      being that one has one UTP port and phy8824 has four UTP ports.
> >>      YT8824_RSSR_FIBER_SPACE is used to access USXGMII reg space, Perhaps it 
> >>      would be more accurate to call it YT8824_RSSR_USXGMII_SPACE or 
> >>      YT8824_RSSR_SERDES_SPACE.
> > 
> > O.K, that completely changes my understanding of this device. Yes,
> > YT8824_RSSR_FIBER_SPACE should change name. And i would include this
> > diagram in the driver, and indicate how YT8824_RSSR_*_SPACE map to
> > this.
> > 
> > For the locking, look thought all the code which is touching the
> > USXGMII side and see if it can be moved into probe().
> > 
> 
> Ans: It may not be possible to completely move the code which touch the USXGMII side
>      into the probe() function. The initialization configuration aimed at optimizing 
>      the performance of the USXGMII side may be moved into the probe(). However, for the 
>      soft reset of UTP, it is necessary to configure MII_BMCR registers in USXGMII side.

I'm beginning to think you need to add an extra lock.

The idea with the mdio lock for accessing pages was that is existed,
and it would protect against accesses which don't come through phylib,
like hwmon. Because it is a low level lock, it really only works
within one PHY, when there are operations going on above it. The
assumption is that PHYs operate independently.

You are attempting to use it differently. Because of the poor hardware
design, you need to protect one PHY from another PHY. Your PHYs don't
operate independently. So i think you need to add a high level lock,
shared across the package. All the entry points via struct phy_driver
need to lock the package as a whole. The PHY can then do what it needs
to do without having to worry about another PHY being operated on in
parallel. You can make use of the phylib helpers, since the MDIO level
lock is not taken. phylibs concept of pages registers will work. Once
everything is done, release the package lock.

So, please look at adding phy_package_lock() and
phy_package_unlock(). Maybe it is possible to make use of struct
mii_bus shared_lock? Please look at how that is currently used and
check to see if there might be deadlocks.

      Andrew
