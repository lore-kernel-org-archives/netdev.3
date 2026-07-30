Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D8403AF8
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409145; cv=none; b=T/fouxkacZ6KbRSbbbJa8xL58Mlzvl+Kb+nOurc1ssy10FBrzw9aGZkuypcc+SzwNNeLd8rulyT9x16lEbU4TadVgB9EB9IE8Xr1ns3UxghZc7QEvOUB2a9cZB9yzWrmwz3yU5scBYC023tfP4UsgmPpXBPVg7T67i4Flx2zXfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409145; c=relaxed/simple;
	bh=IlR0H9+SlG9P5g6Vqx0YNOsYeeXosbjupRt+YlFtkiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edAyZiw190QrvDCEwmCCsyOwsRj5ivKSpVgKs1ycWRt8WrMIWduREtxDeC1L3wBofYS4/DSaMoBRnav6E9ZRaU9p69woyu+rXieMYlTvYDdfCqaWRgKai/b5btp+68+RVv8TuYlX22nFmj7hG7Xw9H4X/Um2dDjFKITo0WE3rSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jtixZeiH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xs1GrBIe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jtixZeiH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xs1GrBIe"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA2HPT288075
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zp8lw42EXOlwez2wJnomFrYBAsJerM17eoLuQHR6avI=; b=jtixZeiHcTfxacps
	P/PSsts6/tJifAkxWTPo+K9d9kbZA0mXRBgI0S4wI9Ts5r6hJQORPwghzOZId9Nq
	qbwzDbrAbUWF3FadpBmE8LkGvmqeg/N+ywlFqqJ1uacmDukFSaofiaD9kwiTBL80
	4ScL9pCH8hzlLEkgGtF7/YjdEqd+1eo0/jZGVDcJqgGgtOITGoFiewN7v0Jh5Rs4
	lLYnlWUms4tbRRTYJBh9zsaHwy1lGWF3DUjusq1huVPRUqOOxYXLx+rJUc1COdMI
	aPX19VdvuiaqakDZZWO2VzmTmWX5rh5mtdsutn5gRZHj1MIBQ3Pfbt33L6SAcppp
	BJ0www==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr3v38dwb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:59:02 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-847a00bcbd0so2534835b3a.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785409142; x=1786013942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zp8lw42EXOlwez2wJnomFrYBAsJerM17eoLuQHR6avI=;
        b=Xs1GrBIe4Aw+0dCw4V7IzYfDunNvhKqWexfkx05/vgFOl/8M0LK0O8TA+TSUTNw7jM
         9NG3QHM+3S25T47Ku0ZfbYAneW+dYwK+743x5X/NJzwHXCrEy3Tb/mbCjgEVYq1cf4bJ
         fTrRNAHVHK35OFnMaA5FHjcFk6I9MBF9iY64GOn2vlJ8tfhpoPS35cDdIp4h+O+2AUBW
         uJTt+KQqLOGuEcrsXxwXpHZXR86bQxrr0GgZ9pA7nZCynb3ISxGYgwC92Yqk1aY80TLP
         3i4loDnLTIHiL4jlFQ1bhXz2ElfFzB9WiAOxAalpCeOdhIFfvhyiyHFQVC0KyW3K558t
         T39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785409142; x=1786013942;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zp8lw42EXOlwez2wJnomFrYBAsJerM17eoLuQHR6avI=;
        b=scZj6V4LWavr5DCzxGQK/l91RzP1eMHmnl47GXrWQVZGBBTn+Maw7tEgiB3Wk1uEVZ
         x4Wy/CxdCZGiedWjuAlZsYbM2OKwysdruVnY6uVFCjHEKb7UnNEafRQuOxq0lqm6FqDe
         EPBzI8u7odYdkSH6WFRPVmhmc0zIAZuQ1v4kcuUAnZlKmT9BxINz7pOKbPkn4sw5cU3A
         Rtd/Io3VkJ6XCAVXNhQIVNhLkIyWnCwbdkhiok+y2qfbHq52toJFyBXiFmLs32F+tQxs
         hSQLrfZbi537W6PgA6hw89KLDqXkSUWyNhCnwpZChB+PZD1dFHkmS473kwpobCXdZAzh
         xSiw==
X-Forwarded-Encrypted: i=1; AHgh+RpAIeTtxEn74TbrsWaZrjQ9mTK4RQTT8hjx+OZLQ68y5yiGdWRYWL+hBLxmXOKhLbrMbn8xfqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1LTrtFw4/0vztk7bYykitPpMNIZucI98OLSxr3HKFgQP8VJgK
	2PUhcDODiS/6vKsCwyZAuDYhAQQOq2ICHR+rKkbL+fCQpOmJW51ihFRt/eLSWT3Jdr9VUF4DI14
	ZbK5gf71UNDodFZixg7IzpA5Uvgd9449Dc1Pw5A7kckoBzv3sJKhYI8H9C4k=
X-Gm-Gg: AR+sD113cAx+KSh6kUBrRN5QuBtwxdZTjWefxoXCGeL7qmK0AI8n402+aSqKpZVFlkr
	wVfoNm7ErzGDyvICZlghgw70AOMrLeXR6pLuQw8DHGWSjT989VqYVAsT3auJe8EOqFQTy+3bGz6
	onZva2Bb/aKlNreJIXws/fJ51VZ7lXpGa/bV2CFXZE6Td3p6Gl0OKMRzMmK/yALq85jzmfLysjo
	huHMt50mNT7Rv2XNOskPvb/rvZgTwtcN+d49IDPdy4Z6FbRy5KzEpMGI2kHMXb7jiduXM2DVScz
	ikfB+7nR8et8Nyb0agnTpqM40qVWjhtg1k99T9IrDDc6jPqYNNBjsq9S3MLQ6+zDg6UudxRKSvT
	xdXCBEZhjtFYu5lSEMVxnI10yuSE=
X-Received: by 2002:a05:6a00:cc9:b0:848:3e74:85eb with SMTP id d2e1a72fcca58-84ebc1f5cbfmr2260634b3a.1.1785409142357;
        Thu, 30 Jul 2026 03:59:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:cc9:b0:848:3e74:85eb with SMTP id d2e1a72fcca58-84ebc1f5cbfmr2260608b3a.1.1785409141911;
        Thu, 30 Jul 2026 03:59:01 -0700 (PDT)
Received: from [10.218.5.114] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03d0675sm2892952b3a.61.2026.07.30.03.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 03:59:01 -0700 (PDT)
Message-ID: <a1894c1e-6e32-42a7-91c4-720e2634b1de@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 16:28:54 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] ptp: qcom: Add PTP driver for the Qualcomm TSC
 hardware
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260727-tscss-v1-0-beed14e72510@oss.qualcomm.com>
 <20260727-tscss-v1-3-beed14e72510@oss.qualcomm.com>
 <c2a7c6fe-60bb-49b7-b877-20fbf948b5de@kernel.org>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <c2a7c6fe-60bb-49b7-b877-20fbf948b5de@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: m9_qxYAExuEQW1pb9I0au9I-tn1JXI06
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4MSBTYWx0ZWRfXwKwy8NSl2cus
 YbgAUvxSaav9KHNQS49j7b9MhMYlYrC77TMmWeNNaHXmtWvGpUDswYtjgadDgBnmQxqOLAwEILT
 h7Tm1kwZOPsd8nabJEfqoLrJDUdnBW8=
X-Authority-Analysis: v=2.4 cv=bZlbluPB c=1 sm=1 tr=0 ts=6a6b2e76 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=d1WRJkdEJf9Lhp5XSbkA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4MSBTYWx0ZWRfXxGJjdEOI5hlR
 e/Jiys03JPBVvY5A0mSgowW9axX2sVxabps2muTJP0WCnb55i4/S24M4gGFzKKBi1bC0veq34Uz
 /2pQf6rasyONZ0YtuaqNqqKyPhoiX5mvfzycFowa7kcm7DDWOVLizFu4THwvlwxz8+3F0cPJpw5
 27IXgNgBhm/+BCby12xc3bkIQKobuPaoe9BRcnPTYt+BJ2rzcN7fdGWS6NzE3HwifW6yrhWgep6
 Wqlogxeur6kcATZnMpjDpFJnKHoDRzaveamraQd4m1ycUIg3wj6LXJIYuRqrbmcUXAvVVTiqUrI
 qvY8GuHOYhEOSmv6OKjyGDHPRfhmS4to0E9liJpy8s23SSnzpAp4uekyuavYIWzd54/GFS39vEN
 s7rwyW6Icqbzbszo90mFHWVOeOS+n2BT4cJPdu1Fa/a2dTwCBdx9rjqB1fp1zILUPJFa3UB0fke
 FmIT2QVQFnuzwXOy3Dg==
X-Proofpoint-GUID: m9_qxYAExuEQW1pb9I0au9I-tn1JXI06
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300081



On 27-07-2026 09:23 pm, Krzysztof Kozlowski wrote:
> On 27/07/2026 16:10, Imran Shaik wrote:
>> Add a PTP Hardware Clock driver for the Qualcomm Timestamp Counter (TSC)
>> hardware found on Qualcomm Lemans and QDU1000 SoCs. The TSC is a free
>> running hardware counter used for time synchronization, clocked by an AHB
>> configuration clock and a global counter clock, with the counter resolution
>> varying across SoCs.
>>
>> Co-developed-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
>> ---
>>   drivers/ptp/Kconfig        |  10 ++
>>   drivers/ptp/Makefile       |   1 +
>>   drivers/ptp/ptp_qcom_tsc.c | 413 +++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 424 insertions(+)
>>
>> diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
>> index b93640ca08b7286fd4298519a17d1daf19056498..d3ceb1ee01a505cdd0bd056649d245308fc9f140 100644
>> --- a/drivers/ptp/Kconfig
>> +++ b/drivers/ptp/Kconfig
>> @@ -263,4 +263,14 @@ config PTP_NETC_V4_TIMER
>>   	  synchronization. It also supports periodic output signal (e.g. PPS)
>>   	  and external trigger timestamping.
>>   
>> +config PTP_QCOM_TSC
>> +	tristate "Qualcomm TSC as PTP clock"
> 
> Missing depensd on ARCH_QCOM
> 

Will fix it in the next series.

>> +	depends on COMMON_CLK && PTP_1588_CLOCK
>> +	help
>> +	  This driver adds support for using the Qualcomm Timestamp Counter
>> +	  Subsystem (TSCSS) as a PTP clock.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called ptp_qcom_tsc.
>> +
>>   endmenu
> 
> ...
> 
>> +
>> +static const struct of_device_id qcom_tsc_of_match[] = {
>> +	{ .compatible = "qcom,lemans-tscss", .data = &qcom_tsc_lemans },
>> +	{ .compatible = "qcom,qdu1000-tscss", .data = &qcom_tsc_qdu1000 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, qcom_tsc_of_match);
>> +
>> +static void qcom_ptp_tsc_remove(struct platform_device *pdev)
> 
> Completely broken order of ID table, remove() and probe(). Remove ALWAYS
> follows probe. Table is next to them. Please look at other drivers.
> 

Sure, will correct the order in the next series.

>> +{
>> +	struct qcom_tsc *tsc = platform_get_drvdata(pdev);
>> +
>> +	if (tsc && tsc->ptp) {
>> +		ptp_clock_unregister(tsc->ptp);
>> +		tsc->ptp = NULL;
>> +	}
>> +}
>> +
>> +static int qcom_ptp_tsc_probe(struct platform_device *pdev)
>> +{
>> +	const struct qcom_tsc_soc_data *soc;
>> +	struct qcom_tsc *tsc;
>> +	struct resource *r_mem;
>> +	int ret;
>> +
>> +	soc = of_device_get_match_data(&pdev->dev);
>> +	if (!soc)
>> +		return -ENODEV;
>> +
>> +	tsc = devm_kzalloc(&pdev->dev, sizeof(*tsc), GFP_KERNEL);
>> +	if (!tsc)
>> +		return -ENOMEM;
>> +
>> +	tsc->dev = &pdev->dev;
>> +	tsc->soc = soc;
>> +
>> +	ret = devm_mutex_init(&pdev->dev, &tsc->lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	r_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "tsc");
>> +	if (!r_mem) {
>> +		dev_err(&pdev->dev, "no IO resource defined\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	tsc->base = devm_ioremap_resource(&pdev->dev, r_mem);
>> +	if (IS_ERR(tsc->base))
>> +		return PTR_ERR(tsc->base);
>> +
>> +	tsc->ahb_clk = devm_clk_get_enabled(&pdev->dev, "ahb");
>> +	if (IS_ERR(tsc->ahb_clk))
>> +		return PTR_ERR(tsc->ahb_clk);
>> +
>> +	tsc->cntr_clk = devm_clk_get_enabled(&pdev->dev, "cntr");
>> +	if (IS_ERR(tsc->cntr_clk))
>> +		return PTR_ERR(tsc->cntr_clk);
>> +
>> +	/* ETU clock is optional, only required when the ETU block is used */
>> +	tsc->etu_clk = devm_clk_get_optional_enabled(&pdev->dev, "etu");
>> +	if (IS_ERR(tsc->etu_clk))
>> +		return PTR_ERR(tsc->etu_clk);
>> +
>> +	tsc->ptp_info = qcom_ptp_info;
>> +
>> +	tsc->ptp = ptp_clock_register(&tsc->ptp_info, &pdev->dev);
>> +	if (IS_ERR(tsc->ptp)) {
>> +		ret = PTR_ERR(tsc->ptp);
>> +		dev_err(&pdev->dev, "Failed to register ptp clock\n");
>> +		return ret;
> 
> Why aren't you using dev_err_probe?
> 

Sure, will use the dev_err_probe in the next series.

Thanks,
Imran

>> +	}
>> +
>> +	platform_set_drvdata(pdev, tsc);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver qcom_ptp_tsc_driver = {
>> +	.probe  = qcom_ptp_tsc_probe,
>> +	.remove = qcom_ptp_tsc_remove,
>> +	.driver = {
>> +		.name = "qcom_ptp_tsc",
>> +		.of_match_table = qcom_tsc_of_match,
>> +	},
>> +};
>> +module_platform_driver(qcom_ptp_tsc_driver);
>> +
>> +MODULE_DESCRIPTION("PTP QCOM TSC driver");
>> +MODULE_LICENSE("GPL");
>>
> 
> 
> Best regards,
> Krzysztof

