Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7CC34E777
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791671918; cv=none; b=HJYzdbGU/uBlLZ2ddt5Eib5IByKSN/kLsVEyUEDnqu/i4S3rEAsj2Kguv3IQy3SiSeTAc2rqnRxvQ7QPuuBsX5RC8rJuCk9TeRI4JcqMzZpvatPX8CIKumVcvr5cYhx5yo2JxvDbHL37Sp3rbR610gozAPU6RdWUs5SHG61Ye0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791671918; c=relaxed/simple;
	bh=GakE8AZ7h7Ff/gZ0gzwS+vvrTUmSI/jN2/MR+62m4Xg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wf/Hz/gDL5txuChyRqLj5XAy21j6TneAM6xW+7E2xwK72RYRESLBgbtGSackThVvnCz04I+JYiBrUJy+ESjQmVLrULVb05issWgRrvk+KfLVfDC4Lv6HAQ+8FBJqUU1T5zBiPlj+7TAxhB0ZqtYVFTLFl10d+ctETHIS+GCtKV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpfV9UN9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpfV9UN9"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2533d83e3bso133401666b.2
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 15:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791671915; x=1792276715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ASc9O9quoKRrtl/skArbQkt7QMywfxsGfVb1NDerWcQ=;
        b=CpfV9UN9TDfvsnlLE/GJzBlZr9r5PT9uhtZ/jG1pg9DY/kqYUHm4IelXq9f+c/MYC8
         8gO1rDPzjomaVGy5pLt5OkUtLx8WelRE5jeIkgG4neV+gidnFOuE5g2n/HGeRSrKDofk
         fXv49mbbSmx7MngYayt9omNviKrIa928FAWS14OY8yr9c/pQA+q3FkBo52sxWMbHT3bG
         hMTvw0/7t2IzVdeWs7IT/1LdZL3rD73KPWtn9lP0oChS1J1gH6VPrJ3xZ+0cGYQjae5k
         HGloZqQNTXEa5TcHubSWA9kdUrGh3oldfaqhDrbqd/aZGkLMY0ZeApUnxaYgNVNiAFKq
         EoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791671915; x=1792276715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ASc9O9quoKRrtl/skArbQkt7QMywfxsGfVb1NDerWcQ=;
        b=VjsYav50QxOgiC3Fuhrf5mXzjhsHRXog0H3J4sxFu0yaqKfdzAnwH3eFvIdp8DtTRB
         VO/z6HXHVX5lSY8XBtGvtYMJGdqI1yaHDq4F2Gls4RZsL6aIv6mLTGeeyu89AA6OGk8B
         ikSppZHW+lG8Y8SH2fvhJx3II5q0NFWgmkXHvX/3Decy+fxGvXctzT5hQtaF/+B7MDE8
         NEvcjAoY0Bh0G1QkQ+FyfpctaafybfzOcY6AF4EKwRQ3oMxKP0ZVXSV8dlSfK+hTyJyY
         47tBliiZoVP1lG51SMG20F85isfzwIhGCeG/TEmIVKf5H/Qsk8Z2DriCLZqcUFOpzwrn
         hnQg==
X-Forwarded-Encrypted: i=1; AKwUvByiu11z7b5KFFakYlfVBav7ufZgdhqlh+qVPLPsCYlx0x+NbebIgc99ELDg7eNRlNN48KzfYSQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfe4r1pZ8pOT68ouINT1i7XzoCsea5QTN81fG8uGPF5o11spcw
	ECa+o+MmQzuDuiAht7WaF59e1luYtrdFqx+/WL3YBcU799gYr5nnmlgI
X-Gm-Gg: AYBFou0XHOXoUNB3U9ZYwNRpyXsGvVCkNr1F4yXG6WcQ348OyI1K4Bl9lPD1P2wcXdk
	+e9RndkQhqUZGUZWpKpxOx/QQVkXLR772ssWdC12q65UkiyiFReFDLss/p34YHLi3JtL+AV2QPb
	Prol4kJKtaxNHtRFp69yIjV7eOawwhCvC8DEK1WSbeB06CuLK3bG4SRo/5PplBGsK8HFFLuAchT
	H5s+YnaO++NHJaWX/WfVAMrJSoL/xgDsYoFEwV4QyxHifz7Ll5TRT6iAYxu54xdn2K6KwcN6/Cz
	tNPtKIeYx/FwURcoEXrD/zUwr6Q7XEesvDqzdsxTy4iOf7OZwivaJ4UAVi+OscOW/qTIiDMsUZ3
	QHpHiLraC9yQ8h9wO1AdYQ+gOXLZGz/IcldIl2F0o8YggSatCiDpcJgrybBk5Oa2Fy5K9REHtHT
	3l0knuzp6/1QFJH1p2SwNBQ4ekgFVCU+2pEbgDONNHjybkdpP9W93RXQK/EYTc8cyWatRJ7eUaw
	j2fmQ05Ng==
X-Received: by 2002:a17:906:f5aa:b0:c2e:3abd:aadd with SMTP id a640c23a62f3a-c31aa093e85mr514870666b.37.1791671914377;
        Sat, 10 Oct 2026 15:38:34 -0700 (PDT)
Received: from theodors-laptop.. ([5.255.118.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9762af5sm293764366b.1.2026.10.10.15.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 15:38:34 -0700 (PDT)
From: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Christian Ehrig <cehrig@cloudflare.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Tom Herbert <tom@herbertland.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>
Subject: [PATCH net] ip_tunnel: reserve headroom for the encap header before pushing it
Date: Sun, 11 Oct 2026 01:36:01 +0300
Message-Id: <20261010223601.1193655-1-theodorlarionov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_tunnel_xmit() and ip_md_tunnel_xmit() push the FOU/GUE header in
ip_tunnel_encap() before skb_cow_head() reserves headroom and unshares
the header. A packet redirected into the tunnel by tc mirred or an nft
netdev fwd only has the headroom of the device it came from, and
fou_build_udp() hits skb_under_panic(). With a mirred mirror, the push
overwrites the Ethernet header of the original packet instead.

Reproducer, run in an unprivileged user and network namespace:

  ip link add dummy0 type dummy
  ip addr add 10.2.2.1/24 dev dummy0
  ip link set dummy0 up
  ip link add ipip0 type ipip local 10.1.1.1 remote 10.1.1.2 \
          encap gue encap-sport auto encap-dport 5555 encap-remcsum
  ip link set ipip0 up
  tc qdisc add dev dummy0 clsact
  tc filter add dev dummy0 egress matchall \
          action mirred egress redirect dev ipip0
  # send a UDP packet to 10.2.2.2

skbuff: skb_under_panic: text:ffffffffad28b5cf len:49 put:8 head:ffff888010217740 data:ffff88801021773c tail:0x2d end:0x180 dev:ipip0
kernel BUG at net/core/skbuff.c:214!
Call Trace:
 <TASK>
 skb_push+0xcc/0xf0
 fou_build_udp+0x2f/0x380
 gue_build_header+0xfa/0x150
 ip_tunnel_xmit+0x87f/0x21c0
 ipip_tunnel_xmit+0x472/0x4f0
 dev_hard_start_xmit+0x139/0x680
 __dev_queue_xmit+0x11e4/0x3520
 sch_frag_xmit_hook+0x10a/0x190
 tcf_dev_queue_xmit+0x44/0x60
 tcf_mirred_to_dev+0xbf8/0x1060
 tcf_mirred_act+0x612/0x11b0
 tcf_action_exec+0x1d9/0x8b0
 mall_classify+0x16d/0x1e0
 __tcf_classify.constprop.0+0x121/0x710
 tcf_classify+0x8d/0xc0
 tc_run+0x342/0x590
 __dev_queue_xmit+0x9a7/0x3520
 neigh_resolve_output+0x44c/0x780
 ip_finish_output2+0x6e8/0x16f0
 __ip_finish_output.part.0+0x1bb/0x350
 ip_output+0x2ad/0x4a0
 ip_send_skb+0x195/0x1f0
 udp_send_skb+0x758/0xcc0
 udp_sendmsg+0x1634/0x2050
 </TASK>

Call skb_cow_head() for the encap length at the start of both
functions. ip_tunnel_xmit() reads tunnel->encap once, so a concurrent
changelink cannot change the length between the reservation and the
push. The GRE callers and ip6_tunnel already reserve this headroom.

Fixes: 56328486539d ("net: Changes to ip_tunnel to support foo-over-udp encapsulation")
Fixes: ac931d4cdec3 ("ipip,ip_tunnel,sit: Add FOU support for externally controlled ipip devices")
Signed-off-by: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>
---
Found with a syzkaller-based fuzzer.

syzbot has an older report with the same title, fixed by c88f8d5cd95f
("sit: update dev->needed_headroom in ipip6_tunnel_bind_dev()"). This
is a different path: redirected packets do not get needed_headroom.

Tested on net af32da41b032: the reproducer above and an nft netdev
egress fwd variant no longer crash, and a GUE ipip tunnel between two
namespaces still passes traffic.

 net/ipv4/ip_tunnel.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index e6bcf01411d0..38ab3c3bf5c9 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -579,6 +579,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	struct rtable *rt = NULL;
 	struct flowi4 fl4;
 	__be16 df = 0;
+	int encap_hlen;
 	u8 tos, ttl;
 	bool use_cache;
 
@@ -587,6 +588,11 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		     ip_tunnel_info_af(tun_info) != AF_INET))
 		goto tx_error;
 	key = &tun_info->key;
+	encap_hlen = ip_encap_hlen(&tun_info->encap);
+	if (encap_hlen < 0)
+		goto tx_error;
+	if (skb_cow_head(skb, encap_hlen))
+		goto tx_dropped;
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 	inner_iph = (const struct iphdr *)skb_inner_network_header(skb);
 	tos = key->tos;
@@ -671,6 +677,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	struct ip_tunnel_info *tun_info = NULL;
+	struct ip_tunnel_encap encap;
 	const struct iphdr *inner_iph;
 	unsigned int max_headroom;	/* The extra header space needed */
 	struct rtable *rt = NULL;		/* Route to the other host */
@@ -679,11 +686,23 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	struct flowi4 fl4;
 	bool md = false;
 	bool connected;
+	int encap_hlen;
 	int err_count;
 	u8 tos, ttl;
 	__be32 dst;
 	__be16 df;
 
+	/* Size and push the encap header from one copy of the config. */
+	encap = READ_ONCE(tunnel->encap);
+	encap_hlen = ip_encap_hlen(&encap);
+	if (encap_hlen < 0)
+		goto tx_error;
+	if (skb_cow_head(skb, encap_hlen)) {
+		DEV_STATS_INC(dev, tx_dropped);
+		kfree_skb(skb);
+		return;
+	}
+
 	inner_iph = (const struct iphdr *)skb_inner_network_header(skb);
 	connected = (tunnel->parms.iph.daddr != 0);
 	payload_protocol = skb_protocol(skb, true);
@@ -765,7 +784,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			    tunnel->net, READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
-	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
+	if (ip_tunnel_encap(skb, &encap, &protocol, &fl4) < 0)
 		goto tx_error;
 
 	if (connected && md) {
@@ -834,7 +853,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	max_headroom = LL_RESERVED_SPACE(rt->dst.dev) + sizeof(struct iphdr)
-			+ rt->dst.header_len + ip_encap_hlen(&tunnel->encap);
+			+ rt->dst.header_len + encap_hlen;
 
 	if (skb_cow_head(skb, max_headroom)) {
 		ip_rt_put(rt);

base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
-- 
2.34.1

