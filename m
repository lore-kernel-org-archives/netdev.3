Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665291;
	b=TlJOfvZTseupGTSRqsSq3C+m+PqfciPj82/SAat+NR0g2TQpiZFXBkq2jjUbi4yRn857
	 4PLlBOj5jCH3S0wNUI+LVuFqPIjAgr9FyYaIxQE8uEAA8y9uCbErqMgC0a0IOh0jDGyIs
	 WRLfsDLTYk5OsGQby+vgBbk1YnssY987Y0OJmbsLecOJ3VENWTfDAl2ATYnGJX/5u3knK
	 tGAfu5A6LcGpCWHV74NUeWa2PxPxIqfgV8X/M3HOZMMsnYupIKN503H48+pCOdGLO/noJ
	 6rQxZXuc3rI8bQdFmggCY3E/8FhCe24aDUB0/6Ml25o/iIN1QYOjenwjDX7aWwFBI/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665291;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=m1CYVddtSAfgtkCDt6VccjVuQkJ2y3YjAFo+UlGYC+M=;
	b=4fqmNuXzn8sslKpfFZCsKnc8DtbELt54FvCSSgVx2Xfp5JTBEYh+Mzy2eeaK0TrpXoy8
	 QfWkYQ3AIQH37Yd3QhHehn0i+RdRvOPVm80bcNI8japbaWKJ+XGkkUF7TcP0LEf+o2rKS
	 F1At0QfRAFduCL1Cs2iiatutVhupBNYwM2hgt8rdD3YOxYPib8ErG/HGKU5KIswcxBlAJ
	 Ps+/OWwa2jK8jXbT37yFsdOVoPHZkD/wtNNWPT4qvNhJ9FWT5/tFgbiT0ZJzLhAhh/G0r
	 wO6xMBYh/+I0w8HW/BJnxwKxdExGXuoHkC2c85vaf5hBDvSZTsoI7jeIvtzYIWk4Iyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AAiMmWvz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A29RzVuY;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA04606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 00:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFA04606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AAiMmWvz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A29RzVuY
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2K6Fjd720422
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 00:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m1CYVddtSAfgtkCDt6VccjVuQkJ2y3YjAFo+UlGYC+M=; b=AAiMmWvzUkKHut6Q
	ulNXTMSVgicCv1fNnSxRvXiJ6t+aFn74HFgqhOfd7c0gYb8q5CYSFoxDogS7yQlZ
	dCnx7bq8U1H+Xf14+rKXEq6YZvw+5wgB+DWiVMNe7QJEhCPhDoHZLDHB/rlmDsEo
	RbJZAxp0WaOXPCXdx8RrtTpaPrvDRwIhDrK1Kf9BDxkRiW5WQQlyPWw2gIHl9qLD
	jdsxwWmMTA6am3+D6xjIr8JO8y9ycMeSJOSCW7MvcnXumccJvw8lMQ4vRxd/hHHz
	ikGuDdxT9WaqTK7a54Hd+BP0oZ1J3TniDgWpHHSYOlrwrrw/hts31hri9KFLEu0U
	Mvhu7w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq08713xr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 00:21:29 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c3c370b17so6098873eec.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 16:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793665289; x=1794270089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m1CYVddtSAfgtkCDt6VccjVuQkJ2y3YjAFo+UlGYC+M=;
        b=A29RzVuYqO1WenXIJEkRiE/kDgO20z32vjxdpmfcI4o/MZPWVDnhH9dG4ScsafzguC
         XY8pyY6R0J4V4dhG3eAsMvCsDRFJCkXz1yXtdpLFzh8lqzgXzwd0Z/dbqe+kf1G32g5w
         T8yTOvgs05BeV1beBPkhcaCwhXXi71sZ9Y5Z1Ghy4tqrG1g97DuyviDaY2Qcz3KNcIeM
         4dOkw3VfyIyjwoPYYgQ3aTYaJGglxidwO2ncPoHsw/5tgW1Q4Jf+zTAg2Q9WJ1SyestV
         7XM166VNpXyrd2d+OTN3qyiSvaX2DRiLmEKPID8G8C9FkM0XkD1W2C/6b3fdhxKSr+Ho
         Pohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793665289; x=1794270089;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m1CYVddtSAfgtkCDt6VccjVuQkJ2y3YjAFo+UlGYC+M=;
        b=qL8llxv12zIqHMFbcEk4t4cZJ3Y60DYTntRywFNIheDB83G2zPNU2lRn7Pva7IDf1c
         7sfcmLvYPuKroZoTHcSZ5j5kf6sNyUFmO/x7nrTAhf4DMyP4h1JHCGc/3FX+daPXZsdW
         bpPv8Jr/RmhucnknCxqfWkoblTR0zMzoMWQ3J17BIlRNnw8FlsW8O1//Y/5CTo8/lNYZ
         OY5eLPpAggsGHVjv4frTSR22FQ3SxboVtlTJKgQtoChjneFShMY4U2nIWxVuh8toePOj
         sRZw/Jj+BIjpxM2CoB94bo7k2HtOy8Z9Dh2vAdpa2/B1kh8357xq9Rf96S1lsqZgUEa5
         /6Hg==
X-Forwarded-Encrypted: i=1; AKwUvBw+5PqlsaY/6k2b6jExuK92Jfm9bXKP0lps/FuJNpjv63G+zV7AEW6fZqBd9iZNJn3dUMJuipk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLb5ah+wcwbRp4zpltrNxBJpqkAvYiAhc8S6889nh/d5qiZ3bEg
	joObigqWGFWbiVWrF/PCRPJy2V57YHGYl9AducfUl3vCmf5B32H4sIoHwm3Y2RoLVFYwb5NgY9e
	A0ofoi1AtnmRK9i4c3XOupmayhx4ZQhXNR8oJF+R2sOUigtuO9k7ueQL80eg=
X-Gm-Gg: AYBFou2Rnw8Ivjcx9l5WJQEZhIm2sp00i92sjybijYIDHkUPBdBGVhU0yeCOA3Xh0Kd
	B/HYrxWU9gOf4+7fMlK4e1HwYs/+ponalDahnM72mvKaBS2w6yzDtPgXAFNF7R5h6GOGw+mck6w
	YdPKGKjBhMcHxSURUJjlftoYS9eydGzfQTmI51Z5laIaOsO6sPcgZm0eqAX5vp5MEHjpU9Ix8vd
	klVZBdGyfPBJufrHMs+ogKJoeY5iVp4GrPxjS1b2qR/T7emgAiF/EL+QfkNwV9pAVqaP0n8oMy4
	wArvQ1KHABX0d2RNSMGgwymZVdh1/Pk+ySmZVp9Oexd0YxD3/FgXglEXAJcqlnUXu1LcRHSy2KU
	sbpNypyQb7g/9LNvaebIgPa1WdyB7vpjPWEAfEjmnFv3g+bOr8t9hgdY5sV/dRRSzuHynbjT7in
	752dGgAG+P6W8=
X-Received: by 2002:a05:7022:ed09:b0:159:aa67:28c1 with SMTP id a92af1059eb24-1ac5c92da58mr16984837c88.20.1793665288410;
        Mon, 02 Nov 2026 16:21:28 -0800 (PST)
X-Received: by 2002:a05:7022:ed09:b0:159:aa67:28c1 with SMTP id a92af1059eb24-1ac5c92da58mr16984780c88.20.1793665287605;
        Mon, 02 Nov 2026 16:21:27 -0800 (PST)
Received: from [192.168.1.148] ([68.248.129.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428c17bdsm40121421eec.6.2026.11.02.16.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 16:21:27 -0800 (PST)
Message-ID: <7005e138-6d5a-4c39-aef0-7200cf3bf911@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 16:21:26 -0800
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
Subject: Re: [PATCH net-next] net/stmmac/dwxgmac: Extend MTL/DMA support to 16
 queues
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, k.domagalski@samsung.com,
        k.tegowski@samsung.com, cs0617.lee@samsung.com,
        abhishek.chauhan@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
        sarosh.hasan@oss.qualcomm.com, hongmei.xu@oss.qualcomm.com
References: <CGME20261016193835eucas1p128cb1712afce0314b1ecb65b0c0fc841@eucas1p1.samsung.com>
 <20261016193823.2711773-1-sagar.cheluvegowda@oss.qualcomm.com>
 <atXhR0sgdW84YxcQ@AMDC4622.eu.corp.samsungelectronics.net>
Content-Language: en-US
From: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
In-Reply-To: <atXhR0sgdW84YxcQ@AMDC4622.eu.corp.samsungelectronics.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAwMSBTYWx0ZWRfX8ntdCsTgm3Ql
 XwPsUM62+6xj3u60G94nYL/yJrIaZ96TNRIqSayjcjRCuRHO0JC/H7r6yfc6pieoKlJsD4CioRP
 bA4tg1ZM+1Y+U7A+RDHSc1zxYzKwfCM=
X-Authority-Analysis: v=2.4 cv=K9m3jCWI c=1 sm=1 tr=0 ts=6ae92909 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=djYDpCgIitZxdph7ACYjJA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=XF986EujfQmVbk2RL3gA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAwMSBTYWx0ZWRfX5HC8HG0cNhB8
 zUbit9Iolypsv15/PFP53CMMSGLYLFg6/sYF4dLEx1ny3lXjvROkkEzg8zUbPvZ/07wAkQmChBA
 auPuSn4zLFCNOtp9wo2Ke3kZ8tjs4h9/aScahUISer+6Ld1Cle1Zvkj+UCjArIAJ//e3LFYph8X
 K6Nb/tCd2p6/Zit4IitazlWT2LYiO1wHmrkCMCR8pb5sx/brq06OlunCJ/s0QdvgWZZVmgAG0LJ
 PuV0v7Z2OIy5zcpRe8Q7CA+4UeTg0F+CT5XD4mcGnlKfLAJKgpalGNdacxHBq+Sej/z8IDhHbok
 gr1qYBJpCZ4aMs6KlGxEwujs5Cy6xQl3tYGHM2hmu+EPTmpNosxC7oXfg+j+qC3trUF4K+lbqr1
 xySNvJgYjVBxJOJFK+20HcCphBtFGpoAW3FN5HtaaSFXZR8oK8icRB1gkXsHDYOZ1PS5t2IkkKR
 S+pz7w1EC5DzxP8mYcA==
X-Proofpoint-ORIG-GUID: lVMrJjY7IamTUD9BxE3sdrqIavJAAent
X-Proofpoint-GUID: lVMrJjY7IamTUD9BxE3sdrqIavJAAent
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030001

Hi Jakub,

Apologies for the late reply, and thanks for the review.

> - Does it work if macro MTL_MAX_{TX/RX}_QUEUES is not increased?

No. With the macros at 8, the DT parser clamps snps,{rx,tx}-queues-to-use
to 8 and ignores the extra queue nodes, so queues 8-11 are never set up or
mapped. The patch has no effect until the macros are raised. Our 12-queue
testing was on a tree that also raises them, and my note under the "---"
should have said so. You are right that it should not go out on its own.

>   How does it look like in your hardware? 12 DMA and (8 or 12) TC's?

The Nord hardware supports 16 queues, but only 12 are enabled in our SoC.
It has 8 TCs, so DMA != TC here too.

>
>   I agree with comment by Jakub Kicinski on my patchset 1/3 that I should have
>   implemented it better, but never finally did. Issue is, stmmac driver
>   assumes number of DMA = TC and uses {tx/rx}_queues_to_use everywhere.
>   So proper implementation would be spliting DMA count and TC count,
>   where both can be verified by stmmac_get_hw_features().

Agreed. I went through your 1/3 against the databook. One point on flow
control: XGMAC_Qx_TX_FLOW_CTRL(i) and the PSRQ(i) fields exist only for
i = 0..7, since PFC is per 802.1Q priority, and 0x90..0x98 is RX_FLOW_CTRL /
MAC_RxQ_Ctrl4/5. Bounding dwxgmac2_flow_ctrl() by numtc is therefore not the
right limit: it happens to be correct for 8 TCs, but wrong where numtc < 8,
and it should be a fixed 8 (the PSRQ window; MAC_RxQ_Ctrl5.PRQSO can shift
that window).
I will review the whole series thoroughly and pick it up after testing it
internally on Nord. I will keep your authorship and sign-offs on the parts
that come from your patches.

Thanks,
Sagar

