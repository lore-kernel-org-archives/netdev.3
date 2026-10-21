Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588079;
	b=uMSX82CvGNH0dlpiIPJHG7ofBpgImlloxaoNeQbdDRN7yuCVzd7cWMoEwNkJ65euRGTH
	 r1SFHKgU8IVOrnx1mnC0wHmJ2RF2MjvUTuIEI1odkULl3G7C5Hk2Z/6xwTquT92URgj+U
	 LYY99WA1ura4UWnqOj0kxuevuvRyaS0t30NUu8QiC246N6iyiiyKZo6wrE3nBqRSfVB5V
	 f8sMsGA43vVE4fSfYJKsbaoGtH0ALcpHiecVHvsuWVHiJJC8Mm8TnIg8FyMgMvCW8fRLN
	 N/j4bfw39u0lSrZHsDUmmkG+lzuSkavxZ8C0wpd3Uuxbc0e5v3PXkcFbua0934cLBug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588079;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=uHps6C48bjErWLWTA2jyVj+V/HCuKfjWf7ze/6BLmro=;
	b=POXFntA94aIdVEOIGANi1Qhx2Pcwwd6NfGMhhMtf5cC6QL2E4PPNQAqkyCaVGMRNCVfp
	 22zd8zvmrjxOWcZOjdbeZw2EaeRK87h8oALnvPoh/cMyUpdpX9QXXKOelY2uS8WI08a4z
	 ld6qbnOMdvLQUwJdCShmMVVYpDB/jlGpkeFXVOgRJzDw+bbz+KHRAybtAnraMconeKgZA
	 ErvTr9Pb1+yy6c2TYjUn/qCyW8VE1e9v0vM2zoMf6jckFCfTM413biKkByTNc2regB+E1
	 DL9nPy9HwsNVtHgh7Hma1zO64+TI+TNBpV6tLq08L4PQNsmlZJH5VcnqnA+vRtVYE2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LlwgX1B9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NqN65Qjv;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BA5606A31E
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77BA5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LlwgX1B9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NqN65Qjv
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LD0xDM662960
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uHps6C48bjErWLWTA2jyVj+V
	/HCuKfjWf7ze/6BLmro=; b=LlwgX1B9QPTmQmXJZC3FEVbGiGYzEgnKeg2Kv2j2
	x73Z6bydNkiDaDZz7Rkt36TgSMxA0Tcon7A/Qkx9jgOD1Gr1bX7uiFUeqxlYvU6m
	OBRVwUscuRRKuGqCYTHFdWJ6YCGGMfYt2upE8FItNlJmVASCW61RC9znVFkT611h
	tqRBVbVLIFrFdZgtmkD0Zrpc15+/D0sDRrbJ517N8TSD0K8NaN0Wn7VtvRpn7Q3f
	sgmJ2BUqwy1GDryKVySzuOW+wr9/z4nWf8gLxYeHV9EiBoR/oOkdP8pvQHlcJ7xT
	YSeiW3AYBYrq/mrwwj7o8LrXnjMRdplYPaRd1j9irawV2Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r33p6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:07:52 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3662e7a9299so2912345eec.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792588071; x=1793192871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uHps6C48bjErWLWTA2jyVj+V/HCuKfjWf7ze/6BLmro=;
        b=NqN65Qjvk51cnPaIJnL1Gu1v6zHApo+oN7v52F/O90ImUF8/IXxhyglIH1Ac1HMsiK
         mYnadnNi7w45Vn+o2v67sNMZYoZDAl4lUSXaWgHkUgQU+F7iUICQX+V3BddmsPF5b0bf
         dC/d6guGhO9DBOSed9iYgV49yQckJY6dAvUlBp6S8U5gBIJzrdIEENuwjzxm7wB5n2Ln
         77eejz5A7LkJCXmUJ47yK4YyXVT60aKerNU84dPNof4bI6hj5/w777zrq8zSWmvpEt4m
         K4yrdTwCj9e0XNAKslhSmW+BYq8/qc4DTt4OfdQ5l3caWJ+OiuWME4Akbl+NcU+abiOd
         FzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792588071; x=1793192871;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uHps6C48bjErWLWTA2jyVj+V/HCuKfjWf7ze/6BLmro=;
        b=KMAKfxQfmuy4mWRcp6MzOkK/a9i19JAn/hXPP25gVoHDZCQiPsdWHNwSoXp4F815Fx
         sPkZHySM6/hlGXc27tPGoxLx5YvnHJhYLAzysh5G0ybtTZuu0wKd3dWDUoC3qTS1O3Uq
         e7bMvE/tN6tkZiey2GzWCNnwUW7DvCHI9YvqlNqv07tWxQMUpRBm3fcUFZRn66TXPsh6
         /8VOA0r1RL+IdAeJXMbmwDzX1dRiuu2sfhFJC/3R9aIhdbPYoY7JHhlNah+m0VTDAARY
         NDVB3A+i3BZVD3qtqRG55kX7j2IogZ5WqxqUKWpzU69vV08PIzDl7dDxQfcYlsUv2bMz
         K/FA==
X-Forwarded-Encrypted: i=1; AKwUvBy6df8vbRDf6TalVn7XSDN8WQgw9XrxX7KtOnry+T4Z+Pfi+Hf3j+iFmoZNs5J/n0uIahkhl5k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPJ/12C9LrTYc1rj/K14r31k0M/tEWQlH4tllFekK6dbdFumY+
	4guJHl/2TjVQBqRvrl8ASDhs/GvavAY0Hup/TaJgKW8/V2N5zM7yhe2X3J49dg009URlG3EZPwf
	RtadrPfm/0b5+p0Kb7Dpj6mFhkou5N4LYZmoblyOPJuapo64HYKCcBDwk+ls=
X-Gm-Gg: AYBFou2vuAeDnaoPHn/T/4in+nntUk8REIe+A2ylzvk3QbkDZPpRinMMWLULtZOdP50
	+DkqsevcMMopzf9Gfb+hJnsaM1xTVGzMLjMJ6ro4/Z1O0kCwJ9gnE/YxzkyzDLWnDGzW93Yjtqo
	om82j4zJEk4SM0k3z45e435DEGG7pfh47HYsbWxbSlz3MZYCWx/lE+QrY3djW0W4Eur6MxVdojy
	y3NoQdbRCTXsa79mB1WPhNyvaeD/jIwF3N26UW/ca7GoWY08fgCbUtV1ZxTqIYc4EgMRVQG5Ou+
	2w2hbtA+G89GG7fC29B8cFqyw09Aht/HKi0tOQT4+UKUzkzXpxcbRidGGxm0FlyZK5Evh+4jcYY
	6BilRSwEHU0/h1UQwM3qcSKpnZQ==
X-Received: by 2002:a05:7022:7e04:b0:15c:705f:b981 with SMTP id a92af1059eb24-190a67fb474mr2783429c88.32.1792588071188;
        Wed, 21 Oct 2026 06:07:51 -0700 (PDT)
X-Received: by 2002:a05:7022:7e04:b0:15c:705f:b981 with SMTP id a92af1059eb24-190a67fb474mr2783235c88.32.1792588069115;
        Wed, 21 Oct 2026 06:07:49 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bf5d0a1sm6052461c88.14.2026.10.21.06.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:07:48 -0700 (PDT)
Date: Wed, 21 Oct 2026 18:37:35 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>,
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
Message-ID: <20261021130735.h7t2c7txqdfohrs6@hu-mojha-hyd.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <ce3f58f7-f500-49f8-89cd-611d8e1ac6ac@oss.qualcomm.com>
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
In-Reply-To: <ce3f58f7-f500-49f8-89cd-611d8e1ac6ac@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad8b928 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=wXrbNP8IbqZU6GI7zsQA:9 a=CjuIK1q_8ugA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 7CnbZNRvV2Z3C3cLGjQiNtwsyR5n4O2U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MiBTYWx0ZWRfXxpeLJ9t7GROH
 C+UcFnLc+djbxEkg00IOeTiEoXHSnuOCGFFGvdfsrqolaEEuqyWV492vIrIsR4dEBp4eQZkjyfe
 sEyEboO8zz6BOIh8aAYFhkGp7gM9QLUp4WIgOJRSsIW2NNhz37B/U9ccHb7KUVnFzV1GsUJaaDB
 2ka6Vh1IdcEtI8io/4RZY7Gb+EoS6Pyg8yYQwBKYqJ0DlIdP6ST6niptpXe3+c0amAA0jEPOpa2
 NYjTPcmWU+UYeoeCY6xu5P00e/l5RnHtEmv+r0mIsZ90JapmvOF4cTlWb/vi4uKXh6sYY5fqjc+
 qbpygTUYVLzuLMgag2sUs4Jhx0GTDUK/ErXHlPCjyR1K1nXVH4mj7Fxfs8aquVB47xSLsHzqQYu
 IBNa+OlsVlILLFjqwcap8L0OOjObrVRe4V2TnZV/JmDqyTJwm9V8VE8gKHATes9f9KBxjPrt2PF
 tgn4aPHSXxRnYObLsjw==
X-Proofpoint-GUID: 7CnbZNRvV2Z3C3cLGjQiNtwsyR5n4O2U
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MiBTYWx0ZWRfXwhwyK32n9C+F
 Z1mIJM44gnXw0y1N8VL5NYIMw2fLUz43qGT/cDCVeVVpUF2w51Cz7OVel/g53u2S4Cr65XLy8AN
 sIA0FC0Y/zSeXtTER4fu67CK3GdZbfg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210052

On Wed, Oct 21, 2026 at 01:32:13PM +0200, Konrad Dybcio wrote:
> On 9/25/26 5:57 PM, Mukesh Ojha wrote:
> > In preparation to remove qcom_mdt_load() and qcom_pas_auth_and_reset()
> > public function, migrate every user to the new PAS context-aware API
> > qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset().
> > 
> > This series migrates every remaining caller of the deprecated APIs
> > (qcom_wcnss, adreno zap shader, iris, venus, IPA, ath12k) and then
> > removes qcom_mdt_load() and qcom_pas_auth_and_reset() entirely.
> > 
> > This series is based on top of although no dependency as such.
> >   firmware: qcom: pas: Make MDT buffer retention explicit
> 
> LLM has the following comments:
> 
>  1. Metadata buffer (ctx->ptr) is leaked, and overwritten on
> reload, because qcom_pas_metadata_release() is never called
> (patches 1-6)
>  2. devm_qcom_pas_context_alloc() is called from repeatable runtime
> paths, so contexts accumulate until unbind (patches 2, 3, 4, 6)
>  3. use_tzmem is never set, so the shmbridge prepare step never
> runs on SCM and the commit messages are inaccurate; TEE gets
> a real mem_phys/mem_size change
>  4. Not bisectable: patch 4 relies on the NULL mem_region
> handling that only arrives in patch 7
>  5. Patches 3 and 4 don't apply to this tree; iris
> iris_detect_firmware() still needs mem_virt after the load;
> the base of the series is not stated
>  6. Patch 7: NULL mem_region now means "map internally", which
> weakens the -EINVAL sanity check
>  7. Patch 6: redundant second ioremap_wc() on top of ath12k's
> persistent memremap()
>  8. Patch 6: ctx is set under one scm_auth_enabled check and
> used under another, which is fragile
>  9. Patch 2: the context now carries the full region size instead of
> the MDT size, which matters if use_tzmem gets enabled
> 10. Patch 3: stale qcom_mdt_load() comments remain in
> iris_firmware.c
> 11. Patch 8: no issues found

Thanks.  Will address them along with Sasiko's one.

-- 
-Mukesh Ojha
