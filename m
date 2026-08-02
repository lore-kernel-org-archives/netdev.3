Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59403C2D
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785710948; cv=none; b=WmOYjh0FKUwT4A5INp59NgIATCjkgSWMcYDU8UwSj762v4DMpv+06+OvE3b6lbX8hEeL7Oi7+aDOWzfPeiZYbqDrfkqHc72h1U9qxO8u9wdbZHUq/V25KVlSSbXFWE/t/u1N/L3mpIVAgPn63Xuf40OszlSyU7gON/R3LCciCrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785710948; c=relaxed/simple;
	bh=xBrzQW+7aNfExKfpenQcdxJ2Ng67UYk48IyBzKvOfdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLwgiOlCsLp4fto96JQtWcnJwTldR0nadVNayaPDAevb0/MLylqeCJ0M60UswibwIG8HzvdbQId8n5HH41IC9k7ndWiyaXkRjlVxmwnoN+UOEkzoGdlsx50cmhlwNT+z8toy7sTa1qZu8enHYucpatXKSbQEKxhLkyd6rkO0El8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WYDwfu4L; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WYDwfu4L"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LtRoF2339633;
	Sun, 2 Aug 2026 22:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=lFgW55kI8NBkjpSdY12GqWuYskt0D
	2JWY0dzo8Neg4U=; b=WYDwfu4LoWndhiFRpxhdQrjgmHwdKdxzcLuR+Slf4dxzZ
	x0Jqja6piyfRq6fN2QyoOHFdPqAEhnMBBbDgCsh+XVLrLOyc3zYYHtcAU5Aq2lXM
	aurdDhcG57ZCykyJWz9rbIjwKdQrFlITxSuHb2U4FQpoCgCf3hK/gSkBtOHS99x1
	ITlmUDXfmRUMXMCfozAtJ30QHrp7Om4VfJ9aHKRRAFMd1G4d2G1qTv104pxvc+vo
	mdIoNkgfg9v7GKxRAs7ymVo+Dm0n3I1UMrf8OlmEO/hM5q6mxHGsKf6izSQKtFwH
	9MlYHCBc2qldsjGjBsBA2jCkSnh55mgpE79FEqbFQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs8ugat53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Aug 2026 22:48:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 672Mj3vV040203;
	Sun, 2 Aug 2026 22:48:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78a1q7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Aug 2026 22:48:46 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 672MmkXI005444;
	Sun, 2 Aug 2026 22:48:46 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4fs78a1q7p-1;
	Sun, 02 Aug 2026 22:48:46 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        denis.pilipchuk@oracle.com, joe.jin@oracle.com
Subject: [PATCH 1/1] net: tap: set skb->dev before parsing virtio net header in tap_get_user_xdp()
Date: Sun,  2 Aug 2026 15:46:12 -0700
Message-ID: <20260802224612.264563-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608020210
X-Proofpoint-ORIG-GUID: 2vSFbHLr3oSNFkbFc-I-TmnDQHNXHaON
X-Authority-Analysis: v=2.4 cv=XqnK/1F9 c=1 sm=1 tr=0 ts=6a6fc950 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=qR_b30O-rng5yiWcDyYA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDIxMSBTYWx0ZWRfX9IawLD5qvKkl
 CzSSLjgJvke/a043XhqHO4VusT0AaDne578TYFx0/rYuYjOKmDpWPVKDETDxpazX/99XiHc4n3a
 +E3wP/F8CCUjYM5e/L1fy4LWxWyh5EKqFYb9blyXn67DBWIzAWJE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDIxMSBTYWx0ZWRfX2TwYJHt+48Kk
 ETHpHn6hs9YA52IhTWkeLw9l4tx/Xfvq68t/sxgVF9K2loX81nD5cZqoKN3OkkCFjAfmJXHMib7
 hieVm72TtSZZpGSqBtblV8PpYyWIFu7rgYJhz9dtg9lEPc+dfZuE8EP6BwKlXonoq2ziGjgFma3
 Kh4SiGJ27n0ESYxjWY6L0t5qJulcFHJ4+6L/WMda4gJKWCSo5FiAZrckUSXwNEWmgKdxz0CQ3C/
 v9kTf1KgfztvsFznMVzb4CjfekLKZ6cQY9q6UGbWIyhvMumNmbEee6xS5FgsK03dhzXf7omrBv9
 vQ22eAxHMPmtlEpzeIScdVHsB1LBOfs3bvMWZs7yByVJWxJkfJq2/h07915OK55WnIKYVhu3a/X
 qInRiG95yAiy2HaEOl9Jz2gF2UUb5AhTJzp1Db4uel0NhLP6nsEEIFNCyBlNkNxe1I43cmiT/PT
 NHX/39UdnpWZ33xgjqw==
X-Proofpoint-GUID: 2vSFbHLr3oSNFkbFc-I-TmnDQHNXHaON

The commit 4f61f133f354 ("net: tap: NULL pointer derefence in
dev_parse_header_protocol when skb->dev is null") fixed a crash in
tap_get_user() by assigning skb->dev before calling tun_vnet_hdr_to_skb().
This is required because virtio_net_hdr_to_skb() may invoke
dev_parse_header_protocol(), which dereferences skb->dev. Without the
assignment, a NULL pointer dereference can occur.

However, tap_get_user_xdp() still parses the virtio-net header before
assigning skb->dev. When the vhost TX path passes an XDP buffer containing
a GSO virtio-net header but the protocol is set to zero on purpose,
tun_vnet_hdr_to_skb() can reach dev_parse_header_protocol() while skb->dev
is still NULL, resulting in a crash.

Fix this by looking up the tap device and assigning skb->dev before calling
tun_vnet_hdr_to_skb(), matching the ordering already used in
tap_get_user(). Preserve the existing RCU read-side critical section across
dev_queue_xmit().

Fixes: 924a9bc362a5 ("net: check if protocol extracted by virtio_net_hdr_set_proto is correct")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5.5
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/net/tap.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index fae115915c8e..5d2d34d24ce8 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1074,10 +1074,21 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	skb_reset_mac_header(skb);
 	skb->protocol = eth_hdr(skb)->h_proto;
 
+	rcu_read_lock();
+	tap = rcu_dereference(q->tap);
+	if (!tap) {
+		kfree_skb(skb);
+		rcu_read_unlock();
+		return 0;
+	}
+	skb->dev = tap->dev;
+
 	if (vnet_hdr_len) {
 		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
-		if (err)
+		if (err) {
+			rcu_read_unlock();
 			goto err_kfree;
+		}
 	}
 
 	/* Move network header to the right position for VLAN tagged packets */
@@ -1085,15 +1096,8 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
 
-	rcu_read_lock();
-	tap = rcu_dereference(q->tap);
-	if (tap) {
-		skb->dev = tap->dev;
-		skb_probe_transport_header(skb);
-		dev_queue_xmit(skb);
-	} else {
-		kfree_skb(skb);
-	}
+	skb_probe_transport_header(skb);
+	dev_queue_xmit(skb);
 	rcu_read_unlock();
 
 	return 0;
-- 
2.43.5

