Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080340DFBB
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823463; cv=none; b=ZX/V0nm3yeLvkzsXdGr7JbD6Amz3SRo5iL4mg6OU14PHDcfKR8p2KlStEKtPp89GUKnBQmKJ5iPZRuDt6jcFALrNEOiejeDV8ESxKlyJaXLGwbSglKHTZIHf+UaLC2SrFTOS4KusrkYgHK0fIYS1RScsgkoVkejJaAm1f3K2Y/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823463; c=relaxed/simple;
	bh=5NyZE/pdk1UUcfMYTWurDSt/bJg+fnkkgCBYJNkdRJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFnKHXWTJYbpdEoY2WYloQqTEHujAmxnkL8TUTAIOha/4kfUahL0TdYBH8MxzIEsN3NQ9l7dHVAPY2o5CU+KJxCtZaTBz4aJrzNEPGbmX2MJ4ixFqtsrmGAPzNZaApNVFHOlDvFR/fbD6XnM4k0VdMiuTtBHCmUEKINHwniHBlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b6o5P/f4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L1mHIhpD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b6o5P/f4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L1mHIhpD"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mxeb1605154
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gD9g9o3wLVxWkvqZBA0nQ7MO4qU/Lgf8nSjItSG4AmU=; b=b6o5P/f4dub0N+sh
	VloUIC5/nznDnJpdi25/JuyuvwG2UEzSJKKvywHK0tZrtZT9KUZ/5rxDpzkAbK35
	dsnM/t9aZuxSxU2dRGIZe6jSc+AjUnNQpE9yweYJ2AHh3rx+0/GCQrqKHV9iLFJd
	l0GX/TT5eBf9LEmr4iI2JoKQon7GYA3eQBuKb73gMscfC3mX6KuyV7kA0Qrm0VgR
	Sx/9IGVhVELkU+ss5iFzAVhFhfcrFPin/yM2k3woV5wD5lCojLKYMgWCTLttw8p6
	JC+Z5uAr7lpj3dOpru9IIxbKchWQWwxRHb/JJjqzOKMn80zS9LHcEIdrMlIPnKRX
	7BmsvQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f43vfjptu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:44:19 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7376ea4bcccso81712137.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782823458; x=1783428258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gD9g9o3wLVxWkvqZBA0nQ7MO4qU/Lgf8nSjItSG4AmU=;
        b=L1mHIhpDJyhyAD5WK+a/yfWPlCboP2MsfJZ5XTrUE+Bm8mHjciwfwjw/VytDe4TJeI
         lHSP5+Wb5h+WsX7ilaX9GOhD5UP7vnr3VQ9aB50Tm+oqc1Fqw3cQNF1GjQg396Udgi1y
         a0yvDOnl8TxejxLGH/lzvDgfWZoqk/AHbMfFFLTsDVaIPpYTSrvgFTAmqKO9nBJXu1C6
         XMGmVpqeJBZp15/cFMzoe8ZIS/eeR7R4SNRTJQ6r5O3m0yhnCoW2avQfHwMj0sbaIriR
         gPQTOgn2uqYH74IbT/wkMlYVvFIe4MWMg5L8DZB393Nf/LXkKhufRp64BV9C1YC+AuGO
         BC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823458; x=1783428258;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gD9g9o3wLVxWkvqZBA0nQ7MO4qU/Lgf8nSjItSG4AmU=;
        b=hyI+8bcZTQ6k4tsExoqQEjaYteQVtsMNpIL7vIs+667uEBNZM094Iw8ItU3MEu8Tsi
         RB5pGIBk+qJAVHJASq8t0JiKa30THofhz6m3dlXSG4fckGY/kjWcaVmdoW6gTiG8407T
         Fe68hU1anoKHRaEW4S8B9YbI6rJJ5xSqsW9n1bVkHtIM1g2LzeiIuP8nuzu17blyJxZD
         ZQeUjqgQTzJJjQkuZ8iveHuPlO/3vQFY+N5R+ClPJr0TPKAHGTkigpuquOYxIb8giKyd
         MSgBHkTXmUKhMi9y+XQWUhIrHok9tY1iPhOfHurK4Dc2/W9kHEgkGhyl4DTe7sinp3nw
         6jgw==
X-Forwarded-Encrypted: i=1; AHgh+RplsyRY6r7HGfspThPeaPdbD4z+7hx3gvAOzVidkarqJGHxMUvV+MiF9obmGdqhljWT9VEgT48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrEoZztDyJiYgSf0VSwr4u3bFZrvwoB4PMRENsHJceNGHIB4IZ
	5BwFkWTqSvkzN4rPSsFUVeSbuQ6xlKLHhzj1LHciZTPp5F4a/qj4u/pjuuDlw2Z01iExtNcod5n
	8VfwBVkP1o+z7rqHijpg2c9Gkyj+Ui14PZN/RlKZVnVWpGRKuoTnG7lVrntQ=
X-Gm-Gg: AfdE7clHcuT68NMfl2LK4pWEXvQ7hBFjjNoaO0QnnfFMA77ENRXl2LTOGcS/CULjPbB
	IZNcylB6O3B9mpi+/3ktyM7m9ohtJgSCsd/32dNg0kG36mcjgvppscFPWyke/xnNQcQ+8v3FMeg
	5rWaZGIYrPNyP2ET1UGFIJfL/CQzhrDawKvB6z0ly95QShO3CSyPm703xdQBY3NvSv98UwpWwcd
	ejVovh0aNmdwN5RPxJWrN5nAAhb0WgLCrE5FRpUaYrt4xnALD/TlIuYlrPAziuoegQKMkRJAD9j
	RiYG9irNKc2Vr8GDCUuiDMulkAYfFhKvPbNZwpjKRrvb5nZeR6txaTonv5oHycYfRqkVCPfGVc7
	zpTgrb7eykapc4SNmfAnSi70C5iM6QXUt4aM=
X-Received: by 2002:a05:6102:8082:b0:631:25ab:8bbe with SMTP id ada2fe7eead31-73a38a37b21mr524330137.5.1782823458294;
        Tue, 30 Jun 2026 05:44:18 -0700 (PDT)
X-Received: by 2002:a05:6102:8082:b0:631:25ab:8bbe with SMTP id ada2fe7eead31-73a38a37b21mr524326137.5.1782823457846;
        Tue, 30 Jun 2026 05:44:17 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c950732sm1117239a12.22.2026.06.30.05.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:44:17 -0700 (PDT)
Message-ID: <ae6518f8-bba9-41fe-a97f-de6001319c0d@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:44:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/14] wifi: ath12k: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-13-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-13-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oj9Ut9Rf7gKdKRATnBFx8tIAZEq51h8j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfX+zgj1/+gR7qQ
 Kafp5WTWMxM5xtOHYF5utsMrkiMVxMpNcjF8VZa0qMRA3NCJytrrphCZ4CEV0wsAUvjWA7D8ahG
 Kwzu3rkOfKDafD3mtdlKw96pwfTqhg7io3SfP9Yz5ryEmiBzMQAgvLQL9i3RQN+UvaoNE8tTqE5
 7IsXXuLgNA5gwq7J7XkPascEmdHNguFU/7ZYSj0Fd8Zsk2Vdedfk/j4UHp1sJX/Wj3GLOZxOXvh
 n28VnZ+nIY0LIw6yNKjVgxx3enQAITdU+pvhwC/TA9lFkPum7YNFVYTlF8P2M9YGx/st4mB1LZt
 eVplh2wP4uhROKWz/1969wIyXDeU7bkcJa8qPIcSkwm5zozqEf3dkl1NzNvlpoe2l1kOjp5ln4Y
 Q6uFN/rBA8jr97eOIY5Kk6Y5z8tBj3MbalN/jmGKEW5TrMkV7FIqp8mo9FTMr+ruUbbPJ6zZabW
 8fJ2drAd6QQ5OCrA7Ng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfX0uJkaI8vWR4f
 ZN+oH8FF/w0u4lYX8yqnNl+CGYYaSK1niu900z5B/uD5zJsWauZXPOPoYuwZs5Sp1Jhmq4GHiTa
 QVohuwAAT867sk5X1+WO0M8lSOMCYiI=
X-Proofpoint-GUID: oj9Ut9Rf7gKdKRATnBFx8tIAZEq51h8j
X-Authority-Analysis: v=2.4 cv=PcXPQChd c=1 sm=1 tr=0 ts=6a43ba23 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=AoAzlOJtnLSqI_VYGEMA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300118

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch ath12k client driver over to generic PAS TZ APIs. Generic PAS TZ
> service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Acked-by: Jeff Johnson <jjohnson@kernel.org>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/Kconfig |  2 +-
>  drivers/net/wireless/ath/ath12k/ahb.c   | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
> index 4a2b240f967a..0d5d1c55bfc1 100644
> --- a/drivers/net/wireless/ath/ath12k/Kconfig
> +++ b/drivers/net/wireless/ath/ath12k/Kconfig
> @@ -18,7 +18,7 @@ config ATH12K_AHB
>  	bool "Qualcomm ath12k AHB support"
>  	depends on ATH12K && REMOTEPROC
>  	select QCOM_MDT_LOADER
> -	select QCOM_SCM
> +	select QCOM_PAS

"eeh"

[...]

> -		ret = qcom_scm_pas_shutdown(pasid);
> +		ret = qcom_pas_shutdown(pasid);
>  		if (ret)
> -			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
> -				   ab_ahb->userpd_id);
> +			ath12k_err(ab, "pas shutdown failed for userPD%d: %d\n",

"PAS" - it's an acronym

Konrad
