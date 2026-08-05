Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8873BCD0B;
	Wed,  5 Aug 2026 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934092; cv=none; b=q406qyNCahqPdnOqSIE1GudeU1X+5r1jr6qHcdW8Xcw7h66hkRaxSaOETshq+oZIZKWuvZR63Sk6TodtnCP3yEZWX0T0RnoztFkHfh44hi8HPqGQ6Z/fHZj4w1Qr376YmVubIpoPPGuf2Co1PKI3qtl/0ZxqgBG1P24nQXVRS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934092; c=relaxed/simple;
	bh=SmGA6GVPBCAcgqOtwFXWmeb7Ifg38i2Pg86Gk1nKyY8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e4fQB8PrdQWRkTMgGEZ5+AuepoKEhDW5BPxNvRBsRTaznbroF8F5dmTdO8VpyO5XoPLI9nlbg4mWFcqnkEC4bZBjOnrL6zH0m3Wf0Ku28asyDn6LSPP1i0jkd5vlN0sVL9S6QCZuDmF59EXE5s3f0Wq0nOx5X//60yEnjQXcxC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ylR5X+Co; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D3D4lk6n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ylR5X+Co";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D3D4lk6n"
Message-ID: <e7cfe930b25998c9a8984a9cf68f75621c1b7b40.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785934089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ShOxBgD3vvx/gS7fujvEeEZYIZ9DQutfRZjzA/9RXg=;
	b=ylR5X+Co3Rij0RmV1x+OiBcPOIoByBd/Pt8DkbRz3z13IIUU7lwYWKAOALOY78WYKGIhlW
	E0CjP6aBvIs9LzJuWMN4wOOCj/gPG80vT/MmpEqvGJfjdZIbYw6sZwsOxPCg+Xcj+R77Yb
	sg0mriqIB+lxD/Icm74vPaHjcwKERIz+3iiEwMwHL6/tqot08jpHeraEZqRGEIyDmXHpog
	xMarhJsxw48XcglHtPKGzMW6M75ygMalcTzlTLHxW/xcjFtszH2qW4tRA9+aZWlFNUjPON
	H+2qn4c71c40/xmK/qqlD2luXUu7jnS1NvFBEGNaGiF0uhgahl1Jzba/V0+epA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785934089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ShOxBgD3vvx/gS7fujvEeEZYIZ9DQutfRZjzA/9RXg=;
	b=D3D4lk6neRZ+i1lMM5xDoA7hY/wd4E6RqVV+ImLIBYMDdQXXOHFk5YLebGkqNZ7rHsI9ca
	V6yIwk5pxD+lGDCw==
Subject: Re: [PATCH 4/4] net: dsa: soce: Add initial driver support for MRS
 switches
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>
Date: Wed, 05 Aug 2026 14:48:08 +0200
In-Reply-To: <653d9c23-6087-4e7f-ac01-fcb01ade405c@lunn.ch>
References: 
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	 <20260729-devel-vstrassheim-soce-dsa-ml-v1-4-be569dae1b20@linutronix.de>
	 <f17d3a62-456f-4580-90bd-c54a30dceddc@lunn.ch>
	 <cee2e05d931a977d0db938ada0964d05885949a5.camel@linutronix.de>
	 <653d9c23-6087-4e7f-ac01-fcb01ade405c@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-03 at 18:49 +0200, Andrew Lunn wrote:
> On Mon, Aug 03, 2026 at 06:01:23PM +0200, Vasilij Strassheim wrote:
> > On Wed, 2026-07-29 at 22:05 +0200, Andrew Lunn wrote:
> > > > +static u8 soce_map_stp_state(u8 state)
> > > > +{
> > > > +	switch (state) {
> > > > +	case BR_STATE_DISABLED:
> > > > +	case BR_STATE_BLOCKING:
> > > > +	case BR_STATE_LISTENING:
> > > > +		return 0;
> > > > +	case BR_STATE_LEARNING:
> > > > +		return 1;
> > > > +	case BR_STATE_FORWARDING:
> > > > +	default:
> > > > +		return 3;
> > >=20
> > > #defines for 0, 1 and 3.
> > >=20
> > > What does 2 mean?
> > >=20
> > > Since you don't implement bridge offload, i'm not sure having STP
> > > states makes any sense.
> >=20
> > I tested bridge and STP and observed the callback calls with something =
like
> > this (reduced setup):
> > # ip link add name br0 type bridge
> > # ip link set dev port0 master br0
> > # ip link set dev port1 master br0
> > # brctl stp br0 on
> >=20
> > That probably wasn't enough. I'll take a closer look at it and either f=
ix it
> > or remove it for the next version.
>=20
> For a really minimal DSA driver, look at mv88e6060. But it is also
> really old, and does not always follow best practices, e.g. .phy_read
> and .phy_write which should be replaced by a Linux MDIO driver.

Will do that and compare it with newer drivers as well.

> 	Andrew

Thanks,
Vasilij
