Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027085;
	b=NMeB6EgcDmE1lUlCqylYVkjX2+uc4e+AvbYqoLdHnNgZtS3Z7FO3pL7C+MZ7T7U7920M
	 nk7K8T/eMWASs70MJcJ8kAczkfpI2X0mvnAss+UnTsJPe1h4Us9tRs/+LoY3tf34BJXsU
	 KviqCclFarQCiWYzZjs5nLesq81fOhw4Gnwhj7qjoQzPu/9RpJArvfCtdDF2r+cN1lv9G
	 u5L7ndxW8GaPEoUGQyPonFsha7J3aPUO3j1YCbJb+tTCcjMOkah7/JyWaijNV+CJflhRI
	 v2acDOIfhOc/GqfQihuuaLS2e3poze+HdVJlWCgxtrvPQOfY7vEzHcUwBTN1LYvcI0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027085;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GcaOJI2AGlsc/iw3sTAv3zZNex+qopC3DMZYd+jAZ68=;
	b=miY5upTcoroBKvcTA8ZGi1oFMALLRfPB22bXV2Z6dDhcmCFywTt8n+UXaRNPQ867UPNd
	 Aayu8mc+xwrLGKAqhj+qPLfRkYVekLbbltMcABDf1eemQiRrbHh1my3J3MrG9ngSHqGBy
	 KzJZ/O85U8ZwW7lff5ie9vXZfIX0Q3GgWh7Dt/OhkBbwFRRl9wqQVHv+NsLjRkqd4ObVg
	 kI3I+Tzmsx3dXmL1CsGIuSxFx4a61wmZnbZXbwdY8RziHiqTItozpXL7oNIgVTMVbUUD6
	 R4hgXlOxZo3hMqMnj6ieOXWJwVEqGOX+uYt7XGS0EZUXHEOn3Ij0OVcQNr7wD8TwHBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wp+k3qrI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VjmFmoeX;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6639606A31D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6639606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wp+k3qrI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VjmFmoeX
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QEvtNV2544443
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GcaOJI2AGlsc/iw3sTAv3zZN
	ex+qopC3DMZYd+jAZ68=; b=Wp+k3qrIh+YaEOH3QJzYJFTiZ7PA6rrOlmzaK3Om
	g0UQtEA9Q2m329GTlC66MyOtkGxhNan8rDYhGD29qFbh3ruypWMjsWZkeB7N4V25
	PVDGMXx2FRX7zkhbe8g03lJrugJOSeokhLe+NQBkLkKWvh6ZTmhF7FVg3oz15MSe
	s4rzCO9TKJi4nRt5HmUeuZ0tN6IDkXvxQuJo4rmVXIu9B2t9f8HzvWqepL8RoPto
	DKIgDkFd4WL6Tpxvo9UD7qZ+fgYSJgdY2NTb/3SDs4Fl3wdAx9GD+VF+JXynZlfz
	97b/FgepqeH7Za/Ssajp0IW3600ju/57XVxoaytBKsXkCg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj8smr3ux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:04:42 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-988b86c66e5so3376402241.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793027082; x=1793631882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GcaOJI2AGlsc/iw3sTAv3zZNex+qopC3DMZYd+jAZ68=;
        b=VjmFmoeX1gIg3U1SLoYXjP5pHsJIadjcDDRtukuCP6P7oLFt001C33ZLvqCA8ksUhf
         X4UITAixns5Ghdpj0oQokP/6kCyKxEIZC3St0NjOjOIN2QELdAddve6BGdE6HyhKF0dY
         lr/lLKpMIp4CvVmBWWByaoja0GfjFgFFuJBBtCHdX7hr1CIM8j135sK0lks7TnKhEs0U
         4pPaf6UKbdaSFLezt3uRO0yR9FX+3eETUKaZgV+5qJ7Hh8MPTN1DXQxk+jSIxx0bjvpt
         zAX+WUssAVM2kKHFHv82pedZPd6dUXhXzZP7eYkFPrBiccc+Q22zIR2CU3RSAcpHYBf6
         GmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793027082; x=1793631882;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GcaOJI2AGlsc/iw3sTAv3zZNex+qopC3DMZYd+jAZ68=;
        b=giDg6ZJaO3xWwoaOobrjiW3W5awQqCRge7PL+6u/gLEvG/EcwHpHaB5UKX+RFGWazH
         +n+tmbxPTaVwgGAlpVk94tzsZ9W3pLS8Vfb1GHLUfshG5gnFD4HaSBcXxuFC25IUYA2O
         cKnjBpoTHvY5zGvIGeMvKU2RJqngj7o0rubFs2znFaCLyo6VhUVepNe/wbegF5lW52Ip
         fkBbLHu3Uft18XqQdldlpyshZhaiyApYrYgvU07Bsf0ppRheZLKWGksuBH0pp67TDCB9
         w9tlDFurJlfFwVdQIe1qPtPMiJZDGp68JRxQCGyywSi7EV9sq33uqbuhVGmaPho875TF
         ByPQ==
X-Forwarded-Encrypted: i=1; AKwUvBys6wlYbU6YJb/UYO2FV4Dk7/K8JlW9M/WJQsAgDkZvdqKDjJkcXop2JRraZAiv7JTWaAE5nm8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYm6O7baSd1p/FxnZDb/hZTkc12SmmpOALkXzCfJQgix7lsNFU
	pzeEfwcquiaivmecaq1AsPLgkCKN4bTwG3696V+8lvQz/UzALgQui7Iu+3LyQPn7JuHSa7kR1qC
	EzcFn3uqT/vBy4KVg6N0iXjEt74sbL8Y/pxO8gZdBwm9nASpFVddXCdpH+yI=
X-Gm-Gg: AYBFou3xN1rL5vs3pgoTE3ge9pGUZKw6TG176d4EDb/2J40mpQ2XsxnzAlAf9UQkOdP
	482Q1/LyFnefSfrvdttu/aYC7dE90PAy+nyhWFtW0jMsDmhrAuIDykL3bAEdlOoQrqaMlUtBWAd
	2DB8B4TMuZ2mz18k1ztTJ6rkiPKlsU5S/Jk2r6HRyMjpp2a6FM7G3DUsIKsLV3Eq1Z3bblylZCm
	V9WP8Ngh8A811T9U8LBOhrwWNQQZiaBG9JEbTxeXcnpjg5lj4xD+1GtsHx0CSOj9AkLupz9rCqx
	jE/mCBiNr42jz+i8c02rb5V6X/x6V1o28wwQrrav7+f+GOVLAjaeOUuIzJmwNW3wdIyaYK8UGiN
	RaONIYkt5q4vK5fOC
X-Received: by 2002:a05:6102:1a1a:b0:7cc:a4b:b0e3 with SMTP id ada2fe7eead31-7ce5ccd81admr1188352137.13.1793027082062;
        Mon, 26 Oct 2026 08:04:42 -0700 (PDT)
X-Received: by 2002:a05:6102:1a1a:b0:7cc:a4b:b0e3 with SMTP id ada2fe7eead31-7ce5ccd81admr1188337137.13.1793027081345;
        Mon, 26 Oct 2026 08:04:41 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a5698f1sm200370845e9.8.2026.10.26.08.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:04:39 -0700 (PDT)
Date: Mon, 26 Oct 2026 17:04:38 +0200
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
Subject: Re: [PATCH v2 04/12] clk: qcom: gcc: Add configurable PDM XO4 div
 clocks across targets
Message-ID: <2zv6vf3kvlb2k5oopypae6fby72ykqyg4pb7mgiomzyptolez3@namz2jhghdgz>
References: <20261026-b4-pdm_clk_gp_mnd_v2-v2-0-ff8e4bc8d567@oss.qualcomm.com>
 <20261026-b4-pdm_clk_gp_mnd_v2-v2-4-ff8e4bc8d567@oss.qualcomm.com>
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
In-Reply-To: <20261026-b4-pdm_clk_gp_mnd_v2-v2-4-ff8e4bc8d567@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: u-gdg37bgJDt9ZvhyhjVlQ2nkEkjXCPi
X-Authority-Analysis: v=2.4 cv=Sfti5fRu c=1 sm=1 tr=0 ts=6adf6c0a cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=Qvngrl3H0rQgGg+94q4QgA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=X4WHrBvVKYo2O6Nn5h4A:9 a=CjuIK1q_8ugA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: u-gdg37bgJDt9ZvhyhjVlQ2nkEkjXCPi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1OSBTYWx0ZWRfX0YSx3wl99MLI
 MFX1DKxYX+DPrIJmsVWsutuJrWsTcBE/YM0WPxiHLcWvFnSTpeLJT6YKJtohLaAyonHfEtE+68p
 DN3Ypw9/gVg8nbV0c3feA30V9yPufUI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1OSBTYWx0ZWRfXz6JgrrMyXm5q
 XWsemWCvu4hJgVdtVZeEV+fw2b4sn6CVrX1GxdcsyKyvVR4MJS/sxWyzQt3CuNknlxR6Uz26p1P
 9QkFoX1cDi3Pmg7xqjR7caBxq7RHgtfE+UPSBO+WGR7uuWsotegwidM3aSnNHWhRu++Ha3kNm/W
 Iz3WzIC3QByCmtHcyqx9uOmTcKTKREDJf9v/kb5LrSlln2AfOgrvEkbS9d2x0fEmFHtV9wMJEZ9
 NBkQuV/3l7sRbwbnR1Mfb49G81j7JLT7YBQu19gRGkurHnH61Df6IVs3TrkRAQlzey5CO7DuuJM
 GpQBK7XUm1UO/3w1S1l/mPNDafEYrl3jOgqIOBYk1kL/LnnKV0QeivyK38XN7xOD4fPGSV6eDy4
 dZfmebnFCpvyKmSqcIIM9oObKQVuAvMl54syHTBfy9yrwdNDbVi0RQHXJyWO7qatF3xfIsKDXPs
 cGNEMehIws2TMZa2QrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260059

On 26-10-26 16:59:30, Taniya Das wrote:
> Add PDM XO4 divider clocks and make the PDM XO4 branches propagate rate
> requests to them on QCS615, QCS8300, SA8775P, and SC7280. This lets
> GP_MND select the supported PDM source clock rates.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
