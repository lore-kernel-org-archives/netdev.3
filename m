Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E766733ADA3
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319156; cv=none; b=L/5vSaB3aiIbHctdSTQi+wcJe6IHV5NwOm0Qk5P4SJuxEmGwiQ5pBIMBHf/dlBKOWywpXF6SOvn5j27M7VA4lHkjeur0HtT+R3CmhGomHgHzcYwAbgCbt11PDRc7BDfeJH2t16Z4nX6GMhs9u0VUsJTYVj+ThEgKlr5Y+Wcgt1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319156; c=relaxed/simple;
	bh=733biS4oj18vSDQkM4AUm3Ha+CkFbGtg7Qd2zuCOqmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGQIcIfVrwHNEB4rqXPKzmSUEjZrDy4NBreQoUp3EWwk9MdyWrhwS6MN9GAasrXuKwwyxp1YMbHOfE42XVxXAq2BvNOlGdryY+XztIz9snHAVhD83Km++zLkMQBo9URpxCx7GiDr744GD5wNRO8EnS0eYh0sRfA9G/U+qSgEJVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L57cVgNF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L57cVgNF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782319154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtfFoiBY4JhPnDkUv0a33nC5pq+OP60m5nJ6IWCduzo=;
	b=L57cVgNFLEYDvvETt38oBmPZe8mbbA2ZA0H9azi5JHIeeuIPfcV4YEORAXsN1e8pjK1aKJ
	pdjEc0AJ6N5gVTfBAX57Bcr/AkS8InDTp82AjJ2aUXNyiX2skmOv0Cd3glsgMDxVSVFKPH
	n8ncyng+s/0knQROXcXptgAhlHsq+Is=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-IWWkdNbtMpGn8yLrFQB_WQ-1; Wed,
 24 Jun 2026 12:39:12 -0400
X-MC-Unique: IWWkdNbtMpGn8yLrFQB_WQ-1
X-Mimecast-MFC-AGG-ID: IWWkdNbtMpGn8yLrFQB_WQ_1782319150
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1DDA1954125;
	Wed, 24 Jun 2026 16:39:10 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 60D6C765;
	Wed, 24 Jun 2026 16:39:07 +0000 (UTC)
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
Subject: [PATCH net v3 08/11] rxrpc: Fix potential infinite loop in rxrpc_recvmsg()
Date: Wed, 24 Jun 2026 17:38:15 +0100
Message-ID: <20260624163819.3017002-9-dhowells@redhat.com>
In-Reply-To: <20260624163819.3017002-1-dhowells@redhat.com>
References: <20260624163819.3017002-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

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

