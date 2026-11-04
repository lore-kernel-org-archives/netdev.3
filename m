Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805042;
	b=Q3efE86M1ZEVdpxXkUvRg4VDcrIxp6tpAzplHuyRVfPOE24e41rDCBzfGEeQ67Vez4fQ
	 5Kj8QRxNV4RWQw6wzv1nfHD/Hkjwam1FTGQn3yKXPS0TVzIhACCjutBH1Jci713r9BgVY
	 2Al+F469N4dCVGpAs6gPetxjFc6dm/MzaLJWaPEPl0PphLWweP/QrFZxMfR2jEBrLwvJJ
	 N8M/sVASAmuoqOwwHmQgG8tiMK/LMdCdjhDpGVmxV1af62Wpwp813i/UJZGhNQ8PEaL2V
	 JLJUJmol+vbVM+mV+7bW1cxilt9pb+e9yifHO/if3R1NdmpyAddffevTyNTB39SeTxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805042;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:X-Mailer:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=INoEaO6i1XuDk1klXJSyLtLXz/khjGFC70VaxLfFDy4=;
	b=3ek7RwcbcwhGAhfyIDR46JMjk6JBiAsXKerxhA2oT7L8Y+9Xi2Nzl1jLvQISbjygAKdz
	 sgAKTtdbXL8Sp7fHOg2n1zT/zrgFoETFB+hwwSpXJO+kDbhRaChHKHBy1qPdwFGCUZEtd
	 KuhjeN3+Wd8x3FEdByAUzsE1w9wD2V2/hwUs6AW3ZfMV481/VbibZSh8zkGL6s1gKT/Qa
	 EYeFOPlAsRacwK8ggJ69/VnqNMhISPWBTmELYbbwDK4457jo+RdgL+zAMZMlDhVYGzsmb
	 GNnxaZlMD6Xyuc/NbmL28hUwb/85qcmmOf1RXMreyHezzwocgB3Ms7GPuiUwaQNFzTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ITte3e9L;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190EA606A31B;
	Wed,  4 Nov 2026 15:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 190EA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ITte3e9L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ITte3e9LXd+Hmk4ifU53fesRV4BbUy+MVBm9O9OqoX63jBa3sTckbxL1wexF9PMCvHsWYOVurdTEe
	 E8YLzQpVfy5FmaUqwCokozq9vS75ozaLuWOFVgd3n/yWEwDKXSgFdIXOjkSzlufy/5GLkkjaDJbmTM
	 n2ek/gkO4Lg1rVNw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66aeb4ae768a-6aea1;
	Wed, 04 Nov 2026 23:10:31 +0800 (CST)
X-RM-TRANSID:2ee66aeb4ae768a-6aea1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.23.104.16])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66aeb4ae444a-257ec;
	Wed, 04 Nov 2026 23:10:31 +0800 (CST)
X-RM-TRANSID:2ee66aeb4ae444a-257ec
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	kuniyu@google.com,
	xeb@mail.ru,
	yana06070@163.com,
	netdev-bot+sashiko@kernel.org
Subject: [PATCH net-next v2] ip6_gre: fix changelink conflict checks for L2 tunnels
Date: Wed,  4 Nov 2026 23:10:18 +0800
Message-ID: <20261104150330.70963-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Mailer: git-send-email 2.43.0
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

ip6gre_changelink_common() calls ip6gre_tunnel_locate(), which only
looks for ARPHRD_IP6GRE devices. The same changelink helper also handles
ip6gretap and ip6erspan devices.

This lets an L2 tunnel change its parameters to match another L2 tunnel,
since the duplicate check looks for an L3 device instead. Incoming
packets can then be delivered to the wrong interface. An L3 tunnel with
matching parameters can also make a valid L2 update fail with EEXIST.

Use ip6gre_tunnel_find() with dev->type, as the newlink paths do. Skip
collect_md entries while walking the bucket: they can coexist with
ordinary tunnels with the same lookup parameters, and their uniqueness
is checked through separate per-net pointers. Keep searching past them
so that a real duplicate later in the bucket is still rejected.

Found while comparing the duplicate checks in newlink and changelink.
Confirmed with ip link commands. For example, with an IPv6 underlay
named under already configured:

  ip link add tap1 type ip6gretap local fd26:106::1 \
      remote fd26:106::2 key 100 dev under
  ip link add tap2 type ip6gretap local fd26:106::1 \
      remote fd26:106::2 key 200 dev under
  ip link set tap1 up
  ip link set tap2 up
  ip link set tap2 type ip6gretap key 100

Before the fix, the last command succeeds and received frames move from
tap1 to tap2. After the fix, it fails with EEXIST and tap2 is unchanged.
The collect_md case was raised during v1 review and confirmed with
namespace tests. The reproducers use existing interfaces without kernel
changes or fault injection.

Tested under UML with standalone namespace tests for ip6gretap and
ip6erspan, including duplicate updates, L2/L3 coexistence, IPv4/IPv6
traffic and normal updates. Additional tests cover both ordinary and
metadata creation orders, all four L2 kind combinations, a real duplicate
behind metadata, and L3 ioctl changes. They reproduce the collect_md
failure with v1 and pass with this change.

Full x86_64 W=1 builds with allmodconfig- and allyesconfig-derived
configurations also pass, with unchanged warning sets.

Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
Changes in v2:
- Target net-next and drop the Fixes and stable tags, as requested by
  Ido Schimmel.
- Skip collect_md entries during lookup to avoid rejecting valid updates
  and to find ordinary duplicates behind metadata entries.
- Extend standalone UML validation to cover ordinary/metadata ordering,
  all four L2 kind combinations, and L3 lookup paths.

v1: https://lore.kernel.org/netdev/20261028115710.27806-1-yanxia@cmss.chinamobile.com/

Runtime and build validation used net-next 7b6ab4dbc156.
Kernel selftests were not run.

The allmodconfig- and allyesconfig-derived builds had WERROR, KASAN and
KCSAN off. The allyesconfig-derived build also had KUNIT_ALL_TESTS,
MCTP_TEST and MCTP_TRANSPORT_USBLIB_TEST off. The full default-to-derived
configuration diffs and the unchanged before/after warning sets are
retained in the validation archive.

 net/ipv6/ip6_gre.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index b5d6ed8..07f7220 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -306,6 +306,9 @@ static struct ip6_tnl *ip6gre_tunnel_find(struct net *net,
 	head = __ip6gre_bucket(ign, parms);
 
 	hlist_for_each_entry(t, head, hash_node) {
+		if (t->parms.collect_md)
+			continue;
+
 		if (ipv6_addr_equal(local, &t->parms.laddr) &&
 		    ipv6_addr_equal(remote, &t->parms.raddr) &&
 		    key == t->parms.i_key &&
@@ -2055,7 +2058,7 @@ ip6gre_changelink_common(struct net_device *dev, struct nlattr *tb[],
 
 	ip6gre_netlink_parms(data, p_p);
 
-	t = ip6gre_tunnel_locate(net, p_p, 0);
+	t = ip6gre_tunnel_find(net, p_p, dev->type);
 
 	if (t) {
 		if (t->dev != dev)

base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
-- 
2.39.0.windows.2



