Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7E948A2D8
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864419; cv=none; b=SnFGNS0AhZcNbqyvTLkSo07zCNZwF74hLZumrNYsn5f6qfyudJKRysO464NDut4/pIgZyaCt18lW7jj+r2WZ797aAh6up3A3hKQpU+UgpfIit6uvFdiarca6ERRnW4KtWJyUVcuGcRu6WHsRjtGXH6J2gRrZy3IINK0khGuT7T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864419; c=relaxed/simple;
	bh=xyALdxjU1TW9/Ki7zm9C1YzWa0+d5DiMlT8No6I9Mes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqH1+h1aLXBKKfCNW6AJqPc1Opotk77Qns5JMLMQZ2ZUkSd2Ay7jxvXAzb7r/IRq07iLu0xVOeouXffSqF+2vK0kUoadLfhd0F1YAAP67xak0GG7w3ZdCKYkZssBO2niIKkn//p73tHO6JteR+0A2kNQi8/mkNIuYms7lfp3Ubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aq6CxZ4i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aq6CxZ4i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785864416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOWCDRxNUNYjz7orMFcedmQGQ2BN2L8e1lJ1KDGIQsg=;
	b=Aq6CxZ4ieyMrSG0ZE21yhn8sQGWfoCATTVgyocyVnyO7pXkVrn1kaaXk9rtPZclri6XCsm
	aO47lKmY8xbY9m0dI70pUee8PsLZ7MzKB6yXOWklWS7YJLjTPX8hENI+Wgb5Sb+t0imdWV
	lh4XvPPinIpnhJL6GF3/pnlZcEg/1Cc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-qNeuhZS4PqSldZfasV5cSA-1; Tue,
 04 Aug 2026 13:26:52 -0400
X-MC-Unique: qNeuhZS4PqSldZfasV5cSA-1
X-Mimecast-MFC-AGG-ID: qNeuhZS4PqSldZfasV5cSA_1785864411
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0476618002DE;
	Tue,  4 Aug 2026 17:26:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.44])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1376195608E;
	Tue,  4 Aug 2026 17:26:47 +0000 (UTC)
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
Subject: [PATCH net v6 01/10] rxrpc: Fix sendmsg to not return an error if last packet queued
Date: Tue,  4 Aug 2026 18:26:28 +0100
Message-ID: <20260804172639.2844491-2-dhowells@redhat.com>
In-Reply-To: <20260804172639.2844491-1-dhowells@redhat.com>
References: <20260804172639.2844491-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
 net/rxrpc/sendmsg.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index ed2c9a51005a..4c754f78ece9 100644
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

