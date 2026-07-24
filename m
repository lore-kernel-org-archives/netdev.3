Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75CB6BB5B;
	Fri, 24 Jul 2026 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911595; cv=none; b=nWy4RwElSwT67DTcHb6R9a2ClmXljaBbKIPDRlxIpDGYmSQQ0UJD1cNcMcllYJ8uTgjYkh4cvPE++Uxpf0/NrqMyXOPlvGUJfTYxOklQqbx7W8kw4ek6s0B5SqFwe9SfCYQ9FzleG+mMeDP5C/6y8bhSnGLls1w/6JJOrEhHfNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911595; c=relaxed/simple;
	bh=BfHOLuCcxekGxLh7PKFijYXSHsRTznbMzmHB+ggbcxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGAMTV2vmUClSt9LCfTBIic85/dEsw4sDNej6RvZF4GSYyIC9VFBUZsxQr1rT56XdwpnZ1g7Atq81T6NroZlzxRdCrcbdfp4wOWNh5tvnyZ8FzdFTmoVriGF/t/jX0I0H8QHCDKxEBI0rpxnJKcuqBh/+cqB5DTnmAWwHdLAs9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4INEk9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4INEk9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE241F000E9;
	Fri, 24 Jul 2026 16:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784911594;
	bh=j/CCzSHtYumyFcj8LN2KX2hcSNpm3ATQp9Nbq1J3VPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k4INEk9cAkJofXWYbjyuHijGQ2Wks6/4KK6OIBninzhNI4zIrCTjDh/DSNRlIY5hb
	 LmIOtoFM1YRnSfN7EgUoORDpBxx6G7VDQSMamwYpcYYix/iUZLktP7hbmO0zNmLUmW
	 2y78hw5QT8a0VB78TcfGM6uaC1ozePuYMPWH2M0ETty3pVXU1Q3doyMIZHPgutnCnV
	 f89tf8eYvrXaR7TBqw6kHts92aa0oJoHqLFMAr9DiPJGPwJ+PFzLJNC/xpQjkEX+Bt
	 0aM+3iGy9EcLeo1iN9+ZFUPCFKjq5gYcathjqKP9cg6P8xG1yfEJWGMEqQJSvOyZNh
	 ycHDVe6jr2mKQ==
Date: Fri, 24 Jul 2026 17:46:29 +0100
From: Conor Dooley <conor@kernel.org>
To: vjardin@free.fr
Cc: Ivan Vecera <ivecera@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dpll: zl3073x: add ZL30643 compatible
Message-ID: <20260724-gloater-palpable-89703c14e394@spud>
References: <20260724-for-upstream-zl30643-v1-0-ea93ba4d85c8@free.fr>
 <20260724-for-upstream-zl30643-v1-1-ea93ba4d85c8@free.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I7Gc7VPNPQPd6uOV"
Content-Disposition: inline
In-Reply-To: <20260724-for-upstream-zl30643-v1-1-ea93ba4d85c8@free.fr>

--I7Gc7VPNPQPd6uOV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 01:09:12AM +0200, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
>=20
> The Microchip ZL30643 (chip ID 0x0E3B) is a 3 DPLL channel member
> of the ZL3073x family. Add its compatible string to the binding enum.
>=20
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

What about this device makes it incomaptible with existing ones?

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yam=
l b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
> index fa5a8f8e390c..13ea55c2c146 100644
> --- a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
> +++ b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
> @@ -18,6 +18,7 @@ description:
>  properties:
>    compatible:
>      enum:
> +      - microchip,zl30643
>        - microchip,zl30731
>        - microchip,zl30732
>        - microchip,zl30733
>=20
> --=20
> 2.43.0
>=20
>=20

--I7Gc7VPNPQPd6uOV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamOW4gAKCRB4tDGHoIJi
0pI1AQCTItjWH90t6ZeuThBADNdxZVWTwaKv9JD2pQSH5/97KQD8CxvwSwe6db4t
5IqREuyQ6cV81POEJqCslLbUwMxH/gY=
=qp9N
-----END PGP SIGNATURE-----

--I7Gc7VPNPQPd6uOV--
