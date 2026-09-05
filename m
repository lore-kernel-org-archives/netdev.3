Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054A94A260F
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788612732; cv=none; b=PYshxmW4wqnj6yOsL7SxqjilMu1PQkGiucu+o3OKPoibAz6niu0PBmjeC4T8kTATDDoL4GPxFZ3krcv6QyZXGDo9/ccVzVr2faiVqyUOHXxmAuZ23j1HrTzps0tO4ujP5MqErKqR8EyE9MPysQiLRWfOFoko6y93Jr1MsLNa6xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788612732; c=relaxed/simple;
	bh=SwU7O5u2Zi+0MO7A5w4CrHOUj77vcKhfx446RwYJXHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tj1RCM9Lkx/n8pxdsVW59pJBDkNfUEtSjKS1F96gJRh5DfgMU1g5Eq6rv3UEkvk3OeMYc9QQl3anIknMpBwC+LmVWUnfOG41RvxnSyENG6srLOoXsgFyiY8oUyU09g4/DW/FR7AesNYdMB7Gb0CvdRESUbf3uw8hd7iEBEID/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/3O0UO2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/3O0UO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420911F00A3D;
	Sat,  5 Sep 2026 12:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788612729;
	bh=SwU7O5u2Zi+0MO7A5w4CrHOUj77vcKhfx446RwYJXHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V/3O0UO2N7TAuDTcDreqSlhtwladrlO5QKUy1e5/D9xvoT985R3Bj7itqN8mcyR02
	 88VjkIbjtq9Vg0JTxy3TkQTtdqpNco4x2EEAJ2Fi3aNLeUl+G3BQeospCtFZXpjYW7
	 YG0NuinBhPqGLQDqLMpBwMzwsOJoxQwOQpH1WaS+CWgAWxFLVSQt4dfgFcIVpgPrfz
	 HnqVAEp4jXmB9Ju92NFz43erb9yRMLef7FNj4W2uw4N8+wPNSBah+WygeQMQSq/HiM
	 yfchUeKczzuPXxkqK7u0pEQJcbmEXvupPfM9uOzXVPc79FyKJqQqQGTFnNcNVz4fmW
	 pYyA9O8jPcgAg==
Date: Sat, 5 Sep 2026 14:52:07 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v5] net: airoha: add HW GRO offload support
Message-ID: <apwQd01aErOMVf7T@lore-desk>
References: <20260831-airoha-eth-lro-v5-1-6b0f50401121@kernel.org>
 <fce0ee5a-476a-4867-9dd2-08e55993bd90@redhat.com>
 <aplpllPidmCjhSmA@lore-desk>
 <1ef90408-99b6-42fb-a7c6-7e5bca20c46d@redhat.com>
 <apmWLtgcUXRrOTFj@lore-desk>
 <20260903162558.2679c1d1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CrcWeQCa+fXKdkYr"
Content-Disposition: inline
In-Reply-To: <20260903162558.2679c1d1@kernel.org>

--CrcWeQCa+fXKdkYr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 3 Sep 2026 17:45:50 +0200 Lorenzo Bianconi wrote:
> > > Lacking more details from the vendor, I think you need to use a
> > > pktdrill-like sender, explicitly sets the segment lengths to some not
> > > mergeable (like, i.e. 200-300-400) but otherwise fitting a GRO packet
> > > (i.e. same hdr except for the sequence number and push flag allowed o=
nly
> > > in the last packet), ensure that the aggregation timeout lasts long
> > > enough to receive all of them, and check if the engine really aggrega=
tes
> > > them or not. =20
> >=20
> > I think in the example you pointed out (length 200,300,400) the hw engi=
ne will
> > create a single TCP packet composed by 3 segments (with gso_size =3D 30=
0) while
> > sw GRO will just push sigle skbs. I agree this is just a GRO approximat=
ion.
> > If it is not enough I am fine to switch back to LRO implementation.
>=20
> FWIW the gro.py test covers that and many more cases..

ack, thx for the pointer.
I run data_sml_lrg test available in gro.py and I can confirm the
hw aggregates the transmitted packets (even if it is not supposed
to do it). I will switch back to LRO in v6.

Regards,
Lorenzo

--CrcWeQCa+fXKdkYr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapwQdwAKCRA6cBh0uS2t
rPirAQC2OncL2LAuHYc8s0bUpffO3Nka35iD1jYtzPuIluDdaAEAwfTd23B04aYZ
UlRKhK+AWicClQ7Sknyr1xeLgqtENgA=
=U/DL
-----END PGP SIGNATURE-----

--CrcWeQCa+fXKdkYr--
