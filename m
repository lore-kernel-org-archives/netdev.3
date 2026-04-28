Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E30526ED33
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777352785; cv=none; b=lp1+J4qEuc1+VPButvSIzqUok9rea/0NBBfUlr12OZ/XAlPchxk+rLxvZQ92InO/cduiifVp8AxgjcG9Gzo945yX8DYEeksgSYzesSsbvhQDDN65IF+VjJElTVGz1oW65VC4dmXhOQPdYOhyVQff/YZJAypnZLdT0DiDzps1/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777352785; c=relaxed/simple;
	bh=YkVuIVrPUH9G6CQvZXtEIKnd9PzfTiFbEiHpBUaI28o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XL6TNVfHslKEDZWnC70J14PaztvX92aRRg1yQQ/cgxSEmIIa2jodIq0cqc+YEcHxtNcb3+Jcdo2UWDSJPsWFkvVWnVTyvCH6g32vuYq9SakbL7eTor8/KL9fadb/A0haBZC6b5oa/LAgiVnKGyEmRkG/yHxnjXgU3YK8Hte4TmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzKPtcxO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzKPtcxO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BED1C2BCAF;
	Tue, 28 Apr 2026 05:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777352784;
	bh=YkVuIVrPUH9G6CQvZXtEIKnd9PzfTiFbEiHpBUaI28o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qzKPtcxO67dGseiMrH0EaH4Cn+6MBhm4KkTVFSHhX2whOqWCuRtqzNeHRqYoK9g6V
	 3kNl1i9HqXxMudWRkhgqAo6Kj5ifkYoPXNk1n6r9qESysCNZ2slkHc44W3fJaxayI4
	 73HaY9dxvXnHYTp+aH6jtSPZzPKDQo4qO3TW7l+3gIm779H5R30peTxBp0dGdhiPFf
	 gLZL1xz/ltGbyoAjHU4WNQ1Aw/AtK/QQ4AERRX+eatEz0CNQqIJzwSj7tqnpfJbz14
	 kCUyiaKNktpzRoYV+SzyPnuvzi/s92bVyxa14uCybE7S8mWROn+RftYAQw52I3J/HJ
	 2PljOTdDU1d9g==
Date: Tue, 28 Apr 2026 07:06:22 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Do not read uninitialized fragment
 address in airoha_dev_xmit()
Message-ID: <afBATq82XMLCaWl5@lore-desk>
References: <20260424-airoha-xmit-fix-read-frag-v1-1-fdc0a83c79e8@kernel.org>
 <aezLa2POvT0It5AA@lore-desk>
 <20260427173935.6a1e36ee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OBY97DuD8kgF4vPM"
Content-Disposition: inline
In-Reply-To: <20260427173935.6a1e36ee@kernel.org>


--OBY97DuD8kgF4vPM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, 25 Apr 2026 16:10:51 +0200 Lorenzo Bianconi wrote:
> > - Does the TSO checksum calculation earlier in this function ensure the
> >   TCP header is in the linear portion of the SKB?
> >   This issue is not related to the current patch. Moreover, can we have=
 a TSO
> >   packet where the tcp header is not in the linear area of the skb?
>=20
> Don't think so.
>=20
> > - If dma_map_single() fails partway through a multi-fragment packet and
> >   triggers this goto error_unmap, will it break the Tx ring contiguity?
> >   This issue is not related to the current patch. Moreover, I guess the=
 hw is
> >   capable of managing out-of-order descriptors.
> >=20
> > - Is it safe to map fragment data using dma_map_single() instead of
> >   skb_frag_dma_map()?
> >   This issue is not related to the current patch. I will post a dedicat=
ed patch
> >   for it.
>=20
> I don't think it's an issue. Unless you support DMABUF zero-copy=20
> the skb_frag helper is just for convenience. I wouldn't bother.

ack, let's skip it for the moment.

Regards,
Lorenzo

--OBY97DuD8kgF4vPM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCafBATgAKCRA6cBh0uS2t
rM6MAQCQQURreRlwbz1P+oyJbYOcGonb68w+NBmP1WqyypDIrAD/b5Cj5TdBpCS3
ScvL3g37x9jKb0jOzE+BQ7fR37+t5Qs=
=Mk+y
-----END PGP SIGNATURE-----

--OBY97DuD8kgF4vPM--
