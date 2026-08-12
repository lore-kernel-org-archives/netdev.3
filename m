Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7146A614
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552620; cv=none; b=u7QctXYWzySZsAjF1zNwQtChwqSBcTMRPvN/cXBgAX1xa5lrHOjUFVcn3DXAvoMhmUD98T0xKyXtv65IegMf0FhtTBiuIrZj3G1IMnLPwRPWRNnKeKbB7nbHTrbuB2PXUPVG8+Sa3EKq5aqfoFYJfh5tVIkXV6yU3qNeQzrgB8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552620; c=relaxed/simple;
	bh=qFJTd1Pohw19wep66XSQur8wBgQEbrCcoIQrmJ2RYwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cs4zMrKjMdNu0FNuewW3rxRV+7+nA9fOOu8oIRJhQQPuPb577s5ubHyOfmPowShr3Yo1H3u+ybXW1b8aA9xhnvEpZGQ3Ty6u6dm6+8Bq8e2Q6na4hFRrfutWXVhkwYCvz1brMtlZ2JYyozR2wOlVMRIyFgqmsdFIDg+P1K42ssw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=rNghMlrm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="rNghMlrm"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so1613772a91.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786552619; x=1787157419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S12B33otl+xs9aLy7HZkleNzMtJjJA/J8Sk9AZrxsWM=;
        b=rNghMlrmo5RBAg1o3dhWY+CcoVj996S+6akPZ8h+HzbO4t2LwC0hzzt6Z9a5KdliKo
         LK/3lty7rlcn2D0eJi750cFXC1c7RcfYFzBQmMcoDXq/a6Lxu0fxScyXzxmrOJG3R6J/
         bvM7wU+y4MWxqDN4aaAFddt8lsPqPxAv86jGKGeLzMefu2fRFVCEkql/SGXqpCItcQCS
         /lJUsXJ5smSnx2Wikdk6eF1a/byknFi/A8+Zh9B1te16pz346GZ/WlHwzlBhjdfWnh1I
         9N5sDW+rvNiMr2m3F9D/6kertnIvKYxJWM9iL+kfNYpDJ22QZf+917XhD4I4oBp5M/IQ
         7QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786552619; x=1787157419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S12B33otl+xs9aLy7HZkleNzMtJjJA/J8Sk9AZrxsWM=;
        b=om0uZqLoy/z48KZW1B0d6HRGOBUCz+ZpNILM9DdhR0k4lnN3GkGwP8RioJIMTGKF2O
         BM7A9Irdio2dkE30ALBfkjRnB6RGDtu/WaYR/Ewce8aFApTHjA9BSeJRQOyOEf4bxHK/
         LSZOuNJj13xSbj3w/p2sfieoM/aUXZwKABrLDejmN/ZvsbjkySBFxL2zNAUO9toUoFeU
         Kz0u4Dkc0x6QtyWQHXpwi6iFgLHHIvVee1oQr0h42XaoIp6Ljebf6B90duJHipg9DJP9
         K7ad9LTyfT9+3PWss0BJ0/vIYa8OQIimQhb70khpnwEq0IlI6vlArSuZwzUvccitMuKH
         my8A==
X-Forwarded-Encrypted: i=1; AHgh+RrMer0ZvhMyXWDG8gzR0IKqC3HLnjLKySTiEZjipvrOucYZHiPWPvk9Po1IZiNnRk2tAKmudfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/IG/yUvDxhTp4Z6CqfvPFgR2XAJNTXUSyzehyfacAf6rVXFB
	0UmS6GlA3csV7sUpbaDPQsMpV5hem90lIGu+IVW7SblYMwGrYwuaqsSQUG/79utFbVSK
X-Gm-Gg: AR+sD11fmwA65ayutzmx5OR1iJ9IhGx3IZPuyCstza0PWTWHuNZDACiJT3Dl1y+mbPh
	6it1KWOHxzNo/BcJov9yMDHCFNvPmmEWIAu10pi8vxujuHppR1lFFn9kN1com2NYEZtpRMirHat
	KgwnIM9lEuP6TrZ7Lj2i6ktfKGD845wuuzG11udPpv1t7tiWfXmG6f3Tine1xjTSWHvCpDlwRXL
	sJJSCTzGmAFky6JGCWSnFizsVD2jxdvbSf3zjOLUcCbzaMPikoy8Z8yAO/SAe9qhBddSDwDrB2B
	3VjWS1PeJu+pBiM67kLd/wISRG89KJHrqW+QSZuuDMbzYj4vEfHUh95zVVM11aSrUKUBP0vJgMc
	qP/KF9CTVxTvQEkYb+VMz430J809JfDYK00cm3SGXDxpv1BQT/UyZ23KwqEManWvxyAmNrM3rzN
	6rUs7KixykWEOIEyqrTLt5ezwexngMTcL9IH3SHcWE3tWV+z01t7HxA1awB6HPO4sTm7iInBHAX
	gkC
X-Received: by 2002:a17:90b:1dc6:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-393013c4248mr8969661a91.2.1786552618585;
        Wed, 12 Aug 2026 09:36:58 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931cd46314sm47499a91.6.2026.08.12.09.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:36:57 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: idosch@nvidia.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	kafai@fb.com,
	joe@wand.net.nz,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v3 1/1] ip: orphan prefetched skbs before multicast forwarding
Date: Thu, 13 Aug 2026 00:36:38 +0800
Message-ID: <0c52eb3d7532aaf8bccf37e0f7c922143c639735.1786552223.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1786552223.git.zhilinz@nebusec.ai>
References: <cover.1786552223.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPv4 and IPv6 input preserve an skb->sk association installed by
bpf_sk_assign() so that local delivery can use the selected socket under
RCU. Both address families can also prefetch a socket in UDP early demux.
In both paths (BPF and UDP early demux) a reference is not guaranteed to
be held on the socket.

When a multicast packet is not locally deliverable, IPv6 hands the
original skb to ip6_mr_input(). IPv4's ip_mr_input() similarly keeps the
original skb when local delivery is not needed. Either path can put the
skb on an unresolved multicast route queue or forward it after the
receive-side RCU section ends.

After the prefetched socket is destroyed, a later skb free invokes
sock_pfree() and dereferences the stale skb->sk. Orphan the skb before
each non-local multicast forwarding path. Local delivery retains the
original skb; the existing skb_clone() calls provide multicast forwarding
with a socket-free clone.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Fixes: 08842c43d016 ("udp: no longer touch sk->sk_refcnt in early demux")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v3:
- Describe UDP early demux consistently for both IPv4 and IPv6.
- Drop the IPv6-specific unicast-MAC discussion from the commit message.
- Leave the BPF-only TC redirect and bridge paths for a separate patchset.
- v2 Link: https://lore.kernel.org/all/f968f497251dedbd1263c322a7c4e3e1a727161d.1786023177.git.zhilinz@nebusec.ai/

changes in v2:
- Cover the IPv4 multicast forwarding path.
- Correct the IPv6 early-demux ordering and document the unicast-MAC
  PACKET_HOST condition used by the reproducer.
- Add the BPF socket-assignment and UDP early-demux Fixes tags.
- v1 Link: https://lore.kernel.org/all/02db4590d0161e31a789dcdfa8d1be1a3212ec2e.1785724784.git.zhilinz@nebusec.ai/

 net/ipv4/ipmr.c      | 3 +++
 net/ipv6/ip6_input.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 1d9a4ac14fcef..e5f2b1c6150d2 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2213,6 +2213,9 @@ int ip_mr_input(struct sk_buff *skb)
 	if (IPCB(skb)->flags & IPSKB_FORWARDED)
 		goto dont_forward;
 
+	if (!local)
+		skb_orphan(skb);
+
 	mrt = ipmr_rt_fib_lookup(net, skb);
 	if (IS_ERR(mrt)) {
 		kfree_skb(skb);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 8972863c93ee5..d332ec60f9150 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -622,6 +622,7 @@ int ip6_mc_input(struct sk_buff *skb)
 		if (deliver) {
 			skb2 = skb_clone(skb, GFP_ATOMIC);
 		} else {
+			skb_orphan(skb);
 			skb2 = skb;
 			skb = NULL;
 		}
-- 
2.43.0

