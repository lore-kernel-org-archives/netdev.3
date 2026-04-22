Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FC137700B
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874335; cv=none; b=cudglWHaql6E1j3Zko8+Zvw3QCGovi47y3vinCv68FKl1w+wL3caqMzfvB95vGOT8UM7pesq6q1zs+/IyhauRoarhRxCh24scglS2OIkEKkZ6Z0yVGXL7bAGJq/F++SqdK7Nsy8O557lVzy13VeO7RPK6NocLERz+mEnqjEFbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874335; c=relaxed/simple;
	bh=VsAr6KXIgPYr27igJ/fVG/z4nkK1KuCu7dlYwZq/gD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTshPfd7z9Ifvm/3S3CEI5GsgJsEWxYaoLbJwFfN38bny7+2dHu2IqX451zOnqTJojrfLlZIPiC5wvJaTTFbnPghnv+roUitHXjQV9EzajpnCk8swHLTIVDZAFfpjecekyp7nJ37Aac0beL78Zx0GJtLz878Y7MdkksZWGo4+m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfXjLL/z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfXjLL/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A53C19425;
	Wed, 22 Apr 2026 16:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874335;
	bh=VsAr6KXIgPYr27igJ/fVG/z4nkK1KuCu7dlYwZq/gD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfXjLL/zjWBpglG7roTbxyv4nZIAzo384j/Gjd+/9gHvcmi8j5BUjRu0T06llJk+P
	 EX5JJs1yGd9YcWQm3zFbQMjnb/0SLddhaZGf6v9TsErqwWPsEXgMkJ3XH4Wb0syepS
	 /b2wFLkZB2lcDuS4mEhJOjNAAUAvApTltrPXU3KErt1FrJ9ptOBUSGSenrIU4RgvXF
	 OsaH2c2sQuMsWC8xWXAFlHm1Z/KFtZMNAYYuR2/+rXY4x1T9r9/UC+Ycd16P33UvuC
	 6+woc1q2G+iWPiyZODJmPBAajrNuZRQV1ivfDzHmc6GZhGRhX5hR9PiFqvxXB/zEZ4
	 6Iivp0lchPGaQ==
Date: Wed, 22 Apr 2026 18:12:12 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: airoha: Add size check for TX NAPIs in
 airoha_qdma_cleanup()
Message-ID: <aejzXEKXls-o_2th@lore-desk>
References: <20260420-airoha_qdma_init_rx_queue-fix-v2-0-d99347e5c18d@kernel.org>
 <20260420-airoha_qdma_init_rx_queue-fix-v2-2-d99347e5c18d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ufmWYy3aeOw//QOT"
Content-Disposition: inline
In-Reply-To: <20260420-airoha_qdma_init_rx_queue-fix-v2-2-d99347e5c18d@kernel.org>


--ufmWYy3aeOw//QOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> If airoha_qdma_init routine fails before airoha_qdma_tx_irq_init() runs
> successfully for all TX NAPIs, airoha_qdma_cleanup() will
> unconditionally runs netif_napi_del() on TX NAPIs, triggering a NULL
> pointer dereference. Fix the issue relying on q_tx_irq size value to
> check if the TX NAPIs is properly initialized in airoha_qdma_cleanup().
> Moreover, run netif_napi_add_tx() just if irq_q queue is properly
> allocated.
>=20
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 =
SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index fc79c456743c..fd8c4f817d85 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -996,8 +996,6 @@ static int airoha_qdma_tx_irq_init(struct airoha_tx_i=
rq_queue *irq_q,
>  	struct airoha_eth *eth =3D qdma->eth;
>  	dma_addr_t dma_addr;
> =20
> -	netif_napi_add_tx(eth->napi_dev, &irq_q->napi,
> -			  airoha_qdma_tx_napi_poll);
>  	irq_q->q =3D dmam_alloc_coherent(eth->dev, size * sizeof(u32),
>  				       &dma_addr, GFP_KERNEL);
>  	if (!irq_q->q)
> @@ -1007,6 +1005,9 @@ static int airoha_qdma_tx_irq_init(struct airoha_tx=
_irq_queue *irq_q,
>  	irq_q->size =3D size;
>  	irq_q->qdma =3D qdma;
> =20
> +	netif_napi_add_tx(eth->napi_dev, &irq_q->napi,
> +			  airoha_qdma_tx_napi_poll);
> +
>  	airoha_qdma_wr(qdma, REG_TX_IRQ_BASE(id), dma_addr);
>  	airoha_qdma_rmw(qdma, REG_TX_IRQ_CFG(id), TX_IRQ_DEPTH_MASK,
>  			FIELD_PREP(TX_IRQ_DEPTH_MASK, size));
> @@ -1398,8 +1399,12 @@ static void airoha_qdma_cleanup(struct airoha_qdma=
 *qdma)
>  		}
>  	}
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
> +	for (i =3D 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
> +		if (!qdma->q_tx_irq[i].size)
> +			continue;
> +
>  		netif_napi_del(&qdma->q_tx_irq[i].napi);
> +	}
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
>  		if (!qdma->q_tx[i].ndesc)
>=20
> --=20
> 2.53.0
>=20

Commenting the issue reported by Sashiko here:
https://sashiko.dev/#/patchset/20260420-airoha_qdma_init_rx_queue-fix-v2-0-=
d99347e5c18d%40kernel.org

- Could a similar vulnerability still exist in the TX queue initialization =
and cleanup path?
  This issue is not related to this patch and already fixed here:
  https://patchwork.kernel.org/project/netdevbpf/patch/20260417-airoha_qdma=
_cleanup_tx_queue-fix-net-v4-1-e04bcc2c9642@kernel.org/

Regards,
Lorenzo

--ufmWYy3aeOw//QOT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaejzXAAKCRA6cBh0uS2t
rDnUAP4uQqKoxj7kVM9+Gx7LonOXYc4Q0EjP3VKRJVPNAWgInAD/ZUt+e+4xx+Ng
fXReaD152z+hQzH0lsnrLMK4iRDSswk=
=Nt0L
-----END PGP SIGNATURE-----

--ufmWYy3aeOw//QOT--
