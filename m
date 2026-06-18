Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5173A31E848
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790555; cv=none; b=FckSnkkfGx5q4U9KICOLT7AgYEV7pt4ovJ0GE57OJeDMggxsBaq5kOhkQjIVOY8hiYxuahkbPSO0a9NHYDEZGWjrAa3ls9a3DD4AzDdwimuMDGBtrZU8rfFQn3hmSXnlFyI5iVMflQWQrtzY1ybdyeSbHm+UFhV8GMNttzJN/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790555; c=relaxed/simple;
	bh=+qGPKzcoiWSzx6lUXVtS1AB9/M749SHY2DyEb9BO06I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJJLlBOEjYyl1Me41QazXGIwq44ukJEPkz6lLUyyP8ntN4CEoBfW4pv4vWswK0pLh1vicGFc0x63roZp0FGrLRdVQiWY/PMm7QBg539/LmjyGG7dZZFkrUPPtixFKZRRMyDP2b00GeY3wqZma/s7crccal9l3la8Q/LOZgEf9VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DecOxI7a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DecOxI7a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781790553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rszhA13b5E8l3IUbxDu7AJJ7XaCO7hy2Dow+qKlO6U=;
	b=DecOxI7aU4ysBVMOHUMTyzExvBGSIuSHFJDkGFzNxM7Q+7dT7W0k23qf4vomren5qpGV7P
	phf/StBLgApvsGtsGK13FEjbnKH1PrO0xuD08UyMLxVuCUGTtxlVa0O8ABmW9FSi7qZzZC
	N5WMMyjkuG84Xl+ov7krpc5Iz01kmkc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-UwUIkR8gNYiw6RU4VuVvvQ-1; Thu,
 18 Jun 2026 09:49:10 -0400
X-MC-Unique: UwUIkR8gNYiw6RU4VuVvvQ-1
X-Mimecast-MFC-AGG-ID: UwUIkR8gNYiw6RU4VuVvvQ_1781790545
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E61D71805C07;
	Thu, 18 Jun 2026 13:49:04 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9DE921800599;
	Thu, 18 Jun 2026 13:49:01 +0000 (UTC)
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
Subject: [PATCH net v2 10/10] rxrpc: Fix leak of released call in recvmsg(MSG_PEEK)
Date: Thu, 18 Jun 2026 14:48:01 +0100
Message-ID: <20260618134802.2477777-11-dhowells@redhat.com>
In-Reply-To: <20260618134802.2477777-1-dhowells@redhat.com>
References: <20260618134802.2477777-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix rxrpc_recvmsg() to also drop the ref it holds on an already-released
call if MSG_PEEK is in force (the function holds a ref on the call
irrespective of whether MSG_PEEK is specified or not).

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
Fixes: 962fb1f651c2 ("rxrpc: Fix recv-recv race of completed call")
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
 

