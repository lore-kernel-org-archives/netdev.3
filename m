Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C114195A1;
	Fri,  9 Oct 2026 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535469; cv=none; b=H80ULDr/FxnV2w8uGeNaRtV11egALjBCDPay0Y9yqFLXtvFvTeVGufAeNfD7hC5HNGondwLELc8dNNtJHsVUpIxPjRoamlkt97QcTgGbja+1DHAnOnj52TjM4Uvuna2Oiv2xd2BtP3HLFsat7nImj4PP4mtMlHpVkQn4MfscViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535469; c=relaxed/simple;
	bh=XPhHEV0zIfkAAm9YMKcPrGSD6j7StInxWNhaqG2RY7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M9gbHpKcHInhFZPtRLdP1AdoRRWRJXp/8Zkepul64oZBZeDE/Av63sgHqr0bpiKfqmUSEhsi9BJUxpodoGXjPv9vRp3DNQnuvUnDum+hwf4pnZT8RIfbhf/BxOVF3a/Gfyh5XMUEgEioFiBDL+9g6vgGrKeXfPhIJLFnh0rVFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bSXsvNkv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bSXsvNkv"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KH9n230934;
	Fri, 9 Oct 2026 08:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jKrOl749CqI
	2BgyKuUvCLGsp5zwk4omgdWxJqtg74Hg=; b=bSXsvNkvXlfEP30UhOwtYY44e4C
	OVxiHPWsCfx389X3LdmVwbRVeesbawDYtXgirOXbseZHfshPcwbu4MAAzleVLWBp
	R7mjkAH+hAAehLkhnHEEDh8CJtmljdinUlpHsN0y/VDlnfnYAiss7Vi/YEpNoMZQ
	WkP0uCvoj/CVPzfmUpd9k52UHTAB8OYOJAGC5jzkn70ZxA7mI+1chJzsqigdEvRF
	mf32FWUjZdfHfpCRHtWc2T2UGxCCJbfv1HAzTuo/D20WMyj3fNsqVv7IIsL7dnPo
	ja/hwt7omknieM4tRzGNO63wsf8QGKjhU43MC2B5L/+ylnhnzspdpLm/+0Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxu2qbb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:44:09 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998i8TH236256;
	Fri, 9 Oct 2026 08:44:08 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6998i7YE236237
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:44:08 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id 92B80ACA; Fri,  9 Oct 2026 01:44:07 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next v3 2/8] uapi: if_link: Add RMNET_FLAGS_INGRESS_COALESCE
Date: Fri,  9 Oct 2026 01:43:45 -0700
Message-Id: <20261009084351.317632-3-subash.a.kasiviswanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009084351.317632-1-subash.a.kasiviswanathan@oss.qualcomm.com>
References: <20261009084351.317632-1-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNCBTYWx0ZWRfX5rwiOR3ubpdv
 YfuLW2qfBZoNrrNodlBf1uT+I5q2E8hvSUXgs/+UnkpMDkF9yDr/GARmvNrQfbreh8O5TC1c16p
 DxNz+46bj6vtU3JW+TS+eL9qNS1AFttGGe3gWofoXJIO4HuwoSAJ1GV/KwwK9orxhLMKA5EngAZ
 RC4CqMBorc8BIY0eKWKRpHFJpu+E7631I/Hmo0/1yQHucbqWMV8JMvve2EfiTS0zMM5Kj+QyE2D
 eKT46ayXeARNaYQJnOCOnyL2DE+6dPNblPTQJWElNyRUBpUW0gS1wRTaRxujqH8D8PVh3QXBbpK
 Ygv3g6wl298STj/EMwnpPk9vj57Jcg1xxWiFMfavjuPllCSDO8MuluKcnDvThRR4qrKEE2QtBkp
 GIoSnGdlWhl/EDAnlMwDoZiQ4E5igM8TN3WJgRQb8YuJHvBU+OdmwLtVtjhLLcAn3/G0lTUhDHE
 h4ZliBh7QLdZmW+NrqA==
X-Authority-Analysis: v=2.4 cv=QbjzLcbv c=1 sm=1 tr=0 ts=6ac8a959 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Hq0_xJipLjZV5mAGnJ8A:9
X-Proofpoint-GUID: cNgehXqgLBwZ2khpA0rDF2IOJoR0ZoO6
X-Proofpoint-ORIG-GUID: cNgehXqgLBwZ2khpA0rDF2IOJoR0ZoO6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNCBTYWx0ZWRfX5Tza5Tfqj98H
 EE8amNWf/NLCOIn72p0hLcRyIMnSU0bbWX+HkEym0vjkN1BDk/kB0je4EmRT8SpHAUyGNAtFFn2
 FerNDJ2g+bHXmDYVp1WlB7YPlGVtzes=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090034

Add bit 6 of the rmnet ingress flags to allow rmnet to process incoming
packets in the MAPv5 coalescing header format.

Co-developed-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
---
v3: no change
v2: https://lore.kernel.org/all/20261008005543.2630828-3-subash.a.kasiviswanathan@oss.qualcomm.com/
v1: https://lore.kernel.org/all/20260930051345.857443-2-subash.a.kasiviswanathan@oss.qualcomm.com/

 include/uapi/linux/if_link.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 245b36204525..349fcddc6622 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -2022,6 +2022,7 @@ enum {
 #define RMNET_FLAGS_EGRESS_MAP_CKSUMV4            (1U << 3)
 #define RMNET_FLAGS_INGRESS_MAP_CKSUMV5           (1U << 4)
 #define RMNET_FLAGS_EGRESS_MAP_CKSUMV5            (1U << 5)
+#define RMNET_FLAGS_INGRESS_COALESCE              (1U << 6)
 
 enum {
 	IFLA_RMNET_UNSPEC,
-- 
2.34.1

