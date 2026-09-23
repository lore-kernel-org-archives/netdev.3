Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC8B534441
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188822; cv=none; b=qCZovypkAaahwu/v/VKG3pYQPYGmROGJY1E4I1I/P9doL5bu6KxRL9JITq0gNADWIH96H1sIRya0LxHfHM75JFCBWxHP8EdRg+w2/1y2YiHIEhS7NYeiGhQoL8JaTJZNoLFW+yrsnaGF2gcK9dwjoIlcL5Q+1nQT5Asdu9S7hbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188822; c=relaxed/simple;
	bh=EvUQuL+9sEfu/yTDDsYynyczprpLsvtenWv1NJgsNFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lx27+Ng+ETzlkutbJCWcRAbvxNL76anwuKUdSIWlPelchVmIiTftZWOFyEpysDEERUt2hKMN27+Z/53KqurTxFCWEDzsCL4ojQbes1+nI5Lj3Xa394ZkdZKO50VNv1IgPWykuQZVCxhYgOnchAjtCMkmOmpdW2B4u9J5Ef0M7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXU0bD/a; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXU0bD/a"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ef15c1so158537266b.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790188812; x=1790793612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JlVZpnAHAmHOvMabqqtARGu8SxbZU7qizTP5GLSJRM8=;
        b=SXU0bD/aaPLax4TXYMVFvLchdTACOZD3WoXSwdY7ltH24VEYxKen7mvixOWF0jzSJX
         9P7aV6FJ9wOw4bt5pc338ZuTxUVw3avSvyEtaffVlW9Ahlsfmpp7wQWijsteVO7Nge+p
         DeWPfHA2Vh+Ev9tPZZOVtMEfVZ7niW+U4PfxU41tO3dECif6Mcw+iDLMhrZIwSgQdfKd
         zQZ9szqf8hKcX5MW5afpWAH+bUen2gnUc/NuUupTSyVM7nxBw9dCB+RfhzDMw8v+ecjX
         Q2iWHbDq67Nn0CJOkgg7UXz3ckGIsUVtaQSmD2HBWV+PW7aOTZ30KmWnN0RBcwhkHcqH
         h92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790188812; x=1790793612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JlVZpnAHAmHOvMabqqtARGu8SxbZU7qizTP5GLSJRM8=;
        b=jbnyfgUiE+C1msJCXNFYhAu2Io8Hekvj+EWvlNFAlkK1Dt6KHrlQFOupltS4Wjw9KJ
         OM02pes/3DN3H3fHELquUOifKktB9r+awkd63Y3J3KzG1loQ9D74EXTuhYjDNvbXGkk9
         L3zyY7002vKToRy0j/A0tPazSqyzj27j8nrDa9dtU2OZG/oUjNq83Hd+6/sqpTilKA0w
         4CF07ywg8y/Vd7mxjgsQ76H8IBU4BTMR+U4KfhBJi1QxVG/c0ARuTaUmaH4CYX3jrMK8
         brtIvJal/upqw/3NAt5DNIBtheJOYaR5XKF/7YavDolRU/qJXmkXuMsAxie/NrnX9662
         p2eA==
X-Gm-Message-State: AFuF++nkp70+Lch63idB+G5IF73l3t9WSKu/2Q7shVt5kdicpdAvTbpm
	u0S0IgkMG4pewUnq06lkAPDOhS9QFaiRJwtZdz/PCtfFc1Ufh6WDJesP02nWU5aF
X-Gm-Gg: AYBFou1U/OaYwRzXS7sFrljzBcd2wbQ1uxFZuoDUKbFWUiDLLuux98ojxvgAGyguv6N
	pV5cS6qLsXV7/ngiqpbHPkrnxQfsUrffbvOSyKV5cS2LrwzHn4RE2XfR+P0RHfcq0V5eNX2607X
	cE3Kxf4kGh5KP80DgyTfVxpvQVv2gsxAiX5oMuK6m/RirWC3GBYfvJuTcQ3spVzR11o491byfNh
	tmYsWJ1d0HMkhE5R6QVuyDPlcbWe6IJR+A5FCYEjh6V3CQGHiMa/LUnIk1d2EFjGMIm7fBMPaE6
	MSSIMlEJX2Z8p73x9knQzD0NRio5+FrWXJP9UpUpBcXlvr13TvUWhDF3BkfxvuurOVXFMn+8qGl
	Sq1GKqdCf95S23he4W8zDN3snpPHZsWLRUgOCHjuUaOYV6NGIG3FIdqSWUN0jftpHF3zA9bMDaL
	Ij/kIh8sKvoLqm5HxbT54os37G5bJgykUOOVNBQui+dBk9nOWx5OZApJdAe7lok92TiTLtgtuCP
	73sIDX6xbUfSZ9dpZ3R1FENHhnmh86eu6ECsIEEjLzSqPMQVqno2n1r2gA=
X-Received: by 2002:a17:907:c71b:b0:c29:53eb:9913 with SMTP id a640c23a62f3a-c2ac2531dafmr836366b.38.1790188812262;
        Wed, 23 Sep 2026 11:40:12 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae33faf4sm173417566b.3.2026.09.23.11.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:40:11 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next v2 1/2] vsock: report pending receive data to io_uring
Date: Wed, 23 Sep 2026 19:40:07 +0100
Message-ID: <20260923184008.153541-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923184008.153541-1-devnexen@gmail.com>
References: <20260923184008.153541-1-devnexen@gmail.com>
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
 net/vmw_vsock/af_vsock.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index f840498b58af..20d6f9ca6a96 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2543,6 +2543,35 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
 	return err;
 }
 
+/* Bytes a following receive can consume, 1 if it would only see EOF, or -1
+ * if the transport cannot tell.
+ *
+ * Called under the socket lock after a nonnegative stream receive, so a NULL
+ * transport implies SOCK_DONE.
+ */
+static int vsock_stream_inq_hint(struct sock *sk)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+	s64 data;
+
+	if ((sk->sk_shutdown & RCV_SHUTDOWN) || !vsk->transport ||
+	    (sock_flag(sk, SOCK_DONE) && sk->sk_state != TCP_ESTABLISHED))
+		return 1;
+
+	data = vsock_stream_has_data(vsk);
+	if (data < 0)
+		return -1;
+	if (data > 0)
+		return min_t(s64, data, INT_MAX);
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
@@ -2606,6 +2635,12 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
 
 out:
+	/* Seqpacket has_data counts messages, while io_uring treats msg_inq as
+	 * a byte length when sizing retries, so only streams report a hint.
+	 */
+	if (msg->msg_get_inq && err >= 0 && sk->sk_type == SOCK_STREAM)
+		msg->msg_inq = vsock_stream_inq_hint(sk);
+
 	release_sock(sk);
 	return err;
 }
-- 
2.55.0

