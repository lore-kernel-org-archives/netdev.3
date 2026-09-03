Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C1D3F4103
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417516; cv=none; b=f2MHpI0QXebgG3vleLkJSa2VvOjJjG9R72V/rP+J+P7eAS0RIxZ4UFJVtY0CfhGVwNb8qdyuTAXZHTz4oVlc29cGV1vJk/R2Ls3fX5YsjKNkk3Ejrwgo13mzdC1ZNn5RnBIoGjZJOexAQnueDYAwXCStw9N3vtoOAXS+UZBDTDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417516; c=relaxed/simple;
	bh=CvOWRGryEQFfBPJ1L91xvnA5ZoOV69nO2Qjtp9PIeXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDH3gPE0sVzKqRfHuxPFrqsO7Cd9NTAl6FJXRLYifY3Oh9hS7nMmWKMF+XKSdxBBLg8KimItxICK0wK8mv+T0Dqrnew3jIY/8zVBDfiTImQI2f7Po+4BdNJ82UgtX76APm0VRBCZZUucpwXUSCF9LMtz4ol5Thtmz5zuw9xh/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=idC51vAF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="idC51vAF"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d560775ca2so17847735ad.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 23:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788417511; x=1789022311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UrNk5mzGE7Lz2pOxwuUgYIEb0akPyWO0WZgmNAAX4FE=;
        b=idC51vAFPEJOW7ZbDMXF2hoeL8xKMd/fxMDyizWTXB0f2pJjJm+Ef0+XrniX6D6Sdl
         Nc1fV+ukOepCvm7CCZKvyhI2qziO2IuriimEWP61xNYcnqux4JtEKDKdXLvVi2M8trdk
         gpiJgP4oJ1SMhDa8hHi/3JWkobb/yazH0IXp9a7dpkuyrW68ckDAlBkopnHHBZpH0hT0
         05nwGO4FcSTU0+QUCrm58Bg4aDAakgLV4vRDq7uFBpjpXtS5eI6HVu6bJr5Ezf+ANDTk
         3G7iI8NeB/qR1Fn8mJtZUnBg5arz6zy1MALGQkLOXcE2SfS1W7XpUXjfwdC46F6Eenaq
         b9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788417511; x=1789022311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UrNk5mzGE7Lz2pOxwuUgYIEb0akPyWO0WZgmNAAX4FE=;
        b=Yn74NiYZzIvDsD698849yRs6TAPf0v0+RGti2UGKDaCp7h+vHdOUtPWL104tfQkx7r
         pvhVZcZkB0sV1+3W6BJxp9PterajPFVYmFoPzD/NwlJMGnSNl4KZfV0zVySCa0BofygX
         xuS/XzsV2iIsiIn33FiyY26mLGckjnq1Y6k1BWSLkAvBCwLu/XQC6q0LiFJ45xhwe6np
         tUloQ2rwa4GP9EaUxvv1mg9hvMtrozhE226+hTuJJUJ4x+twq3Xep+ydSqDxZ5VdUgpe
         TCbkXQI6pPgUeH26Z5f+aJXO2Qhr7w5qnFTplqXI1uQ0NheG3KfjjuixNV1J8rNlqdXE
         MkQw==
X-Forwarded-Encrypted: i=1; AKwUvByDc1IwXkjjbjGLIKv2BDrkUTw5gQTn0W9G7AgS1i/dT2wlsOjNM9chgUYF4C7nIEBKfz+btWM=@vger.kernel.org
X-Gm-Message-State: AFuF++mtGgGGdLDHkYMZ2i91BJ3ReyW3/7ifPn9RZlVgpvf73ZgUB2+t
	NAdsiZr+MfAgr6RiqLr6kQ1uHT8qvk20Ri0vD9rENjGg4Ky7QwvAG8csM1XAhaeX77pU
X-Gm-Gg: AYBFou2Js65z1q069KxWMWRbmlI1OnjkeVFyJ8IYN+XcU7o2i7k9INyTm6MyH6uIPhN
	4EQouv9TaoyyUYgOdHPczzY2zY/Ob13DmjaNlgJ+DpZkSXhbwUthrWrzQNqyHrwQNXq0FTyhlCB
	Pux6uyI6CN2Wik8FhjnpFw+wu6hcLMQgiYVQbJyoNZGwY68x0XjRhAXQEuaFuNAzXY1VxXNFLdv
	i9IoyniRZ8BW/cWog5ER8NWEu8M7cOg2nzID/XJpZBoWdTW3FxI+FObXsNJLc4GvQQCvOcAC4cy
	4dh/Mr8xb5CMx8D9K6qR6lSYA/QfrQOmMoywspSHkpsrRlcMOy0bc/84w8CF8INEZBP1miUjRjx
	t/D16Px3nv/tGOfKsA9u1QeOwh6cM0ULrxBIZdY5IeEYhJwgoO0pej4wWmEh3PSO1zKuwRhSv4c
	xqU/kz2l0nhwaT9bZLA8CZV0yx/W6JIvl6WZPw0BL2uk4EZH4WVag1dXl60oEQCfQsAAHSaufA5
	6gJ7NlLxgAgFQg=
X-Received: by 2002:a17:90b:4a8e:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-39aedf73060mr14002900a91.8.1788417510919;
        Wed, 02 Sep 2026 23:38:30 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm3296374a91.1.2026.09.02.23.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 23:38:30 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: idosch@nvidia.com,
	netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	leone4fernando@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v4 1/1] ipmr: only copy pktinfo to cache reports
Date: Thu,  3 Sep 2026 14:38:16 +0800
Message-ID: <d8a36c317f6216d20f9cfd7e49f1888f62c35f7c.1788417128.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788417128.git.zhilinz@nebusec.ai>
References: <cover.1788417128.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipmr_cache_report() builds short IGMP reports for mrouted from a packet
that may be a synthetic RTM_GETROUTE query. That query skb stores the
netlink requester portid in NETLINK_CB(), but the report is delivered to
a raw IPv4 socket, whose receive path interprets skb->cb as IPCB().

Commit bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP
msg") added IP_PKTINFO support by calling ipv4_pktinfo_prepare() on the
original packet and then copying the entire 48-byte skb control block to
the report skb. For synthetic route-query packets, this copies
NETLINK_CB() bytes into IPCB() and lets a controlled portid corrupt
IPCB(skb)->opt. With IP_RECVOPTS or IP_RETOPTS enabled, the raw socket
receive path can then copy past the short report packet or overflow the
stack option buffer.

Keep the IP_PKTINFO support, but copy only the pktinfo fields prepared
by ipv4_pktinfo_prepare().

The WHOLEPKT/WRVIFWHOLE path is a related leak: skb_realloc_headroom()
inherits the original IPCB, then a 20-byte header with ihl = 5 is
prepended. Stale IPCB(skb)->opt offsets then make ip_cmsg_recv_opts()
copy bytes from after that header as IP_RECVOPTS. Clear the inherited
IP options when that header is prepended.

This changes the accidental IP_RECVOPTS/IP_RETOPTS behavior for these
cache reports, but that behavior was only a side effect of copying or
inheriting the entire control block and was never intended to work.

Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v4:
- Clear IPCB(skb)->opt when prepending the 20-byte WHOLEPKT/WRVIFWHOLE
  header, so stale option offsets are not inherited from the original
  packet.
- v3 Link: https://lore.kernel.org/all/e93d0d2fa5725ddd06b20e3e4223ab68b93b48d1.1785719031.git.zhilinz@nebusec.ai/

changes in v3:
- go back to the v1 scope and stop changing the common path
- remove memset(), since alloc_skb() already clears the control block
- v2 Link: https://lore.kernel.org/all/1b809975e5bd9c0a1dd6fdd1db534e701fe5a4b6.1785379072.git.zhilinz@nebusec.ai/

changes in v2:
- reword the commit message to say the entire 48-byte skb control block is copied
- mention that IP_RECVOPTS/IP_RETOPTS on the mrouted socket was never intended
- move the pktinfo copy to the common path so both report branches are covered
- v1 Link: https://lore.kernel.org/all/5bc7cd71c2d671b305f25497d88ae8a0aa663c08.1784894076.git.zhilinz@nebusec.ai/

 net/ipv4/ipmr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index e5f2b1c6150d2..a4d82a1bfe80f 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1058,6 +1058,7 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 			     struct sk_buff *pkt, vifi_t vifi, int assert)
 {
 	const int ihl = ip_hdrlen(pkt);
+	struct in_pktinfo *info;
 	struct sock *mroute_sk;
 	struct igmphdr *igmp;
 	struct igmpmsg *msg;
@@ -1102,6 +1103,7 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		ip_hdr(skb)->ihl = sizeof(struct iphdr) >> 2;
 		ip_hdr(skb)->tot_len = htons(ntohs(ip_hdr(pkt)->tot_len) +
 					     sizeof(struct iphdr));
+		memset(&IPCB(skb)->opt, 0, sizeof(IPCB(skb)->opt));
 	} else {
 		/* Copy the IP header */
 		skb_set_network_header(skb, skb->len);
@@ -1113,7 +1115,9 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		msg->im_vif = vifi;
 		msg->im_vif_hi = vifi >> 8;
 		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
-		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
+		info = PKTINFO_SKB_CB(skb);
+		info->ipi_ifindex = PKTINFO_SKB_CB(pkt)->ipi_ifindex;
+		info->ipi_spec_dst = PKTINFO_SKB_CB(pkt)->ipi_spec_dst;
 		/* Add our header.
 		 * Note that code, csum and group fields are cleared.
 		 */
-- 
2.43.0

