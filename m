Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794511311;
	b=I5zxwhxuFCCKAkUF4pm56pQDO3hwE5OkAnslVMebICPCmUjoBuh4ap8GN3oFIKrcqUYT
	 p0slnE17A2PPvpYcbk05I7P09cVDSZs8Au3jW7Wd450NXCKiMpfdgkcLMJ79+qT7rIbe/
	 SC4t9hX4Q/6Ve3uBJMlfBqKH93QrSznP9Vm418715YqgwVDbn0E2HMKnfaHaA84KWIMJg
	 tFLUDwWWn19fvqoTZXiJVW6IQekz/+u6H617kig7yiFM+dwOK6cSWvyntAHj5NoEy9E0H
	 oWGwWLC0d95GcmCz7+6DEHuQkv/jvaViBFv+lMvczL+K15e+OpvCvd+otnx61Rgze4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511311;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version;
	bh=NobLKQRfF1/w6GaXuludL/mp9U2ThflRSTiE/WAKENs=;
	b=PBph3b9AxhVsPzcY/34FFdIpeX3/M18A+zzayVyvcd8bLka9LDfnR+xfrVnUdk1la/lh
	 JUAdQbK5sIMtIYtWYiRs9Vi4gK/igozk8mEsTFRCnsV2iLW+/5w39Bj/fB4p7lFWgYb8d
	 a5JqnmzPNXb234c6vA/UPA6uOnW7GKlcVc8nI4IrpJ7ervbW7uAmhTIgsjpmz8Itsq2F/
	 P5nJWR7EGNkD0IVgdws7yidNNA2BnHsb7ZGXX8SbGFLsFx3RWd6C1/lco0KMdn8lQcW6x
	 LxQ5smGBmi7P1KG+BnJKOzaowwFMbUeOy1YK+Gcbjf4qqxM82IpBSq+MkJ4eW0TOEvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=iPMfg8G2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A1A606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0A1A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=iPMfg8G2
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACIF4Hk4124099
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:21:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=NobLKQRfF1/
	w6GaXuludL/mp9U2ThflRSTiE/WAKENs=; b=iPMfg8G2incL/QIalxtaalgsf+L
	gVeP8knU+DIk12TSbJ/Kv4xCSOEbPXwJAkn1oTLrqHlVDI/d9SNfr16HMTQbeRl1
	DeoHNGzbhD4VDRC9/JW/omfqz5rppZsXSZm36AG52Ae9FZtvhWuU1ORgZzj2Lxy+
	MZ2VIFTOzBis93SfJsrhOEdW8bZPA/1asfv0q92elyCiOGLS4lZ8LHRsnvzsbbVh
	P7bcYopkNS/Y871e6NFmPPGZ/xkxTv57MIJA4sb0b2vr8bSe4tfA1F5AdATE/JaJ
	nH2D/kQ4A6E2Z7g03wXr8iz0vR2ecb7miSBpscjqcuBoiIaRmdhRFNwHuWA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwjjn0jrc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:21:49 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed00709df0so1855655ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:21:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794511309; cv=none;
        d=google.com; s=arc-20260327;
        b=dKb7Uo7PxQpqdTl71bSJdmap50qKxn1G8W7xPYeW4sKB9/+5l14UMzemKmwe/OgUA3
         PEK9YGvkJeo98ZsTnwriXN4uMibfQif6vhew8LC2Kmh67rPVYhB19r54AA/ZmYRhIZ3E
         cN1YCzJb1rJ8bO3dZkgcKQkctosJOzMgEA3wLNsvdr53b0LQl7QS02Hm+XvEyZMQqp74
         YGqxYM3SCf6AI+C5Lz9dTXZRQCxPxGjz9Nj+Tu1QpEm6LXk8q+ctquqYh80M8gc2X0cy
         uEC55YVmQi6DVJFgXo2wrWHhv78BhBpQbon7/uL858kqAHQyyqlqV20xq2s+M/YqDr0g
         4Gwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=NobLKQRfF1/w6GaXuludL/mp9U2ThflRSTiE/WAKENs=;
        fh=uFj2i42xO+pFeCfE/HT4XKdqIlB5RmoqyGsJwumKNUA=;
        b=OxCgMvM4kl/+5KaLEs25/buPOmHl5KDkt/jBuVofxUYJzdTq4AtkHnTos3b4pkoZQa
         gsyN8tkADhRekCC8keBbtlpllaGnqDNvqJt+g4qFX7VCNtOzuUcmTbbqBrvHkgeIwAhF
         RN678dstxxQvmVxtvEwmVw6MwlHO/OiGm9l+jXgYW3loqxOcudFSdVHB4g8RBMq0cYR3
         5Bmqj9Vqu0FrQ8AhCoJ7AiRiwx1YnzTqRLeBhoHZUcFVoEQe52T714Tcz5f10P6PgRGi
         AhNRenxCvto9pImXVYEQ98HLRVvAhQECST0s13aPDCg8kSSMb4gNOqZgPXjA10TUYK7L
         UZFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511309; x=1795116109;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NobLKQRfF1/w6GaXuludL/mp9U2ThflRSTiE/WAKENs=;
        b=yeJsNy/XRjRFv9oF8/4o00WAdODhG+hZlBSsGlT7n2qdU3unjBJry5qa/+D7FoLsnj
         HH1KA0SYkifHrRXyOnUd7Xd8NjQ5pcISaseaXEpF1sIFy2QYuepcg54iOPEaqlyW4VJK
         BcuP4esHld7JxjjQXK5L0QMQHJ7YDaumWkADC6FAQ0HJz5QqQo/57YZHWuzELHWtdrWf
         umBMT+XiFNBF/qfsqrq+LhvtRZjw27NoG0MSenZrAKEcgLjNAyq7IZwRDECCjM2H2dA7
         F5QY+2UV8c1ySLlu/1gC/TzBNQZ43zcbwBl1pjSQLPpT+FPUDTiCUZNXfMVQdmvEuQbd
         bMiA==
X-Gm-Message-State: APuU4Z+6vbsWaYz0zBZIh/1wwXdiSkR0uINWuisnv0AC9UON574UH4TK
	iIGALI74rha6w6xAg77mpDeAlVHwc6RRhL765bPF0+lpKbRFcSUuGDx/acL3qoTH7h4EXm4Ys1H
	Ghu494Sdnbh0WjN+ml2iKkrBbnVRdiBHiQLp4phO1QBAIi9GNWT8Wcx1wOCaKUa86xWn1Gi2/UZ
	FATu0HBaq28+IEWKlyHOBaaz8zpxG23a0=
X-Gm-Gg: AYBFou2qKNdx2jmFJLKHLVPLxtrhWvwaKJ4Gs5AZBstyi47NToId+QUJEpQuuN3deZm
	P7Sy+nmfcOl4s5zoXmf+ucgNXMY73SNXL4mVHlwEJ2Aa+NfhFfqoPdvOTDJLj9ObR5MhoONQUXU
	6t9YEz2zNbN6L4OlwZahSDkw1QSXPJ5Y+H4PSAX9CtSdXJMZq5YIohwmMfAQyYbyKYKJqjXdqXf
	MBUeotCU1rYrUDh/DNRfwH6ChrmfnMr
X-Received: by 2002:a17:902:e80f:b0:2e9:5714:6079 with SMTP id d9443c01a7336-2ee0dad1376mr3591925ad.31.1794511309232;
        Thu, 12 Nov 2026 11:21:49 -0800 (PST)
X-Received: by 2002:a17:902:e80f:b0:2e9:5714:6079 with SMTP id
 d9443c01a7336-2ee0dad1376mr3591695ad.31.1794511308726; Thu, 12 Nov 2026
 11:21:48 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112001512.3598626-1-toddfreed@meta.com> <20261112001512.3598626-4-toddfreed@meta.com>
 <20261111170617.5fbde961@phoenix.local>
In-Reply-To: <20261111170617.5fbde961@phoenix.local>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Thu, 12 Nov 2026 11:21:37 -0800
X-Gm-Features: AclHuK-SPUaxeYSukQ-IF3nQ6z6jzUiWezCswtghbmEdFTqs9aFH1JUEyxZc-og
Message-ID: <CADh2yMxurkRB7BW9=-HikSYuHoC1VDk-uU10nWNjg2=N7t1idA@mail.gmail.com>
Subject: Re: [PATCH iproute2-next 3/3] tc: flower: add matches psp_spi,
 psp_ver and psp_dev
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        Daniel Zahka <daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=BusIUoX5 c=1 sm=1 tr=0 ts=6af611cd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=8lLDZMqfsaXpQLmpzUkA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3NyBTYWx0ZWRfX0h2G3rCgnJHv
 JxfPxN+3rZL6GsUcLV9Lp3JWbE5RyzYGnoyr2lHhLTPm7lItsrhZCv8J/8TAeuOCxOKlb9DXaEY
 7YiKVnSRHhLpHeDaMRGupgiVBYmgiSI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3NyBTYWx0ZWRfX5E+8TtMuk2MK
 oOY958XgAVXz/idMm3GXBuLZ/wicJ8WpGzPrb/LTGwcFce7zI2U2R/fFV7koBt0zjQvOamDDK0F
 /AHV4I7lGTO4c2fHRHTeY9yZ2JeD58pimv3HLf5sm87EbwYkNvYLwVsVWsF2MaH8caMIVCuCnKu
 PAF5sp2scHx/vRQ3w4BoPRVseDGY3VACE8fgJ3Lw35qlrTo2KejTBVx4ltbnJysbfvvvpIeJa1o
 80SW+NROnJgcmxMyxukwl98+R14XpI25SLUL0RK14v+Uw2wgY27T5PhTeZ9Ro2kA8A3lNLVe+n4
 FgFrC4NJPsF0jfojJ3asGMJSw93Ip6deRi8ahfPe6U+O0+qkVhTPiB9B9y9BaM3Sv7oPAHW5K9R
 jbmwAECqVNVLGDFwYSfC178bB91B+TXywVf6HFLGHg7Vh7BAqCicv24P0J9VEYRTscvPfLNl97E
 IG3jTlhR9nEUBGKa/Xw==
X-Proofpoint-GUID: dz1BeLps9O0s-3-kUIsyXZ4B_jUjOt5t
X-Proofpoint-ORIG-GUID: dz1BeLps9O0s-3-kUIsyXZ4B_jUjOt5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01

> get_u8/get_u32 use base 0 for psp_ver and psp_dev, so "psp_ver 010" is
> octal.  The man page documents plain numbers; base 10 would match.
> Otherwise this one looks fine.

I will fix this

-Todd
