Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306073;
	b=Dok+o+cnfrCZFJPyFvyi2A0jknmcxEAYxTeCbk0+VM9l42DEiP5VmnGrmZYF+uw1yWZ0
	 ZZh/vIwN4RXAFhQ6SUkaqr6g1CAsxts6J6dM2Qv2uHz7KqM8f2AQWEMCVRDHUZlqxZUp4
	 Rhm96TyaADZ/As7mIexJSo1BOhuZMa6Tx2yXPU2z5NXXxtANP2Q40ZX04dlKyifsdtvr/
	 Bk3EmrQaRWabSO6oSRQlm6iKtl/1ON/NBzF6XznRpsZywSUQkep98PkhYl3jBk8VGWwFU
	 WwSFrmEaYpWmY+uOM/l2cjWOWiMcgxVoK33DvF6V/gI02M/pz313vqXDhSGaTNwLeOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/HNWmbLbU9YGzVySC0e6zjCVGZ8obHwQYm+NFMxIopA=;
	b=IX28FOAKUD9YJM6UGneHodBRpuNAEnR7tOsWIJUREox5ulagX6towCS9OTGBiJtDmb10
	 JU6vq2Wbal+TLNh67KcZbT7BxT0XcvbcItQ0GCxpWmz6PHqN+AezCYjaZ9QUXStTl26go
	 wZPbqRhlhfn53wouZ0CQ7J3ZtKyxBjOKVMxGUb2IvMz0kduR7gpYvlG204hPHNzOrWGhV
	 eaGCGWUtyWD2/V/c74E2Czfm1Ex4cbkfGht54DW/kg5d3unP6kSsbBzjEGtpDvXC9NsqY
	 +sLlrlhTRcew6kGo/+CivUyTOBSZ0KEUt32rKCIsJqIvFQW/WziwoXZXrg9LHyXiEYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=gdo2XNjz;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E355A606A32A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 20:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E355A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=gdo2XNjz
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so1152665a91.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793306071; x=1793910871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/HNWmbLbU9YGzVySC0e6zjCVGZ8obHwQYm+NFMxIopA=;
        b=gdo2XNjzL4/5BzwDFUUC/Ra4XhpQKBj5FSdrj4mH9lqT3IHVTPbZu4r8062FsLPFj3
         jwqoN6N4pIDBBtOf0OKkqvaTA7JqFKW0gkoJlYij+YCU3pZ+9PDtF+xEctwvL205jLPW
         FiTBgc5OSTwQc98C/LLLk5GL/8snG3VEMPzwSxJBFqpeqqBqhzeyDZsXOvk+XL7OESv1
         mNuZ+N0vZ4xvDcyGf0EqbyuafLLpXdX8wlxFysggm3wVorYfuN/0Lrpe12/K/oXa0ubE
         CuyPCEuwyV6gJ1JIyxxdx3bkA2f535KAJiS5jFQc+n4iQ1V9HGS6QNOoTHiWoY+ITfjh
         +Sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793306071; x=1793910871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/HNWmbLbU9YGzVySC0e6zjCVGZ8obHwQYm+NFMxIopA=;
        b=Aeb8EjT1u6GV1W9FMhEngPZ63Ss8rWB/g4B5rFkbFnVePgt6hiAmhSQJ2UuDBbUIfD
         ywXP+X+eNCtxaeBAFG6Hyuma/W0E3UAVYJz/bjyQtrdP1sCgDdQDqiFn4OP6+3XLZiQr
         B585ZaDMX/74fRTsAO2Hv40MnYx/fukw9/T5Md9yJTkKRY9iVP0Bf8ZntTLWLt6YYyLC
         MwyWyqFraoaqkAJh+1INczZb7duSNGQsZfkK4p2ogJrS81a7yRJZJIKGu3H88hc3kJZx
         H5NEmWe2NXK9I0IQ0tf5Lr3SUDG9K6kww9MHB75JEBTarO5zCATjr2y4rhpslQmsKTtM
         c/vA==
X-Gm-Message-State: AFq9FYJZE2nDXhvRGHDZrgD/h0ReOJUmnz259WmFC66CqpyCF+O/dhGY
	PI1SJFrpdkvZsF5IRNOAiDBOyx8qy3pwpRySuS9LY4gJohY58yrmOydujXk19P0PhF++mCz4Ypy
	PAwFc95jKrQifm6EkNp+y9WJWgV1gP7W4ZVs+9wSwC+UmMGxNb2vo
X-Gm-Gg: AYBFou0DJ16y9eH9fM9j9GzoIapGvTqVybzVG6CJZ+mGnZacIbHuZ2dPvhzz11I+Ujh
	FdvkFBx0I44XFhlJ08RjDz5R8QfdYm+C/o5C6F9+r4j0tCEhns5YCthOLC0IWcmeQfcWshYV0b6
	BIKez/pY+v22iyaT8pqZb8ZZf47AOE68VAs56vG2UjJdbL27i5/AaKDTmhq6lkEMbmRYLR5Ogxd
	81nhq38CEeNC29N8JEvBNcSilF3Tf5v6dh0oq9/EwrkjL5xlwATMS98u8munT6x+LlMWH+lQgM0
	1FY8tDRDbFNaTxgGI0TOgozvDapS7DG2GetqS6PTBDMf/DDrn4BGbAp76/zxIUiOEDYtGeNkHGs
	2WuDM7lq3LBu+vgnO12JB
X-Received: by 2002:a17:90b:2d84:b0:3ac:b867:81df with SMTP id 98e67ed59e1d1-3ae8983517dmr81373a91.39.1793306071165;
        Thu, 29 Oct 2026 13:34:31 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae85eb5999sm112711a91.1.2026.10.29.13.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 13:34:31 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 20F5840202;
	Thu, 29 Oct 2026 14:34:30 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 1BAACDCE139; Thu, 29 Oct 2026 14:34:30 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>,
	stable@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4] kcm: reject attaching sockets with a ULP, and TLS on KCM sockets
Date: Thu, 29 Oct 2026 14:34:27 -0600
Message-ID: <20261029203428.3057054-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
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

KCM and kTLS RX do not work together, in either order.

KCM's psock_data_ready() is the lower socket's data_ready callback. It
can run in softirq context under read_lock_bh(&sk->sk_callback_lock),
and calls strp_data_ready(), which invokes sock->ops->read_sock()
inline. With kTLS RX, that is tls_sw_read_sock(), which can sleep: it
allocates with sk->sk_allocation, waits for async crypto, flushes the
socket backlog, and may wait in tls_rx_reader_acquire().

Found by code review. On an unmodified kernel with
CONFIG_DEBUG_ATOMIC_SLEEP, sending TLS records over loopback to a socket
with software kTLS RX attached to a KCM mux reports:

  BUG: sleeping function called from invalid context at include/linux/sched/mm.h:321
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 189, name: ksoftirqd/34
  Call Trace:
   __might_resched
   kmem_cache_alloc_node_noprof
   __alloc_skb
   alloc_skb_with_frags
   tls_rx_one_record
   tls_sw_read_sock
   strp_read_sock
   strp_data_ready
   psock_data_ready [kcm]

Before commit 662fbcec32f4 ("net/tls: implement ->read_sock()"), TLS
inherited tcp_read_sock(), so KCM parsed the ciphertext in the TCP
receive queue as messages. HW TLS RX uses the same proto_ops as SW
RX, so it is affected the same way.

The two also stack socket callbacks and neither restores the other's:
with TLS RX configured after the attach, kcm_unattach() overwrites
tls_data_ready(), and releasing TLS RX later reinstalls
psock_data_ready() on a socket no longer attached to KCM. On TX,
kcm_unattach() restores its saved sk_write_space, dropping
tls_write_space().

There is no known user of this combination, so reject it, as was done
for sockmap in commit 460e6486617c ("tls: reject the combination of TLS
and sockmap"). KCM takes over read_sock() and the socket callbacks like
a ULP does, so treat it as one:

 - kcm_attach() refuses sockets that already have any ULP, not only
   TLS, as sk_psock_init() does for sockmap, with -EOPNOTSUPP like its
   other refusals;
 - kcm_attach() then sets icsk_ulp_ops to a dummy, unregistered ULP, so
   tcp_set_ulp() refuses TLS on an attached socket with -EEXIST and
   nothing is needed on the TLS side. kcm_unattach() clears it.

The dummy is not registered, so TCP_ULP cannot select it by name. Both
sides run under the lower socket's lock (tcp_set_ulp() asserts this), so
the check is made at ULP install rather than at key configuration.

Holding a ULP also has visible side effects: getsockopt(TCP_ULP) and
inet_diag report "kcm" on an attached socket, sk_has_decrypt_user() is
true so PSP RX association is refused after the attach, and adding an
attached socket to a sockmap fails with -EINVAL rather than -EBUSY.

This is a user-visible change that will also reach stable kernels:
attaching a socket with a ULP now fails with -EOPNOTSUPP, and installing
a ULP on an attached socket fails with -EEXIST (espintcp previously
failed with -EBUSY). Every refused TLS setup was already broken as
described above, except one where only kTLS TX is configured. Such a
socket still passes data, because read_sock() stays tcp_read_sock()
until kTLS RX is configured, and KCM transmits with sock_sendmsg(), so
records reach TLS's sendmsg(). It is still wrong: if TLS was armed
before the attach, psock_write_space() shadows tls_write_space() and
does not chain to it, so a record deferred on a full send buffer waits
for the next send; if TLS was armed after the attach, the chain works
until kcm_unattach() drops tls_write_space(), as above. The direction is
not known at ULP install, so refusing it keeps one rule for both orders
and matches sk_psock_init().

Tested with CONFIG_DEBUG_ATOMIC_SLEEP: both orders are now rejected,
plain KCM still delivers messages, and the TLS ULP can be installed
after SIOCKCMUNATTACH.

Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
Cc: stable@vger.kernel.org
Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://lore.kernel.org/netdev/3108e934-ec00-458b-8720-450554b35b55@linux.dev/
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/kcm/kcmsock.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index a7f94d42036f..e0d6536306f4 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -30,11 +30,19 @@
 #include <net/kcm.h>
 #include <net/netns/generic.h>
 #include <net/sock.h>
+#include <net/tcp.h>
 #include <uapi/linux/kcm.h>
 #include <trace/events/sock.h>
 
 unsigned int kcm_net_id;
 
+/* Not registered, so TCP_ULP can't select it. It only holds
+ * icsk_ulp_ops so tcp_set_ulp() refuses other ULPs like kTLS.
+ */
+static const struct tcp_ulp_ops kcm_ulp_ops = {
+	.name = "kcm",
+};
+
 static struct kmem_cache *kcm_psockp __read_mostly;
 static struct kmem_cache *kcm_muxp __read_mostly;
 static struct workqueue_struct *kcm_wq;
@@ -1272,6 +1280,14 @@ static int kcm_attach(struct socket *sock, struct socket *csock,
 		goto out;
 	}
 
+	/* KCM takes over read_sock() and the socket callbacks like a ULP
+	 * does, the two can't stack.
+	 */
+	if (inet_csk_has_ulp(csk)) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
 	psock = kmem_cache_zalloc(kcm_psockp, GFP_KERNEL);
 	if (!psock) {
 		err = -ENOMEM;
@@ -1305,6 +1321,7 @@ static int kcm_attach(struct socket *sock, struct socket *csock,
 	psock->save_write_space = csk->sk_write_space;
 	psock->save_state_change = csk->sk_state_change;
 	csk->sk_user_data = psock;
+	inet_csk(csk)->icsk_ulp_ops = &kcm_ulp_ops;
 	WRITE_ONCE(csk->sk_data_ready, psock_data_ready);
 	WRITE_ONCE(csk->sk_write_space, psock_write_space);
 	csk->sk_state_change = psock_state_change;
@@ -1382,6 +1399,7 @@ static void kcm_unattach(struct kcm_psock *psock)
 	 */
 	write_lock_bh(&csk->sk_callback_lock);
 	csk->sk_user_data = NULL;
+	inet_csk(csk)->icsk_ulp_ops = NULL;
 	WRITE_ONCE(csk->sk_data_ready, psock->save_data_ready);
 	WRITE_ONCE(csk->sk_write_space, psock->save_write_space);
 	csk->sk_state_change = psock->save_state_change;
-- 
2.50.1

