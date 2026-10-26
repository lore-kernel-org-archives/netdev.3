Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995194;
	b=x3xJb/MycPI7UtWTPCdki+LGqY64qYG+he1ZtWabR1bk9QkZXgf/1r6PLSYDeBorZiyW
	 f4/aHXc6xFuXALaDXESJ38JQKolkxqE6n4JzlaNQb6tZpw9tpJbKK8AIv8J7uOf+QdHeR
	 qaXA+WEtRWu+VJhXbSAWVJlAQTh9I7auTL2CuplWWrGMTIuBqL9LUMfpkRQdrLTK8ubeG
	 81Og5/Xx9xdeVbX/wPRqUEei6DH+0xBJU8vtp1n4E8K/JADMiStSv8h9dRqUSTXDe0Zjo
	 D52+5jmoo5yBgi2x4mt08YlerKfgnYHvxI8C5p9uAwFVdhW51AjOw4T9BjZRayoiuSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995194;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=LYDxwtGCEaaeKY+BqFPhzjs+smK1jNiVay0L/T+8eWE=;
	b=i8+u1Kx8xGazIJfDnuRN3XFvfjw5GPcIMq+WWDT7Kj7LqRyeoINBf9cmywYfUE5qltPN
	 0t0A0k99/Vsvjz0wCz8J6X3j8/4tYU/2ZgRXqa5HhgJnQ6wNOaPYEpECpT2RicjBWL0in
	 YqbyF6IjyOCYOopnRf4RtW9PHxKx6iIa1NAqefOwZro174EvD1t3ERVnl3EjB+TDgCVz0
	 T/8tvqTCcmC/WI4QYfTam2xfcQtOqPzjazrfWIKTlthDWTDalu/GEZY2097NWfZmYmKDd
	 osiv8peeHFX4eDvr4t7kP8vCz8KXabwW7NwmRJKT2cD8kkj6/PqpORkqj0srmXmt5/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="NFW/1L9L";
	arc=none smtp.remote-ip=95.215.58.73
Received: from mta1.migadu.com (out-73.mta1.migadu.com [95.215.58.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796DD606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 06:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 796DD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NFW/1L9L
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nxLeUxoA2cNqllgMNF6jbihXV5eKKESlAmd5sput3C8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792995191; v=1; x=1793599991;
 b=NFW/1L9L8HOt2sI73VzCd9fXdbd+UNz2pKUHGfg6xFvuG/73qVpMjyzp/OZNi11ey1uHRDQW
 4vOlG4d8DQ2w6yLXoyhp21iDwXDRkbIqCvmT9awThwdNHgM9gnEshtIGZ1ZZuaq2+ABw6Ns/Eyj
 5ZN/8uC2m9G2bsGH7BtIALyU=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 062b43fba1f871ab;
	Mon, 26 Oct 2026 06:13:11 +0000
X-Mizu-Trace-ID: 062b43fba1f871ab
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Guillaume Nault <gnault@redhat.com>,
	Felix Fietkau <nbd@nbd.name>,
	Eric Woudstra <ericwouds@gmail.com>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v2] pppoe: wait for RCU readers before reusing a socket
Date: Mon, 26 Oct 2026 14:12:58 +0800
Message-ID: <20261026061300.256009-1-qingfang.deng@linux.dev>
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
clearing its fields. This allows existing receive-path and
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
v2: call synchronize_net right after delete_item

v1: https://lore.kernel.org/netdev/20261023043729.219660-1-qingfang.deng@linux.dev/
---
 drivers/net/ppp/pppoe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index ee0e318d6a2a..021b6c767294 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -618,6 +618,10 @@ static int pppoe_connect(struct socket *sock, struct sockaddr_unsized *uservaddr
 		pppox_unbind_sock(sk);
 		pn = pppoe_pernet(sock_net(sk));
 		delete_item(pn, po);
+
+		/* wait for concurrent readers before clearing the fields */
+		synchronize_net();
+
 		if (po->pppoe_dev) {
 			dev_put(po->pppoe_dev);
 			po->pppoe_dev = NULL;
-- 
2.43.0

