Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785638;
	b=byCzhi2f9ROIDIdRetWTsMghGhrgG0lZK6UHE/nt7WeoAZt8T7r2lz+7wJRfcZ6HWNBY
	 yQBf3Q4PhsO/k42ufWCVXAJSUWpIqgYDYF4CyZuZ2etb/9tFd/gmxUPn1ElkzFKZeV0DE
	 nGyx8WQ8QabHuU8CVI9J8FDlplTlOaNPvYne5cZGTlO8KetTXG2MGByC2HT/tkWoW5Ppr
	 4zEaWOvggn5LXX8F2czz+6Kbhs2gV2lABYXEZGjnc2NLx5VR/FlvTwYviy9+dpcupa3mT
	 Qv/ctrgxs1p21nq+z2EDMU/SjIcNnSM2Prrv8WzcYuDoXQ8u+sOzJNqkQe2MvQK8ULQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785638;
	h=DMARC-Filter:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Bm-Milter-Handled:X-Bm-Transport-Timestamp;
	bh=5h7JXEPn07Cl9ZCg5HRFpakYBmuBKBXZTuSgvDezgWU=;
	b=FU8tI/2ZIDT0bY051JDybnxVW0+V99WLyr9BTDeaqNSdNsi09I88dDO4o0D6Y+EIsE0m
	 BI7nfR1ihHd2whDjxRndqI7CEESfrfO0tjFQQ9LT9Wj+LxrVtvAwrGRxHbSqDm/iLfnV9
	 SCerV1lx0kRDn9fm+gJk0KNau9T/oujQYE5/302xsCFENT0EeHJ5IhHe4u5rkLEiaZgzU
	 f8xdJn2Cmr0dCoiKgJbsn98lMbkMSrbkZNqd+Yte3Zx/jpaAJeO/jFPggGsRad9H6YU3l
	 1rR2btmaTZixfX8RfrThdIxgrUK0FNLnSCdXrF9fufrQQu+/AMIxDnzCOM5u+jcSWzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=proxmox.com;
	spf=pass smtp.mailfrom=proxmox.com;
	arc=none smtp.remote-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAE3606A31B;
	Wed,  4 Nov 2026 09:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAAE3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 74CDD43ECB;
	Wed, 04 Nov 2026 10:47:08 +0100 (CET)
From: Gabriel Goller <g.goller@proxmox.com>
Date: Wed, 04 Nov 2026 10:46:10 +0100
Subject: [PATCH net-next v2] ipv6: Add NETCONFA_FORCE_FORWARDING to netconf
 messages
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ipv6_add_netconfa-v2-1-6f660990062f@proxmox.com>
X-B4-Tracking: v=1; b=H4sIAO3+6moC/32NQQ6DIBREr2L+ujSCFltXvUdjjMC30kQwQAmN8
 e5Fu+9yMm/erODRafTQFis4jNpra3JgpwLkNJgnEq1yBlYyTktWEb1E3g9K9QaDtGYciLg2gnN
 RXVjDIO8Wh6NOh/MBmSIGU4Du1/i3eKEMu3JnJ+2DdZ/jPtJj8ecpUkLJrVa0FmWjOKP3xdk02
 3SWdoZu27Yv6PO2r9AAAAA=
X-Change-ID: 20261023-ipv6_add_netconfa-b87b66b35272
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabriel Goller <g.goller@proxmox.com>
X-Mailer: b4 0.17-dev
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1793785627468

Since force_forwarding was added, changing the sysctl sends an
RTM_NEWNETCONF notification of type NETCONFA_FORCE_FORWARDING, but
inet6_netconf_fill_devconf() never emits the attribute. Listeners only
receive NETCONFA_IFINDEX without the new value, and RTM_GETNETCONF
replies and dumps omit it as well.

Also send a notification when disabling all.forwarding resets
force_forwarding on an interface, which previously happened silently.

Fixes: f24987ef6959 ("ipv6: add `force_forwarding` sysctl to enable per-interface forwarding")
Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
---
iproute2 patch here:
https://lore.kernel.org/netdev/20261028-ip_netconf_show-v1-1-a20fc6b20025@proxmox.com/

Changes in v2:
- Emit when net.ipv6.conf.all.forwarding is disabled (thanks @Ido Schimmel)
- Rebase onto net-next
- Link to v1: https://lore.kernel.org/20261023-ipv6_add_netconfa-v1-1-94d14b07d621@proxmox.com
---
 net/ipv6/addrconf.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c8c0dd04982d..1df6c1db472f 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -529,6 +529,9 @@ static int inet6_netconf_msgsize_devconf(int type)
 	if (all || type == NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN)
 		size += nla_total_size(4);
 
+	if (all || type == NETCONFA_FORCE_FORWARDING)
+		size += nla_total_size(4);
+
 	return size;
 }
 
@@ -578,6 +581,11 @@ static int inet6_netconf_fill_devconf(struct sk_buff *skb, int ifindex,
 			READ_ONCE(devconf->ignore_routes_with_linkdown)) < 0)
 		goto nla_put_failure;
 
+	if ((all || type == NETCONFA_FORCE_FORWARDING) &&
+	    nla_put_s32(skb, NETCONFA_FORCE_FORWARDING,
+			READ_ONCE(devconf->force_forwarding)) < 0)
+		goto nla_put_failure;
+
 out:
 	nlmsg_end(skb, nlh);
 	return 0;
@@ -863,8 +871,12 @@ static void addrconf_forward_change(struct net *net, __s32 newf)
 		if (idev) {
 			int changed = (!idev->cnf.forwarding) ^ (!newf);
 			/* Disabling all.forwarding sets 0 to force_forwarding for all interfaces */
-			if (newf == 0)
+			if (newf == 0 && idev->cnf.force_forwarding) {
 				WRITE_ONCE(idev->cnf.force_forwarding, 0);
+				inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
+							     NETCONFA_FORCE_FORWARDING,
+							     dev->ifindex, &idev->cnf);
+			}
 
 			WRITE_ONCE(idev->cnf.forwarding, newf);
 			if (changed)

---
base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
change-id: 20261023-ipv6_add_netconfa-b87b66b35272

Best regards,
--  
Gabriel Goller <g.goller@proxmox.com>


