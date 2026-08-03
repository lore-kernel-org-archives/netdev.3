Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F232A4137BA;
	Mon,  3 Aug 2026 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770560; cv=none; b=Q6QNdcBYvELHLOAGXrarDDs1w6oWimGGoiDxc0YLjrZhqHYBYbAW3cxWKkcOT45Z03/cOT0DTWFCKlPxioAQntFfyp3l/s9vyd3z1ijfiHir1D1n8QE3WM+lpqaJtaKbo8+EbAD8v/mtf4jAZMqA7R9meKW9/9EwrmlFxaCcyW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770560; c=relaxed/simple;
	bh=HEwByISEMqTHOvuw/TQAwGYn4v3pB0HCjn+7Inh3g7w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ORMhmaZWih+5QxnqDkt/hyDOT7EpIAqOtzkK7xjwJ38CnTG58ETJCD7UmEvq2O9YJlqGBIpWW+XlDdEIYYd1lUgRWNi+ZX27koLTskQKl3dm9Db3iKQHgxs27/qPyG37zT34xqrztrtEcYR4gEiWs4pAWMVfTix8azbLYn6D56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W11XnVUa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+dHQg3FH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W11XnVUa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+dHQg3FH"
Message-ID: <8a5ec5c7d76d634293bd8c78a078d536ed516c08.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785770556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SRWxtpCnTHBGpFZn7YG4kXSV1FW3nCbUeh8LaKke1XM=;
	b=W11XnVUaY42qJ9otmV0Cknxr7COjFuekmtL8BRLHNwynqua6y3yOQYXO3i014Yyxgf1Bi9
	BVgXgpVi+3fyMVns2J2XHxkyai/5K/XnMiVWBA4EirntaVAnW6aXSp+w+GELi2C0tY3weN
	6/ylv30S9KSLR8ip6XOIUv9khIEphqw4gM0rBCwV1TAYmJiBuxe8Ec9XWy/RqgJ3i6dvCg
	fpKODPsbdjTWsJaFaOyDf3uIs8u3bkE2dbLysQ4ba1Kbu1ezrPAl2Ooorl2qtDCZZ2gAD1
	HN0v6wfBbK4EQy/+sEStFKjK0Q/u4krPbrzYsAYpM+vVSSzoMoYxUG5b2pCoOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785770556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SRWxtpCnTHBGpFZn7YG4kXSV1FW3nCbUeh8LaKke1XM=;
	b=+dHQg3FH5nDwDsGzgQXAYpxdUQrCqRVBhFpa+/szGsAJBUD9TBgS25yGXE0yWRIAcHROp5
	nRRAxk+h8CS8Z8DQ==
Subject: Re: [PATCH 0/4] net: dsa: Add SoC-e DSA driver
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
Date: Mon, 03 Aug 2026 17:22:35 +0200
In-Reply-To: <50e4f195-f810-470b-b05a-97f622e6efc4@lunn.ch>
References: 
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	 <50e4f195-f810-470b-b05a-97f622e6efc4@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-29 at 18:56 +0200, Andrew Lunn wrote:
> On Wed, Jul 29, 2026 at 06:36:53PM +0200, Vasilij Strassheim wrote:
> > Add initial support for the DSA driver for SoC-e FPGA-based (IP core)
> > Ethernet switches.
>=20
> Let me start with a dumb question. Is this a true soft core switch,
> which is synthesised and running in the FPGA? Or is it hardware at the
> edge of the FPGA SoC?

I should have made that clearer right away. This is a true soft-core
switch that is synthesized and runs in AMD FPGAs.
I have a version in which both the MAC and the switch are synthesized
in FPGA, and two hardware PHYs are connected to the switch. The switch
provides an MDIO bus for the PHYs.

>=20
> If it is synthesised, do we have to deal with different synthesis
> options? Are there registers which indicate what these options are?

While setting up the switch, users will need to explore various
synthesis options. Once it's up and running, it should be possible to
load a preconfigured bitstream into the FPGA without having to deal with
these options in the DSA driver. The device Tree should then match the
configuration.
However, users are provided with instructions and a user-space
library/software from SoC-e to check and adjust the options if necessary.=
=C2=A0
DSA tagging, for example, is one of the synthesis options. If this option
is not active, the DSA driver will not work.

> Where as if it is fixed hardware in the SoC we don't need to worry so
> much about variations, it is fixed at the SoC level.
>=20
> > There are different variants of the SoC-e switch IP, which can be
> > additionally configured at runtime with proprietary userspace software.
>=20
> What sort of configuration?

Different kinds e.g. general interface configuration, traffic
management, redundancy, ...
Most of them are listed on the product page:
https://soc-e.com/products/10m-100m-1g-managed-redundant-switch-mrs/

DSA integration can stay as lean as possible to support only basic
functionality for different variants and versions of the switch.

>=20
>      Andrew

Thanks,
Vasilij

