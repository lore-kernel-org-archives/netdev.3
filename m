Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F35C175A75
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014175; cv=none; b=WzDJrZ4hV5kdkkdDSAkwOyxLrPDvSK1yYv84D/T+dASg6zfVhIotYGVwN/YI3jPIMFhZQaqt4F1M7X1u8lqZ6TAo3pIfxE+RBeBcRqx4e33SSqzzq2+ZpZ73FMk6FmcFBR90208+VNTi1zo5wUUCEc1l04l+vR7c5nL9BoH/pLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014175; c=relaxed/simple;
	bh=qtteGwMyk56fhHdqSE9GXmi/FFYfwrI3UT49+P2m4dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGR8yVXaHPubQcPnx7FiF6FeNDPNRiPBrFbAf44zyobdbv5+DJtwOo2MsDz3jpzWGH9n2Es1/3brHjTSzYs7elE1rtY0XUkcpAphzTRit9DHkew2f5g15FJTQL58fPDNUc1GSMktqML4UJ+MsggVXLa5vDndNNrYZAa+ZC1nUuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TAs5SAUt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAs5SAUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781014173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXh8K7XLPasocrC2l8vFL8a7Brp5j6xFg+mo3XMhrhA=;
	b=TAs5SAUto9tFr6p0Z9T8CAK0LpHOAQdcmYA9EGgJcY2CGxQ1J6rujhuZ2PMmh0QJ9VDTK2
	5KKsGBSyM5JQNNssNwbnIbpiIbeap1BiIrHb2XKbmcfhmg/Dj9WDJM2LM/73/9MruxnkA9
	PC2Q7m1p7Kv00ro4QQx5WxcerZxGYBc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-mf8lCP-gPwyZa9nN6zYWfQ-1; Tue,
 09 Jun 2026 10:09:31 -0400
X-MC-Unique: mf8lCP-gPwyZa9nN6zYWfQ-1
X-Mimecast-MFC-AGG-ID: mf8lCP-gPwyZa9nN6zYWfQ_1781014169
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4259195DE46;
	Tue,  9 Jun 2026 14:09:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.43])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36ACB36920;
	Tue,  9 Jun 2026 14:09:23 +0000 (UTC)
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
	Simon Horman <simon.horman@redhat.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@kernel.org
Subject: [PATCH net 1/5] rxrpc: rxrpc_verify_data ensure rx_dec_buffer alloc
Date: Tue,  9 Jun 2026 15:09:05 +0100
Message-ID: <20260609140911.838677-2-dhowells@redhat.com>
In-Reply-To: <20260609140911.838677-1-dhowells@redhat.com>
References: <20260609140911.838677-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

From: Jeffrey Altman <jaltman@auristor.com>

rxrpc_recvmsg_data() calls rxrpc_verify_data() whenever the
rxrpc_call.rx_dec_buffer is unallocated and assumes that upon
successful return that rx_dec_buffer must be allocated.
However, rxrpc_verify_data() does not request an allocation if
the rxrpc_skb_priv.len is zero.

In addition, failure to allocate rx_dec_buffer will result in a
call to skb_copy_bits() with a NULL destination which can
trigger a NULL pointer dereference.

To prevent these issues rxrpc_verify_data() is modified to
always attempt to allocate the rxrpc_call.rx_dec_buffer if it
is NULL.

This issue was identified with assistance of a private
sashiko instance.

Fixes: d2bc90cf6c75cb ("rxrpc: Fix DATA decrypt vs splice() by copying data to buffer in recvmsg")
Reported-by: Simon Horman <simon.horman@redhat.com>
Signed-off-by: Jeffrey Altman <jaltman@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jiayuan Chen <jiayuan.chen@linux.dev>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 net/rxrpc/recvmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index c940600117a4..a3cf5358f16e 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -161,7 +161,7 @@ static int rxrpc_verify_data(struct rxrpc_call *call, struct sk_buff *skb)
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	int ret;
 
-	if (sp->len > call->rx_dec_bsize) {
+	if (sp->len > call->rx_dec_bsize || !call->rx_dec_buffer) {
 		/* Make sure we can hold a 1412-byte jumbo subpacket and make
 		 * sure that the buffer size is aligned to a crypto blocksize.
 		 */

