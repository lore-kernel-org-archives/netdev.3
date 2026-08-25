Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A9A463B7A
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787671322; cv=none; b=HsWDFQrwAoup5iknxlBoY1WwePYNvPFvFjZEloo+Lvg3GHza5Ht2VB4CvOnnf8LSDp+zIiRcQt5O7DjEEF/pVsIfAEF2+FuAi9kWPwxcfJMgMJexsqcATpQCwXOMb7tTa4Hmsq6V5lELt0Ro3oPwxOa9oSLYiIj0cjgCv3pHk38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787671322; c=relaxed/simple;
	bh=4PoPYG2K42mgciAjX9Rt4iKz0r6GaC4A0xnXs67guIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYu79qQEMktQH9B+EKqZn7wVYXMpEK+2o8GwVpupyT6XBAn84X2bs8iKZHZB3ThD0heErdIXxLkUqDC9VD6t37TILHohQRAzx44asOj+2HUYm3bFJFpjDRVP1ilGWsph8v19yPHhMUJnk78pkVno5aF9NBqNDEBgb6YWnOr6w0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iidRA+cs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iidRA+cs"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d6b5aa7535so21913835ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787671320; x=1788276120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vc0aZw4w9FJVpAPDqzy/8czgK3vByXWj1yC+3VTKlDs=;
        b=iidRA+csNi8GFxFapmvdN+z5e9hQYaQW+bfl52Yk1LnnDz1hI+4fdgOr0CJzA6TQ3p
         2wbrkgD5sGbrU9FLArGmRLNXS2vzJi0j6+lj6SAuUNZPh4JeE8Zmk75TeT0GpMiuKdFk
         Ne1oOSHUJic46GMkJdDd9d91jdBOrG1qMA+ZxAmDYdgqFML7uxgvqQI9bxI8KFXanKSV
         hPeiDNnZpbf5DGiN9pkjfzt6gC1vZ381alng6ZdERktLijR5R+MQh95ACyP4tOsnbq+f
         mYm52xvMSFMor6veGoyF4F4ZJSHxjOtWMkgK+LoPppfQAvn7rbARRZiGMZ2f/91dOj2t
         t1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787671320; x=1788276120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vc0aZw4w9FJVpAPDqzy/8czgK3vByXWj1yC+3VTKlDs=;
        b=fEI2L1CuW1e54wzG+ebZtpBMA3ZmKLQvR6d2dKHvke+zhA82+caJQfl+3KibI6sQEs
         HdzKspl9yLcTnK6kJisby8MsghXBv3jd7b80ewh5Th2m5q5fk3jYlOyt6gkKAdW4PXKS
         6ALmLZCDBpv78FPisRfe3HLdHBvx+f4AaSrdrZ1Ctbu5T2ihtqLVZ0tKUuICUec4tpoS
         1s3Yoqh4SxCBXYWAZWQeOWWcUHHFhZRHeQFAMvJidw0m/YVBJoKWunyWrNW6OLBjM8DI
         Luj7aS66KLs/0BlJyF9HpSjH8OO6y+fPzJkbCT9CoFSxz4NDH80hNJvobX9MqS/+PIiq
         GQiQ==
X-Forwarded-Encrypted: i=1; AHgh+RpvkSkPdWdZ9jyluWCHyZWP/WUIuG2KpBRVlJ63JneJKAclj44jUygYGXSsoQFVrEEZ0TW4eyo=@vger.kernel.org
X-Gm-Message-State: AFuF++mfMiBYo1NJeNBmmZWlPCKQQFDiOEuJ5gbq5yczLoQKU8VQikHO
	rFwhXeo3vEP0phTnXoeCv0sj1GQvMyz2Ti4p59XEn2kM6/539Q5XCtrn
X-Gm-Gg: AR+sD13PuRZzScUHYhuJfVxBlaL6w1WRWQLbGSZbx4ze+axZcRHZHfxWkXNgfL7IerR
	q0FKwCl9SE5wlsdeSxFNjttts7td8+KHNWh1vHNLU5xPtfmLDGSV3GQD84AQbErFcYE/01Ws/5L
	qVmnSS4WfdQbh2RY5ZUhQTgETmnYRt5oKBiZMSYHyI3uylZx6wR67sk9fIWuwBboEVCVRX98D7c
	kxmiDBiJ7pA6t/nO6pvEfQvMIrNBQI6yA6KLHP5WR4+FA4IMRA5PgJNmMMt1+D/tn/aSjL63HXi
	XQanCfCmQ+hxXO1dOtFpScot5GDydUXb1CBBKwZAVIZXM+Z97ApurAZIEolGc4sP4HrQFVueHnS
	Bqd66kgHy9T6JQmcvuqcUgwhk3G7fnF71PO442guxlyH4G00C27UQLbW/8yXL+e2NZRIPKVQVuG
	j7jSqVjTMrOqXPBLdsERsZLsfkoCpRKKf9KLXykPv//hZrUC9y3lfQJkuXirvb+Tq6TfqfLq0W5
	UlUVkLkkfGQYTV4JNQXHtUz86E1
X-Received: by 2002:a17:902:ec87:b0:2cf:8131:75e8 with SMTP id d9443c01a7336-2d64b11893amr553802935ad.13.1787671320277;
        Tue, 25 Aug 2026 08:22:00 -0700 (PDT)
Received: from localhost.localdomain ([103.210.91.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f9236166sm37282967eec.28.2026.08.25.08.21.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 08:21:59 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com,
	ahemadkhawar123@gmail.com
Subject: [PATCH bpf-next] xsk: Fix circular locking dependency in xsk_bind
Date: Tue, 25 Aug 2026 20:51:52 +0530
Message-ID: <20260825152152.86092-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a circular locking dependency involving &net->xdp.lock,
&xs->mutex, and netdev_lock_ops():

-> #3 (&net->xdp.lock):
       xsk_notifier
       unregister_netdevice_many_notify
       rtnl_dellink

-> #2 (&port->pnodes_lock / netdev_lock):
       ipvlan_device_event / bond / netdev_change_features

-> #1 (netdev_lock_ops):
       xsk_bind (holds xs->mutex, takes netdev_lock_ops(dev))

-> #0 (&xs->mutex):
       xsk_diag_dump (holds net->xdp.lock, takes xs->mutex)

In xsk_bind(), xs->mutex was acquired before dev_get_by_index() and
netdev_lock_ops(dev). However, in netdev notifier callbacks like
xsk_notifier(), netdev_lock_ops(dev) is held by the netdev core while
taking net->xdp.lock and then xs->mutex, creating an ABBA lock
inversion between xs->mutex and netdev_lock_ops(dev).

Fix this by looking up the target net_device and acquiring
netdev_lock_ops(dev) before acquiring xs->mutex in xsk_bind(). This
aligns xsk_bind() with the global lock hierarchy:
rtnl_lock -> netdev_lock_ops(dev) -> net->xdp.lock -> xs->mutex.

Fixes: 978939c08db1 ("xsk: use netdev_lock_ops in xsk_bind")
Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aa48b5fe7bfda62d1682
Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
---
 net/xdp/xsk.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7855ee09c4..d2fbbeb7b6 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1612,19 +1612,18 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 		return -EINVAL;
 
 	rtnl_lock();
-	mutex_lock(&xs->mutex);
-	if (xs->state != XSK_READY) {
-		err = -EBUSY;
-		goto out_release;
-	}
-
 	dev = dev_get_by_index(sock_net(sk), sxdp->sxdp_ifindex);
 	if (!dev) {
 		err = -ENODEV;
-		goto out_release;
+		goto out_rtnl_unlock;
 	}
 
 	netdev_lock_ops(dev);
+	mutex_lock(&xs->mutex);
+	if (xs->state != XSK_READY) {
+		err = -EBUSY;
+		goto out_unlock;
+	}
 
 	if (!xs->rx && !xs->tx) {
 		err = -EINVAL;
@@ -1771,9 +1770,9 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 		smp_wmb();
 		WRITE_ONCE(xs->state, XSK_BOUND);
 	}
-	netdev_unlock_ops(dev);
-out_release:
 	mutex_unlock(&xs->mutex);
+	netdev_unlock_ops(dev);
+out_rtnl_unlock:
 	rtnl_unlock();
 	return err;
 }
-- 
2.54.0 (Apple Git-157)

