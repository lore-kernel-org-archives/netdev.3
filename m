Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616882E7391;
	Wed, 26 Aug 2026 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760092; cv=none; b=IloZt1KuWyr/FyFuNWiBP8bLWZuwHNma26rRy1uZFCxFQDPTgjkgbghavlr4GIg7xd/SwoEaQJvrCJf0AQLwfPlKaW4O1Rb6bvCpfcy3TUFSN3AGNHBNmCYdtQVC0f09P9ua3JbjgEnzpW8dy0k9xYPRPz17VC6kGINOv2tKdCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760092; c=relaxed/simple;
	bh=lVHf+Gvn3rmZVmMJJ4PkKLNngXr6ygOAY1JW9Mjty8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIepC72MQB6n12AVxRJTXsMaQs6FYjhn2qP616mJsXoy8lCX9BCevNE3lXvM5iym2QzHnPWYHzCC3lpITinI6ef82ktFmoD5DRTc4iMuox/8j4gWkHTqVYg9Oe1BSvEHJMpk8jV/rV/vt8P0ZxmDjc0PLuy3/mVueQegPbDaIg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wx/C6OJ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wx/C6OJ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4391F000E9;
	Wed, 26 Aug 2026 16:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787760091;
	bh=HKu0+MQ/CsGRSjRAPzNW/D1HhsHLTAjhUx06OW9NRSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wx/C6OJ4nVwBR1WYCJ/p1IXmhwG8Bef1giEp7MP1cAEjvcuen/1/9Zw1IvjBCVnyd
	 325dmg92bAt6AQAurk2kbKIgKgoISNqOm8isIRx25d7jrelMaXazQICHx2XNTJ5nw4
	 GSUHw39VqTbABkYl3A7ZkytBgZKK0ktLfhOhA3SQqQDDBEIz38/ZkqjfbH3FOEebub
	 Z86E/oyPWVw7Z6T8NrsFabQusjVyv1UqHfOCDtjHzBZC2ps1ysoJqX+rO6ojmoCj6A
	 zlmpqoYI1PCpKoDyVvQvsUhx381Q6bFtkypAC06u7WalRTwTSn0HfwbYnAtsEUq0qf
	 7JyIgBJpYtVsA==
Date: Wed, 26 Aug 2026 17:01:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: dp83867: add binding for
 output-impedance
Message-ID: <20260826-salutary-skype-524c69932dc2@spud>
References: <20260826-v7-2-topic-dp83867-v2-0-a97b4cec6e93@pengutronix.de>
 <20260826-v7-2-topic-dp83867-v2-2-a97b4cec6e93@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5aasveUrcJSeX1iD"
Content-Disposition: inline
In-Reply-To: <20260826-v7-2-topic-dp83867-v2-2-a97b4cec6e93@pengutronix.de>

--5aasveUrcJSeX1iD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 02:48:40PM +0200, Steffen Trumtrar wrote:
> Currently, the output-impedance can only be set to default, minimum or
> maximum or via a nvmem cell.
> In cases where there is no backend for a nvmem cell, a value can not be
> set.
>=20
> Add a DT binding, 'ti,output-impedance-ohms', for specifying the
> output-impedance via a fixed value. The existing boolean values for
> minimum and maximum still take precedence over the new value.
>=20
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/ti,dp83867.yaml | 16 +++++++++++++=
+++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.yaml b/Docu=
mentation/devicetree/bindings/net/ti,dp83867.yaml
> index 7a6fe516bab27..49fafe3ce6f47 100644
> --- a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> @@ -38,6 +38,16 @@ properties:
>      items:
>        - const: io_impedance_ctrl
> =20
> +  ti,output-impedance-ohms:
> +    description: |
> +      MAC Interface Impedance control to set the programmable output imp=
edance.
> +      Valid range is 0x00 to 0x1f (32 steps).
> +      - 0x1f =3D 35 ohms (minimum impedance)
> +      - 0x00 =3D 70 ohms (maximum impedance)
> +      - Step size varies with process.
> +    minimum: 0
> +    maximum: 31

Your property is named in ohms, but not implemented in ohms.
pw-bot: changes-requested

Can't you just achieve the same result using the existing max property?
I don't get the use case where you specify a max, but then don't want to
use that max. Just set the max to what you actually want?

Thanks,
Conor.

> +
>    ti,min-output-impedance:
>      type: boolean
>      description: |
> @@ -121,6 +131,12 @@ allOf:
>        required: [nvmem-cells, "ti,min-output-impedance"]
>    - not:
>        required: [nvmem-cells, "ti,max-output-impedance"]
> +  - not:
> +      required: [nvmem-cells, "ti,output-impedance-ohms"]
> +  - not:
> +      required: ["ti,output-impedance-ohms", "ti,min-output-impedance"]
> +  - not:
> +      required: ["ti,output-impedance-ohms", "ti,max-output-impedance"]
> =20
>  required:
>    - reg
>=20
> --=20
> 2.54.0
>=20

--5aasveUrcJSeX1iD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCao8N1QAKCRB4tDGHoIJi
0kq4APoCzvw4l7ecgIaAmNRRokOfSS6ygTNzDBI5uUoRR4uWCQD/ZuaNbazbM0QU
fkxAkzNcXif3RRAYNi5zb5r3vMDb3A8=
=rFze
-----END PGP SIGNATURE-----

--5aasveUrcJSeX1iD--
