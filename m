Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333683793B3
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 03:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789271401; cv=none; b=cnfhEM7T2WK0mt5r9QhHKDnqsNpe1wRcrtjJ/gaHeHC4hWfc5UjDXgLVa+o7W6CPNdSHkcq9+nFJAJJ2n4i9o6LQp/7a8UFzvHmiSr2IxR0HNfdBVSeD+8IVujQ/8NAm6rqjPQqwO4sykK3r/dsbaaaCMs3gApTUeuykV0uc8vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789271401; c=relaxed/simple;
	bh=59WxsqcOX2L2RBvv5RmjuUVbgHr8/VHIhI1MMHeZfPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7zMnSuDk8nJcw3UDnAWAp10zELZ5e4omTWYe7zVc/+vwlM7XL1J2+R1QNtiVd3OXXZlHFsPkBZPIWnQfKY8+RCGjiK3PMM54A5EH2m9GatvEo3KEDMQAbnoRREiUhu1eq0Cmvv+CWmkLm9SWbLM9Mfv+pcpdE45yUB2jAnJJvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEuaMmoP; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEuaMmoP"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5a04b88e9so6567141fa.0
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 20:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789271398; x=1789876198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DAfpRG4RgjzEpNA/SBmwyiTwL7l/5J9GMQEmcjE9tJM=;
        b=hEuaMmoPvcI2iEVvCFAgBP4/W8T1XqI6PO8VA9fKot9C8RO8qQGfXma+/uYqgxwwsg
         isFk3hZezK2WIHsrqRJO1Wdssxj69mrpO6tUh8mcdBvE9zc5ahPgHV7uVfRaVPWbGW70
         TmYCgIaWBcGQbvvoXgQ8vMpZLtzmhY0WdwZbfR7JOtaxC8fsHLaE3c9m20Oapmto5Wd5
         tFz5xXpgbh+k1C9gLc187rnhgfA527ftG5HVKSkD3/BR9+6VG9obrcJrE3fk6ktzJq2Q
         FptLxEL11aEajqyBNZyW/h02T25WfAhyvEIVwwRMBnXQ6lTfGgLBJjvk0kLwkHD9Rxzx
         ge8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789271398; x=1789876198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DAfpRG4RgjzEpNA/SBmwyiTwL7l/5J9GMQEmcjE9tJM=;
        b=ApD22bcdnRc3LWQ/l4PffzUoJJmztH9wceWE7qw+q3692tiAUkh1hMTPPLR/up7mvZ
         cBIEKXpySZvYVGYBsOuATMX+ja2F3CILjGWkwz51iFBLvI6TOCX4NYhP+ZU9OhyapRdV
         X5DRozrMAcWgVlTqTrUBt81IulSDG0k+ToSeGZ+N/tKU5jS6BZ3myTKdky0lo0WVhBOh
         Nri+h4NY6GPnufZsM2Agi5aZV8BXRjXA0JTr6vQyDO1SHWZBkSqbPvEZnorulp1RrUGc
         XVku5ZXhukhHhGtjXw9y1w5nECDp68fwVlD8ylRYZm1bj+O0KM6nGG+NPs3RnE3AuUnS
         0sUQ==
X-Gm-Message-State: AFuF++lEplKlMTvPF314wBQL3XpgyOlVefdab8uUG8oH0crpsZtPUxPJ
	blWFFuZouGqvmMvA11BJj+hwmh6Gl47KSE1Vcvpx2SmGsp7xDy+ZjPcKcYNTDY3wYpo=
X-Gm-Gg: AYBFou3Grzbwc2cV7qiO/kUDvwc71yjX2LMgnt1TYDOxavXpHUZ1sL0O3HZ6mehFOPB
	y11QCgEqqMJuUhPMkxKQtOuWDeM98Na6cawxjmohroRLG0yV7hA520mBbXiZKNaf1kRgg4W4byT
	XkF5oS1Q5hZJFhIFfYIVAOJoNzVow03YoHWvELajt6w8MbUrFcnqawaHeEEWvrzpU4MlBzx7nnl
	IIGUPnyf7U3z1OKAMDxDUWiVleKgjPgTP7HXPqECWdt6LSLMmXGnmQiA15zEJMpmpizEu43ESwi
	IraFekwIYFD8RVBzsRPBclLWyebMJZeKk5KXQfa5LqoeMLCAuKcmnwNvmDzI0+Nlg3fq/+r+1Kx
	c+vbZJLckkX8KCjgwk5xuNFBVz22+rLyIm8NcLrpREPf2EiLPf70HX/ahN0CdVq1PjjM6NJfk1t
	FfhalSx0Yiq5bW9hWP2gKqa7NzQ6x3cNtoaaavPRL2sQbHbdd/sEwnb/m7CFU7EbvuJuhSY78R8
	ABfOyb0h2b0dWB9mkjOgjaj/R1cdQY12PehLjUwKNS4
X-Received: by 2002:a05:651c:19ac:b0:3a3:2a41:c0c4 with SMTP id 38308e7fff4ca-3a5b37efbdbmr6428221fa.14.1789271397883;
        Sat, 12 Sep 2026 20:49:57 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.134.117])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a332737dsm17277051fa.22.2026.09.12.20.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 20:49:57 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/8] ip_tunnel: add drop reasons to the generic RX path
Date: Sun, 13 Sep 2026 06:49:30 +0300
Message-ID: <20260913034937.875068-2-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913034937.875068-1-littlesmilingcloud@gmail.com>
References: <20260913034937.875068-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_tunnel_rcv() collapses four distinct failures into a single plain
kfree_skb(), so a packet dropped there simply vanishes:

 - the tunnel options carried by the packet do not match the tunnel
   configuration (checksum or sequence number),
 - the sequence number is older than the expected one,
 - the inner network header cannot be pulled,
 - the ECN decapsulation check fails (RFC 6040).

Only the device error counters (rx_crc_errors, rx_fifo_errors,
rx_length_errors, rx_frame_errors) hint at the cause, and they are not
reported to drop_monitor or to the skb:kfree_skb tracepoint.

Add two drop reasons for the tunnel specific cases and reuse the
existing ones for the rest:

 - SKB_DROP_REASON_TNL_OPT_MISMATCH is used when the packet
   does not carry the checksum or the sequence number option the tunnel
   is configured for.  This is a configuration mismatch between the two
   endpoints rather than a corrupted checksum: the checksum itself is
   validated earlier, in gre_parse_header().

 - SKB_DROP_REASON_TNL_OLD_SEQ is used when the sequence number
   is older than the expected one.  Unlike the previous one this is a
   property of the received traffic: a remote endpoint that restarts
   and resets its sequence numbering has all of its packets dropped
   until i_seqno catches up.

 - pskb_inet_may_pull_reason() already computes a drop reason,
   SKB_DROP_REASON_PKT_TOO_SMALL or SKB_DROP_REASON_NOMEM, which was
   discarded so far.

 - SKB_DROP_REASON_IP_TUNNEL_ECN already exists and documents exactly
   this check, but until now it was only used by vxlan.

The sequence number test is split in two so that the two cases can be
told apart.  The error counters are left unchanged.

ip_tunnel_rcv() is the RX path of ip_gre, ipip and sit.  The checksum
and the sequence number options only exist for GRE, so the two new
reasons are reachable through ip_gre alone, while the length and the
ECN ones apply to all three.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/dropreason-core.h | 16 ++++++++++++++++
 net/ipv4/ip_tunnel.c          | 19 +++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 12f909651591..e1fdd11c939f 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -129,6 +129,8 @@
 	FN(PSP_INPUT)			\
 	FN(PSP_OUTPUT)			\
 	FN(RECURSION_LIMIT)		\
+	FN(TNL_OPT_MISMATCH)		\
+	FN(TNL_OLD_SEQ)			\
 	FNe(MAX)
 
 /**
@@ -612,6 +614,20 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_PSP_OUTPUT,
 	/** @SKB_DROP_REASON_RECURSION_LIMIT: Dead loop on virtual device. */
 	SKB_DROP_REASON_RECURSION_LIMIT,
+	/**
+	 * @SKB_DROP_REASON_TNL_OPT_MISMATCH: the tunnel options
+	 * carried by the packet do not match the tunnel configuration, e.g.
+	 * a GRE tunnel configured with 'icsum' or 'iseq' received a packet
+	 * with no checksum or no sequence number.
+	 */
+	SKB_DROP_REASON_TNL_OPT_MISMATCH,
+	/**
+	 * @SKB_DROP_REASON_TNL_OLD_SEQ: the sequence number carried
+	 * by the packet is older than the one expected by the tunnel, e.g.
+	 * after the remote endpoint restarted and reset its sequence
+	 * numbering.
+	 */
+	SKB_DROP_REASON_TNL_OLD_SEQ,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 13b5e35e8790..0260a97e990e 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -378,6 +378,7 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		  const struct tnl_ptk_info *tpi, struct metadata_dst *tun_dst,
 		  bool log_ecn_error)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct iphdr *iph = ip_hdr(skb);
 	int nh, err;
 
@@ -392,14 +393,22 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 	    test_bit(IP_TUNNEL_CSUM_BIT, tpi->flags)) {
 		DEV_STATS_INC(tunnel->dev, rx_crc_errors);
 		DEV_STATS_INC(tunnel->dev, rx_errors);
+		reason = SKB_DROP_REASON_TNL_OPT_MISMATCH;
 		goto drop;
 	}
 
 	if (test_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.i_flags)) {
-		if (!test_bit(IP_TUNNEL_SEQ_BIT, tpi->flags) ||
-		    (tunnel->i_seqno && (s32)(ntohl(tpi->seq) - tunnel->i_seqno) < 0)) {
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
@@ -413,7 +422,8 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 
 	skb_set_network_header(skb, (tunnel->dev->type == ARPHRD_ETHER) ? ETH_HLEN : 0);
 
-	if (!pskb_inet_may_pull(skb)) {
+	reason = pskb_inet_may_pull_reason(skb);
+	if (reason) {
 		DEV_STATS_INC(tunnel->dev, rx_length_errors);
 		DEV_STATS_INC(tunnel->dev, rx_errors);
 		goto drop;
@@ -428,6 +438,7 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		if (err > 1) {
 			DEV_STATS_INC(tunnel->dev, rx_frame_errors);
 			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_IP_TUNNEL_ECN;
 			goto drop;
 		}
 	}
@@ -451,7 +462,7 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 drop:
 	if (tun_dst)
 		dst_release((struct dst_entry *)tun_dst);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_rcv);
-- 
2.47.3

