Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AFB3033E6;
	Mon,  3 Aug 2026 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772070; cv=none; b=FwpHfOMgJCj0Zqjf6s3dz5pPZQg8cCkARb3FxNUTNAL9NtN5XGY688p+MJ30Qh30p8zYBxhWvM/ltmf0yTce8y+1RjTcQk5mEOBWVDSZ2EHqNWJ7kYMehej0Z4QmtZuiNszO7Lcdnc4U1KX7nXRuSt0oxwalBTUh4jKqRwfQsZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772070; c=relaxed/simple;
	bh=Doe8eb8iT9MnXvbYNK2AUQO7IdDuVizBdxLPRUvh5uI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=spSnNJ72HQUIzzYYlOoFHhkdDg7pXrlUdlYc/IINecvixktgFeLphZzXWH6LgRCWqSiJgd/TbXJl9IiSZWYv/G2q/HltLnjvzZSZTzMBVBL/a5nKyv9TbmJCt78bEhK0j11DMnx2vOPXR01Dp9W/DsYjDwhhHcefoMeofLk/0aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vqW0cCMy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qx4JSaZl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vqW0cCMy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qx4JSaZl"
Message-ID: <425ab2f6e53057aba88b3e45b9e5dd17299772e3.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785772067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpYZfWgVcqEboE0dDBcxzCk51zyXqeNQdivsXNYg39o=;
	b=vqW0cCMyG37S3G81VfmJ9swcXyXw10qArKFpe1/Bg6X41BMwJdUdb0mBBg8e0dG5OBBRX5
	yomxqsfLhQjtcoAYOc8hDc+BgVQFRsqNsxi2Y2nh00D/bVrB7vuc+XkEv9PD3DVWi0jXzz
	jcZI4gXFxSfTsXi+TvjZRltJjmj13ySMH3Mk45N7DATwGndfYmmAZcHVNOWcOKVXxnezcR
	udBh7C5jMV8oFRVbi+GdPkaozvihllBVivBedW7oqPtyEqwnezCjjYbkO5RMjVKMwGI0pu
	p+JZ+WIe4gtBDzld2JblNT3PtpbzTO/MpYSxGHUYqiWx3XQkj+qKNshN2u/T+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785772067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpYZfWgVcqEboE0dDBcxzCk51zyXqeNQdivsXNYg39o=;
	b=Qx4JSaZlfX1KmFxD4MPyE4ZyS+DZjwCGA1HH3d7vMIlKqrh5Wy5PpD0iP+ZFESxBArzq5V
	Ysl5SFM7/7pOFwDg==
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean
 <olteanv@gmail.com>, Simon Horman <horms@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Martin Kaistra <martin.kaistra@linutronix.de>, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 devicetree@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Date: Mon, 03 Aug 2026 17:47:46 +0200
In-Reply-To: <178534841981.3259959.17483842007790222848.robh@kernel.org>
References: 
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
	 <178534841981.3259959.17483842007790222848.robh@kernel.org>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-29 at 13:07 -0500, Rob Herring (Arm) wrote:
> On Wed, 29 Jul 2026 18:36:55 +0200, Vasilij Strassheim wrote:
> > Add DT schema documentation for SoC-e FPGA switch devices.
> > The binding is split into:
> >  - a switch IP node describing the MMIO register block
> >  - a DSA MDIO node describing the DSA-facing switch instance
> > Both nodes are linked through the soce,switch-ip phandle.
> >=20
> > Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> > ---
> >  .../bindings/net/dsa/soce,switch-dsa.yaml          | 195 +++++++++++++=
++++++++
> >  .../bindings/net/dsa/soce,switch-ip.yaml           |  54 ++++++
> >  2 files changed, 249 insertions(+)
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/net/dsa/soce,switch-ip.example.dtb: swi=
tch@80020000 (soce,mrs-24-01): reg: [[0, 2147614720], [0, 65536]] is too lo=
ng
> 	from schema $id: http://devicetree.org/schemas/net/dsa/soce,switch-ip.ya=
ml
>=20
> doc reference errors (make refcheckdocs):
>=20
> See https://patchwork.kernel.org/project/devicetree/patch/20260729-devel-=
vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de
>=20
I can reproduce that and will fix it. I have to make a lot changes there
before re-submitting.

> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.

Got ot, I'll rebase the next version to net-next and add the information in
this patch.

>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>=20

Thanks for the tips! I will clean up and test it.

Vasilij

