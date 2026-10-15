Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325854AA1C4
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048550; cv=none; b=CYh0B3r5o6MfpJffaYzohgsaTSen2gC69HszIvtg+UkUCbob0vjzTbV+EAXGVW2ZVuw4Mk0Vm2Au3Ctd9pjYscS3Dnpz1QqFMu5adPxi3fa5qiP4jzB+Qjm7IAiEQbQM00vM62X10NFc8UvHWan8UdWcf3q/NkANaUVbqi2mcak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048550; c=relaxed/simple;
	bh=/wSh3zJmkx6TtnnckwzhBMdBXjxjl8xQdGNCsjICl+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAfUhftRFpUBUlcEJdF3WItI6uzaoTezNqTR2J4qGia7pCimWRvKSMt3+vWK5J1iWN7Tv3OSsHjJaomqNUyxzIIZqwl/Byc5B62lLU+xBAiq34BGSovhhXLAqOe93ab/RdGQQQkh+G3UjsVsd7HlRRrDrxVprzWqkb9fwDoxBy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K2ruZgF8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ck8rdLfu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K2ruZgF8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ck8rdLfu"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F3x7fl1640157
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	37uRL9c9rOSmwS/mEtP7cPrnXUUGMopoQZo9iRjCIoQ=; b=K2ruZgF8J3jtYrUE
	17ObGhOSjwoqNxY0Yc2lqTcT/po7C09qq2p71Ngob6oZfVfXv8foF/tYbeJCwV66
	8ktL1L2KQ4Fy8NRbBjRgVVESMl/4yqr77X8EKp5x2oRt7/c5abPbmTRfo1fkUQFx
	ZYVp76OR4KP4WjzcRWLrKssiKjT8+n2YROgH5NU3Dt/MAWgr4agHSPUGf50RFs38
	uEr2aY1vQmaaukYknt6OqNeW2ivQMeqMV7Eq+He61Q+gYL0IvqrPv1FSViyu7JRR
	mBfv4QlZlKUimDrjzpcFjLu7zQYPLSe8vRv93OV3f0+rXue3pLDNqCTMW/mOdIKQ
	R+6Pkg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhgq6t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:15:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3aaee1fc104so7116706a91.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 00:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792048534; x=1792653334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=37uRL9c9rOSmwS/mEtP7cPrnXUUGMopoQZo9iRjCIoQ=;
        b=Ck8rdLfuQmvBCBqr5jy+9Uz4eoDWwrAAsRYwuCykHSZxgeFauis4BmLxZu1iq+VCRr
         n5mVKJ0mHO47I5KdAOfCHGZRYcm1AxH1cXYq2ioGU27lyG1DNkW3NIjpTsRIHeJD4l6U
         48UtPrgJTo0U92QWVv7w3oyaAKhtTZAiKi+lx5RRToE8KmjCB8x2gJGbe1RDtlRSkhx3
         5nT51stlY+NfAaedyRHrV4JJ/GH/aTUGZDjLDhyPr6RtLFEIUKk3KS/rFKs03+Wa6Db+
         r4dr87lo92ys/oJPCwRi53VaAu9Nz5OHFwJuiF/c2QRH+GvqOIfIul7P6g9499xhjIq6
         DYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792048534; x=1792653334;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=37uRL9c9rOSmwS/mEtP7cPrnXUUGMopoQZo9iRjCIoQ=;
        b=t6RSQVns/bkz451Ph5H3n8eZfMfNBC7atA/U149QhD54d3pJ2+x4OIE1sJqpelST11
         CLEB4lwYazLC+61H7SY4R7HwcuHLk1SxtbaEiqw8I9Z5xvuNHyHE11KvUv9u9t8TpvV/
         V6XQ+AiEqzEOVK7Vx+uhW/1i/IIwnFXudiePLwvXtvGPcFIqCTJomH4mTTVCicQDek4W
         WKFma46fo2KG2ZZwZwhDldaAjtR9/a0PcW0UclfXTQq5QfksF/LSajk0jbglbxbtmoh8
         U6O5ycVymM3nc18VPO5JsPKvdqSOzUUO/pjRSIHjjFw7dtNKfCmyQKFoeqcRayHMNB1+
         mm3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwYqeGCXN5oBqfnz6VhBPyIORwpnUU7jqepw97xhxmsxpxGZ1ui7sdEN5qpHR7Df9+3lgKqVMo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOgmg1DS9EBInMCCxbQ6Vwi83BFRSTZmvEU09tpGjpuVHbJeRb
	qboN/dpSabtdBIcKCpCLFEQjZnNcBSeBYX+ZU5gHsLE6uvt+HUSUylGyRDlu40C10yiyPUH/1HX
	rRBcyvUP2yUgOs4cqoWJvOW8EA1NqNfqTKVOLxTmnlj3oa4RnyHdywJzzRQI=
X-Gm-Gg: AYBFou2prJVWqYe2YcM3C1Zgla8wHrFuVFL/xiCMfghKtdltvcSqB8EdCOTNiqCHMYr
	b9CTqgYgJfCgm+MBsSDV7gmt9RaFAI0iCTn+N2e5TIy3PgTukLmBxK6cBrkXv+LRExwgDAe70T+
	dzULAhZWRBzyfVYyoOy89blKkNpWO6XgOHuAMtrlRp1gtxlk2Ryw7fUQwkJP2nPEKVz4jSacZwZ
	fcKdq4JBjzVydXtEgMxrUQ5BN17G7PzUgQWnKTtfwRQfCIxc7TTU2yXCmeJE6upeF4XWsZiYMOi
	7fpcuP/m1OyCzjb9FTf6yp3khSBHIfM3rc/eflN0Sx6OJmT2k5aBRlgYsaTFI07in4ApOuj8l70
	K/bcesnh3HxLMhDYSHHrel6X7ajE=
X-Received: by 2002:a17:90b:3a48:b0:3a0:9640:803a with SMTP id 98e67ed59e1d1-3ab3a33db41mr16430154a91.5.1792048534132;
        Thu, 15 Oct 2026 00:15:34 -0700 (PDT)
X-Received: by 2002:a17:90b:3a48:b0:3a0:9640:803a with SMTP id 98e67ed59e1d1-3ab3a33db41mr16430141a91.5.1792048533687;
        Thu, 15 Oct 2026 00:15:33 -0700 (PDT)
Received: from [10.217.216.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac92a43d98sm1617534a91.0.2026.10.15.00.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 00:15:33 -0700 (PDT)
Message-ID: <a944b2e1-3985-452a-bcc6-8b16969a7392@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 12:45:23 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: clock: qcom: Add bindings for PDM GP_MN
 clock divider
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
 <20260602-pdm_clk_gp_mnd_v1-v1-1-1522662b6c53@oss.qualcomm.com>
 <03ec182f-b1a2-4ebe-8e48-9e88168f7694@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <03ec182f-b1a2-4ebe-8e48-9e88168f7694@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyOCBTYWx0ZWRfXzvtwaE1wnUmc
 BQ4ENfSgIvnSsBFOicaI3LfG2OEGXTQimLaROvL1hnpo1luRoAhvegPv5zEzq70KrvnZlaFDmwJ
 K3mEYBGdyNVyngcLfGl99Gc+Qlpb2KZEPpXHJZSStSasoVlJY9n4JKkAi3a114r7k/zD0cNJBEm
 J6lPp4rgg6IyNQMYaY8WDI2z67NCLaIqjJP/gFrtzhR/BppRxloE5TMfJmsuT4r7Foxq51mCALZ
 ABWCb4x33kIdmyX8DaVtd6iBBylfYMzGQArAWgvlYp1zd/AwBuKwEWtLJMv1Ix3DgstukwXvsiz
 arSrvseTanykt6rAHn8QiRRLmPP5Mb3NXErpCI9Z8KrjYcO7rpa1f/noBiK4hurM2e+Ni00CQ5Z
 BDTEFyQUBebEw/ETzp7bqGu9muZ/1UaL/BqWoWEcNvEoyM7XV3ZltFtJuBkOBL5/nNOmbp+jT0t
 hwoHxD1YyKjIYNtsWnQ==
X-Proofpoint-GUID: q51-8r29wvxj_19gVrlZeeDfebviCry2
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad07d96 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=PM9MLdjoRCq9o7e-zGMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyOCBTYWx0ZWRfX5822U3KwceWO
 diV3Bea1+lVzyHMiDE0oCVnSei/10+iOQKjDzOc7Wxx7wDiZEzOBdikMzyKaZAjtQae1+nHzbKl
 LPuNDq9NzN18bTHXD+YjGbW1Dn4TUXA=
X-Proofpoint-ORIG-GUID: q51-8r29wvxj_19gVrlZeeDfebviCry2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150028



On 6/9/2026 6:55 PM, Konrad Dybcio wrote:
> On 6/2/26 5:21 PM, Taniya Das wrote:
>> Add device tree bindings for the Qualcomm Peripheral Web's PDM GP_MN
>> clock divider. The hardware generates a fractional output frequency
>> from a fixed input clock (typically TCXO4) using the relation
>> Fout = Fin * (M / N), with duty cycle controlled by a separate D
>> register. The clock output is routed over a gpio controlled pin.
>>
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> ---
> 
> [...]
>> +  clock-output-names:
>> +    maxItems: 1
> 
> This should be deferred to the driver

Sure.

> 
>> +
>> +  pinctrl-0:
>> +    description: Pin configuration for the GP_MN output in the active state.
>> +
>> +  pinctrl-names:
>> +    items:
>> +      - const: active
> 
> I think these 2 are always allowed/defined

Sure, will remove them.

>> +
>> +  assigned-clocks:
>> +    maxItems: 1
>> +    description: Parent clock phandle used to set the input frequency.
>> +
>> +  assigned-clock-rates:
>> +    maxItems: 1
>> +    description: |
>> +      Rate for the parent clock in Hz.
>> +      Supported rates: 19200000, 9600000, 6400000, 4800000.
> 
> Likewise, we could simply set_rate on the GCC clock which is the
> parent of this one, via something like CLK_SET_RATE_PARENT


The GCC clock could be either at 19.2MHz, 9.6MHz, 6.4MHz, or
4.8MHz(consumer/customer use case dependent) and the output clock at
GP_MND can be a range of frequencies(which are not fixed).

    assigned-clock-rates
            |
            v
     bi_tcxo (19.2 MHz)
            |
            v
          CDIV (1, 2, 3, 4)
            |
            |
            v
      gcc_pdm_xo4_clk (CBC)
            |
 	    +----> 19.2 MHz
            +----> 9.6  MHz
            +----> 6.4  MHz
            +----> 4.8  MHz
            |
            v
         PDM GP_MND (Variable frequency range)

I missed one patch where I didn't add the CLK_SET_RATE_PARENT on the
gcc_pdm_xo4_clk and CDIV(additional) modelling.

-- 
Thanks,
Taniya Das

