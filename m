Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656289;
	b=VLDP0XLFW7lLgr+8O53/Rtw3CEeElcR4/MA3neJOgjDRDk+WHyjJ2UCpoIK22Z1JEN3q
	 WV9xvRuga1+cTDkDEBO6sxxvS1hbdyqTwQTLo1fZwDn4b9kvcz8gFOnQsT0JtLDqiRoCH
	 ur2Tn+Y8pKjx96v/e+uSYvjr2hPG0BC5/ag11cIJaV9Wun0CFfzDPFkGUWqIZLadgTHay
	 Nw5oHQ94GcSz8OfmTqmg2aVKT91tLpbiMpsKT0Qq1ZW3oUU/v2TpYMjPVdB/mvBDU8TPk
	 c+QE4zjtByUDg05gdc1Ao5wNzNlPDne1ilKTok5DoKtJROq3tUJexq66ffLLO0HtyBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656289;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=BszySUEPjFnjPFPKoD4QC+UNJxKQYQi24xnCbvVQ1JA=;
	b=vKoXnlTPv7dPHsW9pPlueGGbEFr4Y4YgzC3GBvbNAlXL/izXrEoh5FEZJ+5PsBQLpXp9
	 neUsXAF/RdZ3S4oBe19ykQ8ML1nK7Z8y5L9VW4GIZegEvm3DFAZk1AIjKHDF49lSs/d+T
	 SmcMWELHKB9/m8tFWpL85EK0/YolerbGs0pQT30F2HSsmnBVhTSfvCAhBKX0ZaRW+pQbV
	 OFdimAFUFEkMEd1j8lITm8pOnNPgeYYIsn+udGR/zgMv2WQ02Dhk42B+bHHcEHjJNJpDb
	 I58H4acsHHmz9EsVaevAUKXIUaR/IJzzUjEYyLjF2JRUYJ6Hirw08OTsVzPVLv+RT6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fOgOKLfy;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UXAOu9ZD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD86F606D824
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 21:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD86F606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fOgOKLfy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UXAOu9ZD
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2K6CN41746250
	for <netdev@vger.kernel.org>; Mon, 2 Nov 2026 21:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BszySUEPjFnjPFPKoD4QC+UN
	JxKQYQi24xnCbvVQ1JA=; b=fOgOKLfycPfDArfTtGck2stxo83UKmu18QsSyRPX
	urmSrsEGARLNWVyoCDnq4w4EAs5U3rhk+O9jAtrFKMU4hlT5Z84o3oCuukDWMKpF
	roCyjIov+6wkgYQ79IS274Q2tFtrDLNyVpkJHANOIJnurb1apJB2nO/xjHybv7cy
	Qn8APGWxpULqhB6SASlrY+mKcHKRTcn0P6cJOKvStoGcAN/2Lkz+06k1/XmQ06Df
	VE82aO/+eW1PnJj+XXdZwzFI5nnTwG+XqjmhQAjzebGCjHhPB4LPVT17+B/D3Pi4
	l7/lwkTX3snb2Xd5yV82nPuWxNE7AA0iiP1sixzdkzgQUQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqmvu26j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 21:51:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f1e62510cso772536085a.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 13:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793656287; x=1794261087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BszySUEPjFnjPFPKoD4QC+UNJxKQYQi24xnCbvVQ1JA=;
        b=UXAOu9ZDGBR29AXJDsCVAG6DilFQaR88L7m4iOgf7E44vlc5bbLw2GyjX7vIiXfqnN
         ZDefaX6ajnk8oHRGxX9LebsKeWnAvQFvMJpG2g74oD/PT4AJE1Jvjw4zv1Nlrl7ifFCj
         WifPZ6G9YQ5OQq7OK/xgAeNxt8mzY4k644yxwu9PgoJwqjkcKLvnSC8BJaFkGWZM/Kzl
         uGxmGVGMNfnsq29HFRpGiSt8iB+FjmtEFsLmpny/IAJtoZusoRn+S+sy63DS7IB9D2Kw
         Y49sWLxICRpgkHEx+VKohUooF2sR5J180mj3LwgA6RQKfdUkBMkA9o/7Dx5H6ZYqXtJB
         2hAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793656287; x=1794261087;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BszySUEPjFnjPFPKoD4QC+UNJxKQYQi24xnCbvVQ1JA=;
        b=TXBJ4hiiFqjoccraBr5q2iD5+yb6CAD79XgamUU3oQwPLrclbvc9vkKxcw1UWasOBt
         +15drb2gc4H3tsgtX/GV2/Kz/Ik6+DwpH7eHtZxyqMUXy2wHXEkEX3E9GLY2A6TicxJR
         QWiMIW5v8RNmNsfffDClMym/Dq1kPt00pt1XBveRqBDiyTlrU5abwZb1iyYogfsj4tUi
         Vs2eqHAqs5aHcvKFi4APfZrmDKyE4x1du6AQmQqWLbFqQh+gUoV8C77pWI9pzgO3F6Jg
         TJzmOwh0wKO4Az37/ShIJ8fQjOyjIG1dSmklp0x+XHCh5oewuMPy8X29j3JlEgVZo6K6
         E+yA==
X-Forwarded-Encrypted: i=1; AKwUvBw2NPzUd1c77v64uqfEF47LXEzH+WeOxKISnocsznO/PPSr0meSTBbPpFNm16bzcUaSgKW1BtE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRIsi/dcnDAZi984w6xhQAwN0D/eFR+ihcu9Zo84FJz7WC0v1l
	pQcs8G2+F4bH91Y/lAfsi0543/v590NWsBShOueXqJoa1e8YJDTm3VB6eSSAP6hNJOGxiIUiHnJ
	mPaTwhV/y+MyA3T0XzRltTaDP/d67VB8f5VSNLt0PuYBhwSwF7Bh9Tj6KgEY=
X-Gm-Gg: AYBFou3ZL5Su3EqOXWGK1YfaKuyaVcK1IseZVCh5lWQDSq0UjYRnq4zX77HTsYN+c7i
	oR2o1SFJvfSByV2cV7NQDJivtyMNKMzCkHhlOe3q1hw3IRp+/N9ip7YsjvymN7kRthlAJN9OjIs
	/ASUdjrW6GsChU0OuYW7MeL9m/laawFEUbB6Ogm2beNX4cnn5Yfb9hdbV/NvU/hS43GSb4qxNoy
	UdWURcRzeTyhYjT1WeF6RtY75V0u+lXhZd0ilZZ1jdO3NVQHYD3xtJSLSHkb1CpVplR0Qv+Hi0u
	+uAOx2peEbYfQ+acReRo4igiBxPcqRhzMgKj0obhLxM4nGkggQni3JoN8jPrzjyErvcmbbWO8TZ
	7GFtAdPKaIovot4kq0pbLiM6iEPVcvB4EeSFz4ov5fqkLBEIXp0UuIpJ6xWqRig==
X-Received: by 2002:a05:620a:450f:b0:93b:be6d:4f3e with SMTP id af79cd13be357-9442171a2admr1910972785a.25.1793656286651;
        Mon, 02 Nov 2026 13:51:26 -0800 (PST)
X-Received: by 2002:a05:620a:450f:b0:93b:be6d:4f3e with SMTP id af79cd13be357-9442171a2admr1910969985a.25.1793656286075;
        Mon, 02 Nov 2026 13:51:26 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abea533a1esm202480035e9.1.2026.11.02.13.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:51:23 -0800 (PST)
Date: Mon, 2 Nov 2026 22:51:22 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sinfo@kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: keep est_lock across PTP clock
 adjustment
Message-ID: <aukF2h2J1xqAoQ_2@lore-desk>
References: <20261102-stmmac-ptp-est-lock-v1-1-76fbc0cb230d@oss.qualcomm.com>
 <179364145292.3286.14851003961835841774@kernel.org>
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
	protocol="application/pgp-signature"; boundary="oIisQCZ3+3E4e4c8"
Content-Disposition: inline
In-Reply-To: <179364145292.3286.14851003961835841774@kernel.org>
X-Authority-Analysis: v=2.4 cv=TMDQ2Fla c=1 sm=1 tr=0 ts=6ae905df cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=sDj3ZcXk5yIpZCrTAcEA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: E6yx7__qQcifbrAWK6ZjQlTYXMp8XCPl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX21VS3ZJAtjHy
 cpH/2bss+jKMnfuzl2BRD2HjilVCgitWAsTHR18vojhTW7Qwre/54XuNs/M1sqtW74Daayyl8iP
 pEaZWOLovnlmGX0ndetHgHEc+3VsmpQ=
X-Proofpoint-ORIG-GUID: E6yx7__qQcifbrAWK6ZjQlTYXMp8XCPl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX47U2xIN9YJAe
 CFmZZXl4McVF6VpyQjfxm2byXHjGcC3INelYXLzwCOEY9hAA1GRyNFJY1l/ccLB/+vzH5CMgPzp
 L/h1WIX642JoC8P1sRPeEUUOX9QEqnn4KTjnBdMDO59qPu/4PeiFkbSugvIY34ZWjsPW48LOj1q
 19m2rNhQQzV4xyJrDejRqyOhN5hWpd925Q6ZrxRpAF6MYNBnp8NlqV5uuu4MCuhY+C0EIgBS/W3
 u4It9Jtia30BiyYfaWb2bYWhuKV2A+JIPpQEwdVwLiTkeBLc44O8j3j6bi4I5IWMcZXl5yC8k49
 KL3lcny6SrbPQJ3egRmTCNdZYNvlzsQycUBGHcGf8eNrMEoN3fKIBh0kpSk+sCs3lB8Hwpm9plB
 vthd5CBAFrZ7cxdtudiihBKR/YHRk68KWCkUu1Ba8YVbUB3wJtuyAZh+Ct0P3267jh0ZO26IP6l
 AHv6Ins7Bo30dAhynag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020087

--oIisQCZ3+3E4e4c8
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

The issue has been reported by sashiko.

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

This is a theoretical issue reported by sashiko.

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested this patch on a Qualcomm rb3-gen2 board.

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

--oIisQCZ3+3E4e4c8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaukF2gAKCRA6cBh0uS2t
rKx0APoDHiyVUtnqxqlC+DCpn/kQT0RDUuPkODmxd9Sg16fQ6gEAiiKM0PQubiii
b30zB8+8T3QvXbpn4ZxaIdYaagNyywg=
=/4i2
-----END PGP SIGNATURE-----

--oIisQCZ3+3E4e4c8--
