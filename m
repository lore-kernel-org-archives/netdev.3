Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC3D370AD9
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010218; cv=none; b=cUoG8vmmqkCS0wkeaq3l8JjaCpPv1njJ050zF84oen9n4zaNJL3cc89iv7D8gzHXMxLBjRVatw9oTfLwiOV9vmYY+VspLNGwBOi/Py2H8ajh0SIzunKUWW0aWt+FyvokdM3GLw8fgScesy2oQ9k4OCCoaoY6F3adIrrg0y7HFxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010218; c=relaxed/simple;
	bh=udcmLcoCHpb7ZOc7aRtxoKLUF2RAmCDFeLlav7YPN5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeEA7DlwXrBV+uOtxivKPSj8/abeiS54wP2fgaQ21btNDAozW3hn4pwxyVSZNq0wkM1WK6APHU5YnmSaG4dhD3AtNpZfks2onMKNKv/Rsty0RCyVSIzoQYsIpHVFWGBt31gMW4UXSPQhC80G+uBCkGWBLTlFQYuQBaa4uR2pp3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEYJfScA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEYJfScA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65AA1F000E9;
	Thu, 28 May 2026 23:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780010217;
	bh=5T7ZdFE/DIGp2ahb9f3ePi8lKkaYHntoKSMo0GScB3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HEYJfScAHDTd3vVMwP5K4KfvgfNsKcvwi7cYoiGfbDvJ2uqSYDWPHxlvnw1uN1gdS
	 rN0A03GXn89++uK1h4k1LlTu71GKbilwG7w8kvll5R3o/HlXs/yipNuCkAmvQ6Zr3Z
	 Ckm3V0W8L1rNCPFlI72g1kuehcL+ZdXiMSTvJMjEM+JsdIOafdhcHp67OaVq2eGBsu
	 5kfiVh5irp4+JjbFrzAPyfWjep+6eV6OBHqmOeFax4MGjJYRnxjDWrxrb72dC1JhKW
	 IdXr0S1ffV73sKYjO7BVFUGGzW9CJb5M/jHjLkbat/8WM/APETmWBawz1Oerc/lNlo
	 rCyfqxvuTf5NQ==
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
Subject: [PATCH net-next 10/14] net: ethtool: optionally skip rtnl_lock in ethnl_act_module_fw_flash()
Date: Thu, 28 May 2026 16:16:33 -0700
Message-ID: <20260528231637.251822-11-kuba@kernel.org>
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

Module firmware flashing reads SFF-8024 identifier bytes via
.get_module_eeprom_by_page(). Other than that it modifies
a bit in the netdev->ethtool struct. Both should be ops-locked
at this point.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 2 +-
 net/ethtool/module.c      | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 08db7305e0f9..db24e5610774 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2585,7 +2585,7 @@ struct net_device {
 	 *	@up, @moving_ns, @nd_net, @xdp_features
 	 *
 	 * Ops protects:
-	 *	@cfg, @cfg_pending, @hwprov
+	 *	@cfg, @cfg_pending, @ethtool, @hwprov
 	 *
 	 * Double ops protects:
 	 *	@real_num_rx_queues, @real_num_tx_queues
diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index c3388e6d7ec8..9cf670e089f2 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -429,8 +429,7 @@ int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 	dev = req_info.dev;
 
-	rtnl_lock();
-	netdev_lock_ops(dev);
+	netdev_lock_ops_compat(dev);
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		goto out_unlock;
@@ -445,8 +444,7 @@ int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info)
 	ethnl_ops_complete(dev);
 
 out_unlock:
-	netdev_unlock_ops(dev);
-	rtnl_unlock();
+	netdev_unlock_ops_compat(dev);
 	ethnl_parse_header_dev_put(&req_info);
 	return ret;
 }
-- 
2.54.0

