Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164F41C2E8
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503427; cv=none; b=WVch6w7cH9YgESfGu/KMPFr+Lt5Z9SdIcaQwUzQcJWBqop/siOc/FmPwIV/2e466sEvxN5hGRysgv0kTsp+16S2GiJgOY0ruMefhXZ9MYlVkLm6jejurHRf6I26bHGVmDMAKsnDWkGhS/CLgiBW5EaSUb134wOXXfiP2iLq5MGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503427; c=relaxed/simple;
	bh=DzsX1puom5eEftUovrdNZ95H6ISbQl90ZBBHvuTcBdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NwUzMRpjEjm0OWWtLh8mb9RaJy2WJaduzzH9XpY5w0ePweolKeJsWMd8PlIV/G0sxedH+Or6EtOQdd44n9jgf2v0B73XPF1pYgaiQaVT6+b7IZWAi5+tWAusiBQK/0cHIxbFrsx1QfDruXSy9QEGv3aCePXF6sKavc3y0x1jHKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GQFatmxv; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GQFatmxv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783503411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ydX26kqe1zakyWKUhYdu+Skm/dFs17mN2Looq9WX1As=;
	b=GQFatmxvNfZvuFNZUMKCO+9nP07ZBojZc2FU7TCp9ctSRUsBVvXcykzBE2YV99igOX+J+d
	XeChxXLvgy1lLNxEx8FzxYbXVMxO3uM1jNZCNwDh9tEoDPcmWEqOLPgi9R2WFm5Wjx96K7
	p2dNeN5biWPm6HltpKDaG+vIGGacans=
From: xuanqiang.luo@linux.dev
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	netdev@vger.kernel.org,
	linux-afs@lists.infradead.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v1] rxrpc: fix io_thread race in rxrpc_wake_up_io_thread()
Date: Wed,  8 Jul 2026 17:35:34 +0800
Message-ID: <20260708093534.53486-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

rxrpc_wake_up_io_thread() checks local->io_thread before waking it, but
then reloads the pointer for wake_up_process().

local->io_thread is cleared with WRITE_ONCE() when the I/O thread exits, so
the second load can see NULL even if the first load did not.

Take a READ_ONCE() snapshot and use it for both the NULL check and the
wake_up_process() call, as rxrpc_encap_rcv() already does.

Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/rxrpc/ar-internal.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index ce946b0a03e2b..865f05fe37ab9 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1285,9 +1285,11 @@ int rxrpc_io_thread(void *data);
 void rxrpc_post_response(struct rxrpc_connection *conn, struct sk_buff *skb);
 static inline void rxrpc_wake_up_io_thread(struct rxrpc_local *local)
 {
-	if (!local->io_thread)
+	struct task_struct *io_thread = READ_ONCE(local->io_thread);
+
+	if (!io_thread)
 		return;
-	wake_up_process(READ_ONCE(local->io_thread));
+	wake_up_process(io_thread);
 }
 
 static inline bool rxrpc_protocol_error(struct sk_buff *skb, enum rxrpc_abort_reason why)
-- 
2.43.0

