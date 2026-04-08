Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C609A3C5DAF
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650495; cv=none; b=OXmP31gk0Ej+18PkcLP2LMJbaMrrs5Snt8wE4hxdbGOIk6dxCn6LE2T3wmK0N6NZO/AzYVcrXXwzgTV19fkYGyc9kNhxWOKY7qrrb0clLjn9nwJET+OfMzStx88qCg1lCT3vwiZNbKLcjdfzLyrZk00GR1C4++6iR1cxzU+r/I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650495; c=relaxed/simple;
	bh=bXVu2+Z0GwpRAmBHYjgAE256FwRZ8IdCkhvPqkkIQgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBNp5Uvn6TBC2XmgMcagtX6Y8qREzOHjXyYU0G8cIko7cn0X0zk68ofUaTGgVQWr5c4RVHVokryi0kpEiHSMrP5tUmG58v45aEEAhqAmF7Zspf/NNS6dftWJW93R3Pt7r2nI9BxyMxFBruyIPpO5sTJtQbXQNYf3l/ppqgWAMAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bl/kfTyL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bl/kfTyL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775650492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AEHnp+JVnC2Jv+iS7wQfAaLkI3qGTmWEKZbSWHYr80Y=;
	b=bl/kfTyLOJ6rqdmkWyeETYlImhjxQ/L86F8YwpDGgSvOzRFZwR0nQJwvHMhISJ7axnW+TE
	KzGp5YqOIh09JEB3wA82VDIXrnUFCISRZ4lgX30mdACURZirNvmK4DrxkSIYLbIRGSmLl8
	kSwO8j5qzKoInwX9db6pm0pfdHgUd00=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-FRliI0X9MImOngLZwT1rdg-1; Wed,
 08 Apr 2026 08:14:49 -0400
X-MC-Unique: FRliI0X9MImOngLZwT1rdg-1
X-Mimecast-MFC-AGG-ID: FRliI0X9MImOngLZwT1rdg_1775650487
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8F1F1956052;
	Wed,  8 Apr 2026 12:14:47 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30E261800673;
	Wed,  8 Apr 2026 12:14:43 +0000 (UTC)
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
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	stable@kernel.org
Subject: [PATCH net v5 17/21] rxrpc: Fix integer overflow in rxgk_verify_response()
Date: Wed,  8 Apr 2026 13:12:45 +0100
Message-ID: <20260408121252.2249051-18-dhowells@redhat.com>
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

In rxgk_verify_response(), there's a potential integer overflow due to
rounding up token_len before checking it, thereby allowing the length check to
be bypassed.

Fix this by checking the unrounded value against len too (len is limited as
the response must fit in a single UDP packet).

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Closes: https://sashiko.dev/#/patchset/20260401105614.1696001-10-dhowells@redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
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
index 9e4a4ff28913..064c1531fc99 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -1209,7 +1209,8 @@ static int rxgk_verify_response(struct rxrpc_connection *conn,
 
 	token_offset	= offset;
 	token_len	= ntohl(rhdr.token_len);
-	if (xdr_round_up(token_len) + sizeof(__be32) > len)
+	if (token_len > len ||
+	    xdr_round_up(token_len) + sizeof(__be32) > len)
 		goto short_packet;
 
 	trace_rxrpc_rx_response(conn, sp->hdr.serial, 0, sp->hdr.cksum, token_len);

