Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758742;
	b=jA0t04Abg8f6F+POyr83VtwaA5A6cqwQmopRa3PM1uQEeZTAovzNCS6iRQuY3CGJW82G
	 Z7o0BekRGXVoJOqS6GBKZ3yDJ9H33N/STLwm6+4rk98BpjVg6q0NuJ6ynmBRkMzTnAhYK
	 OQHjzf4X8UZ45/5lD0jA1v9OYAegramD4+KQs+9aReQ7vbMBhGp3gEiNp+/NCNQmoh8fb
	 1VVj9PJfAFQE69BZQIvMAlLk3c078V6sWpkcBgJsH6exlUdtfySikBqMx7nqyRSo+DWhT
	 nd2CodpBwtZa61Hj4uzHDXO3sdQDgzcN8sXw3KJ18ILPSE2atyddfag2rSR/00WU47w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758742;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MJtIEZRHfL2+tKH4qspJ2nYCVYpqSi8PgJO1PWzFn14=;
	b=nfrZAqqAR/COglxjyveL2LTmlfZyEBVF5BnwFUARxEhNnvjCS+fT6bOb7vDPNd3F/3/j
	 n2pt7OPeNNa7xaDEcthrNRYD5kwFWr7uU4seaUsKKr9aD8Hi2qJg2wvHjS/AicVVWGc/G
	 ir2VbKuEx//6+eiooVWKgDum6mMwm0O0RxU3xgmebrmnqw/8MXvJjOkbeEotMMyyjh6tD
	 xsFbZQLJFVlwEBB/swurhKC+Aw5CH4bQbZZCLlF5FSF9DHEfPMBxNA9BYHA2hCcpUUQdD
	 hQp3sdEOWUlnmAR+/vY9+GdhzIulI/+sm22mUm+k3bIsF5zUFUFAN02KKaI9UbMuSzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mbJDyKUM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UxIPaKvA;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ACB606A322
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18ACB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mbJDyKUM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UxIPaKvA
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NCAYPT3822088
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MJtIEZRHfL2+tKH4qspJ2nYCVYpqSi8PgJO1PWzFn14=; b=mbJDyKUMbsKBTfpd
	VF8oUL6B3cbqcpONko5rLSZwiSypf+0PUBrTO4nFXhk33eYHiLHJf91mAN5NGP9/
	GaK6wo6T2ZYGK2XZR3r48ri9/cIHnqCcCspymTQJ5S8LEzxxkyNCm/1kcyRLO4tk
	2MKFiABwUAcj37rK5cP3+Z3TFPNw0SVlkJE7IQusX3/AhjlfZkOf5GfRz8lLNF9P
	8MjQPBINN0TchVngglUI4Yew4p10ig5GU1ysk/TuPqvF/JvIB/4vRh4syoDGiqis
	i/ux/RWC6TTU0N9FDlSxbRiVUnrvs2dlBw34F/DA3pO2zyRDkCULRUxuIj49pv9q
	f3iRMg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7bw028f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:32:21 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-99067ffb4a2so14576241.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792758740; x=1793363540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJtIEZRHfL2+tKH4qspJ2nYCVYpqSi8PgJO1PWzFn14=;
        b=UxIPaKvAEPb/sMLdf8Tq6WKEQIdqsrsNT0os5hPL4o9/aFNMl7FtuAlRey7fuenRsl
         +zaAN3Z6se16fIuAtkjm0n0noNXLsgKfC0mLTXyt+FH9Ylf+ysqGteh7jl4G08DdE7EP
         2v3GdwCSsHWorfysTDscin6EcG4Rj4rJKDleYQxgjNo2gEC+VEeJCGg5Ouahq8JexvkW
         dETKCHXL2f7pyAQ1gUqxVGUbaj+07EOWU+nHtcL35owaptkvifYX/mpNYwH3EUsc22gP
         e/6wd5VfSFiNURDK8RnWKLBTzQMYcg9356eB9vUhLDBGpyQiQ8WZElGGBGYr/Rsw9zON
         0p9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792758740; x=1793363540;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MJtIEZRHfL2+tKH4qspJ2nYCVYpqSi8PgJO1PWzFn14=;
        b=TMZJ4KHjVv/r8cSBwbreno3NVn5ilrbx8hy66e3Xvb7Wq5+xxayH9V22Hr0Y68MztO
         vmNyF5ZTE5Xhl79mN60IZtewa6ww8wzGvwmiE5bSUKGCuaROuE6c8Tx3XpwSc8AQSTde
         Q8yzjhLVNqIeorWO+2ASTmVcl/NARcqOhpFxmsctZT1MJrxC8Due38RPdBnefSRZhHWA
         4MwwvS2haHeuhwkUnNepgsacq5f/rKEv6KQymsNlxdClD+9Nw33O20G17wxAcy58UzOu
         yXASK8hk/ZwdsM9zbgQWMx08cApQp25m5sjI8uBnGfvUDatI46gyaoUP5DR1eFS6fqLr
         t+GQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8HZNZ8eWPpq0h6/cB07vkRP3wDUsn3vy9jzpOiOiuUbsNUCdSsGxqTXxADAekdQwjFOoYwss=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaTtDAdOaPk0A3qEKCMGQ/ApWymIx+S+wAP/jPCPHiTbasOqos
	zLna9F7uj6DiuMB1zZj/XrDl6cQgXikwT/1YzYyLzQyvYB1fxn/2SfTmWqdPhxQXEzde/ZfuYxD
	3F5MH/OeLI64C6VcmpDb9Spq6MoKuY/6Ym7YjCNMPGdc/HxNQbV7+r+Aefcg=
X-Gm-Gg: AYBFou19wrRAyB8cAjmre4dhBPGTcW4S3XDEELl6iSvCqmjrG5KEgomIkHGQInOwLIb
	900TPR36mbyvjmbBwzVeSowsMbf/Wxa28c9ZQEq5PZx1nWn2vTaGV85sOjcCrFTxCShG6y1ItiH
	5l88bJ/zaz0uCxIebvWz78MOt4yjwY0L6ZT6IqI5S1qDATGe+4sMc3kEqpOkSrt7pezczmo/eGp
	5RCEMSPLUBLkhhK4NuSFp1tayXYjhQAXSY5IJhk1IBS/6RScuiFA6KZip313sdJuPG939icdgJY
	Zag/uDNLEzgLS4qJfeQ+dtfWnMjgXePqomZrdwuuFt0pl1rMTyV5mnXT/AhDLtUr1Hg22/V807x
	No/vqeq0aqOXo1g8zhCaaVg==
X-Received: by 2002:a05:6102:8515:20b0:7cc:174b:f7b7 with SMTP id ada2fe7eead31-7ccc2d8f97emr775017137.0.1792758740172;
        Fri, 23 Oct 2026 05:32:20 -0700 (PDT)
X-Received: by 2002:a05:6102:8515:20b0:7cc:174b:f7b7 with SMTP id ada2fe7eead31-7ccc2d8f97emr774968137.0.1792758739637;
        Fri, 23 Oct 2026 05:32:19 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b432cc83d3sm993728a12.27.2026.10.23.05.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 05:32:18 -0700 (PDT)
Message-ID: <5114bca8-91bf-4db0-ae12-442d21ebad84@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 14:32:16 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: lemans-sa8255p: add ethernet nodes
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20261023-sa8255p-emac-dts-v1-0-a34d778ce9ac@oss.qualcomm.com>
 <20261023-sa8255p-emac-dts-v1-3-a34d778ce9ac@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023-sa8255p-emac-dts-v1-3-a34d778ce9ac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OZg_pK9W-k2qsAHgEsVnz8KjISFXe3Kd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0OCBTYWx0ZWRfX2cXcJWSaFYpm
 UA3ff9QLXnHbXXM7o8oT6uwWxhUq5ZrKi60o3hF4gQDXjgn6uDBszrE1iEVMRcoZuPvbjTKVAwX
 WqAN6IvcqUQaUxPiS2an8od4hdJ065g=
X-Authority-Analysis: v=2.4 cv=QdTzLcbv c=1 sm=1 tr=0 ts=6adb53d5 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=TV7SFOc1Y2i57lEA1eIA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: OZg_pK9W-k2qsAHgEsVnz8KjISFXe3Kd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0OCBTYWx0ZWRfX0lPSBeGrMS+3
 jLlkOhZQkJxDawXt+Ufk1IioTnWjSSEa3R7MUeijp+laI/cHcrwPYBFzVKJT+yt4LwYZGD+PoIv
 vYLq+YNCdil2zgMUqUyt1CQVRPl1/+Qlygz39ftH5d/3PBo6zhDVPfgKVssXQ70Zh+q7KrOoaqc
 W7ykfWrp40Y0FfJeXr3IHk+Vp/ZTrjPpLrWfLelaZs7uMr+rAIm6s8VAaa+P88VmEEUTlQzQbEr
 1JDzY0tOVEfBRX8PeWhw4FgJqhFVICN7SK0mN4FJ3ydSBerlutBdFI3bscdsJZ1K7cZrK3zLhC4
 9PvMR0/dOcfor39pDdflC1YgvAMMz0EzrmdOmMLoL+5n+4Gx+iRfPpXeOTv7yJKQ2+eH/QcVDnr
 t/Nhet2pBaEhboFGfkBUumymfFvVTNh3dYIdP/rSUYkPE6l433pbT3gh2rwpv3OOZgrSJ0OYWxh
 qd1kCD0namLX59hyTlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230048

On 10/23/26 11:02 AM, Bartosz Golaszewski wrote:
> Add the ethernet nodes along with their serdes PHY nodes for the gearvm
> variant of the lemans ride board. Enable scmi7 and scmi8 to serve the
> EMACs.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi      |  28 +++
>  arch/arm64/boot/dts/qcom/lemans-sa8255p-ride.dts | 213 +++++++++++++++++++++++
>  2 files changed, 241 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi b/arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi
> index 4c155cbc79754af632848cd55b738e3ef0511cb5..c64cfd279af458e24fb48083ae549c96cfc07485 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi
> @@ -58,6 +58,14 @@ &cpufreq_hw {
>  	clock-names = "xo", "alternate";
>  };
>  
> +&ethernet1 {
> +	compatible = "qcom,sa8255p-ethqos";
> +};
> +
> +&ethernet0 {
> +	compatible = "qcom,sa8255p-ethqos";
> +};

'0' < '1'


> +
>  &firmware {
>  	scm {
>  		memory-region = <&tz_ffi_mem>;
> @@ -3226,6 +3234,26 @@ cma: linux,cma {
>  	};
>  };
>  
> +&soc {
> +	serdes0: phy@8901000 {
> +		compatible = "qcom,sa8255p-dwmac-sgmii-phy";

Hmm.. I was hoping Shawn's DT reshuffling would land first

Are the PHYs hardwired? If so, you can move the phys= reference
here

Konrad


