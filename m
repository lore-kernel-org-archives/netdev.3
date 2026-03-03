Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88925480952;
	Tue,  3 Mar 2026 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550639; cv=none; b=HuOk0M61P7gHaw+HcuoLgNCWiJFQMj9qrBGdUzPfkKX2ffnupp6pdBiQ0obY9Itl1ROPHApz8CDaHH+DcffJdbTvY9rZgayKmeoOTK3icsC19/rzBGinI93QWTgDK3ht0PAbOqq34Zx/ZkZjvZkJtg+KbLbp4MJ9W9D5Qv7Dl7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550639; c=relaxed/simple;
	bh=kmLW65LGn3lj3fNViRHixN/BqzcnjNHXl6jmk7uSGv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3i/jXTRWRYS6VkY2+j26Myk6XBlnJZtsvjRudkTPqiy01D2OD/2qSjNWcXGhKUCXk8SY4MftISS3mf3I45oB/fsbJqRlC/Y9KjGs+WxrsNy3dhNE2XT6GGLzGhCQRC1ebsiu/aAbbIfgMsIq80ePwtkrDCPJWKL6YLG7EDzsro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UL0NOTKK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UL0NOTKK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hatu/QAzhv1FKvPqz3f9cN8vip3SjPUH9A/AXblImUk=; b=UL0NOTKKFgwr5abFCaIzbuqIrF
	j52NEejCHRQi6r0gZjeTvlnUWYqC8VMgDc0UTOUVlixXNyZBnWpZ0bysqEu3J/ie0gGxZi/EiZd31
	NGN7ZlDyI89p53kvfzC3iHz6vG075v8soCLh3FazqxqA7zMMiWIco7dm5gwC2m7sqAtucsSEMXe3J
	mN1Tq9LUHE12fgtSouBqlcDjg0ax8waT0o1pk1FQXMJcEYmDWnEls2bEWD2Oi1icPfjxWJjrv7n8e
	Z1k2Ai9Hyl0iR9dy6vD38xJstYroFI5k7gdq44WuHIJKODU9kHZE5I1sM5LHR3x/EvllWh8UbMT0Q
	bJOdXeQw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34698)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vxRO4-000000005Ew-2Bvk;
	Tue, 03 Mar 2026 15:10:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vxRO0-0000000071d-45k0;
	Tue, 03 Mar 2026 15:10:13 +0000
Date: Tue, 3 Mar 2026 15:10:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: sfp: Describe and handle regulators
Message-ID: <aab51KbpIq72wtSU@shell.armlinux.org.uk>
References: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 03, 2026 at 02:54:25PM +0100, Romain Gantois wrote:
> Hi everyone,
> 
> This series describes regulators supplying the VccT and VccR pins of an SFP
> cage or soldered-down transceiver.
> 
> These regulators can then be turned on only when the SFP device is probed,
> thus saving power on systems which only load SFP cage support at certain
> times, or load SFP device descriptions via device tree overlays.
> 
> Please let me know what you think.

As ever, I don't want to be adding support for stuff into mainline
which doesn't ever get used - historically, we've had a lot of that.
So, any patch set which adds some kind of facility like this needs to
be accompanied by a user of it.

This is especially true in this case, because I want to see why you're
wanting to have two regulators, when INF-8074 suggests that both VccT
and VccR should be derived from the same supply. The reason the
modules have separate supplies for the transmitter and receiver is
because the host side has the supply filtering networks to ensure
cross-talk between each is kept to a minimum.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
