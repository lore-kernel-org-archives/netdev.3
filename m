Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A4F41D228
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027771; cv=pass; b=oAQDOUvI3853FFyCmBpALqQD2QVvcipkyqcKfJT6Uke2DIrGKXHwfT/xi86kWX7EDSkaM1izQVgIPcXlLfl7cYS6UxKkCjeAWneYzdBX1oFb1cFiZrI16O9iC9LJF7VIe79yoFWH1LNeGVqx0iJsozhTM7FUJrBH9rfghiqxVMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027771; c=relaxed/simple;
	bh=e+oi/7PVMHZr0yXmqHSvM8XmVBC199Drw87zijqnF1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ytm+XdU1o+y4Vu/vtDyWG82KZ/IORiVsqGGdn7/ci1o42EzD4/7XGIpGaIY2WAncDDERik4uiq9r42jZ1QArwW6xEpne+zeb/AgcyQuUkEbjBk7v87HCxfFx5Jo414L2td7YBG+CtXBNfDgvDFpcomwUEm/IA1qOH1IGktBvgqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QnuYhC7A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KESZCpMu; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QnuYhC7A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KESZCpMu"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5H1uo4143034
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hrcreM8EzHtIJPybaks7D9tmnm5FFMtbNZvHl062kt0=; b=QnuYhC7AcE37eJFg
	jvAa9uaIU5U5Vs4O6u1T7WQMvGVxhQsbjnkHsXUFISkoJMLC5f+sQfw8A5uU2W7U
	nYyQVgD+GkbYAmEfVYYk0et3A55xXWVCtKpfQakPJLQRKQ9OrtzvYgC6wYUYTX5I
	Oc9jLRnSOC6K2U0a9W+WBkNmNQx9GTRrq4A95VYU+WNf6f+jTMjQbawatgqTcC2x
	A7IseivJpEmmEs1rLyQtIzkn7sLN8MDA/flWavDKujiDiC4nXmUpa4cZVGFVwwf+
	5P8UkxxANiFRCwWuGFinpIMJSJuAq7M3g3gcXm5IhfYINEX/qKz6iS5uAvzs4tOO
	GQ7vYg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyd2rjf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:09:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9382f9430deso1166988685a.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 01:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789027768; cv=none;
        d=google.com; s=arc-20260327;
        b=U7KAGTfIrYI6XTj+N3sO2vZrnR2diybirWp4rX1Wu39fK4DzP4uCjGY7X6/dLDqLnh
         uE6mqxX6UufbN7zMFD4dc6RWiGxw9jYfp71se5cW8KNqivSletV0clbGTp2BXb+kwdfF
         f06PbCxntn76ZGroU+XGq4rGPAOU9W02AhxUTHzSJRJ7al8v1ZssZychLHRtNhVOHccf
         P+niiZmVtl+eLtl/btgCkvXsso+086Iqs7zY1/hMoOPKqNSIfzxiy8rAk0Naj/GDNhhq
         Cyi/fzkHTrU5Pw+H2nUFFqIwPeUYv4RkjOaQrjjScPtY8ZjBxqnm3wKkx0wGFa8UNl0E
         Uhyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hrcreM8EzHtIJPybaks7D9tmnm5FFMtbNZvHl062kt0=;
        fh=ABq3h4xOOxnHxrdxNaA6AhYe6q7z/WGHzEPdx1c77xE=;
        b=T0LaJ5q13Regwb6BWGsU6bE+WrvaIyv0SiwmYTDw7NOGc7gDqC5QmtoAOtYD2dB/1l
         al7q6IC2zh++h/kAs/+oUa4Z9u048gaLWVieFZo3cOmS3RHYiPYZFCGM4hKByPJeqpdU
         MhLYco4IUAuEFdefw5Z/YqdgpUW/5fx7V2qvR8wSvc+C1/mGF7G7DPbCAX6JtKj7kVga
         CPGWxH3K2ZfM3YQUmqW88/4OolHlDDYzTpkgzCO52YyRdey0UGzJ8h3JSdYvKIy9Ou2p
         FCTLOVmZm5Al3hZ1CnjFQ7hMoPq9YBSKW10IvYtjxUyTb2aETiEVte2B0uwlzjCk0dOB
         QThw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789027768; x=1789632568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hrcreM8EzHtIJPybaks7D9tmnm5FFMtbNZvHl062kt0=;
        b=KESZCpMuHpgIrSgbTFZvNukqz8adFOI6az8OxiBszlH0ZOQ4NFX1cQfk3oRvhfKaNz
         PzOTd6EfiUPR+DBh6GLJQn2YC6gWExKver97uJMPFVUis1CqTZ0qDpXNT0FS630H+Yc1
         cd0anqSz6lwZP47BqDfB4YY6LC60Q2SFkjf4R8uxaCXjoEFDgQTtRSS6O/GE6jaXzBXF
         eMyTdI+pJ6CqfF9XvywS/LWksXF5+byrFy7uW8tZ9AbRwvJrhA+7FgkS6b7SJEJFgPvt
         rlKL9of68mWy2wKChabhMcX3pXLxe/mMGhtnZVxCrL/up/PxIzfjZr4iOScjkt9PHv83
         vTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789027768; x=1789632568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hrcreM8EzHtIJPybaks7D9tmnm5FFMtbNZvHl062kt0=;
        b=D8bBbhzhI2NWCYLJ6nhCjUO3J0hn/OlFyCm15xAeDnCOaPHDeWa1O4BwRhs143GmKG
         QRQpoz8NizZZ3HleXLrJ7b7TIHv5C1ylWxUEVMqbq0Cqss3We7z11kG0tYflYhTyZNUe
         YAszQ8hmnq8aF9Ty1FQAmfiH/1ev998wNooPLLT7P8ANlw97GXTgidQiGZUYOCWBn41l
         KNUQ7o3vIFBRDmx1GzSMQkBw4cmBDkyDEDLZCTtl2FmLMSoJdMUuezd99+3koZlDe2br
         x19cnulnYyB0TYhuUJqDh5Qw3149e7pQJ8KtHliHVDfasg81EbQH7aIZuSsgFM0HblJU
         CgxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwViYur38ls9nafX9JdkRGtaWt6i7CAgIS2wjlcSPDvbZxAqKD3UMCLlJVvw+IUsAJLUr4judM=@vger.kernel.org
X-Gm-Message-State: AFuF++krDTpULPztbs+LYQ7AbRgOnsxg5Y4cQ2geIh4CBzIwcBNpTySP
	VJ/Ji4CM8z5UOcaEaRwlkkFkV0SGl2Qm6DuMVaxqYVcQuMG6ycntOkvZOpcUq1BHTsgVJgbTc5h
	CmtaRbQeR0+aUUyhp/kpmH0pL5IITf+zU6BPwcqPgtg628bIv+mCBF/KWz4VPayeC6BD0shFqpq
	3LqfmQX7jOidCgLj1ijAeoM+BL9jBOMJ3A5g==
X-Gm-Gg: AYBFou1kdvTtjTdm+EzELPbHVDM3bfKh0pG3mUx1+zWZOC1BJ9hKGsHSA2IJbkLRfTo
	NuAX+uGD7UjbB6HHXDlazAI0x7wXZNz4bDmx8G3bps2bK25hTSJDH5hxZy7dmj3C2U3jiAWRENN
	LMGoQFePedWOYbl+04OEbwP461JlA5pWU/WFCN0lKWG8OxwKD8UQuWSs/HHLPtyRspgQeiwf3xE
	lH3bSzguskmhYYDypTUpoeDHyRWkRRAlXJefnRjNW6cqL2bTRMkRauwiU17WYGZAhzpDpZz8xwa
X-Received: by 2002:a05:620a:8105:b0:939:6de8:43e2 with SMTP id af79cd13be357-939804cadaamr3577777485a.47.1789027768172;
        Thu, 10 Sep 2026 01:09:28 -0700 (PDT)
X-Received: by 2002:a05:620a:8105:b0:939:6de8:43e2 with SMTP id
 af79cd13be357-939804cadaamr3577772285a.47.1789027767689; Thu, 10 Sep 2026
 01:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910033356.1052661-1-zhugl3@xiaopeng.com> <20260910033356.1052661-2-zhugl3@xiaopeng.com>
In-Reply-To: <20260910033356.1052661-2-zhugl3@xiaopeng.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 10:09:16 +0200
X-Gm-Features: AcwNN1Ve1L8LMjcOpqIQaJD_QJYZ6Rdp4UWA7GwnfSgFAJr5DOKNJ8SBomTQUyw
Message-ID: <CAFEp6-1VVVk94T_EoaXSW8aJzRNuWeGTo72ZQNPJePa=aAL5-g@mail.gmail.com>
Subject: Re: [PATCH 2/3] net: wwan: mhi_wwan_mbim: check skb_copy_bits()
 return value
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
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
X-Proofpoint-GUID: 5heds5OxXEBr-VrrrBpoNtaYbMMlfFup
X-Authority-Analysis: v=2.4 cv=ef+o7LEH c=1 sm=1 tr=0 ts=6aa265b8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EgahoUkMAAAA:8 a=VwQbUJbxAAAA:8
 a=wIlMCVVetkfELOPdIZwA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=D2SkTF70-_n5gOfERQdM:22
X-Proofpoint-ORIG-GUID: 5heds5OxXEBr-VrrrBpoNtaYbMMlfFup
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4OSBTYWx0ZWRfXwhp69FXdEvI0
 RzPJPb9hrNv7YQ/YRrDrF4trhM+esAOP7LSvFFf9wh8uLZTn5z5rDhM8k2rWyPxByqSX8cOpiCc
 LS2MgMo8eYRkuMN79tUYOluFM8bLLzY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4OSBTYWx0ZWRfX3bgybOgvKdfl
 JDxjxuJ9c9mVa74fRbeITnbUCdR+17CsAYDGwmqsJJPbEPYfkZOEuaT5WKn8Eh/mQZ+2cKpCnUA
 XP+Vd87yaGJQT0VFM1C8OxYIhvZlQKfOpAzVHsZi0ThxinD90sYecwdw63Kz7CSMMKWELUHs6pJ
 4twURGxkNK4LZL7yLdX7EjM5RKZj7iNKPsZrm4emI1I/+jnngPz/NgtItfEAe3QQr0riXzWd70V
 eob8H4P/ru1mKZnbTtF3j9hBYgDBI+VxeVqFNgvNPVsdMctz2bWOrnAI6JgnEe2ux0dgKGIw7OJ
 xGcovhEYaoT6g2ogGmCE7R05uQ75LjrNV4ol14xYx/ndP2EJsnAToac/8wqXfIhNyJVN/GYjfaS
 rv+P7REdIxdUL3dWcn1+uo5dfEy7HYVOXijJPv2W3dwtRkXltK74pwT4NZphjnKdqKFsv/nQw1G
 lB4TYMPXgR4RCBP3msw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100089

On Thu, Sep 10, 2026 at 5:34=E2=80=AFAM Guanglei Zhu <zhugl3@xiaopeng.com> =
wrote:
>
> mhi_mbim_rx() ignores the return value of skb_copy_bits() when it
> copies each datagram out of the NTB.  The datagram offset and length
> come from the DPE, which is only checked to lie within the NTB
> itself, so a modem can point a datagram outside the received skb.
> The copy then fails and the freshly allocated skbn is passed to
> netif_rx() with its uninitialized contents still in place, leaking
> kernel heap memory into the network stack.
>
> Free the skb and account an error when the copy fails.
>
> Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
>
> Verified in a QEMU guest with a fault injector pointing a DPE
> outside the received NTB: the copy fails, and the unpatched driver
> hands the uninitialized skbn to the network stack (observed as
> "unknown protocol" on bytes that were never written).  With this
> check the failed datagram is dropped and counted as an rx error.
>  drivers/net/wwan/mhi_wwan_mbim.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan=
_mbim.c
> index ef158edeb..71e700008 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -328,7 +328,13 @@ static void mhi_mbim_rx(struct mhi_mbim_context *mbi=
m, struct sk_buff *skb)
>                                 continue;
>
>                         skb_put(skbn, dgram_len);
> -                       skb_copy_bits(skb, dgram_offset, skbn->data, dgra=
m_len);
> +                       if (skb_copy_bits(skb, dgram_offset, skbn->data, =
dgram_len)) {
> +                               dev_kfree_skb_any(skbn);
> +                               u64_stats_update_begin(&link->rx_syncp);
> +                               u64_stats_inc(&link->rx_errors);
> +                               u64_stats_update_end(&link->rx_syncp);
> +                               continue;

We perform the same error handling in the switch cases below, so it
would be better to factor it out into a common helper or a shared
error path.

> +                       }
>
>                         switch (skbn->data[0] & 0xf0) {
>                         case 0x40:
> --
> 2.43.0
>
