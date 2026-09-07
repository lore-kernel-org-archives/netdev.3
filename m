Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E78C3CFF5C
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767844; cv=pass; b=iDYJ9D3OFzj0MyWjv7S8BiU+nKaqxbNWiZOUOjRfhKgL7c0y1dLKcThXkoBhcmYZL5gQsAiqJa/TN0zgplHaq4ej5Z74dHKXbmpW4YRcLG/2vYpcA64qBZ2Qw5Ia7LfU8fWzTfwm5H1/FgNUsAUQVzldu9krXv/OlmVUag4RvTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767844; c=relaxed/simple;
	bh=UEgL+cjcC5V6DKWXjE8NrtuV3xJULsat02NZJ6k4OB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiokEzDUxM2cNoDQdwbzbHvUKnBzamwGMN9uKaTuNT6lcB7Ll46UdyPNhlcyjJPF6J2Qmdjx2MxgifXgV8Fi3B5IePxOwSB14fMxYNUrMI69XX3G7ovuD9GCAU5X3p6Q+dc05083cY0aMum74efJtQ7DjJJyGilyTpj9Aa/YUyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gwwtiUaB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j91DCwsO; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gwwtiUaB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j91DCwsO"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68777vMC3686811
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 07:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	raxOv9BRhxh6b23v1ddPvBQgeOT1uLi4R0ZkrPkOa8o=; b=gwwtiUaBQ9vv5vCP
	F81bVhdb4bDH3f0qGwE8p9c3u1mrl0Apw3TIzE7Zz9Dm3hOzq/f9NONCiGvdpsyT
	QThCObQ3T45DCLGGi85tVZPs4TF8YeC/FijkeIngsVevj1rvd6lC/72BZHL3KoAh
	4LyXm8uUDznpgo2PY5rdntXtE5OGaVvGuuonwL8pKYn/a/J3JVvbffrlCI+DJYXT
	62+ynOG045je2Y6l7haRDroCh3wHbEQj1U19ckeRR/vCT/sYrXUmRsQ2L5HLoRx2
	HSas2PHgkQocg4jdib1bxY0BaYqCv0iAobiGHn1H4B9egSIGCu3bHkGh+czmlIVt
	+PcLQg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gga375xre-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 07:57:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e53b8a302so625701285a.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788767842; cv=none;
        d=google.com; s=arc-20260327;
        b=jzsUirJr+OJMoOo65p9qligRuNPXBEO2jx7IciogEFerPez8tc9kOgyk82qs53rfOK
         PqWiKDHgbCGowjG/cToauoCgb+OKkKHdDUIZU3ZkB2c5nTCNilQW9gnK54XmiiBHkRWw
         Qrw64ygvphKk0jJSKdQzjTmcEd7LSuToMBIc3n9lLHEeQhENOjrDTnd5syWCvk+kM+pp
         02jpccib7XMcO1G9BdLwDrZ354RVErfLx7lcs7VvuL1/tLDKyRUlm17fgB+W/uuNqM2c
         ojGjmyXDiL8dDq1lmwPeKekLGZG89d1CdY+D3t2Emz8CtCYKz26C0RkpMr05rSBAuvWy
         Vrcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=raxOv9BRhxh6b23v1ddPvBQgeOT1uLi4R0ZkrPkOa8o=;
        fh=OeSDcjJmJO+MfIbWIQQvh0ynDLE4+8tQTviyKxOTEnk=;
        b=Kd9uk/jMWwKACAL8RtjtWZbZ74/19hmPdxp+VEE5zTzFz8qx4lUjpli4Z/tRfPrSQg
         wypoHxmGihrYshT/qXnzhNRANYO/IkM1jX4qwYl/0haL0ITp0GHB172njbqRFlsm5pgv
         lvGqRQ72MzFzJrX0STW+7QE6kUOaSkblsVITQ7s+8AfNe78KSQDTBqT5odUf+ptoIBqf
         7Z5HUItDpRrH0FShXLMA7MU441QsarA3BYcGBiig6pAuq+GsrUyanslJ/7DcXDVM9Pt0
         bpGUI7DG6FOY4sBJvdk9tkMXXQO8290QzcJsNtIcLMbp8WlWRI3927KHuFuYMGj00qt+
         ukUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788767842; x=1789372642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=raxOv9BRhxh6b23v1ddPvBQgeOT1uLi4R0ZkrPkOa8o=;
        b=j91DCwsOsYuAs/1AjGtG0MksdXCs95ESIYKw0yrlaTcggDbWA7mW4Xy/7zulNn0ijM
         aT1NTCGPev4o7+QrpI9pVieabpNzyK2Y6DYYEXzdlmWMmzyJFQIOcyRprHoqOcS64VqN
         CSXP4PWzS/JvXy24DD/e1CX2LV13jvfngEYpuRqTVwa25YxQPTEpG7e7K0fbElDjbTq0
         A79U7O+uItwdX4q+zFB6motpGxuHbeqfRz/MjpaxLt90qRQTvEuzQxCv4lAuEbpWWkHQ
         ZEMEmeSPJUhhUjNb9frERVvUPkIrhDhWapoO5oEc2TPqr63kpYiB+YLGp+fABQcAsr6r
         0LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767842; x=1789372642;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=raxOv9BRhxh6b23v1ddPvBQgeOT1uLi4R0ZkrPkOa8o=;
        b=cRdsjU+iQRs6d0mwN00SfLvR8C6QdCdlU1cQzAEC1skZ+SNq0+wu0DpjuvJ8e0Z30U
         Gn5IbP9vxSK8T/XRPt8A85+unb1Xot+iY4J/ie/SVNjZ9+LaeebtaogHOC1fkXZubw0c
         5Ot78A96U5pkTrHhY3upoqpkhhTN4qDWXvoszQ1+TdUkuqfpo3wkJ8b4Eau19r3iXwgm
         GnF3LrMJ0kRdjY/J53lYPEo4j5r6pDjznv+1kMNOFq8xG097dXZkadmcvgaIBYRP5iFv
         CgriiEhxBtUYSEev1Ax8iJbDe4rVrJh+x6F4KIF+jKITLo1mpc8NbTPMVdupcly0TQ4Y
         R6/A==
X-Forwarded-Encrypted: i=1; AKwUvBxTmy0/ptZLb4A2uGhHM7F3vtrlnrzYkCbASKysFMp9ZSVXjjSkBmJz27JYgP4xXtbDOq1065k=@vger.kernel.org
X-Gm-Message-State: AFuF++mFrjIIJbHjpyAcd4L29irL9hYTGbZDiEaqYEP6GYq34k5jlJfk
	V/9L3tumTYl0GNgAhFdugEbLl/YAoDt5kSjBUVCqjXyw2/ZNMMfCYa3ng7IE4atw5fB40WWTx8H
	jeB7Za78SKmtkVnwryg7BEUNejhH/UOI1kXyoQDS6DKUKCRdQ8xP+bN/azjHRspkthHyCsjO/Bu
	buS8r6wiz9XeCbVF+izmirKOQDur23JDk3GuOMbXvNj1G1
X-Gm-Gg: AYBFou369PHxjP/X0UbYoG+A2i5y1VxxDYOo1WMB4KznBsWePCCBFUREW13UQaj69OP
	r4vF/2C30jO0DkC6z9eZ8i8udNRVhYsjmHzgRpuYFc3FVT6P7mLFzX7wc2lmbg6QWGGoxGc4wRb
	zch/DovY9PeRSzyOlQM+mnysHZvNN7FW++ns9fENhZfvdz++DX8eWhxxJNAL0f3BSx1i9twIpQ2
	vs9GkbLeJUayczFGS3cb5FBrgXrpMS3embIC1LshdCKfoE6tLBtjfAJzN9TvqnnmNmDoWbyLrM=
X-Received: by 2002:a05:620a:2801:b0:939:6dea:374d with SMTP id af79cd13be357-939804f9de4mr2213548985a.49.1788767841581;
        Mon, 07 Sep 2026 00:57:21 -0700 (PDT)
X-Received: by 2002:a05:620a:2801:b0:939:6dea:374d with SMTP id
 af79cd13be357-939804f9de4mr2213546085a.49.1788767841083; Mon, 07 Sep 2026
 00:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS8P251MB0001E25A247262552A62241BC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
In-Reply-To: <AS8P251MB0001E25A247262552A62241BC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 09:57:09 +0200
X-Gm-Features: AcwNN1UIpQ05EZDWMaqZ2tZgRpvM1SyCnXtQocSo9oLyoRHOwGYKGcNY3oOx9UA
Message-ID: <CAFEp6-1QNj2a1av6inPPD-Kpg_c8cxzNgEf+rq8Q-GhyS-+Krg@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: mhi_wwan_mbim: validate datagram bounds before copy
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: b4aZ4qVViseegrr6KlNwlXgitMe6Tmpz
X-Proofpoint-ORIG-GUID: b4aZ4qVViseegrr6KlNwlXgitMe6Tmpz
X-Authority-Analysis: v=2.4 cv=CbQ4Irrl c=1 sm=1 tr=0 ts=6a9e6e62 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=Zo5euW2OAAAA:8 a=VwQbUJbxAAAA:8
 a=hBUqTIjWXI3YtBs8_v4A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4NSBTYWx0ZWRfX8Ag7j5JYqfOK
 nSOMozK+Ea3oJ2iZPr9SMoON+70KnQT7rXrC0ssPKLDd+ReVx9PxJR2UwNoSND4Bs2BTJdl3flQ
 Rdm/Zgz7c2ytfyNr0+fWifMvo5ndmDc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4NSBTYWx0ZWRfX2u0oVeC30N4Y
 6qYXrKuRfxxj9e3l23hNLCNJElHpj+TINzYVlCzQZImBmYLUelX8OJHEyU31dnJdRqTHkZJbWqs
 Wi4bD6w/qY3PkPYohDt17Eo3CP6NqJ7wycHzKqP9J+9zWQBXnrpPapXEpRRtR7JV4p/0AviTl0j
 N8jj8CBkU/vrnixmd6inoh+GqinV6ejdPLE+NidbB9KNJTpZhwmS80L4+3uE+ieR4DUDyJw/LqS
 g1fbBFFUhWoZqMDCqx7WxKEWRZXHCHVTRfDVROGVqlNwiHc3MM55QmItxrFTJUnsabH4XGxMS5z
 aFhK4UMp6bxmXimB5qBfeN9em2zFJFrVE5/dxmHBSPPi/CPmpUrna0WJpr438Sdfjn7akgTTIFm
 /K1wHfOlrmTbKO6yZKc+qER/HB5x1zeWjIdUeOSz/SflkX27NL+xWh4AN1tHnkK4DDp8USg+2a4
 NbXN2Aqc/yhID7nXOrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070085

Hi Aamir,

Please review AI-generated fixes carefully before submitting them, it
will save reviewers time...

You've submitted a lot of patches in the last two days. I'd suggest
starting with just a few, if not one, to first validate that your
process is solid and that your AI-assisted fixes are reliable and
double checked, before moving to a bulk submission.

On Mon, Sep 7, 2026 at 3:49=E2=80=AFAM Aamir Ahmed <elb12345@hotmail.co.uk>=
 wrote:
>
> mhi_mbim_rx() copies datagrams from the NTB using skb_copy_bits() but
> never validates that the datagram offset and length from the NDP entry
> actually lie within the source skb. If a malicious or buggy modem sends
> an NDP entry with dgram_offset + dgram_len > skb->len, skb_copy_bits()
> returns -EFAULT and the destination skb is delivered with partially
> uninitialized data.
>
> Add a bounds check matching the one in cdc_mbim.c to skip datagrams
> that would read past the end of the transfer block.
>
> Fixes: aab8d56c11be ("net: Add Qualcomm MHI MBIM network driver")

That hash doesn't exist.

> Cc: stable@vger.kernel.org
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
> ---
>  drivers/net/wwan/mhi_wwan_mbim.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan=
_mbim.c
> index a94998712597..acdcaceebc48 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -315,6 +315,9 @@ static void mhi_mbim_rx(struct mhi_mbim_context *mbim=
, struct sk_buff *skb)
>                         if (!dgram_offset || !dgram_len)
>                                 break; /* null terminator */
>
> +                       if (dgram_offset + dgram_len > skb->len)
> +                               continue;

This seems redundant with the existing check in skb_copy_bits().
What would make more sense, however, is to check the return value of
skb_copy_bits().

Regards,
Loic


> +
>                         skbn =3D netdev_alloc_skb(link->ndev, dgram_len);
>                         if (!skbn)
>                                 continue;
> --
> 2.43.0
>
