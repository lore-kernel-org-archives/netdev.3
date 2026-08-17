Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4844D3563FA
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955116; cv=none; b=IxgKOwR4E07U9+p3e5v2W0ePzWaBHf3dUf6B24DUeNWIoXaIk2wrJ5GrkpaWeM8gGFER4OhKkeklDTH2XbY2P/IBHShWzbKWd4KT8PqeO7PryJ6e1vpOrhEjE+8UxIGkp6XRxs3PXwaNANjM3X+k1f9gIjbl1YsnNoZwmnRE83g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955116; c=relaxed/simple;
	bh=jJ8jshhXAub0tzm6nFfO48jpYWxYj1SkR8djpWbQ8M0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RNWgH3q5/NTu8pGWPNj2LS/78n60/hoOxa3xuhlrb3Nf75LJxq79ahYmWUe7tQll3R9cHblfOBC7CJrelOIpxBuWHo64pel0mUfIJCF/VO4INPmrT6rbY9y9TWtZfn16wh4oMYF+GJBv+qpAysmc/ZgQgI+uvwXB2qkBCt2+fEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IELlapMR; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IELlapMR"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930a098ea19so412970385a.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 01:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786955113; x=1787559913; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hozs/5hvXp+cE9Z91EE4QkqUsUXpdD2tJRMrlOTEUiU=;
        b=IELlapMRh2RwGADDDa9mESpBOiOOJu1KFYzUbCxliEkAjri3aoWKhMXtcoyi+yvYIw
         nef0ClcbuwDOUzZA58OapX9tsDh55DzCHhhLYyeKu+VfwCrMmYDow9PWWfv8Oj9894Lr
         M/2LaW+yrjhZxNQIunmJLfDutmPeausXA5E+5lGxRAIQ3ZN73vP5Yqm8o8X+OSX4faMK
         hI2SG0j7bBFvm/q6B8GquFCv/U3kA7whmsVqZPR5zg2igOuWs3DV/SjRgd45AxAmzAq6
         hCdlJMfaK/Yf9zAUk3pRWevls+91Wrnhq9xBJ/5vhmvugBuJoZndoVlTVWpigtFTO0up
         gq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786955113; x=1787559913;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hozs/5hvXp+cE9Z91EE4QkqUsUXpdD2tJRMrlOTEUiU=;
        b=jYMP/4edhKZYEd2G1A/n6mpcv3uAf9+5jFkrQgMFh4lXw0rxkrnwDYnxvSnsNPPNcv
         9PUse++Q15k847ersaWC7WD9E92lYLDkqUliAfhMiYgSdD2po63VZA33JdqszmGZ48kY
         9Cyn9U6GOe6hLUR1W8+dirHGMUjHSivW3WOkIT/Iqmbwe1JmnZpYQGqnmY+L+cDLFM9g
         LQu56xSojkyW0l4Sopv7BPH28c6yAmYXlzuVU3hF5J5enjX1DQDzZ6TTDSJUC+u4vfel
         sNI7g2vUc5zTkT+R0KUWHYIFOw54frfk9pV2sBlR1YthFUnYcBCfEKJzrT9ClY8fkAzp
         Ql2Q==
X-Forwarded-Encrypted: i=1; AHgh+RoO62mcJA5vom//9nR4ORR+g2xB8ml6LMRlNNi0M0lxNCW2UKXvQAws1GCTK4VO8oQwH1mMOUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCETF4Cs1df+BVZlM8ULc8LShpXPq8hxqfY7g6JxQrp0hSUD2C
	arfX8TlzPq20z2QzSanutj/tblcJiVLlq6SQhmdKCHK3C+4qSv0d9rALvyCWZ0Qb/njlq/zbxtI
	JpqNrfG18m6bW2Q==
X-Received: from qkkp15.prod.google.com ([2002:a05:620a:112f:b0:936:d3a2:2a6e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:8019:b0:92e:6533:26eb with SMTP id af79cd13be357-936d1fd9becmr2494123085a.6.1786955112306;
 Mon, 17 Aug 2026 01:25:12 -0700 (PDT)
Date: Mon, 17 Aug 2026 08:25:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260817082511.2300402-1-edumazet@google.com>
Subject: [PATCH net] netdevsim: update queue NAPI association on queue reset
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+483a6efbc4882c1201ee@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

In netdevsim, receive queues (struct nsim_rq) embed their own struct
napi_struct. When queue reset is performed (e.g. via queue_reset
debugfs), nsim_queue_start() swaps in a newly allocated struct nsim_rq,
and nsim_queue_mem_free() later deletes and frees the old one.

However, nsim_queue_start() failed to update the queue-to-NAPI mapping
via netif_queue_set_napi(). As a result, dev->_rx[idx].napi continued to
point to the old NAPI struct. After the old queue was freed, a subsequent
queue dump via Netlink (NETDEV_CMD_QUEUE_GET) triggered a KASAN
slab-use-after-free read in nla_put_napi_id() when accessing
rxq->napi->napi_id.

Fix this by calling netif_queue_set_napi() in nsim_queue_start() to
associate the new NAPI with the RX queue, and clear the association
with netif_queue_set_napi(..., NULL) in nsim_del_napi() during teardown.

Fixes: 5bc8e8dbef27 ("netdevsim: add queue management API support")
Reported-by: syzbot+483a6efbc4882c1201ee@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a82c3d4.f7a79266.2f965f.0024.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/netdevsim/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 4e9d7e10b527e5e4127331c141e4197afe0efa07..b4a99f3ceac60b66db4b30280db403d4e4319c99 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -529,6 +529,7 @@ static void nsim_del_napi(struct netdevsim *ns)
 	for (i = 0; i < dev->num_rx_queues; i++) {
 		struct nsim_rq *rq = ns->rq[i];
 
+		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX, NULL);
 		napi_disable_locked(&rq->napi);
 		__netif_napi_del_locked(&rq->napi);
 	}
@@ -826,6 +827,7 @@ nsim_queue_start(struct net_device *dev, struct netdev_queue_config *qcfg,
 	}
 
 	ns->rq[idx] = qmem->rq;
+	netif_queue_set_napi(dev, idx, NETDEV_QUEUE_TYPE_RX, &ns->rq[idx]->napi);
 	napi_enable_locked(&ns->rq[idx]->napi);
 
 	return 0;
-- 
2.55.0.699.gb54405d56f-goog

