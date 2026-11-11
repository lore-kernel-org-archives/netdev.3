Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393341;
	b=VnFeeysH27LgBVAx+Wa9ogceYbprJM1YTdlmGXoor4n+czmicornSwRBkz/140Em+3EP
	 0TSkxuWx3745z1k544zD+11nNG5PuiV1ac/K0QSiEX3cEvUKUsYemOhrtxU9ZS4hlv+OF
	 tzyAOu7Pbjq8oK/TCAQw+NRvWrnCxmyeW9OW8h9X5WWiJ1KHZy8iprMhpbA/sbyEdFrNc
	 JAwpi1uJxJVez+ehLOloau0LxisYp9tKmTsEsJEgmhBaWtdbDH3dKeNaEKlFsg3q/Q7kk
	 GEAIBFAwpWMVDlb1xMQ3Gla2sq7HiY+Lc3TLNcARRZ30UimCYvu/Tsz+6O58kr8JP9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393341;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YZMI7TbxPYwx5wkCIKznTql42P6hnvj8TVPxqWc7QgY=;
	b=mlJTLFTMmfW9UJCoOfNnxa210h5TXOE7vdvShtGV2aCIUhBlq6bEv+J3ct/H5Lzrd3nd
	 s3LW0HS7v+YPl0QmGPqCliB0iWtgvL1RczYAcmEUMlPR7pvdwpDPH81XcwdDKwrQeF8Nl
	 VbwiYPM4iyZxxS+NmAq4fOykM5eRDBJddrMMZTmbw+CbREqrs6nwZ2hCc+0+Tcmkv55DI
	 XUNvgbZQWmhXdYM25Crw8TsAVQSc98eVbxwpWsMm5K+aVe/Ham6hQXtRRHJlLXIIer9fK
	 ZmS3zLL7yQvhKU2BCpTIxMIOSvJJxru4kF8ueeWLRDfAocAQtsOC01AzmFkmbddKGeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AiRJAlWd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZtvlqU5h;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766D8606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 766D8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AiRJAlWd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZtvlqU5h
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KP8U2017607
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YZMI7TbxPYwx5wkCIKznTql4
	2P6hnvj8TVPxqWc7QgY=; b=AiRJAlWdbyPYQpa8CHxTUCrWpxmJPWJzxncKdeZU
	NTbslnrfR57T1fdhAMeIJt4wTpAdWpadyvyHda2aVN5UloGlxN9udQwGwnl7NnC+
	3wa6WpF51OaWHpRoVoHZlwnCuWPcNRddEqMewobpkQGJznxsNeFyHhf3i1UsWeEw
	uKLJoyRVjOVPRfoVzRr+CpfP+QkRPicsnDqxso9bfxmVFCcQSCBlp/na9M0PKa9x
	mYwHrQeg0viEPccCwenplzomBtB0d7CP3SG0/IkrpAJc6F5tkRAazabJ9gJh51Ld
	lZHpmOJ3bFTQFBIChNIpYqnRjz/sETWdUJBRzi8K0YTHKQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv97cbae9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:35:39 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91eaad6eaeaso56788336d6.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 02:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794393338; x=1794998138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YZMI7TbxPYwx5wkCIKznTql42P6hnvj8TVPxqWc7QgY=;
        b=ZtvlqU5hbIsD3dAqs2oj5I/a5C3Qtn8jk5G7s4eQTpyhVLPLCDExJ8a3palKuae4gS
         Y+5gL+LKaYaS0nT5WOOre5mAdLWK2xzL2l2krFiSc3xyi8j+00z3QbC+oW+Hy1v0NvDg
         lnUY43siwQZSjWByIwVaYU7LBO6i1bWPSVdBkzPWT9hqhRkpWCi8HZf4qb+1Uv6b0Boz
         +VEgjM08vBEB1tCCL8QxVL4Lxn4Zt+8L1L0Pbv6N+IygGt3ztgEgTPT3Dnc6hC6T3RrG
         sC3bj2q9E63jWx609KDOUmB0R5V+AGRLkQCFMhVLPVmWYpXKm1b0mua1GyKMrKmtwLwV
         qsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794393338; x=1794998138;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YZMI7TbxPYwx5wkCIKznTql42P6hnvj8TVPxqWc7QgY=;
        b=EwzkeegXK8iULUbG/6xRL8cIQj0LMqRWeW8obY22RjuJR6vHij8+kxk9mmDQ2SypCt
         4zx3IGQo38A6rbEvmNN2cdampePbbHJUjqAZanDO/xIq7WcWPboQ/aCi+ZnfF3qmGkgA
         lPFDLqYdE20BiKwuNM0YP/0FBR2ltd6m8l7glM2KzDza/m8jlro8xjN1SDg+vwxZm2Dg
         LAsfkexVMLwtTyfcz4I9YAzH0nJZVb/3wq56kdB60PH183QY6uE0dCxk/c6jquTzzS9P
         UVi/sGeFONTZTrLeH4hFYKWrotVnsqeY3KDK/tnabjE4yD4fbcPGE3x8LGyVopuRp9vZ
         pQqg==
X-Forwarded-Encrypted: i=1; AL+hErGvDEDgU/xYlLxpt8MvBfVK2ukLIQjHNpkPj4WKy8/dqxl8/k7+Lw+9/XgYD9DmSZI43g1MJZo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8T4mNYOzmk07KGAjpvO7M0ehVq0/jf38Vido1Gv3ftwD5vT/c1
	2J7Tgz6u6d1Kj7CGAyekR4xjD//xXw+zSvc4EQWbTir2BWXmen1dV/4ccqeljoO0US6AFfaimoR
	4YqVNHaP3XlFGjMhxqRdXtd+a//a0IAORS+fVmUXjESyL51eBML5m/5L2dXA=
X-Gm-Gg: AYBFou0ofpGeEX2Qi24FPRTEkhDCuYAOB8bh35BDFnjSTLIHVqvbcSdIAX8WLScHXd5
	MS6yM7y269P0a+ZlcwQGS0hTgqisQHpUppoQFFeml6vUKNUkach63yRTz03lqH6av8UNY6GnyGx
	dRaW2NJUiv/U6Rr6GrPnxZtuZRFgZEIvrMMwTsvoSKLb1flJK46xszH8xhsEPH26Y3nmeRYYeo2
	1anPYOB0cw3pkTad0V+aKHrtELNPd40IEGS833SQ0K1FR1yddrCW0A/ja3U6BcCLNjKTnlygyqU
	HS3aPQiW9vXCteci5xWNZxlOSvXhcQIQpVV2yIbHqUkmmb1TT2zETNWCIBoCTCT+taaa5BGfC5D
	temEYzmqOGhd7yG7Ow23WfQ0pL76ZlJYVSuuAn6U9ItalPmGho8H2v0idUaJwBHQ=
X-Received: by 2002:a05:620a:470b:b0:943:faab:a15b with SMTP id af79cd13be357-947affd3892mr316322585a.32.1794393338390;
        Wed, 11 Nov 2026 02:35:38 -0800 (PST)
X-Received: by 2002:a05:620a:470b:b0:943:faab:a15b with SMTP id af79cd13be357-947affd3892mr316317985a.32.1794393337817;
        Wed, 11 Nov 2026 02:35:37 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0204ee67sm136315315e9.13.2026.11.11.02.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:35:36 -0800 (PST)
Date: Wed, 11 Nov 2026 11:35:35 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sinfo@kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: re-base EST after PTP settime64
Message-ID: <avRE9yrHMxPEog_W@lore-desk>
References: <20261111-stmmac_set_time-est_lock-v1-1-da1554f233e6@oss.qualcomm.com>
 <179439101012.2168702.7084889683086505686@kernel.org>
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
	protocol="application/pgp-signature"; boundary="+n+Iz2b53gv4eKLW"
Content-Disposition: inline
In-Reply-To: <179439101012.2168702.7084889683086505686@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0MiBTYWx0ZWRfX6B51+6uaklvw
 2oxTc0JpyMcOvckSO/1ZBAowjqD6MNd4PcWTkfpu4ZrfP1o5DZXQIhj4V54HqGLTM8MzbiifGud
 F+A9Z0gMCEoqx8cr5HSQtILiF9OKWmrAQFGWx6tqFL5GuNQCuHkfBBWAv7sjO5fK77oxwsrf5Ds
 XsmSq53iNGLmggG8VcPtBM0K0ob6Oge/8b2LkwCP7C5w3aGXis4jC/i8Twp9Ypa3bIZnSOLbMht
 3xy0EkuiZYqv0OuRXg1U/iipLKy17r85Qx1fanFIcoVjfmkUEOqGGst4egLWyHpVCUzsyXrR+4f
 7KVfBw4C+Izd0eTL7HWb8iHtuvkTTu2Deav4h9ap/i64hIg0ZMjoY1gRbce3Itwehk69e187BF4
 AQ/f4a44b1oCZZJpObFvoK0yd0gbEbIGD2ejRGcJBOlkKaPYmmyGIwjXFNgz790NdMUoNhO4WBv
 ci5m41wtuvc8G+vwh8Q==
X-Authority-Analysis: v=2.4 cv=cJl1IVeN c=1 sm=1 tr=0 ts=6af444fb cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=5lZe6pp742s8uXtkiyYA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 9u5O1UEu1es5yfB555dhguPf0X5gMukw
X-Proofpoint-ORIG-GUID: 9u5O1UEu1es5yfB555dhguPf0X5gMukw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0MiBTYWx0ZWRfX1A7Oei4rpdF/
 s6IQaJW2Imx/Z8qk70YSuU0vhFrwX8umsSi42lpN30xprugMjLSVjpujJcRiPLPHs9b1y3TLimX
 GpkIOQ6M9w9Z/uuVfG5CGUo66ued+2g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110042

--+n+Iz2b53gv4eKLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi!
>=20
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>=20
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

the issue has been reported by sashiko.

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by LLM and not proven at runtime). If it was triggered
>    please include the symptoms, like the stack trace or kernel messages.

this is a real issue reported by sashiko.

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested it on a Qualcomm rb3-gen2 board.

Regards,
Lorenzo

>=20
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>=20
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

--+n+Iz2b53gv4eKLW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCavRE9wAKCRA6cBh0uS2t
rApvAPoDEjc7/atOkTERa9B/HAzRWUTuokltRPzm1FYP/pVThQD8Dsl0tVeu0Jxk
Q7I7NEpsTyNEnLnicCpxapTKlK6sDA4=
=VbwN
-----END PGP SIGNATURE-----

--+n+Iz2b53gv4eKLW--
