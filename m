Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57105370AD4
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 03:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790564452; cv=none; b=Jb0Nv9xVjGUkPel2+WkSFBIwog/7o9ncfUb/nykvWaAXIpOBMuZp2/Cplmgw7VObNr6/uBhUWxsOqWIBVVJmsEwW6ESu4YK/rne7Rqg1wY5zsmDf0yVI5AfFcwteoV3yt1NuzDq151BUuICNQdx24LgbgpZZmduexaAlEIOZ+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790564452; c=relaxed/simple;
	bh=yoLubl3NLm6CW+hzQ84OoEPGYMXubRwWBePLlCXqrbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvJY1v5XhIQxcLOQ9MLGqmI0KzEDg1N1GeyKTqCtQVTdD8VQ7USRIOqaAp8LEMSrVbONGFSYMkp+NYIVngTIPLoteHps1STDQoPyhl4YKiwlSnF1PcYvT2aHsZikO+3TzmJbcov61eS7v22vMe29TkgQGmpVDMAgh77XXHYxvFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=PsIaKThw; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="PsIaKThw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1790564447;
	bh=4M6u2EgaL6jvAadxHwMpLPpQSngk2BbiCgIE/SayhC8=;
	h=From:Subject:Date:Message-ID;
	b=PsIaKThwVWGcTAK1zun2tDWsctZNLp/gKiSmCv//Darce+UfIExLKhTrCfzpyH/YG
	 uZ6yYRBcJPAkVS97SxGNlezWVGmj4TKmnteFP98SVjcLb2TQJmg2jwGNz5EOgKccSX
	 5bE511PK6nkzC9APlXTnVo3aZxjszXYBOwtDE8Gs=
X-SMAIL-HELO: lxu-ped-host..
Received: from unknown (HELO lxu-ped-host..)([111.198.231.89])
	by sina.com (10.54.253.32) with ESMTP
	id 6AB9D85800001AD4; Mon, 28 Sep 2026 11:00:43 +0800 (CST)
X-Sender: eadavis@sina.com
X-Auth-ID: eadavis@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=eadavis@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=eadavis@sina.com
X-SMAIL-MID: 466024456763
X-SMAIL-UIID: 282A3C32C0E14E7F8AD9F83C36657369-20260928-110043-1
From: Edward Adam Davis <eadavis@sina.com>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net,
	dhowells@redhat.com,
	eadavis@sina.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	marc.dionne@auristor.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+e2f5927fc701355ef101@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH v2] rxrpc: Put aborted conn for challenge packet
Date: Mon, 28 Sep 2026 11:00:39 +0800
Message-ID: <20260928030040.185260-1-eadavis@sina.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179033111533.2160803.6082294415431468966@kernel.org>
References: <179033111533.2160803.6082294415431468966@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RxRPC aborts the connection if the secure connection establishment fails.
Subsequently, receiving a challenge-type packet on the aborted connection
does not put the connection, this causes an imbalance in the connection's
reference count, potentially hitting:

kernel BUG at net/rxrpc/conn_client.c:64!
RIP: 0010:rxrpc_destroy_client_conn_ids net/rxrpc/conn_client.c:64 [inline]
RIP: 0010:rxrpc_purge_client_connections+0xc0/0x1a0 net/rxrpc/conn_client.c:145
Call Trace:
 rxrpc_destroy_local+0x262/0x300 net/rxrpc/local_object.c:451
 rxrpc_io_thread+0x2e1a/0x3820 net/rxrpc/io_thread.c:579

Put the connection before returning when processing a received challenge
packet.

Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Reported-by: syzbot+e2f5927fc701355ef101@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2f5927fc701355ef101
Tested-by: syzbot+e2f5927fc701355ef101@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@sina.com>
---
v1 -> v2: put aborted conn for challenge packet

 net/rxrpc/conn_event.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 611c790bc6d0..f9af07d7db4a 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -272,14 +272,15 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 	bool secured = false;
 	int ret;
 
-	if (conn->state == RXRPC_CONN_ABORTED)
-		return -ECONNABORTED;
 
 	_enter("{%d},{%u,%%%u},", conn->debug_id, sp->hdr.type, sp->hdr.serial);
 
 	switch (sp->hdr.type) {
 	case RXRPC_PACKET_TYPE_CHALLENGE:
-		ret = conn->security->respond_to_challenge(conn, skb);
+		if (conn->state != RXRPC_CONN_ABORTED)
+			ret = conn->security->respond_to_challenge(conn, skb);
+		else
+			ret = -ECONNABORTED;
 		sp->chall.conn = NULL;
 		rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
 		return ret;
@@ -323,6 +324,8 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 		return 0;
 
 	default:
+		if (conn->state == RXRPC_CONN_ABORTED)
+			return -ECONNABORTED;
 		WARN_ON_ONCE(1);
 		return -EPROTO;
 	}
-- 
2.43.0

