Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A439B4A5;
	Sat, 17 Oct 2026 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792277128; cv=none; b=bSeya1OecE/5ghZ3vItWDziRC1Uk4wtAyWm5h0avAnt3Vp0/TA1qBRwAQeUOQtNimHQOq8nNl52G2AEW9gtERz6Ao1zWEXf5w+fy+I5RSioNsHoObyeXM5BCpjdOU2lNpaqVi1JoWinDJrFXH7sEUobzyg8llB3ekNaRRLQY4hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792277128; c=relaxed/simple;
	bh=bEE4PGpaZkZIAz7kZPNKajDa+gw9u8hFXd/FZ3+DSKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVK3NcDJT2gRO+IPxkqJaQYkcl0dhrvCw8IVFaKjYTtEuPT7CLGMMzLhwcenV2IK+y5tPOs/UMsFMLEQYcTSpf9/F9tmYAFn+uELJiVRXJX8w8r5xhCfvDAWbyCa2U4pzVyq66Lcx2YSOJ2LrxNBpv9X8Z9Wpf0lpT1M1KkYVa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=VyrYyp2K; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="VyrYyp2K"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id E1C9DE83404;
	Sun, 18 Oct 2026 00:45:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792277117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEE4PGpaZkZIAz7kZPNKajDa+gw9u8hFXd/FZ3+DSKI=;
	b=VyrYyp2KdHTjwD3rSlANnh+VV0/+mKpvakYKnzvhSKj7kvaWBs5XXPFFZ4ziPU1PqEhNdn
	3oRn61GHjzoqNkThNxzswSHJB4rdjOhDtvcVE+R+LgGlRDDPmcppcsdx5amEllQnlh0nUV
	S5v7wI3MOEp1PnnzWNkEuBSiuzlF/tDlU0nXTJlPKQZkxZVcf9/vyy10V2Qgi7tARC3jXn
	X+Ycf6h4DHtTPLJR3DkNJL/lK9OVYKEO6JOLIY7UfaZqX83BD1cDQIpw8knQqsR+udUxkv
	0nSOLOppt372iHk5Uqwt62cs+xX+dUxMLBdDLpT8P1I7WaeaqHjBTjZB6Oyfcw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 3xJJKWtduPqs; Sun, 18 Oct 2026 00:45:17 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 00:45:16 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	netdev-bot+sashiko@kernel.org,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	devicetree@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 2/7] net: pse-pd: fire lifecycle events on controller register/unregister
Date: Sun, 18 Oct 2026 00:45:00 +0200
Message-ID: <20261017224500.1526770-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179122160553.434549.16806647504780466154@kernel.org>
References: <179122160553.434549.16806647504780466154@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 05 Oct 2026 17:33:25 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> Once the net fix lands, will this paragraph be out of date? Could the
> message refer to the net fix instead of saying that this commit closes
> the race?

Agreed. In v9 the reordering is its own patch in the PSE core fixes
series, so this commit message no longer talks about it.

> [Severity: Medium]
> This isn't a bug introduced by this patch, but the error paths in
> pse_controller_register() leak memory.
...
> Should the kfifo be sized after that default is set?

The leaks are fixed by the core fixes series. The kfifo size is an
older bug; its fix goes to net.

> [Severity: Medium]
> This is a pre-existing issue, but can this disable_irq() mask an
> interrupt line that the PSE core never owned?

Yes, if the IRQ request failed. That is an older bug; the fix goes to
net: pcdev->irq is cleared again when the request fails.

> [Severity: Medium]
> With disable_irq() now running before the event, can a port be powered on
> from inside the PSE_UNREGISTERED walk?
...
> Is that case worth handling, or is the brief power-on acceptable here?

The brief power-on is acceptable. The same walk switches the port off
again when its PHY drops its handle. A port could only stay on if an
earlier pi_disable() had failed, and I don't think that case is worth
extra code.

> [Severity: High]
> At this point in the series, can ntf_work be queued again after this
> drain?

Yes, with only this patch applied, as the commit message says. The phy
patch at the end of the series closes it, as the review describes.

> [Severity: High]
> This isn't a bug introduced by this patch, but can a shared power domain
> be freed here while another controller still uses it?

Yes. That is an older bug; its fix goes to net: the power domain is no
longer devm memory and is freed only when its last user drops it.

> [Severity: High]
> This is a pre-existing issue, but at this commit, can PHY-held
> pse_control handles reach the freed pcdev->pi and pcdev after unbind?

Yes. The phy patch at the end of the series fixes it, as the review
says.

Carlo
