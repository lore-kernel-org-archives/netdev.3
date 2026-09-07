Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC6444C659
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773451; cv=none; b=nNi0lVdg7szEWZQD8YeMQjuWMWlT2E+Mi34Xp5PKSHz1hhihFWCkAMGilPCGuQqzUIl2hbpdMpacAn2EYoiQMicO3lDrXl2W1oqYaCGn6iG+U16YZNqIVFS8VNEhnJ/V11IIxlTyPR1+5RYy+phqNGdyPNxZ5SclVSymBTO+OIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773451; c=relaxed/simple;
	bh=NorjP9Ji/6c0JqsYKr2QuPoTu82n8ADX4ib/q5RaTJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLnj+ZGg9112F62zCOPsb65wxbwamEJI6MLqyLndfKC9r+IfFercvw9sgeXGrO6CczHAFpMBjKrhtmiN9CF1mAgSekjBf8yOpdcCKzPCgh6XdnFI+tBAXqtsqSkcH+bEZ95Ul6vNkMwJE281loegmMCkNf5QTKkTf1Lk1x0TWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=pLiQePCf; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="pLiQePCf"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C155D20719;
	Mon,  7 Sep 2026 11:30:47 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3SGZLJQBP0WJ; Mon,  7 Sep 2026 11:30:47 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 217BD20728;
	Mon,  7 Sep 2026 11:30:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 217BD20728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788773447;
	bh=SWX4oM0Q9Pno217azcu8xzFzvth9Y2ajCTS1tZhYeMg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=pLiQePCf3icY/10lB2XQrtAxJROeepGx0djc3iC4JNLwGZAjjaEz+xvZDwg1t6l1Q
	 JK8rNtbu77tQMw4PdlHEKqTX1sBRAk5L41aDIofUZ4a9KV4xTsppQCPHZZm3mni2ar
	 OHPNJHZXDL1ADsRMCrZSTW2QerVYAKIjsHroIkjTRMUF7NlRk2FSayG0VH+A58MYOt
	 /mgD4JQyV9vnABs/JmdXOEgHE8IqjNg+IpBnfPltVL2jTiIbjQ1vbQvfPKUAaCW5HT
	 YFN6YtjM5zWvjFy7lVoPvSxd+3y33PRajVDpfrGeyD7WEqvWFR52x+okk/qgkvfwgd
	 raVHqhqLZqMXQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 7 Sep
 2026 11:30:46 +0200
Received: (nullmailer pid 2228805 invoked by uid 1000);
	Mon, 07 Sep 2026 09:30:24 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 02/12] xfrm: serialize state GC with device state flush
Date: Mon, 7 Sep 2026 11:29:45 +0200
Message-ID: <20260907093020.2228346-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907093020.2228346-1-steffen.klassert@secunet.com>
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

From: Chengfeng Ye <nicoyip.dev@gmail.com>

The deferred-device pass in xfrm_dev_state_flush() finds states under
xfrm_state_dev_gc_lock, but drops the lock before calling
xfrm_dev_state_free() because the driver callback may sleep.  The device
GC list does not hold an xfrm_state reference, so the state GC worker can
destroy the same state concurrently.

The race can proceed as follows:

  CPU 0                               CPU 1
  find x on the device GC list
  drop xfrm_state_dev_gc_lock
  read x->xso.dev
                                      xfrm_state_gc_destroy(x)
                                      xfrm_dev_state_free(x)
                                      xfrm_state_free(x)
  continue xfrm_dev_state_free(x)

Both paths can invoke the driver callback and drop the device reference.
CPU 0 can also access the xfrm_state after CPU 1 has freed it.

KASAN reported:

  BUG: KASAN: slab-use-after-free in xfrm_dev_state_free+0x24c/0x2a0
  Read of size 8 at addr ffff88810bbaa960 by task poc/102

  Call Trace:
   xfrm_dev_state_free+0x24c/0x2a0
   xfrm_dev_state_flush+0x353/0x400
   xfrm_dev_event+0x26d/0x3a0
   notifier_call_chain+0xc0/0x280
   __dev_notify_flags+0x169/0x250
   netif_change_flags+0xe7/0x160
   dev_change_flags+0x96/0x220
   devinet_ioctl+0x7f4/0x1880

  Allocated by task 87:
   xfrm_state_alloc+0x1e/0x5c0
   xfrm_add_sa+0xe7f/0x5820
   xfrm_user_rcv_msg+0x4f3/0x940

  Freed by task 57:
   kmem_cache_free+0xcb/0x3d0
   xfrm_state_gc_task+0x4a8/0x650
   process_one_work+0x63a/0x1070

Serialize xfrm_state destruction against the deferred-device pass with a
mutex.  Keep xfrm_state_dev_gc_lock limited to list operations and retain
the existing callback and device-reference release ordering.

Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 36a4f6793ede..de097bba803b 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -226,6 +226,7 @@ static struct xfrm_state_afinfo __rcu *xfrm_state_afinfo[NPROTO];
 
 static DEFINE_SPINLOCK(xfrm_state_gc_lock);
 static DEFINE_SPINLOCK(xfrm_state_dev_gc_lock);
+static DEFINE_MUTEX(xfrm_state_gc_mutex);
 
 int __xfrm_state_delete(struct xfrm_state *x);
 
@@ -632,8 +633,10 @@ static void xfrm_state_gc_task(struct work_struct *work)
 
 	synchronize_rcu();
 
+	mutex_lock(&xfrm_state_gc_mutex);
 	hlist_for_each_entry_safe(x, tmp, &gc_list, gclist)
 		xfrm_state_gc_destroy(x);
+	mutex_unlock(&xfrm_state_gc_mutex);
 }
 
 static enum hrtimer_restart xfrm_timer_handler(struct hrtimer *me)
@@ -1000,6 +1003,7 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 out:
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
+	mutex_lock(&xfrm_state_gc_mutex);
 	spin_lock_bh(&xfrm_state_dev_gc_lock);
 restart_gc:
 	hlist_for_each_entry_safe(x, tmp, &xfrm_state_dev_gc_list, dev_gclist) {
@@ -1014,6 +1018,7 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 
 	}
 	spin_unlock_bh(&xfrm_state_dev_gc_lock);
+	mutex_unlock(&xfrm_state_gc_mutex);
 
 	xfrm_flush_gc();
 
-- 
2.43.0

