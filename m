Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD2E4F648E
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565310; cv=none; b=dmbrD/SvHkeSU3zLlpF4skyjeBRLl8ugd60WHVIYqpKE/KlBvcWlyFHcNmUdpY7fYMXqocae6psz1gJWan5t4i5Dmuk9d7zw09NPq+cAhXJgbBuUmTqEx+L4SlBrMjQFQDcLgFR1uGGzimk5mFcvUH/hPLHJnL6G8dO3jw+eoSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565310; c=relaxed/simple;
	bh=fPyCOloq5l1SFrzJDr2ND2xWq+e02v0qTHwLynVA3Co=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZAcE6vOTm7GqnOuhLnSpKgCmAauBBCW7slyhiCWqRdcYLjmgMnA4o8LNH4wM7ahsEFXOALC3A6SWaOKZtVWMs0mjQx5gt1v5oooYcUHpUkmnx0N24SRM3m2iKDOPHFlk5X3IJbIxf3qmW2fIFpAztjIql2ZNI71ZxOgdkNGz0Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HAogRK/K; arc=none smtp.client-ip=209.85.160.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAogRK/K"
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53000c06184so185517831cf.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789565307; x=1790170107; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m1JvXy2nXpgoeE9mgRX+MS48Du0oEssSMEfevUwb+14=;
        b=HAogRK/Kj4UIoyP957czg6zU0CrvxUpOztpV/n3WG+WG4qjVoB5ADYLCYva1yib0zm
         8DtoXBfh4yksxiI5D+i36+IcUtze/kuc13pk4QjYDDHVMdXzPoK2mp60hULg0MD0iak7
         yvJW0MyEcqdojSbXOLD7ev+AwAGlepodELgI72xdrUznpIHXCorjYYIXK92c5xWihsFS
         3jAfhPX+HLBBHFo3ZoW9EtuwLIMg1H1mnwz3A3chHbA5ppyFDxR62C7qsUF/asUeQ4s0
         IharPW40wheBcgMGABlErMAoIgZoZh9U8wqfxy21qgVVTB0mGRTPdbLTnPyN+VmfkKNZ
         z/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565307; x=1790170107;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m1JvXy2nXpgoeE9mgRX+MS48Du0oEssSMEfevUwb+14=;
        b=Dy/+xAuye+eE5mbKOlKYnUN32TPAvCyfsitMbIbTrCIq108ZxB81kcJiWytL53z5it
         fqx/e/n8CLZu9F0ZrhYWo/vJlZnWffcV1uhagDNpO6tApzJJdI9erIxa5MgeDv0K/wnu
         2M3qZz7kZFMrC7B/jgbfJwTk0NTb9xSYAWhuZtc8TyuWb6X+27d1Ahow1NQQ789mTEvc
         NZbtbex5TdhhITupgiuSun3p41vtLO60/c4vWw9fDklPoJSXkiyxM25dTrGbKRPdClX5
         ZRvgIQsijXVznxMKlU93PFLK77AtpLWcAgiFN9uXLlXffbFoMeFZf6F0l2TBYW1KZ3jm
         MrlQ==
X-Forwarded-Encrypted: i=1; AKwUvBxr73KIwz7Dc4j86WXYH1GoFf9MSovtYhaRJXPhHAXU5/LKM/CWGyFqNmTGGfbC5lExJcyQTaM=@vger.kernel.org
X-Gm-Message-State: AFuF++mhIMO3oAE2VdSJ9zNBwkDG/QErUuiRp5t9bBUXaBeAuAI0JgaA
	gQH0G71IjrHj1N2rhjCCx6zsgRBW1AjvrFE7ldvIGz8inj433a/TBnN8jHmxrX1WyxoOJiTFoTe
	/1wMhqpvSBRP+cQ==
X-Received: from qts26.prod.google.com ([2002:a05:622a:a91a:b0:531:1aa:c419])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:90d:b0:530:e6b9:f5d5 with SMTP id d75a77b69052e-5327eea9eacmr43401391cf.36.1789565306807;
 Wed, 16 Sep 2026 06:28:26 -0700 (PDT)
Date: Wed, 16 Sep 2026 13:28:22 +0000
In-Reply-To: <20260916132822.1791040-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916132822.1791040-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916132822.1791040-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] hsr: no longer rely on RTNL in hsr_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

hsr_fill_info() used hsr_port_get_hsr(), which walks hsr->ports
with hsr_for_each_port_rtnl(), forcing "ip link show" dumps to
hold RTNL.

hsr->ports is an RCU protected list: ports are added with
list_add_tail_rcu(), removed with list_del_rcu() and freed with
kfree_rcu(), and the data path already iterates over it with
hsr_for_each_port().

Add a local RCU variant of hsr_port_get_hsr() and use it from
hsr_fill_info() under rcu_read_lock().

The remaining fields (sup_multicast_addr, prot_version) are set
once at device creation. hsr->sequence_nr is now read with
READ_ONCE(), since the transmit paths increment it under
hsr->seqnr_lock only.

Also add missing const qualifiers.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/hsr/hsr_netlink.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 88940e8014b24f35d6a54f49fb7ac82956aed383..fc7820eae884132dbd5f4e62a4397d2c6d1bf79d 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -147,44 +147,61 @@ static void hsr_dellink(struct net_device *dev, struct list_head *head)
 	unregister_netdevice_queue(dev, head);
 }
 
+/* RCU variant of hsr_port_get_hsr() */
+static struct hsr_port *hsr_port_get_hsr_rcu(const struct hsr_priv *hsr,
+					     enum hsr_port_type pt)
+{
+	struct hsr_port *port;
+
+	hsr_for_each_port(hsr, port)
+		if (port->type == pt)
+			return port;
+	return NULL;
+}
+
 static int hsr_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct hsr_priv *hsr = netdev_priv(dev);
+	const struct hsr_priv *hsr = netdev_priv(dev);
+	const struct hsr_port *port;
 	u8 proto = HSR_PROTOCOL_HSR;
-	struct hsr_port *port;
 
-	port = hsr_port_get_hsr(hsr, HSR_PT_SLAVE_A);
+	rcu_read_lock();
+
+	port = hsr_port_get_hsr_rcu(hsr, HSR_PT_SLAVE_A);
 	if (port) {
 		if (nla_put_u32(skb, IFLA_HSR_SLAVE1, port->dev->ifindex))
 			goto nla_put_failure;
 	}
 
-	port = hsr_port_get_hsr(hsr, HSR_PT_SLAVE_B);
+	port = hsr_port_get_hsr_rcu(hsr, HSR_PT_SLAVE_B);
 	if (port) {
 		if (nla_put_u32(skb, IFLA_HSR_SLAVE2, port->dev->ifindex))
 			goto nla_put_failure;
 	}
 
-	port = hsr_port_get_hsr(hsr, HSR_PT_INTERLINK);
+	port = hsr_port_get_hsr_rcu(hsr, HSR_PT_INTERLINK);
 	if (port) {
 		if (nla_put_u32(skb, IFLA_HSR_INTERLINK, port->dev->ifindex))
 			goto nla_put_failure;
 	}
 
+	rcu_read_unlock();
+
 	if (nla_put(skb, IFLA_HSR_SUPERVISION_ADDR, ETH_ALEN,
 		    hsr->sup_multicast_addr) ||
-	    nla_put_u16(skb, IFLA_HSR_SEQ_NR, hsr->sequence_nr))
-		goto nla_put_failure;
+	    nla_put_u16(skb, IFLA_HSR_SEQ_NR, READ_ONCE(hsr->sequence_nr)))
+		return -EMSGSIZE;
 	if (hsr->prot_version == PRP_V1)
 		proto = HSR_PROTOCOL_PRP;
 	else if (nla_put_u8(skb, IFLA_HSR_VERSION, hsr->prot_version))
-		goto nla_put_failure;
+		return -EMSGSIZE;
 	if (nla_put_u8(skb, IFLA_HSR_PROTOCOL, proto))
-		goto nla_put_failure;
+		return -EMSGSIZE;
 
 	return 0;
 
 nla_put_failure:
+	rcu_read_unlock();
 	return -EMSGSIZE;
 }
 
-- 
2.55.0.1032.g73a4cd73de-goog

