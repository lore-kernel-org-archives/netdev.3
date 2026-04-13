Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527D635CBD6;
	Mon, 13 Apr 2026 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776093207; cv=pass; b=sACMUBguBGhF7cUlk3kMGwVWTrmD/xzMB7M+f0/b5yj1NzEISxrcFWWmh2RTnH3/v5casr4zVgI1A3xSosPDif3PUGU1Bp2cD31Jp9QihxinolIf21wfYh+Zk5lYPXjfOD5TE87YAsu5Hi7cDzUkHagNe+6GJj9LOFNPiXhrx0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776093207; c=relaxed/simple;
	bh=81g+qUnNNFsdVTb/SZD3UCTR0442ja+aMzMrIeuqCMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bbBmXhLBmKnn1ikTkph2441HXc0aSqu2Lg3b2mqbT9Jy9IJmM13lNS+wyz98Y5C1BY6QYeFGM/P2yDbXiRTWKBXORRN5sHPLNHPSergZVk3T18T9x1QtAF1Le0c5b7sr8WANpdjfytly8yFHI7GEhV+hwRSZjGHw0uCP99nVZF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=lmbYu6uk; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="lmbYu6uk"
ARC-Seal: i=1; a=rsa-sha256; t=1776093166; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UtphPp+bIt9ThAtBwH6uWaW/nMLbDjNM6tAFvar1CxpaxHsachqbAA1i69jM8iowo7L1Y3d4eE0QpmukhrX9JnWu9H5ARycQV2rX/Po0/K5S14GVezkyRinzQaB/E1wUGZfkrRmnLuLgs2uINNCDQ1ULudXG2iOX98qNdqGa7hE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776093166; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wa0q4a7PiAQyVCNBqTWlZ1ZqIne3iaPUk2uPQB9BgB0=; 
	b=e56jQ20sirdlgEjzzCoFpju8SXRMNRxoEVOStkf/0jZDrsQEN2HbVosk5LJoOdoAVXBDlT4W6CYWzqsxCjdKW2n0wXYhBDc/9hd+2It3j60aU7ZVhbsM6PN+hTphBQP0Xxag1aCk6jmdY/KirXwh6DMKrgvyFvBzRuuvQQ/Wahk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776093166;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=wa0q4a7PiAQyVCNBqTWlZ1ZqIne3iaPUk2uPQB9BgB0=;
	b=lmbYu6ukFjOJNASb8fCK37CzpxIpUB1RmdeMZQ2hWUlcJxPlNDEmudp1uxRJV5Ia
	4ziK0IPisLqCfYww0u15WYugSTFlWq16UH5edyTJWRc4lwAYPMbC8dSg4kwtHi3NCN/
	sxxllJmSWeu5lCc1d+q7w6vjRNWuNiwtzbh5WDk4=
Received: by mx.zohomail.com with SMTPS id 177609316273486.24045386352475;
	Mon, 13 Apr 2026 08:12:42 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Jason@zx2c4.com,
	kuniyu@google.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
Subject: [PATCH v2] wireguard: device: use exit_rtnl callback instead of manual rtnl_lock in pre_exit
Date: Mon, 13 Apr 2026 20:42:32 +0530
Message-Id: <20260413151232.1004611-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

wg_netns_pre_exit() manually acquires rtnl_lock() inside the
pernet .pre_exit callback.  This causes a hung task when another
thread holds rtnl_mutex - the cleanup_net workqueue (or the
setup_net failure rollback path) blocks indefinitely in
wg_netns_pre_exit() waiting to acquire the lock.

Convert to .exit_rtnl, introduced in commit 7a60d91c690b ("net:
Add ->exit_rtnl() hook to struct pernet_operations."), where the
framework already holds RTNL and batches all callbacks under a
single rtnl_lock()/rtnl_unlock() pair, eliminating the contention
window.

The rcu_assign_pointer(wg->creating_net, NULL) is safe to move
from .pre_exit to .exit_rtnl (which runs after synchronize_rcu())
because all RCU readers of creating_net either use maybe_get_net()
- which returns NULL for a dying namespace with zero refcount - or
access net->user_ns which remains valid throughout the entire
ops_undo_list sequence.

Reported-by: syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=cb64c22a492202ca929e18262fdb8cb89e635c70
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
v2: Fix incorrect Reported-by email address

 drivers/net/wireguard/device.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 46a71ec36af8..eb854c5294a3 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -411,12 +411,11 @@ static struct rtnl_link_ops link_ops __read_mostly = {
 	.newlink		= wg_newlink,
 };
 
-static void wg_netns_pre_exit(struct net *net)
+static void wg_netns_exit_rtnl(struct net *net, struct list_head *dev_kill_list)
 {
 	struct wg_device *wg;
 	struct wg_peer *peer;
 
-	rtnl_lock();
 	list_for_each_entry(wg, &device_list, device_list) {
 		if (rcu_access_pointer(wg->creating_net) == net) {
 			pr_debug("%s: Creating namespace exiting\n", wg->dev->name);
@@ -429,11 +428,10 @@ static void wg_netns_pre_exit(struct net *net)
 			mutex_unlock(&wg->device_update_lock);
 		}
 	}
-	rtnl_unlock();
 }
 
 static struct pernet_operations pernet_ops = {
-	.pre_exit = wg_netns_pre_exit
+	.exit_rtnl = wg_netns_exit_rtnl
 };
 
 int __init wg_device_init(void)
-- 
2.34.1

