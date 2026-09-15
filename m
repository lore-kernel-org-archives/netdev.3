Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1105A2C11E6;
	Tue, 15 Sep 2026 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789436291; cv=none; b=EwyxKHEjrie5Xkg8aLl2lDMs2cphiN8l/FQeAWCJdBxF6AabpQqcJh6GGG6THWTFU0XsJXQeeJjhYey3wBTfCZcnag6pbOGFrq/8mKrjazEjTOlgM75emN+S2mNNoaJkxUW0DyVe+WeHuQ+guZrkN3MKdPrHwn8Iup03jYl5Bwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789436291; c=relaxed/simple;
	bh=LJISAw53/XS4cKLmLRcjDrvFI55o5b2VRiFl0cC42d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvLxsDRF+2R7hXni2oew55l+pv0kEtte9biiFyZCrTTNK9ib6fD5eHFkeET01dwDkyGU4Pb1Uz8wZ8uV9Syk+u1n2UlZDvCwT3FVvX+/uaBOPqepoKRsohmUyUaPfT2fcaLt0TeR+6xKRyyXkMdOg/ihtuNo+aj3HsBxzJsEyeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M3sK/gPu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M3sK/gPu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZwlFUKDyv7/oDnq9W07CoOYhsxtE/VuWYanh9L0PklM=; b=M3sK/gPuvLfdeyVqZxifxuisTI
	8wwFHhT4CuekEjHy2tcgc+5bu0o7AVL/KWkMcVwFeyN38YUt3Gza4inEvzZqCL2jkCIX0e+A65IXr
	nMB8f87l1VMKbIbkScKot8rhwRSDPyJHwH0TQ80/Q5lIAQvvT1UWLIuN1AZ+TfXcTQW0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6I7X-005AKP-FL; Tue, 15 Sep 2026 03:38:03 +0200
Date: Tue, 15 Sep 2026 03:38:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>,
	Pietro Ameruoso <p.ameruoso@live.it>
Subject: Re: [PATCH RESEND net-next v17 10/10] Documentation: networking:
 Update the phy_port infrastructure description
Message-ID: <43813c88-e9cd-4333-b7ec-9f7f280cffd8@lunn.ch>
References: <20260910170103.1029108-1-maxime.chevallier@bootlin.com>
 <20260910170103.1029108-11-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910170103.1029108-11-maxime.chevallier@bootlin.com>

On Thu, Sep 10, 2026 at 07:01:02PM +0200, Maxime Chevallier wrote:
> With SFP now properly supported with phy_port, add some details in the
> documentation. Fix a typo along the way (driver -> driven).
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
