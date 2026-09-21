Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55E8334692
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 02:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789959236; cv=none; b=djL5y5oQM7aG14dXdSt7/PKQY2dcBIeI/aFvzZ2zzQHnrxTciETNAm22imP8/edZ+nqJq28b8N+huXr5MGqRvoxHYChcAPbQnCIsLwqvn3tFs9SghHY1VF9+8WLeiZ9hs2wuKS58yO7F+FcRokL1eLQToLZ9inOHGWqCiwGWuUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789959236; c=relaxed/simple;
	bh=o7u+Ilnkg+4xjG93z/0C0NZxlAlBcA2mnfdP5ehaM74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUbVJe0XD60Khsp9Z5mQIOqvLplY+XSlOo1wcd4yCYfOYo0Lg1nZbkh6PbjDt8w/jQMP06nJMqE9cDLScHMkawpvtg1zLxB6b5egB9EGJQJjfk29wt7UJPFe1aPMuHqyr1vdaF2nc7KeY0jMusYfLCY5NGkOzhEUkL85TpT9Qus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et+W8caU; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et+W8caU"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cc46c8so322026885a.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789959233; x=1790564033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u8Ct4yW9W4ymcEv428o4m/ZX/KrAWtAnJ7CKPNzyvYY=;
        b=et+W8caUeJia6mcj+wTgoqX2bCsCLBK/WVaX/C/smL2cFB37iXQulDUhLvBfJ2MX2n
         XEDtaQ1MZ5fV71ktQtakXlkp7WHuxUYf0RrjxU2tvxFQunVd1G00ZS4Ir7OYKRMLawZR
         sN9lXfmtWKxkJnXP74qbhdDxqAW6PASB+IjujdVpRsnGidWJ7BBZVSiYopVO7BdacymA
         BqcYoM5UxmFn7xygMTlbZYAOlCNaDJRrFleZxjhsRKdxf8Y+1iuq/Q2CPE1n0KRCBQdm
         dMjSfjLEjKrYiz/a7Qq5u/cSrOaesRTqIACJZM0LQPBXVeWfU4e7mt00ygMwRV8fl+qB
         c5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789959233; x=1790564033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u8Ct4yW9W4ymcEv428o4m/ZX/KrAWtAnJ7CKPNzyvYY=;
        b=esPGwrXOzR+ekpC0V++YTU7QnNPwid/MEt0FQXQ6VqbXzkiirRIFhxGFPsTAxadZOA
         MJuFTLnSRHLIIdOmNlYZodJarqI/7mLmX1YnpOvp3ojn9Ou5oyJ0jC9UGbkmYAcRaUfV
         YR4Ih+Rb1ljB5AxeaWzJMBH4Qm2J0ePVRwQiW4uzMAWq+xoQYfFUqAR6GomEPkF+abbD
         iuVoNcN1rCt3Mmw52VhfaJfyhax/mv91qeN6wmnX1oPq7SBpAycdJ8lzRplquLI5ugbp
         GCaeVGdtkB4P/DQsgeIce0SLiz2XqG68cI21qqQLOM5vdviy0Dd+QzljENvGclMe8/Od
         m6hQ==
X-Gm-Message-State: AFuF++l3KC1OE+QZXps+UKdltdODaaYgh+BZq6ghG9Q0jNKexPi5x+zB
	KoNjI++DO8tUgL512+rN/F7gcmkwEhqJ1BNpwU5GEnPaTCmBbZuU3TOETO1ELSbKhMw=
X-Gm-Gg: AYBFou2w5EOuC1poCWsSba3geQ6z3BUmrqO605PIvViSWCtvFkk+nvv3BIuhJLXh2L5
	f/mQJ6qsgfEUaO2Fe8UXWHL97veu7TGuAUPqPL78u1YaVu5g/1ofM4wM6TTubgxbOpgTXqUO+VL
	DqmjUK4RxFtzJn5XgAH9MTjuNcjOKf3cDN17eUcNS63qW59fG7LjhAuTe9NWoMdG5D9J1r4vTjl
	k1F12eBSnleHqfMqGO+zQNp9x189Nlqk2ds4n5lKx7iGh/Z0IIfRDlpoV1F4pReTkh/FXRWFwzf
	3woCLa++IqDuuXFzN7jx7NL8q+OYGSVoG5vEu7752U6Phs6ys465ZjDVjwyAcPuXuCFZxQGtDWE
	82YtCyvJgniSJSf3AI0kWpzaFI+KCq0BZ66HcxNaupMyjrH/PlLArsvNUwTpEQHCxeIGb5ZcerH
	1xjzitdfpjidjrlrZ0elv4zgG56puUs+jLN1119au5GNkOAutFQ35W7lVOxbqNNWcVU6U1ENal3
	LJhI08j9toWdIKpcc/Nk19CHOhbCYrjBW7TZeG/njbsJi1mw90GiH29qOdhgKdv36/TS4vi
X-Received: by 2002:a05:620a:1724:b0:93b:d7a0:d9f0 with SMTP id af79cd13be357-93bf57eea2emr869731285a.74.1789959232559;
        Sun, 20 Sep 2026 19:53:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:64b9:5e22:f77c:324e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93bedb3de58sm528732785a.37.2026.09.20.19.53.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 19:53:51 -0700 (PDT)
From: Paulos Yibelo <habte.yibelo@gmail.com>
To: netdev@vger.kernel.org
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	mst@redhat.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	razor@blackwall.org,
	idosch@nvidia.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-um@lists.infradead.org,
	virtualization@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 2/2] ip: reject partial checksums covering network headers
Date: Sun, 20 Sep 2026 22:53:41 -0400
Message-ID: <20260921025341.44846-3-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260921025341.44846-1-habte.yibelo@gmail.com>
References: <20260920004733.6473-1-habte.yibelo@gmail.com>
 <20260921025341.44846-1-habte.yibelo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_do_fragment() and nf_br_ip_fragment() complete a CHECKSUM_PARTIAL skb
before reading the IPv4 header length. ip6_fragment() and br_ip6_fragment()
complete one after parsing the IPv6 header chain. A virtualization
interface can supply a checksum start which, after link-layer removal,
still points inside that parsed network header.

skb_checksum_help() then writes the completed checksum into header bytes
the stack has already consumed. For IPv4, changing iph->ihl after routing
and validation can make fragmentation copy beyond the skb's logical linear
head into transmitted options. A negative checksum-start offset is rejected
by skb_checksum_help(), but only after a WARN_ONCE which can panic a
panic_on_warn system.

Validate the checksum start against the parsed header length before
completing it. For IPv4, read and validate IHL first, retain it, and
reacquire iph after skb_checksum_help() in both implementations. For IPv6,
use the length returned by ip6_find_1stfragopt() in both implementations.

Compare the signed checksum-start offset with the bounded signed header
length so integer promotion cannot bypass either boundary.

Fixes: dbd3393c56a8 ("ipv4: add defensive check for CHECKSUM_PARTIAL skbs in ip_fragment")
Fixes: 405c92f7a541 ("ipv6: add defensive check for CHECKSUM_PARTIAL skbs in ip_fragment")
Fixes: 3c171f496ef5 ("netfilter: bridge: add connection tracking system")
Fixes: 764dd163ac92 ("netfilter: nf_conntrack_bridge: add support for IPv6")
Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
Link: https://lore.kernel.org/netdev/20260920004733.6473-3-habte.yibelo@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
---
Changes in v5:
- Compare the checksum-start offset and IPv4 header length as signed
  values.
- Add parsed-header checks to the IPv4/IPv6 output and bridge-netfilter
  fragmentation paths.
- Drop the prior Acked-by and Reviewed-by tags because the code changed.

Changes in v4:
- State that a TUN device is sufficient and no guest is required, as
  noted by Michael S. Tsirkin.

Changes in v3:
- No code changes.

Changes in v2:
- No code changes.

 net/bridge/netfilter/nf_conntrack_bridge.c | 21 +++++++++++++++-----
 net/ipv4/ip_output.c                       | 23 ++++++++++++++++------
 net/ipv6/ip6_output.c                      | 12 ++++++++---
 net/ipv6/netfilter.c                       | 12 ++++++++---
 4 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 7ecb8a26b..d81ed8692 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -38,18 +38,29 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 	struct iphdr *iph;
 	int err = 0;
 
-	/* for offloaded checksums cleanup checksum before fragmentation */
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
+	iph = ip_hdr(skb);
+	hlen = iph->ihl * 4;
+	if (unlikely(hlen < sizeof(*iph) || hlen > skb_headlen(skb))) {
+		err = -EINVAL;
 		goto blackhole;
+	}
 
-	iph = ip_hdr(skb);
+	/* Complete offloaded checksums only after the validated IP header. */
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (unlikely(skb_checksum_start_offset(skb) < (int)hlen)) {
+			err = -EINVAL;
+			goto blackhole;
+		}
+		err = skb_checksum_help(skb);
+		if (err)
+			goto blackhole;
+		iph = ip_hdr(skb);
+	}
 
 	/*
 	 *	Setup starting values
 	 */
 
-	hlen = iph->ihl * 4;
 	frag_max_size -= hlen;
 	ll_rs = LL_RESERVED_SPACE(skb->dev);
 	mtu = skb->dev->mtu;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a24cc8ee1..fa6a74d20 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -770,16 +770,28 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	struct ip_frag_state state;
 	int err = 0;
 
-	/* for offloaded checksums cleanup checksum before fragmentation */
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
-		goto fail;
-
 	/*
 	 *	Point into the IP datagram header.
 	 */
 
 	iph = ip_hdr(skb);
+	hlen = iph->ihl * 4;
+	if (unlikely(hlen < sizeof(*iph) || hlen > skb_headlen(skb))) {
+		err = -EINVAL;
+		goto fail;
+	}
+
+	/* Complete offloaded checksums only after the validated IP header. */
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (unlikely(skb_checksum_start_offset(skb) < (int)hlen)) {
+			err = -EINVAL;
+			goto fail;
+		}
+		err = skb_checksum_help(skb);
+		if (err)
+			goto fail;
+		iph = ip_hdr(skb);
+	}
 
 	mtu = ip_skb_dst_mtu(sk, skb);
 	if (IPCB(skb)->frag_max_size && IPCB(skb)->frag_max_size < mtu)
@@ -789,7 +801,6 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	 *	Setup starting values.
 	 */
 
-	hlen = iph->ihl * 4;
 	if (mtu < hlen + 8) {
 		err = -EMSGSIZE;
 		goto fail;
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 550965058..d157b6ade 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -942,9 +942,15 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	frag_id = ipv6_select_ident(net, &ipv6_hdr(skb)->daddr,
 				    &ipv6_hdr(skb)->saddr);
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
-		goto fail;
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (unlikely(skb_checksum_start_offset(skb) < (int)hlen)) {
+			err = -EINVAL;
+			goto fail;
+		}
+		err = skb_checksum_help(skb);
+		if (err)
+			goto fail;
+	}
 
 	prevhdr = skb_network_header(skb) + nexthdr_offset;
 	hroom = LL_RESERVED_SPACE(rt->dst.dev);
diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index a7025ec87..da7ada12f 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -144,9 +144,15 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	frag_id = ipv6_select_ident(net, &ipv6_hdr(skb)->daddr,
 				    &ipv6_hdr(skb)->saddr);
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
-		goto blackhole;
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (unlikely(skb_checksum_start_offset(skb) < (int)hlen)) {
+			err = -EINVAL;
+			goto blackhole;
+		}
+		err = skb_checksum_help(skb);
+		if (err)
+			goto blackhole;
+	}
 
 	prevhdr = skb_network_header(skb) + nexthdr_offset;
 	hroom = LL_RESERVED_SPACE(skb->dev);
-- 
2.46.0
