Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED3E4CB8AA
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875025; cv=none; b=oz8LXxuLAZddJKQSXGHvoQ2MiHdOvmpgMgs1+F5bLEn4JEQDUvvPwF544moQTxGBlD1UKCnwbN9FXv5cMQJqCoaaUQa+oHqYOuodjMhd0Pw5JxUfS6ho/gJk1EdoNKPzI2v5XR9HNJgZMvlER3zkCFETqqTTLcrpcRVPPfhKISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875025; c=relaxed/simple;
	bh=/JZEh6olWPepouwU4hBOKCHkM0eWw9CAmBjHT5JKKw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rd1Gi+5s0YfJkHa/dA7t3y1hpd2/mWffl8nAsYHyaw4yJbQAZSe4GSsai9pK9+gBE6JbiswKBoIMgFfKdegw8bZcLuSeqPAk81V0X9aRidQLXoKe+JqgPo/USbuSDgLLoA3TmzwUekTkpbhUA5va7MX5Gjo+kXMHuuDZJZ9+mNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m4A999HM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hlPB1QZc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m4A999HM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hlPB1QZc"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688CktNB3013156
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 13:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FNv4YZM6Cu52UIrM7KpWyRo8
	GDUAmOGuixGQjhwCuBY=; b=m4A999HMC9wgG4G2CMo484t+8Sx5PlNIbmg/aggS
	UbhWtJNQtdob+rwyA2BmXnfdSCogCZah2cRBHPkdDS2p0UUc6eBdIJ/YTZe7XtHe
	qgP5wDwVt4FD4tf6UsG+7eDd5G9eh4q1lu4mxoaq8LbN7IcM+dTvo2apr5aKK3kM
	6ZgcZxw+5YRgXmzGLJ2kdFJObrjHdeO53Zj+z+IGTVHSs0C4JWE3mc9WiYfBjBHv
	xZO65WAdE6fshcCNnmSzDRO+Lwupx7kJqO/APJbUcdw+sQ1WR8ga78iFDU3LqkjN
	0eImjhcFYwR0/em71q3GhQpRzYtF/BUaRY48r1nLX2fB8w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rwkqbp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 13:43:29 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbb92868263so3882894a12.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788875009; x=1789479809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FNv4YZM6Cu52UIrM7KpWyRo8GDUAmOGuixGQjhwCuBY=;
        b=hlPB1QZcCp2SGEG/dBb56Kq5EOWtbkK2gO6EHFpo7Vdau62Q/UeSXQOzndAwROMH/F
         Sb3ALrHTDepzVYgAtcXq7Ck/7RarmmJiHvvOJ2fOXNGiHHjZL2280rNc1D4lSeDZ1kxA
         i2Srl6pHLmqQmjFg4xtzQZ2l7dCYolSEmBdzJRT6NhFCvjaLTYiJVHHaq+pKeU0fRdHy
         k7X3kpTJqbc71Lj0/V99fc4s7xistPv9OQpV/l4NvRJla2DefxjycSQV/H6awtIvQtsI
         hAEsItWmAkBg9acHG07xY02oh8yKIqHDGoNZhwhM/OLQ1Sy3lCbgYsmVN/chxujsJYU+
         s/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788875009; x=1789479809;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNv4YZM6Cu52UIrM7KpWyRo8GDUAmOGuixGQjhwCuBY=;
        b=V3f86hqCWjGFrhK1DJBfTcbGqBIDnquUEH+8TF6TQeLEq4kyEcPe+eSrlSifoQG/pU
         pZY6qh77qy+n5XObBMpwYG6AyZEDRv1TJpYkTJcFUhcTvC/CuEnegoa+4SpSH/U0lDdt
         d3XQZHP+IrynHQujV9Lj45nD2OOLCaZI8uT/umgrrEXels72VVxJQ0U2pz4zcNpX0z5f
         SkJaBZVVq02cdjR+lT6GDgo7QxhxlemfbdKo0gV1EDoYIch0lHeQrG4fVX6Jyj8WZPOH
         DUYq3nKXYOWy8k/ly5Ou/qGie/jW8Do1bBVVwi1HHvvjlSSKbYcO3vKJLddDXFLxSNtS
         R1KA==
X-Forwarded-Encrypted: i=1; AKwUvBwHsgl90LC9ebcgq6EQgVOEjzRKHUcCV2oXmxcQDUIJpY1RxpPLDCHFmByQqIJNwpm7HdBWy2M=@vger.kernel.org
X-Gm-Message-State: AFuF++nu8LXnWRbWlhsZWitswq9bF1UjxUbqZUOTnMxP3w18e8EHIa8j
	UGIItZjI9T2KFSjtN4LqjRVye463gsL/f9HnvbZvk1P5HN2t6wWyG2Mns29BJzJYUPucKJrrta+
	T+c9im2+OnNGui2bP7KhaIPk2OakwTMEZ2HRKxPURFQ0Jqzdt6mkDAlS8Nbc=
X-Gm-Gg: AYBFou1Vv0cyCqmyYD32ZmMl+jNcg8fqlMeHKbh7hjBpchdTzhppwMNE+XoMnpjVq/0
	kL6hEZnID3+pC524GnNH38RajaUS8iZ8w/EgwgNlrdRxCAy3QpXfeEAX2OMfg5xwSuBzLlnwUo2
	OchQn57penmDcbJtrGza2EhrYnhwEHF3eBKnBB3yhw/pmtl1mKFhX3hhRBnfA3/amcv8RB95Zek
	v/eAw3Ai9a/2lQZ14zFOg3SdBld1D6qlF6NUq1QJxjImFUTKypSDCRO6xPBB4sap5I+euDd5oMk
	JSKZmLF4YzlsgTziAEgNUQeZZ6yspvcDmAr3LBNTmTYhBjcge4YozoVviVZFGi18Rg6vVwU1EgU
	U59WpO4cSHmYN3A==
X-Received: by 2002:a05:6a21:3e0d:b0:3da:7154:2ebc with SMTP id adf61e73a8af0-3da71543f94mr24925192637.7.1788875008941;
        Tue, 08 Sep 2026 06:43:28 -0700 (PDT)
X-Received: by 2002:a05:6a21:3e0d:b0:3da:7154:2ebc with SMTP id adf61e73a8af0-3da71543f94mr24925119637.7.1788875008446;
        Tue, 08 Sep 2026 06:43:28 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm36539625eec.9.2026.09.08.06.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:43:28 -0700 (PDT)
Date: Tue, 8 Sep 2026 19:13:20 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Andrew Lunn <andrew@lunn.ch>
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
Subject: Re: [PATCH PRELIMINARY 1/5] arm64: dts: qcom: shikra-iqs-som: fix
 GPIO138 reservation
Message-ID: <aqAQ+BxwJstTlnU3@oss.qualcomm.com>
References: <20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>
 <20260908-shikra_ethernet_dts-v1-1-69c0c5c7c124@oss.qualcomm.com>
 <169b2cd5-d0d8-4682-8756-bacf545a95a0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169b2cd5-d0d8-4682-8756-bacf545a95a0@lunn.ch>
X-Authority-Analysis: v=2.4 cv=Ga8nWwXL c=1 sm=1 tr=0 ts=6aa01101 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=mbnDeuF-4I0g7l0wkJUA:9 a=CjuIK1q_8ugA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE0NyBTYWx0ZWRfXyxHg/ICONjZ8
 mhDzCNnEe3968Sxu+C5veX1Ra2Nqwf5fe8emRFne9qzlEjdrSbXnMeNoyGsoEd1pEVDKxJMNbmq
 bocx0hZRT/jCgpP/Ci2jCb8vC5iiSyzoj2ZTyrpf9AmXGiyVaioHEdySpwBPMTpnwt5AJ+SzgkC
 jSRlNvxWhEnYBAIqeteNbU70/27eb3t3Lj89xeLJwED157j/QGMCPISsJHKf83JFDZ7VAR4yVnC
 gOn4p2S7twaf+7zGNQkSoPvBClS+d3amXauEft2w04GvAPXEmNpdIJS/SVg+s7G5shT7Nd1O8JL
 xxX5qTSGHeqNgebAvxgTJH18gskEvA0SEzqNpz8f6I4PvwHg05ahDQdBTAqpsX+DOX1zld0Vq4j
 EXwhDuPH0u4c70QdSfNU38hNTtZTuXQ7mnlJTn7119HaDlRCEN7V6pQsVB2gNLHLVmx4m035K0M
 u9lBpSjTumRTzmppDGA==
X-Proofpoint-ORIG-GUID: 4T2ymEQmSFCxzHFy1vAQ1WCuhystCot9
X-Proofpoint-GUID: 4T2ymEQmSFCxzHFy1vAQ1WCuhystCot9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE0NyBTYWx0ZWRfXxnZO/13IZJpH
 U9i4Nx8zxaPE5Z/XDE8cSBALGZ6OO9IJPXPZ3ZNzyVxFefAL9jOk/cq+fGHO27klHRfBCec5l98
 LIL+YJfZtFGV7FTQMUglJ7+xfP1wfS8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080147

On Tue, Sep 08, 2026 at 02:11:22PM +0200, Andrew Lunn wrote:
> On Tue, Sep 08, 2026 at 11:53:30AM +0530, Mohd Ayaan Anwar wrote:
> > The GPIO mappings on the IQS variant differ from the CQ variants.
> > GPIO138 is connected to the RGMII1_RX_CTL pin rather than the NFC ESE
> > Secure IO pin; the latter is connected to GPIO49. This incorrect
> > reservation causes the probe of the second Ethernet port to fail:
> > 
> >   shikra-tlmm 500000.pinctrl: error -EINVAL: pin-138 (5d20000.ethernet)
> >   shikra-tlmm 500000.pinctrl: error -EINVAL: could not request pin 138
> >   (GPIO_138) from group gpio138 on device 500000.pinctrl
> >   qcom-ethqos 5d20000.ethernet: Error applying setting, reverse things back
> > 
> > Replace gpio138 with gpio49 in the reserved list.
> > 
> > Fixes: 779aead2dace ("arm64: dts: qcom: shikra: Add gpio-reserved-ranges to tlmm")
> > Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> 
> If this is a fix, should it be posted for a different tree, so it
> makes it way to stable?
> 
> You don't normally mix fixes and on going development work.
> 

You're right that it reads like a standalone fix, and that's on me for
the commit message. There's no functional impact on current users: the
reserved GPIO (138) is unused today, so applying this on a released
kernel produces no error and there's nothing to backport to stable.

I'll reword the commit message so it reads as a prerequisite for
enabling Ethernet rather than implying a current break.

	Ayaan
