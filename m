Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBA175A74
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544291; cv=none; b=AgTrEOeaAX0f41MuUc+cghKM+eLsFSCRxy9Cd/11HFWIUH0QTfyvcRciUcXJ5s2+sLoZWL0nQK0jtLjy4DkRv3NTgfIGyWu10GZOcdPXgLdkmpMcSTpEn3m987SsHa9UjCl7aohR6NKEa57RAGfN589gQGPglLUWJe7JR+kfOUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544291; c=relaxed/simple;
	bh=SfkXslGx8sgCZpir/PS+vZbRiYluff5p3RdxGssUd4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqklip99gXLGpPl8YxUE6sFeMtYrPAAntAVBov73tY2IwJg/iAZw/6xS4YWV107tgC0dNaBUh3eSrg+kwrlDTSiIIG4YA4B+BFhYVI7rub8vYfVwfJBuvR9/k8mzsUgQzAAQ4YUDiuBxbGWBezSFp+yjZxID6TWlabyIsVe5Qjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WUGhl/OX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XviILO+d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WUGhl/OX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XviILO+d"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KHWV230934
	for <netdev@vger.kernel.org>; Fri, 9 Oct 2026 11:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jJ0C2lXXTxby71lnZlxrL1Qv
	aq608lZ8/YfqHwgkQmY=; b=WUGhl/OXzYmTiOa2sAGdDjWti01L7sojaGGZvnFn
	QEXTmo+umM+EIfoKulybB6yiqRiajp4F/kJmFCZO6ZBedF6wJuEEtmXJlInbWqUy
	+dpw0d5+wGHoc6LO90UU5O0jRgJ6n5+uC6bKtHNlLO2DScxMLWdlUlgseCogXxn/
	uY2XeDeEZyXUBy4+UvGH43rWZUOJ+D38a3jkipQuQAvHKPDEK1N+9Iswh8XpAy2x
	1TTFkIbS9DntHNh+BE0g1hqiCiHKgvaIjwl1DiOtZk1AHuB3c+wVZ+27BwXAQnXd
	k5yetvaU/JCv6It+majDrLsZscUUGiZX5yHuyiev7Ds0iQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxu37pn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:11:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ca9b53afaso1643809685a.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 04:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791544282; x=1792149082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jJ0C2lXXTxby71lnZlxrL1Qvaq608lZ8/YfqHwgkQmY=;
        b=XviILO+dP/IoBQNaVdFBqV5QNNVtK+5tOjc0ibePQkzmqSUQFpmRApCGmR2nxf1O88
         eYG7ahBnoSBqx1atrFovN4FXxHecNjbKVPCL251PW+wTtrdcxdTzgUWa8mwqbPLRh/MW
         D70C6PEXuBWy8IwVYyUvkmYcJ8BOTxpp/lCyoDa+3p2B9RkUhUYkHHuzn3CR6T1wLxPQ
         7M0pAVoLOXdXykA+LmO1ITazA7mtoDfHQHglUlnXc+LkORlV2kA7yKghwOdK9wXTrWwk
         KdK6bJDndovzVMQzSfh9+PYGgeEaOn9I9e3hzQ6e1oolHDVoxWFrRcaccFZMHaPY+kk1
         t36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791544282; x=1792149082;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJ0C2lXXTxby71lnZlxrL1Qvaq608lZ8/YfqHwgkQmY=;
        b=Uy6MUT3NcYtn+X6iVH6Ma4f6BhU2V6vlFDN8OAOvNXTzVyMkdIYFJ12d75igLSsW0Z
         5NR6e5NpEfutvL4BwndZXFpPv31kz0X911J9hvPJt3iXp7SPn8jIJer5rpICilejL8NU
         YFzRNLqiVnQiaPS7++rJuyc/OSkFxKJlTr0HQN7pT7X6N8IfAsMv49XP5HpDhf4vXOTZ
         XTRKfZmpt9qcfdOQBzuqjQ3xKhGVUu8gqokY1YJXt29fwWIhbVjnqtEAFv6wsvs77pE4
         fTP21lpcqNIujDOGLtejdK5MDdkscgnIq1VXHWthifFcxixxjEYnIAhJmOdy9Cbwa2e9
         lfXA==
X-Forwarded-Encrypted: i=1; AKwUvByO+7pHOCltldjW60pcg5B3LrWrKf9v3WDnCUD1pKlAGySl6ZAyXl1AevKq4XbrRuQ5j7ctJuc=@vger.kernel.org
X-Gm-Message-State: AFuF++kiPnIqKTe5B6xKKQzB9lnqFvETXYweT+po/VgAJj7dWhJP11jx
	ye1+k/4CB+DIHPDz0A4wHuBPnv6wPZQMJIb1Ck6l4HSEIjZ5w7OjxvyKAqNziaeyoORpRRjp53n
	piVSgKoTu4QdM2on7YEWcmHurcn9CTE5EBirtkvapO6DwUE+S9Np/8EQnwpw=
X-Gm-Gg: AYBFou3cNtb3JB8aaLIXLm+Ll08eGd+Q2USGOYYBjxzxDZR6V5GQZVTdOb1p9apdI/5
	n30O/64hJi6wIOh/cwsLZkjZU+oERg0Y4Sh7m0RndZqoQm/5E6ehfzDn88SfSmhDpSahmi3rmtc
	aJHA7sMCyc302IPkCS7zUPbgL5kLmc933NpoapD6r2J4KXcxs4KkCmeZvrvGN4LEcad1+UWNlZZ
	qA4hKyCGJojljo7F/pHdgu5YRmgPaWJDYICELxtVnKQbU3KdLZpWlhvFgL2wXbNptOkKdzs2x5w
	FvfbnbKz69FQDhJF/FvTTsGtC0QS/WIpbZssUui9RZ3YSkMWKo+glrrItggPwnxGoqgVGCnWSGP
	GY43hNV/+m3OoOw==
X-Received: by 2002:a05:620a:4503:b0:93e:985c:43b0 with SMTP id af79cd13be357-93ebd248388mr200962585a.35.1791544281946;
        Fri, 09 Oct 2026 04:11:21 -0700 (PDT)
X-Received: by 2002:a05:620a:4503:b0:93e:985c:43b0 with SMTP id af79cd13be357-93ebd248388mr200956485a.35.1791544281341;
        Fri, 09 Oct 2026 04:11:21 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bead84esm51414655e9.13.2026.10.09.04.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:11:20 -0700 (PDT)
Date: Fri, 9 Oct 2026 13:11:19 +0200
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
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>
Subject: Re: [PATCH net-next v5 0/3] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <asjL1y_IlFSc5mx_@lore-desk>
References: <20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com>
 <179154182368.2527009.383686573505818394@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iNGO0y3tjkkSqUbG"
Content-Disposition: inline
In-Reply-To: <179154182368.2527009.383686573505818394@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NCBTYWx0ZWRfX3RKA1w4XzjuU
 28ZpFHNYPOQGrXB/GzThCtPWWOtgIbBVX8JDGD5sM3d/k8Ot48jAOo7c5XKGutQAhIIiOUJtkSi
 0cCnrUvXjVjIr9gT0zUw3DC8ct9ORKH9I9+YSTId/pUnXTJGg03C95qSlf9sHo6XiGwksZlcLWy
 DZt0U42DvhtOXmn6e45H4DAkbsH29sRpryRgQ5PUlN61gCJNPQloayQYosO66NGksxENuLcQUDo
 KKmHetZgg59FCEVOLEyaxUmxeL/wZ/MygjkI0ZoZ8q1B9PQLA9hf08fibtmuYVui2NBAb3tqviT
 9jK2Ngcu3lkBc8C90cR6hZ5yiwbPxwq+iCGemU4pgTV4Hq+w0/6Zl0cJJXSfvNx6xX7DtdeRlUK
 zoPmYCItboqYELWqDH2Z2oOAL1b3ZeVTat/mSxmaPFE2hTZMlkW96ePGdxfGj4VSoP49j9TUp7w
 OLp27VeALk+q67TbGiA==
X-Authority-Analysis: v=2.4 cv=QbjzLcbv c=1 sm=1 tr=0 ts=6ac8cbda cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=KWmWMJlhrGjfyJj_RUYA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: Gnf4NlcFghEnkvaphh-iOaEDCyqpVNzb
X-Proofpoint-ORIG-GUID: Gnf4NlcFghEnkvaphh-iOaEDCyqpVNzb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NCBTYWx0ZWRfX1Mg3AN/UYiwa
 qRopNySx4cszd+E9xKJyYZYlwh0MUBECme+x0FZul3AuT1QopN9HNYCKP/g6TtsYkCXewaaU/oK
 CG0NhNj9Ac2pKYHd7A6I76m1o4s4LEA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090044

--iNGO0y3tjkkSqUbG
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

The issues were spotted during code development.

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

these are theoretical issues found during code inspection.

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested them on a Qualcomm Rb3-gen2 board.

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

--iNGO0y3tjkkSqUbG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasjL1wAKCRA6cBh0uS2t
rDZBAP41yvTFMU8+1QZM1eCpABAni8FZUvsNZWn43rp4Cy0JTwEArQJ0ZljVQcWc
ZhQ5t8p8rc1b3QXidv3jo7SQGsDLkQg=
=Q0sA
-----END PGP SIGNATURE-----

--iNGO0y3tjkkSqUbG--
