Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA5A3BCD3A
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717688; cv=none; b=VJa2lWtvliEnHl2Wfpoy06IGu53ZfrJ1FPjBW0KQ4sBMdhvSeZNJA6YgralR4XhSCQ64A2490N7gF36x6+4q9QipaHYJaBKNobquFvTbrIXKM+NaD43Yn0KqdlgM+jH6+AxrazPy+RhQr20sphu+ON65IUg16lB/hJxbXSXf3mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717688; c=relaxed/simple;
	bh=6J4OaXaYXjKIdUFBNXtKAbNe8b0tWHzINyC0x9L4618=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qVbaNu+Xb/uFvs+ZYdS9hWktSdVVtgpI9vh/DZ57t73aDWu8x1+tg+m/XH7E9ULWtNqhURE4P9DkxtStgVOea4HqU8+TXeyDlbbI6v/0P0/zIS2GlYGnReAwXZyhfnAriQJNOhyNaj79zUbxaq+D5Z+/3Ux181WDy/h+Tj/LXBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kaOzGfB9; arc=none smtp.client-ip=209.85.219.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kaOzGfB9"
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90e8472ee1eso49558556d6.0
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 11:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788717686; x=1789322486; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hpnX3LfGWMlyffMGZjgkwir/odK9mr6DOoPHClgvEKA=;
        b=kaOzGfB9D00cXJhFARkZFM1OqPRUsUdN9peohXWtNTWHjroPsQdHAPEN5v9FDVGTKN
         75Alrh3gg9O9M6yoe1YPsDl55I+9SbL7CljbwUnEp7a/p9UCwjsPk2JEO5RbIvAUTgn3
         5Jy7EtnjT7OATvykb2B52hOvSX7L+a904vNLQgnpAnEQJTtlkw//tWE4Sr1ja6LBjNJT
         cx1ATLnw30Mhz96YfQUev4sp1K0anKEsxJ/6MLAGk4KczivEy4zcWJF3ztcbFx58+7ko
         13NwazhHfHBklc0O2MDIN9TXERboUklh1ocyGGKOlFtOXLO4jO3G/UK0lDlSd08CHyz3
         VwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788717686; x=1789322486;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hpnX3LfGWMlyffMGZjgkwir/odK9mr6DOoPHClgvEKA=;
        b=HOERTcddkHm926bNrHsf32KyZr2RWFsOTf096Uxdgm3ilXWLEWCTP9znhCtxtnqaRN
         f0Wg3//brAKrG1/xDHDeFHGOpNQM6xj+bgve9Eu5uk/MmO/XwLBvqrCs0U9gP5SjuJI0
         rVXQkWqREq33FsJyTW6yncxJKWXoiIh3SCzGNsExjsKdVcj63vTDoaCdunLcCjF3YLET
         5pnlORqwlC+X2IuzS7IHMrf0j2ySCBL3q/1ffL5vwNOTdzNLfACqjgQgvlakSJU+PbHX
         Px9DecG76XjS6/dOYzPrdBWH9QVWxVLFAQwtrSOZYKWxv5SErbiTVrE+6OB9RM7gzEzm
         +rpg==
X-Forwarded-Encrypted: i=1; AKwUvBzBLv3MyeKckzUmV4EHtyq2AuqH/Ah7apZ1lWYYOt6Lk9uqBYjW9TZZAFas0GbgfE3IfrIAVD8=@vger.kernel.org
X-Gm-Message-State: AFuF++kw34FzJn9j+jDxZleXVGM5nhaDAP/8HmmeAmqPIgZo59GDwnvR
	aqD8yQTGXTC3QKfCnqJts92k+FY/1bBejGNtNZXoSi7BU4W4dUOw6mVUuhWVUp4sG7ObTinHgEo
	iRiD+Qww/gG9nSQ==
X-Received: from qvry6.prod.google.com ([2002:ad4:5306:0:b0:910:5448:f6c0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:428d:b0:90e:96d1:7b95 with SMTP id 6a1803df08f44-9103f0474a0mr251899176d6.24.1788717685405;
 Sun, 06 Sep 2026 11:01:25 -0700 (PDT)
Date: Sun,  6 Sep 2026 18:01:11 +0000
In-Reply-To: <20260906180111.1973188-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260906180111.1973188-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260906180111.1973188-9-edumazet@google.com>
Subject: [PATCH v2 net-next 8/8] vxlan: no longer rely on RTNL in vxlan_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that vxlan->cfg is RCU-protected, we can update vxlan_fill_info()
to run under RCU read lock instead of relying on RTNL.

This completes the transition to RTNL-less link info dumping for VXLAN.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 2b7da90ae2da3d0d8cc305d24d071cbc74ec2e6e..fd993a95501b02cc7891b434b258420de1ba4c21 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4712,8 +4712,14 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	const struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct ifla_vxlan_port_range ports;
 	const struct vxlan_config *cfg;
+	int err = 0;
 
-	cfg = rtnl_dereference(vxlan->cfg);
+	rcu_read_lock();
+	cfg = rcu_dereference(vxlan->cfg);
+	if (!cfg) {
+		err = -ENODEV;
+		goto out;
+	}
 
 	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(cfg->vni)))
 		goto nla_put_failure;
@@ -4812,9 +4818,12 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		    &cfg->reserved_bits))
 		goto nla_put_failure;
 
-	return 0;
+out:
+	rcu_read_unlock();
+	return err;
 
 nla_put_failure:
+	rcu_read_unlock();
 	return -EMSGSIZE;
 }
 
-- 
2.55.0.979.g7e5102b832-goog

