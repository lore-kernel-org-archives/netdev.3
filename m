Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7D537E314
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073418; cv=none; b=rxzkHV9aPV4373OegiAWiqLKwL7x6wqtqdD+sy5lwNOQNvBTFOXjq2QVBGRpL272b6rf9Z4A0KVzu4rUMp/sgj2/4swPd7efkxX3zAld5wUNm8KfCXuJwExax0aU0hBGtBHYzb1ZzRz2hnP4D8PnMRJkzJKCPyTv2ORuxoM5kXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073418; c=relaxed/simple;
	bh=ngN6mWNc/9g5gOFR/BCfWZgFDLEd9su6DAJSTCUlR1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mjtu93CRU0sMImglEPDzNvw9nVbDo7cgC+3Q1bMKVPRywozv6SR3r37v2qjRqkKBzoP5dW4yQpWbffitw/9HjgKp2SLeUcgdJQ5sDefe39L9xF3EnvfzmItaALOrJ5BCdqvSOaHpp0hfA4dAP/ypb79xho78rP5jLBcnbAuavQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/re1p53; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/re1p53"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3561f5bd22eso236413a91.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772073416; x=1772678216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HMEe1els7Kx1TNo6Gl04t+3Lw2M6ilToebkHjlSQDwM=;
        b=s/re1p53hV8ioZTYx7UXURu+JfrGDYcx/PJxCefCn+/mu3uY+tv6wcM7WIsqF3HgTZ
         B9f52eTppZaw7R1b8TNy4ewBFf/5Xf0jbTtbmWaKsftwYV56M7Rzr8xQE9XHIqRVDLDq
         niTTZj4H3qWnN5afL0YniylrEgPub5Vy21Fn5zJTOGsPDIg50eVDvCRxsx49U45Bv3wx
         GQW8DgF21bOmLAupjLcSsUK205xFaJrNfDiR5r/gK0Cb2Mkzk6hfFxAiI98lxlVvXUFU
         UJMZTUEMC5nCLajZkhiaWU3iJzPcCXBY6ND/olhi6MPLz2YMIhz9ag58UfmRAbZ2nYmG
         quMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073416; x=1772678216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMEe1els7Kx1TNo6Gl04t+3Lw2M6ilToebkHjlSQDwM=;
        b=v1fzpGXOrlZ+sL0z2VmQH7xMtpVm394IwHm2j7ZVLsnDebOjFfnioDWYhf0RO1bbdC
         s13kU+epznoX7m/EJfjEUTcQhsHuVRg4X5n258OYpw4BU9qemqxmIsa57f3nhnLKjYpF
         RdXvnFipYSrPGQx7lq1U3o5YW+I5uOUU5kvSY/BPjDEHnptlZjT7FtA9+ILSepxYB9vu
         enAOjEmdUXH36i7zQP+UJfXvvRE225+KqZZaBysJsinr2XiqV/2CiclfDiGuz8hgJpbW
         is6kq/2jYp4GQS9cKB29AuRJoG5P6lLOn6n0tC0G5QPsltRKP0D1NTtb4+BVLfCA4fyM
         mgjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKZeImJw4ZvNNhpwd0v61jin5x4aGZshGBGJtqDPuHifXQBt/+OxOV2bSd1DHdp7vfrc43RAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYQQ9jEJh6+s5Fpe03s3IhodDGnmw2Jl8EOXWcORAM4iUK9e/h
	7EmdZwV3ZCotIwY+BxaUD8ST8uc0m73WsbeNUPLnlWkUkx3OiNDfo3yylENKA4lAEUVVEUeZ8Z+
	A7k6EWA==
X-Received: from pjbgo3.prod.google.com ([2002:a17:90b:3c3:b0:34c:dd6d:b10e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ece:b0:354:c51e:f011
 with SMTP id 98e67ed59e1d1-3593db5b19amr638674a91.19.1772073416172; Wed, 25
 Feb 2026 18:36:56 -0800 (PST)
Date: Thu, 26 Feb 2026 02:35:22 +0000
In-Reply-To: <20260226023637.1335854-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226023637.1335854-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226023637.1335854-11-kuniyu@google.com>
Subject: [PATCH v1 net-next 10/15] ipmr: Remove RTNL in ipmr_rules_init() and ipmr_net_init().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When ipmr_free_table() is called from ipmr_rules_init() or
ipmr_net_init(), the netns is not yet published.

Thus, no device should have been registered, and
mroute_clean_tables() will not call vif_delete(), so
unregister_netdevice_many() is unnecessary.

unregister_netdevice_many() does nothing if the list is empty,
but it requires RTNL due to the unconditional ASSERT_RTNL()
at the entry of unregister_netdevice_many_notify().

Let's remove unnecessary RTNL and ASSERT_RTNL() and instead
add WARN_ON_ONCE() in ipmr_free_table().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ipmr.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 3526c9afcb03..537be40af9e0 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -276,10 +276,7 @@ static int __net_init ipmr_rules_init(struct net *net)
 	return 0;
 
 err2:
-	rtnl_lock();
 	ipmr_free_table(mrt, &dev_kill_list);
-	unregister_netdevice_many(&dev_kill_list);
-	rtnl_unlock();
 err1:
 	fib_rules_unregister(ops);
 	return err;
@@ -290,7 +287,6 @@ static void __net_exit ipmr_rules_exit_rtnl(struct net *net,
 {
 	struct mr_table *mrt, *next;
 
-	ASSERT_RTNL();
 	list_for_each_entry_safe(mrt, next, &net->ipv4.mr_tables, list) {
 		list_del(&mrt->list);
 		ipmr_free_table(mrt, dev_kill_list);
@@ -355,8 +351,6 @@ static int __net_init ipmr_rules_init(struct net *net)
 static void __net_exit ipmr_rules_exit_rtnl(struct net *net,
 					    struct list_head *dev_kill_list)
 {
-	ASSERT_RTNL();
-
 	ipmr_free_table(net->ipv4.mrt, dev_kill_list);
 
 	net->ipv4.mrt = NULL;
@@ -445,6 +439,8 @@ static void ipmr_free_table(struct mr_table *mrt, struct list_head *dev_kill_lis
 			    dev_kill_list);
 	rhltable_destroy(&mrt->mfc_hash);
 	kfree(mrt);
+
+	WARN_ON_ONCE(!net_initialized(net) && !list_empty(dev_kill_list));
 }
 
 /* Service routines creating virtual interfaces: DVMRP tunnels and PIMREG */
@@ -3287,10 +3283,7 @@ static int __net_init ipmr_net_init(struct net *net)
 proc_cache_fail:
 	remove_proc_entry("ip_mr_vif", net->proc_net);
 proc_vif_fail:
-	rtnl_lock();
 	ipmr_rules_exit_rtnl(net, &dev_kill_list);
-	unregister_netdevice_many(&dev_kill_list);
-	rtnl_unlock();
 #endif
 ipmr_rules_fail:
 	ipmr_notifier_exit(net);
-- 
2.53.0.414.gf7e9f6c205-goog

