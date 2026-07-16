Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB43B387341;
	Thu, 16 Jul 2026 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216561; cv=none; b=FKgI86lZW8XjqLiuKt796Z1Rnx4bsn7iL39tLiY8IKPvVH6uhcfOBzbhIvTo/Ci7h+xJ3U03jkudbMnPSst2jg+9f0WJQKkZt0ph18pozVmBNawiqbO2G3UtbuGLOj+UJDR/psnbpN0cpNg1UMJJsnOsUhJXfAbpPnxctd0ifqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216561; c=relaxed/simple;
	bh=/TN+5AyNuEVk0jXJG0NcT4h6hYsmHtjpSAOdqISDC5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwOxemhy6Zk3d2wDdXFHbc8FsnKNqdt3KyA0r8LzalIXi9RDSfSeH5FMkRFOXJZL3jLI4l/CTKvcVnZ6ssYmFN+BG4B4leR1KfoUah/gdld2075WEhqn8uOC6idQHwJEWqqBZdFeDW3AAvuMxuQM255z0piLEOn0WL2APX5k66Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qVhkBrbC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qVhkBrbC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EPu+Tbo9Y05KfihPlkG+qRgkWK4cT5jrnAK4ukGO2/M=; b=qVhkBrbCRECP4dbYVFgsJ/DhSm
	ZAhM4eRIEVQQIQBtoW6AxHUY5GhGbRyc46HM6Blbb45hNpgRwY/YP7UtKP9FyCPvGgFenxiR1BWLa
	ZDKUVxPcSsaTRa69Irq+dE+bq4ESH2jq+c8I3MLwho7Kxe9VtMLVwiLZlnxpBljYPTWk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkOEF-00CZS4-Ml; Thu, 16 Jul 2026 17:42:27 +0200
Date: Thu, 16 Jul 2026 17:42:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 02/12] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <713954ed-6d7f-4de2-9d2e-3d0af0f2db1c@lunn.ch>
References: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
 <20260708-ax88179a-v2-2-0800fedb2e16@birger-koblitz.de>
 <1f858852-8e8e-4cff-bbdc-eb6751f44ca5@lunn.ch>
 <de0bfcdc-01d4-4683-97e1-16c0466023ef@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de0bfcdc-01d4-4683-97e1-16c0466023ef@birger-koblitz.de>

> A comment on phylink and USB-Ethernet NICs, though. Grepping for phylink
> in drivers/net/usb shows only 2 drivers that use phylink: asix_devices (the
> antiquated one using the 772A-PHYs) and lan789xx, which is also rather old.
> There are more than 30 drivers there, so that makes < 7% phylink usage vs 93% mii.

Most USB dongles are old. There might be new variant, but generally,
that only means adding new VID:PID to a table and they work.

phylink becomes interesting is with speeds > 1G and enabling more
features of the PHY, like EEE. Because mii is so old, it only supports
speeds up to 1G. It also requires that PHY stick to the 802.3 C22
registers, and don't really have an vendor registers. There is no
concept of a PHY driver for mii, so there is nowhere to put per PHY
code.

For a totally new USB-ethernet driver, i would strongly push back on
mii and want to see phylink. For the existing drivers, there is little
i can do, i don't have the hardware. Converting to phylink would
however be a good project for a newbie, if they have the hardware, and
what to really learn something, rather than all the AI driven
theoretical bug fix patches we are getting at the moment.

You are in the space in between. It is not a fully new driver, but you
are doing speeds > 1G. And you are looking at lots of features and
need vendor registers, so per PHY code.

I have another idea to throw out there, and it might be a bad idea. I
will let you think about it. Split the current driver into two. Make a
library out of all the code handling packets. Leave the mii code in
the actual driver. Then add a new driver, making use of the library
for moving packets around, but using phylink for PHY management. You
can add the new VID:PID to this new driver. This has the advantage of
reducing the risk of regressing the old devices you don't have. Also,
we can put out a request for test, see if anybody has the older
hardware, and ask them to try testing with the VID:PID added to the
new driver. We might be able to slowly migrate them to the phylink
driver.

> And at least for the 179A-based controllers it is clear that there is an
> advantage not to use phylink: When the link changes, the controller sends out
> an interrupt URB, that has everything in there to set up the link. No need to
> do costly USB requests to query the PHY.

How costly? You need to balance cost with frequency. If this is
something that happens once a day, when the machine is booted in the
morning, does it actually cost anything? And think about all the non
USB NICs, which do need to use a number of MDIO operations to find out
the state of the PHY. Nobody seems to complain about that.

> In fact, the proprietary driver
> works hard to not talk to the PHY at all. A good example is WoL, which is in
> principle a PHY configuration issue. For setting that up, the driver actually
> never talks to the PHY, everything necessary is done by the controller's
> firmware. For USB Ethernet controllers it makes a lot of sense to abstract the
> PHY away and rely only on controller commands that concurrently configure MAC and
> PHY to reduce USB transfers.

I somewhat agree with you, if you can totally abstract the PHY, so a
PHY driver is not needed. Yet the driver code you posted has lots of
code dealing with the PHY. So it is clearly is not abstracted
away. Such abstractions do occur, with firmware driving the hardware,
look at many of the intel NICs, and most PCIe cards with speeds >
1G. They often only expose a MAC interface to Linux and everything
below that is hidden away in firmware.

> Looking into the Realtek PHY driver code, what is done there appears to duplicate
> the code in r8152.

And other reason to use the Linux PHY driver, no code duplication. And
there might be some freebies, like cable testing just works, it is
possible to control the LEDs, etc.

	Andrew
