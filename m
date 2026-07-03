Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB711429D
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037415; cv=none; b=dVySmMBFhI0Y5b3YVtrI5kPkyuCTSJJ4keLdRxL/84U28DNcdilUoFkUQEGHV0LlzJwWXlfLGIaAEs6S/aZzVs45CaY7HewBIFhtu+1XlA555m5nrBRtyhVF5MbrhmJDoO9WYzqWWtRHlJ8ovfuF0K/hwsj0Ir9sVl/HSocS5Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037415; c=relaxed/simple;
	bh=rXdKas2qFAGabXxz+upauTJMdBqVTTCwB4bLVS7dhyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Egj0LkWdYA2VPxt7JmtApIR47Mot9U+ImxXJJPf4GDuGzGEipq3bIgziWCoXFXl5k8GNrHOwqxVsy555BZyBgl4k7Q9st6C9YbfADvwnJRUpGBlaqpOHULq0la8KkVFdBHFgh3HrPSqeWTT4yAp/5o2+O7Ls3V8U1y5+baYM1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XCMCWkQ2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XCMCWkQ2"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ca0331d0b1so41610025ad.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 17:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783037413; x=1783642213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AD1D44iiuED1WFtnyZpajMPXSIx3JxJag8mmpE+v2bc=;
        b=XCMCWkQ2mmAp+obTQr+/aR5p4PvjYuWOUyLdr0kgsa/FOUQd++oJnsaZFCYuuCHU4G
         WLV0UYxl/X5xtEEC90uE51JEDVWHNdmH+Ny5PMMkKMZ5GW9ph+RXGFRwI2aMOnD+veEy
         ceOuhRuKCZ/ZkToNVXc+2eqbpkVetJP3kgzeJlV5LRAadSv0AuYAPeKV6jN+3LbRefzi
         0CkDAsyRJvrcaIVeMiPynA+F83SsBmqpHKXcxSsPhirSsG7/PYTnTFqPWe1W+hWTUwWY
         Gpkeq0fA6SSFYyUkQRiN8jDNOQ4HEX8VwJq08mSbTqw9Z4yLsQ7D5mG1JsfjFx7T4iys
         X88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037413; x=1783642213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AD1D44iiuED1WFtnyZpajMPXSIx3JxJag8mmpE+v2bc=;
        b=c/qbLwroIdH664gm1jYRiGVOlqwKO8Sm748fHFMeBXUUHGFG1+EE6oYro8fetKxH1m
         Ux3qU8JoJvmj0VBGPQzvhhlGDFJPKmyAWqJjtxMW3zqB0mt9uPS32ym1n57jbS1cM6QW
         a8XovVfnLbQ11g7iKhmg7i62egSXktwL7MjgeiXWDCF6QgRGlDHC8yJx5mEwAUMyqYMM
         6erqesrkxsIoPrFEWkVrBW8MSknuwvg+DR8G/1jN934uZgkVqI5amAtozEgTfZar+AYX
         ebc6R1cvWZ8xOlkDkWSBmvRnwIVlgFR4vxoXAKZpVe+VL2MY25dGmfnGc1Iw52G670sz
         TZMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hr3rkeYB5h5xHuZ0q8cCPFhFIzh/XRVbkrlihkVhBM5zzMwT9dYZS72VX+f+1hNKNTVvs4jM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Buqc2z184PhyUTC4F68yXg8OIA6nNCCzSRFxVuoWQKh7rtEN
	5hacealmLFQ/DYbEd2WBjo/17rArwuSSsNNz8+AtSmIw7aylNry5nYJvpdSBSjDpWXqhHmCM2G6
	ZgHHgvQ==
X-Received: from pgwa11.prod.google.com ([2002:a65:654b:0:b0:c99:d21a:f6cc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4c08:b0:3b4:8f4a:3bc6
 with SMTP id adf61e73a8af0-3bfed3e9292mr9278411637.32.1783037412925; Thu, 02
 Jul 2026 17:10:12 -0700 (PDT)
Date: Fri,  3 Jul 2026 00:09:13 +0000
In-Reply-To: <20260703001009.1572444-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703001009.1572444-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 02/14] rtnetlink: Call unregister_netdevice_many()
 only once in rtnl_link_unregister().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When rtnl_link_unregister() is called during module unload, it
calls __rtnl_kill_links() for every netns.

__rtnl_kill_links() collects all devices of the unloaded module
and passes them to unregister_netdevice_many().

Let's move unregister_netdevice_many() to rtnl_link_unregister()
to unregister all devices across netns in a single batch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/rtnetlink.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f39c93e80e20..7207da002fb5 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -637,16 +637,15 @@ int rtnl_link_register(struct rtnl_link_ops *ops)
 }
 EXPORT_SYMBOL_GPL(rtnl_link_register);
 
-static void __rtnl_kill_links(struct net *net, struct rtnl_link_ops *ops)
+static void __rtnl_kill_links(struct net *net, struct rtnl_link_ops *ops,
+			      struct list_head *dev_kill_list)
 {
 	struct net_device *dev;
-	LIST_HEAD(list_kill);
 
 	for_each_netdev(net, dev) {
 		if (dev->rtnl_link_ops == ops)
-			ops->dellink(dev, &list_kill);
+			ops->dellink(dev, dev_kill_list);
 	}
-	unregister_netdevice_many(&list_kill);
 }
 
 /* Return with the rtnl_lock held when there are no network
@@ -677,6 +676,7 @@ static void rtnl_lock_unregistering_all(void)
  */
 void rtnl_link_unregister(struct rtnl_link_ops *ops)
 {
+	LIST_HEAD(dev_kill_list);
 	struct net *net;
 
 	mutex_lock(&link_ops_mutex);
@@ -691,7 +691,9 @@ void rtnl_link_unregister(struct rtnl_link_ops *ops)
 	rtnl_lock_unregistering_all();
 
 	for_each_net(net)
-		__rtnl_kill_links(net, ops);
+		__rtnl_kill_links(net, ops, &dev_kill_list);
+
+	unregister_netdevice_many(&dev_kill_list);
 
 	rtnl_unlock();
 	up_write(&pernet_ops_rwsem);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

