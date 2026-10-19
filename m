Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6133A59A2
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411523; cv=none; b=lx7LfiosNfWniH62iFE9xoJ6MzcazYBFGlwEjyomlJeP2hazD/1THjdTvGaCHwu9F7yQVOiwDjh00JrRwedGQ0EOzJ1JMfDG0VinJroAADxWMhtTMXz42b407bNS7r+u9j+tfjqh5Y9Dygx7vT0+xLby5IDxc1CNC+d3Ta3fpA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411523; c=relaxed/simple;
	bh=t+2Sjcc3CJYX9gnbuGThRPjbfxPqVr+U/bQ0Vby57uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwoUK/2ZaDHJOcJBXmR7LZrTa+PID5OngK4+nTLaD2dZbwnZod02tXp8JeoXCMzfbUvS5VMEK2p//cSq3+oTGfCsx6cy+derhJYtcYY2uES621WawrYhR1mgy7CH40lzZJPiDzLmwnHMfL934vtQb0vMdZd49u6mCH+sF3sziTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UV2mtenz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LV6ZXxt3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UV2mtenz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LV6ZXxt3"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8OswE1348209
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7PduYI4Tzaf1zqS1KtjsVUZm
	BBZtwzNJ1fbj3zZ1iTY=; b=UV2mtenzRppun/5JpKjkdxO60gkzaORvtHcP9BfY
	WfjqYpWG4wM+a10M0uvlO3rLoURjq2hKpHRfnef7Lxg9WdoZZ0tTanyp045X6B9t
	A1RqLs9CQ8KnqcYtzI/x3F5yA7ak0Z3FNayXKKJvcETO+sOgsnp/9sTSDAOL7qya
	ActXbEk81Kt+LzLB6A1XT44e9nYXEXTdcehrJlLdm9eN0pHWgI8aD43h/c4h46tE
	1JVvUcdcRmRaJAVvw5qHdinHEq/zn6xYBqDEG6l/Sui0ho5mYDcfOYc8/M4U2BBN
	1krsiU9T+YEzjZMFQERtUmRi5uxp2hJCrjuvbNlm+x8o/A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf4rgy2a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:05:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb98809caso318171485a.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 05:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792411520; x=1793016320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7PduYI4Tzaf1zqS1KtjsVUZmBBZtwzNJ1fbj3zZ1iTY=;
        b=LV6ZXxt3vcxkwKngsoXMp+bm6HXSOdMHetBIdcjJvy8bQQIhrusvISP9Ec7lVw8VpX
         YlG0nIZhjAavdBoPU1eRzSrHrGYSxweV2I66cyCh3epCq3ZedFvEN6qti3vu0TGmVdDi
         Q0Sxu2ftzgUJwS4UFCQfzIvom/xMrgblXYVQJ1zSco1tWh8puA53XUTWZaqRIo4yMHHo
         aoSImUnLIz1wCg+h64dCcopQZPFK5kD62AYTdfRXcEJ2HSPdIDJSmkjH4WwKvsapTcjj
         GzNBkhJGnZzlIRJO9tMGd5CPPFHPScWqXvnrpDZ5d4X/UYBcGiv+f96J6pISUtMUlUmz
         dQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411520; x=1793016320;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7PduYI4Tzaf1zqS1KtjsVUZmBBZtwzNJ1fbj3zZ1iTY=;
        b=C7ezOzyI7kJRTHcg0JedbEcKQ6KeP01r6ZyRoU5TjE+UecEMGNRUz/pwJUcX6qdgaK
         R7HuvSFURZPg6PSgV5vrgunYUKJIMPNUBfx2S2N4A1cuPvQ2CRbRyKH0Bb5Z1O1yLaph
         kOevmseKEX2FKrxfHJylJBR8dz+yHpT2R5Gl/MVwq9TSFveZQ06zz4J18Pfrgx67GB6V
         SAWU31+CccmIJ+akuqdoM/ZaRqmr18T4ht9t9ctswsF3heV4noyZk6JWkfgQdMR2oSqZ
         eKVIvlD7U52GD90z1Wo55jtg/nDMtPvpHhqJz+1QF6gH8oN0jvgG0595z4S64H54f0GT
         U5bA==
X-Forwarded-Encrypted: i=1; AKwUvBwTGs49bONFQ8ou5aL9QYtCEnybIIY5lf3CbatzBkz/8HddN7papYdvnGphkNBx1Cu//7KaKGI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPg6litvuhM+Jh0dX0MnBcSUmFXTqum4+lINNujjQycA3UL2Fl
	QnGUras7Q5wnHOCBORdZK0me1U4hgvzM7rBo4P/Xwu6eculWfLVYTiVETtxG95qk+plujNzQcwX
	0nQ+Bx7Iau6rRhhsgSxqgw7ymXNjJMoQLOChzhiGHXW0Cvg1I+gRWtyrnG0s=
X-Gm-Gg: AYBFou33afSlgZLdPyQd2CBxvLaKmPCt9bxM84tystZeeHXjctHTafcAtUvXU3dvDpp
	5YJyUpmUBGgA9ViPxTE9P70XvrM8NnaWYbwj/p1iLeOE286lmenjkYhPCHefVfNa49cOVqdPdHt
	4ANDlI6H3d31CHXKg8OU6l90hQbZbgX0g9m7AbTyPqJCndMBYF0s0YbyhA6COPko1hDX2aBbIwx
	Ay0k0fhwFXz1WKo0PbZ3aQ4hYaBIcvuSceP85Pboo7enXhJXlOtkuGASW8QO0leuuOKBjzYol29
	J1qRsROYucQMy9KDuOHXs7DQxJ/vZxS9vypETgPIRq3Nlr3GTkiL601T/bqwkTItt/muCaQ9Bt4
	sPUKUwQeSRqKqQTNIBkb4C0SrpQnTeMp1Aw8iqMAVK+Zja/d3mnNxrnNaPRhmx6YMcRnMIX611P
	+51UeKD0TPH2eo
X-Received: by 2002:a05:620a:288b:b0:93f:19c2:da4 with SMTP id af79cd13be357-93f29d6dc2bmr1161716585a.70.1792411519868;
        Mon, 19 Oct 2026 05:05:19 -0700 (PDT)
X-Received: by 2002:a05:620a:288b:b0:93f:19c2:da4 with SMTP id af79cd13be357-93f29d6dc2bmr1161701185a.70.1792411518459;
        Mon, 19 Oct 2026 05:05:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a434e4csm2008275e87.42.2026.10.19.05.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:05:17 -0700 (PDT)
Date: Mon, 19 Oct 2026 15:05:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>
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
Subject: Re: [PATCH 3/3] arm64: dts: qcom: lemans: Add Draco EVK board
Message-ID: <3btrmmavq65lp7rwmdx76qjvaseaoa55xdibdli2izujusebhw@fkrtjiqsnvnt>
References: <20261019-lemans-draco-final-changes-bringup-v1-0-dcabe94f1074@oss.qualcomm.com>
 <20261019-lemans-draco-final-changes-bringup-v1-3-dcabe94f1074@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-lemans-draco-final-changes-bringup-v1-3-dcabe94f1074@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 9vjxELfHEUkXGkg5V_X1BArGXWFm0XFR
X-Proofpoint-GUID: 9vjxELfHEUkXGkg5V_X1BArGXWFm0XFR
X-Authority-Analysis: v=2.4 cv=H7NOUOYi c=1 sm=1 tr=0 ts=6ad60780 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=8x1eZdSFF9BeWPnRFlQA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX9d9c0ukfzEAT
 d20dEfhkwlp7DmR2AnR4xI6g9rlKgFVVI+ptEj47xnSxaZ8ZxfL0FLN0hBP7lPB2hS2dw0pLEmr
 POLgGJqHtC8IX1fCWNAbxoqKdOtkjEua5FYRXVRXFWFVmJmu3HYGrgdSwGjwW0/2UI34XGHU54O
 jqcXxe4Y6rmO4wF735uc5VuSyz17lqkmp2uEq98lebiId20IscxHxkpHfpdaH/L6f9AP7/20pnK
 sUQNLzgDJ1doDP/piv/8Vp3Rdma17ys0azpC1gdZgdp3yhKIu2BmB6VKkmIr27I/dOodoON5B/B
 w440hlUHnmn1DpYmB9ye7ZOT5oOp0l+Xrbz6vm4cm0f7I/BAjvFJKFIC1ZryzvKYvYQnu3F5E+P
 vrTcYfPvHXHqzsv2g/yT9pbwUIKBQvtb8sQOYOy00C5ua44dMVO8vBbaTyd8CdS0sjqq1YseV+L
 bc/WnTdFHOFjpABs9MQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX+KGq1zx/0j0Y
 fMIP4X2WXTTmTFnTjcFbyvGivNYj+UCXqQIRGdqtfbGGIZs3VVU8dk/jFy5k2GF/0+O8Jdr+5zr
 Oew39nOKzHCDfUcGqSGiPIMFyOif6vI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190048

On Mon, Oct 19, 2026 at 03:57:34PM +0530, Gopikishan Thawre wrote:
> Add the device tree for the LeMans Draco EVK platform which combines
> the LeMans Draco EVK SoM and Draco carrier board.
> 
> This device tree adds board-specific peripheral configuration on top
> of the SoM, including:
> 
> - I2C GPIO expanders (TCA6416/PCA9534) on i2c2 and i2c18
> - EEPROM with MAC address nvmem layout on i2c18
> - Native DisplayPort output (DP0-DP3)
> - Dual Ethernet (ethernet0/ethernet1) with HSGMII PHY over SerDes
> - ST33HTPM TPM over SPI16
> - AMC6821 fan controller on i2c4
> 
> Co-developed-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> Co-developed-by: Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>
> Signed-off-by: Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>
> Co-developed-by: Ajinkya Inchure <ainchure@qti.qualcomm.com>
> Signed-off-by: Ajinkya Inchure <ainchure@qti.qualcomm.com>
> Co-developed-by: Anuj Tripathi <anuj.tripathi@oss.qualcomm.com>
> Signed-off-by: Anuj Tripathi <anuj.tripathi@oss.qualcomm.com>
> Signed-off-by: Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   5 +
>  arch/arm64/boot/dts/qcom/lemans-draco-evk.dts | 543 ++++++++++++++++++++++++++
>  2 files changed, 548 insertions(+)
> 
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	expander0: gpio@20 {
> +		compatible = "ti,tca6416";
> +		reg = <0x20>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +	};
> +
> +	expander1: gpio@21 {
> +		compatible = "ti,tca6416";
> +		reg = <0x21>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +	};
> +
> +	expander2: gpio@22 {
> +		compatible = "ti,tca6416";
> +		reg = <0x22>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +	};
> +
> +	expander3: gpio@23 {
> +		compatible = "ti,tca6416";
> +		reg = <0x23>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +	};
> +
> +	expander4: gpio@38 {
> +		compatible = "nxp,pca9534";
> +		reg = <0x38>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +	};
> +};
> +
> +&tlmm {

Please make sure to sort your DT file. You have 'tlmm' node between
'i2c2' and 'i2c18'.

> +
> +	dp2_hot_plug_det: dp2-hot-plug-det-state {
> +		pins = "gpio104";
> +		function = "edp2_hot";
> +		bias-disable;
> +	};
> +
> +	dp3_hot_plug_det: dp3-hot-plug-det-state {
> +		pins = "gpio103";
> +		function = "edp3_hot";
> +		bias-disable;
> +	};
> +
> +	ethernet0_default: ethernet0-default-state {
> +		ethernet0_mdc: ethernet0-mdc-pins {
> +			pins = "gpio8";
> +			function = "emac0_mdc";
> +			drive-strength = <16>;
> +			bias-pull-up;
> +		};
> +
> +		ethernet0_mdio: ethernet0-mdio-pins {
> +			pins = "gpio9";
> +			function = "emac0_mdio";
> +			drive-strength = <16>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	ethernet1_default: ethernet1-default-state {
> +		ethernet1_mdc: ethernet1-mdc-pins {
> +			pins = "gpio20";
> +			function = "emac1_mdc";
> +			drive-strength = <16>;
> +			bias-pull-up;
> +		};
> +
> +		ethernet1_mdio: ethernet1-mdio-pins {
> +			pins = "gpio21";
> +			function = "emac1_mdio";
> +			drive-strength = <16>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +};
> +
> +&i2c18 {
> +	status = "okay";
> +
> +	expander5: gpio@3c {
> +		compatible = "nxp,pca9534";
> +		reg = <0x3c>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +	};
> +
> +	eeprom@50 {
> +		compatible = "giantec,gt24c256c", "atmel,24c256";
> +		reg = <0x50>;
> +		pagesize = <64>;
> +
> +		nvmem-layout {
> +			compatible = "fixed-layout";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			mac_addr0: mac-addr@0 {
> +				reg = <0x0 0x6>;
> +			};
> +
> +			mac_addr1: mac-addr@6 {
> +				reg = <0x6 0x6>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c4 {

More of the nodes in the wrong order. Please go through the whole file.

> +	status = "okay";
> +
> +	fan_controller: fan@1a {
> +		compatible = "ti,amc6821";
> +		reg = <0x1a>;
> +		#pwm-cells = <2>;
> +
> +		fan {
> +			pwms = <&fan_controller 40000 PWM_POLARITY_INVERTED>;
> +		};
> +	};
> +};
> +

-- 
With best wishes
Dmitry
