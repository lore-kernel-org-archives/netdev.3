Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748873F7A9A
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041045; cv=none; b=L9uINFDa8YXRbZXesfQRNw75cTBnaKdWe/+ghdziIdpQThcTYiWQ0GJuFZniWtn1ZBOAsz5l4llqcJZOr4pBgCE4TXXMe1oBVLb2R6cdGNcYV+xvAvWjlhFieizL79XBLFxDsVYN32ZpPd16VDcq0eggmAPMDR9aMe6s1QMIjBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041045; c=relaxed/simple;
	bh=0SwzPQiq0K33AI2cjVS+euTUF2s1lCsvoeohpqkDfZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjwyGFvRi1+XEErjXyXuYYjexontbIz53mcVF617XsfjmwiJ04k3whObQa5Gz5V7Ym1tlqFf3cU6abLTNjV1Wxkzuk9POdd2eOBrnxIrSe0a97wEAigUuswKZOHPH0F89h1CVgSGr4ymAKH0MQBcgKHVbopI7J5cPz9PKctL9/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdpVawYW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdpVawYW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775041043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JdpppyRA5L+XT2V7G6SjlP5WRQLvmrVCKEV5uP5VLSc=;
	b=FdpVawYWRzi/XWQXedOgtj6vXKyW/G2psmKd++rUmg+Ly9uV3tK5LO/cf26wlZlxOyY/77
	9kjYUKNiN4pBJY1967XCZ9cV4YpjB2350t3EcCMIzZkt+wKeUkEmOkrRxAdgU7owDBYpd7
	eiwQ6qz3aAe4q0oRG9qnRWYH0yo/aco=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-h6_kB-MTNDWyxOhqrkKjKw-1; Wed,
 01 Apr 2026 06:57:20 -0400
X-MC-Unique: h6_kB-MTNDWyxOhqrkKjKw-1
X-Mimecast-MFC-AGG-ID: h6_kB-MTNDWyxOhqrkKjKw_1775041039
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C85541955BCE;
	Wed,  1 Apr 2026 10:57:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.35.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B79C19560AB;
	Wed,  1 Apr 2026 10:57:14 +0000 (UTC)
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
Subject: [PATCH net v4 09/15] rxrpc: Fix key reference count leak from call->key
Date: Wed,  1 Apr 2026 11:56:02 +0100
Message-ID: <20260401105614.1696001-10-dhowells@redhat.com>
In-Reply-To: <20260401105614.1696001-1-dhowells@redhat.com>
References: <20260401105614.1696001-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
 

