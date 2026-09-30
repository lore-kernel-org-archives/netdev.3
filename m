Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE775226BF
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793575; cv=none; b=gESWU5ArHZ0r1Ca13Ui8+3EwhscuB+DW6x4MO9v6xDu0mJ7Zvk2saCHssLYjUWucvej90HBy8IcsJjt3Y/qvhwsqi5zjQUEClB2suq/xscIX1/DkCUL2keiiT6gPQTWQbAVebBb/iprUnvSq9WahG3GNRpXnokfBlWQI1maHmNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793575; c=relaxed/simple;
	bh=+30bnDy5M/EUZhuBwDo0pPqL7vfdoPWX4PnYaUfMYp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKjXi+Jibs9XvGaecp4WbtyzPw37pU2dlbAuHkqtaAGoxOWFGaKS8Srvid8mKj/N7ofzcVGNivym+Q5X69DBHp6IcQ3atyzNWU65qAs9fh0ZcptdIo1bNi92KqK+NUhE14T3g+iJA1pWMvFsl0710Y9gEQdAYrDFN+ajMUiIHeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SttzixYw; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SttzixYw"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba3e27d525so861809e87.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793572; x=1791398372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gn6c2o2h3AHgs5qHDPlcMW1OaN+cNQv/VRB050jtNvM=;
        b=SttzixYwQ/xCuoewsu+NSHPKI/4t08puLAfMRp4LVUDfkHf7OxRdzsXPC1zpZy3G8w
         J8gnrMAjZhWoAjMARuBAU+nAHrabB50mgKpH2npun0u6ZV+8luposevHWgtAz3LcZjMN
         VhJ+trd5Sh+CToalFzwPtn622wZ6m1mYQNJeAkpe3Fjpxe/0C2ooC39X8tjo1FE4/p0h
         +4L0RsD0Z9RL75yJgpkD2cWIZ92l4bMaadl/gz4fDhKEJ2tNhrDqou1A+7Q7pqRS0GPH
         7UNh8OHN/yXIlUUVfwMoY9RDqohlvOIsy2o5HSbRaV0+YyW3AwJAs4D5xG1r3yC5g3yo
         EjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793572; x=1791398372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gn6c2o2h3AHgs5qHDPlcMW1OaN+cNQv/VRB050jtNvM=;
        b=V2efordVV/olACWPDyF5b3/X9rVNlXe/DIBrvwjsG9DKXtA3tx+X+4eNcwbMIrvTzr
         RwSNLfEusSJKork4lSXMIjWQZgUeuGbVaVAql+Ocb9IaTFe0rOh/vZR/xn8qXKjuYXy0
         b92nnULZIXNTDYBYv5Z3EE6bcXlTexh5aO60hQOA5a8Ds7arumGW0MhjKHCQae/XfsrT
         ll29oBvG4u94k0Z/QTVBeQsMyV3IV5ogb/JOgaIpF889n3v2pY3vr1XxhHc75/NWDLiZ
         YOwEEeaEpI8HsTw8nyBiWjHpv5+mhkP1udUYIJq3esxzHjgeFG+QB3ep1JSmV8iEAqu1
         Q86w==
X-Gm-Message-State: AFq9FYLP48ynbUWhyejrrT2BHuJZ3cF9NUKMy9F8WuMy8vhy97W+u0Sf
	pNMV/ZZ6Jeu929w0aA/8Bbn7pm9x0KQ5cYEbTLjtvpDBo3e47fb9cNaexJSdxAcc
X-Gm-Gg: AYBFou33hTeXFI1wLRTutw2rM4z4ECWfvG7ICtjgEjRS/eSycTlYzOxFSWb2SFm9l/Q
	J2YshBw9vwnzo+koA25E3XAW/3w9OSgogu5+yRmd5h0Sr/4fjJc7CaXbsliGoXy/Mqx2LScFuOy
	x4PP4jdIYI36OFdsj6rj6ou+tpQ0lrYW17Tn2X07MXXQTSTCs4gQZGWbajSsxEAj87ZEfGxGB7f
	l54Nc2BHH4frMK8CII8+JBvY+A489hqT3bTIs8PkwvNbbSH2B2MEZR7qQvgXLNSDRHRXyCQpTF7
	xUDIHsm/JvSrOQJm70KVb+RARayWatmEglbfMEYUFhBCXG4kjEmC+nLdd5axfhHfh2n9IS3D3mu
	Kw92Es0guCxw9x0u3g4nKTlXdpZxuiaaGmSB66cwndP6rhb1FQyBKpnlO5ybul0phytvSjdtMj+
	1rVmNNuFgMF260FS0U0xCyWzPxuTCwwbV0+wkBNUxmIV6GavyO2Pue1KA4P44+IAjAIeakV9t/2
	ayW4o4Dt2FTrOT39tHT1SpNNLnap7CJFvETIETrCw15
X-Received: by 2002:a05:6512:3986:b0:5b8:b419:b7b with SMTP id 2adb3069b0e04-5ba4060b8b8mr880713e87.49.1790793571660;
        Wed, 30 Sep 2026 11:39:31 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.169.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fbb999sm156593e87.62.2026.09.30.11.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:39:31 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 06/14] gre: make gre_parse_header() report a drop reason
Date: Wed, 30 Sep 2026 21:39:02 +0300
Message-ID: <20260930183910.3151873-7-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
References: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gre_parse_header() returns -EINVAL for every failure and its receive
callers turn that into a plain kfree_skb(). The only detail they could
get so far was the csum_err flag, which none of them actually reads:
both ip_gre and ip6_gre declare it, pass it in and then ignore it.

Make gre_parse_header() return the drop reason instead, with
SKB_NOT_DROPPED_YET for a valid header, and let the two receive paths
report it. The header length it used to return is already stored in
tpi->hdr_len, so the callers take it from there. The reasons are:

 - SKB_DROP_REASON_TUNNEL_INVALID_HDR, for a header carrying an
   unsupported version or the routing bit; its description gets a GRE
   example,

 - SKB_DROP_REASON_GRE_CSUM, a new reason for a checksum error, like the
   existing TCP_CSUM, UDP_CSUM, ICMP_CSUM and IP_CSUM,

 - the reason pskb_may_pull_reason() returns when the header cannot be
   pulled: SKB_DROP_REASON_PKT_TOO_SMALL for a short packet and
   SKB_DROP_REASON_NOMEM for an allocation failure. The byte that tells
   WCCPv1 from WCCPv2 is read with skb_header_pointer() instead, which
   only fails on a short packet, so that check returns
   SKB_DROP_REASON_PKT_TOO_SMALL.

gre_rcv() in the demux reports SKB_DROP_REASON_TUNNEL_INVALID_HDR for a
version it cannot dispatch at all, as gre_parse_header() does for a
nonzero version in ip6_gre, which does not go through the demux. A
valid version whose handler is not registered, such as PPTP, is
reported as SKB_DROP_REASON_UNHANDLED_PROTO.

csum_err had a second use: the ICMP error handlers pass NULL for it, so
that a checksum failure does not reject the header and the rest of it is
still parsed, as they only get a part of the original packet. That came
with commit b0350d51f001 ("ip_gre: fix parsing gre header in ipgre_err")
and becomes an explicit ignore_csum_err argument. The checksum is
still computed either way. As the function is exported, the comment
above it becomes a kernel-doc comment, which describes the argument.

Tunnel lookup failures and the other drops of the receive handlers
still report SKB_DROP_REASON_NOT_SPECIFIED at this point; the following
patches convert them.

The reason follows the rule of ip_tunnel_rcv(). gre_rcv() of the demux
and of ip6_gre sets it in its first statement, so it is not initialized
there; ip_gre's gre_rcv() initializes it, which its looped back
multicast check relies on, as it drops before the header is parsed. All
three store the result of a helper in the reason, so their drop labels
fall back to SKB_DROP_REASON_NOT_SPECIFIED.

Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/dropreason-core.h |  4 +++
 include/net/gre.h             |  5 +--
 net/ipv4/gre_demux.c          | 65 ++++++++++++++++++++++++-----------
 net/ipv4/ip_gre.c             | 18 +++++-----
 net/ipv6/ip6_gre.c            | 18 +++++-----
 5 files changed, 70 insertions(+), 40 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 85aaa58c3ecb..0d963f18a21e 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -131,6 +131,7 @@
 	FN(RECURSION_LIMIT)		\
 	FN(TUNNEL_OPT_MISMATCH)		\
 	FN(TUNNEL_OLD_SEQ)		\
+	FN(GRE_CSUM)			\
 	FNe(MAX)
 
 /**
@@ -544,6 +545,7 @@ enum skb_drop_reason {
 	 * @SKB_DROP_REASON_TUNNEL_INVALID_HDR: tunnel header is invalid. E.g.:
 	 * 1) VXLAN reserved fields are not zero
 	 * 2) VXLAN "I" flag is not set
+	 * 3) GRE version is not supported or the routing bit is set
 	 */
 	SKB_DROP_REASON_TUNNEL_INVALID_HDR,
 	/**
@@ -631,6 +633,8 @@ enum skb_drop_reason {
 	 * remote endpoint restarted and reset its sequence numbering.
 	 */
 	SKB_DROP_REASON_TUNNEL_OLD_SEQ,
+	/** @SKB_DROP_REASON_GRE_CSUM: GRE checksum error */
+	SKB_DROP_REASON_GRE_CSUM,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/include/net/gre.h b/include/net/gre.h
index b55f67ecd2fc..b5dbe00ab15e 100644
--- a/include/net/gre.h
+++ b/include/net/gre.h
@@ -32,8 +32,9 @@ struct gre_protocol {
 int gre_add_protocol(const struct gre_protocol *proto, u8 version);
 int gre_del_protocol(const struct gre_protocol *proto, u8 version);
 
-int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
-		     bool *csum_err, __be16 proto, int nhs);
+enum skb_drop_reason
+gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
+		 bool ignore_csum_err, __be16 proto, int nhs);
 
 static inline bool netif_is_gretap(const struct net_device *dev)
 {
diff --git a/net/ipv4/gre_demux.c b/net/ipv4/gre_demux.c
index 96fd7dc6d82d..fccdaa240f46 100644
--- a/net/ipv4/gre_demux.c
+++ b/net/ipv4/gre_demux.c
@@ -56,28 +56,47 @@ int gre_del_protocol(const struct gre_protocol *proto, u8 version)
 }
 EXPORT_SYMBOL_GPL(gre_del_protocol);
 
-/* Fills in tpi and returns header length to be pulled.
- * Note that caller must use pskb_may_pull() before pulling GRE header.
+/**
+ * gre_parse_header() - parse the GRE header of a packet
+ * @skb: the packet; the GRE header starts @nhs bytes past skb->data
+ * @tpi: filled in with the fields of the header, and with the length of
+ *	the header to be pulled in tpi->hdr_len
+ * @ignore_csum_err: do not reject the header when its checksum does not
+ *	match. The ICMP error handlers set it, as they only get a part of the
+ *	original packet; the checksum is still computed and the rest of the
+ *	header is parsed.
+ * @proto: the protocol to report for a WCCP payload, ETH_P_IP or
+ *	ETH_P_IPV6
+ * @nhs: the offset of the GRE header from skb->data
+ *
+ * The caller must use pskb_may_pull() before pulling the GRE header.
+ *
+ * Return: SKB_NOT_DROPPED_YET, or the reason to drop the packet if the
+ * header is rejected.
  */
-int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
-		     bool *csum_err, __be16 proto, int nhs)
+enum skb_drop_reason
+gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
+		 bool ignore_csum_err, __be16 proto, int nhs)
 {
 	const struct gre_base_hdr *greh;
+	enum skb_drop_reason reason;
 	__be32 *options;
 	int hdr_len;
 
-	if (unlikely(!pskb_may_pull(skb, nhs + sizeof(struct gre_base_hdr))))
-		return -EINVAL;
+	reason = pskb_may_pull_reason(skb, nhs + sizeof(struct gre_base_hdr));
+	if (unlikely(reason))
+		return reason;
 
 	greh = (struct gre_base_hdr *)(skb->data + nhs);
 	if (unlikely(greh->flags & (GRE_VERSION | GRE_ROUTING)))
-		return -EINVAL;
+		return SKB_DROP_REASON_TUNNEL_INVALID_HDR;
 
 	gre_flags_to_tnl_flags(tpi->flags, greh->flags);
 	hdr_len = gre_calc_hlen(tpi->flags);
 
-	if (!pskb_may_pull(skb, nhs + hdr_len))
-		return -EINVAL;
+	reason = pskb_may_pull_reason(skb, nhs + hdr_len);
+	if (reason)
+		return reason;
 
 	greh = (struct gre_base_hdr *)(skb->data + nhs);
 	tpi->proto = greh->protocol;
@@ -87,9 +106,8 @@ int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 		if (!skb_checksum_simple_validate(skb)) {
 			skb_checksum_try_convert(skb, IPPROTO_GRE,
 						 null_compute_pseudo);
-		} else if (csum_err) {
-			*csum_err = true;
-			return -EINVAL;
+		} else if (!ignore_csum_err) {
+			return SKB_DROP_REASON_GRE_CSUM;
 		}
 
 		options++;
@@ -117,7 +135,7 @@ int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 		val = skb_header_pointer(skb, nhs + hdr_len,
 					 sizeof(_val), &_val);
 		if (!val)
-			return -EINVAL;
+			return SKB_DROP_REASON_PKT_TOO_SMALL;
 		tpi->proto = proto;
 		if ((*val & 0xF0) != 0x40)
 			hdr_len += 4;
@@ -132,29 +150,35 @@ int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 	    greh->protocol == htons(ETH_P_ERSPAN2)) {
 		struct erspan_base_hdr *ershdr;
 
-		if (!pskb_may_pull(skb, nhs + hdr_len + sizeof(*ershdr)))
-			return -EINVAL;
+		reason = pskb_may_pull_reason(skb,
+					      nhs + hdr_len + sizeof(*ershdr));
+		if (reason)
+			return reason;
 
 		ershdr = (struct erspan_base_hdr *)(skb->data + nhs + hdr_len);
 		tpi->key = cpu_to_be32(get_session_id(ershdr));
 	}
 
-	return hdr_len;
+	return SKB_NOT_DROPPED_YET;
 }
 EXPORT_SYMBOL(gre_parse_header);
 
 static int gre_rcv(struct sk_buff *skb)
 {
 	const struct gre_protocol *proto;
+	enum skb_drop_reason reason;
 	u8 ver;
 	int ret;
 
-	if (!pskb_may_pull(skb, 12))
+	reason = pskb_may_pull_reason(skb, 12);
+	if (reason)
 		goto drop;
 
 	ver = skb->data[1]&0x7f;
-	if (ver >= GREPROTO_MAX)
+	if (ver >= GREPROTO_MAX) {
+		reason = SKB_DROP_REASON_TUNNEL_INVALID_HDR;
 		goto drop;
+	}
 
 	rcu_read_lock();
 	proto = rcu_dereference(gre_proto[ver]);
@@ -167,11 +191,12 @@ static int gre_rcv(struct sk_buff *skb)
 drop_nohandler:
 	rcu_read_unlock();
 	dev_core_stats_rx_nohandler_inc(skb->dev);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, SKB_DROP_REASON_UNHANDLED_PROTO);
 	return NET_RX_DROP;
 drop:
+	reason = reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
 	dev_core_stats_rx_dropped_inc(skb->dev);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return NET_RX_DROP;
 }
 
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 3ee437fa3eae..a1b44007b1d7 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -237,8 +237,8 @@ static void gre_err(struct sk_buff *skb, u32 info)
 	const int code = icmp_hdr(skb)->code;
 	struct tnl_ptk_info tpi;
 
-	if (gre_parse_header(skb, &tpi, NULL, htons(ETH_P_IP),
-			     iph->ihl * 4) < 0)
+	if (gre_parse_header(skb, &tpi, true, htons(ETH_P_IP),
+			     iph->ihl * 4))
 		return;
 
 	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED) {
@@ -439,9 +439,8 @@ static int ipgre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
 
 static int gre_rcv(struct sk_buff *skb)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct tnl_ptk_info tpi;
-	bool csum_err = false;
-	int hdr_len;
 
 #ifdef CONFIG_NET_IPGRE_BROADCAST
 	if (ipv4_is_multicast(ip_hdr(skb)->daddr)) {
@@ -451,25 +450,26 @@ static int gre_rcv(struct sk_buff *skb)
 	}
 #endif
 
-	hdr_len = gre_parse_header(skb, &tpi, &csum_err, htons(ETH_P_IP), 0);
-	if (hdr_len < 0)
+	reason = gre_parse_header(skb, &tpi, false, htons(ETH_P_IP), 0);
+	if (reason)
 		goto drop;
 
 	if (unlikely(tpi.proto == htons(ETH_P_ERSPAN) ||
 		     tpi.proto == htons(ETH_P_ERSPAN2))) {
-		if (erspan_rcv(skb, &tpi, hdr_len) == PACKET_RCVD)
+		if (erspan_rcv(skb, &tpi, tpi.hdr_len) == PACKET_RCVD)
 			return 0;
 		goto out;
 	}
 
-	if (ipgre_rcv(skb, &tpi, hdr_len) == PACKET_RCVD)
+	if (ipgre_rcv(skb, &tpi, tpi.hdr_len) == PACKET_RCVD)
 		return 0;
 
 out:
 	icmp_send(skb, ICMP_DEST_UNREACH, ICMP_PORT_UNREACH, 0);
 drop:
+	reason = reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
 	dev_core_stats_rx_dropped_inc(skb->dev);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 0392f6ba862b..25fd290082c4 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -389,8 +389,8 @@ static int ip6gre_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	struct tnl_ptk_info tpi;
 	struct ip6_tnl *t;
 
-	if (gre_parse_header(skb, &tpi, NULL, htons(ETH_P_IPV6),
-			     offset) < 0)
+	if (gre_parse_header(skb, &tpi, true, htons(ETH_P_IPV6),
+			     offset))
 		return -EINVAL;
 
 	ipv6h = (const struct ipv6hdr *)skb->data;
@@ -566,20 +566,19 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 
 static int gre_rcv(struct sk_buff *skb)
 {
+	enum skb_drop_reason reason;
 	struct tnl_ptk_info tpi;
-	bool csum_err = false;
-	int hdr_len;
 
-	hdr_len = gre_parse_header(skb, &tpi, &csum_err, htons(ETH_P_IPV6), 0);
-	if (hdr_len < 0)
+	reason = gre_parse_header(skb, &tpi, false, htons(ETH_P_IPV6), 0);
+	if (reason)
 		goto drop;
 
-	if (iptunnel_pull_header(skb, hdr_len, tpi.proto, false))
+	if (iptunnel_pull_header(skb, tpi.hdr_len, tpi.proto, false))
 		goto drop;
 
 	if (unlikely(tpi.proto == htons(ETH_P_ERSPAN) ||
 		     tpi.proto == htons(ETH_P_ERSPAN2))) {
-		if (ip6erspan_rcv(skb, &tpi, hdr_len) == PACKET_RCVD)
+		if (ip6erspan_rcv(skb, &tpi, tpi.hdr_len) == PACKET_RCVD)
 			return 0;
 		goto out;
 	}
@@ -590,8 +589,9 @@ static int gre_rcv(struct sk_buff *skb)
 out:
 	icmpv6_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_PORT_UNREACH, 0);
 drop:
+	reason = reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
 	dev_core_stats_rx_dropped_inc(skb->dev);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
-- 
2.47.3

