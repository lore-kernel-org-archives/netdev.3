Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B7E38D3E6;
	Fri,  2 Oct 2026 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974144; cv=none; b=kvQrlcT/ChRjJoWxhlzPe8SjXqeCog/9nIGwDHpaQOvDpvfpVcPwRby79c1fW04huFfi2R523EMmRe1vjI/wdaPiJN9frz8NssySIcDLBGyDVLlisShZhAlDjzmXhzvSvdMSYeKubc9Mw9Kqp8fufs5+XdBc9xkR39muLizuexY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974144; c=relaxed/simple;
	bh=6EL4HascyvFqQ6K1GANUl1sS+8bPyy0DTmrvEmmWMDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tA4AfzCHGvfetf5D9sh1wfUY42gTi8pb8WBzIVLz5KLsMeemc0vI+/zgP8tlQQwtpNE/oIJgc3OU3viaCSJ2yA2Wv7Z60MXFI1PdbtHfsSplJPV546KhC0hLEVZQvLxwEZvgQLJFpjGEuXRvqrLVZlbrC8jgCSNjgBD64QD3AZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aCu8itCJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aCu8itCJ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692K9O2N3449171;
	Fri, 2 Oct 2026 20:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6EL4HascyvF
	qQ6K1GANUl1sS+8bPyy0DTmrvEmmWMDs=; b=aCu8itCJR1AO3EPTeWPB3k+bamJ
	B4R64y9S4DQcRZJdUsr29DXiMqXXEuduDkbIXte38SEIWDPfGMeVqPRgL1WbFMn8
	jn2OFfAmDHg+uIu+qV7qsM24yQaG1RPMhLBgBzVjBjvccr0ivzTlRWKWgjWnVLbX
	JLyefl5ihMbI7BAvncpzOe+hUyTG5NH70lXr9h5ijCLooNsKOXfZ04QzF7hJwOpt
	Nmk1NavaDTZ+yH+nHPYqt9XeexNymxcswXxj9AScaTAnwL8ZLf7nVj2iKrlcTTmS
	/5SxlBe2y6+VVSKGQ1x+UIXogcgHFAnSD/rL6bwx1Ov2osR234EcwvGRsWw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h26bp3a0t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 20:48:51 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 692Kmowu3329594;
	Fri, 2 Oct 2026 20:48:50 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-stranche-lv.qualcomm.com [10.81.25.205])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 692KmoIp3329586
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 20:48:50 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 383980)
	id 07F1768D; Fri,  2 Oct 2026 13:48:50 -0700 (PDT)
From: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dnlplm@gmail.com,
        linux-kernel@vger.kernel.org,
        subash.a.kasiviswanathan@oss.qualcomm.com,
        koen.vandeputte@citymesh.com
Subject: Re: [PATCH net-next 4/4] net: rmnet: optimize rx handler by replacing skb_linearize with pskb_may_pull
Date: Fri,  2 Oct 2026 13:48:25 -0700
Message-Id: <20261002204825.29726-1-sean.tranchetti@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002143529.3217189-5-koen.vandeputte@citymesh.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=OMqyTiaB c=1 sm=1 tr=0 ts=6ac018b3 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=ZADr-uKGAx4ox3V6Ch4A:9
X-Proofpoint-GUID: Tr-aXrrWulYxFwQ90Hbq1wxVkyeYi2So
X-Proofpoint-ORIG-GUID: Tr-aXrrWulYxFwQ90Hbq1wxVkyeYi2So
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA4MiBTYWx0ZWRfX1MnOWe+YYSH6
 ewz15feS7pxCNusSiiYUOBX10xQGyCnB9EFU4TrJLHJ10L+9IfHHSJyrhGKoEnjS8vKuZA5iJgb
 tsyaF/rp5KlgFFQ497Qkfat/mNWYRAM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA4MiBTYWx0ZWRfX/twtrPIhifuz
 nSLJKn4NFLg48sxLWrkPnMhAu4s2XqOPDEAdn59vEa+e5SVJBn+EnFkPLAf/+HoJ4TMXKHooYZF
 jwjdwvztYIJ1x+5fvjA23oyRzHQPLPn3cwjKmDxOq7qok6co1aCy9EkK4iynGB2Oc8mkvyImr6F
 W0prEcKzZM8bgb3kW6DMFkrjjs3vdIrwaPtM2T5mfy1d9Zets4IogpXDJ2NMQJJTgEjoeoA2Zly
 DBd8I9l8wcXDI5S0liFaq2SFwEev1LKa1iHZsMmzrUOr3brqDG2ehBnU3GY33lpkNmU+Uj+pKgO
 YUgZ+pGceSa8gKp2BGLS4/AeIchLr7XwqNoUkAkDW2Tl5Kh3b9/4wic2ojALg0oH43Ds501ozoh
 wGLczdFeQ7Nq729MIVL+nKfkOqJbn0vtRo70ynijl87d0jo6CRDHom4MsvPwYYkdB8GUnXMtEyl
 YZGMYc99pN+s+YhsRxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_06,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020082

Hi Koen,

Unfortunately this patch only works in MAP v1 configuration.
In either MAPv4 or MAPv5 with checksum offload support, the driver needs
to read more than just the standard 4 byte MAP header.
