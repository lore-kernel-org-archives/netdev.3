Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270854;
	b=JyUfbv0FXulFTGEWGYnzbonTUQOzbsst6VhhcN4AEpKjrjM8dGtmyO5v2FgMA122uIC9
	 DPZjsnsPZudbNazNEA6S+KOlRIReQ4E8BTxsLGlxodz1gvhOcCu3+DGxcuZ2AYwzJ9mE4
	 iMUKe1m/G8q1tEzAJeL+VGPebWAXGyLPHJRRTojX6k/PlIsndiQtYpPEa9eVo2QNw05fh
	 vvEJgKPNKemGljS9m5n791wzs/as11LQYCQSyMvIABZQjGppKv97gSuVDNNNwQBVmi2qO
	 jvfjHMFI752y7vcJqp6DVouuBCqn0Ia2JK6NQIFSYKIdhNqzxiD5D7q08x9UxTkmtYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270854;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LgiwcLWFEkc9BGjIqmFkTfgmhNMEizrxCC66mDcMfXs=;
	b=HzSOwDMyBfGF+HJ6QzqH135lqs8hkFvUEJkF0d7r/bz03hv8SYtp00if/R2vUb1Ykepe
	 YT1D2vlvL1xDDP37giFr92owxU9n2J2CmTo1Yvek17xX0P+vgmhgSa7dzutIUNa5XlpUi
	 7qNfzBbeefCVUR7YtTv3ygRZPkOeo6kl4WTm4gFxKDsPaJTKuCrzPkIkz+YslUDIm8aHG
	 EbjT2/e3EygvDUgvd2taFP57SSuS3qI9EDS59w2F/FtuwYYl+hgOW9WvhycD4Wy9Wghe9
	 QiGrmLcSd1hu8Nm4T472p7ise1paYAiQ41/CWMVyZwoc1Rs4zJMCOFXoprh8akTxn2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RTdwGNg0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bmfk5vr9;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C59606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47C59606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RTdwGNg0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bmfk5vr9
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TA3jFr3607197
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LgiwcLWFEkc9BGjIqmFkTfgm
	hNMEizrxCC66mDcMfXs=; b=RTdwGNg0g2mzmaFT1ybL0jzmDUqvqndr6k1OHGKF
	v7d/jrc4SwHopSpyBjyy1SpKs4t3vQT7n8DSfTNSsaxN0QeMEQUyHogHaG1UB8jC
	i8b5YnS3+8QbX7nMLJIBCoPYt3qwG/VV7MsZiRbE1OlCRSr/sPsSM77V/Ml4iOMW
	jKbENMJUIvZHOtG9+LlSlexWlJIEeJEO1eAZOvXHJiuLRosQpdHY2po+e3ZM62qV
	p9oT5H3vVGO/QmmekZZAYfx8XpIjug9r4oyh4pxBz4VMUO+wCHZy7z99n4GBvdW8
	WD8wJDcI0DVCVkNS7EPwx+2OSRIke4nGbtAI94O4n7Nvcw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm42fg50h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:47:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5363b06bcb2so41621611cf.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793270852; x=1793875652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LgiwcLWFEkc9BGjIqmFkTfgmhNMEizrxCC66mDcMfXs=;
        b=bmfk5vr9FtqPN5oCYEoq1qiUf3Qsp8xnaDoJPW02NsacIYLG/kuSuC+++zuUMkRYxv
         iEVzgc0e+w5zR6xGqMnCOlRji6o5byq8L+4QOXfgiyrFssKQkkdz4rh2dE5voi12zpan
         5IW6pg8dFf7OhPm2UPekSt6CHH7hU58tJzg/7NcK9YJFfhaZh6PGikreQBzWFilAiz7l
         rlaAAVvdaKv5d5FH8rLHgvgFu/nT/TACSUKkCBCp4p+CkzURV2JM3eLEI43xHy/xPD6d
         V/5qUTezASdKh2pVB3HxYT3Iknylz1/CZ4nyRGzKDW70/qNun5EwgRBUiBSkg7lf0ioZ
         wzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270852; x=1793875652;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LgiwcLWFEkc9BGjIqmFkTfgmhNMEizrxCC66mDcMfXs=;
        b=XSVGQ+jhI8tQX1+9JyUesglKc/qKNFJ9Os8eu2lYSxcJ97ox1HuJp6+gCWxHfORe6H
         ALKI094UpusXYvIPXljtILTimdteTxXXaaXOPTKu8kbAgDLQFDh+1ag5ST/NAIQ5QsPB
         qoEGyTG4HHVB8IBcXwl+3W69E+VJknsibWL8fN8H3CCezC9kTigI4q7blWhare0iOQ8f
         UbxLl2R9G5zxHPrObYQeWMUCRGsm6eci7zBftb1BKURalRmtjIt54tSfaB9dA6s1+jh/
         vphoU1vQ8pYNEYXjEYY+Ic28Zwa6iqLUNESxzvA1N/WSG8A0h6Y9bmfvMxCjx6/zULCy
         jWVA==
X-Forwarded-Encrypted: i=1; AKwUvBwjEd78U1FiQsQXNaqp1R3fterQyF6a0oCQmNvSFpaq+zwRBW+fhEl3Acb/jnzT++xHysek2UU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLj19uvRcM8p3RsZTuDLZc7TITLDaAvzJM7ra80CLJLUwmsG2X8
	ElrNefH/SCWmvHYHpCXkhK56eT4dRf/bvcd2tAPr2TQ8GiYErM/PuPhcn89o+I5dNp4zKEgQOVo
	agLPRiagJ11S1KytEHZU5/u7wA+vZ09c/WCj45LiPty4R8saHfB1MvpIwlko=
X-Gm-Gg: AYBFou2q3E9o8d/5tjeg6LRoqPgKbLoMSThqessjTbft8Fs0teV1skYJc6uY0QgTP2m
	DhZMw5BQfyRYqCMj/aVTu9WnnD4zrE6crAjfjOVArX69qoglz9q9fFomeLLuLWGe47rP9GSXvOZ
	f2op8ukJNjNehfCJxjXeVaahgWPZ5fA/GI0hbxm9mtiJ+iA2P6OwqQMF39g3bGfxK5qHZef+9rH
	c3Dayp+GCMtePbeL1fmaTy1notISK4mPRPZY9PjwPq4NFolO+25iqlLIEQuF6h/WocA9X85EgJA
	48nK5ulXDmMk+qg9BHnDOiLcnHM0m/ttFlqwteMB7VdPQbMrD19ma671/lMvP/id7c3JDegwCvV
	lZyDa9Jw2zJZjiDNXwVOC1o012bBYkwbZ6yyaT2QA4CiLJpRsUEItlNHdmPXztFZX52Gz/aMMst
	fL7ry1kLDlyxCQikgryYKuBw==
X-Received: by 2002:a05:620a:29c5:b0:93e:561c:5bce with SMTP id af79cd13be357-94408cc4177mr732142485a.55.1793270852160;
        Thu, 29 Oct 2026 03:47:32 -0700 (PDT)
X-Received: by 2002:a05:620a:29c5:b0:93e:561c:5bce with SMTP id af79cd13be357-94408cc4177mr732138985a.55.1793270851575;
        Thu, 29 Oct 2026 03:47:31 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfb8esm33612971f8f.54.2026.10.29.03.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:47:30 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:47:29 +0100
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
        Russell King <linux@armlinux.org.uk>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rayagond Kokatanur <rayagond@vayavyalabs.com>
Subject: Re: [PATCH net v5 0/3] net: stmmac: re-apply taprio offload in
 __stmmac_open() and stmmac_resume()
Message-ID: <auMkQUigOy-gkXmg@lore-desk>
References: <20261029-stmmac-est-fixes-v5-0-85b830a795a9@oss.qualcomm.com>
 <179327019639.3327.12142593314341295904@kernel.org>
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
	protocol="application/pgp-signature"; boundary="S/8J51uVc0oNbge7"
Content-Disposition: inline
In-Reply-To: <179327019639.3327.12142593314341295904@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MSBTYWx0ZWRfX27ZY5zt3TvKe
 YPrhPr5T+VG64dDRqnJBEOQTlcmUfIL5WwOK7qdV9rLYa32Wp15vruN+bDfb88KJjIzelBqfuL/
 jwTrzGMFx9xl36NEUdO1O/ESoVhfo+peqlYxNtnWQtCRmwLRSivgfq7m6StE0yktS0px/izUUpk
 +oKzdSA3JljZwSRIjXcclu3dGDLyIB/+HUU2bqXHcYGiJuDAs8RxAgfbLUquqQkYPpLNONFNqM5
 w8bEd+OacqXoRGW9ufEIeiTTzDq3Gcw7vNerXf6vtlNr2Rj6csLHT5Ft8kN6lwdxxTy32/aG1fj
 2wqj66itBARoLyyUov0uHwH9686bfFJ3PGdleByQta9oPZjuNoNNa4Gh12Xv+RSkntDvtW2B8Tc
 Fr/9n+5qbXNgONt64Yr/xx9wl7IWxxWqZ2sEtSnjkwc2/x/cseOFvhIzXzSOIQaBILR5/GrAgXw
 G5Pvla9GyhyV2RIfeoQ==
X-Proofpoint-GUID: 8tEFaBbLDrSnHfD7K5t9ckIhWprxsYuc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MSBTYWx0ZWRfXwc7ZEr7uwm4+
 fU5qJnupHpBOGtG/F1/beFWCTZpQhVqJH+Q+jR6+5q5xx/W1nERO4NhgZRca6RATuSmjMUGZmN6
 CCQJr5fn3RtSP8+s+KB0ClPKzFMfrJ8=
X-Authority-Analysis: v=2.4 cv=UN9Ijyfy c=1 sm=1 tr=0 ts=6ae32445 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=jeKYxtEjmYGD5WCmXysA:9 a=CjuIK1q_8ugA:10 a=GyJ7KGb24Wf4tUF3bmIA:9
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 8tEFaBbLDrSnHfD7K5t9ckIhWprxsYuc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290041

--S/8J51uVc0oNbge7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 29, netdev-bot+sinfo@kernel.org wrote:
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

This is a real issue reproduced on a Qualcomm rb3-gen2 baord. Flipping the
interface down/up the EST MTL configuration is lost

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested the fix on a Qualcomm rb3-gen2 baord.

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

--S/8J51uVc0oNbge7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauMkQQAKCRA6cBh0uS2t
rEXIAQDUS/tjzpfvhs+2vPuoTrHqPDKx9gNvQP0LMjR1EeK9HgD/SdNaGfEDpwlx
7815m6JJi4PS+5bjnGJC+iJ/VxseLQ8=
=eqAR
-----END PGP SIGNATURE-----

--S/8J51uVc0oNbge7--
