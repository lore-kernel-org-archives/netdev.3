Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888A7305699;
	Wed,  5 Aug 2026 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934039; cv=none; b=CAwjpN7Yc0QOfQ5M9d6tFe5iMYKsIpgYhbm9USX9RC6HmhaOY3Y+JFDXLmpBimCI4RsT6axNbg8uta9o79n/9lcziqCIazB8Jjvt22UxIZXVdzfjQVjONEhD/F5wiskQzP09hbJuuRaecDShV8SxDELMgektf6XxlqgVbXDvXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934039; c=relaxed/simple;
	bh=xf340/v81aD1Z8x2TD+r856jjq9JKRBwe08tRknLpTE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iOTlpTjW8V7KglX0hmXQsc91jmhp8Se9a7LwwXAPc4A+TVQLoipJ+3EZC/fwT8JuaUp6Hjg9eXzdI63zY/QOnSC8PkvNHPyRB0NtLzVX2M4a82JrP+Ha8Iwe/iWhIAalNAqgMqMAb8OqvIU1XI68ZQ8tuNvT6eiiDbIU3DQPdtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LsPW/uxw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SBTtmLSg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LsPW/uxw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SBTtmLSg"
Message-ID: <713da6b8fd1d46964cc51696af5dd60d41895153.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785934036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0o0HlFz+E041vSU1Aqlu5PMMeBFHuuXFr+YnBTUN1c8=;
	b=LsPW/uxwEwR7ZxQGMAOChcb4vIFwvw3G+cDUJyn+sBnNBb7ukshmJowZgtmnaD8E82u6vx
	ZAWaG/7H3sn+CH0N/VXiU2OsiTluhT45CiJLDH+kNgxkj+pLeg0wg9JFtUxDRfgGwmj+tU
	+FC4iaeOLh00LcGvRk8VqutPmBcEJ1+RAwC9S1bxzAzx8qHJv0ijeCZ8ekfwGS0ABDEFwv
	8M7llWVDErE/tPeuX0rVYrZgX5+eoXXEZ+00tQW3sS38qaKbkk5fkgXuJO7QLtlglYDLVe
	EWAEue577Fpl5vumbdIPik+jlHmAsJyPZEJi6zUcl+QhKu3KbZHdieUIcYYS4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785934036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0o0HlFz+E041vSU1Aqlu5PMMeBFHuuXFr+YnBTUN1c8=;
	b=SBTtmLSgrHunueEqxOuBeDh2mSwVSJvzR+QDFxbWM8J49AcEgapiHs1YsKhdCnmNSPpvwI
	z5i4jKANQqWbpTDQ==
Subject: Re: [PATCH 3/4] net: dsa: Add support for SoC-e SDSA tags
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
Date: Wed, 05 Aug 2026 14:47:15 +0200
In-Reply-To: <6129c629-370e-4081-89d2-6dbf1a142cd7@lunn.ch>
References: 
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	 <20260729-devel-vstrassheim-soce-dsa-ml-v1-3-be569dae1b20@linutronix.de>
	 <df7e7e04-80fc-4b80-9afd-0e9bc14a759f@lunn.ch>
	 <723a256eb9d5aa64e7037f98eabeeb99257f03f2.camel@linutronix.de>
	 <6129c629-370e-4081-89d2-6dbf1a142cd7@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-03 at 18:46 +0200, Andrew Lunn wrote:
> On Mon, Aug 03, 2026 at 05:37:26PM +0200, Vasilij Strassheim wrote:
> > On Wed, 2026-07-29 at 19:22 +0200, Andrew Lunn wrote:
> > > > @@ -98,6 +98,12 @@ config NET_DSA_TAG_EDSA
> > > > =C2=A0	  Say Y or M if you want to enable support for tagging frame=
s for the
> > > > =C2=A0	  Marvell switches which use EtherType DSA headers.
> > > > =C2=A0
> > > > +config NET_DSA_TAG_SDSA
> > > > +	tristate "Tag driver for SoC-e switches using EtherType SDSA head=
ers"
> > > > +	help
> > > > +	  Say Y or M if you want to enable support for tagging frames for=
 the
> > > > +	  SoC-e switches.
> > > > +
> > >=20
> > > These entries are sorted, so it probably should be between
> > > NET_DSA_TAG_RZN1_A5PSW and NET_DSA_TAG_LAN9303.
> >=20
> > I will insert it as suggested. To better understand, what is the sort o=
rder?
>=20
> The tristate string.

I see, thank you. I will keep that in mind in the future.

>=20
>     Andrew

Vasilij
