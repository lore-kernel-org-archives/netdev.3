Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761D741360A
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673365; cv=none; b=k7w5FcTONiruG64fdrBxzRiK2noEF2wIzJysQQKdPfpmDhPdeuOQcggpWRUUDiguIdpk0YHQuNIn+QxHMCOzifcBZzrwp6jl5e6wNsj+KSHflfHwkv1UsGfgiTBZgrTa8wC+HhnmdfkUhgHEGbAtJjotIxRFEuDLGTx03NdIbzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673365; c=relaxed/simple;
	bh=IFLbNTdkkygo2ZmuL1ZJhn7oU5AvnzXIa6i9xtglSA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OOWsJd7MNlmoNrnsMekqgEaCMIzh/8cjid3YhfwK4DGGHJsoRFXi2r99X410y/qZK99nVgrk+B0q7GClRNLY29O1bgelAyRMeFkwHFK8TjQnXaTWzlTzsro9J34+BKF6Y/D8oBlEZHRgV1BtBUYBaeNw+FMXRK+BJccoF2WUW+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=S1sSUG9X; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="S1sSUG9X"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9639d7daff3so1479013241.1
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780673361; x=1781278161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rgGq4eLKAvgdfu9bgs5mHMDHpw4BqD71BMCje2A/kA=;
        b=S1sSUG9X/IdVisCXRbW2YNLred2caBcN4yPMKWTVchLaGUQV8U6DzXv/3GDPXXNBhs
         wa0VRzK7hVrGdr46mWbPof850ouqqjpGCAkniiPKT2+FC8jT/If7e1MziWPN4wBWv7gY
         SOas5a/jBRwNboqt49j8F4LAHuop028KpjkLZ7XbsIGHxldiQtCpAtAvkJnvdKbO6UOJ
         JgFRmQYhCqDnTzU5zuDP0ZZedmAnreG4pxSboNb2iR2IQ3jpoyHvby1ePCbD4JCCPMgA
         faiB+tnUdEP2KYDnSZ84b80Zf34zB8h2OPxHhLVQ/efyI4V0j64gWlZriExYAO7+8OuU
         mzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780673361; x=1781278161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rgGq4eLKAvgdfu9bgs5mHMDHpw4BqD71BMCje2A/kA=;
        b=PD7257Tj8mnaZ/ym30F7flyg8XjlMKLZhgLmFHMITA/EpVNFEszi/dTMyJcSRTO5rY
         U6m5kBCw6xYfaw4oPHUN9f1xXC2MQf7Kui35ZfI4186sz/d5onyZw40JGdkQBBExR0Sd
         n3Sg9xDK87oQACxmN7/lyfCrAEQHNX3gEoGWCQE2q3CSeL+JMuMtaFtnneTnw/Y+AI08
         QyXuxY7liYqBUkykgRrAv1Wh4t/QhyQxUGJIzJmhYBtQ7j0RYAflV0pJqx9++FNJ6DJl
         H+/yJUvRiHCfyvQLFWhGj9IvrqXpE/sKmqZNFXGcebnf7sHlFsXq4Ty5ee9hgAwjGDZY
         vvDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/WT9wXOfIOUretQ9tVeFx+2uY2sLel3kYnjp92x83bGCG/OmoX5SxGrtHK1oFLs97qIKktcyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywps4hfsPTSnUIo7E4wDb3oZJXpXH2RV6OVrho1ubMlCGV/Jrn8
	xKmpuB34FmIXdW0FYed7eD9hfXdzB3v5As9ziTGWUnaO85sNH4C+nMd4pYTFlDpNLGc=
X-Gm-Gg: Acq92OH/y79gM+U16ADVOxwSiWMVaiTnJ3Q1Mh0ecsYzKZIPgH+nOwLJVW+FJN8bPws
	YzMn7OUkDOFJG7IGXbHNVy006RlMnUUqVqUbgJ87IBpYxnaNxGq5QZBcUfzDHYbQceppNwxR/GJ
	JXqZP4ODROj7kDdsxnJd8zEwcNHQSLBXeCVl43EIL8wc/qunx0DGHFYX2CX4KpQQ5UGMPT+4Xoj
	wixZIaooiNzT51zkX20XgQ+OY+8RaCU2s7v6G1wZ0VseyodGQutBBteDLfnH6WFcILeC5SRQa3r
	SlPeYsSEwNY8retuwvAmyi2zG2jr//+70S5IjBn13UBPXu0gR5kH5MGiPQYDQ1xyrnk243Sxagz
	fP7Xr5JIFKxQBBoPdn0TjgF9onXQ/xshrispGOaEXLJwlOZuYxEJh7AIQqkJNc365D4Im5pANUT
	XtZhEfi3Z5M6lictwMFVGfZoVB9sinfyijFQvdPg==
X-Received: by 2002:a05:6102:2922:b0:6ef:dc8c:9367 with SMTP id ada2fe7eead31-6feed1a226bmr2360914137.5.1780673361196;
        Fri, 05 Jun 2026 08:29:21 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8ceccd9fa7fsm85758656d6.9.2026.06.05.08.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 08:29:20 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/sched: act_csum: skip malformed IPv4 headers
Date: Fri,  5 Jun 2026 15:29:15 +0000
Message-ID: <20260605152916.2125473-1-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

act_csum trusts the IPv4 IHL field before using it to locate transport
header fields.  Packets with an invalid short IHL can make the action
write checksum data into the IPv4 header instead of the intended L4
header.

The action should not repair or modify packets whose IPv4 header length
is invalid.  Treat those packets as not eligible for checksum repair and
leave the configured action result unchanged.

Return success without updating checksums when the IPv4 version, IHL, or
total length cannot describe a complete IPv4 header.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/sched/act_csum.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index a9e4635d899e..faedf6abd448 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -385,6 +385,8 @@ static int tcf_csum_sctp(struct sk_buff *skb, unsigned int ihl,
 static int tcf_csum_ipv4(struct sk_buff *skb, u32 update_flags)
 {
 	const struct iphdr *iph;
+	unsigned int ihl;
+	unsigned int ipl;
 	int ntkoff;
 
 	ntkoff = skb_network_offset(skb);
@@ -393,41 +395,43 @@ static int tcf_csum_ipv4(struct sk_buff *skb, u32 update_flags)
 		goto fail;
 
 	iph = ip_hdr(skb);
+	if (iph->version != 4 || iph->ihl < 5)
+		return 1;
+
+	ihl = iph->ihl * 4;
+	ipl = ntohs(iph->tot_len);
+	if (ipl < ihl)
+		return 1;
 
 	switch (iph->frag_off & htons(IP_OFFSET) ? 0 : iph->protocol) {
 	case IPPROTO_ICMP:
 		if (update_flags & TCA_CSUM_UPDATE_FLAG_ICMP)
-			if (!tcf_csum_ipv4_icmp(skb, iph->ihl * 4,
-						ntohs(iph->tot_len)))
+			if (!tcf_csum_ipv4_icmp(skb, ihl, ipl))
 				goto fail;
 		break;
 	case IPPROTO_IGMP:
 		if (update_flags & TCA_CSUM_UPDATE_FLAG_IGMP)
-			if (!tcf_csum_ipv4_igmp(skb, iph->ihl * 4,
-						ntohs(iph->tot_len)))
+			if (!tcf_csum_ipv4_igmp(skb, ihl, ipl))
 				goto fail;
 		break;
 	case IPPROTO_TCP:
 		if (update_flags & TCA_CSUM_UPDATE_FLAG_TCP)
-			if (!tcf_csum_ipv4_tcp(skb, iph->ihl * 4,
-					       ntohs(iph->tot_len)))
+			if (!tcf_csum_ipv4_tcp(skb, ihl, ipl))
 				goto fail;
 		break;
 	case IPPROTO_UDP:
 		if (update_flags & TCA_CSUM_UPDATE_FLAG_UDP)
-			if (!tcf_csum_ipv4_udp(skb, iph->ihl * 4,
-					       ntohs(iph->tot_len), 0))
+			if (!tcf_csum_ipv4_udp(skb, ihl, ipl, 0))
 				goto fail;
 		break;
 	case IPPROTO_UDPLITE:
 		if (update_flags & TCA_CSUM_UPDATE_FLAG_UDPLITE)
-			if (!tcf_csum_ipv4_udp(skb, iph->ihl * 4,
-					       ntohs(iph->tot_len), 1))
+			if (!tcf_csum_ipv4_udp(skb, ihl, ipl, 1))
 				goto fail;
 		break;
 	case IPPROTO_SCTP:
 		if ((update_flags & TCA_CSUM_UPDATE_FLAG_SCTP) &&
-		    !tcf_csum_sctp(skb, iph->ihl * 4, ntohs(iph->tot_len)))
+		    !tcf_csum_sctp(skb, ihl, ipl))
 			goto fail;
 		break;
 	}
-- 
2.43.0

