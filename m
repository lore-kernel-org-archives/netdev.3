Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B815416124
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163478; cv=none; b=shMsUtoXYabt+G2PmusGNhR2g7zG9FhQ5JIPhKhF2J2eFU6TM9KO9EEWmrl3HoAH0PmERs9iFh0NP96Ew1Marv8HhshUv5zPviXRS5C62zNkqnd4w5prZB2Hwg0gylMEl6ykr10T6HllxkWk98NCK1EDF8TWdK6dieIJPC+ETtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163478; c=relaxed/simple;
	bh=XN3xa/48SqChZE3wm/lRlklcT6w8t9N6WIhdbCnXc5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrZ0SvYFhtY+FmEhdxL1Zy9OifoH0wfrtwrTKuGMOWce/gCz/QMJ4Z49tdLMRce3KBNRQVJYEX/Gh0zyGMhhGtALWbu79iJqIZdsVMjVGTR5xP8KcqbnCQjUc+6Zhk8nf0Ln+v0zb2vaaectf/9Ltw/oWvTSYXx0I/Q2zH/pCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gDH0wSwp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QSJ8D5Vg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gDH0wSwp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QSJ8D5Vg"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmJAM3823897
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tj5xAxumuNTcwhfMIoVyv0E6o1XgIr7Yq39yh6tYNNI=; b=gDH0wSwp8/jySBt6
	kNt7q6ZV7A4AFGeeGI0CJwodjzk1u8O1BCHbtFhm2G0/P4cuL9Ld+yGdffn7QBRV
	ZVefXjqeuLqa1oEDNFVl9ZuZyWE+s8BDs2UaYy4zcQKRVKjnkr3WT2P4fT6r4Mdf
	gffhzqiCyH/TeRNhkjhVipcKQDWRfesx2ECp2eSKlNdzyzwn8CitYg0tgTQudu9X
	Mze5/fMaXL8tqkkX1Lmg3GfNrKsIauY5wppGqa4dgxTMnzG+AikOAHW5FcXeIj7F
	opNr42EyiFOHjefHEaEVuo5L5S0bSRwhUPLYmZ3fhvEeGIjczzPqYkwkLLZxJytt
	NSu50g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbs7rn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:44:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c9e97b626so4940021cf.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 07:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785163475; x=1785768275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tj5xAxumuNTcwhfMIoVyv0E6o1XgIr7Yq39yh6tYNNI=;
        b=QSJ8D5VgizWY3Q4fbAc5xek0rhImYnn5jZywnEh9SSfVE3Hs2tgMGikKwa8Nm7EmOb
         IlxUB8/NLLD1WIndbZ5bOhIuaibtVVHIkAQy7VS90txK6DZiCYQCtUuPxbznGYvId8Mr
         d/fIKOsxEZ0GCjJz84ewI1gkwtilDrBUWntujiD2HI54rSimGsnvRl8dJWlkX3FvxyrY
         NOIjG2FQQC3F9Q9/XIo3FK5u54q8t8IBIcxESJtTg0psyceFPlmualXMCfFqQAUUORnK
         +DiMIDolhT+1Ok8dyFxyvDoD16cz0UjVnpXep/SmnGTJ32hccmIQ9uk3IOsDBQfDg+Jm
         JBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785163475; x=1785768275;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tj5xAxumuNTcwhfMIoVyv0E6o1XgIr7Yq39yh6tYNNI=;
        b=PjXNXdyBwRanK/nE/dgR3RI9dyCNDCLrZiawQxIyivExrdmLvRo3Y0tOpjwA2+yKCP
         EI9sS1pZIwG571TUE9wui7D8BKw/fobQDS9A6nmseVwd2vULDr7lidfiORJDDzTFYlFu
         Xqriu9lgyv6gcxeYKKVspt8wGWG4fNGVG82Mi1njOoG0v3YFS32IrExWu6ygpDURMaF7
         8/yL4Lwn8XjTNWTvzzyda8jyAn/VuimU8baTHyaqYT5BWN7+g9qf+kqPQK5iyto7RwNN
         MtFo1LVZH9Be8m5ntCv/XjYq/9M8l9/e19PCXl7o80YamcvfqpZ3eX5r5P3j6FFAhr/1
         yN3w==
X-Forwarded-Encrypted: i=1; AHgh+RraXVc/LOVFo71pPtkOkak19eAQ9Ol8AXXD0HSEMW+1XFwxZ+NzFNGGyHEGDgOvWUgzEAecca4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWPK1GyNDsAJUGPuXy2nkIZuIxhL4LQqzbNajkiSZlnq4Id/XN
	WL6dHwr/zIEDRBf3IF0ho8M7cJUZO3oLFEjhWCNnBFTrH/ZQjYtz8kRin8dSoHZAQcwhmCPwv0P
	HxJrjRBR8eHZsbpHt1LWymAJz1Tv3i5BPy608D6/Q91jLLDNtUExXe6m8IKs=
X-Gm-Gg: AR+sD11vbUlzAG8s83T9kZEYDBEDIcuRq5XDfwCyc6UbQyuFh6vh8XLkcs9XRqP+2cf
	+kc5Py8lh2gSj6fiGxIYZrznfWOXgtxHpElE6s0LD2BAH/5npl962DXiTfT8/aKMeTJFW59HxMq
	sdGSnSaFSy2t+4C1sYTiGaSqm+HFjfkEjWCvazg0VPsQhtNhBbTfI12JlRCJeb9U2ih5VjpNKC9
	JyjPnpcClHi8m39+iubExmTBfohD3qm3KEp4tnBuO8O2MUYjuR1rHnR3zzeiVyjbo8zXIkB7tp3
	Kldti8oAsjq5w8W4s3P7W8p1Ra52mIuTf7ptqQ8x/BudQRFUqb/HZ68IugWgs2tlg/Xle5RN2Bz
	DL2qrymqD7a4PzkxC0BESjL1N
X-Received: by 2002:a05:622a:a9c7:10b0:51b:fe41:4764 with SMTP id d75a77b69052e-529cfe3683dmr2895471cf.7.1785163475081;
        Mon, 27 Jul 2026 07:44:35 -0700 (PDT)
X-Received: by 2002:a05:622a:a9c7:10b0:51b:fe41:4764 with SMTP id d75a77b69052e-529cfe3683dmr2895131cf.7.1785163474685;
        Mon, 27 Jul 2026 07:44:34 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2be1e6525sm1469468e87.58.2026.07.27.07.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 07:44:33 -0700 (PDT)
Message-ID: <a93f11c5-d0cf-4acd-a959-53fecc996e5f@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 16:44:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: qcom: lemans: Add support for TSCSS node
To: Imran Shaik <imran.shaik@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
 <20260727-tscss-v1-5-beed14e72510@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260727-tscss-v1-5-beed14e72510@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: S4HG2OpsEzGYwZuCeVNkE6B80zLc6dxe
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a676ed4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=5lWD-fOefMpBFsrRanAA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzOSBTYWx0ZWRfX4+CJD/l57boh
 XKiR7XrVINcHd0vL/Ab3i1dRC9PWYNSwroPzxxtuADj7Bedu3hpx6tuVzQHevzf5Yj4Sr+9o6gG
 fK1TJAZxZvXJ7Bd216MLGBAEGk/B4gc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzOSBTYWx0ZWRfX53pa9x7OwKdx
 S1g22nT9cJjvpqPShAReOY8n87Kql0GIiSGtmmqXW9OMTsTh+LTO1hNU9/0HFr5bxL7jSf7iyEM
 kH0CsZdH/yHcDAU3KCufAFz/YsMHRQSBq3FDB9BYdAEDUYgK3Zo91GQYNo9Ke+pmS0P4LTphKcU
 8J6CvKU6/lam4q71pfyZDr3GdS2gIwavNs9/mXlFbGLU6gldXcrZPajUqQ2dpN1ZeMy4C4l6bWf
 pByMzwBT+19OLRtJrJbP0uOSr8Nt4F6mLIBrPT/sDfTJj3xVbXlJikjAa1b6L+IQPzt/B2kp4dk
 X3zxyJ9w6scq/UEfZj8zOCnKhE0lAIKiYjmQvc9HpBOy4sKyl8wKl2crjZFLPfBD4cmV8JjJk5o
 ahsCeNijcO7JYllnZjiM5vJagl7wwcV9v9cUZMXSA4PgOynaz1SME9ir4ma1jOUMpAePnOyN2YZ
 2QYVAf3J5/7MgMLJYxA==
X-Proofpoint-GUID: S4HG2OpsEzGYwZuCeVNkE6B80zLc6dxe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270139

On 7/27/26 4:11 PM, Imran Shaik wrote:
> Add Timestamp Counter Subsystem (TSCSS) node support on Qualcomm Lemans
> SoCs.
> 
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> index 3b0539e27b5192582e0bc9ea248f1c0382e05030..e225292a1e41a5a313aca188ca04bb12474995e8 100644
> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> @@ -3023,6 +3023,17 @@ pcie1_phy: phy@1c14000 {
>  			status = "disabled";
>  		};
>  
> +		tscss@1c80000 {
> +			compatible = "qcom,lemans-tscss";
> +			reg = <0x0 0x01c80000 0x0 0x2000>;
> +			reg-names = "tsc";
> +			clocks = <&gcc GCC_TSCSS_AHB_CLK>,
> +				 <&gcc GCC_TSCSS_GLOBAL_CNTR_CLK>;
> +			clock-names = "ahb", "cntr";
> +			assigned-clocks = <&gcc GCC_TSCSS_GLOBAL_CNTR_CLK>;
> +			assigned-clock-rates = <15625000>;

I'm guessing this will only ever require a single rate - do we
need power-domains pointing to one of the RPMHPDs and a
required-opps reference to match?

Konrad
