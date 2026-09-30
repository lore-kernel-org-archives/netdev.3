Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89D44F93C3;
	Wed, 30 Sep 2026 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779988; cv=none; b=itSZfnWJFJs4fEOmUQ3SlRHWb1oaaCO0npTd5/iyL//Cm5y/16XN9TWe6Tv9Tn8N14RolhfM//zVPIdfgFcjqWODsat/l8wWIFgSVvHBfIfDTOUzcS98fimDVkBFJ7Y76h14VsV3Uj4YIeRDOD6zMVZWYyOb+d+2Zf6yPdKy3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779988; c=relaxed/simple;
	bh=cOt6AG8CtX3b2wpHP7U3wbLvc+2Ocsdrkvj6rFQ6ZyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hrgtk/0aXi0U53onkDb9n76nkNCneKo3ikdsIQ2QcPkBXre69YcpQosrZbnexn4UdGFd88DfA7YDI1CcbRMZ10W/y/lJy2KMCn6TJGOzj/X5kgeaCIO123B6vDowbDOZv3laIjlAx/h4fBbmMfh/KZzuUPnSM+Va4E7qBzVnHfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=UwB/y85p; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="UwB/y85p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=UwB/y85prPI//Z/KPskpUgSuwutntO6nJQsbRroQV0W5uHbvKyKyQn3luztQJ46ltk16phNSZs/T3
	 c/SySVF2wr9ZEQkyKFMtIyQNusFmEmWtNE+Yqzo6va6aarNHprA6P9PBWfSw9FydsJ0a9U9/2riVmG
	 T1yz/7J2JrxNuQIo=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66abd217f1d5-5ad0a;
	Wed, 30 Sep 2026 22:49:41 +0800 (CST)
X-RM-TRANSID:2ee66abd217f1d5-5ad0a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.22.250.209])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96abd2172881-0109f;
	Wed, 30 Sep 2026 22:49:41 +0800 (CST)
X-RM-TRANSID:2ee96abd2172881-0109f
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH net] net: fix NULL dereference in skb realloc fault injection devname filter
Date: Wed, 30 Sep 2026 20:20:13 +0800
Message-ID: <20260930122013.110284-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a device name filter is set in
/sys/kernel/debug/fail_skb_realloc/devname, should_fail_net_realloc_skb()
compares it with skb->dev->name without checking skb->dev first.

skb_might_realloc() is called from pskb_may_pull(), __skb_cow() and
pskb_trim(), which also run on skbs that are not associated with a
device. One example is a netlink broadcast to a listener with a socket
filter attached, which goes through sk_filter_trim_cap(). With the
filter set, such an skb makes the kernel oops:

  KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
  pc : strncmp+0x50/0xf0
  lr : skb_might_realloc+0x58/0xa0
  Call trace:
   strncmp+0x50/0xf0 (P)
   skb_might_realloc+0x58/0xa0
   sk_filter_trim_cap+0x6a0/0x928
   do_one_broadcast+0x35c/0xb20
   netlink_broadcast_filtered+0x1a4/0x328
   netlink_sendmsg+0x724/0xa58

An skb without a device cannot match the configured device name, so do
not inject a reallocation for it.

Fixes: 12079a59ce52 ("net: Implement fault injection forcing skb reallocation")
Assisted-by: LLM
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 net/core/skb_fault_injection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/skb_fault_injection.c b/net/core/skb_fault_injection.c
index 4235db6bdfad..7f8315c864c8 100644
--- a/net/core/skb_fault_injection.c
+++ b/net/core/skb_fault_injection.c
@@ -19,8 +19,8 @@ static bool should_fail_net_realloc_skb(struct sk_buff *skb)
 	struct net_device *net = skb->dev;
 
 	if (skb_realloc.filtered &&
-	    strncmp(net->name, skb_realloc.devname, IFNAMSIZ))
-		/* device name filter set, but names do not match */
+	    (!net || strncmp(net->name, skb_realloc.devname, IFNAMSIZ)))
+		/* device name filter set, but no device or names do not match */
 		return false;
 
 	if (!should_fail(&skb_realloc.attr, 1))
-- 
2.43.0



