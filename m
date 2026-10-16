Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DE93E3D8F
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181539; cv=none; b=R02LF6oHcXOJ1k02m4BAaHKFzU7Tz1+oY7GFDnMTq1XLmjiNzmywmPansSNR8jI3Wy7iAGWuyqKa1QSG9V837Gz/LwYwwyS9/4O6+FFyq2fNh5J6MYCxsVayoS0svMaFNzoLpKXuDyoTBMxYKp7KwZGOdgWc6lOXuc1EGj3Dapk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181539; c=relaxed/simple;
	bh=G9vzDtONtXjwSvyBkiUxo/rVI5oYHoJJZUqH8P+1vpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCaDXJ+6i5reJu8Y4mwI9UpBgILZKWsybRFJEQAj5IL2RkKBeJA/+W9jmFRXwyO/0cRQOJ13v0tuSTQPfVUVEAnu5D2xeJxJ9YHysRbh3vY4I5ZsnV/sgbZR8ZQ11UzNeGZ1F0N34r92pQvI7OKGTq3u8w5PjMx6kaGZCN6kUZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgUrpsJz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgUrpsJz"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48870973bddso201928f8f.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792181526; x=1792786326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zjXifzsuYpS0FQruVBIsTQMHaxQeJksSexJHZzpqVro=;
        b=NgUrpsJz/8taruCUfoCYAMQ+wjsLvg/rafWJ/EZsybJ1PrJho39nuae4HasPW1Imfo
         DFh5wwAN5w9SOY6I6MUkMkwktGVpwNmh0ZLbpFEGTpXBLk3pZd/9cydm9bHZY9HD6hLk
         6RofufK6co5PQ2TQmheVf3auue8vdFtssrshr9mzTWB/rmkl4KbmJZQGQ07fJxIDnsLA
         xiJbvChkpxPC41PT/ZE5WXSGvoumIOtN9tQ6sGCCS33BBSMMc9grkmdyqOrcS5R+dd8Y
         rkisTqZz1NFYCSn7lTNgc8ohQCEPBLyzHieiejo8cdXEL3IssP7A2bUBEQxemSnj4pNr
         8sAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792181526; x=1792786326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zjXifzsuYpS0FQruVBIsTQMHaxQeJksSexJHZzpqVro=;
        b=1b2THMMYZ3HciPvxI5EzYx1e73sKIHpMee0jpmXuvpSmzGnRZMKcEK3F87ZqD9PfvP
         B8rqm4CftsaCVhfR+vI5U9AxZsI+3E6baKLF1CmOM5yRfVZUwG4w8wNipxsAeS1NBP6R
         GMu1JagKKwIU7hULIHNhNkkenL73VESngS+mqLJjDiyc9bDkITWNhq4Y84Hcl8U+24PG
         eOb9TATbnGnYzdB2H64xQs/Y+edizCfSzcTeg99FqVMH7XQ0SjD6mCcZwJH39Xs//Ys9
         0+LgLAaXh4keeWHExmDFvuF5JiPtP8wDDP6hRmWL5NZVgmZJqcc3wPYICdVfeVB/H65y
         yUzw==
X-Forwarded-Encrypted: i=1; AKwUvBwua+LLoDBhW1kCKNUS4Jn86sFJX7qExLmC3X/ov7iO3ls/9TDqXLcZYAi2CTBrAd2/ZVLQCcI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxh0+Jhr8XmJ1XBmt7M13saXLvEtPdvmfoxhpQzcJYvW2nI8lw
	jEGAkQgt8ci7qgLJG55vl9lz2x6VsDb/dbB0BKnHf8Cgnh6r9tOzTyVU
X-Gm-Gg: AYBFou3ovsT48dxhWZujUmZcKoC/b/NSuMFuq3cZnKot4/lz8DNpU0bguuTNAdfrmu9
	6948iRuNMoXk2wmvEPleq/fu5ZePiPwVMQYhcw5WY7fDGNH34YnYS2b5UgitJLplZsXrg9cD8zU
	Qnac86uRu3LmIzJoZonMc4JoXOXx9pLh3+DEsMuM911LZnwORLh8OChjYKyqqv4rsUdyZ6oMSXS
	3yZrYaCV5NOj//fpJV6rYjFxXSZ8ytv2Rnp1f09sXPjYnqpSWDyGGC+jLW6vMN2M/Ciu0YiVRVJ
	+ee+ZH2HJvMmtH6mCRcu/qJeBd6U8isdcKeKXra1uVNDyPmP5oFl4G4MWMWYytXDFDjYmxo87Q7
	w9RvsXWFy4OzH8B0Qh5l8mRXx0Yme50pBRxocyHfheP3XIYfc3arywL6+nyFZDla2vNWqPolWl6
	ZYzMLlO5NF4UH6xhL9NJqEMzPLgnR2HtEj3zmXN67a1wxiVzKpEmhRDZEjDg2UWy4i1991egZKy
	l7IMr+q4x30RYlx5tHQc2jpU0AAOSRpcZyldBTQIVZR96Lh
X-Received: by 2002:a5d:584f:0:b0:48d:fbe0:62e1 with SMTP id ffacd0b85a97d-48dfbe06466mr8802951f8f.27.1792181525887;
        Fri, 16 Oct 2026 13:12:05 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([105.98.84.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfdc4eecasm6905340f8f.13.2026.10.16.13.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 13:12:05 -0700 (PDT)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>,
	syzbot+ae55a0fac80c73c938ac@syzkaller.appspotmail.com
Subject: [PATCH] net: sunrpc: fix null-ptr-deref Read in xprt_reserve
Date: Fri, 16 Oct 2026 21:12:00 +0100
Message-ID: <20261016201201.4185-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported:

BUG: KASAN: null-ptr-deref in instrument_atomic_read
     include/linux/instrumented.h:82 [inline]
BUG: KASAN: null-ptr-deref in _test_bit
     include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in xprt_throttle_congested
     net/sunrpc/xprt.c:1708 [inline]
BUG: KASAN: null-ptr-deref in xprt_reserve+0xe2/0x2c0 net/sunrpc/xprt.c:1948
Read of size 8 at addr 0000000000000628 by task syz.8.3118/20390

Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 instrument_atomic_read include/linux/instrumented.h:82 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 xprt_throttle_congested net/sunrpc/xprt.c:1708 [inline]
 xprt_reserve+0xe2/0x2c0 net/sunrpc/xprt.c:1948
 __rpc_execute+0x526/0x1280 net/sunrpc/sched.c:947
 rpc_execute+0x1c1/0x390 net/sunrpc/sched.c:1023
 rpc_run_task+0x4a6/0x660 net/sunrpc/clnt.c:1269
 rpc_ping_noreply net/sunrpc/clnt.c:2944 [inline]
 rpc_create_xprt+0x452/0xa90 net/sunrpc/clnt.c:494
 rpc_create+0x649/0x900 net/sunrpc/clnt.c:619
 gssp_rpc_create net/sunrpc/auth_gss/gss_rpc_upcall.c:107 [inline]
 set_gssp_clnt+0x188/0x2d0 net/sunrpc/auth_gss/gss_rpc_upcall.c:131
 write_gssp+0x21e/0x310 net/sunrpc/auth_gss/svcauth_gss.c:1423
 pde_write fs/proc/inode.c:330 [inline]
 proc_reg_write+0x1e9/0x2e0 fs/proc/inode.c:342
 vfs_write+0x296/0xba0 fs/read_write.c:685
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The GSS proxy client setup races with sysfs. xprt_switch_alloc() publishes
the transport in sysfs before rpc_new_client() sets xprt->main = true. The
sysfs offline handler rejects writes when main is already true, so
userspace can set XPRT_OFFLINE in that window.

The initial RPC then runs with the only transport offline.
xprt_is_active() only rejects a transport whose refcount is zero
or whose XPRT_OFFLINE bit is set, and a transport that is still on the switch's
list always holds a reference.

xprt_switch_find_first_entry() returns NULL, rpc_task_get_next_xprt()
returns NULL with it, and since rpc_task_set_transport() returns void,
the task continues with tk_xprt == NULL until xprt_reserve() dereferences it.

Mark the first transport as main in xprt_switch_alloc() before creating the
sysfs entries, and drop the assignment from rpc_new_client().

Fixes: e091853ebdb4 ("SUNRPC mark the first transport")
Reported-by: syzbot+ae55a0fac80c73c938ac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ae55a0fac80c73c938ac
Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
---
 net/sunrpc/clnt.c          | 1 -
 net/sunrpc/xprtmultipath.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 6cedc824cf82..aa9f9c185c02 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -419,7 +419,6 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 	}
 
 	rpc_clnt_set_transport(clnt, xprt, timeout);
-	xprt->main = true;
 	xprt_iter_init(&clnt->cl_xpi, xps);
 	xprt_switch_put(xps);
 
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 3ba818d637be..5e2d43d6c643 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -159,6 +159,7 @@ struct rpc_xprt_switch *xprt_switch_alloc(struct rpc_xprt *xprt,
 		atomic_long_set(&xps->xps_queuelen, 0);
 		xps->xps_net = NULL;
 		INIT_LIST_HEAD(&xps->xps_xprt_list);
+		xprt->main = true;
 		xps->xps_iter_ops = &rpc_xprt_iter_singular;
 		rpc_sysfs_xprt_switch_setup(xps, xprt, gfp_flags);
 		xprt_switch_add_xprt_locked(xps, xprt);
-- 
2.43.0

