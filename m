Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541CC3BE62A
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790530; cv=none; b=aWlBpgQkOcUvXA8UG0+7vdrRZd+WR+u4hh5rgqsXcl584qHezasOeZbIyEAv6/85hQdUcdyi7q/xTQ04TUxu+nKMqnhRlirv2T82Cje8nF/ZpEOihkDqT7fNBbh2srcZ2RkDEIJLyRMVKd58ia5JvmPqENu0IFXTDorloRopi1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790530; c=relaxed/simple;
	bh=M52mmJHnSjPEDJVr/Qudi5l9T4qztSCwFcaAXl9Dxd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dh9bU/7xaHKiguZMCTsoMBBhJWNZNwsjHgnBiLPW2gaF95tvUZqZenJTQODcNrBSCF909g5/tXU//RsBScKRnY+df+zTbjm2/uVs/xfRBBzWFUK2yjTUESyLoARcj9vsCFuZCutiJU9FQNAP2wiv0OzGPgMB7uXQlkwmLs0XobA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6mevBkK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6mevBkK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781790528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hR3NXwesdh6engLbFKPnQ+1uo+KCD6W5AsWNcNQfWfA=;
	b=f6mevBkKLKePBBfnf++G+K1EByqWOJtdXHGDdnCSVxCVE7thBzzoxDKAUCWGX7dBLoUHyY
	qVFk6swqL/GJpKzDJu1A7FHrh8Z2Y3sY5YBhNHfJDLAkVCtcPkKtQk346G/VUh24pOnWMN
	RnH6IVOYJusUZHwk1+YOTlFlbL0yLAU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-LAyus29fNTWhW_Sa5Fbowg-1; Thu,
 18 Jun 2026 09:48:42 -0400
X-MC-Unique: LAyus29fNTWhW_Sa5Fbowg-1
X-Mimecast-MFC-AGG-ID: LAyus29fNTWhW_Sa5Fbowg_1781790519
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DC7619300F3;
	Thu, 18 Jun 2026 13:48:32 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76DE01800667;
	Thu, 18 Jun 2026 13:48:28 +0000 (UTC)
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
	Li Daming <d4n.for.sec@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH net v2 04/10] afs: Fix further netns teardown to cancel the preallocation charger
Date: Thu, 18 Jun 2026 14:47:55 +0100
Message-ID: <20260618134802.2477777-5-dhowells@redhat.com>
In-Reply-To: <20260618134802.2477777-1-dhowells@redhat.com>
References: <20260618134802.2477777-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When an afs network namespace is torn down, it cancels and waits for the
work item that keeps the preallocated rxrpc call/conn/peer queue charged
before disabling incoming (i.e. listen 0), but there's a small window in
which it can be requeued by an incoming call wending through the I/O
thread.

Fix this by flushing the workqueue on which the charger runs after reducing
the listen backlog to zero.

Fixes: 47694fbc9d24 ("afs: Fix netns teardown to cancel the preallocation charger")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://sashiko.dev/#/patchset/20260609140911.838677-1-dhowells%40redhat.com
cc: Li Daming <d4n.for.sec@gmail.com>
cc: Ren Wei <n05ec@lzu.edu.cn>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 fs/afs/rxrpc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index d5cfd24e815b..6714a189d58f 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -128,8 +128,13 @@ void afs_close_socket(struct afs_net *net)
 	_enter("");
 
 	cancel_work_sync(&net->charge_preallocation_work);
+	/* Future work items should now see ->live is false. */
+
 	kernel_listen(net->socket, 0);
+
+	/* Make sure work items are no longer running. */
 	flush_workqueue(afs_async_calls);
+	cancel_work_sync(&net->charge_preallocation_work);
 
 	if (net->spare_incoming_call) {
 		afs_put_call(net->spare_incoming_call);

