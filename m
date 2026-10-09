Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5664908CC;
	Fri,  9 Oct 2026 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571649; cv=none; b=eoYowprYecaw9S5Jcdh5HA70z9MLwsxJAOEZ7dx31OqbjCyivwWfAIqpyPRN5XuaOBJGM2j+xLK+STKdWGDL5Eov1JtqZuBc+kYXccOOwwcugi6NrK5iJzk/74R0nBORzq6+Hnj/ChwREHjjLtZcVRoLgISxGuH7M13ZQ62+Gtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571649; c=relaxed/simple;
	bh=7gsstcGebkrFnRGJfHoy1nKjwilwwVe6fqAqlAfhguo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Apr0anrLvHNG7yTmpd1loETSrfW0WVw1qldn4UgpF/4nLNP/PIbU2LgMpqTibQR/G9EPS7uhKaEiA4zYPT3rc9pnSw/pIt1VwrSUg4209cw1XAasINK6hklzinqSTkf3Ql+iVnzdEqa8XSkmKl7sbQZPsBPooXeMy408OCQJM+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJGG8+jM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJGG8+jM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A011F00893;
	Fri,  9 Oct 2026 18:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791571647;
	bh=rAafs66KHX8PRoS6JPzArnn8IPQpvL2vwnaQb9KQ/+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cJGG8+jMue9DOYj+2oTuBgmXChx739KvKh+t0PiAgkfDYw93jkybAnhedEDPTxWs1
	 qcibjrArpH9Hj30U7VbrL+fpQwcJxny8N4sEQUEH0tbrAi+7DK2K32p+Tx1vCE0Q1y
	 HwSgAul22BVTWO8w7VQdKqaK2syPIvhCGbI05c4ssN59z9+KVxIhMoH1lUYto8cGId
	 nGmVEAPETqvUIkGkWng0OLe550Ee/MlWSI811qFYOcxK9sJP4/t2cWdLO7YmPCCiJj
	 OA88VfYZPCtz571AeKd7+MmgFvPM9pC+f3FB2ebepGR+33Wxvj+KnRdLr7r5BciHZ9
	 oSMPOoJ8hxD5w==
Date: Fri, 9 Oct 2026 19:47:19 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: ethernet-controller: Allow
 "ethernet-N" node names
Message-ID: <20261009-47ea4cd79736efa16f71334d@squawk>
References: <20261009155444.2347045-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QLBnMuTVxTOt0++J"
Content-Disposition: inline
In-Reply-To: <20261009155444.2347045-2-robh@kernel.org>

--QLBnMuTVxTOt0++J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2026 at 10:54:45AM -0500, Rob Herring (Arm) wrote:
> The HiSilicon hisilicon,hns-nic-v2 binding uses "ethernet-N" node names
> as there is no "reg" property and multiple instances. Add support for
> this pattern which is a common pattern on other node names.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.ya=
ml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index 1bafd687dcb1..30b2a335116e 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -11,7 +11,7 @@ maintainers:
> =20
>  properties:
>    $nodename:
> -    pattern: "^ethernet(@.*)?$"
> +    pattern: "^ethernet(@.+|-[0-9]+)?$"
> =20
>    label:
>      description: Human readable label on a port of a box.
> --=20
> 2.53.0
>=20

--QLBnMuTVxTOt0++J
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCask2twAKCRB4tDGHoIJi
0koJAQD24O3rIDxVLiZUhzE7vpEwc0brjbR3F0gAkReUZlVDogEA4lwPae/YGt1K
MqNuNrzbdq7/xX2Ddz/Xm+4mV+k3rQs=
=DqsR
-----END PGP SIGNATURE-----

--QLBnMuTVxTOt0++J--
