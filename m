Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E844A5ED4
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398850; cv=none; b=n1W4NmPL3h6mnJmGz5kGTcc8tDMZL2oqz3Wz7yvmfzFah2MTkrSHxjPAj9AvtO8bsqQ9/bNizVWhT4cpbnHHQeZJwnN0AYYz7p62EKjeqzq2x3DX+uCCSkOqvo4IuW0m4EBqv2CWCjemtr6/5kNnJ5f+b2HpsyI6mtq2RttNDf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398850; c=relaxed/simple;
	bh=phAkye/EJNpcSduR90Yp8yo3aM4oCybisxH/jY/cUG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cia/uYjKHSGduEUr//t6Lu9p/uL5qvaUk1O4TZgEyZZLoLn3yYyP/vJcObLbjzBGb2qQO0sTzXebxFbkk/cseKA3zqI+KEa2zjwl2N5Aib7+bER2r0USZL/EhjaZ2MCxnpAIZiFCC+k9cOm4QOAG4RB/l5bENMjrBqRsFnEDWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxC4on0b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxC4on0b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789398847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOO7MP/O7yI0gdCaE6cgkc3hHa5AFZfhvVJeV02lzh0=;
	b=WxC4on0btqpXE/pPTqUxdJbpFfKgvzwUAmxJ7a9wpMwCS0J8AAZPf9gUL3rO65+wVIqLx5
	UCfC09xs08uKSZ9BS4yeiyjHQqv6UJCw9bm4VDLOkirXxUhjUmQg4beodrA7XTB75MCtpg
	CIz904BEPUT15B4bl0baRCXuPjTziDI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-mUJnU8zBPjqvFBDBPZMPLQ-1; Mon,
 14 Sep 2026 11:14:05 -0400
X-MC-Unique: mUJnU8zBPjqvFBDBPZMPLQ-1
X-Mimecast-MFC-AGG-ID: mUJnU8zBPjqvFBDBPZMPLQ_1789398844
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CC23182A100;
	Mon, 14 Sep 2026 15:14:04 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 345F01955F73;
	Mon, 14 Sep 2026 15:14:00 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net v10 03/14] rxrpc: Fix aborting in rxperf test server
Date: Mon, 14 Sep 2026 16:13:27 +0100
Message-ID: <20260914151340.3227501-4-dhowells@redhat.com>
In-Reply-To: <20260914151340.3227501-1-dhowells@redhat.com>
References: <20260914151340.3227501-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix rxperf_process_call() to always abort if it gets a send error rather
than only aborting on ENOMEM.

Fixes: 75bfdbf2fca3 ("rxrpc: Implement an in-kernel rxperf server for testing purposes")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
---
 include/trace/events/rxrpc.h | 2 +-
 net/rxrpc/rxperf.c           | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 554dfb777b93..56dc9b614071 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -28,8 +28,8 @@
 	EM(afs_abort_unsupported_sec_class,	"afs-unsup-sec-class")	\
 	/* rxperf errors */						\
 	EM(rxperf_abort_general_error,		"rxperf-error")		\
-	EM(rxperf_abort_oom,			"rxperf-oom")		\
 	EM(rxperf_abort_op_not_supported,	"rxperf-op-notsupp")	\
+	EM(rxperf_abort_send_error,		"rxperf-send-error")	\
 	EM(rxperf_abort_unmarshal_error,	"rxperf-unmarshal")	\
 	/* RxKAD security errors */					\
 	EM(rxkad_abort_1_short_check,		"rxkad1-short-check")	\
diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index dad04062213f..7e9a53615309 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -538,10 +538,10 @@ static int rxperf_process_call(struct rxperf_call *call)
 	msg.msg_flags = 0;
 	n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
 				   rxperf_notify_end_reply_tx);
-	if (n == -ENOMEM)
+	if (n < 0)
 		rxrpc_kernel_abort_call(rxperf_socket, call->rxcall,
-					RXGEN_SS_MARSHAL, -ENOMEM,
-					rxperf_abort_oom);
+					RXGEN_SS_MARSHAL, n,
+					rxperf_abort_send_error);
 	return n;
 }
 

