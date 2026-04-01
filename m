Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2635B407568
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041029; cv=none; b=aYriLzcEpUj9yn/ChYW1gli/aCEzEHePDgENKptsrC/SfVgwqrb+vU0k4JCmfUlb+VliPSZgCtvtQ9g3PYGTjbdJKkzZhV6QLRKr4UMHmOhkbups14fcMad67Czblo6mnUXMANXN7TGMf0TTNLpCdqchXp4cbjpUMAjkQKfNPSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041029; c=relaxed/simple;
	bh=CxAq8sxxdfWME2NDmOhfPSLnwRl2eUhJ1SjQUCVqquU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q404sAnvkuA9w0vZR9cnZXC7knii7JUQxjnEDbeXTf8+zfd4EQckAqrdG1XEZrz3Q+Dfcj72imLNugzQOrFhWPJ4Si0LKKLlkNL3PFNdkojrDKBQH6VrpVBzaZdoNdcKAhlR236ZAe6gq+a9IFIGJo1im3wePbVB0ZaYXKxnoco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWQIDhj1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWQIDhj1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775041027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLPucy+/KOM/ZUAst+Ut2hFjeRnIfKEjJCeuzdkhnmE=;
	b=UWQIDhj1GrcN0575jYxlvwumaZMH0l098QorUwMUmFCCN/fNFvrZMBXg664kyYSDq5ggml
	txRJFc2CTTfaLWzJMNd9oaBl0DVA3zQoB7JJREHvK6beXpIY2cezRy9yLquKbMoz3DY9xH
	ardTcPS31sVDEijYpzPlAdmJ/fvemGs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-bP0FBl4PNSGTmG8tsx0E5g-1; Wed,
 01 Apr 2026 06:57:04 -0400
X-MC-Unique: bP0FBl4PNSGTmG8tsx0E5g-1
X-Mimecast-MFC-AGG-ID: bP0FBl4PNSGTmG8tsx0E5g_1775041022
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 717D9180034E;
	Wed,  1 Apr 2026 10:57:02 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.35.245])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A132D1800351;
	Wed,  1 Apr 2026 10:56:58 +0000 (UTC)
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
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	stable@kernel.org
Subject: [PATCH net v4 06/15] rxrpc: Fix use of wrong skb when comparing queued RESP challenge serial
Date: Wed,  1 Apr 2026 11:55:59 +0100
Message-ID: <20260401105614.1696001-7-dhowells@redhat.com>
In-Reply-To: <20260401105614.1696001-1-dhowells@redhat.com>
References: <20260401105614.1696001-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Alok Tiwari <alok.a.tiwari@oracle.com>

In rxrpc_post_response(), the code should be comparing the challenge serial
number from the cached response before deciding to switch to a newer
response, but looks at the newer packet private data instead, rendering the
comparison always false.

Fix this by switching to look at the older packet.

Fix further[1] to substitute the new packet in place of the old one if
newer and also to release whichever we don't use.

Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
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
Link: https://sashiko.dev/#/patchset/20260319150150.4189381-1-dhowells%40redhat.com [1]
---
 include/trace/events/rxrpc.h | 1 +
 net/rxrpc/conn_event.c       | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index a826cd80007b..f7f559204b87 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -185,6 +185,7 @@
 	EM(rxrpc_skb_put_input,			"PUT input    ") \
 	EM(rxrpc_skb_put_jumbo_subpacket,	"PUT jumbo-sub") \
 	EM(rxrpc_skb_put_oob,			"PUT oob      ") \
+	EM(rxrpc_skb_put_old_response,		"PUT old-resp ") \
 	EM(rxrpc_skb_put_purge,			"PUT purge    ") \
 	EM(rxrpc_skb_put_purge_oob,		"PUT purge-oob") \
 	EM(rxrpc_skb_put_response,		"PUT response ") \
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 98ad9b51ca2c..c50cbfc5a313 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -557,11 +557,11 @@ void rxrpc_post_response(struct rxrpc_connection *conn, struct sk_buff *skb)
 	spin_lock_irq(&local->lock);
 	old = conn->tx_response;
 	if (old) {
-		struct rxrpc_skb_priv *osp = rxrpc_skb(skb);
+		struct rxrpc_skb_priv *osp = rxrpc_skb(old);
 
 		/* Always go with the response to the most recent challenge. */
 		if (after(sp->resp.challenge_serial, osp->resp.challenge_serial))
-			conn->tx_response = old;
+			conn->tx_response = skb;
 		else
 			old = skb;
 	} else {
@@ -569,4 +569,5 @@ void rxrpc_post_response(struct rxrpc_connection *conn, struct sk_buff *skb)
 	}
 	spin_unlock_irq(&local->lock);
 	rxrpc_poke_conn(conn, rxrpc_conn_get_poke_response);
+	rxrpc_free_skb(old, rxrpc_skb_put_old_response);
 }

