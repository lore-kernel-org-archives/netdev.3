Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089711;
	b=tcK3LaL8YgFW6SrOjmrEdn4TAuHwicHBu0srgBOhQ9qaCCmjDrzW5q6d/sQN8mJrmqJw
	 bxNH2ZvL34yxaF+RA7AM64TDGdWU3Kdh8I5MfAuHog2rLuz7N6Kbs3KZ0QFav6+SCqcsN
	 c70PV4c/0p3qwsPrpna2o9pbd1tRhv2n4AEDrPpt6T/IrT8tyfiN9kETxqecB0oCSHprg
	 lAK4GiQzrEzEOp0kZWDS56VKt7c+t+qbmEEeUSqLWiIoItvFBZu3ysUQaCDqWeztfIxsc
	 EZaA6apz5Prf3qGw6IgE7WYG/6dQwO3ms+4xI2NLWT0PbaMtCWIbri6YTijq/rC7xQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089711;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+lO09KkTAsM7ProbM/oc2Ec9Kk1EVdkd8GU8zKqLcjw=;
	b=l9SG4g2CtFyU0XfgN70ZRyOT37H8IUieyOlB+qj93Z4eyZ5r3P/yjjAag9qlpK1JG8SS
	 VXbU6LUKhlN9eOrKnypsxxqdY8AbTouBCJgkiXVGpnxO23xKoCt01P++e1R43ym33HuJR
	 Yi4/UOGhHKfnvIylamBB1hy56DdA4YmrKTQm6lh4FjeqsFWDWjd9mT5rmdH4VNCTajEN9
	 LGHLPN4DyuXJNDJi6PoaRBboZlEsc28Td8Ck3Q8/MA4otZ1X0OMXSG3t2d3eqqS1hy8Qg
	 YiMjuTfO3P2I+slbbPchfck4C0jrQHU88NW/lyf0rlAee97eXLKMKGKi19JsWceO5Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GlbFyay7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cOKkjIOE;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FB2606A324
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3FB2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GlbFyay7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cOKkjIOE
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R5Ywij752083
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+lO09KkTAsM7ProbM/oc2Ec9Kk1EVdkd8GU8zKqLcjw=; b=GlbFyay7dsKQ9ONj
	Lj/uYjVSZ75LQTwtVnw+tCNv/wTfopqDcEJ0yjqd4xxymac5LTN/wtZ9c37sqrdz
	m+RqgmI5dkYJAg8JyyJx3Nt45q5KKCWIpZSC4T6co91RCnRsnojpe7MXpAwqtfL5
	w4bgb4COYr3OeDyJ7lDoeXtlslqt8s+Z6H9iq1dlbTNW6pyg0xeQRWLBvXnHfHTn
	6DQf8YRnKb+TuuRFKS5UQI9q/oKzOjrlNj3cjyBbFIjCo6VgVOeP1ufuUT5diUem
	rClYF2XWK0ldpygT74Q/Ta2X9WMC53IPT7ngtN3b4Ky+jq3R6YODlrHxnjetmOgG
	A+BPlA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmanmf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:28:29 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36637676140so6364815eec.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793089709; x=1793694509; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+lO09KkTAsM7ProbM/oc2Ec9Kk1EVdkd8GU8zKqLcjw=;
        b=cOKkjIOECaLzaqzzbCElC/reN3ZRiJ2LMz8/Q9jrv992ZG17jhW5epqYdN5g/kOEjN
         7yMBimWU6rN2+rtY+871NjsWTSI3SrV9OVsJmPiXXltW5E0uEQvhHeEu1rkS6xnx4z/C
         J+auHE9W5dfgFsnaLbjbz3g4wTeuUrip4d83/XXyW2nGWuDPIMHhqc9UrY2jwEQI8dAT
         6oJbw/VW127ZN7HrCwrlyk6YGN5NWCFq/PYeiyqMFgD3dWEyVPlQYma1ZwrwNhro9YCl
         oNulmnttgMAw1QWi9Lhcbgc9jNrgHtlwovAdYG4MgNYdlhEyRD41TF7e8EqoiyuOZ4/g
         Rkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089709; x=1793694509;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+lO09KkTAsM7ProbM/oc2Ec9Kk1EVdkd8GU8zKqLcjw=;
        b=oAftSCFzHgopnQ94jMQK0sbArtW2UTmbOBRmN+E+u7FtmEhTfpzaV982IGzfpEj+aa
         ZFbzDlW0dIohZcgz/AvL7TF4EEYHxz/Zm7MTIxYqrVox6OTKF0Poq04IYAtekhd+0xz9
         NyTZmtbqGwyZ5SEe7regPNpHaBxnLcksGsL+KzvrDgknpQYtE7oOLl1PcO+r8hhpd776
         OxPwOgg/IzUuoOKdfON4J/qceXFJ1NIqpVREvwFlawTh4XsufrfDN/SLJN0UFhMimncK
         aE4L5QAtDz3SKIOsh1EBV4ybfphypRZlkaqhJ1WecD2zxGd0sRaLVb9qbr+saNIW4+yG
         C8EQ==
X-Forwarded-Encrypted: i=1; AKwUvBzC3G9LNo4ZFlebL+MJGCNBQKiLj1JtcKeTd0vMu+jCRzGi/x1SFMnbcnisstAlWnHO74bmumI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2jArsHf9YRQ1xZJ9c32Fz0BpJBj9FAwP1IOCt2L1qBefw4zOu
	oOMal18SthchDd8qrTOM/gMaoAaoxIa8jsD5C1xI8cO2+awkBHLgbW1P6C70VLitgkxq0U2zH6K
	LQcqjJBtLJGKTNPh8r0Am1+6K3wG6a4s4gREj/YqlkrbS9S6MgQxanWduhU8=
X-Gm-Gg: AYBFou2qz317KTVolDoVLgHniKKh5YKrrcUeDaaC9Vno7M1S0RzAg6C/mXOLTucZ5EG
	QfWndd6RXllpK7lJazb8Ooc8LXP9x/SlNntlghyawP0eKeyYIC8bfcZa4E1oDEKk2yWnbvFkZ6u
	2vHfXDTBH2e7mvwWX7KTCQigEZ+H/Mq2w0K4UEAXHqIJFwB+/Wn9yVPTu3Whs1dx1yFFTMdmVQ1
	E28kegrG+Eeqgi2szSVMBAC6Hg10xRIB4Qyb1q3so3WnUzFdT5jWYi5CXIbe58I380qm1IxjGkO
	RlMBiL5EWsczDaCNIKsB1e73lPNvZsfW633DHwSpi8JBFtiWsz0qiI2vVlx5pWDo31qHe3ruRK7
	6EMRLZUC6ZigY9a44FXGuHF3owMC/AuOkdRYY
X-Received: by 2002:a05:7022:e10:b0:14b:cf58:ce15 with SMTP id a92af1059eb24-199377d8c81mr19690484c88.43.1793089708897;
        Tue, 27 Oct 2026 01:28:28 -0700 (PDT)
X-Received: by 2002:a05:7022:e10:b0:14b:cf58:ce15 with SMTP id a92af1059eb24-199377d8c81mr19690386c88.43.1793089708019;
        Tue, 27 Oct 2026 01:28:28 -0700 (PDT)
Received: from [10.217.241.81] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a249c331sm65866768c88.17.2026.10.27.01.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 01:28:27 -0700 (PDT)
Message-ID: <d08f576f-7255-402b-8eaf-41e0d3acc207@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 13:58:21 +0530
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
Subject: Re: [PATCH 3/3] arm64: dts: qcom: lemans: Add Draco EVK board
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
        Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>,
        Ajinkya Inchure <ainchure@qti.qualcomm.com>,
        Anuj Tripathi <anuj.tripathi@oss.qualcomm.com>
References: <20261019-lemans-draco-final-changes-bringup-v1-0-dcabe94f1074@oss.qualcomm.com>
 <20261019-lemans-draco-final-changes-bringup-v1-3-dcabe94f1074@oss.qualcomm.com>
 <3btrmmavq65lp7rwmdx76qjvaseaoa55xdibdli2izujusebhw@fkrtjiqsnvnt>
Content-Language: en-US
From: Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>
In-Reply-To: <3btrmmavq65lp7rwmdx76qjvaseaoa55xdibdli2izujusebhw@fkrtjiqsnvnt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzMyBTYWx0ZWRfX+Uzn+JMgGJMp
 zKmzv4qMlrpLoTB1/bzVvFmFk+sq01+SdVRtMkAwLEHrLRanQlWc2V4yAJpbZhITyYjk83H0HnZ
 GsgGcLAkzB11zPYDTK0qJcRjLSelWSc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzMyBTYWx0ZWRfX+ULbxdrSJvhU
 MmUu0cTW+iRooP36mbgm30ZgwgTf0yXoBZwYUKPVLpmTtQJdv4CqMu0ejACPOloMFRSlDAwK5Ze
 FpIPnwdCp59eA+HT6iUZm0uzwbov6yJjT8Gi1oADxLFmbsHAy+mKG2X9Nvn2WeC8lDhkhiTZHI2
 OGA/NMTDrmiG1eqXPUiulHVsDzRvnI4A1W9W7TfXwQSTYpdsMzJxTWAUH79cAg7k+3c5BpCXIS1
 DgHBwXMkNUDMRxWacmNh0n4K7iiDDziVssF/wNl2GsOxFybB9Oouw3B31S9U6nbVHDyarLnYz6W
 Em2nJ+JSQX18mqDm+CsDFkXU/TbpL7U5t8am9UHH2dY4TlbFFjgailwhg6Qzxi/aQVT4lOTSgDu
 zPe0bie2pbXYOu5EvRnmcnGUuSTDLkhNwI4K+i1eWozzfaURo3eSHfvpqkMnq+ev+wTZA4fjSnx
 Qbj6JBP9cr/r7VKHAvw==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae060ad cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=jkk_kXO6dKdktKeh6coA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 9MaUcQWmx1nZQIC7d_6Xeu4d22CP3c_E
X-Proofpoint-GUID: 9MaUcQWmx1nZQIC7d_6Xeu4d22CP3c_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270033



On 10/19/2026 5:35 PM, Dmitry Baryshkov wrote:
> On Mon, Oct 19, 2026 at 03:57:34PM +0530, Gopikishan Thawre wrote:
>> Add the device tree for the LeMans Draco EVK platform which combines
>> the LeMans Draco EVK SoM and Draco carrier board.
>>
>> This device tree adds board-specific peripheral configuration on top
>> of the SoM, including:
>>
>> - I2C GPIO expanders (TCA6416/PCA9534) on i2c2 and i2c18
>> - EEPROM with MAC address nvmem layout on i2c18
>> - Native DisplayPort output (DP0-DP3)
>> - Dual Ethernet (ethernet0/ethernet1) with HSGMII PHY over SerDes
>> - ST33HTPM TPM over SPI16
>> - AMC6821 fan controller on i2c4
>>
>> Co-developed-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
>> Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
>> Co-developed-by: Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>
>> Signed-off-by: Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>
>> Co-developed-by: Ajinkya Inchure <ainchure@qti.qualcomm.com>
>> Signed-off-by: Ajinkya Inchure <ainchure@qti.qualcomm.com>
>> Co-developed-by: Anuj Tripathi <anuj.tripathi@oss.qualcomm.com>
>> Signed-off-by: Anuj Tripathi <anuj.tripathi@oss.qualcomm.com>
>> Signed-off-by: Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile             |   5 +
>>   arch/arm64/boot/dts/qcom/lemans-draco-evk.dts | 543 ++++++++++++++++++++++++++
>>   2 files changed, 548 insertions(+)
>>
>> +
>> +&i2c2 {
>> +	status = "okay";
>> +
>> +	expander0: gpio@20 {
>> +		compatible = "ti,tca6416";
>> +		reg = <0x20>;
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +	};
>> +
>> +	expander1: gpio@21 {
>> +		compatible = "ti,tca6416";
>> +		reg = <0x21>;
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +	};
>> +
>> +	expander2: gpio@22 {
>> +		compatible = "ti,tca6416";
>> +		reg = <0x22>;
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +	};
>> +
>> +	expander3: gpio@23 {
>> +		compatible = "ti,tca6416";
>> +		reg = <0x23>;
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +	};
>> +
>> +	expander4: gpio@38 {
>> +		compatible = "nxp,pca9534";
>> +		reg = <0x38>;
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +	};
>> +};
>> +
>> +&tlmm {
> 
> Please make sure to sort your DT file. You have 'tlmm' node between
> 'i2c2' and 'i2c18'.
> 
>> +
>> +	dp2_hot_plug_det: dp2-hot-plug-det-state {
>> +		pins = "gpio104";
>> +		function = "edp2_hot";
>> +		bias-disable;
>> +	};
>> +
>> +	dp3_hot_plug_det: dp3-hot-plug-det-state {
>> +		pins = "gpio103";
>> +		function = "edp3_hot";
>> +		bias-disable;
>> +	};
>> +
>> +	ethernet0_default: ethernet0-default-state {
>> +		ethernet0_mdc: ethernet0-mdc-pins {
>> +			pins = "gpio8";
>> +			function = "emac0_mdc";
>> +			drive-strength = <16>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		ethernet0_mdio: ethernet0-mdio-pins {
>> +			pins = "gpio9";
>> +			function = "emac0_mdio";
>> +			drive-strength = <16>;
>> +			bias-pull-up;
>> +		};
>> +	};
>> +
>> +	ethernet1_default: ethernet1-default-state {
>> +		ethernet1_mdc: ethernet1-mdc-pins {
>> +			pins = "gpio20";
>> +			function = "emac1_mdc";
>> +			drive-strength = <16>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		ethernet1_mdio: ethernet1-mdio-pins {
>> +			pins = "gpio21";
>> +			function = "emac1_mdio";
>> +			drive-strength = <16>;
>> +			bias-pull-up;
>> +		};
>> +	};
>> +
>> +};
>> +
>> +&i2c18 {
>> +	status = "okay";
>> +
>> +	expander5: gpio@3c {
>> +		compatible = "nxp,pca9534";
>> +		reg = <0x3c>;
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +	};
>> +
>> +	eeprom@50 {
>> +		compatible = "giantec,gt24c256c", "atmel,24c256";
>> +		reg = <0x50>;
>> +		pagesize = <64>;
>> +
>> +		nvmem-layout {
>> +			compatible = "fixed-layout";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			mac_addr0: mac-addr@0 {
>> +				reg = <0x0 0x6>;
>> +			};
>> +
>> +			mac_addr1: mac-addr@6 {
>> +				reg = <0x6 0x6>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&i2c4 {
> 
> More of the nodes in the wrong order. Please go through the whole file.

Thanks for the review. The entire DT file will be sorted alphabetically
in v2.

Best regards,
Gopikishan

> 
>> +	status = "okay";
>> +
>> +	fan_controller: fan@1a {
>> +		compatible = "ti,amc6821";
>> +		reg = <0x1a>;
>> +		#pwm-cells = <2>;
>> +
>> +		fan {
>> +			pwms = <&fan_controller 40000 PWM_POLARITY_INVERTED>;
>> +		};
>> +	};
>> +};
>> +
> 

