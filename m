Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678F3750A9;
	Fri,  7 Aug 2026 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122591; cv=none; b=Hmr1M5vfXHnKYL0iBiVG8tvxpqdszCeldjlyNXFp0Gn1nmRn0BHqjF7LIM1NOqyrGs6O3/YE1AkCIF1GWna/REKDfKzvmEPW3IZ88Fgfy175yop3PEWG+oz4Hg5Se/Q//4hlZxg6soCYwAxpDhQ912rlpQ5dbRgfHokEpAO15uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122591; c=relaxed/simple;
	bh=sFQTra/cCbfPgdpYPr1RgPeCH75wq/wFOhftfVv4W8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TC+2ALsVHoUc9kLkBtGlh7JCwHr8SpoXaqK/hgmwMAA7PPoYjBd/MxGbaDH07CLxrHK18Sv39fVhBPnvIf6q/YbxgWLUo8PggNy4saPtEN6r5CWVrIXFMTp88pDb8Iyi3F/8nZAIjhwAznmRTls+uFgYxCjLBgUrapWZeJ13VwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRtoj7uu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRtoj7uu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFBB1F000E9;
	Fri,  7 Aug 2026 17:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786122590;
	bh=AOOz5/HFZ3VZ2fi1SYICsO8bhZcrCDvCEqCJjAJFYeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XRtoj7uuHaSLSXEJqgt8VHNlrM5S0SQmyfREgWlLAHf24RkgmIn1Ce0NI8+qeLrLi
	 qyXin9BZRHw9nemQIec2X2dkgWKR43My3aud90x1/G2WbGvRhzdb0uOVaRPp1oUt+Z
	 2naFDoAMdOCyKEacBmU9h6oXauTkZNyH+1K6M4XaSN6I8Q36QmIheK80ZMAsM2YGeB
	 WuguCVoV+QDjtV3cIijqkaMy3a2OZBkmgtAWxDCM0aLKF6evuyDURdx2dPlG3xMuWM
	 JF9DojlwnV22j54mxMguKjBib1eVtQhz0bWOL+Ym/wpLxSgC3nNOFh4Yu3E0VhJa0K
	 y9kaLsv+mAEGw==
Date: Fri, 7 Aug 2026 18:09:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, git@amd.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: macb: Rename MACB_CAPS_QBV to
 MACB_CAPS_TC
Message-ID: <20260807-juggle-porcupine-71281d2d9041@spud>
References: <20260807095012.640223-1-vineeth.karumanchi@amd.com>
 <20260807095012.640223-2-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KSnMEygBgPxuMCVt"
Content-Disposition: inline
In-Reply-To: <20260807095012.640223-2-vineeth.karumanchi@amd.com>

--KSnMEygBgPxuMCVt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2026 at 03:20:09PM +0530, Vineeth Karumanchi wrote:
> The MACB_CAPS_QBV capability flag was originally introduced to
> gate TAPRIO/QBV support. However, GEM IP versions that support
> QBV also implement multiple TSN clauses.
>=20
> Replace this with a generic capability flag that can be reused
> by other TSN features. Rename MACB_CAPS_QBV to MACB_CAPS_TC to
> better reflect its role as a general traffic-class offload capability.

I'm not convinced that this is broadly correct, whether or not there's
Qav support (which is what you're using the newly renamed flag for)
depends on an IP configuration time define that I think is independent
of whether or not there's Qbv support (gem_exclude_cbs).

That said, the only platform that supports Qbv that I have the exact
documentation for does not disable the CBS bits.

Cheers,
Conor.

>=20
> The supported TSN clauses are handled through macb_setup_tc().
>=20
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      | 2 +-
>  drivers/net/ethernet/cadence/macb_main.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/c=
adence/macb.h
> index a11052565436..f24df25923d7 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -768,7 +768,7 @@
>  #define MACB_CAPS_MIIONRGMII			BIT(9)
>  #define MACB_CAPS_NEED_TSUCLK			BIT(10)
>  #define MACB_CAPS_QUEUE_DISABLE			BIT(11)
> -#define MACB_CAPS_QBV				BIT(12)
> +#define MACB_CAPS_TC				BIT(12)
>  #define MACB_CAPS_PCS				BIT(13)
>  #define MACB_CAPS_HIGH_SPEED			BIT(14)
>  #define MACB_CAPS_CLK_HW_CHG			BIT(15)
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index d394f1f43b68..29c93df1444c 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4846,8 +4846,8 @@ static int macb_init_dflt(struct platform_device *p=
dev)
>  		dev->hw_features |=3D NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
>  	if (bp->caps & MACB_CAPS_SG_DISABLED)
>  		dev->hw_features &=3D ~NETIF_F_SG;
> -	/* Enable HW_TC if hardware supports QBV */
> -	if (bp->caps & MACB_CAPS_QBV)
> +	/* Enable TC offload for TSN-capable hardware */
> +	if (bp->caps & MACB_CAPS_TC)
>  		dev->hw_features |=3D NETIF_F_HW_TC;
> =20
>  	dev->features =3D dev->hw_features;
> @@ -5678,7 +5678,7 @@ static const struct macb_config versal_config =3D {
>  	.caps =3D MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
>  		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
>  		MACB_CAPS_NEED_TSUCLK | MACB_CAPS_QUEUE_DISABLE |
> -		MACB_CAPS_QBV |
> +		MACB_CAPS_TC |
>  		MACB_CAPS_USRIO_HAS_MII,
>  	.dma_burst_length =3D 16,
>  	.init =3D init_reset_optional,
> --=20
> 2.44.4
>=20

--KSnMEygBgPxuMCVt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCanYRWQAKCRB4tDGHoIJi
0lepAQCL8DJHbLzfc/ciV6fdlv2aZwWZf7Qc5VROrZakl7wTrAEA9PoiQ0av6S6Z
dv6HdKeMfehglF89aDyPFj2QrXbfAA4=
=sVqu
-----END PGP SIGNATURE-----

--KSnMEygBgPxuMCVt--
