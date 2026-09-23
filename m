Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D777531AFD
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170684; cv=none; b=VaTBaCyifkeQ3Yi9PTMcFnILeH+LvozBkX/rZh+Teb6MbmemoXK+cOKA9OLIaicSeB6DoWUl4fAwKuD0/430HB97eSejmZEhhfUnuySdG5WpTJ0kTP1yBHn13T6ARqqA/kbdfxDVEbVv58nQ3F+WRDyU0ZkxUry0tFtkpEnjIsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170684; c=relaxed/simple;
	bh=AjXk0+Gd7Yn5j59yY4obwLS/qlnsblLHy5mN83d/hxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2UNyTwYW15NKYEhB93vog89cNt4Kigt2DwQelcKFTKkYNB8E5D0ePEzs7pMGQu42FaQCczPqXQPr0qg42SEDkSDSg38n4ZOlhdichXJzny4VlHlDEftAQzRF+PHDM+bKM+4w9cRuN0cQMPHq1O9mT7ggOGV/L/ayHB/ng16XO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ak6sMhb3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ak6sMhb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790170679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOs69U6h5WkhhdZxfYBFLqDvSQjOycABGZRHcs8pqaI=;
	b=ak6sMhb3ff9i7c7vOJw9tBbYhGr5ZZOHs7QT2RoT6q6c7j/GKEElor+sMOe0glMsxeNAWG
	k2jpBHUdcKOdG/tkg3PrkPPmRe9W4MRu15Im8EIDQp+szVsXWfyA72hiuZMEypdgkZgHKc
	Cgub1G6RNWeF41CiIZ9a/oa2uookzn4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-pmkGBa7-O02w3cfHhJYFmg-1; Wed,
 23 Sep 2026 09:37:55 -0400
X-MC-Unique: pmkGBa7-O02w3cfHhJYFmg-1
X-Mimecast-MFC-AGG-ID: pmkGBa7-O02w3cfHhJYFmg_1790170674
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D287E180257F;
	Wed, 23 Sep 2026 13:37:53 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC77119539A7;
	Wed, 23 Sep 2026 13:37:50 +0000 (UTC)
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
	Jeffrey Altman <jaltman@auristor.com>
Subject: [PATCH net v11 07/17] rxrpc: Fix sendmsg length
Date: Wed, 23 Sep 2026 14:36:54 +0100
Message-ID: <20260923133706.1496540-8-dhowells@redhat.com>
In-Reply-To: <20260923133706.1496540-1-dhowells@redhat.com>
References: <20260923133706.1496540-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

rxrpc_send_data() is given two data lengths (len and msg->msg_iter.count)
and is inconsistent about how it uses them.  Fix this by using len in
preference to msg->msg_iter.count.  Also limit the amount copied to either
len or msg->msg_iter.count, whichever is smaller.

Note that, currently, all the callers have len and msg->msg_iter.count the
same and so the problem won't occur.  This is a prerequisite for another
patch that fixes the handling of encryption errors.

Fixes: 382d7974de31 ("RxRPC: Use iov_iter_count() in rxrpc_send_data() instead of the len argument")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
---
 net/rxrpc/sendmsg.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 393a2dcfda07..312be27ca75b 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -374,9 +374,9 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 	ret = -EMSGSIZE;
 	if (call->tx_total_len != -1) {
-		if (len - copied > call->tx_total_len)
+		if (len > call->tx_total_len)
 			goto maybe_error;
-		if (!more && len - copied != call->tx_total_len)
+		if (!more && len != call->tx_total_len)
 			goto maybe_error;
 	}
 
@@ -402,7 +402,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			 * the security header is going to be in the padded
 			 * region (enc blocksize), but the trailer is not.
 			 */
-			remain = more ? INT_MAX : msg_data_left(msg);
+			remain = more ? INT_MAX : len;
 			txb = call->conn->security->alloc_txbuf(call, remain, sk->sk_allocation);
 			if (!txb) {
 				ret = -ENOMEM;
@@ -416,8 +416,8 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 		_debug("append");
 
 		/* append next segment of data to the current buffer */
-		if (msg_data_left(msg) > 0) {
-			size_t copy = umin(txb->space, msg_data_left(msg));
+		if (len > 0) {
+			size_t copy = min3(txb->space, len, msg_data_left(msg));
 
 			_debug("add %zu", copy);
 			if (!copy_from_iter_full(txb->data + txb->offset,
@@ -428,6 +428,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			txb->len += copy;
 			txb->offset += copy;
 			copied += copy;
+			len -= copy;
 			if (call->tx_total_len != -1)
 				call->tx_total_len -= copy;
 		}
@@ -439,8 +440,8 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 		/* add the packet to the send queue if it's now full */
 		if (!txb->space ||
-		    (msg_data_left(msg) == 0 && !more)) {
-			if (msg_data_left(msg) == 0 && !more)
+		    (len == 0 && !more)) {
+			if (len == 0 && !more)
 				txb->flags |= RXRPC_LAST_PACKET;
 
 			ret = call->security->secure_packet(call, txb);
@@ -449,7 +450,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			rxrpc_queue_packet(rx, call, txb, notify_end_tx);
 			call->tx_pending = NULL;
 		}
-	} while (msg_data_left(msg) > 0);
+	} while (len > 0 && msg_data_left(msg) > 0);
 
 success:
 	ret = copied;

