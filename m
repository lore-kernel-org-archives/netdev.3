Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F0E41D640
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061160; cv=none; b=iibpkuSN2Pc5HoaHEbG9IJgOQjI3TVH4dRHT/TrBZ1oNvL17fMKYclmMQf5u/ixko5WMsOQ4rLw1lIqEha2dbqEtaAvEvKg4UdO81qMeDvk3Ye8OTD893R/AEML5gQCkg0soS63pamPUy1E1H/AjtnDLMV/k8n8y+2ixSrCXY90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061160; c=relaxed/simple;
	bh=NA3boDKAwC1ACfxc+FiFlcJYSUIqrYD95FMKUqgjSd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drEU7SOhSz5c6PwRvwxr7GbFKJQVCOKZoS79rnEUOZnoynaYfoKtQo5ksXBpaD5e3BWAB6tjoLczUN1GXmiBoYGxWxJ655yqQ2ITBumlPrGP5fZqsKubWvW5ysj3f68Qa4hxM3ScKKMs5MMi4o2B6egxgq9r6lngle3eMChgdu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X95/FT3n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RmqR4Aw9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X95/FT3n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RmqR4Aw9"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FAPp5c4100543
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 10:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xVES5cjeJjK+Muq8ExAtlSTp+lSKmw1ZNAsjhYRd9pA=; b=X95/FT3nTlaY3tgc
	GlH612If7g2x9adSVaHJhD7mDqsj4m0QnJ/6UQXRIlEh0fDsf3zOyhkooZoCfTEm
	TZQFkL8HFIKpeMlFUg78hqtoB03InOn2j+GkPCzW3N7D9vN7X0NT5tC6AdkDDl3D
	210YS8tyR8qVFf9nzT+waR1Xwlr6BZa8FkuhAp/Qc9dwTvePisVvD+/vm1w8yte+
	xQllqj+EjBbPeQGApMcnCMn9Cn5pvpk0GXYZf6iNyZTthaw3UQoq4sy45FKhhfM2
	pYBFrVPctjNxeUKEdSkLD/xghyKuQfKrg2MGyHi0g/TTT1Kcv1enLfMdFkyoWfEG
	sPGcsQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2r82bf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 10:45:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e954d87b48so16872735ad.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 03:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792061154; x=1792665954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xVES5cjeJjK+Muq8ExAtlSTp+lSKmw1ZNAsjhYRd9pA=;
        b=RmqR4Aw9ICiHMlm7mV5wSi0Eky8M5+7gW73nlNgzOhP3in67oMcuuGQdDYgdNtQ1pb
         Hj5w3hfJEgHndSDOmYUKPQkiczUwJsjP3wAscAq344NqZIWvd7e5dC3NTsDibpdYgZVc
         GPun7fNBc6BqXBCVbESZjqA0hlnmvsBbqskm26bu8wxZEkh/Wb5unvI+0A9cI6n4UEMa
         Ay0VV9ITRTPtjPYjKMNGjoP85xIcPoRU3vS1nSBwZnkUdgRg8o9EVA58ywq5bGkNlM/X
         dr38XeYq8rCZTRZFr4ScpL/Myg6HHrjiNwTI9nVCR3zOyIIxT05dEvODZ2lYO9Y63Egf
         uHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792061154; x=1792665954;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xVES5cjeJjK+Muq8ExAtlSTp+lSKmw1ZNAsjhYRd9pA=;
        b=xdyZqpFa8H+C8KTQAv7xNk2gd6h33Hs6d9pp0kTxyMD71Gc01+l+oe/qnpnwKk4FV2
         cqWQN1TvLqGwKYdA23myTWWiT1HbUtX87w/tG6HeFgsyNoRSpOvrokkukQ3K4XVt0ynm
         JL8Uy7Mu0SUkETLFLRdQ7zKYlg7Pnk58vStD7fO1swPDFapy3DrNR7lD5mwkkjqv1Ub2
         o1ivw1ys6rK3omh9IaIUWLSbSFtlzsHWkBGWHA+ygC9gp18qzTBS5HuF537Ghxj6F3kL
         ilZ9fjsrStLWUPSZm8ki9qwmIcjcTArzjEiK0zn2HI75p+req3D/7QmK+FgVNDLQNajs
         Ys+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwXytIUSogSM7kK86jKMasO65ofXRuLFdgaJZSVqH8HDYrGioE2EtXFAw7CCO6ZzHYF22QBIQk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL906Vl0CrKeImSgKZBDVMTyj/cwl8Tf65vK2lHMIZ1cqCjxt8G
	kzaSDs1Ll36G6VcQZQ6pIXjM7rgt0l3dCiXXp8A3FqVQ6qD6i/6SDyf6pvIp7jTDGu56bAIRDFF
	BdkSof7pRhalItiPG8zcUKXfkQV/SPOS1yFzqx676T64/hgASFg/kNxJ5q2M=
X-Gm-Gg: AYBFou14+NURpfGKIIWMLVQrG7naJYa1YvGEmyze8jde353foHvAG1FSDEdnxW3CqEp
	YakcskiMBmQrQPSJnkD0GrDDzeG6MSIG7Af8DBfJ+Xq1TmTHrwYaUR5+kJJrl6OgtRoa4MXf/i2
	fIDeTZBGRfMKS5NqUgeLpf8yOCeTIq1pbWHqQr6dzu/WdcDYxG+5oL9hWkA22GCZoNl0u9NpqFS
	8AQWh1N9tD9dA3ROPY54zsUrjkpqTD7s1ou0MCd6LWLpdJNC8ugdShp0VG4WYwXwPb6wNYWE8GJ
	8GYgwYIYeDzkQ3PFltNwB5nuUtf10ktbCZhJc2EDq4amuAeG4Iq8TPHIJt3gj1toKIzxAR7snVC
	z2OUsRHgjjmyTF+G96VlB1To3pVc=
X-Received: by 2002:a17:902:cccc:b0:2df:7fe1:72b8 with SMTP id d9443c01a7336-2e8429a649bmr162354895ad.16.1792061153846;
        Thu, 15 Oct 2026 03:45:53 -0700 (PDT)
X-Received: by 2002:a17:902:cccc:b0:2df:7fe1:72b8 with SMTP id d9443c01a7336-2e8429a649bmr162354625ad.16.1792061153359;
        Thu, 15 Oct 2026 03:45:53 -0700 (PDT)
Received: from [10.217.216.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8acfa3b6csm55485005ad.41.2026.10.15.03.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 03:45:53 -0700 (PDT)
Message-ID: <5be485ec-7abb-40e1-9a62-aab90524de2d@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:15:40 +0530
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
 <DJ3HRRGJZN8F.3UNOV86ZOB47B@fairphone.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <DJ3HRRGJZN8F.3UNOV86ZOB47B@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfX87rcRnoLch2G
 vHGiMuHFfxBbDDt2B2deNnquMbkkctml3Z+nK39GDY0s9Xjkyoj2YqsplyXrBeT3tCkm+EYSJFt
 iFXFNW0c1lmAKNn0Y6pvCoOpnpizSTI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfX/xlL6IolEosc
 3aOj0ICuM0IjoKaRhg5yGr4eQkv3GmOivIMYf/KXt4OG0fy5qyOxWfJKWBW+yDvcw98Mx9oiing
 6r0FCCsnugak5f3+/NzgYOL0BBoO/kzXmzSvcVz8fTlQ2nw2z/8PWRLZhOlMv3Da87AvP09w1im
 g8OSQK4Vv04Ah7+j+NPX71le6AWIdniy3qk6HoyiSCFhVHe6Re1SDsiQowe+YIgrPL2bHOR5gpu
 ZI0Zj6KYxeybiUnQ47fyXBtf9NuZ4CErhr7jQyPPnTCl3opHy3ppjP53belwcdTH1tofCCy2I+8
 wuDf55/Y/IFIgVp6rtNHsQg2GrS/IJRq9fdwAb/SpmMrslR5A86EImt2c88IGcIKfxJXfUULXkJ
 3isVwLyvizJBbnRb5HExestjdD37quFPXi0vfg2gw3XI1iydwaqo3FMNjIQXAPtqD6HkHAQB58G
 7o7yz/zO0e/CiBW6RDg==
X-Authority-Analysis: v=2.4 cv=BNMmP1QG c=1 sm=1 tr=0 ts=6ad0aee2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=QRVzKC9bvf-Z0aX3qjUA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: u4KMjAQ2wKUG_rmFBnlkp3VWbXJXZg1b
X-Proofpoint-ORIG-GUID: u4KMjAQ2wKUG_rmFBnlkp3VWbXJXZg1b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150042



On 6/8/2026 1:02 PM, Luca Weiss wrote:
>> @@ -4412,6 +4412,20 @@ usb2_role_switch: endpoint {
>>  			};
>>  		};
>>  
>> +		gp_mn: clock-controller@88d3000 {
>> +			compatible = "qcom,clk-gp-mnd";
>> +			reg = <0x0 0x088d3000 0x0 0xc>;
>> +			clocks = <&gcc GCC_PDM_XO4_CLK>,
>> +				 <&gcc GCC_PDM_AHB_CLK>;
>> +			clock-names = "pdm_clk", "ahb_clk";
>> +			clock-output-names = "gp_mn_clk";
>> +			#clock-cells = <0>;
>> +			pinctrl-names = "active";
>> +			pinctrl-0 = <&gp_mn_active>;
>> +			assigned-clocks = <&gcc GCC_PDM_XO4_CLK>;
>> +			assigned-clock-rates = <4800000>;
>> +		};
> Am I missing something, or would this just configure gpio60 for all
> boards for this clock controller output? On QCM6490 Fairphone 5 this pin
> is connected to FP_3P3_EN, so it's definitely not unused.
> 
> Maybe disable them by default and let the board enable it, if it wants
> to make use of this clock?


yes I will keep it disabled and will let board enable them.

-- 
Thanks,
Taniya Das

