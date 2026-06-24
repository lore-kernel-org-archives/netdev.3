Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B446331EC0
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319170; cv=none; b=HHXWHVKex5tQe1gB5ukDNBq+YI5XojJbHtZfNmzgarKAYbGbMkA0pdWHSSjBgI/4fM/ZX7iVpoDC8ai1XfUQw/1k3OeFWw3HiLZ8BrUAWqfKtmcudZk2+i2IuoNed7nxqeCsmjp3YNJ3YHI+7EeEkCI9DtmjlYd87IJBxcg5U+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319170; c=relaxed/simple;
	bh=uESoTJVBbwU7LCEDXNKk4kWEWYRrirAy5n6AzGBpwz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A30+cBzyaA1qwUX5ptCrj3Xt+s/ml0unxmwLTlGoBLwz8Pz9hj6uPEqvQSEkQla8Mp6OjKYU/iTFbKOH5W64t3i9qqQo4bBjeBo6T+9JE+Vgooc3SoouGJbnAX0MyPbL2TjySp8BpbOnRK3aNL5wTJVT3/OXepY/fgeGw5ocuJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a41yM6k7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a41yM6k7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782319168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwSkQoYjURIOLugioMew5JuUqWF7FL9Uogq2U6NPijE=;
	b=a41yM6k7vTLU/EwSJKhZgdO11dULkPp8UWcEOP0OVTaeTAmMPQAlC/7dWU537fSOuEEhyY
	NCCOfVw891o/t+vX5aCF3tkxJqfhpZOBSRR1kjNsCAu+stsRqEHF1n33aVZjsc9LkQuAkD
	UhKStsCref6meu3AJ3iMJmODofEBUB8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-Eyg30IDBMx2YSIzEIYSHRQ-1; Wed,
 24 Jun 2026 12:39:23 -0400
X-MC-Unique: Eyg30IDBMx2YSIzEIYSHRQ-1
X-Mimecast-MFC-AGG-ID: Eyg30IDBMx2YSIzEIYSHRQ_1782319160
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 965F219540C6;
	Wed, 24 Jun 2026 16:39:20 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F21F3000235;
	Wed, 24 Jun 2026 16:39:17 +0000 (UTC)
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
Subject: [PATCH net v3 10/11] rxrpc: Fix leak of released call in recvmsg(MSG_PEEK)
Date: Wed, 24 Jun 2026 17:38:17 +0100
Message-ID: <20260624163819.3017002-11-dhowells@redhat.com>
In-Reply-To: <20260624163819.3017002-1-dhowells@redhat.com>
References: <20260624163819.3017002-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fix rxrpc_recvmsg() to also drop the ref it holds on an already-released
call if MSG_PEEK is in force (the function holds a ref on the call
irrespective of whether MSG_PEEK is specified or not).

Fixes: 962fb1f651c2 ("rxrpc: Fix recv-recv race of completed call")
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
 net/rxrpc/recvmsg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 9962e135cb73..efcba4b2e74f 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -529,8 +529,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
 		rxrpc_see_call(call, rxrpc_call_see_already_released);
 		mutex_unlock(&call->user_mutex);
-		if (!(flags & MSG_PEEK))
-			rxrpc_put_call(call, rxrpc_call_put_recvmsg);
+		rxrpc_put_call(call, rxrpc_call_put_recvmsg);
 		goto try_again;
 	}
 

