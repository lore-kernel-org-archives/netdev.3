Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD78B48D868
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781095; cv=none; b=VHOn/MsLzHc57iZQvIE/dDWgouUl/i3iZszdQ2TdPjyiiLxl8g0SsCJoP0Q8jZu4SjFrXm2j4EzfrLgTUVpeK7tRMATWevEFNaJe9mcn/VGU7RLdcSr92tG7I3WR3C3GEGNt5sSROLLc5WmGPnx7XalDyHgC3W6Ms96V1/Tt7us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781095; c=relaxed/simple;
	bh=wwUuDa4eS6XqCSxTxNWd0rsvrdpQOaB5NzlDMTwVm84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8Ph33xdzI+s25hCy3wERrGTdorBq+9m9PTXUvgWVlsi9ga2Gunqd/5+J0NqiwYMKFKwm1BgLZjRQRHjswElnS1Xa/oi83lXGctFjmlqMMCsh3ZuBRMWw5tkVLRqqYig0SQDSy9c5hJ6mDo0i8XttnJTS1aNvAqu2xiGoEQVGeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXVQfeEY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXVQfeEY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788781092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bg/USTIfP8wxD4E88M09UTPS1gwZy1IhDKQimHIpjwI=;
	b=TXVQfeEYTHRnPQRsYhvgvfN/YspeenqCWx90j+mgPRugUUMX6I28m59YOXhXULAvV1Z33L
	HbNcCPdCiOgC3H/gPmjrxkp+s31VuxYWd+b+KyKvTITWudRDChPX/1e13O5Lsn44hFAzl1
	scwmU5z3F2E2hBMSLweX7JDG0FVALFY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-hkmrzlq4MKmJdVyibu2bGg-1; Mon,
 07 Sep 2026 07:38:09 -0400
X-MC-Unique: hkmrzlq4MKmJdVyibu2bGg-1
X-Mimecast-MFC-AGG-ID: hkmrzlq4MKmJdVyibu2bGg_1788781088
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1155119540E7;
	Mon,  7 Sep 2026 11:38:08 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.158])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04266180034F;
	Mon,  7 Sep 2026 11:38:04 +0000 (UTC)
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
Subject: [PATCH net v9 03/14] rxrpc: Fix lack of loop around reply send in rxperf server
Date: Mon,  7 Sep 2026 12:37:30 +0100
Message-ID: <20260907113743.1453210-4-dhowells@redhat.com>
In-Reply-To: <20260907113743.1453210-1-dhowells@redhat.com>
References: <20260907113743.1453210-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix rxperf_process_call() to loop around when sending the magic cookie in
case of a short send.  Also make it always try to abort the call on send
error.

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
cc: stable@kernel.org
---
 include/trace/events/rxrpc.h |  2 +-
 net/rxrpc/rxperf.c           | 15 +++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

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
index b8df6d22314d..ebd54222c64e 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -538,15 +538,18 @@ static int rxperf_process_call(struct rxperf_call *call)
 	iov[0].iov_len	= len;
 	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, len);
 	msg.msg_flags = 0;
-	n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg, len,
-				   rxperf_notify_end_reply_tx);
+	do {
+		n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall,
+					   &msg, msg_data_left(&msg),
+					   rxperf_notify_end_reply_tx);
+	} while (n >= 0 && msg_data_left(&msg) > 0);
+
 	if (n >= 0)
 		return 0; /* Success */
 
-	if (n == -ENOMEM)
-		rxrpc_kernel_abort_call(rxperf_socket, call->rxcall,
-					RXGEN_SS_MARSHAL, -ENOMEM,
-					rxperf_abort_oom);
+	rxrpc_kernel_abort_call(rxperf_socket, call->rxcall,
+				RXGEN_SS_MARSHAL, n,
+				rxperf_abort_send_error);
 	return n;
 }
 

