Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793053089;
	b=Q56hO2SWKGipyi8xefXmFhiyuHR2/u0nNZiAEu8sUVcEytgPbGpXkI1OJ7eST27VFlcq
	 L1rthywvWPqUMOXK54tATbMYZCUCNnd8rxZ7N5qk/7Tc1FowCdtlomPEm/pYY7iFhCvUE
	 Vl/dCdXmNkESlYkkPoNZPxLBfUz1IuVQb0lo4ZwE7OtkjMDG/H2bk4Ajh5gQBi6OILjfg
	 R/0f052qkS8/oejR4suGS+yGU+iHgsDCQA+XJUV5C9yq1R+qe1EYehKbrUrRDMpWSIu2h
	 pxAMicKAUjSFNL1Q3zC2cwOHmyQra6XBdeKwzYkDDIoiBCiny7mIv+oQpF8QhNbAvLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793053089;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=j7+Wt+6fz4ZskekKzx7aEXbq6GLlj+ejwaiGk0UsRoA=;
	b=L1+mlS2TmBx6mtwlEUGxkH4zeqA19XKRS74yrWisFq9NSj3jSfosqmgO/1rz/80euPiA
	 jc2vGpkCaAEeqoXPPvoRysAtYxxoGdEBSG5SOot5njiBk3SaI2T/vkm5+byulxF7glZ4l
	 jBzG2KOq62oaemNEs7ZCP5AHG9OKYU0hQcuh/QJ2UzASqJgPwKUxwQeTipvqbCEfCxly+
	 bujzjCvnN1ec9C4eUeq9mMVenyejYzfJfA7WEum5tRqtc5HarAsCjeblm9xNfDMbD+5+S
	 6T9m3lTEOH32In1Ddfe+BOuu1APE9zi9wc1OSbxpWOwOA2pRBO/EJrlORcQF87CXC/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=Khusp+FG;
	arc=none smtp.remote-ip=109.224.244.118
Received: from mail-244118.protonmail.ch (mail-244118.protonmail.ch [109.224.244.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A67B606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A67B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=Khusp+FG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793053086; x=1793312286;
	bh=j7+Wt+6fz4ZskekKzx7aEXbq6GLlj+ejwaiGk0UsRoA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Khusp+FGEK0eE82NLaoHg57wLMIgQor91mCHO5TVPujRbYqnyRGmBhwAsaRVbSx2e
	 Mj3Jf7ZLpCv+2R9lnPG71OgDtmOp+5OQ5oErxk2gLsLKVIKX0XHuE2Hp4v/wMSHXQZ
	 wkX3ZVl7Lsm6OY80JBy4r4M4gLtveY4YJA/Pp1tLPesjkGXSDKUlAmj7Brnq7qjOq8
	 9AVSGq5vmvzuV3n8H0ga7wgNQdXTAwntFD0Z1qmeJNZUmsE3m02B+GqzYvYAGxc1TP
	 932kUEEsXrHliKCRg1tcJvWLBwe1lTWhZcVzxHNH50C9X4/AAHz+ga9avpzx1l5dqm
	 /Qm7M6DJQOh0w==
Date: Mon, 26 Oct 2026 22:18:03 +0000
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
From: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] igc: return XSK frame copies on XDP_TX failure
Message-ID: <HTx28-b95D5R6LIxwQGHksxNXb6wWbEOp6IGCfRU51shEKudZgRxqFylE-Ngqd3ufeFJGlo5VccF1yXfAVeWQlqpNoSMp5oxS8tlJNxH4h0=@1g4.org>
In-Reply-To: <at+yluh1NVm78gn6@boxer>
References: <20261023141317.3904442-1-p@1g4.org> <at+yluh1NVm78gn6@boxer>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: e0cc8acc5183641e5ff64bc4b80c7d5a4a7e0b5a
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, October 26th, 2026 at 3:07 PM, Maciej Fijalkowski <maciej.fijalk=
owski@intel.com> wrote:

> On Fri, Oct 23, 2026 at 02:13:42PM +0000, Paul Moses wrote:
> > Converting an XSK buffer to an XDP frame allocates a page and returns
> > the original buffer to its pool. If the TX ring is full or DMA mapping
> > fails, igc_xdp_xmit_back() returns an error without freeing the copy.
> > The RX cleaner cannot release it, so the page leaks.
> >
> > Return the copied frame on TX failure. Save the RX memory type before
> > conversion so native frames remain RX-owned on failure.
> >
> > Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Moses <p@1g4.org>
> > ---
> > Tested on Intel I225-V with baseline and patched kernels. Physical
> > pause-frame backpressure caused 46 leaked copies on the baseline.
> > With the fix, all 72 rejected copies were returned once and freed,
> > and all 192 copies were accounted for.
> >
> >  drivers/net/ethernet/intel/igc/igc_main.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/et=
hernet/intel/igc/igc_main.c
> > index 1fb5f3cbe93c..39263fd04aa9 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -2487,6 +2487,7 @@ struct igc_ring *igc_get_tx_ring(struct igc_adapt=
er *adapter, int cpu)
> >
> >  static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_b=
uff *xdp)
> >  {
> > +=09enum xdp_mem_type mem_type =3D xdp->rxq->mem.type;
>=20
> small nit is we require a concept called RCT (reverse christmas tree)
> which makes you to order variable declarations from longest line to
> shortest.
>=20
> >  =09struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
> >  =09int cpu =3D smp_processor_id();
> >  =09struct netdev_queue *nq;
> > @@ -2504,6 +2505,10 @@ static int igc_xdp_xmit_back(struct igc_adapter =
*adapter, struct xdp_buff *xdp)
> >  =09txq_trans_cond_update(nq);
> >  =09res =3D igc_xdp_init_tx_descriptor(ring, xdpf);
> >  =09__netif_tx_unlock(nq);
> > +
> > +=09if (res && mem_type =3D=3D MEM_TYPE_XSK_BUFF_POOL)
> > +=09=09xdp_return_frame(xdpf);
>=20
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>=20
> > +
> >  =09return res;
> >  }
> >
> > --
> > 2.56.GIT
> >
> >
> >
>=20

Never know what to do in these cases, order matters here, so
do I touch more lines to move the assignment down below?
