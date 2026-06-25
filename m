Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74843E8330;
	Thu, 25 Jun 2026 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401017; cv=none; b=MoDT/Mdk6OYGgaHn9kRpgTIYol92jco3arVPGfQW+sDtWydU2zmoU0pyKrrVmmkr/ryOUlEddMxEA8pTXh8udCf2wT9eb/Vp3YY3nOJTGO5hZTZVSWRmBEge552ls4zAT24Y0z1qmAGaVglfZuGDZPeXjruIghZBOBkTKdG07R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401017; c=relaxed/simple;
	bh=JQtFa7htbY/CcYz7Ewd1TH9/9WSFG1efPRA7vBU8Jj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRA1eRAHM0tHDW+YWmF8FgJVYpljGw7ZujROBD2B/CQqkVxzkYu+LumzLSK/RvR5nHk1vmncb+Zn2o5KtDmz6HXVwthoKB9j0NLGt+6M9uOeBMVptoBVmWZFyeOJ5CwZGpMGWQPm/r37JWG69TmtA5o5VG/Z2g99OyXN+9sHtco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0u7dZSJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0u7dZSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25181F00A3A;
	Thu, 25 Jun 2026 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782401016;
	bh=IL26CsHIrio9igkJNe+Qqcof5uxEGMEOJx0qYBrwMP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q0u7dZSJz2xQ/zdxR6ZDtcNHfIqQVSwaIgBwGod/vY1YCKPHqmCKp5E6p2d4gPaNp
	 Q2cP7lchEwkfPSE0PevJghkKY/ZpY8xNyMTHQm0TcHE6nDEDi5eeMwXXXxfcS24Dja
	 rFjygUKb3x/PawcX4tzFCN5y635WS6WNUkF98IJZTO/5+ByUktEclxi4As2jhzLYqh
	 zFLZHdnpip1/erG5oWgK2xf2urSOLAe+VmZDAd6eJyUFItrttohA+Q0WEq2wOnZ/6N
	 6i38rMkAQb4brzdgFJJp3OM71Y39ZvV94F9GojG35J7eH4x5oQQSCwLVTjY+cUVHdg
	 tqr9zBDSxuoVg==
Date: Thu, 25 Jun 2026 08:23:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: Petr Wozniak <petr.wozniak@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Bjorn Mork <bjorn@mork.no>, Marek Behun
 <kabel@kernel.org>
Subject: Re: [PATCH net v4 2/2] net: phy: mdio-i2c: defer RollBall bridge
 probe to PHY discovery
Message-ID: <20260625082335.3d13d875@kernel.org>
In-Reply-To: <9f813a8e-8b9a-4708-b3b6-db4972adac35@wp.pl>
References: <20260624084814.20972-1-petr.wozniak@gmail.com>
	<20260624084814.20972-3-petr.wozniak@gmail.com>
	<9f813a8e-8b9a-4708-b3b6-db4972adac35@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 23:44:19 +0200 Aleksander Jan Bajkowski wrote:
> > For genuine RollBall modules (e.g. FLYPRO SFP-10GT-CS-30M with Aquantia
> > AQR113C) the probe now runs after initialization is complete and
> > correctly returns 0, so PHY detection proceeds normally.  
> The FLPRO SFP module still fails to detect the PHY. It is necessary to
> increase `module_t_wait` to 20 seconds. Most likely, during this time
> the module loads the PHY firmware from SPI memory or from the
> microcontroller (rollball bridge) via MDIO. Same probably applies to
> most SFP modules with a PHY that load firmware at start-up (AQR113,
> RTL8261C etc.).

Just to clarify is FLPRO a typo or a knock off ?
Do you want something to be changed here or you're just flagging that
more follow ups are needed if we want to cover more modules?
