Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2473EFFBA
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563024; cv=none; b=llwHJvTuesR+UWTetccwFI9d7TZDCn4G31gQeNlbEWgjjsCnNu99fM4BpUURT93CUqfgOuBj9rL7m7gPVhmgOCMstBNXXaOLI4fzOE23gdRpW9Ybs13c2jlgY2451nE8SNE0oLyemiexZoONYJbrZv4tG1//G6Mlo/xG9wf/LjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563024; c=relaxed/simple;
	bh=PAqU8LJtp3AvrdGczRlO/989RsTmuigK/UNg2hkjwtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZ1zhO+wWju7HSGG/ea4q4fEsO7ntot64gzk5PnUOIGMF2MRHzhHr7gabkHsRMDJa9oaCaw1Xb2qNjPZ1UgFLz1C/yxnO0+IYQKW5We0tmRpDJd6/RqOHEjNTh8YRC3hbhjs93MHqWgWdWk6hllwAEQzMGLeD61J7an0mtJM0wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W/nsLWGx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/nsLWGx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787563022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8lYRMQTb8WXJpLOUld7aQxE3Dwf663XabP8elTCnumI=;
	b=W/nsLWGx1aJyRy/Z48NFcMSuMO7TurfiqeR023gJmNoqoWB4eQnpMfmiYN8RSO+WvFYnRC
	Uqj9HXCTXWcux30joI+JfXqfEwmcaNpmyqQjn/nva33LU6XyV2d8+Li4zY8Zo8qK0xDfcm
	ETvXbRSegi9Lj+nBx0hd7gvKpe93Kq8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-O0B2rcMrMSKJLLVOOUcYWQ-1; Mon,
 24 Aug 2026 05:17:00 -0400
X-MC-Unique: O0B2rcMrMSKJLLVOOUcYWQ-1
X-Mimecast-MFC-AGG-ID: O0B2rcMrMSKJLLVOOUcYWQ_1787563019
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FEB1180ABE9;
	Mon, 24 Aug 2026 09:16:58 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.15])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 242EF18005BB;
	Mon, 24 Aug 2026 09:16:54 +0000 (UTC)
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
	Jeffrey Altman <jaltman@auristor.com>
Subject: [PATCH net v8 01/12] rxrpc: Fix sendmsg to not return an error if last packet queued
Date: Mon, 24 Aug 2026 10:16:33 +0100
Message-ID: <20260824091645.415423-2-dhowells@redhat.com>
In-Reply-To: <20260824091645.415423-1-dhowells@redhat.com>
References: <20260824091645.415423-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix AF_RXRPC sendmsg() so that it doesn't return an error if it has
successfully queued the last packet of a call, but the call has seen to
have completed after it did that.  Rather, leave it to recvmsg() to report
the completion (which it will do anyway).

The problem with trying to report the error twice is that the caller may
try to clean up the dead call twice.

Fixes: d41b3f5b9688 ("rxrpc: Wrap accesses to get call state to put the barrier in one place")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
---
 fs/afs/rxrpc.c      |  2 +-
 net/rxrpc/sendmsg.c | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index d82916657a3d..e35b49a904eb 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -873,7 +873,7 @@ void afs_send_empty_reply(struct afs_call *call)
 
 	switch (rxrpc_kernel_send_data(net->socket, call->rxcall, &msg, 0,
 				       afs_notify_end_reply_tx)) {
-	case 0:
+	case 0: /* Shouldn't buffer more than 0 bytes. */
 		_leave(" [replied]");
 		return;
 
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index ed2c9a51005a..1d66e9808162 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -453,9 +453,6 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 success:
 	ret = copied;
-	if (rxrpc_call_is_complete(call) &&
-	    call->error < 0)
-		ret = call->error;
 out:
 	call->tx_pending = txb;
 	_leave(" = %d", ret);
@@ -467,8 +464,14 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	return call->error;
 
 maybe_error:
-	if (copied)
+	if (copied) {
+		if (rxrpc_call_is_complete(call) &&
+		    call->error < 0) {
+			ret = call->error;
+			goto out;
+		}
 		goto success;
+	}
 	goto out;
 
 efault:
@@ -800,9 +803,16 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
  * Allow a kernel service to send data on a call.  The call must be in an state
  * appropriate to sending data.  No control data should be supplied in @msg,
  * nor should an address be supplied.  MSG_MORE should be flagged if there's
- * more data to come, otherwise this data will end the transmission phase.
+ * more data to come, otherwise this data will end the transmission phase if
+ * all the data is buffered.
+ *
+ * Note that this function may return a short send, in which case it should be
+ * called again for the remainder of the data or to pick up an error that
+ * caused the short send.
  *
- * Return: %0 if successful and a negative error code otherwise.
+ * Return: The number of bytes buffered (could be %0 if @len is 0 or
+ * msg_iter holds 0 bytes) if successful and a negative error code
+ * otherwise.
  */
 int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 			   struct msghdr *msg, size_t len,

