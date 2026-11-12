Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475980;
	b=tP8VT8jgQajAr7LsHpfXl4SQh6e9uKZNP+fE8TL0DKItSpzUWRz0XddbGtBH1ogZazvf
	 3hV5aBvH1WxozGJny1v3wlsWE3n66Lep2hAEzzO5HkbU5dVVchqcZpI6kfYAWrtsSphQU
	 mlEHJUDrFbpE+jvCWOjLy5wA5BSjstkFZJYlBNKlU71T2Djqi9TwS4+NjCNuIGMQA8I1B
	 vBQcfRXrO3y2cSyE0G6GI+MmMN4Pl9779eXMSsQQHN7hgpUnk3gG7Cmg6ApqdDx7AJcQZ
	 2uLly/UeixkU01C2m709P6lAMiKN45YeRIv+8+JBlQqute7UhK8JSqcXrJrhoD2DfPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475980;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Zm4uqjyTBZMLurFKBtWKGU9EMrdGi8yi2J1M7zOknh4=;
	b=cqOxINrOvs0PVLvCG/rgFYO9Lqdta6UEDUsdyPpPWpnXhb4TzphUOUS7fQh4bplyTOgy
	 Idu0bKu5i89hxzzvFNXP13mpFV6P1WXTG5t1Moc28it4c51oQ2Yd203UOBFLstE3cIa5E
	 btF3nyb1Qrq9oSyHNI3loh3vxfdAwAFz7Drhs/SBS5ImGGrGm2Y45Mdwa6q5h+CvZs6oa
	 hCY26BVXvJsxxh4qKOUWIMT4HrASLUpsEbKsuHaKKseJ3GwoI/mnW+5AcJhJkSHEg0WDo
	 HIGCNjk6i2CvCizB7ssReDFrwHY17fO34cVdMbV7DJBC0QgLgJPGfaMqM+9T603/sXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QNEs1OqV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ky6gW3mE;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D079606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D079606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QNEs1OqV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ky6gW3mE
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC53tPp3477246
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zm4uqjyTBZMLurFKBtWKGU9EMrdGi8yi2J1M7zOknh4=; b=QNEs1OqVZhxSqcNz
	7CaxEGvyYxcn8sWAwKPUwf3KHCkip2UMa2qvizkBgf9TCcd02mfsD+Th3nFelV5U
	fpr1KlN7ZkMZLeiHNyMKXfISrr4tOzr4oIZfitDPsleBaB+MjTrX7nWMjKl88cgH
	hDNMhMeWDqstOTNs9TykMxIOUmaqApcZYuElS2knDaSr81Cx3eZaV7nif8X+mHnJ
	PJRNDg4on4bnV+KAPwwCW50QG/7grnxxVavXmGET/uForAz8HKBpmqq+ce+2+i4j
	1albDF1n9ctEO0og8+r2joQds1yFStNm4+A7xkdqR0nUe+7CGVvrH9XieFhYI7GZ
	AcMPnw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6yugx05-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:32:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b0e00d7cc2so3881678a91.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794475979; x=1795080779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zm4uqjyTBZMLurFKBtWKGU9EMrdGi8yi2J1M7zOknh4=;
        b=Ky6gW3mEIC1B7T1WO9PFjZObF2eDUuYmhulCnTrvnrNcGCI12pwzH6V6YM3NtkLhkL
         Y04NUvtaMvMyx1rV9sVAJwYzXQ8Sc42CkSHo7PikAH0+8AtG91t28yN0bu/RJKNQaT94
         9rDr6EZsyZV6us/nIfHR1IrqRiffYooY+R6qW3Rs/UzZ8JKqR+GjmBp5qARMgvxtNlQI
         t/qy+W+RJlClfr7kDayTuEvHYWQQZP8I4nPJsu97vvnoxMMHZDPqfXLP56h1sA9G4heU
         RY6K13XfM576WaZdOu5V+F6WSqmlMtd/3U5oYF9KYCqSSLvXLBUjRcQxM+JMdRs11j5H
         zteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794475979; x=1795080779;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zm4uqjyTBZMLurFKBtWKGU9EMrdGi8yi2J1M7zOknh4=;
        b=Keg5jZC8mUMBZqTvjM0q0yE8G2TiL4MwRlUqkq1n+RGS8P71d50yWtIRr29Lb52516
         jNFQXzf5RYGRz7pquIJeIsuhGV7x+ekrfyEw1E5KC8pbxbrpFAH/2K5VStOCxJ6Jb81q
         k0X77QrzGDV2QPDOQdTQ1Fi9XVdn2rDAfqxYe4sT4yfW350LEAWPRWXEX1gldrrzMslb
         1Zt3knJmgGYWzToYUAAE8LexOcCSCKnTbszSjvRSlLFaumYq+8Lksul1FEFYe9Zgmo8d
         ZG6VIyVn1yPM4rnn+o+U6dEUCKqq+oSr4agc0xYP51uXez06VzFmu1E2RSOC2az85m+B
         a8yw==
X-Forwarded-Encrypted: i=1; AL+hErHm1pZx69IFBoggF3gzW9KrltMphKBD98W85FXniVWnJukB20g53m57IvXj2mT+p4KV9Bo5mRc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BvTb2s3u6tTVXyZIUc+Yt8TRPiELYdaUpT0q7AsW1020rHV82
	IN4LL6UID1cpKv8M2RoJZY51nM6RfPCTs8SNc5vLJiIE/3lJN11uHExaGDkMF7OP1IXHF/uGTRF
	V/jfMDqCCZSD3XTaZuyRMi7ao9hsXgOQ7cXiQvGv1a+KGuO3RiMzO9Ul+hOE=
X-Gm-Gg: AYBFou3555tgiXS+FetB8vb1aYN/RkemownoG6ne9bBf9xn/V4t5unPWKLHvmUwAlRd
	qYAUY+CPl4WDmTrLfqwKMSj4w8YHqFclW2zjOJ4ssDEk8QfXFJp9noMb9kXwdst3fPQDFeSqtmW
	tOgoJ0gm0+AGgm8NeelU7FGGHatIsR8Da8C6AIXe4fyBJFmtix1MTwNP4Ih5EXyq9mOSreGxRsq
	UUXgoELKKTEkINvRT+2y1mJmZdHBrgShAtJGEHQkpb9o4+oinz+1GZ3ZhC65iwtz4Qg2ywWTMIW
	ZnTZxTjmW/kTw0dtmLvhjcuVF6MzHsZucsl6JxqOV06bMDTaLdnCzXHCumPyafDfJUyPw8eDMvo
	QcXFI7gS79I3gvMqG5XYtzn2jdx+a/J4u8pPcz30C1y/PdX9hvYLaEP4iXRzSn8sCdEw7kbRLja
	bD
X-Received: by 2002:a17:90b:2250:b0:3ac:bc3d:6fe8 with SMTP id 98e67ed59e1d1-3b182f57e28mr5448962a91.34.1794475978581;
        Thu, 12 Nov 2026 01:32:58 -0800 (PST)
X-Received: by 2002:a17:90b:2250:b0:3ac:bc3d:6fe8 with SMTP id 98e67ed59e1d1-3b182f57e28mr5448935a91.34.1794475978124;
        Thu, 12 Nov 2026 01:32:58 -0800 (PST)
Received: from [10.217.216.70] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d916c0sm31396185ad.41.2026.11.12.01.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 01:32:57 -0800 (PST)
Message-ID: <1b1c69fd-580c-4104-969b-ba09693ec6d7@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 15:02:51 +0530
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
Subject: Re: [PATCH v2 03/10] dt-bindings: ptp: Document TSCSS hardware on
 Qualcomm Nord and Shikra SoCs
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
 <20261108-tscss-v2-3-d5f575010427@oss.qualcomm.com>
 <20261109-statuesque-polecat-from-lemuria-1b8ade@quoll>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <20261109-statuesque-polecat-from-lemuria-1b8ade@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hzuhLwPynHTyVquj9I40dYJ-G8T1UMWM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzNyBTYWx0ZWRfX1HhWzOizf+ei
 upC2mqmAvmiPkxAtoWEf5twdRoTgxiJUOYtN5SNGtkZC+X35ycm71+nIWlODeoIWReDzi/SLpEs
 qljI4jRphdF6yOXTJNatauBVWAyIsj8=
X-Proofpoint-ORIG-GUID: hzuhLwPynHTyVquj9I40dYJ-G8T1UMWM
X-Authority-Analysis: v=2.4 cv=d49gWhjE c=1 sm=1 tr=0 ts=6af587cb cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=8x6Hp9lnLVyU3yzMCIwA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzNyBTYWx0ZWRfX8Uq20YkOpuPk
 ML7Ak61epRCKVP49D/8RRg8L5vOLvczdqli5RccYnKJ0lBMJoT612gKykJWF+IlLBN/UAoViuFl
 eq8zT+z5UyW32OXBYqUGAa6USxcALFmwJsSw2orv20UHDymTduQ83YSeuGnOKJXDlP4teVS/451
 VCTtay4IlArk+vwTilprZLVW6AW7r7Cnp2IgLpB9hvCS0+Y00nLc8We3sHvFJY6r6oQbPg88zO/
 tb9WTtmZ4yHNEnLqmD+7Ijrs0awuYIW79Bw3vgmYFsSXk8uq2NDBMljZdW7ADiEeaRO/Hk7Os1x
 P1JVuv3U1bXUC+NGiesqwIuuLE7xtSR7yeXHPFH2sfbK+YeLIxTUwwoys+cgz5UV7tvzjhxHal5
 y74C3iIXJ34BNCADl3WEktu54AQL2FheOQ7DdfnXsWtZtHZ+lEg6eUzLOH45sLOmAJjj4cKtCxc
 hsJCLOMeh+Wq+FBQFeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120037



On 09-11-2026 06:21 pm, Krzysztof Kozlowski wrote:
> On Sun, Nov 08, 2026 at 06:48:24PM +0530, Imran Shaik wrote:
>> +  interrupt-names:
>> +    items:
>> +      - const: etu_summary
>> +
>> +  pinctrl-names:
>> +    minItems: 1
>> +    maxItems: 32
> 
> So here there is difference, that justifies different binding file.
> 
>> +    items:
>> +      pattern: "^slice[0-9]+$"
>> +
>> +  qcom,etu-slice:
>> +    description:
>> +      ETU slice number for each entry in pinctrl-<n>, pinctrl-names and
>> +      qcom,etu-event-sel.
>> +    minItems: 1
>> +    maxItems: 32
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +
>> +  qcom,etu-event-sel:
> 
> Anyway, you need common schema defining qcom,etu-slice and
> qcom,etu-event-sel properties. Maybe also pinctrl-names and other common
> properties. The individual device schemas should only override/narrow
> constraints
> 

Sure, I will introduce a common schema qcom,tscss.yaml with the shared 
properties. Per-SoC files will take care of overriding their own 
constraints.

Thanks,
Imran

> 
>> +    description:
>> +      External event selection value for each ETU slice listed in
>> +      qcom,etu-slice.
> 
> Best regards,
> Krzysztof
> 

