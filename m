Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF4C4DE709
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167036; cv=none; b=fd/vesld5QKH/fHkw0x0pqfA7wivSip56YLAj/PpjO1xI2QiBsy7ijg4s4SvrZG3KcsIkSLaemE9/rhKqZOTEiZ52IJlXzfhl76Y1eX5OJJthLH5YAdjRMGtPkyIstjUNRVIXP/lu4SyZGfPkXYBrZUFWVNHUpfeme8z43BpoSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167036; c=relaxed/simple;
	bh=d9kIrG9Oh2k6kPsarmyKxJFDyeWZfLIoVe/7fr9zYHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SF+IBaJFGxHbLyhOcaFZnO4zEtKl7KBc5aCIHpcoRz1iA2zev6XEsszJ/X0FqK07I/f4fqaBjcYLoXu1NWjIIToXPBw0xllR7mMo+nP2jbve9T0D8bCxMpk6sx9TJrj4uXu336YlptDQHUXWylT0BZL2vlw13EFyPf4O55kf7HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XSof8/Qe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zi6UCZI9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XSof8/Qe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zi6UCZI9"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbWge3413886
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=q6aJrQIUE12s0cEQsNzDKJFI
	qPllp7aIt9z6KSAydC0=; b=XSof8/Qe47i4vOA719Hr5gDs7gElm34+jE3Oe0C0
	I8S+v0w3GrG/1N/lu5TklX/5KAdFCVkgwqQN1mt9cav1M3tpmO+UNicc7cFpZsxL
	QB9QzmvHypTekCOjfDLinag0iXAIQz6rnSAu8//Cy8G7/riQq7BeEbz0cdGz6KuA
	QjxLfCn1vtt2ur9REWe00aaB7XcFXyb+cx6lRwcORGPodqIId3KM4/uQ56juHhus
	8gvYjDRT2KQqB4KttfR+UiyWoO5Ld9ArY7sgO4uAheFeqdI6uXQ0V5+lKYz/nW2O
	jCTZoRR8X7s2O9S+Bx187f2QdtyIg1dHh7jQir/FcXkRnw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv78n2034-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:37:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso989567a12.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 05:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790167033; x=1790771833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q6aJrQIUE12s0cEQsNzDKJFIqPllp7aIt9z6KSAydC0=;
        b=Zi6UCZI9zS/TJliUxWCLVe9pMESbGdeRNCw6HFyVLZaHIzwob+EW+KnaZsBicIjz8k
         Yea3CbIxq6qnpgPOwQTUjjcNLDTrEdm5IztoxEWjC/Z5/np6FEDjc+nAyEb6rxApyi0V
         cbGKiqnUyf2eN3mDiiKr+twMypJjFg9kjWOhI8xUtSBGc0roX9VnhDzpmMcDfVnfShkq
         zsmKrOP8rGCFS32MnDKqpbAKhhmlVdtONKZaBfIf+pt48qtV38samycVgXAwZiy2lNMu
         ozV3SdS1/Wx2agkEU18bigqvXuxxkitDRU5/uaZTXtyS5RD493orUaFB700NFZw4Q3qi
         J/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790167033; x=1790771833;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q6aJrQIUE12s0cEQsNzDKJFIqPllp7aIt9z6KSAydC0=;
        b=FD2swfo8SD4ODA7hIU+M0dTR5ssVwhw+pSuLXZN6KkUh+eBOElm7mnuWyNCS1XmXM5
         3u9QGgcWo022c6qlLyF+UAVJd1bLmJWynbxm3LmJUtfLuFws9LhPAxvFmhDeMILgwwOH
         IYg/5qMxhQhhWmXKYe2uo+Ru96zx7MVZGAm2lm50sOXXgVXIW5qGTLGPG4BlPRMviERB
         U17YJs2I0XVbQXhc5jUQhlr+I0ovvkjpppIkQhuKh3UUBaAlEkSw2D/Fj44DRZtqFuwr
         +PhTluMNEkwXE31iwMwjlzgofF0YMnNG/h4IcliGALq1X4Hnp4rLOPCDtukB4o2899uq
         3f8Q==
X-Forwarded-Encrypted: i=1; AKwUvBz5Rx4EgY80z06xBWdRsDGy6UaFwcmjCb7TQU4kiwU//v5ASFAl79O1YQ9vGNP1n7IcbpQeVx4=@vger.kernel.org
X-Gm-Message-State: AFuF++kbBYxlklz4+jGY436jHbqVspvNamMedy/CjHdwznA6wnog23P7
	IWNPJQp9y3gQ8a+vMKQmCMXmeAHHtiAkoIA/YxF/er9a8IKwQ/3PSAeogYztSZVp5OnfLrQcaW4
	agYtE2vIjo0WiltgwNtujLGvGsxg8tqM8ojc7vxGsHLaEqMzgbFOTx+KBHFg=
X-Gm-Gg: AYBFou1wX0pmTd8JOfmYggkNSQpigRTR7OfzVg0T97gFx0VVWrnAV1oj95Q9vqwEqEw
	XhzIsZXKsQwui6pLWPtV2PGzJBT65893Fcyh8H7RzCZNn5ZbF6pzFJ68pODOfRB4v8UKvGFa0w0
	z7+TipyN/3CPCb+ixfXvBU1SKq1Ug/7opxd27oMzgT2fqtGY3jPLoi8nB0j6qQZOdB5F/5wnWZp
	VA/gRWTJ6PpwJhBElLpjNqdoCbUfqIU3GxkG9lMaanzJ1QllYRGB5/bKrwhTzVZwz8IUnKmZJ++
	p81rfdmyGfIMMR3qA7pakAr4ASP5G2FHxarvJOLHh67N5VAkLwSbEvjEF1c75BOvEEPH5bNXIhJ
	IEpmb94mTdBcgyQ==
X-Received: by 2002:a05:6a21:6915:b0:3dd:a196:69e9 with SMTP id adf61e73a8af0-3ddf830eef2mr2433417637.68.1790167033166;
        Wed, 23 Sep 2026 05:37:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:6915:b0:3dd:a196:69e9 with SMTP id adf61e73a8af0-3ddf830eef2mr2433366637.68.1790167032567;
        Wed, 23 Sep 2026 05:37:12 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f3ba8b6sm990949a12.5.2026.09.23.05.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 05:37:12 -0700 (PDT)
Date: Wed, 23 Sep 2026 18:07:01 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>,
        Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Subject: Re: [PATCH RFC net-next 3/9] net: pcs: xpcs: add custom platform
 register accessors
Message-ID: <arPH7aUUyM0ZLXAr@oss.qualcomm.com>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <20260923-qcom_xpcs_nord_emac-v1-3-4b1c682af70f@oss.qualcomm.com>
 <be09d6dc-c1c0-4a0c-9836-2b686ad096f4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be09d6dc-c1c0-4a0c-9836-2b686ad096f4@lunn.ch>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1MCBTYWx0ZWRfX3TsY3cug98Am
 S06kBA/YeaFIhSFOvkMonxa1YopoA6TXB91L41gPUG9ztZ4GVWpUc8rGsFIPvrQ2ZWuXjfxUAyO
 dzu3eP9iNHfc4N4OOnJto4nv+RWvkJs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1MCBTYWx0ZWRfX38+PKiYelRMZ
 mh5O6lnEimfX3m/Q02/jX1HAGAZ5lB+r35WqvoUcF/PBZ2IfGkbEW5S4adEEODy1/u/7SQqJvFG
 wvwwc8GJMOLhF1SvGz1/JU9poEFGEqFuuCrr8c32EH8PsmpbRcibB6+9WVYH3rtFY1LZikhWjCo
 ogjCp0EUwaswO2zkD5vCKaxGl3bkF9+gb6fhGrSAbxWIvRS2YAqJh2gylmglZo7t4FQFfpFfi2k
 l0jSQTNmHFcQr715DdIpu9Nm9b7isqIMoFbj8ZtDlkyLf/95CwUUBFR7jg04p2Oth+qtv5Zhrfr
 fqzZsp0WpdRSP5h5E5b3Lss7G89OVNEO53OqKfPagt+7aoMPgCg+HvoyjyNrYHyTynbD3opKfcQ
 ToSitLzcUgv19GGRi5euU3RrXS6UCMT+kx/LUkBlSNb0ExxM1uDFgxxA0OMYMbrJkgpd1kkPWZt
 jeDhvEY1rP/SZ88Uq+Q==
X-Proofpoint-ORIG-GUID: tXo-VXwJQz5YSO55ciUyHlpLiMIG5nsm
X-Authority-Analysis: v=2.4 cv=aNFlOr9m c=1 sm=1 tr=0 ts=6ab3c7fa cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=B2OTbEDsPxpMJ7_uHOkA:9 a=CjuIK1q_8ugA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: tXo-VXwJQz5YSO55ciUyHlpLiMIG5nsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230050

On Wed, Sep 23, 2026 at 02:18:17PM +0200, Andrew Lunn wrote:
> On Wed, Sep 23, 2026 at 06:37:29AM +0530, Mohd Ayaan Anwar wrote:
> > +	if (pxpcs->ops)
> > +		return pxpcs->ops->reg_read(pxpcs->pdev, pxpcs->reg_base,
> > +					    MDIO_MMD_VEND2, reg);
> > +
> >  	if (pxpcs->reg_indir)
> >  		return xpcs_mmio_read_reg_indirect(pxpcs, MDIO_MMD_VEND2, reg);
> >  	else
> 
> Ugly.
> 
> How about changing pxpcs->reg_indir to an enum, with values indirect, direct.
> 
> One patch.
> 
> Then look at
> 
> 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "direct") ?:
> 	      platform_get_resource_byname(pdev, IORESOURCE_MEM, "indirect");
> 	if (!res) {
> 		dev_err(dev, "No reg-space found\n");
> 		return -EINVAL;
> 	}
> 
> 	if (!strcmp(res->name, "indirect"))
> 		pxpcs->reg_indir = true;
> 
> 	if (pxpcs->reg_indir)
> 		spc_size = pxpcs->reg_width * SZ_256;
> 	else
> 		spc_size = pxpcs->reg_width * SZ_2M;
> 
> Look how easy it is to cleanly extend this with a new resource name?
> And add accessors using the funky mapping your device has. Another
> patch.
> 

That's a better idea. I was debating whether using pcs-xpcs-plat.c
with this HW was a good idea, but what you are proposing should hide
away the ugliness. Thank you for the suggestion.

	Ayaan
