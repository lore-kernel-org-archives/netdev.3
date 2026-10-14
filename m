Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E3348F858
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010079; cv=none; b=LnU0X14Jaw/4cc8ZdV3LWpKPMZe2tQgrv8vMfpKZOE7KAPnBFiLv1AMgb/H6OWapvRLy2X8wPBjO3MpUqRIhre2Oj3aHhxejk5OH8Ps5LnZs6TD2neuXCMMoTDcas90w3l0EGuLCz3/QL4KPKGOvIc+i3DjFUggFkJzGG/iI++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010079; c=relaxed/simple;
	bh=ZDIgi0iGmFDZX7jlfEAWDdYDGeDhU4CVW3R70mqKO5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X57M1l854TeoIadHPasTkIUJ5M8XRpa0w8GPiLftz94E/dOkgrrG4yC6aFdU5yOL3LfXkBBLe1mZEFO1gZj+b6tUXNVwg0ArQgLG6bDgvD5BwzlkZTmHVbiDx2xwbPYEHZcWf6JhyBj9TPLeZay0ALZEWn+M90cjzNKjsnyjyJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hEtReE35; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jD06oTY+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hEtReE35";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jD06oTY+"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EHRB2n841950
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 20:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0JBiBo8u7UaSC9Rv39cO03Yj
	k1sy6Ysk6M919UcSD1U=; b=hEtReE35PA0qGR2ehdV3Eircseeb10WvpxANT3GQ
	bXVdx9PHWVniLRby5yl0FeVagccHR5TDoGEDG5XghOnI0OdLGUmOuT0wNjv672ln
	EEKLjixkKJWzveJZXp39zO08sb8+sdXFm7LXCYBtyqYxr4dGRZzA69gJaMOh6LKs
	ITcYq/G25/7wrqfEcMBfonGwX70mPxSscwy8EH7yJ+IutL5vZoOFAiCEetzXbiy/
	bYN7idogpgpZfoYnTsd/Ld+1ljulYnnu6on1E188UHe2OMdFyS6Hhwrqy+tP1NG+
	P0X9HohIoEUTHsrjJo2nKivGXq3o6Tql6NZ/p7g3sKUTTg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wrnrd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 20:34:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e834ff4d0so1212909285a.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792010076; x=1792614876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0JBiBo8u7UaSC9Rv39cO03Yjk1sy6Ysk6M919UcSD1U=;
        b=jD06oTY+8rEepNQ+7SXByi2WDpDuT6rKD6DMK0Xs13TqfxQaRzZiNOeHNGYkis9SXh
         1ntozTBdqLoIjsWGSXjvBH8HBOV9x5orRM3o27Rs40OoRuHGoJICjiqPN48TkQrJM3y/
         cr42nF4VCn+sG4OwTc1P5eQc8Ou2LTfNCnTtTMibMWbFewOUl1Otm4O2nmrA33lMeh8z
         thZr1J9wRz7ODLC74SaB35HY82Mh3puIa46XD05RVyJFpX7oAsa3dGJol/YBYCRCM8aR
         zOgdY77/DFs8w5pU2IY4YHD8i9sOoN8i4DATTx3COIAN3215ZI8C398IVie4CVP0h2kN
         8WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792010076; x=1792614876;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0JBiBo8u7UaSC9Rv39cO03Yjk1sy6Ysk6M919UcSD1U=;
        b=qtOkEPskgYsW6+hWKmlfkaWws97qxmP8nM8goEj+HYy7+wGUynagsU3ssz/mW0uoia
         7BGV4aBOa7q6wLX08zlHVZfYQGq50Tuv21g6ScneLUNGdGBLTwOgk2Kg8ffLL9aaHCaB
         XdmcfOo4RkuCaUHqxhd2bGo2bdY8pXTAXIMjltgwIWfMtgVIWM/OKmRuQO7zp24uLmNQ
         Y+wGm5UXPth2ZIDA8mOw7ISGvXiv9OARdO3TTOHV94hm1/uNhPoQYK9uJK1ENtQZX4Ov
         MGPRnA3cMzbyUy8ACZe1CYIKB41UlWN4Ey+2Jnl4n50PB5eEDwXXTjM4JwD9MtPVJRR1
         ZbFw==
X-Forwarded-Encrypted: i=1; AKwUvBwNkkJyxo1Ab/zuty4bM6MhdQWdHnx8O9ODEbTF1j5Re8sJak9ry49ExR9c9Ckwsg3lSBoiqBE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRTHpCYlhOosEoYXLkSC2FJo1a3W+q75mC2CwED9mGTeHe8VGX
	tO1n/55QW14L/oXFhC7zyPQ82baff32bgaBwlGaqXuXxwMrOL1AenHOQMtoy8PtPeIS27PdghiI
	vAz6gQAPDfyBOmzIQujUTu2Qfc6Q8u1sPBcCvnvtjK8o0J2KxIBcEpDV54yY=
X-Gm-Gg: AYBFou01tN2FZYHyxvMbbt864YwkTZmJTdHDIw9pmxNo6q/wuoUVbc4yV25+tVMjr/+
	pZDGsBBI1qu0zPqdZDRApqzyros6GCiciPxc5xh6tCJsZjqNc2CN/Pg99OgxiCta9PUCm/D8hFN
	r9pQQZeb30Dg8x431OFlKw6eN4rC6WF5jrrimWaEhLkaSivrk5x6v/jMardQTEPNqtnDFXYRnb1
	U/gF/7/d2FkuBp+tQvCLtuV2+eINfGrC2v0ylA8C9FPZM5eyC4z1UGFrlM75Sc9p8/rWqImsHhY
	qxoif9JGYoCP1ybcO9TrKzbpG/MpNzZ91Ovw88KEcFNChy12mUe963HvLw5YcAcIOdZxsJBl5oX
	2vo/d6oL8UWcCtg==
X-Received: by 2002:a05:620a:6007:b0:93e:a91d:6f94 with SMTP id af79cd13be357-93ebd224f61mr2537121985a.18.1792010075903;
        Wed, 14 Oct 2026 13:34:35 -0700 (PDT)
X-Received: by 2002:a05:620a:6007:b0:93e:a91d:6f94 with SMTP id af79cd13be357-93ebd224f61mr2537116585a.18.1792010075116;
        Wed, 14 Oct 2026 13:34:35 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab4f34sm14487762f8f.28.2026.10.14.13.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 13:34:32 -0700 (PDT)
Date: Wed, 14 Oct 2026 22:34:31 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hongmei Xu <hongmei.xu@oss.qualcomm.com>,
        Abhishek Chauhan <abhishek.chauhan@oss.qualcomm.com>,
        Sarosh Hasan <sarosh.hasan@oss.qualcomm.com>
Subject: Re: [PATCH net-next v3] net: stmmac: dwxgmac2: enable L2 split
 header support
Message-ID: <as_nV38iPqeDnSJN@lore-desk>
References: <20261013192759.776537-1-sagar.cheluvegowda@oss.qualcomm.com>
 <as9XUbOfJazEQ4y5@lore-desk>
 <ff4fac87-380d-410d-942a-a48edce70397@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+LIltqUKrDa7jHaj"
Content-Disposition: inline
In-Reply-To: <ff4fac87-380d-410d-942a-a48edce70397@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX7wCCmT3ZuA9+
 xNrYdPsVWWQS4g2GSlbUwNPS5ZtNG0QlCjhQPfng/FwkRGf5SmEtpVv4/2l+NYquXpl1dysEA2X
 9Ehev+ps98Fh3I12/4eh5ccEA7U9YKY=
X-Proofpoint-ORIG-GUID: Kk80tKwcg5ccW3DzAIs3GZXPOER3il6o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX4TlDEUIrYoBC
 GF6cn/ts+VOF1VSfTCjf9r6c0d/3RYR5jSXlgXAbFYfM3T94M2inRKwHgrgXMJ1GkqZWXf0EfoW
 gZtjDN6MRi+4N7uGtNlmDA29v2xgzWMzLWhP8lEeTr0VCLplobaryoVfrVS5q97XayStxqVwOSk
 CHqZ6P5gBmmbWNbjlZFsLN/AQcjRPbPKUpiZCk5A+6r+upawFQclI5g7CNsMbzYY3R356gr7ue+
 NqOilf21JrreD3HUpRGGWjr/iWUTzrlzWyl7Pzcw9SJrjDLQYxz+VfC1HdxnO8mEDVU3iJpNS73
 yeYS1CRqwnPa6zPsKSdstlwEQN+wCQbB6lNFwlOsT+sSEKElODD02J2VBeXyhRvt5Yi/bDtnbRj
 m8cyDdIN17P81D7w89iWt/kTlgZUMQZagtEFokpCXFPVNsbscYiA1aLMPWfeiM4QDNAnUKHSpPA
 y1wqxXP80gFv7XtGUBQ==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6acfe75c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=l6KQ-lo0NrS8dpgq6q8A:9
 a=CjuIK1q_8ugA:10 a=5EYT4Zk4UCsHSFwCBpsA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: Kk80tKwcg5ccW3DzAIs3GZXPOER3il6o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140081

--+LIltqUKrDa7jHaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/dr=
ivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> >> index 6719ac6e395b..65ac5403ec58 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> >> @@ -292,8 +292,18 @@ static int dwxgmac2_get_rx_hash(struct dma_desc *=
p, u32 *hash,
> >> =20
> >>  static void dwxgmac2_get_rx_header_len(struct dma_desc *p, unsigned i=
nt *len)
> >>  {
> >> -	if (le32_to_cpu(p->des3) & XGMAC_RDES3_L34T)
> >> +	u32 rdes3 =3D le32_to_cpu(p->des3);
> >> +
> >> +	/* when FD=3D1 and LD=3D0, HL is RDES2[9:0] */
> >> +	if (!(rdes3 & XGMAC_RDES3_LD)) {
> >> +		*len =3D le32_to_cpu(p->des2) & XGMAC_RDES2_HL;
> >> +		return;
> >> +	}
> >> +
> >> +	if (rdes3 & XGMAC_RDES3_L34T)
> > should we check FD=3D1 here? Since HL is not defined for the case {FD=
=3D0,LD=3D1},
> > right?
> >
> >>  		*len =3D le32_to_cpu(p->des2) & XGMAC_RDES2_HL;
> >> +	else if (rdes3 & XGMAC_RDES3_L2T)
> >> +		*len =3D (le32_to_cpu(p->des2) & XGMAC_RDES2_NONIPHL) >> 2;
> > same here.
> >
> > Regards,
> > Lorenzo
> >
> Hi Lorenzo,
>=20
> Thanks for the review. dwxgmac2_get_rx_header_len() is only called from s=
tmmac_rx_buf1_len(),
> after the sph_active && len early return, so with split header enabled it=
 only runs on the
> first descriptor (FD=3D1). I don't think an extra FD check is needed, but=
 I can add one if you'd prefer.

I guess this approach would be more robust.

Regards,
Lorenzo

>=20
> Regards,
> Sagar
>=20

--+LIltqUKrDa7jHaj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas/nVwAKCRA6cBh0uS2t
rEcmAQCnBV/1zib4lq8ykuIgs4S7yaMfbi9Uf4Qr042Hk0VQWwD/eZ03uS5gU21E
BglezNU2cYxJHHkAwFb44+hYCJzZsAY=
=jxn7
-----END PGP SIGNATURE-----

--+LIltqUKrDa7jHaj--
