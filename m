Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792744459;
	b=RxEynZOkcRsPSjPo0xiaFXxx13aaubm8nYVG2sve/V9OnFTTWzSTQIVQUYrlDqrSvU9c
	 2fhIQfTrPFp/IjmMNfr17Vhic7LYTNJfnTWUKj7f7ojD/7QVoAkSur8XihKye/oAS4nf7
	 mPbQcN3wCNklWTdKDLy30MAxIn0ml2CNzGQwvVjHRYNLDMznldhFWumbC419aC6AXxkoD
	 lpmWnCSJfJN/PdOSOUO6da/EaPVhdfkCE7Cdh0Y1JRNfgpa6Cyr9f2AuWJ9oGov7qcZio
	 rdheFe0X27Kpx36o0Bv/3rcPiY0pF4K3mFybEg1hBj4qKp/AMMZLmHvrtGXHP4ZrChg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792744459;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=JLouBngFmyzeStR7jpDFnM6B5NYmg7+fEs/IrATZkD4=;
	b=ftVctHMp0qSv5vv6D0XHKpyIy3mOkRA6tQ3X2Rd08LKdrNMRFhtxK1tXzcGiHFa4WyY0
	 /x0Q6d2X4ynvmNfw5QeI4ICXTk0k37SPAv4QI70HmXB0JWw590/4KikDDJ6GyGQ86iSD7
	 EKYd9C2zUr5+B0SEQiXbXDfn5ubd0K+dqugyEVGeiSjA4U0Gf+n3jM7C1VPX+yqADU2u6
	 j2VTZhWJay9UZd1x2HqcJuENOrHPE/Uo52I3pcURgAUbb32rv7owYd0FYaPOK9F7VErDn
	 bmAoXwDMSjpiFP+T8EQCy0uEOgkeuXz+S/rrvzC6q6ML1nFs8Xs8BDfcIgj8M7EsZng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VlNNsFPt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UimSwaIC;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28189606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28189606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VlNNsFPt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UimSwaIC
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FTTd2650383
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JLouBngFmyzeStR7jpDFnM6B
	5NYmg7+fEs/IrATZkD4=; b=VlNNsFPtHpOEOLBQPIEyP7I/jaEfftcF7F+mvdHm
	sGsdlHAs/Xooz0LLYCCk0jG7pQSMecK7TOhIkM/90it1WQcsFKptZxtQkdK/bVhE
	9U3kHoD0zyE6n9EmF7MqoIdDhA3CBcaruxo+7hgNQTLQpAvHmfGecb/DCZ5OWj9d
	p+9k5t8Ov35d9WRSTgUfhM/ptvkDejcm8wx52XVo3Ty6tOIwQ3TrjjYwWaOzuXVv
	mCcgFtmO7y0KI6n9vXmBYZcann6XoaBaYgKWmT0LwPXze5N89qDVgyEtytOdD0hN
	v6wbu34r1auqFe773kYRjNGYeTmtntTDC6kxG+TVOdb+WQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjasuv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:34:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5364605e74bso17475301cf.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792744457; x=1793349257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLouBngFmyzeStR7jpDFnM6B5NYmg7+fEs/IrATZkD4=;
        b=UimSwaICix95Qu4VURNh7MAuQXMsVcZYaxXdPffeIEeJbiCQbsG7A4yYiXOKKoubf1
         1if0kqWVBHMKP7Diz/w22taPESwmkzrAiwwdggIXxJdJGGQNWF07OAkIwdH8VWe1X2m/
         AmTNeSX8/lFAiHmxL5xwvhaH36YaAGA5KVLuzFcf4gXr7O98uwAQjvbDcCuHk0R8MBxa
         dxDt51Exb7zERT6CSwcuimlPOWPE2EbwluNlh2wNFCwgfneX9x5TT0TH8EtOQePjUzra
         +6RXNgDc6WYU/7YTpJG9ta0RkGpX01Kti8Mx4Dua+Qx3PuFOGRvJjnnHkEEwouFNZyfC
         /L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792744457; x=1793349257;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLouBngFmyzeStR7jpDFnM6B5NYmg7+fEs/IrATZkD4=;
        b=INs39ebm9RETQHHFTn0TxmYGkUpulfFvSOBywuKe8Y4LNDuCJOnd/4mw4i/Cn6lNml
         qtGLVnb/w5ZvI1VlIQA7H95/Cj/3iTST0QrhZ+ofhV4nAfPErtaYUV2OGTBcliGXWNXL
         2AlN4DAD9AloDhAVUdV9T+YtZWy8sOfJM9SMcSqUwKG4e+NkTJi+58eaQkglwN/w3uBU
         91jHMd5Mi9opgAcjPIyQISBhlpZaTjUVwo7owUfiigNc4yIqNkwgVxOijDiD5BMuChGn
         BbJ3Zz4E4PJsizbNxi0SZbGL1tOipiJfbzvwSZIgos/jFhq79O2kCzPGJSzQ0KhLQK6n
         V1yA==
X-Forwarded-Encrypted: i=1; AKwUvBysZqBL5LV8SKkWAkyRFT/aOKpbSrIrJ1tKJqjCda4FwlDcSo64Bkkdnk5mzNlOcZID6WL0RFs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3ax1myIBLB8CQffI9v22QNp0mmCO/9TfWhCBP14pGWBVCBYTc
	XczxFVpVt1VOeU3fItGGt8VvAiR1gq6uZl76UJssFfy11XhySaaolEA5b/pMgHzlRa071VCUzwH
	OE0v9NPTa0CICikvHM3yg3CRiZE6t3+2NFFTzl5xPIBrA23WRmk7kBtDzfjM=
X-Gm-Gg: AYBFou0aK9f2/Qvr9BwQr8XJLCp9NYtW+YTXoTC3C9YQFJg8fmdeTaT5ZeUtioEToQQ
	mY60QGMCuZ0FhFmadf+alN+yBP2wWZFejTrYDYQyUalYYs+u1XTWm22A+4kGTcwWPEWfxwMRaju
	qtzT/1UdfBu/9WHln0ak9UuB11QvQdf7e7sYAgLfreSTjG17zUvajEnEPA9fR5SfeDUjzZ2kfeF
	hjiAR2EXIbNlt/2BtI/mX5XPdPVUCdo+ZTyRDZJnrS/zjfiTEeAf8K+fp7qsz6iPIZpQujxMky/
	h2kUB6GhMddlZ1oXvUOB+JVnR5Hwwosk+nK4jXKeyTsF005jXcyiK4DOFiW21drtDH2ApuvNksR
	pg9VUlGNq9AU=
X-Received: by 2002:a05:620a:1d09:b0:93c:c96c:a5a8 with SMTP id af79cd13be357-93f6f8249cdmr284071485a.53.1792744457056;
        Fri, 23 Oct 2026 01:34:17 -0700 (PDT)
X-Received: by 2002:a05:620a:1d09:b0:93c:c96c:a5a8 with SMTP id af79cd13be357-93f6f8249cdmr284069085a.53.1792744456592;
        Fri, 23 Oct 2026 01:34:16 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2104627e0sm58222525e9.9.2026.10.23.01.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:34:15 -0700 (PDT)
Date: Fri, 23 Oct 2026 10:34:14 +0200
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
Subject: Re: [PATCH net 0/6] net: stmmac: XDP path fixes
Message-ID: <atscBtA8faGJ4o01@lore-desk>
References: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
 <179274313871.3327.10475535220969393247@kernel.org>
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
	protocol="application/pgp-signature"; boundary="lRlEkSG0nrXxOB84"
Content-Disposition: inline
In-Reply-To: <179274313871.3327.10475535220969393247@kernel.org>
X-Proofpoint-GUID: NNY_0ZhIOj0fCvV1RrtGFLH8ta3VTvOr
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb1c09 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=jeKYxtEjmYGD5WCmXysA:9
 a=CjuIK1q_8ugA:10 a=TGL2fYcsFtN_zcw-cNEA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfXw2bMG+t0cE7H
 7Bt8NlMhQGdC/2ENY1DlnwVlFSpk64KOJEYdZMV9coTpX64N8HxPAUO/mzAuQ1qezCk76un1IqV
 aIVTINZ3hfik+Y8HlT2+Ke6LLL0Dfng=
X-Proofpoint-ORIG-GUID: NNY_0ZhIOj0fCvV1RrtGFLH8ta3VTvOr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfX+R+Rh79TgE9S
 ly9AyjsgRiRr/Nu3SqAe4kuNShxW/vqBUFXPM/fJuK46yBiyBPGEkScm/CT8iyKrQ5FXdo2YusO
 k0khwbI4HXqE14OUX+ldU+/E6IQ41Tj9BotXa8coojFce7Y8rtFPLcvLNI2UvwL3YfbzfUP6N31
 tgr3N6tUH6/wedenR3m9jif9eFGgW2xBazbUsZYK4EXK4P+rI5SFMrlipVMjBYxwIrAjl19KzC0
 XC+COZoueUzrUxHW6NmBDXyk1rTev/+zNAnkZD5Hx4EaQfRIO5b1FgLu7COhuo7DWxq8yLG6LqW
 56HzZRP3GlcaDt07tYkCUQN+Yk6yw1sZ1P9XocxRKpu6gV5U1+AYcumSkq+sCDOwX9768sP53FZ
 Z/cs68i7fGxPA7YIUpgPg0a73wj+YgG6Q68SVzWlNNJoCEReenvHEFxY9BDv+GntiVSAUZvf04t
 wEwweIjbvGLWNvbZ2lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230033

--lRlEkSG0nrXxOB84
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

The issues are reported by sashiko or spotted during code development

>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

They are real issues reported by sashiko or found by code inspection

>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

The series has been tested on Qualcomm Rb3-gen2 board.

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

--lRlEkSG0nrXxOB84
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatscBgAKCRA6cBh0uS2t
rIpOAPwODAt8L3TAMPYqpuMKG9zg5Q3KhWAnQEHWpI/u7fuNCgEA/kCIx4D8M9eR
jTH9fhWjO4Baz9wjR/8WD+NaIz3Hegw=
=X5cW
-----END PGP SIGNATURE-----

--lRlEkSG0nrXxOB84--
