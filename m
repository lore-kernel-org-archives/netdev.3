Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E714B29D264
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 01:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784942802; cv=none; b=bg8uVMfNyDOMfwUlK8/bvvqR7nnF/mGyQ/ALu5xrr+GVLg3Ck8k7oqOLa8T6MQW7qkoreOVbgdBpCFUKnTxsASzanJPev6TO+/frhGVe/jJf/RPF/Gf2gh8WOYg9YwmDvrXZBx60FQhN8winTLx597NheN0/Bl8ZbOfwEhc3yUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784942802; c=relaxed/simple;
	bh=64KUqgkYNU35EHXrXmG51HVSI9QiSbNGrczWOLMpfrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oow6EoE3CcmE7IEq90TzXFDtLZB5g9uLRX0dTTJ56mAp3mXg3yVA42+Ahx8kqTLT0xB78Al/PfI4wIbZHvAnyhntdO9metetJUdP3x85qBqT9y3G+yOVbr6m/OJnf80+9NZZruzpMWwU3FDXlRHV8yh/jFFknBLGjcDoTKvNXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BJ32zGX+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eAg2hCLP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BJ32zGX+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eAg2hCLP"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P0q7LJ630357
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 01:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	64KUqgkYNU35EHXrXmG51HVSI9QiSbNGrczWOLMpfrw=; b=BJ32zGX+j3pWgHVm
	M35gSjnZ1BuP0k4JJY2HrEbQfo2uAF0QgEgTc/DaK8TtnQaeFKH7Q08OpWzbogXm
	K8+6jkZaeXQ7eGZfJcv6ysUp9yIvv9HM/t0xSYHd6ZIgHummXA4WTfhZZMamX/AK
	9cOA3yfXVCULWjQHKXBYaIqyowAxkG+dtisloww86UIv0krE7ntoRkfssq4WOa1W
	yPdXlsmg9KTmiVZGQgo9fELIbk2x5svlccXudIkKBc7QvygX0tGWSyZT7VmTCGDR
	sTvoZ2/tj4OQsXljiWc3/GiRYFlbb/HCQwMm1fdi8oO13reFVqUSVP51QyQneJU7
	9lP1/g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8cf2kav-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 01:26:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb6f6a3f4so14457705ad.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 18:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784942799; x=1785547599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=64KUqgkYNU35EHXrXmG51HVSI9QiSbNGrczWOLMpfrw=;
        b=eAg2hCLPS6BlM9p4JlArjb14BQgQS+J3cWZ2zcDLn4jwxt3yolzMUD8yY6EWHi8qlt
         hd5qyWzVlpJQwcp+jxyrk+2Hdj78BNJ7lxAfOnZwHI3Fwp7kdmLD8a4neA6jHMqB2PXc
         nM7aXQpaXbsMLU6CSIL/iGNuQshcxNmiw3i+Gk+i5SyU4KdRWlaoTfQVRzo1hdXo9wBt
         d2rx6xm2ctSm+/K7DhGGQDShue5OtgFGZnEjJyYH1ag0dk+yNsFy4xXe0obXZEKAG49O
         L8RDm99Plc3pZuY3CFoKydGGdNHa3JLyQJqXVLjkjovofQTfMOyx8WG4gLh4lRjA+MkC
         GTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784942799; x=1785547599;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=64KUqgkYNU35EHXrXmG51HVSI9QiSbNGrczWOLMpfrw=;
        b=UNIdCUAmzNwgnpjUMzzhaIIUVgh/xmFIgirSiUjmtDbawc3gKSJsxBLDLmBL5MP344
         JqjUzq0IrY6jyG58XaNC5G1jaSUzmbqu6s/EuHlbYpuUnxsKgvTTVRl6rVyPMsoHySXp
         tLZ90we5nY3YPFqvNOO3VkflwuT+JPEOJ/yO0FBlkv57iPONaxgJCr0RAOBtJ4tg6jTO
         U6tt9ND8kVaMOlTNJ0RZ5ZfkR5bzNL3u33mMYNt/tq48kyLBxTB0NXsK0xCQGSV/KBUO
         hrhkgul3GH5/8faY7WEYiLnQNM0dVI82Uzg5ZRcko0V5ronqC3iXxC/BuOVvxFvyW+tW
         N26Q==
X-Forwarded-Encrypted: i=1; AHgh+RriGg1sptNdpnxC9lHsmN18dbVNGdvAOvQrGE6keJkLq27tb05R0Qush0/ghfBtJrANfqJIjrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylEOoyGx7A50wVRK9rmWSL/JtFBOn8hHFeW3ewo0vuqh6MmX3z
	Ar8179Kj9Tf40k7as8Y74aSwQohHyOCKEUKEheL80fm+7M5wfuk5KfZrTsYhnLrOBdqYEnTGy3w
	qzVjEzGyiSMg0Cyq2QvcOpA6nXsuku9KrF7HlzPW5pncPJ0H/ZUwYW3yTFkk=
X-Gm-Gg: AR+sD10dyoEAEipzsDNAG/FiADIaz89EQgSwh+xHTwN7nUH+Pstaj+pEY0Gf3q2Rv5P
	COKtwi9lpOmLbNoi5dHDrBMWTK/lqHyff3Yc6ije4FHu4F2LYeK+Drsk2sN12i9F2KVT/e+jUAt
	KUbiNmvRysXx9uSMbhwTrC4RJmoLZuzP+nWreVfbQqP0VCuxaOPZgOjdgWx6U4Grj3IovxgnKgB
	nnhyzOn2UBkuxU2rc3s2nmu26IGAnKGsmnw5FkMJ9IbZGE9i/CSL+0vZ20VHaNkU7gnsE19xwJg
	ead4rK+USFWlpLdKldzVGjEMGNLl94badRUTAYnjicx3v5cFl4ELtWtHp4Ih8WatlPd6tO6XOnL
	iSiq0xh1wZWZQU6Ry7tvORL3vxjk/JSlFejgsQ5JYxbFEs8SiNFaD/+ZYNw==
X-Received: by 2002:a17:902:cec3:b0:2ca:de3:15d7 with SMTP id d9443c01a7336-2cfd7175b32mr24890045ad.16.1784942799486;
        Fri, 24 Jul 2026 18:26:39 -0700 (PDT)
X-Received: by 2002:a17:902:cec3:b0:2ca:de3:15d7 with SMTP id d9443c01a7336-2cfd7175b32mr24889835ad.16.1784942799020;
        Fri, 24 Jul 2026 18:26:39 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc447f6bsm4309682eec.12.2026.07.24.18.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 18:26:38 -0700 (PDT)
Message-ID: <0f5b698c-6edf-4d8d-bc8b-a77af4be42dc@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 18:26:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: short description of GeoNetworking
To: Johannes Berg <johannes@sipsolutions.net>, Andrew Lunn <andrew@lunn.ch>,
        Simon Dietz <simon.dietz@plantwatch.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dietz23838@hs-ansbach.de,
        edumazet@google.com, kuniyu@google.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
References: <937e2942-3c0d-4583-a741-8a96c4e0bbc4@lunn.ch>
 <20260722213437.3593569-1-simon.dietz@plantwatch.de>
 <70e14ff7-fa2f-42a9-b880-a6adf5713c10@lunn.ch>
 <127c720f9ceeaac6ec3872bfc7732ab27d968dfc.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <127c720f9ceeaac6ec3872bfc7732ab27d968dfc.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDAxMSBTYWx0ZWRfX052r3fC+IfvB
 ZqJLyiS8UPEb2ZVMVqS0rTMxxXOtJ/ljQhjONlAgfH8arnVjKeF9EHlPlOIcAly/k7TKwtxNQze
 2tfi79hd1dL4ThpapT90JvL2+sEEjok=
X-Proofpoint-GUID: eEj4WX0A9l7w_r1HLWcVog9UBSFVbnu6
X-Proofpoint-ORIG-GUID: eEj4WX0A9l7w_r1HLWcVog9UBSFVbnu6
X-Authority-Analysis: v=2.4 cv=er/vCIpX c=1 sm=1 tr=0 ts=6a6410d0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=051a_SxtAkDqf0A2yPkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDAxMSBTYWx0ZWRfX0JkAOuV/R//A
 aUXzusZNi+mIrzGA1lUIamnGHG7c2EdmWFJT/L18m+4XE4NknAHHSN8euq9UYd8lcsc71RyxCzU
 Ef6H06INGy283zxiB/eiO5isfsBKliFj8990yal1a7r65L6/xWcg+ANzLaHhfRy8wcl7iRSvNRG
 baOTXhA+ykKsNH0o0ULGzlyYGy/wpfjo5vAWFVU9pRl+CjRUrYO+fmZnY3udVZ6plhfove3W+LS
 EXhRHpSpd8aJPPzKQUbry4F/9YfHO5i1T5ajYAMksrgfSZrakZSLjJJPtEumk67ojob1kfgsoGc
 39USsmt+mwTuC4X8E7+60oobxiqC5RNDB6xTwkl6p45c0Vay95JTRUfKBnG66zsUdXAs8DwuNTU
 cPspHXvYn3mfsJD049ZgwjnXkjqEAbtoLCPGMXrOUNcA01zt9fsnBa3FS9mHShunKn2lYg1L41T
 SnIFUOrSMaYsgldmkFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250011

On 7/23/2026 5:37 AM, Johannes Berg wrote:
> A bigger issue with this might be that it's clearly a small piece of a
> large overall puzzle - Simon, you mentioned a modified driver somewhere
> I think (can't find that mention right now), which may be using the OCB
> support in the stack, perhaps, but also isn't upstream.

The ath9k driver is patched per the information at:
https://gitlab.com/hpi-potsdam/osm/g5-on-linux/11p-on-linux

/jeff
