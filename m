Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B13932FC
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766955; cv=none; b=gGIR5iOuuqQulER163zlTa5klTLBECVP/jCN731xZ8xMaBq8v6wE9EII3djPVtekHmWV/8zAI2ES484Pbi2sqweX31lFYXXAcPgyJwnbPWsfVYRaIY9QnMZk01cpk5TuqdnJKzlADWuEAQkBmQ1/NoFKTmkzY2F4FUZPp2T99Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766955; c=relaxed/simple;
	bh=KwAm2lfrZQqruUuNisBIX2ppIOK7S5vg+L+v73u4CFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+gh22bbk15ZMImcJiSYWbJXuY4MO4eUo7Lk7ywU1Hr+FgrbVXvcSJEhowexI+VHFbSors659jzfuybVUJB39xEFyjjZ2VTlfKxcsKyqTN3RzwXdYHcOQJEgqWtdIl0KrzHIWhkPfLZpWgoGNJZUzdh4CjxzYxHyqLtryuW5V1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3kUih0J; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3kUih0J"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15c7d22070so234558766b.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766950; x=1784371750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qx4EoVLGIeoARVRd1dVSPAuDmT4zYpupoS+SCU4JI9E=;
        b=k3kUih0JT9k0YugakFxFPNx1XBHmII6ZbYF3dqKYFroAHb+8DKG7S4N/PQZ4anyZHd
         WYkVUkQxOIhqxZPUuDx6dGPKXMCIRkWW0Tgf/cF0Mm3sgV4nUwD5ImfwHjqUuaT7AnIf
         3XiyT5HjNPvUiLWLbEDwrFxVpX2v1IonChwDwnr6O6SayGlVeer/phoZAMk+W+I9YPNu
         vF7HW+RT8w9ThOiB57ETip/2SmuWu/4Aonvq0bWes89XO31wyXMUMO1YXkhOmTo0yRT9
         uyvR3m3al4CTaU0b17msdf5gOQ1Ziw/D8LL/3hcNWtiGVDAthEzPSc9pyVd9MRRh1U5n
         uYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766950; x=1784371750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qx4EoVLGIeoARVRd1dVSPAuDmT4zYpupoS+SCU4JI9E=;
        b=h/i2zY+XYxxi7E3Vnn19wmVqszBIr6YxQbFA2sTGFCzf09phxt7HPGFnoNNewR5KmH
         qkNX4i1MEuC1ge5D36rr5DGRHz4BK3w39sWqor6VoTgNwA6un4gwsOBfHOBrNaBu+f3/
         4Udq6V/WYSuallzRPR1equZdRQjrjeSSM8ZJsxYbVcDmFef7zPhx5xhW7HR51OX3Ab2I
         jlDnWoL1TDbw+iMW3rIWIF3HrGYpdCks/fhQf0/f02IgoPcPeBzeoNh6hNe6FJIDgK7e
         eLPXEGtPVH3S+SHz+jFy2pC9Ve1ZIRxY0nbHzIR9NfWbBNKgI/lpL8MzXp1uLFxZ9soj
         ObeA==
X-Gm-Message-State: AOJu0YzJfDEAMFsFvw5uUFshaeWYmEW4kbWEG+YkooMipfaKoj00fo4d
	wS2qZAOIARdV3/R1FQB1un64eFxfQz1t4CLU0XebKV1hLFmJ4Xrak3uGngsQ7w==
X-Gm-Gg: AfdE7clF/F/78itpJBVsb8v6CY8sVo/7eRdQOVyOtz8TpO7N2fzMBQws/I4RyLGknkL
	s2u+hgnwZdGlh/KiyiML/TVv3ddvSzCQLbw+A9YJ8SvQMJQfhktYSvxRet/lVNwm8R3HJzeiMQd
	q85nxuJD0E857hA4vmxkjY+AEhYggAXkhrbLPlko7NA1RDPS8yvjbOhx8bTXKuG8X3W2+Wuj4SZ
	q9mMgk2m05nessBPmsh82vZiGC4pIRRbcPlwSfFFfNahmvpEHkAb6zTrEsxh/GNARb3nJ4rWhz/
	bt1pGa4zG5De1UVy4LG3Yoew+sX0Pa9IoJNl9hXXifBcXdtz1kSICWNUwQvili9t5QOQ/pO/gwF
	4f4YzCKN/DFKUVU3YguNNAP/7zk8Z1YI13xNwenCso/DCN64MUqUzLWZX1Xs+GAZSlrbRgugqMh
	tIEBIWmz68vsh9Ma4vlJq+HiwbXyzLiymddMf5/aIl4RyNA8D/dcxzjbvkHuR1P4+pyooV05pWG
	TsY9Iuo/U2e5GOJ97XGOQo11XQUDagATUKjEtWTVxys+IBOsA==
X-Received: by 2002:a17:906:69d7:b0:c12:34ed:da0b with SMTP id a640c23a62f3a-c161f3e8415mr57167166b.55.1783766950423;
        Sat, 11 Jul 2026 03:49:10 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15beb53b86sm609123166b.25.2026.07.11.03.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:49:09 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com
Subject: [RFC 02/10] net: reject zcrx skbs to not registered devices
Date: Sat, 11 Jul 2026 11:48:31 +0100
Message-ID: <005a62b553c8b3ecb0ab5492e3842429e4dd1439.1783614400.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783614400.git.asml.silence@gmail.com>
References: <cover.1783614400.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tx of netmems that weren't created for the targeted device should be
rejected. Devmem TCP does it by looking up the net device in devmem TCP
private strucures. Introduce a netdev pointer in struct net_iov_area and
set it for zcrx so that we can check it in a more generic way. Keep the
existing devmem TCP path for the RFC version of the patch.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netmem.h |  1 +
 io_uring/zcrx.c      |  3 +++
 net/core/dev.c       | 10 ++++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index bccacd21b6c3..71024c7ce884 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -103,6 +103,7 @@ struct net_iov_area {
 	struct net_iov *niovs;
 	size_t num_niovs;
 
+	struct net_device *netdev;
 	/* Offset into the dma-buf where this chunk starts.  */
 	unsigned long base_virtual;
 };
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 7ad52f499f87..ef82e064e796 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -516,6 +516,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 			goto err;
 	}
 
+	area->nia.netdev = ifq->netdev;
 	area->free_count = nr_iovs;
 	/* we're only supporting one area per ifq for now */
 	area->area_id = 0;
@@ -554,6 +555,7 @@ static void io_zcrx_drop_netdev(struct io_zcrx_ifq *ifq)
 
 	if (!ifq->netdev)
 		return;
+	WRITE_ONCE(ifq->area->nia.netdev, NULL);
 	netdev_put(ifq->netdev, &ifq->netdev_tracker);
 	ifq->netdev = NULL;
 }
@@ -568,6 +570,7 @@ static void io_close_queue(struct io_zcrx_ifq *ifq)
 	};
 
 	scoped_guard(mutex, &ifq->pp_lock) {
+		WRITE_ONCE(ifq->area->nia.netdev, NULL);
 		netdev = ifq->netdev;
 		netdev_tracker = ifq->netdev_tracker;
 		ifq->netdev = NULL;
diff --git a/net/core/dev.c b/net/core/dev.c
index 4b3d5cfdf6e0..703b55778c32 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4004,9 +4004,15 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 	shinfo = skb_shinfo(skb);
 
 	if (shinfo->nr_frags > 0) {
+		struct net_device *trgt_dev;
+
 		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
-		if (net_is_devmem_iov(niov) &&
-		    READ_ONCE(net_devmem_iov_binding(niov)->dev) != dev)
+		if (net_is_devmem_iov(niov))
+			trgt_dev = READ_ONCE(net_devmem_iov_binding(niov)->dev);
+		else
+			trgt_dev = READ_ONCE(net_iov_owner(niov)->netdev);
+
+		if (trgt_dev != dev)
 			goto out_free;
 	}
 
-- 
2.54.0

