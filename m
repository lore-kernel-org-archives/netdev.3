Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6B7459AD7;
	Tue,  1 Sep 2026 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247401; cv=none; b=VDg8Awpf1eEAII7lycnJJ778P99FTXjeuHR0EXncVNDdad/fWgkni2QMQx8bHFO/qkLcnfcaK61z020skKuixxHS+gNEBPuxAAjytBRDurcpwhlgFbI/2RzLK1rNWb14iErOJUrUxx7ZFO1otTu6x0upkQaOO2twCnY7w4oQLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247401; c=relaxed/simple;
	bh=gTgX58qAN6qPdqTkSvME9HJO52ewwtzUWAj44mkJg2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyTIY/faIeREn/idHpaU4rXS4BfhG5dxtPhv7GOVUJn3l/1AQIvfr/FWCabWtXxKbvkkHVFt6hOfLxG/cr3thDNnM+r1cIvXvTruE5D5GvQtqUsm57Y99s9D/kxJQ48Zr23pP1AxWblDmgBZEiazTYlIdKRXTyyXZtaHmhJdv0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Utv80bzu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Utv80bzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA791F000E9;
	Tue,  1 Sep 2026 07:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788247394;
	bh=qCWCwhm5CYxFm5odxTdtkxLiQAyCBWHpnskP5L4+v2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Utv80bzuMK0AJAjsG5eYLCc1gVmsJqVyUsZ3lAcLPta8DxQxhLUh1JQ50ZWyG7Oqd
	 elS3XtUkgbqz9vLtwUdgssbvf35teoGgTuBFPPPLs1LDAicf6rErM64xfs/+0vn+1e
	 0tbUiaaen9FvDZkzN6QcSs6jcVhnQ46S1Zu4icdMzTIFttRkhbtXOGV8IejiVK7pdM
	 6bXTiSD48lWewI9IttU2NlTghcbKJFxy+7Ck1Xdr2VOVDwYPzJqeH1QqedA6VZ/JIr
	 g3Fnb6SV2JFtwBVRl3a+hbfCAQeo7ym7MsFzylVlm8BBn4iSEIwNfzds3QL57mP9EZ
	 fTQiu80XXe56A==
Date: Tue, 1 Sep 2026 09:23:11 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: netdev@vger.kernel.org, upstream@airoha.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] net: airoha: grow the small RX rings
Message-ID: <apZ9XxGHbyDBzSW_@lore-desk>
References: <20260830095717.37218-1-sochnev.v.74@gmail.com>
 <20260831234701.206021-1-sochnev.v.74@gmail.com>
 <20260831234701.206021-4-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iSgGtsf6CDto9yfb"
Content-Disposition: inline
In-Reply-To: <20260831234701.206021-4-sochnev.v.74@gmail.com>

--iSgGtsf6CDto9yfb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Raise the RX_DSCP_NUM() fallback from 16 to 32, the vendor SDK default,
> and give ring 4 the 128 descriptors already used for rings 2/11/15.
>=20
> Ring 4 is the shared "force to CPU" ring that airoha_fe_vip_setup()
> routes BOOTP, PPPoE Discovery, PPP LCP/IPCP/CHAP/PAP/IPv6CP, ISAKMP,
> DHCPv6, SIP and LLDP onto, so it sees the same bursty non-hashed traffic
> as the rings already on 128 while sitting on the smallest allowance.
>=20
> At 16 descriptors the completion stall handled by the previous patch is
> readily reachable: on a Nokia XG-040G-MF the recovery fires roughly every
> 35 s under repeated PPPoE dial-up, and negotiation never completes. At
> 128 it did not trigger once across 500 forced PPPoE reconnects over 20 h.
>=20
> Ring 4 and the VIP classification feeding it are shared driver-wide, with
> no DT or hardware property distinguishing one variant's ring 4 from
> another's, so this is not scoped to a particular SoC.
>=20
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 =
SoC")
> Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/airoha/airoha_eth.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index c195dad5ed58..0b7c90940272 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -41,9 +41,10 @@
>  #define TX_DSCP_NUM			1024
>  #define RX_DSCP_NUM(_n)			\
>  	((_n) =3D=3D  2 ? 128 :		\
> +	 (_n) =3D=3D  4 ? 128 :		\
>  	 (_n) =3D=3D 11 ? 128 :		\
>  	 (_n) =3D=3D 15 ? 128 :		\
> -	 (_n) =3D=3D  0 ? 1024 : 16)
> +	 (_n) =3D=3D  0 ? 1024 : 32)
> =20
>  #define PSE_RSV_PAGES			128
>  #define PSE_QUEUE_RSV_PAGES		64
> --=20
> 2.55.0
>=20

--iSgGtsf6CDto9yfb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapZ9XwAKCRA6cBh0uS2t
rBTsAQC54xl85XXvmJfDDGnSxh3t76bdMZM9J3/7nroYJroTBgEAwWGjnbVtxJcr
V2ZoukEPId4WHAPImjFYCIq4MGWgjA0=
=FILA
-----END PGP SIGNATURE-----

--iSgGtsf6CDto9yfb--
