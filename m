Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C85C318146
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984917; cv=none; b=WrW5XFvI/ZuHPowkPO8tS1csWWVLNSg2ReUNqxRJZW2wpuFu606hvwgbvlyV09EJkUPV0NM8sXzMlxwLr65k3F1H0+XAABv/cBDjOB+0IWOnwA7ST9R84tBNY1aYAr9AKMV6lCz10riztv/ZWHup8uOzByR3hWUQTP/+7eE0tZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984917; c=relaxed/simple;
	bh=kNK2Duev4gkMgtGTDcI4HGjSiywypepDa+aIOJbp8xw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RjsMVWiZ//k9aA7YKp6C75LeziMt4VasXSu0/LAIlK7YNXpRmn6hXoh0QAb+I0pyfUehgyw5a7aBGhvpSYbb9gNlDmRyLcEjqM/i/3vgRzpEWSDaGxPrtyw8EP1j5yqCN2i2Xonqqgp+udzuYdkQC48rfPnvk8biCEcZ5m2ccJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aksrdd/2; arc=none smtp.client-ip=209.85.219.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aksrdd/2"
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90e8341cfb4so64347876d6.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789984915; x=1790589715; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbR7FJbCK3N53LPnfYUPxfGNLYiorbW8ycSYqGNLCqY=;
        b=aksrdd/2iqpcJrRLjNGOZOhkAhgJ8i1vbcX3CP6DM1a05yFpvg/UHfWv7vBGNz4flF
         9Wod6jDgWlhLRq8rI/9n8aqlfrdYyfy2uniz9dwNXEBF79QmeljM6cv5cZOSgt1Qiz6Q
         l9qq6EeebK8ItoN/7SSXmHBYrsEoIkfgqAVgajkGr6/P3vYqjP1YH2cT1NtYs/iV4q6E
         9AxsM9H7DadM5VvIFX7p+JpxGtf9qzeX7CgbTnIl77UHsHm1xfd2pmvHnv5UlqJJ9wjS
         C0yErGsBWrjjSnMn0BXb49XC4oODmm+lbQXo34GNIDhqK+ru4z4e+Er8Gt7Ug/5e+7dM
         1tEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789984915; x=1790589715;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lbR7FJbCK3N53LPnfYUPxfGNLYiorbW8ycSYqGNLCqY=;
        b=rDLmIE6xZ9n95wikGgS59LZSQzesBbuS4PIRtbcq2qDFsAX0qu4nmKKWgT+HyEjjCV
         BqSFPpQG39dMjspFWh2Y4C9cwAk2OkZfQMsgHE84aNBzGhk8zDKzqSqyKdOaBldgsowp
         7Ik3RJdLHZSJ/juOczecT7fF3Jq/8G8OVKs+gWeAAqU6swZDEIDlGEpmt2PXs4MDMcD1
         T9oL2+kb6idihJl/jBVYIz1x0vH9i8pvcWMTDdbZDhhvvgR6ijxEb92v/1MiMhARTiLp
         CNR7m/0JZKJqBMfIbl5714V54BdVJe1A8yLapmFLtG8OfuCIqmPMVrdYBsdmXcSWl16G
         mwMw==
X-Forwarded-Encrypted: i=1; AKwUvBwxTG0ks5eEVEQ8DJlKHW1Zn1Vqr6rFortmnnCRyLshj/phDQ979vV/zNso8ZPp0IPNTyOhGGU=@vger.kernel.org
X-Gm-Message-State: AFuF++lngacl437gZrFJ1enujcJgoJJNxaCjSN8h0rD4Txaewr3RHrAJ
	1DSbcq0/m1G+vm/5Hu2ZfC+hhaBODsByD9HUNPhm4LGqlaKOcZ3v3kIU12EIrbcRX+w6On+L5qf
	S2lsGUFhmjzi2cw==
X-Received: from qvbcr10.prod.google.com ([2002:ad4:56ea:0:b0:912:3578:4339])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3004:b0:912:517b:4102 with SMTP id 6a1803df08f44-912a8033db1mr97158706d6.52.1789984914961;
 Mon, 21 Sep 2026 03:01:54 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:01:39 +0000
In-Reply-To: <20260921100139.508191-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921100139.508191-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921100139.508191-9-edumazet@google.com>
Subject: [PATCH v5 net-next 8/8] vxlan: no longer rely on RTNL in vxlan_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that vxlan->cfg is RCU-protected, we can update vxlan_fill_info()
to run under RCU read lock instead of relying on RTNL.

This completes the transition to RTNL-less link info dumping for VXLAN.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index b505fefcef70ae9e1704eb5ad5f50a3d5d7488cf..2e975294c69eca9d4400d51115d6164ff7265087 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4744,7 +4744,8 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	struct ifla_vxlan_port_range ports;
 	const struct vxlan_config *cfg;
 
-	cfg = rtnl_dereference(vxlan->cfg);
+	rcu_read_lock();
+	cfg = rcu_dereference(vxlan->cfg);
 
 	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(cfg->vni)))
 		goto nla_put_failure;
@@ -4843,9 +4844,11 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		    &cfg->reserved_bits))
 		goto nla_put_failure;
 
+	rcu_read_unlock();
 	return 0;
 
 nla_put_failure:
+	rcu_read_unlock();
 	return -EMSGSIZE;
 }
 
-- 
2.55.0.1082.g2b9226bbc0-goog

