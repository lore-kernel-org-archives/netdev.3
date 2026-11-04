Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817288;
	b=2H3TdgA8i+2TDvL3OiWbogBL7DhNRRXcya7RolD5QS4fTT1s9FmAN/i8Eu6p4+NCJlVw
	 po4rQebVEeyUEwuYYu6CfBZL53PuP+pOClK13uaoqNPnU7x02L+Ae8JdauZAIQCqvwWcD
	 1qelT5+r3SoO7h5b7ELXKkRNSFJj/LNH8lQBFer62xt56AOd/SlOFmQwpnyCR10Zl+6Mb
	 mNw3hUndcNqedO0ByeGgmNIC6rFFe2TfAo+kviIEsJMe3NHkL2DLx7mYNs2rMR5sOEJ9A
	 nV57nSd/fYLUlDOtDE432A+Kud/7srV3lmM0XjWUXoQvhndm/n9IdtzhebVkS/kwdFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=t4CsEcOCwTNciQ+llzpdZkUU/5tB27wSvzGypzosj/s=;
	b=C1vD0jdmTcuNy1Y7G84WRICyxLDcCMFfSHlx8Q2w/hbpYZb7wtjT/uyiUot6y0AuBF+Y
	 ZDzqxwjYeoMfBbt+NX5YROGNk7BtZoCqTNqoZYngWJ5zG/tOsBHlEvKcizLqKI54BOPCl
	 5xbpDl9Jox/4fet41U1NDnFFYcpjrmVCRLJxB6YhTe7txizQG/ScMQodX+s97IDGAUWy0
	 FmYlhRNiAkhrw8ZK/VgiH1bwnJCrdzKb4vMnQC1mrOFu7AWnMTDbpQMskVXk3PsoQTBzz
	 nbVGkyjgSHXCXNryeYTubPgVlmadKGcE2tZ/hzMMTBc9FuQElfu/KPyrQU/c/0h6dmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A038606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A038606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso455199a12.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793817286; x=1794422086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t4CsEcOCwTNciQ+llzpdZkUU/5tB27wSvzGypzosj/s=;
        b=SEo3BseZI4d2+sy06R4AFJLup2depVnZlVO1YOKZs/T5KWFm8SrT0dtbKtcd7OCfql
         EkciovEgv2rrbGWgi5FJ5NWkV8ZEsBVITZWsf9q/L1NLvkvZl7PMvBJTFKbcAzpWw3/u
         qu9aNb+1CxhoEgTpoDwHB9k7Sxf2UxxpIaMvQtw5fT4oHOf1Wl/wV1/LpvJp5Zg8hlQN
         T1DoltWw0dKqsFLPH5zbPP+EJ6tp47R59jIXE5Dmcgm4XQ5uNfGBwVhTppH9PPI3zY+g
         2dMfLzpz70vyvaqOyDiRSI94+TYiwWvW+xL5SUyuLjqjnWij3jMxaZEZ5im41TQk3jPC
         Sjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817286; x=1794422086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t4CsEcOCwTNciQ+llzpdZkUU/5tB27wSvzGypzosj/s=;
        b=YDv3QVYiuyZkyCprPsV7PI4Y3OZF6/UqWx6p2lzfYSJyMenAQf6qPVTA2wPkbC2udE
         tBbDEjLodrC7Kfmr9sMgNdK6ZswP7sX/rqO5QyVd75nfyIKmJFF3y+sMnRjQag5ACYM8
         1TrtF4cKh32YF2JqL4I/0S2edrdJKV/tHKz9b6tOCnkvEgUmEIwC+lsd24JZPEu5SOoA
         JkwtXXSDz3fAB4fwtGNgtpeXM6dsYgVBQFqG8B/MihuV80yTfmwREYOPPd/J9PZfAUjv
         S9AqS+cMS1z8zFEZiv+9sR2+fL57P0YBSKAard6Gk4ZEoZ/uOWUMfnHeaLrWUGu06NaN
         yOqg==
X-Gm-Message-State: APuU4Z+YqslhMfQkZDd8Y2liu2zuc3Eu9fOK6kfDWI5UabVclIyPQGaM
	LuhJvu4KcR98SMgMw6liVtEuYx0jKUJVwErvcWKT39Z2PDkRPYzx9zlyFCHluA+iwK3Mm/AEGyQ
	GA7X4Z3HgE5gXLHFvIp0ZEdSEFwngqwPoNdHek3MdNkVfwV5/M2yE
X-Gm-Gg: AYBFou2/M4qR1h56gnYrpOjhNi6/8El8jtfD7g7TUNuTohR1+y8SUVn1LLZn6S6IDZ5
	HJQBhBsYiL9Nb2iAkQbLyvnaEc/ZZD620eo26P5TXpE5x6pFyKVp/mJ8cgtH1arSqNbzcRvzXDM
	Lk4kdwDmWJPTH7x0hkjpjvqFBDpgosInwLaojURJsvuA2ZXY2OPF0y7eBViC3W8+PPeNIrAubLW
	69UCKabX1dqmLMcipf6eDs1YkYgQ93wJueP3JvynMkXKgqT1/cg1phvRTP9YA69WEMc60G6VOaT
	Wy+oKlapd6tmHLCk22fqbgaHUcJs389hBXAUQiNsqOi+3w7r/8qCLbP08p6KIriIfjBqp52ti2W
	ihx/MjTgr3mc+080Nycb2
X-Received: by 2002:a17:90b:384f:b0:3b0:b35e:b373 with SMTP id 98e67ed59e1d1-3b0b35eb423mr52418a91.4.1793817285789;
        Wed, 04 Nov 2026 10:34:45 -0800 (PST)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b096bd09e8sm675222a91.4.2026.11.04.10.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:34:45 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id CA5F140124;
	Wed,  4 Nov 2026 11:34:44 -0700 (MST)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id C2180DCE112; Wed,  4 Nov 2026 11:34:44 -0700 (MST)
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
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v6] kcm: reject attaching sockets with a ULP, and TLS on KCM sockets
Date: Wed,  4 Nov 2026 11:34:42 -0700
Message-ID: <20261104183442.617519-1-rjethwani@purestorage.com>
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
attach, and adding a socket that was ever attached to a sockmap or
sockhash fails with -EINVAL. listen() after a disconnect fails with
-EINVAL, as the dummy has no .clone. rmmod kcm fails with "Module kcm
is in use" while any such socket exists, even after every KCM socket is
closed and every socket is unattached.

Document the attach restrictions and these lasting effects in kcm.rst.

This is a user-visible change that will also reach stable kernels:
attaching a socket with a ULP, or a raw socket, now fails with
-EOPNOTSUPP, and installing a ULP on a socket that was ever attached
fails with -EEXIST (espintcp previously failed with -EBUSY on an
attached socket, and installing TLS after SIOCKCMUNATTACH used to work).
Likewise, adding a socket that was ever attached to a sockmap or
sockhash now fails with -EINVAL; an attached socket was already refused
with -EBUSY, but one added after SIOCKCMUNATTACH used to succeed.
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
 Documentation/networking/kcm.rst | 16 ++++++++++++++
 net/kcm/kcmsock.c                | 38 +++++++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/kcm.rst b/Documentation/networking/kcm.rst
index 71f44d0beaa3..b4dee31ad76f 100644
--- a/Documentation/networking/kcm.rst
+++ b/Documentation/networking/kcm.rst
@@ -167,6 +167,11 @@ The kcm_attach structure contains:
   - fd: file descriptor for TCP socket being attached
   - bpf_prog_fd: file descriptor for compiled BPF program downloaded
 
+The transport socket must be a TCP socket (SOCK_STREAM) with no upper
+layer protocol (TCP_ULP, e.g. kTLS) installed; otherwise the attach fails
+with EOPNOTSUPP. Attaching marks the transport socket with a "kcm" ULP of
+its own, see below.
+
 Unattach transport sockets
 --------------------------
 
@@ -186,6 +191,17 @@ Unattaching a transport socket from a multiplexor is straightforward. An
 
   ioctl(fd, SIOCKCMUNATTACH, &info);
 
+The "kcm" ULP installed by the attach is not removed by the unattach. A
+socket that was attached once can be attached to a multiplexor again, but
+for the rest of its life:
+
+  - setting TCP_ULP fails with EEXIST, so kTLS cannot be enabled on it
+  - getsockopt(TCP_ULP) and inet_diag report "kcm"
+  - listen() fails with EINVAL
+  - adding it to a sockmap or sockhash fails with EINVAL
+  - PSP RX association is refused
+  - the kcm module cannot be unloaded while the socket exists
+
 Disabling receive on KCM socket
 -------------------------------
 
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

