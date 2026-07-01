Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC52243634B
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904259; cv=none; b=aAzETTVzi/bn6c+RlkaiyJvUGFz7aVwNzbp6pUYhcg172P5o7UyC9+r8kpr1ePkZZDX0GVKNFhot2ymgzLOFak2v+QRhjj3NJlWmbXmh6zAztezeA/isMi8WCbc4WEh+OfDCu95mrA8lv9WLcJPKwnbycxU6a4jELZV7wZZyK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904259; c=relaxed/simple;
	bh=se5+mIiql1qcAS/QA/QdhGoq3F488Nb59gImUNbQodE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ne3n75QwxDW3rpZdZMjB6YRe/38ohAVJmMcJmJVQTm6wJVPpfDjfGOoUaYUhvyMHj94wLA1DzIZeY6ggwRc2gzCfkkbQo99BR/37f4jZl1kSoU6O3zxSQGa0/2y7x/n6s6lh4ftgjQ5PIFmdTqfUTKHitf7Mp1zHRX72uzNvrJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EiVY6z7c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OMgIx2ye; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EiVY6z7c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OMgIx2ye"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8UL9680776
	for <netdev@vger.kernel.org>; Wed, 1 Jul 2026 11:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n5nBOf/Ov1F+rraEj62zHawTRB/8BjMFTvGV2tnm9N4=; b=EiVY6z7c4AclhJxv
	IjydyH+Cf8APmGkuVaT66N2cKfurEuN4IifGkWx74mHARak9ukggNmPfdqugDsc/
	jbMa3p+k64vQkZ76ffbcdebzndLfIVYO0bnFRSykzIvsd8t+mQmKLWuAowNrWiIu
	o2kSM8Vs8TO+emdmY3tkXQEku/1WkpkUYKJCyoE+FVfZlzIur/hxrub8JBCNXlPj
	L3caq2QjgybbdwaC1QRAGosiePnSltCTrmJozbzWw3+EUbdZWH2ljPtchgjGssHm
	muLzoeFipStVoy+j7zPbClKblFd6XHlaLLivvkoVXLUWnGFBhw4wURAD0a7wHw0d
	a1wavg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4k3skubt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 11:10:57 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c15c77619so993261cf.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 04:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782904256; x=1783509056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n5nBOf/Ov1F+rraEj62zHawTRB/8BjMFTvGV2tnm9N4=;
        b=OMgIx2yeVmoanXkZMu4y2TRFXtiNcsxxb34vRbLjMEoeG1dZz0cs9O4ifzpKuNc3WG
         2BntP59iLZPS8tIba1xcmWO+s9oZGCzdHE9ZoGnfrRNxju7zKGqz+DCMLQVmae1SW/Xc
         0Mh+eoQm07ZKJwluvt4jMaLwp/lEUS9npUtpOQCU3YjMgUVDK3oA0S9wE2iHpnfMtcka
         bwBRdOlg28l0ZR6jz3pKoB0QME00FgoW+E0JOwJ2vzYzTp66palvQXZ2VJAXvUqkyrlF
         ZpUQFb7PQMtrkXK6QUM72fQ9HTxNv/GnF+EUgBd+1SVTVo3wlvWjbWMzZ5xKXOu9IgDH
         2v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782904256; x=1783509056;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n5nBOf/Ov1F+rraEj62zHawTRB/8BjMFTvGV2tnm9N4=;
        b=M3CUsSScPmQIAc2yNDXTAXvMjRUy2xWEyeu3wJh+Jlw+l2gMmAr+/TeddxGhTDuFXs
         9uFRB19q72Vio285nXAZGzKZiXIH9DvQ5oIyIvGtwmvhRLWWwz0JHY53j3BbSXkyy8R4
         Cb0LTsYhEkkz0/auI32tPXXW5rDmLxRRoQ0du4NCEQjxVxtqQZbQqGoDix2iXGgbsA7E
         bJGZhGZBfmXp1HpBwK4t60tF9ZKJOapsAbZRQz0OcztwLVGeQJAj5cgDwhU95F0oyRYA
         U8/1EUBsxzMKxHIycJuS9WEuKRBlkGbxiFp9qPCFo1VNSfDcuqOTTYJTihr8RLmtSIbO
         VYLg==
X-Forwarded-Encrypted: i=1; AFNElJ8u/uQ150N450fF4KCajm9tu/KMt32MIjUnMvWDTRrLaUsJ1kjqYdfFxb75Jquc+WF6dawAAFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVss1SjkydSnQvfb3fd6pYXfIn6Fk6cDKUmU3aDCEYhMmZs1tU
	hu/dJdYMOIx/aW8amMSTkXCbsAMBm3ckD/D8niTf12DaUlc39GOpXW5bFLoAzaMLlsq7Y3Mx1wx
	2PQ5TjdG6iDA0R7yb/lN9FtKFfta1qk53SMUuSeBwMEBUIt5uYk2SvLiS88I=
X-Gm-Gg: AfdE7cmaWhH0/GafRi3FMh5N5nsA91RsGX4LHbkfM3ybf25lBgEInr6YgUPR4W/leVl
	xtDMmHu7SGSMu5F4ls8LmGssD1SNJ0WdT3UeWdSqdeg7UTGgcE6q9OMIKc0W8LoQOlWzYQj5/eN
	/CklF0rjtvk8LwlhRmUwbWrx9RmD7SaNdYtn0+PxiBhLXxHzzH5Qa/CbMjWiW6B2afJY17Y1ork
	i2H7rmedLteoVtMJILtJYWAaSe/VGykRZlSpTh5K9CQptOh2yF8eCXsMbGqFQeBHghtszywiHuY
	d4GVV40ZqCrvm/RVc2Vr5NAfSxGd2BaVdsLuNpRHnTyaFnowpv6ptNzmdJSIRy+b8nnFahxLg8K
	NWWtk6x0Sih+3KKA4Xog7ZWT7VpGReDWwiL4=
X-Received: by 2002:a05:622a:164f:b0:51c:d16:b498 with SMTP id d75a77b69052e-51c26b4ff5cmr8481691cf.10.1782904256287;
        Wed, 01 Jul 2026 04:10:56 -0700 (PDT)
X-Received: by 2002:a05:622a:164f:b0:51c:d16:b498 with SMTP id d75a77b69052e-51c26b4ff5cmr8481381cf.10.1782904255890;
        Wed, 01 Jul 2026 04:10:55 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c3b5ba9sm2553522a12.7.2026.07.01.04.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 04:10:55 -0700 (PDT)
Message-ID: <392d38bd-8bc8-4567-a79c-dca7a1bb8e34@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 13:10:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom: scm: add missing IRQ_DOMAIN select to
 QCOM_SCM
To: Julian Braha <julianbraha@gmail.com>, andersson@kernel.org
Cc: sumit.garg@kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        sumit.garg@oss.qualcomm.com, harshal.dev@oss.qualcomm.com
References: <20260701110344.1999068-1-julianbraha@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260701110344.1999068-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jgqs358kL44MCL3IpPfPtASY66d6OEMo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExNyBTYWx0ZWRfXzOc/w1E376BL
 R8sjizru8+Spu1w4HKufQU42ZGUWvs6MspKbEyHRm1LKFBnEkuJVjMQmguDivcuUXAGTY6V6m6y
 aie2gWFCVQaR+Do8BGkpL+o/a1v2cwSbdv4lCPHT9X8Nn1mEV8/pf41p6GJtMKWK093RkbQEXXH
 YVw1kTOy4H2wKSg7UaHIvvwgdxqWAsc/Pgev/1bsa2JUatVJwn5zn2dEi93MOyVoRElx2d3FQvy
 4tDIbkhdDiFgwIXFPJ720CeJbtlXdyP5i86FDd/n1R4rANlB9g+mN6Y7CR+NrZF62m6CkJLhvy6
 YcdxAq21N6S9qZYNJd3GyRjybjnzms2JKqvxIIMMSZXqG5DXk/+H+ggQ7edOatrRajTBb0U/LE7
 sIIBnU94GnTYAd06Zri+M1uxUGSFaW1zkkZ8K/EpwFWyw0pHArZDfOa0SUTCmlSy7zEKyjPIo5/
 B9+bRnUVyGnUGnL9NAA==
X-Proofpoint-ORIG-GUID: jgqs358kL44MCL3IpPfPtASY66d6OEMo
X-Authority-Analysis: v=2.4 cv=Ff4HAp+6 c=1 sm=1 tr=0 ts=6a44f5c1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=46PZNAZc7cL1ucK_2EcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExNyBTYWx0ZWRfXx4yqSeYcw1te
 xAdk3IAQ2T8/Tmjc76AWOIHVObLcHR7Z9+W3hSqrtj9xEpgNmmTuQaaqkpiDlA8myb96ps5+G34
 dWieGVDsk7GpSfCmU28KGvf/l9f+JCg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010117

On 7/1/26 1:03 PM, Julian Braha wrote:
> 'drivers/firmware/qcom/qcom_scm.c' calls 'irq_create_fwspec_mapping'
> so it will fail to compile if IRQ_DOMAIN is disabled:
> 
> drivers/firmware/qcom/qcom_scm.c: In function ‘qcom_scm_get_waitq_irq’:
>   drivers/firmware/qcom/qcom_scm.c:2512:16: error: implicit declaration
> of function ‘irq_create_fwspec_mapping’; did you mean
> ‘irq_create_of_mapping’? [-Wimplicit-function-declaration]
>    2512 |         return irq_create_fwspec_mapping(&fwspec);
>         |                ^~~~~~~~~~~~~~~~~~~~~~~~~
>         |                irq_create_of_mapping
> 
> A patch-set in review proposes making QCOM_SCM visible in the kconfig
> frontend, so let's ensure that it's safe for users to enable:
> https://lore.kernel.org/lkml/akS_6izxrhgK-I22@sumit-xelite/
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
