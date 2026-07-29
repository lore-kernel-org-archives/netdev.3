Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FCF3EC832
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340887; cv=none; b=YhGhcAQlEdCDj53rsKy0ckjseXBbxyjgT30cnBVYo5Gf9J3qxaDzemIkPl8zN1W6X+ApMmHOOGt9i1afe0Mex6/tIJjdpNGbW9Nu0Mlpg7qCqBdGXrUI2wKVhLfcnxL4j99SXObSF3ABOS8yQjjvkasTixWymdgVi5OOH+n7FT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340887; c=relaxed/simple;
	bh=xyALdxjU1TW9/Ki7zm9C1YzWa0+d5DiMlT8No6I9Mes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utBoE3kV0edzYWo8DhpYCJmxjee/zDzyJbsqXGE7cO9addmcD1UPjOqogRoyuwtXWV04L2ar5WPHl4zF2/uCWtOfX0qSDtGFvHaA7TVruengdXsywN/MQrRomgRGQ1cmbEDuGc/1oUGX8vcSFqe8gVqlhffBrdjQxFKhlcaFa+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cFR0RdDk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFR0RdDk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785340884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOWCDRxNUNYjz7orMFcedmQGQ2BN2L8e1lJ1KDGIQsg=;
	b=cFR0RdDkHLodH21GYYkHZx3+2k8YwPZq18x+4SlGQW5N5Cn0qLYCWEJNBzfHt7DRE8kr8a
	XPwVmsAaoEKVKqpI5+weI+DPJUtAircn8PXe3AioLkhRAWww92jRJ3P+k60xmhgFQBwY8+
	AAQEjWsZQ3E3iA+DOSFnSVKgDbGGbNA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-SWHaFvdMM9-q5Pg5JYL5Zg-1; Wed,
 29 Jul 2026 12:01:23 -0400
X-MC-Unique: SWHaFvdMM9-q5Pg5JYL5Zg-1
X-Mimecast-MFC-AGG-ID: SWHaFvdMM9-q5Pg5JYL5Zg_1785340881
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D265A19560B6;
	Wed, 29 Jul 2026 16:01:20 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 474891800480;
	Wed, 29 Jul 2026 16:01:16 +0000 (UTC)
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
Subject: [PATCH net v5 01/10] rxrpc: Fix sendmsg to not return an error if last packet queued
Date: Wed, 29 Jul 2026 17:00:58 +0100
Message-ID: <20260729160108.2031453-2-dhowells@redhat.com>
In-Reply-To: <20260729160108.2031453-1-dhowells@redhat.com>
References: <20260729160108.2031453-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

