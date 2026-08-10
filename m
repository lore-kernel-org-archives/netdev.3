Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89562416CFE
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381853; cv=none; b=XlkoamdjAw4nHCG8X+wMTNq0uHFr9ThdE1HLP1Z9379qUF8P3ErFO+fPC+SFsuvfR7KOKwwWJszXpgEVfjd/JwdhpCMUDa0FwdESGE0Or6sqvgvcg6K/oM0U4lWw9vthK7EYPRjxcMmnkYQGVYS9D7ZLAAFFeAzT1+hvsAiHD9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381853; c=relaxed/simple;
	bh=UG8CVmhUiNXkcyAixv/sxJGkEM5W+KEMJZCoNAJk8ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGrNixc2ZJjYa4aR6R9x2lblNO9sRK6T+XgVtgEBCsQxCerODuFKDhBvri1SCyZxeOE2ouRIyVUW8BA0WxZGdBOm2F+vElLgDc9OxNharpAECRNSKnb+p56JAMBxrDdmOkEku04T7snkxJpEcfD1N5Jg87M4IN/rdWgQNAxssVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Koh39bO7; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Koh39bO7"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso122015a91.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786381852; x=1786986652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HIzXZz56o+MmOQNy7Jnj/dfQQWOM2HS0FnwvviI6E/Y=;
        b=Koh39bO7kdpGXz6+0PN/XmN9NeQ092SUPi/mRMIWe7nA349shVdRyYlAl2E9xB/c7I
         U44FKSd1p6YaGAdY2CrCbOAQ93jkYNgjw/wLUYsO4OVJMwcawuVYZz4GEwiCiLkAZFdv
         S/WfzLHNCqF4rpfeP+WVEsYIdmz9JKRY+OVZcWc2riJwSQpqYf0ouHkkZxpA8crgqpL0
         ev3nzSebLLMbyd8AyqI6QHcw5LaYQDFbmwRuP7yDRI4Krxxs38wjGx/uBitThTfHFS5Y
         22G/XNDvPyNjiQl5opvWVbRNak1yFj3gpCN0Jtbdsqs1xx6abgT1ENs2rwvav5sPLtqB
         WnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786381852; x=1786986652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HIzXZz56o+MmOQNy7Jnj/dfQQWOM2HS0FnwvviI6E/Y=;
        b=Qy1z974e+yHJSQeJA4OqcLWquNHjctC1rs2DFH6yZmKiwBuCJRG8X4+KPhzd7X6ar+
         ueLw9xRr2tX6KyOKLxokwVA1A10T60yJWqra8s4Yt5kZ/GaF8vSDLrqL6Ye+ajoZiy08
         RgB7m8NVCww/nKrCA9uMapq4m25mELglWu9I5t5boJPRgr6oHaFZTPthJG5iNnapt57V
         uhZhRs7Yb0BrqN4vfnmD+jF4e3Hpzie+5e/aiUuKVGV5E8wSpQN6K/0g5m07elW/7J8n
         I4VFeTHShCrhDHUhlnHomfofRpOxY82c7QLcJgCTqDavgJluNPY0lsh6zD6pJbvmt07B
         2AnA==
X-Forwarded-Encrypted: i=1; AHgh+RozV8lfHwNIU2a3T8isblLcp4Ei0JWIE5+8pw2dE1oIVrFmTYKHm3GlZjpmygXlodrv44vGc+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMhlCpXVLj8Y7x8XcZD1p3bXcoVAYXLuozaKeDCZe2qiiuNlJx
	DKV9YzgZeRpvlEp/wddUfdhJHHm1Q0TVVDqs3dKu1DwvHL5LsebwTrNz
X-Gm-Gg: AR+sD11sL2NCNuqciC2ssRJD7Kk0JEg/ZSpeuVh9BHJl3rO7LOJz4nGmdXXs8leegmn
	8UrGqdV+6canKOGCPr84RkUJA0DxfF4uDN9eYjtdMEi8OjQubzwAc6BH8p7PSZSYGMJQ7raV3b4
	ha8z08+dnjDJJ8hCFjHy3M+fU0VqZjsiLnsxqTpzbpbqNPM3KiCeFkxBp3TaOkAU/kboAYMf+/n
	lkvBC796aNUMKDiQT/9FFTYPK6+WGI9TPhxMVoLoYhbBQkTpV0ap0+SCAgR+jSHm0KgsTRAbVYH
	+gymQ8i26rf9Zb7TZ8rXpZAqiCDU/gF1r7NT3gbZTD/UHd2Lp8dqJlRrXYQWWhyAvJriPtriZGX
	Zmvd2edliWBIkXRfu3FurE2UtIJGjZMkrK8e1YaAE7c5dBl0qUCLFPDmOn3YmqL1HNb9YOeL6nd
	8ZSxkqIZVPv0yUWdz/DX7XDN83VT8b9e0GfJtKQ412Eed7GSpTRfr75FFr5BYfAg==
X-Received: by 2002:a17:90b:4c42:b0:38f:cab0:9aa9 with SMTP id 98e67ed59e1d1-39284703808mr10229761a91.13.1786381851592;
        Mon, 10 Aug 2026 10:10:51 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1410199cf49sm37194663c88.3.2026.08.10.10.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 10:10:50 -0700 (PDT)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] vsock: remove the now-unused rejected flag
Date: Tue, 11 Aug 2026 01:09:31 +0800
Message-ID: <20260810170935.2242314-3-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810170935.2242314-1-phind.uet@gmail.com>
References: <20260810170935.2242314-1-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After previous patch, the branch marking a socket rejected in
vsock_accept() is unreachable, and nothing ever sets vsk->rejected
elsewhere.

Therefore, we can remove the `rejected` field from vsock_sock structure.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 include/net/af_vsock.h   |  5 +----
 net/vmw_vsock/af_vsock.c | 46 +++++++++++++---------------------------
 2 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 30046a3c20f7..3357ee62d10b 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -52,13 +52,10 @@ struct vsock_sock {
 	 * The listening socket is the head for both lists.  Sockets created
 	 * for connection requests are placed in the pending list until they
 	 * are connected, at which point they are put in the accept queue list
-	 * so they can be accepted in accept().  If accept() cannot accept the
-	 * connection, it is marked as rejected so the cleanup function knows
-	 * to clean up the socket.
+	 * so they can be accepted in accept().
 	 */
 	struct list_head pending_links;
 	struct list_head accept_queue;
-	bool rejected;
 	struct delayed_work connect_work;
 	struct delayed_work pending_work;
 	struct delayed_work close_work;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index ff507761f472..b59890bbd217 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -38,10 +38,9 @@
  * pending socket.  When that socket reaches the connected state, it is removed
  * from the listener socket's pending list and enqueued in the listener
  * socket's accept queue.  Callers of accept(2) will accept connected sockets
- * from the listener socket's accept queue.  If the socket cannot be accepted
- * for some reason then it is marked rejected.  Once the connection is
- * accepted, it is owned by the user process and the responsibility for cleanup
- * falls with that user process.
+ * from the listener socket's accept queue. Once the connection is accepted,
+ * it is owned by the user process and the responsibility for cleanup falls
+ * with that user process.
  *
  * - It is possible that these pending sockets will never reach the connected
  * state; in fact, we may never receive another packet after the connection
@@ -49,9 +48,7 @@
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
@@ -774,11 +771,10 @@ static void vsock_pending_work(struct work_struct *work)
 
 	if (vsock_is_pending(sk)) {
 		vsock_remove_pending(listener, sk);
-	} else if (!vsk->rejected) {
-		/* We are not on the pending list and accept() did not reject
-		 * us, so we must have been accepted by our user process.  We
-		 * just need to drop our references to the sockets and be on
-		 * our way.
+	} else {
+		/* We are not on the pending list so we must have been accepted
+		 * by our user process. We just need to drop our references to
+		 * the sockets and be on our way.
 		 */
 		cleanup = false;
 		goto out;
@@ -942,7 +938,6 @@ static struct sock *__vsock_create(struct net *net,
 	vsk->listener = NULL;
 	INIT_LIST_HEAD(&vsk->pending_links);
 	INIT_LIST_HEAD(&vsk->accept_queue);
-	vsk->rejected = false;
 	vsk->sent_request = false;
 	vsk->ignore_connecting_rst = false;
 	WRITE_ONCE(vsk->peer_shutdown, 0);
@@ -1912,26 +1907,15 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 		lock_sock_nested(connected, SINGLE_DEPTH_NESTING);
 		vconnected = vsock_sk(connected);
 
-		/* If the listener socket has received an error, then we should
-		 * reject this socket and return.  Note that we simply mark the
-		 * socket rejected, drop our reference, and let the cleanup
-		 * function handle the cleanup; the fact that we found it in
-		 * the listener's accept queue guarantees that the cleanup
-		 * function hasn't run yet.
-		 */
-		if (err) {
-			vconnected->rejected = true;
-		} else {
-			newsock->state = SS_CONNECTED;
-			sock_graft(connected, newsock);
+		newsock->state = SS_CONNECTED;
+		sock_graft(connected, newsock);
 
-			set_bit(SOCK_CUSTOM_SOCKOPT,
-				&connected->sk_socket->flags);
+		set_bit(SOCK_CUSTOM_SOCKOPT,
+			&connected->sk_socket->flags);
 
-			if (vsock_msgzerocopy_allow(vconnected->transport))
-				set_bit(SOCK_SUPPORT_ZC,
-					&connected->sk_socket->flags);
-		}
+		if (vsock_msgzerocopy_allow(vconnected->transport))
+			set_bit(SOCK_SUPPORT_ZC,
+				&connected->sk_socket->flags);
 
 		release_sock(connected);
 		sock_put(connected);
-- 
2.53.0

