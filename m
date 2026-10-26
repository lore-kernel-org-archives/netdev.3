Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003776;
	b=PchleETzqlMfQypuEQTKvt/xNpXMZOywdjcxCjCq+KQ1tFmcGMICG6QkrbvIShw3TDln
	 CVpXCOCG0uRd6Y5So1BPQh3dxlONVKBGmZviKjcbErZOkTvIVXdUNJqAJQahWUikmcqxu
	 NruKXTcio1kKCz4ARNnVGyrSj/Kh/P+WYmXbRhtKV90D0lRGH1Ay5YDG5KNmlcw6n6TfL
	 aHbYSCs4aBc2Oeqwd5IgdTM7AwboedhZKUVAMpur6radkmsSRL4FYZemkbFqR2dVD/kgL
	 w5Z5bMnvHC6WSvgOKtoUTo2DEUv3oEC9LmDvGNcbrARXkQzltiD0CS4vd+qdCeDcEZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003776;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2IBldTT+B4MiEIGdaWBBVnElcnO8vPC3++c1Vr7JCyA=;
	b=BwNocj3nceoYwsRhol/e7d3dqyac1Qg3Cxp1XgRhrJeYTJcA9aoZQrmAvLMSLpKMkWe6
	 faNKnaDvV95JGMahhKz6tZ46kZsgcKL/WGbiTjF0WCMqwf942TG9WIh9PeiCaHJhv9Vv9
	 s6E92bIwMK5MKCuUYiVn+0SpAgYGx2AprD3wa0JhjcG9fuurFIJz/f0O34EUc0ksByoEW
	 JbvekloEtaqY5he98PD2Mkfn3nYQQI0pQAfQtLFUlMTLjDKsURuB62is6Q/YqZgwrEmG5
	 QfzZq0HTGAu1V9GU/XidM+HoVwxLuud4u8Xph01l9Gs7joj+3kO6Uuh7OkwlJa6+SOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ux2TlE8z;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QL5vGX3h;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F407606A338
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F407606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ux2TlE8z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QL5vGX3h
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b9xT718228
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2IBldTT+B4MiEIGdaWBBVnEl
	cnO8vPC3++c1Vr7JCyA=; b=Ux2TlE8z+gn9CQPUQH7iMDWV3wRVIQWe9SWb4WE9
	dBSsI1tDytWIT/7OBt7qKcvynQ02TKQlx1duqUiZ6dlzQ+S4XWG2OMZHmTWXiPxD
	c4VZKpbS3sVZh5bl/DjDWpmmqyAxzOxgVCpLe029L+2lOS/Lh46/pM5MK9JKEACO
	91/lmaYzR64nc6iWTbcO1Pz2WwtcDR0FPZyDX6AoiGYGSzv+uTFE4Xuv3xFNwxeL
	+h/z8/2emxUseYxs0sm7ZXBnbhIAyaeKQ0a+Rxru6btArCce4ejB9Ge36aeU5VaE
	ZNRW5muNra1IE76qEhY/ye203+B/veS0m5aRqDyNuymRSA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsgssk5p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:36:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad98380ccfso4284028a91.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 01:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793003774; x=1793608574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2IBldTT+B4MiEIGdaWBBVnElcnO8vPC3++c1Vr7JCyA=;
        b=QL5vGX3hZ/MuMoSd9PwzfCMn7g0Mk8rWfsLNIvyB9itnhwRqlMgb5JxZDPm5Viv4WU
         TISe8BGjnu1dVYdeshGGAHtSXbbSVXdqSKKPGr/PbX0PEF6AWPIaBDTan1dLqwmiLTvn
         d7/ivRZ638FmPPDz+MefZCesVYl2VT6DfsAZrX22uhT8v0qZl7oPhzNnpT94MSGQqRl9
         s2qNQJGc2MTp3ejxBmtpY01IyDHTTYT+p/p06FMCK4/g1rDkTxjjuPSxJEComdLXtzOw
         yPFyFOGBWGi2GgB2U3bXN16F+PoaVJes6Y2j2EseJxHFkUP4tzrYSkRz21dGwnY+F7a1
         H54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003774; x=1793608574;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2IBldTT+B4MiEIGdaWBBVnElcnO8vPC3++c1Vr7JCyA=;
        b=fXS8mwKr17Qw1XiDdJfNn0bfCiizbPjUZRYxSKg1CtTGH0A0UfBHGwQl8m8m+wSXc7
         4aKaF7yKc30L7oUe3knrYbUJsOtRGPFcRhYXrJv7dx+wz9EDj+S63GpNOwMVBhnQyqEq
         o/FksNCLZIbvDQvYcho5T8ud1dQPefP0E94ul8pI0RC/JafcF/XK5rCamS5nrbIWP0t5
         pZ4tN1PW0XteYCtyXgpq0eqlkApB67A/DiqkpxoeS4rtfqxE9RHQ4Hd2TJCcdwi+RwF3
         d4hIhFx+YhjfaQw/CvjfyBX+XrJhyiV1Unqw+RkRJ8rf6IFQ9yAycxvk75X5+VjF4rtE
         jNAA==
X-Forwarded-Encrypted: i=1; AKwUvBxQHjoscIIX9D6g4iUIwrbYa8O+avIebD3uniGLx0doNHuMiaiFMIBhdrOA4RZ0Bo+qWKl1e1I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWJo9KjdVW/TJp50CR3h/4TrRM8kwNpR0jgt2fMCdNbHMGybiH
	iDWueJPrJ9rzlLxcUkIZxjYvQ7Vt5r//YpRiAKG4OpmtUtVOcYQoLg5N1AtBYH6NbzXq896+IgV
	poRWId5pTi0qqzdVlxzAH1mOAIJI+vDpTA/S5EkGz8BzYJc4/clDvx307XHw=
X-Gm-Gg: AYBFou2lKxlcTVblLrb/d+u4EYmOvSrA0nU8mQcsDMTg4NN3eEcdPRFbHNJKYi9CoGh
	/PMYjJ7cVKTjyv08xGGP7cl1y60nP3lo5bI8+8xLgzupcPcmRm06LJoP9rMmGoiH2ZeIZarSk2y
	wZwiz3gSdW770rONeYY53x+62IhX3cRh/vca8D87MzbgvrwUXUTNN12VMEnH7CCAjVc8MPaf+/N
	TFoKJ3FQ3SvE557M5uo4XYnEkHaf2rYATjYy9v78x3eCHM75oyB854fhNNGK+n705Ky8whlR4lk
	WfWOuOxeToc5wAq1fsomDES7naO9o8EVK0HDMPz58u33CwGhPKufdUzT0rkjsOUBfLeYiZaaWMt
	29DBoun3UBVfr2FRpyjtm0PMBLPHQ68ho9j7qI7X/5g==
X-Received: by 2002:a17:90a:e7d1:b0:3ab:1b19:78f4 with SMTP id 98e67ed59e1d1-3ade9b2ed8bmr5784764a91.6.1793003773971;
        Mon, 26 Oct 2026 01:36:13 -0700 (PDT)
X-Received: by 2002:a17:90a:e7d1:b0:3ab:1b19:78f4 with SMTP id 98e67ed59e1d1-3ade9b2ed8bmr5784737a91.6.1793003773334;
        Mon, 26 Oct 2026 01:36:13 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebaddd45sm5344362a91.2.2026.10.26.01.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:36:12 -0700 (PDT)
Date: Mon, 26 Oct 2026 16:36:06 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: lemans: make the emac compatible
 specific to the embedded variant
Message-ID: <at8Q9umfE2AP24lI@QCOM-aGQu4IUr3Y>
References: <20261023-sa8255p-emac-dts-v1-0-a34d778ce9ac@oss.qualcomm.com>
 <20261023-sa8255p-emac-dts-v1-2-a34d778ce9ac@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-sa8255p-emac-dts-v1-2-a34d778ce9ac@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzNCBTYWx0ZWRfX4f1m5xXycWdH
 edWgredsLlQBHsxt20ve/gNNIm7kR0EluFpGlve+cRTZj9JkWL/JLNQCaI+hW5twxYNbV6SnrXo
 0sYMJ9NoqW0hcjPpNhrbwDaqzXaAM5g=
X-Proofpoint-GUID: VEsP0f0Gf_4nMYKA4yGxm6QRoUf1tP0i
X-Authority-Analysis: v=2.4 cv=c+8+0h9l c=1 sm=1 tr=0 ts=6adf10fe cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=OYXKdzKcgdxe2yQkhO4A:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: VEsP0f0Gf_4nMYKA4yGxm6QRoUf1tP0i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzNCBTYWx0ZWRfX7RwsjT0J8NCZ
 h/USXkAt6l+XXeXanSSWI/VnJj/HCjYZMHbClf9RDNg69iOoMYUkJQfx8lxW87BYewZeZYZjx84
 iNKM/9xSDikqiaQFBxyVWqZiyh3MKmYOzfClgKq3B218nA/3FCquXyF53Vi5Dd2LfgRGbpOhag7
 nX+/K2fvuixc5/fYor8ylx32GSMaOsqo8+zU1+Yadv56atk/tMNI9Uqd4lRd2usHvtmi88a8jpw
 aze8b0I/SlUhcsGjRH/N8Cp0q4LkhKjDZHWL14huU5Uxz6zzYI70Y9IYi3Bxjdvu5abaPR5UxcS
 T+s5NmLx4Cx9y5kIr/eJExNvZrxdMvQLSqGYnBnReE8M+Vwn6bmQbETYmgbnZ5t/iDkpXHw7oEq
 UmDH3pxX50mH2as+U8GdqI0nLw/2xJy8geXL3X+5H1Mj0rdHfkbcN0YyYC9imxn69TzoC8xvXGk
 97XGenmPYirlVmqLBzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260034

On Fri, Oct 23, 2026 at 11:02:23AM +0200, Bartosz Golaszewski wrote:
> The embedded and gearvm variants of the ethernet MAC use different
> compatibles so move the one for sa8775p into lemans-embedded.dtsi and
> make place for the gearvm variant to be placed in lemans-gearvm.dtsi.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Do we run into any problem if lemans-gearvm.dtsi simply overwrites
the compatible without this patch?

Shawn

> ---
>  arch/arm64/boot/dts/qcom/lemans-embedded.dtsi | 2 ++
>  arch/arm64/boot/dts/qcom/lemans.dtsi          | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-embedded.dtsi b/arch/arm64/boot/dts/qcom/lemans-embedded.dtsi
> index 3733c0b7bace10cad656144b31d02bd8b4dbf3ed..630c40d21ecdab40ec59135cc667e4eccfd23554 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-embedded.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans-embedded.dtsi
> @@ -458,6 +458,7 @@ &cpufreq_hw {
>  };
>  
>  &ethernet1 {
> +	compatible = "qcom,sa8775p-ethqos";
>  	clocks = <&gcc GCC_EMAC1_AXI_CLK>,
>  		 <&gcc GCC_EMAC1_SLV_AHB_CLK>,
>  		 <&gcc GCC_EMAC1_PTP_CLK>,
> @@ -481,6 +482,7 @@ &config_noc SLAVE_EMAC1_CFG QCOM_ICC_TAG_ALWAYS>,
>  };
>  
>  &ethernet0 {
> +	compatible = "qcom,sa8775p-ethqos";
>  	clocks = <&gcc GCC_EMAC0_AXI_CLK>,
>  		 <&gcc GCC_EMAC0_SLV_AHB_CLK>,
>  		 <&gcc GCC_EMAC0_PTP_CLK>,
> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> index da740a0876d4adcff0bb9458564c868a6f406b0d..77e4f57778fd54e414c86a32f5b068239bee6d24 100644
> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> @@ -4386,7 +4386,6 @@ port@1 {
>  		};
>  
>  		ethernet1: ethernet@23000000 {
> -			compatible = "qcom,sa8775p-ethqos";
>  			reg = <0x0 0x23000000 0x0 0x10000>,
>  			      <0x0 0x23016000 0x0 0x100>;
>  			reg-names = "stmmaceth", "rgmii";
> @@ -4407,7 +4406,6 @@ ethernet1: ethernet@23000000 {
>  		};
>  
>  		ethernet0: ethernet@23040000 {
> -			compatible = "qcom,sa8775p-ethqos";
>  			reg = <0x0 0x23040000 0x0 0x10000>,
>  			      <0x0 0x23056000 0x0 0x100>;
>  			reg-names = "stmmaceth", "rgmii";
> 
> -- 
> 2.47.3
> 
