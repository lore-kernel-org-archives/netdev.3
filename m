Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543B23612E2
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 01:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791767856; cv=none; b=cRWXhuChvX73Xvirb1DRL/GER7WKR6AE8KXKLnV8Krcm6Oj+POye5slkm6IWLFWgFfk6x/3I2TQXCW9nmZlSfuWeAGScgilaC55L/iXsForKNHQ4pTaCO8bn37Bb3owhxd2K0xwSaFJpDy1kIED1i9oPvmCzpOj98NdSh3hptHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791767856; c=relaxed/simple;
	bh=hQ0V4emjN35pL22c0loNCh7/yoeuZXj8fb7w+F5wmuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9I5/KcMBAQWJCmKJUtoTHt/9GmYLr3EAOideUfJU6MfZp3ivOEAPPdjlDG8D6HAh0raYK+SDdIOuFsLAfT21nZz5mlWSlExSKkYFubIMefz/5zLm4/kWJ1gzAPFgos3Im9fBK2Qxyl+4/5NMoyf6sEWlwvb1ieMGa0tRaFKllw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtHVgD8l; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtHVgD8l"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso322452a12.2
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791767855; x=1792372655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XLEFCbx9qwaV8Sh994v6fbEqFw9fgRzVy0l3bJClDuU=;
        b=dtHVgD8lCmdOgapM3trbUYsr6AY4zJkieaXFMVY8oX4F+cdBGUIc6IVFQs7GUBMl84
         U3yahS/xinMNsjVZXLUQT5Fx7rVc2ls8nHAS2W+igZVlhicfOfqgMur0OepwwbXftHBZ
         i9rK2Ip9hdgEuGZ4CNWufNsbKF8dT7SMeD/k/aIsX42WJwHjKy7Sb7OZCTO+MRdNBkIr
         lNZkJR1wYaepW6iXrB0VF1p+2qlV2MVIJ5IB8gtdsLqR9Zw8LEw8ZqQ3Dr3Vm9XQglXb
         WPLmwVMM2icWqb1lZIlV/l99ZzmcpA2hEAZKRTq18rAT7zrz2yGNfkIkN5QZRvVSrNw8
         tQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791767855; x=1792372655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLEFCbx9qwaV8Sh994v6fbEqFw9fgRzVy0l3bJClDuU=;
        b=t4QUP2qg5lvT1TNiQq75zmPfF8YRvukVmxq4WZdJV/zsWd39SFllpzBFR6esExYEBp
         bnJKmpBCSgOkvuiHIMJy4UeaAGieKt4mNHauZ8Ye45EXWBWp0ytkWPGoyOzYw3vegzEE
         QXcH7qFnW03cxgsPWh7mFqk+WGgQd3FhBW+r1sM7J48+Eg/Ph7EtEArNxpfOV8dubb75
         AqrsZ72lEMGT6PGvvLHt8kFmZRXJxtpGkG3u1sT/vKL+GNttN4Cn4YCaLSRCS+UkkWc7
         RkbTG9Snuk6GqA0zZR+5yKU7f/oJBnWJtVTaUDWfVn/WmK7xXeVsXmnGjfKmaMSLAUxc
         EQkA==
X-Forwarded-Encrypted: i=1; AKwUvBz/BpqN9cCS9VIayPGuc7DUOnvMms4WTBbkGd14vGtYaovLU8cb1ThmPhQGuQltZOfPzyW7Fg8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIo+V9n6Oa5UQPznINd45H80DF4v6bCphGu937QsI0vm/5thy1c
	PULy9DoftQkJW+8e+9gvg+4cc6ZlThgW2JCUsyOyX/ADr+IlB70TNdwN
X-Gm-Gg: AYBFou317wEm5Yqa+2F0TPvKnjdYwrPeIF65pSGwiA+0WNoU0loGGi2plD8+PY7yQk0
	BV1xfmXsTM6YG1hpqM1vlN0qQyeghPK/eP/4wln/vXhCe+V/dzMRUR9X0/2nX8ggtnmpgAxfBrT
	hFpEKZ4jX8GeMsSXKcpVWrMYs+fAg3+gNfO2u2Q75m/8f4FXPg3+5Uj/r4hK4VJ0yYttdbclXEp
	YkliLwWFDtMISk4acQqvUIe+a5zCUwgHzvAltOMwjH0Fr72kqUgjzHVkn76oNPgCysz2T1tC8xi
	WwnQ6+kN0NZNyMDYJ5FOABikJJGGmnu/xaZK1lckwAvLO3Qlo+abLopP6KvUxVN8aNpEJCwBN4d
	jpMccGIsuMJXoSMB1CfInTY6zGpb1ybVoHugT+Q6cCxP5wThN/7hfoAqNkNz2qEaetXQxEdnzmM
	g4n2SstqY2BvOyx6VWxnkB/jVUXVgls61HtPt+Dacv1vSfcXsq6DK2jvrNwQPZjni6T+4olnhZi
	xrsI0CHW74f+nlo9SLi83OTjdM+iL3lXiWpIEfx9APFSvJREN2wXBiHziQBXb6lWvQmEG8m+ViI
X-Received: by 2002:a17:90a:d44b:b0:3ab:365f:ebdd with SMTP id 98e67ed59e1d1-3ab3ad2029bmr6553771a91.37.1791767854603;
        Sun, 11 Oct 2026 18:17:34 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan (oki-109-236-14-10.jptransit.net. [109.236.14.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38dd5864sm13743307a91.8.2026.10.11.18.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 18:17:34 -0700 (PDT)
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
Subject: [PATCH net-next v11 3/6] net: add a generation counter for dev->mc changes
Date: Mon, 12 Oct 2026 10:17:04 +0900
Message-ID: <20261012011707.3378-4-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012011707.3378-1-sigefriedhyy@gmail.com>
References: <20261012011707.3378-1-sigefriedhyy@gmail.com>
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
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
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

