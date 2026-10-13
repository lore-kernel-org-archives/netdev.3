Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBED3822BB
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879441; cv=none; b=bsUyR4nFs8Wx8Q/QAzc7QV0jyY5BRS671/fQPd1cHvep4E4HaZVqnPhVImuWV4de3hG1P/4TaZY3tzBT3cleq/SL2VfDEHKHrrQn2pU256L5FOtGrAOKEuV17BLYthTT85TlMIhseUevICDwOljj22F8G1tkWQNl2ND545oT35o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879441; c=relaxed/simple;
	bh=Td6UJVofWCDnQamk5CY5XGtu81PPv/v89CyEdQyhisQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7s2B2K8GSmf3ZTWl+/4aWyzKB4KzmeMNdhCSUI6mTrYAXXxd89uFz+o/iXBnNQ40yBNgCP1N22LbMf/4gkgF/ZpELgUsMEVzzji8LHf7IxFScx2mUBZMleF9MFbuoWyguRGtj6I3aefpIJ9QfcQq7IhsMURp7xa+rF+jE06oaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TFx4T6s+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CQYHNnkn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TFx4T6s+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CQYHNnkn"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D20mrd302833
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RDFKYb/m924u2VXBFcjCVaMk
	oZJEVndeSzqMZ0nALvQ=; b=TFx4T6s+vG6c2WLyALwPHKSqjTDtCN7fxBIwwo1J
	dU7J6toDY3QwVuwovF2S2kEb/grSQqpfCVP88Pj9VauALz8f5p1qZ9Bxp5osc2ph
	vVnfrKQb6faASfxul4QO1ApJ2kwEWaOGhETfWu2apCrsqyf3TObZqHgWPEOgQLhh
	Jpnfz0jCHN0kyEdJ1+M5FtNGd0ocJ05actKCyR08YPiN3TVfLRzIwpIZ6lq7Eu3K
	/BUuuasFa7IVJtOsSdtNiVQdtMTFTakXpwk2ovJmmd944coP1P693ovg32b8VC40
	5fKQICLfMUU7TMz2R+ZuGa4oQ6HVnMc2/r9FEOVCcyZX1Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98sq9tha-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:17:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93caa0ce0cdso293661985a.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 01:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791879438; x=1792484238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RDFKYb/m924u2VXBFcjCVaMkoZJEVndeSzqMZ0nALvQ=;
        b=CQYHNnknRWc6mXP96GbigsknYH64QD9zCxtA5eFGKVa/Yy0bbLyaCc/rtrpLlgBMu5
         fFml4XiYgTi9M+mgHFJuOWAOCqjH23o467/MhgjSSsew5C9Marr8+w+ja0P0FFQaqvLN
         Y4ZodpKjQK+IDXAdC8zjMymlslQWwge16KsdSr9kPcim3S98I5nzqeEU5XOVr7j0JIz+
         C3+qwMTAhXv02bCahmY3ZA2VSwyl6Mgm6Jte8x05w9hWZViJpcAhG/V2y6LAfBfENkN3
         yIJ5blhK6mx2dIEDQu02tBPA5Uk1bwPGF5A4CbWA1eHXlLq9OM9jimqDPf93DCxhAY9M
         ZZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879438; x=1792484238;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RDFKYb/m924u2VXBFcjCVaMkoZJEVndeSzqMZ0nALvQ=;
        b=Feq9QHdb/eCEcHmmUYWglhr2JG3OIyuMnw9FMOdOMvdtmlBhinfeWUBl6UW1hJEBJi
         dmrcmzw3lm3cVn/dEkZWGf90Lxj5i2f/+zNAX0DsoxSx7ozrCoctnTOmwTMzvqidGp8R
         whfR8+50PWS9QfaIv233A6uWtWKdLVILM7Ije5PRFmT2Jh6MmkbekKs8sGR/C+qm5uhf
         tc8Dvb36UgbrP1SXZZdXMtLsRWSMvTVNfFpuFdKk2ic0H1vk/498t/Nha49cjcYcyDGI
         JTM2GPAdOnzF5JFp8lNoZcLZlsGbyBS1gEajn2iaXOtbY9r36nAUkmM1rvu0zKSAuxp3
         1jjA==
X-Forwarded-Encrypted: i=1; AKwUvByoAacC4VhDoKCmH9ckEQ7jSI/9+9lQK+52jUZtdtrq464dIGL5FvU/aNiG3wSU4n5RB34A7Mc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJj3yt0LRfiwx3iI9kJ7UDL5APaK6o6Lo8gXCjKlZCY7I8C20O
	e8CmRQgZl/i13A7Hwj+xO+bAJTcLusnaBNzvws3EbR4EQRvRDSAc0syUq/KhFFtYQ1Mgg2uvVP9
	IUNomsejLMyA1aDHUb+DQlDjiwg+CdYKaDg7wXEaj4/QZsEqDkfPRkDmhcxk=
X-Gm-Gg: AYBFou1Y29w2PyVHzUfqXU4OIU2N2R3nsBkD0xa1gDB6v6oEUB1hlZPfhzgZkqMc/3y
	0l0r3KOPLkN4oDCqzgn1/WQxheE8DabmQqzEwHVC6Y/ukeGKbo0QbQIra/90hPbRVPxWMDdbFEE
	hEPYGaasbZRQeYdTsjNJXveShjbXPed24G+qEXo6jvqAX6bdxqBEPPIlFLu4mHWITELFN7Oiy1n
	dKV7sp7d1uyA48NOL7yoj0gfcFJ+z8z6dmqvxamjxniMkNYTcvdfHTAYP0tFqum14mtapa/NLPj
	9MHSUZ8WfIjBzHIy8V6BAa0IvsDQzQgnrcDmNR7LHFmZEafAs5ykUJDitbZd9ZyCwhgPK3gNnYi
	GYFDtdcaI8EzC8g==
X-Received: by 2002:a05:620a:199e:b0:93c:5872:ef48 with SMTP id af79cd13be357-93ebd273616mr1824182585a.50.1791879437770;
        Tue, 13 Oct 2026 01:17:17 -0700 (PDT)
X-Received: by 2002:a05:620a:199e:b0:93c:5872:ef48 with SMTP id af79cd13be357-93ebd273616mr1824171385a.50.1791879435209;
        Tue, 13 Oct 2026 01:17:15 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18dcd7dd3sm221979045e9.2.2026.10.13.01.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:17:13 -0700 (PDT)
Date: Tue, 13 Oct 2026 10:17:11 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/4] net: stmmac: drop multi-buffer frames in
 XDP mode
Message-ID: <as3pB16af0_QhNyB@lore-desk>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
 <20261012-stmmac-rx-mb-v6-3-2225050915c1@oss.qualcomm.com>
 <b11af7d5d430dcddcc681484b50ae7e2@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KY7hfcVLGCw62j4b"
Content-Disposition: inline
In-Reply-To: <b11af7d5d430dcddcc681484b50ae7e2@tipi-net.de>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzMiBTYWx0ZWRfX6vR2DkJ0Gf+o
 UDa0Ezy6AdxrILXCu1i/zgoI6p4/HgIqFJGu27F6B2v2Nu8tIbcdlbazLYotkQii41ic9gLFcNb
 dfmb3nwQYq6hpBye5lGTAX17Y42k4agQa2VousXvt7Y/YcXWtIiPsfn0J/2DDrxbVMy6jay6eKQ
 eoLK6bk6SRzO9/BtTAkICnS+xUGESh8kogBRbbl2zLIBfmmbyrevYEC+Ic3nlp38F9YPwEXmBrf
 Dee/BUNTiHRJc4EwcAVVXifaPpkkOyExiadngBJv5wG7+7VL4djS99bIijMzDwwMZnplFTho2lW
 I6zwNC9ow12M+BUCJOqxnf/ZFJO6vb26iKkDHfAPs8WyCkSL/KaJOajXSp3ajizTm7UCn5E4rBC
 V4865F9j3uy/ATntSeTU4ZqLaW9gsBW0NU/lcNt8zcOIIQhMzw44wtXsMEO6OVFe2efk1HuKFaB
 d4HSbK4I/Q0EwTu2uuA==
X-Authority-Analysis: v=2.4 cv=JN+uIMKb c=1 sm=1 tr=0 ts=6acde90e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=7PNn2skMB5_rZfgV75sA:9 a=CjuIK1q_8ugA:10 a=nfflnHfShdqUK23c0sYA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzMiBTYWx0ZWRfX1yPIjsd8WL0T
 tERL0qxWty5OpDRVlg912g9xHJ4q2qwT4zsIxh6t5FvcCA+theum6KQt94Pn1Za/qcOLAQZLUZZ
 vYJ9T7XehWebL22pmIkP4e6XTXD8zXI=
X-Proofpoint-ORIG-GUID: rLtP2Wyvlod4p37DyO8C2GG73gQelGpG
X-Proofpoint-GUID: rLtP2Wyvlod4p37DyO8C2GG73gQelGpG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130032

--KY7hfcVLGCw62j4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 12, Nicolai Buchwitz wrote:
> Hi Lorenzo
>=20
> On 12.10.2026 18:44, Lorenzo Bianconi wrote:
> > stmmac_rx() runs the XDP program once per descriptor buffer and uses
> > skb =3D=3D NULL as the only marker for the start of a frame. A frame la=
rger
> > than one buffer is split by the hardware across several descriptors;
> > GMAC4 enables jumbo frames unconditionally (GMAC_CONFIG_JE in
> > GMAC_CORE_INIT), so an on-link peer can deliver such a frame even when
> > the interface MTU is left at 1500.
> >=20
> > When an XDP verdict ends a non-last descriptor, skb is cleared and the
> > next descriptor of the same hardware frame is parsed as a new frame.
> > For XDP_CONSUMED this happens via read_again with len preserved, so
> > stmmac_rx_buf1_len() then returns min(dma_buf_sz, plen - len) for the
> > last descriptor, which can be as small as 0-3 bytes. buf1_len -=3D
> > ETH_FCS_LEN underflows and xdp_prepare_buff() puts data_end far past
> > data; on XDP_PASS this produces an skb whose length is close to 4G that
> > reaches the network stack (skb->tail and skb->len are 32-bit and wrap
> > below skb->end, so skb_over_panic() does not fire). A 4+ byte tail is
> > instead offered to the XDP program and delivered as a standalone
> > mid-payload Ethernet frame on XDP_PASS. XDP_TX/XDP_REDIRECT instead
> > falls through to the next iteration, resetting the running length, so
> > the tail is re-parsed as a full-size new frame.
> >=20
> > XDP does not support scatter-gather frames until the multi-buffer
> > rework, so drop the whole frame instead: mark it as errored as soon as
> > a non-last descriptor is seen while an XDP program is attached, drain
> > and release every descriptor - including the last - and account the
> > frame once in rx_dropped. Removing the re-parse lets both XDP verdict
> > branches simply complete the packet via next.
> >=20
> > Note: the subsequent "net: stmmac: rework stmmac_rx to support XDP rx
> > multi-buff" accumulates the whole frame into a single xdp_buff and
> > supersedes this patch; the fix is kept so the net portion of the series
> > stands on its own.
> >=20
> > Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 28
> > ++++++++++-------------
> >  1 file changed, 12 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 426bb68c9bbc..8c08d44fdbd3 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5893,18 +5893,24 @@ static int stmmac_rx(struct stmmac_priv *priv,
> > int limit, u32 queue)
> >=20
> >  		if (priv->extend_desc)
> >  			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx +
> > entry);
> > -		if (unlikely(status =3D=3D discard_frame)) {
> > -			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
> > -			buf->page =3D NULL;
> > +
> > +		if (unlikely(!error && status =3D=3D discard_frame)) {
> >  			error =3D 1;
> >  			if (!priv->hwts_rx_en)
> >  				rx_errors++;
> >  		}
> >=20
> > -		if (unlikely(error && (status & rx_not_ls)))
> > -			goto read_again;
> > +		/* We do not support SG in XDP mode */
> > +		if (unlikely(!error && (status & rx_not_ls) &&
> > +			     stmmac_xdp_is_enabled(priv))) {
> > +			rx_dropped++;
> > +			error =3D 1;
> > +		}
>=20
> AFAIU GMAC4 and XGMAC always use the second buffer of a descriptor. If
> so, at MTU 1500 a frame of up to 3072 bytes can fit in one descriptor,
> and this check would not catch it?
>=20
> The XDP program would then only see the first buffer. With XDP_TX the
> frame is cut and sent too short. With XDP_PASS the second buffer is added
> after the program already decided.
>=20
> Patch 4 fixes this. But if this patch should work on its own, should it
> also drop the frame when buf2_len is not zero? Or am I missing
> something?

Hi Nicolai,

IIUC your comment we are missing the case where we have a single descriptor
(rx_not_ls is not set in status) but the packet is splitted over buf1 and b=
uf2,
right? Something like:

	...
	buf2_len =3D stmmac_rx_buf2_len(priv, p, status, len);
	len +=3D buf2_len;

	if (unlikely(stmmac_xdp_is_enabled(priv) && buf2_len)) {
		rx_dropped++;
		dev_kfree_skb(skb);
		goto next;
	}
	...

Is my understanding correct?

Regards,
Lorenzo

>=20
> > [...]
>=20
> Thanks,
> Nicolai

--KY7hfcVLGCw62j4b
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas3pBwAKCRA6cBh0uS2t
rKv6APsHFZSMX2dOAS1p36e6ZsqIAiOI0NDwoK6myQr0w44IyQEAuyVt58Q+sb1x
hWYvoUu5yllNvcDzIt78fFC420vYdAw=
=jWne
-----END PGP SIGNATURE-----

--KY7hfcVLGCw62j4b--
