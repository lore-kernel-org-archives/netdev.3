Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D6E4766A8
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933640; cv=none; b=TOyEi38+rIkTsQ8h8t4VzYqLSBMR5AES0mG5QoFqWSiqD+mKci+F97+l8RNVRf7C2kxqEiszKhvTETTGWQdFM0vynHdWzV59etqf9DUufKgWoKHtIS0q/mYXgY88k3hy85GMzFDaLvZ2jVI+lTIXvFfF9HCncrUE2Mm9znbe+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933640; c=relaxed/simple;
	bh=P2kW8ATtvkNqZncHYca4L+gsqhgusrW42yBbrkJoSd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkXrBHuT7EgkHSV8g1R7LcF1W+eTgROV3xvBfXA+7vbRhnYQL7qM2x9ZljNi3gWJFef1B4D2cLcVdOoCRG8vhj1lEYERqbbDXzc/B16QD5f7s/Zed2ekrjiGmJj+kzVdGjJypZMHFPG/ojtDXNgydQCjbWrkci4DHLZoRNXUfnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkSKAoB0; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkSKAoB0"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa65080so264197366b.3
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789933635; x=1790538435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ecyy9bn6zcz7JfajH979ClHOPnn+4eN95YmsvJYzOX0=;
        b=LkSKAoB0AViZ+cFiYLay5TDPK+Q63DyYLa5vMd45PAJWNuvbnoVg6emOWm9EKGgMPZ
         FucKqIMTbiv8sFsDGVSOOhkP2ssv5M6Ytt/49uryFtfSCNmYPN4onxWMlu4AEbSPC5e7
         ruCh3Jjlpf51Ekcolt7xcXm3jg6FwUZtYF1RMmC/w+9+QiiLuAn+1qYnVdwbdY9ZMSBf
         xJUhgmA3746XlQ/KH0gpAjqYt2PgM6ZEjjLpLAskxZe4E10OcBBPnTbhjCjuI+AXk1cP
         ggpbdkCDHHIlP79TUrVu7J0+dWgj6C1dktDpQ3Ds8Z6FqdHCyyXtgmCLBV1c0o6Jq3Jq
         V+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933635; x=1790538435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ecyy9bn6zcz7JfajH979ClHOPnn+4eN95YmsvJYzOX0=;
        b=OmamMGL5mWOZG1siC3ArTflbODCGl40M9ZlqnBSSSNxHgflKKrdcyXW/FQTtEo2O0C
         FVMbq8OjQaFYGRqYONmzjJZyQBqDDmB37bv7tM4q6oWjBrGqmWn9+69N10ilA9LeioE9
         RZji1KhoNDH36d//Hv0HTIMEu6qJ0RR4WB7ocGX2furHY21faOTVGOXAUWXpbT0ExolV
         7r7eC794eXToo1dc7Lq6L+pzHyZWLgwhteUmuc60OYOgLWpPJn3nR//nGcYoUbxHUcxu
         O4KAu5apDlup9Rk+1fnQrtL8FDh/QEpZQR9so19gx4ucgHhTt9Oc73CPjqpHcI5JAv9s
         NE8g==
X-Gm-Message-State: AFuF++mIKDPuLG5/voAnrvZi3O4imdZgdg2HRlMgp+FYww7lCz9DAtPw
	nPdg8Wj2EdFwdFzSikfvNk8rjA4eXkFv6rrEaRbpeRy8oz4gP9FtMz9slUcseg==
X-Gm-Gg: AYBFou0r6RHJ4ChS823YnMcDal53hdgzX8FE1uhu4huY5ZjckdIC5CQVdMWOzoo8Hy6
	HtV7ZHh6Mdd3hCyOJ3ojQApyLZtWG9eSXHLdRHExRdgy65E6X0fQq3dCCiEG+Z8mHIpQszSR+o5
	ct1VekJ7fXtF/KyBxoNm/JF99kKiE7JanyjeFa6GqpdC6FpUVgqqAlZYyTZkRXlp/SV8cURs41X
	6MW726e0PKbHfMz9z9fBiEUMdpXzAmD82GWEhp8PDuOvNuAkg4NP+sO4uG0YpDdjgPPOZ2tAQB9
	QPMf5yE+YM7qSefUPNFsVJ9bQlMmI/oqAUxP0wDLGm0i8PXSHXm0zW1LyP6p6KY7bDjuFItlm4L
	SdtsmpeHgVBsndrT8Ao/OGWZEKnZyPMIZPZckQl6vnmTrmapq6L5R7oySCrBiNYaMpkuz0S2mtC
	g5E2iABSpNbzA2figDsxI/qYJWdyGZKzFWJvfQZHgV2N2P3ailtvJ5j1PGEVa3YxLypFcajzwv8
	PsUEVJTfttnvW3afy+Ec3X5R42qyL1WOEnFsxPsOArd4YY06WuxOTHzpRg=
X-Received: by 2002:a17:907:3cd4:b0:c29:4d59:9833 with SMTP id a640c23a62f3a-c2a1569a4b8mr756590066b.15.1789933635349;
        Sun, 20 Sep 2026 12:47:15 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a358ff8edsm211768466b.61.2026.09.20.12.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:47:14 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next 1/2] vsock: report pending receive data to io_uring
Date: Sun, 20 Sep 2026 20:47:09 +0100
Message-ID: <20260920194710.1114748-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920194710.1114748-1-devnexen@gmail.com>
References: <20260920194710.1114748-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_VSOCK stream receives never fill msghdr.msg_inq, so io_uring cannot set
IORING_CQE_F_SOCK_NONEMPTY and retries a multishot receive even after the
queue has been drained.

Fill the hint at the common receive exit using the transport callback that
SIOCINQ already uses, and report 1 once the connection is finished so the
caller performs the receive which observes EOF, as TCP does after a FIN.

A vsock loopback ping-pong with io_uring multishot receive drops entries
into __vsock_connectible_recvmsg from 1.97 to 1.00 per delivered message,
and receiver CPU time by about 3% (25 runs of 50000 messages, p=0.006).

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index f840498b58af..63309708c916 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2543,6 +2543,38 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
 	return err;
 }
 
+/* Bytes a following receive can consume, 1 if it would only see EOF, or a
+ * negative value to leave the caller's hint alone.
+ *
+ * Called under the socket lock after a nonnegative stream receive, so a NULL
+ * transport implies SOCK_DONE.
+ */
+static int vsock_inq_hint(struct sock *sk)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+	s64 data;
+
+	if ((sk->sk_shutdown & RCV_SHUTDOWN) ||
+	    (sock_flag(sk, SOCK_DONE) && sk->sk_state != TCP_ESTABLISHED))
+		return 1;
+
+	if (!vsk->transport)
+		return 1;
+
+	data = vsock_stream_has_data(vsk);
+	if (data < 0)
+		return -1;
+	if (data > 0)
+		return (int)min_t(s64, data, INT_MAX);
+
+	/* Empty but finished: keep the caller reading so it sees EOF. */
+	if (sock_flag(sk, SOCK_DONE) ||
+	    (READ_ONCE(vsk->peer_shutdown) & SEND_SHUTDOWN))
+		return 1;
+
+	return 0;
+}
+
 int
 __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			    int flags)
@@ -2606,6 +2638,13 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
 
 out:
+	if (msg->msg_get_inq && err >= 0 && sk->sk_type == SOCK_STREAM) {
+		int inq = vsock_inq_hint(sk);
+
+		if (inq >= 0)
+			msg->msg_inq = inq;
+	}
+
 	release_sock(sk);
 	return err;
 }
-- 
2.55.0

