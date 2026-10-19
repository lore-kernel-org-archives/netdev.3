Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13474F390B
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416138; cv=none; b=UgH7HC0lYemkE42cuc8OdR/+UC9jaBQQf56wWFJU/+93C1oOa6V6LNo0CwuB+PrFDY4vKqVCtXNaUR4bJ6WE/T4MuMEt12iCLbYZAnXMK2Hr03jKXZlFJm/G7BX0pR13ymkXYSvBbiaSy2l096y1vDIlgiW26bumdNb5xWnQy5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416138; c=relaxed/simple;
	bh=Q2eussegMEXlMuB9XaZj3TGeoOrydpSZHsCEsqU8fDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a+haKzqr+mCXxzSlHd2ET5qZ3WO/+hnRpbP088UBiREYmdUzxwNZCbSa9+bemKuq3aIPY7/p9ANxxshewrYL0wW3Pqeda0XAFO5Eo6Mf7XsHUeqmrcP7BKLGgKP6IKuceABHFZSzuxTQ1q5iuVsbeh1iWIPkVobMxTf5DDeGRS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX8kKHFh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX8kKHFh"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso10754395ad.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416136; x=1793020936; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Uej8RaCixc8uhONaildvoqjFo40RXd4HoOuIpWKquA=;
        b=kX8kKHFhXb6iyY7oJW0fCoS+ru6ZyQk2RZt3AD8vRAcVfE6wADfZ7RvkRlQk8GGvAM
         uYavu57vUn3mstaWZXIZcPNENZv6EVPkYLxn4NsywM2UQhpC+VTIVoh8Cvs7jQ07zxp+
         IJfPTdrLl7yFtVIePDmZ5grrwINeh3OwBUlBI+vg8rZOzYLa0k6L2G2PAnvlQQIgO6Jt
         6XWgYkvOfp8S84ocpDi6hOT1qRDGwINAWarx4aJgRP1yogggkipgrv7432m6xceZLn/d
         KagAcWuXCiEfosAW+2EmdhEqIBlgDPihq1mWOYzGolyvvo957pEI3FZx6adeXgnyapGh
         qJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416136; x=1793020936;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Uej8RaCixc8uhONaildvoqjFo40RXd4HoOuIpWKquA=;
        b=kBzDPZh6si7aNaNMrxcL3PM1t558CzT4XnJp6e0w5Za3I5z08tZa0g8j5HtyeqMN8D
         VcB8y/icl4zZb5MNVy440bdmRhZNKXsIqK2hZtyAFnSC7rQ9nN0fV6ulXNDWnqXG/AUr
         t8dvp7z9m5Dg2ptLfXywbWQoSIRCB6KJAJfAY+Q06traxrsTUi+VKkRzSNmWT5P0ujGv
         ADLBiTESj2liuRERVJovPrHoIVPgj+o0sWC+IbBjciyOePUQriwdJjvZjBHKZicDYULB
         IyQoCh/LDzbBDZyQglzis7RshFNzAcxLxUZBWt4Jo/XoqvdfLDeX+je189eLdJAvXg1y
         RDFQ==
X-Gm-Message-State: AFq9FYLkTql+EvbtukKi7O+/0yFMiNj5mNwpqImZtaMNs3aySkyTNRm2
	iMwxbbzVl5krgnYTud+4QMGF3G2GcvQ/kpSiXDwrj7rwxC9vgnZEK1/4
X-Gm-Gg: AYBFou3e+3lBf4lqqJeRYk+6JA4vhjpRqiKshP2Kq1GsuR2tuzG+wpc7A/OaNg3r/+h
	Zxah9lgr8GM3Th9gBeW1AWapuY4byWbP7MrhPQJeOJqyqglpSmNnyoxNhm49j2FkaDMBnknHMSM
	/wZ26AFv5I5qmjA91Kk9Ri6shraWB5jvckcqHV3/58QuTObgpKr5njsYwCqK5Mc7LHV9gddmCwf
	w/i8p3hf8m9uaeNAUxMgppfLhJdP1Bvj7VtP7Xby4dozqXv/+IGj6eNoTFrJpEqwpmk1ngqdoWP
	TTg+SOoHallQIvdnWppebqu4KcsdxykS2P95sTNxcDVC5IMZ/JgKWChC0eOmLc/0qco1SeDvg3m
	rTXi9D5dTdXqzt2cLeKZsKtB9FTdNlEdGIIADNVavo1k1vLD72HWHrKPJV6OPNwC4qPSzhvEdp7
	rt+nl1NGILrg/xbfacuEdABofqQOYtYjBUZ9Rce/sGJ/AYTYMKDEHtUYgco5um8w4TCv3Rv/XMS
	Wj3nQ==
X-Received: by 2002:a17:902:ce11:b0:2e9:4b65:369f with SMTP id d9443c01a7336-2e9a69f2585mr70292505ad.34.1792416136168;
        Mon, 19 Oct 2026 06:22:16 -0700 (PDT)
Received: from [58.206.202.11] ([104.28.215.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea14ca2496sm782745ad.14.2026.10.19.06.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:15 -0700 (PDT)
From: Haoran Wang <haoranwangsec@gmail.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, haoranwangsec@gmail.com
Subject: [PATCH] ipv6: icmp: use skb_dst_dev_net_rcu() for echo reply and unreach
Date: Mon, 19 Oct 2026 21:22:13 +0800
Message-ID: <179241613335.5916.18191480036849517944@whr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

ip6_err_gen_icmpv6_unreach() and icmpv6_echo_reply() derive the network
namespace from the ingress device with dev_net_rcu(skb->dev).

    /* ip6_err_gen_icmpv6_unreach, net/ipv6/icmp.c:885 */
    rt = rt6_lookup(dev_net_rcu(skb->dev), &ipv6_hdr(skb2)->saddr, ...);

    /* icmpv6_echo_reply, net/ipv6/icmp.c:923 */
    struct net *net = dev_net_rcu(skb->dev);

Under a VRF, skb->dev is the VRF master device, so dev_net_rcu(skb->dev)
returns the netns of the master rather than the netns the packet is
destined to.  The route lookup for the unreach and the send policy for
the echo reply (ratelimit, IPsec, route) then run against the wrong
namespace.  The rt6_lookup may miss the route to the source, leaving
skb2->dev unset, and the echo reply is emitted/routed per the ingress
netns instead of the destination netns.

The IPv4 ICMP echo path already uses the destination netns via
skb_dst_dev_net_rcu(skb) (net/ipv4/icmp.c:1123 and :1267), and the IPv6
echo path still uses dev_net_rcu(skb->dev).

Use skb_dst_dev_net_rcu(skb) at both IPv6 sites so the namespace is
taken from the skb destination, matching the IPv4 path.

Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>
---
 net/ipv6/icmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index efb23807a..de4f39ca0 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -882,7 +882,7 @@ int ip6_err_gen_icmpv6_unreach(struct sk_buff *skb, int nhs, int type,
 	skb_pull(skb2, nhs);
 	skb_reset_network_header(skb2);
 
-	rt = rt6_lookup(dev_net_rcu(skb->dev), &ipv6_hdr(skb2)->saddr,
+	rt = rt6_lookup(skb_dst_dev_net_rcu(skb), &ipv6_hdr(skb2)->saddr,
 			NULL, 0, skb, 0);
 
 	if (rt && rt->dst.dev)
@@ -920,7 +920,7 @@ EXPORT_SYMBOL(ip6_err_gen_icmpv6_unreach);
 
 static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 {
-	struct net *net = dev_net_rcu(skb->dev);
+	struct net *net = skb_dst_dev_net_rcu(skb);
 	struct sock *sk;
 	struct inet6_dev *idev;
 	struct ipv6_pinfo *np;
