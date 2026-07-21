Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C264434E30
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626030; cv=none; b=buKHs/u8YSX68JjGT0lkaJFRYordFhN0NuCYAR0j1MnE9mboL73ZZggwL8q9oR4lGMuqDakWhPRBGa3zRVylUxW3buAJjg+ZmmNY8t7FYvEvadR5mCpK9fRWkCIeCMYSNIUh0Vj5NhTFr7NZp5K3M746bvfp+Z1qoh7BbxN3te8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626030; c=relaxed/simple;
	bh=fOC5Kls/BLdBgvBjUCIPpx/PjhvmfUJqwQ+fJfYbITw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKVJMuzoM50XFxU9WXfHK7R4vFN0tkSXwe559UkpcFoUgU/k3Q5jUXjA5UStN1nHkPhkDicepj982nl4RmrJVz8l37/fYUfua4RCkW7PakHgc4rsPt7Lg9+UPMErVv9k/IbpdYQcd8NZg7CrBUuQMj2PPlD5ib1Ix9+hoXUO0zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WggJLxA4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WggJLxA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E431F000E9;
	Tue, 21 Jul 2026 09:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784626028;
	bh=g2QO9Gcwg7klcjvR8NI82eIGPSP5QACIwc+p9XrZoWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WggJLxA4QzSswWIq+HKeTRpwcg5HgolQXD+uYIT1+lEju0hA76PjChEnyKCGL2VWe
	 XCT1eXt8k6zU5G5e8a6/qbXc2XKJ95D67fLR+1SIFBRqcQk2FiiqU1VCCPZoDmb/rz
	 iEcoRxfQAi51yWd5MF1T7Jd71R0mUybhJHKfn2S/EBv3WbS4a1O5Mji9yJdHaG1Mgg
	 TwOOFPPVpVN7TeOccmURFc9Z5jUeoJLmC7l+P8IBldQEtYU20AlsbvcikdQocPLEE2
	 vrSSA6Q+u3myxyicJIrnIYVh7BJPUEt951nv6eQbg1lwnc8+1SlkHVuiWGCRzUoWH+
	 REQEl93FFPsig==
Date: Tue, 21 Jul 2026 11:27:06 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v9 2/3] net: airoha: fix ETS QoS stats counter
 underflow and cross-channel corruption
Message-ID: <al87am5-OScErxLn@lore-desk>
References: <20260721-airoha-ethtool-priv_flags-v9-0-9c15d8b71a56@kernel.org>
 <20260721-airoha-ethtool-priv_flags-v9-2-9c15d8b71a56@kernel.org>
 <4f875005-e07c-4366-af8d-b7173d2d3b77@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kw43FT3PQHLFXCdE"
Content-Disposition: inline
In-Reply-To: <4f875005-e07c-4366-af8d-b7173d2d3b77@intel.com>

--Kw43FT3PQHLFXCdE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 7/20/2026 3:03 PM, Lorenzo Bianconi wrote:
> > airoha_qdma_get_tx_ets_stats() has two bugs:
> > - The hardware counters read via airoha_qdma_rr() are 32-bit values
> >   but are stored in u64 locals and subtracted from u64 baselines. When
> >   a 32-bit hardware counter wraps around, the subtraction produces a
> >   large underflow value passed to _bstats_update().
>=20
> This issue would only be a problem during rollover, which depending on
> how fast the counts increment may not be a big problem. I could see this
> not being worth going to net since it could be rare enough that it isn't
> considered a widespread issue...
>=20
> > - The baseline counters (cpu_tx_packets, fwd_tx_packets) are stored as
> >   single per-device fields, but airoha_qdma_get_tx_ets_stats() is
> >   called with different channel values (0-3). Each call reads a
> >   different channel's hardware counter but overwrites the same
> >   baseline, corrupting the delta computation for other channels.
> >=20
>=20
> However, this issue seems like its going to cause a problem every time
> you read because any time you use a mix of channels you will get
> corrupted values?

Hi Jacob,

I agree this is a real bug (and it needs to be fixed). However, the real
use-case is having a single channel per net_device (a single HTB offloaded
qdisc) and multiple hw queues (connected to the ETS offloaded classes).
In this scenario we do not trigger this issue.

>=20
> > Fix both by:
> > - Narrowing the counter locals and baselines to u32 so that 32-bit
> >   unsigned subtraction handles wrap-around naturally.
> > - Grouping the baselines into a per-channel qos_stats array so each
> >   channel tracks its own previous counter value independently.
> > - Splitting the delta addition into two statements so the first u32
> >   delta is widened to u64 on assignment and the second is added in
> >   u64 arithmetic, preventing overflow when both deltas are large.
> >=20
> > Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
>=20
> This targets a commit which merged in v6.14, but the patch is part of a
> series aimed at net-next. Could you explain why this shouldn't be
> separated out and put as a fix in net? It seems pretty obvious that
> users can easily reproduce problems by requesting stats from each
> channel? Or is this not really possible to trigger from userspace until
> patch 3/3?

For the reason described above and to avoid any possible conflicts with pat=
ch
3/3 I decided to add this patch here (adding the proper Fixes tag for the
backport) but if you prefer I can remove patch 2/3 from this series and send
it to net. What do you prefer?

Regards,
Lorenzo

>=20
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c | 18 +++++++++++-------
> >  drivers/net/ethernet/airoha/airoha_eth.h |  7 ++++---
> >  2 files changed, 15 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 41c1a0ffbdd8..aaf2a4717d12 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -2482,16 +2482,20 @@ static int airoha_qdma_get_tx_ets_stats(struct =
net_device *netdev, int channel,
> >  {
> >  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> >  	struct airoha_qdma *qdma =3D dev->qdma;
> > +	u32 cpu_tx_packets, fwd_tx_packets;
> > +	u64 tx_packets;
> > =20
> > -	u64 cpu_tx_packets =3D airoha_qdma_rr(qdma, REG_CNTR_VAL(channel << 1=
));
> > -	u64 fwd_tx_packets =3D airoha_qdma_rr(qdma,
> > -					    REG_CNTR_VAL((channel << 1) + 1));
> > -	u64 tx_packets =3D (cpu_tx_packets - dev->cpu_tx_packets) +
> > -			 (fwd_tx_packets - dev->fwd_tx_packets);
> > +	cpu_tx_packets =3D airoha_qdma_rr(qdma, REG_CNTR_VAL(channel << 1));
> > +	fwd_tx_packets =3D airoha_qdma_rr(qdma,
> > +					REG_CNTR_VAL((channel << 1) + 1));
> > +	tx_packets =3D (u32)(cpu_tx_packets -
> > +			   dev->qos_stats[channel].cpu_tx_packets);
> > +	tx_packets +=3D (u32)(fwd_tx_packets -
> > +			    dev->qos_stats[channel].fwd_tx_packets);
> > =20
> >  	_bstats_update(opt->stats.bstats, 0, tx_packets);
> > -	dev->cpu_tx_packets =3D cpu_tx_packets;
> > -	dev->fwd_tx_packets =3D fwd_tx_packets;
> > +	dev->qos_stats[channel].cpu_tx_packets =3D cpu_tx_packets;
> > +	dev->qos_stats[channel].fwd_tx_packets =3D fwd_tx_packets;
> > =20
> >  	return 0;
> >  }
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/eth=
ernet/airoha/airoha_eth.h
> > index bf1c249255bd..bf44be9f0954 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > @@ -553,9 +553,10 @@ struct airoha_gdm_dev {
> >  	struct airoha_eth *eth;
> > =20
> >  	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
> > -	/* qos stats counters */
> > -	u64 cpu_tx_packets;
> > -	u64 fwd_tx_packets;
> > +	struct {
> > +		u32 cpu_tx_packets;
> > +		u32 fwd_tx_packets;
> > +	} qos_stats[AIROHA_NUM_QOS_CHANNELS];
> > =20
> >  	u32 flags;
> >  	int nbq;
> >=20
>=20

--Kw43FT3PQHLFXCdE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCal87agAKCRA6cBh0uS2t
rCd0AQDc2lEHGNWduh9eYsxNxeCYsIvmowkTAtPBBREEmcw6JwEA4BIM1E9ui0UN
sr0Ei83KIu326VPsWSC28VxsxcXK9Qg=
=4TOp
-----END PGP SIGNATURE-----

--Kw43FT3PQHLFXCdE--
