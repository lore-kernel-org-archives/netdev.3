Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E97175A9C;
	Thu,  8 Oct 2026 00:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791421044; cv=none; b=LjqyM59PuNH5OJs4yGBywk1w2Jiu1f0nuOxHoSpRxru0bMnb6LdGVpGI20n3RD3vhO8ykII3JGjqm3531bR9Z91IHUUlRN0EiAzxl0+XGaYqRjfJnFhL6Z+RHrAQTNjB1sFUJo1EiY8MUPbRl5T5alobNFPCQt2KAahPlkid0RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791421044; c=relaxed/simple;
	bh=hiy+r2H68pmhnZTQQp3bi+zd3lV66rF3SckSpdIHOQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qd4OrvZAZWUY30JIpfQ7340AwsckoYrD+uM263XZ42mNjUbv/IApoS05xejvm7DTah1nLS5yI/Y0ragyPsxXM7kTKs5Dr+kEmz1N7R78ikO6niEWqdmRDm/YXV3x5WHeXclLoDAeHnAjnBUzcIlfau4TPoujSimh8PDpv3umR+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SzLSQh4r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SzLSQh4r"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697LtrdZ1467413;
	Thu, 8 Oct 2026 00:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lRb81c2RyWc
	lOo1KRcheNSvud804gn5HNxe9AsZEAg4=; b=SzLSQh4reiC9cRt79eMIEMywU8i
	yW9cHJm/0/pBGXW7khTlCExcyJA7TXtkQAA7/9sNijmsGfFI26GDQW6O+vNss1LG
	KAFiJyDPlnmgDmwd/Fcy5ygEQJ3Q8/dXw/yZ73iGYaj/p0JuJLipV4PrT2zRsTS+
	fGEUtiMY7xlOTpccby37mZ6UPsdjO4V7d9UXNHS6taONQkemSh8P0JwkqEEo54bi
	Wstu46o84Qh60Xc5EVeVomx+oXTOhBGW1cOCQP5shCjx5+Wffgpn+aelC77HYA8n
	dhWpGhGvNfz9A/OMZ5YVGnwgiafJwT6e94HPFg4xHIVKDz/IUyaK/OvjqGw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe40h5t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 00:56:58 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6980uvfn1600941;
	Thu, 8 Oct 2026 00:56:57 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 6980uuZQ1600934
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 00:56:57 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id A22F0AD5; Wed,  7 Oct 2026 17:56:56 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next v2 2/8] uapi: if_link: Add RMNET_FLAGS_INGRESS_COALESCE
Date: Wed,  7 Oct 2026 17:55:39 -0700
Message-Id: <20261008005543.2630828-3-subash.a.kasiviswanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008005543.2630828-1-subash.a.kasiviswanathan@oss.qualcomm.com>
References: <20261008005543.2630828-1-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Proofpoint-GUID: -fjFEZRkGnNHV5PJhphqAhF6KJ3Ovl5L
X-Authority-Analysis: v=2.4 cv=AbwkjHXG c=1 sm=1 tr=0 ts=6ac6ea5a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Hq0_xJipLjZV5mAGnJ8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwMyBTYWx0ZWRfX9yyfAtGYvQAW
 9RtnjroRxDBnT7Ax13WMHYyiQ7C/aA4+ZV7khW/aIYW9BeQN8GipY033kAKkY0/hE1rbJeqe/zi
 3QoqR4ivLrmvRcN2sb4/vG67V50Xbio=
X-Proofpoint-ORIG-GUID: -fjFEZRkGnNHV5PJhphqAhF6KJ3Ovl5L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwMyBTYWx0ZWRfX7iQ1auc5tpXx
 Ha2SMZ/rh9HyJue3UodWA/xQzR6Os7mLowkoDtEo9FLzGBVXVMMWdjKU1h6/L5NN/9UbpzAJQOR
 oQS9Zl9MbgkTCLggVjjnI56VA1OKuc2PVDzcJ6tUzijg/ryQHkj7XjznG8Gnlq7XSjI9XHApKc9
 Mir/EV/PnBgzZ5eUTeACfJm1FQu8R6BVTT0BMvHxVOgo0jyC7B082Ghl2Z5eZCXPyD0WKgml/si
 vA7ymhwap1ZhRGUntn+/kOrVXMfd1Epe4/4Ir74yNx42JJrUK64ILS4EQH3IQRqVPQ+fC0bwP0X
 9x2ye0ZGzHsqgqfN7XnEUlabtd6l9QqAU2581W66JLuPMnhMYEMF/lubUzZbo1qxC0gneGUjEch
 76pHE6ISv11gaa5E/4/dkoAXGfS5TJT+tkKv3Pmvi0olAd2NXdKwMPjAwb3xvkLrKjjIargsG8L
 VSMxfpxna7KxPgOiwZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080003

Add bit 6 of the rmnet ingress flags to allow rmnet to process incoming
packets in the MAPv5 coalescing header format.

Co-developed-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
---
v2: no change
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

