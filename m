Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF01236DA0A;
	Wed, 14 Oct 2026 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792006907; cv=pass; b=bLufYkMVWWHMdc8sfkmTAhYZuBwcgAON25ggUWxoADuJ4CBygCMRCTab147Hl5FFtg/tXOcnf18MeJl5XjogV8zlTs+voWlPfIevL8+EocZSeHOr+PMRKp5BS8T0dwKK4eeu+4ZBwzzLo3cDG3eTnXZjv58QPqYC2d7zICjUkXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792006907; c=relaxed/simple;
	bh=3kiqDHXOFYarnpPmrSQ6KreQBzixYm9FgKqGaA3CXMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/BZxEqIQ0bVmIc1khQeKOf2XQ3tXtw/EgH0NeF6SKckmoR3+2d3OrxSeMdgntlH0eIL/mpbuRK4gkYdfFXdBDn73L2vYOb/pJALTVvBQUoXJoRbJMoBNzdeG7JsWUyz+kokycXJLn2CWWpIn1TBD9Sz+QzIiLRmhoV0L+dbCAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=W0Ubx5QN; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="W0Ubx5QN"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 66001201C8F;
	Wed, 14 Oct 2026 21:41:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792006898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQBqU5bjyvst58Zc94ghtKF7c6DSrihGDVx2Uj/uHQw=;
	b=W0Ubx5QNFt+5tNCfpIYQ52BsewhQo4t4p5+YiOgoQ+co54MM4YeESJ0TowRE3XAdb0BbKb
	Ea+gfqMsh7BfSp1hC6DufcCnqQeL4x52wMw7D6JQDSqczErcQ6zLjvz/Z7XYC8ntZYg7eb
	PuxUE2my2rCu/ApXpkg5EqaOv20xm5E5YDCjUHjhlsK9s1uC8WczPBXGK7djPpSurBlqJm
	PU39laKcpb4rVjoVtp9duXoWyvVBYXLhIt1mY9WmgYEfrmTrwHv1OWMcO/6KXXrLlks5Mq
	6cZS6vSPbjnE8PQws+iahHMx32vrMYaF9M+FLKmQRgXuCH7ceVTKJMXzKaO+jA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792006898; a=rsa-sha256;
	cv=none;
	b=RSebYfutT3dLYGHUDo1Gg3wUAcL+TqkcTZ2rOZu22f1s9fzVQyhX9kaSOtdpKpwklce/ZD
	/1SAkHDagZTT/mXUwoaVJiQ/8E42OU+fIDRowPvU6dxkIJsFAkiMeUr32/UXYN+U1FUUef
	KFFSIGfyfevQC82HNuLjJpqOvzx2DYsv8ukTsj8DH74F5cTX9/up9yUd5ZWJV7azuLgqw2
	4pKyly6IaTXbrI0FdIO5F/Zb56Z9BlTbZgRpAufNfSM57QaLwdq4zyaQK6PKxM+0cncJTo
	cCm129gQwdFNkUtreQB/c9Y95J2MVLjyl/VDX6a0/TK0iDvnH//l4/PdUzdh7A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792006898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQBqU5bjyvst58Zc94ghtKF7c6DSrihGDVx2Uj/uHQw=;
	b=Vw4ROAOTkz6DkXlDgA+XKY36lBANG1hfuNV2fM7GTzWKO6Cc/PpreS6FRDEkNZMry/oxL2
	19d+6hq1gWgswDEid7oTuPciqQWh8Dwk/Kx5q60nmmwebkqhuQ7IdbOEsYklbFT6VmPZGx
	lalY4inVvI2M/HI7Pui0LW0+q2vS3nIn/bODWfcsYuxVRwnM1VvgZgOGHTVWgXwPc4l2tu
	OLpnzvKiTVLd+tMoB1Yrq4IC1qHxdP3AMcYse21ymRZ15tIWExtXhezQH2grFBTvsn0wA+
	H0zADIOvNx7xsBQmLYFJP/7QygFhI0I2Sa3rW/LegcaT6yMk/3n5bO+yPRi4OA==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xH4r4-005uMh-0w;
	Wed, 14 Oct 2026 21:41:38 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xH4r4-00000004lyy-0bAo;
	Wed, 14 Oct 2026 21:41:38 +0200
Date: Wed, 14 Oct 2026 21:41:38 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, netdev-bot+sashiko@kernel.org,
	sashiko-bot@kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 0/7] net: pse-pd: decouple controller lookup
 from MDIO probe
Message-ID: <as_a8jrU9F45iCk4@pengutronix.de>
References: <e70bea49-c18a-4d47-9cf5-fd7b8e7675cc@bootlin.com>
 <20261013090933.3552546-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261013090933.3552546-1-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi Carlo,

On Tue, Oct 13, 2026 at 11:09:33AM +0200, Carlo Szelinsky wrote:
> On 10/13/26 10:39, Kory Maincent wrote:
> > On 10/13/26 09:40, Paolo Abeni wrote:
> >> @Carlo: you should always reply to the AI review, even to point out
> >> previous discussion on the same point. And you should try to be more
> >> concise (even in the cover latter, should a repost be needed).
> >
> > Indeed, the cover letter should be more concise. It's hard to read like 
> > that.
> 
> Hi Köry, hi Paolo,
> 
> Thanks for the feedback. I will reply to the AI review points and make
> the cover letter shorter.
> 
> I am already working on v9, because some of the AI findings are real.
> So if you don't mind, you may want to wait for v9 before reviewing.

If it is possible to split this patch set, please try. it will be easier
to pass the review.

Thank you for your work!

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
