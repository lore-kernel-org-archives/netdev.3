Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D71A37756C
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188483; cv=none; b=WzHK8nEvfvp8qZAsdz9UDfgSntKBb1HTCM9QJl9Pa8oXC/gOVjPdxOGLnX6qb1bTImdl1inK3sBoENanT0wqBddN6blpLU98uIRfjQxPXG6o0y+UHsbJxEElEZc9OOyaHoCt3/29MnpRucd9r/xydLp6E15i39iVUoHsUd93C4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188483; c=relaxed/simple;
	bh=txrsgoh90Rs3tI+ujoFabEk0RhAb2wDO2ROpQPbuhGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LX0PjBIDKa7oRy18YZ8xuGkb/+2hZ4M4ihH5YwsU3cUIUFNpKx/osgKrUdt66j0ynKZcyXIMWDYXhWF0Meq5zs6r+3mGvArp+btXpJa77zVccVNEaI/it35Pw8C9Izn/eC98Y+W76Dx+AWb4DV1xK2rsiPyzk34X5I7v8hIMCY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vn+fY6jX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZX/rMCxN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vn+fY6jX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZX/rMCxN"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695847if1680482
	for <netdev@vger.kernel.org>; Mon, 5 Oct 2026 08:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rUVEJhKhEH7vvNgnLgaPTGHb
	o49iKYfTXpquXY45oew=; b=Vn+fY6jXyjwSkoxvSbfhNbdoJb3l/q8JJps8P7W0
	kdmdltjbDkp+OIyPABTSsnm9V6ab7WoyVR3PHj5gza3kDOP/V16DBx4ZtY+CWGha
	jB41ZPYU6zFdcE4flZL0Bb8xOJ30s9Yu9kzap/Fk7zHw6ZSel2OEMmzvnW4yhHKc
	xMMf1tUWYjr2cWqqm/gvqewHf4JJA3UsIDVFyK5UK9t3k+TB3twhINEhM6gn8v39
	NQloVXps8JRgVN6Lfjd0TrOdrOrfsEbzEpHWBRIYhifZvve4EKd9kMVqdt3XXk8I
	QX5GU7UYQfODBUtScAoHyY4ERomnO3WeXXBAI7m62a52Sg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2spa533w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 08:21:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934956beec8so349110485a.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 01:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791188480; x=1791793280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rUVEJhKhEH7vvNgnLgaPTGHbo49iKYfTXpquXY45oew=;
        b=ZX/rMCxNSi3vrdJb7biGH48f8CWMXcpOTyLuHushYe3gEA6EeTQf/hoWQEWuZ5WIBK
         OTkVmmHcCOcTWCFzQ49GtyhGnGE6dh6SJ6Tm7BMan8yHIWcnYQ8D/Xa1anxE2pJB7c1q
         w8jV+wFQBD5ebBHRZ1rbAQH4pJA4G/VZ0lW4ZAaSFk96bT9Rs1ASzMjehtm6YK8dzcNn
         yIZthGVwL0ixS+2/e6Iz4T5TxJt2nZvlB91HCdlfTx5T4QXRrKrJrWUOUzFEg+w4yijf
         w0dgf/s5bE/TgDhtJnqHvR1lUzXmDPiv+mHVSzLLet0zycxnmZ8ABykyk6X/Uv3FZArv
         QoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791188480; x=1791793280;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUVEJhKhEH7vvNgnLgaPTGHbo49iKYfTXpquXY45oew=;
        b=oNv5F8rgdduu+tqYRjrxMT0rno3VhIUEHpgf8CvYqhwaeCtBeYSRiTvSSgpuF5ghV7
         VwZXfUYprR5yDPvpXUZLw7H45LvZayO9ihTst2UM/zshWeKMakmiB4JJ7M0yGoqbzeiQ
         TUGvpGeFWuRyA3DbA7UgLcpaxgSw24voGYYpLaTUXZhBu0jb45Zj33VhTR+yxdWkB00C
         UsHrYapO43E/tXXY6I7lsRP6XI9yVCI/74pHB4RmmAMCji/yhVFuu1rB2gqYk5ApVkIP
         uZrACr8vJq3Udtow/4sbQ9F3l5yEFkXZAv5OtNUgD4835EgqJorHCbI4aRyfkGeZBXgI
         7oIg==
X-Forwarded-Encrypted: i=1; AKwUvBxPQ+S5Nk8HBYNmo45TvKyaAUliZECXjhmR+S+h/GeILXty7TusjjjeLrJQiI98dspW54pAjhc=@vger.kernel.org
X-Gm-Message-State: AFuF++lKpCHpbM3y8Zba4vxZc+kcyj5TmOjEklsoCCmY3H/9K7Z8GPYZ
	g4Pjz+E6E03w0Nkh8ldXd9NkrxzeI0SiOFlChxi+eXofd58Bi81lexjuIKFUhi+h67f54jG1PsV
	zHdyFEcutKyA3X6lonlu8mUtdPU1x2AOZFL3b/XsNE61WFh82+BEOvQybqNY=
X-Gm-Gg: AYBFou0YJiQ6kW4HXQ0GhToQ7LnQtlp+r9pDVG0xF/YMzN6dpL3Ih9DzmmOeuK+STRA
	DHmKyE/P0w8bUmTpmCgmPK/SgXSt1Ex2eWlKDUgS7i+0rT8ji62Kta+Xw+1afkmiKriRmNzecDy
	5C0Z+as9+jeOUhKp5HqIF/NqX4hMvWuBYSKGhzG5FNlppz/JU9vnpr7qYKMC0wMqoIk4gqjv954
	Ey0Oym5jNNdGFU2eNkLX6mfbUdNp7GW8QTCe+TLDqLX29slIXDEOf4CI6DxpCk52YjcER2tYMTa
	SWL2sOvn/pxB4bjN9XECu5CUiKd2bUU5rpjbMGXxL/LAJQ57q43RkLZ6Kmn0SP1hYg4Vt8xIftZ
	s8ttKmkfYJXzPkA==
X-Received: by 2002:a05:620a:27c4:b0:93c:c6b6:f07e with SMTP id af79cd13be357-93e510414aamr1063403085a.40.1791188480072;
        Mon, 05 Oct 2026 01:21:20 -0700 (PDT)
X-Received: by 2002:a05:620a:27c4:b0:93c:c6b6:f07e with SMTP id af79cd13be357-93e510414aamr1063397985a.40.1791188479240;
        Mon, 05 Oct 2026 01:21:19 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a16bcb9a21sm289902275e9.10.2026.10.05.01.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 01:21:17 -0700 (PDT)
Date: Mon, 5 Oct 2026 10:21:16 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sinfo@kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v2] net: stmmac: serialize PTP timestamping
 configuration with priv->lock
Message-ID: <asNd_LvyknoJG4Yd@lore-desk>
References: <20261005-stmmac-hwtstamp-missing-lock-v2-1-3b3bf4fe3f45@oss.qualcomm.com>
 <179118798620.1402591.3969606322694204017@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fNN4X/HI4OLgub8a"
Content-Disposition: inline
In-Reply-To: <179118798620.1402591.3969606322694204017@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzMyBTYWx0ZWRfXwwf3OE2GPKW9
 lWIrvMvANFCsMIgjzSDnpuT0khCqBCMKbX2cA1mH787LFb/Yg6SU/rx9yYiEYIZf7HaWszwSKUm
 SbASo5AIChyO3MiDkLQQu58CXvSEMpA3li0qd+mHm1WQ0OQFDx1Bl5Jx2FvAkD4xlmFqRNUnBXA
 lXfBb/a6hTMPGTZvrdk6i4giBo+ipTQzMB/krWL83ob8MA7BC6v/lVjJA3XyLWyk5LpGTSr/Dfe
 0pwoqELT7jlmB3S0DwNFmIK9fovp/QrWH9FJBmb9nzmiAShejg/kGzI43D2GHllUCU5RDUoB92A
 m2VgKgQS4QllEV7XI8vH+xKfPT3pAhGrzWdPCwAxQvHh0H16xRTx32wwjYpHl/8Z0dz5wlruD6C
 peJ7fbepICRddq+rpXUgmYwA6ifaLnVOKFpOXf9EEEmw2blWo8jv6Ng4KosQ57gcYAxxyxOW/+O
 ftMc19/BsPHNVZnwwbQ==
X-Authority-Analysis: v=2.4 cv=b7MncdGx c=1 sm=1 tr=0 ts=6ac35e00 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=V1iQPMawNJRGt7sAMh4A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: v7tc3Oogykf4ZHmBkVDJu7CnFKN-Huxp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzMyBTYWx0ZWRfXwEdXaKcenHDi
 Du8QjOvAQW6TDdFihJ0Nd/ON2YW8WJoZIuSriouU4XVf075qjFy5/YCGSg54ENA1CXiaP6ImIog
 xTwdydr0sNh1BR9fhFZh5DopRABXRWU=
X-Proofpoint-GUID: v7tc3Oogykf4ZHmBkVDJu7CnFKN-Huxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050033

--fNN4X/HI4OLgub8a
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

The issue was spotted by sashiko.

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

This is a theoretical issue found during code inspection.

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested this patch on a Qualcomm Rb3-gen2 board.

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

--fNN4X/HI4OLgub8a
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasNd/AAKCRA6cBh0uS2t
rPYZAP45J+CHNqpNdLNS4qw1OTxElIz+xsyDdFlWYLyLbLcgwgEAwko5tKXypMQd
4+GY1KyvDAJ82pv/0r6Y91TaEB0xXA8=
=/FIL
-----END PGP SIGNATURE-----

--fNN4X/HI4OLgub8a--
