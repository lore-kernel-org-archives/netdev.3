Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D10C4A2628
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438938; cv=none; b=c8defM0Bn2oSBbTj4uWE3f9SQ0EDXgnM2HPeET8pIIYX0c0hQA5IcXyiWEGvhVRXUqi7g94f+vochP88DotTxrKC6ZTi6JjcreKVKPQX7DKAz6oUyjlJp2btv/3nheJl5LQ8da29y4PhGhNtoJQyEYiL/hKPs6/ND5OizvIaY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438938; c=relaxed/simple;
	bh=HyBpkWtaUs3sABCXegt/l+QUd8TqSUvAAzApqOQ3+QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VClNWdsBwaqT+oYKoZHmPDLzEZBwD9tutkNEyU1l2mDGvbbM5R2ll7OsjEKAXpEtF2GLYp73cHvxQFQF1HwwqRMVOt4ud+3XAGFOAGBBC+2yiUiookIVBJAUe9N2M0NezkeJijL18Ald0mlAa9pG0Pamiat6QN1OiFTvMxDtxO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKp5TvjN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKp5TvjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F701F000E9;
	Thu,  3 Sep 2026 12:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788438936;
	bh=1XdyeznFhql9EgOoZF6ZIKOla/L9yi5hCmaRt5yqyeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mKp5TvjNoeGSv27DDg/j6XMUIt65JwtrMSbNG2SS9Jy1NEivmw3yqT/HHLqPv/8YW
	 v+nBzQ/MugMFCPRU2WkuyxSnx0qsZ8N4nEOHRTCkPZWxk/f/5TEQUJLeV7a/qi0xo8
	 waloM/Y6OlNim4+DDqtiX88n9MDliqjzFZbvywEdMhaKWkdIhaLKBEzpSyerAXZKJr
	 0vx1+nnOpjJJGfZUlLArp+g76nw7e34WwZzbDfH0jsQXt/cQbEuoQZwzqjWLGEvtQV
	 MIBY9ETaoI77bLkikG25WrW8CLajC8RdtBhU2df1sYJUjzxXwL+aRUeNWh28VcqXfY
	 8QZQuhcbl33sQ==
Date: Thu, 3 Sep 2026 14:35:34 +0200
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
Message-ID: <aplpllPidmCjhSmA@lore-desk>
References: <20260831-airoha-eth-lro-v5-1-6b0f50401121@kernel.org>
 <fce0ee5a-476a-4867-9dd2-08e55993bd90@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EF3/+5Ej5nc/qA39"
Content-Disposition: inline
In-Reply-To: <fce0ee5a-476a-4867-9dd2-08e55993bd90@redhat.com>

--EF3/+5Ej5nc/qA39
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 8/31/26 8:34 AM, Lorenzo Bianconi wrote:
> > Add hardware GRO offload support to the airoha_eth driver, leveraging
> > the EN7581/AN7583 SoC's 8 dedicated LRO hardware queues mapped to RX
> > queues 24-31. HW GRO offloading does not support Scatter-Gather (SG) so
> > it is required to increase the page_pool allocation order to 2 for RX
> > queues 24-31 (LRO queues).
> > Since HW GRO is configured per-QDMA and shared across all devices using
> > it, HW GRO is mutually exclusive with multiple devices bound to the
> > same QDMA block. Call airoha_update_netdev_features() in
> > airoha_dev_set_qdma() so that NETIF_F_GRO_HW availability is re-evaluat=
ed
> > whenever the QDMA user count changes (device registration and runtime Q=
DMA
> > migration).
> > Set CHECKSUM_PARTIAL with pseudo-header checksum on aggregated packets
> > so that L3-forwarded traffic is correctly handled by the GSO/TSO path
> > on the egress device.
> > The HW does not report the per-segment MSS (msg3[31:16] only reports
> > the max aggregated size), so the gso_size of an aggregated packet is
> > just an approximation computed as DIV_ROUND_UP(data_len, agg_count).
>=20
> What is the <max aggregated size> exactly? I read it as the maximum size
> of the aggregated segments, am I correct?

Hi Paolo,

with "max aggregated size" I refer to the length of the aggregated TCP
packet (composed by multiple segments). This value is reported via
QDMA_DESC_LEN_MASK field in the DMA descriptor. Moreover, the hw reports
the exact number of the aggregated segments via QDMA_ETH_RXMSG_AGG_COUNT_MA=
SK
field.

>=20
> Also any more details on how the aggregation engine works? i.e. can it
> aggregate "random" segment sizes (i.e. 200 - 300 - 400) or does it
> respect HW_GRO layout? (i.e. all segments except the last one must have
> equal size, the can be smaller).

The hw engine, for each LRO queue, is configured with:

- CDM_LRO_AGG_NUM_MASK: max number of segments for each aggregated TCP pack=
et
                        (64 in the current configuration).
- CDM_LRO_AGG_SIZE_MASK: max size of the aggregated TCP packet (composed by
                         multiple segments). 16KB in the current configurat=
ion.
- CDM_LRO_AGG_TIME_MASK: max timeout to compose the aggregated TCP packet.

In order to validate the scenario, I run the following test:

TCP client:
------------
- disable TSO/GSO
- set MSS to 256 bytes (iperf3 -M option)

I can see multiple 310 bytes TCP segments on the wire

TCP server: (where rx-gro-hw is enabled):
-------------------------------------------
- the engine aggregates ~64 segments in a ~16Kbyes TCP packet

  so gso_size ~ 16KB / 64 ~ 256B

I guess this would be the behaviour even if the original packets
have different size (not sure if it is a real use-case).

Regards,
Lorenzo

>=20
> In the 'good' scenario, than by definition gso_size =3D=3D <max aggregated
> size> - <total hdr len>, and you are better off computing the gso_size
> from <max aggregated size>.
>=20
> Otherwise I think we can't call this HW_GRO - even if it would be more
> convenient for the driver.
>=20
> /P
>=20

--EF3/+5Ej5nc/qA39
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaplplgAKCRA6cBh0uS2t
rB0ZAP48zGsaOahQ/7/+9gWRoFOHmwQovjU85XOK+X6Ze2iYSwEA7uS7OT9h3/au
H2hDKAHz6p1VAg1AFLFT0LQdDqVX2gQ=
=gEmT
-----END PGP SIGNATURE-----

--EF3/+5Ej5nc/qA39--
