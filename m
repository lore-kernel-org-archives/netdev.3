Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD931E834
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045704; cv=none; b=fsFofaZ3z6ZHpAkZLeZbbZGDEhPXPn0AUlO+K2dedFFsOC/hGhkeaVlj9s3coLpas/5fYPcU94aCDvz8lH+zTeYS4LNdSmApQ16fx9yxU+pyj9VZWWK37Dxk/hsBKEl5/6lCCBg0yZiX3SAbjzwN2bt56qVBzSzuyobny4YLuIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045704; c=relaxed/simple;
	bh=0J8xz71IMWt9Y4fILyZbTmtMkDd+pTqGqtU6FwJKtz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sptlHmhv8lCjDmCV/jfgYWuqLJXCvHmggQiqSzUopTqb3+vKPrkjqGR+AxD8XIjrEE4tc6mZ5WDJSUsOZzgOagk3MI0BqaOvkHCS6bb8n3BiReAVKB45KzHmijjLYaJdHyfRzc3n3QyhhKwnz+mud2oO4262TR1Y8Lw+2kiHZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KdG3BlCf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dgRpkHwz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KdG3BlCf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dgRpkHwz"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AC7lFo245013
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TPnjHnIgdmuzO9kTr0rrEAHp
	4E55nJ+bbwfUwsUg1os=; b=KdG3BlCf1IP7V5byJVyncSli8rVhBCuYl5MzWASa
	JrOKfKfhPIZ8VqHC8hl0Fqe56jTdqTK4Dg2k66CsVBQcwDbHsnAMn5fUTCdORu8f
	KxdEa5rtTBv3SMTCgKpK7ynpb2KXCDB9FObM5VfE2OOJvq9vumjOZWExpIlbhHzQ
	eokPvaXA4yWM/Wk1PioahxILLsQM9rpjlzk0ECJBQL1U4+NLX3rvgE/7N4AdLVg4
	eShneExNa18SPItW8L17YNXyX+xX+V1jRJfI77Vj+CJabzYKyPdtYvSZr9eFV58j
	YPO/ygqAkn9YaOyDKMRXaN0h/oHeo7VRM73EZhuJeEQFxg==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyfm0yv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:08:20 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4a7de733fa9so7744897b6e.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 06:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789045700; x=1789650500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TPnjHnIgdmuzO9kTr0rrEAHp4E55nJ+bbwfUwsUg1os=;
        b=dgRpkHwzuJBr0hyr0QladCl5lc2KqbQTPu9b0OyvG4sGrryC/3tjWEEiSfK2IFQ/SZ
         kh31GEkTCxlbaCBNeeEXd0wjGmc9LNEPEakW/kZiAWpdSaUrHih9NZesbMdPQnnGehgX
         1K/27pNcwc5j/MlhU+XVKX5rPmPArwD21n6Cd/OmscqZyjUVTbBq/0Rq3KRxF46oX+bP
         PG0X9ENMWzg8dm0mSw7IEcikglVRqrUpZ3Z08OuEtxrCKAbPLYikAuN1PDyIdldG6sxh
         p7CUjCz6cxO4XDYCaVdPjG2UKGBMIWZlchX40ns/AU+GYV4udoE+1EiAFT9JbePo7Kav
         Gmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789045700; x=1789650500;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TPnjHnIgdmuzO9kTr0rrEAHp4E55nJ+bbwfUwsUg1os=;
        b=dDebF8+3aMPuVkrJE7+X1WCyWSZSZIvx1VFke/6MiHeifZZHrcdtuIWB+VI+nEDB5d
         zzBGdwPoMywjSWFfH0KHb85Gm1odpye/HZbfhhGs/zxBnH9Js7BaFQAcvM+GoAD4ejx1
         CvvcrkylO9V5PCT3e7Z0VXkddbd9iH47+OAW61JyFKi93q/gKtzZsjkrlWKXe6xio/nC
         +kW1eiym9/eIV92k3nYNONg6Ceg1I+vOPbkJSk4J8iK6E5LvIceP92/OyicgkDCDW/I8
         1n/VaUFX/R38mFZ0Em1z91q6BU/3f2jhip6njAn5mFamW3frQu6YoPgbkO28eIx24Uly
         XCpg==
X-Forwarded-Encrypted: i=1; AKwUvByWi8ahzY2ydQdR3LN2Q+SFbnkN1KdcjYvRntvnmpBI+3/iO05CmUn2rUSV1t958o26WgrAfLs=@vger.kernel.org
X-Gm-Message-State: AFuF++lFfrnndWTexlrJq5/7DbfhP6P3eqO5xIjI4kuf3wDNUaxv2xFn
	2X/YNrAo+xMn3a9nwsTLW9KE3uwYMs7oUZHU7jj93YFTiOyUNfUoFA7tTZpRxbNf3Kd9aATGRab
	5Li/D3es06euwFDYhV4+cKIQ5EB6LqeQyWqZdR5eWCn+U/daD9S/1H/t2rBs=
X-Gm-Gg: AYBFou1HZTs9gtEMWJQMM+1b2IvolUyAwYljkiguxXG10ExHgoqohEOS4y39diCO3HB
	MlwjLRNMuvRA2DuuVOqs2b6YnIgT2sY39akTDO/alH/+1nTDGVUazoQ7pCsuDPl+O/tmQrSTnMF
	SguDnQdY59ISWvc5P/gmThyG9gyZ7Wvq4Q6XnTGvMFV1RbN34YJvlPggqOootE7Fta9iYqxvo7+
	s0XX4C5138W5yHCMqDnzxKihbVNkP4nR4ZhHCbjCAvD7DNaQirWD0MbnqNeAmuXQ6IsajrcnL6X
	J3iz5+gAVlzV2bjXJlpp6d4PKrKxH26AGDRklOGiipSJGZUQBaRAIHEKoL4Oolax9sX7/4EUPm7
	+p1EnggTlde1iSw==
X-Received: by 2002:a05:6820:2209:b0:6b7:46fc:1c9 with SMTP id 006d021491bc7-6b746fc02fcmr20501864eaf.40.1789045700042;
        Thu, 10 Sep 2026 06:08:20 -0700 (PDT)
X-Received: by 2002:a05:6820:2209:b0:6b7:46fc:1c9 with SMTP id 006d021491bc7-6b746fc02fcmr20501794eaf.40.1789045699526;
        Thu, 10 Sep 2026 06:08:19 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5cdf7asm943272566b.58.2026.09.10.06.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:08:18 -0700 (PDT)
Date: Thu, 10 Sep 2026 15:08:17 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: fix TX descriptor availability check
 for TSO traffic
Message-ID: <aqKrwW62rHjVzb5h@lore-desk>
References: <20260907-stmmac-fix-tso-nfrags-check-v1-1-328459906cdb@oss.qualcomm.com>
 <178903370842.219967.14155724625684562557@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LNHrs9xCYmBYQG1L"
Content-Disposition: inline
In-Reply-To: <178903370842.219967.14155724625684562557@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE1NyBTYWx0ZWRfX0/HzgUbocZC2
 DJThOQjxv9PSw/uoq2fOM4DIPzTcWMR0YdpTE7UHXGb9A5hFQTmuTiF3L5v2e0VkoQ1AQTbA8du
 JKRvmdkuyvDFjR7fnwQwfh+edMQIeHQ=
X-Proofpoint-ORIG-GUID: ymtWJ0JpuwX6u32sMqxUwyKAuli972go
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE1NyBTYWx0ZWRfX0P7WlQeRRiJ0
 jjYFs9iN1dI94/LZv3cqEdNOmE4IjS7NWxvUG/WOQKIgNLIOcP3SJTx0WpBmkeLlIjCBNnvsK5Y
 gN4HBETgRCE38NumS2Dn9CdbcRbZTIkiSrJUex0tw3vQOmY5jJSKVOCpTwwXSz1Y4y20nZoe4hE
 cWdxxQ/MVszDJO6T/mvkEPuWy8SBThphUQOLCG81DxWjIEfOjlqMX4a4rOFKkrENlNirhKUN8BI
 eFTJz/VZ8AykN1j1SeA4yj1V+BX44LydbCn70t1eZ/O9Uzbnjx0yhP30OtDjASY4SF+8Ndoxu2K
 vVZLx3we2LPgRpUxYqROgShZVgfQh+UkvL17jVZ+6QxO1WKja34rLLhlobVVlG6n1w2/3WCVY1E
 lE+cIUEL/2cpJjQ+ufwJDg1cuRZcqyg08njmpxjwjbpY9Zhka404mJHQYJgF+3ft5/CM6RpPWsW
 heDwZesqxEF6H83oR8w==
X-Authority-Analysis: v=2.4 cv=H5pOUOYi c=1 sm=1 tr=0 ts=6aa2abc4 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=elNHZ6xcAjOI5rna9C8A:9 a=QEXdDO2ut3YA:10
 a=f7ULPs5uqvM6TsqBw1IA:9 a=efpaJB4zofY2dbm2aIRb:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: ymtWJ0JpuwX6u32sMqxUwyKAuli972go
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100157

--LNHrs9xCYmBYQG1L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>=20
> Critical: 0 =C2=B7 High: 1 (1) =C2=B7 Medium: 0 =C2=B7 Low: 0 (1)
>=20
> - [High] stmmac_tso_xmit() now demands the exact descriptor count
>   returned by stmmac_tso_get_num_desc() (stmmac_main.c:4543-4544) but=E2=
=80=A6
>=20
> Pre-existing issues:
> - [High] proto_hdr_len in stmmac_tso_xmit() is declared as u8
>   (stmmac_main.c:4524) but is assigned the size_t result of=E2=80=A6
> - [Low] The stmmac_tso_xmit() kernel-doc states "mss is fixed when enable
>   tso, so w/o programming the TDES3 ctx field." (stmmac_main.c:4512),=E2=
=80=A6
>=20
> --
>=20
> net: stmmac: fix TX descriptor availability check for TSO traffic
>=20
> This replaces the (skb->len - proto_hdr_len) / TSO_MAX_BUFF_SIZE + 1
> estimate in stmmac_tso_xmit() with stmmac_tso_get_num_desc(), which counts
> the header descriptor, the linear payload, every fragment and the MSS
> context descriptor. The new count is then used for the free descriptor
> check before the ring is programmed.
>=20
> A few questions below.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 24656b35350b1..3566b33bc34e5 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -4454,6 +4454,26 @@ static bool stmmac_tso_valid_packet(struct sk_bu=
ff *skb)
> >  	       header_len + gso_size < 16383;
> >  }
> > =20
> > +static int stmmac_tso_get_num_desc(struct stmmac_tx_queue *tx_q,
> > +				   struct sk_buff *skb, u32 pay_len)
> > +{
> > +	int i, ndesc =3D 1;
> > +
> > +	/* head payload */
> > +	ndesc +=3D DIV_ROUND_UP(pay_len, TSO_MAX_BUFF_SIZE);
> > +	/* frag payload */
> > +	for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++) {
> > +		const skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
> > +
> > +		ndesc +=3D DIV_ROUND_UP(skb_frag_size(frag),
> > +				      TSO_MAX_BUFF_SIZE);
> > +	}
> > +	/* MSS update requires a new descriptor */
> > +	ndesc +=3D !!(skb_shinfo(skb)->gso_size !=3D tx_q->mss);
>=20
> [Severity: Low]
> This is a pre-existing issue and not introduced by this patch, but the new
> comment here now contradicts the stmmac_tso_xmit() kernel-doc that follows
> a few lines below, which still says:
>=20
> 	 * mss is fixed when enable tso, so w/o programming the TDES3 ctx field.
>=20
> stmmac_tso_xmit() does program a context descriptor whenever the skb MSS
> differs from the cached queue MSS:
>=20
> 	if (mss !=3D tx_q->mss) {
> 		...
> 		stmmac_set_mss(priv, mss_desc, mss);
> 		tx_q->mss =3D mss;
> 		tx_q->cur_tx =3D STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_=
size);
>=20
> Would it make sense to drop or update that kernel-doc sentence while
> touching this area?

As pointed out by Sashiko, this issue is not introduced by this patch and it
can be fixed with a dedicated patch.

>=20
> > +
> > +	return ndesc;
> > +}
> > +
> >  /**
> >   *  stmmac_tso_xmit - Tx entry point of the driver for oversized frame=
s (TSO)
> >   *  @skb : the socket buffer
> > @@ -4497,10 +4517,10 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_bu=
ff *skb, struct net_device *dev)
> >  	struct stmmac_priv *priv =3D netdev_priv(dev);
> >  	unsigned int first_entry, entry, tx_packets;
> >  	struct stmmac_txq_stats *txq_stats;
> > +	int i, first_tx, nfrags, ndesc;
> >  	struct stmmac_tx_queue *tx_q;
> >  	bool set_ic, is_last_segment;
> >  	u32 pay_len, mss, queue;
> > -	int i, first_tx, nfrags;
> >  	u8 proto_hdr_len, hdr;
> >  	dma_addr_t des;
> > =20
> > @@ -4513,14 +4533,15 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_bu=
ff *skb, struct net_device *dev)
> > =20
> >  	/* Compute header lengths */
> >  	proto_hdr_len =3D stmmac_tso_header_size(skb);
> > +	pay_len =3D skb_headlen(skb) - proto_hdr_len; /* no frags */
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but the new pay_len computation
> inherits an existing truncation. proto_hdr_len is declared u8 while
> stmmac_tso_header_size() returns a size_t (skb_transport_offset() +
> sizeof(struct udphdr), or skb_tcp_all_headers()), and
> stmmac_tso_valid_packet() explicitly admits headers up to 1023 bytes into
> the hardware TSO path:
>=20
> 	return header_len <=3D 1023 && gso_size >=3D 64 &&
> 	       header_len + gso_size < 16383;
>=20
> For a header of 256..1023 bytes the store wraps modulo 256 (486 becomes
> 230, 256 becomes 0). The truncated value then defines the hardware
> contract, both for the payload start address:
>=20
> 	stmmac_tso_allocator(priv, &entry, des + proto_hdr_len, pay_len,
> 			     (nfrags =3D=3D 0), queue);
>=20
> and for the descriptor lengths:
>=20
> 	stmmac_prepare_tso_tx_desc(priv, first, 1, proto_hdr_len, 0, 1,
> 				   is_last_segment, hdr / 4,
> 				   skb->len - proto_hdr_len);
>=20
> so the tail of the real header is handed to the engine as TCP/UDP payload
> while TDES3 declares more payload than the following descriptors describe
> (a header of exactly 256 also yields a zero length buffer1 with TSE set).
> A TCP over IPv6 socket carrying a few hundred bytes of sticky
> destination/hop-by-hop options makes skb_tcp_all_headers() exceed 255 whi=
le
> staying under 1023, so such an skb reaches stmmac_tso_xmit().
>=20
> For the new pay_len the error biases upward, so the ring accounting stays
> safe, but should proto_hdr_len be widened to unsigned int (or size_t) sin=
ce
> this patch now builds the descriptor count on it too?

As pointed out by Sashiko, this issue is not introduced by this patch and it
can be fixed with a dedicated patch.

>=20
> >  	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
> >  		hdr =3D sizeof(struct udphdr);
> >  	else
> >  		hdr =3D tcp_hdrlen(skb);
> > =20
> > -	/* Desc availability based on threshold should be enough safe */
> > -	if (unlikely(stmmac_tx_avail(priv, queue) <
> > -		(((skb->len - proto_hdr_len) / TSO_MAX_BUFF_SIZE + 1)))) {
> > +	ndesc =3D stmmac_tso_get_num_desc(tx_q, skb, pay_len);
> > +	if (unlikely(stmmac_tx_avail(priv, queue) < ndesc)) {
> >  		if (!netif_tx_queue_stopped(netdev_get_tx_queue(dev, queue))) {
> >  			netif_tx_stop_queue(netdev_get_tx_queue(priv->dev,
> >  								queue));
>=20
> [Severity: High]
> The new requirement is exact, but the TX flow control watermarks were left
> unchanged. Can this make the "Tx Ring full when queue awake" branch
> reachable for ordinary TSO traffic?
>=20
> stmmac_tso_get_num_desc() returns at least nfrags + 2 for any TSO skb that
> has a linear payload, so with MAX_SKB_FRAGS =3D 17 plus an MSS change it =
asks
> for 20 descriptors, and up to roughly 23 when individual frags exceed
> TSO_MAX_BUFF_SIZE.
>=20
> The tail of stmmac_tso_xmit() still stops the queue based on the old
> assumption:
>=20
> 	if (unlikely(stmmac_tx_avail(priv, queue) <=3D (MAX_SKB_FRAGS + 1))) {
> 		netif_dbg(priv, hw, priv->dev, "%s: stop transmitted packets\n",
> 			  __func__);
> 		netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, queue));
> 	}
>=20
> so the queue is deliberately left awake with as few as 19 free slots, whi=
le
> the next TSO skb may need more. Does that leave a window where the stack
> submits an skb that does not fit, hitting the un-ratelimited netdev_err()
> in the ndo_start_xmit hot path together with netif_tx_stop_queue() and a
> NETDEV_TX_BUSY requeue?
>=20
> The non-TSO path keeps the invariant the watermark was designed for,
> stmmac_xmit() needs nfrags + 1, which is always satisfied when the queue =
is
> awake:
>=20
> 	if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 1)) {
>=20
> The only place the queue is re-armed is stmmac_tx_clean():
>=20
> 	if (unlikely(netif_tx_queue_stopped(netdev_get_tx_queue(priv->dev, queue=
))) &&
> 	    stmmac_tx_avail(priv, queue) > STMMAC_TX_THRESH(priv)) {
> 		...
> 		netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, queue));
>=20
> STMMAC_TX_THRESH() is dma_tx_size / 4, which is 16 on the 64 entry ring
> stmmac_set_ringparam() accepts (DMA_MIN_TX_SIZE in common.h). On such a
> ring the wake threshold is itself below the new requirement, so can the
> queue be woken while the skb still does not fit, producing a repeating
> stop/wake/TX_BUSY cycle with repeated error logging?
>=20
> Should the stop and wake watermarks be raised to the worst case TSO
> descriptor count, or the skb linearized/pushed to software GSO, as part of
> this change?

The goal of this patch is to fix the memory corruption triggered by a TSO s=
kb
that does not fit in the tx queue available memory space.
The case described above will be managed by the new condition added at the
beginning of stmmac_tso_xmit(). I think we can change the stop/wake tx queue
watermark with a dedicated patch that we do not need to backport (I guess t=
his
is mostly an optimization). However, if you prefer to have it in a single p=
atch,
I will add it in this one.

>=20
> >  @@ -4532,8 +4553,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buf=
f *skb, struct net_device *dev)
> >  		return NETDEV_TX_BUSY;
> >  	}
>=20
> One more on this branch: it sets XOFF without re-checking availability and
> without arming a wake source. If the ring drains concurrently
> (dirty_tx =3D=3D cur_tx, no further TX completion and no NAPI run), does =
the
> XOFF state persist until dev_watchdog fires ndo_tx_timeout?

I guess this corner case has not been introduced by this patch since the sa=
me
approach is present in stmmac_xmit(). I think it should be addressed with a
dedicated patch. Moreover, is the corner case fixed by the ndo_tx_timeout
callback?

Regards,
Lorenzo

>=20
> Since the patch is tagged for stable, would it be worth describing the new
> NETDEV_TX_BUSY and error logging behaviour in the commit message?
>=20
> > =20
> > -	pay_len =3D skb_headlen(skb) - proto_hdr_len; /* no frags */
> > -
> >  	mss =3D skb_shinfo(skb)->gso_size;
> > =20
> >  	/* set new MSS value if needed */
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260907-stmmac-fix-tso-nfrags-check-v1-1-328459906cdb%40oss.qualcomm.c=
om

--LNHrs9xCYmBYQG1L
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqKrwQAKCRA6cBh0uS2t
rGJLAP97a5a1+31bWNIA/98bBUZ68yBojQhkvWdH66C5SFQi0wEAo6iRd7fMPqu2
cCuGOeOObCKpxbTg7pb0J6toTca2uAM=
=qcF7
-----END PGP SIGNATURE-----

--LNHrs9xCYmBYQG1L--
