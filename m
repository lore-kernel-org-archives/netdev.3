Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373963;
	b=nnoLrJfah5PEMk/FlyXj00U94F8yxI3s496TfvkV5f/rizassGnmM74bdcllNA2t3Ef9
	 O2Kp8F4bYdnbxzo8wd7/ey8bZrShFdEcHI3NXngi6La+OKOD+HnMpKAWk0YX2wRysnzLT
	 9rkxBW69Fq3mFYi6gNcxTlHrGO21U6p9l3vzbL8T+kcvbr2L9JSay1y3xTpZy+BkuBjf0
	 FuoXC818VVn3+VoKFKqqSMZett/EOkKZ3sFXCQN2r3KwysOfD3jonqju+v/d5MaKLVwzj
	 LAUUPoc5JMStCE8VN5wvh1KJXL+MM770H6cuHFNEVe920nKAQ4n2Zl5VZKL0Ww8z9lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373963;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=+Co41UmDhvgfOSUvONitKvKJqzl8wj5ABYHigltlJj0=;
	b=FRx+82xrIzoYk2aCLFs+tsNWYP1/1iGfDr1iFIW3ZUB2QdtsL1MYv+P7kFKl+3C8IigT
	 vs9lr3wiAEwfkxr+HoTEF/Z5zWNiaJw5vWO8Yrk48PCsAvsomtCLvPvojZuoDkxIWAIqr
	 QMm440CfwKSo61ToHTTgFKUJsBJMWT45c1UH6uMT0VbzBsMItgUX6AvXe/jQVw52vyNA7
	 Z/aApXBA9cIunY1Ej6tW9FD84vZiOTnort8xWiafDHkGyEsolxsrbk2bAxgwuy+ghtd8p
	 pNQQC6129itW+wEFVHzWACuEGSElY9ARWz2sNsUE5MZ/fMTw5bCAlBEoJt8iPGYplug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=EBU7UUqB;
	arc=none smtp.remote-ip=195.10.208.51
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A87606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 15:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61A87606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=EBU7UUqB
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4jGQ0b20NCzKF;
	Fri, 30 Oct 2026 16:25:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1793373951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+Co41UmDhvgfOSUvONitKvKJqzl8wj5ABYHigltlJj0=;
	b=EBU7UUqBWFp3EjpNiwIVsdQmO28OOW5G+BY9IJTPKlNTryx9WPB4V1rxjHKf0INDQoPXIc
	3IBdbgG/sY9EYHxMOgNa1Y5gteYQac66JnRddmmrnlpkFzm3oHZt6NflYFcCNfRBMsMN3r
	uQvqTLLCXWv8bno4MxG8lciEPI3SgVEWEoXklYSFEsxuopTLR0AuiqBUWgdx/N0Ze99Mcz
	8rcnvIvRYMAsL09aBLhp0E7+9MurX/iKGxZZsFHl1a30QYU+X5TDL5yeuqvgIMHJk2gF5+
	UnFd7EPEMA6xGd8EuXxlrDoX/WwCMMrbDQepNu1LuNqeUMt+Sqmayjym/3wxbA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH net v2] tun: bound the NAPI receive queue
Date: Fri, 30 Oct 2026 16:25:36 +0100
Message-ID: <20261030152540.1409884-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.0
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
X-Rspamd-Queue-Id: 4jGQ0b20NCzKF

With IFF_NAPI, tun_get_user() queues every written packet for NAPI on
an unbounded list. When the poll runs asynchronously (threaded NAPI)
and is slower than the writer, the queue grows until the system runs
out of memory. An unprivileged user can do this from its own user and
network namespaces, and the queued skbs are not charged to its memcg:
in a test VM, a uid 1000 process limited to 128 MB caused a global OOM
in ~6 seconds.

Drop packets written while netdev_max_backlog of them are queued,
before allocating them, and count them as rx_dropped. The sendmsg()
path, whose callers pass zerocopy buffers, is left alone.

Still open: the limit counts packets rather than bytes and applies per
queue, and the queued skbs are still not charged to the writer's memcg.

Found, fixed and tested with the help of an AI coding assistant
(Claude Code).

Fixes: 943170998b20 ("tun: enable NAPI for TUN/TAP driver")
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---

v2:
- Cc'ong netdev and maintainers

Notes:
- Affected since 943170998b20 (v4.15). Reproduced on mainline
  7be4bc52fd9e; the code is unchanged in net/main 94cea342e891, which
  this patch is based on and was build-tested (W=1) against. The
  before/after runtime tests were done on 7be4bc52fd9e.
- Conditions: unprivileged user namespaces allowed, /dev/net/tun
  accessible (0666 with the usual udev rule), threaded NAPI.
- Mitigation: disallow unprivileged user namespaces or restrict
  access to /dev/net/tun.
- A reproducer is available on request.

 drivers/net/tun.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 770b8fe085c3..1ace0c1f22f2 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -60,6 +60,7 @@
 #include <linux/rcupdate.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <net/hotdata.h>
 #include <net/rtnetlink.h>
 #include <net/sock.h>
 #include <net/xdp.h>
@@ -1856,6 +1857,17 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			zerocopy = true;
 	}
 
+	/* In NAPI mode packets are queued here and processed by the NAPI
+	 * poll, possibly in a kthread or ksoftirqd. Bound that queue like
+	 * the per-CPU backlog, and drop before allocating and copying.
+	 */
+	if (tfile->napi_enabled && !frags && !msg_control &&
+	    unlikely(skb_queue_len_lockless(&tfile->sk.sk_write_queue) >=
+		     READ_ONCE(net_hotdata.max_backlog))) {
+		dev_core_stats_rx_dropped_inc(tun->dev);
+		return total_len;
+	}
+
 	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {
 		/* For the packet that is not easy to be processed
 		 * (e.g gso or jumbo packet), we will do it at after
-- 
2.56.0

