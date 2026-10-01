Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09004D17B3
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887681; cv=none; b=JIeRS1edHD0H+xOJMGEp1yJey2Xtva7sKX2Iug5xIlsdFzZm2aweWn0U8IBmhBfwiGxNlDBY4vok/+VTR8wAWfZgwQtOJM9Q3b0odWErjghc8WsPqDTGao1cjz/OXN9+1iwxZ4xPzEgA1BzT18s6Xbgs+V9CZmD2I3kGjh+UTAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887681; c=relaxed/simple;
	bh=LbS2LgOcciB1fQHXXzSJLlgWFNW4QLaTmuGy04+gs6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ke2w+KRIkP1qzx0spespmABUBfaHnJwyquE7ZQ00UwGcIq3DaFNSBM4M432xBS/KZg/M/s87D2k8VmoTp49GMVA4TJFgOFtt2K1vM4V643yCgr5AJlMJPn7Rt2nthZ5mbEvjl5QyTzm+YbjvGE07RYf8cXV1hp1Yrmrh2clTCC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJ8Ue/kh; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJ8Ue/kh"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6f75c1219so87569335ad.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790887679; x=1791492479; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/lanfkUrOD6rPynrBSLTm6BIjWsTk9sA1acV5eOaW7M=;
        b=qJ8Ue/khHORJ+OzvYWp9V4wKDOS9/KRjYkHDS3XGuR5twV284icviWT99tY1CNthII
         T0W6TM/Ds0MjPMBMX+/UmnCIFbLs/UUQXNJTgsSVGLm3TdWOEHnxHATLGVFh4QbIN0Vr
         GBHvnX00zJP6XUMmUSJOL/rbqNbxA3txMoPj0AEJv30ril8syCdf8AqYBQM1dwvA3SbL
         5mROfMVsmVkfrF4nW0bl/wbMf5wh2Bd75SUSvc2ivYGD6hcf5rlgHJyvr+eLaHjME9LQ
         CHbtBmAV3ehMGN5T83erijcNPpVIFHVE+9q7JaUMyhkdHgOHfyrLvneEoWTtirHPP5rF
         5wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790887679; x=1791492479;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/lanfkUrOD6rPynrBSLTm6BIjWsTk9sA1acV5eOaW7M=;
        b=Gf8B9J0YsM3clUR06y2g+HhZjgGNdodpmktZWv+hsdJOXcvVxajDoRvNZfk1RpkSv8
         aLKBgS3DoknM9tpkqn6aYYadfhv0v/SR7Ibxa95xA0+o4NOoCWt8QLlzq9alWom0CYFa
         qLSQqtxo8ZXSybCDE97cEBLoJ6ffd8MGHUfelwPfi0YweNJzaXDuMZKNWExrRQDS7e6v
         I0BgopvkgtZtD39YvhPHHI53n8iQ3HjViQCoiqEOS5WORWVdhXNLVNR2DAvoeVCWtcHh
         f/B2ny/y3pkmuh8P5JXCI2Uwx6y4IGw6FaOn2wEEbrCyHC/4vtnoD+sBQEuKPWutIj6/
         UojQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxOOmdCyDkHZlywzuAdVHk8/NHstAwzHBD9xKp47rvpS1hGftMiytifE/AtCVWKG6dIm6Tgq8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0ghs/p5lAdZ97B4n08evBcWvDeoAVQkUwfPp1fWzUhAZWNmQl
	mkk8vGp2ynID4QO6dl5dyCFqToGgOleuHoxoPE+4n9uxqQin7yie446jD1c4keS8DcUr1L7tut4
	ASX73vw==
X-Received: from plrq4.prod.google.com ([2002:a17:902:b104:b0:2df:833c:ba8b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f608:b0:2df:9a29:aeb2
 with SMTP id d9443c01a7336-2e49a103e0amr5387975ad.3.1790887678618; Thu, 01
 Oct 2026 13:47:58 -0700 (PDT)
Date: Thu,  1 Oct 2026 20:47:15 +0000
In-Reply-To: <20261001204752.2572265-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001204752.2572265-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001204752.2572265-4-kuniyu@google.com>
Subject: [PATCH v3 net-next 3/6] net: Rename dev_isalive() to netif_is_alive().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Chris J Arges <carges@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The next patch needs to use dev_isalive() in xfrm.

We should try to avoid using the dev_ prefix on APIs
we export via include/linux/.

Let's move it to include/linux/netdevice.h and rename
to netif_is_alive().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/netdevice.h |  6 ++++++
 net/core/dev.h            |  6 ------
 net/core/net-sysfs.c      | 16 ++++++++--------
 net/core/netdev_work.c    |  4 ++--
 net/core/rtnetlink.c      |  2 +-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d037faff7c44..971f1056aef0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5712,6 +5712,12 @@ static inline const char *netdev_name(const struct net_device *dev)
 	return dev->name;
 }
 
+/* Caller holds RTNL, netdev->lock or RCU */
+static inline bool netif_is_alive(const struct net_device *dev)
+{
+	return READ_ONCE(dev->reg_state) <= NETREG_REGISTERED;
+}
+
 static inline const char *netdev_reg_state(const struct net_device *dev)
 {
 	u8 reg_state = READ_ONCE(dev->reg_state);
diff --git a/net/core/dev.h b/net/core/dev.h
index 51921623fc0a..43beebddf22f 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -412,10 +412,4 @@ int dev_get_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg);
 int net_hwtstamp_validate(const struct kernel_hwtstamp_config *cfg);
 
-/* Caller holds RTNL, netdev->lock or RCU */
-static inline bool dev_isalive(const struct net_device *dev)
-{
-	return READ_ONCE(dev->reg_state) <= NETREG_REGISTERED;
-}
-
 #endif
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index fa790e442570..e24a5154b212 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -100,7 +100,7 @@ static int sysfs_rtnl_lock(struct kobject *kobj, struct attribute *attr,
 	/* Check dismantle on the device hasn't started, otherwise deny the
 	 * operation.
 	 */
-	if (!dev_isalive(ndev)) {
+	if (!netif_is_alive(ndev)) {
 		rtnl_unlock();
 		ret = -ENODEV;
 		goto unbreak;
@@ -143,7 +143,7 @@ static int sysfs_get_link_ksettings(struct device *dev,
 	}
 	netdev_lock_ops(netdev);
 
-	if (!dev_isalive(netdev)) {
+	if (!netif_is_alive(netdev)) {
 		ret = -ENODEV;
 		goto unlock;
 	}
@@ -170,7 +170,7 @@ static ssize_t netdev_show(const struct device *dev,
 	ssize_t ret = -EINVAL;
 
 	rcu_read_lock();
-	if (dev_isalive(ndev))
+	if (netif_is_alive(ndev))
 		ret = (*format)(ndev, buf);
 	rcu_read_unlock();
 
@@ -247,7 +247,7 @@ netdev_lock_store(struct device *dev, struct device_attribute *attr,
 
 	netdev_lock(netdev);
 
-	if (dev_isalive(netdev)) {
+	if (netif_is_alive(netdev)) {
 		ret = (*set)(netdev, new);
 		if (ret == 0)
 			ret = len;
@@ -303,7 +303,7 @@ static ssize_t address_show(struct device *dev, struct device_attribute *attr,
 	down_read(&dev_addr_sem);
 
 	rcu_read_lock();
-	if (dev_isalive(ndev))
+	if (netif_is_alive(ndev))
 		ret = sysfs_format_mac(buf, ndev->dev_addr, ndev->addr_len);
 	rcu_read_unlock();
 
@@ -319,7 +319,7 @@ static ssize_t broadcast_show(struct device *dev,
 	int ret = -EINVAL;
 
 	rcu_read_lock();
-	if (dev_isalive(ndev))
+	if (netif_is_alive(ndev))
 		ret = sysfs_format_mac(buf, ndev->broadcast, ndev->addr_len);
 	rcu_read_unlock();
 	return ret;
@@ -747,7 +747,7 @@ static ssize_t threaded_show(struct device *dev,
 
 	rcu_read_lock();
 
-	if (dev_isalive(netdev))
+	if (netif_is_alive(netdev))
 		ret = sysfs_emit(buf, fmt_dec, READ_ONCE(netdev->threaded));
 
 	rcu_read_unlock();
@@ -824,7 +824,7 @@ static ssize_t netstat_show(const struct device *d,
 		offset % sizeof(u64) != 0);
 
 	rcu_read_lock();
-	if (dev_isalive(dev)) {
+	if (netif_is_alive(dev)) {
 		struct rtnl_link_stats64 temp;
 		const struct rtnl_link_stats64 *stats = dev_get_stats(dev, &temp);
 
diff --git a/net/core/netdev_work.c b/net/core/netdev_work.c
index c99967907e18..1b11bcbeb196 100644
--- a/net/core/netdev_work.c
+++ b/net/core/netdev_work.c
@@ -30,7 +30,7 @@ static void netdev_work_enqueue(struct net_device *dev, unsigned long events,
 		return;
 
 	spin_lock_bh(&netdev_work_lock);
-	if (!dev_isalive(dev)) {
+	if (!netif_is_alive(dev)) {
 		spin_unlock_bh(&netdev_work_lock);
 		return;
 	}
@@ -154,7 +154,7 @@ static void netdev_work_proc(struct work_struct *work)
 			/* We took another ref above */
 			netdev_put(dev, &dev->work_tracker);
 
-			if (!dev_isalive(dev))
+			if (!netif_is_alive(dev))
 				core = events = 0;
 		}
 		spin_unlock_bh(&netdev_work_lock);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e3444fd24061..62b4f18e37b8 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4356,7 +4356,7 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 retry:
 	if (need_rtnl) {
 		rtnl_lock();
-		if (!dev_isalive(dev)) {
+		if (!netif_is_alive(dev)) {
 			err = -ENODEV;
 			nskb = NULL;
 			goto unlock;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

