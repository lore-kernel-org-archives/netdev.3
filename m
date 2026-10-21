Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792574230;
	b=gbQPtsyriJFzEvAPHSjF7lKOqPd9hSDklBs9S3XavyYSuHDejrqLdIS9pZ+f9ojJpre7
	 CI5IL/dVQ2Yk72zTOM065038sCyXZWO07EVPgBLLkUT/XhWlavMBhCgKKgb3ymN7gq5ci
	 StwsMtn/KHP5MNZxQU3Ihzk2V4Tj0n4unqMxBZp2FSIupoBcPp5RZ/ukMMYgubQ/2qQ5C
	 oVT7pJYkJog+QO5IfOwiwPnTdWLXAwNVhUduHiYJfpmCfw2RPkMl4qnqghO2SjpntHVpn
	 6awTqt9lKbSK5hi10OJYsNFcRyPNHLHH50Hj6dt6aZMspfiKgsy9AYDnOBjyUt662jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574230;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=9EKReBFykn7zhpEX3hn+iTvsvnnuD91vc8SRQOGYI+4=;
	b=xQT/uMpniZ8Uft4af25u0hecVEQ6wuV7SUnvfYGvhxHZdmXUVbpy7iSlWz1JtXo5kpEB
	 YVxTmbVm3g6mItIdqxqv3V+hu8FqWOnVTa9eowPeq0ATUN8ONn+Rj+dZv5yWSa/wUydde
	 Q5cDOQqK9coPNSXmU0KkIlIY9v7WJynIe25hsKjayNjrFWQGor0NIUwSQEVZXBcLW/dLX
	 XIo1+MJ1d71v3c+TnFi/D8gZJ2qSnpFqbobRkrCUNq+lvKgNFpgMre1eQz+a9peqyyqvm
	 sktzTnUNAuMn7ts2sA8mnBpdhOFCIxwCGGgGWKCAOAgo3W2rhmML5JSV30kKsx47iSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XI+rK7Qm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF953606A31E;
	Wed, 21 Oct 2026 09:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF953606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XI+rK7Qm
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1B9DA201EF3;
	Wed, 21 Oct 2026 11:17:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792574227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EKReBFykn7zhpEX3hn+iTvsvnnuD91vc8SRQOGYI+4=;
	b=XI+rK7QmMxHtwwrzd8K6EvVXzUXwEaBp83ZVI/e2MCiXmYrnn+uGOLo/2ytCPW6VB5LQJs
	dTf5OCQ4sBWAXDKxT7TH0r1aNrz+ECTkK60pULRBbYpiK+C+iilS7od/ea6Cxj6O+Ry0SS
	nfrW7Nh3PWP/KeqvlXzF+koHmM9X9PDrPNiuE82Ywc7T/s4Uaad6jnHXalRl7+u1AK8RQC
	7guFprqNXEQY/GOn9zH8DLd4h3QbcTVpxS1yHe40Ob/h9P5VKzMHXWefLjOgg2ihLxdohj
	GBc6aXXlmuF/7WDnerFzeOHWiSbhWGM4c3+RLikPFQCgyzNo4W0ND8L9o/CJbg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792574227; a=rsa-sha256;
	cv=none;
	b=HG37pnBOBiCsCwqKm+nxbY+6/CpDS/Lfmzl83u79VnDQOkx7e6ew+poPoDFnRtg2r0HAvW
	sjOreQbP8Zg2et2ZTrseRT1eeG6TpPx1CUdewM2EnyIWkYuKF2LdQoSNBNxCcb9Ha7UyO9
	xItLAMT0ZWRtZFWof7X7rxmLOJmkUZAUl+tDJmIq5PjZII57mDli71syIn26jeczC1Hfh3
	+AkIEUcxb61p5LMK1C4P6zxxGZPt0v+Tg2na7l7BkPFw2Okw+18dxtnjbwu3P6074Q04dc
	HkdH3B2YOfDQsZ8Q3dW00bf33+iM73yMK+9bt4YOwJtIoFuLEGtIDnWfzqz2Rg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792574227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EKReBFykn7zhpEX3hn+iTvsvnnuD91vc8SRQOGYI+4=;
	b=GO3itgvn0pGddeD2kw1+ZfaPEclmudj86AefK5zHTu0uFi7fra5vfwuwkQn9KbXP7q2wQU
	E4Pf7wi2/QIwRO/rLJWarEhQ5wHg63rS5pqRAjj4lnAnX05c+W9yS+pFwKWHTs6OgGGX1p
	EiiuVom9+nEoqAVnePlv7+egXBvtqOnaV+m0vTQvl/zqXuNiTO3JF6ot7CRQSxkPtSR98o
	x+0aqwpKwyHULrgU3ynXQUcI3TG/irvS6yWvn3HiyUuTl4xwLqC9HdhqFgChkPyFQRRRVg
	4JktSCZfh20K1g91NhWUs9Y3ChdNTGgPOUa45oE+1jY8pYlk+By1E4Eqpe8QJg==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xJSRX-000XJw-05;
	Wed, 21 Oct 2026 11:17:07 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xJSRW-00000006ejd-3pcm;
	Wed, 21 Oct 2026 11:17:06 +0200
Date: Wed, 21 Oct 2026 11:17:06 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>, Ross Cawston <ross@r-sc.ca>,
	netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net v2 05/14] net: pse-pd: do not reach a freed PHY from
 the notification worker
Message-ID: <atiDEviXh3A5jwzp@pengutronix.de>
References: <20261020171249.853085-1-github@szelinsky.de>
 <20261020171249.853085-6-github@szelinsky.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020171249.853085-6-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

CCing: Maxime Chevallier <maxime.chevallier@bootlin.com>
for phy_port part.

On Tue, Oct 20, 2026 at 07:12:40PM +0200, Carlo Szelinsky wrote:
> The notification worker holds a reference on the pse_control, but not
> on the PHY that psec->attached_phydev points to. If the PHY is removed
> while the worker runs, the pse_control survives and the worker reads the
> freed PHY. The same happens without a race when two PHYs share one PI:
> attached_phydev keeps pointing at the first PHY after it is removed.
> 
> pse_control_put() unlinks and frees a pse_control under pse_list_mutex,
> and phy_device_remove() calls it before the PHY is freed. So instead of
> taking a reference, let the worker look the pse_control up and use
> attached_phydev under pse_list_mutex. This nests pse_list_mutex inside
> rtnl; nothing under pse_list_mutex takes rtnl.
> 
> For a PI shared by two PHYs there is no single netdev to report to, so
> clear attached_phydev when a second PHY takes the pse_control, and warn.
> Events for that PI are then no longer reported, even after one PHY goes
> away. Failing the second PHY instead would fail its whole MDIO bus.

A PI shared by two PHYs on one connector is a rare setup and no in-tree
DT has one (prtt1c gives each PHY its own PI), so dropping its events is
fine for this fix.

If this is ever lifted, the PI should hang off the port rather than a
PHY: a PI powers a connector, and with phy_port
(Documentation/networking/phy-port.rst) net-next already has a port
object to attach it to. That is net-next work, not for this series.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
