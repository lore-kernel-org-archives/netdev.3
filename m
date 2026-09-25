Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B24B2032
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351757; cv=none; b=k6PEdwMmQ9JlgAoge8Tc/I6ZvtbcgWeC7zaYD0Pz2113q8spzb4HbxXudY7db/53+QnSHaOGCn2NscQRHTSxUG5gvHCAHiHAl3ibU+T0aTtlRdbSD0emY0qMvmAkLH6my2UFj6BGC9yNSd3kKYwpkITRvtliI684fkN29ucKD1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351757; c=relaxed/simple;
	bh=ZUsLp7Ds5aPdUzlW5di86I4h3++8mc9RnquQmIQHTP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmxJDM4N35Ng3boFQi8UuGsbqfGd7cCxyWjhooPgHzU+iUvtpTLd4ffhNb6wZrJmFULKYXDunjE2PDwLgfE9d64fynZbYn1x6mvYhiMEKQDxCRPZYLlCVe0xk/tRRgr5dvuQgucPluAMi+xen9J4SDRPY9IC4gz2xadfrFeAQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oeYihPIx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HEaiiGIZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oeYihPIx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HEaiiGIZ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PDOj6C208419
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 15:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NodE5+3njxDI4fR67x4iTQID
	81W7G1IBOTmM8UGK/VQ=; b=oeYihPIx544gfS5Ae3xRTviH6MSeefLqSy2I3mDr
	STHUvNgZNJ6FEOu1rbnp5z8vnr/Nt6LPmpYqqOwfJhZF3Ol+QHa9eKEqdwz3JLEw
	fssFHG2RsLhIfmfeUQW0JR79jly4UZWTIN1l+OORRRWtNSvhcP3WYfmlg1WEUWau
	NAEjreO6qiHoR0rRzlQ/5HV6wX0KFLaAxOhedpgfna7K3wYjrLs4q/wWlu4flk0h
	c/+HvFZIvN8vm391VBjEYDbdBNDtXcvll5ZKZuD0K2JT+BL3bI82S3f98IO2UWhd
	6ncI1qyQ0bJCbVKk0AuPGI9+EQhN2m5Mp1WfCkJ8XXZz3w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw898v85d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 15:55:54 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9855e11e5b9so984490241.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 08:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790351753; x=1790956553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NodE5+3njxDI4fR67x4iTQID81W7G1IBOTmM8UGK/VQ=;
        b=HEaiiGIZkVuiNbJdusWZnxhm7xpAJtopCCEXMoBzEoGsVeQ6wRoITtk5g+HCHR0NxI
         AWiojg5/JUeqnLfjaxAYYDt37rujze75zi6nauu4OTmBqP4rhV68AvEp+q1MH6pMUfH1
         Z4VfBkyULmnj0eQX0OPqmUbZ6uleKGijpDcX37hiLkH+xMY3VZjmp7BmaF5j9HNGBkrI
         vEtmt1jQ4fYDUuyRSgCoPgpsTBnEpa7jJta2DkGlBPlbyALQHFUm5eQl8yyv/dre3C32
         hdWBeamHRV7OEhELE0C2cMMwDc+/oEY41Dq9l7BVAEy/zhv20cqAQ94A1ACgjJiCObHB
         UJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790351753; x=1790956553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NodE5+3njxDI4fR67x4iTQID81W7G1IBOTmM8UGK/VQ=;
        b=2URwXtGGSYrN9d6KU/WE2Bu9tardvURFBvh9AYVp7q1R+5HW/+dPS6wYn28N/Twa1K
         HbCDWLIl+cFXIEY7VICkNS8kqczGqUZO3TVsR9NzJxd2/FNieSnXx5W2iofKJLvK59yp
         BCrGCn+UEPKf2IN5kr/DxvhRMZcxidaMrV0CrdYwrjddmEFGQSDL4PiFyDsm4Ry5pMMR
         jY4/8qdsnxS4wRu739oqQI7Xx8MTX+N54XWmQvmNbxXuJwJ6E57U+zTI39vPMpmobbtd
         JVg3Fcx1SWRNbvXRyuLWMpwzZ57tMMHQduYfiEQXVGq/JsTkKWsj4BsVj44KDGoNJx6A
         JwyQ==
X-Forwarded-Encrypted: i=1; AKwUvByC+GT8lKj64dPMtThVoGzc3CHeZLzVUsaW09z60Sksst3dVcME0s8RR26bBmpwd4pN//mgN/k=@vger.kernel.org
X-Gm-Message-State: AFuF++lDOhxvTTLGg+vdjat7wG+wO5YhBJewcaSEF9FWnkmifeYuXHJe
	8HtXADp0N/+yl1OosBOsqxyji7tRAmJBlJO/SVN7c9nowDpnVE1vgCK5xfdZe7Xv91Hgg/06z10
	e4KRnVWhLbBSiV6+iaWWxn70lY2ViIkyPHfKiMU+/9JTfS/DDCBaWSDzN0kw=
X-Gm-Gg: AYBFou3jHpLJuj3qTfgdBvIayucGADMoeBU9msVOF+J9cnnoosU5YJ4OCzT9VoELchl
	FczEMMS380Ktw9LdHSPEw93jqNHmIKVuxoUossO5Jw1+oeDI31frPOsmJTiY3ww2RQZwi/04x0c
	JDpidWtG0Lba9RWJxhiwMmt0U9iic2rzDlXVW36OlEA/nSuwpdIQxG8J8g7lQEIUIj29XVMBYTF
	WdCtlEmG8EwQfBTwcDbwE6g96Or4N0BlHFRMipfnccSaYL0rtSyszIorF/QxUyNVEAsLkCxllh6
	2HINoC7jvCk0uUd3aqNQMe3GR7BB8E+A9c7EE8CHt8RWqEoP9llUyFrQnpnVhY4jigf/okDH2I2
	lmED/El+gL0van+BDEsRuplGms9lFJsqNilSGRgWqMH6DQSMtLUew
X-Received: by 2002:a05:6102:4b11:b0:7a5:e455:182f with SMTP id ada2fe7eead31-7af1dce60b5mr2980192137.26.1790351752912;
        Fri, 25 Sep 2026 08:55:52 -0700 (PDT)
X-Received: by 2002:a05:6102:4b11:b0:7a5:e455:182f with SMTP id ada2fe7eead31-7af1dce60b5mr2980182137.26.1790351752385;
        Fri, 25 Sep 2026 08:55:52 -0700 (PDT)
Received: from localhost (mob-176-242-14-193.net.vodafone.it. [176.242.14.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fedec53c4sm98228725e9.4.2026.09.25.08.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:55:51 -0700 (PDT)
Date: Fri, 25 Sep 2026 17:55:50 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: stmmac: add XDP multi-buff support for
 TX side
Message-ID: <araZhlxvNmNMjz4-@lore-qca>
References: <20260924-b4-stmmac-xmit-mb-v2-1-003347b7bc25@oss.qualcomm.com>
 <179034282133.2160803.6796326011241134301@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DfpfF2TtoHi+Hm+b"
Content-Disposition: inline
In-Reply-To: <179034282133.2160803.6796326011241134301@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX4bCDPtP+0n4u
 WL6+lTLb0KD41Us32lEXjv6tQgU5OP5w9+A4E9+btYBAuRYHuu/aB4v/F1aNj0GTsdz28CGTvhU
 b9Mw5VH1MdcEMJ/qa+zFwEWviFBJ2Pw+HnTo1NiKXR9K/UEHPODMZKlVf0z10ilXCMcGqTHGVE7
 C3YKvsugx0TqPcTnNKU1C4R8XhA2p+fqxgbGP6Li+FKbh1MXjdGSM+HtT82pL7XAlPXFWHcaHdv
 YjBUxkQzEqjIKLW/ggKH9zs6FdswwVmW2IRVASsJidfBGoxykGqJXap1AbVDdfsBLqyuTcwQS7f
 A9H2/GDs8F6Ur9WDkw6JeAI+trTmYvJC27/6qRdpSKscdo/NsUKGD989q2wev53//2bEfJUl/aT
 deW9HUhbuacEp11ovF4U3mnheHFeJVeAglwS+nhb/k6d/1XbZsBO4uXyxhMbb/qWe+AlALEr+mi
 g3wdxLno3Y9NCUZUYfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX0JIqVV3dzdT4
 am/Zvv1tpnHEkCbvIOYB/V8Gx97qV4ka5JzJ5uYdi1S4wVf2aXbTKmhi6C68rIucG4psGS1cX/+
 rH+TWHD+g1wnjlJuqH/iNy0m/cTceOc=
X-Proofpoint-GUID: JWpL9VY0DKisA3LO1i0i3KtThD__qS7Q
X-Proofpoint-ORIG-GUID: JWpL9VY0DKisA3LO1i0i3KtThD__qS7Q
X-Authority-Analysis: v=2.4 cv=EJWTQFZC c=1 sm=1 tr=0 ts=6ab6998a cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=zqzRha2v0yr7kDoiQM3DgQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=9R54UkLUAAAA:8 a=htdx_T51ip50QcR6nkoA:9 a=QEXdDO2ut3YA:10
 a=WH1HmPzLYftVj8qdMIUA:9 a=1WsBpfsz9X-RYQiigVTh:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250063

--DfpfF2TtoHi+Hm+b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] The patch adds multi-buffer (frag) handling to
>   stmmac_xdp_xmit_xdpf() in=E2=80=A6
> - [Medium] In stmmac_xdp_xmit_xdpf()
>   (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c), the patch removes=
=E2=80=A6
> - [Low] A new comment in stmmac_xdp_xmit_xdpf()
>   (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:5332-5334) reads=E2=
=80=A6

I will fix sashiko's reported issues in v3.

Regard,
Lorenzo

>=20
> --
>=20
> net: stmmac: add XDP multi-buff support for TX side
>=20
> This commit extends stmmac_xdp_xmit_xdpf() so it can send XDP frames that
> carry fragments. The frame head and each frag are mapped and placed in
> their own TX descriptor. The OWN bit on the first descriptor is set only
> after all the descriptors are filled in.
>=20
> Link: https://lore.kernel.org/r/20260923-b4-stmmac-xmit-mb-v1-1-a71a1c522=
142@oss.qualcomm.com
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index bf9e7e4cb1c31..089281ef9e612 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5239,77 +5239,117 @@ static unsigned int stmmac_rx_buf2_len(struct =
stmmac_priv *priv,
> >  static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
> >  				struct xdp_frame *xdpf, bool dma_map)
> >  {
>=20
> [ ... ]
>=20
> > -	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
> > +	if (unlikely(xdp_frame_has_frags(xdpf)))
> > +		num_frames +=3D sinfo->nr_frags;
>=20
> [Severity: Medium]
> Can a frame with frags reach this function from either caller?
>=20
> On the ndo_xdp_xmit path, stmmac_xdp_set_prog() still registers the
> redirect target without SG support:
>=20
> drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c:stmmac_xdp_set_prog() {
>     ...
> 	if (prog)
> 		xdp_features_set_redirect_target(dev, false);
>     ...
> }
>=20
> The static mask in stmmac_dvr_probe() is only NETDEV_XDP_ACT_BASIC,
> NETDEV_XDP_ACT_REDIRECT and NETDEV_XDP_ACT_XSK_ZEROCOPY. Because
> NETDEV_XDP_ACT_NDO_XMIT_SG is never set, devmap drops fragmented frames
> before they get to stmmac_xdp_xmit():
>=20
> kernel/bpf/devmap.c:__xdp_enqueue() {
>     ...
> 	if (unlikely(!(dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT_SG) &&
> 		     xdp_frame_has_frags(xdpf)))
> 		return -EOPNOTSUPP;
>     ...
> }
>=20
> is_valid_dst() does the same check on the broadcast path.
>=20
> On the XDP_TX path, stmmac_xdp_xmit_back() only gets frames built by the
> stmmac RX path, and that path never builds a multi-buffer xdp_buff. The
> driver has no xdp_buff_add_frag() or xdp_buff_set_frags() calls.
> stmmac_xdp_set_prog() also rejects XDP when mtu > ETH_DATA_LEN,
> stmmac_change_mtu() blocks jumbo MTU while XDP is loaded, and SPH is turn=
ed
> off for XDP.
>=20
> If so, the frag loop, the skb_frag_dma_map() and skb_frag_off() handling,
> and the multi-descriptor error_dma_unmap unwind can't be run or tested. T=
he
> subject "add XDP multi-buff support for TX side" also doesn't match what
> the driver advertises.
>=20
> Should this patch advertise NDO_XMIT_SG as well, for example by calling
> xdp_features_set_redirect_target(dev, true)?
>=20
> [ ... ]
>=20
> > +		stmmac_set_tx_dma_entry(tx_q, entry, buf_type, dma_addr, len,
> > +					dma_map && frag);
> > +		stmmac_set_desc_addr(priv, desc, dma_addr);
> > +		stmmac_prepare_tx_desc(priv, desc, !i, len, csum,
> > +				       priv->descriptor_mode, !!i, last_frame,
> > +				       xdp_get_frame_len(xdpf));
> > +		tx_q->xdpf[entry] =3D last_frame ? xdpf : NULL;
> > +		if (last_frame) {
> > +			stmmac_set_tx_dma_last_segment(tx_q, entry);
> > +			break;
> > +		}
> > =20
> > -	stmmac_prepare_tx_desc(priv, tx_desc, 1, xdpf->len,
> > -			       csum, priv->descriptor_mode, true, true,
> > -			       xdpf->len);
>=20
> [Severity: Medium]
> Does this drop the dma_wmb() that used to come before the OWN bit on the
> normal single-buffer XDP_TX and ndo_xdp_xmit path?
>=20
> The old call passed is_fs=3D1 and tx_own=3Dtrue. That hit the barrier in
> enh_desc_prepare_tx_desc(), and the dwmac4 and dwxgmac2 versions have the
> same one:
>=20
> drivers/net/ethernet/stmicro/stmmac/enh_desc.c:enh_desc_prepare_tx_desc()=
 {
>     ...
> 	if (is_fs && tx_own)
> 		/* When the own bit, for the first frame, has to be set, all
> 		 * descriptors for the same frame has to be set before, to
> 		 * avoid race condition.
> 		 */
> 		dma_wmb();
>=20
> 	p->des0 =3D cpu_to_le32(tdes0);
> }
>=20
> Now the first descriptor is prepared with is_fs=3D1 and tx_own=3D0, and t=
he
> frag descriptors with is_fs=3D0. Neither combination reaches the barrier.
> OWN on first_entry is set later by stmmac_set_tx_owner(). Every
> implementation of that is a plain read-modify-write with no barrier:
>=20
> static void enh_desc_set_tx_owner(struct dma_desc *p)
> {
> 	p->des0 |=3D cpu_to_le32(ETDES0_OWN);
> }
>=20
> dwmac100 and dwmac1000 cores have no tail pointer.
> dwmac_enable_dma_transmission() only writes DMA_CHAN_XMT_POLL_DEMAND, and=
 a
> DMA that is already running keeps fetching owned descriptors. On a weakly
> ordered CPU, can the DMA see OWN=3D1 before the new des1/des2 buffer leng=
th
> and address? It could then send a stale address left over from the slot's
> earlier use.
>=20
> stmmac_xmit() has the same pattern, but that is not new. Would adding a
> dma_wmb() just before stmmac_set_tx_owner() on first_entry restore the old
> ordering?
>=20
> [ ... ]
>=20
> > +	/* Set the OWN bit on the first descriptor now that all descriptors
> > +	 * for this skb are populated.
> > +	 */
>=20
> [Severity: Low]
> This isn't a bug, but this comment appears to come from stmmac_xmit(). Th=
is
> function transmits an xdp_frame and does not use an skb.
>=20
> > +	desc =3D stmmac_get_tx_desc(priv, tx_q, first_entry);
> > +	stmmac_set_tx_owner(priv, desc);
> > +	tx_q->cur_tx =3D STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
> >  	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260924-b4-stmmac-xmit-mb-v2-1-003347b7bc25%40oss.qualcomm.com

--DfpfF2TtoHi+Hm+b
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaraZhgAKCRA6cBh0uS2t
rFeUAQCgDdz2Djok1mUYAVbLCIsvIjfbKmTZ/M+a8MMSgC5fEgEA8cZ6UkvhDbor
5dCiQjWnODJ4ZHCWkRa4Tx5THD2jhw4=
=y/h6
-----END PGP SIGNATURE-----

--DfpfF2TtoHi+Hm+b--
