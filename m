Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBC64E06C0
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408397; cv=none; b=F8qBENFVhrNjJ0ye9IWiXJgfm9pDH5rYSfmWBjNS+vy5wUjQpDesNPS3b9Ru2Rn6ZXv83yqFAF7MXs2nCoU7ORUujv2lJCb+uqqRwEUxKABMARIQyQtSdTVJsBHhFAzTttBuhOTSZ/PLuAZ/yWIrs6qjY6i4dT+tEveAcp2w75I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408397; c=relaxed/simple;
	bh=1jQtpsEtEICvGh3Yep3pp+FRxYcqaumWZOyoe+5ANU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n+7PQqnvMp57efbD+2hn2UU5NMnnHvSImwUS6hqNIDL46bHX79DJ1y0TiuJVL4NC+ilvrR6t4a9zYeKjB12lQmdmxegGlE/DUzppXmnQgNuGxGJ2xJyq2IeMw0rGlEZux1RgwK8UC6bZwJ4ZIHHjpqgRCn8pUX2RbY954W/1Bwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=psGNBQOi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NyeKzh0P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="psGNBQOi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NyeKzh0P"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8P2qj3306573
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XEF29vIt9xM5QLqU/ed4ueS67ZZlqFfU3QmCvBMWkR8=; b=psGNBQOiz7j3hZGx
	ThTcwT/zUy3cVY95owrtwxVin7BVxTAxCBLux1nJNN0mG0Fsoi52TeyS5vf0ypnR
	a+Ks3kvLKIC4K5c62BmDLZLnJZeDfivle9dpdkOXkejkX0HspE/k67nGZEt0OFoP
	lJu2BXxhMl4q7kNXoxhMzuLKLPilkCeaPxUAlh7k8vJmVfm1Gq5gkrwE7Pd4NlwS
	PaajMHQ752p8w8Lj7BmTXG+sZQsM6EDKm76ulOYzFksJMFuKYp2MzGIsZ+OTJ/L3
	K0HtrzXYEKghOYUwoAn0mRkGL/hSr9sf1dma+9bmA92r7NyuM47kfxubgf9AbsxD
	yM7UIw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47gs7r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:13:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93caf7856ffso530463185a.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 04:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792408392; x=1793013192; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XEF29vIt9xM5QLqU/ed4ueS67ZZlqFfU3QmCvBMWkR8=;
        b=NyeKzh0PzbTA7FHFo70vhgueVMp+6a2z6niEQRQ5jfqX56s+q0ygZ/EjcI2mG1Fta4
         2ozlixZ7RPQ9pwvAYAKGjf+U8mK4KFvVxzqBdp1lgvVjO5nCbQqpIVBfySp5iXWgndRT
         RVF7z8nvuzanQMMcfXrdCpv8G28AFTqlJJZsYq/TcGSPqNETgLSYE9S40OT8WbyHS6pF
         wKSiwSyBILyWS4TN0sEn/SvcjWFsM3W7t9rpygMdixY0GD8HsP+WElX7Cpevhef/oDKZ
         N/Ifa+5+TmYtReAcOiXXKxKVes/JQwNYWgVcXoM4P4pfglCiw6iacuGrLnDqC48UqvBB
         twkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792408392; x=1793013192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XEF29vIt9xM5QLqU/ed4ueS67ZZlqFfU3QmCvBMWkR8=;
        b=y99wWVMwb59w3EvTQA5RQQTUt25Skc8OikAeQbsj7vN/OX6qoI668hRS33sUOq+zyg
         ZOVi4NKGbJkBLi0Xta+WRGg4+3ZpzmSnIZHjKaIJq0V2zgNioByuVMPFw9b0WsX39xPA
         LWYROurr2qqnodt9U/cVaPpnbERWEsKL4JOQ7i8tLy/437FJblL1Vk8OC4EiW2BuNSIO
         v3GV5yaVNcMmtWU4p3np4jin3n0sTYUFdrpBVUhJtDKio6G3AUXoo1hP9DfHWN7y1o4e
         1T9LfTl0JcxnP6+NB77EJ1CQ5KE5t1c4WEqVOoQ0R830VQ0UmSMb1NUWTQ1LYJBkwR8r
         jcTQ==
X-Forwarded-Encrypted: i=1; AKwUvByaWkxLjRR92l+5rmu7d7VEdfN1GayWa8krPu0+WRtGSHNc+oucjgGft9tsEynfsh9PzqcWOaw=@vger.kernel.org
X-Gm-Message-State: AFq9FYITGInSKgp4IUNDG6SndhWhtcRiLEOXkct4wSYf2KD3OZCOJlqf
	ga+YcVHapseWafc4nllPdG1VisGr4YPdwoHadx4twbbRWxoEU04cozbD6ED2VahHsLGUb1duWsS
	Xjqxg+pkhXaxK+wEuEPcUitDgrWkxnKmdmE0/FVnU3QPkcD7MgzQ4UNBmocXxojZexBA=
X-Gm-Gg: AYBFou3DSOFnEqWN2GSr16QxOzd+969FHgiW3B6FH+h4N8P3VL8EBbGBFAQBRvdtz77
	jd3SVQ0yrmZnQjo6GgZdRHmME3sx6Em2ksnro0fORdJGfMfG49+Vb50mCIChDVdrXxDXEt0mHGD
	/bZf63q3ixwyG2Jv1rCx91euLFe9md5tAuZOXlDml3sU1z0pRrDVeXBWyZwxVY0mbbSk4sMrHak
	X7kdP7aYBDxjxwVJhpHGBKZztuoTnnPUxnVMNBxq0xmPbrr+y8UEHKJfRkmpYHvTYgrpeISJt1m
	MPB3oCwzYfQsBvSRGHbTykk7fqlMOLPatdRVI+RhgWaMd2KwRuWt9sBLzAxI4QAmzTfj2jqRO5+
	AKT7NixHWzK1AkQ1d5pcKP5LsxsIXwcGYL8Ct55+Z7Dsi
X-Received: by 2002:a05:620a:4402:b0:93e:c12c:f11e with SMTP id af79cd13be357-93f29d83580mr1246146685a.74.1792408392317;
        Mon, 19 Oct 2026 04:13:12 -0700 (PDT)
X-Received: by 2002:a05:620a:4402:b0:93e:c12c:f11e with SMTP id af79cd13be357-93f29d83580mr1246143285a.74.1792408391850;
        Mon, 19 Oct 2026 04:13:11 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4256c790adsm211472266b.31.2026.10.19.04.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:13:11 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 13:12:02 +0200
Subject: [PATCH 2/2] net: qrtr: hold control packets behind the HELLO gate
 instead of dropping them
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-upstream-qrtr-hello-gate-fix_b4-v1-2-bd420aec171b@oss.qualcomm.com>
References: <20261019-upstream-qrtr-hello-gate-fix_b4-v1-0-bd420aec171b@oss.qualcomm.com>
In-Reply-To: <20261019-upstream-qrtr-hello-gate-fix_b4-v1-0-bd420aec171b@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>,
        Chris Lew <christopher.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: tg7YdtzNebwCs0tdDFYYEyea83qgZEx7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NCBTYWx0ZWRfXw9SCNpRIDhsx
 QUFrWKAIjTXCFXZRmH+zue/LC3oTT910HylV6Pb4gQwISdK/IXRSaKGFa8XxgDQr+vx1mRoVpsa
 iqE/fir2B6n2BFQu5rCg9vyvdDMNfWliHJFSml5SENRokuG/wMx7rUAl/P+zY4P/Zcd9Ax1jF79
 pXQn4bX27QTXkgvWhqRYi9LBZEdI2pBWgGzLfYnN6YLGNxtm7TqYH20eHMgxLq2rmx+DLMSUizs
 0bFtmkbLmpe3NpQUdO52HRCCR0LtieiNyhko4RWl7enEl5qeE8wQ/FGEWTmgyrhOn2dMe/VOouG
 e0o2D7BAqO7zt/6nLMFuWVxsqEHjEZkYZCezqimHtCcbah4et7W8GLyTAjwPg8sJtuFnRTAJNr1
 kPSQsovWE0R4Yug/XbnEdttlP9G96ChaxmWXvThkMP+r4C3sYErUMP1RSCygKWHW4A2EEB8BzxA
 qCbW7Uo4zikyZOp1amA==
X-Proofpoint-GUID: tg7YdtzNebwCs0tdDFYYEyea83qgZEx7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NCBTYWx0ZWRfX6yC/a848kGGX
 VZ7NvCe60/QMYkpt+lWnglft6vpAiLNxw+cyo/nJy0QLhouvcOwzkH5oNxttpLoeIPa1RjOTAmd
 Cs5h2OMNlGAY3dqCvDMZ24H588QaCyg=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad5fb49 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=o-VfIjT1-S5dX-TKpQEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190044

Since commit 544d85de4dc2 ("net: qrtr: Send HELLO message on endpoint
register") qrtr_node_enqueue() refuses every non-HELLO packet to a node
with -EAGAIN until the HELLO to that node has been sent, and a HELLO
that cannot be sent yet is retried 100 ms later. The name server does
not retry, so whatever it sends in that window is lost: the replies to
the remote's HELLO (announce_servers()) and the NEW_SERVER broadcasts of
local servers registering at the same time.

A freshly booted remoteproc hits this every time: its glink channel has
no rx intent yet, so our HELLO fails once. On the QCM2290 (Arduino UNO Q)
rmtfs and tqftpserv register in the same instant as the modem starts;
when the RMTFS announcement falls into the window the modem waits for a
service that exists until its watchdog fires 40 s later ("DOG detects
stalled initialization"), about one boot in five, and WiFi (whose
firmware runs on the modem) comes up a minute late.

Keep refusing data packets (they would count against the flow control
window), but queue control packets for a node whose HELLO is not out
yet, bounded to 64, and send them in order right after the HELLO
succeeds. Purge the queue when the endpoint goes away.

Fixes: 544d85de4dc2 ("net: qrtr: Send HELLO message on endpoint register")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 net/qrtr/af_qrtr.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index e7b3647424b8..071fa980fae2 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -122,6 +122,7 @@ static DEFINE_XARRAY_ALLOC(qrtr_ports);
  * @qrtr_tx_flow: xarray of qrtr_tx_flow, keyed by node << 32 | port
  * @qrtr_tx_lock: lock for qrtr_tx_flow inserts
  * @hello_sent: hello packet send successful
+ * @tx_backlog: control packets waiting for the hello to be sent
  * @rx_queue: receive queue
  * @item: list item for broadcast list
  * @say_hello: delayed work for sending hello packet
@@ -136,6 +137,7 @@ struct qrtr_node {
 	struct mutex qrtr_tx_lock; /* for qrtr_tx_flow */
 
 	bool hello_sent;
+	struct sk_buff_head tx_backlog;
 
 	struct sk_buff_head rx_queue;
 	struct list_head item;
@@ -195,6 +197,7 @@ static void __qrtr_node_release(struct kref *kref)
 
 	cancel_delayed_work_sync(&node->say_hello);
 
+	skb_queue_purge(&node->tx_backlog);
 	skb_queue_purge(&node->rx_queue);
 
 	/* Free tx flow counters */
@@ -340,6 +343,26 @@ static void qrtr_tx_flow_failed(struct qrtr_node *node, int dest_node,
 	}
 }
 
+/*
+ * Control packets for a node whose HELLO has not gone out yet are held back
+ * and sent right after it; this bounds how many.
+ */
+#define QRTR_TX_BACKLOG_MAX	64
+
+/* Send the control packets held back until the HELLO, in order. */
+static void qrtr_node_flush_backlog(struct qrtr_node *node)
+{
+	struct sk_buff *skb;
+
+	lockdep_assert_held(&node->ep_lock);
+
+	while ((skb = skb_dequeue(&node->tx_backlog))) {
+		if (node->ep->xmit(node->ep, skb))
+			pr_warn_ratelimited("qrtr: held control packet to node %u lost\n",
+					    node->nid);
+	}
+}
+
 /* Pass an outgoing packet socket buffer to the endpoint driver. */
 static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 			     int type, struct sockaddr_qrtr *from,
@@ -349,8 +372,12 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 	size_t len = skb->len;
 	int rc, confirm_rx;
 
+	/*
+	 * Data before the HELLO is refused: it would count against the flow
+	 * control window. Control packets are held back further down.
+	 */
 	mutex_lock(&node->ep_lock);
-	if (!node->hello_sent && type != QRTR_TYPE_HELLO) {
+	if (!node->hello_sent && type == QRTR_TYPE_DATA) {
 		mutex_unlock(&node->ep_lock);
 		kfree_skb(skb);
 		return -EAGAIN;
@@ -383,13 +410,29 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 
 	if (!rc) {
 		mutex_lock(&node->ep_lock);
-		rc = -ENODEV;
-		if (node->ep)
-			rc = node->ep->xmit(node->ep, skb);
-		else
+		if (!node->ep) {
 			kfree_skb(skb);
-		if (!rc && type == QRTR_TYPE_HELLO)
-			node->hello_sent = true;
+			rc = -ENODEV;
+		} else if (!node->hello_sent && type != QRTR_TYPE_HELLO) {
+			/*
+			 * The remote may not take traffic yet (a freshly
+			 * booted remoteproc without rx intents). Dropping
+			 * here would lose name server announcements for
+			 * good, so hold them until the HELLO is out.
+			 */
+			if (skb_queue_len(&node->tx_backlog) < QRTR_TX_BACKLOG_MAX) {
+				skb_queue_tail(&node->tx_backlog, skb);
+			} else {
+				kfree_skb(skb);
+				rc = -EAGAIN;
+			}
+		} else {
+			rc = node->ep->xmit(node->ep, skb);
+			if (!rc && type == QRTR_TYPE_HELLO) {
+				node->hello_sent = true;
+				qrtr_node_flush_backlog(node);
+			}
+		}
 		mutex_unlock(&node->ep_lock);
 	}
 	/* Need to ensure that a subsequent message carries the otherwise lost
@@ -657,6 +700,7 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 
 	kref_init(&node->ref);
 	mutex_init(&node->ep_lock);
+	skb_queue_head_init(&node->tx_backlog);
 	skb_queue_head_init(&node->rx_queue);
 	node->nid = QRTR_EP_NID_AUTO;
 	node->ep = ep;
@@ -700,6 +744,7 @@ void qrtr_endpoint_unregister(struct qrtr_endpoint *ep)
 
 	mutex_lock(&node->ep_lock);
 	node->ep = NULL;
+	skb_queue_purge(&node->tx_backlog);
 	mutex_unlock(&node->ep_lock);
 
 	/* Notify the local controller about the event */

-- 
2.53.0

