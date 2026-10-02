Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA00443A91
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790983285; cv=none; b=aAFlZfHSZcMmWF1bvbXhUzBOkumlLSdsoQN5q1fijihhwqcc3qURb4enfrQ0Cj4ZS5O9ec2A4s0xcIvDD9+8lapapmP0eV8KA68toD9on6HCeWcUbWCXaokATHBdndux2dUV1Mf8S6jhz+LBt5HtfbpPtdyCwwV/0cdc6/3Rw3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790983285; c=relaxed/simple;
	bh=aN11gmz/fs9eR9mEHriugDYJndYk0Es2B85/4E72SH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G98J1uVXLo5ZMnoyrVqpxKTEmeNRF5kJ3Ga5w5iatC++m1V+Ygf9Z52wjxmKS4OBSuhy7h0M1RUwS9n7muHOpR2pL71gLPklS7l5IImYXYTg2IM8qpY//Vya8KZf2xuPlDoq7zxnLYbfkn7isorwZj7MmyVwE9yKRdZAE0ravvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CwByu03t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CwByu03t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790983281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Gu5fXl9HPDwt6SyHcDYg+cVhoCYdqttYhbUDj76UUA=;
	b=CwByu03tbRsLt8YVUqy1SS2lFSNgnkm1wFtrEJmrQwokhweYFZ+EoS8Dh+Zl4QqiY6oY0s
	yzpwNNDnf52Vaf4Iz7HzEEy6qkkKF8S02X23cbqSbcQOWRaFNk6ZGljGcVgDnDgJLpxFB8
	c3R0lyKT1QgqMsPrxhg9kXc5M93UW0o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-sVMaZlobPVO70J9ghc1P5A-1; Fri,
 02 Oct 2026 19:21:18 -0400
X-MC-Unique: sVMaZlobPVO70J9ghc1P5A-1
X-Mimecast-MFC-AGG-ID: sVMaZlobPVO70J9ghc1P5A_1790983277
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42C1A1955F25;
	Fri,  2 Oct 2026 23:21:17 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 09DDB418;
	Fri,  2 Oct 2026 23:21:15 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: edumazet@kernel.org
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC 2/2] dlm: fix socket hang on send buffer limitation with socket error
Date: Fri,  2 Oct 2026 19:21:07 -0400
Message-ID: <20261002232107.1578646-3-aahringo@redhat.com>
In-Reply-To: <20261002232107.1578646-1-aahringo@redhat.com>
References: <20261002232107.1578646-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

As Sashiko AI bot mentioned [0], a socket connection can get stuck when
the send buffer limitation is reached and a socket error simultaneously
occurs.

This issue can be reproduced with the following setup:
1. Set sk_sndbuf to SOCK_MIN_SNDBUF.
2. Slow down DLM connections using netem.
3. Use tcpkill to randomly send TCP resets to DLM connections.

I instrumented debug printouts to confirm that the sk_write_space()
notifier callbacks were being executed, using step 3 to trigger random
socket errors.

With these changes, I can no longer reproduce the hang.

Changes included:
- Removed sk_write_pending counting, as this should not be modified
  at the socket application layer (or is at least unnecessary).
- Moved clearing the CF_SEND_PENDING bit—which allows re-queuing
  swork (send worker for sendmsg())—to the sk_write_space() callback,
  since this callback notifies us that the underlying socket is no longer
  constrained by its send buffer.
- Handled the race condition between sendmsg() and evaluating
  SOCK_NOSPACE after sendmsg(), where sk_write_space() could be called
  in between, using CF_APP_LIMITED:
  - In sk_write_space(), queue swork again if CF_APP_LIMITED is set.
  - If CF_APP_LIMITED is not set, do nothing as send_to_sock() will handle
    it, confirming the race occurred.
- Introduced new handling in lowcomms_error_report() when a socket error
  occurs during send buffer limitation. If CF_APP_LIMITED is set, swork
  will be re-queued, which will fail and trigger a reconnect.
- Added various comments explaining the interaction with CF_APP_LIMITED.

[0] https://lore.kernel.org/netdev/179090395863.434549.3668493667259120759@kernel.org/

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lowcomms.c | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index c3a414d2e32b..29ee1b52d0df 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -521,12 +521,20 @@ static void lowcomms_write_space(struct sock *sk)
 
 	sk_clear_nospace(sk);
 
-	spin_lock_bh(&con->writequeue_lock);
-	if (test_and_clear_bit(CF_APP_LIMITED, &con->flags))
-		con->sock->sk->sk_write_pending--;
-
-	lowcomms_queue_swork(con);
-	spin_unlock_bh(&con->writequeue_lock);
+	if (test_and_clear_bit(CF_APP_LIMITED, &con->flags)) {
+		/* signal to send again by clearing
+		 * CF_SEND_PENDING and queue swork.
+		 */
+		spin_lock_bh(&con->writequeue_lock);
+		clear_bit(CF_SEND_PENDING, &con->flags);
+		lowcomms_queue_swork(con);
+		spin_unlock_bh(&con->writequeue_lock);
+	} else {
+		/* CF_APP_LIMITED is cleared, so send_to_sock() will
+		 * simply reschedule work without hitting the
+		 * CF_APP_LIMITED path.
+		 */
+	}
 }
 
 static void lowcomms_state_change(struct sock *sk)
@@ -623,6 +631,23 @@ static void lowcomms_error_report(struct sock *sk)
 		break;
 	}
 
+	/* if waiting on sk_write_space() and an sk_err occurs, the callback
+	 * won't fire. Clear CF_SEND_PENDING and if CF_APP_LIMITED was set
+	 * so resend tasks can re-queue swork, triggering a sendmsg() failure
+	 * to initiate reconnection.
+	 */
+	if (test_and_clear_bit(CF_APP_LIMITED, &con->flags)) {
+		spin_lock_bh(&con->writequeue_lock);
+		clear_bit(CF_SEND_PENDING, &con->flags);
+		/* dlm_midcomms_unack_msg_resend() does not always
+		 * trigger lowcomms_queue_swork() as it tries to
+		 * avoid to put pending messages into the lowcomms
+		 * sending buffer. Force it here again.
+		 */
+		lowcomms_queue_swork(con);
+		spin_unlock_bh(&con->writequeue_lock);
+	}
+
 	dlm_midcomms_unack_msg_resend(con->nodeid);
 
 	listen_sock.sk_error_report(sk);
@@ -1391,18 +1416,19 @@ static int send_to_sock(struct connection *con)
 		spin_lock_bh(&con->writequeue_lock);
 		if (test_bit(SOCK_NOSPACE, &con->sock->flags) &&
 		    !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {
-			con->sock->sk->sk_write_pending++;
-
-			clear_bit(CF_SEND_PENDING, &con->flags);
 			spin_unlock_bh(&con->writequeue_lock);
 			release_sock(con->sock->sk);
 
-			/* wait for write_space() event */
+			/* wait for sk_write_space() event */
 			return DLM_IO_END;
 		}
 		spin_unlock_bh(&con->writequeue_lock);
 		release_sock(con->sock->sk);
 
+		/* the sk_write_space() came in between sock_sendmsg()
+		 * and check on SOCK_NOSPACE and the socket became
+		 * writeable again so just resched swork.
+		 */
 		return DLM_IO_RESCHED;
 	} else if (ret < 0) {
 		return ret;
-- 
2.43.0

