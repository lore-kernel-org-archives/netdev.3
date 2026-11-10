Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342028;
	b=QcC2WLXmcMboQ8Q42mGyyknWyTFfMQpjvIkCeUOzKLaUYHmWAagBp/AWUUKlm+F9Z+HL
	 IGvVKlPJOYg0CzkOFM25/d4ZJ8/e3se1ohZbI+utzLH1OXQXDaTL0/cA5wVqkj9VNtRgn
	 FM8jb3ssrlGIswq+Q9EFY/oS8m7Glq1F9k2Fe8UrcHSaGvDwHU2PYoAx5vSnUdDdJY8u3
	 ln3m6Cc6aHg3Qy9Kr6+GVCKAQ4G4QorrbWuTuE6XrOOF2v4PLS9A2wFMRwxNprcRHid1j
	 enHOoGQk9Ip0PzCL8Xppx6EzHBSgjm4j+oDSST11co++xxXVKyB9wbID0yC8KpPArmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RIj8u929GVc3WDfh5vUX6nGJWdvQEzEmOyyq8qoXzIU=;
	b=pa9jvDy58Ms2YUctrrc+bch2uQAUXTOHeiLbcdrekevBKJc/K5WQlGddw50dvFiBLSOp
	 8dwQnTriABFUu/R+QF+lhufcwiJSHp06sxkzoHRjWj3mZ9uNWnosSEwnB1GkF/8AuGh02
	 BLC6Q2pOXN6pDkOSX1NerS53YqXIhXtv18SORc5gsURJWNg+jhkEEDSeXE3GnTU25aPty
	 /0Pge5phrV58Fk+5O4gKqdUguYzH5M9VGUWS45EtyfiJJ32WZuMvWXhQkxA2WLx/Aza+g
	 oBBuQhWHZIK0M42MiaMyPqYa6TPC0pckny5L328yXoXJWrmetOQYIypppJQuBAKUSMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hT3Dq4Cq;
	arc=none smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B06606A336
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5B06606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hT3Dq4Cq
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3aae7df0971so27384961fa.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794342026; x=1794946826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RIj8u929GVc3WDfh5vUX6nGJWdvQEzEmOyyq8qoXzIU=;
        b=hT3Dq4CqVSQT2nZKbJDxqH6Q0rPluglsO5fL7/gO9KKkf2Kld04HIX5SC7qkjuQBoP
         Fxp+oEVlHfTVZ/EDOEOJpPBIi0TZjHS0a8wVo9LyIswRQrngUAfZeWSRXBYIts4h04Pt
         lD4E5WeUHiUxVOnYdnbuOQwRtfurQhnGpr7VrtIynxMzr5vEx5Xdrv8LDXxWg0GUk0x0
         JArL6rQtoS/9JuUqiagJHul85CxER6vEeX2K7A1InZDiY0IZQQHOLKzWLPaxeUVLoSIy
         F4/H48iOxZvvlpSsb2oH1jgwa+q0i+Fpz2KBPJVWHfJGlYJAeuUkSa8bAroEvLt1owdM
         jkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342026; x=1794946826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RIj8u929GVc3WDfh5vUX6nGJWdvQEzEmOyyq8qoXzIU=;
        b=qSqNI4/6lZoQREIJxND07A2KSaSVQa0d3KbnP5EEc7DRorhVYgAjxPULXB+Ysj6LuH
         FmzENSXJ94DaUSr0ajuhn0yYlCtCC8vpT75oG045lHjembNoE2jPp+UuK5OcjiNEQOrx
         qzx9jYJUt/iAhr2IfLQEKkfdlURoxvlqvGh/IpPx8ECbCATeXXlYGG9gzA7q/NSOl9+r
         v2zBPQGlgmrCTMzQwmf/+l22HQeInyR+mbafap/2vR+CWwQvhf1vWnJ4k8gA34779SI6
         Tgj2NF+O5S3vXaBUQlvFpaABdHKV2bzeTAVaVld8qNN9yRFkkrUr9KDTMyrBnnlO5Tfs
         EB5g==
X-Gm-Message-State: APuU4Z8xxGMJeE0Af1Khy8gs6hqcd71wmyZ6F/XNuzTn0S/CNYStFGUY
	Rasn2hh5hsqoBP9pE4oMoLdfCZQggLlyJ0Cdlxsj0M96bGGJEV4Dx5vV0eJCO/TbXxg8YA==
X-Gm-Gg: AYBFou16SAXiaTT47C08tFIUrXbc2tP2sNgmgKzQFUjVU7kDzjTxGycRqMFYgliblBi
	WthrwQ7PwPvOI8tvnSL4aPnWBzKItuwCLL0htw4s/aaFm+ZxaEOisD/dochsCiPZGYsf22Kxhx3
	W+o182KPgVGO9QVWg+17PY5bxxGJHDOerzgZTGHT/UscRofa/0DTMnroFeXGpPzhtahJN2AwLeU
	Nv61ZSW3VRgOv6MZ7l14KqBzZt2Lf0eECgdLn1ZjQ4d6hODZ2bhgBm0dYPPY+AY/WVGOJFv+bms
	aiABXimzqtIj4+R1M3jXLlLORVDG58CGEfz37h9wKakH56ge3j5FctsykQA58c9OEqfsJF7xL7f
	JkVWmso8JOuRbbFfPSwjlkR1zkHH1MPk658SS3L0wUqVMXlcpjMU/sl4QlPLU6GGhOgPZUp4RFq
	3dwTO1m8TCyWzb3iaLh1SrlRMIVksPaMGRFd2cOzZYlBIau0uU6HK+7aMRFwgENVA4S8fzQG9MH
	HQIFHqaqAeuX0UpwY0st94E1Ei9tz8VSMQAUitVhgGGfK0IF452ovNBxOcz88p1X+V8MuE/ME5f
	IMpyo4llWz+ISem0pnUDft+P206pVWX+Z9tfXTEgS+jxUgbt/+LMvtBJKJmfRTCIwNhUcm3D3gT
	Nd8DsWgr9TO+Fjto44rCcd+dmrDM2FRJzjn+0Uw==
X-Received: by 2002:a05:651c:a333:b0:3ac:f011:4863 with SMTP id 38308e7fff4ca-3ae0963d670mr7828721fa.20.1794342025931;
        Tue, 10 Nov 2026 12:20:25 -0800 (PST)
Received: from dau-home-pc.megasoftware.org ([95.139.137.59])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae090ea59esm5945401fa.0.2026.11.10.12.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 12:20:25 -0800 (PST)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 1/8] ip_tunnel: add drop reasons to the generic RX path
Date: Tue, 10 Nov 2026 23:20:14 +0300
Message-ID: <20261110202021.821224-2-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110202021.821224-1-littlesmilingcloud@gmail.com>
References: <20261110202021.821224-1-littlesmilingcloud@gmail.com>
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

ip_tunnel_rcv() collapses four distinct failures into the single
kfree_skb() under its drop label:

 - the tunnel options carried by the packet do not match the tunnel
   configuration (checksum or sequence number),
 - the sequence number is older than the expected one,
 - the inner network header cannot be pulled,
 - the ECN decapsulation check fails (RFC 6040).

drop_monitor and the skb:kfree_skb tracepoint do see these packets, but
all four as SKB_DROP_REASON_NOT_SPECIFIED from the same call site, so
neither the reason nor the location tells the failures apart. Only the
device error counters (rx_crc_errors, rx_fifo_errors, rx_length_errors,
rx_frame_errors) hint at the cause, and they are not tied to the
dropped packet.

Add two drop reasons for the tunnel specific cases and reuse the
existing ones for the rest:

 - SKB_DROP_REASON_TUNNEL_OPT_MISMATCH is used when the packet lacks the
   checksum or the sequence number option the tunnel is configured for,
   or carries a checksum the tunnel is not configured for, as the
   checksum check compares both ways. This is a configuration mismatch
   between the two endpoints rather than a corrupted checksum: the
   checksum itself is validated earlier, in gre_parse_header().

 - SKB_DROP_REASON_TUNNEL_OLD_SEQ is used when the sequence number is
   older than the expected one. Unlike the previous one, this is not a
   configuration mismatch: the packet may have been reordered, in the
   network or by the receive steering of this host, and a remote
   endpoint that restarts and resets its sequence numbering can have all
   of its packets dropped until its sequence numbers catch up with
   i_seqno.

 - pskb_inet_may_pull_reason() already computes a drop reason,
   SKB_DROP_REASON_PKT_TOO_SMALL or SKB_DROP_REASON_NOMEM, which has so
   far been discarded.

 - SKB_DROP_REASON_IP_TUNNEL_ECN already exists and documents exactly
   this check, but until now it was only used by vxlan.

The sequence number check is split in two so that the two cases can be
told apart. The error counters are left unchanged.

ip_tunnel_rcv() is the RX path of ip_gre, ipip and sit, the latter for
IPv4 and MPLS payloads only: ipip6_rcv() handles IPv6 in IPv4 on its
own. The checksum and the sequence number options only exist for GRE,
so the two new reasons are meant for ip_gre. ipip and sit carry
neither option and only hit SKB_DROP_REASON_TUNNEL_OPT_MISMATCH if their
i_flags are given those bits, for instance through IFLA_IPTUN_FLAGS;
such a device then drops every packet that reaches ip_tunnel_rcv(),
with or without this patch. The ECN reason applies to all three, while
the length ones can only be hit through ip_gre: tunnel4_rcv() has
already pulled the inner IPv4 header for ipip and sit, and
pskb_inet_may_pull_reason() has nothing to pull for an MPLS payload.

ip_tunnel_rcv() initializes the reason to SKB_DROP_REASON_NOT_SPECIFIED,
as its first statement does not set it, and every jump to its drop
label comes with a reason of its own. The rest of the series follows
the same rule wherever a function has a drop label: an initializer
unless the first statement sets the reason, and a reason of its own for
every jump to the label.

Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/dropreason-core.h | 17 +++++++++++++++++
 net/ipv4/ip_tunnel.c          | 19 +++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index fa2fe8990557..5c0d9b0211bc 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -128,6 +128,8 @@
 	FN(PSP_INPUT)			\
 	FN(PSP_OUTPUT)			\
 	FN(RECURSION_LIMIT)		\
+	FN(TUNNEL_OPT_MISMATCH)		\
+	FN(TUNNEL_OLD_SEQ)		\
 	FNe(MAX)
 
 /**
@@ -612,6 +614,21 @@ enum skb_drop_reason {
 	 * itself.
 	 */
 	SKB_DROP_REASON_RECURSION_LIMIT,
+	/**
+	 * @SKB_DROP_REASON_TUNNEL_OPT_MISMATCH: the tunnel options carried by
+	 * the packet do not match the tunnel configuration, e.g. a GRE tunnel
+	 * configured with 'icsum' or 'iseq' received a packet with no checksum
+	 * or no sequence number, or a GRE tunnel without 'icsum' received a
+	 * packet with a checksum.
+	 */
+	SKB_DROP_REASON_TUNNEL_OPT_MISMATCH,
+	/**
+	 * @SKB_DROP_REASON_TUNNEL_OLD_SEQ: the sequence number carried by the
+	 * packet is older than the one expected by the tunnel, e.g. the packet
+	 * was reordered in the network or by the receive processing, or the
+	 * remote endpoint restarted and reset its sequence numbering.
+	 */
+	SKB_DROP_REASON_TUNNEL_OLD_SEQ,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 0875474a578a..7d8744ed1664 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -384,6 +384,7 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		  const struct tnl_ptk_info *tpi, struct metadata_dst *tun_dst,
 		  bool log_ecn_error)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct iphdr *iph = ip_hdr(skb);
 	int nh, err;
 
@@ -398,14 +399,22 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 	    test_bit(IP_TUNNEL_CSUM_BIT, tpi->flags)) {
 		DEV_STATS_INC(tunnel->dev, rx_crc_errors);
 		DEV_STATS_INC(tunnel->dev, rx_errors);
+		reason = SKB_DROP_REASON_TUNNEL_OPT_MISMATCH;
 		goto drop;
 	}
 
 	if (test_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.i_flags)) {
-		if (!test_bit(IP_TUNNEL_SEQ_BIT, tpi->flags) ||
-		    (tunnel->i_seqno && (s32)(ntohl(tpi->seq) - tunnel->i_seqno) < 0)) {
+		if (!test_bit(IP_TUNNEL_SEQ_BIT, tpi->flags)) {
 			DEV_STATS_INC(tunnel->dev, rx_fifo_errors);
 			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_TUNNEL_OPT_MISMATCH;
+			goto drop;
+		}
+		if (tunnel->i_seqno &&
+		    (s32)(ntohl(tpi->seq) - tunnel->i_seqno) < 0) {
+			DEV_STATS_INC(tunnel->dev, rx_fifo_errors);
+			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_TUNNEL_OLD_SEQ;
 			goto drop;
 		}
 		tunnel->i_seqno = ntohl(tpi->seq) + 1;
@@ -419,7 +428,8 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 
 	skb_set_network_header(skb, (tunnel->dev->type == ARPHRD_ETHER) ? ETH_HLEN : 0);
 
-	if (!pskb_inet_may_pull(skb)) {
+	reason = pskb_inet_may_pull_reason(skb);
+	if (reason) {
 		DEV_STATS_INC(tunnel->dev, rx_length_errors);
 		DEV_STATS_INC(tunnel->dev, rx_errors);
 		goto drop;
@@ -434,6 +444,7 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		if (err > 1) {
 			DEV_STATS_INC(tunnel->dev, rx_frame_errors);
 			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_IP_TUNNEL_ECN;
 			goto drop;
 		}
 	}
@@ -457,7 +468,7 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
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

