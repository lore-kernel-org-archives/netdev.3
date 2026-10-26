Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032081;
	b=kmO+gmeKC/Ce5pmZUHvzM7Jyk25sMDsnyX47pOh1Uz8o7QDjX7icNhlQHgdxy/3Sd5OQ
	 wZCxoeVtVIp/cdOPddmKZAni7KNYvahx/UJElIk7PzAPB2343D2EgsuATCnKDyBWmHfEu
	 vPJ6IYjD85Fz4jQZVAkboHnwWazoXbKMfis0y61rdLMnOsvAvIHHLvcJ6c2mSRXSaFk4s
	 eBhTRZaxT8JVicZQWB7PpuobuW26EddSVQPXzO9QjaJb8WsvCa4a1K0C9TYhnnOG4I8v8
	 IVtxyvhLmgBWytw7YB2qFqq1mRG0NQq45f3Gm3eFQ/TmMeQWses8c1vswLz0jCmN6dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032081;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DgbFgdGwx0LxvaVp9RgzD0rA2Eaf0b4Fh1Y0S4eeYow=;
	b=BtnPHLoU8uS9YuryrJmcwIMDJ1dx8H4kNk3mrQEKVn3XZnkms/U6Tm5gwtj8SNeaKML4
	 bTj8FH9jcf8jHK2yKlObdeEBaRv7B7BmDdBT3gWY24Soin/sg4M+RZwVO4vhhHiiSprEi
	 pzDuIHRlgp9MmlyrTjMikd2mdp9BzeAJyTtImBYuh+DhOZFXf2nAFxRpcj2rQNZpdgU14
	 FCsKjcP0cAj71zfZqsQOH/GIkAyvlhL/7ELg303XKtudaDUvR5xgpIP5NqsUA5trUXEm9
	 4ggjksUb7W8uIIfo/ahBG7IQLC4VpOtofLr0SEBI4H+qmJOeqxn/L4gcnGIC5dWTTjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Icvcr8v8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j6gLnBcl;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD8C606A31E
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCD8C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Icvcr8v8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j6gLnBcl
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QEvdH23618600
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DgbFgdGwx0LxvaVp9RgzD0rA
	2Eaf0b4Fh1Y0S4eeYow=; b=Icvcr8v8v7hK8qcfYwrBYrcqCMVNXeTz3YpTKEXg
	mdmdJ5SuXbVcw945UvK6fUFy7RYibLBAbrK9JVEJ/fBsyVazlw4CvovBwSBDax5O
	JFmOcSwc4pt41RSCoZg1HvxRc1DExZgWUj6rf7TyerDYnGku69EpU5YAb6BbYBHl
	Unv+vZJOfYr5sPnBUerBWR0/68KBwCeb6iec/tGteUwt+VAQlg36QDA90tpD431j
	t36hoZZwXXNbjJsr+hg9erH4C/+HvLN0VMZSDlXwNuDpKa6TWnICxKknknZ1X29L
	j+yCYLrKXmPub9xBgoI8c581p1fNBGyfyyLZjkwCWEt9cA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj79xruru-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:28:00 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f5844cb60so14622285a.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793032079; x=1793636879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DgbFgdGwx0LxvaVp9RgzD0rA2Eaf0b4Fh1Y0S4eeYow=;
        b=j6gLnBcla2HE5aRaz6IunowyyoGLQREkoQaaGRXLUmzgEmASZ3EIX9yDjYlRi2aJCt
         iaoPRJnVL8yHvAuXgk2VE1Y9KZ/R4QNFMaqTZhvJocKBhKo5xBHIwJcomERoxFuEKN2m
         sQbXBCWTBalS8JM/Jq+aRBdVt+QW0FKqAQL58tKo1EEfoKgiZ6Tl7HczpZ+KPRxbIgs3
         30pnAnMf3xxN6N1xIP557rsB0zrICK3iGqSioMzighwpAppjobXnb5Lu6ktIaInE7cmx
         xjjLt6JznYJ3mKKl7B6WbQch4NDP7DI44wRwuU7p0EQcjv9TIlTvnNCyddQBpuJlG74W
         2N5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032079; x=1793636879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DgbFgdGwx0LxvaVp9RgzD0rA2Eaf0b4Fh1Y0S4eeYow=;
        b=Bk2slaYYVjD+Glj/QOy2mx0iUV2D8gEad91UCLBJqM9iyP4wgZKuU1CJLjuu5F//ds
         nB7EobplyJHIpX8Abh1tXMR5Fk/Xq0WINtxCLG+hV4dyvLqJltyNa8MlI8Yj9zQfcXxV
         yKhHUPHyFOm2QL0MtLS1mciGnqyJLhMp/KNETWv5NNpJSSPyTLo/XtsySee4f/DjscgA
         gKz97QHSD1tQVkvLFSRLmBoVHN86Dv/sKQdD4EYpXM0hmKqVVvmgPJWEOWgs9R4LzoRj
         wsYsx+ty+YHAqNmK8A3aUDBRSZtwAG4psVaPTI56PNi4pLTAcFyvTxnrFgOEazKKbpK8
         +bIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbnj16URBHKe27kBUnK7paJ8NnMWxPtUQqEk+00U2ZuXyN1WWYp3SLxo/D/F085puWx6UzJpU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUdgiGyhZfIjdyOgFx3eaH73z2Bf4+kQogZcYZgAdoJPU2EQUo
	ZaCR5+gHgtXepF0I3L9AOZXg/8ENm7ARmJcMA15XgJO4C9YLhYInGCC9CC/9Jhn5nSiWqDzmpO9
	Or53tQC8qzpYDqtixuGIUjgzHuARhsPZjSO6IOzPxhrw8oMYofO1+vQFFyO8=
X-Gm-Gg: AYBFou06Mms3HX+fKmMGJjaHKW9PZ+gFVojalcVQCwAYWYblEXvLQnLjDlid8dmZYCp
	jnICt3Sz/QsinqBtVRuoaEHyQhTBYqBcSbpXAnXsh3NLvTRPkAThEHYMWK1SE6js3lbig9lkzxN
	AWhYxjrBwdOuVA1mkPJfwkP5xdDp9JSrBiZV/u1FyOXPEUt5+rQt1ZlCKDTiCQbPXasljtdvRbk
	1cjPZYI6pDK+h0Js4XRtmQ/3nPGSKZTWZzlc0wfajBYdC3REwetJw/JmTXBymHDwUj18oYYazVN
	XZdORGniaHC3V361ged070OzOKBqxBsNJb4UxRq4JzTxYpZ4cYn3ZklKKTKzPdjvYiIzUOp8+I8
	XhChs4TwZMFy6QaNx
X-Received: by 2002:a05:620a:27d5:b0:943:2746:3c4a with SMTP id af79cd13be357-943f4a05fb2mr32408085a.5.1793032078947;
        Mon, 26 Oct 2026 09:27:58 -0700 (PDT)
X-Received: by 2002:a05:620a:27d5:b0:943:2746:3c4a with SMTP id af79cd13be357-943f4a05fb2mr32399785a.5.1793032078257;
        Mon, 26 Oct 2026 09:27:58 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb902sm18160539f8f.24.2026.10.26.09.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:27:57 -0700 (PDT)
Date: Mon, 26 Oct 2026 18:27:55 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 11/12] arm64: dts: qcom: sc7280: Add GP M/N clock
 controller
Message-ID: <oxkqlvbjnlji4zyx7frurfjzf2ryfkbjjirwkewtp5trj7q5nf@pg6pogt5z6pi>
References: <20261026-b4-pdm_clk_gp_mnd_v2-v2-0-ff8e4bc8d567@oss.qualcomm.com>
 <20261026-b4-pdm_clk_gp_mnd_v2-v2-11-ff8e4bc8d567@oss.qualcomm.com>
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
In-Reply-To: <20261026-b4-pdm_clk_gp_mnd_v2-v2-11-ff8e4bc8d567@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 7unmRXwKKm2KW5_IQSHmzWaUUSGr74l4
X-Proofpoint-GUID: 7unmRXwKKm2KW5_IQSHmzWaUUSGr74l4
X-Authority-Analysis: v=2.4 cv=FPyOVOos c=1 sm=1 tr=0 ts=6adf7f90 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Qvngrl3H0rQgGg+94q4QgA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=oTvOlQyMf-P45GjRKUkA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX5dPzAwGVtXGX
 QbYh8/Wt2XwkO6WjMUmcsv7sez7YU/JJARBUKt0RLKe7pYpN5gsPdJxHXbqWwoH1njni6ysZ+Sb
 fiCBYySz+rhj9Pyk8unVWd+KasyyDKtHYhs2b3T7Q6+puEt61WvZ3A2XmbE7VnKnvtxLvBApRpd
 9X3lxTQw98JZz8BTFTQXqIy3bUwp+cWjH4gGAppHuI/hXDnaOkTP/3u2rkdm7GQHj25CxCuD5I/
 SDARBxBIYdUjEZD7oF5LmJnxdoQ6+qTQm9NGRRLJJiLXGljLL8J9YqugU1WoYgO4EfDEvXy5EfX
 KXk05b+voVAMOU+ygIVhII7aamBaLkG+92C7ujwhwvuFMG5+UscoZuPonzxgcizsk6TSsn6nRmP
 lvo0mVXDU9zVwO2nqmMesdTmvOhZOGd2IEoLBL96N2+41WpACsNJvPeW2EBeiBcbppfmwv6eYk0
 lrwep2OyhEs47d/El/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX1q3Ds5oavtGa
 nuiuIA9Zy6gMRA7qRVohZBDTNdQcuOXqZHE1746gKkde+e5+LHpvR7rkGCkNvQB4kZiDgwUYv5D
 aCzeOtHA/m/5uahuUtTRymSvnLchg68=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260065

On 26-10-26 16:59:37, Taniya Das wrote:
> Add the GP M/N clock controller and its pin configuration for SC7280.
> The controller uses the PDM XO4 and AHB clocks from GCC and routes its
> output to gpio60.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kodiak.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> index 8c7523602d2719775b8f5c6a8cef138a93292721..de27a051ee3b0e9046ff97b8e6fe0164985d7b17 100644
> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> @@ -4442,6 +4442,20 @@ usb2_role_switch: endpoint {
>  			};
>  		};
>  
> +		gp_mn: clock-controller@88d3000 {
> +			compatible = "qcom,sc7280-gp-mnd";
> +			reg = <0x0 0x088d3000 0x0 0x1000>;
> +			clocks = <&gcc GCC_PDM_XO4_CLK>,
> +				 <&gcc GCC_PDM_AHB_CLK>;
> +			clock-names = "pdm_clk", "ahb_clk";
> +			#clock-cells = <0>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&gp_mn_active>;

pinctrl-0
pinctrl-names

Same for all other patches.

> +			assigned-clocks = <&gcc GCC_PDM_XO4_CLK>;
> +			assigned-clock-rates = <4800000>;
> +			status = "disabled";
> +		};
> +
>  		qspi: spi@88dc000 {
>  			compatible = "qcom,sc7280-qspi", "qcom,qspi-v1";
>  			reg = <0 0x088dc000 0 0x1000>;
> @@ -6653,6 +6667,13 @@ mi2s0_sclk: mi2s0-sclk-state {
>  				function = "mi2s0_sck";
>  			};
>  
> +			gp_mn_active: gp-mn-active-state {
> +				pins = "gpio60";
> +				function = "gp_mn";
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
>  			mi2s0_data0: mi2s0-data0-state {
>  				pins = "gpio98";
>  				function = "mi2s0_data0";
> 
> -- 
> 2.34.1
> 
