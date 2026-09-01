Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F1646D558
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248461; cv=none; b=g6POWeTmRmNeSIjjM769CowUJ89MCoxbHFVnYF1WhtFKadv7UGloLL4SaNl21FGHTMIDBZQ1Ogdhk5XPgvK3PB/k1aPHN7FJp+LxP8bGwxn/rX1NwujgqxOn2/QYp/9mAKmqakaPOhbgbs86uQyioaXbWmQRHe6WdI+VTKkFD80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248461; c=relaxed/simple;
	bh=d69I/cdvJ/o7q3nW7vBwryI/iZgtGSueqw1aSs5Y1TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1AhenhSZwXfN4vxieqc1sBTT3SrmzWEIZtAackGv17YAZNXJE76ylVOsWDElTweI/vmQUMrftxA9GV7BeHGAo6BUnrJuHK09eqMQMB1PvUFdYxK5aeuUJ4/938tEoETo+eVL5+iaKR9C/1TDscnkMoOeYLIibYMpwbfbfsRvBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=gwq3qHY6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="gwq3qHY6"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48431648f33so512844f8f.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 00:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788248457; x=1788853257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WzxcW1LLqwVWe0wSU90DzGvke623LGpZQMtqGLDr5j8=;
        b=gwq3qHY61ExCAEo9vWnYPjhPuTvZSCcblZKJkEmTNO/lAKxOPd1/U4iw1VzxqWTJLG
         i7JKL32RC35NaBr5tAI+h0srDgvwQJ3sH9K3VmfX1SgVfVQf609GcL0uvdtK56tpuBse
         6+zIb/NinYnByHK0rfG7WJ1hA/mer3ajVeKLzSVmQ6Zc5dYkfYoOk11gVkhs6JBp5y70
         SeQoAOVlrGfdJomIi4HF1ZztYjHPI0n8eK8lxdaP2gag3M0na+dr9I4/J2l5lI9MpM5+
         t5uQckISmV0b8qZCxG9Bx/8FlYtr/qRsfVHzDC0OkIDdTE/Zz2WG9z27x3Bq8COMeq1v
         Xw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788248457; x=1788853257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WzxcW1LLqwVWe0wSU90DzGvke623LGpZQMtqGLDr5j8=;
        b=kFrzu2g+WOQqQLlryfUtrs19g6r0jnIN7SxtlRPNZtTi7oUTX4kI2+OsaJOP/5IK9z
         dMrSOnIMtMuF/uXVrmuavAzDSganaixxmwKMy8jJQ7r26DF5TrMGBk4qcXvv1sd/fMis
         tsn0dLucpaHJ0cD+AKG0CEB9+Mt3KezELTJcGn6g6Xzk3BogGjL71uz9v9Tbi2CTh1Rv
         xA9B51Q4v2A23GOQJ9HpfBKttu0DbaYRd47hTCZjv5VedJilCV8KyzwtdionB8jbNz7A
         K8VB0zFejb+bqHjRIjM/GF/7Z43h/SpkLxN0UCEYzSm7LTBbYhuCnbdi3pYWrzYbWQBz
         ImGA==
X-Gm-Message-State: AFuF++mmKXS3rSZEfvzYQYrOBjzwLGDBWE9qBqYe2mFqxck6d77M6Xqh
	5KII65V6XjUOZD9qOpUTNqs2PwnDfHvyP4BGIHeVN7v34OcAdWqRjQE35RJ0tBbt/2eJE+Xo+8z
	fiLGAG2o8IA==
X-Gm-Gg: AR+sD12Hnq9hDQsHqHcsO1W5OIsUjZ88TuIXmSRIp2sMwKS4UJflzL2tRgpt9YWhMwe
	t4fmRAQB09M7Xw+7NoqFRBaO6kaours4I8SpFCUhA2GCgSsjrD+kMUsdNQ51hV7eKjqBs+23HkB
	NYbOEU73nF5P3rLm2q3oJ6KjPLqNZN8JadXjru7iJL0RILf6XQ5U8Ub32uBP02GRKLfVKOf1Vlo
	GC5WXzoOHpVUXhrAqpSBI23gLtdT8gougLtnCBgHjWl1Q0RU032VmOtTLnC+/j9v8sXizejdpnO
	OpzZBybA5gu2xgamhE5r0XgTRoG+qDUGBiAQyYJHb8alUDTFRpZtBE/zoAGMMa81Ufq4AroYznL
	pEG5TqgnxjIQb6iL9QGOZ4kS39J3VkNWUR6jAjCmQK5PPLzWsyHUrIvaBcXFpNp84NJ1bApi5Hv
	UTedpy2gCpWQvTnj9pzNW0hUcG8wZWkGTs8k3UhD15Bc7dJNF1VCmAyPaRq0Bhn3yxUmUko+qDo
	Vjh4po5vzM=
X-Received: by 2002:a05:600c:217:b0:49b:9105:e831 with SMTP id 5b1f17b1804b1-49cdd635db8mr37882095e9.7.1788248456986;
        Tue, 01 Sep 2026 00:40:56 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d3c4absm3142913f8f.10.2026.09.01.00.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:40:56 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linus.luessing@c0d3.blue,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net v2] net: bridge: mcast: fix br_multicast_list_adjacent rcu walk of mglist
Date: Tue,  1 Sep 2026 10:40:46 +0300
Message-ID: <20260901074046.316190-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko reported a bug [1] that br_multicast_del_port_group unlists the
port group not using proper rcu helper that preserves the next pointer and
after that immediately frees the port group without waiting for rcu grace
period. The only rcu walker of mglist is br_multicast_list_adjacent() and
it turns out that function has always been buggy because mglist was never
converted to RCU. Fix it by acquiring the bridge's multicast lock for the
mglist walk. Return -ENOMEM on allocation error.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Fixes: 07f8ac4a1e26 ("bridge: add export of multicast database adjacent to net_dev")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: while changing this fn, return -ENOMEM on error and document it in
    the kdoc (sashiko)

 net/bridge/br_multicast.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3ef5d8bbf552..97686984de6d 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4936,13 +4936,15 @@ void br_multicast_set_startup_query_intvl(struct net_bridge_mcast *brmctx,
  * snooping feature on all bridge ports of dev's bridge device, excluding
  * the addresses from dev itself.
  *
- * Returns the number of items added to br_ip_list.
+ * Return: The number of items added to br_ip_list or -ENOMEM on memory
+ *         allocation error
  *
  * Notes:
  * - br_ip_list needs to be initialized by caller
  * - br_ip_list might contain duplicates in the end
  *   (needs to be taken care of by caller)
  * - br_ip_list needs to be freed by caller
+ * - on -ENOMEM the caller must free any allocated entries
  */
 int br_multicast_list_adjacent(struct net_device *dev,
 			       struct list_head *br_ip_list)
@@ -4967,15 +4969,20 @@ int br_multicast_list_adjacent(struct net_device *dev,
 		if (!port->dev || port->dev == dev)
 			continue;
 
-		hlist_for_each_entry_rcu(group, &port->mglist, mglist) {
+		spin_lock_bh(&br->multicast_lock);
+		hlist_for_each_entry(group, &port->mglist, mglist) {
 			entry = kmalloc_obj(*entry, GFP_ATOMIC);
-			if (!entry)
+			if (!entry) {
+				spin_unlock_bh(&br->multicast_lock);
+				count = -ENOMEM;
 				goto unlock;
+			}
 
 			entry->addr = group->key.addr;
 			list_add(&entry->list, br_ip_list);
 			count++;
 		}
+		spin_unlock_bh(&br->multicast_lock);
 	}
 
 unlock:
-- 
2.47.3

