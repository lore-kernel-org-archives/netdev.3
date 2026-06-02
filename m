Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204B395AC7
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780383141; cv=none; b=AMN8nZdmICr2ExvQ+ps2jkl67Gl2t0I+GgBYJc6mXt7gcRS93/KjLvIGc6yjv2lchURYTihNIXzPWD1c2lfoU3x1hxHOD4WUKua6sEnz3/MnzmqhSytneNpx+5coWFVedZQyLjXmeRqHReANLIqOByU53ghutz82OKTt9NGB3wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780383141; c=relaxed/simple;
	bh=/jurpIGVxras/60V4TOfIMEpfTOxspIKn7fZH7+lQlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeLY9EEH5Ty0fRKyLfzUCNIGAJpxJ2ng5bd1FFWNZ9WHPVZiWtm/tPn/1LrGlSq0O1Q1SwiClDOIbQEDNuzjIBj7lyXrurWjYial92fExBB3Yp9NuzFAdKW48GJTr/6scZbO4a4+jEQcVqzLQmxtyrWLslRoZ2RPoc1RlHMRuBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8IElk/h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8IElk/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F199B1F00898;
	Tue,  2 Jun 2026 06:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780383139;
	bh=ZDSxYnMPY0itqsVM4sIvyNaZq4A9tfxgOPqtLTGH890=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K8IElk/hVgq6/2y9P/OGKrMAyBQ/0zQwylWD9vpg4553zitHz8Ps5Fv8mD9wzSvpS
	 xuTYJ6vQ1ZtD6Yn/RAOp3cFFnclPPFkZ0g412Q01VwUB9+YakZFBJTSV1XT6gsxMQd
	 0HmxjvIEvWavEt29wPCTHDtXddp8TmPSXIKcScI3h+JFDhq/Vl+6Kj2sRiYdfqXlv+
	 scMjuOgCQtsx0Op4M0BL8hrwFzeQDGcjmsYrto8fvuUaFTxxktpBsiN1MCvRTaIbtr
	 EAYNFzlxx+wOmYX+fjDfXlxVoAGs2yZ8TBlb8UD5sS5fft+kZQsKXW1xdaURtRdK/w
	 LmtjxWZABNmEw==
Date: Tue, 2 Jun 2026 08:52:15 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Felix Fietkau <nbd@nbd.name>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: Possible UaF bug in netdevice teardown path
Message-ID: <ah59n47KKkhZmt0o@lore-rh-laptop>
References: <ah1NJMrJ5rEkQlJG@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="576asHiwzTTmFSL0"
Content-Disposition: inline
In-Reply-To: <ah1NJMrJ5rEkQlJG@strlen.de>


--576asHiwzTTmFSL0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 01, Florian Westphal wrote:
> Another sashiko drive-by report. TL;DR, do you need to apply this
> pattern in your driver?
>=20
> -       metadata_dst_free(priv->md);
> +       dst_release(&priv->md->dst);
>=20
> Affects:
> drivers/net/ethernet/airoha/airoha_eth.c
> drivers/net/ethernet/intel/ice/ice_eswitch.c
> drivers/net/ethernet/mediatek/mtk_eth_soc.c
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
>=20
> Long version:
> https://sashiko.dev/#/patchset/20260527135751.1031891-1-tristmd%40gmail.c=
om
>=20
> This isn't a bug introduced by this patch, but looking at this fix, do
> other callers of metadata_dst_free() suffer from the same use-after-free
> vulnerability?
> In drivers like ice_eswitch and mlx5 MACsec, a metadata_dst is allocated
> and references are taken on it via dst_hold() when packets are processed
> (for example, via skb_dst_set()).
> However, on their teardown paths, these drivers call metadata_dst_free(),
> which unconditionally frees the memory without checking the reference cou=
nt.
> If packets holding these references are queued (like in a netem qdisc)
> during teardown, does the memory get freed prematurely, causing a
> use-after-free when the networking stack eventually calls dst_release()
> on the dequeued packets?

Hi Florian,

For airoha_eth and mtk_eth_soc I think the issue is less severe since we
destroy the metadata after running unregister_netdev() (that executes
synchronize_net()), but I guess it is better to fix the problem. I will pos=
t a
fix for them.

Regards,
Lorenzo

--576asHiwzTTmFSL0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCah59nAAKCRA6cBh0uS2t
rBbkAP9n6TqudmP6+W+Gls0RKmbOrps5XTC2yBfclupisGuNKgEAzCrWI8aTjg0X
PL+C1WcMnx5qmRT8MuqbePPE7PitIQs=
=sBwZ
-----END PGP SIGNATURE-----

--576asHiwzTTmFSL0--
