Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2429411665
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493086; cv=none; b=UBoUDyfbhOjtZNk5QRn5N6qL1eEN6hFOizsBiaSudgunPWMXDzsoXJ2eSMUqD2C2rrSyVHOkY8VQQJGYHMwmaCMTYiPToib0yirY7HINPbV0B3wWtnS3/otUu3ILdAwsWv7zPUkq+rlE9ZfSdtJGKLJZTCGTdVpnmJRvuqrIYlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493086; c=relaxed/simple;
	bh=ybYHIS4cjFq4LtC6Vy6PclNk4f3cZuimPCgq2cEDGHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oeQEKks0ZnMDJTN7XBc99Lv/uAbMekgoUdVxUBdVM4AY7gA1g+gk+epfCh6NjKBhx/UvyvYBjZ9hKAzlYwXsRjiG0XeQ6b3kEd1dpi7WzSzFc/RUANAJqkrOUiMlcdsTRJ9Lmx+soeip41WB4Ihr1NmJgkQbG3TU1IrfXhFOpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dt4anAV6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QhnC6vfL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dt4anAV6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QhnC6vfL"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VAC4AF3891572
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 10:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iAH3sZ91fK8b0NmKHL6MMO
	FShPzmakonlLH1pQrjDv0=; b=Dt4anAV6RYW2kb9fTQ4x3v4xT1L/h8toU5wOjv
	vDJg6J/YwvNIcxbrTJOjbybPuhRVNp7eVLP3f+LiZeYTZ48Ap6GeKOIOLWwSEyTR
	aOpvu9jK7Bxv/KozfV9qSPMaZLAMT1V6kNPsIe3iygLG/x+lJW7Y6WKFLpjQKfk1
	stDZF1vOevEWBlTtEmf3N+3eUg9jnKTNi7Qkf+WYfP8HZltCSGZTWpo2URpVUcQf
	S/HnKKRZE1Cn5ZuCekK/QPPvk0aqyHzsnAwqWaXdnKHqmVv3G19oiWywLDiaJDEq
	Aw4beYFTP8FM4ruX0Px54QM6S9mgGxJTaX7OpTT9a9J4Hduw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frsm381r0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 10:17:52 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbb92868263so1082543a12.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785493072; x=1786097872; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iAH3sZ91fK8b0NmKHL6MMOFShPzmakonlLH1pQrjDv0=;
        b=QhnC6vfLldrz/AzEtp6tgLJOjYYLgpP7Pq2HViEeaeMJyFZid1J98ItsJfC5fV7Jty
         5JYlivydcyCd/BoEEZYxbTNb1ZLxb7Bf/+LY8nZ9cvqdX1v08mqs+Jw7QGO/jnKKBy63
         xI705c1uPUWGLEDHp8leVcbj41wM+c4Y1QRjYUTbeurfmWHUzk4NoeZHCW1F9PUcDj2c
         JQkq0Cphdv5f6YD3luDMK0CTHoRLGDMTxCw4UJRaDHsScavcOC8s4G24kpl6dRHpzD3c
         UkR3MbgQlS0Jg60ljaMI3EW2wI/xywD3ucv7NbwjImb8chg18aQiPK2OQVOSXDVJc1CW
         SrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785493072; x=1786097872;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iAH3sZ91fK8b0NmKHL6MMOFShPzmakonlLH1pQrjDv0=;
        b=Hdmh8uhWXwqv3MR4BoinYBwPedWnygnHpPx9jOj6JPo48GhfGU2E6Cmc6hbASwHoJ/
         Jwr+bLwuL+FD/s2e7GI4GThS0+3pstWCd5J+AEkUXc6qg/ChbOKPs5CWGwtyFp+gl30I
         bHu92JuJ8PttMq1Lr4pIz6Akm2iK8NVQTojm1qWzuPa8UCbf5NGeTS0lxYOLs7LFRqmC
         2gsK5mftQo/4tNC/ZosIP9vnACigsnzdUJLhGOD081kCwxsl9slQ9vZN8T6VvbYGLGtM
         qZBw3SSiBx1vN0WWCVskTTgLqnDmkNd1LAdessDFj0TtwmxH4GU5EHxKTgLp2Mok7h+6
         6zuQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrj186EKvkU8GxOiccp3KEPJyxYwQyPOIWU5SfYrcoAt+bv1r6Vpc5DFLE7UlUYvZdbsOptvng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq3ylveASZuctAovb04T7OKQfcPn5eKghZHMPAzTdVTYxxqyo5
	xTh8Rvg8G+7HMVj3b1Y67qzY/7V198ps+Y1XAOS+9MWpPs44IiO0F/P85tDyBFMVe7R4KdlbZls
	8WcmTdQFYPrKFnzvwEXfEO+AbkUQfagb35sDhIYD2BWjm5edyTVz514DShUQ=
X-Gm-Gg: AR+sD122bnRAhBaxU4Pqh7uWMnBMMj5jy40GxPEb/9E1cRqIGUVfwbo2Naykr89EEry
	sh38PTzVdPsGGyqdh1NpIRXvnxacrWObVyc/Wc01kURQvlyTkxcY4IYuRMgIddUA4WznTxe2zLZ
	hWGO9kEgTX5VRZ6TvpSYmFw5boAFyXU0NRIJ7pqBFqFAXqVEO/tZ8n2oUnSOtShQMDoSFba8gYS
	lOhRp+9eyDxgpJPsCBnnxCiNFaFOzsYecUzvyKXmgwRdWBPJ2BjFSYAhK7mODU9pkNnW6iingo9
	Y5vWP9NISF7ipoCV1Pu7djmhHZZMoeRHf5CU4SsBKp7K57oCCzWap3BZZMnNff1v/8Wn5eIT8lz
	Lxu1Nb/nOR/eczU7KJPGUTk6cFny5oFKM0mLbfxs=
X-Received: by 2002:a05:6a20:6a09:b0:3c3:9c4e:de3a with SMTP id adf61e73a8af0-3c91b1766a7mr1408149637.6.1785493071933;
        Fri, 31 Jul 2026 03:17:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a09:b0:3c3:9c4e:de3a with SMTP id adf61e73a8af0-3c91b1766a7mr1408123637.6.1785493071380;
        Fri, 31 Jul 2026 03:17:51 -0700 (PDT)
Received: from hu-pphansal-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e5c7sm4995510eec.5.2026.07.31.03.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:17:50 -0700 (PDT)
From: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 15:47:29 +0530
Subject: [PATCH] net: qrtr: Send HELLO message on endpoint register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-qrtr-hello-on-ep-register-v1-1-ddee5b1bfaec@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADh2bGoC/43OwQ6CMAwG4FchO1vTTdiYJ9/DeHCjwBJguinRG
 N7dod406qXJ37Rfe2ORgqPI1tmNBRpddH5IgS8yZtv90BC4KmUmUEiUYgXHcArQUtd58APQAQI
 1Lp4ogEKZGymtrRSytH8IVLvLw97uUm7TmA/Xx6mRz92nqpB/UUcOHHKtbU6IpajMxse4PJ73n
 fV9v0xlvvWC5C/IFIWqjUaz0vodmr8cxd+fiQSWdWUK4sgLRR/AaZruD9sYrmMBAAA=
X-Change-ID: 20260623-qrtr-hello-on-ep-register-7064b66ccd70
To: Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        chris.lew@oss.qualcomm.com,
        Chris Lew <christopher.lew@oss.qualcomm.com>,
        Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785493066; l=6716;
 i=pranav.phansalkar@oss.qualcomm.com; s=20260220; h=from:subject:message-id;
 bh=Y17PNvywPvnbZk2873JdfNQ4mOW1yvoMWYX7gguOvWw=;
 b=wSMZlVNXwH1LGlHXyIRM/v0bA7PeLb4rENs5E+NU6olHBZKnobDPv2yQe1ERU5LcHoITnXZT2
 r9WvB+1y9vDCyQRKod3sdsf3D7JcAtzAl+egc5Ww72FT2kJiwZrVznD
X-Developer-Key: i=pranav.phansalkar@oss.qualcomm.com; a=ed25519;
 pk=MI1mUPTtmeY/WO9GsLnjtoVy4wYL57rtVnRammLT8B8=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3NyBTYWx0ZWRfX7A4VbnmvezQq
 MpcJuhfNVxuUnwGA4gH1EzJG+proCmiXTc+OpVCk/aqZxZcGAojSjAPtROaF0NI3BVpiiTbkPE8
 YT3uACL/BDU6Qv/jjB3MV3CDLrQbDtw=
X-Authority-Analysis: v=2.4 cv=cpCrVV4i c=1 sm=1 tr=0 ts=6a6c7650 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=20KFwNOVAAAA:8 a=QGBKHiwWK076ZCfLL7cA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-ORIG-GUID: iRQ3SYXTE5-TlVl8TnyT8RX4pHmnjQGL
X-Proofpoint-GUID: iRQ3SYXTE5-TlVl8TnyT8RX4pHmnjQGL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3NyBTYWx0ZWRfX8GPRcV0Bo7Qw
 MXiyTVM6QSg9x7TxxD8tQ6ldttx5M45qSmWZLC68tIiYh8Oe5ofvLRDTte7czzFzdj1rKnIJKYX
 licAx6ymlI2RPcpZxDVwsKbIiKH/jFbjOc/BJoRZ3gmu01z/rIW0K+zXEMnm22TLBce4KIO7nkf
 y7lJaW/Oj/wtrOxAU9Nn7IfcoTUjLhJ61aRI3Ko1J+SXo3xOmSXiCyHpbbGFJ7YZKl69MGwVd5+
 mC4tJgzghtDtRxjCtZIshGWwvb429HJE4vi/3+QRjgdZigRU7m00QkjdB9hi6GKHiCN9fmGQy0A
 /uQ3wE2bOv+s0tFZs0PAqd9sj4oK1QB2N1oiuYUZNcdBaesiYrjrChLcsXDkpBam21nFsFOcJmO
 0LvildSYxxLIs1vVdplLj8Ws5fOlj/M4BeTd4Z3J23WqlNgWdfDE4ZHV3fJ9pIJKdgRv58hGw0f
 Z20HlXNTnIbE3+dwyjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1011 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310077

From: Chris Lew <christopher.lew@oss.qualcomm.com>

Hello message is currently sent only by the name server in response to
a hello message received from a remote. When two endpoints operate in a
slave model, neither sends the initial hello, stalling further
communication.

Transfer ownership of the HELLO handshake to the core layer. On
endpoint registration, schedule a work item that sends a HELLO packet
to the new endpoint once the name server is bound. An atomic hello_sent
flag prevents the name server from sending duplicate HELLOs once the
core has successfully sent one. If the initial send fails, the work is
rescheduled to retry.

Prevent duplicate HELLO packets from reaching the name server by
tracking received HELLOs with a hello_rcvd flag. Without this, each
duplicate HELLO would trigger announce_servers() in the NS, causing
unnecessary re-advertisement of all locally registered services to the
remote and redundant lookup notifications to observing clients.

Co-developed-by: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
Signed-off-by: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Chris Lew <christopher.lew@oss.qualcomm.com>
---
To: Manivannan Sadhasivam <mani@kernel.org>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 net/qrtr/af_qrtr.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index d02ef9a74c3ca..03234bd1fe54f 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -9,6 +9,7 @@
 #include <linux/termios.h>	/* For TIOCINQ/OUTQ */
 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
 
 #include <net/sock.h>
 
@@ -120,8 +121,11 @@ static DEFINE_XARRAY_ALLOC(qrtr_ports);
  * @nid: node id
  * @qrtr_tx_flow: xarray of qrtr_tx_flow, keyed by node << 32 | port
  * @qrtr_tx_lock: lock for qrtr_tx_flow inserts
+ * @hello_sent: hello packet sent to endpoint
+ * @hello_rcvd: hello packet received from endpoint
  * @rx_queue: receive queue
  * @item: list item for broadcast list
+ * @say_hello: scheduled work for initiating hello
  */
 struct qrtr_node {
 	struct mutex ep_lock;
@@ -132,8 +136,12 @@ struct qrtr_node {
 	struct xarray qrtr_tx_flow;
 	struct mutex qrtr_tx_lock; /* for qrtr_tx_flow */
 
+	atomic_t hello_sent;
+	atomic_t hello_rcvd;
+
 	struct sk_buff_head rx_queue;
 	struct list_head item;
+	struct work_struct say_hello;
 };
 
 /**
@@ -187,6 +195,8 @@ static void __qrtr_node_release(struct kref *kref)
 	list_del(&node->item);
 	mutex_unlock(&qrtr_node_lock);
 
+	cancel_work_sync(&node->say_hello);
+
 	skb_queue_purge(&node->rx_queue);
 
 	/* Free tx flow counters */
@@ -341,6 +351,12 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 	size_t len = skb->len;
 	int rc, confirm_rx;
 
+	if (type == QRTR_TYPE_HELLO &&
+	    atomic_cmpxchg(&node->hello_sent, 0, 1) != 0) {
+		kfree_skb(skb);
+		return 0;
+	}
+
 	confirm_rx = qrtr_tx_wait(node, to->sq_node, to->sq_port, type);
 	if (confirm_rx < 0) {
 		kfree_skb(skb);
@@ -379,6 +395,11 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 	if (rc && confirm_rx)
 		qrtr_tx_flow_failed(node, to->sq_node, to->sq_port);
 
+	if (rc && type == QRTR_TYPE_HELLO) {
+		atomic_set(&node->hello_sent, 0);
+		schedule_work(&node->say_hello);
+	}
+
 	return rc;
 }
 
@@ -527,6 +548,13 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 		if (!ipc)
 			goto err;
 
+		if (cb->type == QRTR_TYPE_HELLO &&
+		    atomic_cmpxchg(&node->hello_rcvd, 0, 1) != 0) {
+			qrtr_port_put(ipc);
+			kfree_skb(skb);
+			return 0;
+		}
+
 		if (sock_queue_rcv_skb(&ipc->sk, skb)) {
 			qrtr_port_put(ipc);
 			goto err;
@@ -570,6 +598,35 @@ static struct sk_buff *qrtr_alloc_ctrl_packet(struct qrtr_ctrl_pkt **pkt,
 	return skb;
 }
 
+static void qrtr_hello_work(struct work_struct *work)
+{
+	struct sockaddr_qrtr from = {AF_QIPCRTR, 0, QRTR_PORT_CTRL};
+	struct sockaddr_qrtr to = {AF_QIPCRTR, 0, QRTR_PORT_CTRL};
+	struct qrtr_ctrl_pkt *pkt;
+	struct qrtr_node *node;
+	struct qrtr_sock *ctrl;
+	struct sk_buff *skb;
+
+	node = container_of(work, struct qrtr_node, say_hello);
+
+	/* NS must be bound before we can send */
+	ctrl = qrtr_port_lookup(QRTR_PORT_CTRL);
+	if (!ctrl)
+		return;
+
+	skb = qrtr_alloc_ctrl_packet(&pkt, GFP_KERNEL);
+	if (!skb) {
+		qrtr_port_put(ctrl);
+		return;
+	}
+
+	pkt->cmd = cpu_to_le32(QRTR_TYPE_HELLO);
+	from.sq_node = qrtr_local_nid;
+	to.sq_node = node->nid;
+	qrtr_node_enqueue(node, skb, QRTR_TYPE_HELLO, &from, &to);
+	qrtr_port_put(ctrl);
+}
+
 /**
  * qrtr_endpoint_register() - register a new endpoint
  * @ep: endpoint to register
@@ -595,6 +652,10 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 	node->nid = QRTR_EP_NID_AUTO;
 	node->ep = ep;
 
+	atomic_set(&node->hello_sent, 0);
+	atomic_set(&node->hello_rcvd, 0);
+	INIT_WORK(&node->say_hello, qrtr_hello_work);
+
 	xa_init(&node->qrtr_tx_flow);
 	mutex_init(&node->qrtr_tx_lock);
 
@@ -605,6 +666,9 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 	mutex_unlock(&qrtr_node_lock);
 	ep->node = node;
 
+	/* Initiate HELLO handshake from the core layer */
+	schedule_work(&node->say_hello);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qrtr_endpoint_register);
@@ -796,8 +860,21 @@ static int __qrtr_bind(struct socket *sock,
 	sock_reset_flag(sk, SOCK_ZAPPED);
 
 	/* Notify all open ports about the new controller */
-	if (port == QRTR_PORT_CTRL)
+	if (port == QRTR_PORT_CTRL) {
+		struct qrtr_node *node;
+
+		/* Reset HELLO state on all nodes so the handshake can be
+		 * re-established with the new NS instance.
+		 */
+		mutex_lock(&qrtr_node_lock);
+		list_for_each_entry(node, &qrtr_all_nodes, item) {
+			atomic_set(&node->hello_sent, 0);
+			atomic_set(&node->hello_rcvd, 0);
+		}
+		mutex_unlock(&qrtr_node_lock);
+
 		qrtr_reset_ports();
+	}
 
 	return 0;
 }

---
base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
change-id: 20260623-qrtr-hello-on-ep-register-7064b66ccd70

Best regards,
-- 
Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>

