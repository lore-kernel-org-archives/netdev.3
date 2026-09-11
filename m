Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066283B71AE
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789107731; cv=none; b=LuZlAOx+mg+fywsEnmQQDJSLfujG/BvO7+VqKSkr8ow/c2LjCNutX8Ev1246qYvnUAaq8S1ZGcQegmeap3YwslTfUSvHDgmmE25DzL2VSV0sFpc02UdXfhm2+qohHFI2RzeX5D5fqHdO9IkmLIm1FY6EnZp26eNfAv3dRVv3I3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789107731; c=relaxed/simple;
	bh=yUZu2Tw5cTNdTR+6x7K8LbQFQb08j0Ip7OTrCeQBAp4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fX+2OJV4vJLPsd3Qpf8ZyFgr0oNi4n1zg9wVerFi5FMXbUbVi5rVt2G/lgeygWJapiB5V1zamgZgK9Hg3PD8evJBM/g0CzEPv20dMd0v0FRhjE3HkZLqmjBgCX0HoOrIfZz9Lz4nFAdosOEwpDJZU42LZxG8YcEGY66jpfTQzWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=txsP+FlH; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="txsP+FlH"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52fc0097865so13923501cf.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 23:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789107729; x=1789712529; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aleyMRY4Te++rbmAcMtoNtn9ypjX6+IOgkl+zkK0jLo=;
        b=txsP+FlHH+4PTfUyh9LPRpb2X77jbp1zyS+Yw2Q12dT44opvt7aDcbLDmINggyaAu2
         cGkEFzTE2bfedWbbQ3t6Il8EgM+Mj4QG/YmWf3ENOL/DxmNVEIaYqAyTL0Kw7UO/jZSp
         YdheYr8aza5kLedUfp471xyMruOgqCZSUu+0dl1SO/Mha62rSd5mQciecWjdkTZaqwie
         WU/8P4lG3uN3BS4+tvkBnqZy2b3C3nQaQivWT2dYLiboMAvGWWB8chVuUTkJ+mZGEw7+
         6P6XQgN8DhSam28BkV7DZKYPHCke8nAhuy9B4rvV0aIinbzfW0+3owpqITaHlu+kTgxg
         nOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789107729; x=1789712529;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aleyMRY4Te++rbmAcMtoNtn9ypjX6+IOgkl+zkK0jLo=;
        b=dhHVOywCfEU2Jx4DV5roM2W7Smr3Kof7DeI9uAHW+y6lCESnkjffcpVx7/WZiSoSRh
         jm4nYXp/h1GvmlC3qOBu/G9kjQWvUqcQLQfXO7CnK/VY9wznB+fYq77W0EfmFv2nVtEh
         +gbYV56TGAHY03sRPSmgoWHA+RnmpRv0rdMSDePsSv31qg7jlJMXJDzxuF/D9zFssF5l
         FBaVc1VzXXxOlpc3TwYHsWhPPVGTnlNk7991H5NBApyKgCWV5JAo4ckvQU4y1ZaKctPP
         xJlqpkXEwDDQsjjc4+omuLEIDk7YMawqcVfg9t0AJop547yRYp1x6GODnEmmJzI6Cb1S
         yX2A==
X-Forwarded-Encrypted: i=1; AKwUvBwC3thgXOnd1SW2XmtsPaHXSrOwqZowrk0quBxRVx9Zm3iU6VRyg3ffinnERbKsPS8yEANv7ig=@vger.kernel.org
X-Gm-Message-State: AFuF++lJtPOB1VHPsYiHW5y1vIIKQG2zawH+uuZXCKZyZIu3ho96ZgVz
	13TMOntyMFFxcWE+O4mOT1PaNUSYcXEr9/jfVcV4LidnPxudTNGF/njdTu8aERbKkMQ3nccxxoX
	XDRCET8PB9PzEXQ==
X-Received: from qvwo9.prod.google.com ([2002:a05:6214:1809:b0:8ef:f4a8:bb63])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:281:b0:52e:3a38:8cb0 with SMTP id d75a77b69052e-530c84f5071mr45537591cf.12.1789107728651;
 Thu, 10 Sep 2026 23:22:08 -0700 (PDT)
Date: Fri, 11 Sep 2026 06:22:00 +0000
In-Reply-To: <20260911062200.231316-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260911062200.231316-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260911062200.231316-7-edumazet@google.com>
Subject: [PATCH v3 net-next 6/6] vxlan: no longer rely on RTNL in vxlan_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
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
index 8b7558eac049d2f83ab5f68aca2dad62bce9cbc7..8f008ec6d2e98dc015649fd6e26a1346012c2238 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4725,7 +4725,8 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	struct ifla_vxlan_port_range ports;
 	const struct vxlan_config *cfg;
 
-	cfg = rtnl_dereference(vxlan->cfg);
+	rcu_read_lock();
+	cfg = rcu_dereference(vxlan->cfg);
 
 	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(cfg->vni)))
 		goto nla_put_failure;
@@ -4824,9 +4825,11 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		    &cfg->reserved_bits))
 		goto nla_put_failure;
 
+	rcu_read_unlock();
 	return 0;
 
 nla_put_failure:
+	rcu_read_unlock();
 	return -EMSGSIZE;
 }
 
-- 
2.55.0.1007.g17ff1f9808-goog

