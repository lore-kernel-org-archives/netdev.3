Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758656;
	b=CTv6YZrDJJ+bsiN4TtxXzWl986cSEvUlRG0+/JUjYKu9Sx5kUwAKxebb8kF1w+9zsahQ
	 EiInImhTduYPNGCgkPIkPb5DkARaYoXs+aUvX+Yd1hEX+vQkS1vIs3+Ry1cPUbNNDCvZ5
	 //BVZjEBLlEbTL4bL4EsmsG4UPz5tmJHy8c/YTTI6O/Pt1jglnRzA693w4C3+DswyGPTe
	 kTZjYojTfoTgj+VvOIbDHTLfWjpKzvMd6cfS7Ai1ZVFSKYoay6802A9Uir0g2w3CZG/Zr
	 bpNUoEoI3o7hT8KntdIG1mMVKV16jjFQQn2iJE9ZfKaCP6597pYwhCKOPOD8OLqTnbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758656;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=eJerYATXc5Ofmp19lEAv8MyKqAGNtX5c18EGoX1GCog=;
	b=UaiSvTHXwd4IwfLJJpCxSJUFs8CSWfhO0Rx6QFa92CF1vvdBFh5N6MMKEJCn5OM8are5
	 WQPD9GR9uPlAtmE9migLBhZEkaX/kw9vMWMRxwPGtTNBrdBey7srkhvkRjQLGQF1lRGhZ
	 6e4Q0B6OsqnFcZMFSTECxgxNS8vYlW6KDopWsfSxIf3sQsKTpSRlei8o0EIycZtZs0WDj
	 LhI0Bl/kwNfTHNrAQCbrVdva5Ych9nftQK+OJ4qy597Xg6kN47104SOqb+XAIGbxLEYkE
	 nCdNPuzG8ASBbOrcZtTaShYv8Wmbc1hApYwynufkSFMGoH5iZmPK9yDlqlVKb8hirJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n7ZDfs5B;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B3KqsHv8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE460606A323
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE460606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n7ZDfs5B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B3KqsHv8
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NCFTuW2759019
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eJerYATXc5Ofmp19lEAv8MyKqAGNtX5c18EGoX1GCog=; b=n7ZDfs5BA9A8bQpY
	E1H2S/nbo2cvfF169cWF65Aol1lDcXjjU5WExuNarNWGPsT3JlaYWJ8dWgr7aGM9
	OLYZ6m58ai5BJEuRH6jVzggtVa9rEJcGnh2OQB0wlKUi0VQTkYOjyOl2lqixbDyW
	NVWte2fq9us5Ri9hYX4Sat0Pz6IrHel/OZ6uIuHxtnmEi5D4ubyOHss09NEQF/Sn
	Y+04LVcwpil4NHqnuIXSUHqjRMk0Gp/ImrIpWYQXhGohcYACfPP7EZYaa2cTzbId
	ktJUF/3ePHtvRqCUVzcf7FlgvB/VVlT2SKAj1As2OnMJLm7cyB1WSPCAa6c9/f+o
	vlTt1g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn01xs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:30:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93e58614290so18106285a.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792758654; x=1793363454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eJerYATXc5Ofmp19lEAv8MyKqAGNtX5c18EGoX1GCog=;
        b=B3KqsHv8hhsMLLwiizISjoTh+hZ/tOA6Mnw/w8KSaKl132gdW688NP8EbWZgdwHBI+
         MOlllJmX2deUvD7NTFa4Uuik5lhUSKda1l2Q/cLWcXgUKDhrOZsmv6X/kbfaGp4JATR/
         6wa8DnnUzg+hEMK8z4hCbo+0feeFXTnBC6wCK2qoUkgDYaPvgha92wAGAPu6bCLB4eSc
         fBUBeOe8isL9hqLvb6HpybscWaIaA8PCOVPEN3O5XXYKU+Fhjf0rwf5X0YZloBkvSooj
         CMS3D/Eyvbn/PWcSXrDd2CRLCUupF1veG1I32mYNNYWJrYdAH80GkhhJDz8OfPfqiatK
         i+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792758654; x=1793363454;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eJerYATXc5Ofmp19lEAv8MyKqAGNtX5c18EGoX1GCog=;
        b=FsqdVLOOQGWUK4aWkjyuByKD5zBUCL8z5W4tIy9u4M40wm6hdijO1Pig/1FMLk26ic
         9VUo72ETLAbeP1V9DcIrR/JWzqE+e3z+PUl/lfUx/YpzpSZ0bry8Guyyc/a9dmiZYjHG
         Vu0UeiCCOFRBZAma9Rbh0WS+dEm+FbhmsWziAMJWayH2AJIEfuTyYF83qGsyTBS1JyDG
         +Ytx2TwRMedhCJq7xaJoxo3ZF2UnGngP/jzqzfnDIkRIjJgReSOrBdiDIUTMODEd9o5/
         vSieKp4XvrZ6NqVQUU1Ic0am0AhnCdXxQyWnfmp2EZpHMMwO2plsj2RZr1Z+pmieY+5s
         Gzhw==
X-Forwarded-Encrypted: i=1; AKwUvBxAb5OZMD67q7nJkFn0JlMgBWL5Je21FGte1RN7MFHqFHgwqfk/qWTHB/dL4XJZOlpCK8TkjqY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3T3WETIqH6NaBOF0BF0VCZ38DWlP6DFJbqxq0ZSRbPsP5TkDk
	iO/3Gti0HTKjcbc5jmI2u1mo6w3jh9mVB2PmX0DRIKlLLX8wVGNIXUn1QmNAGg81+joHmkO4jdI
	SomqhmTIshUX0qFV99ky8tpgPBVeEDdnNyi3XBxYTJQJgCpIdlQITOZ6Lnlc=
X-Gm-Gg: AYBFou2Ow1GgOYcDhvDWSfiEFZ96z3xzbZmr5c9anfHX0aLgzuQ293Ld0k2ZQrp3RV/
	MuLnYrK4JzfVNZPvWTSlVjjhkYAUTdsqxZXSBT/mgfbOMrduvPDcC4gEpaSKP0PKAdD+VkTBUIf
	4pK86cVt4BF1avsFTOrHzSAEFaVEam4qmDjvmPZQ2w5jwitoH4511FP9xIUCbMKiP3ENGwS849R
	AjWpOpgi/to53njcfA7KXjS4/d/Ke1Nl177JYjDTznFfZLHL00rIHYgMXyY9hjKEJgMxV5xotS2
	e1hHahH68NtB5ZOMNt1VlYjAkoznJo8sFcbEtg+8KUTaAAAimwSeywVTcbCFcESmDNOOjFlA4ae
	GWS2I4GsFR+cZ2FG2/pjkUQ==
X-Received: by 2002:a05:620a:a0db:20b0:939:9205:4d78 with SMTP id af79cd13be357-93f6f8ea8fcmr359361485a.3.1792758650694;
        Fri, 23 Oct 2026 05:30:50 -0700 (PDT)
X-Received: by 2002:a05:620a:a0db:20b0:939:9205:4d78 with SMTP id af79cd13be357-93f6f8ea8fcmr359323485a.3.1792758647587;
        Fri, 23 Oct 2026 05:30:47 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46a5cbeafcsm95025966b.62.2026.10.23.05.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 05:30:46 -0700 (PDT)
Message-ID: <bc06957e-56fa-4738-888a-02723efa3ecd@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 14:30:44 +0200
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
Subject: Re: [PATCH 2/3] arm64: dts: qcom: lemans: make the emac compatible
 specific to the embedded variant
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20261023-sa8255p-emac-dts-v1-0-a34d778ce9ac@oss.qualcomm.com>
 <20261023-sa8255p-emac-dts-v1-2-a34d778ce9ac@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023-sa8255p-emac-dts-v1-2-a34d778ce9ac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0OCBTYWx0ZWRfX2rL+1RO8Neim
 wupYTC9eZGpH37vCdfThQiq/L/ORT+kNNTIG1uJUw3aRZomEaCeL/o8DhN5pWNh5VFLHI4p6YN5
 NkXK59SOE31RBtgxSDBSOziaeE/Q9QzI4wzfalz/j7YC2fQVXnYFaxUjkk+IByF3DHf8xGRxEAm
 3OE0oNvBloQooHkMd87BNhlJlksC7Spe5oR/M4MuASq1OeRtfryMLem1wZloGyQGjhS4e6j3S6A
 zSoHLpfYIHdqcTsMbTexMHge8LCfKzoR3lN5ezzcnKrx3ar2p/5QZaXLrnoI2ZjY4c/GhcHXvU4
 5iF6lzAJl2iaUNXX1zDczEXnR5zUSUBrWhL8OQcr3bO2enXtL6jzLbAaeit9yloZ/Gq5Yc5FwiC
 /8rDxJVGAn9AGEG/z6GytwKU5jzzR0CSHZ5/giiuxtFYBPTpqKI5H3gr9jHeXrogAKSk2/Frswr
 LwtoYP+k6cQ8oJ4ws7A==
X-Proofpoint-GUID: OsssFjze0TYB6y3DihCJJqdo1TnbrWJf
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adb537e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=tUKzjj2clC97W38UOGYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: OsssFjze0TYB6y3DihCJJqdo1TnbrWJf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0OCBTYWx0ZWRfX16wcJ/+6pKtQ
 /Hyiuh9xgMKtNBNuMQ+cwVuYuE0jqour47b+3e/O2yPOCDPKQznwe2bi/P1CUBOHLBi+9yqVtHu
 jVfBJ7inuVM1jEBsf2WxQzz1AGeV2t8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230048

On 10/23/26 11:02 AM, Bartosz Golaszewski wrote:
> The embedded and gearvm variants of the ethernet MAC use different
> compatibles so move the one for sa8775p into lemans-embedded.dtsi and
> make place for the gearvm variant to be placed in lemans-gearvm.dtsi.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
