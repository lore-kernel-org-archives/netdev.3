Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794065395;
	b=w6fcu76+9Yt9maCQQ0Su7fUO20grLg/t44eOTMw9Z3/Fd2nw1ICEI3bE6jx7KkNwEwmh
	 pkKhihVplq/dWhGuFAPzQKupdwyaP5zQQ+2W67yKS0rRLb6xj2vXP+s/BVoBt1CU+4QQO
	 qsKJKCNTxfCxlsl+MxECS5DANcDkctwWO3k8lgAdo16Wd/HmVul2EhI5gOnxsLanm173O
	 B/eBjjDyAdVoOkIJSJlKe6oHx0wf9O5gDUVR9Oz5OdBb+/DnN9/g4TNCxoJEl9ptCWZ5e
	 kSXdqfPWSbCyNspC1/IzWkhwlU5c2hiOK4lCJAPGmC6yJZpaVwthUC5pSsaOJZMf1hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794065395;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Gos6EounOErZ7sTr9+vYXOr/o0iNI5gjdw4MzsgIeXg=;
	b=wTlMowtnXE+0frjxrI9Brqgw/zZQ9pZTeH1kHGU7lsRuZGfFvG8ziCq3NAK3O3bTdEuS
	 5VoCFPH1cIV/KmlXGHqM+MJ7i08XjpCq8VnRsI3DA3XI5UxEatMeN8g62mq74Ge0zyF5X
	 QHuAtKBGRIK20d9GgNoj2LFplkEC5eSXZ9eBEmR5Gy7T6Jsz2tMdJYw9gQUYG6Pwo5m08
	 SHB1g4WEm0VFYAvF3mSzUU/bPsX/OvvF0jVu4Oaz05whhDRnsNccLxwiHy+26/6DsJQV7
	 v7ZU6nvrcKfZQagVm+ZUkBNskY5HVZ1ghad+pjHO0ADwloyTO1q0kJLZjeScJZQnq2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OzM8utpH;
	arc=none smtp.remote-ip=203.205.221.233
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747A4606A33A
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 15:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 747A4606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OzM8utpH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794065390; bh=Gos6EounOErZ7sTr9+vYXOr/o0iNI5gjdw4MzsgIeXg=;
	h=From:To:Cc:Subject:Date;
	b=OzM8utpHE69f60axpy20eF/DsDeD3SpGz38SxoMPrBdfOpr7GCTKhDlUDZ3IkqeXl
	 VirzyJuACjhYeG4PKSv7qIGCxQD1NqISNdA5+8y7Y3ASgPs9aY5ZGUl/y507lhIHbi
	 iQ4nls5htpP6YvFoF7r75bAlwQ+BM7m2baS3Ji2c=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:5872:d752:285e:a265])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 76F1E2CD; Sat, 07 Nov 2026 23:29:47 +0800
X-QQ-mid: xmsmtpt1794065387t21kanaok
Message-ID: <tencent_CB9E1044AC97882719FF3A9F5B410A562408@qq.com>
X-QQ-XMAILINFO: Me3sdj1312powEzU6IheEQILYwAnsTqLbMqKsjSxLxikW8K/nCL9tCMt0Mpj5n
	 qvKtZwOgtAIHo9PCO2jvfRld9+hQinWbeD1SQA7KMATpF68ysxJgGIboukB8H/HPncoYRx9A79MS
	 796HleGrcGMlEsdTkubN4gcu14nKno8TNWFOo04BDvxkv4rlNhiYqrG/iqaqGEricrC6Yquk1IZu
	 Ke4GyD9D+264kM5sjY6KT4VmkG/iXvwnbhyGK7Y2HRijdw7sGDuG9dIGzbiXNnr4+Yj3PkzgY75a
	 KxUQQ5k0HcSIY3UXLObxW+jtCiyuzSf1BluumMHVAN56NJwG3+qn5zQlKUTPHzW+F6aD9dylli4l
	 1oV7WhRZ7c80GitnXHSx8LhsQmesW4ZsUflkic46ya7wRZ7IlENnA0jT7Nj/tfrNA7qHHHQwb3PD
	 UYuuHTb2minaU69Hqf1uoJSa5eZtRlBoJebb6m84pjdUFSJN+Vu4XcSeUiQ3nX46begRnBGLmkDT
	 0QNaKOMGtHj3BG0zLkzCLPTffZX6Bz0U8gPZal2QDFHZiH8whljdzpSrhrcleLFY6sLQqzrpuLCK
	 Q3lbeV1zq05DjvmfufnbFpCqgucv6JU9QANGkTYP+9zAGxaGHyLKt7G45PPAG3SgDPR36Zx4Kuuk
	 WfSDNRyoLzrFRJGCrNpYnyaZGUlLi7IS3DP6qRonuJWUKkZH7a8b5PJPP0YY1fGnqTATVX9Wkw7g
	 ZcF7S8yiGNmmTuqsoHpihejtilPqxXWNS/I9Nvg3OBUKRfQ6SIuYri9CIoL368Ew/49xN3kXob2l
	 /RioNws4ftSrurGvogx7Qm/FvTiNX8isUQd51fm9KIfIjDs48UcNAElUe0j/PUnGXSHMiJrAD0Cp
	 Y1acBndgalYWMXOn8UVKsICtbC8lKObQt1QhLpnrpYXYVOAAQT2sNXWMyIspEj9pOB8xlr6da9xZ
	 wFQswXvdgAVy47ED1QIgUK1gvcA9uqgSs6wlep8mHiqlpWitW9OzhPlhTnXKeDyBsIDO0+8rodye
	 eSYbwEqj3plT1EQDmmqFiL2Gv4RAP6povIpcFctmXUBI7Cr0Xtx4XCg0HAexITNxrlO6cNNFOQ6W
	 /fbFlor2XIMoStLKY=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Yingjie Wang <1075151112@qq.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Graf <tgraf@suug.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ipv6: reject collect_md tunnel route without inet6_dev
Date: Sat,  7 Nov 2026 23:29:47 +0800
X-OQ-MSGID: <20261107152947.1621464-1-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
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

ip6_tnl_xmit() selects an outer source address for a collect_md tunnel
with an unspecified metadata source by dereferencing
ip6_dst_idev(dst)->dev.

A route using a nexthop object can remain after its output device loses
its inet6_dev when its MTU is lowered below IPV6_MIN_MTU. The route still
has no error, so ip6_route_output() returns it with rt6i_idev == NULL.

An unprivileged user with CAP_NET_ADMIN in a private user and network
namespace can create this state and send an encapsulated packet through
an external ip6tnl device. The unchecked dereference then causes a NULL
pointer dereference in ip6_tnl_xmit(). With panic_on_oops enabled, this
panics the host.

A similar missing inet6_dev check was fixed in
commit 1b9b5323725e ("netfilter: ip6t_rpfilter: reject routes
without inet6_dev").

However, the collect_md transmit path in ip6_tnl_xmit()
still dereferences ip6_dst_idev(dst)->dev without checking
whether the route has an associated inet6_dev.

Check the route's inet6_dev before using its device. The unmodified
net/main KASAN kernel reproduced the NULL dereference, and the same
reproducer on the fixed kernel rejected the packet without a KASAN report,
oops, or panic. The fixed kernel also passed the ip6_tunnel.sh selftest.

Fixes: 8d79266bc48c ("ip6_tunnel: add collect_md mode to IPv6 tunnels")
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
 net/ipv6/ip6_tunnel.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 64a184bca467..547c23c3121b 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1187,10 +1187,14 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 			dst = NULL;
 			goto tx_err_link_failure;
 		}
-		if (t->parms.collect_md && ipv6_addr_any(&fl6->saddr) &&
-		    ipv6_dev_get_saddr(net, ip6_dst_idev(dst)->dev,
-				       &fl6->daddr, 0, &fl6->saddr))
-			goto tx_err_link_failure;
+		if (t->parms.collect_md && ipv6_addr_any(&fl6->saddr)) {
+			struct inet6_dev *idev = ip6_dst_idev(dst);
+
+			if (!idev ||
+			    ipv6_dev_get_saddr(net, idev->dev, &fl6->daddr,
+					       0, &fl6->saddr))
+				goto tx_err_link_failure;
+		}
 		ndst = dst;
 	}
 

base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
-- 
2.43.0

