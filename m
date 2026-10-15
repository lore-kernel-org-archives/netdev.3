Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D57549F13C
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048508; cv=none; b=qStAwy5TZyzZCBUmOQtbeY0seJ5bG8f/r3WQrk65ysqOB9L3B+CckOAde9lwEPGvccta/nnAvEL7Ae4xZNuOaaXC4SUcr7F4SYS0RJmaqFPZ4tHo4L9ZRgPckbhxtd3vSvKSvCX/AR0jDT4i3m4DPJbUtmQvbT6OQ4b7AXlbzP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048508; c=relaxed/simple;
	bh=NTYhrykTWtTBp9V+M4bLcII7SFmdACoA2QijUmOeDlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ra6LCErDbX5xcu0bRF0RKfFvJk1tWfQyaVt/W8kBW/pBWZJD653OZRVMSJEe+LL22SWhCKW9YjLPeggSH7W/vqNKsI2RsbV2m+Krfst8eCJsphPXem0qb97D3FsAQnjzERhi2tQJqJO40IXXRirtpKiWqBZJ78juHarNCZiNd6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gbLa2p3t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j8fAuNUP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gbLa2p3t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j8fAuNUP"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F3xZ3V2738642
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KeOD1A+VdtDO2QTZ6vSzekuRwWPEc6a77wmmq752bMs=; b=gbLa2p3tR0PkBx/H
	h0yrYWNT3kkBE2J1Db23/igRBTZRVn8k8s8scP5bWJ4KFX2qQz2TIsLbkSy98P2C
	MA8hCDJoXvjVMDD4Ckclhpx5DzerpfbX0mON+G2e25VUqZhLYLv7XlPLlHBOBUG/
	sjj+VKXVO1cE2kYPwzFvsBLO7IP21fbqLVKize0hRzRYmShSCvw8M++35dVUqG1d
	CjgJrpgLN9mb/UiB6A5/l1th91bu0mGLSfp1JRUvNUJCku3K+YkvEpuPIndYS5QQ
	JUanF3gBIOemujcUaYikbY1U1fB5uDr95rhGpga933xtkxJglHCSQ1znePghb2Rv
	FZ/MIg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqds8nnt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:14:55 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ab2395f104so1107593a91.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792048495; x=1792653295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KeOD1A+VdtDO2QTZ6vSzekuRwWPEc6a77wmmq752bMs=;
        b=j8fAuNUPaKxfo+Ae6vLk3px33SiS67719bABoMzYQQbyzNcHiit335FHJcKFotiZMH
         NF/4bK7Th2ljwtulcE8Q697Q7w4Wu1T1vrRmQNc/qM0xEBmqJFsKLRaw4mDtbgnjhISs
         I5Y/TgAHj95ESofFah8Ov5QlH1gKPllnIRzVTZkVV5qFLiJZ28pXrutx+QYk043SJEVb
         FRl2Nd2TXcsr2MY60F9YFfsVUlA2q2zu4w+WcrBGg2P5birc7nBMJH37jSGoHhGoCw76
         8Rg/QMjBnSprB7oMxXej+ecJbS7APqAgD6vaxAFUORoKEGjK89oNeG0yIoxpOUmscbWN
         EwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792048495; x=1792653295;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KeOD1A+VdtDO2QTZ6vSzekuRwWPEc6a77wmmq752bMs=;
        b=ELuG9zDacor7YdjHeTefe0veqMWegNxANpLQrxmcLVFliABUYuWkAU9bBCDfZNTg5D
         OfeBapzEP6cO4Zrz0yZslbx9v8RwoKC3fpYJK+sEwHgoYUx9CRfvNdxZSSY8uMtTLLQg
         uP+d0NDxEv0g4HqqTQgiUljhd/kBQ3Y9T6Ly1JovHRZBJABrzNx9K6SWMwlbYKOxpS/c
         JevZRTVQcjbkegx2KwKTzEzt9rZxI8wAu4gjGCS93rkCV1ZdtRHFfCl07sKx7AjF5i5J
         ld/dOw2A59yt+9AcgUUIwDExAWimyr2kcwNnr1C9JAvBl52AKLYqJ1rB3sbAJ5aZJ9nC
         twMQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7jHN02Ta3HfoSJCqSF7Mh76ZAg754fkDDEIM+M7lVduuVrvmllstaD5KLAeIQH+dU+Q1BHss=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBJ6KhgnuT/tMIE0gCNHDc6n5MKVlkq36mci7TFMjQcRlEOXqK
	Nw2ylPOlPq1CZ4TMiWf977UI4T7qBVQHMz9eyTP2wNSgxhqY/DKaciA1gjaVIekOzBb4ql34B1s
	Ph+xhpiXbdChb8RVrp0Uh4KTWPtLVBAtbjXBeTyQL/CE9QLclgklJ1mFNE7Q=
X-Gm-Gg: AYBFou147SZPEnq7jgKO1mbltlSt8iL9n+t0WDHJLxYNNJbcuTgL92U0nFLd9UvM5Zr
	4Rq62XKTeFqpAIllkXyHE72z4vXMLt/4cMXNv2yLjENBqK9C4jEtH9wbRkQcZcOLAYQNOfDrfy6
	2tk09lpkxpMEZwA/LtUmA5T14c8OZDadzz1HEiMHBtshYxVlBxmi2zqpwzI564ol1jSzAHwNaJZ
	rQPtMcXKY/Xu43ig1tcIrxdIiXCEvK7O3nN8m6CNOPPkctQyGKACsfejEw7icD7mnitGl8Vv8AE
	T/86J+eWWttLnRA/k+15okR9U7kPBBlUl8yJ5UpTySraZ8x3prrKB5GY0y5iJljy1yd90N4tSuR
	GtiBoJAHf2sMqoyevkmPiTua5sQs=
X-Received: by 2002:a17:90a:d006:b0:3a7:bf13:6007 with SMTP id 98e67ed59e1d1-3ab3a9128c8mr15605956a91.14.1792048494923;
        Thu, 15 Oct 2026 00:14:54 -0700 (PDT)
X-Received: by 2002:a17:90a:d006:b0:3a7:bf13:6007 with SMTP id 98e67ed59e1d1-3ab3a9128c8mr15605924a91.14.1792048494262;
        Thu, 15 Oct 2026 00:14:54 -0700 (PDT)
Received: from [10.217.216.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac944511c7sm3221300a91.10.2026.10.15.00.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 00:14:53 -0700 (PDT)
Message-ID: <84c2e489-05d0-4acd-a88c-ffbdcd111f67@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 12:44:43 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] pinctrl: qcom: Add gp_mn mux function for QCS8300,
 SA8775P and SC7280
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <20260602-pdm_clk_gp_mnd_v1-v1-3-1522662b6c53@oss.qualcomm.com>
 <a516c0e2-0ac4-44fc-99f1-ef8dd051fc18@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <a516c0e2-0ac4-44fc-99f1-ef8dd051fc18@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xLNm45GFCPOL_lhEq9ZVXTodWj-u1HEq
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad07d70 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=xfIMX-YVTLGOWNOYmacA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyOCBTYWx0ZWRfX+f5F3xPXuAzX
 Zuk+HGgsF2AaMOiRZTCOtFgqqaIHVKjj203UedbxRSIDCVEx5mNw2woHJowraMBAcdI2M3Ruu5p
 pfCHKTMIobj6rRFrYH4ao7WmpwzwdG/Lu6iVpK1SwKr/vz5/ys8sw8qLGwB+gAt1arF4RDzHJZ+
 mTLtTytxWfvtWh5AxLY64vDiDZN14VY967viSRIx4dUlVmgC2nyEAEScOYhSQM4i/TKl7IGgibm
 ajfjAPDNdCeymkx14AFBLz1IGiPzFnwWyS6jlNRhHGb92v2ge4Kgfl5+NJYvvwe701nGAR+/WFJ
 BKnYHo/laTT6hEljYNO1sRalQsztrrz6pXAsVz+HSsvjfcXT7wD5ybTDh+CcQBD9msrurI91OBt
 9KIxKpqkAxQDQUoZiV3pp5V1I2pvZbz2EHRl62rqF1NORUGZFD0tZZVeYm5JQw++UjvU5gQRd2t
 1yEVY0pDGNs6Y0ezxYQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyOCBTYWx0ZWRfX10I/KxZRut5G
 W2WPFe/nimhtmkgHMs8vPsVDd4aMyJ1Qxp5C5h4nhW7jJ+gSrVRCEIK1W/2+dRQHaEiXf+o51cm
 wxHLJsUt4c0C5QBpIjiueozZ6zgBVVE=
X-Proofpoint-GUID: xLNm45GFCPOL_lhEq9ZVXTodWj-u1HEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150028



On 6/9/2026 6:57 PM, Konrad Dybcio wrote:
> On 6/2/26 5:21 PM, Taniya Das wrote:
>> Add the gp_mn pin mux function to the TLMM pin controllers for the
>> QCS8300, SA8775P and SC7280 SoCs. This function exposes the GP M/N
>> divider clock output on a dedicated GPIO pin, allowing the clock signal
>> to be routed externally.
>>
>> - QCS8300: gpio32
>> - SA8775P: gpio35
>> - SC7280:  gpio60
> 
> With the changes split into separate commits for each platform:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


Sure, will take care.

-- 
Thanks,
Taniya Das

