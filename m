Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72692D47F1
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004462; cv=none; b=mKPcUTaPqRvEhbvPCzjFQJlPN3XycaUrFG0Ztp9ZpraOg/2kYACkWNHAoSoMv+OxhHvSg6c3lwQra6lwkamxUFuDp/dnw9HA1k7jI4aLblv5PdmolKMs39LqzJnY9eiGPffcFAD4AOhnjkBMWAOd1rmYWGxQhD80wEnzEoBMURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004462; c=relaxed/simple;
	bh=IHNui2Edtj7RfSDakzU/n/5qDlIVockIk2fUBsZ73XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeivmTs67PlyiTsttvflrq8pqbrwmNyuIlGXkY/l16Qcg25xpKxjcR4IKQjruMmnb/GKjzy0riAGmZQT/TsOF1U7JROghrlN3IPgXtNPyze7zRLUpxovlLmWHC32RQ6yy1/zPeyxjzNLZjkUzuG+do51+99cjoQ8CIzvivrcjKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QWkjTE5a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a87L15lU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QWkjTE5a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a87L15lU"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EHR8V6841906
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 19:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	voN+/DnSvNdqF9FDu+3qMGQaGXIMjzAKCkLlGWfn+W8=; b=QWkjTE5apijBfBE6
	nq2/otO/V/2ZLXOJPZ4IhjF77TvAVYeXfGJUTZijKqX1/2YBFj1G2Mwaeg4hRXaH
	oyrwWf8p3v6pXFMhsvyj77wSgTE2O8VB+tyvWIC3ekuA3HUMbUlu7/u3P6hKd+3F
	p7PXrJZc+LrUrH7gKmsP9L+8ZKTVmzSpwGBDBWZvY72qPo5b+6gcN/zQNCvVTLjc
	jaCu7CDfvNPy6WBQpi6MoeLZmnERpP+02zz7TmorU5QZsket1NbHfmbPEQ3/wPB3
	P4R1MgZVWBVuOsBEGzPLwEqvuQIVEVUBHlkO7IrlQoAbU+tLINl9aMQeiGAQ8E/9
	hBRu1w==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wrc1b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 19:00:50 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-143826c4a13so2710328c88.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792004449; x=1792609249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=voN+/DnSvNdqF9FDu+3qMGQaGXIMjzAKCkLlGWfn+W8=;
        b=a87L15lUm+E/OFFERlOR/ZyRstHSfj/AHyGqlzeGplaxj26f0VKvpqVXA4pj8a/lrZ
         G7xD2L/mkq12H02Q3JXfX2eBln2Wpz15p1HfM7AO5TPDfqG9v2SVjS3nUkK+8l1ZUlD+
         Ct7/hdUiiAi8Uie0r7krPgWxQmfWNxr10iWmt1ILeVcymUDuaPr+c1f5WaQpQYSbQ3EE
         dBGGLv4XxkWkB1A29LLcHb+rWFpMITpa60OfbFLHwp7lZdCzRawuME0Hk5WpuCKSUGEJ
         jU4iHTMNAxTmPHrU1XWU6vSAyWGuKIRc180HAL4ik0CugtIAzqYwSgKR4ZeXQyU7Nrtq
         dPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792004449; x=1792609249;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=voN+/DnSvNdqF9FDu+3qMGQaGXIMjzAKCkLlGWfn+W8=;
        b=IuKCwM9eu23FfuwPmBEJ5KKoIbrMkb4SDztxt3pucMP4yO6Y4nV5rt4ak1SBiIN2P3
         zxP/tjlv30pEV4dEjwpaKEoYLlaLDXo8GWrAb3SllicAFLeEIpPYM4URJOKIYFQX7Of6
         QcDbhSFR2S73oJBJMFSf/qesNA3ug8QUQYwoEXX16C91ks9rX3pSVv9gHnGGbFpcmSZp
         ieDA+dU7qclFHDQAf8L0N0zQ8SedhfuHLFP7AhLY3vmKPqM3mPZYp0fYXW6S6FhGL+8I
         SV9ilO6HyJKuq7w6Auki5u59GldMM9a8057nJ+q/OkbAS0MFcI82qrOmVIGX0faRzSpx
         aDew==
X-Forwarded-Encrypted: i=1; AKwUvByD/h5949/CB0oCTo46L2lxJgiiFLPQBZ+tGqNGl9t5VN9cTvBZE64g1YjwffihARghaJmuSeY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzUeUw7Xxfw2b8CZNhKZlj4WwB+WalhvAwD4CY/PMnkrUtgG1q
	bQonQEMN0nYJjvbeucKV4WWhogsTPIb4TsLFgQBzZjbbGwckDPKjptck0YOlHSv9UbGstltKAx/
	bg+ydLrXi+ehMetxyNWji8voRhidQsNOg5bZzFILexX6cP3bHfVzhn6sj1qaxox93VB0=
X-Gm-Gg: AYBFou3hZihzrSK7EgD3OuYRSOWPSYMxJPeEZxwv+3vHy29ag4MkZ5V4+JVShgK4uQB
	zPizTqzkV6TYClzT6c84YJpy16hiGPwksnDpEGYn9Lx9SbsNR3qrrU1ArP+yJQ5+T2sxaZrWmvy
	spiFm24V36eR3T5EtuyZU79q7GMRu+EshwIlgyCH62VysSgF6tT3AeqFvto8W9BBQ2PE2+o/ZFg
	ZYYdU78Zvl6qIl6yKCWSO/C0yj0Kkbf6LQLZTkfnZ352nSN5AzIA7MkWphujf6poD19rf3hxT9X
	ZyzMZfZq5C1NlmPJALJPU43abOflQ8OiMTJjxgS00KBLTITeJ7hEAs07hvKQjsVCYaKJrsCdndH
	x4Pw6zVDIzEhJ2YY5O9ohyDKD8Tct4JAYlbEUgMnSycXb4C6hXdDbWs6tsEbwKxY=
X-Received: by 2002:a05:7023:a47:10b0:14c:1f57:3e86 with SMTP id a92af1059eb24-16a5f5ddf6bmr21715183c88.47.1792004449097;
        Wed, 14 Oct 2026 12:00:49 -0700 (PDT)
X-Received: by 2002:a05:7023:a47:10b0:14c:1f57:3e86 with SMTP id a92af1059eb24-16a5f5ddf6bmr21715140c88.47.1792004448426;
        Wed, 14 Oct 2026 12:00:48 -0700 (PDT)
Received: from [10.71.40.138] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6f5csm47683131c88.11.2026.10.14.12.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 12:00:47 -0700 (PDT)
Message-ID: <ff4fac87-380d-410d-942a-a48edce70397@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 12:00:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: stmmac: dwxgmac2: enable L2 split header
 support
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hongmei Xu <hongmei.xu@oss.qualcomm.com>,
        Abhishek Chauhan <abhishek.chauhan@oss.qualcomm.com>,
        Sarosh Hasan <sarosh.hasan@oss.qualcomm.com>
References: <20261013192759.776537-1-sagar.cheluvegowda@oss.qualcomm.com>
 <as9XUbOfJazEQ4y5@lore-desk>
Content-Language: en-US
From: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
In-Reply-To: <as9XUbOfJazEQ4y5@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3NSBTYWx0ZWRfXy7A6dNtWYkos
 PqgweuHqZZkNSrdkP4e+sydvcyuBfDLhgs1Dro84g5D2UA0qw8dCIJPyogbKJx19HeEq1eOn3gJ
 7PrSMxnzC4vu5B6ARe8tH8yp88mfm4E=
X-Proofpoint-ORIG-GUID: AbPLlxw3yPovZA-0iCDKRTWPW1ubBdCH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3NSBTYWx0ZWRfX9JNo2rkuEVhA
 0WlhEiVD1McXJGSnovBFJY+Lekkat4pL2oVHOPvhhZ6y0FWzpEIKPykzxSsIGbcusmXRGoEcf2R
 kqWfx3aEL4PJ3LFyHhN4KR44zQqvRa3C6clxbS4OUloOZ5BaVMvz+jFhP0mt3IwYIUrc0Te6iih
 Zc6O+hpalZlD+d1bOlQUcDTCLg7v/NzyYzKLPxsApk4UX4NZM2DJiTnkWxGiqLVNVb5vQqNN5kZ
 bmE/hZXw7NbmhThsnxEEnzberOcjDAsZBhr41XgI0z2J2JxmuQyGwPt9VnhZ/tgb201UfxoSOwn
 +GBuPE9H0x4JRmPUFFtEd5dvdf431Nm2o3no4uH5bT5sNGnFclTeAjYeoeMnFDMSbOHuBU/PwkK
 xO4oGqa4O936Zq/oAz49vatjvQXy33L0rJxgO3AVBfOsI2Ils/g5DdzzkwCBnpRM9Nr1oxLYQc1
 QPgtrZtX3hucZsGj3vw==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6acfd162 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=uAmjrx48wFnj9rB13rsA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: AbPLlxw3yPovZA-0iCDKRTWPW1ubBdCH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140075


>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
>> index 6719ac6e395b..65ac5403ec58 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
>> @@ -292,8 +292,18 @@ static int dwxgmac2_get_rx_hash(struct dma_desc *p, u32 *hash,
>>  
>>  static void dwxgmac2_get_rx_header_len(struct dma_desc *p, unsigned int *len)
>>  {
>> -	if (le32_to_cpu(p->des3) & XGMAC_RDES3_L34T)
>> +	u32 rdes3 = le32_to_cpu(p->des3);
>> +
>> +	/* when FD=1 and LD=0, HL is RDES2[9:0] */
>> +	if (!(rdes3 & XGMAC_RDES3_LD)) {
>> +		*len = le32_to_cpu(p->des2) & XGMAC_RDES2_HL;
>> +		return;
>> +	}
>> +
>> +	if (rdes3 & XGMAC_RDES3_L34T)
> should we check FD=1 here? Since HL is not defined for the case {FD=0,LD=1},
> right?
>
>>  		*len = le32_to_cpu(p->des2) & XGMAC_RDES2_HL;
>> +	else if (rdes3 & XGMAC_RDES3_L2T)
>> +		*len = (le32_to_cpu(p->des2) & XGMAC_RDES2_NONIPHL) >> 2;
> same here.
>
> Regards,
> Lorenzo
>
Hi Lorenzo,

Thanks for the review. dwxgmac2_get_rx_header_len() is only called from stmmac_rx_buf1_len(),
after the sph_active && len early return, so with split header enabled it only runs on the
first descriptor (FD=1). I don't think an extra FD check is needed, but I can add one if you'd prefer.

Regards,
Sagar

