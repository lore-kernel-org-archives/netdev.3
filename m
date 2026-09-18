Received: from mta0.migadu.com (out-137.mta0.migadu.com [91.218.175.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E883C872A
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 02:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698220; cv=none; b=qelwhZL4EM5IQJP3l5TqoUS/CjS/anFblY0Sh/S/35W3TOSi/4anB2Wuzl8NNKUDDWX6jrYPjyf9K3S8IwMmGnjGZdfITyaOSOWKldNv/CKFO/bTIKBTK1scHxzc0/EwTXqy9h38Nl6Hqo4enabeK5Me3DGytYsAycOPhVfj7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698220; c=relaxed/simple;
	bh=SK7qn15tIjq6+Yb9VJvc+sI3qcbb2mDtAAmJCsPN/iM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U4vM/6VGjcsZ1KPz0OsTBpQffeBWYYEIglT/er1PFlFpxWAe5+tvL27u2Ih2Lccj+T+PZjW1NdStQ80FskyJ+ZtZ8b4ObA3tZv1wmTCE0p2jVwf4/pPC2oKgAoEF9+K8dvY2w7qMl59KmmqB+Db3i1L9qYscJZtjjczf6rYD14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gDLV9Mqc; arc=none smtp.client-ip=91.218.175.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gDLV9Mqc"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SK7qn15tIjq6+Yb9VJvc+sI3qcbb2mDtAAmJCsPN/iM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789698206; v=1; x=1790303006;
 b=gDLV9MqcsN9OcdCxwIfOGFi5LiCaN6AJJ/ezuVKMkpUPzp1q2YdiblTTPKUIuleG0qklo+NE
 1+hi1QXnFYHgy5eEF13K4ldWilrw4HAEs9OnDhcwxnd/c5RUv5mNh6UrUcALAJo/K0CBbCG78iB
 Mg0cOGsaUo3J8JYWINZURa78=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 304ce3a29e7bae13;
	Fri, 18 Sep 2026 02:23:16 +0000
X-Mizu-Trace-ID: 304ce3a29e7bae13
X-Migadu-Flow: FLOW_OUT
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com
Subject: [PATCH net v2] net: phy: allow phy_detach() before netdev registration
Date: Fri, 18 Sep 2026 10:23:16 +0800
Message-Id: <20260918022316.237646-1-chenguang.zhao@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

phylink_connect_phy() may be called from probe without RTNL while the
net_device is still NETREG_UNINITIALIZED. If phylink_bringup_phy()
fails, phy_detach() uses rtnl_dereference(dev->hwprov) and lockdep
reports suspicious RCU usage.

hwprov cannot have been assigned before register_netdevice(). Relax the
RCU check for that state only; registered devices still require RTNL.

Fixes: 35f7cad1743e ("net: Add the possibility to support a selected hwtstamp in netdevice")
Reported-by: syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=694b49f41098a5df4fd7

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
v2:
 phy_attach() does not set dev->hwprov. It is only written by ethtool
 TSCONFIG after register_netdevice(). when calling phy_detach(), we
 need to check whether hwprov is NULL to clean up dangling pointers.

 This patch uses `NETREG_UNINITIALIZED` as a flag. When PHY registration
 fails, TSCONFIG remains unset; hence `dev->hwprov` should not be accessed.

v1:
 https://lore.kernel.org/all/20260916021505.238990-1-chenguang.zhao@linux.dev/

 drivers/net/phy/phy_device.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..a3a7d5c75970 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1941,11 +1941,13 @@ void phy_detach(struct phy_device *phydev)
 		/* hwprov may technically be protected by ops lock but
 		 * not for devices with a phydev, see phy_link_topo_add_phy()
 		 */
-		hwprov = rtnl_dereference(dev->hwprov);
-		/* Disable timestamp if it is the one selected */
-		if (hwprov && hwprov->phydev == phydev) {
-			rcu_assign_pointer(dev->hwprov, NULL);
-			kfree_rcu(hwprov, rcu_head);
+		if (dev->reg_state != NETREG_UNINITIALIZED) {
+			hwprov = rtnl_dereference(dev->hwprov);
+			/* Disable timestamp if it is the one selected */
+			if (hwprov && hwprov->phydev == phydev) {
+				rcu_assign_pointer(dev->hwprov, NULL);
+				kfree_rcu(hwprov, rcu_head);
+			}
 		}
 
 		phydev->attached_dev->phydev = NULL;
-- 
2.25.1

