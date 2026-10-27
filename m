Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109269;
	b=RWP+I6cWGIIEJwiunXl8w4RBZsBmJu6PhKfARs7wKfGjaN0xN+KrmFv90anQTaX/Bcy2
	 XGf2ssYZmbi8jWdkyv5DV4kghn5Duw+gSGOUsm/PbdqFBOAHpZgqpx74c4kAFtcWcNCqL
	 aPIEf3gIyURqAdzs+s/yEIzmkBHSNl9OUE4j6MB18QQz0s7G6pUp5AkVw32WDhpbWVyf4
	 LhsBsFiASgpysom5QReDWKiIGHU6CdargWm1WjWJbOuDNcnBnuuBwJxCoxoYQ2ayKhILw
	 Vf6xBVPiKSALQt7PcONG4f0bSvbkzERBDiLQ11IkVTrDt8CUSSIPWIRKAF0UR15RDzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109269;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=v9r3g5keo8SdS9B4mGrqQdcoTte1OjZar4nWVFfkp8s=;
	b=Jxql17kXQd9h3wijJTnXLcY7kdEotWaW2E9TbH73DjWJl6w0vkJtlx1nrkFx0OZHelKy
	 yRBvCT8LS+D8yc5JpkdzgtWnVkaDleOiLeBq6d2+rjVktouXXB2As77SiVA1X1NOTQFy1
	 pbVyyJ8GHvWoloo1Gm0RQDdpn6KuldQqj/hOwKJt7jMte/s54sOdD18uXV2XqTywBIrSH
	 DdxxrX3YndSNiIqSAco+QV6C9m1aEyotRT6/zmTFUGvHYJhuPwOe6FqlP+MBUsDumgyAM
	 McnOsjji8OKQgI6xBYYfFJ9yCJEl20NIp8tZOf005n+R2Kl4uoXL2hXm7Qv2BqP2+hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cnTpACR7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Os36awun;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6645606A331
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6645606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cnTpACR7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Os36awun
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDo2ia2344348
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=v9r3g5keo8SdS9B4mGrqQdco
	Tte1OjZar4nWVFfkp8s=; b=cnTpACR7Ca15wLGgLXZxFnkBR6lQFrKltQqV4MeH
	MyOGSawRypQrtAkwkKSwCIIocHhwNmD8vT1sa0Ejw58JGwNk29gUJuEW6CpH4Gf0
	XgxjpqVWjxO5NmlorvmBch2tXjvHPAX96+k1WXXEqjNk7dNpSikHjJt1nBKLs7h1
	4EYdKoREtnKcoVekxMC4VswLs1nMIvRT+gU7g0g3Wvl6W1eElypkqcc95+aQzE3B
	FGSy/T0Dq60GQU48UNPOut+Nfkt4aBMXSEidxbpwCGdE9BCtVY12kN+nMRWyw7Yk
	HJHzyJzaiD4+YFxC4ycFc8lwsQJsUvT5j0P1YS3b9kGaoQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq69666-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:54:27 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f32050e72so985983785a.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793109267; x=1793714067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v9r3g5keo8SdS9B4mGrqQdcoTte1OjZar4nWVFfkp8s=;
        b=Os36awunu1uyJJVfiyijciFjgcYl4DhZmeuB5znX01fUX/Zy3tpeK9l/MLoeIWXA+N
         Lr5OhZ3DLUxEXjVYouvDAc0oTHjZYsTVzXIGLRvzKUJbvyCoIaY1h+gV0CzlJ3Naq5d7
         rd+OmovAtNFBVDLIkt0u+rmSv1wsdPDS+O+bOWS4R6IwnPWxR48i5emT9dF3bans7U9v
         Rhgw2zWMpwQT6Y3zL81wq04glL/xjGjIGt+1IKXlaKQfPTsSEWF3RPiQTvweqTmRB1o2
         QVdC7vpgBbXafRlQNOJmsLUMXBR0CxMy/YUqWeNQadUIods+pTqg0utlx8dRur6y6vIK
         YLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109267; x=1793714067;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v9r3g5keo8SdS9B4mGrqQdcoTte1OjZar4nWVFfkp8s=;
        b=CGzpb5PqcDGdRH8Dla99DaGuirWSEpKxZ1MmSRMx9ilZsrcQJSBYeEmtzd42z7wtv3
         MvKtSqw3+/L1swWWZi0PtRoQ2wHlZIGilaULSoc4WnX/pV5LghKtjj4wyfiLKpI30PFM
         28mtqbdZAuhcJMHKgbXABT5DHhq1uLvwEcMEhqoccD2DGu76h5VFsBdgy8xNG+xwxvAX
         +ETzyEhrX1CWKbHKh7yFQxhxrEkNQKFl6J3NZLfZWvcAqoV9LY+9YLjzTQJ1yf+xeJxA
         FbZxNZaBNIhlxh1bDenglCd2LG31Bcssj+uXFsPqbgQas8z9NKIlF0co9ClrKIcNRXdm
         37FA==
X-Forwarded-Encrypted: i=1; AKwUvBwCBmVxAX7axNaT5FGvFr3+EmAG3Z/C9wK7y32Of2InqolIT5vQhRG1mtrD2plwLiVAH81yGlo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgoy97fB4sIhjoX0RTK9e/X6jNiNVtvph2TziqwFs5WyVhW25J
	djJglLqfSgsea/MvJ1jl8wzRZCXDCQUFQWzmnPDPcg+ElE2jrZJ0IxWTQ+BGpe/82r4QLkrpfK9
	+40ber4mEmGhZk/ky+NDOLq+pRiIs7gqUUsnm+CayN2TB3+WtBkMpfCWGOhM=
X-Gm-Gg: AYBFou16aK0//6kOmt0kEcoFe001DsLZD5XsqbL2V78RejyjkLpr/rND6m1iU892rdj
	sFbUAUYYrZvY4gIxc7q13ZeQ9FZUEeoer+ZHbPo9W1PNcqnPxqC720OEO0PB2uExKHAIJW1qnZs
	Wgw1za0SWwa1iGoTI7k3GZmNzHACfTCbpi0zu9fMfPRc7W4B4BP+JV7zfPzVaQrA0bnGomm6Ptl
	Ms2QyOq9K76ExeU8woaotEMImmMdhsDfIB0IfWDBbmZOPVpiAr4cz65ryjJYyu3ts3kg8fnIcjH
	ifhhjhfEuMVDXBwxvJbxnwNnw2mvIhSI6Fsk55uaXf98ONFyzTPrLMM6XPJW5vjR12wOEvOinAi
	FzIRoQUse0mY=
X-Received: by 2002:a05:620a:3945:b0:93e:f931:a886 with SMTP id af79cd13be357-940ef927359mr1664222685a.57.1793109266487;
        Tue, 27 Oct 2026 06:54:26 -0700 (PDT)
X-Received: by 2002:a05:620a:3945:b0:93e:f931:a886 with SMTP id af79cd13be357-940ef927359mr1664218585a.57.1793109265836;
        Tue, 27 Oct 2026 06:54:25 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a4e208d1sm144595566b.85.2026.10.27.06.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:54:24 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:54:24 +0100
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
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>,
        Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net v2 0/6] net: stmmac: XDP path fixes
Message-ID: <auCtEFmNWwGPHKxp@lore-desk>
References: <20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8@oss.qualcomm.com>
 <179310900894.3327.16366770051104266138@kernel.org>
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
	protocol="application/pgp-signature"; boundary="Wa2Ya5IEJj5sSuGt"
Content-Disposition: inline
In-Reply-To: <179310900894.3327.16366770051104266138@kernel.org>
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0ad13 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=jeKYxtEjmYGD5WCmXysA:9 a=CjuIK1q_8ugA:10 a=LoTJxW7uYgufmn43WDUA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: tg4JigF_o_ohZyUdDOQXyL7FYyTy1839
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX0+mW5M9ZMvu2
 yXHGzatadvC41fXdmJTt/dWLvtvFfgXzENZFsCZiQS3tZZuJXdVG/L11pBNINpNmcYYRK40vFen
 4AUFS9TSXAnLYy38TRONRFWzEhfRWhE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfXwTJ9/RqNCtfh
 cB7c1R22e78R2AqbV0j0z5Zd8+dbK5iwFJcLMHqIog2ogJUrEZpSSgV1llja9DK47jXzgz0XP5R
 wqh9nMHmwed0UBAJcAzVcNNH2z7IN0JfeCPKhZpWkt6vGlqiE9iJ0C2d/ikN44POQbbrvICb0AJ
 W4+PzCEvC3IAa5uVL+UahUQ/zBKhq5rcQ2ivPcn3mf3GhCMXiOV6kCHzTfrK2QstCE7ax3y+NnE
 9QtxiPEFmfD8fcWKZfbqYMAfODeWyFGue3MB7xFxYPU1Q8pCRwitXvU9ZDd0vGPxEgWEDNWy3gk
 I5aUd2w5VR5q4mdXP4Q1Yog+d+0vBLGuoDHaXuDPaFYJepQZn6rAh13rtaLVJ0LFKyn4ibXPO5X
 rl0SWJPo3cUbp/i/TImt74Nj8TTYom5jW6cnvrzyrldd0ivb/YvYdORLiD27mkjAcImy7oRuVC6
 9mxvjq2oy86bpOzLzvA==
X-Proofpoint-ORIG-GUID: tg4JigF_o_ohZyUdDOQXyL7FYyTy1839
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270054

--Wa2Ya5IEJj5sSuGt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 27, netdev-bot+sinfo@kernel.org wrote:
> Hi!
>=20
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>=20
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

The issues are reported by sashiko or spotted during code development

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

They are real issues reported by sashiko or found during code inspection

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

The series has been tested on Qualcomm rb3-gen2 board.

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

--Wa2Ya5IEJj5sSuGt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauCtEAAKCRA6cBh0uS2t
rIR1AQCr+nG/Dx+y/qw8KFwMjZLoidUREPuG+M43m63c8kjpngD/Smo+d7AhTLzI
C30f4bu34pPv+D7xj0sZCyysyVmqZws=
=pve4
-----END PGP SIGNATURE-----

--Wa2Ya5IEJj5sSuGt--
