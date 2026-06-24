Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE85328B77
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319131; cv=none; b=PJQiLZ0wfqTlrrlO8s6ScR5psJi6VkVdOVmdx4zjHXFw6vvnK7IFUulU3dTeRtuJ15JORTi4peoi3txYmcQEVmhvq8hF8hgTW6SS8ervmT0f1m2OMA3NsZWdk8WpButLQJWnIzO8REJ5sodCysSFmRVPNyR9kVtKNHY8Pbrqz9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319131; c=relaxed/simple;
	bh=+c1v171ucIGcreUIBx1KLvMMgikORNXIoAjyt2dWcEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFwlyGyv2HmgJaDiVJ0U3RswB3PL+sC4TsKP1LNkJnYkKqYgV4MLvd0I0nxSHM4fY07APUiRz83inlnQec+67fqUbFlG2i6Vb+/RbBJmSxue+iXIzB8oW/6meoIxoxipyKbeFXVHBGneBnv00XwKoJMimwg4P7aswhXIxNd9r3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tt/K61VQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tt/K61VQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782319129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pelT1Ehf1aADqvzwY1SZp6RYyze5Ju/7z85Yx5jL4A=;
	b=Tt/K61VQJtX1WjvHJmJ6itMjEBfZmXiUEJYrNZl+hff0qF+jFk3ggYfhtxuKx+2pmAj227
	giOJLPEZ/zk584HRCkMdO4JQvoUOrX7ZrGBrkVu1X/be/Vqby56GXY0D4FTopPzZSof5b2
	HqkxbgXaGi4IQDsdpfv1+PLMTY/hMq4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-4OLgRPbmP7qs17v0oVsaCw-1; Wed,
 24 Jun 2026 12:38:45 -0400
X-MC-Unique: 4OLgRPbmP7qs17v0oVsaCw-1
X-Mimecast-MFC-AGG-ID: 4OLgRPbmP7qs17v0oVsaCw_1782319124
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 359FE1800587;
	Wed, 24 Jun 2026 16:38:44 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 965F01800361;
	Wed, 24 Jun 2026 16:38:40 +0000 (UTC)
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
Subject: [PATCH net v3 03/11] rxrpc: Fix double unlock in rxrpc_recvmsg()
Date: Wed, 24 Jun 2026 17:38:10 +0100
Message-ID: <20260624163819.3017002-4-dhowells@redhat.com>
In-Reply-To: <20260624163819.3017002-1-dhowells@redhat.com>
References: <20260624163819.3017002-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix a double unlock in rxrpc_recvmsg() when dealing with OOB messages.

Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Link: https://sashiko.dev/#/patchset/20260609140911.838677-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 net/rxrpc/recvmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 82614cbdb60f..39a03684432d 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -471,7 +471,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		release_sock(&rx->sk);
 		if (ret == -EAGAIN)
 			goto try_again;
-		goto error_no_call;
+		goto error_trace;
 	}
 
 	/* Find the next call and dequeue it if we're not just peeking.  If we

