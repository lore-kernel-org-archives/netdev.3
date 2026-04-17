Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33623128816
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407212; cv=none; b=VwDjOaw9svuwsfmGBR7cczsa/Q1yt/2DkMdMPdVYwXOd7R39X8TNlmjghq4MyhmqRo6RdreUnCiR4jGIUxPiIwZRzS+38iLVcZdnH2O2zBujdsPLS4JtbPZ858y7XKRMq2FtJi2kX8Bm42hqZColDKjdWlWX5LTSgr5r91Jzuq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407212; c=relaxed/simple;
	bh=8olc5JPtTmNs7JxzhXfknZC5ye3nqkDyWIxX6NLqcsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyCYFwCY6/lpQmwEBvt/DZWYiqA99gO9f6Tq7Hg7VTEFrdHaiTKR6zmjAYdvCw0t/40MMjILZm05COr967NRDm/g2dksdWQXIF3X4VZ+duCV+ksWJQMhXXUEbiR4CTD3WbJPnJ+7AZDPBGP9DBga2A71z6ck+4Ig0+0+EJhhsrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii+baCT7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii+baCT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FE8C19425;
	Fri, 17 Apr 2026 06:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776407211;
	bh=8olc5JPtTmNs7JxzhXfknZC5ye3nqkDyWIxX6NLqcsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ii+baCT79b7tsFmDK4rVJilzHvdXtIHbisNirrznWimmbKglALdtQXerrKDhDcSbM
	 KhKzlnwVjNR29gKZ+kjzF5KFQMjCS8LfRfVfOdk3aF1BRmXCal64jH8GV/6xTjQWcm
	 dGs5q8+1ARMgDpuuOm6LRPgAyEAcjXC5PwyA5yVUDMR68pprVCp7J9UZzayT3+3cEw
	 lvqEbxg+uuTszo83t304CAtD91MjvhLzmRgEB+ykI/7yPVM3WD26EWzazmQuBZ1FE9
	 0UMylePmu5izj10h8YmcpluQfWuPUqWWqCZleHqFF0SArMKuE/ZldLM4LsKGyXGGso
	 S7cwrntiphIEA==
Date: Fri, 17 Apr 2026 08:26:49 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v3 0/3] net: airoha: Fix
 airoha_qdma_cleanup_tx_queue() processing
Message-ID: <aeHSqQoFPE_OqSre@lore-desk>
References: <20260416-airoha_qdma_cleanup_tx_queue-fix-net-v3-0-2b69f5788580@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="csZElj/PTazYvxbd"
Content-Disposition: inline
In-Reply-To: <20260416-airoha_qdma_cleanup_tx_queue-fix-net-v3-0-2b69f5788580@kernel.org>


--csZElj/PTazYvxbd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add missing bits in airoha_qdma_cleanup_tx_queue routine.
> Fix airoha_qdma_cleanup_tx_queue processing errors intorduced in commit
> '3f47e67dff1f7 ("net: airoha: Add the capability to consume out-of-order
> DMA tx descriptors")'.
>=20
> ---
> Changes in v3:
> - Move ndesc initialization fix in a dedicated patch.
> - Add patch 2/3 to move entries to queue head in case of DMA mapping
>   failure in airoha_dev_xmit().
> - Cosmetics.
> - Link to v2: https://lore.kernel.org/r/20260414-airoha_qdma_cleanup_tx_q=
ueue-fix-net-v2-1-875de57cc022@kernel.org
>=20
> Changes in v2:
> - Move q->ndesc initialization at end of airoha_qdma_init_tx routine in
>   order to avoid any possible NULL pointer dereference in
>   airoha_qdma_cleanup_tx_queue()
> - Check if q->tx_list is empty in airoha_qdma_cleanup_tx_queue()
> - Link to v1: https://lore.kernel.org/r/20260410-airoha_qdma_cleanup_tx_q=
ueue-fix-net-v1-1-b7171c8f1e78@kernel.org
>=20
> ---
> Lorenzo Bianconi (3):
>       net: airoha: Move ndesc initialization at end of airoha_qdma_init_t=
x()
>       net: airoha: Move entries to queue head in case of DMA mapping fail=
ure in airoha_dev_xmit()
>       net: airoha: Add missing bits in airoha_qdma_cleanup_tx_queue()

Please drop this version, I will send a new one dropping patch 2/3.

Regards,
Lorenzo

>=20
>  drivers/net/ethernet/airoha/airoha_eth.c | 42 ++++++++++++++++++++++++++=
------
>  1 file changed, 35 insertions(+), 7 deletions(-)
> ---
> base-commit: 3f20012a3964f487ae1e9ff942e2f35d4e9595bf
> change-id: 20260410-airoha_qdma_cleanup_tx_queue-fix-net-93375f5ee80f
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--csZElj/PTazYvxbd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaeHSqQAKCRA6cBh0uS2t
rBPrAP0WKNNrlDxxVSNL8TT1jgwKosyG90oakRKSIfQ5f+0hKAEA+FwgEcTw4hCs
OoZLhItk2oKK9Mr2kaBLED692czC6g0=
=DBkL
-----END PGP SIGNATURE-----

--csZElj/PTazYvxbd--
