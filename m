Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2A43303E
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767947; cv=none; b=IWwQXWYKOMBxmHU2tVCAkc15dHKa15wydQdehd1i5KgzoiCEDOJEFHKDUCFPNDJtrrYlIgd0nh6FuyGLZH7gRWEO+8lX2q1k9LtohsugoZERK1mLlAm9OYydUisCeku1UiVPoE+YzYEXAckOq1IwKDu96T7X3zQgTMXC15aBVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767947; c=relaxed/simple;
	bh=/7yRsUvxh7DbnoPkQ9XfVg/D29oHCbcksFp7pgZTMz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eHodb/LM999NM93wMhTN1xYO2EFrKji7c2lxN9zwcH8s1aZuL4sMLWiAW4ajubdGuT9LU6JHZOHyDRoPr6u0Gdb2CihqM9iW4FuYVpwvvjop5VlwPhq+I1MH4cEJBXRrK5xL02bY6wnSFZ6hRuPTBvi9a2DXt9brbJYFdJKphhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BOe8jAp6; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BOe8jAp6"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9399b66e0e7so226313185a.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788767941; x=1789372741; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B531annUlBJyBycnNBVdBw5BuIP1+MR9mQSwoWlN9c4=;
        b=BOe8jAp6UBz8OTx6HNd69h0To7nHmDJsDsxMQOsSxyJqmbuQf4ORiDu6eAONa3qr8C
         OesuhLgNJ7gTFmM8sBrK5y50Fh3kVY/D9EbbNLLQit9HqZbpQHT0rTIWj+tA+rJ4tpXX
         TyYJ54a5WkEV6qkuwyRpBCWg/d+NdltoXeiiICi6sK7nDDyFXKK7jyGyr1Jza7dgb4eM
         HU2tAgI7pIwxbKXCgIIJYBpUd2yuFUPmbZLFgrz/hmc8HuxApmngGsb7jg6Vhq10C/sR
         1oddSEU3NlDX72JO0UsOnBiBcaxZsGzwmbWRgcgL8oyGnQlsYtpnEKe/ehRNl3VSwgfk
         sT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767941; x=1789372741;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B531annUlBJyBycnNBVdBw5BuIP1+MR9mQSwoWlN9c4=;
        b=TZ5wSJ0aeOIXxb7Pt41jASBiMhBSUYs7ro+4WdL2zI4vHcygdlJtdwJXiAq1pFLK4M
         a5m3XPircnD8sQ9fwxl4/FVe13gvq6CfKY4papMUmGIfC51/jpXnSsAwUXyGAw5vYdl0
         +EHhDSimhcE/3h/hr0iI4JAtovEO8hwqs06YvlAD40bkQWxUbQDDFhAqAlio7set9C7y
         WNjw8ahsDkLedBwt2NsEzfCs3L6uWzKtZlZkzFQZr1/7ztH9UZ3CS2lHDmpdplOMhIuv
         AymPzxfLL+pn2v7CGL7PKo/XFgggJL0X6jUx0PNFKufDMaQvkEoGtyokX/jujgzzWZQ5
         GcFA==
X-Forwarded-Encrypted: i=1; AKwUvByN26T67pjAV7LT52d31GUiSsIn+1IDspsKxW1vzIt3tMruTSbm070TLRMEX/Q14Hh1vTCCUAg=@vger.kernel.org
X-Gm-Message-State: AFuF++nQg6FlwpUDRhEUB1B08F614omrWAi4hf0J4yV2FlN5mupmKvIY
	r4wc67jK+pvDfFfyyqoUQVNh/f0sX/Qe12hIOERxaiXgzo77lqRqOTEjy6zlytt4GGOFNvm8vnc
	JDOghv0ql6LcVZA==
X-Received: from qkbbs42.prod.google.com ([2002:a05:620a:472a:b0:937:fdb:12e1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4693:b0:939:806b:f3f2 with SMTP id af79cd13be357-939806bf566mr2187613085a.31.1788767940615;
 Mon, 07 Sep 2026 00:59:00 -0700 (PDT)
Date: Mon,  7 Sep 2026 07:58:46 +0000
In-Reply-To: <20260907075846.2913645-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907075846.2913645-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260907075846.2913645-10-edumazet@google.com>
Subject: [PATCH net-next 9/9] sit: no longer rely on RTNL in ipip6_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Artem Lytkin <iprintercanon@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that SIT parameters and 6RD parameters are RCU-protected,
and fwmark/encap are annotated with READ_ONCE()/WRITE_ONCE(),
ipip6_fill_info() no longer requires RTNL to be held.

Wrap the attribute serialization in rcu_read_lock() and rcu_read_unlock().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/sit.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index c9049ab87e010eed5f53a342460ed10006083cd7..14ba3cfb304a83ee37e3be5b09a57c371f1977c3 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1846,11 +1846,18 @@ static size_t ipip6_get_size(const struct net_device *dev)
 static int ipip6_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	const struct ip_tunnel_parm_kern *parm = rtnl_dereference(tunnel->sit_parms);
+	const struct ip_tunnel_parm_kern *parm;
 #ifdef CONFIG_IPV6_SIT_6RD
 	const struct ip_tunnel_6rd_parm *ip6rd;
 #endif
 
+	rcu_read_lock();
+	parm = rcu_dereference(tunnel->sit_parms);
+	if (!parm) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+
 	if (nla_put_u32(skb, IFLA_IPTUN_LINK, parm->link) ||
 	    nla_put_in_addr(skb, IFLA_IPTUN_LOCAL, parm->iph.saddr) ||
 	    nla_put_in_addr(skb, IFLA_IPTUN_REMOTE, parm->iph.daddr) ||
@@ -1865,7 +1872,7 @@ static int ipip6_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		goto nla_put_failure;
 
 #ifdef CONFIG_IPV6_SIT_6RD
-	ip6rd = rcu_dereference_rtnl(tunnel->ip6rd);
+	ip6rd = rcu_dereference(tunnel->ip6rd);
 	if (ip6rd &&
 	    (nla_put_in6_addr(skb, IFLA_IPTUN_6RD_PREFIX,
 			      &ip6rd->prefix) ||
@@ -1879,18 +1886,20 @@ static int ipip6_fill_info(struct sk_buff *skb, const struct net_device *dev)
 #endif
 
 	if (nla_put_u16(skb, IFLA_IPTUN_ENCAP_TYPE,
-			tunnel->encap.type) ||
+			READ_ONCE(tunnel->encap.type)) ||
 	    nla_put_be16(skb, IFLA_IPTUN_ENCAP_SPORT,
-			tunnel->encap.sport) ||
+			 READ_ONCE(tunnel->encap.sport)) ||
 	    nla_put_be16(skb, IFLA_IPTUN_ENCAP_DPORT,
-			tunnel->encap.dport) ||
+			 READ_ONCE(tunnel->encap.dport)) ||
 	    nla_put_u16(skb, IFLA_IPTUN_ENCAP_FLAGS,
-			tunnel->encap.flags))
+			READ_ONCE(tunnel->encap.flags)))
 		goto nla_put_failure;
 
+	rcu_read_unlock();
 	return 0;
 
 nla_put_failure:
+	rcu_read_unlock();
 	return -EMSGSIZE;
 }
 
-- 
2.55.0.979.g7e5102b832-goog

