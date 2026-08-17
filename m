Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCD7471D18
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002194; cv=none; b=md11JEEAgtbYxiUN9oqz06F8sUBg3fxHPvmL6FRzGofcVO+WR7bxqx+FV8ReXkvl5ymmmAeT46Z0fijbfif3CyTy57+I5LLZYtsCBJT8Ofd2iUz6Un/RjX5hCgnEl35Q0Rn17+aWoyrP596zkAZhp+at7/Pa3ZEgcjoxSRwpW/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002194; c=relaxed/simple;
	bh=e0S6goGner/2wPXsalWvIU/DZ7bM5b6pGzVwjkqck/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXfJAsqU2/CIKZqv7Rcd8sF9n8rK2p7DujJcJxVAonpZbt9s8rTswtfz+9d6s6GkzJMl60kA21m24hmblWlxOYzxcopYh41iZdTUohkz5lR7KZqlnKyWXu2joCZTKvA9jSPH7kgJj0EdjC2PI8/uTxTzkRQVMvi8jXlCopOXa3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kTUjMM/l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DL4jALHg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kTUjMM/l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DL4jALHg"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIR5593649830
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 21:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EscPOpDYNYn67TaC3QAFzk0j
	+ZR8OzOIR14DT/DHQiI=; b=kTUjMM/leo8pwUL1jF+Njy41T7P6BsXW2mGXDUZ7
	T5FY2ngkkzMbAhdsxPs4TDlAxrWSCs2gvQn6M2T8xdvyks3iPk0RteowWKDLYjFu
	kzQrjWqqE4eU0l8Dzb7HKq6D/0mI1Jw1SO7zRR/TNAzvW5F2brwJaHdrHqwVG1jQ
	ldO/Mc+2xuSxGrm4llWQxrhVQgCzaaFjeM5WxaNZixf8levtrA9G2+jIKfmEjdAp
	GtNGhbUOaqrnu9xD+BNwzZ2qA/KEe9vkuQj2bmd1Do3RtnsOlukPxVALno7RxXw7
	buc50QHTqYIZ3C/Qdb0mtzNrnpjzbPZYGMzQvQ16xb9F0Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3wm7ubjw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 21:29:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccd1958e8fso61549825ad.2
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 14:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787002191; x=1787606991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EscPOpDYNYn67TaC3QAFzk0j+ZR8OzOIR14DT/DHQiI=;
        b=DL4jALHgWYaGrLXgBgx5/EfkMXJdbPpotewB2ho2ArTpJSykEkKCakUCs4yFzuZgPn
         /by0OX1VV52YWLNqafjdS+zLpzoxWatDhDUmUP5DARTUKXGU1DlPLNvx4rKItNwqWpru
         cNO5BGpt/KOg+xe7EJ2PSw1LesvMnG/jflfJJtviFhItAsIX/Ij/6+R3cL5qoTtK/U80
         KXpUDFMsaBsTO6ZALGEh1wuJ0pzjuT+xECVzFliEl6gZa3HNvDwarL5+wduMWxr3cO3s
         pJr2hsScV1M/Dc7MLeh3ZqSZTCbacJOoopECnqODo074i5nTT9gq46oSBCeLfRTAPG6R
         suCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787002191; x=1787606991;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EscPOpDYNYn67TaC3QAFzk0j+ZR8OzOIR14DT/DHQiI=;
        b=brGG/fw0JmjgLx+wWrv55a4kcfIGyTXCm9vJH22JZW2UOfvzViewJA70/Y5sd+qhzR
         LaXQW4ExfEe/J/fxaR1mBqYdsnZOrQ2trjs67tiBrSNbDHFNDu3szgt+VZBDCfQw4EIQ
         /+mmcHHK19W1iBw2TQcctPPgLzIgMSS9GUtunT1IiwQ3uXEuxaHPCgUQ3CzlNHmJbf+E
         t3Q4PUolmfCVHk+DLkhT59IPkGcvvcv5igseGalqN6HwagCDWPRjjvtUbuHSCTNteJge
         L08zj3oKwXHakQLvQQxWS5ztU8jU4i7Y4SalUw/niTHKQmi1i2l6w3krCg4ahe6lzjrV
         pd1g==
X-Forwarded-Encrypted: i=1; AHgh+RrSytmvPhZYrC1eg7vqyT7C3NhKkSENiY8crhhUU/a0BPfPsEer0u8SHLL2uh+9qCIuLG7wZeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQgiv7276/7DL5pOXprVN8tWWimm3x1jDZZLVVeLwqsqls12ia
	VcJcKbdKhtR6882OERpfmY6/F57ogYh1W62uLfcSbyo/8CDPxCxpbLi8MrNFzvb3rVOne0LdST0
	PoiV6KFEdiwnQI8Uu0O/+2tm3sj3uY0K4VEJm/yH08u+O+EFWy3tTzqrb9Ik=
X-Gm-Gg: AR+sD125M4IYgbVjlg9t8gjr/wqxorcpacGN5mCuVCcMPUUFR11fhcQo6PiXthECw2V
	LfcALEYFLtzXONK6Y/mnU+OfT3a+tchcZCd4C28kybFqvdikilRU9RysGxQqEVODq2bdc3I4OeL
	yXdydToODeUMb+NOq2QJpg6AUpeiy9FSWoFNfwWR+239PMdWMxC5xuXurnBMGDxfjvUtEeFcszs
	JWZNIxHtqv7Tip1EqXqf+VbBYD98nVaEIU2s2aMEcs7PEaNabBJ2veovfZwLBQlPR+KRlXlamEW
	gSesXM65quQo//RcJ5NGHlF1Y5ynvaNGTR++dRtpNvChOR9gzHKm3Ro+q41NwoQI+oIO7wKn83C
	iVrjhe18SvNTxCMA6/IHF
X-Received: by 2002:a05:6a20:d52c:b0:3cb:b3ea:858a with SMTP id adf61e73a8af0-3cc71ca23b6mr30949962637.20.1787002191287;
        Mon, 17 Aug 2026 14:29:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:d52c:b0:3cb:b3ea:858a with SMTP id adf61e73a8af0-3cc71ca23b6mr30949883637.20.1787002190645;
        Mon, 17 Aug 2026 14:29:50 -0700 (PDT)
Received: from localhost ([2605:59ca:800f:5110:246a:f60e:9bc5:ae0a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-326798cb9f5sm11009602eec.13.2026.08.17.14.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:29:49 -0700 (PDT)
Date: Mon, 17 Aug 2026 23:29:48 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v2] net: stmmac: keep gso_enabled_types in sync with
 netdev features
Message-ID: <aoN9TM4BrnEXt8Qx@lore-qca>
References: <20260812-stmmac-fix-tso6-features-v2-1-72c3b06eb8d4@oss.qualcomm.com>
 <20260817131416.409fc7fc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gLgKYaYlMyj7cH5d"
Content-Disposition: inline
In-Reply-To: <20260817131416.409fc7fc@kernel.org>
X-Proofpoint-GUID: nxTAbkFRoSy6-ggVoew-NwCR7W6nGk_m
X-Proofpoint-ORIG-GUID: nxTAbkFRoSy6-ggVoew-NwCR7W6nGk_m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE2NCBTYWx0ZWRfX+T5zlN9nCskO
 PHVBYEjZV3cHOUNjzmQ/dTJHhg3zL4rp2F2QuMXeHHZWBbIQ8Z1q5ZvOMRTSudQRAMGpasFcJlB
 SDwSVcXw3X08Qe6Xsq3ySQ7zd+DSsq6sJj62D8vL4jlGaXIBxcX4PDJR459bJYBnjimC3usknBP
 yqKOslAFrx/7p0x8K3Gxd+rRHzzgPVa1JupR8pHHrP4cY9IMxITLhVGAaydgiBnmuiCHZ33LwbL
 RupJHNi8ocLnF1pXJg9Ss9Aj37uVeQFvWwwK69VCjkp7YNXyzKyu+hOLSbBTZyioz4mOk2+2cRS
 KuyGZmwWOQR6TKzX23Ecbuvi8NaWRp1gTlNTb4zS/8ydaF4mRnw6LPxPLCN9MiYd/py8SQsDcRR
 IvAzrS8MNNgxJqGFhU3lLiXqYtG3adJvYo7GEoy6OOkrMe9G/oYuvwAE0Ljzjz7CE8sp0t60dKL
 qi0GirSvATz4yK0wvdA==
X-Authority-Analysis: v=2.4 cv=YqM/gYYX c=1 sm=1 tr=0 ts=6a837d50 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PHq6YzTAAAAA:8
 a=pYFe1_jzmwtMJlaTMGcA:9 a=CjuIK1q_8ugA:10 a=xjuSOcxbN7U8p7k89moA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE2NCBTYWx0ZWRfX7ADPTV1b45b0
 Y9Z8RrO1Dg5KEEnEhHKtl7S7n42HHEmDesksIjIGZ8NZb+tqg1t89EDeqOMfFvUsJSpJUAgGyLW
 UYAXHqbueKGI7DyQ0aoDz/46cp49f+8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170164

--gLgKYaYlMyj7cH5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 12 Aug 2026 06:38:13 +0200 Lorenzo Bianconi wrote:
> > stmmac_set_gso_types() derives priv->gso_enabled_types all-or-nothing
> > from NETIF_F_TSO, but stmmac_set_gso_features() advertises NETIF_F_TSO,
> > NETIF_F_TSO6 and (on GMAC4) NETIF_F_GSO_UDP_L4 as independently
> > toggleable features. Since netdev_fix_features() only ties TSO6 to the
> > checksum features, disabling TSO (ethtool -K ethX tx-tcp-segmentation
> > off) leaves TSO6 enabled in dev->features while gso_enabled_types
> > becomes 0.
> >=20
> > For a TCPv6 GSO skb the stack then keeps the frame unsegmented
> > (NETIF_F_TSO6 is still set), stmmac_features_check() does not clear the
> > GSO mask, and the stmmac_xmit() gate (gso_type & gso_enabled_types) is
> > false, so the multi-MSS skb is transmitted through the ordinary
> > descriptor path as a single oversized frame.
> >=20
> > Derive each GSO type from its own feature bit instead, so the mask stays
> > in sync with dev->features and TCPv6 (or UDP L4 on GMAC4) segmentation
> > keeps working when only TSO is disabled.
> >=20
> > Fixes: 9edfa7dab811 ("net: stmmac: enable TSO for IPv6")
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > ---
> > Changes in v2:
> > - Fix possible race between stmmac_set_gso_types() and stmmac_xmit().
> > - Fix fixes tag.
> > - Link to v1: https://lore.kernel.org/r/20260808-stmmac-fix-tso6-featur=
es-v1-1-f82b17595052@oss.qualcomm.com
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 28 +++++++++++++--=
--------
> >  1 file changed, 16 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index a71f0df26378..df3549f55741 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -4371,16 +4371,20 @@ static void stmmac_flush_tx_descriptors(struct =
stmmac_priv *priv, int queue)
> >  	stmmac_set_queue_tx_tail_ptr(priv, tx_q, queue, tx_q->cur_tx);
> >  }
> > =20
> > -static void stmmac_set_gso_types(struct stmmac_priv *priv, bool tso)
> > +static void stmmac_set_gso_types(struct stmmac_priv *priv,
> > +				 netdev_features_t features)
> >  {
> > -	if (!tso) {
> > -		priv->gso_enabled_types =3D 0;
> > -	} else {
> > -		/* Manage oversized TCP frames for GMAC4 device */
> > -		priv->gso_enabled_types =3D SKB_GSO_TCPV4 | SKB_GSO_TCPV6;
> > -		if (priv->plat->core_type =3D=3D DWMAC_CORE_GMAC4)
> > -			priv->gso_enabled_types |=3D SKB_GSO_UDP_L4;
> > -	}
> > +	unsigned int gso_types =3D 0;
> > +
> > +	if (features & NETIF_F_TSO)
> > +		gso_types |=3D SKB_GSO_TCPV4;
> > +	if (features & NETIF_F_TSO6)
> > +		gso_types |=3D SKB_GSO_TCPV6;
> > +	/* Manage oversized UDP frames for GMAC4 devices */
> > +	if (features & NETIF_F_GSO_UDP_L4)
> > +		gso_types |=3D SKB_GSO_UDP_L4;
> > +
> > +	WRITE_ONCE(priv->gso_enabled_types, gso_types);
> >  }
> > =20
> >  static void stmmac_set_gso_features(struct net_device *ndev)
> > @@ -4416,7 +4420,7 @@ static void stmmac_set_gso_features(struct net_de=
vice *ndev)
> >  	if (priv->plat->core_type =3D=3D DWMAC_CORE_GMAC4)
> >  		ndev->hw_features |=3D NETIF_F_GSO_UDP_L4;
> > =20
> > -	stmmac_set_gso_types(priv, true);
> > +	stmmac_set_gso_types(priv, ndev->hw_features);
> > =20
> >  	dev_info(priv->device, "TSO feature enabled\n");
> >  }
> > @@ -4766,7 +4770,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *sk=
b, struct net_device *dev)
> >  		stmmac_stop_sw_lpi(priv);
> > =20
> >  	if (skb_is_gso(skb) &&
> > -	    skb_shinfo(skb)->gso_type & priv->gso_enabled_types)
> > +	    (skb_shinfo(skb)->gso_type & READ_ONCE(priv->gso_enabled_types)))
>=20
> Maybe I'm missing something but I don't see any device configuration
> based on gso_enabled_types. Why does this mask exist in the first place?

gso_enabled_types field has been intrdocued in the following commit:

commit 2e4082e4b739191d71e03fe6c55cec68d36f67fe
Author: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Date:   Wed Apr 1 08:21:55 2026 +0100

    net: stmmac: simplify GSO/TSO test in stmmac_xmit()
   =20
    The test in stmmac_xmit() to see whether we should pass the skbuff to
    stmmac_tso_xmit() is more complex than it needs to be. This test can
    be simplified by storing the mask of GSO types that we will pass, and
    setting it according to the enabled features.
   =20
    Note that "tso" is a mis-nomer since commit b776620651a1 ("net:
    stmmac: Implement UDP Segmentation Offload"). Also note that this
    commit controls both via the TSO feature. We preserve this behaviour
    in this commit.
   =20
    Also, this commit unconditionally accessed skb_shinfo(skb)->gso_type
    for all frames, even when skb_is_gso() was false. This access is
    eliminated.

>=20
> Right now AFAICT packets which miss the mask check get chucked on the
> wire as one giant frame, without segmentation.
>=20
> Can we just delete gso_enabled_types completely? Stack should obey the
> features for future frames, and avoiding races here may be hard.

I agree we can just remove gso_enabled_types field since if the user disabl=
es
TSO or UDP GSO, the driver will receive segmented packets for particular
traffic (the segmentation logic is managed by the stack). I think it is eno=
ugh
to gate packets for stmmac_tso_xmit() using skb_is_gso() check.
I will fix it in v3.

Regards,
Lorenzo

>=20
> >  		return stmmac_tso_xmit(skb, dev);
> > =20
> >  	if (priv->est && priv->est->enable &&
> > @@ -6198,7 +6202,7 @@ static int stmmac_set_features(struct net_device =
*netdev,
> >  			stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
> >  	}
> > =20
> > -	stmmac_set_gso_types(priv, features & NETIF_F_TSO);
> > +	stmmac_set_gso_types(priv, features);
> > =20
> >  	if (features & NETIF_F_HW_VLAN_CTAG_RX)
> >  		priv->hw->hw_vlan_en =3D true;
> --=20
> pw-bot: cr

--gLgKYaYlMyj7cH5d
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaoN9TAAKCRA6cBh0uS2t
rOloAQCVbuBB852UJgcGmrzlPkDB1pdYSHB+9WosXCXnz09j5AEAvL4j7ZI662Ma
1F7w7Q4Xwm1FEGMh3ebu5KEKNvqDZQw=
=rpY+
-----END PGP SIGNATURE-----

--gLgKYaYlMyj7cH5d--
