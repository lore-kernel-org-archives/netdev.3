Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9DA3E5A29
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759108; cv=none; b=idpADYy+d2obhx1uEBBPAArY6SX7mF+NL7JFydFXORvdl1EezN6JmDsGPf9nHpWS1LKx7HkO+DPG/4RgFvTuImsSFSi2hZZsNaOvSoJ8WETg6y0QBKL6ATMwhSineeyHmHYcD11oKu5SD2NTkdkdpUfp/V92/AJcxLsZqzL7w14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759108; c=relaxed/simple;
	bh=5FhqZcuvXbUA7XKnBEjLE6oGOpoajtBISrkOKD3VszQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H/2LUMgqUATyg928jCZwqaYNMJFlfmavWuWeJXm5XZRE6pOMC1PkjOnBFUz+rxeC6Phpvw/2A/hDu3XR9IRt40hsJ+zlR94+KYjIWrCw3vL5yyx6aF9p1D9KQFQ+WbiDg1OmdAzO2aDZm5acp1eAggxc0I07l1NO+LDiS5tPrFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuOcMBZU; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuOcMBZU"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so5596582a12.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785759105; x=1786363905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EcjQI2JYKwg5xZMIFGY1JaKQvya3kkElNk2GTcB9VuQ=;
        b=XuOcMBZUeC2k9mf76uY50hO32n2nLw55ZjfbnJr7uW046ry/Vps3wUXhUhZVyOQfoU
         PA5sW4uOQQSVwF4xANBnjPYpBA3gTS3+qiAd11d+sNTtxnzrIyIKL/MryZGUHhMwjFDi
         BvCL6MbzQypQgtGVNu4c956qjuugbs2KDL9qKiURGIsS/eRpTIyraYmayljJgagQk8ch
         pYriLdgVzDqXJLpYgJfgVFG858pe7WeayRTff4jVkB+jIuvjQ22SA+XOASFtkDXqmVUw
         HFnL02PsknF+1BGBDLGsZNDezrvGGtUy3UeV5Ob1K6zjakgzSYyXlbt+EPuX+lJoGOaH
         iAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785759105; x=1786363905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EcjQI2JYKwg5xZMIFGY1JaKQvya3kkElNk2GTcB9VuQ=;
        b=lv8Ha9kfwb7x4mka6dEUKV3ohL8ZUkz/1Xn/bUySNoZVY7lnt20HI17xrPlZP0c56d
         GBn7S0+Ba3YOfkmzhIFb5M4P/UgSO0yxD87cey2b4Gr2EYIWrokTmG6HgzGEg2rMxJg/
         oATPMoHDHJS6HAveWTLpd/GIJAP1fLb4L2l6APjSQ4A8alAVR/W0VfF8ug78PLCBbx5c
         Wd2RHPYaCH8aXqCSl2viAhj6Z4oxyS5ANA7Z3PkQg1Srfo3QdynlTSUcThwQwPUo73/U
         TceBeiv0Cj8ywipCLQr83T7aCnyelLC2hIRuw6x155yj5MRvoDmU8juPTqHtA9o0sgZq
         aFrg==
X-Gm-Message-State: AOJu0Yy//UZ5id98Z7y7520x1hBrHW+CBdrCDx8YSlW7fgIahWzYnUy2
	h9QvSMUb30BmojqDq4yleULRdpxKojmc6+ijIDgM+llBA7yy3a8WFRcLucaGy7BZMFY=
X-Gm-Gg: AR+sD10IdWdDNRmcyZXCTXm9q/ub0ZF16Td3zpYiST2SG6NxQJGN2JleIBt1DyebhXA
	bubJFkcIiEptet2XSwPT5x6m1wo2FuBFzz7WYh8NIum5mMrM+/zza82nkyu3ilOYWu7SmbYQRIX
	C2nbPnRhnKO8kTU006Yx/lFvUePYiMZri8ZOwb/W9Z41KNi2WKHZK+eHjN+IogVnQx6TPEnFyq3
	QipdSXo40IW4yzz0vkl5Yz9cmtUusA7f3F8qaqO3v/V/wy/HjpyEH55/zO6U822g/YgsVGV2c/H
	NNlG1DEIFbM1vm8B0crmx5yqCbw/MC922BnN/Q63cQNwRL27g5eyNUaxo8tEyUCc2fnjm/T30D2
	zG/rC+HovKwyFzjB+TkEjACFjyyyHhsBSWDdcSifjMiJRLcA5By9louxqCkE3GEPeUZgSh21Yoz
	juMx6yrg7pHjzFEhYYhfh0+0mOyDyyyySii+4FhbekBzbpUzY3bWRfAc4Thp5eqWzeluMjGgjeR
	xnoGLz7A2SCgKB35VLZH21zQ0rn5gdybZ6AXNiVDMALz8iKOZRDiAtJuAIDNOSODsP2u7Un3thm
	ZsVawCBqXUDFG/dSLoGCYdzE++3AsAW3frK+mQ==
X-Received: by 2002:a05:6402:21cf:b0:69e:8ad:515f with SMTP id 4fb4d7f45d1cf-6a0a7c60fbamr6798287a12.6.1785759104890;
        Mon, 03 Aug 2026 05:11:44 -0700 (PDT)
Received: from Ubuntu.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c63daf7sm5208181a12.18.2026.08.03.05.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:11:44 -0700 (PDT)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: syzkaller-bugs@googlegroups.com,
	dskr99@gmail.com,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	syzbot@lists.linux.dev,
	syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Subject: [PATCH net v2] ipvlan: keep lower device alive until private destruction
Date: Mon,  3 Aug 2026 14:11:39 +0200
Message-ID: <20260803121140.261329-1-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 40b9d1ab63f5 ("ipvlan: hold lower dev to avoid possible
use-after-free") added a reference to the lower net_device owned by struct
ipvl_port. However, this reference is released when the last
ipvlan_uninit() reduces port->count to zero and calls
ipvlan_port_destroy(), which can happen before all outstanding external
references to the ipvlan netdev have drained.

Specifically, RXE acts as an asynchronous owner in this scenario. RXE
queues RDMA device removal on NETDEV_UNREGISTER, meaning it can retain a
reference to the ipvlan netdev after ndo_uninit has completed. This allows
a later SMC port query to reach the ipvlan device and access its phy_dev.

This leads to the following sequence:
1. The shared ipvl_port owns the reference to the lower net_device
(phy_dev).
2. The last ipvlan_uninit() drops this reference by calling
ipvlan_port_destroy() when port->count reaches zero.
3. RXE retains a reference to the ipvlan netdev, keeping it alive.
4. The lower net_device's refcount drops to 1 and it is freed by
netdev_run_todo(), leaving ipvlan->phy_dev as a dangling pointer. A
subsequent SMC port query accesses this dangling pointer, triggering a
use-after-free.
5. A new per-device hold keeps phy_dev alive until ipvlan_dev_free() runs.

The KASAN report illustrates this use-after-free:

BUG: KASAN: slab-use-after-free in netdev_need_ops_lock
include/net/netdev_lock.h:30 [inline]
BUG: KASAN: slab-use-after-free in netdev_lock_ops
include/net/netdev_lock.h:41 [inline]
BUG: KASAN: slab-use-after-free in __ethtool_get_link_ksettings+0x230/0x250
net/ethtool/ioctl.c:463
Read of size 1 at addr ffff8881988dae09 by task kworker/1:3/1289

Call Trace:
 <TASK>
  __ethtool_get_link_ksettings+0x230/0x250 net/ethtool/ioctl.c:463
  __ethtool_get_link_ksettings+0x11f/0x250 net/ethtool/ioctl.c:464
  ib_get_eth_speed+0x180/0x7f0 drivers/infiniband/core/verbs.c:2052
  rxe_query_port+0x93/0x3d0 drivers/infiniband/sw/rxe/rxe_verbs.c:56
  __ib_query_port drivers/infiniband/core/device.c:2129 [inline]
  ib_query_port+0x16e/0x830 drivers/infiniband/core/device.c:2161
  smc_ib_remember_port_attr net/smc/smc_ib.c:364 [inline]
  smc_ib_port_event_work+0x147/0x920 net/smc/smc_ib.c:388
 </TASK>

Fix this by holding a reference to the lower net_device using a
netdevice_tracker in struct ipvl_dev. The reference is acquired in
ipvlan_init() and released in the priv_destructor callback
(ipvlan_dev_free()). Releasing the reference in ipvlan_dev_free()
guarantees that the lower net_device is held until outstanding external
references to the ipvlan netdev have drained and before final private
teardown and object release. This mirrors the behavior of other stacked
devices like macvlan and vlan, and safely covers ipvtap devices as well.

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Assisted-by: Gemini:gemini-3.5-flash Gemini:gemini-3.1-pro-preview syzbot
Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
Link: https://syzkaller.appspot.com/ai_job?id=3e3edd19-4e52-49d3-bfdb-ebdde1bda5c3
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v2:
  - Rebased onto net/main; no code changes.
  - Added the net target-tree prefix.
v1: https://lore.kernel.org/all/26b3176e-d9ed-4508-bde7-388deefd970d@mail.kernel.org/

 drivers/net/ipvlan/ipvlan.h      |  1 +
 drivers/net/ipvlan/ipvlan_main.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index 80f84fc87008..13cdad00297c 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -64,6 +64,7 @@ struct ipvl_dev {
 	struct list_head	pnode;
 	struct ipvl_port	*port;
 	struct net_device	*phy_dev;
+	netdevice_tracker dev_tracker;
 	struct list_head	addrs;
 	struct ipvl_pcpu_stats	__percpu *pcpu_stats;
 	DECLARE_BITMAP(mac_filters, IPVLAN_MAC_FILTER_SIZE);
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index ed46439a9f4e..b1435296a0f1 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -162,6 +162,9 @@ static int ipvlan_init(struct net_device *dev)
 	}
 	port = ipvlan_port_get_rtnl(phy_dev);
 	port->count += 1;
+
+	netdev_hold(phy_dev, &ipvlan->dev_tracker, GFP_KERNEL);
+
 	return 0;
 }
 
@@ -673,6 +676,13 @@ void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
 }
 EXPORT_SYMBOL_GPL(ipvlan_link_delete);
 
+static void ipvlan_dev_free(struct net_device *dev)
+{
+	struct ipvl_dev *ipvlan = netdev_priv(dev);
+
+	netdev_put(ipvlan->phy_dev, &ipvlan->dev_tracker);
+}
+
 void ipvlan_link_setup(struct net_device *dev)
 {
 	ether_setup(dev);
@@ -682,6 +692,7 @@ void ipvlan_link_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_UNICAST_FLT | IFF_NO_QUEUE;
 	dev->netdev_ops = &ipvlan_netdev_ops;
 	dev->needs_free_netdev = true;
+	dev->priv_destructor = ipvlan_dev_free;
 	dev->header_ops = &ipvlan_header_ops;
 	dev->ethtool_ops = &ipvlan_ethtool_ops;
 }

base-commit: af39eb111ce6b5eba9c08513b62c4868eb7e7fd5
-- 
2.53.0
