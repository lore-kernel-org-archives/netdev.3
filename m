Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386747;
	b=nyVkmwDuzHLnOmsl6Rn5pGkWscELnBQKcNVwP2V5Rihk9fBKBbg/cqTPWu3E+KPFFb25
	 1kmliJjL/GJSelYvIkoZO3MBy/LnkxC4klXWuNz5IYaMX80MJnQYEKwlefPYnEiWc2UNS
	 yKNaiKbAeN3crxXmxlLWCNwyAxNXNhWStRTD0Vy6l94GLsKeAkDHUkLYZ5asbS7EUDyyG
	 p27pWTiX7JZctE35WZ8c1pG4mm0iHAt4RuLa0Syr3qYFhM+fPZ5aIfztN6oow3xzthEwE
	 mgx6TQcNTowcX7DBNN/NgIXorJFHdtAlI9b+sSb+UFZ4X76VpO0/RgiET1KLCK5atFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386747;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+X3ktU4+fA/Z3wgtO0+WcGE1/Xq2+nGdw+oL+ADG90k=;
	b=BZJOuKkn2RvHF6ws2bxgWIKp8sUkANneT0AAHBbKXi+kTW/PFyXTPz5i7Xy1l2gF3KHb
	 i9h0IAarZHnW3cWl8sItdtoNuuMD0FwkDMGaoOPrXfgOANyAE70X5jB6twyq8XtakhtKS
	 IBRSrUqU5mVR96PYDugaIbxVKknPHVf6731jBssKpp6BXJkQd9MUATodsB0U/NcOAGuUi
	 dzwQJ0x5GrhVLQ5hBCVnabTNkQA0qfQELTnYQFjq/bn5WJxXgbMSEchUjKb5kv7IMYuOm
	 Ie0g4NUminvAprMsPlXBGczm2W4QfH5P/kozJ/9h4cxy+kphkKX1nl7drjF5rBpoAWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hu6+dpU2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Ed//Hcbl";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74634606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74634606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hu6+dpU2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ed//Hcbl
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KNX53958974
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+X3ktU4+fA/Z3wgtO0+WcGE1
	/Xq2+nGdw+oL+ADG90k=; b=Hu6+dpU2pV9HACagcr/adWmF+uHdC+3tPrRE7qKP
	h2AkBKZraIZ0yLeZHiTSqDadvgclY9GJYR4as0Fm1epguzi9XZbZ+chy5HdXfXEm
	Jsd5rRJ+UByFfk9oA/icNRhCd2OTAggzp00VyLZ9EKNK0kLHyNRN/0gSyAvLh30t
	9+fuXf/abJX/4hbEommxgwc5WOrjweiWg7oytXW7nWtsyafLI3M9X60+LG8agxLC
	v+K15qwbk9GTKzCJ/m60e/2LuwE2dFYYnY/L5sKvvGJpD8fCNC9bDhRNYa9++jEp
	BZuJWKk8F7oIO0A+qumU/K9COIWOJ9mOe2fkS091hieb3A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b32qh4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:45:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-94776ee7bf0so483584685a.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794386745; x=1794991545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+X3ktU4+fA/Z3wgtO0+WcGE1/Xq2+nGdw+oL+ADG90k=;
        b=Ed//HcbljBgtIZJEelXWh7mw5yb0Lz57Neu7Tw0Amd1PBMBYTNZU81dssPywnEho2+
         DMC/JvWagUqF8dJz0Hv+7xtjBIVPyl+LI9Os1rpOdboR7jJk/JfZnnhGT2X97JaVGM0j
         IuQufET9gIv0phJDBCmpegjEUJ5yxME5Lfho8fbWoMajTA+5cQmBxWlLrOt8Xgiu0cIA
         5Wdsj1uU3wc7FJuLowuGRB/UgLIu4hMfF2O18FKQjiUQt8vArWJkNKLit1E7NXdb6ip1
         dGdoSrLFFw8Qo0pwGQ1wdnHh3RyzyJNLdRBnhTo/ZVpKLUSpxTqnSjtK1XGKBQwfebAN
         26Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794386745; x=1794991545;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+X3ktU4+fA/Z3wgtO0+WcGE1/Xq2+nGdw+oL+ADG90k=;
        b=wOm3LWwY4AGodKcMpen+KKls5XjqRioC4AgJ+kpU4+Wu2yEzw9R5tnujpYIpoy2wh5
         T1Pb3WrAoHpoL3NpvDmTD6EqH0+O8oNBJhAXL8n0hdxN0v996d5xs9MSDeEK3vkTInUF
         DIRQFvI8soVpqjtiPtMQlKR/Uidw0O60NBYQwZGjeXAjkNbQRMEocBJtMjmiSbMhOlCw
         uiEBM4MxHLOhNaje/A+kppFhMXMQcsTn1zoVKBL1Ft/JR51fGeju1PD0RI48LQde05Hs
         /QYnC9UgVNGjYvwG76IWyxcWvfuVu/tmN7k8GoaxcHQU56kY/5hA1iayvw7gBQjttEaX
         Cfjg==
X-Forwarded-Encrypted: i=1; AL+hErGDyJiyach3M+qdXaQ8YYIEV+LHXrjj0TuKY0BqFYgCs5CM0k+zHJnqZNJl5DmJABUOwSMhfDg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Xrey5QeVdqRFic4sRWjRu9s3S2RbLE7de1IYttxAAwkwiC0ni
	paE8wSgZOLWilVX/CzS1WmQwyt6ERwp/7A50uh7aHf/YvpCusA4Cn1boZiwUGDwbOSruByzYoe1
	lwrVIEqzQmYv8n9aEJIOAPVGofSe9qZAPXM6vIGGZoCxfCY7dLlvhKD22c0I=
X-Gm-Gg: AYBFou35+X3fDPcXH3yav6gxnaGqtR+qJb6lGjipbEoV78KHY2xXJI4RIf3Wtd9mQIU
	WirJDs78wUM68aKaiu1wM3RqoO7htsyjKvfr+SYW+78tp/Suy4ZPQeZO0YBCwi7pr39SdpOaUDB
	yP277E0uYaUH/HGuxV1k2TJXwD1TpS/m7080T53fqxADu1njdVUKRvlL1b8+LbEn1CVG9F8Nxns
	gDjx4XEF5POokb+kfTQg2vYOc7uap8lOi88bvwP1Tpv97dikVE7TX0zU6LtenmWBEAPHk3tndYo
	P655ZSQv9htLfODAYLjhKHUNtbr3czUevfckkKQYBFADDhT16vDVc8MFeZc6Ca4LFIN2PBYELUl
	EeWfuORtB8yzr/VKDzB47Ss9t9KU02PBQFx1jNWgTW7MmX12wKZvIrWTkFdg0KZY=
X-Received: by 2002:a05:620a:1a14:b0:944:9cb:d41c with SMTP id af79cd13be357-947afff4777mr273500985a.19.1794386745318;
        Wed, 11 Nov 2026 00:45:45 -0800 (PST)
X-Received: by 2002:a05:620a:1a14:b0:944:9cb:d41c with SMTP id af79cd13be357-947afff4777mr273498785a.19.1794386744704;
        Wed, 11 Nov 2026 00:45:44 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0204342asm144103945e9.6.2026.11.11.00.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:45:41 -0800 (PST)
Date: Wed, 11 Nov 2026 09:45:41 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, Jose.Abreu@synopsys.com,
        boon.leong.ong@intel.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        nb@tipi-net.de
Subject: Re: [PATCH net-next v9] net: stmmac: rework stmmac_rx to support XDP
 rx multi-buff
Message-ID: <avQrNbqkkREH4-mu@lore-desk>
References: <20261106-stmmac-rx-mb-v9-1-c099c923664b@oss.qualcomm.com>
 <179431886808.994134.6784700644892681429@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gJMFUCSiM5fJQdUO"
Content-Disposition: inline
In-Reply-To: <179431886808.994134.6784700644892681429@kernel.org>
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af42b3a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=Lv1XPQFk8ofifZRQ4s0A:9 a=wPNLvfGTeEIA:10
 a=5_ymsXbCtldPo5z8VK4A:9 a=NFOGd7dJGGMPyQGDc5-O:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzNCBTYWx0ZWRfX6dHhQowMI5Yf
 gAuUiV8rvLOd4hRbw7GMOxwfxFIp9NydYCE1seZWmuGMZ8KBksd8GfX0m8JvcACrwtIRsR829vV
 Lbr9+U7agPTdC5pdOi0taHncPeM4cUxiDX56SzV9B1rrgbRUed3TrqVTamkpsnogZDigt9NgE74
 eCWpvAA334QQDxHHAlnWRoI+bL5WJj1KztFE5GH2PSfMhI66W0iY5WP37bvX2s5gHCix6HKM/WZ
 mEQNlDB6hR9Wre8c7K0o3MKQWCQH6dEv90oyZ5jf4EoQaBgApZ+C3cSfFALZFGFLgu9rHc/UNlA
 4dAgvcGdvt8qbd+31ojtpVJggb//ON4xObGw44hJBBn+ez9NksV73D56HKPUxBp4Bu4T9MW9KsJ
 kp9KGrJO6L49iDHQ2J53E3oVjnwLvk3d+07gY2rAQW3PPqNlDA/RgUFBeMBPtfUmIhmuNvugx6L
 s0VbmQZqfV+TSsR5wrw==
X-Proofpoint-GUID: lQ87qn1CN4YE80gzcuEqJLrPAZt7o7iw
X-Proofpoint-ORIG-GUID: lQ87qn1CN4YE80gzcuEqJLrPAZt7o7iw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzNCBTYWx0ZWRfXxAUFDidkVVRz
 tXLJHE0bF/lk/MltOZB/UuYoYEwxcg7qDAk2tf0cIC0NrM0fANgrituOL0Tu13V+Goz/+EkIg32
 RcLnsH9UIthPYyItLntiKg62DZa4D0U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110034

--gJMFUCSiM5fJQdUO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 =B7 High: 0 (1) =B7 Medium: 1 =B7 Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] The skb head truesize grows on every received frame, including
>   with no XDP program loaded, and the commit message does not say so.
> - [Low] The commit message overstates one change.
>=20
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the patch
>   makes it wider.
>=20
> --
>=20
> net: stmmac: rework stmmac_rx to support XDP rx multi-buff
>=20
> This reworks stmmac_rx() to collect all the descriptors of a frame into an
> xdp_buff, so programs with frags support see the whole packet. On XDP_PASS
> the skb is built from the xdp_buff head and its fragments. The patch also
> saves the in-progress xdp_buff in rx_q->state across NAPI polls, advertis=
es
> NETDEV_XDP_ACT_RX_SG, and strips the FCS with a driver-local tail shrink.
>=20
> > - carry the XDP metadata written with bpf_xdp_adjust_meta() into the skb
> >   via skb_metadata_set(), so it is no longer dropped and TC/BPF programs
> >   can read it through data_meta;
>=20
> [Severity: Low]
> Is this item accurate? The XDP_PASS path in stmmac_rx() already did this
> before the patch. The patch removes these lines from stmmac_rx():
>=20
> -			metasize =3D ctx.xdp.data - ctx.xdp.data_meta;
> -			if (metasize)
> -				skb_metadata_set(skb, metasize);
>=20
> The same logic now lives in stmmac_build_skb().
>=20
> Metadata on linear frames was not being dropped before. The only frames
> that never got metadata were multi-descriptor or buf2 frames, and XDP mode
> dropped those outright. The commit message already covers that elsewhere.
>=20
> Could this item be reworded so it does not read as a fix for a metadata
> loss bug?

I guess this is minor point, I can update the commit message if I need to
repost.

>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index a2177777727ef..c215cc70caa19 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>=20
> [ ... ]
>=20
> > @@ -2290,10 +2294,6 @@ static int __alloc_dma_rx_desc_resources(struct =
stmmac_priv *priv,
> >  			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> >  	num_pages =3D DIV_ROUND_UP(dma_buf_sz_pad, PAGE_SIZE);
> > =20
> > -	rx_q->queue_index =3D queue;
> > -	rx_q->priv_data =3D priv;
> > -	rx_q->napi_skb_frag_size =3D num_pages * PAGE_SIZE;
> > -
> >  	pp_params.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> >  	pp_params.pool_size =3D dma_conf->dma_rx_size;
> >  	pp_params.order =3D order_base_2(num_pages);
> > @@ -2321,6 +2321,10 @@ static int __alloc_dma_rx_desc_resources(struct =
stmmac_priv *priv,
> >  	if (!addr)
> >  		return -ENOMEM;
> > =20
> > +	rx_q->queue_index =3D queue;
> > +	rx_q->priv_data =3D priv;
> > +	rx_q->napi_skb_frag_size =3D PAGE_SIZE << pp_params.order;
> > +
>=20
> [Severity: Medium]
> Does this change the skb head truesize for every received frame, even when
> no XDP program is attached?
>=20
> Before the patch the head size was num_pages * PAGE_SIZE. Now it is round=
ed
> up to the page_pool allocation order, and skb->truesize is derived from it
> here:
>=20
> stmmac_rx()
> 	bufsz =3D rx_q->napi_skb_frag_size;
> 	...
> 	xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
>=20
> stmmac_build_skb()
> 	skb =3D napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
>=20
> On 4K pages, a dma_buf_sz of 8188 (BUF_SIZE_8KiB) gives num_pages =3D 3, =
so
> the head grows from 12K to 16K. A dma_buf_sz of 16368 (BUF_SIZE_16KiB)
> gives num_pages =3D 5, so the head grows from 20K to 32K.
>=20
> That shrinks the effective socket receive buffer for jumbo MTU users who
> never load XDP. The commit message calls out the fragment truesize change
> as a behavior change, but not this one. Should this be mentioned too?

Same here, I guess this is minor point, I can update the commit message if
I need to repost.

>=20
> [ ... ]
>=20
> > @@ -5962,120 +6073,79 @@ static int stmmac_rx(struct stmmac_priv *priv,=
 int limit, u32 queue)
>=20
> [ ... ]
>=20
> > +		skb =3D stmmac_xdp_run_prog(priv, &ctx.xdp);
> > +		/* For Not XDP_PASS verdict */
> > +		if (IS_ERR(skb)) {
> > +			unsigned int xdp_res =3D -PTR_ERR(skb);
> > +
> > +			if (xdp_res & STMMAC_XDP_CONSUMED) {
> > +				stmmac_xdp_put_buff(rx_q, &ctx.xdp, true);
> > +				rx_dropped++;
> > +			} else if (xdp_res & (STMMAC_XDP_TX |
> > +					      STMMAC_XDP_REDIRECT)) {
> > +				xdp_status |=3D xdp_res;
> > +			}
> > +			goto next;
> > +		}
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but multi-buffer frames can now
> reach XDP_TX, which makes it worse. Does XDP_TX completion recycle pages
> into this RX queue's page_pool direct cache from the wrong NAPI context?

As pointed out by sashiko, this issue has not been introduced by this patch=
 and
it should be fixed with a dedicated patch.

Regards,
Lorenzo

>=20
> stmmac_xdp_xmit_back() picks the TX queue by CPU, not by RX queue:
>=20
> stmmac_xdp_get_tx_queue()
> 	while (index >=3D priv->plat->tx_queues_to_use)
> 		index -=3D priv->plat->tx_queues_to_use;
>=20
> Completion then runs in that channel's tx_napi:
>=20
> stmmac_napi_poll_tx()
>   stmmac_tx_clean()
>     xdp_return_frame_rx_napi(xdpf)
>       __xdp_return(..., napi_direct=3Dtrue)    /* head and every frag */
>         page_pool_put_unrefed_netmem(..., allow_direct=3Dtrue)
>           page_pool_recycle_in_cache()
>=20
> stmmac_tx_clean() {
> 	...
> 		if (xdpf &&
> 		    tx_q->tx_skbuff_dma[entry].buf_type =3D=3D STMMAC_TXBUF_T_XDP_TX) {
> 			xdp_return_frame_rx_napi(xdpf);
> 	...
> }
>=20
> When allow_direct is already true, page_pool_put_unrefed_netmem() skips t=
he
> page_pool_napi_local() check. That means pool->alloc.cache and
> pool->alloc.count are updated without a lock.
>=20
> The tx_napi is a separate NAPI instance from the rx_napi that owns the
> pool. Meanwhile the owning rx_napi can be on another CPU running
> stmmac_rx_refill() or the allow_direct=3Dtrue puts in stmmac_xdp_put_buff=
(),
> stmmac_build_xdp_frags() and stmmac_xdp_shrink_tail().
>=20
> Can this corrupt the alloc cache? If so, the same page could be handed to
> two RX descriptors, or recycled while an skb still holds it.
>=20
> The race dates back to XDP_TX support. With this patch, though, each
> XDP_TX frame can push the head plus several fragment pages down this path.
> Would returning XDP_TX frames with xdp_return_frame() in stmmac_tx_clean()
> avoid this?
>=20
> --=20
> Sashiko AI review =B7 https://netdev-ai.bots.linux.dev/sashiko/#/patchset=
/20261106-stmmac-rx-mb-v9-1-c099c923664b%40oss.qualcomm.com

--gJMFUCSiM5fJQdUO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCavQrNQAKCRA6cBh0uS2t
rEHxAP4yTs3XsBIlnOt4lrybgaZSoFNAmTd4XbIZuJ3aij9V+AEAqpQa28+iqzeF
oCunqOu8nRR8JPtar518G+PA9CcdfwQ=
=IEXt
-----END PGP SIGNATURE-----

--gJMFUCSiM5fJQdUO--
