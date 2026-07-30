Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3BF400987
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407756; cv=none; b=oUfj8AHoR/NpijEAfhILNJd5Y5ADKO2+BK0DqLDhqGjAUOHt4bwdB6Ocqceh4N0gmvQ5nqfLS3UFW/uuyz3ghKSiL9s/TjmdeFCvqyDK3EQuHfxU5vnqu2AbXZ/izr8qdiPoXIWVe8E0Ajrl4BiA+MBvj1TJ21WeyadwlzvDTCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407756; c=relaxed/simple;
	bh=r0raIDOSW17CYITUQZE9QsucbRWZGq3BFAKaOnaT8tU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4rLILKWA70NaM43qlafFCk6UCQN+dw1LNJaJdqQVemae1G8EGdpOpreDTgGgLDqnmVX7D4HU4lSwmguLbDqJsQmpfL/1eHz1NwqmWYucQBzSssDfUp0bv5hHN2JAfQwd5Ot1GIJJ8pJqfxfYjTibXbLybwz95SD2fyvAReLr+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxBzzepw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxBzzepw"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ccdce28edeso2282425ad.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785407754; x=1786012554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sHxSCxHA6CRR2S+Pj+AQgpaHzJeXKMKhiOowZI1U4SU=;
        b=DxBzzepwp4lwNvY1bmkJeFQudlzqlXb78PtOmL70vInV+KoNfjmqWpvVmFHgTiZbkO
         pAbosZk9g1kp7CibwYRn/CIGPimdZswwgq7122bWo/x/hyWk0VnvSgxKE3UZtGCYIlDD
         hyMD/iLH/dXr6YrYlQFjOA47kQoq1HagrgF/38lMjklt25sQQbBJdpErQ8XLpIQPiqrB
         llHKGeCQtYY3V/PVn1BYZPoT6GFqJ4X91sitJ3rXTAlTJFbv80SnoGA/2s29xqk8vyU8
         ZXMpgnrxw+zuPlHTcfSCTkovCKQQKQrOnNTVOd1gQ/5Q9k0byCxrIgfFnSjINUHlNTtN
         b8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785407754; x=1786012554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sHxSCxHA6CRR2S+Pj+AQgpaHzJeXKMKhiOowZI1U4SU=;
        b=ceh4FLxmx/lJzVDSiPlVqgbBcgbD+sLjIpqfTMCBDSGPfRU0Qxn6WsaD2a7icvtRf2
         n5NJCsxa2yC2xCuodqo/QZCrkRmwlN+d/DgLPC9W6yXPasir1VJITfmQJtEDL2j+6VJk
         yUs02btGNceTNoML28lkOuN4nkpru+3esHgroZLZZPL7C1Wek3Z9YxgdO6ZZZShFyr6R
         z+kXWroYzWMlGB4vrXdqXLanG0fQz1Ch4Ulgoqs5kszB3Cdxs9tuLtDoeubHgVKTYYnQ
         wZbKqBZHuZLg5M4qrvyg5p+piZy9SQJYGNuLGYDI5Zcn+lvs+k96c0M4OfbyI6+o8fUI
         0+4w==
X-Gm-Message-State: AOJu0YyPYI30uC2UYKcadwhsCZrDeT01WnjTEXfzNrlKWTzT6Ypi89Cf
	7Wf0ZM+P5OfPEl2eAO8EzztVzOxlQ0wkP98OhBUO6A0e5iH0aR8so4NWHhWeOJym
X-Gm-Gg: AR+sD10nyc/RvIRmmXYE3JsdMMpDrVMxtiVm4Sb1MBW6/o0OLg3OMDhH1Ak4jZSvYOT
	4Q3YgWMx+Sc/gvC0mEjOTzDT1zsC/DRHkWjAdVH52dXxy0gwNdEG/h2yS3ioVfMekNXpXFn5Scd
	8vprkoeDxfYwwafUN7QyVuD+j2GTH46BQeW1owsxhZsnQIV7NlURKR1uvNnG6kvU21QqPo2L8wO
	LOkG+Lv/sneeiqflqgTluC90T6JznfVEXFgmkdGR59nGJd7MVH8/ybJjj52GWa89z/Pbxpazylm
	T28zxcQdhG/6dP1LiV7JJ9kDaf/hf3UCQtcgD2cmoDOT9DMuQJsGouX1e8pAhcRHgW0xY29i9tz
	uLtPJmo++awzd98fubzxHYasXtGOOtmpXKvlzf/1RVkIJPBSJNslcH19h89qPBX6FHxpmZbX8V+
	O5QzOePPCV8oCKN8dXgR/AfQqVIv0leJIcYrydNJqHj/pCavuCSFTPfxjvPhhGO5brssmpU8YjW
	C4EK7qEkEaGR7iEZjfoXF/5ddNFhc3iHea94+KRpNsR9h7rjkAy4CgkMV8dq9NK3A==
X-Received: by 2002:a17:903:1211:b0:2c9:fbde:ab68 with SMTP id d9443c01a7336-2d035cdecabmr28046445ad.3.1785407754242;
        Thu, 30 Jul 2026 03:35:54 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc63fesm18235788eec.15.2026.07.30.03.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 03:35:53 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] xfrm: serialize state GC with device state flush
Date: Thu, 30 Jul 2026 18:35:43 +0800
Message-ID: <20260730103543.2077749-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

