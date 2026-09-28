Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF304E80B0;
	Mon, 28 Sep 2026 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612764; cv=none; b=M06N89Sd4MredVN7voQx2Tbg73jy9H4ecdldE0Ej6sC7jzSFwfmfUzgd1cRWCmYL0g7PwVuN0DFO3buqgy8BDf35/DE9eqeppe6pZqBxMtbCIv8g4DUKQDIqQIb4ug7rsADRD64Ql+bv3y8mifG9rsOr6+l90bYESAVKhLCvlSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612764; c=relaxed/simple;
	bh=gftMSJStStEbSiqAx3a0pQjJjaObsOdcXrbIe8kxYHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvrfCjGRWcW1gaQQPemVIfSOXemQWvWW4InKB2aNiOFkIA4DRmbBWoumuYdnwFmhJKK7tgBnJv7ngY1y2c+UvNYErsQrvGs8cPAFnRiW7wFCn0mzO1wNz5XMCPslc0/KBC9ZCfaOb2jAOOn7bKvhEFat1A+YxDZhSzL+PEIBC5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+0w8QQQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+0w8QQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977001F000FF;
	Mon, 28 Sep 2026 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790612762;
	bh=AOKLLoiXDP0CUWxxyHR5QJoVnL3ixgF7oJYmUWLLpTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i+0w8QQQFyifkKLRJMTCSklFa/awqHYlaOpWRpMil+LIbfUTe3egglvBJVWOYFhYv
	 QSdfbDW60fHe4V2/HpKtIodcrFDVX+43Y1S2E5/gKkT9t8rMh1wYJ49mj8fFzgcHvP
	 xKAQ3hlwsJ3DOD7xk/vGCYNcuxAmdJ7eBQnixi+9BQHzp1NMTztOZW57NXngwmUZPs
	 OvuRzXMxkyfJ/0RrAFcVuAN80DYdmyFt+cBCGLH5I2H7+o6hoTXE0ZE2Z9qhT+R6ZZ
	 0rB4kSU7afa8yJNRAqsH+X0Zs0I+dXHRnAbnPRmVOxAKbutII2ytqZH6UTnSt3K8lI
	 NKeFOT7FZ/Tyg==
Date: Mon, 28 Sep 2026 17:25:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com, jie.han@motor-comm.com
Subject: Re: [PATCH net-next v21 1/3] dt-bindings: net: Document Motorcomm
 YT8824 PHY package
Message-ID: <20260928-valium-gents-cbf9a4fdbdcc@spud>
References: <20260924075048.4060414-1-kyle.switch@motor-comm.com>
 <20260924075048.4060414-2-kyle.switch@motor-comm.com>
 <20260924-vowed-roulette-abda42cec444@spud>
 <24cdb178-7a94-487b-9f8a-42ba984e10bb@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ycZp7CDd8UoLXV3v"
Content-Disposition: inline
In-Reply-To: <24cdb178-7a94-487b-9f8a-42ba984e10bb@motor-comm.com>

--ycZp7CDd8UoLXV3v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 09:43:48AM +0800, Kyle Switch wrote:

> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    mdio {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +
> > > +        ethernet-phy-package@9 {
> > > +            #address-cells =3D <1>;
> > > +            #size-cells =3D <0>;
> > > +            compatible =3D "motorcomm,yt8824-package";
> > > +            reg =3D <9>;
> > > +
> > > +            phy-mode =3D "internal";
> > > +
> > > +            ethernet-phy@4 {
> > > +                reg =3D <4>;
> > > +            };
> > > +
> > > +            ethernet-phy@5 {
> > > +                reg =3D <5>;
> > > +            };
> > > +
> > > +            ethernet-phy@6 {
> > > +                reg =3D <6>;
> > > +            };
> > > +
> > > +            ethernet-phy@7 {
> > > +                reg =3D <7>;
> > > +            };
> > Unless the addresses and numbers of phys are entirely unconstrained, I
> > think you should add some pattern properties for them.
>=20
> Ans: I'm somewhat confused on this point. What might the pattern properti=
es

There's no need for this "ans" business, the quoting makes it clear
already.

> =A0=A0=A0 =A0=A0=A0 you mentioned include? Could you provide more detail?=
 thank you.

On second thoughts, there's some basic constraints already provided by
ethernet-phy-package for this. Probably don't need to anyhting specific.


--ycZp7CDd8UoLXV3v
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarqVEQAKCRB4tDGHoIJi
0o0uAQCip9r/9vuf0uWEZLjAezGm5/Azs2SRIZhg3WWlYW/vKAD/d+zxDevW15bh
RnDrIF906WcsrCLtGC6+0TWQ35V/4g8=
=MUnS
-----END PGP SIGNATURE-----

--ycZp7CDd8UoLXV3v--
