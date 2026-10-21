Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792582347;
	b=dP+LP5spxProwXLtsGSLhK+lDSJzcF2UmuDSXbN0tomvf8jGG98RFVjfaUu7QtzdN2nw
	 MYVsSWZILMdjdolkKHgJf2iLgpmFLaSlG1YtyoDAjaAemEnvRojjxMngtkhjUvsMCnR0n
	 0j0nVsFHGT/bxyv4zeAUhoGzUalfaIOavrWt+aTU2BSmXsRpPF4JFAp5R8BoKHqGvwE5H
	 AaGwRm0XDEvjUcno7g4raPyo5y28N5PXwt34ONVTbnJuk4Xzd3Fe+Hwds1C3PPADgGo0b
	 RgMsDjchaka/yWDj1nM2VgooANkir5KQGvrIPo2mxecYhOGgUA6t63jvU+KSZFHD4Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792582347;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4bn9+rLi7mMU4unxZrBwSU21TRh2XBO4KfFG2d5PF1A=;
	b=nIA10BaWIf8Xge3e1PvsPRGMdVcQ2iGkZcF/6RUL4A9PE49tRETFNx4GalB7XvPaV2et
	 DSa/W8abTiZ6lpl1nyN2SmtRD2sVyPql1WYSjGJYtrEVQ+3glYnqtlqXs0AcTDiihbKUJ
	 ZMLeCfXn+iVxUaX6QJBMLaYIPCkq2EH7Hx2QvrBSP4GbCgeZoJCf0DbSDP16KBUN7tEG1
	 wXGAqmhoaERkn+Uvo2ghLVPWxXPoIWj7vQfbucyim0SZQPKFusrzttp2/jJtR1yC6/I1e
	 7zkLbdEF3mMLzJ7oNinTXuOhJWa1nmgozX+nSBMz1uAjZu2xuL49P10gM1XmHGPIj1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l8RcDq9l;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BX8vv8eG;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B8606A31F
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 11:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B20B8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l8RcDq9l;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BX8vv8eG
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LA6GZW848919
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 11:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4bn9+rLi7mMU4unxZrBwSU21TRh2XBO4KfFG2d5PF1A=; b=l8RcDq9l3hlmBKdH
	rHQYwc1NxJzwU37rKeIVvtCVpG8tsm7/8m+fWL+7YJUxZ6Vz3+cd8wWCQAS9o3c5
	UdJdmH9FKwP5kfwIwPl+6MWhFnTlVJPaPtLBL7lNfsIAWyL75d8BjyW6+oSjkyUJ
	ts9zKlfWRcQohLZIuyF4Kv2BswJmjxVnnHcFvKZONBDwYAAPXPzEQlklVjDT1vn6
	Pb+hBCG0A9MkIXgbz/Mn7vUDpELVFnNAi4axkd37MCHC/jFgEMY8ILSzysAg/KqK
	Fd+dyBGog6MJCbZC6DMF7dy2OC4ssqVHtW3J9pskxoTBWqBA/VRpeZn2rAqlwH9F
	yNqkLA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedajknrp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 11:32:20 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7cc0ae52207so12359137.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 04:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792582340; x=1793187140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4bn9+rLi7mMU4unxZrBwSU21TRh2XBO4KfFG2d5PF1A=;
        b=BX8vv8eG8yWLU8t59zgLyYucAfauxQu/MVcVqHl2vpjylDXahr3wVfRZ06iW+ZRxJ3
         6CWxW+zygFXhtz6Mo0HWMDW+qYuhan67+2XfnOIsCx/eUxFo18/ZCv+mTDIQ0lL78nCf
         ++Gp8KseVbLeJnMZiTP7oxohYQkVXc5YCsp2OoqoAQSarSBiwktZdIoH/MH5YUGiitZX
         8/W+EWcAT/xerh2c5R29x+CvH/LUYiyJ5lNIPfZuo3L3Ekkobw48/y5UYm4d+tcnW06k
         vUqZiN9eCLUnPXAJyNP7twozyjkXKQr4Bm8pDd9pRWFxA4FXR7vOku5T6bbHptlJ3J/k
         Y1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792582340; x=1793187140;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4bn9+rLi7mMU4unxZrBwSU21TRh2XBO4KfFG2d5PF1A=;
        b=2sKwvSQGTMeLgzKyvTwyCbUmjZHliwf3Hj55SwBsh/JotOEiDPRh/JkYcjJgoGJCeC
         EyCKkMPAuO3xQiYXyUAwGyEfQJvSDafRB7oU7GNZ7Vcqp/4ZeWFalnU3ILwFogL3qV+i
         t1+F1A34VIfIKAvsiUd4XhJN5K/O5hjkwzlCrcpI7J5+iaEo5RjXb1BZE4QwgVYAA3ws
         ZONOJKFWNnfzGgw7+T7O10wa6afraDiFpZDZtfNM4mLeoX61vNYK3dmoWS6Mm19U+ARz
         WbZnLIpPgJogP748LSYIeUr8T8bcPZOjaVBmPBoFcXroyiFJr7/u+VOxjgUkxmJJ9A+U
         0tmw==
X-Forwarded-Encrypted: i=1; AKwUvBwmc3B7+fNbpaQD+rfVD7twsEQ9q2VbOveEzHBRTg+wbrBjMllpnOdkk3OJVQUu0xdvYxnRSFM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKe3Eob9vx+BHWmwPKWrhmLN6pycWO5CuBFvolQVNfXwA6lLn7d
	Tw4nsfCy8jNK1VqM46sODVstj5rrzhanKAKLHkx43gthmtGD8E+zNhqTn1NBnw4pmNaD26tFWU8
	KCxkiZAQsYKQXjreqKXefFCG7i9d7oYL9PYLKSXqAKwEj5GQmIKMc6wDBA3U=
X-Gm-Gg: AYBFou3ymWGeceA3u+LwkNxI7bL3K7weIa5aU66UsByIj7YzdtzAyk0ZZeuImWw7ppz
	D2yuF54X0nNmxlY4bbxlnyeO8rFYA6OR8DbsJDH+gB+EVzDbdlKW22Btt0BQgvt8A7tuNL+521H
	SomAl2PZfQ8ordBXf/CBVV9NG/bN8BgDv8fpLpJ95Q25nbOTJZQCn3+g71oCMpY+9YC5jkE/MgW
	+qcJtnkE7yJBlc/X61SOHvqeqN2+FTazEHeCF6kF3imPytlbJ0571476RTq2gI2wIzO9/Fqnn4D
	s/rTejKOsOuoaAiVLv5oG+4kGiUuPkqtsYVXFX3OXPFup0DvMMmL9Lm0TJF0dXo1YlsGgrSjXpg
	hfEN2hCscxPOc7j1jzUHS9Q==
X-Received: by 2002:a05:6102:1626:b0:7cb:fef7:3763 with SMTP id ada2fe7eead31-7cc92623e94mr467068137.3.1792582339588;
        Wed, 21 Oct 2026 04:32:19 -0700 (PDT)
X-Received: by 2002:a05:6102:1626:b0:7cb:fef7:3763 with SMTP id ada2fe7eead31-7cc92623e94mr467038137.3.1792582339070;
        Wed, 21 Oct 2026 04:32:19 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4678fafd25sm67887866b.47.2026.10.21.04.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 04:32:18 -0700 (PDT)
Message-ID: <ce3f58f7-f500-49f8-89cd-611d8e1ac6ac@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 13:32:13 +0200
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
Subject: Re: [PATCH 0/8] Migrate PAS clients to qcom_mdt_pas_load() and
 qcom_pas_prepare_and_auth_reset()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab
 <mchehab@kernel.org>,
        Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0NSBTYWx0ZWRfXyrx8HlSymBQI
 PRp5RhhlZfRYABKdjTKhr/OS6HQG3uiEr84iuNv28WSc25sHRJ7WDU7GChkkBLnktzZTaiY6HAX
 AfHGP7o3hru8f7kUIRTnOndM63cNN2RL/aJvGHcHD7S/ECS9kQoM4I+NCDJoNt4CPod4X//J1bJ
 sTfOymcstjIKnWMPrMbgZntCoCXbIPgDTH43oaRUt+leg/ot4QSIKKS7TrwZrdrVCcBOP+vHdsL
 ZDExfyl3f7wz8pMtnwNko74LiNCyCnuKvzaGjy8yBDaEJ+vO5WWM7LdbgCdLgXV9cay6JB2uYBi
 lrk7oGYyV6od2Y2ywtSQESL5v3r/jRiVU6IKuh8k90S8F/XzyvF91KRGVxwPTrlBUH+EShlNCgy
 tuAOEeNIUf+3pYQidqD226fhRyBmym33gS8JEL4INoD3owqEa25gyI/Ce3h3RI6jju4ffnwwAYh
 ZlU5KkJxMcmrIMRiybg==
X-Proofpoint-GUID: 0i_RsJ6ifGdvd4SwZTSH12A5HDoEghli
X-Proofpoint-ORIG-GUID: 0i_RsJ6ifGdvd4SwZTSH12A5HDoEghli
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0NSBTYWx0ZWRfX0+qNR2XNsBO9
 X3KKMFk3wFSdOyyVwwbh1XVy4eyesSVFD1GITLCDlAf22v/r3jOSRPnoBHbLgsNwDtiyCrIfzKp
 odWYodxeNlcH1mwJDCmy0j6GEXoFQMQ=
X-Authority-Analysis: v=2.4 cv=HrTjiETS c=1 sm=1 tr=0 ts=6ad8a2c4 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=25W5T12MUkcB5wj6RmwA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210045

On 9/25/26 5:57 PM, Mukesh Ojha wrote:
> In preparation to remove qcom_mdt_load() and qcom_pas_auth_and_reset()
> public function, migrate every user to the new PAS context-aware API
> qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset().
> 
> This series migrates every remaining caller of the deprecated APIs
> (qcom_wcnss, adreno zap shader, iris, venus, IPA, ath12k) and then
> removes qcom_mdt_load() and qcom_pas_auth_and_reset() entirely.
> 
> This series is based on top of although no dependency as such.
>   firmware: qcom: pas: Make MDT buffer retention explicit

LLM has the following comments:

 1. Metadata buffer (ctx->ptr) is leaked, and overwritten on
reload, because qcom_pas_metadata_release() is never called
(patches 1-6)
 2. devm_qcom_pas_context_alloc() is called from repeatable runtime
paths, so contexts accumulate until unbind (patches 2, 3, 4, 6)
 3. use_tzmem is never set, so the shmbridge prepare step never
runs on SCM and the commit messages are inaccurate; TEE gets
a real mem_phys/mem_size change
 4. Not bisectable: patch 4 relies on the NULL mem_region
handling that only arrives in patch 7
 5. Patches 3 and 4 don't apply to this tree; iris
iris_detect_firmware() still needs mem_virt after the load;
the base of the series is not stated
 6. Patch 7: NULL mem_region now means "map internally", which
weakens the -EINVAL sanity check
 7. Patch 6: redundant second ioremap_wc() on top of ath12k's
persistent memremap()
 8. Patch 6: ctx is set under one scm_auth_enabled check and
used under another, which is fragile
 9. Patch 2: the context now carries the full region size instead of
the MDT size, which matters if use_tzmem gets enabled
10. Patch 3: stale qcom_mdt_load() comments remain in
iris_firmware.c
11. Patch 8: no issues found

Konrad
