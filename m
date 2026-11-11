Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385363;
	b=gwKlM7DY4tsFGuF1cI5wAj3O9KlCsNP7slW98UzXVnz/dSUHTVgBJjUDtMsl65pzu9Tz
	 UqgurPIkozwNM3XR2wO3KmjT49lBiSb2WOwwd3r2D/puUZOOw0kMGW3HV0w7qI77sft2r
	 nbCQkI5jm5TkioFwkvsN8DHQuS3noJEzVCdkTU9xZ6fc1v5Y7dJipXTuTg4DyAUWS+HQY
	 XysIfPBZuhFA/qOcYUTk/TKVE3a4HQMeOGbdAM++aOgKfFovJXSr+ms3TAxiTqf9JJbsI
	 Nc72hjMu5e4lxzOjHJwnm1wTGFyvjtzi6SEXfItcUmfVi4AjIXBf03+MJYXTCjpYsiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385363;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6GK72AVuslSoKdLshEGf1+htRIfaqyHglB42kw/F2tE=;
	b=gK3GOb/C35POdD2LaRuNAgljWUGD4/iJT5WFGnjtelou203mhCpLpmjvigkmpHp94pM6
	 Ul5BnSoPGIGhEXFBCnWOXoSQbKVYxf4OPVSbbTK4ZPdfs+q/8K0SZfi89E0T2LH71rwT3
	 lXTz2hlN4yU/vSj1CcQD11oCd25WraeVJ0CnO0YbqcJApfq4e3IHTk+Pe6z3eoLlu2fqv
	 IvXDjAASF4yuw10/YU2KK3lSK0o1acre1rUO26wGQvPJxWy+T+jT3yVN9zVf1CjzUzaV0
	 edXCvGvR0iJWkpvv0RjFDVPESzI0Z3/tvpyePW8pkbigEHNUO5n+hMunzFoEpBC7Hrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=PAmuighm;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37743606A324;
	Wed, 11 Nov 2026 08:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37743606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=PAmuighm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=PAmuighmobnFROLMHN1WQJ1PWnBljLgPVkbpUVXg4shNibrsyQgLKJHFN86jywCVoaCk7ldNLznai
	 PXO5wB9Rie+kkF8VcGQbpAmFOYQ4Kk4Sr9tRJagGGS83SkqSmP3AnDzECylpNYCkNfcyZDMAtTmRWR
	 hR5aJtrZeq9Vdil4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af425ca6af-7655d;
	Wed, 11 Nov 2026 16:22:40 +0800 (CST)
X-RM-TRANSID:2ee46af425ca6af-7655d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[223.64.115.200])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af425ce061-d519d;
	Wed, 11 Nov 2026 16:22:40 +0800 (CST)
X-RM-TRANSID:2ee16af425ce061-d519d
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Yuyang Huang <yuyanghuang@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: [PATCH net] ipv4: igmp: report IFA_TARGET_NETNSID in multicast address dumps
Date: Wed, 11 Nov 2026 16:22:22 +0800
Message-Id: <20261111082222.327963-1-sunwenbo@cmss.chinamobile.com>
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
extended RTM_GETMULTICAST to support dumping IPv4 multicast addresses.
While inet_valid_dump_ifaddr_req() accepts IFA_TARGET_NETNSID in dump
requests and dumps addresses from the target network namespace,
inet_fill_ifmcaddr() never puts IFA_TARGET_NETNSID in the netlink
replies.

As a result, userspace applications querying multicast addresses in a
target netns receive entries without IFA_TARGET_NETNSID, which may lead
them to conclude that the kernel does not support netns-targeted dumps
or to misattribute the returned addresses. In contrast, IPv4 unicast
address dumps (inet_fill_ifaddr()), IPv6 multicast address dumps
(inet6_fill_ifmcaddr()), and AF_PACKET multicast address dumps all
report IFA_TARGET_NETNSID.

Add IFA_TARGET_NETNSID to inet_fill_ifmcaddr() when requested, and
explicitly set fillargs.netnsid = -1 in inet_ifmcaddr_notify() to
prevent notification messages from exceeding their preallocated skb
size.

This issue was identified with the assistance of an LLM-based code
review tool, confirmed by reproducing in a User-Mode Linux (UML)
environment where AF_INET RTM_GETMULTICAST dumps with IFA_TARGET_NETNSID
omitted the attribute, and verified in UML that AF_INET multicast dumps
now report IFA_TARGET_NETNSID, normal dumps without netnsid continue to
work, and socket multicast join/leave notifications succeed without
warning.

Fixes: eb4e17a1d915 ("netlink: support dumping IPv4 multicast addresses")
Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
---
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



