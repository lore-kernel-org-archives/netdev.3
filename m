Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAE635FF6E
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 06:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526906; cv=none; b=pbBH6AQk0Vp4dOH/pDDlezbiy5Jhp7xz0Dvf5fEm2Y3wmY9NPwcRgfbEn/aEltN+2FXoj/iQikFxNkGdLEebkG2Wt7A128P/NwWvkNL98E3wtEF2Nksb+mJckpcb5sQsKXOBSqabXCZe0esEBtC3Lh8/fO9vV6NbhagpnCwr14M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526906; c=relaxed/simple;
	bh=Nur820jia1XdVla4bty9gBb8D3o6vytzH3lSbZmpYZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UmlCGahdUEn3sc51SeeU2scW7SD0EOujyp3vjBhuhzHaZpX1UqcZChJBencynDeQ21svthed17YAQ5o+Oy9gK89nPVpftLkybi2SJk7UbChEAzO1b8lFs4OTjXfV279X9ntkKpoXxJjgTgJXIHwDKwLeekA4oCbBqPRGPoPEO3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEUQXIW5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEUQXIW5"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8917c712f32so1625515b3a.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 23:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791526905; x=1792131705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7yl9vp0vQupVyoKVdIPNttogqXtRBQS71313jzYhlZk=;
        b=bEUQXIW5eZ7Os3D1OMk7NBKLs7nz6OblY+EJwCBiP1QJeVN1XpZJ7Lp6aRRcc4Wwpw
         g9ulP3pPzxsuAvvAJGjG2r+iYUmbLru67AaKO4EmFKtYANEhugc+PugvIfDvgYs3wQv9
         DhLcftZVPFMCr4o9k4WqKuZaVhb9KHDBhERCnp+Rt4cpuU2abM5mZg2s2vJSohmVWyjy
         ZNQk0Clvu9O6bND2wMV4aHN4nOyRZTyoZO3QphwsqnuihT8fnatwebAhKJ/rSK45I02t
         sQaOnkhLUKPNjeQEq0YJgIsqyAYPLR3xjwhZD3YxSsokR2rW0Slus7teqfE8XAVAZH3l
         7nFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791526905; x=1792131705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7yl9vp0vQupVyoKVdIPNttogqXtRBQS71313jzYhlZk=;
        b=JC4yP882l+o+yBw9Gg09AEMyp6tO/7zorfWOJ9QlyH3mJhjHx2OPC7I0Yk34QDWh3Y
         rQ66h05YsobvHE/2/f4tlmtth+mnFBqcV9LxzBmEK6VMBn4kJn0mJk3Jx7kpiknLGmgA
         qq29GBi2rrgr50hAAgLgT29hFaZzY9vNCWbyi+8TOwcZEsFvW8+s75emllgeERQKGBqX
         gxxQHE5cmA/rRo5MVzHh3sxIxfJKKmnTccp9/f2MboFyL/7TIQtZl0tqWMH6M5lgNFgE
         UrvJjOWMV+SvkkKfmbQlB3YSSKIUQa2fXAS9QA2Vs0m6ApiU/Dq6e0sZR8GFRBdlvAAV
         sEVA==
X-Gm-Message-State: AFq9FYL/iUBy9sBSb1RMNjR3yLC4dStH1Ojyuy3qF4Zs0+gZ/KLNUzaG
	n6V8uo/oGJgSCbmhb3611prcJChEPKl3WYhttUxBmLb7dbo/d1ePTKPC
X-Gm-Gg: AYBFou3bKkt3gmLDV3gjAF1LMSqAQegqxEx7JVA6ZqlRKm1keWq4rx+yWNxTT//4eop
	lpdtx9E73f4Fm2fFHvOzfKLhvAdFFab6+Z9hoPbRsSnD7Xj5n0mKKp2D3B5x7yWdxmliv/L9+x6
	fYaMqbsMNBvgbjSt2rK9PHYF6asnFWA4YQoq/yeC3FHN/R6n4nlN07jVsI1XTX/qXERPoB2T4YJ
	oP8yhM2DEG8x/Jf7wjbxHee/O89jcATz0cwJMvfCMQQiXsVKzyRngxsGATZVThNRLT/U84c8EXP
	djRanbf7OP4X+kg7DAUz1x+rEiIQ39mm0/ZwKlcADe5Rt/n2o04t/V5xq0/O1jnU0PxYAwffvzQ
	JYO067JYSrSJhUIrj01TpZw/ooYR1t5H6BAxaVs4swxRRydJFLB7Z2xf3vYxvbDAPlpyCfGdQSI
	wKWwLR6DuUV0Zgr7sklgzCscX/EbMLAIIDT6bZz02UwTqVfCZCjNbBzp6WizWmzwlp2jjtNoCpT
	LET
X-Received: by 2002:a05:6a00:4fd1:b0:880:cb86:fce with SMTP id d2e1a72fcca58-897c7ec4ce5mr844314b3a.54.1791526904879;
        Thu, 08 Oct 2026 23:21:44 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89805c75343sm139245b3a.38.2026.10.08.23.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 23:21:44 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baul.lee@xbow.com,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH net v2] ipv4: prevent in_dev_get() from returning a dead in_device
Date: Fri,  9 Oct 2026 14:21:38 +0800
Message-Id: <pm-ip-core-objects-candidate-0002-v9-1404514d79dd4560c571@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in_dev_get() samples dev->ip_ptr under RCU and unconditionally
increments the in_device reference count. Device teardown can clear
the pointer and drop the last reference after the sample but before
the increment. RCU keeps the allocation accessible during the lookup,
but does not guarantee that a reference can still be acquired.

Commit 9d40c84cf5bc ("net: devinet: Reduce refcount before grace period")
moved the final put before the grace period. A zero-count increment now
warns and saturates the count, but cannot cancel the RCU free that has
already been queued. Returning that pointer lets callers access the
allocation after leaving RCU, when it can have been freed.

Use refcount_inc_not_zero() and return NULL if the reference cannot be
acquired, following the in6_dev_get() fix in commit 0e243671bc7b ("ipv6:
prevent in6_dev_get() from resurrecting inet6_dev"). A successful
increment retains the object for the caller. Under RTNL, a published
in_device still has a live reference, so reference acquisition is
unchanged. Callers already account for a NULL dev->ip_ptr result.

The RTM_GETNETCONF handler already checks for NULL and can keep
RTNL_FLAG_DOIT_UNLOCKED. This fixes reference acquisition in the helper
rather than serializing that one reader with teardown.

KASAN report as below:

  BUG: KASAN: slab-use-after-free in inet_netconf_fill_devconf+0x748/0x790
  Read of size 4 at addr ffff88811d70b958 by task ip_core_fixture/498

  Call Trace:
    [...]
    inet_netconf_fill_devconf+0x748/0x790
    inet_netconf_get_devconf+0x41c/0xe40
    rtnetlink_rcv_msg+0x7b9/0xce0
    netlink_rcv_skb+0x133/0x390
    [...]

  Allocated by task 496:
    [...]
    inetdev_init+0x60/0x550
    inetdev_event+0x71e/0x1780
    [...]

  Freed by task 0:
    [...]
    kfree+0x12b/0x530
    in_dev_free_rcu+0x51/0x90
    rcu_core+0x661/0x1d10
    [...]

  Last potentially related work creation:
    [...]
    __call_rcu_common.constprop.0+0x76/0xbd0
    in_dev_finish_destroy+0x12e/0x190
    inetdev_event+0xa37/0x1780
    [...]

Fixes: 9d40c84cf5bc ("net: devinet: Reduce refcount before grace period")
Reported-by: Baul Lee <baul.lee@xbow.com>
Closes: https://lore.kernel.org/netdev/20260815172032.79740-1-baul.lee@xbow.com/
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Changes in v2:
- Replace the RTNL workaround with non-zero reference acquisition.
- Keep RTM_GETNETCONF unlocked and return NULL for a retired in_device.
- Correct Fixes to 9d40c84cf5bc, as requested in the earlier review.
- Trim the traces and avoid unsupported double-destruction claims.

Link to v1: https://lore.kernel.org/r/pm-ip-core-objects-candidate-0002-v3-4af089192b0b62b40b9c@gmail.com

 include/linux/inetdevice.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index 6032eea2539a..a1446da64200 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -245,8 +245,8 @@ static inline struct in_device *in_dev_get(const struct net_device *dev)
 
 	rcu_read_lock();
 	in_dev = __in_dev_get_rcu(dev);
-	if (in_dev)
-		refcount_inc(&in_dev->refcnt);
+	if (in_dev && !refcount_inc_not_zero(&in_dev->refcnt))
+		in_dev = NULL;
 	rcu_read_unlock();
 	return in_dev;
 }

base-commit: 6d25ffca055a77787c21a36b66c253f76239411b
-- 
2.43.0

