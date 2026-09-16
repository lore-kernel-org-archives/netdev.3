Received: from mail-lr2-f23.google.com (mail-lr2-f23.google.com [74.125.230.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC22D51C353
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569450; cv=none; b=P0ORH6gjRBxAfhKyw1zEnrcy1/MsETN3bnLbslFSlYhgGHhqvrXFU2+YmI6JL8pC1e0Q/Rn7dxulz7qizanabJB9boJaLgcIquEsOihujcKbfYjGHfMC9ctsZRItYsjAiALZXO3a7uFOaenbI6160r1FqtU/tU0aGMVpUDYXRaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569450; c=relaxed/simple;
	bh=59WxsqcOX2L2RBvv5RmjuUVbgHr8/VHIhI1MMHeZfPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlcAE86lQj9Bmoc2fXyJYRjSmjSh2/67Whg3+gtw6iqCSM0IJuNAuvj4VoQAWCmxSjjeSNsjAjyPVT16/AwXSBB37Mv+cvu8Ky3pcYrzlflSppP7N05124PeocBq+/E5G8/cFxx/hFoEKrhx3RJU5bh7pUlRMcoCEtXfQowjxd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgQVA3Ad; arc=none smtp.client-ip=74.125.230.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgQVA3Ad"
Received: by mail-lr2-f23.google.com with SMTP id 38308e7fff4ca-3a306a4f735so8962131fa.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789569447; x=1790174247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DAfpRG4RgjzEpNA/SBmwyiTwL7l/5J9GMQEmcjE9tJM=;
        b=EgQVA3Ad0Ebu5E3smlu8xfxqxy9bgv+uIBiUx86MUk7dJrOorcnzmn/Sa+WPScxO+H
         X0M4oHOOLYBFQCvaBivLhSUqYWprjDrRkwcXicU8PD+E4MTafFV6D736hke/Q30n2mlr
         eCQOm6TjURXHIq9TrVx2XzlJjEew/vCGbZxm9Jw+fDzHavgNIhH7y0jxHPU8Z/r9E9dE
         hIIuClV2vF8i5jzTdjNjzF3rH1LA+nNZTMSsM4qqR1CLWt35KHEUZ5kgqlGa5Lhf2rQZ
         sP2SF7IsEjdjwTwxSS3qn+daWNsIfMenGqcTz47x/M+WLFmxBYe2faBLn34qXA5E7Zkr
         bXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789569447; x=1790174247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DAfpRG4RgjzEpNA/SBmwyiTwL7l/5J9GMQEmcjE9tJM=;
        b=o+lfcwYTPdCkIp/gNk3MYesUV3p5CuZ/nLY4TDlDajt2AUOOztCZW4nIPrGx76Av/H
         Xw2+TecBv7eqNtIc9kN4SKWrr1/juqbmfbC9ys7d9wepTuYf817I8XsTfPaYP5Ykmp2i
         3+uAB9q3iv6bHT5P+TDTwpjrFbtcRdfQBPP8U6jlnrNmXsYMAd0ZOy5LNHiw7NOcZlMj
         hxfy4ufbesmQraqpAEVZMC37BWZpGzXhuAQ1gBltJ5bwiLTpey1dNaBzXZoL3HmGMy8h
         vNcivn67fwo3ZPDrpDIYhpHGceDG5w89CwxurXB64lHMdsvA2LKvpKldpYHP3ig1kCO7
         3kzg==
X-Gm-Message-State: AFuF++mgyz+jbtX8hmTK9qtKeRhkZkKRN+A/ewdaCBINin5eAScDzEzM
	HtE4F3+Zv3AkEBp1PdtFfPsQJ+PahMiJ50C7YWS/8EluWMO/SLPfBjQQlon6N9uXCUY=
X-Gm-Gg: AYBFou30wXUyBeR0baF5GcxM2i3s5Si4fTkyD2uOVVjZcEVNK1VGGV/Cw0J8TuN5bXD
	BzFUTI1ELtSUokakErqUiQOOnuUToi6enlHqlPB+pAmYcOw4jUuSGttTgEqvGoGKMiftUoZOrpG
	CB5pGZ+Iw9JgLM4XH4uVejsusIrZ1omApnb2iPtJ3VrmOUmwMwmifbyrWKbqHFZwewWRtFk10YP
	5DDONdwSwHlK+cc/DtLkKBI0esqP09VjzJWup+AdrFZgpV62QblPpP46oz9Tnhl32BpqApkpjWg
	iwS+kSsIfcfuGFw+SAzwVLsfyZvteAb+L5upyqaTCfQ/BRvRs4lw0uFY6FIwh3IHRNDLS3dGtSF
	NVBYkXGEs6pJ7Y1n9tkROzam0Lz5Ln6gpK/tWEZE+2i6/Dven8lidkREJH4wCAi7mQyrstNTTIW
	4mo+M2dl9yvcgRT2iIwdhfyCOasyvSdDScWMx6gw6Ir+guicN36DUs6CkoBy8O24xGbcT2jYZ7j
	MFsHIbhw8LmKkqDiGkj4AtzrRQCn4PZRmJC4AqfUth6/fGEtwOLPH5elfkxKKRm
X-Received: by 2002:a05:6512:3b1e:b0:5ae:b2b0:4c0e with SMTP id 2adb3069b0e04-5b8b661230amr903694e87.1.1789569446400;
        Wed, 16 Sep 2026 07:37:26 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([95.139.134.117])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57eb908sm955658e87.79.2026.09.16.07.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 07:37:25 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/9] ip_tunnel: add drop reasons to the generic RX path
Date: Wed, 16 Sep 2026 17:37:09 +0300
Message-ID: <20260916143717.1875082-2-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916143717.1875082-1-littlesmilingcloud@gmail.com>
References: <20260916143717.1875082-1-littlesmilingcloud@gmail.com>
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

