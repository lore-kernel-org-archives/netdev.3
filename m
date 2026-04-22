Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98353845C1
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874524; cv=none; b=CLZ50vKd5FTWf9r5c7W2kCqodQ3NCIT46BqWNm600oI+EaL4hC77lBAuUKYwonE4xRIoB21mIxzzR50QCzPJtaPZKkDfzBWod+H+9J+p0PzvM8igBDpldrZnneiY88NCWQ+keJgbtLkht2bXpym/QhAlkG2VlazOB/frAJ6DX4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874524; c=relaxed/simple;
	bh=VC0xaEp18VE11/4HL93isyezfiB6giE7QUc/XgHBk/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVCvAjl3pNi8w1mhVIUNr78XrrOC0hTt5KflIhy93UwofpJ5dSjc24FK0AuwVjWBGeqOtHgzjjmGqmlBchfVWkP914tVeeYqB0TRiSMksyeGmdgvM+fJfdc+KqgVMusMPL/fr+k2fVfLEZH1hac+iPi7Py8KTTEsY7XkSJU0AwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zx3vNG33; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zx3vNG33"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776874522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tg/xm4khmGTMt0O8denk3V8PJT+Q+STOFvsXoz9Lch4=;
	b=Zx3vNG339tz5SWgDyIWLb4sLN7NSs5W75byHFUgAWwNsOu3nGb+38SZHnKKlK3GeQjCQUZ
	k9mQCgKNXfovdPLs3gpQ3mTKbbFdlGRelkwonHAXOSZ9mEePfBuJHqRTP9Tc0NeRoXorfn
	qt/5pFB68Y6HyMw9Unwd+ngCQNbHA68=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-uyVVsCh6Nxykmm23qjQCYw-1; Wed,
 22 Apr 2026 12:15:17 -0400
X-MC-Unique: uyVVsCh6Nxykmm23qjQCYw-1
X-Mimecast-MFC-AGG-ID: uyVVsCh6Nxykmm23qjQCYw_1776874514
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D5F218005A8;
	Wed, 22 Apr 2026 16:15:14 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D851180047F;
	Wed, 22 Apr 2026 16:15:10 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Anderson Nascimento <anderson@allelesecurity.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH net v2 5/6] rxgk: Fix potential integer overflow in length check
Date: Wed, 22 Apr 2026 17:14:34 +0100
Message-ID: <20260422161438.2593376-6-dhowells@redhat.com>
In-Reply-To: <20260422161438.2593376-1-dhowells@redhat.com>
References: <20260422161438.2593376-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix potential integer overflow in rxgk_extract_token() when checking the
length of the ticket.  Rather than rounding up the value to be tested
(which might overflow), round down the size of the available data.

Fixes: 2429a1976481 ("rxrpc: Fix untrusted unsigned subtract")
Closes: https://sashiko.dev/#/patchset/20260408121252.2249051-1-dhowells%40redhat.com
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
 net/rxrpc/rxgk_app.c    | 2 +-
 net/rxrpc/rxgk_common.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/rxgk_app.c b/net/rxrpc/rxgk_app.c
index 30275cb5ba3e..5587639d60c5 100644
--- a/net/rxrpc/rxgk_app.c
+++ b/net/rxrpc/rxgk_app.c
@@ -214,7 +214,7 @@ int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
 	ticket_len	= ntohl(container.token_len);
 	ticket_offset	= token_offset + sizeof(container);
 
-	if (xdr_round_up(ticket_len) > token_len - sizeof(container))
+	if (ticket_len > xdr_round_down(token_len - sizeof(container)))
 		goto short_packet;
 
 	_debug("KVNO %u", kvno);
diff --git a/net/rxrpc/rxgk_common.h b/net/rxrpc/rxgk_common.h
index 80164d89e19c..1e257d7ab8ec 100644
--- a/net/rxrpc/rxgk_common.h
+++ b/net/rxrpc/rxgk_common.h
@@ -34,6 +34,7 @@ struct rxgk_context {
 };
 
 #define xdr_round_up(x) (round_up((x), sizeof(__be32)))
+#define xdr_round_down(x) (round_down((x), sizeof(__be32)))
 #define xdr_object_len(x) (4 + xdr_round_up(x))
 
 /*

