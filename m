Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F36233956
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787704811; cv=none; b=Tsz0hxPIs7+dTe1KYjZeOHaK/+DK2nTKnKgT/CJ0qD/zKYWZyJVkD7tZWk0QFVF1fltVJYo37qBww3/uC7tbLWIPjcKX9KYuTlingkdhOfK5tbj2BaNHYS2YgcmSOXlR54xFCcZhsKTqnXlnBkVJ1QOsbx4ONAqJTrEfuTIOVb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787704811; c=relaxed/simple;
	bh=FcFN70EMn3NFxzjIeQEMtx0bY3hAkneIIufEHZNApnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ab4HrUGaZ+ctm6y1D7Yefu4/qfHfHShIbm1PZ1UqSIs5rp8+iVUF8huTRrtyN7qeimOOIxFCWxds5AFzzC1KxB1XssPv48kmYtH/mUBwlAcu4niYOEmEul69rOkn/7U1fyw5AjLSbCpF0lhBZvcFqcu3xQpHBy5YH5brvKU26ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r1rlF2Ug; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1rlF2Ug"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84830c774a0so574188b3a.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 17:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787704810; x=1788309610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JuJMd61vQn7VC6GY3r3MpRqnhIXcz7QetrZGVrziers=;
        b=r1rlF2UgBR0VPlf9D8z36y2dw2gvX6mIMJqKfmENe0mvlHx5VdOrn3buNCnv0nwINS
         UTbNNh7CTkRIvbdcCQmIUHDudFmprIu8kEHFpHz0u01OXdWmqGg/w9TM2Ll9oJI3uNV9
         ebgSTZzsbtxHhiCSUDazzQfOTDH32luOrtHh8/2boRNBiP3OUaKdndvEJ3FhUWe3HWYX
         5pakIqd8PrQbUVxkh10hA4W9qmTRuSmhwCMyFy6IQL7Lsxq4o2K9pB0aqLdsGUK2QXB0
         xv1+WRuL2xuRZBeMpm8jxI/0OM1KYOVRzfC8DQj/fVUjpAhLc2WZ3UMEu6X1wEWQ4v37
         lU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787704810; x=1788309610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JuJMd61vQn7VC6GY3r3MpRqnhIXcz7QetrZGVrziers=;
        b=TpoZLKDbqjFJXPwhdivLoRx0093/32fifkpUE3qgyYMBQVsrLQq5ddr0inKnIYHFDr
         vp7JIhUFPpZ1KV76rPpYqwQGnkCfbp8n5tYOSjricreq+Z0n5v6ZWQfbKORHqk5p3x3V
         m5tMUd51O+D8tBrsuZo/jJzCAj2kVPOjweXhMvXmQsIVRtpAYAHN8BZ7DYY+QV0uxd/Q
         fsKlSslG2Y8gcX28Gsgze7gfe5qT9lIVxS51vaxkVmPTtsSZ6olAF9XLB7YyYYzrf1zC
         EQgS3btd1lKdeswdAGqrG1Ore/95zYMdeFWfPE/vg2UoShSSKMRuOuRxHjpsuKvwy3sY
         eXSA==
X-Gm-Message-State: AFuF++kQds7NYsDaYVAbLee4oTO6G2K2ae26i3enT8uDvIR0OFmXOrg6
	SsxDXpwgqPYYsQFBwu6CFCnq2O7UnxI4EdphMcVLft4/Qgoz7uWLfxhhEMBcfWpK
X-Gm-Gg: AR+sD13vjhYST1V0S6ggbSULp4wBBIowp422YMmJyXFShzSClXW9sV51LSqolY+1+I/
	m9WhHTw6v4M4WYdnFGxu1SzdFt/NqAvZmFRl9WVu0z4T4RSebQsAlP5D4dsYbZt/zefq0hfk4wb
	jbtEjpK7KQ6dyG/5oukmSI20nA4wUUvFLA2H3w0gx4bBtW0QVVnHsgXRzH//pcy8NT/ExNeFfjc
	7nQJJY3tPN6G2fyOZZdcKAq6YXzSIoVAJcg/Dt/yC9EEzwCAI0SNLVw9jESZOGCKcMMnqg1isea
	0uVS+CJZl8U8PEj/vqd2J1j9nZxVru3JgAcP5zI5Dz0/zXRsIah7aG0OBatfvG84oHzRTOwEjn2
	P6DB0l8hML/le0WRxcMN8a7Dr5KUr7f6eVDUJTNH3SyamVfoOs5UkqwR10daaKVKgDPPCSVmCN+
	Rzlr3P+iyq74wKkWb+YF4WYK7fso318D8EaPYTe3rRNTXUgo02q4/TX1e94lRcr1VEdW20Kd3C
X-Received: by 2002:a05:6a00:464e:b0:847:881c:7026 with SMTP id d2e1a72fcca58-85371baa990mr4853484b3a.3.1787704809556;
        Tue, 25 Aug 2026 17:40:09 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535cdc038dsm339377b3a.38.2026.08.25.17.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 17:40:09 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	stefanha@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH net v4 2/2] vsock/vmci: validate packet source for connected sockets
Date: Wed, 26 Aug 2026 09:39:28 +0900
Message-ID: <20260826003929.966160-3-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260826003929.966160-1-4ncienth@gmail.com>
References: <20260826003929.966160-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmci_transport_recv_stream_cb() looks up sockets first by the full source
and destination tuple, then by destination only in the bound table. The
fallback can select a non-listening socket without checking whether the
packet came from its stored peer.

This was reproduced with two VMCI contexts. A RST from the context not
stored in a TCP_SYN_SENT socket reset that socket after it was selected by
the destination-only lookup.

VMCI can process notification packets in bottom-half context when the
socket is not owned by user context, or defer packets to a workqueue. Use
vsock_check_source() after taking the socket lock in the bottom-half path,
and recheck after lock_sock() in the workqueue path. Listening sockets
continue to accept packets from any source.

Reply with a RST addressed from the received packet before dropping a
source that fails validation. This preserves the existing reset behavior
for bound non-listening and concurrently closed sockets without directing
the reset to a connected socket's stored peer.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/20260814121255.6B5001F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/vmw_vsock/vmci_transport.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 1c4ee039c..1f186e8f8 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -680,11 +680,13 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 	struct vmci_transport_packet *pkt;
 	struct vsock_sock *vsk;
 	bool bh_process_pkt;
+	bool drop_pkt;
 	int err;
 
 	sk = NULL;
 	err = VMCI_SUCCESS;
 	bh_process_pkt = false;
+	drop_pkt = false;
 
 	/* Ignore incoming packets from resources that aren't vsock
 	 * implementations.
@@ -765,17 +767,29 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 	bh_lock_sock(sk);
 
 	if (!sock_owned_by_user(sk)) {
-		/* The local context ID may be out of date, update it. */
-		vsk->local_addr.svm_cid = dst.svm_cid;
+		if (sk->sk_state != TCP_LISTEN &&
+		    !vsock_check_source(vsk, &vmci_transport, &src)) {
+			drop_pkt = true;
+			err = VMCI_ERROR_NO_ACCESS;
+		} else {
+			/* The local context ID may be out of date, update it. */
+			vsk->local_addr.svm_cid = dst.svm_cid;
 
-		if (sk->sk_state == TCP_ESTABLISHED)
-			vmci_trans(vsk)->notify_ops->handle_notify_pkt(
-					sk, pkt, true, &dst, &src,
-					&bh_process_pkt);
+			if (sk->sk_state == TCP_ESTABLISHED)
+				vmci_trans(vsk)->notify_ops->handle_notify_pkt(sk, pkt, true,
+									       &dst, &src,
+									       &bh_process_pkt);
+		}
 	}
 
 	bh_unlock_sock(sk);
 
+	if (drop_pkt) {
+		if (vmci_transport_send_reset_bh(&dst, &src, pkt) < 0)
+			pr_err("unable to send reset\n");
+		goto out;
+	}
+
 	if (!bh_process_pkt) {
 		struct vmci_transport_recv_pkt_info *recv_pkt_info;
 
@@ -900,6 +914,7 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 {
 	struct vmci_transport_recv_pkt_info *recv_pkt_info;
 	struct vmci_transport_packet *pkt;
+	struct sockaddr_vm src;
 	struct sock *sk;
 
 	recv_pkt_info =
@@ -908,6 +923,12 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 	pkt = &recv_pkt_info->pkt;
 
 	lock_sock(sk);
+	vsock_addr_init(&src, pkt->dg.src.context, pkt->src_port);
+	if (sk->sk_state != TCP_LISTEN &&
+	    !vsock_check_source(vsock_sk(sk), &vmci_transport, &src)) {
+		vmci_transport_reply_reset(pkt);
+		goto out;
+	}
 
 	/* The local context ID may be out of date. */
 	vsock_sk(sk)->local_addr.svm_cid = pkt->dg.dst.context;
@@ -937,6 +958,7 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 		break;
 	}
 
+out:
 	release_sock(sk);
 	kfree(recv_pkt_info);
 	/* Release reference obtained in the stream callback when we fetched
