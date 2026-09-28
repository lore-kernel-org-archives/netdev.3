Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213C140B103;
	Mon, 28 Sep 2026 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622491; cv=none; b=kODDaK1O08yI33l1SrhrZYqsx267aDzQRitQA5UqkhJ8X/M9ckIo9aGfOA4ZYjzmULM0TNHH1UxfmkBmLSw/b7e0YyivtMLjBedJ8kuh1Pli3NnxxtX8gDYz+h64w6Y8StnF/uFIwHxYTVZAE/LPLFjXMP5J4AA12DmKOP1bMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622491; c=relaxed/simple;
	bh=6BrH0HigD9iLUJ8aN6CChP2OW1oARg4HWknsBNaFau8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+OB1vZRzEd8e89FwKFQs9ZQYOmoW/WlBiE7+BLBnf/b0UBJBcGQro/CrbskmM7iLorE3/89rE0k6ecv/Te7ctmPQQW2DYRoKKL1vIlhJzySRdrSfVXWc5PaFTAY5f/FtZGjopv6QCWx+r7JDvloXH/+tMvaMvplIG3uk29oyLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnxtBwca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnxtBwca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AA71F000FF;
	Mon, 28 Sep 2026 19:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790622489;
	bh=RUTn5Kxp350JV29xCs2oZojdLEOY0FUMHl+qu4s2lds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FnxtBwcaxEY3FB4PoC04fLdzbOXiJf/iLKffP2TJbnGXHak/dwrf+uCN5KZ4tXLfr
	 4Jhw2WQXHlLPXeYVYp7BSVOKtqDUs+ZqXJRzqcv1PfZ4B/g94bDA6QAAb6VLYyj7Oy
	 QqydqeZQ/XbfBrIYruHnZH+yjl5RMqZlhgj1ND4V7UKVbwVlKesb/GF/9VowVB5uEj
	 h4amW30KVuzcQfYoasx0eL+8KauXFMyUQ9XrdXrWVJfKnF2YWClNs/HVSHyKOFiA9c
	 BtKPeSLykp6n3qbyQRsTHJ6X1k1mDRjCsj/HGFkQt57JxdBUnor30hukXT1goV/xWc
	 q8kVSyH49SB1Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	kernel@xen0n.name,
	chenhuacai@kernel.org,
	tsbogend@alpha.franken.de,
	deller@gmx.de,
	razor@blackwall.org,
	idosch@nvidia.com,
	aconole@redhat.com,
	ardb@kernel.org,
	tim.bird@sony.com,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] net: drop unused LLC-related includes
Date: Mon, 28 Sep 2026 12:08:00 -0700
Message-ID: <20260928190800.2521749-4-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928190800.2521749-1-kuba@kernel.org>
References: <20260928190800.2521749-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bridge and the openvswitch code include <net/llc.h>,
<net/llc_pdu.h> and <linux/llc.h> without using anything out of them.
parse_ethertype() is the one exception: it wants LLC_SAP_SNAP, which
comes from the uAPI header <linux/llc.h> pulls in, so flow.c keeps
that one. The LLC core has leftovers of its own - slab, string,
interrupt and net_namespace - which it has not used in a long time.

None of this is new, the type 2 removal has just shrunk the LLC
headers enough to make it easy to see.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/bridge/br.c                | 2 --
 net/llc/llc_core.c             | 3 ---
 net/llc/llc_input.c            | 2 --
 net/openvswitch/flow.c         | 1 -
 net/openvswitch/flow_netlink.c | 2 --
 net/openvswitch/flow_table.c   | 2 --
 net/openvswitch/vport-netdev.c | 1 -
 7 files changed, 13 deletions(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index 09a120b3b76c..c602d6305997 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -12,8 +12,6 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/init.h>
-#include <linux/llc.h>
-#include <net/llc.h>
 #include <net/stp.h>
 #include <net/switchdev.h>
 
diff --git a/net/llc/llc_core.c b/net/llc/llc_core.c
index cde6a0b1509e..eafc57ac903d 100644
--- a/net/llc/llc_core.c
+++ b/net/llc/llc_core.c
@@ -7,13 +7,10 @@
  */
 
 #include <linux/module.h>
-#include <linux/interrupt.h>
 #include <linux/if_ether.h>
 #include <linux/netdevice.h>
 #include <linux/slab.h>
-#include <linux/string.h>
 #include <linux/init.h>
-#include <net/net_namespace.h>
 #include <net/llc.h>
 
 static LIST_HEAD(llc_sap_list);
diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index a8730c54b5c2..6bb4275a8518 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -6,8 +6,6 @@
  * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  */
 #include <linux/netdevice.h>
-#include <linux/slab.h>
-#include <net/net_namespace.h>
 #include <net/llc.h>
 #include <net/llc_pdu.h>
 
diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 868d9fdf3afd..1c4f3a079044 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -8,7 +8,6 @@
 #include <linux/etherdevice.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
-#include <net/llc_pdu.h>
 #include <linux/kernel.h>
 #include <linux/jhash.h>
 #include <linux/jiffies.h>
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index d8079dee700e..de0053f701b3 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -12,11 +12,9 @@
 #include <linux/etherdevice.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
-#include <net/llc_pdu.h>
 #include <linux/kernel.h>
 #include <linux/jhash.h>
 #include <linux/jiffies.h>
-#include <linux/llc.h>
 #include <linux/module.h>
 #include <linux/in.h>
 #include <linux/rcupdate.h>
diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index 1e0f9d193eb0..93d36f66e2ac 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -11,11 +11,9 @@
 #include <linux/etherdevice.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
-#include <net/llc_pdu.h>
 #include <linux/kernel.h>
 #include <linux/jhash.h>
 #include <linux/jiffies.h>
-#include <linux/llc.h>
 #include <linux/module.h>
 #include <linux/in.h>
 #include <linux/rcupdate.h>
diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 44808cd0fcff..7daea2e44dfa 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -9,7 +9,6 @@
 #include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
 #include <linux/kernel.h>
-#include <linux/llc.h>
 #include <linux/rtnetlink.h>
 #include <linux/skbuff.h>
 #include <linux/openvswitch.h>
-- 
2.55.0

