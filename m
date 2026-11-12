Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478810;
	b=qkN4tv6n3DfsO5lNbNfrMsN6M6CHiPFZBnvmukbrOYOvt4x3QCwSfY4uTsnkQj+54TnC
	 yLNwrOdFvUsLKpvqBnxf/K/841Hui9v0Rcdnd4N/ZxxvfqFSRrJXVx0CvSaQvzLLIvyR8
	 YKJOWy2HqAhjGI+VBipG7kNwai4Bx7Faacd1qIPRa0lg3GIM9eAmnnjtkrNQiJvEOonaB
	 oRm5moTgZ5OPW17bDdpTXzUxhHFuVsrvg14SQigdRYdcwtSRtLmfClekEjT0IUBqowq5V
	 u/48biL3jn+D/bVtzf6DrR/h27Dz7JvTUcmUvHkrHvG7JPtUv+2V2Qm4lgnWMUu57pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478810;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GXPN90cQiTOTR8/CCLubh8FbaUlKBYUqpj7WtEUsOIY=;
	b=qBiNHtvNu6M0Ukk0C/uQcbGgGvsBBtX3k8dLP83WFd3aQVKthfU0cnLSUZ7sMxMW/1OZ
	 QQ+lTCzN3GmKahsdPgBn0hffV/crvOkFWzLqBzZFDT9lZitnaqSdDRhKk86HKuik4Zu6T
	 +tfKlGuFyfc2jouba8vf92aTG6OI2v38HLOC3RpwwVxsLdrqp2BQAfioBmp9qzHM09hkD
	 bVApNS/vesR9Ur2a3/Bhr/RyQIrNl7GKZNGHGuj4MMX8hSd9sICb6TQNK2kD9YEA1XA/o
	 Xt0BmqPzMcvEF+O7b428mRZlSvWv39jfiDsbOhWwf2fETOziRzvH0tAdRb8A7dTYaCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iiF0WmoT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA98606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iiF0WmoT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4D21F00A06;
	Thu, 12 Nov 2026 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794478810;
	bh=GXPN90cQiTOTR8/CCLubh8FbaUlKBYUqpj7WtEUsOIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iiF0WmoTHJvmOOoN0Jh1T26uNoFuiOUM0TlZew64jO3I6jzv0L7Ez4IRtOf+imGTq
	 nRJMFL5+6Q2Hhmsb2NzFJ44ohwGxSxB6uUhgrkMLAe7n4g+ZObdLutjJhifOZm2ArU
	 FhvnWz3ltUuz9aORkRrVDhht2i9UjgHAtR+F8C/x1E92zWVr1olEkShBHxjl6Dzr9u
	 cNlmVRVhUk3WIXpeoEYdB52QOAjiPPG0X3JkxQsOoJLKl4Bu6iNvLJaSqlYBaDHmp6
	 dbyzLhUubvaQof9XPV3KBDp0461bcaF3/aWZ/w04dyFmhzoQcnJSCiMaohTikX1md+
	 pM9sE6wzaCo1g==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Jiri Benc <jbenc@redhat.com>
Subject: [PATCH net 1/2] nsh: limit recursion in nsh_gso_segment()
Date: Thu, 12 Nov 2026 11:20:00 +0100
Message-ID: <20261112102001.3744643-2-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112102001.3744643-1-edumazet@kernel.org>
References: <20261112102001.3744643-1-edumazet@kernel.org>
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

nsh_gso_segment() calls skb_mac_gso_segment() for the inner packet,
which calls nsh_gso_segment() again when the next protocol is NSH,
either directly or behind an inner Ethernet header (ETH_P_TEB).

Nothing limits the depth: a GSO packet made of stacked 8-byte NSH
headers recurses once per header, and a 64KB packet can hold about
8000 of them, overflowing the kernel stack.

Such a packet can be injected with a packet socket using
PACKET_VNET_HDR, or with tun/tap or virtio_net, as nothing checks
that a GSO packet with VIRTIO_NET_HDR_F_NEEDS_CSUM carries the
protocol it claims. It is then segmented in software if the output
device does not support the GSO type:

BUG: TASK stack guard page was hit at ffffcad5c0ab3ff8 (stack is ffffcad5c0ab4000..ffffcad5c0ab8000)
Oops: stack guard page: 0000 [#1] SMP NOPTI
CPU: 3 UID: 0 PID: 337 Comm: nsh_gso Tainted: G            E       7.4.0-rc1+ #118 PREEMPT(lazy)
RIP: 0010:lock_acquire (kernel/locking/lockdep.c:5902)
Call Trace:
 <TASK>
 skb_mac_gso_segment (include/linux/rcupdate.h:309 include/linux/rcupdate.h:849 net/core/gso.c:50)
 nsh_gso_segment (net/nsh/nsh.c:110) nsh
 skb_mac_gso_segment (net/core/gso.c:53)
 nsh_gso_segment (net/nsh/nsh.c:110) nsh
 [...]
 skb_mac_gso_segment (net/core/gso.c:53)
 __skb_gso_segment (net/core/gso.c:129)
 validate_xmit_skb (net/core/dev.c:4238)
 __dev_queue_xmit (net/core/dev.c:5087)
 packet_sendmsg (net/packet/af_packet.c:3157 net/packet/af_packet.c:3189)
 __sys_sendto (net/socket.c:800 net/socket.c:818 net/socket.c:2283)
 __x64_sys_sendto (net/socket.c:2290 net/socket.c:2286 net/socket.c:2286)
 do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Use gso_recursion_inc_test(), added in commit 006c8b834aed ("net: gso:
limit recursive IP-in-IP segmentation"), with the same limit as IPv4
and IPv6. The counter is shared with them: a packet with four NSH
headers in front of an IPv4 header is still segmented, one more NSH
header and it is dropped.

The NSH -> ETH_P_TEB -> NSH route is covered as well, as each round
goes through nsh_gso_segment().

Fixes: c411ed854584 ("nsh: add GSO support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/179443691180.2199510.148246238688217560@kernel.org/
Cc: Jiri Benc <jbenc@redhat.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/net/gso.h | 2 +-
 net/nsh/nsh.c     | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/gso.h b/include/net/gso.h
index fe3260b381d4..119fc4c170e1 100644
--- a/include/net/gso.h
+++ b/include/net/gso.h
@@ -19,7 +19,7 @@ struct skb_gso_cb {
 	int	encap_level;
 	__wsum	csum;
 	__u16	csum_start;
-	/* Number of IPv4/IPv6 GSO handler entries for this packet. */
+	/* Number of IPv4/IPv6/NSH GSO handler entries for this packet. */
 	u8	recursion_counter;
 	/* Max MSS segs per output skb, 0 = no limit */
 	u8	max_segs;
diff --git a/net/nsh/nsh.c b/net/nsh/nsh.c
index bfb7758063f3..dd4de50fc38c 100644
--- a/net/nsh/nsh.c
+++ b/net/nsh/nsh.c
@@ -9,6 +9,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <net/gso.h>
+#include <net/ip_tunnels.h>
 #include <net/nsh.h>
 #include <net/tun_proto.h>
 
@@ -84,6 +85,12 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
 
 	skb_reset_network_header(skb);
 
+	/* NSH can carry NSH (directly, or in an inner Ethernet frame):
+	 * limit the recursion, as IPv4 and IPv6 do.
+	 */
+	if (unlikely(gso_recursion_inc_test(skb, IP_TUNNEL_RECURSION_LIMIT)))
+		goto out;
+
 	outer_proto = skb->protocol;
 	outer_hlen = skb_mac_header_len(skb);
 	mac_len = skb->mac_len;
-- 
2.53.0

