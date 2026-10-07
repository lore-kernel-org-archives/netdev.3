Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA4D493620
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374342; cv=none; b=UlQVXFiUn7nFYapNTTPmkQ4BARVvDQsf9hDM4lFWkHfKSWj1wS8HXh+Lgl7Eq7W9yb5LQmvI60nKJkd7reW9h1QMS+ZA+haNklGSGjxy4Yq3hx52D7cxNLX+i3xFl1R82OymSIss2ZPqMou5b1z54PfQlj6QEzQjjr+H9kk+Ryk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374342; c=relaxed/simple;
	bh=IgbYzH2C6hbv015jsEN0i3YOMqCP9cu1G2VmEtmOUcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXZXp1FfqgKGt/zv0jSM0tdmeFvyVNFCfxCcoQSpk58hAjZxfIYFH9cnJMBUd3B2FlIiNlTtbjhGU0d7OeOhc4NiKiSK0pagL0xZrRn7focnz692JWSuY5+uNtttQKmQvjX/VES1Zd3bj1RKS6gqg/TjdwpUoHzKv1O3tm5RMRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1CWFtwD; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1CWFtwD"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381b831d535so3893046a91.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 04:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791374331; x=1791979131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DI4d2s8GvHpPglm8OhsdKL/5L5SEzceEtpEBmwHSvtg=;
        b=W1CWFtwDRhGm6wFzO3wNOwXblISsIaic4qhZDw6i5ImihoBM2XjSjwlExQAle0XpSs
         2+6khvVP9dKK4FAG/cqOsr6hum9RIOafLMj1nhVPzo+Fbp93bcRkhV+yHTU0/gfzPMd5
         +DrmqZmBSJvzjJ/w3lOGo02NcF+nP950UK9HSX0j/m6bdmxq32UqRV+QDKNgkQbsfG6Z
         sP0oB48tpyN6CP8SMqcRxA/trhYphpZnd8vVSBPSYQ9mmQiLdUW8+9psXOCcNS4Xy4ab
         7VjRToaNxeynEd9fIQjfvHXVRe4iFxHw00ptfkKU/EH846NzacsFqMM+gUA7YTbjtlMp
         fJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791374331; x=1791979131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DI4d2s8GvHpPglm8OhsdKL/5L5SEzceEtpEBmwHSvtg=;
        b=f8TXtxcZz7NYuOFaN4T8Tgw+j5SSqf87uyYkdybO1dxHEdgjRF8+AGyUglnqP1Hfo/
         Dr7g/GTpcis/YtcPC7vudMyyx9yEGMO3RTc6IcHTtEXWqQApX0/gGP60UGs+NZ3I7R3s
         e1jHb5fPz7j72ig9gFgDf6KYml4Wppof2HwmgphrNIHO76l0VN/pdukeJtsemEOe6GAB
         6+zq3lHTPNiCndyuXmvCCQNilnPpK5BYV/3KpPOrZmnrf0PlHQhYFEP104f82GkKS7VF
         ds29uZZzPymdGYrBRy6OR6VTij5V0ItawNgAZvm7sXb1kmV+LR8lqGxbXwJpOtROQcTA
         FDYw==
X-Forwarded-Encrypted: i=1; AKwUvByuQrGa0XOn0Zt82gMRS/rWIIV18QHGDssj+LP+Zwk3ngB51M1a8Io6uYveNQWzfkzvTLwTYO8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKquyKeLJXjJlXhDA3J92ZHWCYXZo08DMJ7FFwZCgCO7xPTNf2r
	g6Mn6sUYKcEXW2ZYr2Pka9hiw5t3dXHilXQGE/5frcZix1beIX6fkg6z
X-Gm-Gg: AYBFou1o9jnE0UkLqCkzPhSgeXN1MIujFhfQz4chcSFruHkWVaCsdEjficKXNSD49sZ
	Sjw1CGJB5WVQh/CjteNS19oYSGPUhdZ/mJ39Wov9mUthIcxq+0yzUQJKpQOWJXlyaOx6aN64g3F
	gmU+m1B7kvsW9y/dK4oWxuA5UbSL5QEi12B+HmWthH/meiHnLjsbqRAjEQYr9sf3sxAIrQafg58
	K5fQyYE7X1r/HIzbYnYNYs22RnlEw7UkZdiUlZIoaj1JQv0WH9dow4DmCKsBFfRmTKvdzlp+6NB
	ssZh9AoyiaDlFsjmIsW/BZwCS4DC2sPQeVvQ0qfuVz/RqyzQQXgvwgxhU+TClt/iTdvtxBlMaqo
	UhS3FouqPbcQj5ltRnM6rY0mIf5Kzbv+CufhkvDv2h7D9xWANfcFTVtQly0NSFJkGGFD8IP087l
	A4UXQFge0n90Gjo7UzhLM/7Uzlo62DOW8wZwPFivSIo9CKN8tltnWehXBOsYqYqi4kEfT6oaoR2
	DKYW6Q8UtlzohUdwRvVIHLCk3gBYzNxVcrwqjnWSh9eSCG+UjWq+mnL5nQIRS0IuevaIZw6WzYQ
X-Received: by 2002:a17:90a:1c88:b0:3a8:c3dc:3c44 with SMTP id 98e67ed59e1d1-3a8c3dc621fmr387226a91.21.1791374331072;
        Wed, 07 Oct 2026 04:58:51 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan (oki-109-236-14-10.jptransit.net. [109.236.14.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8987b09e2sm4456582a91.2.2026.10.07.04.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 04:58:50 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Kees Cook <kees@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v10 3/6] net: add a generation counter for dev->mc changes
Date: Wed,  7 Oct 2026 20:58:18 +0900
Message-ID: <20261007115821.11332-4-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007115821.11332-1-sigefriedhyy@gmail.com>
References: <20261007115821.11332-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A multi-part RTM_GETMULTICAST dump of dev->mc resumes by position, so
entries added or removed between two dump rounds can be skipped or
repeated. The IPv4 and IPv6 dumps report that with NLM_F_DUMP_INTR by
stamping cb->seq from a per netns generation counter combined with
dev_base_seq, see inet_base_seq().

Add the equivalent for the device multicast lists: a per netns counter
bumped whenever an entry is added to or removed from any dev->mc. The
list helpers do not know which device a list belongs to, so give
netdev_hw_addr_list an mc_dev pointer, set for dev->mc only, and bump
the counter of dev_net(mc_dev) from the count helpers. That covers the
dev_mc_* helpers, both lists of a sync, the hardware sync helpers
drivers call from their rx mode callbacks or their own workers and the
reconciliation after an asynchronous rx mode update. It is atomic
since the writers only hold the address lock of their own device.

Used by the following patch for the AF_PACKET multicast dump.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 include/linux/netdevice.h   |  3 +++
 include/net/net_namespace.h |  1 +
 net/core/dev_addr_lists.c   | 15 +++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3d9e3a70ca5c9..6c837ea34748e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -259,6 +259,9 @@ struct netdev_hw_addr_list {
 
 	/* Auxiliary tree for faster lookup on addition and deletion */
 	struct rb_root		tree;
+
+	/* Set for dev->mc only, the device the list belongs to */
+	struct net_device	*mc_dev;
 };
 
 #define netdev_hw_addr_list_count(l) ((l)->_count)
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 46b4c67e2966f..c29a22ca178fa 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -71,6 +71,7 @@ struct net {
 	spinlock_t		rules_mod_lock;
 
 	unsigned int		dev_base_seq;	/* protected by rtnl_mutex */
+	atomic_t		dev_mc_genid;	/* dev->mc membership changes */
 	u32			ifindex;
 
 	spinlock_t		nsid_lock;
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index d615192d1c3b1..3ab053cbf8b99 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -16,9 +16,19 @@
 
 #include "dev.h"
 
+/* RTM_GETMULTICAST dumps use the netns generation counter to detect
+ * changes of dev->mc between dump rounds.
+ */
+static void __hw_addr_changed(struct netdev_hw_addr_list *list)
+{
+	if (list->mc_dev)
+		atomic_inc(&dev_net(list->mc_dev)->dev_mc_genid);
+}
+
 static void __hw_addr_count_add(struct netdev_hw_addr_list *list, int value)
 {
 	list->_count += value;
+	__hw_addr_changed(list);
 }
 
 static void __hw_addr_count_inc(struct netdev_hw_addr_list *list)
@@ -33,7 +43,10 @@ static void __hw_addr_count_dec(struct netdev_hw_addr_list *list)
 
 static void __hw_addr_count_reset(struct netdev_hw_addr_list *list)
 {
+	if (!list->_count)
+		return;
 	list->_count = 0;
+	__hw_addr_changed(list);
 }
 
 /*
@@ -521,6 +534,7 @@ void __hw_addr_init(struct netdev_hw_addr_list *list)
 	INIT_LIST_HEAD(&list->list);
 	list->_count = 0;
 	list->tree = RB_ROOT;
+	list->mc_dev = NULL;
 }
 EXPORT_SYMBOL(__hw_addr_init);
 
@@ -1197,6 +1211,7 @@ EXPORT_SYMBOL(dev_mc_flush);
 void dev_mc_init(struct net_device *dev)
 {
 	__hw_addr_init(&dev->mc);
+	dev->mc.mc_dev = dev;
 }
 EXPORT_SYMBOL(dev_mc_init);
 
-- 
2.43.0

