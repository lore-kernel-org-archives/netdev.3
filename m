Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4F234A796
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794345; cv=none; b=FzwDP23BmgoYJTeTb6BaHV/V466E5LKFAigPT7P2ML0tS1fJDcE9NuvAEzJQg9NaWJixH9jOG9IwimtYWsiIaRbYCwXSZyoTMlBxhxVN+NRSxnd3LiFPNLsXZYzl3tTnqjPdadRcbh5AO70WrR/XFycpG9K79oX6UwsUeH5NKmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794345; c=relaxed/simple;
	bh=8deJ0SmJCOcNPsWSe0IKJTMfB7NVEr+sfErU5XXltVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D4QsAFyrJFfZFd9ONqMfP4hQ2jNgNzaOn6RnNEnevMzuciz5rkDfKf96iHny2yrPjDbsUPZGVlr4jFXakXgfYdRItJY+mqk7grCiw5TGVIxRjZ/aITTxM7MTJCEpaDUKtPXgIGYWBkB6Vlgjese9Oszv2hgIVFUtg60MCAWkDo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sr8iTDJ0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sr8iTDJ0"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e618db81c0so14165195ad.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 01:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791794344; x=1792399144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0fH2wtCeYIH7fxQP2FbdZIo9RnDH4xLIDypfRPvi78Y=;
        b=sr8iTDJ0EvBrh40bu0eF/NX22+XPG6nC49+1ne0YAp0ZDVb9UdQaxj5oD+bf1TLGbj
         1VMWW7kKxaY4FMZnQnUz/r4CAo5OLCu99RXDYJeQO5uNaaJu5KEgGu6AN5oHVMomjwNi
         cQAMFB1Ta0b7KGtGayLLMDDFXnZatkaVG/Qq7uRv8aeX5cfYOVKT/w8ZZi3D8NncVXU2
         kn+mOFNgCn9oWt2mWdAHK6i9BKCdf4NVzc3Hks+zWXaBfBs9GuitMl9nGWHrudub+vR4
         NNO2vQVR2tux5fv2D9xSO1RmksT0jFn9OmoZd/oqgG2fEhjGzvLGEFrbBrSuriWDHG5/
         GSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791794344; x=1792399144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0fH2wtCeYIH7fxQP2FbdZIo9RnDH4xLIDypfRPvi78Y=;
        b=IWJS3wh73Zor4cZo0oEV9Fb2fO6Ip95GNnjJcXVUGg5U1+aIu2qBinu8v+Fvv0N96M
         0LyRo4ZlmndBVG5cPLiNIrKJzVQJ9uuPoyLAsNTyTp1AGnNZxWFepvBSE3vXs4ovegIt
         g9ijNY7PWyV1n1Ym/5t58EP5r20mwJ8aRPWKasxxCltYns5CBHt3knXo5FkZWc9wyuBU
         NXn9cnCSxKCwzgPEBuUEQkW9wXSDtltN6Ofg6dnq9jrCG0P2wNcre7IUxw80WnWVuXgd
         FmGUeD0EhuhFsnKi/WavHu+YqkCc3lz5gbFZnCr1Oe1GsKp024wdwqKinH1hDNOTwnZV
         CmFA==
X-Forwarded-Encrypted: i=1; AKwUvBzG89OUZEztQboCkl90xDn/gaJEnYpWNdkNpORifuPVGMKoyuOK1nw7JW1fUoGGJvvsHC1coTg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBa1bG4/mdy4RXLR11GuuhQOIWFSA6xTIIAtSiW1wnxUhNI45+
	MXr4snajIUS7o6N5evRLL52HiPSHN3eebB9iIPwFO5Bt4Mwvjrx6Lcvb9+RPCGCMHxw=
X-Gm-Gg: AYBFou1njZWT3gKEm92F2k0TqZaDlwembdhuxhLobW65dzuQwVM4bUrTOKQtWH1RUwG
	ZEmvrC9lDcgKEF+1xk1RhEeqQzblgeWeZI59k+f/Ri7O/jtc5Hr4jfNh+CPHvnkg6pmZ5rnJhe6
	gCt4DVqjrSWAcgVf9tYJbylDvRyFGqSCVmF6fEbexbHTbTWA23DLfemsoeocko0WHsv6n9/XFH0
	rK1sTWakFeMPkvc6rlX3SKCORn8uKxoa7UM2t2ay9n5Ai0iYk66zcr/s+YP3QalEKLaP2KdCXDH
	2sSjH95oTilQQGmarGpP7NLnAxhYWYo/UOoi4AYhmd00wYvtj84pAN4skD7QvLrp7FWbvjJdm6i
	hz8eoh9gMgpgeLj2XavtF8tkmxdjkXLwLWEWC0YuQ+P/4FX6vpOJKqpUQbjETohnnYWV7FCWQZd
	nAYw4g1ivB+gHo1kkD64LmsucfNEW3yVU7jCqI7HQZcA5fTx97v0xR+JRyElYTBOkzb7xiIN7dh
	PiyaWOdqMifds7udNU8rBoPd/nMMVgxWp+OkEpBgYsbuoa0gXl6gMQ30A==
X-Received: by 2002:a17:903:1b6b:b0:2d9:383a:30f1 with SMTP id d9443c01a7336-2e842820605mr84465605ad.4.1791794343388;
        Mon, 12 Oct 2026 01:39:03 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b5924sm40200745ad.47.2026.10.12.01.38.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 01:39:03 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: dsahern@kernel.org,
	idosch@nvidia.com
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kaber@trash.net,
	netdev@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net] ipv6: take tb6_lock across the fib6 dump sernum snapshot
Date: Mon, 12 Oct 2026 16:38:20 +0800
Message-ID: <20261012083843.60510-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

A resumable RTM_GETROUTE dump parks a raw struct fib6_info pointer in
w->leaf when the skb fills (fib6_dump_node()) and resumes from it on the
next recvmsg(). No reference is held across the suspension; the only
thing standing between the walker and a freed route is the fn_sernum
check in fib6_dump_table(), which restarts from the root when the tree
changed.

That check is done outside tb6_lock at both ends: the snapshot after the
first walk is taken after spin_unlock_bh(), and on continuation the
compare runs before spin_lock_bh(). A writer that slips in between, e.g.
RTM_NEWROUTE with NLM_F_REPLACE on the route the walker is parked on,
frees the route via fib6_info_release() (the replace path has no
FOR_WALKERS fixup, unlike fib6_del_route()) and bumps fn_sernum, yet the
dump records the new serial next to the stale w->leaf, or passes the
compare and only then takes the lock. Either way the restart is skipped
and fib6_walk_continue() hands the freed route to rt6_fill_node():

  BUG: KASAN: slab-use-after-free in rt6_fill_node (net/ipv6/route.c:5821)
  Read of size 4 at addr ffff88810adb0c64 by task fib6dump-repro/541
  CPU: 0 UID: 1000 PID: 541 Comm: fib6dump-repro Not tainted 7.3.0-rc6 #1 PREEMPT
  Call Trace:
   rt6_fill_node (net/ipv6/route.c:5821)
   rt6_dump_route (net/ipv6/route.c:6130)
   fib6_dump_node (net/ipv6/ip6_fib.c:534)
   fib6_walk_continue (net/ipv6/ip6_fib.c:2180)
   fib6_dump_table (net/ipv6/ip6_fib.c:620)
   inet6_dump_fib (net/ipv6/ip6_fib.c:714)
   rtnl_dumpit (net/core/rtnetlink.c:7006)
   netlink_dump (net/netlink/af_netlink.c:2350)
   netlink_recvmsg (net/netlink/af_netlink.c:2001)
   sock_recvmsg (net/socket.c:1173)
   __sys_recvfrom (net/socket.c:2331)

Take tb6_lock once at the top of fib6_dump_table() and hold it across
the snapshot, the comparison and the walker call, so fn_sernum is read
in the same critical section as the walk it describes.

Fixes: 2bec5a369ee7 ("ipv6: fib: fix crash when changing large fib while dumping it")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 net/ipv6/ip6_fib.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 9ff761962b45..70482381165f 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -592,14 +592,13 @@ static int fib6_dump_table(struct fib6_table *table, struct sk_buff *skb,
 	w = (void *)cb->args[2];
 	w->root = &table->tb6_root;
 
+	spin_lock_bh(&table->tb6_lock);
 	if (cb->args[4] == 0) {
 		w->count = 0;
 		w->skip = 0;
 		w->skip_in_node = 0;
 
-		spin_lock_bh(&table->tb6_lock);
 		res = fib6_walk(net, w);
-		spin_unlock_bh(&table->tb6_lock);
 		if (res > 0) {
 			cb->args[4] = 1;
 			cb->args[5] = READ_ONCE(w->root->fn_sernum);
@@ -616,14 +615,13 @@ static int fib6_dump_table(struct fib6_table *table, struct sk_buff *skb,
 		} else
 			w->skip = 0;
 
-		spin_lock_bh(&table->tb6_lock);
 		res = fib6_walk_continue(w);
-		spin_unlock_bh(&table->tb6_lock);
 		if (res <= 0) {
 			fib6_walker_unlink(net, w);
 			cb->args[4] = 0;
 		}
 	}
+	spin_unlock_bh(&table->tb6_lock);
 
 	return res;
 }

base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
-- 
2.43.7

