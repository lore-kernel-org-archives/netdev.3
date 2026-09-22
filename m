Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9FF577E22
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097267; cv=none; b=GI4akHj8ohKUHSmKh3AfZw9RxlgRUWncZ4TboCNnaLLnvnlH4fvnIfR+N0hwf0MrdbSFKd1JjiQcJxzQrk/WQSCH41wHCLNBRL8a/ZnfEV8h9N3LdugQjCTtuyp1ezZokB1gPyKg0ALPQunPb7H+aWrEqev4u9MPiVfneL8nAAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097267; c=relaxed/simple;
	bh=YoKdxzXqcxs8aDLJDgxMewiJDR0phHL0RqzGzKoDtbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ve6SYq4xYjFMPxD9NQn5+6IWXKHH7uypXxoMOSQBmVNCx7J38CeK/sg8Y3XWWmFC0f+yP1ocS3Xd890myBEFQS0Vdq8oBuRBwwTh9BXn0s1vfyhbaBvyOUaoIk4xEWkXDDqWiFL5bods3StAFMiTG3tPFDwn3tFK+zOIDhu5c/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SH+LZHyY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LTzBuDrQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SH+LZHyY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LTzBuDrQ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MEijS63924021
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YoKdxzXqcxs8aDLJDgxMewiJDR0phHL0RqzGzKoDtbA=; b=SH+LZHyYwm2EFfev
	dC5BCRUX03669BE8eC0oX2/hVQM7GGQdKVUNUdu4Itf5aHF9qQvWOX7MmQOwrZGg
	kWcnsZWveGgyMRCrEn2H8nN6mhJLWFQPRtULJLFNTYv1cSWibtySAPnLuuDosrK2
	WuJsH+sc9vYBtwbhj9SZDjxSCF4nMV1MYxKEGmRGckPPpNkjIjpzDsALZHYkyV4A
	Wi0miG0scxa/iKB0GevgxH2N8lUg9+pVqEZ1MI+zPx9gUdwdAbwL2ZWWDOoCZ8u8
	/779x+jpuN2xDyu7BTMFi1aVqBky7lF6RSzfZ/PAHroxEQ2nZzWlv/2Sj++WFsJf
	6Sha7g==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guuec0vg1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:14:25 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-980682ebf05so14358241.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790097264; x=1790702064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YoKdxzXqcxs8aDLJDgxMewiJDR0phHL0RqzGzKoDtbA=;
        b=LTzBuDrQM9/ievMqIR8scbOGzJHFlb+lxwB7lHQLh1ZWJPsvfFvSu5SL88NTZ6o8HA
         udd2wQkDXS5iFthPodSoo2T2xDzIEiHfM872GT6SgosVXXkcs/Ll9j/KnakDZ2Ro1Y1A
         Dg+/LzZmP9P5kjpijj4bdFyj3YXWjYaDJaIL5FWOMsHGam26/iMJuAK0iBTiATIy5OB2
         w6WZCLlEKIVaxRF/5puLsi/EchcJNmFh9YSLzUYW343/HrdWFiD7usLBf1m4poVJ9w9H
         8qKrYKHnjVyOya+IdLllNsy9iQ5LmXvo5KQ6867Tqwg/N4aVc+642gWu+hRwXwbrnGm4
         EC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097264; x=1790702064;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YoKdxzXqcxs8aDLJDgxMewiJDR0phHL0RqzGzKoDtbA=;
        b=BrJ5VrnV8ZVepZCmQUCky1hGUjZS1o4e7ojEacPoxvlg+PrWhFuVwVB94B8jcWDEVM
         zhIaMkzczqk6JZTjzaR+lDaosCKQTDqKr04IEjUYL4QRylrpzB82ch50xLNjuG9U+EvN
         aUeImPwADwKYaEv+jGJSWnoOampCcK6chAOhXQyOHEqfApY5QLXnFBT5oVtrjOYacSmj
         PGzpEsNB3weHJ6YheE+kjD7TVqxDWhEhHGMzv/8fC+IprgLrYyNx7A3T9avDX03WBMpc
         +VpAr1NHMKUM9w4ClI9yh9pm9gkblDtPvk4waBRQ2XVQ3PWGQb0vraMmVWRl6whZLyJ2
         PQSg==
X-Forwarded-Encrypted: i=1; AKwUvBy7Lby8tDiIxa1YquU0W7FRfSquMb7g6bgnZkm4MDtCw8LrfF+7BKW7hy0N7E/ZaPoMq39YQxQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kBTKiuw/HZVq5URzG6IBrMk5s+eOyV2VTQ88E9y1yv1jBN/Fya
	f/dhxT34K1pKesvgIN3bO8gmYx6yL8lFkYYAT8mqMKTuyGGU4b9IpFLez7lRCaSif0KMfKm48B5
	J9Ga9FxD2Q7T7FudZpCRyF5OnBP2W6eFVVAxT+YRkgp6BMKNg39+l6O2dS6/vTxOgsoUZdQ==
X-Gm-Gg: AYBFou2PwAXcopqBKWt4xI4une0RWHJvQsEIhS+1+WGZRBCasjS8Bq0Asd2/b8jvLzw
	Dh5rbcwJMegGoBng73CeuF5kl8ZRRclGeehv5/wFeYqZFS0BIkaxb78GRWY0t7d2Vi5mEmNi26u
	6AcwdohEVeMgwm+alplNfYVf3iSS7Q/mvWMTjscRK9iOQ6kI5IZoznLl6VJzQUhvjC8TFGQtXpw
	hUy0qsU/N6qTZthxBzG+rf8QiW7Y0/Q3+T8C2oE2x2+2fXr9b10rSx2FyD35q4pOwyTwXIY9OX9
	6xNEwdTWAAXaKpOjHZ6JKhj+Bwhar8mR9498ZR9c0saJ0h796NF6RrY1pM/UBD1U1uDheDktjxp
	yqvUFRUQRqpa974bVVbxMivdJdeOVWOLg2p6UWYg=
X-Received: by 2002:a05:6102:f85:b0:7a7:19aa:f0d1 with SMTP id ada2fe7eead31-7a719aaf773mr6957679137.30.1790097264218;
        Tue, 22 Sep 2026 10:14:24 -0700 (PDT)
X-Received: by 2002:a05:6102:f85:b0:7a7:19aa:f0d1 with SMTP id ada2fe7eead31-7a719aaf773mr6957615137.30.1790097263755;
        Tue, 22 Sep 2026 10:14:23 -0700 (PDT)
Received: from [10.243.142.186] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdaaf0074sm59131665e9.3.2026.09.22.10.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 10:14:23 -0700 (PDT)
Message-ID: <a16d507e-17f7-4074-8817-4b8da3a71c3b@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 18:14:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] net: qrtr: Assign unique node id for MHI endpoints
To: manivannan.sadhasivam@oss.qualcomm.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Lew <christopher.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>
References: <20260921-qrtr-multi-ep-v2-0-27dd80d841a0@oss.qualcomm.com>
 <20260921-qrtr-multi-ep-v2-2-27dd80d841a0@oss.qualcomm.com>
Content-Language: en-US
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
In-Reply-To: <20260921-qrtr-multi-ep-v2-2-27dd80d841a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1MiBTYWx0ZWRfX8/4cJJoGW3pR
 q1YEhUHoQOsliqkTgoQoeIxk+YbKSLUWo6faDUtJaglPMDRl3rVcbkLFUGfLPZAau1duV2z/QCh
 SPCKLSQHQP07oj3Sm1RFUFm6+62VBSiHHSwfLkq5JNSog8achLx+e++K3qROYxvifQRejUHA21h
 Njz+Szqev1IRdbSz4BAHSAZ9bHho0PqejP/kmr0aI32+UWWGdHdEyjs4Y02/dqDTthd7lb0VVYi
 8deGAUdJahbtZL0tl9EKqGdFYNhLTcWMZnNC9/gj89+tn7jfF7To1KIjQTSj+udp6qozzHULvTp
 IMYa6tIk5cNIF37lYgfq/BYmMFCXW801R6SxZLzybW6RUlPqcUN+wT0qr9oczx+ISkwJDeZ5/fq
 S5pX3+LDoNSo/zHX3jH6Lytb8LCEwlrZy+M5f7tVJE4dquUAjjtGl1YiZ7DKuyz+XHKkxUShcBV
 TKu3Z4r1F0ioEAuR5Dw==
X-Authority-Analysis: v=2.4 cv=VKdIDNPX c=1 sm=1 tr=0 ts=6ab2b771 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=ar2LfINMGabpzH7QhtgA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: 9PbCSNWggqD82-ui2UDAOp0TMzsWdhT1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1MiBTYWx0ZWRfXyEWobHkKlH0N
 e5JIZS12YiaLogxV8oanhneLpzJA83dGet2/IDLXKiFEiI2Ocr8r9nSaC+rp8UZVJwSLnaB69z7
 XDjU1evLYoPjyvD4BnPy3YaDovyrny4=
X-Proofpoint-ORIG-GUID: 9PbCSNWggqD82-ui2UDAOp0TMzsWdhT1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220252



On 9/21/2026 12:23 PM, Manivannan Sadhasivam via B4 Relay wrote:
> +
> +/* The offset is chosen carefully to not collide with the node ids allocated by
> + * the remote nodes. All the remote nodes use node ids in range 0 to 0xffff.
This assumption does not hold up for QRTR V1 headers where the node ids are 32bit.
QAIC devices use BHI_SERIALNUM as the node ID, and it is definitely larger than
0xFFFF.> + */
> +#define QRTR_NODE_HOST_BASE 0x10000u
>
Thanks,
Youssef
