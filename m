Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599B03822B1;
	Thu, 15 Oct 2026 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080169; cv=none; b=gqejkL2BPoDVW+DTkz62quZUQaMSbINQFfHrbadUjqoEr9cEsnp6bLrUcz1yNk6Snka9tkFipAHsPKw1eRU6JnU3ebOwdKlCu7IyROZRxSZjMpUgXl7MRaf5g0r/4KoYVRprXBJrAy2pK8ilSbhHpkwziF01tqPubUr50mNG8p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080169; c=relaxed/simple;
	bh=8gdjOKgrDih0wkVOs8l2QbHcmeS5J7v2+strT1QWPxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kk3WUQ9HEgEnv6vJ0ZPBisK5Re0TORyDfOOPVmgpI9OtqinBd6JhvUzAfn3UDQuVyVTuAaUZbs6ErBDKT99lDh9jnFdms2r0on1ZJLlRyX9n7qm0H+oM8IyoTl+OqPtSBOgEzSoQB2DVhWCZjF5kIfvIy3Unm/6g6faKnh0yJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=urG0wmvp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="urG0wmvp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=K0u57/z8jtSUOgsIRuljVakGxstUfqikfUalLZjBTY4=; b=urG0wmvpASIEplabHTn8fnH2tf
	LwA1v85gsX6Og87OkQNwv5R8X9InuloBr/V2JnJpasGCslxKxAg1XoS8cuwkj+X+RnH0UxlgdxAKn
	NeyfTWK5qJ4TunqAhJK50yqx4R3j2RVRd0bbiDSDNMeIE09WAQ1Za8UbYE38NsuKctMk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHNuJ-00Aysf-LV; Thu, 15 Oct 2026 18:02:15 +0200
Date: Thu, 15 Oct 2026 18:02:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: James Clark <jjc@jclark.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>,
	Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor.dooley@microchip.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Brian Masney <bmasney+clk@redhat.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jerome Brunet <jbrunet+clk@baylibre.com>
Subject: Re: [PATCH net-next 4/5] net: macb: implement timestamped MDIO writes
Message-ID: <5afc446b-bd20-4f9c-a330-71615a71d244@lunn.ch>
References: <20261009143506.2507607-1-jjc@jclark.com>
 <20261009143506.2507607-5-jjc@jclark.com>
 <DM1WEUIF8V8V.2OZWRB5G232T4@bootlin.com>
 <CANz3_EamUFhoQJ54g9pxdrxGK9EYxu_KeqRTdAdxWzV15k4_9w@mail.gmail.com>
 <DM5J6J74NCTY.1IDZXHZM276JS@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5J6J74NCTY.1IDZXHZM276JS@bootlin.com>

> I've not checked what is in tree. I care most about EyeQ platforms.
> The EyeQ dev boards use a Marvell PHY which could benefit from the
> feature if/when Marvell PHY PTP support lands in tree. I've tested it
> briefly (more accurately, I tasked an LLM with running a few tests) and
> something times out but I stopped there.
> 
> An RFC has been sent two years ago by rmk, and I guess it will be
> iterated upon because there is interest!

That seems to be self contradictory. If nothing has happened in two
years, nobody is interested enough to actually finish the work.

From what i remember, it is not easy, because Marvell switches contain
the same PHY, but also have PTP at the MAC level. We need to ensure
that when the PHY PTP is introduced, it is not used in preference to
the MAC PTP, which i think is more accurate. Otherwise there are going
to be regressions.

	Andrew
