Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EFB42589D;
	Tue,  8 Sep 2026 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855928; cv=none; b=Vb2uwm/vwxXnCVfh2r2WRs3fI4JZyXLJDA1/jTzeXXEEWww1aplnmHSWHqCBRMVeRL6JxjGLXKABqXZgi4KqYd28UfdRJtoX74730GUdVK1AX+VGRW9IyYpot7SqBOzEQHiheKbx+9XyMXtbg9tA/CJUAGpyaxgOK83H1Wr87hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855928; c=relaxed/simple;
	bh=P+yhYIZi4xMF5qmM81V+uLOr+7qdxXkcnjxr0ACEknI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hLnuObOXi1XRj/7G4+GSm+Tvg+j47/vjUE5WhcwYJp2/wAEqf4bWXR4I0yFtf3OrgGqTmjVwlTerqrMQyYSbCopzB8KqHITPV7QIW+jF6M4hhYIiev3B75WMFiMHlshQPUTp/wZTR5Qo8+6JWYk3tezsqIkvIt1+oOHXV9UA2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UH/Xlal0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xVFxmMcx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UH/Xlal0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xVFxmMcx"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788855917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obyn9B+WHvsBPD5qGfnZHr72VXetk3OXFfz903w099c=;
	b=UH/Xlal08lVcP4t0U48SAylZSbQjA4YGGni6A56R1oXi9dlB24AoUT9n0yuLdaV9Pg4GwA
	rJ4kR1e3HfYwPlfJ00mWZkJalREYqy0Idki7aqZ45xjGi6hs5G6k9MksnxEO4NOoz6ZJBm
	eKRxX1e+xvnF/FUaYPTNIrdGd4paUiMxQ/g1zTsTlJYvCpHLvtsJM7J/bldvVjzClU2kwE
	Iq95oKDdmIfKCJ7tbMOQz4gc6vBEIHkAk8E4ftjfh7dLRFyh+SL9wLAfgQe+PmigU9yjRw
	lnjOFmssbp2A4xeLujsHEEiAcewsPTZMGjuvRexZUw/EcRF0msrs2W0Ls9s+dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788855917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obyn9B+WHvsBPD5qGfnZHr72VXetk3OXFfz903w099c=;
	b=xVFxmMcxnZQgXIdbpHnUpwpcbvTbSag47f4NuANx3BMPYExHYZ/eUVEyo0YCwbsZhch5MC
	YUAt66CXBpPyjBAA==
To: Vasilij Strassheim <v.strassheim@linutronix.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>,
 Benedikt Spranger <b.spranger@linutronix.de>, Vasilij Strassheim
 <v.strassheim@linutronix.de>
Subject: Re: [PATCH net-next v2 4/4] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
In-Reply-To: <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
Date: Tue, 08 Sep 2026 10:25:15 +0200
Message-ID: <877bkwgnf8.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Thu Sep 03 2026, Vasilij Strassheim wrote:
> +static const struct of_device_id soce_of_match[] = {
> +	{ .compatible = "soce,swip-00-04-0c-10",
> +	  .data = &soce_probe_desc_swip_00_04_0c_10 },
> +	{ /* sentinel */ },
> +};

In case you repost, remove the comma ;-). See

 https://lore.kernel.org/netdev/20260904043724.2955444-1-s-vadapalli@ti.com/

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmqfxmsTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgtHWD/0alMenNi3k3jvtTkUGLPR/gN9FrAud
X74HMLt7k3MvtdZNE8UTy7kBlGBX2Pw4DOypMcy70v+A8K1EViEn1uPEkjLymKXk
Yk6IJ2MFmH4XoohmoYbcU7xNvzkbIjzBOWxg6hfrZkEnoU5139m/lqt9gxsBiOme
mJjE86njuVDbruJvWHZ/BcWAi7wD/ceuuYkcXqL4s7o0k8oN6c8EQrXs2QRVKBUV
5Iv14yW3GgRl7b2ktN60ZMjugGEgVXB8xLe7yV82DNByZ/d0ykeRR0c23mKQff+G
2HuL6df3Iy27+tt2pLi6OeI0P6S+MNVT7VPX1DReS4/oM09WlMtd1J5zDcfJ6TkL
j5czEIozdGk7fEy3NgFJdBQY0jQ7VBbhRnybrGnfm4BxobKQMGOkx5mXCpDfbuMs
PD42Qqcdfco3fDsyNae3EGcPHAOpP43n601BeVG/hnH6IgE+DiJFCdJKAeCVVMPn
Gfq5Gt3WFzatDxf9us8d89fZMPEZD5vnIdI2TKe1StiQIMmn/PGfh+mX5USgGXmt
hhdQvT9RooNHW2g0mihAwXSFRIpIudHqETTDA0aLJH9ouE2bBikrprouH3AooQAT
Za9s3cWv7Ew/gUg0NfLkP4e60mEe7d7idc7D7pLB7ypXmPdKCDGSh1fT+KKe8eny
h6jetx49W0fhJQ==
=g4BB
-----END PGP SIGNATURE-----
--=-=-=--
