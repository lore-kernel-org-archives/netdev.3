Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E53426437
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103316; cv=none; b=InH72CGll5qYAFn4qNPjEv7dSa2C2dn/NG6XSd9UKAB7MZsZTwfCKgpGD9qQpJJDvxbMK5GcKUUR7dy7BPevSUZ80gTEzF4EOR0roLKtxsJGnY8ioI5t+J/Hmp+hRVCtsKUtbvfBmt+7RBhGaCWSkUPmZqOgFhZTf12nR2VNIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103316; c=relaxed/simple;
	bh=dBRcctB1HbE1wp3EANcrd4ceGJoZwfhb665DWjmN70M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nnej67QwKmQXvkDxEzzwYztWQ35e5HJX/NQ+qf0ja6wQvD3Y2G5QiTVssbNIfOaLTZLv4SIKx5EccIGVX4zu244tUF2Qiiy/Rcdfl8ped8Car92WE6V4v8O7XfXdA2UuRTj3nyxIyqudosPHUJytMEFl1X74hae/y/YeVTQKI0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frMM/js9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frMM/js9"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so3671895b3a.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 04:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786103309; x=1786708109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n7mwOnPyfiCCwq729LgAnh/HsggJnMmpUOleEikcENM=;
        b=frMM/js91S+8AZobTBXBz9e5mOmpdcxZlXhedXuBUQBGgdXSix1ekWfygsorDgFEER
         szlkywL3GalAntpw/ix1eYxDsC9OPsq7pkmHR+dOzUBf+3ZNE0OSYqP68KllsZfoAkdI
         4aemGysoYpGJ8SohgibXsPE7jujkRiTrZPpMgVGKIa6nmuLBTRgsIyCeaszVTg6Vr7N1
         aa2dZEPV2LdhwYDtWtFPr2QyUuuqIhv1ZIZfwZj+4geo4uN+h6LMpiZ+0JfTmjCSASUS
         J4G3xV88VFCfXY7GM+T6zcIPffDa8AzovrzDj9JegOStH+vDgcUQbT/Dv/zuqn/zCfUt
         nStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786103309; x=1786708109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n7mwOnPyfiCCwq729LgAnh/HsggJnMmpUOleEikcENM=;
        b=MC6rTi+RRj8SGY4ATZnBNH4sO+k9yYs4HRPiSPLxkWV+VEuctL5LGmXKmxfJpTlZWy
         7wjNZ55wiP2lsXu/EySqAfscV2rGEZogTSE1YmRFo0m6WQtaxbHBQZqOT8vXPVDhQ533
         nk+cZLMBSdP1/xqxcoq1As5O0Xq2sGr6+DcUSoziKLYOh6mTHciyLzWe0y/nhhYbgcbJ
         oroMZYVwZOH4pJi9woVfnxjc5Q5tKoDv9L68JuMgrVLHIwBCpURphIRzsebrKts847sc
         FnujWEbTyci5sjHcZPNn/9AW7gzeWxPw116CPaowk9kJhWSgckd2Z9DdakCB7andxlSK
         6iKw==
X-Forwarded-Encrypted: i=1; AHgh+RpkbGIm/jL63KEgbn6GhRbHaEsBwC3TGDTbqbWmlJwDU1AfYpyhr7bflViW5qMTp097JAKgLjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUIHV8fGgVDRtx9lN5Ediy43P1Dgn9j6vejv6XwxtK0yQLe7Ok
	I7CJbBMvng9wiJaN3Auv6esMnrdVh8egWm9wwcoL9qSlLHiUofDzCAKY
X-Gm-Gg: AR+sD11PEUpC6pL9irzjo+jYruQz3GO54BQ9Dt34wvqQAD9ezDaaRvnRl0/dHergmCI
	Afb23WogXdsmua1vD6iIF4klEHMPGeDgOXLpZO0jSajCXI0Vcehheg01kfFmMg5yg+1YRMrhZcv
	49pUnjClgAGegSBZtQT3emlOHTUcU06RKDsJ/2Ni+Aa92CUYdjzv5e9QaBD5wNN8u8Qc3Xrd3PD
	05rWwV68bcICKnnnIlMNX8pFnb+2FuogOp7Gtv96Y8xyTD5rwHKxZmmxHQRwLgcDiihJkp1bKrf
	yVecVCcRWCVXsAZPs+9oKBPqP9hFVC9Zc6EYwE+LVolV391fMmS+qh8P9dsQVQB+Ykqb7UqBFnK
	d/1IzsjVmFptJQpx/SSfBPP+BEBsuFMtEMiOmtmyo0iKKQa1JYhAZZDnlyfQyUZIzIBUHlaMydq
	i8fnETgOb84wulYGN8lqNuV3PGFBSSv2A466RgsqXAXUstydXB118IwA4MFcCqNfIN8uibHi78J
	g==
X-Received: by 2002:a05:6a20:3d1a:b0:3c3:719d:dfe2 with SMTP id adf61e73a8af0-3cb85f4e179mr25112695637.36.1786103308527;
        Fri, 07 Aug 2026 04:48:28 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86fc7bsm7011180eec.1.2026.08.07.04.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 04:48:28 -0700 (PDT)
From: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Asias He <asias@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chaithanya Lagisetty <nagachaithanya9911@gmail.com>,
	syzbot+53515d23498d641e21ea@syzkaller.appspotmail.com
Subject: [PATCH] vsock: fix memory leak of rejected child sockets in vsock_accept()
Date: Fri,  7 Aug 2026 11:48:04 +0000
Message-ID: <20260807114804.320862-1-nagachaithanya9911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a listener socket carries an error (e.g. sk_err set by a connect()
issued on the socket before listen()), vsock_accept() dequeues the child
from the accept queue but rejects it. Previously it only marked the child
as rejected and relied on vsock_pending_work() to clean it up. However,
rejected child sockets created through virtio_transport and vsock_loopback
never reach that cleanup path, causing the child socket, along with its
LSM blob and transport-specific state, to leak permanently.

Fix this by releasing the child's references directly in vsock_accept()
on the reject path: remove it from the connected table and drop the
references taken by sk_alloc(), __vsock_insert_connected() and
vsock_enqueue_accept(), so the socket reaches vsock_sk_destruct() and is
freed. The now-unused 'rejected' flag and its handling in
vsock_pending_work() are removed.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Reported-by: syzbot+53515d23498d641e21ea@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=53515d23498d641e21ea
Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
---
 include/net/af_vsock.h   |  4 +---
 net/vmw_vsock/af_vsock.c | 38 ++++++++++++++++++++------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 30046a3c20f7..b70cea7f754f 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -53,12 +53,10 @@ struct vsock_sock {
 	 * for connection requests are placed in the pending list until they
 	 * are connected, at which point they are put in the accept queue list
 	 * so they can be accepted in accept().  If accept() cannot accept the
-	 * connection, it is marked as rejected so the cleanup function knows
-	 * to clean up the socket.
+	 * connection, the child is cleaned up directly in vsock_accept().
 	 */
 	struct list_head pending_links;
 	struct list_head accept_queue;
-	bool rejected;
 	struct delayed_work connect_work;
 	struct delayed_work pending_work;
 	struct delayed_work close_work;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd046799..2084c88ac836 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -39,9 +39,9 @@
  * from the listener socket's pending list and enqueued in the listener
  * socket's accept queue.  Callers of accept(2) will accept connected sockets
  * from the listener socket's accept queue.  If the socket cannot be accepted
- * for some reason then it is marked rejected.  Once the connection is
- * accepted, it is owned by the user process and the responsibility for cleanup
- * falls with that user process.
+ * for some reason then it is cleaned up directly in vsock_accept().  Once the
+ * connection is accepted, it is owned by the user process and the
+ * responsibility for cleanup falls with that user process.
  *
  * - It is possible that these pending sockets will never reach the connected
  * state; in fact, we may never receive another packet after the connection
@@ -49,9 +49,7 @@
  * future, after some amount of time passes where a connection should have been
  * established.  This function ensures that the socket is off all lists so it
  * cannot be retrieved, then drops all references to the socket so it is cleaned
- * up (sock_put() -> sk_free() -> our sk_destruct implementation).  Note this
- * function will also cleanup rejected sockets, those that reach the connected
- * state but leave it before they have been accepted.
+ * up (sock_put() -> sk_free() -> our sk_destruct implementation).
  *
  * - Lock ordering for pending or accept queue sockets is:
  *
@@ -774,11 +772,11 @@ static void vsock_pending_work(struct work_struct *work)
 
 	if (vsock_is_pending(sk)) {
 		vsock_remove_pending(listener, sk);
-	} else if (!vsk->rejected) {
-		/* We are not on the pending list and accept() did not reject
-		 * us, so we must have been accepted by our user process.  We
-		 * just need to drop our references to the sockets and be on
-		 * our way.
+	} else {
+		/* We are not on the pending list, so we must have been accepted
+		 * by our user process (rejected sockets are cleaned up directly
+		 * in vsock_accept()).  We just need to drop our references to
+		 * the sockets and be on our way.
 		 */
 		cleanup = false;
 		goto out;
@@ -942,7 +940,6 @@ static struct sock *__vsock_create(struct net *net,
 	vsk->listener = NULL;
 	INIT_LIST_HEAD(&vsk->pending_links);
 	INIT_LIST_HEAD(&vsk->accept_queue);
-	vsk->rejected = false;
 	vsk->sent_request = false;
 	vsk->ignore_connecting_rst = false;
 	WRITE_ONCE(vsk->peer_shutdown, 0);
@@ -1919,14 +1916,19 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 		vconnected = vsock_sk(connected);
 
 		/* If the listener socket has received an error, then we should
-		 * reject this socket and return.  Note that we simply mark the
-		 * socket rejected, drop our reference, and let the cleanup
-		 * function handle the cleanup; the fact that we found it in
-		 * the listener's accept queue guarantees that the cleanup
-		 * function hasn't run yet.
+		 * reject this socket and return.  The child was found on the
+		 * listener's accept queue, so it still holds the references
+		 * taken by sk_alloc(), __vsock_insert_connected() and
+		 * vsock_enqueue_accept().  Drop them here so the socket is
+		 * destroyed.  We cannot defer this to vsock_pending_work():
+		 * rejected child sockets created through virtio_transport and
+		 * vsock_loopback are not cleaned up by that worker, so the
+		 * child would otherwise leak permanently.
 		 */
 		if (err) {
-			vconnected->rejected = true;
+			vsock_remove_connected(vconnected);
+			connected->sk_state = TCP_CLOSE;
+			sock_put(connected);
 		} else {
 			newsock->state = SS_CONNECTED;
 			sock_graft(connected, newsock);
-- 
2.43.0

