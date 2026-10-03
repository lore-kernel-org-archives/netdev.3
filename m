Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7827BCA4E
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791055866; cv=none; b=rL8so8U+QVeT4aeW6I3pLp/OGvxFrNQZRw0t1hvIATfj5+A0m53a8Au5+/GbcHarDgxMkTfn4H7NJkF3yYkXQpjFamudG4fg50xvGorlZXCbawX4h5ux4F6z6aENXIDrT1FPatiJhegw76kX/FBu6F7wvULGkG9e64zckhuCJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791055866; c=relaxed/simple;
	bh=ZElFYlTJytLPOtLoz2WTBpG5AcBBbeL5LukqcdZwsis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OeIBhQ4Y/jihJL2gj9gC4cTTKJtjIN3TFKEkORqlNBdlE21mqh7NjKKVmzUvWYOIr1bfmLpc6MGyg6mcWkJHmWvsMEmgE5lulnqQAsMpU8ns8/XGTR+Mni+aPDf3lovl74dhCtoIX5LK2E1rHDNtLrik2p93I7zVVQby8DA9Q38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hp9oONDJ; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hp9oONDJ"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so622151a91.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 12:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791055864; x=1791660664; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G1b1NAIb66+4gL0f+Lg3mVBb3spaxgJDZmnksBLtDWY=;
        b=Hp9oONDJwwQrGUs9SJVdZqXc2wWVdoI/1YH91UhXDyHufyuH0gitkibgBBLZkV4BNW
         oZBlBNJp8vw7iKTwd9yptL2leC1Kld7oH6nf0pNWvitlQqwGatElvH5CIuSBXq1SR6PY
         bnYFWuXNSWiLjNftCQZe7U0a/q+G17+FDyrE0Lu06TmSqvOTTT2ESElEkLJXUK95yQXr
         HqAyOuzW14wjhdG+XVD1ifHNjeK9bJ7RBTnvwcyQgbtMGn5Br7gMlrjL+2NLf0kEm7S4
         e4g+VxGa/1QRs2BPSqK+vETF7D/T43s8HZbwc13WWEx0f1Zt5eXtlZNFiEhPyYQtWkD7
         EL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791055864; x=1791660664;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G1b1NAIb66+4gL0f+Lg3mVBb3spaxgJDZmnksBLtDWY=;
        b=HUrLWHwJCD1oF36HgqFpUx1llta6KeJpLbal1jBg6OXV17TuviwLBzZg74+6jT64Pj
         RrF6oG9Rtj7g9lMPAdJ7C2sXc1cfiGc0jfHh/Xu6/HJYJWROLwDgBz+WA7xdpfFHa4lg
         SQzIOOObO8SFmLpvxvDZjCvUoTX+dHBU3Uj96oOuyqBqJDr2ASReswSFHwSoWDNiibyL
         KB96BqBEWkLNxZhqZ+4vJJTqbHnJkH4kqS6JD6r51WrEiJ5CXB5x45Dbm3K5D8PFU/IJ
         OcustkEEFbI/hf0tQ+Fe+K1G60ENpstDsdErJPEEBtL32/A4CkkXc3D4+wq9zYbHadkB
         Fqjg==
X-Forwarded-Encrypted: i=1; AKwUvBzSppKP4KuHkehc9ZFLozkrZxh+hFPKAHTlrbCGEPpAoyRCRDecY6Sv1TV7KWBOz3ZyPKvm9oo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxUJp0PQE9CXbRJfY/MDfX5A6KCDULOim4n/McLk0KO4XvT6vY
	RcdQ6LDbBYR7dJAxTlbAyzBciQJctH63cdo/C+P8Qxc5Nda7vPBpGiW13Oj2knPD4l+euoCATOq
	ZpFh6Vw==
X-Received: from pgag1.prod.google.com ([2002:a05:6a02:2f01:b0:cc7:cf2c:7b6c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33cc:b0:3a2:aec0:6bc2
 with SMTP id 98e67ed59e1d1-3a6ced50989mr5631016a91.53.1791055863553; Sat, 03
 Oct 2026 12:31:03 -0700 (PDT)
Date: Sat,  3 Oct 2026 19:30:58 +0000
In-Reply-To: <20261001182136.33-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001182136.33-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003193103.1178658-1-kuniyu@google.com>
Subject: Re: [PATCH net] ipv6: rpl: unclone the skb before modifying the packet
From: Kuniyuki Iwashima <kuniyu@google.com>
To: andrea.mayer@uniroma2.it
Cc: benquike@gmail.com, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@kernel.org, horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	kuniyu@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, sashiko-bot@kernel.org, stefano.salsano@uniroma2.it
Content-Type: text/plain; charset="UTF-8"

From: Andrea Mayer <andrea.mayer@uniroma2.it>
Date: Thu,  1 Oct 2026 20:21:36 +0200
> ipv6_rpl_srh_rcv() modifies the packet data, such as Segments Left and
> the destination address, without checking whether the skb is cloned.
> The skb may be cloned, for example by an AF_PACKET socket receiving on
> the ingress device. ipv6_rpl_srh_rcv() then writes into the packet data
> shared with the clone. A read from that socket can return the modified
> packet instead of the received one.
> 
> The only pskb_expand_head() in the function runs after Segments Left and
> the destination address are written, and only when Segments Left reaches
> 0 or there is not enough headroom.
> 
> Call pskb_expand_head() on a cloned skb before the packet is modified
> (i.e., before Segments Left is decremented), as ipv6_srh_rcv() does.
> On failure, drop the packet with SKB_DROP_REASON_NOMEM.
> 
> Fixes: a2f4c143d76b ("ipv6: rpl: Fix Route of Death.")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925133807.32-1-andrea.mayer%40uniroma2.it
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  net/ipv6/exthdrs.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 09a4552f7f08..8fcf18e6114d 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -548,6 +548,17 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  		return -1;
>  	}
>  
> +	if (skb_cloned(skb)) {
> +		if (pskb_expand_head(skb, 0, 0, GFP_ATOMIC)) {

ipv6_rpl_srh_rcv() already has pskb_expand_head() call later
and I think this can be merged there.


> +			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
> +					IPSTATS_MIB_OUTDISCARDS);
> +			kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
> +			return -1;
> +		}
> +
> +		hdr = (struct ipv6_rpl_sr_hdr *)skb_transport_header(skb);
> +	}
> +
>  	hdr->segments_left--;
>  	i = n - hdr->segments_left;

This and the later swap(ipv6_hdr(skb)->daddr, ohdr->rpl_segaddr[i])
only modify the header before the existing pskb_expand_head().

Also this seems wrong because skb_postpull_rcsum() is applied to
the modified header, which should corrupt checksum.

I think we can merge the clone check and pskb_expand_head() with
skb_cow() and tmp IPv6 buffer like this.

compiled only:

---8<---
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 09a4552f7f08..af285edd4d16 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -485,6 +485,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 	struct net *net = dev_net(skb->dev);
 	struct ipv6hdr *oldhdr;
 	unsigned int chdr_len;
+	struct in6_addr addr;
 	unsigned char *buf;
 	int accept_rpl_seg;
 	int i, err;
@@ -548,9 +549,6 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 		return -1;
 	}
 
-	hdr->segments_left--;
-	i = n - hdr->segments_left;
-
 	buf = kcalloc(struct_size(hdr, segments.addr, n + 2), 2, GFP_ATOMIC);
 	if (unlikely(!buf)) {
 		kfree_skb(skb);
@@ -559,6 +557,8 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 
 	ohdr = (struct ipv6_rpl_sr_hdr *)buf;
 	ipv6_rpl_srh_decompress(ohdr, hdr, &ipv6_hdr(skb)->daddr, n);
+	ohdr->segments_left--;
+	i = n - ohdr->segments_left;
 	chdr = (struct ipv6_rpl_sr_hdr *)(buf + ((ohdr->hdrlen + 1) << 3));
 
 	if (ipv6_addr_is_multicast(&ohdr->rpl_segaddr[i])) {
@@ -575,28 +575,24 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 		return -1;
 	}
 
-	swap(ipv6_hdr(skb)->daddr, ohdr->rpl_segaddr[i]);
+	addr = ohdr->rpl_segaddr[i];
+	ohdr->rpl_segaddr[i] = ipv6_hdr(skb)->daddr;
 
-	ipv6_rpl_srh_compress(chdr, ohdr, &ipv6_hdr(skb)->daddr, n);
-
-	oldhdr = ipv6_hdr(skb);
+	ipv6_rpl_srh_compress(chdr, ohdr, &addr, n);
 
 	skb_pull(skb, ((hdr->hdrlen + 1) << 3));
-	skb_postpull_rcsum(skb, oldhdr,
+	skb_postpull_rcsum(skb, ipv6_hdr(skb),
 			   sizeof(struct ipv6hdr) + ((hdr->hdrlen + 1) << 3));
 	chdr_len = sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3);
-	if (unlikely(!hdr->segments_left ||
-		     skb_headroom(skb) < chdr_len + skb->mac_len)) {
-		if (pskb_expand_head(skb, chdr_len + skb->mac_len, 0,
-				     GFP_ATOMIC)) {
-			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_OUTDISCARDS);
-			kfree_skb(skb);
-			kfree(buf);
-			return -1;
-		}
-
-		oldhdr = ipv6_hdr(skb);
+	if (unlikely(skb_cow(skb, chdr_len + skb->mac_len))) {
+		__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_OUTDISCARDS);
+		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
+		kfree(buf);
+		return -1;
 	}
+
+	oldhdr = ipv6_hdr(skb);
+
 	skb_push(skb, chdr_len);
 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
@@ -605,6 +601,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 	memmove(ipv6_hdr(skb), oldhdr, sizeof(struct ipv6hdr));
 	memcpy(skb_transport_header(skb), chdr, (chdr->hdrlen + 1) << 3);
 
+	ipv6_hdr(skb)->daddr = addr;
 	ipv6_hdr(skb)->payload_len = htons(skb->len - sizeof(struct ipv6hdr));
 	skb_postpush_rcsum(skb, ipv6_hdr(skb),
 			   sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3));
---8<---
