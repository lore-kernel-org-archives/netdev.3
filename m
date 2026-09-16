Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED014F55BD
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565143; cv=none; b=BkMHYN1GzK+C+aSSuu2Uff0yqDHFQFGLu15VhlpIvsE0RT7Fa9C1G5wbJ7fk1TBvQY8lHIwX016YIq4zmreHIL8kHwu5napzlkN0g0LQ2nlrq/g+NbdjxEicTu3jzPvFXUjNSvpRMCQKcbzC+xRGmMtdRVgGBTSG4Yk+szTenyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565143; c=relaxed/simple;
	bh=1P1zl+m8mMPk2TBgRmNO+iO7Hgbb/nAwB2YYMYah6qM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NnDrZwSXNOGejiOijLQhLBuJEj4S4C19eNsLGPIFwqh78tXOUdBrb3X7yw2lzRfnO2gQ+BIorpoBz5HO/jBCfO/OpFGG6yPuyUP4l8hgCfRC6F+fdOUxlgsyxkgiDbMQDT5eNljQiND8BfyWuDsCxNXyigJEIwHRWD/PadWs5gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hF/UH9ef; arc=none smtp.client-ip=209.85.160.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hF/UH9ef"
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5328827bb8dso5891421cf.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789565137; x=1790169937; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+od095t3PyFNc9i8+hOQCo4y7uNWPel9xVkzSSrGnOE=;
        b=hF/UH9efkDTHEiwcuf/S7pCEt3sI2O7zGhrpg7DdzDeLV2v/b6rq9Z3KjNmv+FiKJA
         +4yPzJaFaEG7Ugt+DmdNDwY7wrntCvDyZyryQaIxvKqbNGLTPFDqQ+Fr9VTDmZ9FL4sY
         4QRbYd3CfTtKIHWZ4CGwMqyz9hTA8/mQzr8pFRFV30l5Bl0fiwwVsqCs87HzHWtnQvyk
         Ad7fLAIxOpJgpA5FjyKQXp+voPXbq0tK98A3T1cAH5YSnTTtHl3FaAphJZNajQYuUZyR
         883bO/QnInTAgY8b9l31vNQ42qjLLyw5zYpo514I+reqUgw0j6FFI4l78dL+OfGYqaPl
         ZU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565137; x=1790169937;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+od095t3PyFNc9i8+hOQCo4y7uNWPel9xVkzSSrGnOE=;
        b=uK7bB2RKEv8iR1r96+S219asWK6neN6EyzrIvI1xubtgIWQ/zI/rjEhymGTISL88oI
         zCfSyHyCgvNUzjyXjyCiHqRoVz1qTMKlg68IP8R6vJWlpYh1oJFlOvCpZS7HjeAGfGpK
         AZvqvxkkk8H3lQp22uSxCwQEeKZ+qanzKbTnT7KFmr6h+aCaC5JspxEuKwuhvHf3sT14
         um6x1mvPf9ORoxcS0+XfQ6X4kjdIDdn6fDSjj/T0sVcavLXodAnLOQBaBXUvNw9+YFzh
         53MqAhBG+tu2LSuqrvZUii1jSwHCiXWmdMrvMn0gyZX7yA4D8O2i77vpdH78DED2jZz/
         HUAw==
X-Forwarded-Encrypted: i=1; AKwUvByJrm6zPPuOsKThj0w8j32JHTWIfpE93kuA2Opkck17zbuPqJSEyEz8a3jyhF6x6h4zmLY47l8=@vger.kernel.org
X-Gm-Message-State: AFuF++mYC1dF8UWfVTgjYN4oayPOhp/R+KBaJiCQ0w9xDz0+7As8YIx/
	O7NNMrFAEWbAQ9L6a1trYG3mo7jKCb9l9xW7QeqoeDrifm+Db31+sBSRDwFvcdqVAvc5O2IrB4x
	p91J0vZIAS3i8LQ==
X-Received: from qtbs16-n2.prod.google.com ([2002:a05:622a:e490:20b0:531:10e9:3f5f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5e88:b0:52e:2e04:44f2 with SMTP id d75a77b69052e-5327ee403d9mr45791691cf.20.1789565136794;
 Wed, 16 Sep 2026 06:25:36 -0700 (PDT)
Date: Wed, 16 Sep 2026 13:25:32 +0000
In-Reply-To: <20260916132532.1785657-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916132532.1785657-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916132532.1785657-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] vlan: no longer rely on RTNL in vlan_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

vlan_fill_info() used rcu_dereference_rtnl() to walk the egress
priority map, forcing "ip link show" dumps to hold RTNL.

The egress priority map is already fully RCU compliant:
entries are published with rcu_assign_pointer() and freed with
kfree_rcu() from vlan_dev_set_egress_priority() and
vlan_dev_free_egress_priority().

Wrap the QoS mapping serialization in rcu_read_lock() /
rcu_read_unlock() and use rcu_dereference().

Now that all the involved fields are annotated, use READ_ONCE()
for vlan->flags, vlan->nr_ingress_mappings, vlan->nr_egress_mappings
and vlan->ingress_priority_map[].

Also add missing const qualifiers in vlan_get_size() and
vlan_fill_info().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/8021q/vlan_netlink.c | 48 +++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index 71cb98950511fe30f9b117834ce8b9107889f0cb..8c0c33cff4539f22d7fdca2bec68dc484c55209f 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -209,7 +209,7 @@ static inline size_t vlan_qos_map_size(unsigned int n)
 
 static size_t vlan_get_size(const struct net_device *dev)
 {
-	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
+	const struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
 
 	return nla_total_size(2) +	/* IFLA_VLAN_PROTOCOL */
 	       nla_total_size(2) +	/* IFLA_VLAN_ID */
@@ -220,60 +220,72 @@ static size_t vlan_get_size(const struct net_device *dev)
 
 static int vlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
-	struct vlan_priority_tci_mapping *pm;
-	struct ifla_vlan_flags f;
+	const struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
+	const struct vlan_priority_tci_mapping *pm;
 	struct ifla_vlan_qos_mapping m;
+	struct ifla_vlan_flags f;
 	struct nlattr *nest;
 	unsigned int i;
+	u32 flags;
 
 	if (nla_put_be16(skb, IFLA_VLAN_PROTOCOL, vlan->vlan_proto) ||
 	    nla_put_u16(skb, IFLA_VLAN_ID, vlan->vlan_id))
 		goto nla_put_failure;
-	if (vlan->flags) {
-		f.flags = vlan->flags;
+
+	flags = READ_ONCE(vlan->flags);
+	if (flags) {
+		f.flags = flags;
 		f.mask  = ~0;
 		if (nla_put(skb, IFLA_VLAN_FLAGS, sizeof(f), &f))
 			goto nla_put_failure;
 	}
-	if (vlan->nr_ingress_mappings) {
+
+	rcu_read_lock();
+
+	if (READ_ONCE(vlan->nr_ingress_mappings)) {
 		nest = nla_nest_start_noflag(skb, IFLA_VLAN_INGRESS_QOS);
-		if (nest == NULL)
-			goto nla_put_failure;
+		if (!nest)
+			goto nla_put_failure_unlock;
 
 		for (i = 0; i < ARRAY_SIZE(vlan->ingress_priority_map); i++) {
-			if (!vlan->ingress_priority_map[i])
+			u32 skb_prio = READ_ONCE(vlan->ingress_priority_map[i]);
+
+			if (!skb_prio)
 				continue;
 
 			m.from = i;
-			m.to   = vlan->ingress_priority_map[i];
+			m.to   = skb_prio;
 			if (nla_put(skb, IFLA_VLAN_QOS_MAPPING,
 				    sizeof(m), &m))
-				goto nla_put_failure;
+				goto nla_put_failure_unlock;
 		}
 		nla_nest_end(skb, nest);
 	}
 
-	if (vlan->nr_egress_mappings) {
+	if (READ_ONCE(vlan->nr_egress_mappings)) {
 		nest = nla_nest_start_noflag(skb, IFLA_VLAN_EGRESS_QOS);
-		if (nest == NULL)
-			goto nla_put_failure;
+		if (!nest)
+			goto nla_put_failure_unlock;
 
 		for (i = 0; i < ARRAY_SIZE(vlan->egress_priority_map); i++) {
-			for (pm = rcu_dereference_rtnl(vlan->egress_priority_map[i]); pm;
-			     pm = rcu_dereference_rtnl(pm->next)) {
+			for (pm = rcu_dereference(vlan->egress_priority_map[i]); pm;
+			     pm = rcu_dereference(pm->next)) {
 				u16 vlan_qos = READ_ONCE(pm->vlan_qos);
+
 				m.from = pm->priority;
 				m.to   = (vlan_qos >> 13) & 0x7;
 				if (nla_put(skb, IFLA_VLAN_QOS_MAPPING,
 					    sizeof(m), &m))
-					goto nla_put_failure;
+					goto nla_put_failure_unlock;
 			}
 		}
 		nla_nest_end(skb, nest);
 	}
+	rcu_read_unlock();
 	return 0;
 
+nla_put_failure_unlock:
+	rcu_read_unlock();
 nla_put_failure:
 	return -EMSGSIZE;
 }
-- 
2.55.0.1032.g73a4cd73de-goog

