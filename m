Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793356951;
	b=WjMv7QKHr+LIse2gN1zdZIrGP0zH80Ot9KJ3DQ7qJSteU/ID84XE1CW3pl9A4Kpz91lx
	 7rztSTtRPuAu1MfEPqOI+4hEw1Ot1b4H1gKwNzmGq++oFLSOd8G2xawpsn6/0Ungvg6ls
	 Kk9mBWk3Iq69nY6uBjVQQjZlC6LOZ9jM5e1fXbJJpuWB1s4qGb+PAmiZR3aaZJWpFoOMy
	 suAvlv63f8tAVDtOetGVPsjhrOUIsfFnssNviFHcOI1TfEaUqpAvP2k0zKVxCG5Wk4gbV
	 cQnE/Ku1ElLo6gowPq1DIxlWbJgINBI5jZRCZ3gEKfqrbRp6AH2MaXpkAeb/PynPVmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356951;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=exE+hHt5oQLFBWrYD1Rh+zr0AUD2QpnwnfsG4mC3MFY=;
	b=4NjfT8uecnq69ozAOieb9qU8Njywpm8hYfzuTWd9XOVuH78ixaE5BXlOUfxM99NmLFkk
	 UfpJ7XLtqyBaMzwvo+L5tpv6MBbzCZgc9943fix444cCLKzPju2TWlb+Xw1L1gFQXsx8E
	 6yQ2Pi1EPqm97epFTHMq70sjzaHT03+/+FXMnWaoQ+0Sy2ISsoJmV/COPhslIAMjLwD6H
	 i78uxglC+qSctQZWCT5H4vbYwGr+7jACUHVIW6fUUrD5zilAJKP/gNfc3qybkXXJfUBrP
	 fYUS+AJknTaKgT+R3C7QUU/WGRUEGxy870GVbJZU8xuWoL9euBbNuaJMteUHSvagK1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aY9yRZIh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798BE606A32A;
	Fri, 30 Oct 2026 10:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 798BE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aY9yRZIh
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 409BA2007F9;
	Fri, 30 Oct 2026 11:42:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793356947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=exE+hHt5oQLFBWrYD1Rh+zr0AUD2QpnwnfsG4mC3MFY=;
	b=aY9yRZIhh039IwXU2DWf1dZuEtB5T4HK4ECstmByqUYwciV67tCVO3pG3c24P4irt4onNX
	p8o6NaIuZrm5HkxR6+3BrUJ5aTPGEbcaMNsCHO3PD8S9gl6eCCCHAuQJsf6joq4EacFPHs
	fXg+jC0yP8RFkcx/90P+p5elCvPTrFsvSsAxuUP3hgrH9HoKX9/Wh7zOSqqQbQv2BJYOjv
	tj/NUTjtrWmlmSwIQjdBNCyCY5Sn8+P8c3TNF6misXF0+H8KMiKGnDzTkgdT4a1uFW3S+0
	SujX6AMro3JjTUzVpwAgZGWGUrih7SXZ4m4h/beaDzCemQf2cg6f3avxDXJIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793356947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=exE+hHt5oQLFBWrYD1Rh+zr0AUD2QpnwnfsG4mC3MFY=;
	b=AVT5i78lYaHZ+hblbkNogAi5ghNTNp5X7HSwH0/ccpC2UwqSb8y5ZjwrQ1hPrCv9Uxpd9r
	donv6rWnGF2zlECy/PGHOjHT6SAMRR54V29UgHYdlYAXRyaMpqvbEf7EGBWIyHbnOq5LQv
	X5qy/EQMP/f/YOwKEp/FGNN3Fwn1UgYWoxF+TbQaldgeInveGaMgpSS9CYJpEGTASR9vYX
	aTrFeLlBctqtKXlg6Tp1anIuItb+JWoZEPcm+oQ6uBY0Hvy8BSh7hUkKDvVEW7j8ftqCAp
	2ralFJ8fG+FCBb8OE7rNnawWAlEWLLyJB8/x3XzXRWTtjwArOmhDrnXl3wt9Sw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793356947; a=rsa-sha256;
	cv=none;
	b=cnmwy/oYBVOkobgdVRCeb28DXdGW1R1bjoBGMpVHZhXuM7hjjp3SEXMv1Yoc9iq4mUTOJ+
	DWPN5BpP3JircJE/NJEHageqloDkSyhbVwlsZbe/g2g0Dc4Qhq7y7oZInXG8epHr44ySxu
	qpwX7FxMmSJBfRtuqbwyZqlr03tNf4ZM5nSpirN36k8Y59G0hbUCLvlvuuDQ6MN+qSxTmg
	s7LkGPldFsF/MnOW2zXIhJK283pk1YXy/AZYSTOwXHHGfM6JKFNprtilvssA3mqqHV+cfY
	dDa8gMNJa7IFZ8Ib7r5WwYg7wFEYK/dS2fYLnxdqW254KDOjqDN7NjxHN7PkmQ==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xMk43-001rLi-0a;
	Fri, 30 Oct 2026 11:42:27 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xMk43-0000000EobU-0Gac;
	Fri, 30 Oct 2026 11:42:27 +0100
Date: Fri, 30 Oct 2026 11:42:27 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>, Ross Cawston <ross@r-sc.ca>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 07/14] net: pse-pd: do not tie a shared power
 domain to its creator's devres
Message-ID: <auR0k1ECrKc0awIz@pengutronix.de>
References: <20261023215416.1087206-1-github@szelinsky.de>
 <20261029104851.464294-1-github@szelinsky.de>
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
In-Reply-To: <20261029104851.464294-1-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi Carlo,

On Thu, Oct 29, 2026 at 11:48:51AM +0100, Carlo Szelinsky wrote:
> On Fri, 23 Oct 2026 23:54:15 +0200, Carlo Szelinsky wrote:
> > One downside: Mark and Liam would then have to review the rdev->supply
> > change inside a bigger patch. If you prefer, I can keep 12 separate
> > for them and only merge 7 and the power domain part of 11.
> >
> > Is that what you meant?

ack

> Hi Oleksij,
> 
> a short ping on this. The answer decides how I build v3, and I would
> like to send it soon.
> 
> If I hear nothing by Monday, November 2, I will keep 12 separate and
> merge only 7 and the power domain part of 11.

ack.

> Mark, Liam: if you find a moment, Oleksij's question on 12/14 about the
> PSE core using rdev->supply is still open:
> https://lore.kernel.org/netdev/atnK9lEinSLgx5yK@pengutronix.de/

On 8, I agree with Sashiko, please move the unregistering flag from 10
into 8:
https://lore.kernel.org/netdev/179274321725.3134.14426162965545087203@kernel.org/

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
