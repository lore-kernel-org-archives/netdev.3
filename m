Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4784AC14A
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398902; cv=none; b=VHJc0qsuQq/Ni2VfUVFN/FbWjx4lqevU5jFsFq3ES+PbBpsamMb6UZLEdz10tpigwHM1WsuhNovVvVbId+xEUUY1PKKHSIAkQumdJ72bDU1JR9DZuWdKtVtwO/Wc6fPRYEjsbiSU7ZyKIRBgbX1eFfs/4MXBiGUXjrDQzQRj/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398902; c=relaxed/simple;
	bh=Xkx5uacLGMq2ROvzW9biAuFwvhBWSlh0ZaPMFOhQcvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpCyKdfoRVefwqTdDH3gwdVUAsZ5Q+2oebWS35SwC2ndhSly3vJaMGUwW4p0ryBglNZ7fRZGCWinZgRp9LPk1EWLTKQLOljjaar0jFA1+bGvjau26KdtZLqF5lT9ytgkqRkCka5+a4vwS88RquC/l7Uer7EKCjFui6c6LQWXPeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=behZT0eY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="behZT0eY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789398898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PicxqHVPZpCvrfAde8up7sgm2mpBjZr5f4x8vg4jkKM=;
	b=behZT0eYVQSCNOuiKiok2MCNHx1Qz01G4HSWRb3s3Lgq+nGnq9Ts66ZnaiVACefj3jOSW+
	06proTfbSa8Ney8Dmmn7MWTrNiBeLGU+DoyFCWstrhshh1JuehcpAyCb9RQUj3qBlRaPdH
	S5nhp016r73qs1M/8F94v7m6UfGhnOY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-g-n6QT3sMXm3k7qj4pPO1g-1; Mon,
 14 Sep 2026 11:14:54 -0400
X-MC-Unique: g-n6QT3sMXm3k7qj4pPO1g-1
X-Mimecast-MFC-AGG-ID: g-n6QT3sMXm3k7qj4pPO1g_1789398893
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64EC019540EC;
	Mon, 14 Sep 2026 15:14:53 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 776761955F7D;
	Mon, 14 Sep 2026 15:14:50 +0000 (UTC)
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
Subject: [PATCH net v10 13/14] afs: Fix uncleared op->call pointer
Date: Mon, 14 Sep 2026 16:13:37 +0100
Message-ID: <20260914151340.3227501-14-dhowells@redhat.com>
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

Fix uncleared op->call pointer in afs_wait_for_operation() lest server
rotation occur and try to reuse the call.  Note that afs_read_receive()
already does this.  Note that this was spotted by AI code inspection rather
than by hitting an issue.

Fixes: 6f2ff7e89bd0 ("afs: Don't put afs_call in afs_wait_for_call_to_complete()")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907113743.1453210-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
---
 fs/afs/fs_operation.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 20801b29521d..94fa65548d71 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -297,6 +297,7 @@ void afs_wait_for_operation(struct afs_operation *op)
 			op->call_error = op->call->error;
 			op->call_responded = op->call->responded;
 			afs_put_call(op->call);
+			op->call = NULL;
 		}
 	}
 

