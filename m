Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793718815;
	b=vcoCv6IPuYys+luUYBvt/Vs6zcZYGc31U4mk2ZMBsNGmbQOnKBooRh0q2IkAbAlYQbyv
	 txShvJ46bUJimeRdovfbFyA6i+FUV20DmeETg5bV06i6obHZiqo4WMT6p5DDTbvSKlnAK
	 xE1f2fjjLzkI6UmumV7TApdiSGbDHhiBx+zr2ToBfKRhf2O+StPh1SpDzP8gfvEqFEG28
	 T+o0N5aFj1oJtBMmwzqHyqaD/rDA3kn/3IF9hHDlbGeKfz6FF/NllnqdC/7lB8GPinaHJ
	 X3Xcu+oGQo9FdKbOzIVn0lyXWcHxG9SwnQaGuCPFCKMmO4cwrhToLS2QcNSslfr3/3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718815;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=I8qVa7oSpZqMvWdcR4DKEC6yZTIuxu6met6/Uocy6ek=;
	b=fQgJMUb4p6xtxayWFF4AIHwritjeL7h6e8l9OzzYH7N/PqYU9oUf2k7Rfm6XMZbOB2+a
	 jyYcJVWf+1xo2m/XJddw2xFZNSntWjAPTlnTEHNaO8aQYv833OaopeALzPvLMeE7jXAOd
	 USgDy3X9LSm0eKuNAT3rbcbM+0zMy45Zidvn4I9hj8g1n4n1KbfsIiFw0QJ/JBUnDMDhs
	 25oojuqomRZ337CMO1H2S28KWbD2/dv+rjF6D2SomQPqTCZWANb/CoPJZRiJPBhDBUnr5
	 ZDNX8RSSnJTA6PH1w1ZlNRFAUWLJgWPAcC/Snaw6GvcRGnu+Bganevm6r1e1zUU5tDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WIjh0Kt4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W2Mfx9hH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2221E606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 15:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2221E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WIjh0Kt4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W2Mfx9hH
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EAKOZ3690046
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 15:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I8qVa7oSpZqMvWdcR4DKEC6yZTIuxu6met6/Uocy6ek=; b=WIjh0Kt4ABNef2V2
	/FY9+JSGyNOhCrO/xZ8TBxCP18UqZzCNnSf0zEn+J8x9YBwdrAIwdHa2p71fY+M2
	7Mz3WdANa5J14E0v2crwFKXlfVK2M60b8BjhykJ8gEoAJCYCx0kgHuMnCdE/WOsc
	CvFqC0lGlLnOhUGRur+AJaknldn/SdA/eMGiwHyQPFT1jbI0zwqMlH2hyPpwet3L
	3FPo+WV7J5xSK32tXv8Xg3ZQ8ZxEfJc3O6KH4XWYc8qDb6qtJ/m9g9587AMOzYDb
	dIQCYzIB35XE5nBJzBGk8LUuKTOLBPuRY4pveOBZMKUg7Ei1W86NeIWO9Pi9LFcz
	t5KmmQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq6m9avth-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 15:13:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93e49a1d3b1so1016217485a.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 07:13:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793718813; cv=none;
        d=google.com; s=arc-20260327;
        b=iIKHXoDjOY7G5C6Y72oYMe3gnngYVaHTUUoKOL+XLfhLMI9HzD65B+qQM1yFCsRvMf
         pTQGctwW6oAcmh86fcibxVRSIkoZ1fMSwJ6V3/oYIgh3+JmcQxac6C95xQDTFa2kgMWl
         dgHoBItmWI+BdeG+fuDiSC7CdU93tcG9KHy81BYZlFdoVP+icgD5lJd/Kgplg3rfTjFq
         D3KLxAkjJpJlUoAbqGV9uVJ7z+b2GcitJ8lhCCryMmFzd5lNJeZIWlxHUI9rTczMHZSY
         pUBRwQpgItF30ljyif1or2Wv1tAtKPA91IP7betzXpKBCOIdXYd3l2Lo8lFRZ8Xl1UJc
         qM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I8qVa7oSpZqMvWdcR4DKEC6yZTIuxu6met6/Uocy6ek=;
        fh=lWrLBp8DAzav9ijcJ7b/MhEUDL/Pp/mmw5goMrkjA5g=;
        b=O3bDKC6UNBX1wE1x5+nXhuzFr4xcL2h0HGamytMP2wZ5uorbl9cbevufb50XRxq+3x
         cJze4ahfEXU7iMWNiQvROsnmcxSaSqvpWjCTuZ0n5Ip5XPPC1kXx7VMUjU997sIthFCO
         AcDdeSVGkchAE/QKxyioeTRWoyONQlBgwys8+8QnW9cdDbsE1qCDFwGl7ACa5gb5C/P+
         wBZTWOIm1XusnpgUT16pFXK97UXT5deD2WxJu4KHtAdld9fFOm6GwAIFwyX/sz3wTqk9
         nXkfh52xEAUnYC7cMNC3IfFnqYRVrdfi7kGwzo7b7Qjd+2W7GNh6bak5w1EPXsnERzQx
         z6PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793718813; x=1794323613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I8qVa7oSpZqMvWdcR4DKEC6yZTIuxu6met6/Uocy6ek=;
        b=W2Mfx9hH+6Qgz3AhP5zJoiaRdw1mMmKM4KTT22ta4msWU4KbrVnXjWbUCO2+H/n2fp
         C8r4VzXO2P4YMCa4VJJu8X/c+kRGicw2KA5swz/RNqAtgW9ysxI1T0ZMwJmfiNWm11T0
         b/IJBD+RkYllnxn+f79D3U1S9fSexhq8seV+gD4s2OgmfO8OcmmXhYZTnNuzoe2I24DY
         0B738K5N+FlaED0s+Ni/YcRiLpN4JlwxMp1kU8zkiNl27h+XkUA87EcAm1z04XBzyapL
         8oFbz4eCOgIuGOWGmYozs0gon30tEo0yFfQMn3ivlZbqWC9QG+/wjDjaCgWNUTRxqx4y
         Gf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793718813; x=1794323613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I8qVa7oSpZqMvWdcR4DKEC6yZTIuxu6met6/Uocy6ek=;
        b=wCMpqw1UeIcLTe9nquRK4j/mmFnGcYF6ZWc/C2jQnocUOn6SNFwR9U2s7TPtJ17o/l
         w/w28pMN2N54C3s7xWXry99x0cjil3JkXuNo6qdtV1XazuZ06aNng924sUGoJRprcwUm
         lMR2cp8p2xZ15Y+OI+FGJIab9OKpMSq3WYjrD/vPteIAZc+vNwsacsnkgV/TX9LVerEn
         sYbkHE953rBOK2yzaVN62yjHDhqkcaEwf9uCNTliG39EKTYqJe8TiVuvt+CtfyphuNmN
         dbNYeIN2iyI55ywijq1UwQrI/Xw3+rgIuzuXNRR9d+HWJ+1ansP5bzkApzUZRvnmGktb
         fq/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwTJz9LfwTSkbABP/zQxtcTXJzkGSBD3Dv0PwoCJ5sYIJVmh+helLIbWZJNEpRZfL76bNb2frQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Lt4rnPaaVophSLRaJFliEy/TEBj6Z6qCv1Wakrrtaum7cmQII
	9V8SjcV81+/7a0IvHKcE5d0aTiEL+n9WUCvEMFnxLU8n1Vt7lpQ88FGV4wvw9ultU1FPOC13fKn
	hQy6tKzb6whLWLHQPGLxlVZ1NL4We9FodQUyW4jkVMYJ+HK+f+09lwx07smGqCv20xKzdir59CR
	8LHbP3QsmLAm0Tshn3XjfV17ZnohcqfJDZeQ==
X-Gm-Gg: AYBFou2opSCkbBszkW/6oLXICcBCxB5o7R4JC3eAh6KDMPhUApRafVG4UUEYhkLauJS
	EDzS+ZOFGhBjvFGuFg0AyutnPaTGo58DcZd6+J3cLqaRJSSiK/CpZVKXpgjmjIb2luocWkSbLqD
	brWa3kQ4VqKwQFZ7rm0KmmE62ct3MsTVgDvM+Ft/ZcLwCM2W9tFQRZxayxkm+yW1Hg7PrXRMcUc
	F2pzqsUpsO1cwSeI3TiBzeXXIpKuCgnpWNYtHtYtWOWtaJzXb52lINp4m7vaed4YY5jaQnDpAo=
X-Received: by 2002:a05:620a:4707:b0:93e:dcb4:c73e with SMTP id af79cd13be357-94421588073mr2330908185a.5.1793718813033;
        Tue, 03 Nov 2026 07:13:33 -0800 (PST)
X-Received: by 2002:a05:620a:4707:b0:93e:dcb4:c73e with SMTP id
 af79cd13be357-94421588073mr2330901485a.5.1793718812516; Tue, 03 Nov 2026
 07:13:32 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103145925.69981-1-fangxy@xiaopeng.com>
In-Reply-To: <20261103145925.69981-1-fangxy@xiaopeng.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 16:13:21 +0100
X-Gm-Features: AclHuK8DIjXpRf1kb8U2F0fW682errUhejBgNhE7RvKkKRDQvd3zpOgJNdiispY
Message-ID: <CAFEp6-2mpTBGNCOhJzaNFMyH1EUxBGbihEhvOYLhp3+VSVZ-pw@mail.gmail.com>
Subject: Re: [PATCH v2] net: wwan: iosm: drop redundant skb->data check in MUX
 DL decode
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Guanglei Zhu <zhugl3@xiaopeng.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: M8jBqLxXoLVm57-sTXKchepuw-Awlf1P
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2MCBTYWx0ZWRfX+SRpowCCDxPu
 4n+Z5kW23rnz2mC8zVCUVIpsPFVQvjC9ecqyQ3LztLSC3eU3eHMUvuxcosoknaJjho5oki8Zawb
 BNBZ4HYzcesbIWeAP9rDtSJXQzeuJoY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2MCBTYWx0ZWRfX998qBHXN3YxJ
 szTOtbkJdPGS0v3XQLeKrvo+x8IiIUli8A3iWd2yp2EfTfEtwix74tWrIPy4Eks4kZMsq3ez0fi
 8044zELKHjrWIwx+A9tbi1OVF6F6WtGl5mW1gADRDaodEaxxg7bNhX8z+eRLfaDfnqQB1pLPvJ4
 7aZyKwJdgaIBoSX6w0Y5QOPl+gQFFFs3sL57WCtApof9lUSwEnSRQ3Lw2NmTI2pi74l02J5P1rO
 k38fUCRK5Jw+bUlqJhr5laiDxFxitKCmbuzkilUC9uJwbVLdxEoBm8swedQMRMbsiO34ll/1XqX
 v+dGQvXcIXKexEMeo+UZxG7sqLeHbO0LVol6iyftpwgYnCe2Fmt5UeoB+cJ1yHpiSRTCFWDaBNv
 TEmKUH1mgQcEqiQQcBuncybowW4W+suOZQe1hg+RJejqc+qHqBVT2+5oO0OgPpJzVmon+XBFyu5
 9P/yhM30dLy4DJ3sh+Q==
X-Authority-Analysis: v=2.4 cv=C7B8WgP+ c=1 sm=1 tr=0 ts=6ae9fa1d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EgahoUkMAAAA:8 a=EUspDBNiAAAA:8
 a=52d6GeA0XoVMxxXrUM4A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=D2SkTF70-_n5gOfERQdM:22
X-Proofpoint-ORIG-GUID: M8jBqLxXoLVm57-sTXKchepuw-Awlf1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030060

On Tue, Nov 3, 2026 at 3:59=E2=80=AFPM Fang Xieyan <fangxy@xiaopeng.com> wr=
ote:
>
> The skb passed to ipc_mux_dl_decode() through the current RX path
> always has a valid data pointer.
>
> The only caller, ipc_imem_dl_skb_process(), checks for a NULL skb
> before calling ipc_mux_dl_decode(). The skb is allocated through
> ipc_pcie_alloc_skb() -> ipc_pcie_alloc_local_skb() ->
> __netdev_alloc_skb(), which provides a valid data buffer on
> successful allocation. Allocation or DMA mapping failures return
> a NULL skb instead.
>
> Remove the redundant skb->data check.
>
> Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>

On top of that, the early-return branch does not release the related resour=
ces.

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
> Changes in v2:
> - Drop the "fix potential skb leak" approach. The skb->data NULL
>   condition is unreachable through the current RX path, so remove
>   the redundant check instead of adding an ipc_pcie_kfree_skb() call.
> - Drop the Fixes: tag because this patch does not fix a reachable bug.
>
>  drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwa=
n/iosm/iosm_ipc_mux_codec.c
> index 0bbd41263cc2..2b8a22980c87 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> @@ -693,9 +693,6 @@ void ipc_mux_dl_decode(struct iosm_mux *ipc_mux, stru=
ct sk_buff *skb)
>  {
>         u32 signature;
>
> -       if (!skb->data)
> -               return;
> -
>         /* Decode the MUX header type. */
>         signature =3D le32_to_cpup((__le32 *)skb->data);
>
> --
> 2.50.1
>
