Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.108.3.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922921;
	b=4MDupkd21f/AkEl8OzA7/T6BJMW2tTriQ+shcB2sOqy7TWmgEPiapIDrZwXoCzKGoW2+
	 ZQuXL78pzgpkkzMYwhoRxc7Iz44uTW5yrFLuvPUYiQWZFbV6tJecFPgdU6d1M7lfCPRlu
	 JPPeom67aamY3iVbOvoUM8T+8Xghi2OcNvXGigTYB0msEkfnzEynR9ZUDynAiDMUzPr1o
	 Pn4TRefPBVjL2lVWTK0wiCWhE3A2ZT88ecSr4xrug0qWYrHgLa/QSepp0Gu7BBZr08ou7
	 8OVjL/hs5m7zVLtNwM0dyuoMT2h7Uic509HohSs66wTsBgfzahW1hfs7IYERdw1kvPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922921;
	h=DMARC-Filter:DKIM-Signature:X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:
	 X-SMAIL-MID:X-SMAIL-UIID:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gPOrIJbxTbaobtLDqdGnocXoOvc+5x9CMIXdjphtWqM=;
	b=htw0zRwcLVhdchVQ5p54q2NwWC7wbb9XoalfD4OtbAkZNW4FVB6j2ke1CmWhI2hFqBXt
	 q9QbbbhmKU2k7REuaW1sp3yOg9Cx0ABhqU5S+wVKhSRPEY8MYJBMN5YGTI9uq58a/pbs/
	 N03AL71HTjf5dc1+XKfU4uqHLP4nVntKqtDbUaPWL96wQJxMaOvHHlyYZWvppRz8UyxX1
	 f8hZW3HrHvf/9Oc0VI67T+I6BMkm9zvcj+kp7N1dfO7bqrzxt659KuvvBmabiqiC//+qz
	 DnbI0vbqwaoWyv/RR/VQfznv1sHHHAj+6RWdt2vMJL4pniWDk+JTHqbbGoDBPUC2+1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sina.com;
	spf=pass smtp.mailfrom=sina.com;
	dkim=pass header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=CQmbinRh;
	arc=none smtp.remote-ip=202.108.3.25
Received: from r3-25.sinamail.sina.com.cn (r3-25.sinamail.sina.com.cn [202.108.3.25])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AF5606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 23:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56AF5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=CQmbinRh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1793922918;
	bh=gPOrIJbxTbaobtLDqdGnocXoOvc+5x9CMIXdjphtWqM=;
	h=From:Subject:Date:Message-ID;
	b=CQmbinRhmwPDT3n8dyWmkVYZpGnep6/VfXWWjnLtz4uxXCYay3XLhdw1wMGoakHAt
	 xXsTc3jbUSNkztuJ0JgodxQNBv+nf/MLxtCL78ULsRB0YSeolr61FAKMS98UV60QTl
	 SAX5wtG9eZAxxxQ46WMjR41ak7XW+YiR3BBBsRZc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.244.129.184])
	by sina.com (10.54.253.31) with ESMTP
	id 6AED175F00005F79; Thu, 6 Nov 2026 07:55:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8656686815976
X-SMAIL-UIID: B07D5ECE90754F94903F205035CDC3A7-20261106-075514-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b29ed72382b0e218323a@syzkaller.appspotmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: spinlock already unlocked in corrupted
Date: Fri,  6 Nov 2026 07:55:09 +0800
Message-ID: <20261105235511.346-1-hdanton@sina.com>
In-Reply-To: <6aec63fd.5f5735a5.290c1c.0003.GAE@google.com>
References: 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Thu, 05 Nov 2026 03:09:49 -0800	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    03897066069f tipc: raise the minimum bearer MTU to fit tun..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=10c2fca1580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d30e1495ee3ac817
> dashboard link: https://syzkaller.appspot.com/bug?extid=b29ed72382b0e218323a
> compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f95969580000
> 
> 
> AI-generated root cause summary:
> In drivers/block/nbd.c, nbd_add_socket() retrieves a user-supplied socket fd via
> nbd_get_socket() and invokes nbd_reclassify_socket(sock) to assign NBD-specific
> lockdep classes to the socket. When CONFIG_DEBUG_LOCK_ALLOC is enabled,
> nbd_reclassify_socket() performs an unsynchronized check
> sock_allow_reclassification(sk) and calls sock_lock_init_class_and_name(sk,
> ...), which is an initialization macro that not only sets lockdep keys but also
> resets sk->sk_lock.owned to 0, reinitializes sk->sk_lock.wq, and calls
> spin_lock_init(&sk->sk_lock.slock). Because userspace retains the socket fd,
> concurrent socket operations (such as inet_shutdown() calling lock_sock() or
> release_sock()) can acquire sk->sk_lock.slock immediately after the check;
> spin_lock_init() then reinitializes the active lock to the unlocked state,
> causing debug_spin_unlock() to trigger a "BUG: spinlock already unlocked" kernel
> panic.
> 
Correct, Eric's patch is tested a HBC, with which deadlock is still reported [11,12,13,14]

[11] Subject: [syzbot] possible deadlock in wg_ratelimiter_uninit
https://lore.kernel.org/lkml/6aece79e.382bd2ce.33e041.0001.GAE@google.com/

[12] Subject: [syzbot] [net?] possible deadlock in sk_stream_wait_memory
https://lore.kernel.org/lkml/6aec646f.aca85a03.3b899.0000.GAE@google.com/

[13] Subject: [syzbot] [fs?] [mm?] possible deadlock in hugetlbfs_file_mmap
https://lore.kernel.org/lkml/6aec66fc.059f5055.2712e4.0001.GAE@google.com/

[14] Subject: [syzbot] [cgroups?] possible deadlock in cpuset_can_attach
https://lore.kernel.org/lkml/6aec699e.73adde43.12e2c1.0001.GAE@google.com/


> full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=b29ed72382b0e218323a
>
author	Eric Dumazet <edumazet@google.com>	2026-06-13 04:26:19 +0000
committer	Jens Axboe <axboe@kernel.dk>	2026-06-13 06:34:34 -0600
commit	d532cddb6c6049ced414d64d83c6ce7149a6421a (patch)
tree	8f6571fb1cf0c7087ab584a07828a1e3f993ee44 /drivers/block/nbd.c
parent	e8dcf2d142bd720c8334233ad6cfdf00f0e76b7f (diff)
download	linux-d532cddb6c6049ced414d64d83c6ce7149a6421a.tar.gz

nbd: Reclassify sockets to avoid lockdep circular dependency

syzbot reported a possible circular locking dependency in udp_sendmsg()
where fs_reclaim can be triggered while holding sk_lock, and fs_reclaim
can eventually depend on another sk_lock (e.g., if NBD is used for swap
or writeback and NBD uses TLS/TCP which acquires sk_lock).

Since the UDP socket and the NBD TCP/TLS socket are different, this is a
false positive. Fix this by reclassifying NBD sockets to a separate lock
class when they are added to the NBD device.

This is similar to what nvme-tcp and other network block devices do.
