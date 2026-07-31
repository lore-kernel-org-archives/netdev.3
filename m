Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB7A1A6806
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 03:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785469739; cv=none; b=WCwHYaFUFJPdF47eqzyhAiTK0C4CWMbJCRII/mgMv9ySwVwl4/bLQZlBQsEDUZbvcvX3irRfOh5aQHw/qnIq+henfH1+PEvUC02nOHqeU7L/YmU4dgtsZmC617tzxjNxa/RwkRobc3qSeENRY98NvO/dWioCA4xGx0Bfh/5BL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785469739; c=relaxed/simple;
	bh=IQ0I5VjcNpiqCKQoL2x56gOH91oOkEopEEVn9lwvXwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=psMzf2Lh29dr1b1rEbgBxWyrPmAwzpwqTHTEos+W4VC22JZ8/t3osHmcnWbZBI+B4JVv4FTvNCChy3ASY7GNchkKkyWLTdud3Ii13AT7/RZzS0y2ZIfT9tLTX3CZGAPBwTu+AInO4tYHVe66aD1c1EaTffHT44qN7DCRC5tk4VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=QKD3e1+4; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="QKD3e1+4"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-52b4e988c77so69621cf.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 20:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785469737; x=1786074537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6a/qznT3e9ePhKTa4f6oZcZAWMKMKr+HbsCDrncY3d8=;
        b=QKD3e1+4GvbL2otOhatvRTemVsdCeqAZ80FA4/wE5spiaZBF/apPrL6yO16uXaEUDF
         6fiGrjnkr+k7CjXIe4gOP3UMqaCnXEUSyO6As/pDJ55CZFDZhyXQxijqrVlNch5j2j97
         KoOdICZpx6PdkFshHduewh5QVM2LSrHbsN0Y42pfv3w9/Wyz9labS/q97jLrWioJpZL2
         97GSbQSPx6aHVxJWWvV5clgLLxugePOQAPrHEZTkNJ9Puu+jTdlvbqSBn0S+9X3R90Qu
         ozKPsGfY1tEV3XHjOw5EFBcaREfWuBgwNz5DWZMybLR5+ymvUUUVWur01UGDFD8hr3nc
         1KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785469737; x=1786074537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6a/qznT3e9ePhKTa4f6oZcZAWMKMKr+HbsCDrncY3d8=;
        b=aaDe1tEbiykaSh5pBdmJGKXFjZ0BSnuWwFg7+5Z8xSwPrRD6UfOvHQaqzczO+IXLIM
         wV4ThHZGIfhGQgdQ8+I0tPb1iYCZWwM/E7+iWVClMrRKT4kn2aFjvgxBNHiLhnJBsB1g
         FkU2GfRRK2L7N4ZT4vQMuns5EYyMv+WoEWXqkWj7PNu9RMl9M0jR8ZmmyX4kNH9zSwz8
         2FEoMS0nU23tHoucD5AG4m9QH9HuRpe9NaCWkdNtMYiyfbv4NxlUm+RNICHGYmd14uon
         zbdG+PWU7abDkxLVYRFUoWIMLg6QwfQ0toinD3syvVtjJpx8s9y2YBXQoiqIhv+Oejkb
         L51g==
X-Forwarded-Encrypted: i=1; AHgh+RqkJktJlIfsOZL6ed8BIWUv/Dl4RFPCGfYQopWPpwxULvr/RLzQ7FMMlkhNvp37WayhHBMfT6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuLgsCjFaUYsioG5Chxa5DhRC2CDtf9n9xHdQvnUD1i1SqjgEY
	ZylEu4Y4yYnNyhqfQU4sjV8QJYJQJ99VqeaNKU3HrglaS+qhXpBzxnk3J80ALxI1yQmtIldBKIq
	LcsfJXuqseps=
X-Gm-Gg: AR+sD11v7zMgr4AogQaBrk3ffPDPJI7SlHC7ZL2DDI2MkaDUtPPvieAYO52Q10GBDNK
	GN8TSpd2C4jYskITCtT3hqIlDL+KxaduvetqXh4t55PPavhrRooHDkPhKvBKRmXfwr30jjLrtqL
	6jAPrVzDoVo3mTj39JkbniByaivA+o5Q3CzaF6PPt+zu2pau8ScEmdHcJ+kCU8C49gFXGWUAQvr
	/11wenOvfVfckrDl8Mu+TglERrw+ove1PkZG1uDw3Xd0tCZM9i8YxJ8IGFUljuDyba9ZDPuE9FN
	XTDo6Vk0oRrPCRRFkUvOkhjNEgnsIk5p9o476Tfm+flt68w34MpCNp6JSB7U4cehttjUnRkW5cM
	gEfXdtZol1cycb+q9awfe9+vsTyByxcptAYRIQjyWkLUI7sUtRfO7w7BYOLBJWhyTeKNRb4z2TN
	Q/qlx7WulE0GOPpLHq62MhQJ4IIWzWCLvtJTyx5Yfr5w9bdxTlff5dkyi7DxiKJB3KD/yffJWaE
	6Jv
X-Received: by 2002:ac8:610e:0:b0:527:f5af:9e7 with SMTP id d75a77b69052e-52b4b0cf824mr4916991cf.51.1785469736632;
        Thu, 30 Jul 2026 20:48:56 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.58])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4ebeb909sm266761cf.29.2026.07.30.20.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 20:48:54 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: pablo@netfilter.org,
	fw@strlen.de,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kaber@trash.net,
	zhaojignmin@hotmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH nf v3 1/1] netfilter: validate L4 headers after userspace packet writes
Date: Fri, 31 Jul 2026 11:48:42 +0800
Message-ID: <587830a57a593c4b621f7e8e94b2ddc73e6becb0.1785468829.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NFQUEUE and nft_payload can hand packet data modified by userspace back
to the stack. Recent restrictions keep link and network headers stable,
but transport header fields can still be changed.

A packet can therefore keep the same network header and conntrack entry
while changing the transport header layout. For TCP, increasing doff can
make later helper or NAT code use a different transport-header base than
the parser used, and can make offsets point past skb->tail.

Extend NFQUEUE payload validation to check the final L4 protocol and
known base headers after IPv4 options or IPv6 extension headers. Reject
packets whose L4 protocol no longer matches an attached non-template
conntrack entry, and validate TCP data offset before reinjection. Unknown
L4 protocols are left to their normal protocol handlers.

For nft payload writes, reject transport-header stores that overlap TCP
doff. nft_nh_write_ok() already rejects network-header protocol changes,
so keeping doff stable prevents nft payload writes from changing the TCP
header length underneath conntrack and helper users.

Fixes: 5e35941d9901 ("[NETFILTER]: Add H.323 conntrack/NAT helper")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v3:
- Allow unknown L4 protocols in NFQUEUE payload validation.
- Add explicit AH and ESP minimum base-header validation.
- v2 Link: https://lore.kernel.org/all/f0efaa7d67a580488fc5e32a09683c992db35742.1785392716.git.zhilinz@nebusec.ai

changes in v2:
- Replace the H.323-specific NAT/helper-only fix with generic validation
  for userspace packet writes.
- Validate NFQUEUE payload replacements after IPv4 option and IPv6
  extension-header validation, including TCP data offset and attached
  non-template conntrack L4 protocol consistency.
- Reject nft_payload transport-header writes that overlap TCP doff.
- v1 Link: https://lore.kernel.org/all/68faab5bf406aad612233e76994c649fbc547b8d.1785133455.git.zhilinz@nebusec.ai

 net/netfilter/nfnetlink_queue.c | 61 +++++++++++++++++++++++++++++++--
 net/netfilter/nft_payload.c     | 13 +++++++
 2 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index b8aaf39cb4d8e..5c29a4428b6eb 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -28,10 +28,17 @@
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_queue.h>
 #include <linux/netfilter/nf_conntrack_common.h>
+#include <linux/icmp.h>
+#include <linux/icmpv6.h>
+#include <linux/ip.h>
 #include <linux/list.h>
+#include <linux/sctp.h>
 #include <linux/cgroup-defs.h>
 #include <linux/rhashtable.h>
 #include <linux/jhash.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <net/gre.h>
 #include <net/gso.h>
 #include <net/sock.h>
 #include <net/tcp_states.h>
@@ -1206,6 +1213,51 @@ static bool nfqnl_validate_ipopts(const struct iphdr *iph_new,
 	return memcmp(iph_new + 1, ip_hdr(e->skb) + 1, ihl - sizeof(*iph_orig)) == 0;
 }
 
+static bool nfqnl_validate_l4(const u8 *data, unsigned int data_len,
+			      const struct nf_queue_entry *e, u8 proto)
+{
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+	enum ip_conntrack_info ctinfo;
+	const struct nf_conn *ct;
+
+	ct = nf_ct_get(e->skb, &ctinfo);
+	if (ct && !nf_ct_is_template(ct) && nf_ct_protonum(ct) != proto)
+		return false;
+#endif
+
+	switch (proto) {
+	case IPPROTO_TCP: {
+		const struct tcphdr *th = (const struct tcphdr *)data;
+		unsigned int thlen;
+
+		if (data_len < sizeof(*th))
+			return false;
+
+		thlen = __tcp_hdrlen(th);
+		if (thlen < sizeof(*th) || data_len < thlen)
+			return false;
+
+		return true;
+	}
+	case IPPROTO_UDP:
+		return data_len >= sizeof(struct udphdr);
+	case IPPROTO_ICMP:
+		return data_len >= sizeof(struct icmphdr);
+	case IPPROTO_ICMPV6:
+		return data_len >= sizeof(struct icmp6hdr);
+	case IPPROTO_SCTP:
+		return data_len >= sizeof(struct sctphdr);
+	case IPPROTO_GRE:
+		return data_len >= sizeof(struct gre_base_hdr);
+	case IPPROTO_AH:
+		return data_len >= sizeof(struct ip_auth_hdr);
+	case IPPROTO_ESP:
+		return data_len >= sizeof(struct ip_esp_hdr);
+	}
+
+	return true;
+}
+
 static bool nfqnl_validate_ip4(const struct iphdr *iph, unsigned int data_len,
 			       const struct nf_queue_entry *e)
 {
@@ -1229,7 +1281,9 @@ static bool nfqnl_validate_ip4(const struct iphdr *iph, unsigned int data_len,
 	/* support for ipopts mangling would require
 	 * recompile + skb transport header update.
 	 */
-	return nfqnl_validate_ipopts(iph, e);
+	return nfqnl_validate_ipopts(iph, e) &&
+	       nfqnl_validate_l4((const u8 *)iph + ihl, data_len - ihl, e,
+				 iph->protocol);
 }
 
 static bool nfqnl_validate_one_exthdr(const u8 *data,
@@ -1286,7 +1340,8 @@ static bool nfqnl_validate_exthdr(const struct ipv6hdr *ip6_new,
 		int hdrlen;
 
 		if (orig_nexthdr == NEXTHDR_NONE)
-			return true;
+			return nfqnl_validate_l4(data, data_len, e,
+						 new_nexthdr);
 
 		if (unlikely(exthdr_cnt++ >= IP6_MAX_EXT_HDRS_CNT))
 			return false;
@@ -1323,7 +1378,7 @@ static bool nfqnl_validate_exthdr(const struct ipv6hdr *ip6_new,
 		data += hdrlen;
 	}
 
-	return true;
+	return nfqnl_validate_l4(data, data_len, e, new_nexthdr);
 }
 
 static bool nfqnl_validate_ip6(const struct ipv6hdr *ip6, unsigned int data_len,
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 8a4472fd77d9f..e315d35f73d4a 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -1067,6 +1067,17 @@ static bool nft_payload_csum_write_ok(const struct nft_pktinfo *pkt,
 	return false;
 }
 
+static bool nft_th_write_ok(const struct nft_pktinfo *pkt,
+			    const struct nft_payload_set *priv)
+{
+	unsigned int doff = offsetof(struct tcphdr, ack_seq) + sizeof(__be32);
+
+	if (pkt->tprot != IPPROTO_TCP)
+		return true;
+
+	return priv->offset > doff || priv->offset + priv->len <= doff;
+}
+
 static void nft_payload_set_eval(const struct nft_expr *expr,
 				 struct nft_regs *regs,
 				 const struct nft_pktinfo *pkt)
@@ -1105,6 +1116,8 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
 	case NFT_PAYLOAD_TRANSPORT_HEADER:
 		if (!(pkt->flags & NFT_PKTINFO_L4PROTO) || pkt->fragoff)
 			goto err;
+		if (!nft_th_write_ok(pkt, priv))
+			goto err;
 		offset = nft_thoff(pkt);
 		break;
 	case NFT_PAYLOAD_INNER_HEADER:
-- 
2.43.0
