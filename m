Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B513F410D
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158185; cv=none; b=OtRQtVM2Tt5DnGmGPomBpYlA38vNkUjDiOpna4sdJ2yMJ2YSAljOFen4kJoB45JhLHKb9vgP0Sb9u1sqZovcxI5FcMgsu7dm1gn+jgNmIiECD4iHTdOm4daEPDaoPnYteSkn77wIVFJd6LKZm2Nen9rxnNkaGXg9lgYUUQ86OZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158185; c=relaxed/simple;
	bh=27NDRv7p/PzfpWXoS/zZNQr2ctrGSxIFX0ZQ0a9Tp7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWSfocYIQtOQdNO9NwPcFXwuwrEMv9MX4kXPMX/pvCF+UXg62JHSAtL3xbpucbrPXOwq+DCNsmV48Bw/ORKHMZEWYRVnbc9Ad3h6O5V2BNi96Bnf6vwaNhQ03+nQ+JlKjm7W8LI2IZRQTFM0UkYt732yqJAcoLxCtUHa9XE7JTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bJ042nM3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PEc2cd/c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bJ042nM3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PEc2cd/c"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NA30r54087733
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 10:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WjGscos/B1PE5WOtCOqAZRk+
	UbUZMAQeunmZh02EZbs=; b=bJ042nM3DgRDhzbpaz3QpPZ4KeDxXVzNjcgvQq+Z
	/PgINWDk+drldnqz9WtBd1EKq2uodv8YpmHIypSVtJnRCrH091PGUbkL7JjaTinI
	z3j4WSiH3bR/yr5rxS9DpFY+1SkY8S9KqpGnlH252XDD0hcCH4M/NWOm6vj8kPG5
	YQ30BPb6wgqtfzX3WSzkht0HfF5w8hi8TSlR7s8vnZaI4MVpoe6xJteo6VCivLIl
	D+fTUWHC8Q2bQhMiZoWi4KvYZy3bv05IIUw52yPNVu6l6rlv4+d0kkn8dafHS6BF
	6CKFR7h6x1FbJDqxkweCYCBQC4Y2q15SP9/gnK3biAiEKg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux8c3tek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 10:09:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9308eafb465so194766785a.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 03:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790158178; x=1790762978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WjGscos/B1PE5WOtCOqAZRk+UbUZMAQeunmZh02EZbs=;
        b=PEc2cd/ceE5PaZURQUR2I01QrmVp4/4/Tu9e5KIgi/0Z2m5aKeVB8cHTaFddCnepeh
         h64UfE5aYc/bssKLzCsbHD2z3RCqD4HFBKsacbmnrXsb4IfCrwc8aFrjhd+awwzdpmC4
         gJSyZevQoRBchBl37Z8u0MYyu6MFqGIqe0mazE4F4pYZMI4kpsWzZZLoLociK02z59OG
         TKThPwvXo1X3KCRLYbrEEO4DLMVmxZq7Qq9E/eWHOYm9+xsaNUvA6Kyr589gwsApj86r
         3caKBQBwVYHReJLzJYtptXQ9XQgVWhBBLDanZecwdODhEW1kB62OZ/tfXA6/iTMcIy92
         tS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790158178; x=1790762978;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WjGscos/B1PE5WOtCOqAZRk+UbUZMAQeunmZh02EZbs=;
        b=VwfUd1gU8wwCs6+xEUFOQAoAgv0x4gPzarMR9/m93jLTfgPeUoQh/UtSA1SSqs7Qia
         xSbwhGt6+RRiyoWFejoG2k57ryoFEQ8wkQ49Li56q3Hyx0dFRmZ2u0A+bWs0ztiGdDA6
         8hJp95+7d8QHtXhkjGLdGBtFQr6Zz54ce/xALMJzENF+KTaqSsfCEXNb/wXhAmLuzIl6
         emtJgLzcMAGxfBhZtrN1vYO4amHafMkEMLGcA2pUqLeBvKpgt/FdHuQjQL8udgiewDyq
         mCgGzUeP2U3XpGGR2MwKYQOU3KYmqnw8XZmM+bj3UCZeFCzcD2x+3wihrW9p0ToNLaQI
         OPmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHbBH2HK1riIj0t9aXs2jC4NN3lRuil0uYa8t0mGkxi5DYyj6mN5hSm6jo5O2LM21vx5e0EF4=@vger.kernel.org
X-Gm-Message-State: AFuF++nMOrpq1heF6Y3ZGeUz6GCORz8jJZiwZVxGXQmr2jSjZje89gFV
	C1EoS4H1M8K3b/B61J+tm2XfEShiE5sYTZxe/n2BmQ13jqcl0K1QhAokiTAOxCFdfjEAZ32AtrR
	ROYsQ67tyipiAVHqEnTYLkoWf2erh1Rsm/3+emCdw9ve0rO/FACNmvw6fFM8=
X-Gm-Gg: AYBFou0y7VjydUbXn2OuwYzbc1EjwHZ3lwCpqWwhKNmXGBv1quknJeSqLhnDHZyYXZE
	tk4wAJpUndclnsXTRaLTsL5rXgSZxioiNaZEvkE6n/i5NP3CvrprMWfO59dYPAaJJpVi2b1gyS7
	EGupCzP69ShYLVt5YBWxuVO3zYnnbWiqWrYUOoORKcErJcQB/5hGyNa+TvkJh+hM3vn+K2BbiWG
	4uXVFlVkdC1q8r0s0rDB12TSkykl40TOyAtAfoWhAYcU8mFQFddXb7HGui3IJ1WNiHzjCD+L/yK
	WvbVlgJpJ6axZa4co5PjrhmsoZOIBt2IKVzOHryaFMesnyeFujGKdJb9tuX5J3vAJb0fhdrlkul
	HhDRxZ+5W+nxbtg==
X-Received: by 2002:a05:620a:6f9a:20b0:93c:29b3:3536 with SMTP id af79cd13be357-93c29b3421dmr114400285a.36.1790158177649;
        Wed, 23 Sep 2026 03:09:37 -0700 (PDT)
X-Received: by 2002:a05:620a:6f9a:20b0:93c:29b3:3536 with SMTP id af79cd13be357-93c29b3421dmr114397585a.36.1790158177068;
        Wed, 23 Sep 2026 03:09:37 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1acb91sm63138295e9.15.2026.09.23.03.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:09:36 -0700 (PDT)
Date: Wed, 23 Sep 2026 12:09:35 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Toke Hoiland-Jorgensen <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH net] net: mvneta: clear XDP pfmemalloc flag between frames
Message-ID: <arOlX0y3-wNMoB8L@lore-desk>
References: <20260920-mvneta-xdp-clear-frag-fix-v1-1-d7efadecf959@oss.qualcomm.com>
 <20260922190118.1f1ffb81@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qzm8HG7bSHfYQdPa"
Content-Disposition: inline
In-Reply-To: <20260922190118.1f1ffb81@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzOSBTYWx0ZWRfX3ElvwonOwIeU
 U02cmY64hXPfw+ei7uuNZcnoyHkL1EayIRNAIHpyApIxL2Z70+jcmOO7ebbmf9m9j+QUWIZNzo8
 S0J5Xl/VurXUMUKULw0OTEUA4Ffc8i7UWHokYaa0tdGhdlovJ9m/I3pSMOm/81VWXO1XBdD3oOf
 BDQwFJs/jaGtqToU/59hC9zq3DBt6TkcEDLw9uO4N/pjroNPI+XsNzxmR1M81CS4r5V5NDdPRuK
 qGiGH+uceljuBwKL/oug9nXCwNy7UG89Q+5UQn7FC8G/SzaSmHofmZIkex/BPuw2VDu6kK/Vh71
 gAEncehO2ikC0Z8EWqFwhQAjX/zlC28dayvuNPfRNxFPjPuZNaIV7fXkOB1FXgU7vgdiSGhgrBR
 xCwWYXJVdXC7bo+5h34+2N3pP7yjGeLvQEmil4mLZzABQSAr6hrETDcpaNgOhH+3BZwyf0tvedZ
 6j+P15McVouAGuv+dSw==
X-Authority-Analysis: v=2.4 cv=P9evFSAu c=1 sm=1 tr=0 ts=6ab3a562 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Wk1q40mINxl-DWuuGNYA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=CjuIK1q_8ugA:10
 a=2q5E11mNeA-3wjOBgwEA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: k48ydyHZiTkUH53wOg9Dr1BEM1roZaYm
X-Proofpoint-GUID: k48ydyHZiTkUH53wOg9Dr1BEM1roZaYm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzOSBTYWx0ZWRfX10bnhXVyi34T
 lr8CT1CvyU6MGNjyQJ6wUu0HmbHAEXmSrqVYfh+vs2hlmECWxZGt5FHYTfIVPq7S0PxkRugRyXg
 RAbaoTSe07XUL2dluEd6+iNknsxYts4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230039

--Qzm8HG7bSHfYQdPa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 20 Sep 2026 09:55:09 +0200 Lorenzo Bianconi wrote:
> > In mvneta_swbm_add_rx_fragment() the XDP pfmemalloc flag is set on the
> > xdp_buff if the page under pressure is a pfmemalloc one. The xdp_buff is
> > reused for the next packet and the flag is never cleared, so a pfmemall=
oc
> > fragment in one packet wrongly marks the skb of a subsequent packet as
> > pfmemalloc. Clear the flag in mvneta_swbm_rx_frame(), which is invoked =
for
> > each new frame.
> >=20
> > Fixes: ed7a58cb40bd ("net: marvell: rely on xdp_update_skb_shared_info =
utility routine")
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > ---
> >  drivers/net/ethernet/marvell/mvneta.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethern=
et/marvell/mvneta.c
> > index 543e566425c1..32416999f3d6 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -2341,6 +2341,7 @@ mvneta_swbm_rx_frame(struct mvneta_port *pp,
> >  	/* Prefetch header */
> >  	prefetch(data);
> >  	xdp_buff_clear_frags_flag(xdp);
> > +	xdp_buff_clear_frag_pfmemalloc(xdp);
>=20
> bit of a trap for your future self to clear the flags one by one.
> Should we not write the flags to 0 ? Or maybe add:
>=20
> /* Clear xdp_buf state for reuse on the same ring */
> static __always_inline void xdp_reinit_buff(struct xdp_buff *xdp)
> {
> 	xdp->flags =3D 0;
> }
>=20
> and call that?

ack, I agree. I will fix it in v2.

Regards,
Lorenzo

>=20
> >  	xdp_prepare_buff(xdp, data, pp->rx_offset_correction + MVNETA_MH_SIZE,
> >  			 data_len, true);
> >  }
>=20

--Qzm8HG7bSHfYQdPa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarOlXwAKCRA6cBh0uS2t
rM3tAQCYKmgng//tYI4+xIQ2ArUjBsrSxxUUtF4YIPt1WcG6EgD/Qn+Q84ka9ZDQ
9fGp7+cYn26JOsS60d0sMg3NhFxx8A8=
=rdTF
-----END PGP SIGNATURE-----

--Qzm8HG7bSHfYQdPa--
