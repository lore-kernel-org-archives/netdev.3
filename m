Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7864E66B8;
	Tue,  8 Sep 2026 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862347; cv=none; b=GA58WnfUdN3Kevl/nPqzp7AOSo4ZR4KM1wgEhPFN9XU2i6jYKLqoPrvPLPqokq5VQtTgnlYB3+L4Oh4k0E1A4CwMKJOwiBdZpH1TWK2y7dH2icAN9pnWTw1UFM6vryFPd9WY3B3ZTyENWcYSjWOYkdlVrk0NKjXJoUw90pk84xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862347; c=relaxed/simple;
	bh=WzF1YvDo3Mkrmc4pctFzdUwSCXIpGrI+QFPNGuZ75iQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qTlqC5ely8DtP+qu4AY6E4H5sSrlw+irlOTcYKC9kurSnkp/CkrJtoDHND2PiPHAcnYcY+1ojc6WPQIdmnnxbZTbwv9vFWO8YdxP73vxboPodMIT+pGonB3c7r3Wucc3dnDTseiQA4iYR5+HES6WHd01/muFgU5gnDINZW7muSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KpVvYIR5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4QrkXGvg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KpVvYIR5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4QrkXGvg"
Message-ID: <80af9ae1997476e3e0eee9259c4d6e27ea6e68c7.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788862342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAk5fLNP5hHOqK/hIBLAS4rdVMVFROcB3jV6ruzzn1A=;
	b=KpVvYIR5H7xa4jmYP66fWWjVEeIfB8qXvMrHb7qPBgmmUSMwkG8VUOCSJKp/CRu4Iviu/o
	9aPRJwahX3H7IyR19KS/rcmSXcTvC96q3970GlUXEOGPxEBhrYLJyRZ8CNuYOhHwYC/t8Z
	ZQKbVIrxAG6hZjzovtlEZQuSMhITJf0cL3jn31aLq6QW0FIZtu4byCmt8PDTlE3qnpiCjK
	6PfXrQKjP8roDeqDNbYudtiml2H2MScXT8p+KHW3xm40LNa/uaSCBFAckPMEtTbYKbaW22
	j6Jl4B9HngAMDUbP5vS8phHthLu6RG5y1SGA8FBAa9joMACOr2hO2kQJ7RUJpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788862342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAk5fLNP5hHOqK/hIBLAS4rdVMVFROcB3jV6ruzzn1A=;
	b=4QrkXGvg/qGDeUk0MwunjPyL8pMuxP0lHzgefaejvBRWX2EhJwFKO/1GpGK3PDsfIiXxS6
	IIKqqyhArOYXjuBQ==
Subject: Re: [PATCH net-next v2 4/4] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn
	 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
	Benedikt Spranger <b.spranger@linutronix.de>
Date: Tue, 08 Sep 2026 12:12:21 +0200
In-Reply-To: <877bkwgnf8.fsf@jax.kurt.home>
References: 
	<20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
	 <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
	 <877bkwgnf8.fsf@jax.kurt.home>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-08 at 10:25 +0200, Kurt Kanzenbach wrote:
> On Thu Sep 03 2026, Vasilij Strassheim wrote:
> > +static const struct of_device_id soce_of_match[] =3D {
> > +	{ .compatible =3D "soce,swip-00-04-0c-10",
> > +	  .data =3D &soce_probe_desc_swip_00_04_0c_10 },
> > +	{ /* sentinel */ },
> > +};
>=20
> In case you repost, remove the comma ;-). See
>=20
>  https://lore.kernel.org/netdev/20260904043724.2955444-1-s-vadapalli@ti.c=
om/
>=20

I'll do that.
Thanks for pointing that out, I would have probably missed it.

Cheers,
Vasilij


