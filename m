Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782CF13D891
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786814443; cv=none; b=W01NJsF8QNaSN/thcf8eD59gPZ1On2aGfHRAFBM6N7OvLRGwgQOkYBmRxSQy9hW6awpCFYlWhI1tmRz3AjgkOoOacutp/sPNlrI9E27oDHn6NjZ6tva0eikMPuTV3nbEsw2+oEdIz6ktfEvgTgcgGcHKS0L4cX/+607X7cZ+6AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786814443; c=relaxed/simple;
	bh=GkYUEAY9Fh48b1cuYNZukFRNDJzRytRYQTNsi8EW33Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gf+NpPFRf1pP5dz4FCVrlppWBsGaYrIFlPO6DfZb2Bp8qdETbHLziyEo/DSkK8t0CxD9rK2JbcJ4IoFZ6DkKrkPSBSEyc8ZwSDR88pXysB57X8UTBUIbIhx8HyTSUCfB6ETsdj9GWZY+3ZHRM+UHZ4YhAZpIhIExmj0hQs4F++I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=MykriOWo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="MykriOWo"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc61541f8cso38672945ad.0
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 10:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1786814442; x=1787419242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xOhXcLJBN0+9oZqIF3HKJ0CWwKJoc7ILQyCOL2sYC5k=;
        b=MykriOWoezWMRmPtljr+z9uIcB/KcRAZwrbmfCV5GVSiQBwhpiU1/cR2+6EtvG6aVa
         jvO9/eJMOidEDREBxd0c//3gSOkBU6m+XkRnui/xhE3wnYDZyfjc/gOEIDbk3dNSB9Zl
         acYpdFE36nO0FPtq9M5xHOn82U4q4PPBcY0o4xZA5tk0tvhhTgTGnUDS47KzrrrUZzWh
         zm99zmGXYjbqAYcLSmkohlvMqc0Eb0GXfFqhGwLC+SSWJInZBKwlc1Y4r8LqrH3Ur/Xk
         +tyTze1jwXCSwHXWr6Ta+cjiQW3tNHqGfnvD5fQEOJRWs4/Bi1Gi177h9+Pchlz40MKh
         OMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786814442; x=1787419242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xOhXcLJBN0+9oZqIF3HKJ0CWwKJoc7ILQyCOL2sYC5k=;
        b=MfIHy1LBnuis8la/phhW/oOkwqHGdugZg/iTEM1H/RmIzLpS1QaX8h8tyUb0hLW5dU
         79x51+IrcJmunHZe5clZJRFhBTG041RkO1WBXN88IchVpewXMOLxrTo0azNKzPo5m8gT
         iHbSvWOIU61teBQsjMwkNwvzEu+hCdbbLyWjd0JhQ8GUrbldDZKaLS4A5EPK2A3IP4K3
         WPbDMzTJUAROBc6zGp88rlelWnkYDovu3CHuQ1hqXtLsL36mTfesGm1dkAovgFIfCXRW
         2jtGSwagCmvvC/S6zSCVy+OZTkS3newWKZV2PF1o8M+IYifo91OpAsL78M1CupCYIhcb
         wD6w==
X-Forwarded-Encrypted: i=1; AHgh+Ro6Higz1vHvQ6NyWVyStnIj7PZIlGqhB0QP2mIwr2ShejPVcI4IjOd/2fZiyRD25W3H1wNSbmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjVw6HGcncoIGlU5nXGFKU400i+iAAHg6dk1Mlknv3pG8MszTh
	JV0fP91UgMDCL4HwFfThHwjEVrzQfp9Eunzp82Uez3EOVPNa81x2uQlQXdex93UYLvA=
X-Gm-Gg: AR+sD13a4sNsVHyxFEKCjaGKPpbXeCNOVUJwswEyyGXIZV/wg2Pero+XqwCzwLWnEB7
	SisRhxz9m/6rbZ4hCVfjZFCKoXJip+5Y51hdKCzAAUgJctAbIf/OiPRcuQwZ0aF/kMCjpBu0AmM
	tBXLfpwHRqBNI30RCG0+7JizQsGWuXmQpEBdd/xQ0MS5N7hUs72fNKWGni+0T5kMrDvRtTeKYpY
	UTgYG72A/Gj4GbEQ+ZA+L0cF7un/xSMqKB0x1DJbyrfRFLJx7x8bkG/RaWes151gOu6k8fWPeYw
	EYCkF/yugNInDNzlZ694dbV3FuyuuUjjfQojszG2fvJ3/hOQBrOBcPZzZs433pM7XXA4t/IUvt1
	RkBHSbpadeD0FVqAIQBSJViRoGF6iQWqkHSaOzHQ6DzgKWUa9huXCGg73MTyVawDblwY7MrRMUu
	Mr3+gvGz6iPYoibYZ6ej2ZEtRkBQzIme2Hqr9HLKEDeErcgeE2yWA/0RME2PJ/7HBPxGTRzUVxF
	0brAKA0iKavtOvCBea/AoSj1fvq2bK7poMTEvfuyXuL0A==
X-Received: by 2002:a17:90b:48c2:b0:385:3ab:fecb with SMTP id 98e67ed59e1d1-3933af07e4dmr11226876a91.4.1786814441698;
        Sat, 15 Aug 2026 10:20:41 -0700 (PDT)
Received: from localhost.localdomain ([125.181.61.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea99ab1dsm6576459a91.7.2026.08.15.10.20.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 10:20:40 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	idosch@nvidia.com
Cc: jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com
Subject: [PATCH net] ipv4: Fix in_device refcount resurrection in in_dev_get()
Date: Sun, 16 Aug 2026 02:20:32 +0900
Message-ID: <20260815172032.79740-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in_dev_get() reads dev->ip_ptr under RCU and then unconditionally
increments its refcount. inetdev_destroy() clears the pointer and drops
the last reference under RTNL, with no grace period in between, so a
reader that fetched the pointer before the store can increment a
refcount that has already reached zero. That resurrects an object whose
RCU free is queued: dropping the resurrected reference re-enters
in_dev_finish_destroy() for a second netdev_put() and a second
call_rcu() on the same rcu_head, and if the grace period elapses first
the drop itself is a use-after-free.

inet_netconf_get_devconf() is registered RTNL_FLAG_DOIT_UNLOCKED, and
rtnetlink_rcv_msg() exempts RTNL_KIND_GET from the CAP_NET_ADMIN check,
so an unprivileged user can drive the reader side. Reproduced as UID
65534 on v7.2-rc7:

  refcount_t: addition on 0; use-after-free.
  WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x14c/0x180
  CPU: 0 UID: 65534 PID: 655 Comm: j1_poc
   refcount_warn_saturate+0x14c/0x180 (P)
   inet_netconf_get_devconf+0x4b0/0x4c4
   rtnetlink_rcv_msg+0x434/0x4d0

followed by the matching underflow when the reference is dropped.

Use refcount_inc_not_zero() and return NULL for an in_device that has
already reached zero. All callers already handle a NULL return, which
in_dev_get() gives today whenever dev->ip_ptr is NULL. Callers under
RTNL see no change: ip_ptr is cleared before the last put, so a non-NULL
ip_ptr there implies a non-zero refcount.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: bbcf91053bb6 ("inet: do not use RTNL in inet_netconf_get_devconf()")
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
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
-- 
2.50.1

