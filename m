Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625648;
	b=izpGPWlXaI1kcu3oUJbYGMInGqSqYJBodXazV81RJMUyfwCqxQcZ2usTSvDe9ldduoSN
	 XVthyJFvM70MIrGMe3wK0A501K/09Q3JVH1/ldrwtN1zzVrtbqfs2Se9fWB6zAaU4dbPY
	 a18hdZO6unVgwwWVc5bn+oOG6nRZqBnSgKYYAcSGgYpQ/GA9VL6Dos24lcr0ajPIInI6s
	 3PSl2L5YsjSuIpoSHlxPsCN28eWHF0wKstHHW5AWoulDGSZrhQvJLiS6saTzhzf/+0Pni
	 z69bxrb/TV2xJxN4ISui/hBkyx6cSgMqgeljYO4vhL2W6BwM8FvpQb2XMIXrMcSvAkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625648;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KlXD+aOR63c/FOljEMI3DnU5RwdrA1mGi00aGRNoEI0=;
	b=pbVayvv22Q3D5xI9QKRu68MRe2EX9BBUm3BUfq5itPM3jmlqdxRSB7TKYkg030Dkfjvi
	 fJ+4kTZCrZE7E99ea4pMmhCMU8cdyZtztznIl8DTyMhJFm+au35UMaUEsAEscURZcBUF2
	 IQ7XNuMNRDb1ym0Vf24Tvj/rZPuNbmcu05/X6tOWkCfE7h+1tJTBJwVnjZH3Uad1xl+32
	 XKyk+8dkh+YLa1raPuNl17wxf8HM5RFjAZcubfEoWiV03J/llq2CakiqVGgKWWzQGlhtX
	 cRcpf+M+gIZVVxPmQ2pVGBlF1/ajJW+eBZRTkxDFJFod9EmmuIh3JJSZctF18X2DvQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hp39N+GV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z4jJayBe;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F029D606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 13:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F029D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hp39N+GV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z4jJayBe
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DAGIc2902106
	for <netdev@vger.kernel.org>; Mon, 2 Nov 2026 13:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KlXD+aOR63c/FOljEMI3DnU5
	RwdrA1mGi00aGRNoEI0=; b=Hp39N+GV8u/o8iM+5Myo10stt656PODJcvKDZxE7
	JWSrdiOFqnM0taNmJ2WLDI1yBnsflmLiOqu5nWXXPBDNljgh4vDtt99cTfWdclj2
	iRjf2t3wUk6r0FCP+gHLTJy3CtwADEjbnsFO8SCW7Mnw3p2odyJiHX21Kdv/dl0V
	Q9ri2/YP9yBaUSsFeRifCzBsYyu1IP4GVpq1U0WXmdKRdKWesfrPKami20fCdIcB
	br5iLA/1ICURZPPV8hnL/8P3yadRhZlhktl3bRn/SgDx/5fqBJ27PUwJuZjOdDFo
	Ld47SFfCV8Jh2kQeuc7CPRxuc1n+DwpZikCIhzMMZb8DtQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsavgfjq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 13:20:46 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f322ef7d3so564697085a.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 05:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793625646; x=1794230446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KlXD+aOR63c/FOljEMI3DnU5RwdrA1mGi00aGRNoEI0=;
        b=Z4jJayBeCpCOB+DmqGIDXTa4403oNvghHKRFf76XUf8NcpmUFf6ZAbYsFZKp2znIuN
         o96Fn/3w7hgNu9mFt5qgmmo8T0loybUO20sGVRlL0b+oi+A3yhMLAKmqQVzHXlcLcw/w
         X3SlBuOckpLC8LRqkeqcxoWxE/8zG6PSaAk68Bt8MlpsnBqxLrKT31tc+uExT8grpRzB
         UignzlsJi6Jc2Vi6sK7cLJtFPEdM9mkDu/dzC9zytHpbzjKRMcKONQtVMCEsL8nPO7Hy
         XhakxN5p/12h9xroDwnk+IdUlT9ufEgn89saA0HDy+Mxwmi4qhJr9M+TEPEYHXxEmvDw
         BLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793625646; x=1794230446;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KlXD+aOR63c/FOljEMI3DnU5RwdrA1mGi00aGRNoEI0=;
        b=PA1and4Zqzl2GRVA1OUQWX1pdecG/g5KlXhp3PMqu373/326x8GYWnTYztjoE8qUOA
         ev97r1ALN+QjUDWz8jSSiSFoYtIrMGHj5gZmVP8tKKwM+KoNghQIgMd9MqtZ17T7HwPS
         3QgBky3pfafP/OnoWyjvhpb6o73xI6rEBOzluli1eZncLkXU4XPxYv6tx5Hpsk4TfbuH
         rU74Cf5+Xe2aZv+5Rod8PMQKE20RlD+W6rAalkgQNx3bjGhUGTau1pjE9tnWrCGbBoH4
         KGyoTFCKBsqegOR21LPS85+g7y7Q9UwSwc2oSqgAoYRmCkPkyHM/MCuwk0mbSE0+/kMY
         ZO6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxqYoiRfLgXR9ZImWzYd8TO3NX7wVwqittbat/h8yrfStEFm2N4hw8YoDGpIeeGVBPLs+cLg2E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKb046tOrLEoSUYT257tgKQ2hGlfhE8vtPTJBHWYJxGlvwejlzq
	nMowgc7kjV1Q/y3NcxOQ0zmV8eNTwfC/uI95eUh5ZyWxunzt3VJo7qecKIbfjR+Xmk4hQkaTvlp
	0DgyEBliAfZZjawRX52S+ohZIsUR8yulx3vMNOkkvYGB7apCL3k6eYUTO2rk=
X-Gm-Gg: AYBFou3nvUOKYFfOsa9sBP8BjWTysuMupvnhYcGEXzq3zp0hcfS5oZO4i01S9VHgFIE
	m3rMa0/tMaKtysUt8Bqfd7zyiEtI+8/klATB+yyeqrpJu4YTmx9z0H5OjiS26voV6PtZhifdgqY
	lEpW2VFd8lU2ganPs9DcpQbawxVH6p0gLep60jrsfoqNwSnOyhM19qREpVUmjuOg4q6MbJUkpY6
	PGs81HW6iFvsnZ14jdB4SqMJIzRnVoUNP4tNsEGyrbz1oKqq3u8CNeEjrXb1OlZvj6s3fzSHYr3
	vX/24MGQpZ5qKjqKsYtDWMeP4fhp49mnoFqYVQLk1mnYWxXC2f8vbLrdnsLoBjGZaY7LVQFTYYc
	02IeDzqIjG8jOECtun/eDp0AOlAGE9x4AIPjA/EInJFny6Gq/8zmruCcroNgkPA==
X-Received: by 2002:a05:620a:618e:b0:93c:6e1d:96b4 with SMTP id af79cd13be357-944217b4de9mr1533413685a.62.1793625646110;
        Mon, 02 Nov 2026 05:20:46 -0800 (PST)
X-Received: by 2002:a05:620a:618e:b0:93c:6e1d:96b4 with SMTP id af79cd13be357-944217b4de9mr1533404985a.62.1793625644858;
        Mon, 02 Nov 2026 05:20:44 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ad414e298bsm125215315e9.2.2026.11.02.05.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:20:43 -0800 (PST)
Date: Mon, 2 Nov 2026 14:20:43 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sinfo@kernel.org
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
        Song Yoong Siang <yoong.siang.song@intel.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: set XDP metadata length on the
 page_pool RX path
Message-ID: <auiOKxu4PY2lGgkP@lore-desk>
References: <20261102-stmmac_meatada_pp_path-v1-1-d93cc4f9a864@oss.qualcomm.com>
 <179362019361.3286.8732260602904932373@kernel.org>
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
	protocol="application/pgp-signature"; boundary="hEQCQpva2igBtHcT"
Content-Disposition: inline
In-Reply-To: <179362019361.3286.8732260602904932373@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MyBTYWx0ZWRfX2FKNhtLVQT2F
 Ag16N6aTHWtYYh6rRvSoygX7dFYyGVnzzwoj4OHO6gJ2EdR/lGWbU0EMCFSuI1SDbjS7YtTmpWP
 jJcIzDvSdONNq6XX8w9HK2WEEfCtapdEut9/2kpWdhxQMtg9or8OF8Owar2FNBSBWrGZEIR3Tq8
 eB/rDN7x/1Wfhh/1uqJdpNxzsuWhpTEj8vO0yxV+uupORYsHwEVIyEZTn++AhRE9G+ufEEIWf28
 2UGZlKr/ASDs0QpTd0IqcKcNme6GChQK0/aVFeTgcOhrYa0kHbTla3/mjogGU+Jx+qm0NXX+Z7P
 JAguIOBZYCGrC4fdkrN/S2/l+NmuhUvNOlqLMhSxZruX7F2OzNPDZrVSdmBggl4+o1mOX5x7Lhh
 3aXgoqP71b6N0/iKotkeql5jxzKHbZcJe2hDjo16huY+ZVoCIeBMGInGy/TIHh0P7GN9jNgkane
 3P+cGOkDtCHZS/sgxog==
X-Proofpoint-GUID: C0C9I0hA2m2_rAAtCSIqTgZHEEL19Gmo
X-Authority-Analysis: v=2.4 cv=FZmiV5+6 c=1 sm=1 tr=0 ts=6ae88e2f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=Go-FRpC6VwjTotnDkukA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MyBTYWx0ZWRfX3QUmS1OWBA3t
 NkrKoUeaEbY9qHXaRXDU3kdO5OToLeIQStXQbydTeU7ZIYZIPvG6BxzEprpsoQCcIzHNTt2Kfei
 G3ajocTm0s8YwDxHfnIFssRF8qgN9Pc=
X-Proofpoint-ORIG-GUID: C0C9I0hA2m2_rAAtCSIqTgZHEEL19Gmo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020053

--hEQCQpva2igBtHcT
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

The issue has been reported by sashiko

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

This is a real issue found by sashiko

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested the patch on Qualcomm rb3-gen2 board

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

--hEQCQpva2igBtHcT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauiOKwAKCRA6cBh0uS2t
rHRdAQD/v8Dhm8FIwTs3wowVw2wCikCGentLt6uK5GTW5atbhQEAz8EIXwAcWJPJ
sqI3crlBL10HzgL1B2U0IkCcfwTQngA=
=Z4aK
-----END PGP SIGNATURE-----

--hEQCQpva2igBtHcT--
