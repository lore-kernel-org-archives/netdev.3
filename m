Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA86D45BD41;
	Thu,  7 May 2026 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175877; cv=none; b=XsYhiEym8+QUotOK5jReT6y33GVSCegRMQSMBNlHsgVahAa396VLSexSLQl4hfKWel+q0NDSJFJQdtQAhT0qb0Sg0lLGkTKpM9y/s2QXjLWbycN6Y4fpnxYUhz2AlmCZsSTtd9U3jRB9XRkldvUWmsBTuXT7WvD/ryQFvUtqK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175877; c=relaxed/simple;
	bh=qjeD8hwp10GbaUexdP3erEb8CkTqb7qN9kMATj2u9A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpdKGQRwLLpBf5eVUBl71k/YW8fs+eW2NbI1gjfb734pSFSbA4ABLeexJKXeadEr32TU5qAt9PswVzhf50W6kqEIjD0AE8ORE3oxfaxv7MZBoOOmVg2n8KjcXQgIcQwGKhRxBm1Uw3DgPzrqH416uySKAiInQ1kZ1k+HzzbfmyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POMVGRId; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POMVGRId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F8BC2BCB2;
	Thu,  7 May 2026 17:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778175877;
	bh=qjeD8hwp10GbaUexdP3erEb8CkTqb7qN9kMATj2u9A0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=POMVGRIdkWwa5YAIcc6/YW+UFL/EarFcJyCTGvJtfSFu7mPXkvW0PM4X7LRwpWLd8
	 pRO7xunP05JlEo8v0sU8f4n4Ip/t8Sor1L77NUWT0MqK58boyV102UJ9hFnfnoAzSh
	 +mrEUd+jy2KOMQH7DUsUKMRvWOiyZhZ3rsvtOoo1FiyU/SKSK9KtllR9b+Ei/HTD3k
	 1V2/y3CCa372LXgS786YFkQ7pCRS+B2tOykuhhcmbpDGND+vXhjdJuoPbVGb+bY2kj
	 kUum3KXYTxEUGYOVdbzuXRa/09bXsIZwuzAwF0a2FYVd6wxqUtdUbOh2+iczpIffPx
	 QAo4RrcJqbD6Q==
Date: Thu, 7 May 2026 18:44:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [net-next v3 4/5] net: stmmac: starfive: Add jhb100 SGMII
 interface
Message-ID: <20260507-reoccur-underfoot-bac75e8e454d@spud>
References: <20260507094115.8355-1-minda.chen@starfivetech.com>
 <20260507094115.8355-5-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1y8BhspTTm66m592"
Content-Disposition: inline
In-Reply-To: <20260507094115.8355-5-minda.chen@starfivetech.com>


--1y8BhspTTm66m592
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 05:41:14PM +0800, Minda Chen wrote:
> Add jhb100 compatible and SGMII support. jhb100 soc contains
> 2 SGMII interfaces and integrated with serdes PHY. SGMII with
> split TX/RX MAC clock and need to set 2.5M/25M/125M TX/RX clock
> rate in 10M/100M/1000M speed mode.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
> @@ -130,6 +160,7 @@ static const struct starfive_dwmac_data jh7100_data =
=3D {
>  static const struct of_device_id starfive_dwmac_match[] =3D {
>  	{ .compatible =3D "starfive,jh7100-dwmac", .data =3D &jh7100_data },
>  	{ .compatible =3D "starfive,jh7110-dwmac" },
> +	{ .compatible =3D "starfive,jhb100-dwmac" },

You've declared compatibility with the jh7110, why do you also need to
add the new comaptible?

>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, starfive_dwmac_match);
> --=20
> 2.17.1
>=20

--1y8BhspTTm66m592
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCafzPgAAKCRB4tDGHoIJi
0s5kAPwJ8DNl1Z9mFplSHREfjOFAs8yQ3/t/xZYhY07C2sfSTwEAj5xXufiXBr2V
FZqP1AY1cu9s2+ucvq127NGSJLJ7xgs=
=YCco
-----END PGP SIGNATURE-----

--1y8BhspTTm66m592--
