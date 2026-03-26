Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC583FADE2
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531159; cv=none; b=FFTu73+wXxBEIaTfCAxbm7IUVWHkH03wRLCExBwh08Y1gJJ2oeRfdazqEO3SQMzFYNwZ1E3gTp4qRcU+gs1CW6l3uxptNPKtZzrj6CY9iLDImWK0cJTs2++drsQfLhyKrKzkgACTk5yNTfiOb/FCtcPyJHNrxPYw85tXDiudAIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531159; c=relaxed/simple;
	bh=2w2X5/keWSYIEq5kP0enuQqtU6bjbD/nwb96pNy227I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cM0YdjZtwR/nOxdArDSL6G+Ts7oVguLlM8xb0KCDwXcJIzyS78RS3y5qSFaT7VBlBSt4c4fxKkRCaftQaHq8hwX33aJyGm3ECuTw+sDvyUm8YOMCe0jUJqgPmtsvmpo3J0BmbxQossoF7QnbjdCxeGb+/Est6pxqWkBvub0M1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z2pf+zPz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2pf+zPz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774531156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fc4Dc9rhjFkx+bfczLiQwRPtyzYqEhuP7T8AhY5Spp4=;
	b=Z2pf+zPzI8McTxUmgeZbsyvQ1SWPw+YgZVt+EnhI4eo2M6ywBPiIO/WrIPJXO5J0pidOdf
	u8lWY7fjS+NxuoRlJGO6UzYF9WoWu0Mt/fWNjTiUECyJQKLdUb3SVDWif9LEjKVzxk1Mjw
	OPrMqHqetvIbFwX4jsuR7gncYtCDzeU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-G02DmEYdPPOZ0nMh_6dlZA-1; Thu,
 26 Mar 2026 09:19:14 -0400
X-MC-Unique: G02DmEYdPPOZ0nMh_6dlZA-1
X-Mimecast-MFC-AGG-ID: G02DmEYdPPOZ0nMh_6dlZA_1774531152
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78295195608E;
	Thu, 26 Mar 2026 13:19:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B1721800671;
	Thu, 26 Mar 2026 13:19:08 +0000 (UTC)
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
Subject: [PATCH net v3 05/11] rxrpc: Fix call removal to use RCU safe deletion
Date: Thu, 26 Mar 2026 13:18:30 +0000
Message-ID: <20260326131838.634095-6-dhowells@redhat.com>
In-Reply-To: <20260326131838.634095-1-dhowells@redhat.com>
References: <20260326131838.634095-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix rxrpc call removal from the rxnet->calls list to use list_del_rcu()
rather than list_del_init() to prevent stuffing up reading
/proc/net/rxrpc/calls from potentially getting into an infinite loop.

Closes: https://sashiko.dev/#/patchset/20260319150150.4189381-1-dhowells%40redhat.com
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
 net/rxrpc/call_object.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 918f41d97a2f..0e47751d5937 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -654,9 +654,9 @@ void rxrpc_put_call(struct rxrpc_call *call, enum rxrpc_call_trace why)
 	if (dead) {
 		ASSERTCMP(__rxrpc_call_state(call), ==, RXRPC_CALL_COMPLETE);
 
-		if (!list_empty(&call->link)) {
+		if (on_list_rcu(&call->link)) {
 			spin_lock(&rxnet->call_lock);
-			list_del_init(&call->link);
+			list_del_rcu(&call->link);
 			spin_unlock(&rxnet->call_lock);
 		}
 
@@ -738,7 +738,7 @@ void rxrpc_destroy_all_calls(struct rxrpc_net *rxnet)
 			_debug("Zapping call %p", call);
 
 			rxrpc_see_call(call, rxrpc_call_see_zap);
-			list_del_init(&call->link);
+			list_del_rcu(&call->link);
 
 			pr_err("Call %p still in use (%d,%s,%lx,%lx)!\n",
 			       call, refcount_read(&call->ref),

