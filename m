Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8853CCFCC
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847534; cv=none; b=WVReQg68/1JgDooH0Qb2AO2L/Gx8JKNE2tkmPiIzmfW+UoIvjQ9KRF7iDPhh6z8xC0PKl0RR/tExrKHAYo2pl0VAmnmk1B4cPgDkin1MPdtysXnDChikL4+fxeKnlkzr25rWxjeE+VfmW2ib5Zv4AvwGgzSWCgR5QB71F8DSV1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847534; c=relaxed/simple;
	bh=DwRJbG/uMp8HoAdckVQr9mJqesCe7yGo4l9qdz7SZiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeyaJOKrMJrV8Zt+Qqmek0wXSFj2/F/3egZScv9Dj2Q2z85cnLnU6AFnmNvrZnLf8rjIFq/08L/YbNzf3BeStkhYdYLud3SHiQQ+Ejoq3malGdSpU2cfpdqNLLQ+0fhURV1XNRhmRZUiGePXR+IIC5fnn3FutRLk99XRaWQ+EZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PRSB/MnV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qc7mnfr5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PRSB/MnV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qc7mnfr5"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xRfu1289112
	for <netdev@vger.kernel.org>; Thu, 1 Oct 2026 09:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DrWa66j0hTcus25nYq/Fkb5T
	BHxWAJjvPe1utIoQNCE=; b=PRSB/MnVAwE423KDKNUELp9Meju13Me4itv8BetQ
	vDfFGoP37nYhIx1y+xxH3OllKzS+7Ugn+xC8XwcWsmpBZEdtbcjP6iMusatgGD4x
	T40+A8+ln4hqebacjLhxdV87ZdEokaXuOxj/zgGHtWOULm7sWLQkmWzSxqmBgDo0
	3nCnYOh2SEE+7eGX3/o0sdFZE785V8mgSDz0LefKivTc01jgcWoKjKJTrH5RwC9o
	OR8i9hPhiLx2q5uoDZ9NE1ttCxyMZgANu5OreznsdJAPPrQRQwYJPN4knDzYsjuS
	VbCOC9Z5P9f7sNFioRGWo5i8JUJ82V1mU6EbrL0d0TQunA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17pjb53g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 09:38:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ca9b53afaso379560285a.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 02:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790847531; x=1791452331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DrWa66j0hTcus25nYq/Fkb5TBHxWAJjvPe1utIoQNCE=;
        b=Qc7mnfr5E4Vagyu3J3rnFYU5oV2lOBU192xVQpJYkd559OdrRwQFYSFVHSBr3TeVsd
         Upb5HBR32FM9yqXfODRAFDmNIzU0Fb8KEXbYnQa6y705APS/uLM4ue7Nbo57Bv0dY0KE
         /oXEo819rTBfJPlbhfAvQBNQNJbYgkdtyvFteZfL4VoPKvO8wgnRJFZaXrcxPtz5wXGp
         I5NWPzu7gEDVTWzkZHD1Dfcbxs5NTCp8UnguFCQArG4WqzL0kk8vSGJ5buwQHPbF2QwV
         iRo2vMWGaQbz+AvUPiCXpRzzVvfy9VEovGg5YZ4TK5oCV4RzIYHWdqcHu2Rjt+4F8hUt
         xnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790847531; x=1791452331;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DrWa66j0hTcus25nYq/Fkb5TBHxWAJjvPe1utIoQNCE=;
        b=IP9JtvqI1228m5q1Ahjo3SuWRrEXTE/1qQaqIapfTEITUqsSgYI7OOnRAWC4w66SID
         jbAYwd+ceZuM3ue/9EmXioR2J9Qbj/BUWmOgw2BMWXZonhdsQn9dcAW4NeCgRFpHCkqi
         6uVieA80vY0/kpqXt3WOq31gkw/MoDyHQ5y8DpTM+JDoyhnQVE+yH8X2GI78A5YgQvab
         qWdPrZHv+QMhSqVJ2PxeOfhR408ofCQ5ZnfS/fT4YkwykjVO5MZzRqt4HMhL3y0xTxD0
         LMc+EGl3XNeBQufL1ZxxNGowRU3iP+5qZeYA6IoQh2aW04cL1QV0oOMiwzySjwaiGi59
         7K2Q==
X-Forwarded-Encrypted: i=1; AKwUvBznEoVNJRUl8LdRk/WBXRY1ZNLsRZBUCkk587z7Z87P3VeWU+7oqojab0bxRybuu1p4HPyv2Sg=@vger.kernel.org
X-Gm-Message-State: AFuF++nGdfPt2PqYe9nr/2luWH+lMB7DFVEYagULSIVqV/eLurVNKmq1
	gYMgEXsTwEQ3e7eZZZG7RVrPGLVw2sYtGpD29K9il8FYS4WAQdCGbxnziafLEownJ/yBytd9IpE
	Jojs9PEjWy13Lg83WniW+QuSvUrkOiw7b8JiG/tnras+q9IgT4b4QDDdLJM0=
X-Gm-Gg: AYBFou3P0gsFwf5pE/Xhs2mdlkvi9Ckjq7Juw5YRmE7DOqvADTHhxj7+hIBaZGCDvcc
	A8DPrwKQp0WMhRbRBF78Knt25U00qaOYCK1rtU6V3dKvBmreZnF3K7iX37JbMT0Ph06VmXORbfe
	hN0eI1FJwqNxDQsbET8nhmIRpnlHZftY/VgFWbwoLqAb+BF5PEYPEuH5CutzN/EEvuTmPecTWru
	nyzOFAe1Ua4j+C3LRLYU2JZtb1W79IYIp4YD+jpjTIlC8Woez7pIjrWLtwLk2MIHJRNrHVDHpH+
	m5C+syiQ/WdFQiiB6DKPSP8bV+1cypMDhalnQmVl37D65icxRFllrbd/W5C6406ZKJkW2mgXFZQ
	HhsQZ0hk4bKHL0Q==
X-Received: by 2002:a05:620a:4102:b0:93b:eac0:ddd5 with SMTP id af79cd13be357-93ca97ae97bmr808655785a.51.1790847531018;
        Thu, 01 Oct 2026 02:38:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4102:b0:93b:eac0:ddd5 with SMTP id af79cd13be357-93ca97ae97bmr808651085a.51.1790847530391;
        Thu, 01 Oct 2026 02:38:50 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f984d89sm64686035e9.7.2026.10.01.02.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:38:48 -0700 (PDT)
Date: Thu, 1 Oct 2026 11:38:47 +0200
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
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v3] net: stmmac: propagate PTP addend and system time
 programming errors
Message-ID: <ar4qJ9gI3dk4S3yw@lore-desk>
References: <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
 <179068769042.31693.17699965363723906103@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8R9T85pNZ31B4MBi"
Content-Disposition: inline
In-Reply-To: <179068769042.31693.17699965363723906103@kernel.org>
X-Authority-Analysis: v=2.4 cv=eqpKXYpX c=1 sm=1 tr=0 ts=6abe2a2c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=TtmoeoLASM2qgFhL7psA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: tih2eAKoxmIj9SEuMPFtZ9WLb0UNYz0N
X-Proofpoint-ORIG-GUID: tih2eAKoxmIj9SEuMPFtZ9WLb0UNYz0N
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzOCBTYWx0ZWRfXzMDxZER3mIcT
 UJ4WxRg/hTxNx8YIVNKls8qr8BLAZEeDZsnHUxiP/cMm5Oi/PbbVsMV7VlgBI7yBDnIwZOb0mcw
 5nKWY/q1YEzdy7Iq+PkUdi4ahKkYRWQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzOCBTYWx0ZWRfXzj34s6Watgo5
 AvpcsriUwFVedfV+yWnZ9RfifHvxQoBEoQGrPe6p3rsyY10WPQtWTMCmdaCPgbkmcgRG6PSAJfs
 xqdjuxRWbMzPzTOaPcDppArbpGQdTKViFPYor7dhdFxb1x+R8BFoL3Y+MMb/I19rp8p7P8+bbP6
 QxLxRZcdPlYYQZkSNHZzjwiSeVlpl7AiVv6oqjoPLMjZYHsemOhMcWMCthbMbHBOLMQ5PkFrMu1
 Be4igFUpgUMMmMelRlM2Ybh+Uz7hq6LgzefvyuITlgMjPiMwLvlUHfcExZg4LUuj7GzlI7VpL1t
 9MX1ttttnLT4EPFZOGz+ya4Ipv7OXTaTqHrXQuHGLp7Gsu6JJCmdrPsOunNCVaR+xVT16mFkKzN
 IWCCm3+9mEdiGi4kEtxqPbyNERjCgUSIUBEMBLlvH/eY6tWVav0bwGDl4YpNQnWdwBuopYotdEE
 AZWae3XlgAPxav+QS/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010038

--8R9T85pNZ31B4MBi
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

I discovered the issue during manual code inspection

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

This issue is theoretical, I have never triggered it on a running device.

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested the modified codebase on a qualcomm rb3-gen2 board.

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

--8R9T85pNZ31B4MBi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCar4qJwAKCRA6cBh0uS2t
rELSAP9HYlTAf2mcxWuOVgeouaefMXxRsMxlo7nr5ueWymrv4wEA4wf7C2dHgd6W
B7t9Q80FMvQlwZq2+VnfrK6bTc7NAQ4=
=fQft
-----END PGP SIGNATURE-----

--8R9T85pNZ31B4MBi--
