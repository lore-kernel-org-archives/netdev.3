Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793779761;
	b=vvx9jjep2NhL0Ul7AjM7hlQusVULLAq/zC3v7wB0ooXNUNXsb5+sbfx4fX7eryzH5s89
	 4daXPZMNeieY9/y1xUGhGyy6a3TSZnzGuaCsr7ExZn+4H1CKZQ44McoYhU91ChS0dF5so
	 OfrrovWcqrGAme3/5s5v3D34ZHgeOQt/ERQldkhPkoviZZwGQI0Cye83G8H447AJgGTQP
	 9MjCeft2QyQJBsM4Nt/fCkDvDoDT6fg8SJLwW3jSslGLC0qk9C7HwU8bOUc+Nd08erlU6
	 Ir2qz4YiynbMhzJgSqZJsJ66RLWGL10XmrOJM+kGmYMh7U9rPs1/pkIWVMh1yAsNWIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779761;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=RZRuOZhvJ+M8UAjchgBjXC6213tCtv2f8+7YeeLXEsQ=;
	b=b6aVujK21Lq08eztIZjbkQ4Pu5ix8DaFbJ8466r1FLSxPNn47KGlyxph+t2upqHImlpF
	 ehS3hy3T5s8g1tIaUMxf2k3vO/hNttbk5V4MJ4ZEau0OlMIeTwSzJ+9v/L1GNOZF7cGih
	 UcGx3DHz5swzbcLsiO/nU7hXSt4BxPs/AyMUynoNXeeA1darJ2J6hzr8/+NIiO6wK52Y2
	 gaGZvkKoD7Z6+f/6cWcX3pdXgjA5eY1qDRS1APBn3Pd6jmxtUcFNgEL/Fsa0trpZrUwSb
	 0M55XAtUYZVD+OX0yqydVD/QhpzERb2U1UI3+MOA3/yUyZYEHPyxWmFDU/wEZ9W1oOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kiNV4aT1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OYMKMGJO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C112606A329
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 08:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C112606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kiNV4aT1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OYMKMGJO
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4721TG3867705
	for <netdev@vger.kernel.org>; Wed, 4 Nov 2026 08:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RZRuOZhvJ+M8UAjchgBjXC6213tCtv2f8+7YeeLXEsQ=; b=kiNV4aT1KYh+5EFx
	eB6M3wCE0EpfzX3kQBv4YXabp/AtE2h9dZkR9sUgfXDP2cIZouXeOw5KA96xagjd
	UvthDoYOcgmv1lsrfKT4dHlX1LJyJ2dysAFSiE+j5VOnpI3OmvYBcRnn6CR/XCx6
	9qXpvcopWjIVQGpzoOrnzLnf4hjtvzjBZmcc3GyGs5T5FMgwYqVzYmHobeofsMJ3
	NEYSJik/c9pBls67QWJNxynCtry2+9AKU2VK9s8OdJwARUrlOBrQAHeYVsEvT0mz
	+Lzpv+txhSpGnBpOkV2NLftsGQ+EG/mFPeo9JCdQlwqArU2sgYA3kfplhWJZKtSe
	LX2CCw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8y2p73-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 08:09:20 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91b7e7d5f56so11688556d6.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 00:09:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793779759; cv=none;
        d=google.com; s=arc-20260327;
        b=k4wbZnARoMqOwIJ3DyRsrHBKr0PECjMNJxUfoSoEd/UtBN5sLMQVM2Nnl5Vf46hw8t
         k+/QQVCb79TKg7hUcZaoE+yJqCaBfGzp349DShaZTQE04qrT3qTY54VVl6hnmiSig99a
         YsKfdX9N11e+MEyUep1f2Ue7SYqEOmIA0iETBxLuYdS1wAPXpUek0AMQ0mek5H4Itbx8
         D7S9WqrIpLT+35RoJuwjgWxY5xW7ABWte85Zk3Ul73wSiaEpOur8snJYUyKLszm7rEUU
         brcteNvscHnsSNJsgIbRGsYPZoeybuF5iF1vBqq/qsO/IiCX/64GVpFlY/sZryKwmUhu
         14qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RZRuOZhvJ+M8UAjchgBjXC6213tCtv2f8+7YeeLXEsQ=;
        fh=lowSggg57Ew+HdkNvzIeWICk7HNynO+hCQdm7yRJyas=;
        b=ewEL7+0BEid7VWVNnDUUnvf+Xzx3QH4f6CrUSL3rroYgY4xoSdT4pJ5wtc5PDieB3T
         KWbO5HtjFIQeOoLre12dkF9/PVhfbff995O+vD27UVYoCw+2fPt+o4B3rLE6C7HY0KBS
         8qAuDZyym0oUBn21EtCgQaFjIB918luosZ3x+2bFxb4uVtqNMW9GvqybAlIHefWiW0PP
         JE9dpKyxS0pI6pG+Z+8Pkhm1ZvhwDu5j4gvLakqMzyoaWJApuUDnOhl4zNE7aVgUB678
         ueC27L/BAkNGWclr5o55ytV1FExaxiBQ80nYRqa2kd5RmoYjXyOBP41fcjpt83/un6pX
         ksHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793779759; x=1794384559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RZRuOZhvJ+M8UAjchgBjXC6213tCtv2f8+7YeeLXEsQ=;
        b=OYMKMGJOTNcvFP2pksDGBnXRktz46TkbpRKexrz9JapAhNKxhCUWjV54aTdvbFx40l
         ewqGIbgM3DVCV6lKoAgMz24UMqOQtKrgBYSWluC76Hs/g6KTxa07bmSxsCAJSFyyvQ9Z
         Fa++gfis8He+RsoPPOQQv2RT59v2lTXB48n6PoBUnRdmEgTyKiZugOnzmAj2JTejeAZH
         rNkpDlOdkVGsi1IJ0kiHYkW3w3iyisjj+7ktwdQ5KKSxqJEX/cIiS91vNeftetIi+gI9
         29JkmABNylnwuZ9OTnRfJAzmfnjatQm34gYmkk0bnfiywc6YMikOhB4eeayV5wNjm7Nw
         CmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793779759; x=1794384559;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RZRuOZhvJ+M8UAjchgBjXC6213tCtv2f8+7YeeLXEsQ=;
        b=z5NS49iDNSVJCfg8qlDg+DLUMW926nJlJhbCKJ8YXWlNoJOikTNbs9LhrpaeQj6t6z
         SQZetyWiAuU2dHPKc6hgVKPvuXb/QF5fxvqIrpT1+k0tSa19mETdM34gpxWwPpgtN8+g
         WcAegYn++bAct8jVNfslcEKvC08QMZ5VTBF6FVwm+Ss1yjzcFYWpQVZi2PHFF2e82uYJ
         8YFerQ92y28vzJpurVAGnn/G0XaunebVS7y21ya/EBRsa2dojEnCFxuVmrnQEOtwOiwA
         hJEJ1v41iBD+zZN1hCKIWv0SKQ0pLhdZR08LvoKjT9oidyySGg+G73ijvz2HpPq2gumE
         Fv1g==
X-Forwarded-Encrypted: i=1; AKwUvByPgF+9ovSjmoZMEHjaug8md2m2Vs9DyeVQtptJvfiCziExuQgcoEB0PwpQAEqt5002CfuO4QA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VfrtFkkxvsC2CSz0vkaYaCs37l2El7+biSaLU5yJ/6GGAT+nL
	2NNfkBmG4aoLP+Cq98dPmDbtCvPJWux7x6tBqOkbLmDZfnJooh3tskDF/uSHXf+1j7kbnXOdlvs
	/YCVyQrd/KMSnml9NmPD/zb1kbiGW1ML2S/Ln2jqyNW1Nor7iPsEdD+Ourftpm9OS63W6qLX1Pv
	tQcwsu+Z1VuIRC9+nsG7f9Rr2UrU5GnSktK8nffjjl/ZUk
X-Gm-Gg: AYBFou1S87dslfZJgLYowUAf1xgzvSG/G1WGxEDLIQHs+eLH3Mu1ScISjxXOIQPX4vG
	4GUmcRPot3O8EFOu+44/x5dY04tF6gKyBj1ChrR4N//53JFvbjEmCeAJjKvcxVHym1wOoHPEL8l
	5kcE66tSENc0ngG9PdpoYC8Ysztr3r7LQbJ7XbCzFILa/eWNPXtByKN9nE6QY/v87lA2pIAVDDv
	MW3dQ//6DnLaw/EdhXEQWJjFPdKAXmTR+VNTTNNN4eUYgcO1Sb1va1tzkg82wo9XP5J58a58VU=
X-Received: by 2002:a05:620a:4627:b0:93f:362a:a893 with SMTP id af79cd13be357-944217ee29amr2579091485a.50.1793779759023;
        Wed, 04 Nov 2026 00:09:19 -0800 (PST)
X-Received: by 2002:a05:620a:4627:b0:93f:362a:a893 with SMTP id
 af79cd13be357-944217ee29amr2579087185a.50.1793779758458; Wed, 04 Nov 2026
 00:09:18 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-qcom-bam-dmux-vmid-ext-v4-0-3690cc5ca0fd@oss.qualcomm.com>
 <20261103-qcom-bam-dmux-vmid-ext-v4-2-3690cc5ca0fd@oss.qualcomm.com>
 <CAFEp6-3iRLDJUHAEa4qGGcqJYUSB733wKBFDw_k5NF7LQF+jQg@mail.gmail.com> <ca063b2c-a218-450d-b28e-7bb1c775e7f1@oss.qualcomm.com>
In-Reply-To: <ca063b2c-a218-450d-b28e-7bb1c775e7f1@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 09:09:07 +0100
X-Gm-Features: AclHuK_qb6QHn3SKTgJyNyyRF7E8etXUIprr9JLQmofzs9FM6AEtBI0fw4N8r5M
Message-ID: <CAFEp6-1SjCBz5G-9YgJXTQsk+YU378AqZUh61cHrOpXxpR8AGQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] net: wwan: qcom_bam_dmux: Assign
 restricted DMA pool to remote processor
To: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Cc: Stephan Gerhold <stephan@gerhold.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Dumazet <edumazet@kernel.org>, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: G1xv9SLiG01xJwUERbA8YuQwHn-ZFiyv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMiBTYWx0ZWRfX4qkbhN+J31xL
 6564Zk6g/NoitvqyeVtQb9aLBRoFLqes5LowPOdLx9v7cy7GkHHbGlHdBL332WExKwQEfQwCTcf
 OXfTyFT+veQHBcYmKc96B2l2tY368Hslvioty90nWsy7onS9qtP6XZc+2TccnJxOa8l6yvOc73Y
 s0EUKp2Y086/Xzf7g5U3DAabDRFGPENFWZPwg7H9zXTgKkHkeb907C8K7Tiy8ki+hODIeWQwgvG
 HhmTFbi84mAfuXIa3y4r2KcJwylVTnvAULw8DgNCpp078IF1kvPy59zGxJhnztwha07netVyRYX
 S+Z1PrsaSqhxuMWtEnp2UoaRYufuh7clVggU3qTEGqX04iMKi2U5DvSCOuTojZ5tQFmrQVLxysp
 dmUGBlCvphHY8Tbs5VUJWpp19pFSZzZQxIpMPMXrZsWScLDMAS7374TMwYJG+De8ugqLOnUcDoc
 6/n1OgE83bYXK67p03Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMiBTYWx0ZWRfX0uqMdW3FoeON
 jBKTPJskTCcdyjh6xR+pKH5xdPkKQ+LRt9gjQKgWOHKtswAO/LiiXiIZIGyPXh2lR3fl4L8RQoi
 6VxwZ89lbri9N+Jb1E4K/yauHXbrWxc=
X-Proofpoint-ORIG-GUID: G1xv9SLiG01xJwUERbA8YuQwHn-ZFiyv
X-Authority-Analysis: v=2.4 cv=NP5AaE6g c=1 sm=1 tr=0 ts=6aeae830 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=sSW3jX2S7Jz77nn5xcgA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040032

On Wed, Nov 4, 2026 at 7:22=E2=80=AFAM Vishnu Santhosh
<vishnu.santhosh@oss.qualcomm.com> wrote:
>
> Hi Loic,
>
> On 03-11-2026 09:34 pm, Loic Poulain wrote:
> > Hi Vishnu,
> >
> > On Tue, Nov 3, 2026 at 3:19=E2=80=AFPM Vishnu Santhosh
> > <vishnu.santhosh@oss.qualcomm.com> wrote:
> >> Some Qualcomm SoCs, such as Shikra, run the modem in a separate securi=
ty
> >> domain with restricted access to system memory. BAM-DMUX DMA mappings
> >> and BAM descriptor FIFOs must therefore be constrained to a designated
> >> memory region that can be shared with the modem. Accesses outside that
> >> region can trigger an XPU violation.
> >>
> >> When qcom,vmid is present, require a restricted DMA pool and assign th=
e
> >> entire pool to both the local and remote execution environments before
> >> requesting the DMA channels.
> >>
> >> This ensures that BAM-DMUX mappings are within the assigned region. Wh=
en
> >> the BAM DMA controller references the same pool, its descriptor FIFOs
> >> are covered by the assignment as well.
> >>
> >> Track the assigned execution environments explicitly and reclaim the
> >> pool for the local environment after DMA channels and mappings are
> >> released during remove or probe error cleanup. Skip the reclaim and
> >> leave the pool assigned if the remote side still holds its power vote,
> >> since it may still access the pool.
> >>
> >> Fail probing when restricted DMA pool support is unavailable, when the
> >> VMID property is malformed, when memory-region does not reference a
> >> restricted DMA pool, or when the pool is not attached to the device.
> >>
> >> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> >> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> >> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> >> ---
> >>   drivers/net/wwan/Kconfig         |   1 +
> >>   drivers/net/wwan/qcom_bam_dmux.c | 114 +++++++++++++++++++++++++++++=
+++++++++-
> >>   2 files changed, 113 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
> >> index 958dbc7347fa84ee869439bf8b503037faab8bef..1b133c5623161526969814=
0187ca3141dfe48dbf 100644
> >> --- a/drivers/net/wwan/Kconfig
> >> +++ b/drivers/net/wwan/Kconfig
> >> @@ -65,6 +65,7 @@ config MHI_WWAN_MBIM
> >>   config QCOM_BAM_DMUX
> >>          tristate "Qualcomm BAM-DMUX WWAN network driver"
> >>          depends on (DMA_ENGINE && PM && QCOM_SMEM_STATE) || COMPILE_T=
EST
> >> +       select QCOM_SCM
> >>          help
> >>            The BAM Data Multiplexer provides access to the network dat=
a channels
> >>            of modems integrated into many older Qualcomm SoCs, e.g. Qu=
alcomm
> >> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_=
bam_dmux.c
> >> index cc6ace8d64371eb8d00c638a39b234ee540b83c9..c9639474e58acc16ce0d04=
f181b2e999cff42bd1 100644
> >> --- a/drivers/net/wwan/qcom_bam_dmux.c
> >> +++ b/drivers/net/wwan/qcom_bam_dmux.c
> >> @@ -9,14 +9,17 @@
> >>   #include <linux/completion.h>
> >>   #include <linux/dma-mapping.h>
> >>   #include <linux/dmaengine.h>
> >> +#include <linux/firmware/qcom/qcom_scm.h>
> >>   #include <linux/if_arp.h>
> >>   #include <linux/interrupt.h>
> >>   #include <linux/module.h>
> >>   #include <linux/netdevice.h>
> >> +#include <linux/of_reserved_mem.h>
> >>   #include <linux/platform_device.h>
> >>   #include <linux/pm_runtime.h>
> >>   #include <linux/soc/qcom/smem_state.h>
> >>   #include <linux/spinlock.h>
> >> +#include <linux/swiotlb.h>
> >>   #include <linux/wait.h>
> >>   #include <linux/workqueue.h>
> >>   #include <net/pkt_sched.h>
> >> @@ -75,6 +78,9 @@ struct bam_dmux {
> >>          struct completion pc_ack_completion;
> >>
> >>          struct dma_chan *rx, *tx;
> >> +       phys_addr_t dma_pool_base;
> >> +       size_t dma_pool_size;
> >> +       u64 dma_pool_perms;
> >>          struct bam_dmux_skb_dma rx_skbs[BAM_DMUX_NUM_SKB];
> >>          struct bam_dmux_skb_dma tx_skbs[BAM_DMUX_NUM_SKB];
> >>          spinlock_t tx_lock; /* Protect tx_skbs, tx_next_skb */
> >> @@ -762,6 +768,96 @@ static int __maybe_unused bam_dmux_runtime_resume=
(struct device *dev)
> >>          return 0;
> >>   }
> >>
> >> +static int bam_dmux_assign_dma_pool(struct bam_dmux *dmux)
> >> +{
> >> +       struct device *dev =3D dmux->dev;
> >> +       struct device_node *rmem_np;
> >> +       struct reserved_mem *rmem;
> >> +       struct qcom_scm_vmperm dst[2];
> >> +       u64 src =3D BIT_ULL(QCOM_SCM_VMID_HLOS);
> >> +       u32 vmid;
> >> +       int ret;
> >> +
> >> +       if (!of_property_present(dev->of_node, "qcom,vmid"))
> >> +               return 0;
> >> +
> >> +       ret =3D of_property_read_u32(dev->of_node, "qcom,vmid", &vmid)=
;
> >> +       if (ret)
> >> +               return dev_err_probe(dev, ret, "Failed to read qcom,vm=
id\n");
> >> +       if (vmid =3D=3D QCOM_SCM_VMID_HLOS || vmid >=3D BITS_PER_TYPE(=
u64))
> >> +               return dev_err_probe(dev, -EINVAL, "Invalid qcom,vmid =
%u\n", vmid);
> >> +
> >> +       if (!IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL))
> >> +               return dev_err_probe(dev, -EOPNOTSUPP,
> >> +                                    "qcom,vmid requires DMA_RESTRICTE=
D_POOL\n");
> >> +
> >> +       rmem_np =3D of_parse_phandle(dev->of_node, "memory-region", 0)=
;
> >> +       if (!rmem_np)
> >> +               return dev_err_probe(dev, -EINVAL,
> >> +                                            "qcom,vmid requires memor=
y-region\n");
> >> +
> >> +       if (!of_device_is_compatible(rmem_np, "restricted-dma-pool")) =
{
> >> +               of_node_put(rmem_np);
> >> +               return dev_err_probe(dev, -EINVAL,
> >> +                                    "memory-region must reference a r=
estricted DMA pool\n");
> >> +       }
> > You later test with is_swiotlb_for_alloc(), so isn't the above test red=
undant?
>
> Right. is_swiotlb_for_alloc() is only true when the DMA core attached a
> restricted-dma-pool from memory-region, so this check is redundant. I wil=
l drop it.
>
> >
> >
> >> +
> >> +       rmem =3D of_reserved_mem_lookup(rmem_np);
> >> +       of_node_put(rmem_np);
> >> +       if (!rmem)
> >> +               return dev_err_probe(dev, -EINVAL,
> >> +                                            "Failed to look up restri=
cted DMA pool\n");
> >> +
> >> +       if (!is_swiotlb_for_alloc(dev))
> >> +               return dev_err_probe(dev, -EINVAL,
> >> +                                    "Restricted DMA pool not attached=
\n");
> >> +
> >> +       if (!qcom_scm_is_available())
> >> +               return -EPROBE_DEFER;
> >> +
> >> +       dst[0].vmid =3D QCOM_SCM_VMID_HLOS;
> >> +       dst[0].perm =3D QCOM_SCM_PERM_RW;
> >> +       dst[1].vmid =3D vmid;
> >> +       dst[1].perm =3D QCOM_SCM_PERM_RW;
> >> +
> >> +       ret =3D qcom_scm_assign_mem(rmem->base, rmem->size, &src, dst,
> >> +                                 ARRAY_SIZE(dst));
> >> +       if (ret)
> >> +               return dev_err_probe(dev, ret,
> >> +                                    "SCM assign restricted DMA pool f=
ailed\n");
> >> +
> >> +       dmux->dma_pool_base =3D rmem->base;
> >> +       dmux->dma_pool_size =3D rmem->size;
> >> +       /* Track the destination VMIDs explicitly for the reclaim oper=
ation. */
> >> +       dmux->dma_pool_perms =3D BIT_ULL(QCOM_SCM_VMID_HLOS) | BIT_ULL=
(vmid);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static void bam_dmux_reclaim_dma_pool(struct bam_dmux *dmux)
> >> +{
> >> +       struct qcom_scm_vmperm hlos =3D {
> >> +               .vmid =3D QCOM_SCM_VMID_HLOS,
> >> +               .perm =3D QCOM_SCM_PERM_RW,
> >> +       };
> >> +       u64 src =3D dmux->dma_pool_perms;
> >> +       int ret;
> >> +
> >> +       if (!dmux->dma_pool_perms)
> >> +               return;
> >> +
> >> +       ret =3D qcom_scm_assign_mem(dmux->dma_pool_base, dmux->dma_poo=
l_size, &src,
> >> +                                 &hlos, 1);
> >> +       if (ret) {
> >> +               dev_err(dmux->dev, "SCM reclaim restricted DMA pool fa=
iled: %d\n", ret);
> >> +               return;
> >> +       }
> >> +
> >> +       dmux->dma_pool_perms =3D 0;
> >> +}
> >> +
> >> +static void bam_dmux_remove(struct platform_device *pdev);
> >> +
> >>   static int bam_dmux_probe(struct platform_device *pdev)
> >>   {
> >>          struct device *dev =3D &pdev->dev;
> >> @@ -796,6 +892,10 @@ static int bam_dmux_probe(struct platform_device =
*pdev)
> >>                                       "Failed to get pc-ack state\n");
> >>          dmux->pc_ack_mask =3D BIT(bit);
> >>
> >> +       ret =3D bam_dmux_assign_dma_pool(dmux);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >>          init_waitqueue_head(&dmux->pc_wait);
> >>          init_completion(&dmux->pc_ack_completion);
> >>          complete_all(&dmux->pc_ack_completion);
> >> @@ -829,8 +929,11 @@ static int bam_dmux_probe(struct platform_device =
*pdev)
> >>
> >>          ret =3D irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LIN=
E_LEVEL,
> >>                                      &dmux->pc_state);
> >> -       if (ret)
> >> -               goto err_disable_pm;
> >> +       if (ret) {
> >> +               /* The PC IRQ may already have powered up the RX path =
*/
> >> +               bam_dmux_remove(pdev);
> > Calling remove from probe is a bit unusual, have you checked that
> > everything is correctly balanced?
>
> This was changed in v3 following the Sashiko review of v2 [1]. The PC
> IRQ is already requested at this point and may have powered up the RX
> path, so in v2 the error path reclaimed the pool while the DMA channels
> and RX buffers could still be active.
>
> Yes, it is balanced. At this point probe has assigned the pool (if,
> qcom,vmid is set), initialized the works, wait queue and runtime PM, and
> requested both IRQs, which is everything remove() undoes. The steps that
> may not have happened yet (netdev registration, RX power-up, the PC vote)
> are handled the same way as in a regular remove: unregistering an empty
> netdev list, power_off() and free_skbs() are no-ops, dropping the vote
> only clears the SMSM bit, and the wait returns immediately if RX was neve=
r
> powered up. The PC IRQ is disabled before power_off(), and the IRQs thems=
elves
> are released by devm afterwards.
>
> Do you see any specific concerns here?

No, that looks fine then.

>
> [1] https://lore.kernel.org/all/178996250389.2160803.17277339384338088713=
@kernel.org/
>
> Vishnu
>
> >
> >> +               return ret;
> >> +       }
> >>
> >>          /* Check if remote finished initialization before us */
> >>          if (dmux->pc_state) {
> >> @@ -845,6 +948,7 @@ static int bam_dmux_probe(struct platform_device *=
pdev)
> >>   err_disable_pm:
> >>          pm_runtime_disable(dev);
> >>          pm_runtime_dont_use_autosuspend(dev);
> >> +       bam_dmux_reclaim_dma_pool(dmux);
> >>          return ret;
> >>   }
> >>
> >> @@ -879,6 +983,12 @@ static void bam_dmux_remove(struct platform_devic=
e *pdev)
> >>          disable_irq(dmux->pc_irq);
> >>          bam_dmux_power_off(dmux);
> >>          bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
> >> +
> >> +       /* The remote side may still access the pool if it holds its p=
ower vote */
> >> +       if (!dmux->pc_state)
> >> +               bam_dmux_reclaim_dma_pool(dmux);
> >> +       else if (dmux->dma_pool_perms)
> >> +               dev_warn(dev, "Leaving restricted DMA pool assigned to=
 remote\n");
> >>   }
> >>
> >>   static const struct dev_pm_ops bam_dmux_pm_ops =3D {
> >>
> >> --
> >> 2.34.1
> >>
