Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342031;
	b=IRWbe2KKZK92cS5qu0omxxInlI2Mm62Hb/ZmKZxEuDZ6vrBLqLc6iRJaYzgSb0bYPtfw
	 ie0qDK7wlSNxx/Xs4RyNPdo6zbYm8ZjFWf/jxojxJwE+T+Su4zjYw/Uljt0cgiadVKSIP
	 LnWF38dAc3i9Jt+QdzF/5Gq9lYRNXB9rG+QL3DNbMhDTVbgC/uF/7PSNBgxhU4BglFLlg
	 /Dk2oU6GhQvnoqCXlWWO6wBwWb2NrRwWnNQEca6samXglBO7rlbwM9FSoASYiwjayrTg2
	 MxKFPL1wqhRuaD/jvBJk+Tm3jmHRsXehnuy3OMPhhYQe3+b07P80vnbp/6KrA1Z/Vbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6epOf5Wc/dfovitCOJcCbxrBGTMahq0YjdxuieLJ4Lw=;
	b=RQHtVUAXvIFHX0/seHb8dJOMZ/QMPZO2cUQhrRohqynQal8pwwXmk1s0FuQmsat2GT5b
	 dqFP3oRA6TalPhbMSDHKKeN2LprNvy2wlb8fAWoGh501sx+ZWmskKH4BFTOk8O1e/XVl6
	 C4UmGihMbfyCsYdDQx+j59WntcYhthFb7RriUBeesNhwuyHA1LWe5EzGSvknNgw53EKat
	 skgLOc59LjVgX7O3z+nLdhWDhpcbCjAKwsAzXIcdmkdX8OJSo3aWtnAXkS3HvlNyg5UsJ
	 Q4Qk5N1CtxK68Kl2yaNK3R/Q2TTmG/d7ylmjiDTm/poxsfUubE5U53Fubf88BpjZSAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W8usBN6k;
	arc=none smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6552560A2618
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6552560A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W8usBN6k
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ab4891fc73so19168931fa.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794342029; x=1794946829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6epOf5Wc/dfovitCOJcCbxrBGTMahq0YjdxuieLJ4Lw=;
        b=W8usBN6ks1TPmIg9BI0trs6b/7aQdcMqV1utEPMxpJpAlAiUrFgx6Xpo90DGwEh1mV
         F5fuQhbAoQUj9bpl10VV4Cnv+IhzIIquUTYZfduyzfLM2Q4chXD0Tak54Kv5rZivZjTa
         LPUs5EIRUwz0fWlZdhhRuZcBmpLamBCOwlM0RUW52szW0+98pau4IxKK4Cr8FTb8odRS
         Y4+2GEdkHX0D5D8xpEzRZ8lfheWasgZVnHC9yXJTMgdi5Q7gYC8h4coLUftCs8NmdxNX
         aHUmNXfbKhiZSarRUShq96OJ13frCCeqPsrM//3qFdVKgPdT4LW0bqcEOstmKjqd7Epg
         osMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342029; x=1794946829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6epOf5Wc/dfovitCOJcCbxrBGTMahq0YjdxuieLJ4Lw=;
        b=XQfQfREdA8jv44dczqXKZGwj0UL4cNaWXkBOTJRsIK5nhVyVmX3OHf6Wdh5uYD1jsp
         cCCLRn3f45NBhZ9RIGDr+LhfaqaOMJD5y02ZJBJKb6vonPPnwEa5xZ0shRjS0VpIghPl
         pJZWOxqNgtFiNbnWnEGaGl8rgt5AgmPUpspJkE3GviOOtW3nRXFn+fBUYI12fhWZ6wO9
         K8/jvZ7hq3CfaJeYiKdFN8YG0nkA+IT16oKUFmavEYjJ12/QT7iWj4izcN0f3UbTzbup
         FtcBBLG8EC1ndTjlUT8hHq6KHaqXK4NzAPy6jzPWxUyO2D14uvp/jxoJMXp01XNuJ/On
         hODw==
X-Gm-Message-State: APuU4Z9rc+KQT1Gxn2KH3VsW2+vzExSkOhAGHLgdJVq8JGM6Rgsr/Z58
	cLUCEn8k7nBlf07FGyBYp/sTckqd6c1vle9snmb0nGGErioqIf/0fAqzsjKpdxJD0IPc3Q==
X-Gm-Gg: AYBFou2IGYtFzUuqqDxC6Qt0aDpvulmKhzR1VzSpDLfNEO02CDD1XP0LYOPrQj8wbmq
	NZoKRL768k3ZdmBddAZ00GurGVM5dEVSazG6iLkFDfqSg/KzJMi3tO2NqHRh2STaehuuPPK4XoM
	WZiw+PHFV8Fcar7Knr7gweXJPxyn++oZ0lOnxrSoXQmdaqkhIvD5FvpUn6pEXAjKoRs50JG9IJK
	+bhHH0f8XHiyK+DFbTjMr88QuI3EB1srWHqGpLAjK6f7yNuScGv3GglAEed/BWXYzumQjw4YeTb
	65goFgwjVQqTNgxF+OS73qpzheGpm7sq7eDm4K0XLoiShLw8yhWMmLlJF/FMfg+Rtr4qQh1gqQa
	ZyxR6zfGTPIhbIbgswF3UacEK/dCfheq50o1oDZfsL/tzz/62kPzUBDuBOOWuSvUjYNJzgMCyX5
	o1VhB3mdIUc6kW5IRQsX4aS+PSHMwbCBXjyO5YuTzX1kp7aKDCemd2VxsCrnMQ8SRwGsurxHz4G
	q87Jxeh0lVWKfLNj9vRynD7F6bFO06U7smJec1vkxLNY+mi/JHTUR6X2H5YUIJxT3ZkYszjNNkH
	x3UwK+MtcKjVTxnvlHbSP7hN+YOSdt2rkVjuwXxmZ5BKN4I/G2zOp3DAG5J30Jx+T0QAdiFtwn+
	duhwDZLWOqyIM7oQ4
X-Received: by 2002:a05:651c:31d7:b0:3a3:3170:5420 with SMTP id 38308e7fff4ca-3ae0955c97emr8444961fa.3.1794342028493;
        Tue, 10 Nov 2026 12:20:28 -0800 (PST)
Received: from dau-home-pc.megasoftware.org ([95.139.137.59])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae090ea59esm5945401fa.0.2026.11.10.12.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 12:20:27 -0800 (PST)
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
Subject: [PATCH net-next v6 3/8] gre: make gre_parse_header() report a drop reason
Date: Tue, 10 Nov 2026 23:20:16 +0300
Message-ID: <20261110202021.821224-4-littlesmilingcloud@gmail.com>
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
   WCCPv1 from WCCPv2 is read with skb_header_pointer() instead. It does
   not say why it failed, and a short packet is the usual cause, so that
   check returns SKB_DROP_REASON_PKT_TOO_SMALL.

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
patches convert them. Until then, gre_rcv() of ip_gre and ip6_gre sets
the reason to SKB_DROP_REASON_NOT_SPECIFIED once the header is parsed,
as the handlers do not return one yet.

The reason follows the rule of ip_tunnel_rcv(). gre_rcv() of the demux
and of ip6_gre sets it in its first statement, so it is not initialized
there. ip_gre's gre_rcv() starts with the looped back multicast check,
so it initializes the reason, and that check, which drops before the
header is parsed, sets it to SKB_DROP_REASON_NOT_SPECIFIED explicitly.

Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/dropreason-core.h |  4 +++
 include/net/gre.h             |  5 +--
 net/ipv4/gre_demux.c          | 64 ++++++++++++++++++++++++-----------
 net/ipv4/ip_gre.c             | 23 +++++++------
 net/ipv6/ip6_gre.c            | 19 ++++++-----
 5 files changed, 74 insertions(+), 41 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 5c0d9b0211bc..de2796184e06 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -130,6 +130,7 @@
 	FN(RECURSION_LIMIT)		\
 	FN(TUNNEL_OPT_MISMATCH)		\
 	FN(TUNNEL_OLD_SEQ)		\
+	FN(GRE_CSUM)			\
 	FNe(MAX)
 
 /**
@@ -537,6 +538,7 @@ enum skb_drop_reason {
 	 * @SKB_DROP_REASON_TUNNEL_INVALID_HDR: tunnel header is invalid. E.g.:
 	 * 1) VXLAN reserved fields are not zero
 	 * 2) VXLAN "I" flag is not set
+	 * 3) GRE version is not supported or the routing bit is set
 	 */
 	SKB_DROP_REASON_TUNNEL_INVALID_HDR,
 	/**
@@ -629,6 +631,8 @@ enum skb_drop_reason {
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
index 96fd7dc6d82d..6c1d1fe914b8 100644
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
@@ -167,11 +191,11 @@ static int gre_rcv(struct sk_buff *skb)
 drop_nohandler:
 	rcu_read_unlock();
 	dev_core_stats_rx_nohandler_inc(skb->dev);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, SKB_DROP_REASON_UNHANDLED_PROTO);
 	return NET_RX_DROP;
 drop:
 	dev_core_stats_rx_dropped_inc(skb->dev);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return NET_RX_DROP;
 }
 
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 5485586fa0e6..10f1a5a2fd91 100644
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
@@ -439,37 +439,40 @@ static int ipgre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
 
 static int gre_rcv(struct sk_buff *skb)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct tnl_ptk_info tpi;
-	bool csum_err = false;
-	int hdr_len;
 
 #ifdef CONFIG_NET_IPGRE_BROADCAST
 	if (ipv4_is_multicast(ip_hdr(skb)->daddr)) {
 		/* Looped back packet, drop it! */
-		if (rt_is_output_route(skb_rtable(skb)))
+		if (rt_is_output_route(skb_rtable(skb))) {
+			reason = SKB_DROP_REASON_NOT_SPECIFIED;
 			goto drop;
+		}
 	}
 #endif
 
-	hdr_len = gre_parse_header(skb, &tpi, &csum_err, htons(ETH_P_IP), 0);
-	if (hdr_len < 0)
+	reason = gre_parse_header(skb, &tpi, false, htons(ETH_P_IP), 0);
+	if (reason)
 		goto drop;
 
+	reason = SKB_DROP_REASON_NOT_SPECIFIED;
+
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
 	dev_core_stats_rx_dropped_inc(skb->dev);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index b5d6ed8f0c36..75665a576657 100644
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
@@ -566,20 +566,21 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 
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
+	reason = SKB_DROP_REASON_NOT_SPECIFIED;
+
+	if (iptunnel_pull_header(skb, tpi.hdr_len, tpi.proto, false))
 		goto drop;
 
 	if (unlikely(tpi.proto == htons(ETH_P_ERSPAN) ||
 		     tpi.proto == htons(ETH_P_ERSPAN2))) {
-		if (ip6erspan_rcv(skb, &tpi, hdr_len) == PACKET_RCVD)
+		if (ip6erspan_rcv(skb, &tpi, tpi.hdr_len) == PACKET_RCVD)
 			return 0;
 		goto out;
 	}
@@ -591,7 +592,7 @@ static int gre_rcv(struct sk_buff *skb)
 	icmpv6_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_PORT_UNREACH, 0);
 drop:
 	dev_core_stats_rx_dropped_inc(skb->dev);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
-- 
2.47.3

