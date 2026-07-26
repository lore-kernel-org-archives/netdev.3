Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B1B72630
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785059175; cv=none; b=cqmdnmL/L5SgZygA2UYmG5BvtKd3xk4fmzMQe8KI3IZfDCJ9XHDWcDJG8RY1qk8qa4DEQne2gq7bLVDn1FwZ0PmxA6rEeIHKwsg09pIJ0EGtix2CfcbqOCkUPo+TfxwPuNQ+BH6jJNNdz/VDkSP/48hRD+eR3ARKI9e3Yu3mD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785059175; c=relaxed/simple;
	bh=TwerJkFHdT++LOIJgv9PISLSBG94I00IzJAq6hZLJtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SI9Kz9agNfvAccKkH649Q83TG86zvxt+BhlQkF+ipozr/IXUJsduzz+7/YdBvDogv/H8xZ9Kra/0D42CCBivwy4b+OzSUY2croUdMM6ReVBvXXEbIgzmFGtaBkfdlfVckJs7nQMgKUfooGcX9CiEXrhvPVwsqXNB3MTehn0cmrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqkWkC34; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqkWkC34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1891F000E9;
	Sun, 26 Jul 2026 09:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785059174;
	bh=Vqp2BixdCXUQZaBs8MDk+t4jlUBuZygrQzHv2Kz2JrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iqkWkC34dZcOVmUM4hhoTsUjz7mj3YkeQ6GMpUBnA1S6TUKg55x7Tk43/mxBrElGU
	 mmgIg/Gs7DUSSxRqlHFhOVytsmsZsSpjSyFMrmSoml9VmLNz/Q/Is95bNuuzwsVKmE
	 mu264MEecua0eiO+mrrWYR3Tp1H+g+fjNoDkEco4oqUEwa0Hc6V0k3ka8C9Lyf1T/V
	 Wp/98joQ57jMkC7HzKwLNPRCPXl3cHObyfg8kFTNqeA38tHyFv0JzvB3KT43Gic2vQ
	 8Bvl4jlfxZ7ee3K5yinLcF3WnkI6rNhUuPtKidfSJfPOeseyl31AaZeQ9bCmJSoSuI
	 mVzSkpNGnfRQw==
Date: Sun, 26 Jul 2026 11:46:11 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ipip: reject unsupported configurations in
 fill_forward_path
Message-ID: <amXXY1_oi-TdPfzs@lore-desk>
References: <20260725-ipip-fill-forward-path-fix-v1-1-bc69fd3127d5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H1Fnms9KoUY9mpQy"
Content-Disposition: inline
In-Reply-To: <20260725-ipip-fill-forward-path-fix-v1-1-bc69fd3127d5@kernel.org>

--H1Fnms9KoUY9mpQy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The ipip fill_forward_path callback currently does not check for
> configurations that cannot be offloaded to hardware:
>=20
> - Collect metadata (flow-based) tunnels have no fixed destination
>   and rely on per-packet tunnel metadata, so the forward path
>   cannot be pre-computed.
>=20
> - TOS inheritance (parms.iph.tos & 0x1) requires copying the outer
>   TOS from the inner packet at encapsulation time, which is not
>   known during forward path resolution.
>=20
> Return -EOPNOTSUPP for both cases to fall back to the software
> forwarding path.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  net/ipv4/ipip.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
> index d1aa048a6099..0831f6b81717 100644
> --- a/net/ipv4/ipip.c
> +++ b/net/ipv4/ipip.c
> @@ -360,6 +360,12 @@ static int ipip_fill_forward_path(struct net_device_=
path_ctx *ctx,
>  	const struct iphdr *tiph =3D &tunnel->parms.iph;
>  	struct rtable *rt;
> =20
> +	if (tunnel->collect_md)
> +		return -EOPNOTSUPP;
> +
> +	if (tunnel->parms.iph.tos & 0x1)
> +		return -EOPNOTSUPP;
> +
>  	rt =3D ip_route_output(dev_net(ctx->dev), tiph->daddr, tiph->saddr,
>  			     inet_dsfield_to_dscp(tiph->tos),
>  			     tunnel->parms.link, RT_SCOPE_UNIVERSE);
>=20

commenting on sashiko's report:
https://sashiko.dev/#/patchset/20260725-ipip-fill-forward-path-fix-v1-1-bc6=
9fd3127d5%40kernel.org

- This is a pre-existing issue, but should the IPv6 equivalent callback,
  ip6_tnl_fill_forward_path() in net/ipv6/ip6_tunnel.c, also receive similar
  checks?
  - already fixed in the following patch:
    https://lore.kernel.org/netdev/20260724-ip6ip6-route-lookup-fill_forwar=
d_path-v3-1-7b7991538614@kernel.org/

Regards,
Lorenzo

> ---
> base-commit: 04026c998c24ac47eb76886b9790c5710b603eb4
> change-id: 20260725-ipip-fill-forward-path-fix-543c41000a57
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--H1Fnms9KoUY9mpQy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCamXXYwAKCRA6cBh0uS2t
rP5ZAQDr/3s0FzbIxcLeQUUhn26PxMz5DlHKk/s1807RDp89FgEAtjcno1RpePY6
VRKeYPSkjeLW84Uv1gDifHGhvhIsngY=
=F4f3
-----END PGP SIGNATURE-----

--H1Fnms9KoUY9mpQy--
