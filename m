Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495343;
	b=HbH3ZkiZRueQR/COwNyK5/MEyBB5wUXe2XPWCHmWL8/Tfo7LnEFv8q5h69wRes+KQ+20
	 +6kc7Q5skkLnDI08ra5Kf6dNZTqmADM9iBsigrDYnOtffC59SkyxibMIjJSlcRABMhKWe
	 tZyXCfJWeuZaLxcCW9Cq4yFjGarPkAB38a/bBfurovdC04xsIRs/mVlL0yRfXtraxLfO4
	 VVz+p0tgPd/MoUV++GiiSCKbeMCyEYf5ZYObur3iIwvdKlZRVstTV0o1GR4FgtDFp6Ras
	 nUTgPSkhf5TgONySckhgSwpt+2vt4KDnskEeKBMVC8YH6iewmPGyKI7MInGNtPVIx6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495343;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iLa7N/5PMxMIbw6XFiucfzTWFw0y9C0Nc4OXIPahQro=;
	b=CLy50kQP/uiFJ7TI6bFvTFnxFieFtkHIDH+FHJJ53K6OeZOmviZ5CVf6DR1V9Zl7v4Hc
	 0pGS5VNpfjl2OAgPsg3NA02EVyitAbDZI+1n8pZBGWJqJ12HdgVTSO/6D1yofY2LN0ztX
	 f/qA45njdaqf1p4GSdXMi3hsq0RMdktZWIKZRnqU3cNkWYms1i+vG+UmIBwuCS+iSRQnm
	 r6nq6ISY6MrmSqfSRgM0zi6ojFuUI5vOs6DPGbhwM+1BpcWY4gx0GFGaRiryTL0F6M7iF
	 yvhcORo2BiOE3YUCfKJD9shG5zPdujclERt5MiaKSf3bW1ZtuCZouuxnvSTEfvjTCbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GzLs4tLR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34D1606A31C;
	Thu, 12 Nov 2026 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GzLs4tLR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEA81F00A06;
	Thu, 12 Nov 2026 14:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794495342;
	bh=iLa7N/5PMxMIbw6XFiucfzTWFw0y9C0Nc4OXIPahQro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GzLs4tLRWkvQljPBr0XQxiwfM4AxgnYEikGh3csILNyhnM0n0IkrRo61qSV2dWs4G
	 cL4WiDf3FOFYJhBrw8DVSGEixG4mr5m+me90OgEFDgcVhPzv89K6TGn6PWBOP3H/4E
	 TX7ys/l/hIgNph/+l+QuniM264HZNuvCIQTKERCtM5kT8Qc7iqr8lZr9c2qgQhiX5s
	 m/P/612FS8YTsIG/PDHHLLQ8pWWJNNcVeqO70wdSgAC3majxGdO7zBtgsrA0Eij1dx
	 3EXIxHQFMsddzLl3ndK7j0/vV2G0NRIf5EeojOnAaws80JRENaDyQ/g88j4n7PuoDp
	 vJ6XzZcQPArFQ==
Date: Thu, 12 Nov 2026 15:55:40 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Felix Fietkau <nbd@nbd.name>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: Fix potential PPE hash
 table leak
Message-ID: <avXTbE2C9I09b3rn@lore-desk>
References: <20261112-88a3a7ff32-net-mtk@mail.sdu.edu.cn>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3P06uWmzQDZRbKO3"
Content-Disposition: inline
In-Reply-To: <20261112-88a3a7ff32-net-mtk@mail.sdu.edu.cn>

--3P06uWmzQDZRbKO3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The remove path does not destroy the PPE L2 flow hash tables. Their
> bucket tables are not device-managed and remain allocated when the PPE
> objects are released.
>=20
> Call mtk_ppe_deinit() after unregistering the netdevs and cancelling the
> driver work, as the probe error path already does.
>=20
> This issue was found by our static analysis tool under development.
>=20
> Fixes: 33fc42de3327 ("net: ethernet: mtk_eth_soc: support creating mac ad=
dress based offload entries")
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/et=
hernet/mediatek/mtk_eth_soc.c
> index ad0fdc4133fb..08973b6f0711 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -5426,6 +5426,7 @@ static void mtk_remove(struct platform_device *pdev)
>  	netif_napi_del(&eth->rx_napi);
>  	mtk_cleanup(eth);
>  	free_netdev(eth->dummy_dev);
> +	mtk_ppe_deinit(eth);
>  	mtk_mdio_cleanup(eth);
>  }
> =20
>=20
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> --=20
> 2.43.0
>=20

--3P06uWmzQDZRbKO3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCavXTbAAKCRA6cBh0uS2t
rJMnAQCxCJLxh3xXoIo6ffBg/WJ9QAMKv+murVMDfTXlkqfPEAEAkdkzVoUscK8l
cXq37j/SXZQW4sEx6Xa5a/dKpw8hBQ0=
=n1xX
-----END PGP SIGNATURE-----

--3P06uWmzQDZRbKO3--
