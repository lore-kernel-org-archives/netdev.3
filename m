Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EA14F68D7
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635310; cv=none; b=F3rrB4GMFlUfETGqpLKzN1nQCOt+2Xp/ixQyFF+oo8rPD0v0JTK2pEN5iQmYkFOtEN7lOBhkrQozgE+1h+LY1DHYUG1vn3XALqhAEuOnSozXoQ3rEwiDauqMI528wtuBhdG4y6mgWYAQRH21ZWl5Txi/EUBdpnBFBPaplDuF1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635310; c=relaxed/simple;
	bh=Y7TrbY07MB1wxA/bsFezV+7VtGSYdawE26S7EDf+DDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9gjDvIvawqgf2zjYmAgetIbo1PJJHoS8GmqnrD0nuvqdeeqS1PwJ8lH/bIGCmoqb0GIP6/LSBr/1iQX81foP2oXRgswFVCqm8f1ynuEcqF9cxMb+RJtwjIXnTwDzBwhuZpF16KIBwGlWYy5B2SABLGMm5Rzos6DRzuSgUeLisE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ey0VdUVh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NE8HRNk7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ey0VdUVh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NE8HRNk7"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SLTWcW3200516
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lc0k+BB+B+pR9YWQ1iPcOnfiXQnv9hmfa3Jo581awKM=; b=ey0VdUVhTiQujIvu
	rGOGRtg+9yJrmlcbf6Hr5HkLn11O5bp17i7/sX4iSRzZ0+jo9q6CHcogLe/AbW7Y
	YBDGBKgqvxLsuaJaTiGaSi/2BF7AI3Q5y7EmQJQ03N4JkCHVRDkNLbFOTF/vnE1a
	l1A1jz7V85ITb8dqyS18HxGllsQOwBscxmCaYZsWjbJckw5MSyqJy/XRbbSm+zjb
	gReSYLUqJEIaGye2KK2IrV+RukChEpEPE1yJoi9P8kcn/R3rY9dyLX9g1Gx+rGrz
	RqQ2x3uFs/VocJJ0DFcYNImWhNg8XAK4wer8zM8A2umryL5K/gsJMkC9psn8vfYD
	5HtOTQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynb6k553-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:41:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso5977075eec.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 15:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790635307; x=1791240107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lc0k+BB+B+pR9YWQ1iPcOnfiXQnv9hmfa3Jo581awKM=;
        b=NE8HRNk7vbRjwdtkKVZmF+gv/LeR5ZLYEe5Ae29Or77jM4n/XudyjW65cKxIqg0mxM
         CyWsQHFvpwa7vh3h8rZQB2E8HFoBh/QB0zgStTIsPbxwXJfHG1kelP/AM4t14ZWWIhuf
         IA3LR+r18LNo8lf4XXe1cOI1eZvA21D4Fuuir+R3gQz8jZtjniYhc1pR14cclQ6Ganu1
         bmZhHh4fqYSMpFRgXh95yhNM/WI3Fr3oGvXfAZ2Cp5vr6OkVXitZr7+NpkKh8l9lwpuW
         ZvSVYd6tOoFsH5knG7+YsyAj4qeFtFkHyNoQ99H8MZm3M53o4FeYleoDeJLi+dcd+qDY
         KLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790635307; x=1791240107;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lc0k+BB+B+pR9YWQ1iPcOnfiXQnv9hmfa3Jo581awKM=;
        b=UJIcYeoZf747Q0jpC3/K9AiphbdZM1rNU18C8scDD6JsKklInN0IM466r2IY2hznKH
         fZqBZEK2fWbM7K/akxyQL/Ae+Zs+7RwUNPQZF97ygtGjQj4f4CXPDj7mugOUWth6ci6W
         kNnNdU46aV0ivJQZwyKfpyExLkDAVtNoQw6ZBsvTNK7lLR3ZiZaCppodpuUqeKEZVYBO
         yTyPCesiMqfHi2YB5/hQBLMyYDnPLYoOTOQO3soleuVBNBC6H/uxAjaU7/MNsyp0kEvV
         sQnY/aPmKismIKp4PTV2ZrhLj2mSSPCYTOdN6GtNsNde+FwZKfGdb9z0r205gpTxbXIM
         HVcg==
X-Forwarded-Encrypted: i=1; AKwUvBwVErtYDpZAU0XNiv/SxQEHFl7KN3Qb0Tvk3uSZ76zkQCxwPww30MMVYXUrx9nMX5oskevPN+k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjYK4Th5DOdHe/SmBTw1yhenZL2LCbZHx5d8MlwQxSX41RA8Aw
	bjaQFbo/KjOkfckymZwnR/FZxeNhMizFXyZStDLgwcCpz2Iroe8vUMaldm5UfwgpB0WGMJinCbO
	cBfaEqo9cwfnQpfaTQRDzLibEDvobbi/y7cKgOixW1yoAvuKA9y9//mLjO4Q=
X-Gm-Gg: AYBFou2C7+WtU5jXa9HYI4DoWRxiRbdUceMtZU/VKgjYV6zwEncTOMqNHQwTxLF4H9l
	nCjezqCSG2bIjBj/O53J+8/GtQLjbnj+W0j3wPkyjKFqYCmhkDzH0s2iGBYA0KvFWzXyYumRy61
	ZZNFMdJG1en6UMJP6LNT9NcslQYOfPt91m2nmyxGnt1yIa6wiOzA30nC4WjvkCt9oGQeRyBSze+
	RZvO+lL+nUlcEP32D6WULN/SgEfPS/0mJGMbsQuJUSY2t6Xi58qAFCPWeU24spoqG7qvNnv3Ama
	Q0uEMTiG6wdT9MPa1GFQKAJpyZEYJhU9kBcw9Lp2Yesm6g2m1puO6ql3uSGXlq2KBSVDs0/nQGy
	nFjoAukhtAAPu+EABYWxyInuJAtTW6CCINqIj8wa1UAHe2/KKqkILeyw2BMIG1ks=
X-Received: by 2002:a05:7301:6781:b0:341:a4ed:d910 with SMTP id 5a478bee46e88-3426fcc826cmr14033362eec.7.1790635306810;
        Mon, 28 Sep 2026 15:41:46 -0700 (PDT)
X-Received: by 2002:a05:7301:6781:b0:341:a4ed:d910 with SMTP id 5a478bee46e88-3426fcc826cmr14033328eec.7.1790635306198;
        Mon, 28 Sep 2026 15:41:46 -0700 (PDT)
Received: from [10.71.40.138] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341459234a1sm29893248eec.24.2026.09.28.15.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 15:41:45 -0700 (PDT)
Message-ID: <db2e1a67-4b15-4bec-ab08-1a22457b52ba@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 15:41:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: dwxgmac2: enable L2 split header support
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hongmei Xu <hongmei.xu@oss.qualcomm.com>,
        Abhishek Chauhan <abhishek.chauhan@oss.qualcomm.com>,
        Sarosh Hasan <sarosh.hasan@oss.qualcomm.com>
References: <20260922232116.889630-1-sagar.cheluvegowda@oss.qualcomm.com>
 <aro7Yijt_d-KRD0Y@lore-desk>
Content-Language: en-US
From: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
In-Reply-To: <aro7Yijt_d-KRD0Y@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA5MCBTYWx0ZWRfX7n70wEBJWplY
 sXvpmPjme5MaQG+r32rAivw1yGBOaOZ8uhQ3maPLvTQzdKnIvL9a8Q9rrh8Ihd7z69Qh17dnwcU
 /oP/MZ+512RCXxkXHzepTvtH0aaxJ1EiXMpydU563p6L0uqgzWA6dUD5jYjXQ59Jjw7h0h7035T
 w9AHL+Ur2uUKafjJTADedERXzy08TwC64QhD/55Xn1yQb+PobxKKg9WbqL2kbMGYMEjsgcSLZzy
 VaFN1X+y4dJTLBuUjfDwcHWZMUl0ueHLu2YjU1AenUcoo7y7wIhvP0Ai+jbywHiUeHkcdF190R4
 iNiMKbrmLsYK9kOgGUIyZLsE8h9sIdd1uaM3Pxa0mtvW0ES116n9hUMC7KdEtbEpdACCEU7eBHw
 fAqzb4HU699PxKzNXlKvHYEEl6S5dogjxRuoWQBOLZha43FnDvHjv7DK4+7qQXJEl1esczsGGjq
 UN/JI0a5FK3n6kSNGfg==
X-Authority-Analysis: v=2.4 cv=K+e3jCWI c=1 sm=1 tr=0 ts=6abaed2b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=IMd6QsT5PRD0yrB2h3IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA5MCBTYWx0ZWRfX0t8axjsb0NlC
 9yXRNktqYivSjRXBNMaKcfDe+xLmfYmdeCHx7auuV3+5XM/6uNCa4Cg2BDIB3V5Z9/08QYRHxsw
 Yb3dl6bDnKU6TaKzz9+hm3DyBXpq6/0=
X-Proofpoint-ORIG-GUID: hWiu202qKXRmK34q-COkMmEMP7DW2G2J
X-Proofpoint-GUID: hWiu202qKXRmK34q-COkMmEMP7DW2G2J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280090

Hi Lorenzo,

Thanks for the review.

> Hi Sagar,
>
> are we missing to set dma_cap->sphen for dwxgmac2?

No, that's already set — dwxgmac2_dma.c reads it from the HW_FEATURE1
register (dma_cap->sphen = (hw_cap & XGMAC_HWFEAT_SPHEN) >> 17;),
predates this patch and is unrelated to the sequence added here.

> +#define XGMAC_EXT_CFG0_VPRE		BIT(8)
> +#define XGMAC_EXT_CFG1			0x00000144
> +#define XGMAC_CONFIG1_SAVE_EN		BIT(24)
> +#define XGMAC_CONFIG1_SPLM(v)		FIELD_PREP(GENMASK(9, 8), v)
> I guess it would be better to define a mask for XGMAC_CONFIG1_SPLM.

Agreed, will send a v2 with:
    #define XGMAC_CONFIG1_SPLM_MASK        GENMASK(9, 8)
    #define XGMAC_CONFIG1_SPLM(v)        FIELD_PREP(XGMAC_CONFIG1_SPLM_MASK, v)

> +
> +	/* when FD=1 and LD=0, HL is RDES2[9:0] */
> +	if (!(rdes3 & XGMAC_RDES3_LD)) {
> +		*len = le32_to_cpu(p->des2) & XGMAC_RDES2_HL;
> If XGMAC_RDES3_L34T is not defined on non-last descriptor, is it fine to use it
> here? IIUC XGMAC_RDES2_HL depends on XGMAC_RDES3_L34T, right?

The data book has the following table for this (Header Length
Availability in RDES2):
    Value of FD   Value of LD   Header Length (HL) Availability in RDES2
    0             1             HL not available
    1             0             HL is [9:0]
    1             1             - IP packets, HL is [9:0]
                                 - Non-IP packets, HL is [9:2]

So when FD=1,LD=0 the full RDES2[9:0] is valid regardless of packet
type; the L34T/L2T-gated split only applies when FD=1,LD=1
(single-descriptor packet). So the non-last-descriptor branch
deliberately doesn't consult L34T at all. This function is also only
ever called on the first descriptor (dwxgmac2_get_rx_header_len() is
invoked from stmmac_rx_buf1_len() only when len == 0), so that
precondition holds at the call site too.

Will send v2 with the SPLM mask fix.

>> +		return;
>> +	}
>> +
>> +	if (rdes3 & XGMAC_RDES3_L34T)
>>  		*len = le32_to_cpu(p->des2) & XGMAC_RDES2_HL;
>> +	else if (rdes3 & XGMAC_RDES3_L2T)
>> +		*len = (le32_to_cpu(p->des2) & XGMAC_RDES2_NONIPHL) >> 2;
>>  }
>>  

Regards,
Sagar

