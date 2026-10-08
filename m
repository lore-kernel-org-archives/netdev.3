Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346972931F5;
	Thu,  8 Oct 2026 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791421045; cv=none; b=UvmKL7h0MCL+t3Wi9Cl2Ao6d/MIG8D969oRG01A41EmYvi1Z/UIoopjUFjc3/n9TUQ/nVGTveesMzFrazuy5ijeXuDZ+WIMBFA/A9HODDMeaeKUVtDEwKIaj9wkbdXvx4sdGXmLyYp+rDdpPNJVz2/i+l4FXEpiMPqPoprCiQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791421045; c=relaxed/simple;
	bh=qdJTaDfH3BztnEtjcsHe5mUeJu5bz79Nx6u7CBjjNB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YZu97v8FX0vd8jdffdM932+CpqcB0NcUHOogGA8UJynTNahZwBuguR9iCQE0BwcxKby4X9uJotzTpJC1RPBeREJdxoCcPJSTooUrCc4f+oulu60sRvTCZ/lamhk2BHCPdDxouohb/LO3POYHkaehd7ZmIKE/RzuJiwFOnpqAZsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B3Ir5yY9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B3Ir5yY9"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697LtcWF851364;
	Thu, 8 Oct 2026 00:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QZKJ0cvKRzA
	//5i3ewOfc/Z+bAN4D5zHwLEhtF2ML8g=; b=B3Ir5yY9N7uYVFMsZSbveSxI2HX
	oY0Y5fe7UP+MgSopGQ/vo+HXCnOZQ+dpzZkO6PIZvneDJuyWGN6rGpUrfk3vT+7I
	jgwAt8W1u56GT1px4el9IyEO/i/gKPKgdTLbv9/+FCVERz7TZWRMkjb1qTpIafrn
	FTfizZBp77eyQve3kPSSQ0Txlu9L7jfXNpWbsKRtX7gTju6QgbS9t9OijxjWpLbV
	Fbplqv+Ikym7RNQIOHpwMCOc9ZKRMJgp8pWdymfh+arTTZ+6mICRXqmI6Z+awumE
	AfZf+79qrEDjtjZbufLAKUmflyiZRMyE/PoAruh6ZU9kGUM/d9ONKV7ZPSQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3gh1s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 00:56:58 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6980uvLx1477126;
	Thu, 8 Oct 2026 00:56:57 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 6980uutH1477113
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 00:56:57 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id ACEC7AD7; Wed,  7 Oct 2026 17:56:56 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next v2 4/8] net: qualcomm: rmnet: Restrict supported MAP checksum configurations
Date: Wed,  7 Oct 2026 17:55:41 -0700
Message-Id: <20261008005543.2630828-5-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=NchzRGD4 c=1 sm=1 tr=0 ts=6ac6ea5a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=x0N0Csb9lgv-IS86onMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwMyBTYWx0ZWRfXzZ5qhGgaOrJw
 yb4QDO6gu5O+U99gyiRxLrHO9yjHBdIk9b4Me0aUfWBeiJ3Y0kjiCQ7zvkTHH5A13kBQfQAuwGI
 wB+f2uxg7G0IS8VngEDfzBXbq4aev3o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwMyBTYWx0ZWRfXyLUo+kgRUwC5
 k7us8Cwb7110s77ISB916qxKnielqQSn7O/lkSW9Hi2cSdQ7PtqDa79kl7dVz0o8HBB+DUCl3jB
 6m0iPPrwBTt+oRgGoHJ8v0WTSLce11cWClYUlHatWG8NVoL0AZ4XUdxxs1oJKZ6YmINI26tbr9F
 HSzgniWGJAfhyfrvHZgYfOlwt8iEfaGMhS9yzKSOlVvijYIGskyPPtWObVqykjCDVMF/q8/gvVg
 XwbEN+BZqwDz1/x5F8PYSbB4CHtc7pNgXKJcx3W9jIfWKFE2wLRvwchf23O3e+JB81s6HkpODeI
 FUvRS/YcQj3VVP5yH0YgVRjlRZr0gJpekGbMXgIGRbpNLNQZ6Xr+QHCEbvPialM1t6O8PMDU5qv
 opZe8iNdEiFHnlWe3ziat3Twbm3zrFYNhvqOK95o+cqupgvMkw7AEm+hb1uFfIKloRAjV03Va/l
 oMb24b8loaUb1boEWFg==
X-Proofpoint-ORIG-GUID: qxBnEEvH3H0HSqRBNde85630rV1S4xxQ
X-Proofpoint-GUID: qxBnEEvH3H0HSqRBNde85630rV1S4xxQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080003

RmNet only supports three MAP data format configurations: MAPv1 (no
checksum offload), MAPv4 (v4 checksum offload) and MAPv5 (v5 checksum
offload). MAP command support is orthogonal and may be combined with any
of the three. Checksum offload versions are selected independently for
ingress and egress, but only one version may be enabled across the device.
Mixing the v4 and v5 checksum offload flags together, whether on the same
direction or across directions, is not a valid configuration. A direction
may leave checksum offload disabled.

Validate the requested data format in both rmnet_newlink() and
rmnet_changelink() and reject any combination that sets both the v4 and
v5 checksum offload flags at the same time, regardless of direction. This
is in preparation for the next patch where coalescing support needs to be
allowed with MAPv5 format only.

Co-developed-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
---
v2: 
  - Document the restrictions on invalid combinations of data format as
    reported by Sashiko
v1: https://lore.kernel.org/all/20260930051345.857443-4-subash.a.kasiviswanathan@oss.qualcomm.com/

 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index e5a6289b018a..b68f5561680f 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -26,6 +26,23 @@ static int rmnet_is_real_dev_registered(const struct net_device *real_dev)
 	return rcu_access_pointer(real_dev->rx_handler) == rmnet_rx_handler;
 }
 
+/* Only three MAP configurations are supported: MAPv1 (no checksum
+ * offload), MAPv4 (v4 checksum offload) and MAPv5 (v5 checksum
+ * offload). MAP command support is orthogonal and permitted with any
+ * of the three. Checksum offload versions are selected independently
+ * for ingress and egress, but only one version may be enabled across
+ * the device. Mixing v4 and v5 checksum flags is not supported.
+ */
+static bool rmnet_config_data_format_valid(u32 data_format)
+{
+	u32 v4_mask = RMNET_FLAGS_INGRESS_MAP_CKSUMV4 |
+		      RMNET_FLAGS_EGRESS_MAP_CKSUMV4;
+	u32 v5_mask = RMNET_FLAGS_INGRESS_MAP_CKSUMV5 |
+		      RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
+
+	return !(data_format & v4_mask) || !(data_format & v5_mask);
+}
+
 /* Needs rtnl lock */
 struct rmnet_port*
 rmnet_get_port_rtnl(const struct net_device *real_dev)
@@ -151,6 +168,12 @@ static int rmnet_newlink(struct net_device *dev,
 		data_format |= flags->flags & flags->mask;
 	}
 
+	if (!rmnet_config_data_format_valid(data_format)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "unsupported MAP checksum flag combination");
+		return -EINVAL;
+	}
+
 	ep = kzalloc_obj(*ep);
 	if (!ep)
 		return -ENOMEM;
@@ -337,6 +360,12 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 		flags = nla_data(data[IFLA_RMNET_FLAGS]);
 		data_format = old_data_format & ~flags->mask;
 		data_format |= flags->flags & flags->mask;
+
+		if (!rmnet_config_data_format_valid(data_format)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "unsupported MAP checksum flag combination");
+			return -EINVAL;
+		}
 	}
 
 	if (data[IFLA_RMNET_MUX_ID]) {
-- 
2.34.1

