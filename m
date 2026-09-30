Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CAA4F3EAA;
	Wed, 30 Sep 2026 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788420; cv=none; b=BH0xxkbI33CR8vKrodmh7jLeTwvzKJCdI60a9ksmEAwqnlYO76fqEyAPD0sA0RLS0fViG/kBh72JluBsA7RT2CDWTmygxU61SklqxhzY83efF6aLim+z8bXSlctrMUfyQAYBKayP7/UInqjpEE6+KRVatEQEx9F5b9jziVKcBpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788420; c=relaxed/simple;
	bh=ce/JtVI8RnJzrAoPbgkSOIWEObEQ67alIfJ11QoVAww=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bwzuj282tst/94fcS65/QKlPDaYp9iXgCnFCd2idXe3bP+3wRktBHUrix87D+KglOkdDEtTcD/2hy9C0zHSbLbJv6BUBxAXQyAgsAYxHLFtBz1F0kBbyRCHpx1BdVQAjMm7AsBiungQ3XsTuORYPP6nPVlUDU/qTo0UVg7NJ+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WfHQd/1E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bZCtTYvM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WfHQd/1E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bZCtTYvM"
Message-ID: <ad24be6928e33b544f9c8c72ea05f64c2968035f.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790788416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+pLxbbbXB6n3gBHBet+35rX1PK9v+XENj+TEEEUUSw=;
	b=WfHQd/1EFVvpsw7+3qLRlAyDz6bU1ML7jtk6fStade507LMkSmDUNBA0JtPMvb4Tt5/0HL
	m1pNsQ83PELUSrs7GCtsDBDCALUyrMPUSmzGeYuVQ8oGdz5EqGxRpmmoGWWSbwTJh4cxkQ
	Sx+L8hq+VIjleE8kZN4eZv/38P39R1soow0tvtgKz3KmTIwP3QMaI4tc3yr2XKJjEydKBI
	ZdSPdbzfEvU4XRtwGrfkmqpisUtMrx1hvREJbCYPkG63J3OsT54r6QVZ6anTUYoUiF1fan
	uzanslGQ6OCuy96Bsu/FJqBSKpd2xOw+5BvFfQD1Y6XveLcMASdGLP/y3XKWfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790788416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+pLxbbbXB6n3gBHBet+35rX1PK9v+XENj+TEEEUUSw=;
	b=bZCtTYvM6ZP54WCkLRMb8YW2kdSh1Ewn2XJN5d22ymg8qUO/xBK5dML+gQrfh+nAVqHzRf
	Q8To4scMvAXJWXCA==
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
Date: Wed, 30 Sep 2026 19:13:35 +0200
In-Reply-To: <6416b34a-83ce-4aca-8adf-c8894ca7b3c3@lunn.ch>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
	 <20260923-devel-vstrassheim-soce-dsa-ml-v3-2-ddebafcb9ba7@linutronix.de>
	 <e5aa5cd8-e805-47d3-a105-07bf1b9eb9b8@lunn.ch>
	 <218d4c1cf5f05cd6cc648c01f8a20ec66b95362c.camel@linutronix.de>
	 <6416b34a-83ce-4aca-8adf-c8894ca7b3c3@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-30 at 17:14 +0200, Andrew Lunn wrote:
> On Wed, Sep 30, 2026 at 04:00:56PM +0200, Vasilij Strassheim wrote:
> > On Sat, 2026-09-26 at 00:55 +0200, Andrew Lunn wrote:
> > > > The controller exposes separate register regions for transaction da=
ta
> > > > and for the shared transaction control and external bus selector
> > > > register.
> > >=20
> > > > +examples:
> > > > +  - |
> > > > +    mdio@204 {
> > > > +        compatible =3D "soce,swip-mdio-23-02";
> > > > +        reg =3D <0x204 0xc>, <0x200 0x4>;
> > >=20
> > > At least in the example, they are not separate?
> >=20
> > Not separate regions but registers...
> > I'm obviously bad at documenting things.
> >=20
> > The current information in the commit message is misleading and
> > irrelevant. Looking at the bot's feedback, it's at the same time not
> > clear enough yet that the mdio controller part is mapped within the
> > switch memory and can't be used separately from it.
> >=20
> > I will update the commit message to something like this:
> > Add a binding for the MDIO controller integrated into SoC-e SWIP
> > Ethernet switch IP cores.
> > The controller shares the memory of the synthesized switch IP core and
> > cannot be used independently.
>=20
> I think part of the issue is the compatible. That suggests it is a
> separate device, with its own driver. But it is actually driven by the
> switch driver.

I can't avoid the compatible right now. Somehow it is still a separate
functionality. I hope the following example doesn't cause unnecessary
confusion, but rather helps to understand the system better:

The relationship between the MDIO controller and the switch core is more
like that of tools in a Swiss Army knife.
There are a few standalone tools, such as the knife and the screwdriver.
These can also be described on their own. But they only make sense when
they are attached to the knife as a whole. As soon as one takes it
apart, the individual tools can no longer be used effectively. At the
same time, no one needs to worry about the screwdriver if they only need
the knife.

I haven't found anything that I could use as a reference for the
documentation, so far. So right now, I can't think of a better solution
than document it as clearly as possible for the next version.
Do you (or anyone else) have any advice on the best way for me to describe
this in the documentation?

>=20
>        Andrew

Thanks,
Vasilij

