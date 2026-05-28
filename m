Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A136D9F1
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010213; cv=none; b=bCiMQEcTGu1d3EtxAN8KXrUbOq8OTrmrFgO7PaezCSUJLLyS4g12jtrnBKjGG6RgbWUk7SAT9yAyE2Mc42pt70wP8wZX9Pd4PY/ZVgMoyg8gm3mIej09URVEIA3JEB9AILS6lc8vjzU/DhVKXJ3FgjJDsT5JDWup2qcE0brm6lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010213; c=relaxed/simple;
	bh=zfyyHeJnDdRWKIc4vkSawWyAhpq+EFNvhd4x6nIBXzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJkibMfCzfiUyoKLmub5+t6uuM8VwTop6JjsilYVYIe5g40iYoQlaMGAP27QtciRoUNKC2rZF6H/5pgExxqeQFYBi9sXZWKw1350ZJmsK+VeGCt2nqwoGWu/jLRTp1w56QOKbgstjTWkKuQR1iM+opFaKYKKqBu3G1t7s9f87ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EI/4jU1t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EI/4jU1t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEF11F00A3E;
	Thu, 28 May 2026 23:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780010211;
	bh=nHOlKwzIquzQ01+xq/KHcOSCbRPLnYWPsrIfFWV0qBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EI/4jU1tqgxP5MKcIKNkFaNmYLNTfXiXkjaobFf7u7aaDY088drW3ftLvAHVYBe1z
	 Fafh0CrYgxJ3AKNG7Gk53msqwA10H/dVl2hwfsbk71ocWAwfSexm9HsdfLmYQngqgK
	 MkXkKsae4tr2zNYYA9c0KOzaAvE1p+h+y9YRrbGjBjuVpPRRPH3Muznwmh50N1tNCs
	 qMee+Vo+fO539UpQm/GoUl1L/f3YrQanFVHDlq+b9XxRr961Y+JosV/9IJn+IZRcT4
	 B2UIN+WrAGOpxJUhxQtvZMNQh0kAS7Uw2hHx0Dis/AIq/s1q0x7liWVP8A/1EEVt1h
	 LC+UxmfdqKK+A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	haiyangz@microsoft.com,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	willemb@google.com,
	ernis@linux.microsoft.com,
	sdf.kernel@gmail.com,
	kory.maincent@bootlin.com,
	danieller@nvidia.com,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 04/14] net: ethtool: relax ethnl_req_get_phydev() locking assertion
Date: Thu, 28 May 2026 16:16:27 -0700
Message-ID: <20260528231637.251822-5-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528231637.251822-1-kuba@kernel.org>
References: <20260528231637.251822-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phydev <> netdev linking and lifecycle depends on rtnl_lock.
We want to switch to instance locks for most ethtool ops.
Let's add an assert that ops locked devices don't use phydev
today. If one does we can either opt the phy ops out of
being purely ops locked, or do deeper surgery to make phy
locking ops-compatible. I don't think there's any fundamental
challenge to make that work.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/phy_link_topology.h   | 5 +++++
 drivers/net/phy/phy_link_topology.c | 8 ++++++++
 net/ethtool/netlink.c               | 6 ++++--
 net/ethtool/phy.c                   | 1 -
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
index 68a59e25821c..95575f68d5bc 100644
--- a/include/linux/phy_link_topology.h
+++ b/include/linux/phy_link_topology.h
@@ -36,6 +36,11 @@ struct phy_device_node {
 	struct phy_device *phy;
 };
 
+static inline bool phy_link_topo_empty(struct net_device *dev)
+{
+	return !dev->link_topo;
+}
+
 #if IS_ENABLED(CONFIG_PHYLIB)
 int phy_link_topo_add_phy(struct net_device *dev,
 			  struct phy_device *phy,
diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 1f1eb5d59b38..aed3b26c1674 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -10,6 +10,7 @@
 #include <linux/phy.h>
 #include <linux/rtnetlink.h>
 #include <linux/xarray.h>
+#include <net/netdev_lock.h>
 
 static int netdev_alloc_phy_link_topology(struct net_device *dev)
 {
@@ -35,6 +36,13 @@ int phy_link_topo_add_phy(struct net_device *dev,
 	struct phy_device_node *pdn;
 	int ret;
 
+	/* ethtool ops may run without rtnl_lock, and rtnl_lock is what
+	 * currently protects the PHY topology. No driver currently mixes
+	 * the two, flag if someone tries. See also ethnl_req_get_phydev().
+	 */
+	if (WARN_ON_ONCE(netdev_need_ops_lock(dev)))
+		return -EOPNOTSUPP;
+
 	if (!topo) {
 		ret = netdev_alloc_phy_link_topology(dev);
 		if (ret)
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 902ff7d0a71d..a91cc4bc964f 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -226,11 +226,13 @@ struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
 {
 	struct phy_device *phydev;
 
-	ASSERT_RTNL();
-
 	if (!req_info->dev)
 		return NULL;
 
+	/* If there is no PHY in sight there's no need for assert locking */
+	if (!phy_link_topo_empty(req_info->dev))
+		ASSERT_RTNL();
+
 	if (!req_info->phy_index)
 		return req_info->dev->phydev;
 
diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index ddc6eab701ed..018b0412be86 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -78,7 +78,6 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
 	struct phy_device *phydev;
 	int ret;
 
-	/* RTNL is held by the caller */
 	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PHY_HEADER,
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev))
-- 
2.54.0

