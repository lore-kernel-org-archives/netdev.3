Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B7C3AEF5A
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129987; cv=none; b=SS7G/bTZjKof/OPheu33KV/a8yzXYf6VLdnA+3b/ogByu1kOIaA0Rz+x6Lf7ZbeBqERqtbissVl0io4kD+LeB1q+6UVK+ta+q4BJJ6WcBka6NJGGiXZjiHFEeqbKPHu2DUGD3qv88bV1T7jpnfI6kAUxjdru3mm66Tnp5iuz2VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129987; c=relaxed/simple;
	bh=AITtcoaAIpb4uUeZtALKX3JgmREav8R3aY0e8nMvhXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aqH9Ji02AdnDzPqu0MTogpEw64Q4beZN8YjgH3O66kxBlQ2PL4d+R0DsRIZXtTEOl3zLAXTUTiNQ1q9GGwYeNnugRXD7F3lFIvl1pf83qge2dntbVbeOwYKaW0lbc36PkUJxvQhwNEEn+HApXcgX00Of+jK6/HnZMSBopokzL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWB0PpX8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWB0PpX8"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e30b9f1441so10906955ad.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 09:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791129982; x=1791734782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KPCQRYfj3K7cx8lOYemZCxsct2R2cHzCc+gyMPgQVA0=;
        b=UWB0PpX84irY5u1ik9pACqKNxWiL5S/iHe8RtboCKx4bbfqlsHmXqaKo9HP1qFwapQ
         pjsQxFdVhl7QAXJGMDt+FG4huM65a7KZ9qopHbFQnmZP4ZNTl30XW/naKkwxs/+6iiqv
         2vxME+Cwi8+8BNV1BJCOGJb/7ZA8MikhfVs628uMta+UvLrbgDyJVvqee/qqgDk89nCN
         C4AnR1yTZl2MNnYsPX6va7rJwB5qdkzpXTfZ2itNU+m6zVDj6wArDRIhfT3Rw/w8GUC2
         UhNG1pKhcOFspa8NUl0GYxCTiOsmu3whdMxL3P381a41Xv9XZibvzY7137RgDfDqU6iN
         tXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791129982; x=1791734782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KPCQRYfj3K7cx8lOYemZCxsct2R2cHzCc+gyMPgQVA0=;
        b=JtmAoRhKtDTJfx+pcrjNAnIb0tnujm8kkVk+wc8qiymWTrLzCKD6sTjKRX3/Dgh3h+
         3L9QKcPJoPY8cM+qmVOeJW1Us95i2+KarycsiGq1Rg6m5pmffZKH8F3RdTZsLIpxnK7A
         9QRe07poeoZW4ODUBUpi24vRPe/gsAnUP2F6z36U7B5FlCWXtlOFl1VXbWFXFwHlo+pj
         H1vSFJzz1M6mF76mtDjgt1qZ9NXX/MGKERhgvyTPlx0aHYDvnhKWflkO28ddnkVjJOcJ
         RebDCku2uwg3PCA5s1xn4cl0/DI/hxJ5Jmxh0CtroPSpCet/C58/8VkG7AU7PmslY7S3
         8f/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxOPk16PyIURBFGaAQqAydId9zogHFAIzgvX78t7SviZY2Jz/2wa4wCGKGw+sb8C/e3zKR22Sk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMnx1t9icoL1d0nEk832A2gB/2Nn6blYAcEhhzDeY7YIxi6aYQ
	mavHw4ywL6R1b1TfSfhD1fh/4kX5nLDvK/nGakSw9KYkKIIQAzccdki2
X-Gm-Gg: AYBFou1+7zLvshHi5aBuqZmLMNo3RW3skzaUlEYGN0B/ehTSfUKGTUK9QYM1PGug6y8
	3CkFVNmB2SfZcN9bpWchKe/D4FT6JSVSsKFc1g3Eur8s+IKe/TZmeYSVxdJ6g+C2yoOhqqMeM5I
	ZtCSaFCU7Wp/6YWSpv+h7Z3SyRZbl+WZPNaORKYpM7+I8rNvkrRYsm3hE2KPbXRFAgJwpbv8IOa
	FAZcfE8QxAcLqoc9t/AmznSB9yYw0vuBdKJdplkTWlYa5MybSr2WP4R3vWW5orIHm/A1vw7lqFI
	w14GvrzjEXn2vHJd8L8TI/A8uCglUDg0Z5UKYGq21Ivk0bstx1T5y9InRomWt2DR5O2eAbi5awq
	sIi/9dqLbQy0WgwNFEV1x+X5Y7Ut31Sm55wg+OsDh4ItiEU73Nsqsd/LbhKEyJa3TjzXP+rYK03
	ozAft/q00TtIS88kYxFougU/40SHsmhC+f/K40mFvSwBN1d4eJBjwKGFJ2C/GXH5wQdv6zAQ==
X-Received: by 2002:a17:90b:1d43:b0:39e:1633:d29e with SMTP id 98e67ed59e1d1-3a786736686mr4376078a91.5.1791129982011;
        Sun, 04 Oct 2026 09:06:22 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45f:e6::17:34f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7ad87874esm2760347a91.0.2026.10.04.09.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 09:06:21 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+d7795c8487ca4e20ed88@syzkaller.appspotmail.com,
	syzbot+d0d2f1a65f45b319d25d@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH nf] netfilter: nft_synproxy: only handle pure SYN and ACK packets
Date: Sun,  4 Oct 2026 23:06:15 +0700
Message-ID: <20261004160615.142456-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nft_synproxy treats any segment with SYN set as a client's initial SYN
and any segment with ACK set as the client's final ACK. A SYN-ACK thus
gets answered with a fresh SYN-ACK cookie.

If that reply is routed back to the same host, e.g. to a peer address
covered by an address on lo, it re-enters the input hook, is answered
again, and never stops. Every such SYN starts its own endless loop over
the loopback backlog, so NET_RX softirq keeps the CPU busy and memory
fills with skbs and rtable entries until workqueues stall and the
machine OOMs.

Use the same flag checks as ip(6)t_SYNPROXY: SYN without ACK, FIN or
RST is an initial SYN; ACK without SYN, FIN or RST is the client ACK.
Anything else falls through to the next expression.

Fixes: ad49d86e07a4 ("netfilter: nf_tables: Add synproxy support")
Reported-by: syzbot+d7795c8487ca4e20ed88@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d7795c8487ca4e20ed88
Reported-by: syzbot+d0d2f1a65f45b319d25d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d0d2f1a65f45b319d25d
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Notes (not for the changelog):

Reproduced in QEMU (x86_64, 2 vCPUs, KASAN+lockdep) with syzbot's C
repro for d7795c8487ca4e20ed88. Minimised: only the nft batch and the
injected SYN matter, which is exactly the d0d2f1a65f45b319d25d program.

The rule is an inet table, base chain on input, with an unconditional
"synproxy" expression. The SYN goes from 172.20.20.187 to .170 via tun;
syzkaller puts 172.20.20.10/24 on lo, so the whole /24 is local and the
SYN-ACK cookie comes back through lo. Instrumented trace:

  synproxy tx .170->.187 in=syz_tun out=lo syn=1 ack=1
  synproxy tx .187->.170 in=lo      out=lo syn=1 ack=1
  synproxy tx .170->.187 in=lo      out=lo syn=1 ack=1
  ...

Before (3fd2ff60f6d6, full C repro):
  - synproxy syn_received ~400k per CPU per netns after 15s
  - rtable 80k -> 295k, skbuff_head_cache >1M, softirq time explodes
  - "BUG: workqueue lockup", then OOM / hung task, VM wedges

After (2 runs x 300s, full C repro):
  - no lockup, hung task or OOM
  - rtable flat (~2.2k), skbuff_head_cache flat (~80k)
  - syn_received grows slowly (~9.5k/300s): real SYNs still answered

ACK|FIN and ACK|RST no longer hit the cookie check (and its NF_DROP);
they continue, as with ip(6)t_SYNPROXY's XT_CONTINUE. The usual
"ct state invalid drop" rule still catches them.

 net/netfilter/nft_synproxy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_synproxy.c b/net/netfilter/nft_synproxy.c
index 9ed288c9d168..a580cb7324da 100644
--- a/net/netfilter/nft_synproxy.c
+++ b/net/netfilter/nft_synproxy.c
@@ -53,13 +53,13 @@ static void nft_synproxy_eval_v4(const struct nft_synproxy *priv,
 	struct synproxy_net *snet = synproxy_pernet(net);
 	struct sk_buff *skb = pkt->skb;
 
-	if (tcp->syn) {
+	if (tcp->syn && !(tcp->ack || tcp->fin || tcp->rst)) {
 		/* Initial SYN from client */
 		nft_synproxy_tcp_options(opts, tcp, snet, &info);
 		synproxy_send_client_synack(net, skb, tcp, opts);
 		consume_skb(skb);
 		regs->verdict.code = NF_STOLEN;
-	} else if (tcp->ack) {
+	} else if (tcp->ack && !(tcp->fin || tcp->rst || tcp->syn)) {
 		/* ACK from client */
 		if (synproxy_recv_client_ack(net, skb, tcp, opts,
 					     ntohl(tcp->seq))) {
@@ -84,13 +84,13 @@ static void nft_synproxy_eval_v6(const struct nft_synproxy *priv,
 	struct synproxy_net *snet = synproxy_pernet(net);
 	struct sk_buff *skb = pkt->skb;
 
-	if (tcp->syn) {
+	if (tcp->syn && !(tcp->ack || tcp->fin || tcp->rst)) {
 		/* Initial SYN from client */
 		nft_synproxy_tcp_options(opts, tcp, snet, &info);
 		synproxy_send_client_synack_ipv6(net, skb, tcp, opts);
 		consume_skb(skb);
 		regs->verdict.code = NF_STOLEN;
-	} else if (tcp->ack) {
+	} else if (tcp->ack && !(tcp->fin || tcp->rst || tcp->syn)) {
 		/* ACK from client */
 		if (synproxy_recv_client_ack_ipv6(net, skb, tcp, opts,
 						  ntohl(tcp->seq))) {
-- 
2.43.0

