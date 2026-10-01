Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64963AFCF7
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790840338; cv=none; b=MyDTbjH1wEwTRakux/kSdkGckBAAi97c9jm1IZWO4P0+Y73tyGw9r0mcehynC9sNRpaNDdTGR2uQ/vRLomOVjG5bO+fxyNKhf0Mqzpe/5UTy+B7XwrbeecbYVTVGc9kW0+12H0GaZWSs+BJAIZCUmEH3Yi4Wh2BYlewsda7AJe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790840338; c=relaxed/simple;
	bh=YhTbhaT44QAyG0Cs+DvgfplU2GijMISZ0oYsDe7E7yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gN+imVQLgjwVNNQJI0GJrMysT5v6B/jVVGZfm8BsabuLHpAr4YAOoZ5d2ZON+qmZPN3xhaL2Lk4tUPedYNmnsAA5E6ZLU8WqbUEv5bmsVduYLyomVBx/AnZ6JDMk37iQjlabePJ43i6BIi2u2NpO0yf0P8yxs8YfDT/iTbscmtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W+Jpc+D0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PfdugEVC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W+Jpc+D0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PfdugEVC"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xtWg1661232
	for <netdev@vger.kernel.org>; Thu, 1 Oct 2026 07:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YhTbhaT44QAyG0Cs+DvgfplU
	2GijMISZ0oYsDe7E7yI=; b=W+Jpc+D08wXsaRPIiuiDDOQ9lgwTJWezDzT3BEXY
	byIPIxxPXbkw1hVsm+wigLyH4Og6wIdG+jYQ7FAKyZPXao6aO0lKPjy0cVcvj24J
	A8J7IINLiMGJOKQrNaqqQMs5bOhai1e3A2+JwOcQRYn0nvtFqrVHljJP3u93CygU
	s1ke6zdVuAU/t6yI38cHgSYdwmdWscmDhLA9W6EjwNK2mWMbmBcVKyXzNKwJMtcH
	Xzj8R7LzZ+JVQydCSJNUf4lJ79nwPH0GqR5LKTpcqupBjmDM3POI5zjXfXXBoRY8
	yPwW6upKTpf/3HkoHBP3azN4+M9XN4OzPXZssB3Ygx9GrA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pk3b5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 07:38:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-530d206e2b4so138234691cf.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 00:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790840336; x=1791445136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YhTbhaT44QAyG0Cs+DvgfplU2GijMISZ0oYsDe7E7yI=;
        b=PfdugEVConOSR0+9iDGLS5642uKrc4gbJfB5qRbkVOJ58SiHiHOBaKyu5IUIK26lCv
         GJ7q0WcWkJXHjZijqyi3xi/VP/hemuEuvz9G2gqAaxrBaMSFHs9qEHVlap9Ut476yR3I
         wHMYpcb6h0cvKgI4QTqzaGNJcgVfqOpp1VhzHVoga6KJ76cmI8aO1b4dYDYLpoNpe9/a
         VeLiqwgqThSBikCzh6pnmWsXy1wIQZtviLWgl74WWZWFruTSy0Ev4IhaJlG+2K1W8egB
         j8wTGA1I87cTJXxRrA/XD5Rqh9iL4ukt36gDEKA3PLo5n1aIyMxv3v00YSt6tDePV7ee
         OOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790840336; x=1791445136;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YhTbhaT44QAyG0Cs+DvgfplU2GijMISZ0oYsDe7E7yI=;
        b=WZqyi/Prd/l/U1EWa8585D8KHEH1lpNcPoftdgiC4oOjUIQaUeECH3JnbNonAH4edA
         cmiGUMrhFG43hubGa4ijkPjYwxOKlq0E6+x2cdKhtSd0eDubcAPJ5bNx98vegTFcv5M0
         c0TYI/DTbpGLAnHZ6MzBQVipt/fH24unEBlduZjTrh5uWR0xKKhN2C6yQw+IJbsE/kcS
         CVw8yxVBktbGX2giAEGY43t5Yxq7yy3haop2kZ/9eesWZZoY/fzLgZLx+lXcToOzRTY/
         6aTMWzWl0nXF1dg0X5G/G+M2R0LCfXnJTjPF4CK+cHXwLzeH4Udc3BBKYU9mhB61DslC
         gmkg==
X-Forwarded-Encrypted: i=1; AKwUvBz90P95AgimYEyAJb+9jGGMrz8g0pKQuPt1LzGGb5KpM9fdfGVzWbaMM4FPdPqgs1qHWvrtPic=@vger.kernel.org
X-Gm-Message-State: AFuF++kSYu3prvAXTtudC6+RAkNYLcQRozlqnzLi4H6DGt3JDDGVVp2t
	CeUlrufxMvAFGejkQw7k9fXXrwYoSy9OCns3HYV269LfNL3yhSTYeZUo3B/F79FH8+8l+8sPGQt
	q1EGdAAPRIgi6OtDCw8iZRKOiRniQRvYClVo1J39a6VyArdtxEDOhzsJmFHU=
X-Gm-Gg: AYBFou1X1j81h0KhYRZJl30qQvdEmQZw7dwrelE/g4PEW+fxwz70agJTkGx5f+cuR0t
	ebZP2RywW4CihkrDJYzcsM21Uew5KS4+B+PGckrMrzw5aSHYVx3m1Dg+W96fl9LJOff8ZEPHXWz
	y6ie2UkUEuwK2bfMiscRAuj2q2h/w+td2P8zW6Hmt38uNp8dyP2IKiwy1tEyj0i4nVYDXNpyf2B
	5mlo5uNbr8TOxdeJnEHNVTQ/GnIuZaRVeJCGSBF9y1bjweBn0l5fQgsFsXpMR1XNWYcT299w+5o
	jAjhz0kJNfEraIbwk+fBpjn/rwnd5qzcGiDGNqIrVwl8R8dCSJ2SzVhSc3EDBK74y/2uVWh9mRS
	cBLUguTyXXFJGgw==
X-Received: by 2002:a05:622a:e3ce:10b0:533:8e6b:260e with SMTP id d75a77b69052e-5338e6b28ffmr7739861cf.31.1790840335631;
        Thu, 01 Oct 2026 00:38:55 -0700 (PDT)
X-Received: by 2002:a05:622a:e3ce:10b0:533:8e6b:260e with SMTP id d75a77b69052e-5338e6b28ffmr7739681cf.31.1790840334995;
        Thu, 01 Oct 2026 00:38:54 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f98f72fsm43817135e9.11.2026.10.01.00.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 00:38:54 -0700 (PDT)
Date: Thu, 1 Oct 2026 09:38:53 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Toke Hoiland-Jorgensen <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v4] net: mvneta: clear XDP pfmemalloc flag between
 frames
Message-ID: <ar4ODcdhTW9YkZmD@lore-desk>
References: <20260929-mvneta-xdp-clear-frag-fix-v4-1-1e63b25eeed8@oss.qualcomm.com>
 <20260930173940.1c5f55c0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rodYHr3sibE3NhxX"
Content-Disposition: inline
In-Reply-To: <20260930173940.1c5f55c0@kernel.org>
X-Proofpoint-ORIG-GUID: bvF5JPcG_AbuXEEIJz_vv-iY_H6zimWe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzMCBTYWx0ZWRfX1A1tMjfx87T8
 jQHfft1mbmGV/7eEdXZlJVBE5TS48FWwRlLdXZXxM24Rg1SxNg40bnL1vQNIQuYQNLvO5bdGtMu
 hfVc/1LNDOyxk80nFe9YT7WoDpSFQ+8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzMCBTYWx0ZWRfX4VxOvZQ580Ez
 ZpBO/JHfLa36qLowXWGTqv2LHwKsNJCliuWntRIdEs6stNuLDzX+bJk1aVw/0T7Q0DWX1PR1AZk
 UghmgygF8QcCEClwbJWN1mgmj8h2hX271nE0uSUMATjTAvjjuiZY/W+/DrsfZlfxGXhHLJQxVy/
 t1zbg9+o7qeD+KROY+uIFGWNkZQIX3L8p095Qp1+55mLQsM95pDRumM/3V+GyYivMXaLLf+sMde
 XpRvzLQ04GRY5XQQwo3fIq4tYP6I5y4TSgwKtyKE+WlSF3RHfGpH7Izc2sY8pPedpec7cjh1LsX
 WXZX1YdGTxOH78udvE0f8cuyGFBVRwg3jPS2dQblX9lnKzgsiyDXKJYPF8arMWOxeC9w+7G5V+y
 70PXmiAxeeokxRkMZ6BrzqGLElGGHH40tIk6vwUh5OzhQywc9jvXXaUG4OhID0FxeDH9+gKayjq
 mh9fjQzoMsrZU5bFmhw==
X-Proofpoint-GUID: bvF5JPcG_AbuXEEIJz_vv-iY_H6zimWe
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abe0e10 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=uF5hQ00_2t6gHad61HsA:9
 a=CjuIK1q_8ugA:10 a=2r8B7bCDcRZpvO-uCnwA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010030

--rodYHr3sibE3NhxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 29 Sep 2026 15:43:03 +0200 Lorenzo Bianconi wrote:
> > mvneta_swbm_add_rx_fragment() sets XDP_FLAGS_FRAGS_PF_MEMALLOC on the
> > xdp_buff when a fragment page is a pfmemalloc one (page under memory
> > pressure). The xdp_buff is reused for the next frame, but only the
> > XDP_FLAGS_HAS_FRAGS bit was cleared at frame start, so the pfmemalloc
> > bit leaked from one frame into the following ones. mvneta_swbm_build_sk=
b()
> > propagates the flag to skb->pfmemalloc through xdp_update_skb_frags_inf=
o(),
> > so the skb of a subsequent fragmented frame could be wrongly marked as
> > pfmemalloc even if none of its pages are under pressure.
> >=20
> > Clear all the xdp_buff flags in mvneta_swbm_rx_frame(), which is invoked
> > for each new frame, instead of just the XDP_FLAGS_HAS_FRAGS bit.
>=20
> Is there a reason you're not adding the info sinfo bot is asking for?

nope sorry :(. I have just forgot to reply. I will do next time.

Regards,
Lorenzo

--rodYHr3sibE3NhxX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCar4ODQAKCRA6cBh0uS2t
rJQAAQDg5ax7C/+1yFaZ+e2cR9P90DLOCk7ivKjVB04+eLBX3QD+OAvRTExhY5q9
b3+WBnS2kKrC44PnWWBkKHqVLVoC1AM=
=VXRl
-----END PGP SIGNATURE-----

--rodYHr3sibE3NhxX--
