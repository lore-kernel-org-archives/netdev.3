Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694A5387599
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852229; cv=none; b=ZUXbsR9x8juw+O7TZRbg9RgNmBG7zilQJt4jdWaqd5dPznOsWYjSkP27GiYfC8rSQyEKFYypvp4Wb4v2l2KNp8o1YKlBTdzYbwCXg4IGbZOjmFC3CpSbj6dK16vK1fBUFV0hcNEx2WH4txgVmtzTI4enWu1gk1tqZRQmCpi9w1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852229; c=relaxed/simple;
	bh=0Hn3nwFflocQDE1Vnf/oZsgxF4q4ZrlzvFiOG4Em9aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbHh05YiBn4QTuiQqR38E09P5Abrx744POyj7EZdSt0WPB+Pxio4LY3GMdemTXitQWjB8Uz8EzaPjHilO8sredq53gyQ+dq67dUgta76FAuhjU1o+N/Ifa0X9LHUjGJwXvy9dhRJHlXz8Zn8R+vypnu/Mgeacu7g9EVT+8zaA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gAt3yW2A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EE9n50bc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gAt3yW2A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EE9n50bc"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886M1eL2363234
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 07:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=repPIlp7EV4oN5ph2gAva5Wf
	gIj/jHE07iTHvT9P2zQ=; b=gAt3yW2A0/zE7b8Wn5f82T+fA4l7lq4kudwqWMvC
	adw2vDQmfLzguOQnOKVRgc+CptAbjA4k3bbFiPYItE+pZhV3tS94rzo1j7VNqxGe
	nKuTI1hKNJHvvEJorFf+juJgYSsKNCg2esVmi85pvdYMESKGSnFFvyNAXAehz6Io
	pKPWCOG568TXw5QQVeg0hphYQiIa+cT+WkThGj2+0iWDQl4OmuDaLxJJ7Xn7AcNl
	SnThu0XD8uwvFpG9EhxkVHsnc8NlMOL0/Ce5f9PVcRbXx3AesZU9Whyh3flUAf2s
	h8sEJhvc65j1KhiURLf7A6luPK45cFDWb8MdKeXEy+0tHw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjagugt9d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 07:23:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cee1ec30f2so50326675ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 00:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788852226; x=1789457026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=repPIlp7EV4oN5ph2gAva5WfgIj/jHE07iTHvT9P2zQ=;
        b=EE9n50bcw6o9gzcOVgt7yyHkY9bq6skq50Zobpd+BwqD9I3pGaO+Mp7fMRolx8GM4h
         OdQYlZS6TI2Wk1zo+JSHOn0uylTJTEFXG175stMRste4mLvkMOMHyySTL8lQKaszTaXe
         7qTlrLgNCVxZ9h2B2BHszoiNh3F+d9BI36c95spKZpBliCbQF6BoMulTEXZ+4gmJnIXl
         OOUvti0sz1DYR9eiIh8OsKjSHOI8oBNrar00mAzZuP823RTY/2ycBYG88cUBjO9KRfCG
         XOj8XBEjWtsDH8IhlOd0eg4XnlYMIqYr2qAeJVym4BbTnSokbq50DrRo7hqt5dg385cE
         +5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788852226; x=1789457026;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=repPIlp7EV4oN5ph2gAva5WfgIj/jHE07iTHvT9P2zQ=;
        b=mtOnmWkjHtMcu4SI8uO9o8U/EQgKg9IKiP2Fx8LTxg6OBhzE1mkXTuuum5p0l5RpOb
         M1ZOwKCx/K4mKsPOqO454RXKd9r1Qqo9wjI6f3eYfy7Mltt39YNoRXznpzLe9NP42+E9
         o63iOPKT5FbFheyO8H78YhyusAuw2QoxCqE1QEmOzoO8U0GaXeyjWusl363Pf9X7f67e
         ex0t3L7k2en9zam2DR6l4UutL7Us22yAvvVQx+ZHe+3YNpiaGA6ikYJsrzDlQUCoycmM
         arNvsy30kvhLTvNY/cIdRMjLr+0/lF+bZF/Ir6PlMc8MriE29uP2N7firllEIuToPMCI
         rq+w==
X-Forwarded-Encrypted: i=1; AKwUvBxXH5BPkPoVTjDH6Qb+q7xTeYZCpRBmdXdoRsN1sWH3wLP/hYqgoTtKRFUI0kkZ0lzcKIivv0g=@vger.kernel.org
X-Gm-Message-State: AFuF++kalNY3wubANADa1EBZW2F+Th7hUh8/i+MIOGQRBwVdm3im1rC9
	ync/6qnrlzeM/3cDqo8sylgsXIVq/dRSQcK/NGyKgkht+0w1k8OX2NyvV7TE47W2oZuAIlZ665F
	YCuNG2lE1epuoSa2M8LEtow2pUxUzwdr76hL6uoQcRfkHyvvBzndsBWvT/LQ=
X-Gm-Gg: AYBFou0KAFWXnaO/dMSQKeQeyHrlRX5KO8KAtxGu2gmToLFo0fTEZ+IHI4QaKlSIpig
	XYcbFbCXh397i543rYmMMy2Ywdo4n9TNiDUG7tyvbGS1Jhq2qE/xXyZkKGgvxDOxGLSxe43z56/
	r+6C2inPpSfft6zymUZBiLHxSspr6ptoX3T9JvcLouQx3rvz2hsMSx64Iehba3iNyoSCo0+k5IB
	PziG+i0/nrjTN9wP6cRtCcJ227kG/gx0K9j/svvICB3W9tUGa4DiCvS19F/3/eZTTBSOJNSSl0a
	CxAgLQ2XJxHEu/3tLSO/60WoWRTOkKdVMuEKgfVz96sk7Syv2SB/ze+YE7BZerKubJq6cPabn8h
	0Z3xZEQh9PlybvQ==
X-Received: by 2002:a05:6a20:2583:b0:3bf:7bf7:7913 with SMTP id adf61e73a8af0-3da39ff4716mr38887947637.14.1788852226265;
        Tue, 08 Sep 2026 00:23:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:2583:b0:3bf:7bf7:7913 with SMTP id adf61e73a8af0-3da39ff4716mr38887881637.14.1788852225783;
        Tue, 08 Sep 2026 00:23:45 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b9f68e4sm35845902eec.24.2026.09.08.00.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 00:23:45 -0700 (PDT)
Date: Tue, 8 Sep 2026 12:53:37 +0530
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
Message-ID: <ap+3+Xhq6ygnPzQ7@oss.qualcomm.com>
References: <20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>
 <e9388ffc-ddc8-456f-ad7f-1d185d35ab69@kernel.org>
 <ap+zd/2QmerMwi0o@oss.qualcomm.com>
 <c23369fc-84ff-4881-8327-c18fc3692306@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c23369fc-84ff-4881-8327-c18fc3692306@kernel.org>
X-Authority-Analysis: v=2.4 cv=TqLWQjXh c=1 sm=1 tr=0 ts=6a9fb803 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=enzuNw960j4ePshAGDsA:9 a=CjuIK1q_8ugA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: -kCYY0E3Fx3DP2MH47oBXfbkixn77-kJ
X-Proofpoint-ORIG-GUID: -kCYY0E3Fx3DP2MH47oBXfbkixn77-kJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3NCBTYWx0ZWRfX7NWMUk9eOohW
 fl62zFuMPwXnm1jDw/xpPuvWIg+pXv+F3Qj+0XetRu/20C4tMCJanFK9rP9Rq3PkoebM0EzTNk3
 Oi6MQsKqP9EY3joOXqDUAYup4UJun40=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3NCBTYWx0ZWRfXwWSePT3sK+pe
 LeJiqCpYSm2xjSWwICnosiVs5lcUhqujQF8TAJNetYuACmRcBmJD7JQzWwkLqqI2y1QKI/0ncuD
 vPXRV0t+Zg5PyhWZI8GTe5JWPbGH9VCymNj0ULTn32LJWL1nwSKL0LyNAuEUYp6empQBaIDNKK/
 3p4brTuX/G5qkV/5/NHszg3HNXnOF+zvo/uTOpXj1j7mZbGaPtnsBgLM7Bhe7Ud8bl8+SBAGOm4
 bultI2+rgJzt7LW0iPIG4/s93SXJ7QIcSPwfOPSBk0OU5Tmzta+a2a/GPPbkyp05x3eHqOkjBGr
 l/TMsiiMZlqd6LpmzGu4TtvMCb6YHYr6FKUBM+tNpV2dsXYX4NyexdvWG4Tpzss9QJM15OQeopt
 CxQ3Id6MlfnwJ2h5ejIpeIH4gVK/3CHM47MI/Co0UANYmZDOHKgn8Kvz6fgsQwf4uQX1CuREiDy
 UtnfV0XjFRUd6c/eBWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080074

On Tue, Sep 08, 2026 at 09:14:45AM +0200, Krzysztof Kozlowski wrote:
> On 08/09/2026 09:04, Mohd Ayaan Anwar wrote:
> > On Tue, Sep 08, 2026 at 08:56:39AM +0200, Krzysztof Kozlowski wrote:
> >> On 08/09/2026 08:23, Mohd Ayaan Anwar wrote:
> >>> Hi,
> >>>
> >>> This preliminary series adds the DTS changes required to enable
> >>> Ethernet on the Qualcomm Shikra CQM, CQS, and IQS EVKs.
> >>
> >> What is "PRELIMINARY" patch in upstream? Where is this process
> >> documented or expressed?
> >>
> > 
> > My apologies. The code is ready, and I was hoping that sharing the DTS
> > changes would make reviewing the driver and dt-bindings a bit easier.
> > The original RFC had them together, and I split it out for net-next
> > and linux-next.
> 
> Yeah, but why calling it completely different than every other patchset?
> Why coming with different style? Why this cannot be RFC?

Agreed. In hindsight, this should probably have been an RFC v2. I saw
some recent series using a PRELIMINARY tag, but I see that its
ultimately just an RFC.

> 
> > 
> > The only reason I added a PRELIMINARY tag was because these DTS changes
> > should go in after the driver changes and dt-bindings.
> > 
> 
> DTS cannot go after the driver changes. If that is your requirement,
> then original work is broken and needs to be fixed.
> 

I should have worded it better. I am only worried about the dt-bindings
going in before this DTS. The driver changes just add support for
whatever we are desribing in this series, they can go in after
dt-bindings and DTS without any issues.

	Ayaan
