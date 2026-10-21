Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588811;
	b=mnIFZlU8NMgMTLqNynGv1oEfG79pwHaflIkO5HQkKlhBUonQJyIhDHEy5CwF3GgDKjrR
	 VDwL0bIFiexxA6gaiBiROHodbr7SUfR03a+9myHErs+iVegG9+sDmRU7dlEnQccP9UXGB
	 Cvcj1S/mIdWPu73d1lnaX/TJtVFHBls4xgqgG6gyJIDAKnOhJyZKyVZc6WhHwnAAqvsyJ
	 pjYmzLQhUx1WG8sviyFtrE6ji0bAHrh1FAHw940PbfXo2T5l2qShHpLO6Hs3jr0qMZC44
	 AQQ2+Z0+D2hoylPdYoNtqKY4+6All58vRdoGQVzqw+0MramKAHIo188JO9uEhM4pgig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588811;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aSnzuw64QaL2ODuF7dIoTHdiPuBaqdsaTTJECpYAR54=;
	b=O73kzrheX1PR4cGdNjsnUrrbxoklb5f+eCQNOPA9nCs6cxYUZEvHw+ysWBteNFOj7VYQ
	 XcRdOVOAuwEZQtMZRfDW4Rc97GelEOYPgt9DkIcntBA1q2RzMxovEDM7JB03xHkIh2SAX
	 ZvF3YyzSjwzI1ecZ4bPTzEh8zZheW9q61sZnWcWWTsZkNoX56G2/hG7TLL+2VPH9Ws0Y6
	 RIeBN0pTQPh5c8xCuO0vVxqTitoiKvrmROvXRpDM7RD+nk3oIJSbX8O+l9o9vSfvJXfCs
	 4LxP4Qvq5CEj6Cbu0p8wJFQdAquAvOBIFt6otPfAqGVXLwEt83dLs3P+ol6xGMAWhAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EIv8tbx6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J+DoKJEa;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9216606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9216606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EIv8tbx6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J+DoKJEa
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LDHPoO4038149
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aSnzuw64QaL2ODuF7dIoTHdi
	PuBaqdsaTTJECpYAR54=; b=EIv8tbx6tXPAcGXLwoHMp83UmNhsZWHR/l9I8HDi
	4/NrazfTe4cn1dw9qZPNikqZsw4VVrGPrY4VtSEFy9B6EJYk1yQ+z1v03RCikitv
	K2YIJ0XBiKWbLJwtOzXCYY+SYkCcsRUwgYQ8nuVJdN1UTbWR3t6Lsyk4iRLagU9X
	iwGJ0sXwcyFwUH+4ANIereXBcz7d8bV63FMhwxx9w5IKcrZbrbm0x8MD1BoQOd1M
	Wv/u6WWzBsPnrYV5W0cH9JesZmgnCCTV8T3s+GVT+4io2QwEiMSn4FEkY+DU2lS4
	e2QI7TEEg5n0OPk7FoWS5Dm/se8LLP2qSKvoCQXVATJTVg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex5880b2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:20:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9308eafb465so226321885a.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792588804; x=1793193604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aSnzuw64QaL2ODuF7dIoTHdiPuBaqdsaTTJECpYAR54=;
        b=J+DoKJEaJGV1exCt6hQsecBbBX2Iem8uDn4CQKHRRp3gFRfaHXPScwY5CH/t2I9ioU
         hWTU6Xitm4StBQO7km1Yj9QKlv9c+XPYDK1KUBBQU5CtGDuugAdNIogOg4ICYs9nMlF4
         1iL24hvmLL4+bLTrxXrI1dCLmOJxRHDe3GaTemPB9cWLaYzOuhcRyASAgiJwoiozf5fY
         XQdw7Obkmoc4AtWLsygd6WgoTA+QMqofxNkitjxWfYxKHDFvfXBDEOw7ySFsEcjVfcN0
         UFO7VvXPycMrzld6Tq5VKNBA7JL+GyJNDTqvejvitz4ISnQSXposFbgPBzdjokeAhCjd
         X+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792588804; x=1793193604;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSnzuw64QaL2ODuF7dIoTHdiPuBaqdsaTTJECpYAR54=;
        b=1gzPxGWoGtHOrcrmJewC0QCctl7N1qpaJMOcZLoMu0fAoSXgzw08K8szu4dVcHghcx
         /0R0KVSZoNRQLcpkWMz5IfXfaoHAB38KGoKXyekvyKO1QX4l9zUYD3OkO7FWpjxsfEpj
         xjrbPw41k/9ALiT3/1+tHMbvlDtW+NUGR3QSa1gIQv1DJ5VoBUCwDPDv3sDKnt4xmN1J
         QKe+ZLpLSnQNffbrlvKYHnHykwvmuIn4uXo3Dcv8JSZkXONxkOPWc62yIubPQoqG4zMm
         tN4E3Bp+8Tl+bWNAqevmwzy+tGR9ZJ9NPwbqb+Jdu8QMtIRmZ5pn1av1xD16zXB3lPpt
         f1DQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSlvmqo75CTnPG3HTiH8774WB28VxtHoIMONTzrZDqMk7LfxgMCucJ5HmBxIuWhwlRJgByWi8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3zfqlbr9b+eats4rz6MiQ3nqu2/m2LhqzrzjpXlIr/s6UOfd/
	OMwDeXxajCdLePnEqlUO+vidRw0EebyzWm3cJBV1Y7GXl1/Q1GMUN4pbAlyq8QfGJTTNZ7XwMKQ
	5C7kJ5fSyHagtKQkn5OOvQluMn0LtaHLchdHmh/3nqsaYAkm6li3az0XoWao=
X-Gm-Gg: AYBFou0FvGklO82mD8jsR1ijuQckRt9JcuVHR3+xfl6Utw12SYgre6eCDeQ/pYL8gte
	Z7HJ7MfJZe2b2Ig978kb8k1IqIzuTTC+lkFja3J3PHU+oUQn/S0KRRgRs/S+287dO/9CLoJvdOK
	BigAuM84X/0UXZBlvYE/GT9IiuPFC5GJThb/jdzZKzUynFqfSiFgSpNXEB8YcNVAxqdmMq9V83Q
	YDS5amUAXjvswh3oSHMLPUsN3Gjs0auvK2sfhYl6dhDOfWO0x46ZNH0WXAEzUR50716rf98P39D
	rXbOXbCh42QJg6MJTN2O+muFN2c7pjrwi5pDU9qLtEgaS3pWR53FAoYPLr2u0dIhWBg9o7/OJfr
	txtNYAFmX6nSe5x7aYEWy0C9GZmK90FRdTUtOAa1u0fIkgdrhEo3o70pN3YVNYQA7INtg8SaRKN
	uEP/lDyFM2dy7U
X-Received: by 2002:a05:620a:40d2:b0:93f:571b:c72c with SMTP id af79cd13be357-93f57f66116mr409626985a.46.1792588803924;
        Wed, 21 Oct 2026 06:20:03 -0700 (PDT)
X-Received: by 2002:a05:620a:40d2:b0:93f:571b:c72c with SMTP id af79cd13be357-93f57f66116mr409621585a.46.1792588803368;
        Wed, 21 Oct 2026 06:20:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfa1224fafsm512832e87.63.2026.10.21.06.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:20:01 -0700 (PDT)
Date: Wed, 21 Oct 2026 16:19:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 0/8] Migrate PAS clients to qcom_mdt_pas_load() and
 qcom_pas_prepare_and_auth_reset()
Message-ID: <zqu4sweaftstbt26v2u3ajzv7snnqswuyrktm7t7k5gh4zi77e@d6t2fpsinvxc>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <ce3f58f7-f500-49f8-89cd-611d8e1ac6ac@oss.qualcomm.com>
 <20261021130735.h7t2c7txqdfohrs6@hu-mojha-hyd.qualcomm.com>
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
In-Reply-To: <20261021130735.h7t2c7txqdfohrs6@hu-mojha-hyd.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MyBTYWx0ZWRfX/xqxha30OxPL
 ISsVkY2c+DqC7ew9YrRoMoOz1inCFtLIhza1QnksL7RiDTcw8tpi+qXVlgLyx3M0tgTv4bkPuAK
 x59+DujxBbr3pXkZ4tfbqNCli6NHCgs=
X-Proofpoint-GUID: 7de4xeujqrmBuqhkqnpSlX2vEv59SYLX
X-Proofpoint-ORIG-GUID: 7de4xeujqrmBuqhkqnpSlX2vEv59SYLX
X-Authority-Analysis: v=2.4 cv=Ku7YSmWN c=1 sm=1 tr=0 ts=6ad8bc05 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=LTSqVt2n0stEVfQD8AYA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MyBTYWx0ZWRfX7+tBB1SwmKiJ
 Q4GPj/apCToOsMErU4zGPZvkotzCgw0fSe889F1mFAWTmaZ7SFJWmhZPZBa3L1C7R8MBVb8oTR5
 o3veN+WyCaH8ihjkV1KPAc6bVhI55diIAPExgQorXMe33AempHYtf33L6LGUKt7kt488duwezXy
 +coNjYt3CGtRnt1PhSssvALxAmrDh26oeta2mZvpgO4JdtJdZx4Wrrv3P3YeVBl8s4D9NsYsXbW
 q3WPvvvpPuioylW7ZRbWrLFTFRs0NdTfn0SyOfaK90l/d52kx0lqJGFxBBuqH0WERkbVsQ7gEkG
 TOd0suWXLijmpZVFniQRIhLNC0SEcoht/Rv9rMdsNz/464QKDdmWQk6mqO1OWCOw0eNFXMK7htN
 MRpI/nKOqTnnK3uKI10LtFdIVie34xrUjdgOQ2nTLTrT0qjkfU95PCuDtYHhNm5xgf/b0N3GdWB
 qidlvD4N6cIweGX2jzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210053

On Wed, Oct 21, 2026 at 06:37:35PM +0530, Mukesh Ojha wrote:
> On Wed, Oct 21, 2026 at 01:32:13PM +0200, Konrad Dybcio wrote:
> > On 9/25/26 5:57 PM, Mukesh Ojha wrote:
> > > In preparation to remove qcom_mdt_load() and qcom_pas_auth_and_reset()
> > > public function, migrate every user to the new PAS context-aware API
> > > qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset().
> > > 
> > > This series migrates every remaining caller of the deprecated APIs
> > > (qcom_wcnss, adreno zap shader, iris, venus, IPA, ath12k) and then
> > > removes qcom_mdt_load() and qcom_pas_auth_and_reset() entirely.
> > > 
> > > This series is based on top of although no dependency as such.
> > >   firmware: qcom: pas: Make MDT buffer retention explicit
> > 
> > LLM has the following comments:
> > 
> >  1. Metadata buffer (ctx->ptr) is leaked, and overwritten on
> > reload, because qcom_pas_metadata_release() is never called
> > (patches 1-6)
> >  2. devm_qcom_pas_context_alloc() is called from repeatable runtime
> > paths, so contexts accumulate until unbind (patches 2, 3, 4, 6)
> >  3. use_tzmem is never set, so the shmbridge prepare step never
> > runs on SCM and the commit messages are inaccurate; TEE gets
> > a real mem_phys/mem_size change
> >  4. Not bisectable: patch 4 relies on the NULL mem_region
> > handling that only arrives in patch 7
> >  5. Patches 3 and 4 don't apply to this tree; iris
> > iris_detect_firmware() still needs mem_virt after the load;
> > the base of the series is not stated
> >  6. Patch 7: NULL mem_region now means "map internally", which
> > weakens the -EINVAL sanity check
> >  7. Patch 6: redundant second ioremap_wc() on top of ath12k's
> > persistent memremap()
> >  8. Patch 6: ctx is set under one scm_auth_enabled check and
> > used under another, which is fragile
> >  9. Patch 2: the context now carries the full region size instead of
> > the MDT size, which matters if use_tzmem gets enabled
> > 10. Patch 3: stale qcom_mdt_load() comments remain in
> > iris_firmware.c
> > 11. Patch 8: no issues found
> 
> Thanks.  Will address them along with Sasiko's one.

Just to check. Did you verify your commits with the lockdep and atomic
sleep debugging on?

-- 
With best wishes
Dmitry
