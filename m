Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33592550DB4
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115338; cv=none; b=qE8uu2twoKecjbC2tddYCPM2/EMiWXKedkCKNP2BXtRH4YNJEXxgXZKIwndJpneGdCyhshhIpwnnlfoQaynfR7eTIe/2hGFRcvrMSSfmSGI1dOBAx+9rRfmrx1GrHl6wEyCceGjLD3eJ/dQ+3exmq+phRS7sZDa7O6OhsDUNSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115338; c=relaxed/simple;
	bh=VRZNWx4ugJkuvukyHgB8smW2wlSxu5AiMHqtTnuMIyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8TeQs69KIyU4HNjYQIkKR5oV3+Qxstwu6ymhVbeUqORFPAz14HMIflEOPVwhSW9I2sWxSe+DspsYwfvcXD/yGCiTwS/312SGnPrCbAduCu0cJsi2mshcYB4YQv/NaAgrhR9WRoTqR7hH0E7qaVI80B2pP3q5Kih3UproVC9aPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFRnd56T; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFRnd56T"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f15b78so222981e87.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790115325; x=1790720125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I/01E19apDogLQJb8/WrRagKxzGtq0BoJnfIbRYZXRU=;
        b=OFRnd56Tmbpy1zWuNVMh105PqknKaj4LtsfoaXlN1/CPkKYFpmtH1kPPdLiTNtuHWo
         wsU6lq/yZ75LakVFx6db6sovPkW5qNoBhncO6xpeJlbNLuCiUD0GR0/IDMbnkBssYFfu
         FNZXqRtONaKcfDDO7qlEXOSevMr/Fex2Wus7+8SYR6hKD5adtAslGDcdHGUCKzpQiBLQ
         mWVIPA0dOIH3ZSorXQNJr+F1BgxP3jSx20ed8TOEoA24j1OLAqIei2zBtJitO5qRZZ9z
         /8ElRdoDJ1qRrx/+68nhpQ+LBOLOOiirbf8eATufRDalhDqg+2FjlZn0Jv2kQa9xrIBp
         LF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115325; x=1790720125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I/01E19apDogLQJb8/WrRagKxzGtq0BoJnfIbRYZXRU=;
        b=OhephBk2MeHFtaDvKfxxTtLf5iT3oom/vdI9mAd62pUUHNHHdgzwaQg7UC67PPWtgd
         3CjPys1TuFyidZ6H3ST8c3k8fwpRMMA3dITsE4lpxZoKuirZ/bG4v8hH2kiFAymca59Q
         sN3knFjUxaGtW1WD3IaIyNcADriQukqpDN0036h7iGT5zZ05733j+nEgo4ukrmLk0W5r
         jdHXQN//W/t7XM0YiehNAs+uvhLcyT6l7IkQ0G19VccqMg+07J/cXbpERHXGNTcKZyfR
         KGJm/hB3FTKFxr6SbRmiuMwc40SN8p5+rXd8nL70M2r3aJcv++IiMSer40N+toVPBcUd
         za6g==
X-Gm-Message-State: AFuF++mhwjXxkTUtWFejw+zu0FIwd999mL0JOaHtqf0SEsq6K/x5gOA2
	yBvsIe5YxSFV7KJDWmgC8sTLxD6B/4Ra6NQpHgGXIptPvQQTHLlsNDMH45qbkm2+OEA=
X-Gm-Gg: AYBFou1HtpbjJbybu22iTcEy8yrSYtLkZLlNSPuObjQJEuP6ZkOcPD7C+pJpTta6wnz
	BTQfX7/AQk+CAhximJXzdrpKo+Mfi/ewQR/ucWDQDORJFMYnn/Rfqt74bPruk7YcCTVKqB2dSQa
	qMeXLn6AlLGj7d0et3NgAcWq85Mu12G2AaA6gvAaDKElDnkVIUFhWmoswuuaTwlVHFA8P7YrRY7
	wOuo3OJc3DAIZrCongAPmbkvYOH0WE8O86pMbockFfU7jlwdjsrrCZoO7ddosaXF5UIrXtfhepQ
	eDWoo6/so1Q7MUWQm9OxKC17iF0GvWDDkBIrHWryuFVSIOeDc741CcBp46NIAVXZ2ufy8EXjLXM
	cLcERqzr2IGPyXWcM21k8ofTb9dvLA6m9DFQm0QleBRj0bKsx0FztGUXFiNiClyykokZovE/Mzl
	D9gYXHugGbcHOCUAlxMF+6PldfbyHxu9mWiOYcVV+N7t1KaEuc/tw5ChKJp2A6GonSFxucEzE16
	5ua8YxZ7+4lXXRQcH+2sHZe+9mz6h8WB2sazwiF0O0+9rOY78ySDa41DsCzjfqBdx3j7oPQ
X-Received: by 2002:a05:6512:3b86:b0:5b8:bc5e:b56e with SMTP id 2adb3069b0e04-5b8d89b04f9mr179380e87.38.1790115325212;
        Tue, 22 Sep 2026 15:15:25 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([94.28.220.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d857873asm164920e87.17.2026.09.22.15.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:15:23 -0700 (PDT)
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
Subject: [PATCH net-next v4 04/10] ip_tunnel: add __iptunnel_pull_header_reason()
Date: Wed, 23 Sep 2026 01:15:01 +0300
Message-ID: <20260922221507.3268127-5-littlesmilingcloud@gmail.com>
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

__iptunnel_pull_header() returns -ENOMEM whenever it fails. It can
fail in two pskb_may_pull() calls, one for the tunnel header and one
for the inner Ethernet header of ETH_P_TEB, and in the skb_unclone()
done for GSO packets. pskb_may_pull() fails when the packet is shorter
than the requested length as well as when pulling from the frags cannot
allocate, so a truncated packet and an allocation failure look the same
to the callers. The ones that report a drop reason can only pick
SKB_DROP_REASON_NOMEM, as vxlan_rcv() does, and so would the GRE
receive paths converted by the following patches. In ip6_gre,
gre_rcv() calls the helper before the tunnel lookup, so a packet from
any sender whose ETH_P_TEB inner Ethernet header or WCCPv2 extra word
is cut short would be reported as an out of memory condition.

Add __iptunnel_pull_header_reason(), which returns the reason
pskb_may_pull_reason() already computes, SKB_DROP_REASON_NOMEM when
skb_unclone() fails, and SKB_NOT_DROPPED_YET on success. Turn
__iptunnel_pull_header() into a static inline wrapper that keeps
returning -ENOMEM on any failure, so its existing callers are left
unchanged; the export moves to the new function.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/ip_tunnels.h  | 13 +++++++++++--
 net/ipv4/ip_tunnel_core.c | 24 ++++++++++++++++--------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 7102aa11fae2..c68031d01c39 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -614,8 +614,17 @@ static inline u8 ip_tunnel_ecn_encap(u8 tos, const struct iphdr *iph,
 	return INET_ECN_encapsulate(tos, inner);
 }
 
-int __iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
-			   __be16 inner_proto, bool raw_proto, bool xnet);
+enum skb_drop_reason
+__iptunnel_pull_header_reason(struct sk_buff *skb, int hdr_len,
+			      __be16 inner_proto, bool raw_proto, bool xnet);
+
+static inline int __iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
+					 __be16 inner_proto, bool raw_proto,
+					 bool xnet)
+{
+	return __iptunnel_pull_header_reason(skb, hdr_len, inner_proto,
+					     raw_proto, xnet) ? -ENOMEM : 0;
+}
 
 static inline int iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
 				       __be16 inner_proto, bool xnet)
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index bab42b9e277f..51f1537ce6c1 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -106,19 +106,24 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(iptunnel_xmit);
 
-int __iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
-			   __be16 inner_proto, bool raw_proto, bool xnet)
+enum skb_drop_reason
+__iptunnel_pull_header_reason(struct sk_buff *skb, int hdr_len,
+			      __be16 inner_proto, bool raw_proto, bool xnet)
 {
-	if (unlikely(!pskb_may_pull(skb, hdr_len)))
-		return -ENOMEM;
+	enum skb_drop_reason reason;
+
+	reason = pskb_may_pull_reason(skb, hdr_len);
+	if (unlikely(reason))
+		return reason;
 
 	skb_pull_rcsum(skb, hdr_len);
 
 	if (!raw_proto && inner_proto == htons(ETH_P_TEB)) {
 		struct ethhdr *eh;
 
-		if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
-			return -ENOMEM;
+		reason = pskb_may_pull_reason(skb, ETH_HLEN);
+		if (unlikely(reason))
+			return reason;
 
 		eh = (struct ethhdr *)skb->data;
 		if (likely(eth_proto_is_802_3(eh->h_proto)))
@@ -135,9 +140,12 @@ int __iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
 	skb_set_queue_mapping(skb, 0);
 	skb_scrub_packet(skb, xnet);
 
-	return iptunnel_pull_offloads(skb);
+	if (unlikely(iptunnel_pull_offloads(skb)))
+		return SKB_DROP_REASON_NOMEM;
+
+	return SKB_NOT_DROPPED_YET;
 }
-EXPORT_SYMBOL_GPL(__iptunnel_pull_header);
+EXPORT_SYMBOL_GPL(__iptunnel_pull_header_reason);
 
 struct metadata_dst *iptunnel_metadata_reply(struct metadata_dst *md,
 					     gfp_t flags)
-- 
2.47.3

