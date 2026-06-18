Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C3B31E848
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790546; cv=none; b=uQ6A4oi+HH7Xt4fkpPhYhvWXmfZLr+4osjx/hdhu2e8FD+CTXMkr/93ARMC02qXqjDRzct5UdwQmJ/SfSWeL5rnGZqXq3kpuu6X2WJ7g80G/bGlR3tnXBFjZmVgGYo+NhYxVsnCWv54bKpJHxXbj/5lh8ZAu7hLo6YB7Ba0lMkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790546; c=relaxed/simple;
	bh=733biS4oj18vSDQkM4AUm3Ha+CkFbGtg7Qd2zuCOqmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMilaSOolfJKoz5c7I2AYSunTinCqUisviuvfMCjOQr/fnYHLQn6xJoSjiT39jV2B0iqtkMQuusmygTOn1+useXaVmzQBzL4jn2Zd2XqRGCG+Zotd7ggRPtaoGuDMdq5L8VQq/LNkoncPsLu9GXC4sOA/wtORnHti0waJUA+B7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+JUC1QH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+JUC1QH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781790542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtfFoiBY4JhPnDkUv0a33nC5pq+OP60m5nJ6IWCduzo=;
	b=L+JUC1QH+yrhXFcrXJLLBjn8R/vl+BukLHU9nVQ49HP3elObmxFMbp/xVQ49FI0XXTxYw4
	x0+In8djgtPXqxKOMdgb1R2vHHFvKnqu4QIwbOPPJUuwaP1Bngeo3f68dbw2bAMGgzdEev
	mLvWL29vCBiOhMFpK/XxgpNFLmaNp+w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-3yn6mUP_Pji-Az52fEGIfQ-1; Thu,
 18 Jun 2026 09:48:58 -0400
X-MC-Unique: 3yn6mUP_Pji-Az52fEGIfQ-1
X-Mimecast-MFC-AGG-ID: 3yn6mUP_Pji-Az52fEGIfQ_1781790537
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C1981805C1D;
	Thu, 18 Jun 2026 13:48:54 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C52CE1955F76;
	Thu, 18 Jun 2026 13:48:50 +0000 (UTC)
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
Subject: [PATCH net v2 08/10] rxrpc: Fix potential infinite loop in rxrpc_recvmsg()
Date: Thu, 18 Jun 2026 14:47:59 +0100
Message-ID: <20260618134802.2477777-9-dhowells@redhat.com>
In-Reply-To: <20260618134802.2477777-1-dhowells@redhat.com>
References: <20260618134802.2477777-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix the wait in rxrpc_recvmsg() also take check the oob queue.

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
 net/rxrpc/recvmsg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 39a03684432d..f382a47c6eb0 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -438,7 +438,8 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		return -EAGAIN;
 	}
 
-	if (list_empty(&rx->recvmsg_q)) {
+	if (list_empty(&rx->recvmsg_q) &&
+	    skb_queue_empty_lockless(&rx->recvmsg_oobq)) {
 		ret = -EWOULDBLOCK;
 		if (timeo == 0) {
 			call = NULL;

