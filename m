Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476814;
	b=qkjizIU5pF6AYOUYVBGWQWrdA1lRYoBAQa0efvCHCrAHZkKO583SDNaYJfnhl7Nn2h2M
	 smNU3rCu9/4TVYKyW2FBTJKJyPTXu8xmY9nN/5KqdsXXO36agxC106AjF6cQ4Pp5A9KX7
	 rCY9I7Sd5JK7bAGp40r7OJn4POV54YTI0iT8YCgoN5ce32CfdLcLklmNaEoqIFTFVXEJi
	 KSjgAXBwvETCFBNCOALDHdZd79kgKvbrEsYJpDDs/TF+o8asnn2X7za1NbKY6F4Z885/A
	 3K0ejo8W+42MWOHTq0JRMTRMPPRk6hvJAXTkR9a/uA5biil6NGSTgTby6ekByyhVobQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476814;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Os5ASwC0ZZ0storl1qYXZGqutt7G4ITq+W/A7LHhpa4=;
	b=oqP7d+ia1YbRN0FxxCitKueeaaJnNYsnAAmR1Onb9xQPD8aW23yBunqSZN0Gg2kdOiWz
	 Yt06y4hlvEydmbzRkSD1/5qitG7Eu3FPkfkggnRbKIja2EuqrhlxDvJqB8HrCHoj4LbWG
	 x1nKfKYy33L0P+WKtT6F0mrF5ifq58p5kfS1V04Dmi2g2/QqfshSyozo0kcLdv38MjcR5
	 nBckLtTpphkP1EAJGZJet4ZWsIlTqqDtI1pOTJ3smeae2E4eUu+fZ3+TtOD69vu0EgVsE
	 G5IOk88uNQytvBOOFKyqmXTTH3nQAkKfB626iP6lmSg5/VZjmxsHxYQVU85KGodHFFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=OgSlMzAz;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA93A606A31C;
	Thu, 12 Nov 2026 09:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA93A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=OgSlMzAz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=OgSlMzAzKJAqJsXs45GSMc7H2iU3L5Sv5RERx/6CZQ72TaJDW8goA80P9mt0Cp5sJWNJGVi3pJRGF
	 iEqYPYxtrD7kQwKgY5HpTp1Ls2iVAsXNiusJTia1Y2DQUJ8QWfq/bx93TU6KDXsIQmlscfLt5UP2xj
	 doMzL5NwX/KbXMU4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af58b096ea-816cb;
	Thu, 12 Nov 2026 17:46:50 +0800 (CST)
X-RM-TRANSID:2ee46af58b096ea-816cb
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.64.115.200])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af58b07794-fbc64;
	Thu, 12 Nov 2026 17:46:50 +0800 (CST)
X-RM-TRANSID:2ee16af58b07794-fbc64
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
Subject: [PATCH net-next v2 2/2] ipv6: preserve ip6mr_get_route() error in rt6_fill_node()
Date: Thu, 12 Nov 2026 17:46:30 +0800
Message-Id: <20261112094630.197244-3-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20261112094630.197244-1-sunwenbo@cmss.chinamobile.com>
References: <20261112094630.197244-1-sunwenbo@cmss.chinamobile.com>
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

In rt6_fill_node(), when ip6mr_get_route() fails with a negative error
(for example -ENODEV, -ENOENT, -ENOMEM, or -ENOBUFS), the error path
currently jumps to nla_put_failure and unconditionally returns -EMSGSIZE
("RTNETLINK answers: Message too long").

Among all callers of rt6_fill_node(), only inet6_rtm_getroute() passes
a non-zero iif and propagates negative errors back to userspace. Keeping
-EMSGSIZE as the default return value for attribute put failures while
preserving the negative error returned by ip6mr_get_route() lets
userspace see the actual failure reason when multicast forwarding is
enabled.

This issue was pointed out during code review of rt6_fill_node() by
Hangbin Liu, confirmed on a UML kernel with MRT6_INIT enabled (where
"ip -6 route get ff0e::1 from 2001:db8::3 iif d0" reported "Message too
long" despite the failure in ip6mr_get_route() being -ENODEV), and
verified after the patch that it returns -ENODEV ("No such device")
instead while other rt6_fill_node() paths behave unchanged.

Built with W=1 on UML, x86_64 allmodconfig, and x86_64 allyesconfig with
zero new warnings or errors.

Suggested-by: Hangbin Liu <liuhangbin@kylinos.cn>
Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
---
 net/ipv6/route.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 6dd4a70f6490..11ce0db66484 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5808,6 +5808,7 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 	struct nlmsghdr *nlh;
 	struct rtmsg *rtm;
 	long expires = 0;
+	int err = -EMSGSIZE;
 
 	nlh = nlmsg_put(skb, portid, seq, type, sizeof(*rtm), flags);
 	if (!nlh)
@@ -5864,12 +5865,14 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 #ifdef CONFIG_IPV6_MROUTE
 		if (ipv6_addr_is_multicast(&rt6_dst->addr) &&
 		    atomic_read(&net->ipv6.devconf_all->mc_forwarding)) {
-			int err = ip6mr_get_route(net, skb, rtm, portid);
+			int ret = ip6mr_get_route(net, skb, rtm, portid);
 
-			if (err == 0)
+			if (ret == 0)
 				return 0;
-			if (err < 0)
+			if (ret < 0) {
+				err = ret;
 				goto nla_put_failure;
+			}
 		} else
 #endif
 			if (nla_put_u32(skb, RTA_IIF, iif))
@@ -5992,7 +5995,7 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 
 nla_put_failure:
 	nlmsg_cancel(skb, nlh);
-	return -EMSGSIZE;
+	return err;
 }
 
 static int fib6_info_nh_uses_dev(struct fib6_nh *nh, void *arg)
-- 
2.33.0



