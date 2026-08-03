Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E819D89E
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 01:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785719497; cv=none; b=sc/JpVO3KtfCvudQCpH09d9Co3x13D6LEwXmPYUhnnUKvelcC04O7XRxzygtbPiBPbWgQ04BdY8ebxJkBop/zPxAV1Y6fIXQimvuNb16YNd3XKPoy8HLSi5uk5tlk/CLNk/XSsxwt8OdkWDL7LlYbUzD5izpm0X0Vah212pduiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785719497; c=relaxed/simple;
	bh=wm8mob0keFoY2LhZVi3xYt5kiMlqNcqGMUBMU4ucHU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRhRy4DaSJAJKYHjFNzhq550g7Vg5XqUrD7Y/5eXm8NsCopXlajdbuvHV/Z+yWiPX1sGH2FhKa3mlmPhbhszye/iDriVaJ7nDZG1PoIOpDKKeoHZlMVKQ1YcSVHVAGmxiJFopivsrQyPlceTyqXJoSqfkN2ZKVbFq4mRpWbmQiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Cj8dTRcw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Cj8dTRcw"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso26031455ad.2
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 18:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785719495; x=1786324295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+G1bAolgU6V5zxUlfeklEuaZufwIFq/LpVrW8Hvs89U=;
        b=Cj8dTRcwBVguWlAaj99IGQt9PQG3T/N89S3F1jBuDlj3EbnmV/aznBqgMyZvyl0rvw
         eumwi9cW1MExowGfYy5X5Ru6QPVmLbIfkt6lh0urGEsg0XT2RoILlDt9bRNM8s8UUrKq
         ijofX3bb+VuVoCvZQeZujAEjI2O2wTfC2fPKr0sP1Itl1zEADZ/2uBj3y5vnxhnDSDzJ
         kM5c1OAOY7Tuglao9bS/VDEAz6zOx2Kgj7ns5GPqG2nBhMPQ5b7Ixwc6Crpw1oW5dA49
         n/QZWBpYYFtHb42/R7YbKG/+DwhpvGRWbGXqew3jqueGzKZQGCjKGXUkzD3JigfWDh8p
         t6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785719495; x=1786324295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+G1bAolgU6V5zxUlfeklEuaZufwIFq/LpVrW8Hvs89U=;
        b=jMa5lKFJRY3+F8GsHpEU2RUPKFuEGVpN5galHQOrbsEyYS7irhBK0jkX50+Sk0T1Ol
         7roDSlq8j69h+66AW1Y+ZNa9SWYiAz/z2QvG3mCxJyThyNEwSqnioMOij8xO0z2FRVSd
         LZr567GNdnfJThVzzdPpVipjg9Pa7p/TSWB6U2aRbeAB2JKDeFyayUxRPKykAdWBgB3q
         /KRtZb4OkWX1ORCqQChliOvFWNX7gXnYkZo9RCmm2+XW+4cXKITy0m0Zc68u+TToQ4qk
         tcId7dZzM1UzqgtcsZ/6D2Il7jqM52WjINUODmJuuqMgB3SYBUEiRzjlWBVY5tMqY/CL
         V8Bg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0dtRboYDagB4um4P7yQikrYzMYNnaiWGEGJ/lOhXPKfUl7GDFF3mTA4/ob4Otb4/5dmkQirE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3r6xRierdnuXxZqwL6RYw7KR8LWwBpY+us0ESg9j2V8hNS2OV
	IHDTBden4UAEVh9uaKaqJasCXj2QyQGbibjYnUrVqTCrPyeY88O3eblI2iL5/x8V2bfPogqHN9D
	t0bSmsmTORIhRXQ==
X-Gm-Gg: AR+sD13GrciUpemCTEZI0g+PNdbYAfeEANroEs1vVNRc6+4+p8fEFAMe2eGRwOgeC2D
	yYG/Z6tCfhqm6iBSbHFecynHAJbDU+5xHSo76eZ2QgzlCCBPlu1fWLG9pvVtzrBffOgg0lD2jsY
	JsSK0LiyFbs3HAykmQekxwHff5eyz2x/XLPnopsAAq9GyF208HN3ng2RZ2403vicJdHP/x6CHuO
	Xw0aMuLYh3eVd6aowKI0B15vzP0KLTEGDk4TBPFZP/2dSZR9n4QIoKY0ASyIwPmAg3luzc4j7Lj
	y+tgyEfyC9z9aM6+wBXWceBIQMHACwgw3E2jg96Y9x05pLK4LY75T7DNdrHciQKMG7X25X3yGP0
	J8gtkVyGq+wz3foAJQ5aPQ35EdxtT9A2NY6hK6K4beWsjsqaCjcTBOal/SOFYv8ZDnvLB4G09tr
	WFlqlJuPl3dsTcmv65rDKk4Dx7Ukzu364F+uwKXW/8pMnoRSs0hSeFl+Kel4O8TreNBke99IL1g
	Q==
X-Received: by 2002:a17:902:f612:b0:2cf:8131:75f3 with SMTP id d9443c01a7336-2d05219f296mr80661705ad.7.1785719495294;
        Sun, 02 Aug 2026 18:11:35 -0700 (PDT)
Received: from Roxy.localdomain ([202.8.9.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb491sm30170585ad.42.2026.08.02.18.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 18:11:34 -0700 (PDT)
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
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH nf v4 1/1] netfilter: validate L4 headers after userspace packet writes
Date: Mon,  3 Aug 2026 09:11:23 +0800
Message-ID: <399a88004d250334f85f78144f4427b586c7b424.1785718969.git.zhilinz@nebusec.ai>
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
conntrack entry, and reject IP fragments that already have such a
conntrack entry before trying to validate transport headers. Unknown L4
protocols are left to their normal protocol handlers.

For nft payload writes, reject transport-header stores that overlap TCP
doff. nft_nh_write_ok() already rejects network-header protocol changes,
so keeping doff stable prevents nft payload writes from changing the TCP
header length underneath conntrack and helper users.

Fixes: 5e35941d9901 ("[NETFILTER]: Add H.323 conntrack/NAT helper")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v4:
- Reject IP fragments that already have an attached non-template conntrack.
- v3 Link: https://lore.kernel.org/all/587830a57a593c4b621f7e8e94b2ddc73e6becb0.1785468829.git.zhilinz@nebusec.ai

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

 net/netfilter/nfnetlink_queue.c | 72 +++++++++++++++++++++++++++++++--
 net/netfilter/nft_payload.c     | 13 ++++++
 2 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index b8aaf39cb4d8e..e135ed762b5c8 100644
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
@@ -1206,9 +1213,61 @@ static bool nfqnl_validate_ipopts(const struct iphdr *iph_new,
 	return memcmp(iph_new + 1, ip_hdr(e->skb) + 1, ihl - sizeof(*iph_orig)) == 0;
 }
 
+static bool nfqnl_validate_l4(const u8 *data, unsigned int data_len,
+			      const struct nf_queue_entry *e, u8 proto,
+			      bool fragment)
+{
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+	enum ip_conntrack_info ctinfo;
+	const struct nf_conn *ct;
+
+	ct = nf_ct_get(e->skb, &ctinfo);
+	if (ct && !nf_ct_is_template(ct)) {
+		if (fragment || nf_ct_protonum(ct) != proto)
+			return false;
+	}
+#endif
+
+	if (fragment)
+		return true;
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
+	bool fragment;
 	unsigned int ihl;
 
 	if (data_len < sizeof(*iph))
@@ -1226,10 +1285,14 @@ static bool nfqnl_validate_ip4(const struct iphdr *iph, unsigned int data_len,
 	if (ntohs(iph->tot_len) != data_len)
 		return false;
 
+	fragment = iph->frag_off & htons(IP_MF | IP_OFFSET);
+
 	/* support for ipopts mangling would require
 	 * recompile + skb transport header update.
 	 */
-	return nfqnl_validate_ipopts(iph, e);
+	return nfqnl_validate_ipopts(iph, e) &&
+	       nfqnl_validate_l4((const u8 *)iph + ihl, data_len - ihl, e,
+				 iph->protocol, fragment);
 }
 
 static bool nfqnl_validate_one_exthdr(const u8 *data,
@@ -1273,6 +1336,7 @@ static bool nfqnl_validate_exthdr(const struct ipv6hdr *ip6_new,
 	const u8 *data = (const u8 *)ip6_new;
 	u8 orig_nexthdr = ip6_orig->nexthdr;
 	u8 new_nexthdr = ip6_new->nexthdr;
+	bool fragment = false;
 
 	if (new_nexthdr != orig_nexthdr)
 		return false;
@@ -1286,7 +1350,8 @@ static bool nfqnl_validate_exthdr(const struct ipv6hdr *ip6_new,
 		int hdrlen;
 
 		if (orig_nexthdr == NEXTHDR_NONE)
-			return true;
+			return nfqnl_validate_l4(data, data_len, e,
+						 new_nexthdr, fragment);
 
 		if (unlikely(exthdr_cnt++ >= IP6_MAX_EXT_HDRS_CNT))
 			return false;
@@ -1297,6 +1362,7 @@ static bool nfqnl_validate_exthdr(const struct ipv6hdr *ip6_new,
 
 		switch (orig_nexthdr) {
 		case NEXTHDR_FRAGMENT:
+			fragment = true;
 			hdrlen = sizeof(struct frag_hdr);
 			break;
 		case NEXTHDR_AUTH:
@@ -1323,7 +1389,7 @@ static bool nfqnl_validate_exthdr(const struct ipv6hdr *ip6_new,
 		data += hdrlen;
 	}
 
-	return true;
+	return nfqnl_validate_l4(data, data_len, e, new_nexthdr, fragment);
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
