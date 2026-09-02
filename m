Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FF547604E
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347944; cv=none; b=ptJJYQZrF/Qc3BZoWrgobxTLpKNTQRnlb92LUDooatdanO1MNwTJKX5iTxfdocnzCeoY6TSshU3xIiPN4/LGVHPKo3YtPCTRq3HZg2NZFhVY9YELRGRCjoCyI3IyQtjDqwFCKHnNdYyT0S4vGDtdwDSmXyzKGLy0XZXTDSO0z4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347944; c=relaxed/simple;
	bh=ZywNGJcHZuoi0EOzkQkDGlqkbMGZzOy3PHrwXF+zkFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNtnDf+N2eFCnOQNqLRv0beXpv0ZxaRyxRYC+fScnfkGkr6d8MP+J0bIkegU3LhCdUgCx1PH9q7xuZtr61/xSvmNINq6U1BldVH9mLZzzZPmWwE1blz/Zfut22tabGT76YXIHwRG+VCjjXHrF41LVz36aUIBzbrhKH89CPTikkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acoMWGSt; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acoMWGSt"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1c73645a1so747205a12.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 04:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788347942; x=1788952742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QD0h/egrFFsr8riwFbhILly9mQVYZek4nXPI/CU5sbE=;
        b=acoMWGStYwz2XJFuX1M1ZSpdGHJF+IqolWhleSr9kJY5TIFG/UIzAKrfBhHTn4CksF
         mvhZ/PdanxGyoIrnWU00UWwA/szCZOrWZNQNF6IKPG7FSMJU0iF0dkhXYXnKx7OUlzK+
         7oBUVO6kZJ1Xl8zt7co3evdEGzUMoHPGVb/tr/EgOTurViVDNhRzw7N1wYHGrNch2LeG
         M5LXEfFWhTVkBcmD5MMdrVoG7FUMeM+0L7Q91BPzgi2cFKtziBVkE0EqBig1zgJQ2HlI
         8VrUv0H/VR3JK1bXjej+t1aTkFGslO0HByLSzSqvUGPr4rflSVfGEo21+DHQVYVz652I
         6GdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788347942; x=1788952742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QD0h/egrFFsr8riwFbhILly9mQVYZek4nXPI/CU5sbE=;
        b=sgCaZ9If65sY8Bt4ML+Q2v0oPAV2Q7lw6R/VU9dDtBf8WErsi8v+hk1lrngnyqCSaW
         WycsOVgClkDPNlo58Pi5WaqDb/Ydzox+MTmgUV900id9n1K0qHYrNLzbQnlYIbhPPdOD
         MWVpT/Yw+xErsWgZPiPnMIEQbb9ZCbdM0HANIuANjwoiA3LSBpJz0zmzhW14+rTkC0Uc
         EHlABX5rk6bAAhRZUd4v/q9QCrgYWKZFdp6x7wR8hZ9OLSbi6KWzUZfP2G/DNWFtWZiI
         1a01scic/jXvjxKkFBwGVX3+TQXeF5EslpwFBQaG1x237lcThVkxfvSL87omNiG+e+KF
         gMOQ==
X-Gm-Message-State: AFuF++kvtXJ2XlnOd6eS9srMKax6t618r7jtPjc1E36tz4bn3CtSW5RC
	17Tf+zD5JJ+y38zAiBRnfTijlb5B+pJ5hmJoWpwo/nshJAgN54yRmAlgXAMe5w1bDoh0eA==
X-Gm-Gg: AYBFou09oeeEf2ccqS46WUtlwljrf51/Q1x4k6fhKcH5TxOJAOga4ik7jvNUpO/k7VZ
	QnN2vXU3ULojRtvKlschWcplrmOn8sun0KGX+eJh59Wz+3loXhQBhvY++gbPbGkSYo7mCT5/NoN
	dQNOlLxk0Z4CDLRHrrwGq2g2/JgQhelMTjvNuWVoS/y12hF2wOEEu5zEYIERCBbDWa0D1dhijeR
	q2OhU1HcJtPAbPHUU4IYxr6+edLX7fYD2WJEoz7o+aQ5ZMgIBGr1y+qpc+bgc/efbHIuD6WvqX2
	mK0/iYQMzQ52vNlVEoPxQdSKt3/97CL6EOSaF4z/vQFZArIFx6slpu3Bi6DngskmV3MJcJMTxz9
	Y26Zd25Dta66zHotGfoL+Eom7OXBciHyfpnwkMnfhkTh45FRCavTD97U0HtZbCU++Y+I3wji8nd
	eXhPIjEtDS+1wgM+xvFboCd2QQiVHRZCzptrKC+gZS6RuuSN0yh2KewvQdvhad7pYl3ScLnB5HS
	VHqRBB5zUrCwKT86Q2QNK/uq/U=
X-Received: by 2002:a17:90b:538f:b0:398:b17b:3bd2 with SMTP id 98e67ed59e1d1-39aedec19fdmr6518176a91.4.1788347941647;
        Wed, 02 Sep 2026 04:19:01 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d75b540sm11377554a91.10.2026.09.02.04.18.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 02 Sep 2026 04:19:00 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: netdev@vger.kernel.org
Cc: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>,
	tipc-discussion@lists.sourceforge.net,
	Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net v2] tipc: purge cong_links under the socket lock in tipc_release()
Date: Wed,  2 Sep 2026 19:18:37 +0800
Message-ID: <20260902111847.79955-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

tipc_release() frees the elements of tsk->cong_links after release_sock(),
i.e. with no lock held:

	tipc_sk_remove(tsk);
	sock_orphan(sk);
	release_sock(sk);
	tipc_dest_list_purge(&tsk->cong_links);	/* no lock */
	tsk->cong_link_cnt = 0;

Every other accessor of that list runs under the socket lock, including
the SOCK_WAKEUP handler in tipc_sk_proto_rcv(), which does
tipc_dest_del(&tsk->cong_links, ...) while holding only sk->sk_lock.slock
via tipc_sk_rcv()'s spin_trylock_bh().  Because the purge never acquires
that spinlock, it provides no mutual exclusion against the wakeup path.

A SOCK_WAKEUP delivered for this port can therefore run concurrently with
the purge: tipc_sk_rcv() looks the socket up and takes a reference before
tipc_sk_remove() unhashes it, is then delayed past release_sock() so
sock_owned_by_user() is false, its spin_trylock_bh() succeeds, and it
list_del()s and kfree()s a struct tipc_dest that the closing task is
walking at the same time.  Both paths free entries of the same list.

__tipc_shutdown() does not close this window: it waits on
!tsk->cong_link_cnt but ignores the return value of tipc_wait_for_cond(),
which returns early on timeout, on a pending signal, or on sk_err, so the
close can proceed with cong_links still populated.

  BUG: KASAN: slab-use-after-free in
   __list_del_entry_valid_or_report (lib/list_debug.c:49)
  Read of size 8 at addr ffff888028b4b6c8 by task poc_cong_race/9425
   __list_del_entry_valid_or_report (lib/list_debug.c:49)
   tipc_dest_list_purge (net/tipc/name_table.c:1225)
   tipc_release (net/tipc/socket.c:653)
   __sock_release (net/socket.c:735)
   sock_close (net/socket.c:1526)
   __x64_sys_close (fs/open.c:1560)
  Allocated by task 9425:
   tipc_dest_push (net/tipc/name_table.c:1183)
   __tipc_sendmsg (net/tipc/socket.c:1518)
  Freed by task 9418:
   kfree (mm/slub.c:6792)
   tipc_dest_del (net/tipc/name_table.c:1216)
   tipc_sk_filter_rcv (net/tipc/socket.c:2164)
   tipc_sk_rcv (net/tipc/socket.c:2450)
   tipc_rcv (net/tipc/node.c:2210)
   tipc_udp_recv (net/tipc/udp_media.c:389)
  kmalloc-32, freed 32-byte region [ffff888028b4b6c0, ffff888028b4b6e0)
  Oops: general protection fault, probably for non-canonical address
   0xe0347c4420000499
  Kernel panic - not syncing: Fatal exception

Move the purge above release_sock() so it runs under the socket lock, the
same discipline commit 844cf763fba6 ("tipc: make macro tipc_wait_for_cond()
smp safe") established for the wait condition.  A concurrent tipc_sk_rcv()
then either backlogs the wakeup because the socket is owned, or processes
it against an already empty list, and no new delivery can arrive because
tipc_sk_remove() has already unhashed the socket.  tsk->cong_link_cnt is
left where it is, so a wakeup taken from the backlog by release_sock()
still decrements the real count.

Fixes: 365ad353c256 ("tipc: reduce risk of user starvation during link congestion")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:hy4
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

v2:
 - Move only the purge.  v1 moved "tsk->cong_link_cnt = 0" above
   release_sock() as well, which makes a SOCK_WAKEUP taken from the backlog
   by release_sock() decrement an already-zeroed u16 down to 65535.  The
   value is dead by then, but the race does not need that hunk.

v1: https://lore.kernel.org/netdev/20260731101926.31514-1-juny24602@gmail.com/

 net/tipc/socket.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index d5d70eb230b5..cf7ee31638ab 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -647,10 +647,14 @@ static int tipc_release(struct socket *sock)
 	sk_stop_timer(sk, &sk->sk_timer);
 	tipc_sk_remove(tsk);
 
+	/* Purge under the socket lock: a SOCK_WAKEUP looked up before
+	 * tipc_sk_remove() can still reach tipc_dest_del() on this list.
+	 */
+	tipc_dest_list_purge(&tsk->cong_links);
+
 	sock_orphan(sk);
 	/* Reject any messages that accumulated in backlog queue */
 	release_sock(sk);
-	tipc_dest_list_purge(&tsk->cong_links);
 	tsk->cong_link_cnt = 0;
 	call_rcu(&tsk->rcu, tipc_sk_callback);
 	sock->sk = NULL;
-- 
2.55.0

