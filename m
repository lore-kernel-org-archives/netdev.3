Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D1B4AA1EB
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048557; cv=none; b=P8W8MDcFLTB7ZfK0PXA14abgVJ6FDkWPWlZ8uF1ns14jOgGfoXZJcW0lzbDcfk8c3iaWR8VTiGT3ilVxAwFFVilq4AeSU3V0Z/oFy9mdgAt3nEPq6Y5gVP5scg24qG5nLWnSovLGaFNlRIa7faZIMEyhCj07C5iP0ZbNiJpd0wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048557; c=relaxed/simple;
	bh=vjC+BasSM2A5pqOKU4kst3CVWxdJ8H9DWDf0gHYFgJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uE9Gqee6hgMaG+9GN4piAmWVjs/BPZ9HGjqKg5dRWKq36ZclNHkYCi6SMz4tQveYu6aFyx+/4XWbY2OZS4Ie0+N6s3fKmOzjYOlrNMD/nP1YYnupvfrhHkjCnGK7z2z6WdjLsTPpW++fRzER2UA3/0KCDUK/kSsvPITdLaBtEC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xs0WUlmO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jirIuTnH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xs0WUlmO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jirIuTnH"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F1PnfY3468853
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YcL9Tn0lD7wDtND94KTiC4YZKyvPoN5Qhi+HsYjbYmQ=; b=Xs0WUlmOsjvUIFWm
	VGjcxKvZv+I1DWj4+mZpbWUfagOhDigL5ylhevrFn31lYSj0HV9NGxg+gKJF0gAi
	Pn6kCSzrDslJzpMItz2hxi3qXfs20wR7NT9YhjFv6mzs3oOvaY+eBKiU2iMH4RNx
	oZ5nBU+cWITt8NPaN0ciPBWmP9GeFz25yHRZWA7CMJWkhTO72W9cMCZvxzsq8Ut8
	ORjV7FXDdQpFHIOoQaP7YmFLYX4bLnPNV/pjLaKoE1464TPWqFLXVOso3NOnlLWq
	jsmpKzBfHpCGm51RAHfx8rO9U8D+/a2izpAtnyDNEAVyymmLQRtVHkXAyHPEIahg
	INctFw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd7ax51-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:15:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so2367965a91.3
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 00:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792048544; x=1792653344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YcL9Tn0lD7wDtND94KTiC4YZKyvPoN5Qhi+HsYjbYmQ=;
        b=jirIuTnHUksjcJ82dC1k+2LvN6jLQxqnJIGpEDyyS1xExEGWg6bw8KqG/Y2zYfpGo7
         ScYf+CJOW53lcoBcpOMicRCSOPlkvvCuxCr5b3Wsv6EKrLUv04Q1/ymd4yDQCTD3Iu8d
         DBjPgKdc0id8YKYDr7FAJGFaAwO3vketpNf1FLcNBxPN3NVBJvwpFS1joofuQIC3XmJg
         MNPCXAt0HrSkNYfDictiRtuHqRaJMgVnCDSX517U2HtLUEIxofTI7jj2qxJR3crlBDHZ
         L6qJ5ypdxmiXtyLXldMRILN3+ZHYOwwyNqWlCG7F/kIUAfScxH4XkCCGx+CxHHHajypm
         5F1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792048544; x=1792653344;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YcL9Tn0lD7wDtND94KTiC4YZKyvPoN5Qhi+HsYjbYmQ=;
        b=XTw2aITtWLMpd/Fjxsz8oRA2Cl70dQ1N7qldUD0kI3qUoBzJ357i56J1tRhvRd85FP
         Ts/HYnkgPiAmkj5XWQHBYDjRnTrXMozhSziF9m/TGE9wYQ1Ytkc/hT6VN6ox2Anf9Wjt
         4G9Oc7UeYY1JtdGffmjYaANHkpWuct+si+OFcYV5oP10dh4A0ToRQjrh/n0pIB5jjVWx
         FRJrd/8QG652uD3ZucgcGnYym2ObavAin6WgEmhVREeK1uQ7OAFq9pWjrT8uF2TdBkIa
         lbFgWY+sU7RuT8CrcXF5CCXRvVd/+pXIIJkrRu4livb0N07njVN6q8aKaKeUlVE5P+6N
         atEw==
X-Forwarded-Encrypted: i=1; AKwUvBzkiMdyGiWItHSTxv+tBmNigCIUsbwMWFiGpmDXXBgz/VIGOEEBsRuQd8/J8crJ+R4JMopHmQU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJ8FG8u8c3o4lONbo9+CdQAYBoOPFtBxiJHtNWTr7UTDiQ3pQz
	4iFZhiViekyySUvU+2FGYtJwc9AbtcjTPbb0UlQdwuy9drXJQQ+0DSBYIr3BG30aN0IHIWMRmPj
	WZyt07u7QckzlsZ1hdNJCRweUrP0U7u4HChSu73XPVSquD0BHU9iRUmXbZVQ=
X-Gm-Gg: AYBFou0d0mA9eiiraUEY7EFObBna8JYyx8nxL01JRTNPxpmUaNKgszQ2Dl3wXTNUhPq
	SzFjAk69Wcwbn1C1vq9YD64DDqy8NABkJozBNZoeKfuRo9Zg0vnpkU+Kgq7UkvaD12swEx4oYK6
	Hmv5F+oq0j9LHjlaId3FrDqcOBR9qkeEpv7NB9QXImnTAzVqGLhxXV3fqoUll0M987P7NAJKkDR
	pndBmUOF4Z9HuKvc0gcp9ofxB6vpHZGuqfld5thIjOaBwI6DA0jK5ZzYZ+WJTSRaPfGVIWTxhnQ
	pU+YX4oY2SDX5LmTsMPr5mG8Wg51+goXQrYHQ6GsJFiQ35rJHhv6JVczBqW4svuwY4Te1jbAbmh
	0dPvaGOXRJr7SsaN4ZnGC1TNKq5U=
X-Received: by 2002:a17:90b:1d52:b0:3aa:fc22:8ab1 with SMTP id 98e67ed59e1d1-3ab3a8a1ad5mr16246297a91.35.1792048544259;
        Thu, 15 Oct 2026 00:15:44 -0700 (PDT)
X-Received: by 2002:a17:90b:1d52:b0:3aa:fc22:8ab1 with SMTP id 98e67ed59e1d1-3ab3a8a1ad5mr16246267a91.35.1792048543623;
        Thu, 15 Oct 2026 00:15:43 -0700 (PDT)
Received: from [10.217.216.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac92a43d98sm1617534a91.0.2026.10.15.00.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 00:15:43 -0700 (PDT)
Message-ID: <0691ab2d-1ca5-4140-af77-05bbf718d205@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 12:45:37 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] clk: qcom: Add a driver for PDM GP_MN fractional
 clock divider
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, netdev@vger.kernel.org
References: <20260602-pdm_clk_gp_mnd_v1-v1-0-1522662b6c53@oss.qualcomm.com>
 <20260602-pdm_clk_gp_mnd_v1-v1-2-1522662b6c53@oss.qualcomm.com>
 <h7ai3qajk4yq2jgvy6etqpchxuxo56sxtvcgvh7xhodw6jkias@ayn2thdck4ct>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <h7ai3qajk4yq2jgvy6etqpchxuxo56sxtvcgvh7xhodw6jkias@ayn2thdck4ct>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6ad07da1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=a29RP2Si9AT6pp-L1QcA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: sJMT72g-6eqpbPn_iU1hCZSiJW_XW1GE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyOCBTYWx0ZWRfX8BhMq81we8Vg
 jwsoR4mb4rKGige7e7NdcP4VCyEiYnKSTMVG4nyhK8mX0oNtl68TfYNjUFp2zAuTwL10uGnrxR2
 /OYOoAyPrGUr3e9PIYwzCXq3aCjXTgR8ShSpeReUlIPnG4bwzQ5osi/WnuTmm+Pl26L8ZW8wht7
 lxQFyENhHam01QaKOM2iovmLK3d5NEPE5bK2DZkdM+AaXGp+/uHQNeh5o4bhpb8mWb7W7r3Ww/E
 XrX/QhfdFis9XXwGSF90rsORi06tjs+Jd6/Ezx9fdJZw042ZYmoCMnJNPGrfh4CGxvvSzHfunph
 578o8TUYNOP/jCboQegmQHe08lKRf9G/vgFkPnjpgtNNURmZxmiN0AxS0v3Yny99M8Z6+YlaEE3
 8QNDM6so+4P4vdW34z5QY+Nv6KqTHKX+ekHqL0Hvc7G3e80SkHCyUp4w50jcU0QW6mq9G/4dynH
 XeRejUZS8gw7yFGfDfA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyOCBTYWx0ZWRfXxBycDKRmWmYX
 xuPbzKkIp3/18Mz526z5GRb1FcNTvCjdvvgIioEAE4DZajKxduaNmb7cL90As3KQEL1OP6mQ8tN
 JhqrHACSpjW4Pu+g4W88zUihDAYfjrc=
X-Proofpoint-ORIG-GUID: sJMT72g-6eqpbPn_iU1hCZSiJW_XW1GE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150028



On 6/8/2026 9:01 AM, Dmitry Baryshkov wrote:
>> +static int gp_mnd_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>> +		unsigned long parent_rate)
>> +{
>> +	struct clk_gp_mnd *gp = to_clk_gp_mnd(hw);
>> +	unsigned long m = 0, n = 0;
>> +	unsigned int d_val, n_val;
>> +	int ret;
>> +
>> +	rational_best_approximation(rate, parent_rate,
>> +				    (unsigned long)GP_MND_MAX_M,
>> +				    (unsigned long)GP_MND_MAX_N,
>> +				    &m, &n);
>> +
>> +	if (!m || !n)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * When N = 2M + 1 the valid D range [M+1, M] is empty; no duty
>> +	 * cycle can satisfy M < D < (N - M).  Reject before touching hw.
>> +	 */
>> +	if (n == 2 * m + 1)
>> +		return -EINVAL;
>> +
>> +	ret = clk_prepare_enable(gp->pdm_ahb_clk);
> Can we use CLK_OPS_PARENT_ENABLE or pm_clk instead? Having to manually
> toggle the clock looks like a coomplete overkill.
> 

Sorry for the delayed response. Yes, I will model it as pm_clk.


>> +	if (ret)
>> +		return ret;
>> +
>> +
>> +	ret = of_property_read_string_index(dev->of_node,
>> +					    "clock-output-names", 0,
>> +					    &init.name);
> Do we need it? Can we generate the name instead?

Yes, I will generate the name.

> 
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "missing clock-output-names\n");
>> +
>> +	gp->hw.init = &init;
>> +
>> +	pin = devm_pinctrl_get(dev);
>> +	if (IS_ERR(pin))
>> +		return dev_err_probe(dev, PTR_ERR(pin), "missing pinctrl device\n");
>> +
>> +	pin_default_state = pinctrl_lookup_state(pin, "active");
>> +	if (IS_ERR(pin_default_state))
>> +		return dev_err_probe(dev, PTR_ERR(pin_default_state),
>> +				     "missing pinctrl default state\n");
> Isn't it done by default for you?
> 

Yeah, I will move it to default.

>> +
>> +	ret = pinctrl_select_state(pin, pin_default_state);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "failed to select pinctrl default state\n");
>> +
>> +	ret = devm_clk_hw_register(dev, &gp->hw);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "failed to register gp_mnd clock\n");
>> +
>> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &gp->hw);
>> +}
>> +
>> +static const struct of_device_id clk_gp_mnd_match_table[] = {
>> +	{ .compatible = "qcom,clk-gp-mnd" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, clk_gp_mnd_match_table);
>> +
>> +static struct platform_driver clk_gp_mnd_driver = {
>> +	.probe  = clk_gp_mnd_probe,
>> +	.driver = {
>> +		.name		= "qcom-clk-gp-mnd",
>> +		.of_match_table	= clk_gp_mnd_match_table,
>> +	},
>> +};
>> +module_platform_driver(clk_gp_mnd_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm PDM GP_MND clock divider driver");
>> +MODULE_LICENSE("GPL");

-- 
Thanks,
Taniya Das

