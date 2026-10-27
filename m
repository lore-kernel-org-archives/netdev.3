Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089448;
	b=jB6A0kFT7/fiSS62C+OzDvB8+QipnewOs50WAx7zUXTLRCbj5RaG/g57sY4kDClZdYay
	 ggO+jnB6iSeRmOa+BQihXJ+I7XU0GzkQYGzXXcoXBJnaERviAAwYYW+rhEjAjDRFouh/e
	 ZLqWJ9U/rbgUtA4UPxh9gxBgh+/sDg9WwP7n4kXSWFkDK58TzZqvAPgJa3ga4KvQq7nFY
	 QV2OJAfTIsDU8bo9TG42FvudAMlaqwGdPeSkbfGm2VvC8IzjQ+dzHG/iUM2Yr4cz5o1iA
	 w6NVxyIMjTeDOnxbgkx+fEVqGDBvXPb6QToR+MXBSv9CaKpFMR23yQDT+ysIEK/tK8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089448;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4lqM52UNtIm/PsesfmEGnfz1xjM4BBYrsaKB+SObPis=;
	b=n3O7pjfWWp+Vq7XbJnz/aCqyzP8Dh1EGn9BlfPAvaC+KIP5BnYXX6rTUO1Qa4OeyX/61
	 fFkBfNtIpPknHm5xCRTZIN0ADx7Mfzc07v6GLIqx8jY5+VdHBXYlhNnq5dtR9pof+AiOt
	 ovVMZuECe2l8mw7RSB60upTqtSAsKgTkbq9I5zJqu4wOEEI01EZlk16etwif2WFe1ybhG
	 eC4O/KIEVu1xx553JtMGT2A4kKAXbY3lqwiAH+T21Fg8rnaTam8e6xZ4+x8aFQjyeDZeA
	 H1VBS1d2CYJByKZPsXU8gDmgxoiM5LgP2hQLy2sdSMm9oF2Ff7dKlqG4H1qfS+BqWHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LFvJrAdX;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K9LabksJ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F29606A31F
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10F29606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LFvJrAdX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K9LabksJ
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R5Z09C1244798
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4lqM52UNtIm/PsesfmEGnfz1xjM4BBYrsaKB+SObPis=; b=LFvJrAdXip0Ihrgh
	fPip5hp4MFBszTRstrAe0XcUxB33FbPuJKl830JUr4gYDS3EuCaSGe0EFIIDKy1T
	iAikAphw2+NSaW/ObbSvfb9KWD/bM17oU07HGMht1zmNpq1IKcywC+sXJvPveqqY
	P7sBbWJWSyaxSpu9RfkMSN/UevrlQWraYNpEOk0BeHR27BpgNoqhOOtjeKikeWQs
	So2ihwDj48SGLjIGx/UB5dkuASKgzEH7pZQCYcjQ8llBVI8F9nPIb7k5a26qup/u
	XchTRAp7SQSsbyqUUbZtsAm9vj2JP9P2TcHBUqQuOY/WRGtXDDbK1vv8AhGVD9W8
	rAxcUg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj56y4c3s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:24:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3addd73e66bso2770517a91.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793089446; x=1793694246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4lqM52UNtIm/PsesfmEGnfz1xjM4BBYrsaKB+SObPis=;
        b=K9LabksJ8UWR5G65BHGxNz42MrvYkB7mZuUINkGxiaNhA8ZIM4RUNS+SH6R2U8fiXS
         trg9cgKiyTSQbFPYzl/Z9JyMGtivq63pAXTDW6SfsNBjYb+15UzW5FknH7P8NEeRulqY
         YNp70IFVLVYD8F0kxUFZJKeRmxpM9Wjalaq/OMm31tqYvskLBz0REi9a97MPc1q1chSt
         8E6gQZ7CBxyPCfJQ9vKA3CBImdU32Rt1nILyLyg3V5OPgwC+rAKJNfwkpRt3kxAQwOT7
         gRjP5xM2myyhKRpo+zs2bTFaGyzeQNxEonJAi0EAFMAJgl6ShJSxnbgl50mGmbXHoho8
         alVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089446; x=1793694246;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4lqM52UNtIm/PsesfmEGnfz1xjM4BBYrsaKB+SObPis=;
        b=2ABCr+h/LAU7rb0HP357ykvnYRX3jaYkj7ZiW7ofVR683exMY7cbQb8qkX5dkLYBNH
         XBE0OoRKzVqeKEB736Ig4UDxtpcCzr07xRuWSvfy06EUwn60HXwJF5oX34lre06xbtJY
         2uyttanLVQbURmiKawsfCoIMc+R0uMfgtKPZWyDRuSzzkmF8XuO2U1tReiMjFavfgUAK
         FTeVFy1IoQxxX+cwclvOqLj94iHUTDSEqogWYIUe5lJ7oDjYj2CSokYt3PBWQvWQdiIc
         85UUZjN1m7OBIdzukg7YSg/5B7bjqdXBvpI+Q8U8wqNC0r8QW0uGsjSCQgm5f5nVVJfR
         FwgQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVesPZe81JpF1MTyQ731H1InUkZdJERHAHtQxzvv5CfTnU0Hm/1MBM5jNklfrk6b2Mdlsa4mA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyMyV0323jHnToQGL8GBIJ2btIL4Nj//s9K5ALbUtPPT7L2/su
	TtooBr27EbokoudrnTpp6LNK0FU2lflU01fo1h5RZbtAD1OqCdGGdv3wmQsrAbQj3vHfGJkXbFY
	3+pjXHjSh1x/oRcJoov0Y1enTRKmbte5je1gcfPeoCjofrfd0EbzC0wn1BRM=
X-Gm-Gg: AYBFou2pACpS2DE+tvCbo/Ai/3dcU0Rro6JC3uWtDnLAJmjTH9q4fwiRA7Jlk+1beI7
	XhnyfXtaKAX9xOHZD5GJAcMlhMbtR+TS6nrz3+hXgrHuoVhjShzPF9bu7gL/g8iz2Q3STLnkGdX
	ax8Ui2INeuwzBkhswlpR4HUhNlQ4qnceNNbBumBrkPHVY6YmGEFZDeRdCGQ4sy1AiXBU4angRZk
	CB7n19RHIKS1WXuzfXQ5M8S2QPA7JzK8BAy7LV/mx6KAR+cTanXF+x0diteelKYIxWCgUsi7UCo
	CqbVOcqnAK2Bn3t70fl/R7k69ei2vSf+ZDgrwFiDyf+H2UiAXmeBwOEAuGAMuFUkcNZ6VjzBAYN
	/f48F99AKBlHxXOJ9eU6ig87kSykT4NCtYv8=
X-Received: by 2002:a17:90b:528a:b0:3ac:a11a:7c79 with SMTP id 98e67ed59e1d1-3adeae6db13mr6803696a91.16.1793089445963;
        Tue, 27 Oct 2026 01:24:05 -0700 (PDT)
X-Received: by 2002:a17:90b:528a:b0:3ac:a11a:7c79 with SMTP id 98e67ed59e1d1-3adeae6db13mr6803684a91.16.1793089445527;
        Tue, 27 Oct 2026 01:24:05 -0700 (PDT)
Received: from [10.217.241.81] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebae7f3csm8147056a91.3.2026.10.27.01.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 01:24:05 -0700 (PDT)
Message-ID: <254c26ce-ef3a-4296-9981-34863db9fa73@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 13:53:59 +0530
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
Subject: Re: [PATCH 3/3] arm64: dts: qcom: lemans: Add Draco EVK board
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
        Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>,
        Ajinkya Inchure <ainchure@qti.qualcomm.com>,
        Anuj Tripathi <anuj.tripathi@oss.qualcomm.com>
References: <20261019-lemans-draco-final-changes-bringup-v1-0-dcabe94f1074@oss.qualcomm.com>
 <20261019-lemans-draco-final-changes-bringup-v1-3-dcabe94f1074@oss.qualcomm.com>
 <e675b54f-9eae-46f0-a207-02580fd0b974@oss.qualcomm.com>
Content-Language: en-US
From: Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>
In-Reply-To: <e675b54f-9eae-46f0-a207-02580fd0b974@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzMyBTYWx0ZWRfX+322Erq1kWMV
 dt0JpFUtecpnF1FvBTXR5zgPzQ6zQ52ojXRry4zMXVT7RxcbB2BojUohMb+xOxldzscIL3WktJk
 VV108lIcHM9skgUQMP3ruf4r3+XeBRs=
X-Authority-Analysis: v=2.4 cv=eMeGH3p1 c=1 sm=1 tr=0 ts=6ae05fa6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=3SUrRiYI98BmUlIlBn4A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzMyBTYWx0ZWRfXwFJsBuAV/c6C
 Sgf+clLRUPgBQsbd13YVnrIUFAUklDp8C40N8N4+h6pIbk4nBwdyDjyyFDMW/sjwd94OfSFs8/b
 EvLvPGHy9XrN9yHPvLfhUWfktzEzJP3lBmgt1wLa78HCopcG+R1Vt1ZV0oXNP8nL3fL/z36uyNZ
 vU1xEcW2Yjiz8IvOI4icV2cz6x6yaVvIgzyKktb38wXpULeRbOQU3eaOn8cQsSii7ngk5e3J/qd
 eFbUc1vlCopMwHBlas8UQJKxnQjK6Fr4ncCiVXHVO6XmI9T6Mw3rumb7rHfLU2BrBfQbiXNjhLA
 Kf/9MFn8F6SgNPrd5ZVUP9bDSU23i1lZ+zbQAFHevecHwXvWR5drRyKgPN5fWIyZUQRi8aOP27p
 FMxX1PTe4ttTJ7j92wDCz6Ap3Ob4s6Ma4JtiibDcz04hPjZR3bzdUMzAQ6ZPUI2e+LTN+iJlRhS
 2mFHESsgGcEiEolnnhg==
X-Proofpoint-GUID: 4wpgwYgLGK8WVEgtKIBYP5Y-G55SiHC4
X-Proofpoint-ORIG-GUID: 4wpgwYgLGK8WVEgtKIBYP5Y-G55SiHC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270033



On 10/19/2026 6:01 PM, Konrad Dybcio wrote:
> On 10/19/26 12:27 PM, Gopikishan Thawre wrote:
>> Add the device tree for the LeMans Draco EVK platform which combines
>> the LeMans Draco EVK SoM and Draco carrier board.
>>
>> This device tree adds board-specific peripheral configuration on top
>> of the SoM, including:
>>
> 
> [...]
> 
>> +	ethernet0_default: ethernet0-default-state {
>> +		ethernet0_mdc: ethernet0-mdc-pins {
> 
> Please drop unused labels
> 

Thanks for the review. The unused labels ethernet0_mdc, ethernet0_mdio, 
ethernet1_mdc and ethernet1_mdio will be dropped in v2.

Best regards,
Gopikishan
