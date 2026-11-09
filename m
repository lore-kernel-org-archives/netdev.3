Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213809;
	b=qMJOOAIoggSTnFenRv1yXROmJ9ihdAHIfGjoZnrBN007Mw/WpGDFc0GzgRU9SVUATBQC
	 ltBdHhLNXSoIYh+KS+CI+ySqQfwOeURKiGFOJ2rYrhbmcrnZlwAWpQtN5bRuwlyMTrF4N
	 rkyFCJG0fc1lkEkVJeiseJ/pZkyIas9XDvrlkertfu775oc8Lq0MNpBsxhhkMLRzMuXds
	 KWp62fkRgkx7Bmdo4z4TkV55onPsLYszEgmSSaeSZ5Bppmfz/8yh+pTwkTeI3ASKyLM2o
	 tNs5h+l2M1UVxUw3msmNtI9RsBc1KOV6brqrRIVkmc1IRhu7GRuZa8YaTgIMDvEF2Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213809;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=e+emj+6qiNrOat6TM8hv2pRrM0n+mR0YQ4yCLVvt6qk=;
	b=BQsivkM5VreBxORo2S3JP5FYYPx+f3Oab/AZnqyUsrC/5Nyxjs/qyDMDnng8CWpOhfzf
	 srIEh3ackfgjMZmSHpuxIXWGdCxeBiJIiUc+hhps74toMDm2DOpedzWqeZ1LrsdpQjBZg
	 82ps8EoIhjRQ+bwh0hsT2RX4oRpKgPHvh5LNE7QQ9sgprhFE865YdzIfUSjlOryGn6mQt
	 XfVtDquRnsouLnMXaBHZoy4fQIuMSqUmXAG7IAKQ0y/Jjvdk15OJ4xCdvhX5xv4cPnMoM
	 PFuMCnJa9WbbSByS19qXqkBKZJb5cLHiJlzuILBVlA9TVG2J+WMDwINEqOQFWdSBb6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GOfghSB0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MrQEXIHt;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C40606A322
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 08:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15C40606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GOfghSB0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MrQEXIHt
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96A9FN056088
	for <netdev@vger.kernel.org>; Mon, 9 Nov 2026 08:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=e+emj+6qiNrOat6TM8hv2pRr
	M0n+mR0YQ4yCLVvt6qk=; b=GOfghSB0/R60EzbDLySz6wvf+BFuGwqObvUm/K1B
	jjtXCbBTpoPoGnz4urnxpY4KQPwKrKeNKzzzuhMNFjnRRwIP5fbNJbNUPxsuX0yN
	LbU8HCjYzOUJ1BHRQgeddyUjwCE/GEcCbs/cuUQLJtmrgmbfUSoW6/uUTQfuGJwG
	N9/vjz+8AJQnQP9IrC7toRsMMuUOuEB1kziydvF7UzIJ0SCguBrXgoXSnBW6ODxC
	2E4omYL+JZTEktsv45YeL/oa04f5We2TZXeTfC54cHC8gn7TwtxZ9tgdSjnqrJES
	ySaf11LBx21aUbSKeLmsJkdTVgrUrysoiXlBJWvaHlEFmA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4htuqm2awh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 08:43:27 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36f26e6abe9so1293878eec.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 00:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794213807; x=1794818607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e+emj+6qiNrOat6TM8hv2pRrM0n+mR0YQ4yCLVvt6qk=;
        b=MrQEXIHtZKClR55jtt83FOeFas7Mkczfn507RQUbBimJc2NHuAIcizsmlYZIv3+Dh0
         5iX44Yk5BbvJfDwrwF2oP9yq+kCcG9zVnoPiUMKKxnPpTBRSvRBHlHfe8LT0TFdUXIls
         tFeb6zDIwBaOtrxms+W42SVqhbYdABuCM8Q5MShUk3FqSWUmIp8+O2ya/wMA2PsrESzx
         anyxjhXyeSoxKb3hno77dNYftdZvmX/6yfoxn0RMwkr85dp5c/EOQr7OcNaliWx0+xrj
         02D9qWq78udH7taFc3pg/iYcj5QlmHfHz+sAU5qgqK8T6qWLQgtBxITUElM4MxEQz0GR
         SiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794213807; x=1794818607;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e+emj+6qiNrOat6TM8hv2pRrM0n+mR0YQ4yCLVvt6qk=;
        b=uSdazK13eqXuBfphG6+mVxpAho3ggDl32jDYHJoeGGoTcWzklQ5y1Esfm/fk+xjMkL
         m4GlxfcazUoFvf7mHF77YvCRhQRahiqmqjTJTufpiRfAHnk5u4Bm8o03ME+8KU/M74Ay
         VHy1nVOLXVq0HdwIqSDaDmdp0t/VoQdEkvKCvAh48AC05uEPrtPu3dZxP1DIPEFUI7rk
         3FSzx+xlgN5RqaN0D/AZ/rSOva3AirUnRe3oNES72SHfr2JCKOljqYniMMut9S4WP651
         2d8lhJZoJUS6pBHbWZbGwnvXaP8LrYVaArzZ0T+8SZQHnZU+vuKn0/z4liM6nUe9bjZC
         5Z5w==
X-Forwarded-Encrypted: i=1; AL+hErErNvmXFGXeyhQ/zeShuUcLrZe30HzrgDTqUZxAKVFUR8nQ6NChjBF7DDfZIgFYI+Hdh3oirDg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vJASj3PgSXBJIpmPwlfQKXMNQ9vEaTqVeE3my6kwCi+7Guf4Q
	R6GX1RNefOM4lFfd32eF+GCDCuz3WLWSmX9AHG/ExQLVf8OG14a/QpNn9EM5DfRY0tqHefKkxfg
	5c7k34K8D+xx2Zo/0jX3mjR0qiPtbySj1JsXrdf14FlnUCfLC+oKU6ITHvyA=
X-Gm-Gg: AYBFou0AH9xSDNlOkGdyCwUxR8dvrj0aEhHIH0/21aBgYTFxFWrNHqXSqH2ftL9NHxT
	Nw1MbsescMfn3jMbh26lyP4Js2uMsMihBG0pmHfiWoyuxq6FZtKRsUdjtMCyMd2DXO/O5NmmIzA
	2ehUdndye1AauClZH3kTyJKTLfuPTVjrsXjSORY1FlfvZkNx0+DLmTRLz9hkQlONH40Vhz59wbC
	ETjEpJLr2Gpq3erbcPq7BbzDHcGR48NwQmkxR+g/EUce43mKfRah+Qi6dD3MxiniVxJIC7XtGCz
	JSv+9JpSikhXQCLpASGFAALcgAwpFSckU1F3+kBkdV+RiJ1FaUovLx4JabMNp1odOyXMjr4z1se
	P8jdwPiI8v1GfEmhb2iBrnU4zQ6pqIkfzj1YqnfOTLm1S272kk1BtJqP5nutW28RvpiiDjVC+KV
	Y7Z+vi45P6fZMIhg==
X-Received: by 2002:a05:693c:864b:10b0:36e:c213:e03a with SMTP id 5a478bee46e88-372573d242amr7233350eec.10.1794213806936;
        Mon, 09 Nov 2026 00:43:26 -0800 (PST)
X-Received: by 2002:a05:693c:864b:10b0:36e:c213:e03a with SMTP id 5a478bee46e88-372573d242amr7233312eec.10.1794213806393;
        Mon, 09 Nov 2026 00:43:26 -0800 (PST)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265d05514sm11077499eec.15.2026.11.09.00.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:43:26 -0800 (PST)
Date: Mon, 9 Nov 2026 16:43:19 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Imran Shaik <imran.shaik@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 10/10] arm64: dts: qcom: nord: Add support for TSCSS
 node
Message-ID: <avGHpvYV2Q6T3vwd@QCOM-aGQu4IUr3Y>
References: <20261108-tscss-v2-0-d5f575010427@oss.qualcomm.com>
 <20261108-tscss-v2-10-d5f575010427@oss.qualcomm.com>
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
In-Reply-To: <20261108-tscss-v2-10-d5f575010427@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNCBTYWx0ZWRfX6z1F+IMbUaNB
 hxREfzT6Pj2cRfs2vQYz/xLLb3SI2IF+78hMvGqSR/Roz8B2+hbZaQ+LZZFzxeKufxAYoIEu+8z
 siuWZSdaEOlrWVM9SCff0yEYoPG0kwo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNCBTYWx0ZWRfXzaIHLnjsPorH
 K2GYmWLxIcDE9w5Eg3RUvUI9VITxusuccRvlE23bVEcYOt1MSL3y3rwf3IW3niCEoq2d4eSEvqD
 qNAiKwXZsSeC9VPb8SRTEWVB7NRgxDe1zhS4a8oDSuyRolAPwtRNUcvxDAzeJsPisbAtnQ8SuU6
 fjurQJBMtRo/KS/f4s4N7hkpGztUUX7Q1UNUr0dBcRFdvRKAhl986bGKYtu9UoeSKSna2IoL7H2
 rOBq40TOuNc/rGbtTqu4hsOuB689ryxegR4wl7JBrc2gIn41q9lffAkK+Ov4FLxnLYYsYMKU9EW
 5JDMsr1321OAMK2pTAGWY2iA1TI/DYtL3eiVh3tMoxYFdEdtqWA65f3CDq7dV7LVzGdEiJxiG86
 nu3eymVe4w7f8r1E+8ayCOYRQXrICBmZOzTPi9N5BZiMlGAoLjVA4yrBvEvDuaC7m/ff9ps+Rla
 IRLZZsQXF2cMGp0l/oQ==
X-Authority-Analysis: v=2.4 cv=JLquIMKb c=1 sm=1 tr=0 ts=6af187af cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Fam-3tgAAb8rIOWbl-AA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: uDQWcciu-suqIY1fBk-nIZAvwj8enIt-
X-Proofpoint-ORIG-GUID: uDQWcciu-suqIY1fBk-nIZAvwj8enIt-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090034

On Sun, Nov 08, 2026 at 06:48:31PM +0530, Imran Shaik wrote:
> Add Timestamp Counter Subsystem (TSCSS) node support on Qualcomm Nord
> SoCs.
> 
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/nord-embedded.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
> index 1ab7d9bc3cfe..1d5f27336f73 100644
> --- a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
> +++ b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
> @@ -736,6 +736,20 @@ pcie_data_inbound: interconnect@1c00000 {
>  		qcom,bcm-voters = <&apps_bcm_voter>;
>  	};
>  
> +	ptp@1c80000 {
> +		compatible = "qcom,nord-tscss";
> +		reg = <0x0 0x01c80000 0x0 0x2000>;
> +		reg-names = "tsc";

The node should probably go to nord.dtsi with nord-embedded.dtsi
supplementing Embedded specific resources like clocks.

Shawn

> +
> +		clocks = <&segcc SE_GCC_TSCSS_AHB_CLK>,
> +			 <&segcc SE_GCC_TSCSS_CNTR_CLK>,
> +			 <&segcc SE_GCC_TSCSS_ETU_CLK>;
> +		clock-names = "ahb", "cntr", "etu";
> +
> +		assigned-clocks = <&segcc SE_GCC_TSCSS_CNTR_CLK>;
> +		assigned-clock-rates = <250000000>;
> +	};
> +
>  	ufs_mem_phy: phy@1d40000 {
>  		compatible = "qcom,nord-qmp-ufs-phy",
>  			     "qcom,sm8650-qmp-ufs-phy";
> 
> -- 
> 2.34.1
> 
> 
