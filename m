Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB334A78E;
	Mon,  3 Aug 2026 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773823; cv=none; b=WWhd8Esl21bUgVp8ikWB8cR9P1l1T06mqw6cgekpszTIFGV7bxIi8X5r5TJvSKjc9vBEVvdOR/L4XGiY/7GDG7O0cWntkR5Lz4JM1a4UdxZWO60kvyKHR/wCj40Lj0Rs9rU8GfkwWP8MFo2OPgaDaKCbPVZgPN3HLzXU3iqMSZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773823; c=relaxed/simple;
	bh=aSLmt+PR3+Osn8wgid3oVqYxSJu2yj6JoNUkxPECYhY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IdGX5s3LdphfQrrGK4yA4LNbBxNGK5siRJMygIAlseBIS9H5JCb8YANhS6htEFL7IcXTD2nkhoeY/0RD3s+ncg6LnlP9NPwSKmYRXodP7oWDjWFZZ4lm/DVHNapOuiyZWP3KPPQc4CNISlTjrtUoAhhJg4pu6+jxOKb0SIWZktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mepk03sS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jcve4gue; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mepk03sS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jcve4gue"
Message-ID: <ee90e6477075541e2e8f20ba69532c38146cc0b7.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785773819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8M3rDvmC95591Shteu27p4HREejvHEeIU4YwNmcwB/0=;
	b=Mepk03sSNdRo3Z1jcbONSDu9OZTeCpcfMcPNwhzcGp0jIH8g6LedjLq6QeYTBrcRhqYKcj
	j/81MoULEaqC9a7mI2qD/IIWS3sksi5L+gyOcVL28nc2jgFqe5DYsuygeNg6gL4yw2U6hm
	PVPf6SAC+30VOKS+6pt5jUDHIMUyK2pXmAAeYadTANh7Mev12ehoLBIIeT7oG3Str7HLoQ
	XRKHU1XVieX+MzOQRTLuXsYsyW5vFyBLlxRRLoudMhMmVAEdjglw6OvAde54GWu43lIVCL
	ptZeFN2/2L+69G/OIe0JC877AflMZk0eqxrN9YJC3hdokls6Op6e6mvdtxJ8cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785773819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8M3rDvmC95591Shteu27p4HREejvHEeIU4YwNmcwB/0=;
	b=jcve4gueRyQmWmXtRk5UzQ+6V9ZUauX3ng9zKcnuW6A+NWArPPnLKdE03XN07B1tTXBNG2
	xvbEWpzO+QEJBYAw==
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>
Date: Mon, 03 Aug 2026 18:16:59 +0200
In-Reply-To: <20260730-positive-vagabond-coot-f9d8f7@quoll>
References: 
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
	 <20260730-positive-vagabond-coot-f9d8f7@quoll>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-30 at 10:56 +0200, Krzysztof Kozlowski wrote:
> On Wed, Jul 29, 2026 at 06:36:55PM +0200, Vasilij Strassheim wrote:
> > Add DT schema documentation for SoC-e FPGA switch devices.
> > The binding is split into:
> >  - a switch IP node describing the MMIO register block
> >  - a DSA MDIO node describing the DSA-facing switch instance
> > Both nodes are linked through the soce,switch-ip phandle.
>=20
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree=
/bindings/submitting-patches.rst#L23
>=20
I will fix that.

> Best regards,
> Krzysztof
>=20

Thanks,
Vasilij
