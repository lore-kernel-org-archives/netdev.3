Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AD335B63D
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 05:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790832124; cv=none; b=INZep5dUXuJH6dIlt/kF9lL2XdB18WpwtyXV+ixF0SnEWafvAdNpX7TlbRUMYY8eaLxDscPMNb1FdWmbyCxyIdkroy2kizWgcGcNX2YcIhLt1LMmUFFuVfRq9otCJ6mPItaFrbSrNGZJXlCo+Vb/eTDHVH1O9q71Gkz0/RnCrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790832124; c=relaxed/simple;
	bh=6zQ/dGVekAKk4Ygn9pvYX2mxUUI5q0Qrh3Z4u8De64U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RV1hPE6eJvT75laveM82A5NgZwiQWkLoqrpXLJMES2iio/emFSPyZgao7djtrxJArg8zYzA/orWfKrbpggvxOKvIQowwt8jJT29SyA6e+P0t2sBxb7Dj1KOf/7Ll8nRUEpU6EADM/911iZ7HQCyJsf4GwqD+Y488sRtP7jEKB+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4kUH1Vm; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4kUH1Vm"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-881d9da69b1so1583231b3a.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790832122; x=1791436922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=drcBlhp1loCKFpHE49qLsszBsMwUy6/00G+FHSsCpkE=;
        b=h4kUH1VmE42UdcYrg11gtXQ/lhNyR5YAYXEptIbhoeW++yQszCm8GgXdXK0b46FdzC
         9xUFLzCneA5XwLk/oLLLhLxP/Eg8iLhc7cJH0oIC797QxjAe2NTeR6aYza2sljOscqa7
         S/fo0hC86xhofaTWBisCx31UWiqlLPYuW8tOzRnLjaPhnxBe8E5mLoFceHiWKJoSDzX5
         PG4Q49IJbLXtlXkGOMWv2olcjWEoilArz2rYMCI+ES8DNt09//v1M5Nvzv0vNvW/hzDb
         UxRkPVSTjxyM6PL+GaSpiXuowMu7j5FdOAzGpoR0adW+1TrBS9uONmoVE76bHHmxwRqL
         uv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790832122; x=1791436922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drcBlhp1loCKFpHE49qLsszBsMwUy6/00G+FHSsCpkE=;
        b=QRT8SswLlLvQsPKsODN04U6G49IwwoRm/al6ODmr1iwadHXbBJ2fy8W2LhJoktAUwv
         1DY/+oJaiJOHiXae/aKil/gcVhNEKwWf54jJrZQunrUrhDBDDQH+/akODULctsvA0/er
         9p4mKmF5ttwr9kvl8WOS6rXydYWoB//xyAEKczszCITnGRAtBse1nNUhuKNNInKJ1a8Y
         tcQLi+3rLWPkw5iACUkwMwiY/Fh0mpEvBWyRtcxDsRT5mVzvADE9e25POvO434ncX8Ei
         bcaeTHm/a3vhoCdBnGR6SCOkTGawbyaaaaUedBekkStTKnjDlQ/hpvE/yu1rLPn40xnr
         /HzA==
X-Forwarded-Encrypted: i=1; AKwUvBwsUTKl4W6jA/MGc5xn+w1PCgREOsI49S3sKxE+6jE6vMl2KQw5w3PSrMls6pOC7YsNdQ9maNg=@vger.kernel.org
X-Gm-Message-State: AFuF++kC9COufuTpubWFlhqEf7MihxJSF02gRkJg/oJPbhhN4PEkz4wi
	KQg00Z93iGSWxRfnHUkzwfC/go8Iq3JDoynhNHHJI/n8zC306cb4fodb2yX59CiV
X-Gm-Gg: AYBFou20ndhAZuEA+mQ7KHjMcE/oG6Oa4FiKpjVj9Lj4kyXuz7l+egncRkB5k5V49zL
	xzP1td4W7rRqpzkYsSy9L8fSwCYj6uAeWkxQwbvGBclx76HhqZhLTex94lNQxWOoeilrf/qzadw
	0xEa4DhXbLyHG/Yimwh/8r1WpEkFwKiiPkth/XuRpxh599h4okmCUN3cNom6n4Yxohr+P8nFmI9
	LwzFX1M+NdWLxsG2CUesZ17C+FLZFgEOcNilUaEz5aFBJFe0u4uGCJMNjDtl1ImTQTbQhtfPa23
	XtE0fItQI9p2Y4CdIfJ0PsQzonuVazh6loSw1gt8NlTmxOw7p3jQqbyZ3EyDryZDgb/DTGTkck9
	M5jzLRQRMVnP0gOh6LL1e/CRe0YtMbmvWrVTWyZjiz2MyJxzz5wtcp9mOR7rWziUJ1ncSIXXJTM
	a6+ymPIxcVxQEcEnB7cjtfo3KBkVHgCM+lo0UmsnrRJThuFe0Koh/zGDAQDOsuj06jWZzpocLXl
	Gm0ZTaCn1o=
X-Received: by 2002:a05:6a00:1415:b0:881:7ff5:6061 with SMTP id d2e1a72fcca58-8874c6d6e74mr2623126b3a.24.1790832121957;
        Wed, 30 Sep 2026 22:22:01 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88819bbc6basm461851b3a.55.2026.09.30.22.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 22:22:01 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net] ipv6: serialize address publication with addrconf_ifdown
Date: Thu,  1 Oct 2026 14:21:50 +0900
Message-ID: <20261001052150.136559-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipv6_add_addr() inserts an inet6_ifaddr into the per-net hash before
linking it into idev->addr_list. addrconf_ifdown() clears the hash first
and snapshots the device list later. A nonblocking add can therefore
enter between the two teardown observations.

When a non-loopback device's MTU falls below IPV6_MIN_MTU, teardown
marks and detaches the idev. A late add can then link the ifaddr into the
dead idev. On v7.2, a deterministic interleaving left the object
hash-visible with idev->dead=1. ipv6_get_ifaddr() returned it, and later
device deletion waited indefinitely with usage count 3. During network
namespace exit that wait can stall the single-thread netns cleanup
workqueue.

MTU changes require CAP_NET_ADMIN in the affected network namespace.
Where unprivileged user namespaces are permitted, a local user can
obtain that capability in a new user and network namespace.

Publish the hash and device-list memberships while holding
addrconf_hash_lock followed by idev->lock. Recheck idev->dead and
disable_ipv6 before either publication. If teardown wins, the add fails
before publishing the object or taking a list reference.

The same forced interleaving now returns -ENODEV and device deletion
completes without a KASAN or LOCKDEP diagnostic. A real Router
Advertisement separately reached ipv6_add_addr() with can_block=false;
bounded natural stress did not reproduce the full race. A reproducer is
available on request.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/ipv6/addrconf.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c90ee6dd7446c..899e9a47f7585 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1047,8 +1047,9 @@ static bool ipv6_chk_same_addr(struct net *net, const struct in6_addr *addr,
 	return false;
 }
 
-static int ipv6_add_addr_hash(struct net_device *dev, struct inet6_ifaddr *ifa)
+static int ipv6_add_addr_hash(struct inet6_dev *idev, struct inet6_ifaddr *ifa)
 {
+	struct net_device *dev = idev->dev;
 	struct net *net = dev_net(dev);
 	unsigned int hash = inet6_addr_hash(net, &ifa->addr);
 	int err = 0;
@@ -1060,7 +1061,23 @@ static int ipv6_add_addr_hash(struct net_device *dev, struct inet6_ifaddr *ifa)
 		netdev_dbg(dev, "ipv6_add_addr: already assigned\n");
 		err = -EEXIST;
 	} else {
-		hlist_add_head_rcu(&ifa->addr_lst, &net->ipv6.inet6_addr_lst[hash]);
+		write_lock(&idev->lock);
+		if (idev->dead || idev->cnf.disable_ipv6) {
+			err = idev->dead ? -ENODEV : -EACCES;
+		} else {
+			hlist_add_head_rcu(&ifa->addr_lst,
+					   &net->ipv6.inet6_addr_lst[hash]);
+			ipv6_link_dev_addr(idev, ifa);
+
+			if (ifa->flags & IFA_F_TEMPORARY) {
+				/* manage_tempaddrs() relies on addresses being added to the head */
+				list_add(&ifa->tmp_list, &idev->tempaddr_list);
+				in6_ifa_hold(ifa);
+			}
+
+			in6_ifa_hold(ifa);
+		}
+		write_unlock(&idev->lock);
 	}
 
 	spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
@@ -1168,26 +1185,12 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 
 	rcu_read_lock();
 
-	err = ipv6_add_addr_hash(idev->dev, ifa);
+	err = ipv6_add_addr_hash(idev, ifa);
 	if (err < 0) {
 		rcu_read_unlock();
 		goto out;
 	}
 
-	write_lock_bh(&idev->lock);
-
-	/* Add to inet6_dev unicast addr list. */
-	ipv6_link_dev_addr(idev, ifa);
-
-	if (ifa->flags&IFA_F_TEMPORARY) {
-		/* manage_tempaddrs() relies on addresses being added to the head */
-		list_add(&ifa->tmp_list, &idev->tempaddr_list);
-		in6_ifa_hold(ifa);
-	}
-
-	in6_ifa_hold(ifa);
-	write_unlock_bh(&idev->lock);
-
 	rcu_read_unlock();
 
 	inet6addr_notifier_call_chain(NETDEV_UP, ifa);

base-commit: 7375d38364a9aa66fb31716bcefef38aecad75d8
