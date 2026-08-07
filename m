Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307B937DAAE
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110833; cv=none; b=PecggSrn77z8hJVlka1Yt2byoQRkn5xXMUqx+52xLItYfnvN7YmVXt+UCrjFyPdOXBtWSRomNepS09AzYxwyNvjXb8khCMpX2lJ9oFMmJqDfv+7yqD1Q8et2/NyzIK/hqUFtKEEJ1tAXIUG6jyLaD/XLw2h1M4llXS5ZAP1dvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110833; c=relaxed/simple;
	bh=vxvafmxj3u/QRGZvYHNNOJxkk2DL9hpCFE7Pjf/hwMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CjpDoVYESKFecwPwcEl3AByaZEWvngebN8/WWkH6hx8uaCcLC8DpiM5S12ZIByTAdEZUVLu1FDgCCK7x/xAROnA8iadEv27CUvmseG+QbzjWExmSuOtMuu3dAnXyiXhy5DrfWPP+GUuaG66eNPtU4to5G2DRbLzowL2NMVEsHd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ez+mFZRR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wliuw1a/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ez+mFZRR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wliuw1a/"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CgGmD989333
	for <netdev@vger.kernel.org>; Fri, 7 Aug 2026 13:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AQcfRSQNAUY9rUAlwcCP+K
	/ijtMHM1D3SVNCesyUknw=; b=Ez+mFZRRMfhZzoVJ33T/shpI+ZbP/e7LLTLcES
	W/US0dY9EBV8qg5wdEyWU1bXaonA0FDbmawd92LGxJuR8Bdnjo1hHHn938/frpEH
	FJueCNECYhaNxjBROfHT10JdzKwmHQ2wKfKJm1d1fzg9fpTP1ZFKtGzceEqT3lKt
	i/QekvMJn+pzPomynnSmsbbrRn+bbwc0GrEaanUdZLcPGRTKyxYQRsqOFXoYXG3v
	RXDn0J/13hG3kliO6E9Tz65pvHieCjbMQ7L2QT5ew+tAaNhp2G03on6Vd8+/S0vr
	Oci2j3ngkiRak3Q/3jswsIQOGRiY39PDjs8T8WFnCzAdgeUg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwctp8y0x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 13:53:42 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848474825ffso3133526b3a.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786110821; x=1786715621; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AQcfRSQNAUY9rUAlwcCP+K/ijtMHM1D3SVNCesyUknw=;
        b=Wliuw1a/Z9PchHsvCwYs8bC0+8RqUS8rH66ASW0w/SfhyPydkAta367aLmGBdD6QIq
         Xm506bZiVd4tLXs+YNDRyqFlYr1uu1M+4FuPREieMqSovo08qmHswERYeoRfmZg5lk5e
         CzHVbfhEY0iMJyu/Il0ZI/Iktiqsfz77fo/fp9+me4lNL4hcq526hjRmHprusUxR+2z5
         Zxtfyg5iocSBdLvqxMH26jYPbei6YewxV5rD6dUhIqmtSaQjc1W6uhkQqc/McQLJwg0A
         n7nP/2FeBkDZcjSPPIas2WR2TQZIfx5aujLl7DGCxxbc4oVFwjeuAv9ZVldyJC0zqmZI
         svbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786110821; x=1786715621;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AQcfRSQNAUY9rUAlwcCP+K/ijtMHM1D3SVNCesyUknw=;
        b=AOZWKIPsRCzqCQrbUBGN2S1+IqZCDpdwbGs4MhewWVZO2uunPEck3XlevWYUCRZCqO
         f/NVFo58KxvkmebOXAcqRpqRjhxERWlqSp4gM+OWzXC94Iciny6isR6omyqN1t2DlBxR
         oE3j0OUHFIPyoXZKH4t9L6bpUWC1VESmvlRHKoL9yDpVut9QOH/qyCvHEtaZorM+RmCl
         G/2yRgKwhWHpJ9Hu8bHERDbHXmrSep7Kw/IlXppiYfHQCfxFnjmi5OiTwylOvM5d9MrQ
         mLygR6l4zKg68Wh59HZOy9i16ESFWrhl/y0+TPlmwKt5CHbhVR+w1bPfq1qVb/Uj9LCw
         C5Bw==
X-Forwarded-Encrypted: i=1; AHgh+RqqJlDG7mbXbasilDEpqYjGsDg9/w8Rd63gK8zpJ+dbG532JHHylrgdG+7hzcnz1CjS1fB0mEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlR12rzHSsunKlLcF1CpNa+kvUklReTPvHjBbjw2d8YoD5vjHX
	l3CDSxn0/Z2J8njTp6ghILTRudThwS8KYqC38bUGRSRFyqo7N/Ec1w5EqpllQKyFkAGdEJdPY2l
	Sbh7HJhsV9bAYOJvI54vQmKckSKWseUMrh70NkWahEX4T3HQnaiJ8Nqr2TQ8=
X-Gm-Gg: AR+sD13iaJor4obqTZMArA1SmqneLJjOKOyTYQuwCMfJ5wSUOaEJ/wZRTNIjuwZAKLh
	VnNeXPG+n52WD2gPusBGNUN+EKfWHBZBuZeq9xUZ56rxue8vCXmjCyqMrMVgvjFTEB64uMY/QGN
	Nc7v/sh0oCyKH2SdS9PnGoaYF5sukV5/622WU6DUVAzQaLS58Qqv0ylZApcacpkbbKxI+JpnvFR
	QVBs9g0rur4UQjsYqT9mls1ZQYQOLsJqgTadrXEq9s02gUkti4c1yzI2w1D1pABx+hHBz9acTF2
	Dmv3IxjT1lYXTmJYJ7QdIJnkIaAbe2hvU5JEz2W1jWb2GSJ1WkDiBZTGj9gp5Kip1eW4mQBFkLP
	JPQCzVteKrxkFKAT14u7IA5TrXenDXDsrro5c/8s=
X-Received: by 2002:a05:6a00:2e14:b0:842:446a:4cb5 with SMTP id d2e1a72fcca58-84f418a3e81mr15398751b3a.0.1786110821489;
        Fri, 07 Aug 2026 06:53:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e14:b0:842:446a:4cb5 with SMTP id d2e1a72fcca58-84f418a3e81mr15398707b3a.0.1786110820994;
        Fri, 07 Aug 2026 06:53:40 -0700 (PDT)
Received: from hu-pphansal-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f1aa50esm846610a12.9.2026.08.07.06.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:53:40 -0700 (PDT)
From: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 19:23:04 +0530
Subject: [PATCH v2] net: qrtr: Send HELLO message on endpoint register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-qrtr-hello-on-ep-register-v2-1-a7f265a42f7e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAD/jdWoC/43PwW7DIAwG4FepOM+RIQFKT32PqYcAToOUhha6q
 FOVdx/JdmvV7mLpt+CzfWeZUqDMdps7SzSFHOJYgvjYMNe345Eg+JKZQKFQiRou6Zqgp2GIEEe
 gMyQ6hnylBBpVY5Vyzmtk5f85URduq/15KLkvz2L6XkdNfOn+qhr5C3XiwKExxjWEuBXe7mPO1
 eWrHVw8napSlll/kHoHWSl1Zw3a2pgXUP12I++JpOW2a8k9Qsu5k/j3iaKA285bSRy51PQEnOf
 5B9Q6cR6sAQAA
X-Change-ID: 20260623-qrtr-hello-on-ep-register-7064b66ccd70
To: Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Lew <christopher.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786110816; l=7447;
 i=pranav.phansalkar@oss.qualcomm.com; s=20260220; h=from:subject:message-id;
 bh=wCkz6EuVi39ykL26ywWpCJN3ni+VwbrhtOBM8yHnnEk=;
 b=Qy3q3FXrhAyjs0htl5aCh2WMiLPxhiXI9+Q/GzdpJyC25DpUCpvuZMztX2lzfcGRzfN7rPsf2
 seOMEcbJwTyBYd51xMyMPlTcidi7v/+yG5G2QM69Vro/WaL7ZvvP9Sf
X-Developer-Key: i=pranav.phansalkar@oss.qualcomm.com; a=ed25519;
 pk=MI1mUPTtmeY/WO9GsLnjtoVy4wYL57rtVnRammLT8B8=
X-Authority-Analysis: v=2.4 cv=Fp01OWrq c=1 sm=1 tr=0 ts=6a75e366 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1VuSPjvJZ7mnb2hqxAcA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: UscUVF91dClghhdzMJeDtjaW0X7zrR-T
X-Proofpoint-ORIG-GUID: UscUVF91dClghhdzMJeDtjaW0X7zrR-T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEwOSBTYWx0ZWRfXzoaTRYLunvax
 UPKx38UwBl/5Vw4Wt+dQ+J66Y/VtI3n/SgYt7NtL/qUaRiiydi4xMUi9h2pWkkCGfCoMEHUdlps
 362uYpvBt3YYPvDTQDHguoMDCYQndJLXQZBEQoKXAFG2WnJBH/P3ZmMtuJ80dfT50TIoRw40n+D
 ufibyjF402v25qTLGMQdrVgZ6ztazqKsZUHe5TQTkKgjO8jqu0DOEBvhob+IiE+KLdGA66sVznU
 QWjxMjDvL/d5734n+kzprD21ExkeMxhWT2IyvOqZ2mvC7w6KNX52FCRGC7hnDBrIBojWyLxCVHB
 syTMqCOyhA7m3VxqGYvj6GtzAF1wQ73Y3AkzrCL/+MOLHMzjSKbn7ckWeLS0hQHE/TOE6OrtfEB
 qrRTNCKMx70Wjxxt5ZArseoiXm8Q8LruFwB0yMTaU3xnptDMEA6z18T6Ay+L99PgraOSdABorAh
 moQLWp222HHI5VTRbow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEwOSBTYWx0ZWRfX5OmA2ITIHy7X
 fDUqYM+R2QNqSMiaMwa8ux4yjb5huPKwXY7crtH7TUq7COKGwgWNMQHxGP+36QHc3E+/QqEJ985
 +aHq1naH+dL63BMWKiVtpM9wvzAFRCs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070109

From: Chris Lew <christopher.lew@oss.qualcomm.com>

HELLO is currently handled entirely by the name server (NS): it is
sent once as a broadcast when the NS initializes, and again as a
reply whenever the NS receives an inbound HELLO from a remote.

In a slave model, neither endpoint initiates a HELLO on its own;
each side only replies to one it receives. Since both sides are waiting
on the other to speak first, no HELLO is ever sent, stalling further
communication.

To fix this:
- Transfer HELLO handshake ownership to the core layer.
- Schedule a work item on endpoint registration to send a HELLO once
  the name server is bound, retrying on failure.
- Enforce HELLO-first ordering by dropping non-HELLO packets until
  the HELLO is confirmed sent, using bool hello_sent guarded by
  ep_lock to make the gate check atomic with xmit().
- Skip nodes with nid == QRTR_EP_NID_AUTO in bcast_enqueue().
- Remove say_hello() from the name server's ctrl_cmd_hello() handler;
  the core layer is now the sole sender of the outbound HELLO.

Signed-off-by: Chris Lew <christopher.lew@oss.qualcomm.com>
Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Co-developed-by: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
Signed-off-by: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
---
Changes in v2:
- Drop say_hello() from the name server's ctrl_cmd_hello() handler;
  the core layer is now the sole sender of the outbound HELLO, so
  the NS no longer needs to duplicate that logic.
- Fix Signed-off-by/Co-developed-by ordering so the submitter's
  Signed-off-by is last.
- Duplicate-HELLO detection at the name server (hello_rcvd) will be
  handled in a separate patch, so it is dropped from this series.
- Link to v1: https://lore.kernel.org/r/20260731-qrtr-hello-on-ep-register-v1-1-ddee5b1bfaec@oss.qualcomm.com
---
 net/qrtr/af_qrtr.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/qrtr/ns.c      |  8 +------
 2 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index d02ef9a74c3ca..7adc0a0531254 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -9,6 +9,7 @@
 #include <linux/termios.h>	/* For TIOCINQ/OUTQ */
 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
 
 #include <net/sock.h>
 
@@ -120,8 +121,10 @@ static DEFINE_XARRAY_ALLOC(qrtr_ports);
  * @nid: node id
  * @qrtr_tx_flow: xarray of qrtr_tx_flow, keyed by node << 32 | port
  * @qrtr_tx_lock: lock for qrtr_tx_flow inserts
+ * @hello_sent: hello packet send successful
  * @rx_queue: receive queue
  * @item: list item for broadcast list
+ * @say_hello: scheduled work for sending hello packet
  */
 struct qrtr_node {
 	struct mutex ep_lock;
@@ -132,8 +135,11 @@ struct qrtr_node {
 	struct xarray qrtr_tx_flow;
 	struct mutex qrtr_tx_lock; /* for qrtr_tx_flow */
 
+	bool hello_sent;
+
 	struct sk_buff_head rx_queue;
 	struct list_head item;
+	struct work_struct say_hello;
 };
 
 /**
@@ -187,6 +193,8 @@ static void __qrtr_node_release(struct kref *kref)
 	list_del(&node->item);
 	mutex_unlock(&qrtr_node_lock);
 
+	cancel_work_sync(&node->say_hello);
+
 	skb_queue_purge(&node->rx_queue);
 
 	/* Free tx flow counters */
@@ -341,6 +349,14 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 	size_t len = skb->len;
 	int rc, confirm_rx;
 
+	mutex_lock(&node->ep_lock);
+	if (!node->hello_sent && type != QRTR_TYPE_HELLO) {
+		mutex_unlock(&node->ep_lock);
+		kfree_skb(skb);
+		return 0;
+	}
+	mutex_unlock(&node->ep_lock);
+
 	confirm_rx = qrtr_tx_wait(node, to->sq_node, to->sq_port, type);
 	if (confirm_rx < 0) {
 		kfree_skb(skb);
@@ -372,6 +388,8 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 			rc = node->ep->xmit(node->ep, skb);
 		else
 			kfree_skb(skb);
+		if (!rc && type == QRTR_TYPE_HELLO)
+			node->hello_sent = true;
 		mutex_unlock(&node->ep_lock);
 	}
 	/* Need to ensure that a subsequent message carries the otherwise lost
@@ -379,6 +397,9 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 	if (rc && confirm_rx)
 		qrtr_tx_flow_failed(node, to->sq_node, to->sq_port);
 
+	if (rc && type == QRTR_TYPE_HELLO)
+		schedule_work(&node->say_hello);
+
 	return rc;
 }
 
@@ -570,6 +591,35 @@ static struct sk_buff *qrtr_alloc_ctrl_packet(struct qrtr_ctrl_pkt **pkt,
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
@@ -595,6 +645,9 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 	node->nid = QRTR_EP_NID_AUTO;
 	node->ep = ep;
 
+	node->hello_sent = false;
+	INIT_WORK(&node->say_hello, qrtr_hello_work);
+
 	xa_init(&node->qrtr_tx_flow);
 	mutex_init(&node->qrtr_tx_lock);
 
@@ -605,6 +658,9 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 	mutex_unlock(&qrtr_node_lock);
 	ep->node = node;
 
+	/* Initiate HELLO handshake from the core layer */
+	schedule_work(&node->say_hello);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qrtr_endpoint_register);
@@ -879,6 +935,11 @@ static int qrtr_bcast_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 
 	mutex_lock(&qrtr_node_lock);
 	list_for_each_entry(node, &qrtr_all_nodes, item) {
+		/* Skip nodes whose node ID is not yet known; they cannot
+		 * receive broadcast packets before the HELLO handshake.
+		 */
+		if (node->nid == QRTR_EP_NID_AUTO)
+			continue;
 		skbn = pskb_copy(skb, GFP_KERNEL);
 		if (!skbn)
 			break;
diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index b3f9bbcf9ab9b..14262623d2dd5 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -212,6 +212,7 @@ static void lookup_notify(struct sockaddr_qrtr *to, struct qrtr_server *srv,
 		pr_err("failed to send lookup notification\n");
 }
 
+/* Announce the list of servers registered on the local node */
 static int announce_servers(struct sockaddr_qrtr *sq)
 {
 	struct qrtr_server *srv;
@@ -349,15 +350,8 @@ static int say_hello(struct sockaddr_qrtr *dest)
 	return ret;
 }
 
-/* Announce the list of servers registered on the local node */
 static int ctrl_cmd_hello(struct sockaddr_qrtr *sq)
 {
-	int ret;
-
-	ret = say_hello(sq);
-	if (ret < 0)
-		return ret;
-
 	return announce_servers(sq);
 }
 

---
base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
change-id: 20260623-qrtr-hello-on-ep-register-7064b66ccd70

Best regards,
-- 
Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>

