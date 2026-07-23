Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915FD318EC5;
	Thu, 23 Jul 2026 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816324; cv=none; b=Uux5C5AN5wAV+bHOHmnLFMsVrN9tSPsRh/VBQfZ0j350W8LMuyJ6vjA0DIkGArdgnyoG2nc7DurcEMDn456q8Z09gH6KyhOqD0Dnp4yxSSz26O5Ml9pR/8KcMrjFOVj/rnqfosUF0aF0qiJXD/fvYX+N/B+/xBoI6tvgYxCxDzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816324; c=relaxed/simple;
	bh=c3tmG0ZwuT9eJCJiSgOdieoE9hM5mXHNEni+wnhmo6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0lwQXrL6BKu1XV1dhsQQd7uINKEbeIWrVES9JI3JSG78rWLV47F+BgwAKrYrs3yKmJ7tZAalmAR9lo3ojY52faqDMUlxGs1Z9K2QwnEIxACPYsdDhQeBHHjiXEmgTnnO1tyNK1qdAdtUCqL2rAWFw8JJPhVG3GXLHvrt7/jf50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N+34V2gc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N+34V2gc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KL0DA1IoI/AdySUR7MwiUBV9n2CQ+8MyuCEa2o4mxV0=; b=N+34V2gcVJhZe6wIYq0+GbqFdc
	vdT2A81rFSs22btvjCYTjnS1yjmv74r1YUjpuSZHg87Fpx7S1+e6WYmP7O248YrSF0J+gNQIkgGy3
	waUE1oyMy7xRyMdlvxtZbayCSXPdM0dBCpHrwvqjA/9f76QYOrOamYarX7RuQ8cujoxA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmuFg-00DpWh-M0; Thu, 23 Jul 2026 16:18:20 +0200
Date: Thu, 23 Jul 2026 16:18:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/8] net: mdio: realtek-rtl9300: Add polling
 documentation
Message-ID: <420dbb03-6a39-4ef3-9cb3-da78401fd4ce@lunn.ch>
References: <20260722062356.12291-1-markus.stockhausen@gmx.de>
 <20260722062356.12291-3-markus.stockhausen@gmx.de>
 <ef41a5bc-804e-4a5f-863d-7221fc1ef1ac@lunn.ch>
 <009e01dd1a6b$d9726a80$8c573f80$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009e01dd1a6b$d9726a80$8c573f80$@gmx.de>

> Appreciate your feedback. I will sum up the situation and my point of 
> View about the C22 PHYs in this single answer.
> 
> Regarding speed detection: I ran a quick test and MAC side 100Mbit 
> detection works fine. So we have no issues there.

Just to be sure. You have a broken cable, so could trigger downshift?

Maybe some background is needed here. An ethernet cable has 4 twisted
pairs. All four are needed for > 100MBs operation. However, autoneg
can work with a broken cable where some pairs are O.K, and some are
broken. The PHYs negotiate a link, and then tries to actually use
it. They then find the broken pair. A downshift then occurs, they swap
to 100MBs, which only require two working pairs, not four. The phy
driver knows that the BMSR and STAT1000 don't give the true status of
the PHY, so it reads the vendor register 0x1a which is correct. phylib
should notice the difference and print the warning:

phy-core.c:	phydev_warn(phydev, "Downshift occurred from negotiated speed %s to actual speed %s, check cabling!\n",

and the MAC is told the true link speed via the adjust_link callback,
or the phylink equivalent.

I wounder what else the hardware polling is getting wrong. One obvious
thing to test is pause. Pause can be negotiated, or it can be
forced. I assume forced pause is broken, since that is configured
directly in the MAC. But it would be good to test negotiated pause as
well. EEE is very similar, negotiated, or forced. At least these you
can work around in the MAC driver, by just reporting EOPNOTSUPP in
ksettings_set. But downshift configuration does not come through the
MAC, the PHY driver defaults to enabled, as far as i remember. So you
are going to have to somehow special case the PHYs in these switches.

> Regarding hardware designs and page handling: I do not know where 
> your information about non-Realteak C22 PHY is from.

It was a comment from Chris Packham, to one of the versions of this
patchset.

This hardware polling might be good for a dumb unmanaged switch, where
there is an embedded Z80 or other similar MCU doing the minimum amount
of configuration, and no PHY drivers, just power on reset
defaults. But when Linux is used with proper drivers allowing full use
of the hardware, HW polling makes no sense, it is a broken
design. Yes, you can make the main use cases work, but i expect you
are going to find lots of broken corner cases.

	Andrew
