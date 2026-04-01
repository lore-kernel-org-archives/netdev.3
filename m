Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62883F8E1F
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041084; cv=none; b=fpbXHUiJDGhZcGrZ9x2I1kMQ+FdpdlVUA96i6QoLpTkwWYmiRoEMUJE/UF8gkAATPDPOVRq8CLQHnt/AUZaleziP2GBZoUq656UWgrukCKdVtCWkrD81tN6QTCSjH7Zc79YW3MR4GoqjFIy3iQ3w6GMIFFCgJc1s+VOs4wRxm0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041084; c=relaxed/simple;
	bh=JwJGdbweTuuDjN+NXcqYxN+qucEYzBfYu1eIx/secDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g70ivd4j/LNi5gYS9tZyU4YkSGRYFUPjHezWmFLSUTB9VNvlHSB3LICqXCFRE1x2sEsrGYXkWjrVjqm/kjDhjRAprZ89A05eHUrSX8llTGNCqOfmuPjUluQxm489f+T04F7srjpkrFkivykSXFDoj4tKAIiGSILmgLw272gZSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5VDOX1M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5VDOX1M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775041081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQyK5djJUrk3jo4ippjZIsLsgYqKegjuq875Nu7Zr74=;
	b=X5VDOX1Me9tpgSB/VC3VcnoyISnL6/t1kpeKm7w1fngnHIRwzEc21rSOxp1m3ucVOgTviq
	OGjP2Xhoo4ucH47r8etaO7qnLytgNh+rDu1FMhDnw0GrOP0wCLmMs1ppvLihvBWlPVIL+Q
	FCJgPk0wnikV7kqggYFeCVm0x7S2PpQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-_l04Z0iCNL6WDu-06kIelg-1; Wed,
 01 Apr 2026 06:57:58 -0400
X-MC-Unique: _l04Z0iCNL6WDu-06kIelg-1
X-Mimecast-MFC-AGG-ID: _l04Z0iCNL6WDu-06kIelg_1775041076
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 676FB18005B2;
	Wed,  1 Apr 2026 10:57:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.35.245])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EB2330001A2;
	Wed,  1 Apr 2026 10:57:51 +0000 (UTC)
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
	Luxiao Xu <rakukuip@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <enjou1224z@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	stable@kernel.org
Subject: [PATCH net v4 15/15] rxrpc: fix reference count leak in rxrpc_server_keyring()
Date: Wed,  1 Apr 2026 11:56:08 +0100
Message-ID: <20260401105614.1696001-16-dhowells@redhat.com>
In-Reply-To: <20260401105614.1696001-1-dhowells@redhat.com>
References: <20260401105614.1696001-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Luxiao Xu <rakukuip@gmail.com>

This patch fixes a reference count leak in rxrpc_server_keyring()
by checking if rx->securities is already set.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
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
 net/rxrpc/server_key.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/rxrpc/server_key.c b/net/rxrpc/server_key.c
index 36b05fd842a7..d4777851079f 100644
--- a/net/rxrpc/server_key.c
+++ b/net/rxrpc/server_key.c
@@ -125,6 +125,9 @@ int rxrpc_server_keyring(struct rxrpc_sock *rx, sockptr_t optval, int optlen)
 
 	_enter("");
 
+	if (rx->securities)
+		return -EEXIST;
+
 	if (optlen <= 0 || optlen > PAGE_SIZE - 1)
 		return -EINVAL;
 

