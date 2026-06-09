Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF48305669
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014187; cv=none; b=FnLF5Y2tZkPcu4rISXZkqddJhWAHYpEwJhrnyCchaLaQD0skGZ28V/kbpXK8aDwYZVyExm7wYUVuKX4E3Y4z2AnB0geuJ9gz9lSkAoS9Z3Ulxv3lUgoQ8VJmGxYa7h5EMFrQoTRo/5+NgEexpccfrYMlXhx8qlzaD5Q9/aGkRIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014187; c=relaxed/simple;
	bh=MgeqBqbeM9ZjlJEyVlgOa8AhiCyuAqsINqkRrxIJK0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTjteJrNpAGr9ZRUNKS3ewDNdfUv4RyiivmW31vAk1OMpRPty/Tl+f1vi8Qsp1vM0bRMohYAYWW4dHVKnpUdYG+Io4DkYuk+CpJjp6+ea4rNe2UNdMUkEIoeBkd9NjfYSjYVM2atdsro71X5A+qs657KZUL5l3ifmwW059Jamx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L6INEzia; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6INEzia"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781014185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJpcmVk55zVXVTYST+KIIg3DqPL02LXVu+0D5lYDt7c=;
	b=L6INEziaEoCuMfEyXgeCmWAHbe1gcYrGDG/foMpbHkNfXKrqCF7vnROqKs+7Z/5sVayx2Q
	d48KGdEEckmAvkJxaDDmGRjOvfXPf021hl3AEWL/upDoHxu0qLtH5KGvJmDrIbgnfr8v9r
	dN6jTHYmRz0WLGaqbUd57Ywr6tPEHmk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-qTik1dEPM7qg9tPFIrqWYA-1; Tue,
 09 Jun 2026 10:09:42 -0400
X-MC-Unique: qTik1dEPM7qg9tPFIrqWYA-1
X-Mimecast-MFC-AGG-ID: qTik1dEPM7qg9tPFIrqWYA_1781014179
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7474A180AC71;
	Tue,  9 Jun 2026 14:09:39 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.43])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB8451954105;
	Tue,  9 Jun 2026 14:09:35 +0000 (UTC)
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
	stable@kernel.org
Subject: [PATCH net 3/5] rxrpc: Fix UAF in rxgk_issue_challenge()
Date: Tue,  9 Jun 2026 15:09:07 +0100
Message-ID: <20260609140911.838677-4-dhowells@redhat.com>
In-Reply-To: <20260609140911.838677-1-dhowells@redhat.com>
References: <20260609140911.838677-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix rxgk_issue_challenge() to free the page containing the challenge
content after invoking the tracepoint as the whdr passed to the tracepoint
points into the page just freed.

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 net/rxrpc/rxgk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index a1ee102abae1..77a67ace1d24 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -687,16 +687,17 @@ static int rxgk_issue_challenge(struct rxrpc_connection *conn)
 	ret = do_udp_sendmsg(conn->local->socket, &msg, len);
 	if (ret > 0)
 		rxrpc_peer_mark_tx(conn->peer);
-	__free_page(page);
 
 	if (ret < 0) {
 		trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
 				    rxrpc_tx_point_rxgk_challenge);
+		__free_page(page);
 		return -EAGAIN;
 	}
 
 	trace_rxrpc_tx_packet(conn->debug_id, whdr,
 			      rxrpc_tx_point_rxgk_challenge);
+	__free_page(page);
 	_leave(" = 0");
 	return 0;
 }

