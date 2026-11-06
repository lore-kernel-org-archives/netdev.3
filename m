Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954709;
	b=36w7v2p1kaBJhnCoTyK6abcavYK5crQrK6t7Kh161NkccILgNd/PD0UJTjuAVBOc7E2p
	 uBjTcjrRJnqk8DJBRp/nCMOcQEJH1Z1HnBF4u2LrA6ffvWXkBF+f/8Amv7pgan1GuIhBG
	 W2zAsGBEFgIx0zX53mdWiS36SpJQ9b3dH/BneMSV2LYU3hAUAK+U6+oThxIqQ7i9RnbRF
	 WWBlZT+1Gf3tWR1YJR5W4xJ1cFq/Cka1ktLtg/Elo9CQJGWLN6raAmMXK+UpxIBeUCDqq
	 IhltRih3ogE1BU6KBnZ8K+HUTgz+Gqkj0dIfLENT8q1Eb5N+0+WIywc3H+zXMX6SKAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954709;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NA0fJ+/oBhW7wShePAgbVR2p7KjXGENPkxQ0oB5Wpwg=;
	b=2nre8mqjr745BfYWgS6LSHaz5Nsvy4pf4dh4dEgLBVBzi+YHeDLdiSoLeiH3R2NDCoqt
	 htW/dFJa0gVHRrqjDN9oQpIVn8uX53Z5KqR8yhNoSWLRN37sc3MY/e2ZnZTlFa6v1KWqx
	 3sUs11GW9ipwxZh0/uQefGPfZePBpyHb9vOm3mOWY9gQeZ566uxYri6K/n64ZLiTJny8p
	 9bvgeBWEwpSmFZ++V9+vm8uHUN3JO9MiEPu1TR89LPJDYS0EgO93FRVgh+NVhjM2AaCJb
	 Rkpo1v3uDwZJR/b9vg/eXZaumCLvFQS3C4zkqYiiS2KqO/VdQ51xrAZ30cz5L61aWAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yw3bl58p;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eYQx+rDa;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30362606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 08:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30362606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yw3bl58p;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eYQx+rDa
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A67RkOB3883394
	for <netdev@vger.kernel.org>; Fri, 6 Nov 2026 08:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NA0fJ+/oBhW7wShePAgbVR2p
	7KjXGENPkxQ0oB5Wpwg=; b=Yw3bl58pj4Rz2reuhM20My+jZEL+GycKtt4fkPAo
	78Z4fcmCljx3eIxYPnilsFXsNdZgk3Ak1WxZVIQLfwqO8cLOq46DZ9rNFlNC9bC0
	uMIQyPWfwOQ47YroHKw0TjSHhG53NUTdzwmJONqH3hFTfgk8gVdyjd+AIjRqx0T1
	DV6hItwMQg/RcFjaMIu21fyIk/iMpK14dus+K+IKEeQ4iqtJvKmqAYl42kLACR2K
	ifj59ozha+cYE1BSCYC5j5zMTMIjYkhlrsyn3zha0qIOxkg2Ncu/w7nnrdtytIZZ
	iKYtKZwLdxehu4jYQbuCGumzfdpfN/JpzSzHLy7lpPkj7g==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pb1xqv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 08:45:07 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7bf3a6cf1c8so368627137.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 00:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793954707; x=1794559507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NA0fJ+/oBhW7wShePAgbVR2p7KjXGENPkxQ0oB5Wpwg=;
        b=eYQx+rDaT4XOIQtnH49lLcV2/6UYgKKAXmQL06Oz9TgRtrCPHX1ToCqYu/qekK9mkz
         FgoWolIjRGSpI5dAkF81NERA+MZtaXUTu93iOaM9/NAiRx+8LqGsdpKz5AIpWkhc7kxt
         D0eFKnP/IvOI0amQAN/yu6bCFItSvUzahfOZvAYK5+Ng212xE9A0K0mL/gq6rlAhEZWY
         ue1+E0dbeKQPqI9a0nayFcY0LZuvyFQyW8CatuBn8okGcMVnRsv9S93EuYI5vWSWqCGo
         +btKZZzL4Mhm3pKfdvSJiC5QZe8XnlWppOsnWeJ/tCdNRXNR9be7o2gsKy9IT8fLIrWN
         FnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793954707; x=1794559507;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NA0fJ+/oBhW7wShePAgbVR2p7KjXGENPkxQ0oB5Wpwg=;
        b=qlZ3RQFVBvDWXcp97+acLLN0LyhU5I4cN193JS2p41zWF3WywEQGEkAMD+503MlnSL
         vzar4VccNRC1/EZI3zDZnU2hCnRj/e85dQo881c8Uw91ymbQYsKgDXS94RbddxJBRjdl
         TKZQVGGQob0xPW7LW06dZ8r9x96cRCDSDbgtEFBP2dDji+7CteRp1LNjniORq/R4MJ9W
         NqrK00AA5j377q1xCrZg8GKWLTVZ8lioYS9v+wXiBsisq/xPwXvX9ycg/6BNb6IGt8mO
         /pjyAfi0Y0TqDrqZqhsxH9FmaBFLZ7WikUQN9hoM8cxf1G2YSKOV9zLiEyUYSejAeqdq
         EoYw==
X-Forwarded-Encrypted: i=1; AKwUvBwr/lyComypEBE2mmySP8fuRmnXKE7pwN24OMhPuaIJcCCq18CpuZmsoLg/59LAiSSzLpbuz50=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HVmF8HcA3oGpgOpaYQ6S7n1MDUEUyteDhZpxhZwSZ0twuBftj
	lIQK8DV6HsLm9+TpPhNAxCzl5w7Yp4/NWuBVAB8zYIbUxAhFPINsjKsfJthbSKpl+RHIpWeu2de
	BOAbw9H9tJqWAvlyhN15q4pRsnlBj8jVRSMKsTMeF6DmJkqcj4/2RbN0Q97M=
X-Gm-Gg: AYBFou0MXZF6i7AapoCl1443fyB9BtSG2O+jcmTr0RUE5BtNsAW+N5NIfeUhpgTmI1P
	lrZ7QFgWEAvtFSvwSVvhbpyP+rfzBYIxurj8naKRm/R9NGM5uNGDHtJ85iH5OkLmc+p1swrOMmL
	bt+iJzXacgHSZtRtVfnHkV9deFEdlm05wFvP0wp6aHjTIsN05J2xTHW65GaEsJZWIYQo2MR0T9j
	BydpKZZLRrpRVNRtiBC9M+KvzLkJQG1YGHNGUnJ1O3lJlnAAJCANnyXuQK752T7olSjscbct6b+
	F/LKEOfWEzzuJfsoWXfusemFSpW4TTyPtlV4oxla343NBUwVt88uDWQin8DUSTW19x5UR6VIAOL
	0FYv1tTS28zhufdGxpRW0GG4fhACT/X5L5cqNHzAzCoticjkhkuDCd8mUrqfq7g==
X-Received: by 2002:a05:6102:f9c:b0:7cc:971a:61ee with SMTP id ada2fe7eead31-7d2a153f6e7mr1158324137.10.1793954707096;
        Fri, 06 Nov 2026 00:45:07 -0800 (PST)
X-Received: by 2002:a05:6102:f9c:b0:7cc:971a:61ee with SMTP id ada2fe7eead31-7d2a153f6e7mr1158320137.10.1793954706567;
        Fri, 06 Nov 2026 00:45:06 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d72333f9sm2436169f8f.29.2026.11.06.00.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 00:45:05 -0800 (PST)
Date: Fri, 6 Nov 2026 09:45:05 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Anandu Padinhare <Anandu.Padinhare@electrifex.com>
Cc: "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH net] net: stmmac: count XDP_PASS frames in rx_packets on
 the XSK zero-copy path
Message-ID: <au2TkRTFTYA_cLzF@lore-desk>
References: <PNYPR01MB11444552E41C2B17A992492C0FD762@PNYPR01MB11444.INDPRD01.PROD.OUTLOOK.COM>
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
	protocol="application/pgp-signature"; boundary="2G+1fjskYN37ywXE"
Content-Disposition: inline
In-Reply-To: <PNYPR01MB11444552E41C2B17A992492C0FD762@PNYPR01MB11444.INDPRD01.PROD.OUTLOOK.COM>
X-Proofpoint-GUID: UYY2leAPZxO0TZVfK_5tHMem0_XcbB2o
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzNCBTYWx0ZWRfX5H0ljVhXEuE4
 N8hlDRqNG/wBzIdSAjazIXLEkKZLDdLV0YDoclU1Dmg5jnEll3r2SNFIdP8QsdLgnVrnLg6mbmu
 n15ahU2M5rszCIvTUk11djkvu3nCAPA=
X-Authority-Analysis: v=2.4 cv=LIrz05W9 c=1 sm=1 tr=0 ts=6aed9393 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=eAP1Tc7OGHt2jfLb:21 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=XLvKn1FcAAAA:8 a=EUspDBNiAAAA:8 a=xcCJ7Db-qqDgv-G31QAA:9 a=CjuIK1q_8ugA:10
 a=EGoOMHdvsRrHocU67jwA:9 a=crWF4MFLhNY0qMRaF8an:22 a=dHlOxnuW44bjfRMq0w86:22
X-Proofpoint-ORIG-GUID: UYY2leAPZxO0TZVfK_5tHMem0_XcbB2o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzNCBTYWx0ZWRfX8dAgfvdWNYXR
 Qria63YpDMJaR1l8AVgkIxxyVRJd9WP4dlXhsdlRkw/EHyyWr+yFWwf9fbFGTAJ1To7eXtHhlGz
 Jj3IvbwmfLLlGLTdvueO3rMDssmw848gmvTUJMD0rDTuiU8LrggEoJ9Shci+w5qKyk+mtTtWA4O
 OnUTnOl3m5cx1egzebryDuAYas/iNObG8VorzdOv73LOJzsx8Tre3UROq29IFfZsdcg4di2DLah
 qWhJHlBeB9CAGavGXcLeNcyu/5vIwSB4yIL+91wOqmtmSl51bSUwmYzf4DbG13zta4x3gca3DmJ
 bBM+48FG2j9QW3wnvI9zw7j7tMb0UmKwlYFg6rQkEct3tCprURg+pLZVrLkvoM/cNy3HmrX+Syk
 VemwmBbbftTKmKJWVgPALa8KOfuqmjuE+MsKk13YAyEjSt2mp1s4UMH0qOwzzHzHOpCKhE4pzYz
 gi0RQeYoLPGRoDHEvqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060034

--2G+1fjskYN37ywXE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In the AF_XDP zero-copy RX path, frames that the XDP program passes to
> the stack are handed over by stmmac_dispatch_skb_zc(). That function
> increments rx_pkt_n instead of rx_packets since
> commit 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics where =
necessary").
>=20
> stmmac_rx_zc() already adds every processed frame to rx_pkt_n, so each
> XDP_PASS frame is counted twice there, and rx_packets, which
> ndo_get_stats64() reports, never counts them: on a zero-copy queue
> rx_bytes grows with the passed frames while rx_packets stays still.
>=20
> Count the frame in rx_packets, as the regular RX path and the code
> before that commit did.
>=20
> Found while testing AF_XDP zero-copy on an ADSP-SC598 (adi-dwmac,
> 100 Mbit/s link): rx_pkt_n grew almost twice as fast as the frames the
> MAC delivered, while "ip -s link" counted almost none.
>=20
> Tested on that board with a 6.18-based kernel, whose zero-copy RX
> accounting matches net. An AF_XDP zero-copy socket on queue 0 received
> frames of one EtherType while UDP traffic was passed to the stack. In a
> run with 60 s of traffic before the change, rx_pkt_n was 1.88 times the
> frames that reached the driver (MAC frames minus RX FIFO overflows) and
> "ip -s link" counted 55 RX packets. In the same test with the change,
> rx_pkt_n equals the frames that reached the driver and rx_packets equals
> the frames passed to the stack.
>=20
> Fixes: 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics where =
necessary")
> Signed-off-by: Anandu Padinhare <Anandu.Padinhare@electrifex.com>

Reviewed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index a2177777727e..f8dceafdda2d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5587,7 +5587,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_pr=
iv *priv, u32 queue,
>  	napi_gro_receive(&ch->rxtx_napi, skb);
> =20
>  	u64_stats_update_begin(&rxq_stats->napi_syncp);
> -	u64_stats_inc(&rxq_stats->napi.rx_pkt_n);
> +	u64_stats_inc(&rxq_stats->napi.rx_packets);
>  	u64_stats_add(&rxq_stats->napi.rx_bytes, len);
>  	u64_stats_update_end(&rxq_stats->napi_syncp);
>  }
>=20
> base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
>=20

--2G+1fjskYN37ywXE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCau2TkQAKCRA6cBh0uS2t
rNNYAQC/+7wwhQ2W39q3qnv93pNRsz7SEKfxogDx/n02RIDa+wEAjKax0xHfoIzn
/mKcfaBNkF/GqKVd8teWzHk5FDmfZwY=
=X79E
-----END PGP SIGNATURE-----

--2G+1fjskYN37ywXE--
