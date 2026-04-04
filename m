Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6DE139D
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 00:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261981; cv=none; b=gMfaeqWD588uJYg0C5Y9BXNqXy9rq7D+MXYNcSSm7o5OkivBfAS5/1K5BlDcEXBCVMnicWSLEQLnTF88AoXhgidpSA7Eg85DWXsoTsGaTse8KXUsm8arBXdKsRyUe0PJolXUO553veOa1Fn0ofkCYXQlAdIfepOAbsFf6GiHovU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261981; c=relaxed/simple;
	bh=3F85GwgCcuzGHESuZXjmzZQ1lDmQzmLM4kNKWsjF2o8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ppxuqwHKBVYxXYsy3GLAhvUzL43l6xuhuiuo7siU5COMEYmeC6Uav3SSDCTcW5AZvyuRSjUN3PoUFd9HgLlYwQrpOPTAEMG5MqBrEKSHI0AOdurBwweCxNeiyWabEZILy7WHRBR639P+BzmCbj/ohInEm6jti+hTw6vjDm4oTd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Upfj4uG3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Upfj4uG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A32C4CEF7;
	Sat,  4 Apr 2026 00:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775261981;
	bh=3F85GwgCcuzGHESuZXjmzZQ1lDmQzmLM4kNKWsjF2o8=;
	h=From:To:Cc:Subject:Date:From;
	b=Upfj4uG34lBK6WjNfT1vHHfWPqk/wqSc3MWBE/lr8qrcetvK4KLkrU+AdDDRxbFSI
	 3a1mxvd7EGBgNOSQLNcqJ0T+S1rA3TBEMhZENBuKHD6o90T7zlCTgFcMw9Npkg1JTJ
	 YS0TwTmeigZnFONRgreKkRGY/dXRFXe24D9kImmepIhozR7bdcjscXvC2ECW8nZQcc
	 XOAYdMWTyv2xabLPwtay/8jbuTjx1My1pdDer4UUXzelRKn07OkpuYzo48TKa5bfkE
	 UWLPxzJ8bkV9mAsq6UwdeisUd5eWehmdgQ+OvzcnxZf5uDDBybNkScl82FWdwUIBRL
	 ccm2/UaOOLCrw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	sdf@fomichev.me,
	almasrymina@google.com,
	daniel@iogearbox.net
Subject: [PATCH net] net: avoid nul-deref trying to bind mp to incapable device
Date: Fri,  3 Apr 2026 17:19:38 -0700
Message-ID: <20260404001938.2425670-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko points out that we use qops in __net_mp_open_rxq()
but never validate they are null. This was introduced when
check was moved from netdev_rx_queue_restart().

Look at ops directly instead of the locking config.
qops imply netdev_need_ops_lock(). We used netdev_need_ops_lock()
initially to signify that the real_num_rx_queues check below
is safe without rtnl_lock, but I'm not sure if this is actually
clear to most people, anyway.

Fixes: da7772a2b4ad ("net: move mp->rx_page_size validation to __net_mp_open_rxq()")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: sdf@fomichev.me
CC: almasrymina@google.com
CC: daniel@iogearbox.net
---
 net/core/netdev_rx_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 668a90658f25..05fd2875d725 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -117,7 +117,7 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 	struct netdev_rx_queue *rxq;
 	int ret;
 
-	if (!netdev_need_ops_lock(dev))
+	if (!qops)
 		return -EOPNOTSUPP;
 
 	if (rxq_idx >= dev->real_num_rx_queues) {
-- 
2.53.0

