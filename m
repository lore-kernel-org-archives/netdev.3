Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26E73B19B0
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930283; cv=none; b=iGglisRnQKuVR0sIh1yT0N7S73fzf+1n3c9K3hxynUMp60aIYQAxKyY3dGbo3wbzIqe3buB7INDiGPkZJwPs/Tf5K4mvC/S4dJgY3lR8lrwR5XAYIOtVg2P6rTx6RkCg9mq3UxB6yK3uxrhtI3Hlusi9tMfBtR4Ed0w2k8GQVNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930283; c=relaxed/simple;
	bh=x68jmtgRi4WLvvhzlv8t4ufL4Lh9Zn5cECgSNdtwQ9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPC+8zIsQu+Z8+XF6799pm6sQAkXmGF9C/5tEdmLupweYDIW+5dUG12v8aNmhMOI1Ny/qfdIqR3qDZYgbybDPGlptuojFxNNLj6bwjwjYTbJ7poPSKd/KGUdPHC2Oee+hTRPeLuMS7j2Amdujur0Aej0NM6HQIJS6V1OHc8ygus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rxn9XD2i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rxn9XD2i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783930280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIgZcla1/YpoDmZ2ZqwvtibEJyua5l/6xD4lwXMlYlE=;
	b=Rxn9XD2iVq1o+pU4MS32Tt+NnwpyFa3pLRB/0/kt4U4etZmDuDDI230YvJroNnBLZEbJxM
	h9EPNkTjgWDO21sHlr3J1x5KjSKJ+GG1Qs6yQ26RK1VbNsdL99dwghvaHPsCQEqL82adtn
	dlwSJQ3LQdrCrzOc6OX2EefuqBMZbrU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-mx3kNCz5Nam1wM_c3H7BlA-1; Mon,
 13 Jul 2026 04:11:15 -0400
X-MC-Unique: mx3kNCz5Nam1wM_c3H7BlA-1
X-Mimecast-MFC-AGG-ID: mx3kNCz5Nam1wM_c3H7BlA_1783930274
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6EA318052EA;
	Mon, 13 Jul 2026 08:11:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0ED0195604B;
	Mon, 13 Jul 2026 08:11:10 +0000 (UTC)
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
Subject: [PATCH net v3 09/14] afs: Fix UAF in afs_make_call()
Date: Mon, 13 Jul 2026 09:10:15 +0100
Message-ID: <20260713081022.2186481-10-dhowells@redhat.com>
In-Reply-To: <20260713081022.2186481-1-dhowells@redhat.com>
References: <20260713081022.2186481-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

There's a potential UAF in afs_make_call() in the event that an
asynchronous call is being sent, but the call fails in some way (e.g. it
gets aborted from the server).  The problem is that afs_make_call() tries
to abort a call if the rxrpc send fails, but the asynchronous notification
from rxrpc may have caused the afs_call to be torn down.

Fix this making afs_make_op_call() give the op->call its own ref rather
than transferring the caller's ref to it and then dropping the ref when
afs_make_call() returns.

This also means that the afs_make_call() func never loses its ref on the
call now.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Link: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com
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
 fs/afs/internal.h          | 3 ++-
 fs/afs/rxrpc.c             | 3 ---
 include/trace/events/afs.h | 2 ++
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 4901d0acbe14..645fe2f12dc5 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1417,7 +1417,7 @@ static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *c
 {
 	struct afs_addr_list *alist = op->estate->addresses;
 
-	op->call	= call;
+	op->call	= afs_get_call(call, afs_call_trace_get_op_call);
 	op->type	= call->type;
 	call->op	= op;
 	call->key	= op->key;
@@ -1425,6 +1425,7 @@ static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *c
 	call->peer	= rxrpc_kernel_get_peer(alist->addrs[op->addr_index].peer);
 	call->service_id = op->server->service_id;
 	afs_make_call(call, gfp);
+	afs_put_call(call, afs_call_trace_put_made_call);
 }
 
 static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t size)
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index a1b9ced4e0f4..6dc6fd853832 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -382,8 +382,6 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	if (ret < 0)
 		goto error_do_abort;
 
-	/* We lost our ref on call if MSG_MORE was not set and ret >= 0. */
-
 	if (write_iter) {
 		msg.msg_iter = *call->write_iter;
 		msg.msg_flags &= ~MSG_MORE;
@@ -393,7 +391,6 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 					     call->rxcall, &msg,
 					     iov_iter_count(&msg.msg_iter),
 					     afs_notify_end_request_tx);
-		/* We lost our ref on call if ret >= 0. */
 
 		trace_afs_sent_data(debug_id, &msg, ret);
 		if (ret < 0)
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index df397c11df85..a1963e21f034 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -122,8 +122,10 @@ enum yfs_cm_operation {
 #define afs_call_traces \
 	EM(afs_call_trace_alloc,		"ALLOC      ") \
 	EM(afs_call_trace_free,			"FREE       ") \
+	EM(afs_call_trace_get_op_call,		"GET op     ") \
 	EM(afs_call_trace_get_make_async_call,	"GET a-make ") \
 	EM(afs_call_trace_put_async_complete,	"PUT a-cmpl ") \
+	EM(afs_call_trace_put_made_call,	"PUT made   ") \
 	EM(afs_call_trace_put_discard_prealloc,	"PUT dis-pre") \
 	EM(afs_call_trace_put_get_capabilities,	"PUT get-cap") \
 	EM(afs_call_trace_put_giveupcallbacks,	"PUT gvup-cb") \

