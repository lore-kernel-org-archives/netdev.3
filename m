Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169854A2E02
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328348; cv=none; b=hM2CnkkkdM4uhOnfZBLC4xEIsxh5nqtwg/N8AYThwxUWi3iJ7QxUV1gHOrzKdMN0eaAKFpjpZ0FmGxCwxV0PpQj1eUa7krYcTRfSXn6pbStjywIknT0i9AgprE6RfjFToEUIWZPFiBqKUwlcWwbnjN2NMoUgU8g5CFb7E/VGApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328348; c=relaxed/simple;
	bh=T7bO5vskgi4wdKqqOvcqgB8KIqtxNl+r9o5C3t6+Tps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+S5lfbBzzMuwN/r854WLnjKsiDyfZSNn0X7wPKo42fZXMEDdDFmwBbzmo7zHST+uB4oTE9uP7IBaamySvtehxrxJBL6k+BYm5dD8YRwJBF0jGXAwxgaOogodD267BnG4yeGLAwUUfih8eLeFZL+BXTiAGqN6qpcNEhsso8BBMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=jCX5nsAF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="jCX5nsAF"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c34bff61551so176637766b.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792328343; x=1792933143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GTgCp4IrBiqN7a3kGTWquJfuTdWShdwpAuqeHd8VlDQ=;
        b=jCX5nsAFAnBpGoPk0WEgIrn7PXClaNl05ZNl3x36GEDIgU+lWGNNZkBsiPdAO0TsH6
         5h2seyHjkX/Kv57JHbP0cIJU/QJoa81g22ICNU/+NSifvoNYWDnGUHB+wvJKP//STnJb
         L0zC+6QF6H/x5jZTBPk8iDszTtkUgSSv//kqvtZbrchZ5RMg0BsdS7u3A+5jvQCwAUnc
         OdhivZKLgF+038N/GQJd1KlGoyfP0B3JVqY7f0IIaRf+zsto7PxG5MXIfnA6AmuPQlSJ
         ky5BbpsRcy7nIQXVnPFoA6mfzBG9MopOMlQHFXkcgi4t8n1sda6k/Qbg+bDe9D5c8KgW
         8bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792328343; x=1792933143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GTgCp4IrBiqN7a3kGTWquJfuTdWShdwpAuqeHd8VlDQ=;
        b=LxeDPGECuMCDpaz4Al//SwlngMvFbCGXIalJx7pyY71eWS+rHiFgxgtl2zvMizREtQ
         ZPHou1NJbOxOP16TzQM1YAiDxadgY8nIBYSmpeazLHlD0NE/aJw/P3M+Cbhem0YXB2EX
         48XB8/ht28DltBiSpWXHEvpA7rDWzYmbRtVGQ70u9Z9ruTHT5f6Yzp/1m+UPb3L/yM7I
         5DMZkwoIb3ibDhd42Lm5tY+wXDrcTmcwDDmTtXBygNI8YR95hkV03JtQORsLqM3FJxbJ
         YszeyQm0qb4y7VS6L/CIbNoreOoDvSw2qMcoSItJcnutmR2Q6vZjsK4XVxwW4tJ8nqwY
         p4UA==
X-Gm-Message-State: AFq9FYK/fyBrbnJoBtyAXi4W05O7i3HuGXo5q3EUZ0e5ltRbxEsIqmQC
	PBGLKImNlEbp1E0B4g64k5iBFnbKboTt2RyQNln6rX7XM2eXfhW9nYXxUOGHC4/aI5LIn/nhQs9
	5wRzoTV6p6Yw=
X-Gm-Gg: AYBFou3HciFPGbBrbow50JKNVrWhEybJTg5dVGXeRr93+DE1aFo8WksjiIObhb4FgJ4
	i7aIH6KPnxppC6ftX6cmaafNE0SfOaCHMGqGIBfrdqIWWEMdVuOL78v8OpYfaUzlmpN84XZT5i8
	nOJDflId8IMELWgomWGz/M/NJ7l+8arxKMQJn0qyKUv25tBZmpLuSEbmaFh53f7yFDhNvPkttbx
	6NGZoN6y2GDnmCMq5x/IwoKY7WACKOg6mymNImJqCaBzCSR9EYCpJbOHVa2jDGI7IFqaNgYsyyl
	eV3Z5TQkRHxLk4puaPf1ft5J3zh0R5L+5HM8y3Kr5mWMPTP0h7zoqsQCP078sPepa10JboGNTPF
	lHsS8uDbqClCF8JRGXx8/5zY1VnVS3OsExrZ986oyj9g9h6MwTq/aDOubIjgo5T/uLUp6VTwjg+
	Qt95ZnJRgjnOTiM/wlSAmTSJDJsnnStQtz3jm1oENE+Hump6PpolW10kYOK1hlLLQSj8mopupuL
	584Ka9KAHjD3otJjS/YVlAR5dgboEGmftbYTzk+aQhopOvdiFKMC/Y5yxvHFEXHqrXgUhSRE0SK
	9LG0QFFxMiHyK5/eQXcQCssyzXiRBBP+nIjOPIDJ1MV7vROizaaf8ArisSrnYuEf0PXFWJX3Xwj
	3qqu8xZu5aRrnqW8aA7pE8PG4RtSu9l64ASP9cm+N1qgSaQe2Twf32EF2I9YN7LwNXyg8KT93HX
	fjvYJbvFYt
X-Received: by 2002:a17:907:96ab:b0:c3e:f39b:2286 with SMTP id a640c23a62f3a-c419699e001mr345304966b.0.1792328343308;
        Sun, 18 Oct 2026 05:59:03 -0700 (PDT)
Received: from Desktop.fritz.box ([185.181.130.213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ce05csm259032066b.33.2026.10.18.05.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:59:02 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	willemb@google.com,
	jiayuan.chen@linux.dev,
	mfleming@cloudflare.com,
	almasrymina@google.com,
	bigeasy@linutronix.de,
	richardbgobert@gmail.com,
	ecree.xilinx@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 3/4] ipmr: set up GSO state for tunnel vifs
Date: Sun, 18 Oct 2026 14:58:53 +0200
Message-ID: <5b5fb061bec2fc8d75c448b41159e0e338c89cbe.1792327155.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792293419.git.julius@bairaktaris.de>
References: <cover.1792293419.git.julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_encap() pushes the outer IPv4 header but does not set SKB_GSO_IPXIP4,
skb->encapsulation or the inner headers. A GSO packet forwarded to a
VIFF_TUNNEL vif is then rejected by ipip_gso_segment() and dropped in
validate_xmit_skb(), after being counted as sent. A device with UDP
segmentation offload is handed a GSO packet whose transport header
points at the inner IP header.

Call iptunnel_handle_offloads() and skb_set_inner_ipproto() as
ipip_tunnel_xmit() does, and reserve one outer IP ID per segment as
iptunnel_xmit() does.

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 net/ipv4/ipmr.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index b9c544d48c452..6f2eb571f30f7 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1835,12 +1835,17 @@ static struct notifier_block ip_mr_notifier = {
  * This avoids tunnel drivers and other mess and gives us the speed so
  * important for multicast video.
  */
-static void ip_encap(struct net *net, struct sk_buff *skb,
-		     __be32 saddr, __be32 daddr)
+static int ip_encap(struct net *net, struct sk_buff *skb,
+		    __be32 saddr, __be32 daddr)
 {
+	const struct iphdr *old_iph;
 	struct iphdr *iph;
-	const struct iphdr *old_iph = ip_hdr(skb);
 
+	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4))
+		return -1;
+	skb_set_inner_ipproto(skb, IPPROTO_IPIP);
+
+	old_iph = ip_hdr(skb);
 	skb_push(skb, sizeof(struct iphdr));
 	skb->transport_header = skb->network_header;
 	skb_reset_network_header(skb);
@@ -1855,11 +1860,12 @@ static void ip_encap(struct net *net, struct sk_buff *skb,
 	iph->protocol	=	IPPROTO_IPIP;
 	iph->ihl	=	5;
 	iph->tot_len	=	htons(skb->len);
-	ip_select_ident(net, skb, NULL);
+	ip_select_ident_segs(net, skb, NULL, skb_shinfo(skb)->gso_segs ?: 1);
 	ip_send_check(iph);
 
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 	nf_reset_ct(skb);
+	return 0;
 }
 
 static inline int ipmr_forward_finish(struct net *net, struct sock *sk,
@@ -1968,7 +1974,8 @@ static int ipmr_prepare_xmit(struct net *net, struct mr_table *mrt,
 	 * What do we do with netfilter? -- RR
 	 */
 	if (vif->flags & VIFF_TUNNEL) {
-		ip_encap(net, skb, vif->local, vif->remote);
+		if (ip_encap(net, skb, vif->local, vif->remote))
+			return -1;
 		/* FIXME: extra output firewall step used to be here. --RR */
 		DEV_STATS_INC(vif_dev, tx_packets);
 		DEV_STATS_ADD(vif_dev, tx_bytes, skb->len);
-- 
2.53.0

