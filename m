Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61B447A0D7
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907502; cv=none; b=n6qxn679v1goJNqRRt52+ZhrLFc9Zorye8bEkN25g6IWaNrRco1aEpqFIRBBqRubOM+Db58YPUFQpwzQ584bThHQ1MhCgJ3kUxxEkpb6csimivmNderyK2Me+h4R7f1XAaJkvVf9YjLkbVcbEYqkMZJEtnvthpuymAB16T2ttb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907502; c=relaxed/simple;
	bh=A++/Fa1J7vWTeDGMOhrcC13fz45+/4uyceOQLWs19Ks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FAo0nYHP1Jg5dhoit4kJEWgdDKSPuITTcELn29DhdXKyVYda4R6cKw4hnLDwNtBz1lxgUtIZIxEgVKccE+xicT1mWhhrsAu68XU2VaxFDzE6DeT9NmeCigcPF8MyJ1pWP5b/wwq2+KTwwSuwonsNe9DNtcFyE3Ze/g6Ye9N3Y+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULH7ZdiD; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULH7ZdiD"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-92d1cae5740so70485485a.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 05:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782907500; x=1783512300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vILHl5639viwVNz7I5T2fTWP8hBiFkbWvv2jej9GrLc=;
        b=ULH7ZdiDqtPIETNBA6ChjvRzEugAOJ+y5Hg2DEgHD58xRAkbMSjRDcxYWMXXpzPFlv
         HblPBrvcqcRKg27vN7Bru8M+KddZjj3wAiFqdjs9Z17H3NlVhgJflx7btyRkNdCemfHB
         jIzJFliAnl+lmFzqRn5tvDERqH420BLJeYv+jlbcqwOWabC0umSSsK81ORWz1PKuD6vn
         87IXgKWa6fEVljYdRe3VnTakCiExi2WHOm0Tp5LRpQRP8c00ihO/R2vkVPQWy6/rGQKw
         XENoAAwoLeDT9tcR4v67Yk04/CrkNSta1fG/6OBDwiiFBcLmFvHIVnKVI6gUFT10BBCF
         /3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782907500; x=1783512300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vILHl5639viwVNz7I5T2fTWP8hBiFkbWvv2jej9GrLc=;
        b=nSVeWzSl9JyB3sFA6w+ooFI1raHERKaiNpvDmGn3EtGczs7RmRXPhqrtiZExPQpDYu
         u3JzlCrQRo0nibsEHqOA5o5PCqEgi0Nsd8WnNTzGjeRZYPWyFmkG7wzDotIuBV/ZmupG
         4XlhLcTca0cPQ0e3lFEOPo1OR6NshVq6BnvN2OZb6D4Yo+72AO+K+xjp+UVIxofz6DzY
         IJldK8LQJD0r8ArRlEtWkDG8LfZ8BJTUF7aSYeL/UvDhOTGGeWkibt2cYTF5Ek3VqMpz
         NY6ZxBovgizGzi8RWfcO3/aHd5OFs6QvMWqo4BrZw9lpKjoIanYQoCf1R39DN9ZSidMr
         iDTg==
X-Forwarded-Encrypted: i=1; AFNElJ9pM49+7CbC4X6R7U5RNXCPNJ8fvfZaXrGUHVEMQtpo2Got9vZwS+BUs7JKMSEPaSq3iUqaMP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhmvxt4nJiNbQEj+mnhcEymPDXCn+swzb6126EoM/P3RsKCjJ1
	z3phZaEyjD91pYKh500cnvOmxCX6x0wnpWuKgPrLEUMCYrsqm6Bbi0oHAhVwInluNklCIFHpZFI
	vlT+WeQnQTQzmFQ==
X-Received: from qkpr10.prod.google.com ([2002:a05:620a:298a:b0:92e:5116:44b5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:ab18:b0:92e:7cc9:a888 with SMTP id af79cd13be357-92e7cc9aa48mr7057385a.2.1782907499452;
 Wed, 01 Jul 2026 05:04:59 -0700 (PDT)
Date: Wed,  1 Jul 2026 12:04:54 +0000
In-Reply-To: <20260701120454.3533252-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701120454.3533252-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701120454.3533252-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] geneve: make geneve_fill_info() RTNL independent
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that geneve->cfg is an RCU-protected pointer, we can update
geneve_fill_info() to read the configuration under RCU read lock
instead of relying on RTNL.

Also add const qualifiers to the dereferenced pointers where appropriate.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/geneve.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index c777c1a1fa930d74768a659e16380d719f12a6b2..7197f90eeb0f3a381fac5be4a96d6570ca4fccb1 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -2483,17 +2483,28 @@ static size_t geneve_get_size(const struct net_device *dev)
 
 static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct geneve_dev *geneve = netdev_priv(dev);
-	struct geneve_config *cfg = rtnl_dereference(geneve->cfg);
-	struct ip_tunnel_info *info = &cfg->info;
-	bool ttl_inherit = cfg->ttl_inherit;
-	bool metadata = cfg->collect_md;
-	struct ifla_geneve_port_range ports = {
-		.low	= htons(cfg->port_min),
-		.high	= htons(cfg->port_max),
-	};
+	const struct geneve_dev *geneve = netdev_priv(dev);
+	struct ifla_geneve_port_range ports;
+	const struct geneve_config *cfg;
+	const struct ip_tunnel_info *info;
+	bool ttl_inherit;
+	bool metadata;
 	__u8 tmp_vni[3];
 	__u32 vni;
+	int err = 0;
+
+	rcu_read_lock();
+	cfg = rcu_dereference(geneve->cfg);
+	if (!cfg) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	info = &cfg->info;
+	ttl_inherit = cfg->ttl_inherit;
+	metadata = cfg->collect_md;
+	ports.low = htons(cfg->port_min);
+	ports.high = htons(cfg->port_max);
 
 	tunnel_id_to_vni(info->key.tun_id, tmp_vni);
 	vni = (tmp_vni[0] << 16) | (tmp_vni[1] << 8) | tmp_vni[2];
@@ -2573,10 +2584,13 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    nla_put_flag(skb, IFLA_GENEVE_GRO_HINT))
 		goto nla_put_failure;
 
-	return 0;
+out:
+	rcu_read_unlock();
+	return err;
 
 nla_put_failure:
-	return -EMSGSIZE;
+	err = -EMSGSIZE;
+	goto out;
 }
 
 static struct rtnl_link_ops geneve_link_ops __read_mostly = {
-- 
2.55.0.rc0.799.gd6f94ed593-goog

