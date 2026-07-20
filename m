Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849142A7B8
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557117; cv=none; b=BmY/FMEPA75gO2lOme/mt3BhfeKk6vn3UV1IxlS1CKbxUQbHlsYUy15VHu7JjE33+JOSPmcuhLIbkiv2AEq2NyGWbPwySs+IKifekte2UpLjb0cDNSj0hqO9MnggxQ8hM+n5RlVMCNyz0eWiK9Pr+kqBPvaB2Da/msomIsyVWpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557117; c=relaxed/simple;
	bh=6XLAK18qq6YBqyBhv06WBGI8a6DBEWNa12vh2vrzgj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=is+neJYXUK/O8ndgGCh/8YWBmF7x5TyxQ0L5G9ZdkRlESgFeHezwiF/3aY1ycz8V/iQLDN2XXebsihLKsEAENG+BPYY+bcY8qUx9BMWDeylsfpUUS2gtV/vPfBm+jvpCG4TTDBLw3QaENa94rO/gQBycpT5psH6zdCURr6WxLik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H23KX3tF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OOlO0iZE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H23KX3tF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OOlO0iZE"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KDqXAD2962851
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6XLAK18qq6YBqyBhv06WBGI8a6DBEWNa12vh2vrzgj8=; b=H23KX3tFcQtmbFl/
	CF+EPLEL5JVgKPy5IOlCvICrmcZXqG/DJBnsGpC0IY8vbNvGmfyh29HeArRqIDIt
	3tRoueqWRM2v1731jm97tMCSovqWU2hWwuxqpVak/u5iDyAbLtoJab0yOzlazGlU
	WX8VplRATyglnXzW3lAmdPjpJX25eDf6qWa77V9z1Ae38fFUD+62r22VA2Kyh67U
	bx/PUu6W6gABIbxxaqFdj9ELu4tjQvBIe/wWam0q5cOzDjG+f0mL0Vm4C2ttSlVA
	TyDsf5piROp5WkTNNI3KL1JMGX5v2V220KGH7x2gADToDQIsR1meP83mr4oA8ncY
	jz0YRg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfdchr39-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:18:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c07313be5so20576671cf.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784557114; x=1785161914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6XLAK18qq6YBqyBhv06WBGI8a6DBEWNa12vh2vrzgj8=;
        b=OOlO0iZEo0dNGy19JpdWZh64+zdx267S2raMCOQ1SbIedejmYAlh0my+3UUQ00FCQ/
         kcBZFiaIv2xxrBJNjK71SSSNp7TS0Xd3HgnEqXkrFZ3Id0RlIHaM6vF1JxEjKrdPo7my
         B5aRQh5rzJ0KfhSAA7gWHp5IiwAdpU0g0/P0dW24hOJgpQ3uE1ExKUkYvEahP0Zc5yLb
         ZDUZkUCRCCCyr7WHPHAHti4LVB22kecsmv+O2oh9l9UszUniyikERJ1L3j3RQWkfeXQf
         ohh3b5NSUtVjfmUbrFySX33DqvyEylJgVQ5GuubbNKh/F6tKl0AO1B9FPxfGSfWcqMmr
         GZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784557114; x=1785161914;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6XLAK18qq6YBqyBhv06WBGI8a6DBEWNa12vh2vrzgj8=;
        b=ZqImUR1PvWUOi5PweDwdX5D4z+48oQZUCF/GQEDTthrri8Aa/46WCH571rNO+ezC4F
         ih5iKTBQROTRF9LI36aW0PwvrdU57YWEjHmTZYhxs6E6L0ettJaXIVGauBY6YuQiwr/x
         CcwfwsgDnB0Id74H7xsd5uodMc5BGAJjlemjmNU883vBPRof/g+pMT/Yf69HoVMOvuuK
         pjrj/nBDTf/PQCUydTN+kVOICSK/PMPIN22ZhmLhqT2lGkHZFok1z3JcfasaLXB0NktW
         EG1gzK1OAvA0BR70yK4A/VxqJTEfhQ8VwbZacXzVcvqk3NjuS/S5rVPlPH8cETfnW1zE
         +PDg==
X-Forwarded-Encrypted: i=1; AHgh+RqH3WE319+NuhEOQrdf0TtEbI3egKi6y4VDW1r+fMUvsxW0cMa2+OvPgumefRCx0Nkp2A1kiMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHRl3HJgfBq6RytK4Qo597GyLNCD1CVJtjjxDKPt7Omht2Ijd8
	GJE+wJFV0UfdenTPEc65ZPC9oaJ5mXSAjREDjjbvesxZksSzZlIxP71vweR4UgvN++cuvZnzc9N
	NfxOy41kwQjkAEVCCyPw/wIH5V5OjtMUto+L+6xMRECfrqvKxjZcHg2jT0V0=
X-Gm-Gg: AfdE7ck8ruf4LSN/9Pyy9LMHO9q8APOjbO/bG0qSfmgtYXY8c6DXpee2LHpqJUxh9EQ
	GoDPW4Vr9wPOX4M5ObV/cs6NFxhaAAZrVmcENemJqs+p83uqyQNUgEOK9sA/BhE3GTuS3ac7r/g
	KZTpmx3Z/Hen3lV6KXCPWJDVPkqyluNbH4w4PF7VQ7sEnQ18SWdfeD5p57At7Yg2nbfO+z+KfTU
	mZ5cHGbKbIFJJgiOa2vqCfz8pEg6JyQtOdoO+XznKmhjXs+tkCDxDJCwB3zVhCuwn4NA4IkMId1
	0pYHE1yPXIKN0uqyZue+DBzbeN5g/Y0iw4D1mybdg4JICfsuF3yukUojrsNNZakAIY9/LFBDr8B
	ivsyidkWLKYdPaMEEO6zQJWtZ
X-Received: by 2002:a05:622a:a9cd:20b0:51c:11b4:6b24 with SMTP id d75a77b69052e-525f9059fdbmr6312441cf.3.1784557114176;
        Mon, 20 Jul 2026 07:18:34 -0700 (PDT)
X-Received: by 2002:a05:622a:a9cd:20b0:51c:11b4:6b24 with SMTP id d75a77b69052e-525f9059fdbmr6312041cf.3.1784557113588;
        Mon, 20 Jul 2026 07:18:33 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c17009ae10fsm479030166b.10.2026.07.20.07.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 07:18:32 -0700 (PDT)
Message-ID: <6983e3e8-9eb6-4ea0-82da-be48704fe9c8@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:18:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] SM8450 IPA support
To: Alex Elder <elder@riscstar.com>, Esteban Urrutia <esteuwu@proton.me>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260622-sm8450-ipa-v1-0-532f0299f96e@proton.me>
 <959db395-ae71-4a50-bd46-ac5add545a52@riscstar.com>
 <48c624c3-5408-4862-b4ec-9321ad279bf9@proton.me>
 <8309e9c7-a110-478b-8cd4-c002070d2b4c@riscstar.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <8309e9c7-a110-478b-8cd4-c002070d2b4c@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: c8oM651N0QoKqUBQSVFgmDmLDvP8DnRv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE1OSBTYWx0ZWRfX6ux6ehvCVblA
 XEvH4baqjQxPxtp6camiXH+J5OsnAhg445X6+MxGFFtWfMq3JjZhBYYTxumBeCx+4sq0bqDgnUb
 NIlVr7APO+//U4ImWuxYVGUqU/PdLM/jDTRmgC4pzVW4BPlXCtGiP1RWUciO8BTfipawSsQ496P
 etDgV7Rp1tDGPqvY2hGFxyh+OGhNV2B7UQR9U4WoqgUHR5zTfoe/aHE7d5e43Y0Kgubi8bR3MXh
 V6jEhXBno3hgMpX0qdiQr943gImUNp5Dycc1rAXE8xpzbRmOZxMmK51ecTCSaDwgirflcv4peQ4
 OSksagl2m4Mb2At3rWHUqVLvgDq6ZHe+9F3MO1qyQl01xvjVhbdPjPzWTUu7lqdDijzfcZ/yrrn
 cnfYCyl/L2jKsSyYgYEH4j/B/dQJKmyU45RftKb7rb9MwhHWvZRZrmQ+ueS4PXiP01FxjGF6B8X
 2dMvW9tH6sUIKSGQCzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE1OSBTYWx0ZWRfXwYJ5pTbF0PVk
 B3+xyAqwCLtQvGlbG/1x/Qp8drZS/Hm8GkkfpsGCwOg+nMTcPx1CkheLmNSF3pBEEoifWOal2zh
 33fITj6adNidHX1dNq5jWmUGI7IIh+Y=
X-Proofpoint-GUID: c8oM651N0QoKqUBQSVFgmDmLDvP8DnRv
X-Authority-Analysis: v=2.4 cv=bv58wkai c=1 sm=1 tr=0 ts=6a5e2e3b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=tXjHqIsmZuv-EF8L4YsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200159

On 7/8/26 9:49 PM, Alex Elder wrote:
> On 6/23/26 8:57 PM, Esteban Urrutia wrote:
>> On 6/23/26 11:56 AM, Alex Elder wrote:
>>> I assume you have implemented this based on what you found in
>>> some downstream code.  And if so, could you please indicate
>>> where to find that (so I can do some cross-referencing myself).
>>> I no longer have access to any Qualcomm internal documentation.

[...]

>> It's worth mentioning that between SM8450 and SM8475, IPA SRAM size is
>> different, so I used the smaller SRAM size to support SM8475 as well. Hence
>> the reason why I included SM8475's downstream device tree as well.

I can't find information that would confirm that. Where do you see
this difference?

Konrad
