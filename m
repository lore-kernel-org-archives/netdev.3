Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7935CB9C
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 03:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787283080; cv=none; b=K9Ot22dsPbBbZ7m5As1ldnUM2Pi+Slf7sSA6O/0DoLSGA3zXqX+Szv95DqIIeh4lIQLJqWMO+eEXsNsdQxQNpYyBgE82833MDRgXMWN+fRizQ8wMbabslhFNlg8XjibdbtDeWrHhZtf+C367Sk1MKOMwKEpicDCMPr+VBfzxtXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787283080; c=relaxed/simple;
	bh=rRLjEKOLQTMb3MSs7xUoB278zcnrFLWzrc9athBYbT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh2ESW8u4eAqR84YueDjpE2tuCgCjNW5nukgP88JhanQ0V4/kmC8Kttkn+80BP63pz5d6ahBhOLNMbbKVmzWmYMWDSb5ID+rZ44L6OSKhgaAkAr/2E4OkNwH8obxqKYyz7aw0vMUhoSiiqpknec3EZ+PMx/1S3VX1MsGyLP/VYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bfUBn51c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iq/TBpzG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bfUBn51c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iq/TBpzG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L21bO9575397
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 03:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=D0BJKbNWPl65wpikRy//Ivdi
	8hshU2EcZQfRlKLXdf0=; b=bfUBn51cj+4qnKl6bAsvBrdGbGMw/iGoS7nPicYG
	Nn8QPmqNHk8rxREjVkgWGIW8tyAwKdNVMg8Yjr0KCGoNIH8zAVT4Q5GVKzsCgVM4
	vAmqfqewKISGPcwbdHIbc4XRd+7P7RUma9RFK3p7Vobeut5DyyGKBhNBLcTUUIFd
	SmFo7lLf/klJHxQbGomoO7c2vcK5SmD8NTQTNy2JdTEQq1EgJJ41uCxA/G/pEuk+
	D4CEBlCDceuoGeNZzguo6zUzvWqFpBekUkyidzEH/7puOYGuYLZknJzDotDvHzd2
	rtcu8Og2FVryCEX2pbO1eePFEPeFGuDOhwj5ODfpYaNg6A==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6d068c70-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 03:31:16 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9772e18c186so520813241.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787283076; x=1787887876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D0BJKbNWPl65wpikRy//Ivdi8hshU2EcZQfRlKLXdf0=;
        b=Iq/TBpzG2ju1k1J+L2RyidxfgF1M5Ztq+0iqOPuNflCPcCVdUzBp7OE0Smu4vz/LJf
         ocM/14ciVj2xEpr3clQsVjFjAry9q3lqbVZ+Wibb3j/FLfi/ypbOUORbYWas2lzClCMg
         uIa6zo7UR0BqGzk9UnbAvO+lc6L4kSig+BdF15lieb9HW0/ga3utmLA8MRrdUPHERCwr
         CMUyJl+Y/0QclDLzbDC7EiAE3TmORLSu8cUXD7BA8jEgRJ8t+Omgf/pegu9PpOtuOwo0
         zWwYIM0/GgdqaJof1iExCxZuFLFpzBCAzYVeGAp5OBnv0uKB5szZdC7OTUFawmrtf2gK
         VEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787283076; x=1787887876;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D0BJKbNWPl65wpikRy//Ivdi8hshU2EcZQfRlKLXdf0=;
        b=ejAJNobetx2nj4XAqm2M8UbZm8fnsM4SgvE8AQAGwjbRIV4xnXyA/YoRRjN7Xz52lo
         XvgXd312QvARkrLpYKizT9DModaFffnGycIkTI83VkyLuWpywKraIsgK9zYqmf+NzOGk
         BgGsKWKtgWjG/lK3MwjlrkO8bk5DKHweYIDWB+lnJ1FhT3YCgP7vv0ylrskqmdy2YmNc
         71OFST9r6CzvBtULnGUWXGv/UatWw0I84r+hN1N1QqP3K2B/jkf2bjcUEKrWTZZpBJrs
         VUYg0Md1t3bK+SUKZnjObd3reyZdoyb/VyMXnqspFGyiPba0X8yOafSGp6671583G8by
         9phA==
X-Forwarded-Encrypted: i=1; AHgh+RoeVPvupwsL2wadOQuodqDYSPFitDauK1EbXMPzE95AbcY8efUva5h/F2fGywYfVCkYYFYDMt0=@vger.kernel.org
X-Gm-Message-State: AFuF++lyV+ystG2i4XA3puo4lu4agXbpMUZwSa5480RgbZ0g3vyEyJ60
	yWpYLGBwiBQ9JlbwxaRoMoWrmbiOf/pde3sSETA96EeReyvLhJERWYCwtyGnZEh36wnFzQYpHeO
	ybLfxA/eiDu0xdZ6wHhXnDBFthQekgXGNn/KSwfA0kTfvhiGjhX9mRnOCnnk=
X-Gm-Gg: AR+sD13KgeZIPyEFAHk8FKRsctFYv1MNRQwACNQBA+p0bjfwIkzQ9mnytWa9mYArze0
	lgLxAPAUEjeWRFfuCXawyVJy1fVg9usoxHAu1ITcxbAHpS6K9V+NdbT5eQ28Mzk4+zAq0ReKx9D
	t57d6wxKTC2COv93JuSdimAcXuc7K9Cmlk+xjzvvj36/24ev271URndQUirkTilj+JlWbbVf2Gk
	1T6Lq2ORCtXdVJw+3FS5ffa+D5vXM7fYFOlU6KT4nOsdJjbsTE433uurRkGmqx6wzMlP6kbWnmq
	09rq8/eDgCait0yXuc3Sqv6vGZI8Sh3j+PsmRzR72+5frY/vSxJ8nzFSg1yQKPk093BMHmHVXo7
	Q8DttP3UPZtiBjY8=
X-Received: by 2002:a05:6102:441e:b0:778:295f:d915 with SMTP id ada2fe7eead31-77a64767987mr1520079137.13.1787283075716;
        Thu, 20 Aug 2026 20:31:15 -0700 (PDT)
X-Received: by 2002:a05:6102:441e:b0:778:295f:d915 with SMTP id ada2fe7eead31-77a64767987mr1520063137.13.1787283075188;
        Thu, 20 Aug 2026 20:31:15 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff16c3bbsm4318886a12.24.2026.08.20.20.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 20:31:13 -0700 (PDT)
Date: Fri, 21 Aug 2026 06:31:10 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, richardcochran@gmail.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Frank.Li@nxp.com, horms@kernel.org,
        wei.fang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] ptp: netc: fix period truncation and potential
 divide-by-zero in PEROUT
Message-ID: <3pct7p5r66gcjk6lv7lczavowqqeho5auwsdxzcuvpfyqatbqc@5mclaxpjrp32>
References: <20260821032449.1235065-1-wei.fang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821032449.1235065-1-wei.fang@oss.nxp.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDAyMiBTYWx0ZWRfXzrURZnI8bnVR
 tszbkNOa6KnLKXpmZYXkPnFMOQFbWqIZlWolNFzoa9qD/3MtndLRRWtd9c0T6ovx+enMsp8wsW3
 1N58Vi5LDbA2fHuu1eyyiis/K79CB6ZN8htMR2eId7F89X4Dl1cBMN5dGidju3N5Z/UNCnlZKgx
 rAzMmg1Y+Fvkr5bNs1M4OxbyAzihDELpYXz1KSEPp+Bea3badIplYVfRmDzg8KcCtXn5zMm1xHE
 UqXOQ0RaKLb07jnm6KbF2DFIs8vdmcHzr2tWcqsm0/Y0rhfBlU0VlIIs5gqylJY1SbO9KwDyu7k
 yAt1oE7615vDWG1H3CZgQshWHuvmFeX/9mPaBxDlliJK58OvkixtUKCAQPdurYmtTrdB0py8KlC
 2Vb+vfLG6+1IyLLyJRBl788pKKTnFl39ZjkQncE4JhIGwZZbjLYHFKd82o/lQ30Nif+B/ZwVW5u
 USxR0txnZLEBmUm0yGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDAyMiBTYWx0ZWRfX1dB0AcshgtRk
 qqkoFWf/tG/g0pEV4iVzACUBRORbz9pFVZz7+5TOCo/PbU8RK0EVpRm+DvOyIxQbweKYe/NTGIf
 Tw7tZTNxvHPsN0HLQWJqLNx5huJK3gc=
X-Authority-Analysis: v=2.4 cv=DdQnbPtW c=1 sm=1 tr=0 ts=6a87c684 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=yuO1uXqJhx-VUX7VmG0A:9 a=CjuIK1q_8ugA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: J6DRJiF4NaKz2a7lJr2bTSSZsoVaNP-m
X-Proofpoint-GUID: J6DRJiF4NaKz2a7lJr2bTSSZsoVaNP-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210022

On 26-08-21 11:24:49, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The max_period bound in net_timer_enable_perout() was computed as:
> 
>   max_period = (u64)NETC_TMR_DEFAULT_FIPER + integral_period;
> 
> which exceeds U32_MAX when integral_period > 0 (e.g. 0x100000002 for
> the default 333333333 Hz clock). A period_ns that passes this check but
> exceeds U32_MAX is then silently truncated when stored into the u32
> struct netc_pp::period field.
> 
> A truncated value of zero can reach netc_timer_set_perout_alarm(), where
> the local u32 period variable would also be 0, causing a divide-by-zero
> in roundup_u64(delta, period) whenever the stime < min_time branch is
> taken (which always happens for a start time of {0, 0}).
> 
> Additionally, netc_timer_enable_periodic_pulse() and
> netc_timer_enable_fiper() both compute:
> 
>   fiper = pp->period - integral_period;
> 
> A zero pp->period results in an unsigned wraparound to 0xFFFFFFFD,
> mis-programming the FIPER hardware register.
> 
> Fix all three issues by capping max_period at NETC_TMR_DEFAULT_FIPER
> (0xFFFFFFFF). This ensures that any period_ns passing the range check
> fits in a u32 without truncation, so the stored value is always valid
> and non-zero. The accepted range is reduced by integral_period ns
> (typically only a few nanoseconds), which is negligible in practice.
> 
> Fixes: 671e266835b8 ("ptp: netc: add periodic pulse output support")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
