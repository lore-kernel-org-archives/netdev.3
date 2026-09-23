Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895AB5383F2
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170724; cv=none; b=smzYIDNWf+JnzqgULC1MS+Lu9A2y94sc1YDOKHqA1upJ/tbYH0PugXyARPN4KfPdNQAG0RQb3cYllJ+Q/8sSHaeUqYJ8OX0622z84plwfP4Bchh0+PqUDitHH+NaF+pnPC/1QD2Z97wuRFSo4SLv+0ZfNDXd6oQ/WerHRBIcGf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170724; c=relaxed/simple;
	bh=C5Z33UK1q9A2DIreWQwpPUin3DP+A9ytD5ps3dEuVDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMyd2Ow0Mhx9fHtxAIiJcrf01eU0XiHJ9c5OeNfYjGC3hat6FD+yRWXtFfrvP7wygyVIysOLA0I1tQswyrEjqY1QiBzhR7TV/IaqFNVEg1C15IvAWrluX00wjTB6kHTnPxJfyJFgaTmDK+8YAyWbjKuvi77LI29BUOQya6a4AG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTd4MsBI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTd4MsBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790170721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9h5xcT8+EYkwS6UIVrfYDzPRvAU8rPGMSJ7y80eXqKQ=;
	b=XTd4MsBITKAujYF0IjVKcGR0wmvmD1UB3ixjRQvmAmw93A2IfGoJwKTcC9i3e1klYe9XP5
	hBAALmKIyyk0RO9VA4AnbagopBB7X2kWVXD52aS8ErHsT49nqA+H6yNhg8PD2FmXR8iv0R
	F1/kjiT+Hoc89RAcgCrLlSKUcwswfOc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-X0GjhdGRMlCSoIo7vPp8GA-1; Wed,
 23 Sep 2026 09:38:40 -0400
X-MC-Unique: X0GjhdGRMlCSoIo7vPp8GA-1
X-Mimecast-MFC-AGG-ID: X0GjhdGRMlCSoIo7vPp8GA_1790170718
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CB451955DCE;
	Wed, 23 Sep 2026 13:38:38 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 92DF01956042;
	Wed, 23 Sep 2026 13:38:35 +0000 (UTC)
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
Subject: [PATCH net v11 16/17] afs: Fix uncleared op->call pointer
Date: Wed, 23 Sep 2026 14:37:03 +0100
Message-ID: <20260923133706.1496540-17-dhowells@redhat.com>
In-Reply-To: <20260923133706.1496540-1-dhowells@redhat.com>
References: <20260923133706.1496540-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fix uncleared op->call pointer in afs_wait_for_operation() to make sure
that it isn't seen set if server rotation occurs.  Note that
afs_read_receive() already does this.  Note also that this was spotted by
AI code inspection rather than by hitting an issue.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
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
 

