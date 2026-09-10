Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBFF4A485B;
	Thu, 10 Sep 2026 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052883; cv=none; b=YImEWswPf/ibNq5G1efQHTa8btsKkuqyRsoCkiIt/H+HztR8OFuJqK7BtnKwfLfI/UYM+4ueqHa+g8+08SLizCswM3bp7lYHN1kMg6ZlG0eRo5pxSFkoykUV/KY4oj/PIasH1T1Xhb0k026FNelp79kkPxdmtajOSTPBWTKMp34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052883; c=relaxed/simple;
	bh=ErwTpVinq47Bz5B3I6Trw0G9IjnA0HH1ShtsRhXmykM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0tt3q91w8TETh6u1Ix1mFW2WDEGR0wCp+FxiFq/T4wOV2PsOHAO49NYxZ6wLclQSI9RPf2KhGLXSgrGtB5WRjzQgyUVeMN01bO+/cu/eenUaJGI+IudIfm8KqfQBMOK7JkOF95AJCrcXff29x7Y4DGXbOkGeW0+V1wd8lHJjyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s87aifiY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s87aifiY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sAxry/9gxO8ra9Tc4i2+zGNNckg7kZCkH2Eff0cthwE=; b=s87aifiYli2n4g6vPxg0rGs/6G
	VsxpkWgl2rFW3bWOpVaeOTJNOYzWTdFBPGepHGf4I65wXPy+jThikHXyZKiLVg+aZSzvI83DqQ/DU
	rF89Eb92lJupn6o0wh8tJrfcJGRvVfzCNDKbZ63xYoGs6k7nFxuu3U8DXFobrRldKVhI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4gNO-004Wa7-4q; Thu, 10 Sep 2026 17:07:46 +0200
Date: Thu, 10 Sep 2026 17:07:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v2 4/4] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
Message-ID: <5bc95ef2-4e23-4c80-af17-07aa3643bebf@lunn.ch>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
 <371fe855-e21f-4d53-a13f-4486494c8ae1@lunn.ch>
 <42efedd837c1631b38849693e1d66bd2b1fb1529.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42efedd837c1631b38849693e1d66bd2b1fb1529.camel@linutronix.de>

Thanks for this list.

> ---
> Global register block at 0x0000 (three registers currently used)
> 	0x00 Core Version - Major and minor revision number (RO)
> 	0x04 Licensed Features (RO)
> 	0x08 Reserved
> 	0x0C GUI Configuration - Implemented Features 0 (RO)
> 	0x10 GUI Configuration - Implemented Features 1 (RO)

GUI? I assume this is not Graphical User Interface, but something
else?

> 	Licensed Features Register (RO) (Bits specify if the given
> 	feature is enabled by license):
> 	[31:27] - Maximum Number of Ports: These bits specify the maximum
> 	number of ports licensed
> 	[26:15] - Reserved
> 	- ACL: Access Control List (ACL) feature
> 	- LLDP: LLDP feature
> 	- IEEE 802.1X
> 	- IEEE 802.1AX-2008 - Link Aggregation
> 	- IEEE 802.3br/IEEE 802.1Qbu - Preemption
> 	- IEC 61158-4-2 - DLR
> 	- IEC 62439-2 - MRP
> 	- IGMP Snooping
> 	- Port mirroring
> 	- IEEE 802.1s - MSTP
> 	- IEEE 802.1w - RSTP
> 	- IEEE 1588 - Transparent Clock
> 	- Switch mode: managed or unmanaged

This is probably something which should be tested in the probe
method. No point loading the driver if it cannot be managed.

> 	- Secure Chip
> 	- Time Limitation

What do these two mean?

> 	MDIO - Control
> 	[26:16] - Bus selection: These bits specify the port number over
> 	which MDIO operation is performed.

10 bits, which allows more MDIO busses than ports!

> > I also wounder at the name. Does the data sheet really call it DSA?
> > 
> 
> Yes, there is even a chapter describing Distributed Switch Architecture
> (DSA) as "a subsystem that was primarily designed to support specific
> vendor switches using Linux, ..." followed by information about "custom
> DSA tagging".

Does the switch support the D in DSA?

> Yes, I agree that a feature structure will be needed once more fields
> are used. I would prefer to keep the current interface for now and
> introduce struct soce_features when another detected feature needs to be
> retained. At the moment, it would contain only a single member.

O.K.

	Andrew
