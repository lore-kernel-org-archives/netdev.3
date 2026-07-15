Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D5394490
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126951; cv=none; b=R2kxhpWCCBL4CLG+bQQ8GcYwhd+EL7Ssnt01L0kWYDdTs4X5pbplJ32xmlvpSr4PS8U2PL9dDACBfsszewNh7QzqIpeadNO9MkazvsR6fxEg40cwetIIu1OSmXmQM4x+GUF05MJfnUKgeARbwsseO7vp+2rOBfbttN/TNp9pmt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126951; c=relaxed/simple;
	bh=S1geam2ptN/61bZXD7t6acbAOlVJaOjYQ5KHuQO7Tqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHbWyFdTnF7ayFBhMNjPHpVtT2VBPTWXZbGbdmjO0YMLroqJJFRugePld2m3z+wQjXf6EOsXLYU5qA08M8/sCvWvURFSAQykF9SQj5bceZcMSy8AzhFfQmkyzmHjUJaoVN3kL/hj0FLwe28JQjdPWkxeTmRIiDGljj/EKv44gBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Wo79yW6O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Wo79yW6O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8O75snAlioYrXr4g89vd6g3dpEis+nEkloUB89beBcQ=; b=Wo79yW6OH0GXKAg410UiTEt8qv
	3adc0vLOZ4OQpSjgYGHJjefebGkvooxNQBOPvzKvGyKPE0pnzCPDeT7hW3KBfQit7JG/Zye1Ous2V
	NuHZWih7GGprXlShOJ5LZxb/dFuGPFZPLKCtO2l5CCpdP0jMbT8UWXLzpCCkd/TmcvMQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wk0v4-00CN0l-Pf; Wed, 15 Jul 2026 16:49:06 +0200
Date: Wed, 15 Jul 2026 16:49:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ayoub Kaanich <ayoub.kaanich@technica-engineering.de>
Cc: Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	=?iso-8859-1?Q?Dr=2E_Lars_V=F6lker?= <lars.voelker@technica-engineering.de>
Subject: Re: RFC: symmetric SET_MODULE_EEPROM_BY_PAGE with i2c_address for
 non-SFF pages
Message-ID: <259dbf46-5d93-4fc4-bf67-a7356a70ed26@lunn.ch>
References: <AS4PR08MB80212ED810625BB46A8EE1B7B7FA2@AS4PR08MB8021.eurprd08.prod.outlook.com>
 <23323308-6278-47ba-834e-662b0e408705@lunn.ch>
 <AS4PR08MB8021E0A64800F977B6887141B7F82@AS4PR08MB8021.eurprd08.prod.outlook.com>
 <cd58995a-6bcf-4283-a072-84651a4f0031@lunn.ch>
 <AS4PR08MB80219505FEC2334B503C55DCB7F82@AS4PR08MB8021.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4PR08MB80219505FEC2334B503C55DCB7F82@AS4PR08MB8021.eurprd08.prod.outlook.com>

> That does not sound reasonable, given that the only interface needed
> to the SFP/PHY is the I2C bus which the kernel could access directly
> (to read EEPROM for example)

The MAC driver needs to know what the PHY has negotiated. Should it be
sending packets at 10Mbps half duplex, or 1G full duplex. Has the PHY
negotiated pause? sync or async pause? The configuration API via
netlink is via the top of the MAC driver. So the MAC driver needs to
ask the PHY to advertise what the user wants it to advertise. Enabling
loopback again comes via the MAC driver. There are all sorts of APIs
between the MAC and the PHY. The firmware needs to implement all
these. You cannot drive the PHY independent of the MAC.

And when you consider this is an SFP, ideally you need access to the
GPIO lines. You want to know when a module is inserted. For a copper
SFP, LOS has less meaning, so you can probably do without it. You
could maybe use TX_ENABLE to save power when the MAC is admin down.

I'm actually surprised you are interested in ice. You seem to be
targeting automotive. I would of expected a more embedded SoC,
probably ARM based, and those do tend to have Linux driving the
hardware.

	Andrew
