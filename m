Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E940492E24
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788959453; cv=pass; b=XUzw5DTEsddlmLIQ1PCnsaoJtSl1XuxvTVTX00R6ug+BIF9Y3CzBh+yRJyy4qCXL4HWbTvOmSWyK2a5EYd+cJs8IScbA5g3SkvuEO8spZJNidpW0FP6QL7okxCFd2sFe7giJgIP0KQwLN34yYgh1CaTY6gPitjqOXy2WPWHSRlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788959453; c=relaxed/simple;
	bh=USoy+/1sjsE8gM7fL1ZzAANxBJA3GIi2oiUUyXweKmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAo88CzExlk7iqVRq8l9JAPPR4xFzOXJzuSf0qntuIdDTtUy0NDr+MksX7nq8DqX3r6+guJXRp/a1nP00VZ8DpJmFF5CYJ012A7u7AhLdzoGvVpxIzfM6fPrPx+ibdoIX0fY4qsxCtzbaqORqhsqecv4qMV4+3RFqjSKi+CAi80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W+6uoT1W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JKmOINAd; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W+6uoT1W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JKmOINAd"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BU2Rg1723075
	for <netdev@vger.kernel.org>; Wed, 9 Sep 2026 13:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e18YgiYDcY3A71+s9t6tnvZG6iOI2p470IJGpWf+I9Q=; b=W+6uoT1WlKKJVmm6
	jBFUof9ktWt86eS+f0SztMAYfbEm1jpajPKOOEG47A1dnbqWamS8WJ1bGOrBVd9l
	2sLqg+iirSIIFwzCjnOeEMp6o9ZUmg4oZHbsquZhFbPw9HAkWu7v5gUtfIZAcHJ3
	CZTaKI9AtVZ2+4iDIY+8p+Q/JVBnuHnnGTaSBI1ynpvynT53D5IfdATiX6QYNjF+
	wujvbVBDOr0SVnoOmi0QiJL0JeU1k+nbnYR2WUhLwbUKd35I/P2vvITs9bVbs8ks
	guuL2/Pc8lAXQzLTPu1IyfAUUgCitjzdxddOusL2++iUQGOftvJ04tLjs+aJt/0P
	PNtjCw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5cnrp9e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 13:10:51 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9104417215aso110515536d6.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 06:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788959450; cv=none;
        d=google.com; s=arc-20260327;
        b=XyFlysbUGypnctwxtdl+RtNxg+SdbtoCb0XA/cM779G0ehqswxNRi+NR1a6gUL/z3n
         6eLPYp4xmd5AWFyFvOzf/TQroSnKub+dtUOJ/o0UNa6ubhcdHtdot7LKUsFGhk8/clzB
         6v4UeTv3R2mvyCIDw2CoyKwg/ajdaiKIA6tCiqZO6j5LQJwOpcnV9XVhAjg2GAtqqIxb
         VkMclRxAiJLnOMGcb6aIo6XqgzyzdDHkxL0JW6cA6cVpcHoad3kCdoWKc+rhlWeHrhVg
         7utbx5a/MeTE5D5nFRaDIw3KiKH3yjDCFMhBxM2CvZA3a/mTw1awKsF2z+MGpunUGtOG
         0EBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e18YgiYDcY3A71+s9t6tnvZG6iOI2p470IJGpWf+I9Q=;
        fh=XJ5sPOndWEbU3flqzvjCTRCdIQ+lE++M9k1bUEbUcCk=;
        b=pq7bG2HMWJ2Qhd0xocpo00kxmHBiKCrOlH9A78ZM4ciXysTTJv3pv4V+E6vTamHJfL
         9SvDniMZG8vBOlMv6KD7//oFILRwDjB/D/w0lgvZncRp0utVlSyws9cHbkhg4bhlcWIm
         ybcLAsJ4jxBOPd6laxtwea4FZq7WW2YsAkPzfQtuisylqdkpPQUweJtQQrsdPQ3JXREs
         Cg9B0gzfasteaOAPyVm0MFPoyX5psmC0yL+qzubfMxEAMvnYLfwv3EhthiRPyrkqPMS3
         sF3B+7r/+SFJFzfpMc09Q3n1LRfwfmeTwgLzjJ9AtczaD1rFgLQ00eXCRPr1UJwHvCgb
         ItYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788959450; x=1789564250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e18YgiYDcY3A71+s9t6tnvZG6iOI2p470IJGpWf+I9Q=;
        b=JKmOINAdregftNkDarIS1wzWB8Z/Rykyad1ttzXbzNSAy1CasUMPOoOKnFM5S9IE69
         hupQ0tPEiLTx96bdjCq6tgQTkaKAjB+XeGjkb/F7bB3dPIZO6ao6eV3HWOvU2q42lAYR
         ICz1UM49f1aanhgMiD/iRQAi1+YWgJ3AGSJYFCoV8GP/1lAJcatDD70sSTkK9DKNWfXe
         PHOv+yJ9q5VV1drG61A5u22khCzU6wtaEBd4b9odxpFRBTo2ZXihJiu/kTGLDCMLmfs2
         bDMlh2yc+wOTv8h1FZh5749igIEHXIEbVsRpittWzzR7L9lf0lDh8pBLY3UhXWbu5Htg
         YS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788959450; x=1789564250;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e18YgiYDcY3A71+s9t6tnvZG6iOI2p470IJGpWf+I9Q=;
        b=aPwoBXelroycFJfLrxEDiyFg4a6gx3g4tCIiG829jfePQ/VLOH6zxevgThegTwXkjy
         cXJLG+engNK1U/fAc62iIFTsxPm65rDeHbMCoAxK52tmJ7Z87v3clXg3m7/5gEQ+NwR9
         TNWjQ4nbCMDFoLfUVWYq7nATXNea/FwAVKo6Nt/oCD5FI46QKOPJ2pzJwi5UfV5Gk0K4
         gDwc6a7npAz6/CcKQEX96/g7dfZoPXNNNxvGppgMrkjDlO3zW4UKS7Ne5G6+ApSlFCL+
         onFfs3mi5QDkkXf8REpaE6d/76fdhUfPEdeyD3ZJhHCVzfPMudkbc4cCil/qYy3aFC7s
         wwWQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8dRt0NcIKJm/JQK2HykQ2g4hsUvNY0EK7lQMXZfZBy5zL4/4DPGe93RNFe8oVbU7MNXgekE0=@vger.kernel.org
X-Gm-Message-State: AFuF++ncoda/aLnDdyZKguRcyBeRjiWpKT0C26kAWb2ecU1T8j/flb53
	gfu+mHL8Xe7o15GzV90c1u5hDfdLlYe4UbjPuYWWZT+75uxP5/4ZuGaREjIbchlvX4dFBmPKNr8
	saLg8CNJa+C/FGDzBxv/cPtUcBlmd3mBRwjSevM8kM+3mHnRKs92DUaqgqkoVZmfjQaPu5O34Ue
	JJJGxCLaipHdsVCJANOfafNKc0vdOQGeeT1g==
X-Gm-Gg: AYBFou31cY6oE2Wz9cdAP4PnpzvXoC5NCKw/j4xoyTSFhv6umSlqVAwCvp0Y1R6RYEC
	sc3GdbJf/4PgSH5Y+KZFC4kUJNY5q2m3gtyTPXuc/zAL5tVzc4G+wWwDRGNvRsGDxxc8BBYy0wh
	DWeibbgpLRVgQvTIwFVle7zxL8/v7rZTEuelXyEwYatCHYksSl/dIgoeYvpEfh8uIN4OwW2CDmZ
	ein/WaciQPzBjlMWuQz/k2PIpdvG/p0RfL/iaHcAvjQxt30kIN8QYWXUEfWnjZ+ttHnv3C2pKI=
X-Received: by 2002:a05:620a:3186:b0:939:c9e9:81a3 with SMTP id af79cd13be357-939c9e9e6d3mr648184185a.30.1788959450547;
        Wed, 09 Sep 2026 06:10:50 -0700 (PDT)
X-Received: by 2002:a05:620a:3186:b0:939:c9e9:81a3 with SMTP id
 af79cd13be357-939c9e9e6d3mr648177885a.30.1788959450098; Wed, 09 Sep 2026
 06:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909054401.718959-1-zhugl3@xiaopeng.com>
In-Reply-To: <20260909054401.718959-1-zhugl3@xiaopeng.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 15:10:38 +0200
X-Gm-Features: AcwNN1XRBsJQUp_8Vo3_MALJlQYTHzC-PLbfBluaOY_sDn4qJVdQudxsA1DY1GQ
Message-ID: <CAFEp6-2xNNJ_uNV+fuY8hxcURW0+zoiKgCV92+10PR7oZn_UEQ@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: t7xx: validate the HS2 message data length
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: YWE2GGGzxJaMbgBWHhvG9SrFNY-acPOg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE0NyBTYWx0ZWRfXwVicLqHx/95a
 wRFhj/H1HAzumzkco6FYbUXT4E+JPtROxNoMwaSxnTAvZgSEcnLaK275PM881qMpPwJoRL5hqei
 Vo26xVrq4P3+KaXhGb2OLw3wG+xslQA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE0NyBTYWx0ZWRfX1CVCy8Boexd+
 8rO0X6T7xcUfBZ9fIT93phnoE0kbGS3Gw1BNYX6zVr1YVtyXv6YSDZXcSTzXdmwNQ95y+xa8LE2
 hkyvAvztcLajott6vkhM2S/PpziroNlTUxbBVEKZtUPdRy6z0eA0LG3ghnmAXTAJMt0liaz5dPU
 05EX61tZI2Ee59s0b54p/u2Cx5qEjUBMUYGXCv2DcDkT/zj9+KLXnAWinrbpHR/VA3nukt+9kgR
 gNbs12AQDTTZtPR9msjstpCN+z/US5YFsDmDg1hKa0E1wnTf7HG3rD41IcVcMd1x8KR7p/C0Q84
 Ym7gqV7Hc9dju+orCyjdrVjlq93wDe7ic1uBj0pq1xSnsrRIEGrw/VtEGXl8KpyNB3AarJtvV63
 yePuKXr+9OJ9Bp8XxCBru+pnQzRgXGErAa5PKiFrls5pkLS0HzrVNEvEEee4rVYxojLfrpDMw9Y
 7mIvquf7DhdKwu56zbg==
X-Authority-Analysis: v=2.4 cv=S+jpBosP c=1 sm=1 tr=0 ts=6aa15adb cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EgahoUkMAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=jOW7-oFJvRO1IEPcfKUA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=D2SkTF70-_n5gOfERQdM:22
X-Proofpoint-ORIG-GUID: YWE2GGGzxJaMbgBWHhvG9SrFNY-acPOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090147

On Wed, Sep 9, 2026 at 7:44=E2=80=AFAM Guanglei Zhu <zhugl3@xiaopeng.com> w=
rote:
>
> control_msg_handler() passes the modem-supplied data_length field of a
> CTL_ID_HS2_MSG message straight to t7xx_fsm_append_event(), which
> memcpy()s that many bytes out of the skb.  Nothing compares the field
> with the actual length of the message, so a modem reporting a larger
> data_length makes the driver read past the end of the skb and store
> kernel heap memory in the FSM event.
>
> 0e7c074cfcd9 ("net: wwan: t7xx: validate port_count against message
> length in t7xx_port_enum_msg_handler") added this kind of check for
> the port enumeration path but missed the handshake path.
>
> Reject the message when data_length does not fit into the skb.
>
> Fixes: da45d2566a1d ("net: wwan: t7xx: Add control port")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>
> Verified in a QEMU guest with a fault injector feeding the driver's
> control port thread a handshake message whose data_length exceeds the
> skb: the unpatched driver trips KASAN on a read of 8192 bytes past a
> 500-byte payload, and the extra bytes land in the FSM event.  With
> this check the message is rejected, and well-formed handshakes are
> unaffected.
>  drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwa=
n/t7xx/t7xx_port_ctrl_msg.c
> index f869e4ed9..0f2ead8a7 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> +++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> @@ -178,22 +178,32 @@ static int control_msg_handler(struct t7xx_port *po=
rt, struct sk_buff *skb)
>
>         ctrl_msg_h =3D (struct ctrl_msg_header *)skb->data;
>         switch (le32_to_cpu(ctrl_msg_h->ctrl_msg_id)) {
> -       case CTL_ID_HS2_MSG:
> +       case CTL_ID_HS2_MSG: {
> +               u32 data_length;
> +
>                 skb_pull(skb, sizeof(*ctrl_msg_h));
> +               data_length =3D le32_to_cpu(ctrl_msg_h->data_length);
>
>                 if (port_conf->rx_ch =3D=3D PORT_CH_CONTROL_RX ||
>                     port_conf->rx_ch =3D=3D PORT_CH_AP_CONTROL_RX) {
>                         int event =3D port_conf->rx_ch =3D=3D PORT_CH_CON=
TROL_RX ?
>                                     FSM_EVENT_MD_HS2 : FSM_EVENT_AP_HS2;
>
> -                       ret =3D t7xx_fsm_append_event(ctl, event, skb->da=
ta,
> -                                                   le32_to_cpu(ctrl_msg_=
h->data_length));
> -                       if (ret)
> -                               dev_err(port->dev, "Failed to append Hand=
shake 2 event");
> +                       if (data_length > skb->len) {
> +                               dev_err(port->dev, "Invalid HS2 message l=
ength %u\n",
> +                                       data_length);
> +                               ret =3D -EINVAL;
> +                       } else {
> +                               ret =3D t7xx_fsm_append_event(ctl, event,=
 skb->data,
> +                                                           data_length);
> +                               if (ret)
> +                                       dev_err(port->dev, "Failed to app=
end Handshake 2 event");
> +                       }
>                 }
>
>                 dev_kfree_skb_any(skb);
>                 break;
> +       }
>
>         case CTL_ID_MD_EX:
>         case CTL_ID_MD_EX_ACK:
> --
> 2.43.0
>
