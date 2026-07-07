Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19D42086A
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 04:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783398645; cv=none; b=AsUkWzImqb5aQ9SUfzmuVjw1ZPLD7HXPqaOFCmfrq980R7AKRsqmCxcDAvRl6yYX9EILSq/4nct1epDP+y/RAEFybiaOt9QzdqqXmvCvTjr6j37of8u6R519yLLlqo2TM4rqQSNpfEVVawP0Luz49uGRpCjmlEt/CL1JfjW7r28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783398645; c=relaxed/simple;
	bh=M2hWQFzhSKgrdKI6qiemtu4JnDynZZgc1Roe2FLVgwE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LV3dZF8qHfY9256sOXq6SGnoTakyoF8uXgV62PXXH/YcfWzDOUN7/l5yODW0o6Awqll5zXR9TbOn//DmZebfTo56qwHxzDMLzRGozIAUcUb/R7WiYqHdDAhCB8aY2pNSCcRYFLITIII7IjNnLNNl1ansLnW9tlTSH40quck6UB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ntYWJ1A5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ntYWJ1A5"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c7f385887bso57278025ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 21:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783398644; x=1784003444; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IGoxbQSfVWHXD3Qk6QxK4PGiP7s64rwM9sU/cWIRVkM=;
        b=ntYWJ1A5rDdk27egIHys6oN9wm4rlbcsopa9cTWX2My9n5YrYx6jUlyDXekJE0W/CE
         cH34g8XdsAkM7bwqA/aHX8I8RO8iMCur6TvUlvZFfpakyQ5eVH4dXQTgCqPc3Lzc0V/e
         azRzv92BJ9NkpGnFwGY2alBFSaNK8a3K96N6NLAqMvkCgU9Gmr0NZ2a4+0xkKUM/Z9dD
         Jbn0dlPBQ01PHIbxpskccBxq8eXELf+NK8lYmsLnTzxgbj+XTCfT3XpafceR6Oo58u84
         Hs4Yj0hvbujSORCYQGUsLiJ2BTfzhIsds1QB1nlTqtV1ufjiU98QrZ6L80K/4vD4TO9k
         XM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783398644; x=1784003444;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGoxbQSfVWHXD3Qk6QxK4PGiP7s64rwM9sU/cWIRVkM=;
        b=Fj1Lyd8J1cO9VydTvDdVMWegWS+yTNkv/1lRtoMDadINA3niBKj7uUMosUb5s+jsSy
         dnxoZZ9CNtSUwpKpFecbFtmCT6O45eW4eD+Qy+BchFeLbPywD5IdAspWOeqnNF1ygH1X
         NQlId4sxTUyBLpjV/NVhAgTF04uKyB0ZqnMJToziAt2K2jJiDwq1Uu3N3V9rBN3QcMoy
         SKgyOijK/BV+Lwq5Dehqn4F5qjfQtRS+ufLhumjqpeiAufdn7AM75yT187IWmy1FW1ts
         pcHc/OVIhNM40uGudArWX8IJYQxfeK3HbdZQOKI+gUbQboCFOin8cKLtfPH/CIjA2i7/
         BnUw==
X-Forwarded-Encrypted: i=1; AHgh+RokUnDxW4M/ZGIzaVCnmgoikFa1mvqZz/Y1JjHS7RUrSEyKd0tvB8CEnbUDnlLGeVJyIoiIAUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3hjubUJBDMwGm1vAgEOChKTM2DXsNF4QBaQoaaZ0YP5sB9yfM
	PQ2itXD+B3Z0g9sab/DrcfxYDlCVnJrYRkAHRwZqP+CbXw+gx0IGlBbNMwnyahXl3M9KV+GwOxU
	gB4T6E25U9WrL/rt6Wb/l2DfWbQ==
X-Received: from pllj7.prod.google.com ([2002:a17:902:7587:b0:2c9:a23b:b02c])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d490:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2ccbe7224c4mr34291765ad.14.1783398643713;
 Mon, 06 Jul 2026 21:30:43 -0700 (PDT)
Date: Tue,  7 Jul 2026 13:30:39 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707043039.101983-1-yuyanghuang@google.com>
Subject: [PATCH net-next] net: ipv4: clear dev->ip_ptr before destroying inetdev
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"

To prevent RCU readers from accessing a partially destroyed in_device,
clear dev->ip_ptr early in inetdev_destroy() before freeing the
multicast list and individual IP addresses. This aligns the IPv4 teardown
sequence with the IPv6 implementation.

Cc: Ido Schimmel <idosch@nvidia.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 net/ipv4/devinet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a35b72662e43..3b31f4bec30e 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -322,6 +322,8 @@ static void inetdev_destroy(struct in_device *in_dev)
 
 	in_dev->dead = 1;
 
+	RCU_INIT_POINTER(dev->ip_ptr, NULL);
+
 	ip_mc_destroy_dev(in_dev);
 
 	while ((ifa = rtnl_dereference(in_dev->ifa_list)) != NULL) {
@@ -329,8 +331,6 @@ static void inetdev_destroy(struct in_device *in_dev)
 		inet_free_ifa(ifa);
 	}
 
-	RCU_INIT_POINTER(dev->ip_ptr, NULL);
-
 	devinet_sysctl_unregister(in_dev);
 	neigh_parms_release(&arp_tbl, in_dev->arp_parms);
 	arp_ifdown(dev);
-- 
2.55.0.795.g602f6c329a-goog

