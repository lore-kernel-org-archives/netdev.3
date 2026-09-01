Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64DE397937;
	Tue,  1 Sep 2026 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284808; cv=none; b=HDjkHoI720S35jeDWgtIEYwRdwDLSJzEQ49pjyOLrFtkFuY3nTBpOjOdKt8sMNjfpWOZ6qbBLL4/ABJLNP6MCJ1m1tCjtHoUNOxZz8VKbuwsmajYmWRRNGNdTUohH2kFUkwGdcJfrD/QO9792SAeejvNgR90qpRDH06zuyE1wRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284808; c=relaxed/simple;
	bh=0JxmeWVydT0ihziXtDVOy5pWHYK5GYZf44fz61PRjX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRA9eSRY1bVhLThsB7rTA3CUjDh8MDceKC85M1k7BbaT0tgPwEZTspg7OCYA3cdvYTD1foeuHMIaMQtEJJrkrCci5hOzU2x9gqVjNaYo22Uj469WCo+a/xAh5djfOevz4nPviZQxq2tgruhO4VdfYuRk/KXUwn9Ks0wQlc2S+ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXTCt3rN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXTCt3rN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E731F000E9;
	Tue,  1 Sep 2026 17:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788284806;
	bh=iPWi4hoZNDrjC4oNfHd7fHgoe10Ao+nAr9o9Kh5FrzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nXTCt3rNQUkwOrhPzMl0KYcQM0uwZq+OWqHdAykNvQi3KJ3W75V1wgo+nZIlRf+b1
	 GB7VwPNqXnX5Rs6wcx7DZGLSExw0HLvDp4KtZsHLQ02+vRHlhSsSQKbA5ACVa8ikP+
	 AUJJaseGWXkgNdM+O7OlCDrSno6Fwj6ij2L9NAtJ300JlUES0huwhjmZ9c+OXe2KXP
	 xeHoU0eZwxbiUnHGtzfO55eUfSOTKMIZF8T8uk4Ggktc8FlUw+qBpC1QS1Uc0a5ghT
	 x1gyMwBBTWQNPQbKzLTeEfc9AJWgPahIyWpAQLGV5C/81xRCjXoRkh46lAgKJavs4S
	 pKFh39gZDRAvw==
Date: Tue, 1 Sep 2026 18:46:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: snps,dwmac: Add UltraRISC
 DP1000 compatible
Message-ID: <20260901-press-buckwheat-92d17a6b8f71@spud>
References: <20260901-dwmac-ultrarisc-v1-0-f19454814bcf@ultrarisc.com>
 <20260901-dwmac-ultrarisc-v1-1-f19454814bcf@ultrarisc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jiiFleqVVWDTS025"
Content-Disposition: inline
In-Reply-To: <20260901-dwmac-ultrarisc-v1-1-f19454814bcf@ultrarisc.com>

--jiiFleqVVWDTS025
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 09:27:30AM +0800, Jia Wang wrote:
> The UltraRISC DP1000 GMAC is based on a Synopsys DesignWare MAC.
>=20
> Allow its SoC-specific compatible in the common DWMAC compatible list.
>=20
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index 2449311c6d28..2ed4564ae99d 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -119,6 +119,7 @@ properties:
>          - starfive,jh7110-dwmac
>          - tesla,fsd-ethqos
>          - thead,th1520-gmac
> +        - ultrarisc,dp1000-gmac

This should not be a standalone patch, rather merged with the other dt
one.

> =20
>    reg:
>      minItems: 1
>=20
> --=20
> 2.34.1
>=20

--jiiFleqVVWDTS025
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapcPgAAKCRB4tDGHoIJi
0pJJAQC2MOQ3WQ775wZhL2oOE84EeepYhkoKAGs4AIdvFoIJIQEAs4oDcmd2sGxv
x/CeJ0b0IJ340Tqg8YPgsSiFvur70QU=
=9MSe
-----END PGP SIGNATURE-----

--jiiFleqVVWDTS025--
