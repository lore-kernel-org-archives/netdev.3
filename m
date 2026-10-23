Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753248;
	b=vZnCf/po4rJWnbx+LUuVOB7/3eVpC5VIQtZ1ev58cjtlEozpC4gfpBUvxq6YZhI70SBj
	 tCSC35JXDjRfOsgy6JPTLTwucMWMUmt6Qd4cRuKm/x1Rpoch1l9cBRTIPoHu++B3QABdg
	 LfkMS9rbHnRF1C+OgT6/9yjJ31+/pZZjYZyH+hcDgStOUknSm8WniAfWj34BaZJjuLoW/
	 BYG5EcjQ6t5pvyCnbPfS8Sr3cxerjvyrzQXdiYfq1OXUtbBZYt9t7EqGVg8jTcqihZZdb
	 aKI0gGVpvPVWw8+ITGAkLDBM9/3gnm2R5hFoklEoqgkMoxrFcvG4pNZV+HPUiKhwvLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753248;
	h=DMARC-Filter:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Bm-Milter-Handled:X-Bm-Transport-Timestamp;
	bh=IWKtxFKjRODhckz5/aWucmo3yj4awpvEuohY8D2KsU8=;
	b=xq3asVvattG/MFRjVxnAqpvtDnfhsINosfo3R8vxDCjGn5A0BLDEjWUrtusREc5dNmSL
	 5RIeK3hGxj+QlEkdktEGYd4FIh5KhjTfmvNYNPaw+ZQHTz2881n/wBZgcUPFbguIHq8sg
	 E0pUEpnaJV9kp3H8dak1Zq2jGeyrs+z5s+kA8w261IUOszdg/wMuAWpK3Ex6ckkEPDofv
	 wfvv9KyV0L7fZ0G1gdBAH5BGksTEi+/2GOhfrQ1TYhTsp30R2CIJcPEMyXh+wJZd2fDsr
	 HI03qh5TTltjmTrJYQpjVn2XviVg0Tv7nwEdjt5M+MR8Db435xWdhTpySqrH4vguVmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=proxmox.com;
	spf=pass smtp.mailfrom=proxmox.com;
	arc=none smtp.remote-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3385C606A31A;
	Fri, 23 Oct 2026 11:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3385C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8F1A045194;
	Fri, 23 Oct 2026 13:00:38 +0200 (CEST)
From: Gabriel Goller <g.goller@proxmox.com>
Date: Fri, 23 Oct 2026 12:59:18 +0200
Subject: [PATCH net] ipv6: Add NETCONFA_FORCE_FORWARDING to netconf
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
Message-Id: <20261023-ipv6_add_netconfa-v1-1-94d14b07d621@proxmox.com>
X-B4-Tracking: v=1; b=H4sIABE+22oC/yWMWwqDMBQFtyLnuwG90li6lVIkj6vefkRJVARx7
 6b6OYczsyNxFE54Fzsir5JkDBmqRwE3mNCzEp8ZVJKuSqqVTKtujfdt4NmNoTPKvhqrta2f1BC
 yN0XuZLuaH+QXvveYFvtjN/9rOI4TBThPgHoAAAA=
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
X-Bm-Transport-Timestamp: 1792753237868

Since force_forwarding was added, changing the sysctl sends an
RTM_NEWNETCONF notification of type NETCONFA_FORCE_FORWARDING, but
inet6_netconf_fill_devconf() never emits the attribute. Listeners only
receive NETCONFA_IFINDEX without the new value, and RTM_GETNETCONF
replies and dumps omit it as well.

Fixes: f24987ef6959 ("ipv6: add `force_forwarding` sysctl to enable per-interface forwarding")
Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
---
 net/ipv6/addrconf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c8c0dd04982d..1b8caf6f4f16 100644
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

---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
change-id: 20261023-ipv6_add_netconfa-b87b66b35272

Best regards,
--  
Gabriel Goller <g.goller@proxmox.com>


