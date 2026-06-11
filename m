Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A91A3659F9
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163324; cv=none; b=aqjyhnlYt0BArfOyfceMKRAxDNVjGzQvWXSq2WBKC3EhJ0GS8iZFH7IHtS/beYVlcqFPoVzUrxsWMTYU0qf4MEsmOZ4Cp8H8n3p1+ScxLItVqkaHV0nDgAOqXUE33UeYj2ATMRV2epvCHMCdUgLvZJZBsZ/k5omDZEyRNaHzdxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163324; c=relaxed/simple;
	bh=UnF+K8mAch3WlaWSjNnMqittAUFmEeNUuwD35qLGH6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3i2NEiQkF8pnvSI5nEBn/SrMb+QEMosyZvfemDItdXvsqayecd6TxDWZzHWzfML70KBOFuyh8c3agwa1Gq027yAV5CzB5soC9tUKCbKhw7F0kz2EAQauCTLEM19sQ+2p7Vln9avY5ki1BMEFUJOP99ZmtdS2iNam5OKb+PlToA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JB1BU9Ow; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JB1BU9Ow"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2ED2BC49F63;
	Thu, 11 Jun 2026 07:35:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DD6075FF03;
	Thu, 11 Jun 2026 07:35:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 24531106B9D8E;
	Thu, 11 Jun 2026 09:35:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781163313; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=oWrXDoc/Z5sf3FfvsKqP53sLXdTXugEPb3P6LUGlfzA=;
	b=JB1BU9OwUJQ/KUMbD9QocM8tp2KM8xzX84hBbPdcDShynMP/hYWtymPf6qgrbLbxSgG4bo
	+YHXHjhr4GuS9hRx9PaqRZFBuUwwwLaXvoTxXJxxCdMdCyuSq5B9QmwO3DzBaQSlbgzkOY
	/zqlGlRSaMH22VP3szCZm+XJoCSSzwJJqgXQNTO2j8yeu/CbAyIUT7jDgJKEo/AtsPMgLe
	0d+H5bddhBM41XmZ7zOvNc9mQ6Poc591yqmkZQD1hsW0JABrWj4gQq6lZ3XXNbKeO+qGC9
	bvtgm55MjtQH2RpiDRGyAQcryhpoboGdLNlXvLCh1i3CPVnvDrjs/gwUHcVTdA==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: phy: dp83869: Support 1000Base-X SFP
Date: Thu, 11 Jun 2026 09:35:08 +0200
Message-ID: <uKjb5R6hQWGmAlZw6eSfBw@bootlin.com>
In-Reply-To: <6c4f54bf-383a-4ff8-8389-99592a8fcd16@lunn.ch>
References:
 <20251110-sfp-1000basex-v2-0-dd5e8c1f5652@bootlin.com>
 <a5OAN5n1TlqpbApOWnEEjQ@bootlin.com>
 <6c4f54bf-383a-4ff8-8389-99592a8fcd16@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartClt-0xiRStOqKBHrfCgO_w";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPartClt-0xiRStOqKBHrfCgO_w
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 3/3] net: phy: dp83869: Support 1000Base-X SFP
Date: Thu, 11 Jun 2026 09:35:08 +0200
Message-ID: <uKjb5R6hQWGmAlZw6eSfBw@bootlin.com>
In-Reply-To: <6c4f54bf-383a-4ff8-8389-99592a8fcd16@lunn.ch>
MIME-Version: 1.0

Hi Andrew,

On Wednesday, 10 June 2026 22:39:12 CEST Andrew Lunn wrote:
> > > Why is it safe to call dp83869_configure_mode() without the lock, but
> > > dp83869_config_aneg() does need the lock? And what are the
> > > consequences of not being able to get the lock and so aneg is not
> > > configured?
> > > 
> > > Some comments would be good here.
> > 
> > Since phy_port has been merged, I'm currently preparing a v3 for this but
> > I'm in need of some general guidance regarding this
> > `mutex_trylock(&phydev->lock)` which has (rightfully) sparked some
> > concerns.
> > 
> > What data is supposed to be protected by the `phydev->lock` mutex? Is it
> > every field of the phydev struct + standard hardware registers + vendor
> > registers? Or only a subset of these?
> 
> The phydev lock should prevent two phylib operations happening at
> once. It also protects the members of phylib which are accessed during
> the callback when the link changes.
> 
> Phylib operations should include access to hwmon sensors and LEDs, if
> there is a danger such access could upset things. Since LEDs come
> through the phylib core, locking is done for that in the core. But
> hwmon sensors are not part of the core.
> 

Okay, thanks for the explanation!

> Since PHYs are pretty simple, and MDIO operations take a lot of time,
> it is better to hold the lock than not hold the lock.

ACK, so presumably we should also hold the lock when doing 
dp83869_configure_mode() since it modifies PHY registers. This'll be a bit of a 
headache since configure_mii() may be called with the lock already held or not 
depending on the call path... I'll see what can be done about this.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPartClt-0xiRStOqKBHrfCgO_w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmoqZSwACgkQKCYAIARz
eA4z7Q//a1x28Z5jUZ5+PcLShDgCu1z54he8I4d5+rG186nuEAmfnHKV3QpZDTVn
zwLR9Kk93IrnPRQmiZ3blq3bTICFsNiyclSTtM/9DwhveGBLTmgc1GcTX2tXd+Bb
YnPmZZPBR2idGnikJGZ+MbQ9sAFwVozFmzFJm9LhuyWGtzcvl3BaXMW1gMcFqF93
AvwqrOZNpCMIBlbstTo/e3ZecLwseFNve7zXxkkF6FZYk+aou/X69e4byeFNkHii
SX6rhUAGJnSuvWwAUpOeeMr83Qihq10BuYAzo5Hnbk6+6Zzk7uw1og8uurYz/E8T
xH22pYf0cbPpL9SOiMNb9GN6A68DDL5/m9AORVPsbUnIkzz6XVXPcOVwiPzeiMT6
qmXEMkVfIDHjfkvSAdgjv9EILRqRTpICOitJii649gjDbFN7mrncZbF97vjgb52t
gtSBhob8MIog+kcQ+AEkf3O0HxdLJEJcDKR5p9OzLqZCWSwf+UjD/1A9K1iGpa1F
i2zHi/4ZuqnlmQZfnTSvrFezqeJxuD9dbZQOmTRqCszzcsyxHukOSKVKvIIGfm6d
y/9riVrrI9V41KqF9UD3ZRPqGgXCHsbBymFCr/MVZ8k2mpgZMwBSeVz4qSNSDuf5
+c/LH76wUQBjYClI7uzJj6WaFP7R9URltnKoGf7ghqi40GVYyEE=
=+1rJ
-----END PGP SIGNATURE-----

--nextPartClt-0xiRStOqKBHrfCgO_w--



