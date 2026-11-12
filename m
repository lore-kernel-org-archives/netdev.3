Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471853;
	b=uRqjO4gnzV4N8uKJ5uiC2EGGP04pLLQe5gv08A8aIsiCaj1uQd6jxZnSBf0e1UX1Qv9m
	 Cqb6RHYn++3Gw65aV6L37A26ZmXvvXO8qgVD8LqPi+pZKKoJihV6NYED4c1a7xlzuqBZG
	 oXH89nPa5lxOuRxCzDvje8SFsd36wzcisO5VXhnoHjxk2nfxbOSsSxg6qr1XWdyd/at7T
	 spuGnuo+iuqQH1r9wJN8nfnpgaV1smXiZYkw85Arv+EmFW8xa6pAV7Cekca/obzt2h3qA
	 o0zXv02EE/1KUNXrNdiDHzl18rdmDD99hTbyX0mcTAg0Ym+3M3BTBSrhdGBs01A4rxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471853;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JMrnXJbl1AbunGpAayAEFxy1RdzVfz2r7X5OdfT2r3Q=;
	b=AgE9f+MaTKeCU67WzunexCKRH9v04ZCUTIphWPjMoCIlZ74kb5CUM2j54/Nz//VdavRz
	 fexE2JnLFZRos0tjY0+AgR5PpTgFZoT5ciAl+0gxmF4yLK9qcHLAyxFfFeHZUx2/UhBx7
	 E0wra6x+4gJDBUaVrBDXO0VHBeCyswpePLNpkHJ+lMdRDL8LYktBIsJGZsD93tBLYnnCM
	 nhosZswF4/+iMJN/or443aGf+vtG7Crk7XkeY2kT6e3uMvfJ7RSrxLIm/oOrWeeu7szO9
	 v+OkPdCe4uWVUUqoy35Iw8mrotrbhcfPnvea4prEu2fSHHhGWX1EIkHxu50CzPwnv8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=h+9HscNd;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BC7606A32A;
	Thu, 12 Nov 2026 08:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96BC7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=h+9HscNd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=h+9HscNd9XJ6MX6K5nBhFyIrcVgDG3/xbtIOn7JD0FH4EeDGiDi1g+SDK0UyY/1piceRDsT7nFqNm
	 +E5RlyJpDrKJipSTCjBE9c1W7Lojjb2KzVSawWarWGB2r72Wo5wW1u0Db6kmW7aedt5k3WLV0eoEBs
	 qYt9zVJ+ykxq25Ys=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af577a925a-80233;
	Thu, 12 Nov 2026 16:24:10 +0800 (CST)
X-RM-TRANSID:2ee46af577a925a-80233
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[112.23.105.204])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af577a9753-f8ba4;
	Thu, 12 Nov 2026 16:24:10 +0800 (CST)
X-RM-TRANSID:2ee86af577a9753-f8ba4
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Hangbin Liu <hangbin.liu@linux.dev>,
	Yuyang Huang <yuyanghuang@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: [PATCH net-next v2] ipv4: igmp: report IFA_TARGET_NETNSID in multicast address dumps
Date: Thu, 12 Nov 2026 16:23:52 +0800
Message-Id: <20261112082352.152338-1-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit eb4e17a1d915 ("netlink: support dumping IPv4 multicast addresses")
extended RTM_GETMULTICAST to dump IPv4 multicast addresses by reusing
inet_valid_dump_ifaddr_req(), which already accepts IFA_TARGET_NETNSID
and switches to the target network namespace. However,
inet_fill_ifmcaddr() does not include IFA_TARGET_NETNSID in the dump
replies yet.

In contrast, IPv4 unicast dumps (inet_fill_ifaddr()), IPv6 multicast
dumps (inet6_fill_ifmcaddr()), and AF_PACKET multicast dumps
(dev_mc_fill_addr()) all report IFA_TARGET_NETNSID when a netns id is
specified. Adding the same behavior to IPv4 multicast dumps aligns
reporting across address families and helps userspace consistently
identify target-netns replies.

Emit IFA_TARGET_NETNSID in inet_fill_ifmcaddr() when args->netnsid >= 0,
and initialize fillargs.netnsid = -1 in inet_ifmcaddr_notify() so that
multicast join/leave notifications do not include IFA_TARGET_NETNSID or
exceed their preallocated skb size.

This alignment was identified with the assistance of an LLM-based code
review tool, confirmed in a User-Mode Linux (UML) environment where AF_INET
RTM_GETMULTICAST dumps with IFA_TARGET_NETNSID omitted the attribute while
AF_INET6 included it, and verified in UML that AF_INET multicast dumps
now report IFA_TARGET_NETNSID, regular dumps without netnsid continue to
work, and multicast join/leave notifications succeed without warning.

Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
---
Changes in v2:
- Target net-next as an enhancement/alignment change and drop the Fixes
  tag, per Hangbin Liu's review.
- Soften and clarify the commit message to reflect feature alignment with
  inet_fill_ifaddr(), inet6_fill_ifmcaddr(), and dev_mc_fill_addr().
- Link to v1: https://lore.kernel.org/r/20261111082222.327963-1-sunwenbo@cmss.chinamobile.com

 net/ipv4/igmp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 144fca158adc..831d003677ba 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1517,6 +1517,12 @@ int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
 	ifm->ifa_scope = RT_SCOPE_UNIVERSE;
 	ifm->ifa_index = dev->ifindex;
 
+	if (args->netnsid >= 0 &&
+	    nla_put_s32(skb, IFA_TARGET_NETNSID, args->netnsid)) {
+		nlmsg_cancel(skb, nlh);
+		return -EMSGSIZE;
+	}
+
 	ci.cstamp = (READ_ONCE(im->mca_cstamp) - INITIAL_JIFFIES) * 100UL / HZ;
 	ci.tstamp = ci.cstamp;
 	ci.ifa_prefered = INFINITY_LIFE_TIME;
@@ -1538,6 +1544,7 @@ static void inet_ifmcaddr_notify(struct net_device *dev,
 {
 	struct inet_fill_args fillargs = {
 		.event = event,
+		.netnsid = -1,
 	};
 	struct net *net = dev_net(dev);
 	struct sk_buff *skb;
-- 
2.33.0



