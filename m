Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0025349C5
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170700; cv=none; b=dc9mIuAJiJiA7+wSR9m38CtKpKdU2vAxVnAw0DYNQ3wnGGRWK3RiZAP4i2t2FUmabMntnq01uiFnlB9PXZxWUtO7f3qEEktrvcigySM5Savcz6ckVeJ5Sb94txnEFuzzqNJhYQvPYE+11FK9sGdjLremdlgsNsBxPIij++nqmBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170700; c=relaxed/simple;
	bh=YVG2GdfZ/DU+R1hpjVUnwj/1UuU7gqIwRqvk6yX2xuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p13fHARBuo9FOG65eGFsqdromJ10GOyrX+zSwDNQ1FQgdvsmhZkt+1Bce6K/4cLtr7RXf5XvNVok021D8UeUQDCnfFZkBRevmURzlkV1PoEi4ZrftCuOW2VgzhksX4k2js9DN/Bam7diLITv4EMYYeD+loqBb9maMgOcPLNypxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZsA9B7b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZsA9B7b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790170698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8cEewKUOsN85qX65B7mWIZXL/Xgq09KjiIiPoqM12k=;
	b=EZsA9B7bzkQlWb6K7kASga35nqO0jhUjkdcpj9XpCF7bK6xOOmJZuAyIUauBr5EGUn5sTn
	NEz7eDUCMjJWDvl9G3Ur3y7vhpTzNO0+7IxOlLBSQs0GVQswVbZAyCqiRKRZCl7tkMdB/4
	EkZjExZdpUu1Zi6vl1UzhM3XQkjNcaM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-cBpLWN4dNFigqFKlw6Q32Q-1; Wed,
 23 Sep 2026 09:38:15 -0400
X-MC-Unique: cBpLWN4dNFigqFKlw6Q32Q-1
X-Mimecast-MFC-AGG-ID: cBpLWN4dNFigqFKlw6Q32Q_1790170693
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58B3919775FB;
	Wed, 23 Sep 2026 13:38:13 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42DC319539A7;
	Wed, 23 Sep 2026 13:38:10 +0000 (UTC)
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
Subject: [PATCH net v11 11/17] rxrpc: Fix double IRQ enablement
Date: Wed, 23 Sep 2026 14:36:58 +0100
Message-ID: <20260923133706.1496540-12-dhowells@redhat.com>
In-Reply-To: <20260923133706.1496540-1-dhowells@redhat.com>
References: <20260923133706.1496540-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

rxrpc_notify_socket() explicitly disables and then re-enables IRQs, but one
of its call chains (rxrpc_input_queue_data() -> rxrpc_end_rx_phase() ->
rxrpc_call_completed() -> rxrpc_set_call_completion()) has IRQs disabled
around it.

Fix this by making rxrpc_notify_socket() use irqsave spinlocks.

Fixes: a2ea9a907260 ("rxrpc: Use irq-disabling spinlocks between app and I/O thread")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260812110129.979970-6-dhowells@redhat.com
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
 net/rxrpc/recvmsg.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 716f7f47d7e4..0c960f13b5fc 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -24,6 +24,7 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
 {
 	struct rxrpc_sock *rx;
 	struct sock *sk;
+	unsigned long flags;
 
 	_enter("%d", call->debug_id);
 
@@ -38,16 +39,16 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
 	sk = &rx->sk;
 	if (rx && sk->sk_state < RXRPC_CLOSE) {
 		if (call->notify_rx) {
-			spin_lock_irq(&call->notify_lock);
+			spin_lock_irqsave(&call->notify_lock, flags);
 			call->notify_rx(sk, call, call->user_call_ID);
-			spin_unlock_irq(&call->notify_lock);
+			spin_unlock_irqrestore(&call->notify_lock, flags);
 		} else {
-			spin_lock_irq(&rx->recvmsg_lock);
+			spin_lock_irqsave(&rx->recvmsg_lock, flags);
 			if (list_empty(&call->recvmsg_link)) {
 				rxrpc_get_call(call, rxrpc_call_get_notify_socket);
 				list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
 			}
-			spin_unlock_irq(&rx->recvmsg_lock);
+			spin_unlock_irqrestore(&rx->recvmsg_lock, flags);
 
 			if (!sock_flag(sk, SOCK_DEAD)) {
 				_debug("call %ps", sk->sk_data_ready);

