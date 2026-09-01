Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E62D47CA73;
	Tue,  1 Sep 2026 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268882; cv=pass; b=pT3v6rijgqOUzm2zDi3P95Z7xjInuOaLJuJl8pEh0BEtwEDPOKGruPBlAtEkYst4LxAQ04B0sQF98ju09rZm9hRwZxeOJTxDUvX7IrEqIrLkAkvBh+7he051FYjyuq7Z7fv9kDUHAQLvEzG/JWsptuH4ix9fpfaHEmrcV42Ze+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268882; c=relaxed/simple;
	bh=G2u4QUEtPn+JuaH/1d7NVY9ZHJgje1rLs5v7TkeoLG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cv6m2WlqfUfo3/MEyh5el554svEyDp2EZ9WgxuJFCX8P+JURgSBtAL4wAnUoOlUMUI+E728PoUUJPKiCy2IS+3cHmqdlxTwwwO1uC+WluVBXQBXhMou/HZa/OTwlDogK7P62jkCKO/yuRrq83T7G326MCDu2h8k/ODL5u2//FlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=rwa5gCl7; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="rwa5gCl7"
Received: from mandelbrot.. (xdsl-83-150-90-33.nebulazone.fi [83.150.90.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hZ62322Pgz49QLK;
	Tue, 01 Sep 2026 16:21:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788268875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wU+Nh/TTGuJHWO4OvCj1HpjL1997pFYAxqIp0Rc3JXU=;
	b=rwa5gCl7Jt+BZksWFiIuihBwdTw0a63tcwWhSrz7lwV8PSTdXKYdHL8YZyLCXAN4e4/NWm
	mrKwudi8h9aMKL+GqBx6J8c5aH7Ldj0FaRvmrQ5RPEUa5UDi5O3tshnidtFgawypj8LNGO
	cosL39WSPlznhVOG98b5IdudnhIixnUjDUJ53A1e+tW1/E4c3jrj6Q8U578wBW0Wwxmt16
	48B7HRIuuDVA0CXd/3iVZNuDnOAtbnE3pTBsZi8o7RFPyhZaE6xiMOkkxkDUss2Psno/R8
	r61veAj8JRCZhx27iMCo5LkXIji+w0Z0b/eLDagrFdTT//FDfdiTimdppvPnnA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788268875;
	b=isavcQ37mQE3U/tAwkk9expHSb0X0jJNL7XcHL+LCmnPEYh8fzOjS6K/B/oqafxi2VTSbS
	VT8Btb9HP55Mq5H5Mb0HkrKNlLTcDs+a/7cXKWK85ifSU2PmhGCpq4CM9E5t4mpPNJg3Dt
	JsCMe/BSWsndhuAHn1SywFStKlxarNzjRhwHbPrAVRve06bIc2ifr/D5LnVPAU9ZzKvTsK
	c8sVyJ40p4x/JtRUhQ7bUXkAMvAxmf4khAfJ1b6Xe4herM1VnDC1gFurB3cKh41HY2Y+V5
	LD6A2DwyMy2sy/43zCa7BBPEyMiCaR3KTzuMcpGRJu43jth6x0um8fjLITqR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788268875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wU+Nh/TTGuJHWO4OvCj1HpjL1997pFYAxqIp0Rc3JXU=;
	b=nKxYQdty38Ai/PdbRNZiIwrWGmfUc75oArf2SXAwjbtqPyMcKZqpk2L3PI9kXNqLSxVxFg
	JBLC2kjFJjN95jwJUwzJnXGln7insxMXeWeCVtUmGPgcdIKdkmqOpLx4C24+aRSSrFgiWI
	GszJH3rqpta7DzsvBfipdr9QH/3jmrOvdy0/jKh/c2/Os8tCXd43giLsRv3+CefPmqbWor
	UDNzoDE8FCuWdsfSFdFGp31tpNEASKbr7+avkA4YCpfX4+0e2uADEHX2TTzqxQ1CO9bP9M
	LNvZxwuhL3QgWejUEEZKhH8aICno/4DD6P7Qrpn4if4beD3/eVQh/rOLCTYlxg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
From: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
To: linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Andy Gross <agross@kernel.org>,
	Mihai Moldovan <ionic@ionic.de>,
	Denis Kenzior <denkenz@gmail.com>,
	Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 06/15] net: qrtr: Report sender endpoint in aux data
Date: Tue,  1 Sep 2026 16:19:25 +0300
Message-Id: <20260901131934.225991-7-juha-matti.tilli@iki.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
References: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Kenzior <denkenz@gmail.com>

Introduce support for reporting the remote endpoint that generated a
given QRTR message to clients using AF_QIPCRTR family sockets. This is
achieved by including QRTR_ENDPOINT auxiliary data, which carries the
endpoint identifier of the message sender.  To receive this auxiliary
data, clients must explicitly opt-in by using setsockopt with the
QRTR_REPORT_ENDPOINT option enabled.

Implementation of getsockopt and setsockopt is provided.  An additional
level 'SOL_QRTR' is added to socket.h for use by AF_QIPCRTR family
sockets.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Andy Gross <agross@kernel.org>
Signed-off-by: Mihai Moldovan <ionic@ionic.de>
Signed-off-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
---
 include/linux/socket.h    |  1 +
 include/uapi/linux/qrtr.h |  6 +++
 net/qrtr/af_qrtr.c        | 77 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 2a8d7b14f1d11..4af1dd816dc35 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -400,6 +400,7 @@ struct ucred {
 #define SOL_MCTP	285
 #define SOL_SMC		286
 #define SOL_VSOCK	287
+#define SOL_QRTR	288
 
 /* IPX options */
 #define IPX_TYPE	1
diff --git a/include/uapi/linux/qrtr.h b/include/uapi/linux/qrtr.h
index f7e2fb3d752b5..6d0911984a050 100644
--- a/include/uapi/linux/qrtr.h
+++ b/include/uapi/linux/qrtr.h
@@ -46,4 +46,10 @@ struct qrtr_ctrl_pkt {
 	};
 } __packed;
 
+/* setsockopt / getsockopt */
+#define QRTR_REPORT_ENDPOINT 1
+
+/* CMSG */
+#define QRTR_ENDPOINT 1
+
 #endif /* _LINUX_QRTR_H */
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 43e48b89b5cb6..897ecc8dc304d 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -26,6 +26,10 @@
 
 #define QRTR_PORT_CTRL_LEGACY 0xffff
 
+enum {
+	QRTR_F_REPORT_ENDPOINT,
+};
+
 /**
  * struct qrtr_hdr_v1 - (I|R)PCrouter packet header version 1
  * @version: protocol version
@@ -79,6 +83,7 @@ struct qrtr_cb {
 	u32 src_port;
 	u32 dst_node;
 	u32 dst_port;
+	u32 endpoint_id;
 
 	u8 type;
 	u8 confirm_rx;
@@ -92,6 +97,7 @@ struct qrtr_sock {
 	struct sock sk;
 	struct sockaddr_qrtr us;
 	struct sockaddr_qrtr peer;
+	unsigned long flags;
 };
 
 static inline struct qrtr_sock *qrtr_sk(struct sock *sk)
@@ -567,6 +573,8 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 	if (cb->dst_port == QRTR_PORT_CTRL_LEGACY)
 		cb->dst_port = QRTR_PORT_CTRL;
 
+	cb->endpoint_id = ep->id;
+
 	if (!size || size > len || len != ALIGN(size, 4) + hdrlen)
 		goto err;
 
@@ -1130,6 +1138,7 @@ static int qrtr_recvmsg(struct socket *sock, struct msghdr *msg,
 			size_t size, int flags)
 {
 	DECLARE_SOCKADDR(struct sockaddr_qrtr *, addr, msg->msg_name);
+	struct qrtr_sock *ipc = qrtr_sk(sock->sk);
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
 	struct qrtr_cb *cb;
@@ -1155,6 +1164,10 @@ static int qrtr_recvmsg(struct socket *sock, struct msghdr *msg,
 		msg->msg_flags |= MSG_TRUNC;
 	}
 
+	if (cb->endpoint_id && test_bit(QRTR_F_REPORT_ENDPOINT, &ipc->flags))
+		put_cmsg(msg, SOL_QRTR, QRTR_ENDPOINT,
+			 sizeof(cb->endpoint_id), &cb->endpoint_id);
+
 	rc = skb_copy_datagram_msg(skb, 0, msg, copied);
 	if (rc < 0)
 		goto out;
@@ -1300,6 +1313,68 @@ static int qrtr_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	return rc;
 }
 
+static int qrtr_setsockopt(struct socket *sock, int level, int optname,
+			   sockptr_t optval, unsigned int optlen)
+{
+	struct qrtr_sock *ipc = qrtr_sk(sock->sk);
+	unsigned int val = 0;
+	int rc = 0;
+
+	if (level != SOL_QRTR)
+		return -ENOPROTOOPT;
+
+	if (optlen >= sizeof(val) &&
+	    copy_from_sockptr(&val, optval, sizeof(val)))
+		return -EFAULT;
+
+	switch (optname) {
+	case QRTR_REPORT_ENDPOINT:
+		assign_bit(QRTR_F_REPORT_ENDPOINT, &ipc->flags, val);
+		break;
+	default:
+		rc = -ENOPROTOOPT;
+	}
+
+	return rc;
+}
+
+static int qrtr_getsockopt(struct socket *sock, int level, int optname,
+			   char __user *optval, int __user *optlen)
+{
+	struct qrtr_sock *ipc = qrtr_sk(sock->sk);
+	unsigned int val;
+	int len;
+	int rc = 0;
+
+	if (level != SOL_QRTR)
+		return -ENOPROTOOPT;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	if (len < sizeof(val))
+		return -EINVAL;
+
+	switch (optname) {
+	case QRTR_REPORT_ENDPOINT:
+		val = test_bit(QRTR_F_REPORT_ENDPOINT, &ipc->flags);
+		break;
+	default:
+		rc = -ENOPROTOOPT;
+	}
+
+	if (rc)
+		return rc;
+
+	len = sizeof(int);
+
+	if (put_user(len, optlen) ||
+	    copy_to_user(optval, &val, len))
+		rc = -EFAULT;
+
+	return rc;
+}
+
 static int qrtr_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
@@ -1347,6 +1422,8 @@ static const struct proto_ops qrtr_proto_ops = {
 	.shutdown	= sock_no_shutdown,
 	.release	= qrtr_release,
 	.mmap		= sock_no_mmap,
+	.setsockopt	= qrtr_setsockopt,
+	.getsockopt	= qrtr_getsockopt,
 };
 
 static struct proto qrtr_proto = {
-- 
2.34.1

