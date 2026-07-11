Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26FA1CAA65
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731272; cv=none; b=VrJtrSw2RXPN+RDqatQ6QuYtxfpQfP4JBUYAvi6PxDIo960RyoGjZT4rTX+hrD1iBhWOqOURzdsh03TX6bLeJPliBlmvrpp6a4KjYjxPHqxlZQjzlGNPtbECi1S2IRC0lObMaMDUeUqxVl1Qd8YeWBEIIN1pqZx/4CdHxtRqY0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731272; c=relaxed/simple;
	bh=M2hWQFzhSKgrdKI6qiemtu4JnDynZZgc1Roe2FLVgwE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kONE5udqKN0BzmYoVUTPXvJoFFpjhL6QDN/C1zRDQb6wQSZYbtznkkH3LPZ9Oa6a7Xl6hRM6zX41Qr7w30cR3ctQoIBblftLHJWVDUqzT0mAM3j16rzqE18DJIpdVuW19Cq80eKosThcnGgt5iTODRd8FKQswC9GU3GIEEqW/fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJno1SI8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJno1SI8"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cacd6d37edso19513545ad.0
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 17:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783731270; x=1784336070; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGoxbQSfVWHXD3Qk6QxK4PGiP7s64rwM9sU/cWIRVkM=;
        b=iJno1SI8DL0SB+oYISqrjpLBSO+0f4h0jiy7bSXIYEKjbe1yeUa7Y3mlkZUUpHHtQM
         n+L8JE4qdEXqm6hBYQUN+e2Bsa9NspI3VP7uNzJ3ibOlmyuVsjOJq3/53YjaNqVx/X73
         IFwpzYxpwcBWVESJ3542e+IH+4VnNC7OJ8sCcYK1fRF7FJyWtG6NV5+mKL8uImpOH5tM
         wY+YBfLUJyGAY4sWjTg5FA5UJZHAiZf4tjTqbJ7mByU2cssBT6jq+GrWKmd6DEBHdl3g
         bc2xLTiQpeJjGFbIhIFGxp+Ig1Cpzry/DxsVLrU2Vk564n/jjJ20fLcAjPRrpc5KgDlz
         1nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783731270; x=1784336070;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IGoxbQSfVWHXD3Qk6QxK4PGiP7s64rwM9sU/cWIRVkM=;
        b=B6MGGqNgwOlFvMiV9pCcdZAJxByAfy6QYj9OIVFbNERyHeyEUTnO+PAFUNldWYaLp/
         IwZbDzFOEWCe+zAv6Wf+Tr/PzdYvnrDu93gWpgPj92pO3vPUYhGapRvHa3+FSX+ITqRn
         LeA7vzkUDHIn6BNhFGZzpeV90SdMI12XNjLbaEMcTM8E5hlfsuWs3FTH/ofACW/ILQbM
         qESjF5REXRHpo/WyntHOqnufRSEJAGJShpQVu2aylKmvz7oPK8r23lEnbOvxS86C69n5
         3ZLBBYzbz+DnlXaD0zYqNVgdm02ZotisPBnTJKM0pwGjCLFOYnhulSeb/5CV6Pt2QAw7
         b3FQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRbiIbQr26EMnElvjo0Jha+pkA15deL+c+7LsbiOaMvmUL1vMApcwErdTGopoumgIvCS0xdeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRe6zVCW3Nky33AsnOz+8x4jkYCUAbF/SmhrZRwLYz8aj267Su
	TCLPyR2uLW/JGhY2rm/T+5UEsiuou/hRDqoBXOpQOhlVgbe6lbplNDUgvofF1JNHZEgFPhpkLAd
	9/WPU0D/2xK9yhxWgSGZuoQG7FA==
X-Received: from pluo8.prod.google.com ([2002:a17:903:4b08:b0:2ce:6df9:bda5])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:292:b0:2ca:f16c:87b3 with SMTP id d9443c01a7336-2ce9eae97efmr11997835ad.19.1783731269952;
 Fri, 10 Jul 2026 17:54:29 -0700 (PDT)
Date: Sat, 11 Jul 2026 09:54:04 +0900
In-Reply-To: <20260711005405.2861680-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260711005405.2861680-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260711005405.2861680-4-yuyanghuang@google.com>
Subject: [PATCH net-next v2 3/3] net: ipv4: clear dev->ip_ptr before
 destroying inetdev
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	David Ahern <dsahern@kernel.org>, Elad Nachman <enachman@marvell.com>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
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

