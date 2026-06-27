Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28582395AEA;
	Sat, 27 Jun 2026 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782552457; cv=none; b=QwZ/FoLX7xpxoZ1s2IWins/oiWnyax2k47tAhtCOYSk6gUlstUd7/xTo7u9T97KV5bjdE2loXReJ+oDbgOYTXBK0KyNHyOftHPv10xlWGTWZGixktMttv+1/uQMS8UbrAMbOEOrx9ZK/vI4ZpT9iJ1zA88pz1HiPcK/DUhYgWdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782552457; c=relaxed/simple;
	bh=l7XM2AVZdatBvllVHmZNwMMfq0/bhHAfuiI1wJjzYwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KHUbLGSmEBIGJu6cjFyphnQwn1i2FNPyFUW5RmFym/6ia/0vDxpnfVMKaqnfl8Fz/MyjUi2nZhBOGUNJVd87NtEPdo8pKE7tRWh5vn7B+HMJnjmTun6LlnK6ycnOV3eEu9Jv16qojU26sogIWgaSslixpMKmWovjic0rDIZ0610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=BlsYlC+f; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="BlsYlC+f"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 43fdf9cda;
	Sat, 27 Jun 2026 17:22:21 +0800 (GMT+08:00)
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
Subject: [RFC PATCH net 2/2] net/ncsi: stop device work before freeing channels
Date: Sat, 27 Jun 2026 17:22:14 +0800
Message-Id: <20260627092214.373480-3-runyu.xiao@seu.edu.cn>
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
X-HM-Tid: 0a9f08631efc03a1kunmb5b491adc8bf0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGBhJVh1LHklOSU5NGhlCGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BlsYlC+fHCYoZ1tZcP2y4DFmPJrCdM+aMkmRgSVUMZujPlVmqNo4T27qy5a35oVYDpatmBnedhS88UjE0yrbglmcptQtri9Ffkw8wMfKChIQ2cPmAd5J5cuKX789u5IHzb3uaGVmZQuNyfA6CZUTjsLYbb4JJtYA9lzRkWk5yZg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=WvNRjtPj8ElX4II/Zb/SLufSf65ErdXS12z35MPn1is=;
	h=date:mime-version:subject:message-id:from;

ncsi_unregister_dev() tears down packages and channels before it
disables the NCSI device work item. Current trees already stop the work
before freeing ndp itself, but a teardown window remains where a running
or already scheduled ncsi_dev_work() can still reach package/channel
readers after ncsi_remove_package() has freed the underlying objects.

One visible path is the configuration flow through ncsi_channel_is_tx(),
which walks package channels and ndp->channel_queue while choosing a
transmit channel. Channel queue entries are struct ncsi_channel objects
owned by the package channel lists, and ncsi_remove_channel() frees
those objects during package removal.

Disable the device work before package/channel teardown. Also clear any
remaining channel_queue links while the channel objects are still alive,
so no stale queue membership is carried into teardown.

This was found by our static analysis tool and then manually reviewed
against the current tree. CONFIG_PROVE_RCU_LIST was used as
target-matched triage evidence; the teardown change is based on the
source-level workqueue and channel lifetime review rather than on the
dynamic warning alone.

This is deliberately limited to the teardown ordering problem. It does
not change the normal package/channel RCU-list update model.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 net/ncsi/ncsi-manage.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 5316eadd8ce4..289974dff0c1 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1956,10 +1956,18 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 {
 	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
 	struct ncsi_package *np, *tmp;
+	struct ncsi_channel *nc, *ntmp;
 	unsigned long flags;
 
 	dev_remove_pack(&ndp->ptype);
 
+	disable_work_sync(&ndp->work);
+
+	spin_lock_irqsave(&ndp->lock, flags);
+	list_for_each_entry_safe(nc, ntmp, &ndp->channel_queue, link)
+		list_del_init(&nc->link);
+	spin_unlock_irqrestore(&ndp->lock, flags);
+
 	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
 		ncsi_remove_package(np);
 
@@ -1967,7 +1975,6 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 	list_del_rcu(&ndp->node);
 	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
 
-	disable_work_sync(&ndp->work);
 
 	kfree(ndp);
 }
-- 
2.34.1
