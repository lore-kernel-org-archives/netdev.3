Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B7448AE0F
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578842; cv=none; b=OaU5+LCGT6CheU22gGgrt/BK5v7pqYqmOoi0Ix0TE58XSnqxE3tANO1/Aq8vh4qvPpGVD87SYRaP0S/Fs2xpWPnvpw+gstUAcWpeiS97BlPsSI2ApGYxagrwL9Pi2wQOHfTzVQJmGRiyhS0O60yB8nrXftErFFY42Ux+rJOz0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578842; c=relaxed/simple;
	bh=MowQt+K170gbSghvfo0hhm7Y8rD7woW3oyvuy0UsKCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bImu6bYcHTOddiqcUqkWj+1ne7FrpBvSkEA+HvVBHSBSmDij16xx/vgWzzA98KbbQ8BbUYUKbtOsUEvOEr7zULfRzcr3/0yvAafa+JRzKm7Kyc//hedY6kbGplWGTE1SDPheYSH3Ht9Nc9613+zi7i+j97Q/dtWldmHbfBKLBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SLAeiwu7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IgAFLOGR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SLAeiwu7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IgAFLOGR"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFeT522600368
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 17:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DeHaJe9Qao7AHi4F08K5E9v8
	rW7Bb0sStmKEtc/P+qE=; b=SLAeiwu7Uwh3KtN5bkGk2pkL1bNJCqnYJJm+/bKM
	N02h/UGRZWasLth58wbhc9CM5/IvSvYxlF/OrdZb93lc6sBKujTDcOYv/FVDrq3n
	Kq6tcTOU8ycf7s8GBLkxkjbVa8XOnf2dJXe+RYbaHU+hJK6cdrd0XRZx/lzPbZye
	DJKAqz5FCxV5O299KWgTkwdNZ/XWNJeTjiZSvoPApkVNVwDIJqsKyo+MVX6l0VwV
	zeLSz0iavekN7QRt/U6aWL1dOhaeQKW4/3ssXePJqUmB9bz8IY6JdcwznpDgszI3
	Z6wPIjlCzqpHssgTD/0MlJnozWCVCrqvNw/5dhkof2zmTQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquwb13vc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 17:13:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a07b5b5efso436202385a.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789578838; x=1790183638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DeHaJe9Qao7AHi4F08K5E9v8rW7Bb0sStmKEtc/P+qE=;
        b=IgAFLOGRwUQc0ciS/Y+0xLCCOcVTBeM7YshX0hmUn4US/uuZe9zi7QtXNOUUaypbFj
         TyTLSdFkUL56QlykpfqunKZ2cPtQwbqdQblKes2B5UCSlqIdecg/OYrQEa3TwM9cfdgd
         FaUO45tL+18jRmeyJeRp0nVuuH440WMIxBUEpUdCn5Ye4Z/THvMOhAd5sYm1ZxGdWhf8
         lGHiU+CX6oryx8Uj6hjo+QlmfeUZeqoFHOQl0Tz52HVLeRtOLUyKCRj1v3s8MW9nQ7mj
         Ig52YZN5r5FsItLD9BVUA9z+Rx+xRUpxrey6OlLQftZJc/XvV82fgohMydkqX1VMJ36U
         wIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789578838; x=1790183638;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DeHaJe9Qao7AHi4F08K5E9v8rW7Bb0sStmKEtc/P+qE=;
        b=ZYQr+uULWxBsfhcAWnPPPbySNEJfnIjOo6ZxoS0tsc8xY11kYWbSA8WQt16cQhAFvz
         Nb7IOEdrbdYl+XeMNQ+Y3QOqoMlS780EcQP8IphPbtU9h/EiT/7A5tmx9VkqamO+CTr2
         VhlINEnfhzwOvljfIYYVqL6XU874ETwZDRTR2oHvZu/vsHYjKNsYDe63Nd9DOPDqi5ft
         IX0k41pviMZS7qS/yF66NcBuA9xS2pYxgopstjx+AVJeUzFPKLYiXx17dCK5jtAStvMv
         xN20mEdW3YhFh/AvrPBfBFgCqx0hmSUEhE2jF2F/QrOz6fWyAzbz4bcarbiK76cZaWMD
         PjlA==
X-Forwarded-Encrypted: i=1; AKwUvBwvilwj3DzM1oPeb9/XfuZnUvns+NOQYOGRdyzumFnqFralqn9bHnMyGLNJcE4OE3c01wO32AE=@vger.kernel.org
X-Gm-Message-State: AFuF++mKEBr/ND6taN8btY0XKcNhLStp+OVCVXp75iAYD+heNff8rdcp
	PV6WomCJl/nkJBrY5vta04YNLBdX76j0mLpeXJ1HmHdmgyns6418iAFG/VgdcNPKqrFpfqnfcpG
	LpeABMREk21C81jnTf6j1RVA9V4jrnfYhoGwFJijBl4uHiHnFheHHi0V8MPU=
X-Gm-Gg: AYBFou2OFXyVJ0Xnwl4oMzmSjXLVP58T60ZoPKhP6BQNikaXZsJEv4QQ7+td/XjLoBy
	4rLdoxicsbv9OKWTtfoKGK6VEz0KWAfJCImwtHBXtFdTkmXM6zjIGLoF2SgxM5HRo5CUeQeYw+U
	kn67z0efZGDMCF9Bjuia0X3pUDaJqGJf1zMiL6G9vRXF5LP8k4kC9est+aOU8E5aFNRNeb3nyNb
	Uh42qQUzjvmlvS1NLmlbLiqY/WM2B98sFqAH0acRdiS55Ex0ej2Hn3U0nGOfSZ7qJR0dLHAlufI
	PEfO2dnjS6yWDSrRW+AUhOc7HYDQ9NLZYIKICh1Xvm6t1BQJ/JAwBOl3SqPD1EXZrIwx2QzxAbi
	uQasm8hJ984I71CXRJun39T9It+0uGxRG/HdvATEF1eBHdk1DTQ==
X-Received: by 2002:a05:620a:1789:b0:937:6f98:c68f with SMTP id af79cd13be357-93bc62405afmr61133085a.1.1789578837991;
        Wed, 16 Sep 2026 10:13:57 -0700 (PDT)
X-Received: by 2002:a05:620a:1789:b0:937:6f98:c68f with SMTP id af79cd13be357-93bc62405afmr61126785a.1.1789578837460;
        Wed, 16 Sep 2026 10:13:57 -0700 (PDT)
Received: from localhost (mob-176-242-39-34.net.vodafone.it. [176.242.39.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bef7642sm7943207f8f.5.2026.09.16.10.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:13:56 -0700 (PDT)
Date: Wed, 16 Sep 2026 19:12:56 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: fix rx Scatter-Gather support
Message-ID: <aqrOGKHuJ63wWd8y@lore-qca>
References: <20260916-stmmac-rx-sg-fix-v1-1-b49b7b8f725f@oss.qualcomm.com>
 <2ec95f84-2eaf-407f-8372-6f6e89eb1e3b@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Im3uIu74X4MILul3"
Content-Disposition: inline
In-Reply-To: <2ec95f84-2eaf-407f-8372-6f6e89eb1e3b@bootlin.com>
X-Authority-Analysis: v=2.4 cv=H4JOUOYi c=1 sm=1 tr=0 ts=6aaace57 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=AQCpnuTwkiGt/6pP7chwVg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=a7vlQkQE84izC6u3-4sA:9 a=CjuIK1q_8ugA:10
 a=pPXggMpnJ1fGgHuoTg8A:9 a=IoWCM6iH3mJn3m4BftBB:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: fvhvNbUrtsbgK3_d3oflH57BSRX3Cohz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIzNSBTYWx0ZWRfXzrkqSoZ7jNff
 2xDFrt5+WEsgB3q9iC/U+h9lxx+GDLBosJ3eO8mml2ogl62JAD4CAFlF/unzvDp8L12qnPrRS62
 kJXt0KXb5Id3HxUZt9KJ+zPot0U6jVOHijkdJt8S0FOZ7IZg8cyVDQ2u2Owwuff+S59SJymW/DL
 Olk5wu8RDRMMN6LgiPVamgKIe2vIfVljA4oImXmlpIKSdNMUkOAV/WMc4r+z/+azZdgUtOT+oIH
 NFHkKCiqh19PJGpIvPVh68Gyu9tqM0093J5aMMpPPPbAUs1JlifsqYWl1P/R6z0NvwYk7O0TLxn
 A7yh5aQBWr9l4CtEE6X2aX2/p/Q97W0c+9C8cxY/gnRPHOLDMwW1S/B3xHBZfEExVn63wzHzECL
 lM6Q5GFeHclYq4JQ0BPxucjlojEoNGhbDigxj+14HEcdbaJCkb8Jm/d2xj1hNyvIa1zagaCL8Ir
 1juqvXIU3t9P7Ppiejw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIzNSBTYWx0ZWRfXxlugwMra9ZN7
 6n/AfRJfkCmwTKwepZrT8CFYw1whAvP5VShYSSApli+3TO6w/2N3tcqzq2pH64xcEk00+XR2oBH
 09S/GELvoraGHSkjT3vmvJaxqtRMrU0=
X-Proofpoint-ORIG-GUID: fvhvNbUrtsbgK3_d3oflH57BSRX3Cohz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160235

--Im3uIu74X4MILul3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo

Hi Maxime,

>=20
> On 9/16/26 17:25, Lorenzo Bianconi wrote:
> > When a received frame is larger than dma_buf_sz, the DMA scatters it
> > across multiple RX descriptors (rx Scatter-Gather). The secondary RX
> > buffer (sec_page) was only allocated and programmed when split-header
> > (SPH) was active, so for regular frames buffer2 was neither allocated
> > nor backed by a valid mapping. As soon as an incoming frame overflowed
> > buffer1, the DMA wrote the overflow into the unmapped secondary-buffer
> > address, triggering an SMMU translation fault on IOMMU-based platforms:
> >=20
> > arm-smmu 15000000.iommu: Unhandled context fault: fsr=3D0x402, iova=3D0=
x00000000, fsynr=3D0x7f0011, cbfrsynra=3D0x1c90, cb=3D11
> > arm-smmu 15000000.iommu: FSR    =3D 00000402 [Format=3D2 TF], SID=3D0x1=
c90
> > arm-smmu 15000000.iommu: FSYNR0 =3D 007f0011 [S1CBNDX=3D127 WNR PLVL=3D=
1]
> >=20
> > Enable scatter-gather for non-SPH frames: always allocate the secondary
> > RX buffer and always mark buffer2 as valid in stmmac_init_rx_buffers()
> > and stmmac_rx_refill(), and account for it in the buffer length
> > computation. stmmac_rx_buf1_len() now returns min(dma_buf_sz, plen - le=
n)
> > on the last descriptor, while stmmac_rx_buf2_len() returns the remaining
> > bytes on the last descriptor and dma_buf_sz on the intermediate ones. T=
he
> > GMAC4 + split-header path keeps using the accumulated payload length
> > semantics, since there an intermediate descriptor's buffer2 can be only
> > partially filled.
> >=20
> > Fixes: 88ebe2cf7f3f ("net: stmmac: Rework stmmac_rx()")
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> Ah this is also nice ! Ran into that with the Jumbo Frame selftest, it
> spills into the next desc and it doesn't end well (at least on dwmac1000).
>=20
> I don't know how you've tested that, can you test it in conjunction with
> this patch too ?
>=20
> https://lore.kernel.org/netdev/20260911212028.1497613-6-maxime.chevallier=
@bootlin.com/
>=20
> It changes the way we select the dma_buf_sz based on the MTU.

Ack. My main goal here is to keep the default MTU/rx length (1536B) on
the stmmac device and to split the received packet (e.g. with length 8KB)
over multiple DMA descriptors.

>=20
> I'll run your series on the boards I have and report if anything weird ha=
ppens,
> but if you have some testing commands to share that would be awesome :)

If you want to test with a simple ping you just need to increase the MTU on
the sender (e.g. setting MTU to 7KB). In case you prefer to test with TCP, =
you
would need to change even the route MTU used by the stmmac device:

- sender:
  $ip link set <nic> mtu 7000
- receiver (stmmac):
  $ip route change <net> dev <nic> mtu 7000

Regards,
Lorenzo

>=20
> Maxime
>=20
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 25 ++++++++-------=
--------
> >  1 file changed, 8 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 1fb5f804ea23..be7cb0cafeb5 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -1659,17 +1659,14 @@ static int stmmac_init_rx_buffers(struct stmmac=
_priv *priv,
> >  		buf->page_offset =3D stmmac_rx_offset(priv);
> >  	}
> > =20
> > -	if (priv->sph_active && !buf->sec_page) {
> > +	if (!buf->sec_page) {
> >  		buf->sec_page =3D page_pool_alloc_pages(rx_q->page_pool, gfp);
> >  		if (!buf->sec_page)
> >  			return -ENOMEM;
> > =20
> >  		buf->sec_addr =3D page_pool_get_dma_addr(buf->sec_page);
> > -		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
> > -	} else {
> > -		buf->sec_page =3D NULL;
> > -		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, false);
> >  	}
> > +	stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
> > =20
> >  	buf->addr =3D page_pool_get_dma_addr(buf->page) + buf->page_offset;
> > =20
> > @@ -5097,7 +5094,7 @@ static inline void stmmac_rx_refill(struct stmmac=
_priv *priv, u32 queue)
> >  				break;
> >  		}
> > =20
> > -		if (priv->sph_active && !buf->sec_page) {
> > +		if (!buf->sec_page) {
> >  			buf->sec_page =3D page_pool_alloc_pages(rx_q->page_pool, gfp);
> >  			if (!buf->sec_page)
> >  				break;
> > @@ -5108,10 +5105,7 @@ static inline void stmmac_rx_refill(struct stmma=
c_priv *priv, u32 queue)
> >  		buf->addr =3D page_pool_get_dma_addr(buf->page) + buf->page_offset;
> > =20
> >  		stmmac_set_desc_addr(priv, p, buf->addr);
> > -		if (priv->sph_active)
> > -			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
> > -		else
> > -			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, false);
> > +		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
> >  		stmmac_refill_desc3(priv, rx_q, p);
> > =20
> >  		rx_q->rx_count_frames++;
> > @@ -5160,7 +5154,7 @@ static unsigned int stmmac_rx_buf1_len(struct stm=
mac_priv *priv,
> >  	plen =3D stmmac_get_rx_frame_len(priv, p, coe);
> > =20
> >  	/* First descriptor and last descriptor and not split header */
> > -	return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen);
> > +	return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen - len);
> >  }
> > =20
> >  static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
> > @@ -5170,10 +5164,6 @@ static unsigned int stmmac_rx_buf2_len(struct st=
mmac_priv *priv,
> >  	int coe =3D priv->hw->rx_csum;
> >  	unsigned int plen =3D 0;
> > =20
> > -	/* Not split header, buffer is not available */
> > -	if (!priv->sph_active)
> > -		return 0;
> > -
> >  	/* For GMAC4, when split header is enabled, in some rare cases, the
> >  	 * hardware does not fill buf2 of the first descriptor with payload.
> >  	 * Thus we cannot assume buf2 is always fully filled if it is not
> > @@ -5188,8 +5178,9 @@ static unsigned int stmmac_rx_buf2_len(struct stm=
mac_priv *priv,
> >  	 * Thus 'plen - len' always gives the correct length of buf2.
> >  	 */
> > =20
> > -	/* Not GMAC4 and not last descriptor */
> > -	if (priv->plat->core_type !=3D DWMAC_CORE_GMAC4 && (status & rx_not_l=
s))
> > +	/* Not GMAC4, or non-SPH and not last descriptor */
> > +	if ((priv->plat->core_type !=3D DWMAC_CORE_GMAC4 || !priv->sph_active=
) &&
> > +	    (status & rx_not_ls))
> >  		return priv->dma_conf.dma_buf_sz;
> > =20
> >  	/* GMAC4 or last descriptor */
> >=20
> > ---
> > base-commit: ceac0de741bfb47ca255eee075257b3bb31f0651
> > change-id: 20260916-stmmac-rx-sg-fix-a8d2d8a3ba01
> >=20
> > Best regards,
>=20

--Im3uIu74X4MILul3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqrOGAAKCRA6cBh0uS2t
rEc9AP9lSxuJ98JUZ5NxlDXvDdE1CpA/9FW+O7HPw5YG+Vr8SAEA72d2As0gaD79
SwV5DGTakhWkPgzYvdCuvCZPG+diNwE=
=L9Kn
-----END PGP SIGNATURE-----

--Im3uIu74X4MILul3--
