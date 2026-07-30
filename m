Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1C3B9D81
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785396645; cv=none; b=IDBVc+Sms99DGJF1wa19yev1T8kr18Fq9UOcl6yCo55Flf3qoO0VvSE5p/sre5X6nwTeaBju2UCV4r4SclRgIWBOnEuCHRGVXW2Q4FNIzo+MfRCnDcVArnN1bmlp/+Brh7b1boZid6UYz759H3hDRxp70oLUtTj3ErHYTcU55Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785396645; c=relaxed/simple;
	bh=GqQpAwlYaIZs3wCFyDpIWB/NE+UztWrFJBL/6ix0W3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1cNam/DC+ZXNKSoFw3WD1RecNvQatiGdHti/E+xF2A0YGwA8fW8iWO7XWOS2ECV72R9EbmOr+lXftOMa/09xl+NLLllNjbTVRbLUgTGxIr2kkk48ckYfoWeV54vs15043MGDOKiHYtpA3RFUYYB3MDAkiYNLoeDPhYpv6OeniU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=lytQPWeU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="lytQPWeU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ceb096e675so23095335ad.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 00:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785396642; x=1786001442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fbg4G6uDy6aVTLr4SsEE/5bJimkgIjt/OIwOsBCmh8Q=;
        b=lytQPWeUn10Zqu3wFmAbdhXLMEoT+qClCTYKFsaIRjTpY9pb12nApWsZC7jXR19TMB
         W8YSpHfqNBnZO+8MzZVxfDcDPs/4TlpjD4+6fWrULdnoHrC/YjUhf6UpoZeTga1OgGyl
         r26rGT8Fyu3CA2Xazhwv8pLMOqR1/S8qVZtIOwYJFheQAn4pSKkmECqLm9dj86sjE0zK
         +ZjKYhaksudgzkYu9dPKVAzQXpVLLHNFNNwn425lnf8uJj+wW9MrC/rRCwscfQpB91M3
         VuNpWHoC7CyjgXX5Ji/G4zQeDcoTdcyz27Ap8rE/BTFZscnBDIl47eaLKL+P1LWENLmu
         TKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785396642; x=1786001442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fbg4G6uDy6aVTLr4SsEE/5bJimkgIjt/OIwOsBCmh8Q=;
        b=DfTBEDlIzJbwartgPHjsPDr6KdCUUIwH0Oo6YsxFE3ucOjppci7yv7FGf6FwRfrKAh
         WEnSTVI/CvbsWaQaNKJvSqSVQ1bXWpiHeEwStJmKCJ7V7rvLxHwwvygEOZgq0W1ly14C
         2vo7fjUfd73/fIAaUDSdV7sgB30kMC1VIPe1hst5/c26ugsCG7ULyUS1CzgOI4eLF5No
         na+kfmtC9L8tH/BN9mmEsh6jjJddH656Uuh44nc+3ta8TZYx+L90BeH09AjEAV8444hp
         fFNFxcEYgpvZftreMmvD9Rtj+97h5edjM6LTYMRiQPc7AGfzUJZO9CT8CJkdvgqf1byG
         iZeg==
X-Forwarded-Encrypted: i=1; AHgh+RpzkZ8H09/p6bDoJu+myU/2pwO4IWbZFL2wNAt2uFC1r6uo6EXXW492LyvZN8B+r3PHpwuAbc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN9zbKFJ3NqzPucoHAELWBCLVSV0MoYdnHMBwSiMV3Ad4FZggB
	+M30cKX21KumE4pDzlaFppbCaLK2yxln7gKN/IVGe2U034wHMYKONL32/DFRgeLLLIDA
X-Gm-Gg: AR+sD13zPRDqR4pR5dfRN4n9xx37nWaXH5LGeZVEupgDI7vTZwgSOZQhnBDMMDGjRpG
	0VDBOHK2iqeVGWA48DxtGgognl+gZ/8xX6adCfXpv04iBQ1XBcgNwyvx3HjmbrZYPPFUxgxet/S
	6M3BVL2tPILZCSyDXRGQGgYQataNGvK+GwMomIpxmo9iDI7R0YKqJKrkdZVYgiY9JY3CsZHwBFI
	tk/oA4ARJsSOoKgXz2GdShh4PMLz+tN3BjEqbimSO9cZgZc0jUzCFW3N2bN+iTrVKGZ+qSokhrC
	xXzGGxRSJCyMx6nLA6Ovta2/KjLiz234bxgUKeClY5UK5LwviLuaoVGNBZ1JSzt2ANH6Tx16JSU
	xL60Qeb4plU9pdE6/j4gm4kxzPGYW4/TXbWjz6snWA4x5iE7LUf+I9iB7/6xwpeMXA+kOQgYpTA
	dLrcOsFo1TMAe8KXA2CHTGH24SrFv8wTVtFOoaecPf3L24Qd4Te4JI37RxAIxEfO+3fT8riQcgk
	elK
X-Received: by 2002:a17:903:388c:b0:2ce:d5e4:2fcf with SMTP id d9443c01a7336-2d035cfb3a9mr15269515ad.42.1785396642130;
        Thu, 30 Jul 2026 00:30:42 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a7e333sm22236325ad.36.2026.07.30.00.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:30:41 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: fw@strlen.de,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: pablo@netfilter.org,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kaber@trash.net,
	zhaojignmin@hotmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH nf v2 1/1] netfilter: validate L4 headers after userspace packet writes
Date: Thu, 30 Jul 2026 15:30:26 +0800
Message-ID: <f0efaa7d67a580488fc5e32a09683c992db35742.1785392716.git.zhilinz@nebusec.ai>
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
but the transport header can still be changed.

A packet can therefore keep the same network header and conntrack entry
while changing the transport header layout. For TCP, increasing doff can
make later helper or NAT code use a different transport-header base than
the parser used, and can make offsets point past skb->tail.

Extend NFQUEUE payload validation to check the final L4 protocol and base
header after IPv4 options or IPv6 extension headers. Reject packets whose
L4 protocol no longer matches an attached non-template conntrack entry,
reject unknown L4 protocols for writable payload replacement, and
validate TCP data offset before reinjection.

For nft payload writes, reject transport-header stores that overlap TCP
doff. nft_nh_write_ok() already rejects network-header protocol changes,
so keeping doff stable prevents nft payload writes from changing the TCP
header length underneath conntrack and helper users.

Fixes: 5e35941d9901 ("[NETFILTER]: Add H.323 conntrack/NAT helper")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v2:
- Replace the H.323-specific NAT/helper-only fix with generic validation
  for userspace packet writes.
- Validate NFQUEUE payload replacements after IPv4 option and IPv6
  extension-header validation, including TCP data offset and attached
  non-template conntrack L4 protocol consistency.
- Reject nft_payload transport-header writes that overlap TCP doff.
- v1 Link: https://lore.kernel.org/all/68faab5bf406aad612233e76994c649fbc547b8d.1785133455.git.zhilinz@nebusec.ai

 net/netfilter/nfnetlink_queue.c | 58 +++++++++++++++++++++++++++++++--
 net/netfilter/nft_payload.c     | 13 ++++++++
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index b8aaf39cb4d8e..562b7bf6c8777 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -28,10 +28,16 @@
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nfnetlink_queue.h>
 #include <linux/netfilter/nf_conntrack_common.h>
+#include <linux/icmp.h>
+#include <linux/icmpv6.h>
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
@@ -1192,6 +1198,49 @@ nfqnl_enqueue_packet(struct nf_queue_entry *entry, unsigned int queuenum)
 	return err;
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
+	case IPPROTO_NONE:
+		return true;
+	}
+
+	return false;
+}
+
 static bool nfqnl_validate_ipopts(const struct iphdr *iph_new,
 				  const struct nf_queue_entry *e)
 {
@@ -1229,7 +1278,9 @@ static bool nfqnl_validate_ip4(const struct iphdr *iph, unsigned int data_len,
 	/* support for ipopts mangling would require
 	 * recompile + skb transport header update.
 	 */
-	return nfqnl_validate_ipopts(iph, e);
+	return nfqnl_validate_ipopts(iph, e) &&
+	       nfqnl_validate_l4((const u8 *)iph + ihl, data_len - ihl, e,
+				 iph->protocol);
 }
 
 static bool nfqnl_validate_one_exthdr(const u8 *data,
@@ -1286,7 +1337,8 @@ static bool nfqnl_validate_exthdr(const struct ipv6hdr *ip6_new,
 		int hdrlen;
 
 		if (orig_nexthdr == NEXTHDR_NONE)
-			return true;
+			return nfqnl_validate_l4(data, data_len, e,
+						 new_nexthdr);
 
 		if (unlikely(exthdr_cnt++ >= IP6_MAX_EXT_HDRS_CNT))
 			return false;
@@ -1323,7 +1375,7 @@ static bool nfqnl_validate_exthdr(const struct ipv6hdr *ip6_new,
 		data += hdrlen;
 	}
 
-	return true;
+	return nfqnl_validate_l4(data, data_len, e, new_nexthdr);
 }
 
 static bool nfqnl_validate_ip6(const struct ipv6hdr *ip6, unsigned int data_len,
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 391539a1ceaa7..63cf3b4f7420d 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -1077,6 +1077,17 @@ static bool nft_payload_csum_write_ok(const struct nft_pktinfo *pkt,
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
@@ -1115,6 +1126,8 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
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
