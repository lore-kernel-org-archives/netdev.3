Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746900;
	b=CmOiu402QOXyOXnAtlQq/CXigoCiNk7ZXK3Alkz+vGThaB+B9595OAZSXrv/yF+aRZai
	 xiESW9q1+GMAhzKT+LjfyBOKLzSgrDUk2FGGWpb+ET3tmEMHLvjnCnA0bDkkws6Hi6u6E
	 Tj7h40b+DYgeMFYAeK+zohO6sH+jTEMYqN14/AQFr34oMiHGZuryEOWM16Ur0gdQmNUGA
	 Fk/t9jmiQwCAYgJ7rHiHiB2tituSwmyFJEnE2C8zNplumV58curAzjzkM4BqmkshsNiO/
	 aEE4y9VyXYkOBlT/QyyF5Gx4z3FLlJaHe/taektjk/0w8Ns7b9hJVO7wKD2UWZoacHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746900;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UdJHrg0RN3klYyxIxzwKv6xLCwx4WKiEgFNLswgc0cs=;
	b=mN7AGAmUzCyzohdbBD+gki7Xk4ZC61fjGWWp9vmbi+A+TBSJowDQTk8Blny5TCipGoWq
	 Z+GENyzwldocQ80122BEt2smLpqeF+bmMxSAzf8w35L+XYEBgYWUCkt+x3UAGN3frjI4Z
	 6dXsB1/QRZoRw9KOxIxOJzyBGgVP5rdawHNbso5DKjhOI2jZ3KNZpu/Rp14WEtiWxzmrN
	 stHVYoZD5DEIzrdnvuCqfdTun0gfHanJZo7EbrVBGs4Iw3kDjIWnRxKZXaqpJBWOt9SHP
	 UPntok103A42ORqL870iKP0ISJVWShvxWcFWH74DtOq8QqWtg6tUbA4ba6I/C9GC1cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HAafurdT;
	arc=none smtp.remote-ip=95.215.58.32
Received: from mta1.migadu.com (out-32.mta1.migadu.com [95.215.58.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA4606A32C
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11DA4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HAafurdT
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jgTz/hYZcxRGvrksAA4I+lCwJ2sml6J3MvWNfQZi+XQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792746898; v=1; x=1793351698;
 b=HAafurdTjiR4j+sehmdgYDGOnA4AWQgWOmveo7kbYzMxhLapPL70iQsQ3zxVJktJlZjW+wnJ
 TwPgMxYqYtEwwhfVQFYYZpYMSmgYl8XagvCtVIzTh4te3GU87l2oGEa4Q1sMA3YjXBBN2MHgETZ
 oOO09oOaYLh9UlXqgcLaU40A=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e6b6812eb02a8c77;
	Fri, 23 Oct 2026 09:14:57 +0000
X-Mizu-Trace-ID: e6b6812eb02a8c77
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Joel Granados <joel.granados@kernel.org>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Flavio Leitner <fbl@redhat.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/5] ipv6: restrict gc_elasticity to 31
Date: Fri, 23 Oct 2026 17:13:27 +0800
Message-ID: <20261023091419.167088-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023091419.167088-1-jiayuan.chen@linux.dev>
References: <20261023091419.167088-1-jiayuan.chen@linux.dev>
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

Every counted IPv6 dst allocation runs ip6_dst_gc() once the number of
live dst goes over gc_thresh (1024 by default). ip6_dst_gc() decays
ip6_rt_gc_expire by gc_elasticity: the smaller gc_elasticity is, the
smaller ip6_rt_gc_expire gets, i.e. the more aggressive the gc.

ip6_rt_gc_expire is a u32, but gc_elasticity has no upper bound, so
writing >= 32 shifts a 32-bit value by >= 32 bits, which is UB:

	val = atomic_read(&net->ipv6.ip6_rt_gc_expire);
	atomic_set(&net->ipv6.ip6_rt_gc_expire, val - (val >> rt_elasticity));

  UBSAN: shift-out-of-bounds in net/ipv6/route.c:3369:53
  shift exponent 32 is too large for 32-bit type 'unsigned int'
  CPU: 2 UID: 0 PID: 615 Comm: ping6 Not tainted 7.3.0-rc7+ #364 PREEMPT
  Call Trace:
   <IRQ>
   dump_stack_lvl+0xc1/0xf0
   dump_stack+0x10/0x20
   __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
   ip6_dst_gc.cold+0x15/0x1a
   dst_alloc+0x4e0/0x620
   ip6_rt_cache_alloc+0x189/0x7e0
   __ip6_rt_update_pmtu+0x68e/0x1160
   ip6_update_pmtu+0x30c/0x3a0
   icmpv6_err+0x1fa/0x330
   icmpv6_notify+0x303/0x770
   icmpv6_rcv+0xc12/0x1670
   ip6_protocol_deliver_rcu+0xb4a/0x1520
   ip6_input_finish+0x19c/0x400
   ip6_input+0xd4/0x240
   ipv6_rcv+0x1fd/0x330
   __netif_receive_skb_one_core+0x118/0x1c0
   __netif_receive_skb+0x21/0x150
   process_backlog+0x37e/0x1200
   __napi_poll.constprop.0+0xa5/0x5e0
   net_rx_action+0x4c0/0xf70
   handle_softirqs+0x204/0x9b0
   __do_softirq+0x10/0x18

Cap it at 31. 31 and 32 are equivalent anyway: ip6_rt_gc_expire starts
at 30*HZ (~30000 with HZ=1000), and such a value shifted right by 15 or
more is already 0, so val - (val >> rt_elasticity) stops decaying well
before 31. Values above 31 add no new behaviour, they only hit the UB.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv6/route.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 94e5ef1c4f83..6f2efc219f39 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6579,6 +6579,8 @@ static int ipv6_sysctl_rtcache_flush(const struct ctl_table *ctl, int write,
 	return 0;
 }
 
+static int ip6_rt_gc_elasticity_max = 31;
+
 static const struct ctl_table ipv6_route_table_template[] = {
 	{
 		.procname	=	"max_size",
@@ -6627,7 +6629,9 @@ static const struct ctl_table ipv6_route_table_template[] = {
 		.data		=	&init_net.ipv6.sysctl.ip6_rt_gc_elasticity,
 		.maxlen		=	sizeof(int),
 		.mode		=	0644,
-		.proc_handler	=	proc_dointvec,
+		.proc_handler	=	proc_dointvec_minmax,
+		.extra1		=	SYSCTL_ZERO,
+		.extra2		=	&ip6_rt_gc_elasticity_max,
 	},
 	{
 		.procname	=	"mtu_expires",
-- 
2.43.0

