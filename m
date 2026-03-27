Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3CD3D6689
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604387; cv=none; b=sWQq5j7TIAqNQsnByhvvqv8hCTDLU4WPdzLmYWWDFAJPQYO4FoFDvuysb5Eb3iCQqKTs05UlrlMFvk3XbZnihzuRpQcrL9+XwzODED3Fu7eMjbUjG+q2JSHiMaLbDoNzV/1m6qY4gRRoLigAT9lc7jxEHLBonzdt8ubi+So0nqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604387; c=relaxed/simple;
	bh=vE7aAgOybl8kkMRNRMKH3/474cFLbolEO1kCDStPcHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfudrCC490yF/Kbs76J8ZKwDXV75fNSa6WJGVPG5guAXdO5ZiH1tVEREGR7kVl3fn8O+ke+TaEu9lP3D2J1KANNSJPmwtmo1/ZpDs6PXqZq6PlA45LetZJjw6qfFHhXTA+/RuQ9b1K0OhSl0O3znOaj+bo3tM1WhKQD1GnVeEa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG6eFPCN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG6eFPCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E81AC19423;
	Fri, 27 Mar 2026 09:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774604386;
	bh=vE7aAgOybl8kkMRNRMKH3/474cFLbolEO1kCDStPcHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aG6eFPCNSVxypTv9jEH5KH/xPEibbRyBfFUVet2kUEFX32KUxGclPCcrocoYApiZk
	 1VSGqwxvqtzFLlMgthLlDYa8yUkL5fgDPPsLURNzErv4pmm5WzPmEdp2sZbLSlEJ4S
	 7DBjsBL2GPDPGLeZAz9HyylFUIUaYOTluLi7RxvTecQf25aK1c0TEv1+Sq5JINuXcm
	 lKG/P+Cdr4KwjYaA3qKHvnHb0AfXD0w4XGC9oWLklkdZhmOl1hYO7kw0uyn2+2HPuq
	 JERvnxKGEB3U+MRMMzjLGt+6XtJGgSsTpfkA/eTOKZi3Q0iLPMQG0ArFOaRMrUl6C5
	 qaBALaVB3IFYw==
Date: Fri, 27 Mar 2026 09:55:35 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Grab flow_offload_mutex running
 airoha_register_gdm_devices()
Message-ID: <acZGBngWPvjB6ZyA@lore-rh-laptop>
References: <20260324-airoha-regiser-race-fix-v1-1-6014df55886b@kernel.org>
 <20260326200605.39222917@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fJ1bmY2v5shV2XLg"
Content-Disposition: inline
In-Reply-To: <20260326200605.39222917@kernel.org>


--fJ1bmY2v5shV2XLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 26, Jakub Kicinski wrote:
> On Tue, 24 Mar 2026 17:54:45 +0100 Lorenzo Bianconi wrote:
> > Netfilter flowtable can theoretically try offload flower rules as soon
> > as a net-device is registered while not all the other ones are
> > registered/initialized, triggering a possible NULL pointer dereferencing
> > of qdma pointer in airoha_ppe_set_cpu_port routine. In order to avoid a=
ny
> > possible race, grab the flow_offload_mutex running
> > airoha_register_gdm_devices().
>=20
> Sashiko says this causes a lock ordering issue:
> https://sashiko.dev/#/patchset/20260324-airoha-regiser-race-fix-v1-1-6014=
df55886b@kernel.org

Ack, right. Thx for pointing this issue out. I will work on a different
solution.

Regards,
Lorenzo

--fJ1bmY2v5shV2XLg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCacZGAgAKCRA6cBh0uS2t
rFjSAQDQ1c+Kgc2ua9ykMwg2Ik7Y9Qnbiz1WGHZhludsXoIdewEA4EpBiexqldQr
kxPBov/kITpBYnXQ0uVDyd5zKQouIwk=
=E/LG
-----END PGP SIGNATURE-----

--fJ1bmY2v5shV2XLg--
