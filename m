Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96438B15B
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787507992; cv=none; b=o8LxO7seccwItdgYLgOLuoN1GZdmBr9a9JxlzMViXwd0cGbXHzx5+NSr0pn3IidpA0i6P6wOQMjYaQaNnCLkKz4JhZcSq8M3hL2+rScMNa4vAWqDYbM8wQoQ2t6r1MQeB5W//7M4gtm0OVFhnzkW/YIsnmR3THs8VPRQ4lN+TmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787507992; c=relaxed/simple;
	bh=Q5N8akU4x+F36ss1pZ0xBmq2Yh+ClMoeMJuX3SACBjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWi7ash8vIXO+5bIu+8RjkzowW3nHIb7LckYMXBsr5mK8GGe1Syk41XBT3mtABR0QKhpPh5kw1PmCS9BKwxRStnJ1HM3REi5N2PPN89Obl9aFkhp5pR7mGvblX8cX7zb1N8GElen5fXbdlwMUKRIJBIUYxpOoih/sWEhxEbtovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNmokkrZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNmokkrZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e88b60121so2023342a91.3
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 10:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787507987; x=1788112787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ECOspUthc7jBrs5mtjKd9RwO1oTEgx0ts6iTJsWVuOY=;
        b=mNmokkrZ6k83OPsCtcYt+1K1ita0ZnBsb+LN6njAswk34m7i3jT5lEVzMy8/+I1LwI
         44PhWOrB97C0XM6eadbCtbRAy1ZnPgBkBniNsyQ7sEdtYdo8X+u4o7i1QXY7SUAEZJHC
         ykWtp15HKnKK0gDZNy+/DjaUCfHqijg9Rn2BLvW/WClaypeznOJebPE+PALg6wphA24f
         lo1vR2kgGVENz4WWCsqTFRZ0Pv7Er02kVYYp1iA0Js7E66bddUyKvbvuchunk/71Mx03
         01uK68g41RQgPi8t/EUp3g9AhYCsGEX/1hoW6O04gUYaMB+uHdzo60A2L1h4EzPcMd7F
         98gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787507987; x=1788112787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ECOspUthc7jBrs5mtjKd9RwO1oTEgx0ts6iTJsWVuOY=;
        b=cJjv014U74uPitTz4O/rJUkSCGq2FVGQWKRfTGbWNqgKWqyM5G7Gg6PuwSFMpWXv04
         BRXkIcl75NMhP+yHOKKmPVX/av9jMc8os9hUQ5Oj0ps8WJ6fx6CcuhCHsMbNFrICBfKi
         CNJ87NUmJZQplPL5TilnbW5JWM8Z1RhcRYHBfKsQsCLwOfpJ1/UxJzQm0cQ2N0eLXqGV
         Bs9803Bv0IduwD5yEyI3YWPJGT42YxKTs/qWZc+WUxqcYXqUN3J9eoCV9ddVUGSEwEo6
         4zHtEr78/vrnkTl6jTXGE5QBYTqm1COESl2MklLtqMnMF7bLIzJkMkOdqroDaoWP4hKt
         a3EQ==
X-Gm-Message-State: AFuF++k2uIl1lSrMZURLjZMQPypN1iy5DuwktyCQxDhBeNE2/QYRjoZy
	JaqBuwo2zfdpAXGsa0kHoNiEZXX1T5w0IjYjZ/l7/HN8SfaZdYf2gFOoSyFpkAyGzH4L1A==
X-Gm-Gg: AR+sD11RfB1ciSjq8Xn4bQwYeG91XQxemDfglKtCXnjCPnIEF9TEwmsaJIdQQdujT94
	CGThrLSUIGv6n2JsHW5xx4uMzcGyYTR5wWsu2Ih5FCADdfYQ7ed+k4AlNwb5JlBEQpHSjMj8fAk
	xcdI9CVMRM5kMsJTkqGoNQH/61IUZzc6SBITlSQkD/AGjufixcmMaRUk4/ZY57zj4JFNH93FT+M
	Y9tczXOxJL7V+ACSr5Gni6J5Ic10YIxIxtqLqTmGdilxZxWlM8tIO0pSkmxqyMzUvA1KEhr1pFS
	U5KTeuqk4fi7EHOdmmiVB/8n06S4vCwBgvdDTx+6UyFE7AHhh5KwqWik++0Di/I/qdiwWx2oaBB
	6S+FUmc7kHYTw0hbs0Doc7g8+J4s6C6g3YZWjpFQx3FU0XJvezyU8UkA+uo9BsZQFqmSHeLGTHA
	VxZLg5Hp8skY5v1BsnD8JoaE6r7Kk88+p56wgXuKRoyOK5UiXAvcvnEtHuHvSq+bWyE4bwZ2bZ
X-Received: by 2002:a17:90b:4c84:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-395df2595d4mr19966783a91.9.1787507987364;
        Sun, 23 Aug 2026 10:59:47 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8fd34d9sm3722818a91.1.2026.08.23.10.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:59:46 -0700 (PDT)
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
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v3 2/2] vsock/vmci: validate packet source for connected sockets
Date: Mon, 24 Aug 2026 02:58:58 +0900
Message-ID: <20260823175858.351431-3-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260823175858.351431-1-4ncienth@gmail.com>
References: <20260823175858.351431-1-4ncienth@gmail.com>
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

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/20260814121255.6B5001F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/vmw_vsock/vmci_transport.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 1c4ee039c..b612a9893 100644
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
@@ -765,17 +767,26 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
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
 
+	if (drop_pkt)
+		goto out;
+
 	if (!bh_process_pkt) {
 		struct vmci_transport_recv_pkt_info *recv_pkt_info;
 
@@ -900,6 +911,7 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 {
 	struct vmci_transport_recv_pkt_info *recv_pkt_info;
 	struct vmci_transport_packet *pkt;
+	struct sockaddr_vm src;
 	struct sock *sk;
 
 	recv_pkt_info =
@@ -908,6 +920,10 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 	pkt = &recv_pkt_info->pkt;
 
 	lock_sock(sk);
+	vsock_addr_init(&src, pkt->dg.src.context, pkt->src_port);
+	if (sk->sk_state != TCP_LISTEN &&
+	    !vsock_check_source(vsock_sk(sk), &vmci_transport, &src))
+		goto out;
 
 	/* The local context ID may be out of date. */
 	vsock_sk(sk)->local_addr.svm_cid = pkt->dg.dst.context;
@@ -937,6 +953,7 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 		break;
 	}
 
+out:
 	release_sock(sk);
 	kfree(recv_pkt_info);
 	/* Release reference obtained in the stream callback when we fetched
-- 
2.54.0

