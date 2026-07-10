Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0A2384238
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711360; cv=none; b=MB1c8o+v8XU8e4ldYfNxTwufgN8473KUbwKdxMGlvRwPLkPyw/63V7qcIiPJenrfTGTkHiGCl/GrZADv/SPauTJrWxZDKlIbmZAI6/HDrcPk5XD14U31T6nRdMuNfIeqp876k3LUN5O4iFQGeLwlyF/s4+f7qmg050feSX7W+dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711360; c=relaxed/simple;
	bh=E1DKv1zWMYA4DFk3hmqLlCOGhxl4FdyLa/Rx8tHLo+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBe99Z1PstRpFida7wS6RHlsN5MeSdUbIA+TyP85faYbgoJVIm9fLlvxRaqnpdnZUYLBhFpp2zec5wlJBHUUQS7BhxREE8smuZgBzll58cBiWdiAUVOZ5W3pjpiBcOrc4REPXNqZC0T0D36R3YuoEQdAf8NhDev+BpFnwdmdWVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IsOz/2px; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsOz/2px"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783711358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NahzdypL9w7RySKlcv+DTp0PkyrUPrVJ3XH0FwVcdO8=;
	b=IsOz/2px5Ml2KIL++FfnWMvvbGgX4GFmyK9llq3NT6x2Zrpc+S8hxP/EnCBtqBqQtmPLgr
	eacnyj1lZYe68c+oAOlu/KmaCGGR3l2H+5m64J7U9nBPDMfKQnfKygvpRXuumzBwwDlave
	okopYZ/LaoQ1ZS/JH0uTmTw5QIgr+EI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-dmHEOo56O0uibFApa7m0Ag-1; Fri,
 10 Jul 2026 15:22:35 -0400
X-MC-Unique: dmHEOo56O0uibFApa7m0Ag-1
X-Mimecast-MFC-AGG-ID: dmHEOo56O0uibFApa7m0Ag_1783711353
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDCC418002FF;
	Fri, 10 Jul 2026 19:22:32 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 06274195608E;
	Fri, 10 Jul 2026 19:22:28 +0000 (UTC)
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
	stable@kernel.org
Subject: [PATCH net v2 01/16] afs: Fix NULL deref in afs_deliver_cb_init_call_back_state3()
Date: Fri, 10 Jul 2026 20:22:03 +0100
Message-ID: <20260710192220.1922433-2-dhowells@redhat.com>
In-Reply-To: <20260710192220.1922433-1-dhowells@redhat.com>
References: <20260710192220.1922433-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fix afs_deliver_cb_init_call_back_state3() to avoid a potential NULL deref
should call->server be NULL (ie. afs_rx_new_call() failed to find a
matching server record) when it checks the server's UUID.

Fixes: 40e8b52fe8c8 ("afs: Use the per-peer app data provided by rxrpc")
Link: https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 fs/afs/cmservice.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 5540ae1cad59..d579a665e3da 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -364,7 +364,8 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
 		return afs_io_error(call, afs_io_error_cm_reply);
 
-	if (memcmp(call->request, &call->server->_uuid, sizeof(call->server->_uuid)) != 0) {
+	if (call->server &&
+	    memcmp(call->request, &call->server->_uuid, sizeof(call->server->_uuid)) != 0) {
 		pr_notice("Callback UUID does not match fileserver UUID\n");
 		trace_afs_cm_no_server_u(call, call->request);
 		return 0;

