Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954586;
	b=3GPwMNKI4/UIdeWRC082A4+nsbAKrSsE73CLXlIRa3Ft08wdEPsR/rnIEDMi5qgwlEX8
	 E1HTtPnRgHvUZpMZighGyU/wDbGUJhFdwb+I8cePCyglHrnJAbF0X77/jozRoKoJ9yGqU
	 pBQuP9e3jmrcLLHRsGTFUnRv/LsR/d2OtHHpyJjkGxg+RwaDl8CvrbEkxc/Vqi2FwxKC/
	 mrlPO6iCt3p0tGRqrBaABkRIR32dzulZhuzTJs8EqONkV2gHVWYiJCQ07Oh9wrvPxdupC
	 beHL7iahmlKKUiWrVKyXBlTGe5R1M7FO+ItmFY+B5is5tvrW2BjGimqoV0wngynnGGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954586;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uHM/fLTrrrtsiytgCMXnVGsW000MOYoXtR+SaLgahWg=;
	b=xcJNf/6Vm6e6NR0Wi802VKumECsratsqfC0K1ktaILDxWHXYtVuyJQbrw0mBFnyix6JH
	 WK3rE/QDXwTEgZFvqV6zbFqQGhWORcn+qivJAhuD+TGzvmVno8peMqXsgAjaWBhuqutrb
	 fVHVR6pwmGrBgtE4ZzYwI6KlEE4KMPHv1Kp16sxa3IUpw6iTJ+HEj9dfR6eI5rTkln/3J
	 vnF7vQAQE3yeKZKXmaNQdJ3ahnz/LWjI2kmip47KDo/wg5fnEzadQ/bLe3CKQKZQ8ZH+t
	 wcm05yaBi95tCAJ6vp3v+YyPIC4EV1cyQHL+nfhVJZ8d4H9Hwjwh+UPzTP/LA1GDnSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHMSXU0a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3054606A330
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHMSXU0a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9251F0089F;
	Fri,  6 Nov 2026 08:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793954585;
	bh=uHM/fLTrrrtsiytgCMXnVGsW000MOYoXtR+SaLgahWg=;
	h=From:To:Cc:Subject:Date;
	b=oHMSXU0aVZOeFuKLnemOEb1LKxXaKFEsaKl3SlYPIJTSQ7nnuHRS6g2n0+zH+5jj2
	 8QUW9p9+mB2CcM0TIZrr+z2y7DxChOUnxbyyezquQuHmn6x8cO3lN8eZpZJH4+8UPv
	 j6+lPctg8lCJ6qPo+PNGNpxTT8Q4RYhLvAxzYhO7P6LZID+mMhAkNK6L+yoEb7iaoz
	 PrQ+iwmakqwhH5tI1xO7RkcBXPzgZotMWgsGuyD9y1r14mHAjefBthFiBJNvWiIGXI
	 VYtOUMEoo0bk7MXFODPTrFaS9TbUn76HI68X5Iq9u9D13GZ+gtcARRMJoPBxuKY1W2
	 1MxkNRVWrACtQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Kyle Zeng <kylebot@openai.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH v2 net] tcp: do not resurrect a former listener with SO_ATTACH_REUSEPORT_[CE]BPF
Date: Fri,  6 Nov 2026 09:42:59 +0100
Message-ID: <20261106084300.2029567-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
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

After listen() + shutdown(), a TCP socket is moved to the closed
section of its reuseport group, while TCP_NEW_SYN_RECV requests
can still reference it as rsk_listener.

If SO_ATTACH_REUSEPORT_[CE]BPF is then used on this socket,
reuseport_attach_prog() calls reuseport_alloc(), which resurrects
it into the listening section of a new group, even though the
socket is still in TCP_CLOSE.

After close(), the socket stays in that group and the pending
requests keep it allocated. When the final ACK arrives,
reuseport_migrate_sock() can select this dead socket and
inet_csk_clone_lock() clones it. With a ULP like espintcp installed
while in TCP_CLOSE, the child inherits icsk_ulp_data and sk_destruct
after tcp_cleanup_ulp() cleared icsk_ulp_ops, leading to a
use-after-free in espintcp_destruct().

As done in commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions
between ehash and lhash2."), deny this transition instead of adding
checks to the fast path.

Only an unhashed former listener is affected. Applications can still
attach a reuseport prog to a socket that never listened, or to a
listener (including one that called listen() again after shutdown()).

Fixes: 333bb73f620e ("tcp: Keep TCP_CLOSE sockets in the reuseport group.")
Reported-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
---
v2: use sk_is_tcp() instead of checking sk_protocol, as raw sockets
    can have sk_protocol == IPPROTO_TCP (Jiayuan Chen, Sashiko)
    Add discovery, validation and testing info to the changelog (netdev-bot)
v1: https://lore.kernel.org/netdev/20261105164830.1682714-1-edumazet@kernel.org/

This was reported by OpenAI Security Research. The report does not
state the discovery method, it was likely found by an AI-assisted scan.

Validated with the reporter's PoC on a KASAN kernel: run as an
unprivileged user in its own user and network namespaces, it triggers
a slab-use-after-free in espintcp_destruct(). No kernel modification
or error injection is needed. With this patch, SO_ATTACH_REUSEPORT_CBPF
fails with -EINVAL and no splat is seen.

The following selftests pass: net/reuseport_bpf, reuseport_bpf_cpu,
reuseport_bpf_numa, reuseport_dualstack, reuseport_addr_any.sh,
stress_reuseport_listen.sh, and bpf test_progs migrate_reuseport and
select_reuseport.

 net/core/sock_reuseport.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index fccbdd0430b05984e82c19b17b6b723b0a3a03a1..b9e5648fa4c515a578fffd375c5214b3d5de6645 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -6,6 +6,7 @@
  * selecting the socket index from the array of available sockets.
  */
 
+#include <net/inet_connection_sock.h>
 #include <net/ip.h>
 #include <net/sock_reuseport.h>
 #include <linux/bpf.h>
@@ -692,6 +693,14 @@ int reuseport_attach_prog(struct sock *sk, struct bpf_prog *prog)
 		if (!sk->sk_reuseport)
 			return -EINVAL;
 
+		/* Do not put a shutdown()ed TCP listener back into the
+		 * listening section of a reuseport group while it is in
+		 * TCP_CLOSE: requests can still migrate to it.
+		 */
+		if (sk_is_tcp(sk) &&
+		    inet_csk(sk)->unhashed_state == TCP_LISTEN)
+			return -EINVAL;
+
 		err = reuseport_alloc(sk, false);
 		if (err)
 			return err;
-- 
2.53.0

