Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C832453A26;
	Fri,  9 Oct 2026 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535472; cv=none; b=j6Nw5DfEhQm96y60XJDNWlPm0Hm7h1hXvLkHLF7ZikLS0wfCarvxrF5OAxLosz7YFEtl2V+/uKlr0tYI+NBSblMNKnr6Y0E8NJt1fKOyyoR/rN6Ihp3DXQVR4/yAS7zdDxSHY/okfqhBZynG2N3WpobVkZaYF8OLeSpR9yhKeNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535472; c=relaxed/simple;
	bh=ngLPajDsEjNV33XGiU3Ob88ld6UEqWp6oIqh5rPp95E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aW3/SkwNoOC6eSA0V5CJk1jPHaLOl8aY9p+fxXhWlpHbvoauSnbv47MUwxX8SaRuNAq4l8ucPzVsnKwX+X+eB+SXIpGjpJOINiSsUvOIGw92ZBgj+NVKzz3Re0X2H+H9kE/z48hDhKBcOvIPBs80Cw7+Crx5UNoRj+NMyg5Ppo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GzyO7qa0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GzyO7qa0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KMFj1223197;
	Fri, 9 Oct 2026 08:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eWZARviAGM7
	+Rh35o1w4Yf6ghjjC7mcwymdE/PPsPfY=; b=GzyO7qa0hFyAfniEvlxPjbynxi5
	RGKwGr2Cjzs11EOzpm6B/ujisPq3+091bgQbSMZMIfSWthiya0qWVJ9NrTo8tjuQ
	A7YZapC3+uCLxD26nMn3b/B6MM4at7EDZH2Q4yEKLhaZAmg5Y4kEOTfLVWwLfGtp
	9AXH7Et3zS/iaBeaAvQs37JUzVI/mGDX/Xxf41v89w+tX1ZQtENV3prVXO7mGbQg
	VEOWfYkRFGxOzXdwqBg2eoMuBq2vKMQSEP8exMfqQs2N+Ggu1CdLDn+arWmOZov7
	/vB9Q1v9stzGQBByq8aBGRpdqnYUHP+Mo3LNKUiKLMHVhHCMkHvat3lF7rg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxkan7w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:44:12 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998iBDt317188;
	Fri, 9 Oct 2026 08:44:11 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 6998iAE1317172
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:44:11 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id A4B52ACA; Fri,  9 Oct 2026 01:44:10 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next v3 4/8] net: qualcomm: rmnet: Restrict supported MAP checksum configurations
Date: Fri,  9 Oct 2026 01:43:47 -0700
Message-Id: <20261009084351.317632-5-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Proofpoint-GUID: r1RCCfCM3Lt5Ccp2-7qocAD91O28zh1v
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNCBTYWx0ZWRfX88NPXICYBMfm
 aTa+1lqMIgFq8a1ECfNyzlD5RoLgGF2AILmgAA+B2T4mkkJPYVfWy1AK7ff7YO1nBSdcAj0IdNx
 f9pTzDgxrOMtHLDDaF1flJJ40IKokl0=
X-Authority-Analysis: v=2.4 cv=Cs0q4X4D c=1 sm=1 tr=0 ts=6ac8a95d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=x0N0Csb9lgv-IS86onMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNCBTYWx0ZWRfXywb5SMTbs3Bv
 EwiwFE5gq4jjtGQSJHrSF8sFFWrpwmNScaXz3t39uTRRuKq2TNbv0NmX2liG0ibgqNK+Spg+kBz
 yzCvtwTTG9EXSL1iCilzJqRlVjp1lV1Rr+rMfpBiKpfBtf81RuKBbqZzvkkXKhBepxHiT6oxssG
 T1PwnpW7oecWJ5+tW11D16oK0OHeaMDJh7QptwK6/Exjj6FMpKTa4h7v9IX2QEkA9YHBxYNnmse
 fWI8bhOVgXJ8IEAWhovenauv2jGdSkGxPuAjFHSpFsiNkTlWL7RzCuzdzVBMlxnRpVXQMNiTPa8
 mVMvIaiiqHtBq3ep368AYPAFWhJts0uoLOYp7uy2aOzgztckA5BYuSSiJqv/2G44/Po0UeHMTst
 iAH5FWXZ8ree3grc5Q77VIUiz888ENXeWiV24k25x9fxQjk5LIFoFF74tsOIS+Qj8ef2ST6KU9c
 jV92BmrwYTh77BQKriA==
X-Proofpoint-ORIG-GUID: r1RCCfCM3Lt5Ccp2-7qocAD91O28zh1v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090034

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
v3: no change
v2: https://lore.kernel.org/all/20261008005543.2630828-5-subash.a.kasiviswanathan@oss.qualcomm.com/
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

