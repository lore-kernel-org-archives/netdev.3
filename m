Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F477346E44
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647555; cv=none; b=AovXACH4rfXtsgNz0YIw3vj6GbtrC0VqXHdKA19k13HcTeZujbl2Iqexzi5Bofm5n7joiQieGOoXjkHPxxZSo8KIGWnJ/18OWMGE5oD/8KziJV6Lntr2vkbg7CBJ8/v4Anw9H6F7552yGu50TlyF6YPg6dH2ZcVMTpgQbnWkjQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647555; c=relaxed/simple;
	bh=K88MNP5Efh+BDoAwbMW5733qhPs1XEXb6HePqnGcV1U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oU/YRTyTt7Qu0sEHAxxXh+wl/TTIg8MN4BcAhujdJUx4vtQYtnr0wXGhwA9YlylFmR/7VFqYft+fHOjxqL/qJ7O95Bl9mBAD8hq3PyLwZW4UaYEX00GSXHGZI5A0M63Ktih3QXRgqRfR1P9clCL4HnthIs3wm1RiuvZk08mCzC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgxyuXrP; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgxyuXrP"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93494cce712so569179885a.3
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 01:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787647553; x=1788252353; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vQtdTjsaKdKCFOf1EkwnKdDwxDVhVBq1+fbr6eZi5fM=;
        b=rgxyuXrPVCbkpzqc6hgKrY+HYkhBF3rex30UNKpBIuN78goRTTXMrz7Mj2LUuA2fGV
         Sd2lZaWN86BPNplWPyf9mSK/dcWZYxbHfrvezqjrpWewgPtZEUsNp2QM0Wj+15xDuFnR
         LZoQ+1QMfgbSJfg4i5Ajf1yzRYVdvJVRKwqpCuVIhVokzS7j5ImNcqYo/NrtvAXNlxPk
         +HsjRRGaHTYjTzB2XS60nywia78k49MahT7O4zFZvyzVY10qRzFB8jaCiLoBGdKdQRxK
         PvBcCxAD+/aMjWI5ziPNHUvhDanwH1Hyc+RjO0BzD3jAwJggoP9r0P+ZtkTOdei/QpEe
         rH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787647553; x=1788252353;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vQtdTjsaKdKCFOf1EkwnKdDwxDVhVBq1+fbr6eZi5fM=;
        b=DRk5UvKnj7rZPZjcyz8WLmDeQpCwX/TMs4CGP7YnwukDVGrLoBEzDraTjLyy/H+5Qp
         fjltF77FzBbEM8c3B8rD8XgeGxw93eSgW+oT60NzFsLdX9Vz6tGWdVeS2eqLFoCsccW0
         Y1tsVYXeAMY4aWcTelEe62fT7b0D4efIlUz0mRydlSkFdHR7/1dJx9F5JnPln5zdlvS3
         LoPhvdzbn5a9++rdNwZwui55Eri0HJdeEM9VyfQ7JX3uwMXwgpgPwkgjYlu8Jq9Vd0MM
         qUtbKHTM3Xl8d4Sqg5ca1V6G+Dx4zR4Sdt5EisIYbKDmge1/G/+nrDQ6O845m/WIPcuu
         jObA==
X-Forwarded-Encrypted: i=1; AHgh+RroSxRwhs2gE0Uc0+cTrfSj2I8G1zKHe+fnHaIgAlr+AV350TM/J4gkoD6kHCucZfmjPE0dur0=@vger.kernel.org
X-Gm-Message-State: AFuF++k86Vifu9ej2tTjNS/jjuPWZisQpiO2AXUZqZ9v6BR0LXi0YEoF
	Alz8ojuISMXhyv+6rjRslysZRsHSw4esQQ9R5f1p+pSueq3vFFT6XXc6BGg8OXYsMoHkCJAx0tP
	iRFpBf+fXBLkT0A==
X-Received: from qkak10-n2.prod.google.com ([2002:a05:620a:a0ca:20b0:937:7890:532e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:678b:b0:92e:7d53:8e8d with SMTP id af79cd13be357-9373952dbbdmr2091230085a.27.1787647552843;
 Tue, 25 Aug 2026 01:45:52 -0700 (PDT)
Date: Tue, 25 Aug 2026 08:45:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260825084551.1562967-1-edumazet@google.com>
Subject: [PATCH net] net: icmp: avoid invalid transport header access in
 icmp_send tracepoint
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+6d2762674103618994b0@syzkaller.appspotmail.com, 
	Peilin He <he.peilin@zte.com.cn>, xu xin <xu.xin16@zte.com.cn>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

syzbot reported a WARNING triggered by DEBUG_NET_WARN_ON_ONCE():

 WARNING: at skb_transport_header include/linux/skbuff.h:3087 [inline]
 WARNING: at udp_hdr include/linux/udp.h:23 [inline]
 WARNING: at do_trace_event_raw_event_icmp_send include/trace/events/icmp.h:30 [inline]
 WARNING: at trace_event_raw_event_icmp_send+0x48c/0x6ec include/trace/events/icmp.h:11
 Call trace:
  skb_transport_header include/linux/skbuff.h:3087 [inline]
  udp_hdr include/linux/udp.h:23 [inline]
  do_trace_event_raw_event_icmp_send include/trace/events/icmp.h:30 [inline]
  trace_event_raw_event_icmp_send+0x48c/0x6ec include/trace/events/icmp.h:11
  __traceiter_icmp_send include/trace/events/icmp.h:11 [inline]
  __do_trace_icmp_send include/trace/events/icmp.h:11 [inline]
  trace_icmp_send+0x320/0x49c include/trace/events/icmp.h:11
  __icmp_send+0xcfc/0x11d8 net/ipv4/icmp.c:1013
  ipv4_send_dest_unreach net/ipv4/route.c:1280 [inline]
  ipv4_link_failure+0x57c/0x8dc net/ipv4/route.c:1287
  dst_link_failure include/net/dst.h:438 [inline]
  vti_tunnel_xmit+0xe40/0x17a4 net/ipv4/ip_vti.c:307

TP_fast_assign() unconditionally calls udp_hdr(skb) before checking
whether the packet is UDP. Furthermore, __icmp_send() can be invoked
from paths (e.g., link failures, ARP errors, forwarding, AF_PACKET)
where skb->transport_header was never initialized (~0U).

Under CONFIG_DEBUG_NET=y, calling skb_transport_header(skb) triggers
DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb)).

Fix this by:
1. Only parsing transport info when iph->protocol == IPPROTO_UDP.
2. Using skb_header_pointer() at skb_network_offset(skb) + (iph->ihl << 2)
   to safely fetch the UDP header without assuming transport_header is set.

Fixes: db3efdcf70c7 ("net/ipv4: add tracepoint for icmp_send")
Reported-by: syzbot+6d2762674103618994b0@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a8d5538.91706f20.ef82.0009.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Peilin He <he.peilin@zte.com.cn>
Cc: xu xin <xu.xin16@zte.com.cn>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 include/trace/events/icmp.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
index 09ae115099dfe25616b6c74d5b92be1af4acff55..6937b778ae54dbf4442b127957a017da3551aaff 100644
--- a/include/trace/events/icmp.h
+++ b/include/trace/events/icmp.h
@@ -27,17 +27,20 @@ TRACE_EVENT(icmp_send,
 
 		TP_fast_assign(
 			struct iphdr *iph = ip_hdr(skb);
-			struct udphdr *uh = udp_hdr(skb);
-			int proto_4 = iph->protocol;
+			struct udphdr _uh, *uh = NULL;
 			__be32 *p32;
 
 			__entry->skbaddr = skb;
 			__entry->type = type;
 			__entry->code = code;
 
-			if (proto_4 != IPPROTO_UDP || (u8 *)uh < skb->head ||
-				(u8 *)uh + sizeof(struct udphdr)
-				> skb_tail_pointer(skb)) {
+			if (iph->protocol == IPPROTO_UDP)
+				uh = skb_header_pointer(skb,
+							skb_network_offset(skb) +
+							(iph->ihl << 2),
+							sizeof(_uh), &_uh);
+
+			if (!uh) {
 				__entry->sport = 0;
 				__entry->dport = 0;
 				__entry->ulen = 0;
-- 
2.55.0.860.g4b6b3295ed-goog

