Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39182379C23
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787048859; cv=none; b=cV6s+zDyY5TIa0M85WPtHNHUv3vTm4e33YjMqJBkXCPozx92TuogOjcFii3G/RcMH0DQeT72eqWzcnxpgNmkBjPbiVv01sqefHiU2+ojKwLW8baXmIsrolgfTBOZKyQ3ULo0IxhnZCqqO+D+pw3pT6Pi/Bi/oY1gZy3QC1yQLPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787048859; c=relaxed/simple;
	bh=qzVduJq5GdVNzfjCOi6IYK/AGsAYiirXHMuWBR5pY6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TU8g0ocOEz2r+3BZE71mSoED6WOlN34Ui3BsiJpp2/FiCckDMxsnZPhJIJDltt3+gl0lmIJrhvoUX+6Gtl4vI3uBqmXpKpAYF0Y1FQJtqZUN4lM7LZDSPxFlXNDGNawusUAa9pwATVPlWon60Leyl0MMwMeLtnkrEAp6LfvUVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PchoZbV0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qc6tW0Zd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PchoZbV0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qc6tW0Zd"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABUWZ1544793
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 10:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kbAw28JEMDtsVhR/iRFJoE82+XonCmoCsrWXqTH4a6I=; b=PchoZbV0KUbr4cVv
	pqYicGS389HO7wkBfrbAxIwrMP5B0dwDc1c7hzD6zE+C6B89rB8Qit96iKeW5O1x
	89PHNnfolz7ua/md1UbTN71YtmKMDux8bs8djS5N+vKqEf/Yr0iZUVQBWdOV4eUD
	R4p25oPtf0XkJJAIGXROex6rU0auIcuLaax1iFxXyu3Lm1O0by5hJHm/J3x36Ww4
	B3ETSZxK0MP0AKL9Y0qDmRbEOdgPW97Z0UeXDi1+gRPuocIap7+c6EvYwWsWjorp
	idnRcaIc81lxN9ZOABVyvfwpAAnIPo11V/yi4BCRG91IP/Z37jhPyp/4sc5uqkSe
	PrqGug==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4dcn258q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 10:27:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9310484c005so3629385a.3
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 03:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787048856; x=1787653656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kbAw28JEMDtsVhR/iRFJoE82+XonCmoCsrWXqTH4a6I=;
        b=Qc6tW0Zd74PJ5qCNOE3hM3KzfYBkAE5Kq4uxNxdB9mj+z7uqlPxz/mXX8OQ0e4b0dp
         +etVnraPtJMhbfPaM+gA6zQlYGbz00YWzMLaSdFF/lMoOHhmQiThkGPFVa+ujnk39NF1
         LCi+P0Ty74LLFBJixF/c9vEQ3HADpw4N2bgbRie5Uf8N3XUozxt2aSmEokR4OtlEyAzL
         IaD5OvezCiNzT/quDsPK1OBg4bsNFVw0w8lXg85oFVg+cxhosWH6fBOzPSLhvWkyEyi0
         gHILbtQemHs0Hd2+lEeueKLNsAb+tlELzSIP8KodzAblOtNbrLiHX55pC9pFuMxbRSap
         niag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787048856; x=1787653656;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kbAw28JEMDtsVhR/iRFJoE82+XonCmoCsrWXqTH4a6I=;
        b=GDjeLJoFTKp4xtxNv1XtTgm8RA8mJZ+0SCm8rIamSeaUGtWSBtZFHiXchk94ItkPBr
         GA545ZhO3QjUmi1PZjZd7l/pR0hcXq5UXibNFSjtsKRGExTUCcfG2/JmcUWWGMYCIG3k
         p74H9CFRK3ttextvsX6WAha5H+Kiu1qxxnfF9HCsqF2wBpRQRelqWaC58R5WcLGObVzn
         deOmiDiNTP3TFNGA0GL/YL/YCWo0uUGhYdHh26H4fSRoNN9dzH1Sax5Kui7L/l8TfsOb
         1EVLPTwTmdH8PY5CJ7oAAxLWIyYIt7u0G1+jyAcTQifxGsjFP7TUb4THc2CD+fBNJmt7
         u1/Q==
X-Forwarded-Encrypted: i=1; AHgh+RraWwxsbE6T8rF104tfHjtXRZZK11r5OK9Q9NemtoXEWClv+lPOa6SxLjHu1om2/DEyoiQEf7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1zekr50FQBABcdTCK/MmWdM05gAfFoDqndYJSf9K+zwlS/ADi
	qx3ijWDq3zYSy7Fka5AjAYZlqDhZCjQal8QY+bAH9CfKd+N1NfZHyO5RhhkXYwRfe3+Lys1vHpB
	de1TfeXiz0xmIXDEvBs5NCjjWdb8VthacqM3avioB/8wI1Z/2VQKTSlO4gSU=
X-Gm-Gg: AR+sD12T5kxZOQ6mmoHs3ELMnxa0/ZWiVaEmsFCx1nSPfcZ04k9aePzT+SZEjdu5tRk
	g917D4RBi8rPTtsTagoyI6L1OIMblFvBvSQ+d1iQXh2m/JFAyQAEP0LC7eITtb0zL0J9eAkeT9Y
	4jiuWJqfCM3k8RwGarX7swTvKEEAwpRK7Fhx4X/Bk7dXPeNzZtf0o/6t+rn3t74sgh6V6J+pPUJ
	HpJtlOmdrTu/jiXvivG+aDSa4Od5BUKuIZhSRI7xmlPyVaMy38zCZZXq3/hwrnHP7IAvbMataMZ
	w6Cuf1rpkAZcJ5a3AQnlArzjyU3zsXUB+x+Yv1HFQl3NjmC+g3F8o2RIeaeXZ2YsiCCRv6I63yW
	bo4/fBohpqHGCSF62DIu7ufKH
X-Received: by 2002:a05:622a:190a:b0:51c:2324:666 with SMTP id d75a77b69052e-52d85425e6fmr252266151cf.3.1787048856537;
        Tue, 18 Aug 2026 03:27:36 -0700 (PDT)
X-Received: by 2002:a05:622a:190a:b0:51c:2324:666 with SMTP id d75a77b69052e-52d85425e6fmr252265751cf.3.1787048856096;
        Tue, 18 Aug 2026 03:27:36 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d859b274sm1576957a12.25.2026.08.18.03.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 03:27:34 -0700 (PDT)
Message-ID: <8c04340d-6d19-4292-a873-7ded67caacca@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 12:27:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] arm64: dts: qcom: milos-fairphone-fp6: Add NFC
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
        David Heidelberg <david@ixit.cz>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Conor Dooley
 <conor.dooley@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev
References: <20260811220135.472380-1-jorijnvdgraaf@catcrafts.net>
 <20260811220135.472380-7-jorijnvdgraaf@catcrafts.net>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260811220135.472380-7-jorijnvdgraaf@catcrafts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JSPLgLc7FLN9-HhK-BU1dCzah4zKZ6hm
X-Authority-Analysis: v=2.4 cv=Gs5yPE1C c=1 sm=1 tr=0 ts=6a843399 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=GYSh3LzNAAAA:8 a=EUspDBNiAAAA:8 a=Dd_GrI0rTSTmvMZCxHUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=lWcdFasyL5yHfcDTNXXo:22
X-Proofpoint-GUID: JSPLgLc7FLN9-HhK-BU1dCzah4zKZ6hm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3NiBTYWx0ZWRfX9p3xOLgD/U+Q
 bdfOgpOihf2nC0GzQOIejbPu3ijex/dOHKoQ+gv29Gr7TT4tleA2wF2M60spJQBaPJSvNA/4OwI
 q/U3BskOUkuZQzcnUdgvsiwr5asI+IRGC8iyoM62zHiIpHoMxMEHziYssHVJJvBmzeGKGQlnK16
 yv2lKlPDaIf/Q9a1PtI5x2X0gua+lIDT4DJZaO1Rs07ReK8wVdqVZeBAL7pz0UoB2RVZKnuFIZb
 MTck5B2oD6faOFzo59dQ0xk+IDz3TD2C+55EpAL0rVxSneye6JoIVtgfIFG5Pr+rFMhdvThsRBU
 vB+B+jfUU1FBpkVpE7O7Fku4XR86SKx2Y5qm5uvsYy28Fd3d8Q+68ir/j8iAJ4K/DrOpzwFpClH
 MePUJ6VR1yMXDc+9MKGZInA1Rk5bc0wdLhE6Y6N31oRpAMZvuL0Qm6Yci6RvA/6WTGnrFiSPdae
 FcAKyFbUCAI8LeHLWYQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3NiBTYWx0ZWRfX8690Qc6o/J39
 MWf7Sc9ooLOBuFc0AoAhdlGlx1qXLZnQU6RuCyq5uxwfohzFOOrn1WIrkaVXGE4XcXewzOYsYmn
 ShywBhpD3clk+YslGeLeDzbnFZhD0Bs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180076

On 8/12/26 12:01 AM, Jorijn van der Graaf wrote:
> Add the Samsung S3NRN4V NCI NFC controller on i2c1. Its XI clock comes
> from the PMK7635 CLK7_LN buffer (RPMH_LN_BB_CLK2), and the reference is
> load-bearing: with no clocks reference at all the chip polls but never
> activates a tag, while a held rpmh clock vote lets it read (verified on
> hardware).

hw generally works better when plugged in!

> PVDD is fed from PM7550 LDO20, the rail the downstream driver switches
> for this chip.
> 
> The enable line is routed to the chip's power-down input. The driver
> drives its "en" descriptor to logical 1 to hold the chip powered down,
> and on this board the chip is off while the pin is physically high, so
> the line is GPIO_ACTIVE_HIGH. The pin is pulled up so the chip stays
> off while the line is not driven.
> 
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
