Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925123998B1
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 03:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791517369; cv=none; b=XNndYSzmy9MlD/UNzx1hbmpchWZjGVPQhTsnrPA3fSyXwuurLG8toqS05jpwURdPVmkWcaDheTapW3FbpIXF1x/d1GRiq5xjNUSBNDH98vIAHA+zLZvFwFXsbBtvAbsUjsue2s+pe8XgCIhbqOHgn29rZtMeuluKq8Yg6B9Lw84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791517369; c=relaxed/simple;
	bh=oMmbNnz932x0fDcbEC3ogsWJcritc4/OIAiDDCwdyVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNZure9Y4KQEKUXGpUUAxOXYe15WS/O298rj0smnn0bVnApJWAjihRcFR/chc5758a9MCN8l2mD8RAhWHRUvoLo/PSA5Hcn6e3L8Q6zLoOh0l9hWPSpA85M9hBJABWEtcllGz5CjsR3YM/mFm3I0m8S4Qup4CJAa8V0Oc6XwZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E5KBbTJR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h0y8PikE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E5KBbTJR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h0y8PikE"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HHhn3943342
	for <netdev@vger.kernel.org>; Fri, 9 Oct 2026 03:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t1z7NeV5zzw+Qh/Xy7bTSMaYqP4hRm0zEwpbgCNxVr4=; b=E5KBbTJRdB/IPv5L
	HPEJG1sGFDtiA8Ok8DX7DysczMA7y/EvzCmu9GobIIJShNphngiMCcgHBCMvSxCQ
	zI8UET9o3q9qLtpnwJvBrP30Oa5eE7zZIDmOtPYUM30HMOvCZ87eWWkAzfnm/H1p
	Pta8NHDJFoVR51mIbqn1fl2e2FN6dRoRO0CENgkTqyJwSw2Qlt+E+GsYAHoMT7RC
	O+9n/DzRb1Pp0bEJVwdgbaFQLeYoWp2jWpfN6ltAVQH+TN4rfoHv4gcuWHzsqb0n
	5EcWPKSwqV1TwdxcmAGuMws4LLoQ4PQmUjeAkogsMkOBz843AqH6qPsQh1iS4UOM
	KTtcWA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxk1rhj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 03:42:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a7d2f25f65so964205a91.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 20:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791517361; x=1792122161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t1z7NeV5zzw+Qh/Xy7bTSMaYqP4hRm0zEwpbgCNxVr4=;
        b=h0y8PikEJRfd/tlSt9uvx8MRehvGxtY5XzIJMeP60YR5sipv6P1aGvgwSPVclo4Rh2
         AmfsB3gsUmDsCgN3yP1QnlF5WMaUcZ4wke0qdMfcm2k/+NWlEweGKnzR61bfWX4ZPiRC
         PJqRdBIOXAs7h4TE9LGpt8IvnxIXix0XOY9jUgB1agLfG28Xx3tr2TUulm3Z86oJ2qbl
         3Wx/Fjto1ipK49161pfr4lrJEDz1KAHMKaVCwYhYMeM36Y2lffIRGReRfxzSQpvP/Lae
         mv0wOOmry0Cg4Be0teiOu1a0ib/yB7txZ0x5dlaYCJN6Xiez2rFeYwjmhcqTevX9bLJx
         0dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791517361; x=1792122161;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t1z7NeV5zzw+Qh/Xy7bTSMaYqP4hRm0zEwpbgCNxVr4=;
        b=msgcb6vmi+WVj80lx8gMtIPufvAR0U/IplExAvTOvTmeulrQT8/XPDOgydw7w3qUOM
         hNXRaJVXFIAvOhj+HGlz+f4EYR3YMGVO8cfC5hQMn59l4fjal3st9h5dS1QWNNjQ2djm
         ZliwgtYpxTFQkDUloD/YFmDTm+c2WeAwCF0bCLoIoWGBLKRiDkeIuvaEC3k1IqzGqTbW
         8V/1MtGoqR71QWpz+wc1asYWFBxv2oTf3udgxVXkKG88YC2EL0/b2kX7bCZJKYnxF1rm
         23UgLBVzlg9W3HPyGSg0p+677/UY8yfRsbRyxsfQwkKyyhPRl9B9QMzUFnwvMPvVdrAH
         NHpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJCEuzYdr13rRIxhNk4Y4jU5egH9r5T8NylBfuGjE/4iXN0GmzHHkhOt03Sl0J3as/4dxnPm0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgWkWnIbPnQC7rjwwr2oHv+efqtp1+R/1i2cp+L+AFy1Jy76zj
	X1TK+1l913tbdAnemW76mAbRjFqxXVtfWqGFz+ryRjVaTuK5o5ff497WQrquXyWA2WpK44MQnm2
	3UkzEEoC50hbeD1tHOhESjMgx5R1Ov82lfOOMTftJEtQFApTwBt30/mrfJEk=
X-Gm-Gg: AYBFou2yFId5KpcQzujALp3vVSuaBuIe/nLwjgKO8NI1PtQG5dldfDBmm9RDP+1/Tai
	1XZT1zUXXpGeiRrI4dFCan6SFfneABbKt/rSGPcgZFnlC7CBYJtrLLbJNWhwgAwbvjSISVVVEkW
	6BqY483IYmsgezVvd7ntBc8V2Dm5gPrO46+tnOvTSd63odOgC57tyRinQW5Z6HgizrsUkSanVpU
	wVLzr+OT72PzbvzSKMoD9DDOVsSvQMWFXPjfb99kjt8maP8sSAal+w6wButNYHwRZNg2yiNrGDp
	ZE7KfAThnaowFOLSYeOT1yGnmqvzPfRVdA7OZ0tDJxuaBOBpgErvZhCxIS53fagAOxhbi1+zv0q
	P69jKS37opY6xN+WYkOtu
X-Received: by 2002:a17:90b:2d82:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3ab3acdc391mr403452a91.38.1791517361048;
        Thu, 08 Oct 2026 20:42:41 -0700 (PDT)
X-Received: by 2002:a17:90b:2d82:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3ab3acdc391mr403427a91.38.1791517360547;
        Thu, 08 Oct 2026 20:42:40 -0700 (PDT)
Received: from [10.92.18.229] ([114.94.8.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38ddac6dsm1351959a91.7.2026.10.08.20.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 20:42:40 -0700 (PDT)
Message-ID: <4272947d-a9df-4cf2-b890-c2b2392800e5@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 11:42:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/11] net: ethernet: qualcomm: ppe: Add support
 for IPQ5424 SoC
To: netdev-bot+sinfo@kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lei Wei <quic_leiwei@quicinc.com>,
        Suruchi Agarwal <quic_suruchia@quicinc.com>,
        Pavithra R <quic_pavir@quicinc.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com
References: <20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee@oss.qualcomm.com>
 <179147126645.2527009.13829110581548714861@kernel.org>
Content-Language: en-US
From: Jie Luo <jie.luo@oss.qualcomm.com>
In-Reply-To: <179147126645.2527009.13829110581548714861@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fKesTpae c=1 sm=1 tr=0 ts=6ac862b1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=+dQloWKbpC4JZN4npCJT8A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=wfrYX8O7EWgUh0Dss7UA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: uxMmqI2N_I8Q5p0Qhg_1sv5FUd29OFfu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAxNCBTYWx0ZWRfX482qqrauTx6e
 7VY15d5IdMB2d5gIgqbhGJsxZRIF39RiwIUpjLcYnDG+hGLZy3iB5z/4/OKasWc1rxC+YhPF0Sm
 w7V7Lfeijw99B5io7t5EDBnvEWlo3U0=
X-Proofpoint-ORIG-GUID: uxMmqI2N_I8Q5p0Qhg_1sv5FUd29OFfu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAxNCBTYWx0ZWRfX95Qea+Vdnnwi
 IwkP+vieDrrMpBRk7Sd7rQLhsR9XWXmGJr/VMY/Y8+FHnz2q8HiFUvzbDz00mEa2mFrKUvdr/ne
 ZIGfeTp78/y9i0ZzH+zs4aKCvDPafYz4SUAmjU3kdRb7dnQKQE/9yKkvyGvjmQ2HB6lvJ8BcmB9
 HW530k1L3ajaZj2+Z91/E6PdG9rr5HJjBpqACCQEPTaQukC0Hmn9NY/6faa04vuCY+kfF3HeRKb
 qUxjRdccmBZz/ANHcwX/E2NNpw1+kxM6zyinZkitXIVekoBA/PG1a5zIDGEcSjxH4uvIvaLLfBY
 DzhSM3E0a8bKg1jA6U95Cg6qOb7opj3l1f7zErQR2MCIDVEXGjv4QDajB+4/KZYloz/SUUFP47P
 xPXSPMbFs0y4oHGek+NNLEoHu6DfyGPXguuIjarWLpKK0uFomunlfBGkIm1GTzwUy35YU0KrsDX
 jldoO8CufdF5W7hqwsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090014



On 10/8/2026 10:54 PM, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Both issues are theoretical. Neither was hit in production or reported
by users.

Patch 1 (dt-bindings: Split EDMA reset into sys and apb): [found by
manual code inspection while developing the IPQ524 PPE driver]. EDMA
driver is not upstream yet, and no in-tree device tree uses the
ethernet-dma node, so the issue cannot be triggered today.

Patch 2 (ppe: Fix multicast queue config table index): found by the code
inspection. It was not seen as a crash or an error message; [the
multicast queue thresholds are left unconfigured without any visible
failure].

The series was tested on the Qualcomm IPQ9574 RDP433 and IPQ5424 RDP466
boards.
