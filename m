Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7394D4F55D2
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115327; cv=none; b=X/yOQpGEqJVKMYhvo8i51P4cOas1gcfHkfrCcajgd7L5TfclJrhJYIsFaK6QpUavY58lhpUwLhjvPAaSZF67m9aiklv8ov90Y3NjgrlUyahD/2YVMeRor8pgBIYMZZ1ghN0urez+iBkb4PsEo4FukM6F9G4tHvHeWaHprSQrVMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115327; c=relaxed/simple;
	bh=lDaeQywAkd0uBlKk3oiOi1EGJ4dlkQdf6ygCCL5j95k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f63VjsO+dhBpmiEUrMAi6FAf1gIp3KTmZhbIdtVWWAnDuj2tW3kYbU9jkB7ssPJgAURGwbJmVWuUkkVEDdjPKnFGtHuLS5ABaw2TbeoO9C1Ej0GVcekE1uok11GLVJmjslPr1g8OOp6uTSFyjJ4G5Po2RRrk/1yEQgf11UTEL5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae7udJzt; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae7udJzt"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f1b845so216985e87.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790115318; x=1790720118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bP3J1wrqvElmNl+E95+ncUWTRk8fLaOH2UYEkTJtxjc=;
        b=Ae7udJztTjNsdkZoBV4vPVXSzfwa00JnuqFLc+e5Z3XSLMLmLF+ANGavlC7ANVuTq/
         r3cadkB1CIngRLAVaJARp05b/vhT4fd3Tv5uN2DmgXYN2XJTZzsKVVd3sdEm3hJx0Thb
         n6UzaEUDQ/LhlKdT/SZ2s5LwSCtkY+LFjC/IVPK1Jdvm6nNwfUKivYGi/avtIYLFKktG
         KsZQ7l4ZLqjLEcp0GDUQ893Hl5C9MSTBsxl5vTtyCuusKxTbfPdu1765u2yIjUuiMKfH
         kZbhG7HjTO42qbOzJZI1pd0IcsO/DztpslE2/WGOD+7QN7WVKRMmGLh0Nrzb45/0fh46
         CFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115318; x=1790720118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bP3J1wrqvElmNl+E95+ncUWTRk8fLaOH2UYEkTJtxjc=;
        b=A10U+mKkPGGOSumZleLzje+tEsKoJInyT8m8GfEzJ4HpBvfaKgMBND4jW4ekV+I7Nx
         bbWYSifp+hrs5d8D+s92vsC3u8JutKW7FYfdyS/zYqsjrUbyf8F85tpp1N4A0jcvIBct
         vQRXEr9SNG6wOp9dO1I7Emdjhnb43SOfTs6OtdW4bkog5je7rPhZGF1oeGjRfoGcpJZ3
         cGtp6/z0H0k0vX8smGnZfj/5bkbxVvRU4Ay8IvojS+ZdbSPPuWYZlgeLEQ3D3WpjspRP
         P23HYlf40vnZOxDA5dPbG+94u6N8k3G8E4fJ3nDta7rzjlFDiP8TfuDn1mr4bM4zRC4K
         6wwg==
X-Gm-Message-State: AFuF++nznznB3EolDWpXc9SjWfCbzcgMa5E/urzN+HKhz3u0Q7c6VFNF
	vlHXuwrlA6PMW8wIoScH7VWCmnkwBP500Kava/af1RzBFX9Jc6USYHR7ULErlW0LKqw=
X-Gm-Gg: AYBFou1KdCg3rKE5sbpxJ6mZfoTGMW1mDqE8azBdE7NKDawxoMrgQyKNfdMoD0U8xdC
	RStuLtyDgUd7zhlTPHr/4iCF5bczdeAStR2RBzcIQxmUPYr6meeCYl0ZN70k3alMC9N3x+IV92U
	F+gTXolrF5jwIhJpSiFF9cb+xv6oMrJZHTlpbZbW6Eweb7qD8bsLpFedzmOm9ZEpviDbE7VD2yi
	fIY0hLOdvbojCTfQy8vvFfbxG8/nIi7PIrzEidJZKUOF7qrnSUQY11BCAWoEIkod8OiFZ/tDH5j
	nAWK6JhsbNW0HuzeZw5uQcyvzOolufjdtNjnJRJ+Fa7ufXUuBnbQaG/saLHHLpAwuUZEtWLaQXo
	XmDcwHDNk+M2Zsw9D2s5Eaq4R10mFMOyd74yFTmvQvUXkOCStOXHRdHZCU3dvroo8mVKwaL4EF6
	shfg9JaQEj7ZwCd1o3QS/rRvPGYXbkgPteLcg1r+EaXp6ckxN1ZbgAV3d2urKkaTlwPwuQfDWZb
	2+oakbVBldjoGZiVH69EgFP9IKdjRnr78XObI/GN8IMUUv+mwBb/ZfIrn7pKJ/BwA+arln3
X-Received: by 2002:a05:6512:318c:b0:5b4:fdbe:ab4e with SMTP id 2adb3069b0e04-5b8d895e710mr201829e87.25.1790115317953;
        Tue, 22 Sep 2026 15:15:17 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([94.28.220.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d857873asm164920e87.17.2026.09.22.15.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:15:17 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 02/10] ip6_tunnel: add drop reasons to the generic RX path
Date: Wed, 23 Sep 2026 01:14:59 +0300
Message-ID: <20260922221507.3268127-3-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922221507.3268127-1-littlesmilingcloud@gmail.com>
References: <20260922221507.3268127-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__ip6_tnl_rcv() mirrors its IPv4 counterpart: all of its failures share
a single plain kfree_skb(). Reuse the drop reasons that ip_tunnel_rcv()
now reports and the ones the length helpers already return.

Note that skb_vlan_inet_prepare() returns an enum skb_drop_reason that
has so far been discarded, and that the ETH_HLEN check gets one by
calling pskb_may_pull_reason() instead of pskb_may_pull().

__ip6_tnl_rcv() is reached two ways: ip6_gre (ip6gre, ip6gretap,
ip6erspan) goes through the exported ip6_tnl_rcv(), while the
ip6_tunnel encapsulations (ip4ip6, ip6ip6, mplsip6) reach it from
ipxip6_rcv(). Only ip6_gre sets the checksum and sequence number bits:
tpi_v4, tpi_v6 and tpi_mpls carry nothing but .proto, and unlike ipip
and sit, ip6_tunnel stores IFLA_IPTUN_FLAGS in parms.flags, not in
parms.i_flags. So the option mismatch and the old sequence reasons are
reachable through ip6_gre alone.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 net/ipv6/ip6_tunnel.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index d5ff50a2ac01..458ce328311b 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -813,6 +813,7 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 						struct sk_buff *skb),
 			 bool log_ecn_err)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct ipv6hdr *ipv6h;
 	int nh, err;
 
@@ -820,15 +821,22 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 	    test_bit(IP_TUNNEL_CSUM_BIT, tpi->flags)) {
 		DEV_STATS_INC(tunnel->dev, rx_crc_errors);
 		DEV_STATS_INC(tunnel->dev, rx_errors);
+		reason = SKB_DROP_REASON_TNL_OPT_MISMATCH;
 		goto drop;
 	}
 
 	if (test_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.i_flags)) {
-		if (!test_bit(IP_TUNNEL_SEQ_BIT, tpi->flags) ||
-		    (tunnel->i_seqno &&
-		     (s32)(ntohl(tpi->seq) - tunnel->i_seqno) < 0)) {
+		if (!test_bit(IP_TUNNEL_SEQ_BIT, tpi->flags)) {
 			DEV_STATS_INC(tunnel->dev, rx_fifo_errors);
 			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_TNL_OPT_MISMATCH;
+			goto drop;
+		}
+		if (tunnel->i_seqno &&
+		    (s32)(ntohl(tpi->seq) - tunnel->i_seqno) < 0) {
+			DEV_STATS_INC(tunnel->dev, rx_fifo_errors);
+			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_TNL_OLD_SEQ;
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

