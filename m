Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB113C1974
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650424; cv=none; b=K6FzswpWAhLDahqL6b+YnP3A9AhzJB7YLpKM5DdojjK3JP7nyRu2uznnWm7vT9ccR6Bu3/MfdKkLYRn4LEvGmx6PZZE4O0NZzVAIKq1C41eYbz+pggBXIECVfndHP+7V3Fv+TbvrCwM70su9td0QbvjAWFTTfFurpHZeJUpTa9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650424; c=relaxed/simple;
	bh=CxAq8sxxdfWME2NDmOhfPSLnwRl2eUhJ1SjQUCVqquU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Njlh4P8/NmBNyUcSs958TI/SRvmBQGEuN3rDhXZTaBQjbL3F4jBeFf4ZJjX/XchDwU2IHsn007G17I91JcicM7Y9SK5ga9R+OKR8D16r5Ldu0fjwe9/zpotnZfRxOlzcwUAs+r2Y8uTFHUPZcLjrciKQvVa3fY8asLOldvFTdEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIULoows; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIULoows"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775650418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLPucy+/KOM/ZUAst+Ut2hFjeRnIfKEjJCeuzdkhnmE=;
	b=TIULoowsBWT9/sTisKqcLOwBBXrdJtYFnDMvcZ5WQaFhl2wo9a74QV1A+mMV905Zu/ANu+
	YNP7qf5TjxwOav5AVx9uwlvbBArvxiO2wDB33tSr34FPhKrl/Tt8DcqoIUs5WgxzxeuHZG
	hIr781Xz7x1HS2EXxeriQuJXorEZcgs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-zq0SZ0xwNiKD0LiurotUSA-1; Wed,
 08 Apr 2026 08:13:35 -0400
X-MC-Unique: zq0SZ0xwNiKD0LiurotUSA-1
X-Mimecast-MFC-AGG-ID: zq0SZ0xwNiKD0LiurotUSA_1775650413
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5667A18002E3;
	Wed,  8 Apr 2026 12:13:33 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.94])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 765021800351;
	Wed,  8 Apr 2026 12:13:29 +0000 (UTC)
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
Subject: [PATCH net v5 06/21] rxrpc: Fix use of wrong skb when comparing queued RESP challenge serial
Date: Wed,  8 Apr 2026 13:12:34 +0100
Message-ID: <20260408121252.2249051-7-dhowells@redhat.com>
In-Reply-To: <20260408121252.2249051-1-dhowells@redhat.com>
References: <20260408121252.2249051-1-dhowells@redhat.com>
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

