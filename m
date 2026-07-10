Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37507383985
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711371; cv=none; b=pfQk6OYvcgRvTtBl6Us1PBhTga5VKfRo5H7UhR5PgUhv4oIupxKhK9skLuZXZ9GR8oHi+CCbBOzeaMM3dE5K1Fhv5TqfVmdAt060GpxvNUiMv6S3zHPJYuG3Uf/TJlQzksu/W69D5vTH+2fWKG+AfYMIj08xBmGGztZYqAbD5pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711371; c=relaxed/simple;
	bh=E5WS46j5a8G17EdBUcF4rWwBW8nW3IbIBrOVF96DvQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPkIzQIqQ0xWa1CK9b3+ziMd+FYUjgvitTGFvvHN4uOyXFlv4SWTnChbHKJpCHjEOUoCeXpslL1YXvcHPeA8gMryTRxKYI2ExcA0ku4xawzosiK2K1hcdMxUs+Y0Tw9OkPjRWtTUIjijmoP5Y9bZ7AoqYZfrzgBUjEF052JtAno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjKphMxf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjKphMxf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783711368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgpV4kjwvH55LZvzMLmX7XWaBZ5UY8VXhuMtFgykJ6U=;
	b=AjKphMxfCSxTqnejUTo/A4e5uqpT8g7EIv2TO65ekE/+wRY7YArAxgg/htoxphubDZ32EN
	VC+1+AF2gRXv+UY43BMSo84ZwtLe3YJaYxRKUsnImy56LRUsv8jxmWEwBU76sfskgd3t6V
	cABaWkziCCzbDkDtP1++ReoPvIYA2O4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-3BhFdBnrOn2yqfDbiWG2jw-1; Fri,
 10 Jul 2026 15:22:45 -0400
X-MC-Unique: 3BhFdBnrOn2yqfDbiWG2jw-1
X-Mimecast-MFC-AGG-ID: 3BhFdBnrOn2yqfDbiWG2jw_1783711363
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 155951955F2E;
	Fri, 10 Jul 2026 19:22:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6A53180058D;
	Fri, 10 Jul 2026 19:22:39 +0000 (UTC)
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
Subject: [PATCH net v2 03/16] afs: Fix UAF when sending a message
Date: Fri, 10 Jul 2026 20:22:05 +0100
Message-ID: <20260710192220.1922433-4-dhowells@redhat.com>
In-Reply-To: <20260710192220.1922433-1-dhowells@redhat.com>
References: <20260710192220.1922433-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

In afs_make_call(), there's a race with async call reception and
destruction.  If a call is dispatched that doesn't have call->write_iter
set (used to specify the data content for FS.StoreData), then the first
rxrpc_kernel_send_data() will not set MSG_MORE in the msghdr.

Once rxrpc_send_data() queues the last request packet, the response could
come in at any time and cause the call to be completed and put.  However,
afs_make_call() will look at the call again to see it ->write_iter should
be handled - something it's only allowed to do if it has its own ref on the
call.  Whilst this is the case for synchronous calls, it isn't true for
async calls such as FS.FetchData.

generic/650 plays games with randomly taking CPUs offline, and can
interject a significant delay such that the call is deallocated before
afs_make_call() gets to check call->write_iter - and a UAF ensues (caught
by KASAN).

   BUG: KASAN: slab-use-after-free in afs_make_call+0x1c90/0x2210 [kafs]
   Read of size 8 at addr ffff888035e050e8 by task fsstress/1409

Fix this by caching the call->write_iter and call->debug_id so that neither
variable needs to be accessed after the first send.

Fixes: eddf51f2bb2c ("afs: Make {Y,}FS.FetchData an asynchronous operation")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 fs/afs/rxrpc.c             | 12 ++++++++----
 include/trace/events/afs.h |  6 +++---
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index d82916657a3d..06c711c75f55 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -347,7 +347,9 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	struct rxrpc_call *rxcall;
 	struct msghdr msg;
 	struct kvec iov[1];
+	unsigned int debug_id = call->debug_id;
 	size_t len;
+	bool write_iter = call->write_iter;
 	s64 tx_total_len;
 	int ret;
 
@@ -410,7 +412,7 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, iov, 1, call->request_size);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
-	msg.msg_flags		= MSG_WAITALL | (call->write_iter ? MSG_MORE : 0);
+	msg.msg_flags		= MSG_WAITALL | (write_iter ? MSG_MORE : 0);
 
 	ret = rxrpc_kernel_send_data(call->net->socket, rxcall,
 				     &msg, call->request_size,
@@ -418,7 +420,9 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	if (ret < 0)
 		goto error_do_abort;
 
-	if (call->write_iter) {
+	/* We lost our ref on call if MSG_MORE was not set and ret >= 0. */
+
+	if (write_iter) {
 		msg.msg_iter = *call->write_iter;
 		msg.msg_flags &= ~MSG_MORE;
 		trace_afs_send_data(call, &msg);
@@ -427,9 +431,9 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 					     call->rxcall, &msg,
 					     iov_iter_count(&msg.msg_iter),
 					     afs_notify_end_request_tx);
-		*call->write_iter = msg.msg_iter;
+		/* We lost our ref on call if ret >= 0. */
 
-		trace_afs_sent_data(call, &msg, ret);
+		trace_afs_sent_data(debug_id, &msg, ret);
 		if (ret < 0)
 			goto error_do_abort;
 	}
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 1b3c48b5591d..cf7218efb861 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -937,9 +937,9 @@ TRACE_EVENT(afs_send_data,
 	    );
 
 TRACE_EVENT(afs_sent_data,
-	    TP_PROTO(struct afs_call *call, struct msghdr *msg, int ret),
+	    TP_PROTO(unsigned int call_debug_id, struct msghdr *msg, int ret),
 
-	    TP_ARGS(call, msg, ret),
+	    TP_ARGS(call_debug_id, msg, ret),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		call)
@@ -949,7 +949,7 @@ TRACE_EVENT(afs_sent_data,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call->debug_id;
+		    __entry->call = call_debug_id;
 		    __entry->ret = ret;
 		    __entry->offset = msg->msg_iter.xarray_start + msg->msg_iter.iov_offset;
 		    __entry->count = iov_iter_count(&msg->msg_iter);

