Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793721886;
	b=HNdHrfXSOb3usp9hXk+9B05aZYlGkXcVyeNdVuQhGGGjlUGPzSr0VMbsi8COIXhkQWEr
	 pX5CPSBg+kyCt/36zd5UiHrh29lU+X4PTu/VKO0GdwibmeZzv8L0dfG9QQB1Sm8CHKDbO
	 i8OdGAZRot0ZOCSl1ccrT09I7KiFk5KEkhGqPA2MVdQuMKn/oaI+ZRbnGpe18jLc6/ri/
	 d6+4347a3mYQBSjneIP+7UbNNLAvYIpKO1G1j4Hz7oIMIDg29r6MwgmmSU9effNRrrFsB
	 2eHIvEuSy/eqs1YFU00E9Zlw5ktNDwEsSX3TaZs8Mn0smvLI8T/C3SEbnjGsopqiAaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721886;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gipF20o2h34hBulprmr5ZDNI7YyF8KnzA3/1TkP3zHU=;
	b=QRUzB0KvanMeFBx3EEFua2NXSm5ldONnxSGQIBtXraJYO8kQMTqwrXtsv/8Y/bAxSR8k
	 /qbX0adzPtZJcOZbQcBv+NYgFIp+cP9b7YvXZI/ihAvs8UQGj7v8BxtDnDuO+h9G6jyB9
	 qlVLZ0jzdVVE2sq31xwrtILWEowOqTHuYySRpzrH9q+1089GjsspIJb+0WeKdIKeDtGe/
	 soyBJJpuEtQ7WJYYkSm5+QT7R6QtRRZF9fOEKVI4ywXCbou/reVbaKoVG7zfLdD6Qen8K
	 EI+ReCtmJ4TaGmm0D9owbavXFVp9N1XWb/zTUaTFwVhl41Fde6eEbtsBs+oyDotTTxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GlWUZvhi;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IRg0Jmxi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B865F606A334
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B865F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GlWUZvhi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IRg0Jmxi
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3E9x2d2526854
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 16:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gipF20o2h34hBulprmr5ZDNI7YyF8KnzA3/1TkP3zHU=; b=GlWUZvhim3fVL138
	By17xJF+HAFdSFb5vFlTwCUaaqsy6LeegwVzhxrS3+0sXI5qqsIA6aMowswYfofc
	9rDMFD9+8pw13kTTpvHGQudOSz6PqOYQjddoesXcV2A7Zi6LPPzlkdJKo0JUmtFy
	swaE3AEnWtXhbYVPDiemQSYtiVG1WWmBqCr0ehBbwXs7dHujbHC5ZrEEpgalhkCe
	4tj7v34iHfH42RL11z6c8GvD+ybcJvb2TLOY5Hm/DJwb9z+Hc2bBaOctj6nN86Ny
	dUk5c3FHBUVYiGmIyMP67B2bbTio//ikap8Hbvg1Yt4Ckjbf5zc5WByqFYZ8dlOq
	4G/iYg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq7yctvsf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 16:04:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f3969a2a7so667694585a.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:04:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793721884; cv=none;
        d=google.com; s=arc-20260327;
        b=Uh95P/pzZnmswijzLhKSQFaWS3vrMNRyv5nfnCmgTayE6tb8ZwVzSj7s2hUhx5WiwJ
         eG0+dICz42Tfn2aipe//WGDy8VfnaictqxHULQnQIq+Syvc1D53J2DrurgIxkJBdrzNU
         joaVJpfbx9dYm0qr1DS45XHDs8IN5v1dzJytgB32Skup5RUSqTX73daMABk1vAbx1gDc
         mnn+D4T32VYpqW5cxbVsSfizILgJs8cQSgdc0BlxlV4RyBezFlL33aCXTQfWUYRM52no
         rqvXaNLWLlZzSIiSsQ2Bmf5mIVt0G3FhZ/ZXrwCxi/0h7Sn//D5mhv1acZw5JtzOp1ov
         GOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gipF20o2h34hBulprmr5ZDNI7YyF8KnzA3/1TkP3zHU=;
        fh=I69bi4rHNdL7j6W/0ZtIkkJrMk4JMIOoZTCTNoJA9nk=;
        b=FN9WIA7noCCyJbvDtzT6/DEatSRt1r6hw7Q3rUA0j4Xe/eVZDTWA9bCyyPHIsbSHzu
         2S+RHtbcCmvPqJGL/SpqudS8sQIwv/K86Qk0IjHAWlW86ln1zgHjpysfNc4w/vYiMEac
         P0J0BFO6bgyObwsTrmdZzqy/87II3jC8PM87oSiof7TX5GB63eKEdycvM9AeZUQRRMKk
         2dZDzk+H1LGgkepIxXGFGoBmaL8UqNhP8FOL7RR1fY1FTqxfI8jndF46laVsg7JSKKNG
         P5+iNldztuAuBfTCdjJ07UyPwu2EHksYZ3/ALK5gTzoSzDQCWACbjfImM2DY5EFrl7U7
         0y3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793721884; x=1794326684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gipF20o2h34hBulprmr5ZDNI7YyF8KnzA3/1TkP3zHU=;
        b=IRg0JmxiNFL5tFu2TjUf+fzxnf1SRJB3BXITVRaTgOhro0rjnl3SbLEESnTCrgMgO/
         q2ndJMpA32jDnZCEGwDrr7GRHObBMz6iNNwMGBSkbynkhU3lW4Gu3XFmXaEuzPqdj2HI
         9w5XPfushC95fBgAi92sSSb2uUgH8WBvi2Np10jm/gm8U/x5EW4VA3gJkGatvhR9O15S
         oZTKxevsc/ktPNbUuB8MfxRYD2mnSqPQvmYq3poHSIv0odzft6mzbSRQ5Qvvvpx1Mw8P
         dNoVZNx3ol8ixLlzuhx8vFB5ikLv7VdSXHjTjxAW+KrKB5knafLOPmgxH69plFboiC6A
         X8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793721884; x=1794326684;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gipF20o2h34hBulprmr5ZDNI7YyF8KnzA3/1TkP3zHU=;
        b=Ob5/iQrkVaqfdSKahwKB8ttr/CmL6tuNCIq9dkuiGG7VYfLJc08xOYSJ/gCVikkLKs
         J86cNFKvLEbfdXhenQaUzwTzpI3BwQtrb3JQkNfkZnbMpK/rOkqarbC7DM0ORwotkkMt
         DELh/rCWgFOCS5mwIh+G/ymU8ct7G8ykXD/GidPHAyGNqVS6uTdiCxFPmc8TZDES0CPG
         45aZj+zwzPZ5RbNYjxJ+bi/7ylVKXEO49FDtxlw+RMroxbfQ0SdHz9vdEkz7HB5ikpS/
         6IXWF1XnLboqXQcAfwRbdz7c1RJ2GUfSeQpoAKQtKNSbRC45OjKj/8vb9AL1lgdRAYKj
         uXRw==
X-Forwarded-Encrypted: i=1; AKwUvBygNztctthWRKGhc1MSbnm+jKwyjOnLMKk3oI6l7arzjo3nRh1JjeyofMfrVWS2oM7EFw532RA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/z2W+VER+jD9fpm6xUrTZvvz6HE2/7ic4GOI5cFgePZIV0gPGM
	9zAy0gzh4Jj1IsIG6aPcj0JU0pVOVGFJYKQ5VE9uDaZUul4nhVaJCvmaOKzbgRViQWujTSaduDF
	oUK2SXkU0e2xzfEa+4lrCbGtNN/hGK+UuC/3XGN5v9VUWPhluB3MLWjNFTXypanPhLFVxYaY1IS
	TBhGpptv9Zwq8s10zHPQt02ADQQWdQZ9xctg==
X-Gm-Gg: AYBFou2huYE2YRaYJJs5NjkbkaN3q2nzqrS4mDX1Tm3m1GR1ZF+6mW2l7DVrvCZMrvX
	lnhQRUstOCHtWeNyN3nZUY47y/bzB0sVbYT+Aj1BgztPLgGnR3KcT+zLfLkT3eKZ691ECh+lkal
	PSbWbKQnzX1b0abqmTdEStatYzFHuPO3SYC7yXr54NdZAMglU5mmAgBrSMsAuf7qg0vZ1lwbhK+
	bUuDLVVn+9H8sc4bjsWpaNyO6mUQ2+UTfV7QRK78Egbhod1M3jXxD3Z+bkaThrgHNE0u5PZKoM=
X-Received: by 2002:a05:620a:4405:b0:93c:7a5c:77d8 with SMTP id af79cd13be357-944214cb71fmr2205525185a.4.1793721883603;
        Tue, 03 Nov 2026 08:04:43 -0800 (PST)
X-Received: by 2002:a05:620a:4405:b0:93c:7a5c:77d8 with SMTP id
 af79cd13be357-944214cb71fmr2205516385a.4.1793721882884; Tue, 03 Nov 2026
 08:04:42 -0800 (PST)
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
In-Reply-To: <20261103-qcom-bam-dmux-vmid-ext-v4-2-3690cc5ca0fd@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 17:04:31 +0100
X-Gm-Features: AclHuK9dPBw-jO64BO1ihdfRNLN-Qdvw27QiCh5hGuNrF7OPnfM6M-1Uq35l-aQ
Message-ID: <CAFEp6-3iRLDJUHAEa4qGGcqJYUSB733wKBFDw_k5NF7LQF+jQg@mail.gmail.com>
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
X-Authority-Analysis: v=2.4 cv=V7foQuni c=1 sm=1 tr=0 ts=6aea061c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=6-Cr49sz5ZyKOFeZGKYA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: ydfScNYAWwpLwnUZJyvaZ_7IJNLUhX6J
X-Proofpoint-GUID: ydfScNYAWwpLwnUZJyvaZ_7IJNLUhX6J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfX6WoX/zxu0y3z
 Bmkf6JkYJrEa6v6LASjJVFU+347Qct4zILIDqhFjjpb18VdAm/5SUZAja0N1R2TaHgwNLh9lLLN
 aO7gpGNuttPiVJZZvZ/uspDR902bpTf9vU89vHRFuNlBb1/9JXsafpkDtS4Uq+gpJ8cFXhqU8eu
 sWdUzJmC/l9O+TUVQNUSwq+zFoSLgrypDgoIJz7WI30ceaVsqa7yoMVCfHjbFIIgXupryXFbE20
 CusThR0ogg9QgbY9UUG8bISx2jJ7Pe49/kPKxbiDDtLMsy+Dd9QKReheW7Iz/hAuA4kQmxNz+vg
 jEJf/mNCf87FvVDD/vbICU0PCGTTzLLMYNlj71uRScxI4zpzeGG/lVz4M1lYJG9Vt/k+ScmY5j3
 +uw3uUCQ8qi87tEt/yd7onv/OtvzCJSwKpYHWxdYBs6WnPwfDLjxxAz/fJ2JXXnFkehrOyesUhy
 EaVf6s5t3ibSZ+OGBwA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfX8mXtmMz6/z4o
 /gJdWzxxQ8FMPg12MIpijn+kipqp5mpQ2RNYW2bXbNrcEd/MjVJfa7UxjwEUd9LIhiIUrEJ4J6e
 Yn9LKIa5Hwg5geW6p30L+pYSHzZ5m6g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030064

Hi Vishnu,

On Tue, Nov 3, 2026 at 3:19=E2=80=AFPM Vishnu Santhosh
<vishnu.santhosh@oss.qualcomm.com> wrote:
>
> Some Qualcomm SoCs, such as Shikra, run the modem in a separate security
> domain with restricted access to system memory. BAM-DMUX DMA mappings
> and BAM descriptor FIFOs must therefore be constrained to a designated
> memory region that can be shared with the modem. Accesses outside that
> region can trigger an XPU violation.
>
> When qcom,vmid is present, require a restricted DMA pool and assign the
> entire pool to both the local and remote execution environments before
> requesting the DMA channels.
>
> This ensures that BAM-DMUX mappings are within the assigned region. When
> the BAM DMA controller references the same pool, its descriptor FIFOs
> are covered by the assignment as well.
>
> Track the assigned execution environments explicitly and reclaim the
> pool for the local environment after DMA channels and mappings are
> released during remove or probe error cleanup. Skip the reclaim and
> leave the pool assigned if the remote side still holds its power vote,
> since it may still access the pool.
>
> Fail probing when restricted DMA pool support is unavailable, when the
> VMID property is malformed, when memory-region does not reference a
> restricted DMA pool, or when the pool is not attached to the device.
>
> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> ---
>  drivers/net/wwan/Kconfig         |   1 +
>  drivers/net/wwan/qcom_bam_dmux.c | 114 +++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 113 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
> index 958dbc7347fa84ee869439bf8b503037faab8bef..1b133c5623161526969814018=
7ca3141dfe48dbf 100644
> --- a/drivers/net/wwan/Kconfig
> +++ b/drivers/net/wwan/Kconfig
> @@ -65,6 +65,7 @@ config MHI_WWAN_MBIM
>  config QCOM_BAM_DMUX
>         tristate "Qualcomm BAM-DMUX WWAN network driver"
>         depends on (DMA_ENGINE && PM && QCOM_SMEM_STATE) || COMPILE_TEST
> +       select QCOM_SCM
>         help
>           The BAM Data Multiplexer provides access to the network data ch=
annels
>           of modems integrated into many older Qualcomm SoCs, e.g. Qualco=
mm
> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam=
_dmux.c
> index cc6ace8d64371eb8d00c638a39b234ee540b83c9..c9639474e58acc16ce0d04f18=
1b2e999cff42bd1 100644
> --- a/drivers/net/wwan/qcom_bam_dmux.c
> +++ b/drivers/net/wwan/qcom_bam_dmux.c
> @@ -9,14 +9,17 @@
>  #include <linux/completion.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/if_arp.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/soc/qcom/smem_state.h>
>  #include <linux/spinlock.h>
> +#include <linux/swiotlb.h>
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  #include <net/pkt_sched.h>
> @@ -75,6 +78,9 @@ struct bam_dmux {
>         struct completion pc_ack_completion;
>
>         struct dma_chan *rx, *tx;
> +       phys_addr_t dma_pool_base;
> +       size_t dma_pool_size;
> +       u64 dma_pool_perms;
>         struct bam_dmux_skb_dma rx_skbs[BAM_DMUX_NUM_SKB];
>         struct bam_dmux_skb_dma tx_skbs[BAM_DMUX_NUM_SKB];
>         spinlock_t tx_lock; /* Protect tx_skbs, tx_next_skb */
> @@ -762,6 +768,96 @@ static int __maybe_unused bam_dmux_runtime_resume(st=
ruct device *dev)
>         return 0;
>  }
>
> +static int bam_dmux_assign_dma_pool(struct bam_dmux *dmux)
> +{
> +       struct device *dev =3D dmux->dev;
> +       struct device_node *rmem_np;
> +       struct reserved_mem *rmem;
> +       struct qcom_scm_vmperm dst[2];
> +       u64 src =3D BIT_ULL(QCOM_SCM_VMID_HLOS);
> +       u32 vmid;
> +       int ret;
> +
> +       if (!of_property_present(dev->of_node, "qcom,vmid"))
> +               return 0;
> +
> +       ret =3D of_property_read_u32(dev->of_node, "qcom,vmid", &vmid);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to read qcom,vmid\=
n");
> +       if (vmid =3D=3D QCOM_SCM_VMID_HLOS || vmid >=3D BITS_PER_TYPE(u64=
))
> +               return dev_err_probe(dev, -EINVAL, "Invalid qcom,vmid %u\=
n", vmid);
> +
> +       if (!IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL))
> +               return dev_err_probe(dev, -EOPNOTSUPP,
> +                                    "qcom,vmid requires DMA_RESTRICTED_P=
OOL\n");
> +
> +       rmem_np =3D of_parse_phandle(dev->of_node, "memory-region", 0);
> +       if (!rmem_np)
> +               return dev_err_probe(dev, -EINVAL,
> +                                            "qcom,vmid requires memory-r=
egion\n");
> +
> +       if (!of_device_is_compatible(rmem_np, "restricted-dma-pool")) {
> +               of_node_put(rmem_np);
> +               return dev_err_probe(dev, -EINVAL,
> +                                    "memory-region must reference a rest=
ricted DMA pool\n");
> +       }

You later test with is_swiotlb_for_alloc(), so isn't the above test redunda=
nt?


> +
> +       rmem =3D of_reserved_mem_lookup(rmem_np);
> +       of_node_put(rmem_np);
> +       if (!rmem)
> +               return dev_err_probe(dev, -EINVAL,
> +                                            "Failed to look up restricte=
d DMA pool\n");
> +
> +       if (!is_swiotlb_for_alloc(dev))
> +               return dev_err_probe(dev, -EINVAL,
> +                                    "Restricted DMA pool not attached\n"=
);
> +
> +       if (!qcom_scm_is_available())
> +               return -EPROBE_DEFER;
> +
> +       dst[0].vmid =3D QCOM_SCM_VMID_HLOS;
> +       dst[0].perm =3D QCOM_SCM_PERM_RW;
> +       dst[1].vmid =3D vmid;
> +       dst[1].perm =3D QCOM_SCM_PERM_RW;
> +
> +       ret =3D qcom_scm_assign_mem(rmem->base, rmem->size, &src, dst,
> +                                 ARRAY_SIZE(dst));
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "SCM assign restricted DMA pool fail=
ed\n");
> +
> +       dmux->dma_pool_base =3D rmem->base;
> +       dmux->dma_pool_size =3D rmem->size;
> +       /* Track the destination VMIDs explicitly for the reclaim operati=
on. */
> +       dmux->dma_pool_perms =3D BIT_ULL(QCOM_SCM_VMID_HLOS) | BIT_ULL(vm=
id);
> +
> +       return 0;
> +}
> +
> +static void bam_dmux_reclaim_dma_pool(struct bam_dmux *dmux)
> +{
> +       struct qcom_scm_vmperm hlos =3D {
> +               .vmid =3D QCOM_SCM_VMID_HLOS,
> +               .perm =3D QCOM_SCM_PERM_RW,
> +       };
> +       u64 src =3D dmux->dma_pool_perms;
> +       int ret;
> +
> +       if (!dmux->dma_pool_perms)
> +               return;
> +
> +       ret =3D qcom_scm_assign_mem(dmux->dma_pool_base, dmux->dma_pool_s=
ize, &src,
> +                                 &hlos, 1);
> +       if (ret) {
> +               dev_err(dmux->dev, "SCM reclaim restricted DMA pool faile=
d: %d\n", ret);
> +               return;
> +       }
> +
> +       dmux->dma_pool_perms =3D 0;
> +}
> +
> +static void bam_dmux_remove(struct platform_device *pdev);
> +
>  static int bam_dmux_probe(struct platform_device *pdev)
>  {
>         struct device *dev =3D &pdev->dev;
> @@ -796,6 +892,10 @@ static int bam_dmux_probe(struct platform_device *pd=
ev)
>                                      "Failed to get pc-ack state\n");
>         dmux->pc_ack_mask =3D BIT(bit);
>
> +       ret =3D bam_dmux_assign_dma_pool(dmux);
> +       if (ret)
> +               return ret;
> +
>         init_waitqueue_head(&dmux->pc_wait);
>         init_completion(&dmux->pc_ack_completion);
>         complete_all(&dmux->pc_ack_completion);
> @@ -829,8 +929,11 @@ static int bam_dmux_probe(struct platform_device *pd=
ev)
>
>         ret =3D irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LE=
VEL,
>                                     &dmux->pc_state);
> -       if (ret)
> -               goto err_disable_pm;
> +       if (ret) {
> +               /* The PC IRQ may already have powered up the RX path */
> +               bam_dmux_remove(pdev);

Calling remove from probe is a bit unusual, have you checked that
everything is correctly balanced?

> +               return ret;
> +       }
>
>         /* Check if remote finished initialization before us */
>         if (dmux->pc_state) {
> @@ -845,6 +948,7 @@ static int bam_dmux_probe(struct platform_device *pde=
v)
>  err_disable_pm:
>         pm_runtime_disable(dev);
>         pm_runtime_dont_use_autosuspend(dev);
> +       bam_dmux_reclaim_dma_pool(dmux);
>         return ret;
>  }
>
> @@ -879,6 +983,12 @@ static void bam_dmux_remove(struct platform_device *=
pdev)
>         disable_irq(dmux->pc_irq);
>         bam_dmux_power_off(dmux);
>         bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
> +
> +       /* The remote side may still access the pool if it holds its powe=
r vote */
> +       if (!dmux->pc_state)
> +               bam_dmux_reclaim_dma_pool(dmux);
> +       else if (dmux->dma_pool_perms)
> +               dev_warn(dev, "Leaving restricted DMA pool assigned to re=
mote\n");
>  }
>
>  static const struct dev_pm_ops bam_dmux_pm_ops =3D {
>
> --
> 2.34.1
>
