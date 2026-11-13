Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566703;
	b=YJuW06T6Bv0CRy4eSs26iyr7uTnrX3Q1J+oumnEv+pDB5AtJWjcFheC6MYHJT+RPtrpE
	 2OrdDLd5upCpDjrEoD92dRoHp+d0YQ3Q6LkCPkhOVlvTV9kkDrn8+lD9U8WsWFAf3wy27
	 dn9akgSHniaXH3fnIlYImEkMZnpoczp0kaj85Q7tbQnaIbKxyuKHI09JAbC0AKdxiw8a7
	 MGUZsUGsJKRbaPnOf142aQfSN9xXnHNWC4Y7KvVqUG6tALzHHGamo4gq1i8egQkrmA+ap
	 3gUp7EGMaxsjmCZ9xip1XzrZBZesYMgGVlnPXH2F9+gBroWBs7gsoVQAUgM+43JXHhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566703;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ljDMRqOHYPM+180KLYBxEZozbfQKzrnp4W89QlCNPN8=;
	b=iMYxr0R2Pp3cpDz7FzxaJTw/Uq72Q5I4yFW0eTDaVAGQ0qvU8zRyzE5zF+Dc/3B48VFe
	 Nh8ds9HrLQvi65gHKbelXsJe+Bq1vu+x/GHn4ilFDv2Iq2dx12V3QT0e2rsVzwbmm7ZIu
	 li19TePUUbFkpOtQYouMa5QRsPrrzOzhNbHDPoj+zKgwrqrfNT5wMy+hedXzHC9Fzt/qn
	 ep7iaoUa5tEOUDdMVF3RGmw8NsUJQTVCOrr+tvBnybQirAP0kTYB0EUFY0UsW9LSCI7K9
	 FKg62UBxBcSwO0kNstVWMvS5VKWZD7xtH/KmFD334bGbXmfrSqIV1DvR6nUY0tMUYLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QLA7Mo6c;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fG4j4S70;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07D606A32D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C07D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QLA7Mo6c;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fG4j4S70
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8VNJ32515782
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ljDMRqOHYPM+180KLYBxEZozbfQKzrnp4W89QlCNPN8=; b=QLA7Mo6cLIZZjf82
	qk7w1ss19fAqrQxUtYV2M+uEjrZ1uu0mFeG4b43NEscXVF+9pW/XHNwLWpcQS77s
	6dmMqW2NsMZ4g+JTwFcrpCcXNcdpoCNp0b7UvYsu4oSeH3/3J2aOFCZQSZVKxFTR
	TxpthXxc9bCK4PNfTGuX64k6qH9U7q2JLwmdyR5qtdQnfYoNPB96bnJ9IiTY8sjt
	epv2ng2Oew3L1krcTqeUps24WdNz4upXKvskRDifvYEPXr9OYKlXDo294hkCOfws
	uYUpsV+KPrHmtDgus0b/4a8ZTLPFRTgpIV43Qlqz6fIf6fj96mL7yMxei8O4slDn
	ZcXEwg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwg1bbnju-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:45:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36fa5673fccso916253eec.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794566702; x=1795171502; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ljDMRqOHYPM+180KLYBxEZozbfQKzrnp4W89QlCNPN8=;
        b=fG4j4S701Kq1/hZBqE2+DKp2rEL9Mlw8nTrVVMQCMtSpWkdJPmLjEPKtYHeQ0sSap1
         WIAlFvoXMYY0nS4x4savN3Pz8ajxvRUjRfo/GwxoKVf5uge0dmAx3LLBBXe5BYuHPO7E
         1Gy/t3WdMQoSwgReZWYG2Ol+lV3/fV0JIfqdMjjlrpE2C8PCDgTTiZWy2EcyAElKqh73
         gWd00HbK1yAAxYwYANAjuae292RZWzulssgOrsCoTiW+mkslQx7FGR8YjSAL28+crycG
         lhRxiSzbb5MvnKd3FYN0hiE8OykROMTXWC16KqcidZ9pHrdRGKPGzbiKcYH3YJ6jbCb2
         Ltxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794566702; x=1795171502;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ljDMRqOHYPM+180KLYBxEZozbfQKzrnp4W89QlCNPN8=;
        b=KoEsKyPjpFdWyklYVqiPP+37rLXczYshTeG7yFpu+lKbE/Taqr4MqinEtaS3WlZL/o
         pDsZOaJVkPswnMLiM36rUhDJA0d8UVl4PwGOM061CnyQHTtuiZtG5KwRa2wxCxs1EWlL
         IQB73g89w9Ep0jvwflo+GCDaUYM57JqYhrBZg0gDqGHt1ceAPIDvCJKmmOHvxFL0Yipt
         TxqcCfwcJ62UHPUj/Ceazcuu3ogCMVmpYrK+tLdlTWmWin68cveNAaf0LNze4TXRPb2v
         A0cK8C4ajBS/xT6w+ABthcUFqEYFKsfh7XSm6/Hgb6LccmXBxwyySQdFsrgsuswk8V/T
         8pDA==
X-Forwarded-Encrypted: i=1; AL+hErETsNIR5eZIBMQDOVfcp3QAHWr2wBBEY0LbDQ22okK1G/6m1fiik2B+btDZ5sVIMkooX4cXW8o=@vger.kernel.org
X-Gm-Message-State: APuU4Z954v4n6nV/8huNh7nU8nvsRWmtji92pzV9Tr0wcMPhcUY30ouI
	AZ35A1P2jJ4mwXeDCc0QAfhvoM3qg3fD0TAZBbO5RD7aautctocp7Z8HeCmhsR1zRds9y+X1RS1
	/iDwBuhkdVZWM60YmrfR8XmjjJtmlQU036jOLWyUUiZg3krJD1d/YlXMaLQMoDhxqVis=
X-Gm-Gg: AYBFou2DPwdBdymL3OSIKX1U47Zn+Ddugud+r1tWiw/hfGsrwV9buXABRX86tu252z6
	utY5PYT837Vsu++3y0Y80Y8E1Az5l5U3vk0EQF1NseqfZ7oXFZ+Xv81JB+P0KxF1iKJPIwY+sKt
	Q3QK1BGFy50qcCNeYydXIW3m0WLv7AVyEs9Bwin7txrQDyfTQfyoE/z0c0m1gkSfQeqqgsyw/5U
	GrhF9SRINLtBhxn52fN4TM43MRSbI8w9GelYHkyO57AFvjFiNotFmYF/062LmADzCEv3Gx+/Gjb
	fDXqQ4cNdJzm+uh1tm76CTzBLOQKAs7pmwdmFPZHM1ALZtHLyWanEXttQrs8HyeTNyQN2B187ML
	VkQwhPwb5Hy0NGyyqZGF7Dd+e20IqYlwv8zZ8cngNyobRL+wlqCKIeSVSkyIf+wzutPuAiIr4Fs
	PVCw==
X-Received: by 2002:a05:693c:6293:b0:378:314:4033 with SMTP id 5a478bee46e88-379679e29f2mr1882077eec.32.1794566701696;
        Fri, 13 Nov 2026 02:45:01 -0800 (PST)
X-Received: by 2002:a05:693c:6293:b0:378:314:4033 with SMTP id 5a478bee46e88-379679e29f2mr1882040eec.32.1794566701053;
        Fri, 13 Nov 2026 02:45:01 -0800 (PST)
Received: from [10.217.216.70] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316fdsm6746586eec.5.2026.11.13.02.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 02:45:00 -0800 (PST)
Message-ID: <a476c249-74ed-4b23-bca0-13b8ae5a2888@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:14:53 +0530
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
Subject: Re: [PATCH v2 02/10] dt-bindings: ptp: Document TSCSS hardware on
 Qualcomm QDU1000 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20261108-tscss-v2-0-d5f575010427@oss.qualcomm.com>
 <20261108-tscss-v2-2-d5f575010427@oss.qualcomm.com>
 <20261109-sticky-caiman-of-research-65e9a4@quoll>
 <28202f96-f234-4c7c-be6b-3019e119bb0a@oss.qualcomm.com>
 <c068e21a-6dcc-4080-a35c-8f604646aef8@kernel.org>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <c068e21a-6dcc-4080-a35c-8f604646aef8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=c6Q+0h9l c=1 sm=1 tr=0 ts=6af6ea2e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Z8WexQQaEhEqRXIjmLQA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: azpescwZi-VelfXz2eq3UpqWPFI3OPiX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0MiBTYWx0ZWRfXypRpfg9axLIF
 ikS2OyVHHomXT+Pr3/ndBFEI8AaDSj+Z40XsNTMwNAmMGlnsClSkSb4ih7RS7ya5c7lyjR0anwi
 /KJADbFd/lR91/7/BvO8XgtwiUJTeCrXlFCYIUNkqei7Xv06AE0Sp7M3PF8lPhiY6nhajaT4qha
 ue1dAvjJcc8MxI4m3a7Qe5qOimTl7Dmz77Oa2cm4IqdxgSq12Fn3844xB2CEMWeFz+E43sYfNuP
 hCJxHOqCpFgk63B/hcTdD9PR27c8lwgY1Om1epK5SH0iMKHCu1it7z8wOE2H5vwlR9+8I89+qS4
 jxmAX/rMIH7cDvfR3hsn2DB/LWODbNTIas2FMln11iHXAHNGuzdk5XJFW+rNa9wGNZei/bIEcqm
 3cJaFlHLwWQQbHLtCoZOXx8+YscoKtA6TSGYZu/xNG14chJVK6KR5zrXOlk/9JpU7yrGlHtzIJp
 GoCMiTuSQ777A2B353Q==
X-Proofpoint-ORIG-GUID: azpescwZi-VelfXz2eq3UpqWPFI3OPiX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0MiBTYWx0ZWRfX5KBMplBOZsmr
 JKCFOaWMyKJptrnRYc2R0rz4u8QBfMP94OTP2JlObRxiOfHgTA4gL2fBvZj9T8WUJ4V9r9Wa3Dv
 2/6PAx1zaCDQ/RJC9q5BReZ5x5+uAyU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130042



On 13-11-2026 12:35 pm, Krzysztof Kozlowski wrote:
> On 12/11/2026 10:32, Imran Shaik wrote:
>>>> +  The TSC block is a timestamp generator that maintains a running counter used
>>>> +  for system timekeeping, and is functional with just the AHB and counter
>>>> +  clocks.
>>>> +  The ETU block captures TSC timestamps for external hardware events. Each
>>>> +  ETU slice binds a slice number to an external event selector, and
>>>> +  generates its own interrupt when that event is triggered.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: qcom,qdu1000-tscss
>>>
>>> I failed to spot the difference against your binding at patch #1. How do
>>> they differ?
>>>
>>
>> The ETU interrupt wiring between the QDU1000 and SA8775P/QCS8300 is
>> different.
>> The SA8775P/QCS8300 share one summary interrupt across all ETU slices,
>> and the QDU1000 has each slice with its own interrupt line. Due to this,
>> kept them as separate bindings.
>>
>> Can add them into one file with an if/then on compatible if you'd
>> prefer. Please let me know.
> 
> I see, it's fine to keep them separate, but you need common schema to
> define common vendor properties.
> 

Sure, I will introduce a common schema qcom,tscss.yaml with the shared
properties, and take care of overriding SoC specific constraints in per
SoC files.

Thanks,
Imran
