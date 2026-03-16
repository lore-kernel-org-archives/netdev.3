Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB8349B18
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773641556; cv=none; b=aXZqwhiYS5dJky15cqSzFoXLB8d20/h8PSGLMBF5R1vfdv5t2oCWcPBiP3zlwp3eqV3NvctsNRkn11i69wbDGHBcvfDRks1jPwvncXuh+QVGWdVyVw7q16W4mVwdGrZ29WsAem4Rvhj87O9BirOHW48aa1jEScdSskNfEoEgtTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773641556; c=relaxed/simple;
	bh=dlr9RcEMDDnguoCWxM6vBY1CTWKzuOdeD40kzUxoQuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnQG+xBbtzbxqO+MEGZJtvwuiE2vdVHi2IK98odF+WQccFi+nK+l74DfBWva6bnfzuOCWFxdyH0vyIAMwfGQIcZORVUqdl8jISGz6FjcDwSCH/S39mxV848ZLpJWohFwcEQ/KnSrLWyvZMg1ueJegtZ9B//A4BFQI+SpJ0sQimg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1w21Bg-00079Z-IX; Mon, 16 Mar 2026 07:12:24 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1w21Be-000WV7-36;
	Mon, 16 Mar 2026 07:12:22 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1w21Be-00000005Mwu-3Y2R;
	Mon, 16 Mar 2026 07:12:22 +0100
Date: Mon, 16 Mar 2026 07:12:22 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kory.maincent@bootlin.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, kernel@pengutronix.de
Subject: Re: [PATCH] net: pse-pd: add LED trigger support
Message-ID: <abefRjK49FtJWGTr@pengutronix.de>
References: <abblHRq6Q85j5lXA@pengutronix.de>
 <20260315211222.2519478-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260315211222.2519478-1-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Carlo,

On Sun, Mar 15, 2026 at 10:12:22PM +0100, Carlo Szelinsky wrote:
> Hi Oleksij,
> 
> Thanks for your kind and quick feedback. I appreciate the time you
> invested on the weekend :-)
> 
> I will look into your suggestion and try to work on it... 
> 
> Regarding your question: It is a simple POE chip (hs104) that is
> integrated in different cheap realtek managed switches.
> It communicates only via i2c with the host and does not have any other
> GPIP/IRQ functionality. The problem is that the LEDs are controlled
> via a different (MFD) chip that communicates via i2c as well. We
> wanted to uncouple this as much as possible to keep things clean.
> 
> More information you find here:
> https://github.com/openwrt/openwrt/pull/22245 [hs104 driver]

I would add regmap_range , otherwise regmap damp will try to access not
existing registers.

> https://forum.openwrt.org/t/support-poe-on-hasivo-devices-s1100wp-8gt-se/244817 [discussion]
> https://github.com/openwrt/openwrt/pull/21578 [MFD LED controller]

I guess, here we will have some discussion on the devicetree binding :)

> Side note: We are working hard on supporting PSE-PD for openwrt
> (backports to 6.12, luci, netifd support) and we plan to port other
> old drivers.

Very nice!

> Do you think this simple driver for the hs104 (openwrt github PR)
> could get merged to mainline kernel?

Sure!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
