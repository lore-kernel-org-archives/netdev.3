Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118788;
	b=szygv1NEjGFSFay++DFQb49/TB3/QTUrhXL9elI9TqrJr9hFLyjM2NacDjwHIfyOEjAW
	 /cpzW0eNQZYNArFHEQD/amnN91XTPVIz3jwjF+PSoyWXkkpLtA4q6up45mdt0cLsGy6gl
	 1N3FPNXbAWpkcOMdDky5qoX1gspB5U6wD2COyAbtk5cDU/1wqykbT4e+kmTYCF4yJ0DPm
	 9CM4CFc/8MjjoW2abO4dduWasgNdg86kwKztHN/WNqAXKsenIYWQZZhkAT3QdEJgklGo1
	 Sb20ceolujGU8Fx1n3+d4iiL7wnr/L0O2wV+hF1SRzOB8wEqQDLVprBqAeL103ix5HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118788;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=TbMT5lghyaS7KxQgJ+MM/CluoulGShAxSFb3s558JYY=;
	b=lMw1xhm1eXEuzEwtSJkbNX0O4rVLH79pBuVezMSAU1Jbl/5MEUwjisqY7hqPi/vY5yhb
	 lF9zZWmgFy0NLnncrpFpG6dSDjM3EMh035ayHkSR0EH7x7n2ti6oqr6zTg96jfluqkAg8
	 fy82+Z0IXw/MrThgYJNSizZpQhqDpcbSIxk2tiX/erAdtdWH6L2P/oMGKdKsMU1/EvuRR
	 dDJMRNrwhA+HYq/ey7jpJOCev/BeTAqQbJBQiLC/TQsCzWe9AVDYEYtdONK9WPzIahi7m
	 2I8A3rEUCzcHbUMdYPZHwzaGEEFwEWrA447dAf/ZwjEFVXQXGRyPxxHmhe4r5S7iRiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=obR0omlz;
	arc=none smtp.remote-ip=185.70.43.97
Received: from mail-4397.protonmail.ch (mail-4397.protonmail.ch [185.70.43.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DABC606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 16:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DABC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=obR0omlz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793118785; x=1793377985;
	bh=TbMT5lghyaS7KxQgJ+MM/CluoulGShAxSFb3s558JYY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=obR0omlz+RH9skUK/AijjQJ0MbxcBbLaq7bLBd+ZpUKNrs6DZIiO03GL5wtCPo4tU
	 oxLSsRs6PHG8SP/+utakZfh3tB6mub8qUPGxwgV/IpqiRTGtsAFyWH/w6biugAASJL
	 3oRf38MGoR6/+0DToGYWTq/JQckkQg99rkiqXbE+knIq5yKQxZmsMrcJ/PtYNi4whL
	 mGSW+uToCK9TQO0TECEevVoO/rADbQ1Qm7wx4E7bXCKHanRLimHQngryr1pCy5hU5Z
	 FS+z6Av0bvsU+H9mKg4N9ixa/kk3bNu4VLmVofYZWHIBWPZTiGMul+YrhgIkRBEgGD
	 idF/xJ5XQGSQQ==
Date: Tue, 27 Oct 2026 16:32:59 +0000
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
From: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] igc: return XSK frame copies on XDP_TX failure
Message-ID: <R7FJ9H2Yqq7aJ5dcgVzcIZN-iI5qNsSVTCHlGTVoz9-HMbzAcMqJ6qCtNLlpjc6DATjNq67fgeC6paxLm4r5hBf4s85vmMOlLqB8MbAFTr0=@1g4.org>
In-Reply-To: <auBehtniOJTRGfaD@boxer>
References: <20261023141317.3904442-1-p@1g4.org> <at+yluh1NVm78gn6@boxer> <HTx28-b95D5R6LIxwQGHksxNXb6wWbEOp6IGCfRU51shEKudZgRxqFylE-Ngqd3ufeFJGlo5VccF1yXfAVeWQlqpNoSMp5oxS8tlJNxH4h0=@1g4.org> <auBehtniOJTRGfaD@boxer>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 31b7716a514270b0b4fbc73d35c670e646ea2b41
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





On Tuesday, October 27th, 2026 at 3:19 AM, Maciej Fijalkowski <maciej.fijal=
kowski@intel.com> wrote:

> On Mon, Oct 26, 2026 at 10:18:03PM +0000, Paul Moses wrote:
> > On Monday, October 26th, 2026 at 3:07 PM, Maciej Fijalkowski <maciej.fi=
jalkowski@intel.com> wrote:
> >
> > > On Fri, Oct 23, 2026 at 02:13:42PM +0000, Paul Moses wrote:
> > > > Converting an XSK buffer to an XDP frame allocates a page and retur=
ns
> > > > the original buffer to its pool. If the TX ring is full or DMA mapp=
ing
> > > > fails, igc_xdp_xmit_back() returns an error without freeing the cop=
y.
> > > > The RX cleaner cannot release it, so the page leaks.
> > > >
> > > > Return the copied frame on TX failure. Save the RX memory type befo=
re
> > > > conversion so native frames remain RX-owned on failure.
> > > >
> > > > Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Paul Moses <p@1g4.org>
> > > > ---
> > > > Tested on Intel I225-V with baseline and patched kernels. Physical
> > > > pause-frame backpressure caused 46 leaked copies on the baseline.
> > > > With the fix, all 72 rejected copies were returned once and freed,
> > > > and all 192 copies were accounted for.
> > > >
> > > >  drivers/net/ethernet/intel/igc/igc_main.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/ne=
t/ethernet/intel/igc/igc_main.c
> > > > index 1fb5f3cbe93c..39263fd04aa9 100644
> > > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > > @@ -2487,6 +2487,7 @@ struct igc_ring *igc_get_tx_ring(struct igc_a=
dapter *adapter, int cpu)
> > > >
> > > >  static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct x=
dp_buff *xdp)
> > > >  {
> > > > +=09enum xdp_mem_type mem_type =3D xdp->rxq->mem.type;
> > >
> > > small nit is we require a concept called RCT (reverse christmas tree)
> > > which makes you to order variable declarations from longest line to
> > > shortest.
> > >
> > > >  =09struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
> > > >  =09int cpu =3D smp_processor_id();
> > > >  =09struct netdev_queue *nq;
> > > > @@ -2504,6 +2505,10 @@ static int igc_xdp_xmit_back(struct igc_adap=
ter *adapter, struct xdp_buff *xdp)
> > > >  =09txq_trans_cond_update(nq);
> > > >  =09res =3D igc_xdp_init_tx_descriptor(ring, xdpf);
> > > >  =09__netif_tx_unlock(nq);
> > > > +
> > > > +=09if (res && mem_type =3D=3D MEM_TYPE_XSK_BUFF_POOL)
> > > > +=09=09xdp_return_frame(xdpf);
> > >
> > > Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > >
> > > > +
> > > >  =09return res;
> > > >  }
> > > >
> > > > --
> > > > 2.56.GIT
> > > >
> > > >
> > > >
> > >
> >
> > Never know what to do in these cases, order matters here, so
> > do I touch more lines to move the assignment down below?
>=20
> =09struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
> +=09enum xdp_mem_type mem_type =3D xdp->rxq->mem.type;
> =09int cpu =3D smp_processor_id();
> =09struct netdev_queue *nq;
>=20
> this would satisfy the RCT rule.
>=20

Ok I'll send soon.
