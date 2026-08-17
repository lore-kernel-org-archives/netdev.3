Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163CD3DB326;
	Mon, 17 Aug 2026 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974720; cv=none; b=e39hrHl2yi6hOXzJOYr9R6iAjNWJcwcfmPyo1MsaxoE/CD4vBDFSdZkP0SClS34v0WaKp/W5NWApbUe6o2Z7J9VjM/Ey6f9lZmHxEqQpYj32f70NX4Gte2oox3kojGWth57De++tVErFe/rafmqa4TbuVxEoQh01YIUvQ+/A7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974720; c=relaxed/simple;
	bh=ionovE/b3eILHUWfzw0IafIEx75nZh6h/mLl9cF5/Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z39q07i2/DhrzgzstP7OwI/LrzjWOgxjKlAL4GGsj4C/tlpR5Rfeggkv64S8I3RLOqvYIPEgTUZLz1WFqwrPae7QLOiAlRZaqRB7AOlb+8WjK9sD+eZIsPimc75nl64blf3XoJDEM0ge7aBRjjfCZiJsL/W6niXwfZ9uVZvrKKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B0061200C95;
	Mon, 17 Aug 2026 15:51:47 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wvxkh-001xqY-23;
	Mon, 17 Aug 2026 15:51:47 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wvxkh-00000009p24-2BDk;
	Mon, 17 Aug 2026 15:51:47 +0200
Date: Mon, 17 Aug 2026 15:51:47 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
Subject: Re: [PATCH net-next v1 0/2] net: dsa: realtek: EEE support for
 RTL8365MB-VC
Message-ID: <aoMR80MH1eLBBLsE@pengutronix.de>
References: <20260817134758.4182833-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260817134758.4182833-1-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Sorry, i missed - it is merge window now. Will resend it later.

On Mon, Aug 17, 2026 at 03:47:56PM +0200, Oleksij Rempel wrote:
> On these switches EEE is enabled by default, but so far it is neither
> visible nor controllable from user space. This series wires EEE up to
> phylib/phylink on the RTL8365MB-VC integrated-PHY ports so it can be
> observed and controlled per port via ethtool
> 
> Oleksij Rempel (2):
>   net: phy: realtek: use C45 for RTL8365MB-VC internal PHY MMD access
>   net: dsa: realtek: rtl8365mb: add EEE support
> 
>  drivers/net/dsa/realtek/realtek.h        |   4 +
>  drivers/net/dsa/realtek/rtl8365mb_main.c | 123 +++++++++++++++++++++++
>  drivers/net/dsa/realtek/rtl83xx.c        |  20 ++++
>  drivers/net/phy/realtek/realtek_main.c   |   2 +
>  4 files changed, 149 insertions(+)
> 
> --
> 2.47.3
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
