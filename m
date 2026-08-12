Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A16842A176
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532519; cv=none; b=hANMXN6+wGqQ14Z9pTWapv66hKy6lQ6tvFw0NshaBUA3KnLDSWRgkg82Xbdg60ZtS5RWkZHGlKJTSAt5wbdLmNA1m4IEi8e/U+9/CT0atT28frbSrSNdDUvuFkLdqTTCGSGs+IDNaoOgWgtf+ejwNA04Vm5jNjSTtZQDr8Rku+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532519; c=relaxed/simple;
	bh=TY7/aEt3ERxew+nhATYL/mM4RAbZlWlf0cZEtNrEHLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOGSO6QHbuEAlA/pHVL8kM4JhaGBQBUGO5C3pU7hB4Wpawrn05p7NKxeoRidJcK6+GhPRR0iu+uwDvshhlDI03MoehNB7pGMvSiOuWH1WLrEUBPPcfKRUZ8oh3apgi/ZgH/XL0CuFo4Ly9R6REgCLpzBCfsovmABe5IS+KFh7Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=galnkVqm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="galnkVqm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786532516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+Jic6K0goLi2dOYlF0OwhUdKxtk3nzcv3NzQkuAkKE=;
	b=galnkVqmRlzzQwC3aW1Mhdz22XkQqF9t3TzYQ7eA5jaAuyY/SFvnl+2plpQKRnlOVFVfy5
	2lel0V5dkrP53FXyC5M1sHpEYDJD18Z6cHTCcGQn+cU/oeL0QhWZTMyTlLH2cn/i7tzhDt
	cQ8xR/saqcPYepBPft8RJxFY8lTe4QA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-p_VnRwbEM1qfN6TfYxAdiQ-1; Wed,
 12 Aug 2026 07:01:49 -0400
X-MC-Unique: p_VnRwbEM1qfN6TfYxAdiQ-1
X-Mimecast-MFC-AGG-ID: p_VnRwbEM1qfN6TfYxAdiQ_1786532508
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0ED21800657;
	Wed, 12 Aug 2026 11:01:47 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 757D33002D28;
	Wed, 12 Aug 2026 11:01:43 +0000 (UTC)
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
Subject: [PATCH net v7 02/11] rxrpc: Fix sendmsg length
Date: Wed, 12 Aug 2026 12:01:17 +0100
Message-ID: <20260812110129.979970-3-dhowells@redhat.com>
In-Reply-To: <20260812110129.979970-1-dhowells@redhat.com>
References: <20260812110129.979970-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

rxrpc_send_data() is given two data lengths (len and msg->msg_iter.count)
and is inconsistent about how it uses them.  Fix this by using len in
preference to msg->msg_iter.count.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
Fixes: 382d7974de31 ("RxRPC: Use iov_iter_count() in rxrpc_send_data() instead of the len argument")
---
 net/rxrpc/sendmsg.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 4c754f78ece9..626ef5778691 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -379,9 +379,9 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 	ret = -EMSGSIZE;
 	if (call->tx_total_len != -1) {
-		if (len - copied > call->tx_total_len)
+		if (len > call->tx_total_len)
 			goto maybe_error;
-		if (!more && len - copied != call->tx_total_len)
+		if (!more && len != call->tx_total_len)
 			goto maybe_error;
 	}
 
@@ -405,7 +405,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
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
+			size_t copy = umin(txb->space, len);
 
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
 			txb = NULL;
 		}
-	} while (msg_data_left(msg) > 0);
+	} while (len > 0);
 
 success:
 	ret = copied;

