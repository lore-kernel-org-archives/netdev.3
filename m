Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13BC3A8736;
	Tue,  3 Mar 2026 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550750; cv=none; b=d6owGrq8jPSkxcgqWWc44HSUoWHGzC+7uUz782h6gjXwW7aS7dN/2AybtLO5wldz1yxqkYKm7mhL8coyczTeJrJxRguWHWkt31ltLwxhDJPJ5VwvvSj1TcOkdVBchGs02E3uhcBlI9RcRWqZwlVYYH7DcpLQ1C7gEahZNEk0Csk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550750; c=relaxed/simple;
	bh=4JEOj1Yv9JwueQS3GU/dm4CBVow7OUg+VKtl15NRjUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlxwSek+gxdyOqrxJuxDq35OXCYHy6tEvcILUuxxvhaT8XpgLYcf6uRQNeo9F7F0tKBc8yURnnoRa0xqj42fk/pO30VKs2DvnE2G/TxTm7s8b3MwHrjvdDqM2WDbgj2jJMisqsfsdPch+9TinXpZ8yZ31yrxwGrWhlDBxv+MMu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=E2vVxtjf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="E2vVxtjf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9HNWqW/5qWHN0QBEI80/r96WRbljDrLfozCnuqKtqBQ=; b=E2vVxtjfJQ4Z5xCAc75ygEl+L5
	IIdWZgg+42iBkPmro0AfJ4Zntg3MubLvAQlkLOnpwhLfSZre649TjYJ+rDrzT7bpqkQnZodvsOqoj
	HuHMV1P7Iac0kDX0whyjGQ5TeTK8sIsAhxV0wikH+bsCx6sgKdLzUa+1pGQvK5YaO7c04kaLQFT3y
	QgsBaX6Ly9brinTTe/C+TiZsJ32T888nKyX02PSxUVjM5ou46vSBIZf0S6ZAqqSJlnIrprPmGSXjF
	hoOCvFahbS7kGbdJ1aYwonfIUxyAWjEvvsFpK7YJBhGfSWKUShkI8kgG4OXCXYS8cmsSVLwFnIfKC
	JFGOuqLw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41570)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vxRQ0-000000005FN-1IFP;
	Tue, 03 Mar 2026 15:12:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vxRPy-0000000071n-4ABh;
	Tue, 03 Mar 2026 15:12:15 +0000
Date: Tue, 3 Mar 2026 15:12:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mark Brown <broonie@kernel.org>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: sfp: manage receiver and transmitter
 regulators
Message-ID: <aab6Tqo1z-8YQ4j6@shell.armlinux.org.uk>
References: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
 <20260303-sfp-regulators-v1-2-7101ae34cb84@bootlin.com>
 <e7a1ab5e-c34d-4ca5-93eb-4f5bcfacdb40@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a1ab5e-c34d-4ca5-93eb-4f5bcfacdb40@sirena.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 03, 2026 at 02:22:40PM +0000, Mark Brown wrote:
> On Tue, Mar 03, 2026 at 02:54:27PM +0100, Romain Gantois wrote:
> > If phandles to receiver and/or transmitter regulators for an SFP device are
> > found, enable them at probe time.
> 
> The driver should unconditionally request whatever power the device
> needs.

... and then we break everyone, just like you broke SATA, and I've
never forgiven you for taking a principled line on this rather than a
pragmatic approach. You're making the same mistake here.

As we disagree, we're at a stalemate, the result of which will be a
NACK to this patch set.

Sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
