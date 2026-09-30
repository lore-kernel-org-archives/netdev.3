Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88D1330307;
	Wed, 30 Sep 2026 05:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790745284; cv=none; b=kN7E9jcxvQ8AgDc4jNsYuINLjpCEuYM8NCSsD++61TKeCAYMAicPSo4qD7T8iGPzK8WEu98eqeBbDvBvLedLp6v5dK+FI6V9sj7PQWtgXSIFEDi6i4q01XJDPna1rjJbJeLlAqJHRe0fuWNLeHwygnA+IB08Y/UBPesXrjBmE78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790745284; c=relaxed/simple;
	bh=gWFuVTb0Pb+PHqtXs0sDfwCNI6TYx7KTYRV946ZgCjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bkAetXwWVn8E5cZCA+6TsAhWV7dMvqhqtPNrDpMt4OrHETQTvo0I9UZ+CwNbNmLoo726/kTq2nNoLi+yAg5BWLszas1KtDjDY6udnUg+Mkc0ACMw2H70tIcSQARmKvdoMbPUoY7xpBxGkgNat6k7K+arc5LNtmMDVM/IiMvtYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KL49/59c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KL49/59c"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U1BnvX1967401;
	Wed, 30 Sep 2026 05:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IKnvFr0dvFu
	RQiB0y6khkqp3xw/oK3h7Hs9oHIDHzlI=; b=KL49/59c3ANhpb58O8kcjxK2qMO
	gjqoovV5DiAYdXZK6v3h7r12viuNJ3bcGukXS/sDBJ4pgo8as2/7SPPp98jpwB/9
	H0RraQNo3BTBkADy45DfWYY/8mo4tseP+GjPqpdKcpta8j9xUTRljf0S74EG4P+z
	+DVmEd46AFpYRPYwUZae9+an2gPhtL6CWsc3C1tnrI5vFIMBEDNIf5N2oRdz9zyY
	XAdJofI2XRwV4QGWcT6SxuQEdRljMenehl8RX46d1WpuTYIwDq0Kef/d23IeOrsD
	vpCU+ep14oth/aVz+lytuLyLVgHcdFAO23JT0bWpRnHBGyjGUkftRjQit5w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rj2ry8x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 05:14:27 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U5EQPK1579022;
	Wed, 30 Sep 2026 05:14:26 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 68U5EPLj1579006
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 05:14:25 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id 70036AC1; Tue, 29 Sep 2026 22:14:25 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next 1/7] uapi: if_link: Add RMNET_FLAGS_INGRESS_COALESCE
Date: Tue, 29 Sep 2026 22:13:39 -0700
Message-Id: <20260930051345.857443-2-subash.a.kasiviswanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930051345.857443-1-subash.a.kasiviswanathan@oss.qualcomm.com>
References: <20260930051345.857443-1-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: c3GGvfadQipK7PxGv-QKFQW7JQDCg2uV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyMCBTYWx0ZWRfX4TAxwxMqT5MZ
 zDA0JfI3H/hoG0pPJpMfNrVPYJm1HchXhi0KiE534cR7xcVWuOLA6xiftdX5Rpe1enmjhxNd5WF
 q1zleThMl/pQF1/gR3YpZzpfiEGENRFJRAV2QuL2Rte+QEL/1hOELD3XxyVrNRP0BisBEYyxrwq
 4AN0AeS5R0ib23UXpNt6hQkBcoao5RGc3Oob88RtRBD+GBvPC+/dAhVExHajlxRFglR9YXT6w0d
 EepjaOYN1jK+k0vLzCPr5J/gAOJI1dWvGNH1S9qip+XKxtyeJbRiY8UcLGZcgE2RdXxuUIQ0I+S
 bGpN9FgZ3RwKao6tBVOxLIByCFxmb/5Uh7HUCLPbdOgk59Vvalsm19jCFnHUT5lwC3+6P4e1SDC
 L663izAZEgG/hDWKb2bOIAShJjSTgN7rm6YdMHBka7QDO0g53BVEiPDnYlGEHiKAO9THRIHWEoz
 DjJtLZ0n4Xtc1r884Ng==
X-Proofpoint-GUID: c3GGvfadQipK7PxGv-QKFQW7JQDCg2uV
X-Authority-Analysis: v=2.4 cv=Ypya1IYX c=1 sm=1 tr=0 ts=6abc9ab3 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=nfWCBxzmDq_4KRmiX6sA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyMCBTYWx0ZWRfX2DkrkVxi/d+C
 msumLLYg8sbIv4oY1Lk1hisA5hHrgOshPnuJdso/0f8B1TX+/5cNRp4onQDURpqk1OjRr0NZefR
 5TNizdbs5FRO81bgh6m6+ztqQf20ssM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300020

Add bit 6 of the rmnet ingress flags to allow rmnet to process incoming
packets in the MAPv5 coalescing header format.

Co-developed-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
---
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

