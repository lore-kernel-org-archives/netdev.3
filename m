Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758638;
	b=1HEwQmBV2u49qzuCAluQggh3ChNHDLgVYMMMPYjP/+CyWTQdBohNLSi9nbPHailFEqdF
	 1l7StZEfQvdsDtFbiMivPY6gtdLk4bBzJioJcf6R3H88ac9JepNrgghUIBodS4TUCukWe
	 aYJ6PwwY0GarJ1Av5PLOIRqdImtZQcCjEXh0S5bsj8xrLKeAOqlprdzu9rMCR183cvrai
	 Jk14LaNXA2jqPV0RlMGUOPoXd7kskoAvjKQau54o3i7oXq8vIfHfs7lH8jW3QJQe7DLku
	 IC0QmCr3O/YRIZ77y9bocL+uS/z0MdYUbYpJA4bd4CNsue83bzlVCXLoVUrBePAPW7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758638;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QYbMFzbjxkJpVo9pkN7QoDDHfc5w+jmedxWWYnZ4x1w=;
	b=BdfgJiNWbxG+iDCc2H1VspwPMG+OtWxTqZK1u9ryjZYQLRmo8QJSk6WNIqO91FNY3dMv
	 2ph0BSwPbqcQvPFoYozQtZet19C222Xbzioz3JdNwMTeIj1Takg0SjGJ7mUfNV4lKjoIW
	 VpGRaH4XUZAx9Bq/7lTSeET++Usw4o1y7ghHThBS35lI48pu4cobby+CuqoyG5Mex+OQz
	 RCQlGw0D3iL/yN++FXT4yWzxiz1d+po5JtQ9a8fINiawZlNCP2VH2Zm90LJIFGfsnedCF
	 HmnkilnyRXOafAtNzSx5euq2MDJWb7FP68qioYDpT0u14W6Xs9Yx6lAiaPTG71NqYJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GefZOR9V;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Al0PgfCm;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339BA606A31F
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 339BA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GefZOR9V;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Al0PgfCm
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAATXR2164232
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QYbMFzbjxkJpVo9pkN7QoDDHfc5w+jmedxWWYnZ4x1w=; b=GefZOR9VYvH6EOhK
	atAViuU3eAyJtLYqjxrnvK/kHFS9xm0xRy38tdeV9SmjWO82HyM2sLAtwvvr/jTQ
	QKCimYHiLijfvBm1OLiLSCYFitDdnqJikRP+r1glZQZv7qjCLJWLZ5PxVuplORpY
	9EBXnnbKshrXsd36Xis1oOUz+0lHtrRD+BfoRXFxbuzCyhUIKTuZ+AKAMp7WhBxJ
	3DSm3PHsLgFkryi8SOI4inXDAItovCBMBcZug+mlREalBL1EHrN2nrKAHkS/Yhnb
	f+7TEEkMvwqUpsdhjKQsfRzLC4iIJgfM1E7t8diF6e0DATCfrWF3pEaBJGXdymKz
	vw7xkw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahv3af-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:30:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93edac5877bso28196885a.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792758636; x=1793363436; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QYbMFzbjxkJpVo9pkN7QoDDHfc5w+jmedxWWYnZ4x1w=;
        b=Al0PgfCmiteEWZG2LKzj8/55fOg8sluCdF6VTZqVwCuKU5K9lLbNDemal8/2Lr4DaE
         a7nDBmXe7AZI1NTRh/2821g4sU7G9orb/mhLR4ssfnqJP2GyVuZcw+8q50PHNDjbs1dJ
         3r/x5NstOqtdRNEBvUHvf0nprsd351UI2TLEXzrJLownSgEeUJp14RPB2Y1vpeYNU/Dh
         H9DxF1cFqPeMkfy/U4XhULSpsotp19xfKkS5ChPBSmqYMnm9NhJFOCgW/c7fS/9Zy4y8
         k27ah1rAic2eUssKkz45BrmxYQCTPPtcK/GZ7zVhXW5bo1kJwshiz/5Amin7EVornZEo
         3Aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792758636; x=1793363436;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QYbMFzbjxkJpVo9pkN7QoDDHfc5w+jmedxWWYnZ4x1w=;
        b=dFq3yLDuT1uSSTibEatTELHyi7GPqFnYu6nSaHDbvA0zh+QjAChLc8uInY4fQvI9I+
         5MbdiYZnUYi5JyMF6WKhLXvbBuRMa+uOO2DTsdUiaVRQmfrKkch28q7A227ZoTdTuaRg
         xORAR8fwqzhvAKCoVSVRCNgxcfFkyBFBQQlwm40KTIhTvJPO+xhwaemrlZ1n6nMTNsVc
         3l+Hq+qWaeQnVpKpLQSBWoLDlSDmgtO7EaBznNlXyo5pmebb/CqgwVEMBW3gp5xh6VrC
         832y+wi9tBEhn3QsSWBePGqsAbCeWu7sECJiMYpqlMHnMHv69gAgnNv/k2XMrbueON2b
         5AAA==
X-Forwarded-Encrypted: i=1; AKwUvByGOUKjpCGmTq7zEz35dHFCdmgiL6MR3aop7SQ2ifoo67JR7k2+ZMfEN1jl32FSmWEvGHoE6A8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHZSm+wB0UGbFf1kP0Hlvcp27nkgvVfswjX+lAooyETQL9/KVz
	0mocn0rA8apit0DUFhkoUCc8FUFCTx+yXCrTOWnhtbk3P4ZsGj7b/AVfBK36AM6R57X0RclricY
	K3Ns7lVVyWyETtSSCCZRURoarfSv3i9IPRREhozw1AiXJThqXMOfc0n8Ow84=
X-Gm-Gg: AYBFou2mecwiX/KuDj/o0V0rRB/4MR/55HmhP7/8dM9aPPjvF8YEFg95KaUzE3GDczN
	rLQAoikwJ2icGmHGUX8RCb8lAxBcUJLu9u4rg1uV5oph7iIIlgGSa8nW6wLjytesvXhreJDAFRM
	VUyV/c3JKWU22HrO+UobZCU0ho/3376/L99ZgKnXWC/6EhkMCfqxq1ejUDcTp82hkiZKY4JZdV/
	n1MzvzE301L+1abZTlCHmMGlola30AnWzRwo8P2lPGcxcAmt1Mp6mo3ABwSD0aZPU988Mj8Nu1F
	HJE0nYTaviNCEoo+jHkFmWFMO95HNo59eAGpbOC3V3l/xIvCVfW7QaV/2cyHYNvQpRasJHHVlRf
	m8PDx0g40fXpxonHA/PW+PQ==
X-Received: by 2002:a05:620a:a184:20b0:93f:1eb0:88bc with SMTP id af79cd13be357-93f6f7a8441mr365719485a.1.1792758636129;
        Fri, 23 Oct 2026 05:30:36 -0700 (PDT)
X-Received: by 2002:a05:620a:a184:20b0:93f:1eb0:88bc with SMTP id af79cd13be357-93f6f7a8441mr365706885a.1.1792758635248;
        Fri, 23 Oct 2026 05:30:35 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46a5d17e95sm97254166b.83.2026.10.23.05.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 05:30:34 -0700 (PDT)
Message-ID: <ea77837c-0a64-4705-bd8d-946a0a03f16f@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 14:30:31 +0200
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
Subject: Re: [PATCH 1/3] arm64: dts: qcom: lemans: fix iommus SID mask for
 ethernet nodes
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
 <20261023-sa8255p-emac-dts-v1-1-a34d778ce9ac@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023-sa8255p-emac-dts-v1-1-a34d778ce9ac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0OCBTYWx0ZWRfX5zD3UB5S42g+
 3+wtEgRsP7hB33ZIwfiltNmkc9y+onjAOSgh6zP5EdXM2VeKpKa3S4SBiUCV6fmouTDJ9VyWqiP
 /uTZ4sohKYHB4VwMmVU8/7xr7EnO9ZU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0OCBTYWx0ZWRfX9aDemreTlzZZ
 RVHCM10KjvdS3hMV+3CsAwZYImb2NnNxsC5ZhJWQuiaG85WiDyn56poRRMnot+C3cQT8GykGMgY
 5MpBIig+Lqx4KcqWTnJFG2qEo0UFcqb393u4t11NHbEoL9HLofRKOFuxWFQa2OJZS1kIZcxxr85
 Xg7MIZcNR8EYRlW/egM6oius+/+UngBF/triQ2hT8lPoGnWuQ+q2G2k6N+GBRPiSLwbzuZlyRk4
 FhpEheVF7lb4q6ofKhPHfCmS0W9sOT1EI00OTqaStO2muth/HgR7A5si/ZO2mC9P6YLckmhQC0k
 /43/oLf2VwFLGRMxkx7aqhBQPEdMM12eHr2f1OeSgTfKYnl262ZPwfYY1k7347fHmk0pW5Z8csd
 AXGCw55k3tHrkU0HdBsibX/K+ek1E1hjc91H+u1npzbeI1BGF5doDqg5YKAg7IhLB0iCyIRK0Pr
 cf/RNHeK6BIGgagw85Q==
X-Proofpoint-GUID: lti2HzTINC_YaokA8r5AmgfPxvbSaZ3t
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adb536d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=MNZHkl_XmBfbRSJpkuMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: lti2HzTINC_YaokA8r5AmgfPxvbSaZ3t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230048

On 10/23/26 11:02 AM, Bartosz Golaszewski wrote:
> The iommus mask for ethernet nodes is wrong, it makes the SMMU mask 16
> stream IDs per MAC. We should actually only use 8 SIDs. This has
> triggered a crash on sa8255p after a boot firmware update. Use the
> correct value of 0x7.
> 
> Fixes: e952348a7cc7 ("arm64: dts: qcom: sa8775p: add a node for EMAC1")
> Fixes: ff499a0fbb23 ("arm64: dts: qcom: sa8775p: add the first 1Gb ethernet interface")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
