Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2B521897
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984780; cv=none; b=BG7gUvCwW+N63OHBXf8KORRmkxXIzM/uWrXyWdYqBqA3l6iw4kUcmtDMc8C7fKJRDnu8k4c3sUu+hRRUIaNT+QkgJL0nCNmLKKRD/LjB6yTTz+5yHZQe1Uoz3vocCPwfXNL9WpN/dzy2SnO5SZGQY/KAzsvRyIuSmKNKLiS2dvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984780; c=relaxed/simple;
	bh=0L4Nbu8du58reQkSm3StrgE48it0YJU1Ueyadr49Vfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl8hV8PLnk2LgfZynYwpMZWBP5UJqYHuKYQmQbi4ltST4Marh++Q41ow8Z1GElNrMJt/XSWl9R5ufk+Im8Z3PsMw6mLy8zqdnUiaq1/kV28gmnbulAhnPu6xQLQGelzY1WkDVnCvJxByg5k+gVXiaVU5fWb823p7P0G2TjMQtmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UnfABSKF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H7HuHbIp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UnfABSKF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H7HuHbIp"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBFrxG3365499
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Sqq3d4Um/1FzAW/kUe6wQksJ
	qVemNCXMK7vcu4NUvaE=; b=UnfABSKF4JG68NRDS67n6FE6AnekBQykOL4dXwyE
	Lyv7SfAq92MSxg/NrlbJV+N22FkwrRfz1rvxBk56npO9QdUUq/VpujtVZEIRl2Ta
	nYctr+D9MFQKQ7eN9JOqCUogOh+OQC8JeUOiI9pCW9roWtHj5GlmcnsCP05PTpii
	5GRxY4+zhnTqgZdlksK+Qjb29bFX8A8MYjCvwAgbXr78RAb52zHSYJMCiJHPrfL3
	oNlOsNFMMq9MXzjw67mbd4gMyk7ImLGh/5DZwJAhXP/P5rImYvy1xtETZIjoZD0X
	4ut88kZXLGxS4yDQ95V+egmivq9706ssobJbZhFmUxoncA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4621t5y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:32:51 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5d9f5706703so90436e0c.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791984770; x=1792589570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sqq3d4Um/1FzAW/kUe6wQksJqVemNCXMK7vcu4NUvaE=;
        b=H7HuHbIpDSoqQRtXoS17ySlkA6yJT+LLziqgm2+A4RkVd3S3g6uiw0BWSQLfhYDLTG
         C4mFIQydKZxm5YZhIFxB6d7uRBbOEcLGC4wrk0oR57+qao22pggT5nfg8vTgX2EW9SRy
         j5x3EldNd42zQxDyl109gKXE6bX1Uu2H2+ZU6RLHv1mSKJCzZHlGqmk91h3iOgZT6qm7
         Xh+uH+Q8V6pcfJuDHGlRWSKDuiksnf2y5ZcwQ9YE3lQ3w0lu+bzbpkuZBrh9/s2XP3t0
         svmSj0JPllzZ3Ui1NknuBT2GXNbf4Ox0HhUOv5bunySoHlrRvyLLsjgWAdFDi2FfpjSK
         2C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984770; x=1792589570;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sqq3d4Um/1FzAW/kUe6wQksJqVemNCXMK7vcu4NUvaE=;
        b=cwzHTRSyPrF09UXCyW65mNrFi4r99Byq6+5bsAFwhqdJyEI8Ajo/I2l97JfWQeBFeE
         yKfVz+lbDijZGvoH1CT0vlyEWApayzqaVBZunHOdeR7oBlSQJAOBEjIqr1uoN4SQpvwz
         9hpqbNsHte2ZfB1yHzPDozKaFgSGrp1/6Hj/MJsz07Ol6svlzTSM1n9pXGYLzvra6t1x
         8haPuhYI0VnxXDbzYPxz/xFGTsFmveHb+yM2kLEgJEDHK647wf/xrPE6hMeqIvhWB+Sj
         O+bivwueputBnzq81XqFW0DSpM/N+oHK9v4tlZ5w1gE11B+1L9rNdqHeZgYFDKfflmz/
         WkJQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3KbyztkZF0weXV9ZRSXVZJMAvXDf+gnuRG5NaX/LyQNpKcHZ+KwIEUahYtoYc6ad3tt7LCeU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLp+CrcIFFPPGU4jz55JpSKGZYyz3f5D5hERe2R0pPlUWhfER/T
	nmCj3TjcVTySH/XNRZO7aAlscLAemrj1aczxJ1qtE99usPNfoJeXWaEjoO5EUeC+U6qm0OLXkpE
	OE268C1w3CqEGIA7xfD71Jh+2y5PX2a0exXL9LQ+LDffSjtw9ei4MHagBzrY=
X-Gm-Gg: AYBFou1+1t92wstnqgMGvV+cOqIA9BV7nUXbcl8OVv2g3z7A8cJxa76ozmr9Ri4sOLR
	QU8mwYz+AeaF+pKIi5HsGMD6Y2GM/WJyeGizcDsU57idSQA3ZKELx2k0w8ynTMHh12qMbqBtIGK
	Q0Kq5yGIZqwjYNss/FzOpbQYknyGQZAs8+be5erCTDD/3/tJIXr0afPWaadjtIjv/GGc3iWe5ZY
	UyQGK3awrKKlbQodPZ9voruqxL1T9Hqa1DtQ2hYgM3NBrWReLY+CiZSsxW3T5IB4bFIcj2RYYWP
	m951U4aFTgSUsXXLg1IYiymgXFQWrtsYWuaQxUZr97OATHNu7RJKeWLsm+pR1eJUQjs+TfZ3lOr
	N7Ep4aXUiQNR7lg==
X-Received: by 2002:a05:6122:20a8:b0:5c9:a60b:e5bd with SMTP id 71dfb90a1353d-5e91f48b6b8mr4332948e0c.13.1791984769680;
        Wed, 14 Oct 2026 06:32:49 -0700 (PDT)
X-Received: by 2002:a05:6122:20a8:b0:5c9:a60b:e5bd with SMTP id 71dfb90a1353d-5e91f48b6b8mr4332918e0c.13.1791984769035;
        Wed, 14 Oct 2026 06:32:49 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd07c276sm416225e9.13.2026.10.14.06.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:32:48 -0700 (PDT)
Date: Wed, 14 Oct 2026 15:32:47 +0200
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
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>,
        Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net-next v7 0/4] net: stmmac: introduce XDP rx multi-buff
 support
Message-ID: <as-Ef22VEKQcZ9QQ@lore-desk>
References: <20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com>
 <179198374828.320699.17103999780938670424@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q3kgqRgL7mAsQ/qT"
Content-Disposition: inline
In-Reply-To: <179198374828.320699.17103999780938670424@kernel.org>
X-Proofpoint-ORIG-GUID: Kn8IxLVfVo-8dZ8cFiyBZgbmBaGfxZiO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MyBTYWx0ZWRfX02ezydXGhq7A
 GdIn+H6LXOY7CtP7ydIu3zWBxOEojxXTC0e0+q0SkKMX+s9PYaBXi/hpCtqLdDVtOzyZqueCIDs
 8g7ugzGV06LlGgQgR9pq3ggzvEnixCTQjMhtZueFcfQNXhbte1Rffi4052bQ16ptwROTiUWmx/3
 WfXz9NTYB2ICs+t30ykdM5ZYYYNu7mfCZB/9UL5o2+bpE70ZF8Z0vrL7y49fk5xEE5s8Z+XN7rm
 EsVDrKyHTqSOhawH7uGOfmfvTnyQeY7pFCdeCoPGNzhe6314sVYgcVLcUG7MIglx8LcG9FivnGA
 5PC0hMdjqUNvqYRKCaMXMNS/HGG/YVTme/w39/zfW0A4nY57hsxs6en7DfogU6AcdJZU+0aWa3P
 L3mBoGWpmmbnlnOJLncoJKwHsq5uPo60aDX6RFmEXiqJX4OD3Pie5F1a5O8+DSPS40DlNFNKnOl
 SSR7TaMouJhaqm/Q7Qg==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acf8483 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=cApNwXssEwYNTDXMzu4A:9 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MyBTYWx0ZWRfXx1horyYwkKEl
 2EzWV8d4cR52bAcyjaxMzYY86YMSUUnRc8mgMOm1cqSHNsIRYL4Zkdv3p1MYJRIk8bCfhk5OAe3
 Wk9rvpxUeAVsvAKGX10rL9Ol/YolkCc=
X-Proofpoint-GUID: Kn8IxLVfVo-8dZ8cFiyBZgbmBaGfxZiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140053

--q3kgqRgL7mAsQ/qT
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

The issues have been reported by sashiko.

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

The issues are real bugs spotted by sashiko.

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested them on a Qualcomm RB3-gen2 board.

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

--q3kgqRgL7mAsQ/qT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas+EfwAKCRA6cBh0uS2t
rHLiAPoDfKUfclyNbJe2zYWQCf+joNgROzCH1Sw+dJSGo0Hy/wD+JduogxPwQFL2
qb5cuv1UhjwryPGYdH+CM1gOy0VEIAw=
=E36V
-----END PGP SIGNATURE-----

--q3kgqRgL7mAsQ/qT--
