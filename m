Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD44407593;
	Mon, 15 Jun 2026 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539475; cv=none; b=GsZ/hy3dxPx1ClESM4hGpW9Sz+VtyuO0aMqMQU9tvHhnvp49bd12b+oAP0IimNPbzrow63KhvuD3/fYmvJbkPAoqdR8xKC4UVANG3GdywrhbYltog/ZS48P7KoADKPdbxaon/RZbXOAoHSK3HCGFMaPzotoNMuFt55KljtKbtG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539475; c=relaxed/simple;
	bh=jbG1Ust+FiBggxWGf6DQg+1jmY1hXtQYGd8GTxQBRzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mljuFTJHWISN8+J2mflbJzg5Fh85WqU7flWA7qHumblD3TquN5O6kn17fHpAFAtIYKOdAt04Yoi5rzHq2iZkneBZrHhTBNRMn8vYtacrdX9BnqSOqqtzieTkyrgcoh4BPbN6QuCUY8IKXTHCYR2Mhe3/uV+d9iSilEfvT7C+oxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPXb1Gi6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPXb1Gi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261531F000E9;
	Mon, 15 Jun 2026 16:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781539474;
	bh=jbG1Ust+FiBggxWGf6DQg+1jmY1hXtQYGd8GTxQBRzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OPXb1Gi6S8JolKi40bWgOxIi774hz4UJ2gouKSpxjeGXLf7jXkd6SDwVIY+o4t1fP
	 Blds1K7780L3LCWJoI+/ubteG5J5aAd9ltFCB16bEnWxB2CaU4PFFkpd5lwVTx3GnG
	 FJPjQrcc97zSE4qehQMTzrGD5PwEE5paJ1l1n0PtC9CEuiP12Y2lqDGXLYcZh1WfcI
	 d25dsR3bh9X1iYdGlbN56q2FMA1XkmTYOfj7Hm7yE3s04LUHsGKKD8ZvM7PaZdr3aT
	 6Sos1w7TLaBLcm2xjwRVPvHt0/n4Vmp8mjb2KqLABFfrCYvfLasDtanaioYXj6Zmu4
	 RDPqVreEHtR3g==
Date: Mon, 15 Jun 2026 09:04:32 -0700
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
 <frank.wunderlich@linux.dev>
Subject: Re: [PATCH net-next v12 00/10] net: phy_port: SFP modules
 representation and phy_port listing
Message-ID: <20260615090432.4eaf832c@kernel.org>
In-Reply-To: <20260615153907.862987-1-maxime.chevallier@bootlin.com>
References: <20260615153907.862987-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 17:38:56 +0200 Maxime Chevallier wrote:
> Here's V12 for the phy_port netlink interface.

net-next is closed, deferring
