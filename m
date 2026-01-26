Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02F2989A2;
	Mon, 26 Jan 2026 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457777; cv=none; b=K8T8QXUDcDBsorw5fSMMJsrlNjuNpNvYNoK3tGeAvU9l75OD5mjXY/tnmGpfQ9o3K7ml0Y9Y+tCdSmhG9XFhPs2q6ouxHzDv4/byBiwMurP/N4jWWXkZWpb2g2FQeVnDTim36583IvnG0eVRXHPlRh16VNXJB7wFo6LVju2YlSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457777; c=relaxed/simple;
	bh=6/qXVNGWQAV/Q1Q2B60y2dEifM/qsJVq4Xf0kOfWgTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8WG4Yr3yCueaY0WAXJ6+bkIb4M4gROvh1+6dgBR8I+KZm9bvo1HSh9998+79COMI8ZUpTIqVnN+SO2B1nEIShiNZ7hyzJB63Q+CUVMrj9GmxDrk1zNlEuYXG2Pdr/luJiP07QhEYMUPoUYGt4AI9Ga9NJOWjDqJrhjRhfDfbeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HqICFBwt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HqICFBwt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WmGo079PHp8o044khYdGMqhSgYmESmhpcYA5HDsD2Qc=; b=HqICFBwt8EbLJXONcEsg0M5Qob
	DXoIYbwPfas0+mFWxOS2D8vBKVGLrNeUuQyYcb+T/nECbvebhTQWWShFAJlN6n59k9+6aImzLzPCT
	vmlf/H1h5549kULZl8kAjVlj0ZEVebZswl8IEQqGYaIIFgwESwlYZEdyPlJQDnWXfPOd2SmMOSmcN
	Evi6nDJ+3MMocBk7PHIljnx1kEBbwZXTHCViH9sncSDsTR01APpVrYeDQZYUPEiedKwSQycqoRXQZ
	abpb8SDchRdsUiZijVJmqbLBb0ZmqV/M7WjvQDQQiYVYsGGVqoVGthmTN5ktwao2WOudzqb5d7KeV
	ca8ySsdA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50380)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vkSn2-000000005Ii-02B4;
	Mon, 26 Jan 2026 20:02:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vkSmx-000000005DW-110o;
	Mon, 26 Jan 2026 20:02:19 +0000
Date: Mon, 26 Jan 2026 20:02:19 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Divya.Koppera@microchip.com, Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v11 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <aXfIS1N2gYM7lcEs@shell.armlinux.org.uk>
References: <20260126192250.2480192-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126192250.2480192-1-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

In general, I still don't like the idea of writing this documentation
in such a way that we have multiple definitions for the same controls
in multiple different locations. That is a recipe for the definitions
to diverge.

What I mean is that this proposal adds definitions for:

	ethtool -A eth0 autoneg X

separate to the definition in ethtool.h for the "autoneg" parameter in
struct ethtool_pauseparam, separate from the definition in the yaml,
which is again separate from the ethtool man page.

There should be one and only one place that is authorative, and the
other places should refer to that authorative definition, maybe with
a brief outline.

Having multiple separate definitions just leads to questions about
which one is correct if they are defined using different wordings.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
