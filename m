Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793696136;
	b=Nv9tPaiYGe7ygFGGGr16tjmfuTWvl/0K32N+8EuRDyBNd6Zgo2TPtat6McMboPHg3/R1
	 UnjE+GuLXUGGXf0voYVqWIzpSd+TSDWkf3vleIjqqN30D59/5yuqpn2mkmrkF0GjU8i5j
	 dq9qZ4nXCJvdVhw2VQj96CiWFKC4ZbNN8U63P97JFXrJZGTzYTo2ThMsIGUFwqEByTv/A
	 5xpTAU8d7BiFwj1h9SJKEoh4oq7pUZm23l/CDaRDfQ9GatI1d3zZ1oZzSxDQ3bvSjw7c8
	 2pTovZ4QutG83IFnVaEf7fAMi1T1ERcF386NQvCenXTxvt2jNeV1t7suGVjEphedBUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696136;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qbsOpFiwDX2dELfvfvGwSVoz/OIQAceMk9d+tt4Lk5I=;
	b=keL2EPQELOyZnP8uaRprlI8A4evtF9ZfU/iau0E+RFQ7UlNl4NlCaCY7TtwP4ZjhvXhm
	 i84zXOzid2wV0hY8dYPwBWxXH9Lei3ch2J7PmBY9C2HHC6/XuD5+HTvRYs8wtbUrZNbFH
	 snTx3kZSVWH/4l+H1GO+noLcv55aUCg7cKe03PgNBLJOrAmTi6WaXaKfsBKcMGe0UuO2/
	 7AGPGpYGWRMMNIH4hXuQKZQbnCIOKMCtHvQgP1rIN1GetQajtqonx8Rp3EZdQTrn9bpEA
	 7o2ps9WkRJSVFARls/ZJEhFPue/LNMnB48qjxYqC37za6+pQISyrn8P/MGe104+CE3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OWmJBZ9g;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HQBJlRfR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E036606A337
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E036606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OWmJBZ9g;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HQBJlRfR
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A37tXgT1397190
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 08:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qbsOpFiwDX2dELfvfvGwSVoz/OIQAceMk9d+tt4Lk5I=; b=OWmJBZ9gc8nkZerz
	b1HG3TUo8MIzBBrnc4dE088yesRqksaRibt7o2ejR7EMPKLM7Sd+wr+prPDIZVwl
	Pv49uXdDmq2HLJMXKLwIKsL+mhOo8lJkCv4lGoLBRzEmzEeUP581zuX9q0KUlZD2
	zo+oKNv1sqaLORWJq1VbGjXIHmE0UTS4R5/AsES2rA4KftwMi6NcmdQUyurgGFaA
	2S8lf/Gz0dBh9bpxXBZbI/0Z+PTYEbDOvuEeu0QNPDDmxmfyp6lVSyXRCQd6+QMi
	cYe5cxo52UItq7Yv/2hPxg3PiCga9BvqtFeDnqs7EUGIkRbi6O9tX/WQvKQYPeS5
	CNW8/g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq4v5hss3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:55:35 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91c7cb9e267so46377526d6.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 00:55:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793696134; cv=none;
        d=google.com; s=arc-20260327;
        b=ZEEIlj39DToyShuT1auHDSc7IGCyilnieR4Mp0WG4fo/5l6XJQf5TRxPiDMgODhDTF
         dWCOcI0J6fXP2WaHeRuvqTktqpiOFGzR/KmY3P0RB6okCNwqMDORwH8fhCXyzTHnQrDz
         E/S/7+FUUfaZZE4HU5vsKbE+taUOShvjYQDc5XJ3WhLxrU0gGLGl5eH+t9hqAj/M2SiQ
         ZczAXviTiLHvdbZYhXqfe1wApSim3XIk/StXMyG/D/qdwN+P2io2RdYrpLykbLYA8Phe
         a0I1XDJbKpFgTNOMqAnB86L41g9GaXue3zkFDR+BCAFaIN2mA8erOV3pVgtEn12YVNKp
         iRiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qbsOpFiwDX2dELfvfvGwSVoz/OIQAceMk9d+tt4Lk5I=;
        fh=93HCxGVseL5JN/Ll70fpN2fBy36qYDlXaAzE3OSzsgI=;
        b=b2/XPTxEJZ8A2OnKqdRSH7P0fXQGYLsCWY7y532WtzDgt3bwtuNVflC13dK2GDaCxI
         42U31zDpRzmgGyoJWvwZYfn0HQaNuRYc0BL12TOozAgLVFJ5RKAVCKZe0wSMPGszzv1n
         RS/diiHfJrBOv+RX2ojlx91FT/KNoKbK72DpSbeL4hXNg3mdDGgGQVnaTfftw3Btb+wU
         IDLrfOeE+aUgvpqUyeWH5BsbCtwd8CIWgB9H84mfwzy+CxZdrUylAP5ac+SGhwlFn8jy
         we7/n7vrdqo3c3r0uGJ84q9QXbedNYa9W0JPDP/6xKH76uS9Wcft9SEc+XZUl1xrZQTN
         Jj7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793696134; x=1794300934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qbsOpFiwDX2dELfvfvGwSVoz/OIQAceMk9d+tt4Lk5I=;
        b=HQBJlRfRC+4iLMd73Erbza31dHAaBeBRf1r6hDddFdZ93Xri3jZ4/KbuH9SbLZ1s3W
         UfW7WYqAybK3Qqo9QJoyenFBbCIIuwApCDIrxFzJgSz1Re47+eBz6Pq9pF7QITETDOl2
         aBfCnDZHEJb9zhTJX0oqf0rgPgtjKmBtsO5gDoQ5UOsazp6m4YxEkJfRM4w8zjsdhbdm
         GnixX7m65YBH8SB9EnJbFY9KuGEeFHQg0O/MFPM1N0fvUCfXaUrDUK6+5k/BrKcRy4q6
         Ov2pHvojv2Dkr1ql77Fq034QWJL0jfnM1wlaha0m3eDrCAehkXTU6Uo8I+3NAltzPcCK
         EcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793696134; x=1794300934;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qbsOpFiwDX2dELfvfvGwSVoz/OIQAceMk9d+tt4Lk5I=;
        b=jMGKXu7jXWgfcOhbvl2lM2smchbtX3C5JOJjwI+sm1PJIowoiXJMMO7nEukaqjVU+m
         dlQsrXLo+dhxC3b5GQdeKIH0yvp/SOayhjSqrnW7CGcuhVdpScrN4JzlotgzxE6zvO8t
         R0EjvjGq3NK1zypbTnfMa616fcwETIuXcJGzmLC6PhNsT9JhHG5L5u5DfvhTEUo0ubA9
         OaffOB+7hd+xz2UHq3NjhOs1nP+pL/9WLe99oZylS2dphOMaLYmoa59s7DCHphA6mWrn
         /wF8f4JcG+wcTDrEK+sXZdNs9kbFzyKT5YTmTQg7GzjURnsdS/r2AeLnjf3KPZcKKbGF
         U0lQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgeDKS6Muf6i/nChPiBS35CAnQc+0usEIGVuKmf1gtssqyDgxJ/wyiOpQhYVeBqKArdYf/iGE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NTya1aJ0fKnB8FPP27shwz2vx85AShjkpD5GbH0vvv1g2rw2L
	FRG2cseuMHTusAEQbg1+fCpaPIxbSy/YPimHUK8GDlba/gHE1BebhP6pZsrdEehASpCIsUeBo1v
	hwf5JyWp4SNMfd98mo+544gvQKGcX7H0UC3NWQRSrFn+4sHnZpBTV2xN9IVNyT/TensoDKAtZJ9
	TppbDYSl4TBByepBRGY8Ru+6F+sltFsuPe6rCHmc9oR13b
X-Gm-Gg: AYBFou3Y67tldyMCp5i+N1cnj0YxqnCkODE70pyLZBpfWF/lHFUOUrOGVUVXFfytQGY
	Bx6zajfQrXa86n+ytUMCQfMp5QXe8NkUJMhKo1PoQOhGLggjHZVT9LeIQ6kToTStiidjhWGT+ee
	hWgwbJbLXVQ/aJ6lt1wc8+4XN42B/ZjNci4mP/kN4TGa6FguFfpazd9jZU8XiRWBKuvOjQntLLb
	0+SEYmlNb5UHUvbajuNunzZ6iFYp+iMbBKkf7bmxYU5s47hbYF/elsbVvlJM9z+IAGpE995mwU=
X-Received: by 2002:a05:620a:4044:b0:93f:3163:3e37 with SMTP id af79cd13be357-944216b1af2mr2157957185a.28.1793696134226;
        Tue, 03 Nov 2026 00:55:34 -0800 (PST)
X-Received: by 2002:a05:620a:4044:b0:93f:3163:3e37 with SMTP id
 af79cd13be357-944216b1af2mr2157954685a.28.1793696133721; Tue, 03 Nov 2026
 00:55:33 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102191922.4044912-1-Frank.Li@oss.nxp.com>
In-Reply-To: <20261102191922.4044912-1-Frank.Li@oss.nxp.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 09:55:22 +0100
X-Gm-Features: AclHuK8MJq-s56wdtunEmLoEql-aTRrOrw2wQVU5g0yE5nW0xqWZNoiPrAFZCeY
Message-ID: <CAFEp6-0CkkoT_xP+zvJ-ffVQnn2E-9AuiC0=cer-Cm1_s1dZ4A@mail.gmail.com>
Subject: Re: [PATCH] net: dma: use dmaengine_desc_set_callback()
To: Frank.Li@oss.nxp.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>, Frank Li <Frank.Li@nxp.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Li Youhong <liyouhong@kylinos.cn>, Joe Damato <joe@dama.to>,
        Arnd Bergmann <arnd@arndb.de>, bui duc phuc <phucduc.bui@gmail.com>,
        Yicong Hui <yiconghui@gmail.com>, Simon Horman <horms@kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
        imx@lists.linux.dev, vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: k3R8W7zd5wZP0p0WkjvNbWy7tRGx7g4k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzNSBTYWx0ZWRfXySGEYIHHFahg
 6BAE9ak7BzoW5q69znHOoRzDC6yVvR5bKdHzbStEjrELz2Bx4nJrssgbmNq4T1XwwA6h1H6E/mA
 PUfpbpcq8pXkEBHvxkgj7/firL5Z7v9r8ZeFwJyu6u+8WX79JONHx/ezvnYfFl+SCUlqclkmM8G
 b2sE0tEVZhCSEDjLU+0u7rXryj0rNa4iOVptpPtJrgNxKvPDhXSDx+VI7oX94cNny8zSIVkc0+B
 xk7l5EMIQ+UhDrdd62m1h2pyGs8TaL0e838poZhVYbrtkKMVzod4kji6CCLNiZ6s0PRhVGZNSzz
 7mD3OcSRxamDSS0qTQU3OxuPpX+x35eH8LjV09hWAsHFjrdZEhwEOXYk3i4+Z8i/PVJ6O3NZK5L
 vku+Vup35hAT1yD28/+9J1JGLGmrWLlcEFUM8xWEDI1JNo9Y8ZHDbRgiP0G5GtBkyig5kPNnHDh
 YWsUBZ2YVAk4iI3FS8g==
X-Proofpoint-GUID: k3R8W7zd5wZP0p0WkjvNbWy7tRGx7g4k
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzNSBTYWx0ZWRfXzkfud9mFrWXb
 RS9ZfDTnj31pJDAu0b4xF+FZ9HvrJL5nlqbcHw13mS//bY56xyoCaXjiarBc68GrphJuX5GUD5H
 FVsg11aGR1As2wI+Xi3u2Hyk+6EVLaI=
X-Authority-Analysis: v=2.4 cv=NeZzRGD4 c=1 sm=1 tr=0 ts=6ae9a187 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8
 a=OV43vvX7PjCfZyRFssgA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030035

On Mon, Nov 2, 2026 at 8:19=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:
>
> From: Frank Li <Frank.Li@nxp.com>
>
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across net drivers.
>
> No functional change intended. Prepare to make struct
> dma_async_tx_descriptor private to the DMA engine.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/ethernet/allwinner/sun4i-emac.c       |  3 +--
>  drivers/net/ethernet/micrel/ks8842.c              |  6 ++----
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c |  6 ++----
>  drivers/net/wwan/qcom_bam_dmux.c                  | 10 ++++------
>  4 files changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/et=
hernet/allwinner/sun4i-emac.c
> index 09b2abdfc9e84..d7ee42b2c1976 100644
> --- a/drivers/net/ethernet/allwinner/sun4i-emac.c
> +++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
> @@ -303,8 +303,7 @@ static int emac_dma_inblk_32bit(struct emac_board_inf=
o *db,
>                 goto prepare_err;
>         }
>
> -       desc->callback_param =3D req;
> -       desc->callback =3D emac_dma_done_callback;
> +       dmaengine_desc_set_callback(desc, emac_dma_done_callback, NULL, r=
eq);
>
>         cookie =3D dmaengine_submit(desc);
>         ret =3D dma_submit_error(cookie);
> diff --git a/drivers/net/ethernet/micrel/ks8842.c b/drivers/net/ethernet/=
micrel/ks8842.c
> index f0d6bfc6025ca..c68abd4643e72 100644
> --- a/drivers/net/ethernet/micrel/ks8842.c
> +++ b/drivers/net/ethernet/micrel/ks8842.c
> @@ -453,8 +453,7 @@ static int ks8842_tx_frame_dma(struct sk_buff *skb, s=
truct net_device *netdev)
>         if (!ctl->adesc)
>                 return NETDEV_TX_BUSY;
>
> -       ctl->adesc->callback_param =3D netdev;
> -       ctl->adesc->callback =3D ks8842_dma_tx_cb;
> +       dmaengine_desc_set_callback(ctl->adesc, ks8842_dma_tx_cb, NULL, n=
etdev);
>         dmaengine_submit(ctl->adesc);
>
>         netdev->stats.tx_bytes +=3D skb->len;
> @@ -567,8 +566,7 @@ static int __ks8842_start_new_rx_dma(struct net_devic=
e *netdev)
>                         goto out;
>                 }
>
> -               ctl->adesc->callback_param =3D netdev;
> -               ctl->adesc->callback =3D ks8842_dma_rx_cb;
> +               dmaengine_desc_set_callback(ctl->adesc, ks8842_dma_rx_cb,=
 NULL, netdev);
>                 dmaengine_submit(ctl->adesc);
>         } else {
>                 err =3D -ENOMEM;
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/=
net/ethernet/xilinx/xilinx_axienet_main.c
> index 8a50cad1c104f..7e83c4b5f1931 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1014,8 +1014,7 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, s=
truct net_device *ndev)
>
>         skbuf_dma->skb =3D skb;
>         skbuf_dma->sg_len =3D sg_len;
> -       dma_tx_desc->callback_param =3D lp;
> -       dma_tx_desc->callback_result =3D axienet_dma_tx_cb;
> +       dmaengine_desc_set_callback(dma_tx_desc, NULL, axienet_dma_tx_cb,=
 lp);
>         /* Claim the ring slot only after the steps above that can fail. =
 The
>          * completion callback can't run before dmaengine_submit().
>          */
> @@ -1565,8 +1564,7 @@ static void axienet_rx_submit_desc(struct net_devic=
e *ndev)
>         skbuf_dma->skb =3D skb;
>         skbuf_dma->dma_address =3D sg_dma_address(skbuf_dma->sgl);
>         skbuf_dma->desc =3D dma_rx_desc;
> -       dma_rx_desc->callback_param =3D lp;
> -       dma_rx_desc->callback_result =3D axienet_dma_rx_cb;
> +       dmaengine_desc_set_callback(dma_rx_desc, NULL, axienet_dma_rx_cb,=
 lp);
>         lp->rx_ring_head++;
>         dmaengine_submit(dma_rx_desc);
>
> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam=
_dmux.c
> index cc6ace8d64371..1479f8362e04e 100644
> --- a/drivers/net/wwan/qcom_bam_dmux.c
> +++ b/drivers/net/wwan/qcom_bam_dmux.c
> @@ -195,9 +195,8 @@ static bool bam_dmux_skb_dma_submit_tx(struct bam_dmu=
x_skb_dma *skb_dma)
>                 return false;
>         }
>
> -       desc->callback =3D bam_dmux_tx_callback;
> -       desc->callback_param =3D skb_dma;
> -       desc->cookie =3D dmaengine_submit(desc);
> +       dmaengine_desc_set_callback(desc, bam_dmux_tx_callback, NULL, skb=
_dma);
> +       dmaengine_submit(desc);
>         return true;
>  }
>
> @@ -477,9 +476,8 @@ static bool bam_dmux_skb_dma_submit_rx(struct bam_dmu=
x_skb_dma *skb_dma)
>                 return false;
>         }
>
> -       desc->callback =3D bam_dmux_rx_callback;
> -       desc->callback_param =3D skb_dma;
> -       desc->cookie =3D dmaengine_submit(desc);
> +       dmaengine_desc_set_callback(desc, bam_dmux_rx_callback, NULL, skb=
_dma);
> +       dmaengine_submit(desc);
>         return true;
>  }
>
> --
> 2.43.0
>
