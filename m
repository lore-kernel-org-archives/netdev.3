Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8663812F6
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851075; cv=none; b=EDVCo1f30mYEFTetkjYjQtkdoMpjnUR8cyoePg24YDPbMpQ5ERMz/8/Zjfq4eUiTemPG/WQHXszm8bNvF4JYA9/tLWrGqthGGgXiWFv3ANYtzUy8pMzPStuPrNl1fQZRvT1khd8UG6+HuJzdOxeTgTVYQyvoDh4s8jCpjLZskoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851075; c=relaxed/simple;
	bh=QzWEww27danke6pVuKQ865QkKlQ6qEvVrB1nT2Ssj5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqE0j8MLmAdl/rLGgzBysE1Rdyydh7CffzNKEgtpsxvHt6CIiyzaJfEAtJIR+GKvtQf2pjps+CYl1VeGeSpTx3uZy8vWgUYGjOmpQaMx6hVlVtxq3N2FWbFzEbyuc3pFAB0gRE1hdlHaoWMo5d68l5/2gnOMXPzhrfU4xr7XWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LS9eJkNV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xh2Mo0hg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LS9eJkNV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xh2Mo0hg"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886M3P12072795
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 07:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qb33tFd7B0AHkg7R+dCmJclp
	qBJUbuxxgUYmiEyjnXs=; b=LS9eJkNVCxJeORL+Pr1WijtqzIvBVlEeDFJyJi2U
	p3gIZiASmuTQmAmY3ZmqyHwSu04egCxuGP4237LeLhc2e7V8L40wfYyvNy8vRIZJ
	5phGl4FpbTPUtsOgv7YSwIx7WIKcNFq6o0lwb2WORIHaxl99gFZ+g9jqoMpoyVDC
	kdenPZ+lgV4WktmMq2U/IogggEEQgaHRTdIpS2R2kyGdEiR8gC0sXS+EzefbLZ3g
	OXlPWNclU0oUgwr6VkxCCrh1Ia5OkE5j8ZvDqZ0EKykftdj3FThaFhrWXb6n1LrM
	dkMnkECQsm607OGnH8gc80GdHPw5W2Np8JMdW3yrjY+7gQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsfym853-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 07:04:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6f75c1219so15925915ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 00:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788851072; x=1789455872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qb33tFd7B0AHkg7R+dCmJclpqBJUbuxxgUYmiEyjnXs=;
        b=Xh2Mo0hg6C8aXqwAA01OzK2yZvb4zQYEPetkOhf1qKLhVTYKm1yUB2g8UByzgDRNzl
         kGjhVPzXTdbXL8oitS/o91DX0f/t4mwp1hmVj7fwsIeGBhT6gWQe3TNLZcY/n8Y5Xtov
         Aig9mEPYwTUuYX3PFKKTT9vXvWN2OCmcfUX21C+8fIrI8+Dp1mZDBNA0cHDqTUCrg7sR
         uhUtIJLMBh2OuXBtfI0NxSoP6Hk2nRxEAJaGm1bsLsWM2Kulebuz1KhGtKqOvwQ5sxYM
         LFvFGYWjHcLg/lqgZD6RRNdm2DJ/i2ocopAw20KoRz7HHrigzUIKsRTOwKiuIyhQPTiN
         jaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788851072; x=1789455872;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qb33tFd7B0AHkg7R+dCmJclpqBJUbuxxgUYmiEyjnXs=;
        b=o+PpFNjLGafEnYb628GSrEXQhZfLvmShyPpldTLOWD1ryG2y2S0X4v8RVk9hOKtpCz
         yclOOGjdeSyojvsKW3imblynFzrfEsAIOLNf+dn7hzvdd+Nc6Gat0vjlTUNe/dKFIaBY
         v/irv2dUG9kS5NC9lMDazjAVrG/MT4TwpChovKcIJ2uWm0d36BFTo3vagWUyB3lvby76
         E4MbzPZTM7vNQ9cS5VLClnFcxd75UD3wJeqyu7YUkjbCj1mu/HJau0TPg1UuZ2oUI2KW
         LwSfYxXj5ebm3+4wJoaeKl53dtRN3qTCB7Pck6/9sUDSV4OzJ9R82yavneeE6uov1Rv9
         f4Kw==
X-Forwarded-Encrypted: i=1; AKwUvByO4y/uwGnoK1wNhc/PpP5LQ6d6p689kzL+vKz1zZeJgtSfk0arWHjNVazjOziQb7ACzKl7cdo=@vger.kernel.org
X-Gm-Message-State: AFuF++mW6FrufjbS8VMrA3Z6ZXQRV8ji/6TtI6BlR3cvcjvv3CsZIse9
	G78Pz0hNhCizbp2rwZT50s86E/FeEDdIg/11V+SEc/EiIXCOIc9LgSbIMgyoSiuqdIrOMDIgbIi
	y3b8LKJZv7Lu+Dxz5p8mbvm4EEfnWgYl8vZS+YAC7sBV+80uIKfkxPIsLIQQ=
X-Gm-Gg: AYBFou3w1ZrZT0fHy1hzf/aV6xanASlErkFd6A6p0LL0IZVmoapilMaU9bNA4HQoL3A
	rSBVYkSy+xtFAIDMF10EuRwgxv0Z8Ci55/oMD4eOWWTGKG1OGt+kh8GTPI+DKztP5SWY0faQzOB
	tRGVRAN1eZR6N1EceBpgFUffI7m5SEp9AWAucI/TB3VoWOcCAYLgvXRWweyfzlCHP8qOWnNM1L4
	eqtHQ6nXvAaARZypoKkqicb/ME9Fd/YdRrbwXV6ITn63R3Ej23mDq4sbCQoc8XCXq0/QbRldZJf
	Rdyf9crRCBuS10w5XYMR6hL6bYTVF7FS9987GX99LnRXrjIyh0Rcl1sbMCjNRMGHDQ2bl1RGwR9
	zzlFI7Xpz9463UQ==
X-Received: by 2002:a17:90b:4b90:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-39b2610f2fbmr38627640a91.8.1788851071184;
        Tue, 08 Sep 2026 00:04:31 -0700 (PDT)
X-Received: by 2002:a17:90b:4b90:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-39b2610f2fbmr38627601a91.8.1788851070748;
        Tue, 08 Sep 2026 00:04:30 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b8f44d7sm32734467eec.22.2026.09.08.00.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 00:04:30 -0700 (PDT)
Date: Tue, 8 Sep 2026 12:34:23 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Anurag Pateriya <apateriy@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH PRELIMINARY 0/5] arm64: dts: qcom: shikra: add Ethernet
 support
Message-ID: <ap+zd/2QmerMwi0o@oss.qualcomm.com>
References: <20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>
 <e9388ffc-ddc8-456f-ad7f-1d185d35ab69@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9388ffc-ddc8-456f-ad7f-1d185d35ab69@kernel.org>
X-Proofpoint-ORIG-GUID: imHLs-LH0B6qrwxjlFrSi3zGlxJ7S6L8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3MSBTYWx0ZWRfX0/b8DnbV3xXj
 LDdbVMGxji6IcGKMh+PASYrwBYrDNXMxeFEVk4jXKSLCVLggbXhgHWch5ZM0X1orgBKQ+S/FLeg
 DurNoC011VJjXWb2DZwfNefKMPY85V4zZ50LQt8Wafv6j1/6BJs2QmhcRshw1fMdRYxM+EjjusI
 F86c9LogzQjpywJJYSUuSux5vtN3v/8wrRt+ovtoBXyF9nGq1YStFsxgc+7RNrsC7J3NjTleEyt
 2nWzYm+xzVETeTDBgd6k5AoCLE6Js6RyVlbgGtd5yL/tPiuVMoAkGmOsPPDXfZXJsVkicjWGcOJ
 TOnabsKLElDlf5nWLWTuSflQK3Jrvlynwijl+pUwwNm01uBpCzpIt/a+hBQJTFvP9Qkl4EtTClm
 h3Xk7saC04EIfKzV7Pw4j0HajivTGMEwCDppLpZCqMvOyy6IWB5/3ng4ITLeholjfNjspTMiZcB
 H2BCCJXeCA3BbmMNQIg==
X-Proofpoint-GUID: imHLs-LH0B6qrwxjlFrSi3zGlxJ7S6L8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3MSBTYWx0ZWRfXz7n6CkCAmDTZ
 +U9+FUahlPtI+XUsyXXlxxwuSJ/1tapikfiToLcL0ub85BgFEydziZa0UJ7jhmj9gvFlMAq9M49
 9x+L2gCC2VjJGHVuwClvOT+d+WiHo3E=
X-Authority-Analysis: v=2.4 cv=AduB2XXG c=1 sm=1 tr=0 ts=6a9fb380 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=K0Q-0DoUKIFXmulf0hMA:9 a=CjuIK1q_8ugA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080071

On Tue, Sep 08, 2026 at 08:56:39AM +0200, Krzysztof Kozlowski wrote:
> On 08/09/2026 08:23, Mohd Ayaan Anwar wrote:
> > Hi,
> > 
> > This preliminary series adds the DTS changes required to enable
> > Ethernet on the Qualcomm Shikra CQM, CQS, and IQS EVKs.
> 
> What is "PRELIMINARY" patch in upstream? Where is this process
> documented or expressed?
> 

My apologies. The code is ready, and I was hoping that sharing the DTS
changes would make reviewing the driver and dt-bindings a bit easier.
The original RFC had them together, and I split it out for net-next
and linux-next.

The only reason I added a PRELIMINARY tag was because these DTS changes
should go in after the driver changes and dt-bindings.

	Ayaan
