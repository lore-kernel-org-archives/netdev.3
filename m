Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DE841F349
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387572; cv=none; b=onYLl8GzSpimfp3vokU1zZbG7pnOXHogLysD9aRTHoFpjo2+ckjHk42/RZky6MEfPY4kbQfPnhT1ustCTO60tZV8SptVa4J7DfZnLwm7M95EMz9re+XJc52Q2AumZ0jToZ5MskHSsHBMKLj4w8y+0/UgSr7XEaEoESwUGwYNR0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387572; c=relaxed/simple;
	bh=nYpn4Q6YlM4eXb+1AFtFRHR1fHKOjKIOh2p3Svcwrbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XI/eu7a4jauYapvV7f1wzf2dpt0/L6j1Acjt/0R7SBOxqHiOikTloUkVlSBOXiO0rSkfTKPLFz68A359vbgLb04u0y3ptQT9H0vdE3AL9rVCpzZ3jcZ3ZG6RxobGphceGpLkUvQi3xFoy3m69w/3egbA+acZ5oed4HiQI0SLAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8tJ7qpu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8tJ7qpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A1D1F000E9;
	Wed,  2 Sep 2026 22:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387568;
	bh=lEioVwdoyefrd8s9LY1ucPtPBkwOre20r5RlJF5Ydps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P8tJ7qpu10YQnhWPtilf7sM7eVKILK4PpC+emKdqXcRQ6mUvfovjWJVurRndYSGDV
	 VBFFN8wfyMQ8wwxB3dMskfTsh1es7xtyPEYAc0CNSGa+xwht2sffl51qfry1qAGZ6I
	 tgN1TOrGsYOvAYzMBxfR9PeTuISGO5gA+1RGYGEHYe1V4P7IZ1UMG2ZrsPksChBENC
	 994Tjn2k7F/Y0G76RqODwgfhcQ3DdehAHQMjYGL7K7ExzlNhxMoPbaD7kKncpH/jRo
	 NJiXZxtpOSZBuXEfCGVO6rAPh76nv+5IvcLfUwyZkg0jYQ+MPVbGeIuDC2yMOuvtxI
	 TEn2jF6R8lbWw==
Date: Thu, 3 Sep 2026 00:19:25 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [net] net: airoha: enable RX_DONE interrupt for RX queue 31
Message-ID: <apig7UCTvWjKmzQB@lore-desk>
References: <20260830-airoha-rxdone-rxq31-v1-1-830a91503f2f@kernel.org>
 <178836297161.3394541.17329602881799623239@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gUSQjzkNCxpYl8at"
Content-Disposition: inline
In-Reply-To: <178836297161.3394541.17329602881799623239@kernel.org>

--gUSQjzkNCxpYl8at
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>=20
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>=20
> - [High] Incomplete fix: the patch only adds BIT(31) to
>   RX_IRQ1_BANK_PIN_MASK, so the exact defect the commit message=E2=80=A6
>=20
> --
>=20
> net: airoha: enable RX_DONE interrupt for RX queue 31
>=20
> This adds BIT(31) to RX_IRQ1_BANK_PIN_MASK so that RX queue 31's RX_DONE
> interrupt is routed to IRQ bank 1.  The stated goal is that the queue gets
> drained and its buffers returned to the page pool.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/eth=
ernet/airoha/airoha_eth.h
> > index fa9a8edce22f..8277c1c87bb3 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > @@ -538,7 +538,7 @@ struct airoha_wdma_info {
> > =20
> >  /* RX queue to IRQ mapping: BIT(q) in IRQ(n) */
> >  #define RX_IRQ0_BANK_PIN_MASK			0x839f
> > -#define RX_IRQ1_BANK_PIN_MASK			0x7fe00000
> > +#define RX_IRQ1_BANK_PIN_MASK			0xffe00000
> >  #define RX_IRQ2_BANK_PIN_MASK			0x20
> >  #define RX_IRQ3_BANK_PIN_MASK			0x40
>=20
> [Severity: High]
> Does this leave the same problem in place for the other RX rings?  After =
the
> change the union of the four bank masks is:
>=20
>   0x839f | 0xffe00000 | 0x20 | 0x40 =3D 0xffe083ff
>=20
> so rings 0-9, 15 and 21-31 are covered, but bits 10-14 and 16-20 are still
> clear in every bank mask.

Here I wanted just to align to the vendor sdk and enable rx queues 24-31 (31
was missing) in preparation for HW GRO support. The other rx queues are
out-of-scope.

Regards,
Lorenzo

>=20
> Those rings are still allocated and filled, because airoha_qdma_init_rx()=
 in
> drivers/net/ethernet/airoha/airoha_eth.c gates only on RX_DONE_INT_MASK:
>=20
> 	if (!(RX_DONE_INT_MASK & BIT(i))) {
> 		/* rx-queue not binded to irq */
> 		continue;
> 	}
>=20
> 	err =3D airoha_qdma_init_rx_queue(&qdma->q_rx[i], qdma,
> 					RX_DSCP_NUM(i));
>=20
> and in drivers/net/ethernet/airoha/airoha_regs.h RX_DONE_INT_MASK expands=
 to
> 0xffffffff:
>=20
> 	#define RX_DONE_HIGH_OFFSET	fls(RX_DONE_HIGH_INT_MASK)
> 	#define RX_DONE_INT_MASK	\
> 		((RX_DONE_HIGH_INT_MASK << RX_DONE_HIGH_OFFSET) | RX_DONE_LOW_INT_MASK)
>=20
> with RX_DONE_HIGH_INT_MASK and RX_DONE_LOW_INT_MASK both 0xffff.  So the
> "rx-queue not binded to irq" comment filters nothing and all 32 rings get
> programmed into hardware and filled from the page pool.
>=20
> Meanwhile airoha_qdma_hw_init() only unmasks RX_DONE according to the pin
> masks:
>=20
> 	airoha_qdma_irq_enable(&qdma->irq_banks[i], QDMA_INT_REG_IDX1,
> 			       INT_RX1_MASK(RX_IRQ_BANK_PIN_MASK(i)));
> 	airoha_qdma_irq_enable(&qdma->irq_banks[i], QDMA_INT_REG_IDX2,
> 			       INT_RX2_MASK(RX_IRQ_BANK_PIN_MASK(i)));
>=20
> and airoha_qdma_rx_napi_poll() re-arms through the same mask:
>=20
> 	for (i =3D 0; i < ARRAY_SIZE(qdma->irq_banks); i++) {
> 		if (!(BIT(qid) & RX_IRQ_BANK_PIN_MASK(i)))
> 			continue;
>=20
> Since rx_intr_mask in airoha_irq_handler() comes from the per-bank irqmas=
k,
> rings 10-14 and 16-20 are never passed to napi_schedule(), so
> airoha_qdma_rx_process() never runs for them and their buffers stay pinned
> from probe until airoha_qdma_cleanup_rx_queue().  Is that not exactly the
> behaviour the commit message describes as a bug for ring 31?
>=20
> Ring 11 stands out here, since RX_DSCP_NUM() gives it 128 descriptors, the
> same as rings 2 and 15 which are mapped to bank 0:
>=20
> 	#define RX_DSCP_NUM(_n)			\
> 		((_n) =3D=3D  2 ? 128 :		\
> 		 (_n) =3D=3D 11 ? 128 :		\
> 		 (_n) =3D=3D 15 ? 128 :		\
> 		 (_n) =3D=3D  0 ? 1024 : 16)
>=20
> while BIT(11) is absent from all pin masks, and the ring this patch enabl=
es
> (31) uses the default 16 descriptors.
>=20
> Would it make sense to give airoha_qdma_init_rx() and the pin masks a sin=
gle
> source of truth, either by having the masks cover every ring init_rx arms=
, or
> by having init_rx key off RX_IRQ_BANK_PIN_MASK()?
>=20
> Alternatively, if the sparse mapping is deliberate and those rings are si=
mply
> unused by the hardware configuration, does the justification given for
> BIT(31) still hold?
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260830-airoha-rxdone-rxq31-v1-1-830a91503f2f%40kernel.org

--gUSQjzkNCxpYl8at
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapig7QAKCRA6cBh0uS2t
rB64AP9t5OQ0jCXdBGQbh0vfOVWE0Y2Xj4khPZ+DK70eX2CfHQD+P1M+aRumfnx3
CuT196vj3T966tdxwulRVQsXY/LWNAc=
=3W28
-----END PGP SIGNATURE-----

--gUSQjzkNCxpYl8at--
