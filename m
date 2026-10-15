Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A6A4A3D2E
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048489; cv=none; b=t3GcOe0kzdFacaPmDZdONXfcSkFKj3ptSUf3EDkBdxXl5esWVADloyA69B5v+nemGFmN8WOE0doHlhkZxrpMKm0QTNxUzOvfpaMkUDbf5HrRWheJG6fApShHpJJIKWON0ZxWWwVyW+z2j3fTwnkQYflkzVxz3oHNhxZB1TFSoPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048489; c=relaxed/simple;
	bh=emkzokqcHGoSiNdf7/IR9GL/48zbZC4tKViItldNSFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUdZ0W0HHBSUnlTWeL41P5wR9C3l8elGzZiuwS1/codU2ZBoxL74VEW6lo4xgdOINFb9d8QylnlMYAI+7QlvoBiRedTltdth8V1RW1dGSuPH9dFPXu/lyuwcno0VWDJ3+cOF4UMDlKrjpa4qqbPMffLSaRSw3v4icmyarhbvyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HlN/egU/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c6GcvJYp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HlN/egU/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c6GcvJYp"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F7BXXb2121415
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YoScrv3WBuf5zalDmn8KP0h1kd8vXuQSoJFP/Cj3PYM=; b=HlN/egU/oUVq9xjv
	418nceLeDOEW5d0Sc/J40XwY0zVm0rtwt34JXdDJPw9Y+poJuMMWaMqY4fJt9Bz3
	/vG7RJjDjUGp3dUHBT0ZbTLVqD/D+/XPihQeoRPf1f6t4dhKcsUEMaBVDvEUBjH6
	DpvlYbFtEcjD192kykEzXtja/tIG6Th4ffzvJRab3lKcfVvKt8iRqdZqpaMyyiNC
	c4/WmqNfC04Oa2mu/5v0cK2nvceuODvBlG0KPopycLW/iIKyn14JKcqd/iWO6qHB
	kOwhIuV3FGGmYYLc8e18EPGJ+2o3UhSrBj8qF+tAriA6QTsx+q68lFsfDcmJPEGy
	3qcyCQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn1d4n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:14:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3548cdfd2fbso7503942eec.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 00:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792048478; x=1792653278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YoScrv3WBuf5zalDmn8KP0h1kd8vXuQSoJFP/Cj3PYM=;
        b=c6GcvJYpeETNrLkooEn1R34QJDAy/sORjSccB4ayPBLPDgAfnDV8XbMXnvFk/h3mxq
         IBLjzecaptaJVgP2slf+5J5JZ+35ZR6jmp3uhjmPsSVBp/S9uMDkJGNt7b4Uh7pUe6Hp
         RrrRyivl4YTHLeOsbiX1XJq7ureOJdPtcbEGc5lR70erLEJ+qcBemO1CGvFWcfKrlBeo
         G1CQ23EdeEbIJS8Rphpo9argyEUxWWU5ca9CFhxJ98oH5DNMtrFGyYbcHHD49KVmV4dt
         iJUtpbjzAdTQkfJebxoJo6puv9yKjTuvQnkIP3gGX29MW219hfUF6s/xqzXHzZpPaVex
         Ya1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792048478; x=1792653278;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YoScrv3WBuf5zalDmn8KP0h1kd8vXuQSoJFP/Cj3PYM=;
        b=tldORsWMwTryhtuSELf/kbYr0fFlRWkzIDe333YIv47Av5rxe38Dsn5DqhrvTrfE+p
         A2eGMV1Lk4RFnPoMXJ56Bb3ui/HZrTdxIO3JOTlHqunVVKeYG7H+zUyc+VBWSZDfoMf/
         R0qmoE6NmBYYBHpMlt2qLQ1c6py/7aZWTvPgzLKonuXb33kR/APAGct0Dx8Khs9yH51M
         /8Mb876nhC2MVUCvpeAzIcuAL9klI2JBkeYj6IarkLs4qSvf8lW0Bpgyr3hcUKB50V6d
         U3xmCUTTH3YDAO27rw3VNaLvBOAEenOX4JFicgK5mN4ioVCSHhLkB1E+PNFtPrVPHWXl
         ckHQ==
X-Forwarded-Encrypted: i=1; AKwUvBww6r1cEi+JxGkPxONidhhfPVmTDAeOvPCVDjfUqu7r4xxU3fXigJoTU7luBDWuD7EbE+vqldg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyxTOZ0f/EERNoCC2bWRyuVrrixzJqQWsAqXB1/y6DxAWiWTIm
	3jB6jFvGTgZLMYG5ji4q7875Ca0GEiYQHw2BJWY82i3FC+c+Afb81311Mjf+uOd/bjNzMvdfYvW
	45QPT3SAMHKkpI/w9eeXGGdZM1zKnIL4vXhIKuHIdniqV4GSySOKowOGWd/o=
X-Gm-Gg: AYBFou1zeYLlLklZ+ybGMgs63dn5e6E4su9xRhcYLKc8YuIeEewzUW3yhOh/MgTnaWt
	TTBF4MUiJs5N8i/NzRdVjYq0kUxYdXcJQ8LZ0CJ/9pQwh775oDQvD1RCjpXImxWGZXHBHFqlJq/
	TjD6bCA+i8K6HhhKhPksttttEZ3EcmReAlX0b4FK5UmMKD5h4YaEVnQ/UzdNK5h5SIC0eUvyzBQ
	X2QPJwmUHuXpREW3JeKmNwC5k034oY3RjAyzLKX8GGXdrAnG2SU0NNv/ro4/PAY9oCvaf8kursd
	bS4a5sY5BWMiwrgpfSjCnC7NvqXlD/id9x4FLNsy2aMMKcm6q5mLXv4zYozqJqTfoV4yN+VPFqB
	/WOk9Ln21zgZ6qDtbae5pcfklnPk=
X-Received: by 2002:a05:7301:fc08:b0:351:4d2d:af26 with SMTP id 5a478bee46e88-3537ddd6633mr23169998eec.2.1792048477847;
        Thu, 15 Oct 2026 00:14:37 -0700 (PDT)
X-Received: by 2002:a05:7301:fc08:b0:351:4d2d:af26 with SMTP id 5a478bee46e88-3537ddd6633mr23169964eec.2.1792048477221;
        Thu, 15 Oct 2026 00:14:37 -0700 (PDT)
Received: from [10.217.216.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35de709d928sm14059954eec.25.2026.10.15.00.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 00:14:36 -0700 (PDT)
Message-ID: <57eac8a5-9963-456a-916d-3c997acd15d7@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 12:44:28 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: Add GP M/N clock controller node
 for SA8775P and QCS8300
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, netdev@vger.kernel.org
References: <20260602-pdm_clk_gp_mnd_v1-v1-0-1522662b6c53@oss.qualcomm.com>
 <20260602-pdm_clk_gp_mnd_v1-v1-5-1522662b6c53@oss.qualcomm.com>
 <DJ3HSJ8UK5MN.3FWLDU8CG2J2R@fairphone.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <DJ3HSJ8UK5MN.3FWLDU8CG2J2R@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyOCBTYWx0ZWRfX68m+FsLJzUsx
 urJTtBqAJDdPofTcc8f4XBL2h/q06iKXDQniyIcHxUNiA8wrInJl1tShhteanFGwVpamu+moSNW
 plBK9WBlhlheSEbu6YH0Pf4w/tSkB8LDtOBs1OpC5R9TYPpt/UW6JrLMpKu4nVwwm5CS9Gh9ST0
 UHTwbMyg9Do22Ji6hPbLNJO6yu26X0b/LWG5Ea24RKXhaEIfAESFm9X+NHxIoTA2rqAC5x1CcR1
 LfvXuISOTP/sQpRY3acEdoAZC2DRb0v5oDqv+uQS8S0rDFqpIJsPwFSJONUElbV6zRqM1mjjDYO
 EgRx+ySos4gcKZ4qWqJsRyfWCqX+5CX5yyEAcLBL1H6U8wDQxOUCJv07h2wM1D3kt+o4asCc7tO
 GKTof0KglgVKIhM7QrCACFdvRKTHStUkbaEhskB9mJtG65JMWP0gssRy541wFhr4W2C3E9+vID+
 yDnBBhUj2umU2SvkCJQ==
X-Proofpoint-GUID: uHB-DCsGfgcxiBwpdps4jzjfc6nm6SLQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyOCBTYWx0ZWRfXy4DR3QYpALYY
 xso42LYWJnKrzE5eZ+Rc1RyvdDMfa6BtwREkF+LHOBC/E/GOopE72s846ccjEcHW6zrUcEp1xRf
 7x7YxH5biNvMKJwB41mL8wdHNNWJWdg=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad07d5e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=yyOccef8O3uynvDP9xEA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: uHB-DCsGfgcxiBwpdps4jzjfc6nm6SLQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150028



On 6/8/2026 1:03 PM, Luca Weiss wrote:
>> Add the GP M/N divider clock controller node at 0x088d3000 to the
>> SA8775P (kodiak, lemans) and QCS8300 (monaco) SoC device trees.
> forgot this in the previous email, another kodiak==sc7280
> 

Yeah I missed the name.

-- 
Thanks,
Taniya Das

