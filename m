Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52303B14C4
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788213122; cv=none; b=GcRFMzQYyN6qDL6SIb2AHQbR+v7+XAphFW9Lb/NzJNpPF7OFiCKkVGyohHY5F9MsVet4BCOmvuRdYR9JpAFoEfxWe63319pRhyKoHt2c9m5H0rcz41P+/fm8+gqKUV5OEW8+pxYDcIaSOtXrSiRZ8OnQjiiTGOgbGWqA+Vajowg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788213122; c=relaxed/simple;
	bh=3qvZ3aiO+s+CVAa4MERALYDlYKjhPNcy4xFtFfaY6/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ts78JM7YIToKZ9igKc4XYhADoq1/MECezyIhx22/ueFuExkNyjIkx25InmOhHq3uIRSVVhnJ9puILHi9C4F6BLy4u8BcLAN+iIn+avTikcwBHxXSW6Y3Ew49g6yJCL7+z+gBFRFrEQIdLOotdEvdSvmfKimnL33RccGWHZ9I6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N16BYGlx; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N16BYGlx"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b5ef26b92dso3857386e87.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788213115; x=1788817915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2NyiM+FHtIF3Ks/VyMyFTJauOhca6iS4MuHeOc8+lYc=;
        b=N16BYGlxO4G1pur2uOucSPNCBDx88uG9h0z67tYE1BE4K4IzYXu6iflRAaY4t3bNzU
         Pn6DYwzbnJmsPUdJk3mT6jv9uRCw1/tv117jQhLp2YxYpH2e8ArRn7ydV5cG87HjDDmC
         lkqh8o8aaI3Bays1lRE1hnYREwFyontGH3O/RBGR64cyVnCsyVVkFB5E3SNKsA8CuU/B
         M894k/KQ8fbiL7q5v7iEfmR3a7zpl2I5aUVRycMMrn0SI6gTLoN/WgyZ11vUBazEfxV4
         HddbPvZOsbyPC7NJKvocTHCUpOQHogd7CjnllnpZ7d3fnNKr/PAylsb4I/UFvDIYUXIE
         ln3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788213115; x=1788817915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2NyiM+FHtIF3Ks/VyMyFTJauOhca6iS4MuHeOc8+lYc=;
        b=qX6DRBwH838FqMGc08Ok51W25v03z7yD23fGPy/RCRq5PSBqJq8hgDZz/wsprxqMBb
         qcc9Pl9VfZoG+vkm+geSiEepv0PArU3O0p962Isl7k/2XJ9NMuSlwvkek0q/JA+cEecn
         /KbBF2bcc1ckgbY0MU43F/bahzkLh3OEGmj21WUBNsd53boE30J4/ba1oql8Oubf5r0R
         XnsHZYYA1LdOBwqryXBNJIGl5e/Y2Jygx4f3532EuUhAyzNY3rtFQdyIFStam6DRFWzj
         EUvYTg9n2A8db2nZ9hZRT0X7jii3/DOjojRvn6YdA67/qfStnMaTUBAZR8LqM/EpS8de
         WJqA==
X-Gm-Message-State: AFuF++mSJ9ox2gwyqcrTE8L/+Ax41trwuiMq82TIYLqH7NdkXTL2c+KO
	YEfeTz3oBG12pjMwTY4x+y7B0NsFjZGmuc2D2CXLot/yPPYtaBx2DWx3Lclo+2Nwrjw=
X-Gm-Gg: AYBFou1ltGqWYgOeba8LLz6gQ9SXhhm0ZmOJ1AU6brN6BUH6m8TUjcxvKUiooUzhSSg
	XhrzyUU4ZLopBY09ZC061Chvcd6a8voWXY8ry1HkBmevQgx/XfvCEmkiqEqdbfKW6xktP6A+aN3
	W/mghUBKGLE+BBLi1oUAkKUuC3ZkPPELIiJHrOEFYlzhfGVUoG8aj24s1xQN55Z1fOXo5qFg3Q4
	REjvi4hBkiDMgBupVfQN6r2iwmWccbqH4yCiwxQmSDu8y5PovTsI7wpmiqHWvgPGeMlZ3w/GazM
	IA2XQzTu3coCDZwH9ky//A7dcUM7RZZ0W4UrsIjmt8icroqUkJ3bosU6JnZ0bnpS0wAxajGi4dL
	AqSXpKDQU/lf58dXwoTT9Q/2i6H01uO3FjnYjn4GQBgsX6OGN1arFtA6/xkq77zD4F6tkp3Oxet
	xVEv/9A+skntcvltDztuOM/Xm/g7Kfg/aGjFdxrb7LRYBVScnObWaED2fcnWXwysEXrILIa8eks
	p1IyCQ+exystSVE91zRE/ZaNvCCAdIo1Q==
X-Received: by 2002:a05:6512:3053:b0:5ae:b7ce:9ca5 with SMTP id 2adb3069b0e04-5b5fe0902a3mr1665824e87.18.1788213114642;
        Mon, 31 Aug 2026 14:51:54 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.184.237])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b5e8a06a77sm2388782e87.48.2026.08.31.14.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:51:54 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 02/11] ip6_tunnel: add drop reasons to the generic RX path
Date: Tue,  1 Sep 2026 00:51:28 +0300
Message-ID: <20260831215137.549324-3-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831215137.549324-1-littlesmilingcloud@gmail.com>
References: <20260831215137.549324-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__ip6_tnl_rcv() mirrors its IPv4 counterpart: five distinct failures
share a single plain kfree_skb().  Reuse the drop reasons introduced
for ip_tunnel_rcv() and the ones the length helpers already return.

Note that skb_vlan_inet_prepare() returns an enum skb_drop_reason that
was simply discarded, and that pskb_may_pull_reason() has been
available all along.

__ip6_tnl_rcv() is reached through ip6_tnl_rcv() from both ip6_tunnel
(ip4ip6, ip6ip6) and ip6_gre (ip6gre, ip6gretap, erspan).  As on the
IPv4 side, only ip6_gre sets the checksum and sequence number bits, so
the option mismatch and the old sequence reasons are reachable through
it alone.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 net/ipv6/ip6_tunnel.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index d5ff50a2ac01..85578fa125bc 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -814,21 +814,29 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 			 bool log_ecn_err)
 {
 	const struct ipv6hdr *ipv6h;
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	int nh, err;
 
 	if (test_bit(IP_TUNNEL_CSUM_BIT, tunnel->parms.i_flags) !=
 	    test_bit(IP_TUNNEL_CSUM_BIT, tpi->flags)) {
 		DEV_STATS_INC(tunnel->dev, rx_crc_errors);
 		DEV_STATS_INC(tunnel->dev, rx_errors);
+		reason = SKB_DROP_REASON_IP_TUNNEL_CFG_OPTS_MISMATCH;
 		goto drop;
 	}
 
 	if (test_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.i_flags)) {
-		if (!test_bit(IP_TUNNEL_SEQ_BIT, tpi->flags) ||
-		    (tunnel->i_seqno &&
-		     (s32)(ntohl(tpi->seq) - tunnel->i_seqno) < 0)) {
+		if (!test_bit(IP_TUNNEL_SEQ_BIT, tpi->flags)) {
 			DEV_STATS_INC(tunnel->dev, rx_fifo_errors);
 			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_IP_TUNNEL_CFG_OPTS_MISMATCH;
+			goto drop;
+		}
+		if (tunnel->i_seqno &&
+		    (s32)(ntohl(tpi->seq) - tunnel->i_seqno) < 0) {
+			DEV_STATS_INC(tunnel->dev, rx_fifo_errors);
+			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_IP_TUNNEL_OLD_SEQ;
 			goto drop;
 		}
 		tunnel->i_seqno = ntohl(tpi->seq) + 1;
@@ -838,7 +846,8 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 
 	/* Warning: All skb pointers will be invalidated! */
 	if (tunnel->dev->type == ARPHRD_ETHER) {
-		if (!pskb_may_pull(skb, ETH_HLEN)) {
+		reason = pskb_may_pull_reason(skb, ETH_HLEN);
+		if (reason) {
 			DEV_STATS_INC(tunnel->dev, rx_length_errors);
 			DEV_STATS_INC(tunnel->dev, rx_errors);
 			goto drop;
@@ -859,7 +868,8 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 
 	skb_reset_network_header(skb);
 
-	if (skb_vlan_inet_prepare(skb, true)) {
+	reason = skb_vlan_inet_prepare(skb, true);
+	if (reason) {
 		DEV_STATS_INC(tunnel->dev, rx_length_errors);
 		DEV_STATS_INC(tunnel->dev, rx_errors);
 		goto drop;
@@ -881,6 +891,7 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 		if (err > 1) {
 			DEV_STATS_INC(tunnel->dev, rx_frame_errors);
 			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_IP_TUNNEL_ECN;
 			goto drop;
 		}
 	}
@@ -898,7 +909,7 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 drop:
 	if (tun_dst)
 		dst_release((struct dst_entry *)tun_dst);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
-- 
2.47.3

