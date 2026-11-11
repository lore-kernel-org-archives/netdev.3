Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794383834;
	b=WvytWP7/42VGVlgX18DQ/PwWSAXq/LezdP4r+H4Uunv5y1+QUHVmV7++YIjiq7oJDxkJ
	 Xn/jiVFVfUhrISisYncdXVzGzbDXSoq9Y6mxcXQQ4LSzifjEt6zCDIZpHS8/i2P9bXEDI
	 08bLE3uMNn2i9YqjOwMjwlpdJlfngIZO/dvTeBFMW468nDtcYz7+r+iXv2o0nH/cPeOar
	 yImI4tloSoq3XksuJOkLgU/caHzWSVwHXcR2jSR0qSj3SzH36BTK8F6zDl9glh7SOx80A
	 tjq+39Gc4sxG0LmeTynY/vD39EaPeOSP0GP8vyBd5SAUG8yGZd/iqDXYe4AO1WUcZuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383834;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=uVN9ehbX+juUaswgjcc1y08qWf1uQq1soRn9jz/Nxc0=;
	b=AKlUy4iiNq7iGd5+LoGPfrlPuBmWeSFM0QvcNbjrUj+Oy+HsPjm7gKTsvO45ouD2X5Lk
	 JJIk6hErhMErrHw7C83kZzGgnSAYPNbesSwcHXpbRGlYkDMVoEsgDlvbknrrw2guTKgor
	 mINEqYXP3tk3EUDDd/yVA5AB+RwqM4TxB8SjYqL2Dj6IOVeqJUq6v6PFyqwl/+CcCb5Mf
	 Fp8wjBiBOL/bMcAscwUOIwqse35u0tqxkWIRWnllYVcS7pR21YyYGI8uVPKimT7LrpIsC
	 5MdQ5Dqv1n0eeyrRcDtxi/lDI89XyR0rbByMPg4fMYdBgdGdt9Y6L7sIzqvEw0kmDUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TDgAr5EX;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XCN8fJSu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AF6606A320
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 07:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76AF6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TDgAr5EX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XCN8fJSu
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KKbZ2350847
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 07:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uVN9ehbX+juUaswgjcc1y08qWf1uQq1soRn9jz/Nxc0=; b=TDgAr5EXV8YAyPJG
	mjLztF++mlItCs1VnDCYxToS3W9CnRSNp5oWmXyYbfwtkVHc5js3TNTO+AFZ8Hfm
	V+CratE73GzWQd6KYxiMt17CpEJZQfd22Q/LBTlXbInKcRLai894drA8c7kxuKne
	ss7nZ47XbZ0tQUGCS7Vfd/Pzsku5P81XNwkWxdzx2GVwFX0c4MRRW+iCF+wBwFbe
	9G7W1j/Z+4kc1aCuKuQxkUZoGDDELeRP7sHjdQWt04va7BaRVMWu8PbX5PAO/iaR
	emUTPHVR1Z5hPrdDyz+aQaZDoNfUFkh2jl6lBev0T47gjasScrkPzQy2B99r281Z
	a3IoYA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnp1guc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 07:57:13 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b0c6e7151cso49129817b3.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:57:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794383833; cv=none;
        d=google.com; s=arc-20260327;
        b=Q7yDmW0KJhbVGJc5XjdtiK1o071EEASRoKlrxEumUKcw2CjXe1LJ//qrRXTWlWmPvb
         Clu3kon4pPYPuNWFoXYJepn5EwrB8QkrRGrsjoJjb4K71kq3J3lTlIdtlNtAYQUAdrRI
         hYvSq/KLEzDyHxnrOjGifdPufWzfvLic+03bQ0Cur7drDe2PYS0e4JMN0qznjSeC5tnv
         dKA4nJuezrP61CUHd+XsCP5dl5ehizhjOXqA4oPFKclzHZ8wAmqlgO9tDLGR+wsp6mjN
         OO3PK+byrONjacK7c3mWGRhs0kj/1i1uynI3yyqsyqy++eRqTumhUee8DkMRXgNb5Gbz
         XKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uVN9ehbX+juUaswgjcc1y08qWf1uQq1soRn9jz/Nxc0=;
        fh=1ldnxIfN2Xx+zlimTLvtFacfwTeEpWgmoL8yZOjnJok=;
        b=q7+W3wkYSjeUf0u7bdxeDBfg80oQAtsbMg4upjNNoaIfMA7w4OSa4Zbjmoa+mk8LP9
         RlgVdzlBqaGnvGjQfgFrq/SgDCM3AHhe4CtBMixrYKTOxdm+eTPqYTstM7tObdaP9uQF
         s7BevNnfvctW2Zz/p0DfymKvBSlCeLYuO6aaSOUeT2nBzBX1DIdVij3X9dZzDFiAxUJG
         7atsxl7V/I9mR2Y8NTw/mVvFOW3VJ18IP18q+KDtEW/kCC6rj8ZaMT/8YEdpJz/43cfA
         bfi1DaLIgjhOjQ8kUK/amz9A8C+R5GvSeFf/+FT73l0chigSHskWlGcir0BS07s1fYiG
         sFUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794383833; x=1794988633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uVN9ehbX+juUaswgjcc1y08qWf1uQq1soRn9jz/Nxc0=;
        b=XCN8fJSuXBeiRZZJZJIvBZtF2trtDcR93XFbGAsM9HwCdRvMBN8QeUW3Y5NY9Utc5X
         NCPcyl12UYAxDofWzXieHNH+kFDkURS5M9KDcd/lBBcte1Xnn0RNjoVpBiLDZ24a0bCt
         9+wWh5mP1Rv5ZVAwnzy/EySLVOyFw+6hSB0/Gh1f0bMcDvMiJyr73LfZNd1DVguM7gBG
         4Vqi5RfPwwqgWAHMONKWsOHooprcs8fbw6TAJA39yTSZWjJVjIzVbwJJd0SBifgy6Nfa
         +LVQs1GYXEmelo/veOFKl8VbkeWys/cfQMTPNHP4H3azU4XcsHq1sBJPotbw8hMSXbEA
         dFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383833; x=1794988633;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uVN9ehbX+juUaswgjcc1y08qWf1uQq1soRn9jz/Nxc0=;
        b=Ptn5MFgC4fUpPxkauy7+/kwbRJ2UqNh/+cSzoscvbjGWmE8iaqz4UftOoXED/5+Ddw
         zOVnGa3rI9o52flSbhTiXaAm3SyZBD3Vtet76l+YE88aQZ9aX09a9pJW41JyJxgsUMG4
         DUZx7bMJnwmKWNk5WWy4hrx73Qdzof+leqIqA+LPgTIn2U8tli2tv6wknYZOCnGM/N6I
         P5L7GAhNfJEylRilU4JZWgxnCfNpC0eoemkxQfHW05MD8doA8xVHPYAst+ySpk6N7jOM
         h8DTCju+gsds+Z0QeaRj0rTLC96sryUELuqvRodD6QDtBRHOqkQ/R0cwlm23XRUQpGOq
         86jg==
X-Forwarded-Encrypted: i=1; AL+hErGON7j/eKf1IEGcGtlgvydQQwpwQhaozheXnpsQttyg5z7lGgpE34ieeldfoGMhMk0INzGMxbM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UKpIewcMVvJOBjDRrZps3tjPQlmR5myKNcVAUa9stQaNJ4Jn1
	K6ymIJqEqylaWUf6EhabpJmle3VVZb7y0+TabBtBDXWfpSKo1svZvBbMqS1OegJQEfelA8Hf4Mz
	WE8LT//5D5dlxg0CvdrxcnqT77kWfz5xI1ZLRDzCNUHSdHYMOolpbamANnLGW9qk1P2nASlFl2D
	js09Sz1h7pYAio0Q66CPVdiIwl34EJIGTqfA==
X-Gm-Gg: AYBFou3O/QF/dFstySpiH4jIqc20kxnrnyjiAMlx+4DRD3mbEqwBduVlawsNmwd1vPt
	Zz68/UCV28qRpgbVcAmgxKeL7OpXASHjqGYCrmlHMKgQY0rjzdfl/gFhp+4nk0z6aH/2Bg/wnJF
	+/pROkQNmUva8qOGmKtWE8GescsR74rAvJatoJK8pXLI6RmVDBMw+ARtmjuA==
X-Received: by 2002:a05:690c:d94:b0:8b3:b31a:1dfc with SMTP id 00721157ae682-8b3b31a2a20mr1165277b3.57.1794383832601;
        Tue, 10 Nov 2026 23:57:12 -0800 (PST)
X-Received: by 2002:a05:690c:d94:b0:8b3:b31a:1dfc with SMTP id
 00721157ae682-8b3b31a2a20mr1165107b3.57.1794383832045; Tue, 10 Nov 2026
 23:57:12 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-aquantia-poll-global-status-register-v1-1-808089824a3d@oss.qualcomm.com>
 <12b07a59-c087-4ba2-8d5e-40b2a6d6a72a@lunn.ch> <CAPTcHHRv959iu-4V6dAWwfH+gRy4nt0M0MGZYL3CCiuD+Gc0jQ@mail.gmail.com>
 <d6bfe1cc-f925-42c2-8628-1fc5978904ec@lunn.ch>
In-Reply-To: <d6bfe1cc-f925-42c2-8628-1fc5978904ec@lunn.ch>
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 15:57:00 +0800
X-Gm-Features: AclHuK-hytLQX62FzXkKSkwIVZ2K94dtdhWY134T40oWN677gCjiWZm_sI3HmSU
Message-ID: <CAPTcHHRmee+eRYLG30Xu0gTkhVXwSzGeKG-gixduUvKsyVWbFw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: aquantia: Poll global status register
 for provision ID
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzMSBTYWx0ZWRfX2bttAxxAlUMJ
 ZUf+4u6DuyHVvcWdacPMyugoIaGpA5JpQPOyEEG7pwXMf9PTtTQK2cfSRpBH0rKiRGL55qNXFCf
 ARSANcbykoNYaZ/WyOQboAnF44alT3/rtBi8fcCee2Gy+bWkUsN/EtsrjaeKAeE57lrNJa0kqAV
 utfF7q0gAmqxKwfuFpaMHOzVqhAYJNIXNhUo53thA1a1b4Ul2hBrYvuptcNIfqyP6oDCDr2xwRX
 K2yj5P7rk6UmocpijkZmygmJ75H1Sgoxw7pb4yLV0GRXoDc4j975gyCCB9Pw0xyXjO19Obz6t2Y
 ps/4vO8taEZl6mb2djGc21HA0WNOu7M0Dxxk+DpOpRvHs8FET9+D0nyV8F0JAP9QkmFevKm2/BY
 QTnXiROCyt5LXdbKsG/KVcDjGVrznPj/64LHeHwiQhmSaDccrJWM50PRluGexJe28whTvzeblXo
 NutITKS5wALIK5YyUWA==
X-Proofpoint-GUID: jFKfu3XAagked2HJUlQml2ZZfA3lkM8F
X-Proofpoint-ORIG-GUID: jFKfu3XAagked2HJUlQml2ZZfA3lkM8F
X-Authority-Analysis: v=2.4 cv=NK1AaE6g c=1 sm=1 tr=0 ts=6af41fd9 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=KVbMDv13y-5b161CbQoA:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzMSBTYWx0ZWRfXza6r+I/JBcrk
 OXu07N5GUd1NCOgi1uEV4u+B1CZG9ME3Yyfn3keSCSchM7VF8LYKMrNBYZ4wLpnCPkcpvpEm9jI
 2NJYNTAljecyP6fJgb2Xvlko2kW9cNU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110031

On Tue, Nov 10, 2026 at 10:41=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> > > It looks like USXGMII and 10G-QXGMII might be mixed up? Is such a mix
> > > up not fatal?
> > >
> > >         Andrew
> > Is this comment mis-posted? No USXGMII and 10G-QXGMII related inforamti=
on
> > in this patch, isn't it? Please help to confirm if I have any
> > misunsterdaning here?
>
> The provisioning ID is used to determine USXGMII vs 10G-QXGMII. If you
> don't have the ID, they get mixed up.
Totally got your point now.
The chain is:
aqr_wait_reset_complete() returns 0 on timeout =E2=86=92
aqr_build_fingerprint() still runs but reads a stale/zero prov_id =E2=86=92
aqr_translate_interface() fingerprint won't match
AQR_G3_V4_3_C_AQR_NXP_SPF_30841_MUSX_ID40019_VER1198 =E2=86=92 USXGMII stay=
s
as-is instead of being translated to 10G-QXGMII for AQR412C/MUSX.
So for AQR412C with MUSX firmware, a timeout is genuinely fatal
because the interface mode ends up wrong.
Will change the commit message to describe this consequence, and add a
phydev_warn on timeout so users have a visible log hint that interface
mode detection may be incorrect. I'll still not fail the probe since
the existing caller already ignores the timeout =E2=80=94 but the warning
makes the failure visible.

Regards,
Hongmei Xu
