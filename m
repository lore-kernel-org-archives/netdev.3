Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A473803F9;
	Wed, 29 Jul 2026 05:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785301440; cv=none; b=gnwdV1a6lLA7gVcSWjw+uBYLlzEhq2/SOTdDofZWctnGt8QV4N6cfQbpyfUW1x2OtQHbNVAg8AQhZQVm/WVColTUMPwD85apquLmcr0fSBpjyy+LmY/KpA8BLAFpvBnprKM7rwpTb4GvVaxvjKTj/hthyW1z67fHM5abI/RyOEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785301440; c=relaxed/simple;
	bh=2ak3odhGfkcMTrP24yYwlcPF5r1ds+C+7NFQA7Hbc4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCdilArlVHi68ZyJ26eZ6WHEULifkZeXhMy3XejQcm64GLr9wf2QWPfGXKc9yR6VCFD7LUyn47687EPCZh4er/PuM0VmtLYQeKVm8bQHdJ12UTmkWGe4SgPl/662JMGNKBnynZJN0MV/AmM4Z8K86hbOqeeBD8vleuRcgLTAVQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 810B7201D4B;
	Wed, 29 Jul 2026 07:03:54 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wowSQ-001pNA-1L;
	Wed, 29 Jul 2026 07:03:54 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wowSQ-0000000CKiD-1CKm;
	Wed, 29 Jul 2026 07:03:54 +0200
Date: Wed, 29 Jul 2026 07:03:54 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Zxyan Zhu <zxyan0222@gmail.com>, thomas.petazzoni@bootlin.com,
	Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 2/2] net: stmmac: Don't rely on the PHY for
 flow-control testing
Message-ID: <ammJus9isvL5M-Lx@pengutronix.de>
References: <20260728155728.1193169-1-maxime.chevallier@bootlin.com>
 <20260728155728.1193169-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728155728.1193169-3-maxime.chevallier@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Jul 28, 2026 at 05:57:27PM +0200, Maxime Chevallier wrote:
> For flow-control testing in loopback mode, we don't need to ask what the
> PHY is currently using as pause/asym settings. The PHY is no longer
> involved in selftest, we rely strictly on MAC loopback. We therefore

In case of the Full-Duplex, Link-wide PAUSE (IEEE 802.3 Annex 31B),
the PHY is not involved in actual flow control. PHY role is limited only
to autoneg part - announce own and receive link partners caps.

With this reasoning this patch will have more weight, i guess :)

> only need to know if the MAC supports Symmetric pause for the test, as
> we exercise both TX and RX pause support in the selftest.
> 
> Remove phydev requirement for flowcontrol selftest as well as the
> AsymPause requirement.

This is currently the weak point of generic and stmmac selftests,
we actually need to force the link in some specific state.

On the PHY side we would need to enabled force link mode (disable
autoneg) and bypass link-up status (PHY may still signal link down)

> With that, we can also drop the linux/phy.h include.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Otherwise, LGTM:
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
