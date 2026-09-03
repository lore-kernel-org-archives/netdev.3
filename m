Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFCE4E66C3
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450353; cv=none; b=tuuIwlHHE45tTaA16rvasj3xCGbhnGWWErZ93tbXH9mmb5fKU3XHWQV5kX8DjBVQsgO7CYeJqbS4C+7pAuk4nN2Aq7Xkky5ARxaXaRGBNODjNCOOvFOnngOgjSunpoYxkrb+D4FIX4TqZIar+qsG4YMDmdSc4IofCEYnQ7WmvWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450353; c=relaxed/simple;
	bh=RAYwY55EGn/bAeUGHlw4U5RAYW90S1S+jDQJ1rHQLFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESCPd1y0LC0m+O39aJmDJa24twVjXRN1UvcERGLowWWPgtF/elPtPkz6Tz2jl3RkX17/cg/FGLMnhQcU9+rV98WwkS17V2UEYYUPPqWV5XH3d6X3QfSY5bDNJf0lFRBADx3nry5W+cY1ugJGWL8WsRJYO8MnjUfEO4z8uChdL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RShHivsJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RShHivsJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B771F000E9;
	Thu,  3 Sep 2026 15:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788450352;
	bh=yCMUqh6ANgvQ3Pwx5RlqzkheOtUmmalNv6/kwBMPNcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RShHivsJHdQYENIAXi57A6y92sj/SKI64hzjlD+CpHniAIzXmEJphBiTvmrNl/Vot
	 3Y0GFG1uKzoPSt5EUSrrJJ3zR28vBI4mDG6hAB6ZgGKWoUwblt8vqNEwRvU4FnJ69Z
	 zemYcX3EYv1CWiICaujZowbPBgt5zgDDWX//759uPwefwK4tR8PECY2+w492cmgEmh
	 7m7EzvBTZMiZBqNS2cclfG7ngmVxjPTEqargjpLRYBULmyL6i9XiO3hwAgc88eXIi/
	 bjWPwueSBU2ZsmTIiVW2e1yah5PWZ4WHtxIY4yerUbHSf9sWMzAiwssJS7S8tNvmWc
	 +JzTasZSy8BPQ==
Date: Thu, 3 Sep 2026 17:45:50 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v5] net: airoha: add HW GRO offload support
Message-ID: <apmWLtgcUXRrOTFj@lore-desk>
References: <20260831-airoha-eth-lro-v5-1-6b0f50401121@kernel.org>
 <fce0ee5a-476a-4867-9dd2-08e55993bd90@redhat.com>
 <aplpllPidmCjhSmA@lore-desk>
 <1ef90408-99b6-42fb-a7c6-7e5bca20c46d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NDvggmcI2CoJ2jcY"
Content-Disposition: inline
In-Reply-To: <1ef90408-99b6-42fb-a7c6-7e5bca20c46d@redhat.com>

--NDvggmcI2CoJ2jcY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 03, Paolo Abeni wrote:
> On 9/3/26 2:35 PM, Lorenzo Bianconi wrote:
> >> On 8/31/26 8:34 AM, Lorenzo Bianconi wrote:
> >>> Add hardware GRO offload support to the airoha_eth driver, leveraging
> >>> the EN7581/AN7583 SoC's 8 dedicated LRO hardware queues mapped to RX
> >>> queues 24-31. HW GRO offloading does not support Scatter-Gather (SG) =
so
> >>> it is required to increase the page_pool allocation order to 2 for RX
> >>> queues 24-31 (LRO queues).
> >>> Since HW GRO is configured per-QDMA and shared across all devices usi=
ng
> >>> it, HW GRO is mutually exclusive with multiple devices bound to the
> >>> same QDMA block. Call airoha_update_netdev_features() in
> >>> airoha_dev_set_qdma() so that NETIF_F_GRO_HW availability is re-evalu=
ated
> >>> whenever the QDMA user count changes (device registration and runtime=
 QDMA
> >>> migration).
> >>> Set CHECKSUM_PARTIAL with pseudo-header checksum on aggregated packets
> >>> so that L3-forwarded traffic is correctly handled by the GSO/TSO path
> >>> on the egress device.
> >>> The HW does not report the per-segment MSS (msg3[31:16] only reports
> >>> the max aggregated size), so the gso_size of an aggregated packet is
> >>> just an approximation computed as DIV_ROUND_UP(data_len, agg_count).
> >>
> >> What is the <max aggregated size> exactly? I read it as the maximum si=
ze
> >> of the aggregated segments, am I correct?
> >=20
> > Hi Paolo,
> >=20
> > with "max aggregated size" I refer to the length of the aggregated TCP
> > packet (composed by multiple segments). This value is reported via
> > QDMA_DESC_LEN_MASK field in the DMA descriptor. Moreover, the hw reports
> > the exact number of the aggregated segments via QDMA_ETH_RXMSG_AGG_COUN=
T_MASK
> > field.
> >=20
> >>
> >> Also any more details on how the aggregation engine works? i.e. can it
> >> aggregate "random" segment sizes (i.e. 200 - 300 - 400) or does it
> >> respect HW_GRO layout? (i.e. all segments except the last one must have
> >> equal size, the can be smaller).
> >=20
> > The hw engine, for each LRO queue, is configured with:
> >=20
> > - CDM_LRO_AGG_NUM_MASK: max number of segments for each aggregated TCP =
packet
> >                         (64 in the current configuration).
> > - CDM_LRO_AGG_SIZE_MASK: max size of the aggregated TCP packet (compose=
d by
> >                          multiple segments). 16KB in the current config=
uration.
> > - CDM_LRO_AGG_TIME_MASK: max timeout to compose the aggregated TCP pack=
et.
> >=20
> > In order to validate the scenario, I run the following test:
> >=20
> > TCP client:
> > ------------
> > - disable TSO/GSO
> > - set MSS to 256 bytes (iperf3 -M option)
> >=20
> > I can see multiple 310 bytes TCP segments on the wire
> >=20
> > TCP server: (where rx-gro-hw is enabled):
> > -------------------------------------------
> > - the engine aggregates ~64 segments in a ~16Kbyes TCP packet
> >=20
> >   so gso_size ~ 16KB / 64 ~ 256B
> >=20
> > I guess this would be the behaviour even if the original packets
> > have different size (not sure if it is a real use-case).
> Lacking more details from the vendor, I think you need to use a
> pktdrill-like sender, explicitly sets the segment lengths to some not
> mergeable (like, i.e. 200-300-400) but otherwise fitting a GRO packet
> (i.e. same hdr except for the sequence number and push flag allowed only
> in the last packet), ensure that the aggregation timeout lasts long
> enough to receive all of them, and check if the engine really aggregates
> them or not.

I think in the example you pointed out (length 200,300,400) the hw engine w=
ill
create a single TCP packet composed by 3 segments (with gso_size =3D 300) w=
hile
sw GRO will just push sigle skbs. I agree this is just a GRO approximation.
If it is not enough I am fine to switch back to LRO implementation.

Regards,
Lorenzo

>=20
> /P
>=20

--NDvggmcI2CoJ2jcY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapmWLgAKCRA6cBh0uS2t
rANwAPsF+NTXOkcRL4V1CRL7a/tEjI+S8Ac2hcZ3NwATud1NygD8DBFi90ndS7yk
KCWzgZIqDHNgBnbbx2iTecwOVYlALg8=
=kEaq
-----END PGP SIGNATURE-----

--NDvggmcI2CoJ2jcY--
