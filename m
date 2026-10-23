Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792730262;
	b=xft8LvxoBmAlpF0hqFe5UjdH6y10F5Znno1zGmYyHzTau+3wDQnVzWxPHqSE8cgnMX79
	 KjdM5ILOiHYvbNcRYBhTL+1VB3hhFwOcLadADbp+uHPNDebesRN2TJ9+FI98T1b+pnmb2
	 HEyahUdbpsGDyZUd7+VEWxc2bjn6OwT0kUKMqWcsjnYIKp4gn5dHxgmfZkwbrs2LzO1zG
	 gs+l9SD4gUG01rTth3r533+vcemow5X8X8oUr5ei1RpJ1SITO0GN1gHf+ZBVQswRkGM/b
	 +rmXmPaX3cBSmrmpljdhbtaJkFQ2dupdCK3r+rpsWtK4x+2aByKGGqsbPKkfPq/IqeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792730262;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=f123tdsbUST4XIUSI+zBPuw01Yi2GUfKPUwb5NzT2Rs=;
	b=OYS+GoRWYk6GIKLEMRF83eEOCfvVTPuCHtY2CkCeFFIF7Yl+zrK5c5LILAxLK3vIHop7
	 vSX9qAMULHPgg/iPE1JMgmCpaGauquRBiovlVrRytmPalLiE1NLRpsGGG08TSW5vYqR87
	 xqZ4m8PpQK0cWPVgmkyCZPqLUYaEL/a/n6FrjSfYyAPgaRmmEKhmrip8IChlCu05I6SNs
	 d+QEErtCrUA6UEpu2XS/mz46wOecWrwAJkbYkpNnTq1Gt/xQ6fokbPZgQGKfinwqlzXIy
	 n7iAIuXslPY2w7N0cMepOBQJRqtSCt8Pqz0SlNcGa3Hg/FnU0tmjgBWVe/QlF1VUpFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=smylZh74;
	arc=none smtp.remote-ip=91.218.175.199
Received: from mta0.migadu.com (out-199.mta0.migadu.com [91.218.175.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CD606A336
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF2CD606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=smylZh74
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hI8lFW79eKCI4bBWDUvXpaoorI5+2uT+zu+nDueEt08=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792730258; v=1; x=1793335058;
 b=smylZh74r6ZvVqUl30ub0GCDSSt78EzeTIXYS4lkwHATPi0k3Tt1sPu4xdKCEgT5a+2KyYa1
 Iskxh7imnbdrOOu22xyULrjtuLMTPX+Mi/PdfoRb8ZTO+BioTN1k72gaXWFpwV8bmLJddfkzcex
 Izo6TrSqCKx5kcIrvRYykA44=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c621be0b7a2731b2;
	Fri, 23 Oct 2026 04:37:38 +0000
X-Mizu-Trace-ID: c621be0b7a2731b2
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Eric Woudstra <ericwouds@gmail.com>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net] pppoe: wait for RCU readers before reusing a socket
Date: Fri, 23 Oct 2026 12:37:27 +0800
Message-ID: <20261023043729.219660-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.43.0
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

When pppoe_connect() disconnects or reuses a socket, it removes the old
session from the hash table and resets the socket's fields. An RCU
reader that reached the entry before it was unlinked can still be using
its address, ifindex or next pointer.

If sockets A and B share a hash bucket with A preceding B, a concurrent
__get_item() looking for B can be traversing A when it is removed.
Clearing A->next then makes the lookup miss B and drop the packet.
Reinserting A can similarly redirect the reader into another hash chain.

Call synchronize_net() after unlinking the old session and before
resetting its fields. This allows existing receive-path and
/proc/net/pppoe readers to finish before the socket is cleared or reused.

This was found by Sashiko's static analysis, and reproduced on a VM
stress test with KCSAN.

 BUG: KCSAN: data-race in hash_item+0x1c/0x60

 race at unknown origin, with read to 0xffff888000a1c566 of 2 bytes by task 147 on cpu 2:
  hash_item+0x1c/0x60
  pppoe_seq_next+0x112/0x1b0
  seq_read_iter+0x595/0x700
  seq_read+0xb0/0xe0
  proc_reg_read+0xd0/0xf0
  vfs_read+0xbd/0x220
  ksys_read+0xa9/0x100
  __x64_sys_read+0x47/0x60
  x64_sys_call+0x98/0x1fd0
  do_syscall_64+0x5b/0x260
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

 value changed: 0x0002 -> 0x0000

Fixes: 72cdc67e7fa7 ("pppoe: remove rwlock usage")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020092118.47416-1-qingfang.deng@linux.dev
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/pppoe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index ee0e318d6a2a..99600fb40c4b 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -622,6 +622,7 @@ static int pppoe_connect(struct socket *sock, struct sockaddr_unsized *uservaddr
 			dev_put(po->pppoe_dev);
 			po->pppoe_dev = NULL;
 		}
+		synchronize_net();
 
 		po->pppoe_ifindex = 0;
 		memset(&po->pppoe_pa, 0, sizeof(po->pppoe_pa));
-- 
2.43.0

