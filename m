Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2122EEE66
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293460; cv=none; b=TIpqXN/AYGy82Q2kY/HOMzshyf8UvV+Zn+jKuaLkl5YAgDMxePzFGzet2woTDFQ+gNNityr2PtNq5sUeM+vRuyyjBVaYziNY09xRkRXd0/2Xjn5YX1C5t6NimvYDkwHzCucOmkoLVOO32GdK0lsKgQXpmFlj1/H47b0ISpi/91I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293460; c=relaxed/simple;
	bh=kDBIIl45O2T4d/byIUEpXWwSeAMYt0uG962XhCRLDj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6lL2R79IJ23rzK+yUD4eIpsqSEzeOo1HMp98j0nLVl8Q+Z2B1ugqpXlpmaYCGp5YVrGaSzZ4gIc3JAkkqvDs78VzcxS7T8ktSqPhAzQ4l6/IDYLxevBO9GWksq7elSuHFkfG9NqecQIDrfjFTQ5GP0cWNUdhDSr12oFl4Odjc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eiIy8ZSU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiIy8ZSU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791293455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MD1FRdLLly2uzv/0FzyzmeRbgozglo3oqKTacqAml0E=;
	b=eiIy8ZSU/REKV0TW1GUaSQ65ALGPtdgbVm3JWQRGNbOhBxCiWveCGqMaH1gDK90tSNt7mO
	ptmmz33At+ogu5qpt1AQKsMiSEhsl0nLuQLEN5cJurqGYzLlk8Cz/aiSPQvKDwlAwV8rlR
	6P8i2GzD8cBiG4zp3t53CnCLECrlH1E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-7Y98lzldMn-quZI_90LFiQ-1; Tue,
 06 Oct 2026 09:30:52 -0400
X-MC-Unique: 7Y98lzldMn-quZI_90LFiQ-1
X-Mimecast-MFC-AGG-ID: 7Y98lzldMn-quZI_90LFiQ_1791293450
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4F0719235E3;
	Tue,  6 Oct 2026 13:30:50 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.90])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D716019560AB;
	Tue,  6 Oct 2026 13:30:47 +0000 (UTC)
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
Subject: [PATCH net v12 06/15] rxrpc: Fix aborting in rxperf test server
Date: Tue,  6 Oct 2026 14:29:58 +0100
Message-ID: <20261006133011.531806-7-dhowells@redhat.com>
In-Reply-To: <20261006133011.531806-1-dhowells@redhat.com>
References: <20261006133011.531806-1-dhowells@redhat.com>
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
 include/trace/events/rxrpc.h |  2 +-
 net/rxrpc/rxperf.c           | 11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

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
index 981c0596c774..823eedc5d16f 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -515,7 +515,7 @@ static int rxperf_process_call(struct rxperf_call *call)
 		ret = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
 					     rxperf_notify_end_reply_tx);
 		if (ret < 0)
-			return ret;
+			goto send_error;
 		reply_len -= len;
 	}
 
@@ -526,10 +526,11 @@ static int rxperf_process_call(struct rxperf_call *call)
 	msg.msg_flags = 0;
 	ret = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
 				     rxperf_notify_end_reply_tx);
-	if (ret == -ENOMEM)
-		rxrpc_kernel_abort_call(rxperf_socket, call->rxcall,
-					RXGEN_SS_MARSHAL, -ENOMEM,
-					rxperf_abort_oom);
+	if (ret == 0)
+		return 0;
+send_error:
+	rxrpc_kernel_abort_call(rxperf_socket, call->rxcall, RXGEN_SS_MARSHAL,
+				ret, rxperf_abort_send_error);
 	return ret;
 }
 

