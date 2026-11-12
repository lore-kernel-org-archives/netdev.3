Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476816;
	b=xS39Z8aO2j5fo3AodaSfX+QKn07pra+tZpVdktJDoZDhvzp06zD8uvAX+F0ngWZowxsF
	 lGKTWW8aV6PcHPWYExtHbhoIy6voXxvqVFXQZzzkUTEGZsMVgP6Pg/FCDQZ4EGdwakOwo
	 CznShYL1ao2BMh169bsuV7q4qqkllEDPVncVLmp6IwcaJnVQkncuCYrgB9rqS38zVImH0
	 bbMkzsmHwpih7KXrfshZBx07DKtdLwBIXjg29v+UOWpYPIohJ+phG0oK+sMpQU1bS5bYk
	 Pm0eUkHAlL+0p/pxbiocnJuQR2o457WQdrSa13TVzDg59OIFjAPMsPTBh8AzwVFOKFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476816;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=96AFcjsFUu64ph602ohCRRpMTvRHlkWjdKbxPsrp7iE=;
	b=MSXros0wvYropaB26ECSETRknqbnJ544vNpIbAhXa+mYPfmUxDv7wh0GcghEAx78grL/
	 AclPDJZhsPuPGMc4vJIaq+9TQzJBMQc2qyLuK8Xx62Ma6u3HSEQlHNxpAOlLRox13t1IM
	 /6Cv98qZN3YC2wqX5PnbdbNu5cleo4HXSdcIkOWKB2G+bCNagufCpoqBDltJgqbuBDu/x
	 ykcjGGMKFtgdk2lilplEw3KdkgkLlcMSOvnu8aXRshB1FU8qTwLBcF5jHAOfqbW6Kdtt6
	 VfbdBqJIKRzRwcIIe7WgsExR8lE+3ioV7wesrH2+uapNRPZHUUgs5HbsN+XfE50kwgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=P6Hc+lk1;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12C2606A333;
	Thu, 12 Nov 2026 09:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D12C2606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=P6Hc+lk1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=P6Hc+lk1AHb4PhEPbvSOTb2Q1s9CfFt4dgm4nA0qxZm+UPbEpBw+GMNrhSiJjUgeSofztcZG5w10l
	 K/f8hy09tLhw+xS0OnqfOPMZB9CASsuy/n40vnnXt/oJk08LVcwE2uXw2FjBb5COG3UDAhnal1Frwh
	 nHtBXem2mexnFjxA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af58b08ad0-df203;
	Thu, 12 Nov 2026 17:46:49 +0800 (CST)
X-RM-TRANSID:2ee56af58b08ad0-df203
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[223.64.115.200])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af58b07794-fbc5d;
	Thu, 12 Nov 2026 17:46:49 +0800 (CST)
X-RM-TRANSID:2ee16af58b07794-fbc5d
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Hangbin Liu <hangbin.liu@linux.dev>,
	Hangbin Liu <liuhangbin@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: [PATCH net-next v2 0/2] ipv6: fix rt6_fill_node() multicast route query handling
Date: Thu, 12 Nov 2026 17:46:28 +0800
Message-Id: <20261112094630.197244-1-sunwenbo@cmss.chinamobile.com>
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

When querying an IPv6 multicast route with an input interface via
"ip -6 route get <mcast_addr> from <src_addr> iif <dev>", rt6_fill_node()
currently calls ip6mr_get_route() unconditionally and masks any negative
error returned by ip6mr_get_route() with -EMSGSIZE at nla_put_failure.

Patch 1 checks mc_forwarding before calling ip6mr_get_route(), matching
IPv4 rt_fill_info() so queries succeed with RTA_IIF when multicast
routing is disabled. Patch 2 preserves the negative error returned by
ip6mr_get_route() instead of overwriting it with -EMSGSIZE when
multicast forwarding is enabled.

Thanks to Hangbin Liu for reviewing v1 and pointing out the error
masking issue in rt6_fill_node().

Changes in v2:
- Reword patch 1 commit message for clearer tone and carry
  Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>.
- Add patch 2 to preserve negative errors returned by ip6mr_get_route()
  instead of returning -EMSGSIZE from nla_put_failure, with
  Suggested-by: Hangbin Liu <liuhangbin@kylinos.cn>.
- Verify both mc_forwarding=0 and mc_forwarding=1 (MRT6_INIT) cases in
  a UML kernel alongside W=1 builds on UML, x86_64 allmodconfig, and
  x86_64 allyesconfig.

Link: https://lore.kernel.org/netdev/20261111094528.425826-1-sunwenbo@cmss.chinamobile.com/ [v1]

Wenbo Sun (2):
  ipv6: check mc_forwarding before calling ip6mr_get_route()
  ipv6: preserve ip6mr_get_route() error in rt6_fill_node()

 net/ipv6/route.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

-- 
2.33.0



