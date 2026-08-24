Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41923B3C11
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561838; cv=none; b=mbTOw65y08dnWyH2h8s1sk4PftYLD36wwwIEYI4+vfx1NxDmuofayaalT+9rErN4XXDsxlvJPEXDUqZGC0VN1wR+zwN3khRHqkxxV5R/0UcgXiwrV9vaGUEGiyx+beW5u+l9PPyTIMC2rbYDeUw5eawr6ixeTZz/Mqm9r6hzA2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561838; c=relaxed/simple;
	bh=n/O40m2GZ/yzb5oqxUkC+dBG0QysdnWonyA+OmACEtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jObXOrVArbSeL6rR+m69P/OMaHpUhVujL/OTrEbmrbHgiNn3glIH+EfZxOfDT2dqzT6OAvcwzDFJ19npj9WaV6mvtkCT9tU/Dxhvk7iotMVHhP5fqo0lLm1NMtesJ1ibjWz/dMUE4ELm1BEzpAIvGAoejEeSLLBnyIQ3rQ9Ehaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gSTvfiCP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E4VnZqaK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gSTvfiCP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E4VnZqaK"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O8U7aT3018465
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FediVK++eWEGtqNNfanEj1qRZ+5vZO6tRsceojvl3NU=; b=gSTvfiCPiy6tBTT8
	H8xD01Dvexde2c9yveBahOyv+6rWc4h6vR4tVDiWFdO7sbDVLYVUnupFrNRGzpE4
	lHBSyHqMcQ3r3fo57LBmJL8xZrrxQZqs9URJCUiYYSHjS4nzhMsBNECoro8hkZ7T
	KwHhkn3dTyYiu2sJvOF6ZpGjr0GcW9EVMN891cxQBZpkkyQylhCzd6XUYim6/Py3
	ishbu7qmKPJKdZHtFCCY6O1XwZpw2gGqc2bdSjP807BzmGlEkRvo+LRWMS5qOraL
	gyZEONUUALUaSbrUfA0SCGOpI+AQaPQ9BbqGskZSlsmgucNXR5Is0ImWUYdlOLfy
	Mbcv/w==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8jgk03rr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:57:15 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-737ddaf8c57so47478137.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787561835; x=1788166635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FediVK++eWEGtqNNfanEj1qRZ+5vZO6tRsceojvl3NU=;
        b=E4VnZqaK+UqwbHYSbGizgyLqfDwCMG1EjkNW8+ndYa9b0ps7fET7TilPsEesfwFUlw
         HGxMwGVPv+OJnv11wYYVISK36nCIvI/hDToeWyx03iijssVoVouVvPUUhofVUb/3tUmo
         6K4Q5G0jyk9kzmp9WchRxfhQpPXV85eqYnRWPY9jZTtECpve6qvK7pqRhnqM8HgqYO4P
         BcpsBUSPNZB6lcXknTgyH4viZKkN+xPfkH+vmgJtK+2FnqSTI5TTHNvjWYNA9UhLdwXj
         1+g//RlYEyG550P51EJV5IcJl1yekXLTBSY/RNVcAO+sAAwEsdrQiITPJj1Q1natZdCz
         lvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787561835; x=1788166635;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FediVK++eWEGtqNNfanEj1qRZ+5vZO6tRsceojvl3NU=;
        b=mOvEkOzOL1QCs2SwaCYM0G3cPzs8XWB6oQyk1EAEJ2Ok75p79/tqsu2fbDU4kGcmVP
         uqtXJqJUoMinPuyOfQ4vK/8QM2dTx0dI7BxW+LBzM0T3QnJqRmTy6ONkfRruU/3mv09z
         8CEG3C/BZWN6IYOkABHdcS4F10yngFPJY3P2KkaJCARjoaorXDd+38NjjPr1qZOfvreh
         xi50pcGqQ9g8aXxRcrpYXyhp6nUEKHPCcX8+y+wAqYnryZXhTQ9tuImQeev8MOpDOZ/I
         pvyIXMWoZf8HKGH7NSBWYfHVnqAGgdHjOdR4fsBZ9a1+xSHPOM5qXQFVO1yqEZFMwvlj
         xkag==
X-Forwarded-Encrypted: i=1; AHgh+RpmXEgyjNrlHPaBbx1iVtZPtGLYvw+ya4KIAXPttV7xyfO4avk7fisJlKOk/QUZPRCtKfJHbwI=@vger.kernel.org
X-Gm-Message-State: AFuF++kx1foYjV9DH8TH/E6jMsK9W1Y++bf7ymUA9pluvyMNQsWsHZGc
	RcU/KGRCO9xH6g7z1oBAhQhXEFIQ/oEaSl9oC+FB3OwlbuG8XzeU5McgeeHqOYpy6EzvnUxxapZ
	8Dc7sVvJth7BFWh3Fqt55KRgZH7+6WRIa0qDYC2RUQDNeHU77oRh699SgcHk=
X-Gm-Gg: AR+sD11XXJrHIsPD0+wMs181r+ehGxlE8r41q63nxdc0f2jZPzW/Ie7tPwZs8CSsIs5
	2OuHQhZiKsk2m8OvQE4nBa7qDFHN7p7u13zuvF+QIJqxk0s4TzQ8Jia/LxZMPZ2wolqgoeRsW7K
	wvdXnDyloasP6nLX4PXNqRrKtFpRym6KNH8byhBzJOoUtfoU/LOYMPudalPN6basEucVzSlYNp3
	9cxKlNcA3MU3t8NjoO6hKbTOMp+mrOm2McvQK6gdj4vZVeiWdxr1HjkxOQGMMonwnTGqjkVvepd
	kgXDKJEw1j4SN1V6y7x2976FrAheIn01cMHdggwqtPqFmfjQ19EqoG85mAyekYpuSRfalsURiph
	AdsDyp9JSQpx1+1F/8fTv/Yyx
X-Received: by 2002:a05:6102:6893:b0:74a:b1ee:e21b with SMTP id ada2fe7eead31-77a643461f0mr3515310137.1.1787561834946;
        Mon, 24 Aug 2026 01:57:14 -0700 (PDT)
X-Received: by 2002:a05:6102:6893:b0:74a:b1ee:e21b with SMTP id ada2fe7eead31-77a643461f0mr3515306137.1.1787561834572;
        Mon, 24 Aug 2026 01:57:14 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e2ddad2sm7355677a12.30.2026.08.24.01.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 01:57:13 -0700 (PDT)
Message-ID: <0cc4dcb5-cc90-46cd-9174-029416e7f51d@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 10:57:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: add
 ST21NFCD NFC
To: Kristian Brox <isyourbrainfoss@proton.me>, oe-linux-nfc@lists.linux.dev
Cc: david@ixit.cz, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, luca.weiss@fairphone.com,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org
References: <20260818205940.1973944-1-isyourbrainfoss@proton.me>
 <20260819210906.2500789-1-isyourbrainfoss@proton.me>
 <20260819210906.2500789-4-isyourbrainfoss@proton.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260819210906.2500789-4-isyourbrainfoss@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pAvDsuRf-R_HaeyXc-UrELZBANSTeNs-
X-Proofpoint-GUID: pAvDsuRf-R_HaeyXc-UrELZBANSTeNs-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3OCBTYWx0ZWRfX2SnqqXpIVRHD
 Wec35YyAWqcrPF6XK8JXcg9MguXTmSjf0OxWnKYzaFmsike+2thhzrN8UnppnLduO9OwwibMt1e
 NskJWCL2d4Hom9SeS5K0yKzHL/64WqE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3OCBTYWx0ZWRfX3x+1rDi5NdLY
 5PcmihSvXn0zKxr3skyoJ+py0c6BewEXIQs7IafNoEml7j8keCW61P38Q72yLzJrkU0gsDjzLIQ
 MjeYSvnvLMNu8MGBUyz0PVYJNZEQlyfmkhcE55UlzKDv89GjSdQqapsiJF0ZKcRt3V5RZj4ch4H
 htw7zPkXDNTe1CGDNJXX+nLcYDidBzYsdlamTi3temXwTXPreFFZMOZyDXsge9Wh9KRvF5ahk1J
 IjUQtEfAFG48LP2GBbfWnAgMJVFLXfIBbutj4R685yCdQwSXiGHOd0sWmlqghJo6AVioxNgGF53
 aKkkuRqZGQTpbZczqAhQ1izMfjSTL88v7NcjqBwgNmDzVfVd1jeSvhX1iv0yj2GCSNfTOiZZHyB
 Jlh4lfba8zUV52C4J9JiSPXUUrx1Dz7dHKjHehne3XihvENS14nXd+byqrfKV8xmS/vGt2/XBzJ
 kwL4BvS7FgYTsGvX1sw==
X-Authority-Analysis: v=2.4 cv=KcvidwYD c=1 sm=1 tr=0 ts=6a8c076c cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=FWA6L-ytD-VELHUIOsEA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240078

On 8/19/26 11:09 PM, Kristian Brox wrote:
> Enable the ST21NFCD on i2c9 (0x08), IRQ TLMM 41, reset TLMM 38
> active-high. Compatible is st,st21nfcd (raw NCI).
> 
> SYS_CLK is LN_BB_CLK2. VPS_IO is L18B (vreg_l18b). ese-present and
> uicc-present follow the public schematic (NFC_SWP1/SWP2: SWP_SE to
> SIM1, SWP_UICC to SIM2). Reader path is tested; SE/HCE is not.
> 
> Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
> ---

[...]

> +	nfc_reset_default: nfc-reset-default-state {
> +		pins = "gpio38";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-high;

This line is unnecessary, the driver should assert the pin

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
