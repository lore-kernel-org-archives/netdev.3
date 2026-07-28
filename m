Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2839D439F6F;
	Tue, 28 Jul 2026 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243783; cv=none; b=Etfrdm3RSOEgWuR3Vbkx5Nhrg+kC2XJkpRA6hRMjOpbAGoy12Y3DPHalgMODrYB5+KR9wumDiQnTxvhW4RtexinJ4Yd+JYM9VZ6R6bm4lCsjFadBv/1qUUpVPN4QYFwVh4YuEpgyAZK5FBydacwQFT7NA8ywzEYE59+DCFekVwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243783; c=relaxed/simple;
	bh=gvpCeQyS5TDvo/bEC4OKuyVie3yWovgNWLeRRoPLdn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxm/3hXFwP2WmeXUZQ7myRMvKJyZPuPyw8SeFWyrAz9U5j9+XhBmGpSqHGKxPHjZtcOymWpYpmANzaqiY6sxQ92UitnO/A2lPhTltUDBMWiawXz2PPL+NUnq+bIUnY4K09+DCngoAxC768/UnvuUbgRjBWT7ACqBFPCtsCqPrFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EF5092029DD;
	Tue, 28 Jul 2026 15:02:53 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wohSP-001iqa-2s;
	Tue, 28 Jul 2026 15:02:53 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wohSP-00000009qkK-3F93;
	Tue, 28 Jul 2026 15:02:53 +0200
Date: Tue, 28 Jul 2026 15:02:53 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Zxyan Zhu <zxyan0222@gmail.com>, andrew+netdev@lunn.ch,
	rmk+kernel@armlinux.org.uk, alexandre.torgue@foss.st.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, hkallweit1@gmail.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phylink: add phylink_pcs_loopback()
 method for PCS loopback support
Message-ID: <amiofc_3xi5nAt5w@pengutronix.de>
References: <20260727120704.2319467-1-zxyan0222@gmail.com>
 <2c0c6864-99ea-48d6-a889-c886bb91c351@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c0c6864-99ea-48d6-a889-c886bb91c351@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Jul 28, 2026 at 10:41:12AM +0200, Maxime Chevallier wrote:
> Hi,
> 
> On 7/27/26 14:07, Zxyan Zhu wrote:
> > Some Ethernet MAC drivers (such as stmmac) need to perform PCS-level
> > loopback for selftest purposes when no external PHY is present. Add a
> > new phylink_pcs_loopback() method that allows MAC drivers to request
> > PCS loopback mode through the phylink framework.
> > 
> > Implement the pcs_loopback callback in the stmmac integrated PCS
> > using the GMAC_AN_CTRL_ELE register bit. Add a helper function
> > stmmac_selftest_get_pcs() in stmmac selftests to unify PCS lookup
> > across glue driver PCS and integrated PCS. Update the selftest
> > enable/disable paths to use the new helper.
> > 
> > Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
> 
> I'm actually seriously wondering if we shouldn't just stick to MAC loopback only
> for stmmac selftests. I even have a patch ready to send for that, as I've
> been struggling with selftests in the past days because some PHYs will
> either stop their RXC while in loopback, or bring the carrier down which
> makes the dev_xmit drop the packets we're sending to ourselves.
> 
> Using an external loopnback (in PCS, in PHY, somewhere else...) doesn't
> bring anything to the table given what we are testing today, which is
> internal stmmac behaviour. The MAC loopback (on dwmac1000 and dwmac4 at
> least) happends at the GMII level, so everything we are currently testing
> happens before that.
> 
> If the goal is to validate what comes after (RGMII, PCS behaviour and so on),
> I think we should instead add some other, more generic selftests that aren't
> stmmac specific, that we could run on any netdev, such as the ones Oleksij
> has added in:
> 
>   3e1e58d64c3d net: add generic selftest support

Ack, it is better to push the effort towards generic selftests.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
