Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656994;
	b=HabjpvVrjylKfEfDW7TYTRFzhldOSgFJINvPM+oqCsINOF69esvQKbJ1nkq6tBXxOjox
	 y2d/hsHzU8YByuFCeErdbg54VE50wE5PorBT/Ea+I2Ju4irUc2NPQETHwOZhArS4ctMOX
	 ZN2kCDdIuInJkz1sVmG6jbqO32tCIYOPpAjbyxGuynTFs5bL3PUd0j+TkDfL+CUN9DSPX
	 9nMvuCB5MtjUOj7NBoe8zWHCua6Qd9y4ezCYUTiHcUQcj7u3JCmOxH3c4KrsL0KFLjY9a
	 Wwt+Fcn3oGq0fSWdWCJOHkxlUsChdHhS9/gmwzpMFboZN3nx/Peq6cs9aqZKxlIBmwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=B7tvhjLJU3okbL5MoiWuRA1SUKq0KoXzHsZeqZS+QNs=;
	b=Df/FTsJlyvvzGLpfpEDZUvEMOVrPJUf3vElQqqjNh+yNKz0td9khiwDFPXZ2xDuUOw7A
	 SfuV2ETQxGQciWzQpfSPt6gccn1sF3LV7kv1FXlWJwL1JGTday1h7ZTDa9HPOblDk1Yr2
	 L1WtUQre5y2E/ewsZgeIwYYAwGmcbwo5o0qRUCu/L0twBt6Qovi9DufMCvXxefrTjKXF0
	 GuXrhiSeliXSlISQwpSG6yl3mQp/iwAU5cRYxFGPSm9o45f2DSVvMqhehAHb+913/pU2X
	 bn1S0e+uhGN36x3YyBbLlsUJpgdFpJZ08HHNzfxF1zbp5MMxGrxCeIht1BUyaupAVVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=QJ6UzNvS;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6529606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 22:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6529606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=QJ6UzNvS
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so1705216a12.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 14:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793656993; x=1794261793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B7tvhjLJU3okbL5MoiWuRA1SUKq0KoXzHsZeqZS+QNs=;
        b=QJ6UzNvS+3Hi0tt2BcNl8f61nIvJQQIENhvp8pGCTHHQ4xP5g+lRhP172YcotzMK8B
         Z186J+U1t0kYXxJ/KegTyV6yD4BAw46qCaESDptRQ5M7EbwrUJ36RooRcITvdRq46uqL
         0sklnqAfT7PKwn+bZfAJW8OjdTkGxw3P5DAxVSl0cnd/Rh+bzO6DupO09ts6YW7nrAoK
         AmexJrGwbwqtqoBezeC4VOvwLnZM5d3pU0f0I4Z4HNRxItsZXyYTWYbno/0VxyISJLAv
         yqCD03WcKsc+ebQcBQeG4/Cv2V/WN8p4pIISbOQbZxt5h8t3iZY7bLNofawDT6feG/q/
         GEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793656993; x=1794261793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B7tvhjLJU3okbL5MoiWuRA1SUKq0KoXzHsZeqZS+QNs=;
        b=g1bcZ20LYRY2Xegs2Suj3mYd+xK9Bsy6sDSiP70xORubIBb/cSWwllaJy6vrhfMU4Q
         q5H7Qz3bCrXF77qGOE+H7pPiW+pBHWBGaP/5Ebk6sUWElvLQH+N65HjT9Dbg4rioifjT
         lHVQrKMN8CyINJbUNoFM2D5fDiljVkJWuPBELtmO89o6X21Re3ir4SYO+nvOEBPL3Kbl
         03DPvqTwtWZKmCs9nonl93gHzXgxB2pl7s2KcKeeVwgT0uN8Ophd3x8m3wNEr1esxVC+
         DmrhevQKuMfpnB3LOgFwXIG60fl+0Uvl1myJGKnBRPyk1oE32yU0/b3iJVZ1uoajb7f+
         xpXA==
X-Gm-Message-State: APuU4Z8MWdnYp/14kcHfLp/KAmQiVMquoAuFu9MAjw08+i6XUJ61bZ51
	nBujC5FGxp/uj+N+UqB0Fxl+yqNm4FLlbhpVhmGbVRQ6DO+a3b7s5CSbnQn9r3vt0O3yH7qH8st
	Oaf+xxh+B7CXL1goWZsoG8/mL5TvUik0QCbVwgXhZojpfIYl27rjp
X-Gm-Gg: AYBFou2JwO57qwJCZI9CxJk82FIWgnWJe1v5pZ3q6Ms/7xCsUWjE405AquhGKRiJk44
	PZgi4W6h4RU3jFi/+PLLDw7NwBM7QeliUdpW8ZicTAuKRkhIZQyeCuMteh3yAaDGEi07T7ePnzy
	1XRMI6oglqZkxcLkhOjmiXtHWGUutgRbO3kgCf1SEvf5mGOL031+AzD9OPhpKylNBtWlvSOaXEN
	yRTXlCbgQE7EqQj4R3Juwx4nQF49TqJ2RWHb8IQKixPUhPvjN9YV+oidcSFDlMskpjsDXw0Y+S+
	5iZhszPN0eet1rvc+3rjKxUU52BQFTUX1T1I7Up9wPabi+b2mgwQ8+KxGYL150MrsGqBJ5N35gv
	dKwToUFELK30v0D4d13BD
X-Received: by 2002:a17:90b:44:b0:3ac:a11a:7c7f with SMTP id 98e67ed59e1d1-3ae897ab482mr8485137a91.23.1793656993214;
        Mon, 02 Nov 2026 14:03:13 -0800 (PST)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae881d509fsm4085327a91.5.2026.11.02.14.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:03:13 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 0F616436BC;
	Mon,  2 Nov 2026 15:03:12 -0700 (MST)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 0A2E4DC0CB7; Mon,  2 Nov 2026 15:03:12 -0700 (MST)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>,
	stable@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5] kcm: reject attaching sockets with a ULP, and TLS on KCM sockets
Date: Mon,  2 Nov 2026 15:03:09 -0700
Message-ID: <20261102220310.12649-1-rjethwani@purestorage.com>
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
   nothing is needed on the TLS side.

The dummy is not registered, so TCP_ULP cannot select it by name. Both
sides run under the lower socket's lock (tcp_set_ulp() asserts this), so
the check is made at ULP install rather than at key configuration.

The dummy behaves like any other ULP: it pins the kcm module, it is not
cleared by kcm_unattach(), and tcp_cleanup_ulp() releases it when the
socket is destroyed. do_tcp_getsockopt(TCP_ULP) and tcp_diag read
icsk_ulp_ops without the socket lock and rely on it only going from
NULL to a live ops once. A socket that was attached once can be attached
to KCM again, but it cannot take another ULP for the rest of its life.

The existing family/protocol check also accepted
socket(AF_INET{,6}, SOCK_RAW, IPPROTO_TCP), which is not an icsk and
would have the ULP pointer stored past its raw_sock. Use sk_is_tcp().

Holding a ULP also has visible side effects: getsockopt(TCP_ULP) and
inet_diag report "kcm" on a socket that was ever attached,
sk_has_decrypt_user() is true so PSP RX association is refused after the
attach, and adding an attached socket to a sockmap fails with -EINVAL
rather than -EBUSY. listen() after a disconnect fails with -EINVAL, as
the dummy has no .clone, and rmmod kcm waits until such sockets are
destroyed.

This is a user-visible change that will also reach stable kernels:
attaching a socket with a ULP, or a raw socket, now fails with
-EOPNOTSUPP, and installing a ULP on a socket that was ever attached
fails with -EEXIST (espintcp previously failed with -EBUSY on an
attached socket, and installing TLS after SIOCKCMUNATTACH used to work).
Every refused TLS setup was already broken as described above, except
one where only kTLS TX is configured. Such a socket still passes data,
because read_sock() stays tcp_read_sock() until kTLS RX is configured,
and KCM transmits with sock_sendmsg(), so records reach TLS's sendmsg().
It is still wrong: if TLS was armed before the attach,
psock_write_space() shadows tls_write_space() and does not chain to it,
so a record deferred on a full send buffer waits for the next send; if
TLS was armed after the attach, the chain works until kcm_unattach()
drops tls_write_space(), as above. The direction is not known at ULP
install, so refusing it keeps one rule for both orders and matches
sk_psock_init().

Tested with CONFIG_DEBUG_ATOMIC_SLEEP: both orders are now rejected,
plain KCM still delivers messages, a socket can be attached again after
SIOCKCMUNATTACH but not given TLS, a raw IPPROTO_TCP socket is refused,
and the module reference is dropped when the socket is destroyed.

Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
Cc: stable@vger.kernel.org
Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://lore.kernel.org/netdev/3108e934-ec00-458b-8720-450554b35b55@linux.dev/
Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/kcm/kcmsock.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index a7f94d42036f..1f8bcbb8b9c3 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -30,11 +30,26 @@
 #include <net/kcm.h>
 #include <net/netns/generic.h>
 #include <net/sock.h>
+#include <net/tcp.h>
 #include <uapi/linux/kcm.h>
 #include <trace/events/sock.h>
 
 unsigned int kcm_net_id;
 
+/* Not registered, so TCP_ULP can't select it. It only holds
+ * icsk_ulp_ops so tcp_set_ulp() refuses other ULPs like kTLS. Like any
+ * ULP it stays until the socket is destroyed, pinning this module, and
+ * tcp_cleanup_ulp() releases it. Clearing it on a live socket would race
+ * with lockless readers such as do_tcp_getsockopt() and tcp_diag.
+ *
+ * No .clone: children copy icsk_ulp_ops without a module reference, so
+ * a socket that was once attached must not listen().
+ */
+static const struct tcp_ulp_ops kcm_ulp_ops = {
+	.name = "kcm",
+	.owner = THIS_MODULE,
+};
+
 static struct kmem_cache *kcm_psockp __read_mostly;
 static struct kmem_cache *kcm_muxp __read_mostly;
 static struct workqueue_struct *kcm_wq;
@@ -1242,6 +1257,7 @@ static int kcm_attach(struct socket *sock, struct socket *csock,
 {
 	struct kcm_sock *kcm = kcm_sk(sock->sk);
 	struct kcm_mux *mux = kcm->mux;
+	struct inet_connection_sock *icsk;
 	struct sock *csk;
 	struct kcm_psock *psock = NULL, *tpsock;
 	struct list_head *head;
@@ -1259,12 +1275,14 @@ static int kcm_attach(struct socket *sock, struct socket *csock,
 
 	lock_sock(csk);
 
-	/* Only allow TCP sockets to be attached for now */
-	if ((csk->sk_family != AF_INET && csk->sk_family != AF_INET6) ||
-	    csk->sk_protocol != IPPROTO_TCP) {
+	/* Only allow TCP sockets to be attached for now. A raw socket
+	 * created with IPPROTO_TCP has that sk_protocol but no icsk.
+	 */
+	if (!sk_is_tcp(csk)) {
 		err = -EOPNOTSUPP;
 		goto out;
 	}
+	icsk = inet_csk(csk);
 
 	/* Don't allow listeners or closed sockets */
 	if (csk->sk_state == TCP_LISTEN || csk->sk_state == TCP_CLOSE) {
@@ -1272,6 +1290,15 @@ static int kcm_attach(struct socket *sock, struct socket *csock,
 		goto out;
 	}
 
+	/* KCM takes over read_sock() and the socket callbacks like a ULP
+	 * does, the two can't stack. Our own marker left by an earlier
+	 * attach is fine, a concurrent attach is caught by sk_user_data.
+	 */
+	if (icsk->icsk_ulp_ops && icsk->icsk_ulp_ops != &kcm_ulp_ops) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
 	psock = kmem_cache_zalloc(kcm_psockp, GFP_KERNEL);
 	if (!psock) {
 		err = -ENOMEM;
@@ -1305,6 +1332,11 @@ static int kcm_attach(struct socket *sock, struct socket *csock,
 	psock->save_write_space = csk->sk_write_space;
 	psock->save_state_change = csk->sk_state_change;
 	csk->sk_user_data = psock;
+	if (!icsk->icsk_ulp_ops) {
+		/* Paired with module_put() in tcp_cleanup_ulp() */
+		__module_get(THIS_MODULE);
+		icsk->icsk_ulp_ops = &kcm_ulp_ops;
+	}
 	WRITE_ONCE(csk->sk_data_ready, psock_data_ready);
 	WRITE_ONCE(csk->sk_write_space, psock_write_space);
 	csk->sk_state_change = psock_state_change;
-- 
2.50.1

