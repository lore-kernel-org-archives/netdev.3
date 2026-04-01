Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99D1410D1F
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041076; cv=none; b=pkfKLwXvcaCAsQQW40zbF0IpBE1YH4gNNltK6Rq9YK2DNfcRlQT/kVNNtVGegV/akLMEerWxTf4rG0MIIovKuEQNBLW/Kvu33950e5cNT5ZUX0SFAyZ8dpsGq+eYMzi/xv6VyKGn/tQlXvGu5VZr2LD1szPgmh4N4m4y7hT0mhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041076; c=relaxed/simple;
	bh=E5Ktr5ujZ7VRhGZNliJlSlHfN++85hVgVhq64IAONJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoFuWmhhG6t08+HljWzRxDEBbMBgKTEI/WQycHnTFKxRmzUe82lBBbS0gf22Gck7fS6wju0ZTTAsU7i2DFAoN563T0btFWPkhp0Ad0/KdOTcRZc2JfgsZxLxVlGcMWwKPNGpKJ0JnQHCZb62Qb5IptWEKM9JMVC0KUd8zGsz3UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OMmpB5Cu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMmpB5Cu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775041074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svfAwTnHVWeMxDrZSO9dpHkcb5nEFh4Zczxno4SRn7Y=;
	b=OMmpB5CuUIEQwIHKBLOLxPLP6rMTUuDQUSsDPpng7j8TZ7bGmqqHXNebEArhxMnx0T9CP8
	fDpJTRKDzKt49u3C5pEZyXlKIuYysWnmgcJVvgYzN2ekW+QBdyEYA5tyocc2ke6RB6zBF2
	73zB7mPBGxLZvyF2DqWIZKWY3El201k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-uGEGZSpYOnyW0kxwK7WGGQ-1; Wed,
 01 Apr 2026 06:57:51 -0400
X-MC-Unique: uGEGZSpYOnyW0kxwK7WGGQ-1
X-Mimecast-MFC-AGG-ID: uGEGZSpYOnyW0kxwK7WGGQ_1775041070
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABDD6180035C;
	Wed,  1 Apr 2026 10:57:49 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.35.245])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB68B1800351;
	Wed,  1 Apr 2026 10:57:45 +0000 (UTC)
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
	Keenan Dong <keenanat2000@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willy Tarreau <w@1wt.eu>,
	stable@kernel.org
Subject: [PATCH net v4 14/15] rxrpc: fix oversized RESPONSE authenticator length check
Date: Wed,  1 Apr 2026 11:56:07 +0100
Message-ID: <20260401105614.1696001-15-dhowells@redhat.com>
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

From: Keenan Dong <keenanat2000@gmail.com>

rxgk_verify_response() decodes auth_len from the packet and is supposed
to verify that it fits in the remaining bytes. The existing check is
inverted, so oversized RESPONSE authenticators are accepted and passed
to rxgk_decrypt_skb(), which can later reach skb_to_sgvec() with an
impossible length and hit BUG_ON(len).

Decoded from the original latest-net reproduction logs with
scripts/decode_stacktrace.sh:

RIP: __skb_to_sgvec()
  [net/core/skbuff.c:5285 (discriminator 1)]
Call Trace:
 skb_to_sgvec() [net/core/skbuff.c:5305]
 rxgk_decrypt_skb() [net/rxrpc/rxgk_common.h:81]
 rxgk_verify_response() [net/rxrpc/rxgk.c:1268]
 rxrpc_process_connection()
   [net/rxrpc/conn_event.c:266 net/rxrpc/conn_event.c:364
    net/rxrpc/conn_event.c:386]
 process_one_work() [kernel/workqueue.c:3281]
 worker_thread()
   [kernel/workqueue.c:3353 kernel/workqueue.c:3440]
 kthread() [kernel/kthread.c:436]
 ret_from_fork() [arch/x86/kernel/process.c:164]

Reject authenticator lengths that exceed the remaining packet payload.

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: Willy Tarreau <w@1wt.eu>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 net/rxrpc/rxgk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 01dbdf0b5cf2..9e4a4ff28913 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -1224,7 +1224,7 @@ static int rxgk_verify_response(struct rxrpc_connection *conn,
 
 	auth_offset	= offset;
 	auth_len	= ntohl(xauth_len);
-	if (auth_len < len)
+	if (auth_len > len)
 		goto short_packet;
 	if (auth_len & 3)
 		goto inconsistent;

