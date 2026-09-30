Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D640D47CA8D;
	Wed, 30 Sep 2026 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808968; cv=none; b=pljuQAJBE1rdf4SccH0krEkCf8GJSlk1+YkaQqxOi9SEO2JsIZl+QvP+mATg+qHtrorGVsFsql0ugXH5NiYq5YitsNk3utgKC30qeTelfCH5cpuj0x+q3P/6oDtL/HQ5c8JJJBSbO5Us2Dliwe+HcC6wGHASzpTW6o5DbYBPeNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808968; c=relaxed/simple;
	bh=yb1aTZJBy950Ab7G7REhwM+t57XIvDPW1JXAWHDGtYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiC5rX6g875AB1x43zkJQ15WxeJZa085nR4cKd8XSMK+trEqtPufI6QlX+ODYOQfXK2uxHVYi4yNbzZrDxd3pUnNZHdrgOZizTd+VoCXZtfYBTTCONu6jVfswfDVjTgqs8wIB1+8cZV/Tc82UJuvjwfBkRiCYwsJsoa++j1oW5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOsZNIYE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOsZNIYE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A1B1F000FF;
	Wed, 30 Sep 2026 22:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790808961;
	bh=qHHYqPRV+m8v2VUfLotNTzVtXMK4YB35bky+6A4Adok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BOsZNIYEYq+B3SiahprMOm7UpEKfeV5cc87jwH2t3qYsZ/W6tcqIglvFTrP4drChL
	 0TK0sgQ7XxOJYmEjDkBZ3pBXPjeLVJrClpGRY+WDzIbNFsoeNLvbK6lSS8lIFcQUcz
	 fJ6CNRDx6VmzW+XLkxMzYKQMG+ewzM2vfRUJMWbbpgYlMgmaxhuMyVqdpw2D7uYcCh
	 2HEdOLrbGzen+7epyiZSSOa4Req08bs6dEEi0OwbpT3k/evRWr6bVC+o5viKsq6hAP
	 DJ6zixHo7H2Pq5GInPWSDQigEgxn1DCr+9X7NY5yh+qKEuGT4QL5x/KL6IF+oSTFRh
	 nQIotRmVVF0Dw==
Date: Wed, 30 Sep 2026 15:56:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Romain Gantois <romain.gantois@bootlin.com>, Daniel
 Golle <daniel@makrotopia.org>, Dimitri Fedrau
 <dimitri.fedrau@liebherr.com>, Frank Wunderlich
 <frank.wunderlich@linux.dev>, Pietro Ameruoso <p.ameruoso@live.it>, Aleksei
 Sviridkin <f@lex.la>
Subject: Re: [PATCH net-next v18 00/10] net: phy_port: SFP modules
 representation and phy_port listing
Message-ID: <20260930155600.3b18c7c7@kernel.org>
In-Reply-To: <20260927133619.955236-1-maxime.chevallier@bootlin.com>
References: <20260927133619.955236-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Sep 2026 15:36:09 +0200 Maxime Chevallier wrote:
> What this series doesn't do :
>  - We don't support selecting which port is active. This is the next step.
>  - We only support PHY-driven combo ports. The end-goal of this whole
>    journey that started with phy_link_topology is to get support for MII
>    muxes, such as the one we have on the Turris Omnia. This will eventually
>    be upstreamed as well.

Any plans for representing a few "complex but expected to work" cases
with netdevsim? Or are you thinking of trying to cover this with NIPA
HW tests?
