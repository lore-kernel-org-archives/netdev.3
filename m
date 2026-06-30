Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76E540C5A8
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823424; cv=none; b=MsXvJg7RNoepuKRJKgkhuf9ben3hZBjs/3X8P1yG3W2Tr0StSV4SWvPSeZviNqFP6PiAbqmIyWme89Jt/vSMa4hvBM7S2wVeeRQ2GlgBRStjKGduNAxWayFPAu7ihG8zmV4Da1P92C3QQJIW4P8TK/qOTWepFbZVItO66WFetns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823424; c=relaxed/simple;
	bh=BgY00mBvxWkHejgPkucyLWTBpsCWCY5fK1NqMPCqd+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OC9EQ7xyw8V8emMdaFExC/3e/TyNhb0L3HPGEl5DNmx/zzy4g5cehLtNYtbesmjhDpHHJzrFR9LOHCAUVvpb7au4GblmozDgHtY5JV5txfrMneQyKaWQvDYtIwddigQ6QwRulzSrrb2Wvl61wsAqcShM7bubCFn694W3tCNzcYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F3n0sFhN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UedqZOc+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F3n0sFhN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UedqZOc+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nK3R1606633
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	40HebzjMVnQxUW0qFO0coiRdTK0hbU3rpwuRRVO0fek=; b=F3n0sFhNv4vOtoPY
	BXpZieU5OTwgT+HxAP0Ui+awldHBAbEr4vblIJ9IdeTx7g2gtRrx1GseILh+9/Zz
	aUmOUzW30aW1DfxX0b6aivoylCA8dyu5nTTHJxTXKFcXYQeJpUqRYcH+cRLQPY2L
	mgBawKtvZMT/4MLeuXXScRU9UDEzx2vtpgQNU524wiU4QVKVdS2TJuOs1bU1B4gY
	PP3d9nugzR1z9WpP3ZipFIsVzxeM8o5ivIptJ8TRF5ogVjGNk69Bk7kkhKrB4KZH
	SX87UJJTfzONkxOeiEhrA3XT5VKplB3UT3HP8JIyDOMh/eDIuUKMKAkX4IkMSFbr
	Mib4eA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f45k5tcr6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:43:41 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5bda959ebcaso100917e0c.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782823421; x=1783428221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=40HebzjMVnQxUW0qFO0coiRdTK0hbU3rpwuRRVO0fek=;
        b=UedqZOc+rqU/MtSH03B7AJY779it/pTkJP4J5i28GgIC0o8ho1o3hdu4M12l3vyfjN
         kbplrwRR4jfH0cFYyJzfnokej6LAbjM6XJQ3iRiaorwK271KhRx313fiiDeJo7iCRz8g
         VIZPshhB1UvppaFlaV2hZi5NF2mjdfCVxJqd2ZagYf/sjh/SIZZ50IZ7jIvogIqfZSX9
         sMCQQRJMpzeUwgcDy3NZ1OIdWSgb/8a7JlIC1kQht9dQIVSEzXt0B/R3wo5fFUn0fgxr
         tUVDb+oBKfz81nK0FtNw/e66791FhD5e/BrMVGI5lxzBOZlJJ0kviYWKk0V374K5Ja06
         SZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823421; x=1783428221;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=40HebzjMVnQxUW0qFO0coiRdTK0hbU3rpwuRRVO0fek=;
        b=jP5rm027DSoyxQDdr7AWKKeDwjjbPZAXYhe6vDCVkFt5ACL7/h08QeKaMtTkD+ejGx
         4AcR5AYjjSn2n3NPzZOG6+dnBP975/jjvuUCxUzmoj1sG1p/XPMKCiSsAJNaYuiI0Kky
         ZEKU1HX3O4OFzngeEjju/h/HwUtdk6ettLIbfgKHMGshqL6vDCozkWcKPG1wQG1BCrSf
         WRpfltkXxTPoIoMEL7BffW/zQ/vp0MQ3yeC/svGXOCp0wzQQXTgJudFJWxEPzyTRE43l
         MMStHoHxvtopdmdI3ZWwtzXz3sGEFAhAvzfx7tObN5rPZ4CgKSvseNcT5rn3W5W+Coyi
         mK+Q==
X-Forwarded-Encrypted: i=1; AHgh+RodRZxApK27Lem7bgH5Cq+ivkKdklm50uvu1sC6RdKE913dFoITF4mnz3pFjis+TNsQLT7W+30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnFsaN7o+PP6+nhS2/UiDWZSuhtVBMf6IMgqFpVoXi5LyCrmJj
	hSJFdnjn5JJJel3E5Q7FlpTL8HB1K6TR25m9WNet3TYKXTIVskUPpkv3Bx6exknhtnb9iyk5yRe
	/PA1xKFt8u1TPKAkGwWi1QpZFP1qnHfIuKtJdcisKLLEC4i2PrpKyQaB7cQo=
X-Gm-Gg: AfdE7ckjvcFYStsP4FiwiGvrdmOeNU7rBAfmn7b+ZYvldMGTm577QKM+TF3j2+MvPFr
	JIHoZMXcoAb5tvkLxuitbFUSXLutPuXOf/EQh4lyv71XODM81kHUogMfUkL6+DNj6Ms6mO+VpE8
	T3uifkUjHAU/j0fO1sfCA6Ti8aZrY0kMKVVI9VqQ8V4+EXSqlWPTtUkH2lf59uHqgtIsuli1fdJ
	BnVVNkxzUHaUB0oGDptgDPHzKArc67kousjIkBo8rqcS+5bXwvr6KM2yedQRhsj/chF0nltWzg3
	AZMQpguLjatxcSYlr0t6mEVvKqYqdYaQbz4D7UDgemOy1+OomYgkw0FOSG+pSM46BpEnydxiCFe
	3pD5EFIqmaZ2fcAXTxXASOPRViLsMWk7VZdM=
X-Received: by 2002:a05:6122:860e:b0:5bd:9cbc:93c6 with SMTP id 71dfb90a1353d-5bdbe9a7662mr493240e0c.0.1782823421003;
        Tue, 30 Jun 2026 05:43:41 -0700 (PDT)
X-Received: by 2002:a05:6122:860e:b0:5bd:9cbc:93c6 with SMTP id 71dfb90a1353d-5bdbe9a7662mr493224e0c.0.1782823420597;
        Tue, 30 Jun 2026 05:43:40 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c968400sm1127666a12.25.2026.06.30.05.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:43:39 -0700 (PDT)
Message-ID: <e05fdb45-0ebf-4dee-8d25-05dfc65042fd@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:43:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/14] net: ipa: Switch to generic PAS TZ APIs
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
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Alex Elder <elder@riscstar.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-12-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-12-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=6a43b9fd cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ee_2aqc6AAAA:8 a=smRyAmGWe8i0dDVrb1gA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-GUID: muLwFpHBQDP_kxSgn2_lo8aPp7rJGTrr
X-Proofpoint-ORIG-GUID: muLwFpHBQDP_kxSgn2_lo8aPp7rJGTrr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfX5hp3lZ/2fNLO
 /2Bvs51SU5Xzs4HP4WJgbsFI2sTLKigK+PdVTJ4eONyqJcGLcOx9sqkJY5iWOPmmO3lWWXbZ5Rp
 N07HUrn2cuWjqxGyVXSKlPkcr/iIgJ8ZrziKDRDGqxlKrCsVlJAtqnYb+BocMtTzS693cAUQy63
 3NU0iasCMo9pSYCOjX7AekZsE5P3Ueq+rkQ+mOkPSONjd+GJ1YRN49DrfuQ5FVLUVN9HABMlrTN
 A3qQ5VL72Gq3K4/VKAeUlrsoBVT4LdA6qxwA4g/RaFSYTZdWNCwFKDLIcfbeJaR+5WUOsimCIsR
 CJbbjspvBTOdXgBuXHTKsmZZPJsBpYEnShJxZjZWNXNl1xSPxl/4PRyQiE4w79SrFExmhxqlTTJ
 oMHODHyrRQOXpM7xHn9lTDOuOXAsnHBwXsDY0cJPgqX/Y2N8rjZsyH3PIa9E+CiqFkwBnhRHYWI
 ElrVoiCcOXybEiS08zQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfX8BVE6kn9G1gM
 FbeHnx11B4wCJAkf2Y3QLgnE3nCt9gtYFJWeVSawtvBZj+f8HzOW0fGvDqf07wILxmCgzV+Gg6N
 UU3M2O3Xbl1U7+VLrXA+iOVFGX/DYhM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300118

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch ipa client driver over to generic PAS TZ APIs. Generic PAS TZ
> service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Reviewed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/net/ipa/Kconfig    |  2 +-
>  drivers/net/ipa/ipa_main.c | 13 ++++++++-----
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
> index 01d219d3760c..a9aff1b7977d 100644
> --- a/drivers/net/ipa/Kconfig
> +++ b/drivers/net/ipa/Kconfig
> @@ -6,7 +6,7 @@ config QCOM_IPA
>  	depends on QCOM_RPROC_COMMON || (QCOM_RPROC_COMMON=n && COMPILE_TEST)
>  	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
>  	select QCOM_MDT_LOADER
> -	select QCOM_SCM
> +	select QCOM_PAS

"meh" for the reasons stated on rproc patches

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

