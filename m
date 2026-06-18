Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A72D9ECA
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790536; cv=none; b=ovwZj9zd/UAqBbqQXAf+hqpaeFa+B7mUtZ/z3EN1FkrVw4WcgqQMY8TManCNTylKcAogJ+N8Q3l2uNL+72QvatBI70fXWXDL3eaJ2d2wRXaa1vqESuhpLQF6u3ahCN1x0UnPf0LGbFV1ZJ63W+1nO8AnbdvtuLkN70LKoyhBvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790536; c=relaxed/simple;
	bh=BjpO/+twHjiPheCNQW2a/W2ddyBORgwr5Nlb7wy0gE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnLI8LHYLHDFRnRcmh+yxWeaDp9kqWdU+MDZskV2G1ZyEZXBn+VZ2JWj84lS67g5BG4G45/+c5PlKa3MYVopFaukwDV40OlbTYa168q5NlwgQoX2eV9iryQErdR7KV9VA0vY98ZfHXhuDR0OFrVqc4MhDBukC5ta2X1NdKx7GwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6AYe+Zf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6AYe+Zf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781790534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omyQEdOOKgjqCdiWLWyNGSXB7YTbMvbcxjiSc+t8KZ0=;
	b=W6AYe+ZfrByi77rdJcKS00jX/xYhu0JwtTULu5E7IoNm2GZuWkiHDjs8mP9iY8MNSWMKrx
	8bRuTPbpbz5mPjkAOn5fXizGKQ4tKFAS0rXPaeLXM0iJoK0MYkpXIcYE2vvpWLsbZtRs0/
	MsLdwZ3Xqc3Nz1tpfQaLyc+PnU/XB60=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-ocFYBd_eMmqCzAZaBolkiQ-1; Thu,
 18 Jun 2026 09:48:51 -0400
X-MC-Unique: ocFYBd_eMmqCzAZaBolkiQ-1
X-Mimecast-MFC-AGG-ID: ocFYBd_eMmqCzAZaBolkiQ_1781790529
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 313FC195D037;
	Thu, 18 Jun 2026 13:48:49 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2755C1800678;
	Thu, 18 Jun 2026 13:48:44 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH net v2 07/10] rxrpc: Fix oob challenge leak in cleanup after notification failure
Date: Thu, 18 Jun 2026 14:47:58 +0100
Message-ID: <20260618134802.2477777-8-dhowells@redhat.com>
In-Reply-To: <20260618134802.2477777-1-dhowells@redhat.com>
References: <20260618134802.2477777-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix rxrpc_notify_socket_oob() to return an indication of failure in the
event that it failed to queue a packet and fix rxrpc_post_challenge() to
clean up the connection ref in such an event.

Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Link: https://sashiko.dev/#/patchset/20260616155749.2125907-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 net/rxrpc/ar-internal.h | 4 ++--
 net/rxrpc/conn_event.c  | 9 +++++++--
 net/rxrpc/oob.c         | 7 +++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 98f2165159d7..ead3419f08b7 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1355,9 +1355,9 @@ static inline struct rxrpc_net *rxrpc_net(struct net *net)
 }
 
 /*
- * out_of_band.c
+ * oob.c
  */
-void rxrpc_notify_socket_oob(struct rxrpc_call *call, struct sk_buff *skb);
+bool rxrpc_notify_socket_oob(struct rxrpc_call *call, struct sk_buff *skb);
 void rxrpc_add_pending_oob(struct rxrpc_sock *rx, struct sk_buff *skb);
 int rxrpc_sendmsg_oob(struct rxrpc_sock *rx, struct msghdr *msg, size_t len);
 
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index c96ca615b787..611c790bc6d0 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -436,7 +436,7 @@ static bool rxrpc_post_challenge(struct rxrpc_connection *conn,
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rxrpc_call *call = NULL;
 	struct rxrpc_sock *rx;
-	bool respond = false;
+	bool respond = false, queued = false;
 
 	sp->chall.conn =
 		rxrpc_get_connection(conn, rxrpc_conn_get_challenge_input);
@@ -472,8 +472,13 @@ static bool rxrpc_post_challenge(struct rxrpc_connection *conn,
 	}
 
 	if (call)
-		rxrpc_notify_socket_oob(call, skb);
+		queued = rxrpc_notify_socket_oob(call, skb);
 	rcu_read_unlock();
+	if (call && !queued) {
+		rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
+		sp->chall.conn = NULL;
+		return false;
+	}
 
 	if (!call)
 		rxrpc_post_packet_to_conn(conn, skb);
diff --git a/net/rxrpc/oob.c b/net/rxrpc/oob.c
index 3318c8bd82ad..c80ee2487d09 100644
--- a/net/rxrpc/oob.c
+++ b/net/rxrpc/oob.c
@@ -32,11 +32,12 @@ struct rxrpc_oob_params {
  * Post an out-of-band message for attention by the socket or kernel service
  * associated with a reference call.
  */
-void rxrpc_notify_socket_oob(struct rxrpc_call *call, struct sk_buff *skb)
+bool rxrpc_notify_socket_oob(struct rxrpc_call *call, struct sk_buff *skb)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rxrpc_sock *rx;
 	struct sock *sk;
+	bool queued = false;
 
 	rcu_read_lock();
 
@@ -49,6 +50,7 @@ void rxrpc_notify_socket_oob(struct rxrpc_call *call, struct sk_buff *skb)
 			skb->skb_mstamp_ns = rx->oob_id_counter++;
 			rxrpc_get_skb(skb, rxrpc_skb_get_post_oob);
 			skb_queue_tail(&rx->recvmsg_oobq, skb);
+			queued = true;
 
 			trace_rxrpc_notify_socket(call->debug_id, sp->hdr.serial);
 			if (rx->app_ops)
@@ -56,11 +58,12 @@ void rxrpc_notify_socket_oob(struct rxrpc_call *call, struct sk_buff *skb)
 		}
 
 		spin_unlock_irq(&rx->recvmsg_lock);
-		if (!rx->app_ops && !sock_flag(sk, SOCK_DEAD))
+		if (queued && !rx->app_ops && !sock_flag(sk, SOCK_DEAD))
 			sk->sk_data_ready(sk);
 	}
 
 	rcu_read_unlock();
+	return queued;
 }
 
 /*

