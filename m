Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D538F954;
	Sat, 27 Jun 2026 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782552457; cv=none; b=KEwuLP3XQ7RkfnwXkA+D21y4GB3a57UIuehkeFSuXr2Mt87J4vPg1vmun6kgl0iC+3WVpDzrHL7x/007qXI5/JgU3Rg0DrN9yGXYXri497/KO404fcYugPj1/wKyQLB3vnzwANXPeYPSf2nm3pJQOWhEVHqt677RLqz824LEmWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782552457; c=relaxed/simple;
	bh=jrVtsHnfDRNSEJ/aii/rkH/8a/kolbD9GzkJQOM0Svs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iBYsrboKgvQukE91KNBi2yn60HCfQF1Ro7sJ/yJb7mtss0csypjlaU59gpffN7ddS0ysasPHS4nz3JyKFzAHy2wLiyU17HINJUfaMV0NTfw/lKrt4AdVzAqJMjBWRcp5rsgFjQlkcGfLH+YY9EFCfZFwDOb4d87ZoAuEBBMRFWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=hF2yAGFB; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="hF2yAGFB"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 43fdf9cd9;
	Sat, 27 Jun 2026 17:22:20 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: sam@mendozajonas.com,
	fercerpav@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [RFC PATCH net 1/2] net/ncsi: defer freeing VLAN filter entries after RCU removal
Date: Sat, 27 Jun 2026 17:22:13 +0800
Message-Id: <20260627092214.373480-2-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627092214.373480-1-runyu.xiao@seu.edu.cn>
References: <20260627092214.373480-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f08631a5903a1kunmb5b491adc8bea
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGksZVksdSh1KHk1JGBhCS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hF2yAGFB0J0rFrsaO1TUsCScW+pX1hdnLcU4Ikse4f3DnarNY5ZlgRJcjMjyzz3/nn/ZFq8hsHNvargspqPmwP0gj3x11nz58kDw7qBbLTMqMYp7/WzvHKJKZWdmw1wXnxUsQLOHmEe7m/cklsyj0y/L+MOUVRKq3j7yTaVDick=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=PeYn69QskiMyDm2sM1NSc6St2B7NpfiUq6HwvAi6PVs=;
	h=date:mime-version:subject:message-id:from;

NCSI keeps VLAN filter entries on ndp->vlan_vids and updates the list
with RCU primitives. The configuration workqueue reads the list in
set_one_vid() under rcu_read_lock(), then dereferences vlan->vid while
constructing a Set VLAN Filter command.

ncsi_vlan_rx_kill_vid() removes matching entries with list_del_rcu(),
but it frees the object immediately with kfree(). VLAN add/delete
callbacks are serialized by RTNL, but RTNL does not serialize the NCSI
configuration workqueue reader. A reader can therefore keep a pointer to
a struct vlan_vid across list_del_rcu() and race with the immediate
free.

Give struct vlan_vid an rcu_head and release removed entries with
kfree_rcu(). This keeps the existing list structure and makes the
list_del_rcu() lifetime contract match the real set_one_vid() reader.

This was found by our static analysis tool and then manually reviewed
against the current tree. CONFIG_PROVE_RCU_LIST was used as
target-matched triage evidence; the lifetime change is based on the
matching source-level reader and updater paths rather than on the
dynamic warning alone.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 net/ncsi/internal.h    | 1 +
 net/ncsi/ncsi-manage.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index adee6dcabdc3..d9f0eadc7a24 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -310,6 +310,7 @@ enum {
 
 struct vlan_vid {
 	struct list_head list;
+	struct rcu_head rcu;
 	__be16 proto;
 	u16 vid;
 };
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 446e4e3b9553..5316eadd8ce4 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1737,7 +1737,7 @@ int ncsi_vlan_rx_kill_vid(struct net_device *dev, __be16 proto, u16 vid)
 			netdev_dbg(dev, "NCSI: vid %u found, removing\n", vid);
 			list_del_rcu(&vlan->list);
 			found = true;
-			kfree(vlan);
+			kfree_rcu(vlan, rcu);
 		}
 
 	if (!found) {
-- 
2.34.1

