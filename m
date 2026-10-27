Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084391;
	b=C+SstLejAC8DE9yNIqBQ1NSqLY69uKmtoAPT9lz8C4kCsQe5mxHQDn+szHsO7ITS/NOF
	 06FrG8q//1AKanYRqnj29CkTpPTemgSYRYVo0RhCjK/JIdehAwcL/HrumryXOjJYbzlth
	 WjvJ6m76JF/VzIFcEZ83WM3PkWINrWbYqQxNajEQbTQzce6Oc7cR3ct1PdmRvhByG5M3j
	 E5UbpOBuDOyVvH66KNegfwBc7zGA3a8xN53uckS57FTi34MBRRjqt6iGpe/GakJG9O5ut
	 u3sVbQrzn4u+sEwGcRgEg1eHbF08RgKdXNag8SyHqBuNup2NZYF/YT4pjz2+IFHZ/Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084391;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WNC12pOFow6vg7cxuHOJtzrj2t/7mEYl6Zadij4kSCU=;
	b=UU6s4SP+UfNeW24cyyZigR7YddzYW5bZGYSWobgxyVa1KoCm+w+vEI2mkuhmL7cbsQxo
	 nEm85gGQAhEmknLOoFwK3XfOSaNR3hCto7eWShYnfHEpkOEarmWF1iZPQiCEOL4Dl67mQ
	 nFsB3PWi4nSNAMxjlkuvEMzXa7oMUYxOiYxRXsXV510CLZD0NRqQa3K7U9vMKnWlzDYhc
	 L/vMYmw5GZI6GdhTdu/rjAF/2AzIYhl81hlUhm43xbfeTST9IgSXuM2AG9PPDL6ekbaJ9
	 FKppftkykbPc6evjDHN0aKL08Iy0VikGs7oyjPU3HdGHR2aV1bmEjIcsPM+ULK0vMog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DAVRLh4P;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a4FzZZbs;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE3606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AACE3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DAVRLh4P;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a4FzZZbs
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R5iHsI404126
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WNC12pOFow6vg7cxuHOJtzrj2t/7mEYl6Zadij4kSCU=; b=DAVRLh4PXOFgsY5n
	NOwS1p564NkTFUyqLClL/gsUJR9wNX5qnJvEAmMt/meuWDxin3W026bwuMSDlGhi
	DEYsNqPGlP4l+RtFRwlBt0s6Qa1zjvo6TOkLIZoI9chXqrOg0breRflgS8vHRRbX
	IhssrvHg+ZcjAVcWw6fMnB+zThniQpDauTyBiYFCqg+PHGVjZV2m/B8OXFtwaeP1
	i/dhAWkpoOaJ5YGykdTdAOWwY9onmx5ByNRJapV/HCIRBRKDonJkyHf7fasLii8s
	4I7CHxuXfMPvQak69CmPD57UZpxpu0ldWgHGkvX4pa7Ki/xAQaH+mjDxp85hGiMT
	9UtFXg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjp2t88c9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:59:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ac77c3ff6aso5655071a91.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 23:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793084389; x=1793689189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WNC12pOFow6vg7cxuHOJtzrj2t/7mEYl6Zadij4kSCU=;
        b=a4FzZZbse2fbYo2HO+BOk2KVJIdehLeh5UPnmbx+/WyQxqXOJny0RNOup3jIQKEqGr
         YV6OULdNCVz76M0XAD8WJtNAodcfA8FhmY50nyt1IbJvwXEZX8I6ZvpMSa09JOJmME3I
         PvNCYTVBxfpUQRRmcR0UUiNyu8/lN8egY7Teoa3WbiiVRUPNGdtfOBjoLHiIv/G3B83B
         8w9vvZMABVFRE+P1vTOAr3kgoFQb3w0r275RPVXc0223NIhAMh807wo0N9Pgjf62mYXD
         5eummGTkmUuWaVLrCuj4nU2d8kUa6HAHBTpF7lOYg3PYzbBXhdebCnogRkFMAl7mvDiQ
         V9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793084389; x=1793689189;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WNC12pOFow6vg7cxuHOJtzrj2t/7mEYl6Zadij4kSCU=;
        b=zfLHGmW5YcZBIi2VlVOFCbvPbN96Rp8/Yaqsvs3meLgorUnuG446u6bJSwn4NOlhXu
         eigdkkF6wsKhu06oJviU0CsjmNS79zIeiLyifpk6RbE3zDFuuXFpuUJ+DMB3udav6HK6
         JhAgHPRQwgDnW8X9++IebE2Z9YaQwfSW5+SEXTpwNOZUcwzew3lIpQA+ksv3L0LTxVtE
         GJZRd6W4XC7ya5hADZCPaWS5I06ZzFOIDEzD4xLtCJj1qadYD2vH0Lqckk8XXYVaVyXw
         jv6x+izxn6wFRBEfO6WKIWbanIkiHHpHcKbUCCaxyIbtMBisN9HmNY6ZozNpjaBhznO2
         8GbQ==
X-Forwarded-Encrypted: i=1; AKwUvBzoqi/kLAuYXNSFYQQt+CIoCT5zkrl1tz8usz2/wjcrId98tkJe8HtmLIie07AD5zRR8xOX7N4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLux3gCRejH41tmtsLwP+jstSY5cQhLyq59HgjqAOwycnQku6Uf
	gDzodQJ21t/hUBSVRVTsLQbY7i35O/xbOPjzBX4UZ6jm+mqaQPmgwjTFtbtlhY2BNBwk8XIBwco
	sog/Xo9hLCSsNNuOo8DMKEDXwky2pZPzncTSYvqApm+iOU28vP4Muny0NYNs=
X-Gm-Gg: AYBFou2DUmITBsxhRtqmaRkO8JPv2o+Vt8/1pVFWBImvgTLu96K5PLWNpV3LKgELC1+
	f1EJdtw+gXiyFYflwVh/DiPKK2/7KsChQC4PF72X+ZfvE3TLyEzUUGOHPpEGncWyXzovftqCxqR
	7N0+3fM+7dV/zy4gw+OTJeUtAGHxsNDhqfBNLZkEWWeXZtVYmY9Kzq0axvC3LpGXdWjGtnygogz
	IKcQutvaoee1JjZnJ+eMFK7Z4VtHx2X/VdFTCLhfr1ZyShaDp0SnThTwGzIaqnrJHKDFGZxXOot
	x9IS6wzuh0qrDRrx62GjgBzs7re9GBOpKHwgk894tMumDulJfuHS6HdoKnxx+qS1UVaSaOFu3EF
	9Ow7Z+OqSdddol1Fy7DgLgVlERzzIFqjIwZU=
X-Received: by 2002:a17:90b:5286:b0:3ab:36c4:b502 with SMTP id 98e67ed59e1d1-3adead5c836mr7647144a91.30.1793084389121;
        Mon, 26 Oct 2026 23:59:49 -0700 (PDT)
X-Received: by 2002:a17:90b:5286:b0:3ab:36c4:b502 with SMTP id 98e67ed59e1d1-3adead5c836mr7647128a91.30.1793084388707;
        Mon, 26 Oct 2026 23:59:48 -0700 (PDT)
Received: from [10.218.35.238] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404730f1sm2350317a91.15.2026.10.26.23.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 23:59:48 -0700 (PDT)
Message-ID: <8ec30a0f-2c9d-4011-8e26-9ec51c68681d@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 12:29:43 +0530
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
Subject: Re: [PATCH 1/3] dt-bindings: arm: qcom: Add LeMans Draco EVK board
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20261019-lemans-draco-final-changes-bringup-v1-0-dcabe94f1074@oss.qualcomm.com>
 <20261019-lemans-draco-final-changes-bringup-v1-1-dcabe94f1074@oss.qualcomm.com>
 <20261020-accelerated-husky-of-whirlwind-ce022c@quoll>
Content-Language: en-US
From: Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>
In-Reply-To: <20261020-accelerated-husky-of-whirlwind-ce022c@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AJjzCM5L c=1 sm=1 tr=0 ts=6ae04be5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=Y71-Jxx4QiA4W6V5z98A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: eu24zR3s-hQqwx1kvMFF_QeQ3wrR9t9l
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAyNyBTYWx0ZWRfX1HaNERIR2s0G
 UF+km+hFpPhZ5NX2+anuzcwKezqCH9CntLe0leIYtR9tazal16SNsR5A+XAEajt5Sd3EnWUWchj
 giFfhqgtkOukM8KHM2qqPt7vKVvT28s=
X-Proofpoint-ORIG-GUID: eu24zR3s-hQqwx1kvMFF_QeQ3wrR9t9l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAyNyBTYWx0ZWRfX72fl3FLU+Vlg
 ildhJCV/5J3EP9JQGEhGQBIfTS/dlDOFsrlWeEcTlYv7P+D/foZDBNC4lV+yZQ/3gmpJSgjFq4S
 9asMysUGt/+oun6KVAwYGhvUNgT/apsKAR9UzXrcQksTZUq1LRkYZejRhebkqnkKSxmNdRp4eZ5
 2e1DW6/3G6RkS17tgYj1Sobqai+GDPlaUlfUIXRCyLk1l5ytRbiPuhhH8BACdgWl3k/iaoVnav1
 BNW2bfzviTr18qQ+Q4j1P+rTYll9atSVZTUZjqIl85jKcN0ish9hy2XJwEzH4oXqFtG4z2WtjCs
 VzWp2q47h1wDodE24E35S1A9EZ+iVpQqy1yDEsr/sMC2oVDpoLsMtV1yGKzaURuMJHbXpIv+nZT
 cPClA28qJeu9qEOazUfVI4kK7MuS+uNsJVD5di7sNs9+LruT1MpWK4wlrrI8/dbZ3h5nPR/LoTw
 KAsxwpOM1ttIx1F0L+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270027

Hi Krzysztof Kozlowski,

On 10/20/2026 1:21 PM, Krzysztof Kozlowski wrote:
> On Mon, Oct 19, 2026 at 03:57:32PM +0530, Gopikishan Thawre wrote:
>> Add the qcom,lemans-draco-evk compatible string for the LeMans Draco EVK
>> board, which pairs the LeMans Draco EVK SoM with a common carrier board.
> 
> So here you explain any oddities, like why SoM has no dedicated
> compatible and why common carrier board means it is not common but
> SoM specific.
> 

Thanks for review and suggestions.
Agreed. The LeMans Draco SoM is the module itself, while the complete
SoM and Draco carrier board combination is the LeMans Draco EVK. I will 
update the commit message accordingly in v2.

Best Regards,
Gopikishan

