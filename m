Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0910C3C1980
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650439; cv=none; b=SZfoDIEBJ0sOjDJz9iJ9UjD1bHzsyjwykV07VALGgW0dF2yVvIxAvtrgXQ1eKEyo3BYVD5fhHr8YJb6pOyYC7gjYVEI1ks0WDCyvaX3P/dQ9qFbt006QZ9hs0sS5EZJ20Ahxkdp20z3pTQPBVk/lcNy/Zy01O2xncBtE+5IVekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650439; c=relaxed/simple;
	bh=0SwzPQiq0K33AI2cjVS+euTUF2s1lCsvoeohpqkDfZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ID9hbZ0aOzn4PQxwh1kWMrvd/5DUFuH4+lmXLY4cClIeXXFZg9M3LKXXGwi5tnoBgijrJQ62DUMjNj9EsQak+DGJsSi4JxgQBBu2yxhKKEewoo/rCbMGucO2kUPlXoFgjfS3hi6oy0xmRcUwgVJFODBdh5bwKFaUF5DKdiiyptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GyrZ6cSs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyrZ6cSs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775650430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JdpppyRA5L+XT2V7G6SjlP5WRQLvmrVCKEV5uP5VLSc=;
	b=GyrZ6cSstmjAO+X2d2IEpLbmak8cWO4fKbq3XtAlznAmuqY2iGHUfnGZYgCR+BZt5fx4Mj
	6IePIe+OwlaFH7vIP/ZWAVsRJ0BD7gTzeX80IiWclNhwqwk1XPO0jfxEGZGXiLTjhK3XhD
	ouhvekt26FdqkefFKEWxQRPICjryr20=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-bwaO0MSsPI6-ik3rVQQh9g-1; Wed,
 08 Apr 2026 08:13:47 -0400
X-MC-Unique: bwaO0MSsPI6-ik3rVQQh9g-1
X-Mimecast-MFC-AGG-ID: bwaO0MSsPI6-ik3rVQQh9g_1775650425
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11F6D1955E75;
	Wed,  8 Apr 2026 12:13:45 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48C5F1800762;
	Wed,  8 Apr 2026 12:13:41 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anderson Nascimento <anderson@allelesecurity.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	stable@kernel.org
Subject: [PATCH net v5 08/21] rxrpc: Fix key reference count leak from call->key
Date: Wed,  8 Apr 2026 13:12:36 +0100
Message-ID: <20260408121252.2249051-9-dhowells@redhat.com>
In-Reply-To: <20260408121252.2249051-1-dhowells@redhat.com>
References: <20260408121252.2249051-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Anderson Nascimento <anderson@allelesecurity.com>

When creating a client call in rxrpc_alloc_client_call(), the code obtains
a reference to the key.  This is never cleaned up and gets leaked when the
call is destroyed.

Fix this by freeing call->key in rxrpc_destroy_call().

Before the patch, it shows the key reference counter elevated:

$ cat /proc/keys | grep afs@54321
1bffe9cd I--Q--i 8053480 4169w 3b010000  1000  1000 rxrpc     afs@54321: ka
$

After the patch, the invalidated key is removed when the code exits:

$ cat /proc/keys | grep afs@54321
$

Fixes: f3441d4125fc ("rxrpc: Copy client call parameters into rxrpc_call earlier")
Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
Co-developed-by: David Howells <dhowells@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 net/rxrpc/call_object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 59329cfe1532..f035f486c139 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -692,6 +692,7 @@ static void rxrpc_destroy_call(struct work_struct *work)
 	rxrpc_put_bundle(call->bundle, rxrpc_bundle_put_call);
 	rxrpc_put_peer(call->peer, rxrpc_peer_put_call);
 	rxrpc_put_local(call->local, rxrpc_local_put_call);
+	key_put(call->key);
 	call_rcu(&call->rcu, rxrpc_rcu_free_call);
 }
 

