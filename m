Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064D6378D8D
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790136640; cv=none; b=h/M5Y4JcPkH3zbVxoP2yjtSvdGR0L1nzuaGsIfVhlQE7WoWzr1R8JafR6xZPw3bpIjQQ3HssJGilmJw0MYrU2d9uZRKSqy0Uaa5nnNlVsi7GRZx/OjPmCPWm+ck3oFmNbTy0LlP96djS+jQPaoyjJoe2ak4fJNpMJEIa5Eol2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790136640; c=relaxed/simple;
	bh=AbluJKhWQG7R//IQcs3VYld/GNgrDvqSrPoABDKJ0aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8eV9yy2fcqwCzoe1yt9csh8AUg3YOsRyL2UXyXjjjTikrNovucIouLKYSdDW93dVQmupOehPRC7+sMiBLSBy5WjVt/UITOSKAVUD6CE/Z8MDQQIY11rHZDVX7oCp8/Mizg35WrmCEK3aWephFja88JhEdRzRFhafHFsdOrUMSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=SLPVJ27e; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="SLPVJ27e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1790136633;
	bh=vctU8jIPt/tdK1W5q74hFGGDVYfrrQaTOaAmh66VVno=;
	h=From:Subject:Date:Message-ID;
	b=SLPVJ27e7/4qP3OIa8RwQldOOdn6oDZwvgbJzUGNpiRPRAI8NFqW9+7lMfSI5Hjaf
	 GaVd8j6Q8gi3cWMdWcnGHA6t3FLg/TnUJU1GJ7rpeFfpqZ6PhrkEjR+lYhgp8O2j/t
	 ZZqO1tlvbFJcrsAJFs7L5Q/3M4wCETKeA7mOV28k=
X-SMAIL-HELO: lxu-ped-host..
Received: from unknown (HELO lxu-ped-host..)([111.198.231.89])
	by sina.com (10.54.253.32) with ESMTP
	id 6AB3512E0000415F; Wed, 23 Sep 2026 12:10:28 +0800 (CST)
X-Sender: eadavis@sina.com
X-Auth-ID: eadavis@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=eadavis@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=eadavis@sina.com
X-SMAIL-MID: 6404444456922
X-SMAIL-UIID: DDD1CD4C22914D4B943D2571998711FF-20260923-121028-1
From: Edward Adam Davis <eadavis@sina.com>
To: syzbot+e2f5927fc701355ef101@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	dhowells@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	marc.dionne@auristor.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] rxrpc: add missing unbundle old conn
Date: Wed, 23 Sep 2026 12:10:22 +0800
Message-ID: <20260923041022.25845-1-eadavis@sina.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6ab2989e.a6af0033.177e91.0021.GAE@google.com>
References: <6ab2989e.a6af0033.177e91.0021.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding a new connection to the bundle, the old connection was not
removed from the bundle before being dropped, potentially hitting:

kernel BUG at net/rxrpc/conn_client.c:64!
RIP: 0010:rxrpc_destroy_client_conn_ids net/rxrpc/conn_client.c:64 [inline]
RIP: 0010:rxrpc_purge_client_connections+0xc0/0x1a0 net/rxrpc/conn_client.c:145
Call Trace:
 rxrpc_destroy_local+0x262/0x300 net/rxrpc/local_object.c:451
 rxrpc_io_thread+0x2e1a/0x3820 net/rxrpc/io_thread.c:579

Old connections that cannot be reused need to be unbundled.

Reported-by: syzbot+e2f5927fc701355ef101@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2f5927fc701355ef101
Tested-by: syzbot+e2f5927fc701355ef101@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@sina.com>
---
 net/rxrpc/conn_client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 48519f0de185..9f13520be249 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -335,6 +335,7 @@ int rxrpc_look_up_bundle(struct rxrpc_call *call, gfp_t gfp)
 /*
  * Allocate a new connection and add it into a bundle.
  */
+static void rxrpc_unbundle_conn(struct rxrpc_connection *conn);
 static bool rxrpc_add_conn_to_bundle(struct rxrpc_bundle *bundle,
 				     unsigned int slot)
 {
@@ -344,6 +345,7 @@ static bool rxrpc_add_conn_to_bundle(struct rxrpc_bundle *bundle,
 
 	old = bundle->conns[slot];
 	if (old) {
+		rxrpc_unbundle_conn(old);
 		bundle->conns[slot] = NULL;
 		bundle->conn_ids[slot] = 0;
 		trace_rxrpc_client(old, -1, rxrpc_client_replace);
-- 
2.43.0

