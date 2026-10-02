Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37EE2D9796
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938922; cv=none; b=Moouormv08kHvEEMFx1OEC0hCyp9EDOLQxAsJG5Q5CmTMfppkezoFIUf3oejoi/oZdDhs/dHAt6SvJM8c9DQQJJACSqYfOm+ENxOr1yYJbHxygwAdhvfbMnxBPGHd6qkmol9YMd+WgpEiFA/13yCvNbedelKvxq5WojNg+40Co8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938922; c=relaxed/simple;
	bh=AOvio/hvg1XCkLTMxFpL/kZRvqG9clRp5/3P2UuuPxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuzcpOaK5hu1SUgQP9tDmM2KHRZYF2cI2oJ+KBxknnspeq0pkDMYSKm6Gq5ngzkjoA5k6Ey2qREKWrp6WXKsHBEUmkJDIODfUMfFPxrgqzCGesQk1x26zwklz1DoTV9yua+vV78GL5EU5j7MZ02KiIoPXjsYJaPeW+Syp/DAMvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J+Vn3VsZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WGQYAmN+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J+Vn3VsZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WGQYAmN+"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6929nabc1190355
	for <netdev@vger.kernel.org>; Fri, 2 Oct 2026 11:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CKdIJ/v0JRCkX2ewj0d9dXQZ
	qyPU31WRE6qg+Xr8wXY=; b=J+Vn3VsZwEkg65qq1oQ9Hc8AVj5ctExNmtQfHLbi
	ROYntezQe8j5uEhHmz+TG7f3LzhfPO/frh6c5fKi6A41rPzuh/ErRXmOKt/MnTbH
	zdwBcg0PHcDstwMOBdhtHnaSRQxwM1M/wpiUoSvUZmYK/NVRTuJftK2owEsYm7cm
	c10CTC7J6Kp0Ou0jR5AQ7O0w+skxMD5lZ7HZtk5eQIsCYxKqBKPzMnxDMq6AsheC
	ZGIHHb+wkC68hiFvA4Qk5zknCV41Ol0AMpaai638j0+jo5kDcyZk9mq09snnKKkC
	eTz8TTrTztFoSkwkkoB+31c6B29AT8+zf+xp8pMHj6A2fg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1w8tjr4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 11:01:59 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-988c7363ee1so2838636241.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 04:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790938919; x=1791543719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CKdIJ/v0JRCkX2ewj0d9dXQZqyPU31WRE6qg+Xr8wXY=;
        b=WGQYAmN+0M+2klcoiqqBaQ6n8VpeSdhsk8uVJfoNKnrHACl/wNxq0kVJ3x6Q6pyaah
         YlJ1xYXvuYPebNQfTBT0g6JxoURua26YrJY2pWiBxl8R+UquzfAkBqiGhVnrjvCwfd5K
         ZWZmqhbybtZj04l1/em7eOoeG5zt6zjOcqosP/Eu2iHJ1f+nr/uzreFAyrJ+l26jtUih
         Wqp/jCV4JmqaA9P7zO6RSI2k3PkjFTqwzss5gIT8dRm2uri2ZK5S+1b2sgG+xIFjbSLt
         nu0dvLVoQ33mabvrhJK0qH9qfcyhJwAgdCgOVBC32DoVTmZegushJF9DbDwgGiQwFzac
         W3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790938919; x=1791543719;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CKdIJ/v0JRCkX2ewj0d9dXQZqyPU31WRE6qg+Xr8wXY=;
        b=Os70KRuskPTlamzt1Z3t7zZIrRs4Ga8+z6fshq7gGnFn+naZd98e1dYPJs/MUgNIf7
         xsLWqTMymXzZjqXGgFIXwsAV8bHSwDceYFMKjA8HQ9khxQS4sTJWmLHmXSpBWsHKlNZ2
         P6enU6PqlfdYtN8KIFygaZzW43GVpeqtUr0lV0RVtiH3fdD7Epnz+gYq+tzOABZzN/xm
         rQfBcDQtRLp2hhPDDXS5cVd80STYK6XO8MmQKzPAwuF9OIcbqtb+L01LnJt0W1V9v4wR
         VH94rXB7vKEoiIrTv60xbe92drg5jP9nYQN+vCTngMy6y0O42C4HXcD4BswiGekpYCJU
         FYEQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9amKSE2GSAEk8X/7mZ8IwQvKoPpjqRdZ0eoRt7tG2SpQvcXSI06QW6wrR9lLEczJPnsO1vOM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfSNo2nTY39t3haSyR5HCA80DobIxnw+7yE6KE/X46yN4dWx7X
	m0ibNDTsusBcKdSlXszZEuRKrpSjFqn3PIY5+4vX/sQkzqsorvpCEY4hlEQyO3RJtx8gXUPS+SE
	kw7OCiR2qdr2v1GTghs/SiU5iLLVPLFxPHQVUj0LdbapzPuI7siMOAI95AAc=
X-Gm-Gg: AYBFou1ghIR9SpxmcyCPvKdRnF48SLHq4JdoE3VhtCiLFk0obpd9qfJ3ZC6ndC7N6Gd
	akKF2Va2lIkv4mOprokKHhn7IOoIgXUlITEUSRCmu1MsgHOeJeLhnqmJAF1G67EuES1wuDiI6GS
	4xtSbALW8YCsBWSQlQ2Gi2l+mntprbSkEGNHoZHfuKOBqZXlSCj5MVAhoxkczzJ+oCcPV+64Lci
	Ccw36C0kx/VM4Z4u1Yln1uXDO6bKaQXlmUp1GJML/ii9vuYW9gcq09WyMGpWiluLWXkULwGNOwO
	AD3xsh8YdY+PUQGJ51dsLwvoDfI4udtS/5nU+htwGNQcyYs8tXRSlSs5Ar8BG5Fr+PPBOitKO2r
	lNyhMkhbpEwrc+Q==
X-Received: by 2002:a05:6102:54a7:b0:7bc:dd88:add with SMTP id ada2fe7eead31-7c0f4d9aa1dmr646936137.14.1790938918580;
        Fri, 02 Oct 2026 04:01:58 -0700 (PDT)
X-Received: by 2002:a05:6102:54a7:b0:7bc:dd88:add with SMTP id ada2fe7eead31-7c0f4d9aa1dmr646929137.14.1790938917927;
        Fri, 02 Oct 2026 04:01:57 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280d1e38sm59659315e9.13.2026.10.02.04.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 04:01:56 -0700 (PDT)
Date: Fri, 2 Oct 2026 13:01:56 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sinfo@kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: serialize PTP timestamping
 configuration with priv->lock
Message-ID: <ar-PJPMxGGZ0-jl8@lore-desk>
References: <20261002-stmmac-hwtstamp-missing-lock-v1-1-189ce151a624@oss.qualcomm.com>
 <179093783778.1402591.4305443516462782245@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PPH0o41flN+L76U/"
Content-Disposition: inline
In-Reply-To: <179093783778.1402591.4305443516462782245@kernel.org>
X-Proofpoint-GUID: TvTUwy5uhCm12gRwAxnHG2MaQ7ApgWxO
X-Authority-Analysis: v=2.4 cv=ML/1C8Zl c=1 sm=1 tr=0 ts=6abf8f27 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=5rDVVPiX1ZP2Va_hm84A:9 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0MyBTYWx0ZWRfX5Cd/CiFwyslJ
 +Jflrk5d/zyPXA8SD+VKQMiHD4CMaM4v5TARK9gxvdM94s1icXkXMvFviZTtpJCpReKRa0ObUtR
 4AnaJJGopK2cbr08YggqQah+sQf0bUzGbTWK2VJF0YXdCfshUJhPjLQnbqqZRHw4kXKj4me7ghK
 EUBOD+z7LCkv+lOqJz8qnR/3NkOUK3FFwQpPB9V8LXu68VnOI+F0s5HRLyqBD5ujPQgJpHGTQN3
 xjE8Wn2Ghc0cWTggrMdl7/ab2SUzeKMPiG/Vlqgxnt4MmHkz3gyEKXOzO/NTNcuTAcnwMNPsBHo
 Cgr9T+pUhp8Wxc18O4VeJUi16d+GPdoXeh702+lKu5GINt1JzZ0sJtcmQzakW8aV7Td9J47S3Wm
 dk81AyO4yrT+LQcFWQ4Q7eSusc+k7aSLB1pDzGuZVKfe/iKiXcFoU/X1r5ilTcyaPm6uuF4kTzD
 TP/VrIl4q0r5rdAk67A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0MyBTYWx0ZWRfXyGwFdgjrQraF
 68d11rZdZ3mtvC936VfLXWcDLRTrXSPlk6CUjXw7KTsOqd8XuvWO0d8g3OI/B+p/l/rhNwpYyXE
 iJ/1XDdPlbtOLlzokLP9q1gFWCNH8iM=
X-Proofpoint-ORIG-GUID: TvTUwy5uhCm12gRwAxnHG2MaQ7ApgWxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020043

--PPH0o41flN+L76U/
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

This is a theoretical issue

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I tested it on a Qualcomm Rb3-gen2 board.

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

--PPH0o41flN+L76U/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCar+PJAAKCRA6cBh0uS2t
rB2pAQC9fLgohVoDohP4ZFqOu35UI6l3+z7mlsf0z/4QHjm37QD/dubaG71YJkpH
To/1ZEezcU3wwLqk6fIEPnW8Vz7UjwQ=
=Sd12
-----END PGP SIGNATURE-----

--PPH0o41flN+L76U/--
