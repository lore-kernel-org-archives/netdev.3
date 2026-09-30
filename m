Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2651D3B634E;
	Wed, 30 Sep 2026 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776874; cv=none; b=dtTGy59m0r3PFZNjQJVz3bBw9U6jP01toPezXzL7Vh1LMo/jpLsSNeH4N+Zf8wD+duZwpTDX10Dzz19MxuiPdyXpf0R+CdrJkao+E6Id70opVWpUOrCEr5fny+TWuhAQPn8Pl2J6Ye55irODnrT4PqWJikSS4JezASwjIbz/zMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776874; c=relaxed/simple;
	bh=Nj9rD/39m04hvIh2+54l5897uaQ7OedDuJymjYcq4uE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mtkL+kU/X1cGr2CDuL8YozUzGwGSPqeAh4OQdu5U7FJ81k0MxSmIKJ9BUHHtf7zT+V0hxt9jI+wGGRRFlzRu88O4Evp3uPxESdeRpcNemPvS01U3iYy9sp0DhDy/8AVEbApnW+sFW/sRGJvvQRBI2vpVFIF0EL7Z9l2aQLZM/Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WHlNUV/R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xbllk66O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WHlNUV/R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xbllk66O"
Message-ID: <218d4c1cf5f05cd6cc648c01f8a20ec66b95362c.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790776857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=laEGmVJZvNVKahu8x3VIGJAJ2ykpNiay6kRgzzv/wCo=;
	b=WHlNUV/R4hXsWOPE2js82WnoXS8tbZaYSBz1c+SIeADxtatESIGSuNowqfShomYDWuSQ40
	wge/0fK/vHDtR2/8PHgMjvBJQe+toRvo1FssGk6MTjvMy5CJ0Qv+iPRMuori2k+3Dj3GOi
	MFr4gWSl4PyKIcA1o/3FiqQoK0jGWlB4dDFS2tsMvjjQdHonA8RW2u52yNZEHlFD2Tuvgv
	pHBp+6pUVEnCSKKZCjnLb/YQb3q/HSVC6axLmdbo4XnfGUPJAOm8LnlAr1MfxtafYkIEPr
	xawKGwMp+w+dXhNtB04edeF2TAioxiscDg6h0zWUwlu4ZwKcYMCwfogsG67bqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790776857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=laEGmVJZvNVKahu8x3VIGJAJ2ykpNiay6kRgzzv/wCo=;
	b=Xbllk66OjXN0ePb3Tc6Nrmq71RrjAosY+2PGeEx6KBo59ORu9b/39X+lfyqf6wMgrbTtAF
	vLC+VAkgOXEpz8CQ==
Subject: Re: [PATCH net-next v3 2/8] dt-bindings: net: Add SoC-e SWIP MDIO
 controller
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Wed, 30 Sep 2026 16:00:56 +0200
In-Reply-To: <e5aa5cd8-e805-47d3-a105-07bf1b9eb9b8@lunn.ch>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
	 <20260923-devel-vstrassheim-soce-dsa-ml-v3-2-ddebafcb9ba7@linutronix.de>
	 <e5aa5cd8-e805-47d3-a105-07bf1b9eb9b8@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-26 at 00:55 +0200, Andrew Lunn wrote:
> > The controller exposes separate register regions for transaction data
> > and for the shared transaction control and external bus selector
> > register.
>=20
> > +examples:
> > +  - |
> > +    mdio@204 {
> > +        compatible =3D "soce,swip-mdio-23-02";
> > +        reg =3D <0x204 0xc>, <0x200 0x4>;
>=20
> At least in the example, they are not separate?

Not separate regions but registers...
I'm obviously bad at documenting things.

The current information in the commit message is misleading and
irrelevant. Looking at the bot's feedback, it's at the same time not
clear enough yet that the mdio controller part is mapped within the
switch memory and can't be used separately from it.

I will update the commit message to something like this:
Add a binding for the MDIO controller integrated into SoC-e SWIP
Ethernet switch IP cores.
The controller shares the memory of the synthesized switch IP core and
cannot be used independently.

>=20
> =C2=A0=C2=A0=C2=A0Andrew

Thanks,
Vasilij
