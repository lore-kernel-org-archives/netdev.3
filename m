Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950EF3DB626
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833137; cv=none; b=Qan3GTVdSbQE9idEUSo58a4RkZSULvopdeAiEgQ8JE7ORp8bDa4aeiWvaBOt/d3nao+530GYa0GQfSVKtQoai/K/010dYt8yn3tmz/9wsicuqgtcvgCX1wUuHqdKRFOFU2mm8Xp40RAHhC57uS0fGTvuU3prREbwHi90/YOWkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833137; c=relaxed/simple;
	bh=UYgQmB7qLR7zkxPPkjkq6G5CfKxuU6jxBNtb9Zqv8IE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ISvakch1WkUvq3/Qdo/voxhEIekT1st0tZL4XDNdzHfPSk4VZmZVrrKiU+YtW87idOC2Ex4YF9fbZ3naejOuuPK6RXcewH+B12myUDJIApuAhpAhj5gPG4vnifiqUVgyMixgdY7wnuD1iTtrvAG837t8KqsDzvC3MBL9lgTBvXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aTBrtmWb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AoK1YA5m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aTBrtmWb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AoK1YA5m"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RCC9cL3803178
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 12:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yvZRm8NKgBNpbaweKVg3t7
	RUcwrN4G+we2r4OoXb1u4=; b=aTBrtmWbsrxeUDVJwPq/RbmB1QRo2AYC/aHgGF
	ANy7egl7FVqibdRzRc0To+EBa228DKA93yEerP4zXEcMbE9FNvpkoZha/tkfrJzh
	woBmyAMKsuioa5w8uQsm/Zqo3qKo0CujHoe78S0SBiogqSg3AeD476HTIJS77bMD
	YcY6x5TQRON7tSPS/9KeqcU52U2iQ4a/kk6lZYJL5OpazzBTVjP+MUjMnkaIhHzH
	Vbqv2mYq88a4cgX7KDaQAFUNiaVQiyr9HojyupuJe07fAaJNT7XDwBX/884kBkPn
	inG9a/8VkvIsb+pxKQ4USJ6THPLs7vczTOk+m+OfAgW13YpQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gak560e9x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 12:18:54 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e13b57b2cso2181452b3a.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 05:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787833133; x=1788437933; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yvZRm8NKgBNpbaweKVg3t7RUcwrN4G+we2r4OoXb1u4=;
        b=AoK1YA5m9yptzX309Q7Qyr3beY2TCQJlTVDEXz031dit3uvuFJJ/RUhX1xuPbPzRjK
         j9kimYkVqXREStWVI/2bv/wXLVh9ElkmPzD1hN+v6ocmZenM7DqsUcwYNbgzE1zwl+QN
         tB8hzmA4D6hk1v47xVUwdzDGxfBCbbrgT1Ieh5Lkgpa+vsaPVrIy2ISi0OhShfvW/B9u
         dWwPrixlAPW4uTpRgxPm98yN7lK5jNR2cCxLugz5lBE0E+TYoYpPYL8+5gM8y0Wi1N8X
         m7WhUKX1WBJ8bvAiiRvhIf2RGXfanV9S1hTjR6LJO4AUIijqKBHCSygp5yD42vVLS4zx
         /yRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787833133; x=1788437933;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yvZRm8NKgBNpbaweKVg3t7RUcwrN4G+we2r4OoXb1u4=;
        b=DT3b3RKnNpQA8bpu1OQTH9Y8MchWjWUzvbKmwa8VTyqD3u1RtzRFPOjukEd1RM16wm
         IBfSfJz96lIIZxvRBWjirAERdPEKhbW5nb/dQBSbIKr3/5I/mbtSbx0BEA8PkPd8z4EN
         IEDGEN8R5FFdmE+tXb8aZCqyOSFZLohVRxzCS8MVVmk4hMSgsVL6rQ8kNLJ5srnvrJMF
         Y7nueJnR+IVy9WYcnf2SXhZnUUYRh7hade9gS857gPvtCO4NJ1ZL+Cvmwiklyi/ki0qY
         D90LCJSVhUpcASR2SaN/yaDhPlyfYTRJbtFgwJvVgHnsxg+C2ygVTJT+KNDP/iZjyEys
         Wd1g==
X-Forwarded-Encrypted: i=1; AHgh+Rolu6IH/DL7hmsOQCfwh3HYT63f7d9MlyKhbnG+lPIi8+MOX2xnXjvLjq34YvoX3g3+FqitKJA=@vger.kernel.org
X-Gm-Message-State: AFuF++n3oGh+1/8gm62nDpC7myH/DISz+QHVXzlyH4FwIM5GjEq8CHRv
	q55R1EgG0IQKuv5rAKihRZ8Qa3YL4Iz6/yhapzZ7VQsiNN1J/svE1dwG2LXxSaeJaBAgkCDPyBs
	9Lo+nW59PSEIbHuDl6C51Mecq/LysQhG/yC/QEct+PwFgGGb4N2bR/IIJPl8=
X-Gm-Gg: AR+sD12OmA4l7d3y39OeyMVPcAlMHNPFwVM1ge/GIlhttvJ40anbQbVUR9mJMZ5Ob8S
	N2ll786UgaUU86QUtov4xm3SXybT0hMiA1AUZtlUtUJLe/XUGkjurUu1wx0cLFH+BXWnilNh0CT
	KmYBKD5l3p5xWRIQn6inzGS+daIC7yJnWdaiq+bLV3Pt+qavAEDyDH1uZxe8kFs1JSiRGZwl+HD
	HBHIQ/+9a2Ue7GUO6O7S4ydAaeOOgK6vnhyfBTHghF2TmLaptbhGdqeQMtw/e5bg1ay1hV+Ix30
	GxMarBDNDMz/ZcJCKAfGU9BrXUVsqU9MZqHtQUrVWlvs3dZ525qxWzQ1FEcDlbRwSCZfhqfyxby
	o1WB2IlpVtvZofYB3mU74rhBQVePOrURAMuOSonI=
X-Received: by 2002:aa7:8887:0:b0:846:22ea:e171 with SMTP id d2e1a72fcca58-85371cb5f0dmr25326579b3a.3.1787833133230;
        Thu, 27 Aug 2026 05:18:53 -0700 (PDT)
X-Received: by 2002:aa7:8887:0:b0:846:22ea:e171 with SMTP id d2e1a72fcca58-85371cb5f0dmr25326323b3a.3.1787833132242;
        Thu, 27 Aug 2026 05:18:52 -0700 (PDT)
Received: from hu-pphansal-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535d344577sm1990580b3a.60.2026.08.27.05.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 05:18:51 -0700 (PDT)
From: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 17:48:46 +0530
Subject: [PATCH v3] net: qrtr: Send HELLO message on endpoint register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-qrtr-hello-on-ep-register-v3-1-ca289ff99abf@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACUrkGoC/43PzW7DIAwH8FepOJfKkABhp73H1AMfpkFKQwtdt
 KnKu5e0u21rerH0t+Bn+0oK5oiFvG2uJOMUS0xjDc12Q1xvxgPS6GsmHLgEyRt6zpdMexyGRNN
 I8UQzHmK5YKYKZGuldM4rIPX/KWOIX3f7Y19zX5+l/H0fNbGl+1AVsCfqxCijrdauRYCOe/ueS
 tmdP83g0vG4q2WZ9QPJNcgKoYLVYButn0DN6kbeIwrLbDDofkPLuRN/+URewS54K5ABEwr/36w
 DtQYZFbgUpuXhL2g/z/MNLsHc5/UBAAA=
X-Change-ID: 20260623-qrtr-hello-on-ep-register-7064b66ccd70
To: Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        Chris Lew <christopher.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787833128; l=11592;
 i=pranav.phansalkar@oss.qualcomm.com; s=20260220; h=from:subject:message-id;
 bh=NLUfYOcMrrwUw0L5ZHuerkaARAXtk2ri2zjWh5wzObY=;
 b=+/J0aT7Agrze+fa13PYdzP8eSxa+fsuvxqyOBo+FSHeN13v0MSL4lCFiJaiRikanBZuUxjnMi
 /sK9eC4wbHiAGEDasnx0y0gGITY/hccAiMLww6qK0CuoHfpdhILYgLF
X-Developer-Key: i=pranav.phansalkar@oss.qualcomm.com; a=ed25519;
 pk=MI1mUPTtmeY/WO9GsLnjtoVy4wYL57rtVnRammLT8B8=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwMSBTYWx0ZWRfX3SkH2JH4q+ar
 4vrpmbhPzqleiDaXqsqhMKTUQ8ofayIDw78sEG65wyb+AsBwe0blVCdMSSaYqVS+UdqLRTnlphh
 gGqPpVmN+QSjC1kbFWi/ClS2x4w4VPo=
X-Proofpoint-ORIG-GUID: 1DblkleiEQ-MwgLkM4Zflv9MUO7mzIDu
X-Proofpoint-GUID: 1DblkleiEQ-MwgLkM4Zflv9MUO7mzIDu
X-Authority-Analysis: v=2.4 cv=G+Ms1dk5 c=1 sm=1 tr=0 ts=6a902b2e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nbVe5d7HPEM6lZhScKcA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwMSBTYWx0ZWRfX8aJQD6aVTdrw
 3ZHULTcVFjEqDKQVEnxI/RtNAynG/wts3ARkHnwNq/FnjqU2KFeMdw0vJgt6pIkYUpP6940GLwI
 Zglc8LtK7d/CEHZ6gEtnK5PPeBFwn+wK632OSW0S/iso1B+COQclycSfNPxfBfpZ5IZKWQpw1/I
 4HsRRNVZEn2OsEWS5KBmCY9Ve5eOa0BtmkPxVwY4npqRRDgW6lc1BfDo8BbjyNuak0h0H4z1X5Q
 VktraiqTPfcWGaM7VX7KHJ5/W9QpTUWnqoGFa47AEhXOBb77HijJnn7JiLxMYqIDI9kql6C5qoh
 y8T4oCbEyunEjG7kBeAaFyN2FkXCxKnR7FLL3gFsWRtLsja5hl5wxU/4whx3Msx0XxhZbefh1jx
 u/u6Au6YLck0nphQALrcpMeX95Pm3Ok0jQhXx7dknkwCsLHWcDwsmqkIhGF7gCJnXfxiRAb0wBK
 9894LRTC45e4c7rkYUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270101

From: Chris Lew <christopher.lew@oss.qualcomm.com>

HELLO is currently handled entirely by the name server (NS): it is
sent once as a broadcast when the NS initializes, and again as a
reply whenever the NS receives an inbound HELLO from a remote.

Some remote QRTR endpoints (e.g. an external WLAN chipset attached
over MHI) operate in a slave role: they only ever send a HELLO in
response to one they receive, and never initiate. Since the host cannot
tell in advance which remotes behave this way, if the host also only
replies, both sides wait on the other to speak first and no HELLO is
ever exchanged, stalling further communication.

To fix this:
- Transfer HELLO handshake ownership to the core layer. A HELLO is
  now sent once, per endpoint, at registration time.
- Schedule a delayed work item on endpoint registration to send a
  HELLO once the name server is bound. The work reschedules itself
  with a 100ms backoff if the name server socket is not yet bound or
  if allocating the control packet fails, so a transient startup
  condition does not abandon the handshake permanently.
- Enforce HELLO-first ordering by dropping non-HELLO packets and
  returning -EAGAIN until the HELLO is confirmed sent, using bool
  hello_sent guarded by ep_lock to make the gate check atomic with
  xmit().
- Skip nodes with nid == QRTR_EP_NID_AUTO in bcast_enqueue(), to avoid
  broadcasting control packets with QRTR_EP_NID_AUTO as the destination
  node ID.
- Remove say_hello() from the name server's ctrl_cmd_hello() handler
  and from qrtr_ns_init(); the core layer is now the sole sender of
  the outbound HELLO. This removes the NS's reply-on-receive
  behaviour without a replacement.

Signed-off-by: Chris Lew <christopher.lew@oss.qualcomm.com>
Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Co-developed-by: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
Signed-off-by: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
---
Changes in v3:
- qrtr_node_enqueue()'s pre-handshake gate now returns -EAGAIN instead
  of 0, so qrtr_sendmsg() no longer reports a fabricated full-length
  success when a packet is dropped before HELLO completes.
- say_hello (qrtr_hello_work) converted from work_struct to
  delayed_work. The retry on a HELLO xmit failure now fires only on
  -EAGAIN, with a 100ms backoff, instead of unconditionally with zero
  delay; other failures are terminal for that attempt instead of
  self-requeuing indefinitely.
- The two early-return paths in qrtr_hello_work() (name server not
  yet bound; control packet allocation failure) now reschedule with
  the same 100ms backoff instead of abandoning the handshake.
- Reworded the qrtr_bcast_enqueue() comment to describe the actual
  nid-availability check rather than implying it tracks hello_sent.
  Annotated the lockless reads of node->nid with READ_ONCE(), paired
  with WRITE_ONCE() on the qrtr_node_assign() write side.
- Removed say_hello() from qrtr_ns_init() in addition to
  ctrl_cmd_hello(); the remaining call fired once during module init,
  before any transport could register an endpoint, so it never
  reached a remote peer.
- Expanded the commit message to describe the slave-role scenario
  this patch addresses, and to state that the reply-on-receive HELLO
  behaviour is being removed without a replacement.
- Link to v2: https://lore.kernel.org/r/20260807-qrtr-hello-on-ep-register-v2-1-a7f265a42f7e@oss.qualcomm.com

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
 net/qrtr/af_qrtr.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 net/qrtr/ns.c      | 35 +----------------------------
 2 files changed, 65 insertions(+), 36 deletions(-)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index d02ef9a74c3c..8e9b36479bab 100644
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
+ * @say_hello: delayed work for sending hello packet
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
+	struct delayed_work say_hello;
 };
 
 /**
@@ -187,6 +193,8 @@ static void __qrtr_node_release(struct kref *kref)
 	list_del(&node->item);
 	mutex_unlock(&qrtr_node_lock);
 
+	cancel_delayed_work_sync(&node->say_hello);
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
+		return -EAGAIN;
+	}
+	mutex_unlock(&node->ep_lock);
+
 	confirm_rx = qrtr_tx_wait(node, to->sq_node, to->sq_port, type);
 	if (confirm_rx < 0) {
 		kfree_skb(skb);
@@ -353,7 +369,7 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 	hdr->src_node_id = cpu_to_le32(from->sq_node);
 	hdr->src_port_id = cpu_to_le32(from->sq_port);
 	if (to->sq_port == QRTR_PORT_CTRL) {
-		hdr->dst_node_id = cpu_to_le32(node->nid);
+		hdr->dst_node_id = cpu_to_le32(READ_ONCE(node->nid));
 		hdr->dst_port_id = cpu_to_le32(QRTR_PORT_CTRL);
 	} else {
 		hdr->dst_node_id = cpu_to_le32(to->sq_node);
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
 
+	if (rc == -EAGAIN && type == QRTR_TYPE_HELLO)
+		schedule_delayed_work(&node->say_hello, msecs_to_jiffies(100));
+
 	return rc;
 }
 
@@ -416,7 +437,7 @@ static void qrtr_node_assign(struct qrtr_node *node, unsigned int nid)
 	spin_lock_irqsave(&qrtr_nodes_lock, flags);
 	radix_tree_insert(&qrtr_nodes, nid, node);
 	if (node->nid == QRTR_EP_NID_AUTO)
-		node->nid = nid;
+		WRITE_ONCE(node->nid, nid);
 	spin_unlock_irqrestore(&qrtr_nodes_lock, flags);
 }
 
@@ -570,6 +591,38 @@ static struct sk_buff *qrtr_alloc_ctrl_packet(struct qrtr_ctrl_pkt **pkt,
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
+	node = container_of(to_delayed_work(work), struct qrtr_node, say_hello);
+
+	/* NS must be bound before we can send; retry with backoff if not ready */
+	ctrl = qrtr_port_lookup(QRTR_PORT_CTRL);
+	if (!ctrl) {
+		schedule_delayed_work(&node->say_hello, msecs_to_jiffies(100));
+		return;
+	}
+
+	skb = qrtr_alloc_ctrl_packet(&pkt, GFP_KERNEL);
+	if (!skb) {
+		qrtr_port_put(ctrl);
+		schedule_delayed_work(&node->say_hello, msecs_to_jiffies(100));
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
@@ -595,6 +648,9 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 	node->nid = QRTR_EP_NID_AUTO;
 	node->ep = ep;
 
+	node->hello_sent = false;
+	INIT_DELAYED_WORK(&node->say_hello, qrtr_hello_work);
+
 	xa_init(&node->qrtr_tx_flow);
 	mutex_init(&node->qrtr_tx_lock);
 
@@ -605,6 +661,9 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 	mutex_unlock(&qrtr_node_lock);
 	ep->node = node;
 
+	/* Initiate HELLO handshake from the core layer */
+	schedule_delayed_work(&node->say_hello, 0);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qrtr_endpoint_register);
@@ -879,6 +938,9 @@ static int qrtr_bcast_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 
 	mutex_lock(&qrtr_node_lock);
 	list_for_each_entry(node, &qrtr_all_nodes, item) {
+		/* Skip nodes with no assigned node ID yet. */
+		if (READ_ONCE(node->nid) == QRTR_EP_NID_AUTO)
+			continue;
 		skbn = pskb_copy(skb, GFP_KERNEL);
 		if (!skbn)
 			break;
diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index b3f9bbcf9ab9..6d93bcd250e7 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -212,6 +212,7 @@ static void lookup_notify(struct sockaddr_qrtr *to, struct qrtr_server *srv,
 		pr_err("failed to send lookup notification\n");
 }
 
+/* Announce the list of servers registered on the local node */
 static int announce_servers(struct sockaddr_qrtr *sq)
 {
 	struct qrtr_server *srv;
@@ -326,38 +327,8 @@ static int server_del(struct qrtr_node *node, unsigned int port, bool bcast)
 	return 0;
 }
 
-static int say_hello(struct sockaddr_qrtr *dest)
-{
-	struct qrtr_ctrl_pkt pkt;
-	struct msghdr msg = { };
-	struct kvec iv;
-	int ret;
-
-	iv.iov_base = &pkt;
-	iv.iov_len = sizeof(pkt);
-
-	memset(&pkt, 0, sizeof(pkt));
-	pkt.cmd = cpu_to_le32(QRTR_TYPE_HELLO);
-
-	msg.msg_name = (struct sockaddr *)dest;
-	msg.msg_namelen = sizeof(*dest);
-
-	ret = kernel_sendmsg(qrtr_ns.sock, &msg, &iv, 1, sizeof(pkt));
-	if (ret < 0)
-		pr_err("failed to send hello msg\n");
-
-	return ret;
-}
-
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
 
@@ -774,10 +745,6 @@ int qrtr_ns_init(void)
 	qrtr_ns.bcast_sq.sq_node = QRTR_NODE_BCAST;
 	qrtr_ns.bcast_sq.sq_port = QRTR_PORT_CTRL;
 
-	ret = say_hello(&qrtr_ns.bcast_sq);
-	if (ret < 0)
-		goto err_wq;
-
 	/* As the qrtr ns socket owner and creator is the same module, we have
 	 * to decrease the qrtr module reference count to guarantee that it
 	 * remains zero after the ns socket is created, otherwise, executing

---
base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
change-id: 20260623-qrtr-hello-on-ep-register-7064b66ccd70

Best regards,
-- 
Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>

