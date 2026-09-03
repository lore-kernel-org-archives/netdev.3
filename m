Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71E13749F6
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421789; cv=none; b=EhrBFpA924c6OJSg2kywVjlQGERBH6UMRey48ONvcgZOR9YGftWLmPxCrRnTaW01wvPq1MiAQIcTeu/yrBOX3T85bYIB+uWb8bSsjBytZDhaucMTwQRWf5mZ5UKEqWiGt0HlP8gOUgAs2lSWwmWG5g6TiQL/38Um1t49WzZWo+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421789; c=relaxed/simple;
	bh=ksv/avRnK4UOBJ1PwYrAwimKQy13c+CjYXmlx2M+y08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4+qtbvjO96um0FMF+oC5weLUgdbdZNxI3MsPtenU893nB9KNgtewvFECQIiawYQqoLenXyjTnxtXcHXr9dZjuKZT5PF1e5mcG/VRF9aIWc0m2zr80h8SX1SP05jANQiHUIeB4RipDuv/z3/8kNuGYbhZJjsdtPy5ESwZWRsCpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q1oxQjw/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T13BqZOg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q1oxQjw/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T13BqZOg"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6835lKUs3798924
	for <netdev@vger.kernel.org>; Thu, 3 Sep 2026 07:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0GHibo9Blx2AAUlYEMr9nHfq
	J5O/B9F3H0pQUm/H9Ds=; b=Q1oxQjw/FsamPFoT6xhhMx+0cOMRK02mhvy518Zk
	ZrXvctXVLhqBKLXcq4ksiw5hIGxZ+3HNBq1gSumdq+mfme0gCrThrv6fjTC/3szr
	fcUql69XiY38pX/hu1FVCSsB18qPV4I1s/Q7ZW8Vsb1yhRCumW/iw2Mx+vY714OH
	cgWs8379I1YRcESweUqdhoOZMLDum2TutAL2U9Kn8yM8ZGUUna6IUEPmRkuOAu6l
	zPyxT624VozAINaIfXnQWowqOT/DktWhyIzaao3jC09xhf72qZx/7iWtJiHWAWMU
	UoPE5fl5QxqlE0ht3rdJ8qW0HxunKcTeO0+31GiYmClhHQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1pygs84-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:49:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e53b8a302so412976685a.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 00:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788421786; x=1789026586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0GHibo9Blx2AAUlYEMr9nHfqJ5O/B9F3H0pQUm/H9Ds=;
        b=T13BqZOgjfdoXUEhABJkkafh26fRsW28zEpYhfzCS1Jv7ehhaToPeksB7/T+82WKuM
         LrDVubgDRs3JIfrCGmHRtD/X3gW4mPllh2OAnhkrh4WwDm2PU7KUCKiMiU1o4PYGWNzr
         0VuHFFnmpwEqQdj4wWfyXeh4N2hVRJqBaH4H7/IcJLmZGGBtzYogcfdcoFa96Rl5MKc4
         XFxc1j+Trv+H0jX93OJ1JEVvrLTRjNFF9xWFql+ZbNVDOkUP8xagBedXSGAXMAhxMke3
         GbwIreI1ckQw1v0oLYB/lAd6rGnFB33WCssMokVA/tDC2rrrP8fAxLDfTXmQ0QHZUzYG
         pAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788421786; x=1789026586;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0GHibo9Blx2AAUlYEMr9nHfqJ5O/B9F3H0pQUm/H9Ds=;
        b=k79G0yWrQ5WgtPkDn0VUmwSz7m7OxAyyIqtgoUUnhcuCbTsVPtN0SXQNEDzGW+59XG
         lwwbopLMQ8QCaR5S70cpzza0XR1D0dycRHGQlAJYAcWGlYiAqP3wWPPSAAIzobtaI55u
         fVkP6VB6zpHv7cB3GV7LPyEOBxNtG6R1YAU5mr4CexBIVjm6CKKbNizdQV5+u+u4IBVg
         t2HasY6MJUVgED2yywHwWZ1rLtQo+qSOJTtREOLZLJuve27s/1sMESkLqM5wzsJGkzTo
         VNR4KUfAsG/3bxsvsa/7NkmMk7z+wpAImVfoVoQ0lINqTAKKvjEATSh6TqzHbFbW+OSP
         0d6w==
X-Forwarded-Encrypted: i=1; AKwUvBzcMXwA8bZtWEoXOKUqTcTX9MMqRPAKL1azwMqg0C7G0jvE/DkovdAWruGDgzJOfC+NboSQrck=@vger.kernel.org
X-Gm-Message-State: AFuF++khUKPL1NNzjsvv4J6L7vRkxcDMA8SZXkxb632EXMKZe9grztkS
	EikXUBkGiFlVfhlqntj8QH5Vbfu3qLvXMXZid6qslgmgqjkAGzYfEwA8tUWbjFyXYehyOQRY5B6
	13CaLlkzQgeDndR5JV5wqSt4rsQSjMp1qMiljnY0d6rLk2acKAzxqPc2zbSY=
X-Gm-Gg: AYBFou3Ya1QXIXLgnVGdUDERU7PbszDxTDKJN7i3fKjzqZbxr7DWZ70whYkkyDWih/U
	GTuMfMFSbrDxj/sd74uMsdBouVB6ZBz4GYR7nvdqdsn7P8mqdQlkCOtbmY8nqKvdQkf8OYcMSaO
	iRnP0zJL+oYdSpnwha5RoLhUTwxsBwOcK9SeeXGeFccn+qAI32V6lLWTwvAbVZngmo9r6gMAfir
	jNVSq5VylnGe1QJTPTpPXwdyvj4vhS9bU3yvKOk1gt1rqpgpuqa9DmCe4eKn+KM5GuYDpshbq7H
	QvyrBrubC0Az0Ur3yWkbmbhX2tikT47ARs97KT323G9/iBp1VDmhTHm8sRXBzRQjPMleQYoLSYo
	6CkDl1eW82ZWX/g==
X-Received: by 2002:a05:620a:271a:b0:937:2443:341c with SMTP id af79cd13be357-9396100cb30mr1279827185a.41.1788421786091;
        Thu, 03 Sep 2026 00:49:46 -0700 (PDT)
X-Received: by 2002:a05:620a:271a:b0:937:2443:341c with SMTP id af79cd13be357-9396100cb30mr1279821485a.41.1788421785465;
        Thu, 03 Sep 2026 00:49:45 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eeabbfsm11219681f8f.31.2026.09.03.00.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:49:44 -0700 (PDT)
Date: Thu, 3 Sep 2026 10:49:42 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Kristian Brox <isyourbrainfoss@proton.me>
Cc: David Heidelberg <david@ixit.cz>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: add
 ST21NFCD NFC
Message-ID: <oznqr22wo4tuonlcs36uabppl7anwax6hcpdt4j5ppgjpmkzha@q3qmtizrtzam>
References: <20260902-fp5-st21nfcd-v4-v4-0-ded2f1c501be@proton.me>
 <20260902-fp5-st21nfcd-v4-v4-3-ded2f1c501be@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902-fp5-st21nfcd-v4-v4-3-ded2f1c501be@proton.me>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2OCBTYWx0ZWRfXyxR0j+Eob08w
 K7kqrYkxQFDe/wNpZ3JRJ6wK6hfXbBwr7vbpsDMZtvfBw7TBBOx47uQIp1AVZpOaK5ucFe6wBA8
 YvIlqTOohSINLeUm2m3Q+1ODjfL+5n4zKGncYTZ2t33MizyjGqmJ9h09V++7a+GgMkYA297X+8s
 LZqLibQqSZwAUbnOCaupIE1o6gi+mzPPKDvACaRqZ7o7onNJ8wwSQZMaMtMYq3ydGyTdRyI32Vo
 mYAYCJIIniI+eVXym601e2dLQGyHiyT7xO7HGqPeaB359d1+eqMsEZuZISX18ELh5ZVRVS7FUlC
 0Z4STZHfsK2tpfx7m5rPTtH3uJqd+AKdzTwl9ntCF3Sy99ui0Oby9gpVD9w5G/fCIAzS/rftwYf
 YhfG/yr9rKDTgRjbnKecTtkhokZd4z/sF2bNtWPAx8ijb9QiIwMmJVStylaeuVnvgsI+gXS8dog
 9/KjGFRuGUOvLTgP0Dw==
X-Proofpoint-ORIG-GUID: NSKw79XDotdh1hXb0MPuZ22yHRamDAv-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA2OCBTYWx0ZWRfXwQw7OD/vADy2
 Fmn+ypN59ZK6bSmNIg0FI+eARiVbxlq3bxYr9KtBWkkQ0K/BJuQopgYb1UrLWJrRc3krI2NpKza
 6v1yKcm1aJI8aXrFnRmFJZsVxXy49aI=
X-Proofpoint-GUID: NSKw79XDotdh1hXb0MPuZ22yHRamDAv-
X-Authority-Analysis: v=2.4 cv=DMO/JSNb c=1 sm=1 tr=0 ts=6a99269b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=q7XEBjOi5DRkXzmV0jSBjQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=FWA6L-ytD-VELHUIOsEA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030068

On 26-09-02 21:22:25, Kristian Brox wrote:
> Enable the ST21NFCD on i2c9 (0x08), IRQ TLMM 41, reset TLMM 38
> active-low. Compatible is st,st21nfcd (raw NCI).
> 
> SYS_CLK is LN_BB_CLK2. VPS_IO is L18B (vreg_l18b). ese-present and
> uicc-present follow the public schematic (NFC_SWP1/SWP2: SWP_SE to
> SIM1, SWP_UICC to SIM2). Reader path is tested; SE/HCE is not.
> 
> Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
