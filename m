Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768201;
	b=phAcwr+1K3e68W/vMFHsSlZA/hMe0j/2DCt8fKLC51NMm7iLRjQ8s8U2jCPlyVIo27Xn
	 PhnplqPPSWlUG7VLR7WQMOOtNZw/RzE7dZ7KEV1N1vJz9QBHyDjz2EdNB1WJqTWOafOaq
	 So7hciK9b+jwKyWuHTUrUEBKj4W3ZYCp+VgV8SrRbOUSHRe9ZB+hxPtP3YQ4FkRpoe/7G
	 l2yUHonIv5S9cGbOICGnNwtEVqXiwxN8++Z5qZGwInFxhU8JhWJIpjOiBgxr4wAqBUwnV
	 e9cMzpyZV46x+Cqr+tTqFFRJPpFcZg7w9Sx1eD90lYE/qj3xjsUtnQGbhzCNbNUXm6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768201;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Mailer:X-Mutt-Fcc;
	bh=dRrmIJ8flnOPg8TSfGXbT6RnrbuAF8nRL7q/iyIRIBU=;
	b=l05YL19u2tKUe3YQj7gtiJVoD+kzY/PqC6/3Kx/fSh2Srcs9/RArylgxL9pbPqvidfmf
	 rZsL0hx5OnVtblAfVhSx5lbfyJPbhYV5x7blpjtabx4DsViJuBELvgL29EsbNNAQCRQlo
	 BihrDD60Bk0n1ImL2GkeqJMDiginX0H/eua8ysWNNCEbnduLTu5oihDYQkTtVRTxbFs+A
	 Fi0sCFtHwFElM93lWVhLLXttot/fqM5rDqeyZSK6RI/EdRo4eVmpyu5gVSu/zPFs/S+Qz
	 cc1ieL1UbpfSKbFDSg82Knx6R4iJdWhxyWGDD30eqNvqnkmQEAkGZRl7icic1QWoc8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=doKtofeA;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GxFKSBP0;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ABC60A2638
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00ABC60A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=doKtofeA;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GxFKSBP0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792768200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRrmIJ8flnOPg8TSfGXbT6RnrbuAF8nRL7q/iyIRIBU=;
	b=doKtofeAPGXwa6SdO2LteODHLErvl4zr0YrhwVYibLae07o1k7FLo/J+CNroiG4k7SdZte
	Lack/ATYm4dKNLm59aHxYNGt22tYXa68smPGgieJ8Vci1M4jFtZVvcsuhJLXqC2LVr/vpt
	E30phMWTkqFNeBaXQX6DtOjPxrxg5Nk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-TFD5PpnuO_mQgpS84Bjn-Q-1; Fri, 23 Oct 2026 11:09:52 -0400
X-MC-Unique: TFD5PpnuO_mQgpS84Bjn-Q-1
X-Mimecast-MFC-AGG-ID: TFD5PpnuO_mQgpS84Bjn-Q_1792768191
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1fa972b4fso5120625e9.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792768191; x=1793372991; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dRrmIJ8flnOPg8TSfGXbT6RnrbuAF8nRL7q/iyIRIBU=;
        b=GxFKSBP0uQAqTptChLomOrflkH+I4EQM9lT1axMdLOk1cy5KbS+F7ghBeVHWlJRuS6
         NWEAKmGSorxZ4/N4HvFg2ansn9PVgFeCdFhPywiMQUEZoW5B64nrq9vELIbVGURiLKxn
         N/7SZciMW7QU+wnOf8rSBCXyh554hpq1E+M3GUmx/W64O4CPyhKQ1ivNcYYJ+9fYMOyV
         YchTDo1o+U+zPTm7CHubap65yEGpK51bkxAEMKyCmLVyy2+PAe1Dxaq4ZruO70YHZW/I
         I/bzW2JtZ5gD0Rk4jHTiImE15klCelO7azO4EZq/e1Ps0vAWgsqgB+ZY4qduOoNQCzJ9
         IPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768191; x=1793372991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dRrmIJ8flnOPg8TSfGXbT6RnrbuAF8nRL7q/iyIRIBU=;
        b=HOXwUA9FUE5NDN5n5jU3URfGcSgEnDoQukktnU920/ishQysOGMJET3+marJFA/OhT
         BbHKM8xhG9bvGoAdiV5Y3DSFpVswAIABbrBtMrm6Y+Pm/W78V/UDobwrAaWAzvnPbf7Z
         Nr/4HE3y1Yb62tRXFGHZeC8oQ3K5A6774CFkidjtOnwBjKAuZ1PmcKPssbpX/j9jdfIS
         /A7+AoYBDdu4eYVUauE0KG54KOoiDxgLKOJpq6k7JvT289OycenBhFAdAwPM93/TevN7
         Pe78IYQF3YcrRro57OwGpzX2C0limQbcTGwlrRQuRQZm+reQHhpbgeAArrzYIRglTKc9
         QUhw==
X-Forwarded-Encrypted: i=1; AKwUvBws3qprTtT/gEIoWqeZTA9OzzwVhupLs61uWyEPh1uuGkltHcZGzmRwhCY/ExMTw8oncW9mCQg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOtF/SpJHJrdTu0Znj10YWmyILL2C+fE8RfRLJHK5pmXFezTRv
	yHOkZAl2cJZqewotLGQl2kTg8P8eYL10imIr8uS8BuA97qRy/1oe2ejA9IC877SgO6FjLFCtZaW
	0ROCtGcFJkrH2KA1nTb4d75B+AhjM9hyYbDVwkWqUaJkO38H+RoU8PhpSoQ==
X-Gm-Gg: AYBFou2VYEZDrd2c32gXj+g2ZILcYg8I8pJt47fUo5ZMhxS/iHWNWflRCb0xHZnSYep
	kZOcQqwZY2YvLdvkUIV/X+S9yuqjHIkFiQ+YaS46xhNCHX5rbLWe4l/ArDkohgvAQZ16jAstcgs
	cgzCjVfQMf5vpOlj9treMeozhwDeqeya7EkK5z9sm0AiAEiFcvgG26Sw65S7kj59AZ/PgvDc7+f
	wUBLIaLbjTTF/JzIO+4hsNcYTXqQkmWuGXswGsxQ/ab3Qm8EsaKxfTlaXI5bnLEysexTuqqgATa
	GtLVq0mBtEeYayB16CmuxPclh+MRR+jOAKLSTW9jbP9zsQnLDsFSwbfa39G/d1Kf6tfI5f8=
X-Received: by 2002:a05:600c:4e43:b0:4a2:c9b:9b98 with SMTP id 5b1f17b1804b1-4a211ed613dmr41748825e9.17.1792768190655;
        Fri, 23 Oct 2026 08:09:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4e43:b0:4a2:c9b:9b98 with SMTP id 5b1f17b1804b1-4a211ed613dmr41748145e9.17.1792768190150;
        Fri, 23 Oct 2026 08:09:50 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d3f9d0dsm445729f8f.22.2026.10.23.08.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:09:48 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:09:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev
Subject: [PATCH net v6 6/6] net: add ip4_parse()
Message-ID: <970e2341834eadcf265fa7dd61a05ee305fdc1e4.1792687500.git.mst@redhat.com>
References: <cover.v6.git.mst@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.v6.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

Multiple places in the net stack open-code the same minimal IPv4 header
validation: pull the fixed header, check version 4 and IHL >= 5 (where 5
is the fixed header size in 32-bit units) - and locate the transport
header at IHL * 4 past the network header.

Add a helper for doing that: it returns the validated header and
the transport header offset, or NULL if truncated or malformed.

As noted by Phil Sutter, there are more places that could use this
helper, e.g. ip_mc_check_iphdr(). They will be converted in a follow-up
patch.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: Phil Sutter <phil@nwl.cc>
---

Notes (changelog):
    v4->v5:
        pull the options as well, so that the transport header
        offset is within the linear data (Willem de Bruijn)
    v5->v6:
        the options pull moved to the helper introduction in
        "net: resolve uncommon partial checksums at ingress"

 include/linux/ip.h                  | 38 +++++++++++++++++++++++++++++
 include/linux/virtio_net.h          | 34 +-------------------------
 net/bridge/br_netfilter_hooks.c     | 15 ++++--------
 net/ipv4/ip_input.c                 | 13 ++++------
 net/ipv4/netfilter/nf_reject_ipv4.c | 13 ++++------
 5 files changed, 54 insertions(+), 59 deletions(-)

diff --git a/include/linux/ip.h b/include/linux/ip.h
index d11c25f5030a..22604c19c460 100644
--- a/include/linux/ip.h
+++ b/include/linux/ip.h
@@ -56,4 +56,42 @@ static inline void iph_set_totlen(struct iphdr *iph, unsigned int len)
 {
 	iph->tot_len = len <= IP_MAX_MTU ? htons(len) : 0;
 }
+
+/**
+ * ip4_parse - pull and minimally validate an IPv4 header
+ * @skb: buffer to parse
+ * @nhoff: offset of the IPv4 header within the linear data
+ * @thoff: returns the transport header offset
+ *
+ * The whole header, options included, is guaranteed linear on
+ * return, so the transport header offset is within the linear
+ * data.  Callers that need to read the transport header must
+ * pull further.
+ *
+ * Return: the validated IPv4 header, or NULL if truncated or
+ * malformed.
+ */
+static inline struct iphdr *ip4_parse(struct sk_buff *skb,
+				      unsigned int nhoff,
+				      unsigned int *thoff)
+{
+	struct iphdr *iph;
+
+	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
+		return NULL;
+
+	iph = (struct iphdr *)(skb->data + nhoff);
+	if (iph->version != 4 || iph->ihl < sizeof(struct iphdr) / sizeof(u32))
+		return NULL;
+
+	*thoff = nhoff + iph->ihl * sizeof(u32);
+	/* Pull the options as well: the transport header offset
+	 * returned above must be within the linear data.  iph goes
+	 * stale across the pull.
+	 */
+	if (!pskb_may_pull(skb, *thoff))
+		return NULL;
+
+	return (struct iphdr *)(skb->data + nhoff);
+}
 #endif	/* _LINUX_IP_H */
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index a3012ebbed71..96293d3ab0da 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -53,38 +53,6 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	return 0;
 }
 
-/* TODO: nothing virtio specific here, move to ip.h */
-
-/*
- * Pull and minimally validate the IPv4 header at @nhoff.
- * Returns the header and stores the transport header offset in
- * @thoff, or NULL if truncated or malformed.  The whole header,
- * options included, is guaranteed linear on return.
- */
-static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
-						  unsigned int nhoff,
-						  unsigned int *thoff)
-{
-	struct iphdr *iph;
-
-	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
-		return NULL;
-
-	iph = (struct iphdr *)(skb->data + nhoff);
-	if (iph->version != 4 ||
-	    iph->ihl < sizeof(struct iphdr) / sizeof(u32))
-		return NULL;
-
-	*thoff = nhoff + iph->ihl * sizeof(u32);
-	/* Pull the options as well: the transport header offset
-	 * returned above must be within the linear data.  iph goes
-	 * stale across the pull.
-	 */
-	if (!pskb_may_pull(skb, *thoff))
-		return NULL;
-
-	return (struct iphdr *)(skb->data + nhoff);
-}
 /* Defined in net/core/dev.c, enabled while any network namespace
  * has net.core.virtio_net_hdr_validate set to 0.
  */
@@ -170,7 +138,7 @@ virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
 		    unsigned int *thoff, int *ip_proto)
 {
 	if (proto == htons(ETH_P_IP)) {
-		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
+		const struct iphdr *iph = ip4_parse(skb, nhoff, thoff);
 
 		if (!iph || ip_is_fragment(iph))
 			return false;
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 0a394e5f4391..e89da0e41542 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -206,18 +206,13 @@ static inline void nf_bridge_pull_encap_header_rcsum(struct sk_buff *skb)
 static int br_validate_ipv4(struct net *net, struct sk_buff *skb)
 {
 	const struct iphdr *iph;
-	u32 len;
+	u32 len, thoff;
 
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+	iph = ip4_parse(skb, 0, &thoff);
+	if (!iph)
 		goto inhdr_error;
 
-	iph = ip_hdr(skb);
-
-	/* Basic sanity checks */
-	if (iph->ihl < 5 || iph->version != 4)
-		goto inhdr_error;
-
-	if (!pskb_may_pull(skb, iph->ihl*4))
+	if (!pskb_may_pull(skb, thoff))
 		goto inhdr_error;
 
 	iph = ip_hdr(skb);
@@ -228,7 +223,7 @@ static int br_validate_ipv4(struct net *net, struct sk_buff *skb)
 	if (skb->len < len) {
 		__IP_INC_STATS(net, IPSTATS_MIB_INTRUNCATEDPKTS);
 		goto drop;
-	} else if (len < (iph->ihl*4))
+	} else if (len < thoff)
 		goto inhdr_error;
 
 	if (pskb_trim_rcsum(skb, len)) {
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 9860178752b8..5adf01763e85 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -500,7 +500,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 {
 	const struct iphdr *iph;
 	int drop_reason;
-	u32 len;
+	u32 len, thoff;
 
 	/* When the interface is in promisc. mode, drop all the crap
 	 * that it receives, do not try to analyse it.
@@ -520,10 +520,6 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 	}
 
 	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-		goto inhdr_error;
-
-	iph = ip_hdr(skb);
 
 	/*
 	 *	RFC1122: 3.2.1.2 MUST silently discard any IP frame that fails the checksum.
@@ -536,7 +532,8 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 	 *	4.	Doesn't have a bogus length
 	 */
 
-	if (iph->ihl < 5 || iph->version != 4)
+	iph = ip4_parse(skb, 0, &thoff);
+	if (!iph)
 		goto inhdr_error;
 
 	BUILD_BUG_ON(IPSTATS_MIB_ECT1PKTS != IPSTATS_MIB_NOECTPKTS + INET_ECN_ECT_1);
@@ -546,7 +543,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 		       IPSTATS_MIB_NOECTPKTS + (iph->tos & INET_ECN_MASK),
 		       max_t(unsigned short, 1, skb_shinfo(skb)->gso_segs));
 
-	if (!pskb_may_pull(skb, iph->ihl*4))
+	if (!pskb_may_pull(skb, thoff))
 		goto inhdr_error;
 
 	iph = ip_hdr(skb);
@@ -559,7 +556,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 		drop_reason = SKB_DROP_REASON_PKT_TOO_SMALL;
 		__IP_INC_STATS(net, IPSTATS_MIB_INTRUNCATEDPKTS);
 		goto drop;
-	} else if (len < (iph->ihl*4))
+	} else if (len < thoff)
 		goto inhdr_error;
 
 	/* Our transport medium may have padded the buffer out. Now we know it
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 59ec465a9df9..42d639854ddf 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -25,22 +25,19 @@ nf_reject_ip_tcphdr_get(struct sk_buff *oldskb,
 static int nf_reject_iphdr_validate(struct sk_buff *skb)
 {
 	struct iphdr *iph;
-	u32 len;
+	u32 len, thoff;
 
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-		return 0;
-
-	iph = ip_hdr(skb);
-	if (iph->ihl < 5 || iph->version != 4)
+	iph = ip4_parse(skb, 0, &thoff);
+	if (!iph)
 		return 0;
 
 	len = ntohs(iph->tot_len);
 	if (skb->len < len)
 		return 0;
-	else if (len < (iph->ihl*4))
+	else if (len < thoff)
 		return 0;
 
-	if (!pskb_may_pull(skb, iph->ihl*4))
+	if (!pskb_may_pull(skb, thoff))
 		return 0;
 
 	return 1;
-- 
MST

