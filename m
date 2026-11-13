Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553525;
	b=wkXs4c6KlbdBTRkbQRr6d5A42qoixU9Bm0Nlh9TH5rUw+WukfkFbKRfIM8w/XZsp4oMK
	 wsgHr9vqkIMtFW1JsPAUAvyQsU0qzZ1z4gQAP1cjQeg92sVeMP2u7vDeB2ResOy4roTmN
	 vS2y0lVR9VcwAaUn0rK7OQ1aQVFXFSrU8EZRGRH1/lk/ERWiQ5cUr0Xlf5W40thv2aUw8
	 21RuQLZJ8LPRWjhWfF3TSs3GNfsc9N9GPwcPEcc2MdDV2MgA1h4HZ5ht+BEchmYx1qWdq
	 OE3IL1clokq49NH8HkYQUUfsN1kaVYF8wF4GaoKIQ0NjnjxAyfyiyuu4+rCgHSWn1zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553525;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Date:Message-ID;
	bh=PL2JrQrlFCZkPDlSoBfHNnVP+PHI384lIjGURt26NKY=;
	b=dkjxVwj3Han8EtxomsYsgB9pe5ZPqlAUzwgNWwBlYD8jKN7YSLuzJug1cQVNuHvtSHeQ
	 /af3EjPczZGxaIYFXpN8OtK7EW9o0TwMsvF5G//mEN4mDEpTlJ08qMGUW7plJfe4qW9bo
	 YK/1RGaTuixv2S0REuLofjYW4iMW+Raaf2+Aictga2FVT1/VQRv+HKE3QUUFYGngrfuWr
	 6Jk4ANGlW030h1pMmg1X5TqvolUx5qjOkS3nLZzegxiNelW9tunvTFoHC+OyvXiiJJfMZ
	 FFtHTeKt1+VQTQIrUMStcixwtZW2YK2LV2jCBkxSf5A3dAnpC3GD/JboPvDPeM5sMBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=dZs+UKLK;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908BD606A882;
	Fri, 13 Nov 2026 07:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 908BD606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=dZs+UKLK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=dZs+UKLKx+GGQ9ZfipaY7BmrMPy+PSlxKvealr0KCY2mGcABMir3FpOQHgXQhZBxk/PcLi1bzPyIJ
	 eIl5Kbg7GEO2lLZhfcK0pHuxAt7D6TXCOxXf0Aaew08YtaOCu5w+NZplvBYvuWBt6HJlmaWpHM3KT9
	 AR/N4AySI1eTGoWI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af6b6aff86-e66ec;
	Fri, 13 Nov 2026 15:05:20 +0800 (CST)
X-RM-TRANSID:2ee56af6b6aff86-e66ec
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [198.18.0.35] (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af6b6ae209-1aa50;
	Fri, 13 Nov 2026 15:05:19 +0800 (CST)
X-RM-TRANSID:2ee36af6b6ae209-1aa50
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
Subject: [PATCH net-next v3] ip6_gre: fix changelink conflict checks for L2
 tunnels
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Fri, 13 Nov 2026 15:05:02 +0800
Message-ID: <179455350258.84965.17518172977020586093.ip6gre-v3@cmss.chinamobile.com>

ip6gre_changelink_common() calls ip6gre_tunnel_locate(), which only looks
for ARPHRD_IP6GRE devices. For ip6gretap and ip6erspan, this lets an
update create a duplicate L2 tunnel or makes a valid update fail because
of an unrelated L3 tunnel. A duplicate can receive traffic intended for
the original tunnel.

Use ip6gre_tunnel_find() with dev->type for ordinary devices. A match on
another device, including a metadata device, remains a conflict. For
metadata devices, update the device itself without the ordinary
duplicate search, as newlink does. Leave the shared find helper,
newlink, legacy ioctls and receive lookup unchanged.

Check conflicts and unregistering before applying encapsulation
parameters, so these rejected requests leave the encapsulation unchanged.

Found during code review of the newlink and changelink duplicate checks.
Reproduced under UML with an IPv6 underlay named under:

  ip link add tap1 type ip6gretap local fd26:106::1 \
      remote fd26:106::2 key 100 dev under
  ip link add tap2 type ip6gretap local fd26:106::1 \
      remote fd26:106::2 key 200 dev under
  ip link set tap1 up
  ip link set tap2 up
  ip link set tap2 type ip6gretap key 100

Before the fix, the last command succeeds and received frames move from
tap1 to tap2. With the fix, it fails with EEXIST and tap2 is unchanged.
Custom UML tests covered both L2 kinds, metadata updates with ip6gre0
present, receive interfaces and tunnel metadata, legacy ioctls, and
encapsulation state after a rejected update.

Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
Changes in v3:
- Keep the shared ip6gre_tunnel_find() unchanged, including metadata
  matches, so newlink and legacy ioctls keep their existing behavior.
- Skip the ordinary duplicate search when updating a metadata device,
  as suggested by Jakub.
- Reject an ordinary update that matches another device, including a
  metadata device, without changing receive lookup or allowing new
  same-key combinations.
- Check conflicts and unregistering before changing encapsulation.

v2: https://lore.kernel.org/netdev/20261104150330.70963-1-yanxia@cmss.chinamobile.com/
Review: https://lore.kernel.org/netdev/20261110205838.2246603-1-kuba@kernel.org/

Tested on net-next c88fd6989aea9237a60a4859139a265bfb7ddc0b with
W=1 UML builds of the baseline and this patch. Runtime checks used
custom netlink, ioctl and packet tests; kernel selftests were not run.

 net/ipv6/ip6_gre.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index b5d6ed8..0a113bc 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2046,28 +2046,25 @@ ip6gre_changelink_common(struct net_device *dev, struct nlattr *tb[],
 	if (dev == ign->fb_tunnel_dev)
 		return ERR_PTR(-EINVAL);
 
-	if (ip6gre_netlink_encap_parms(data, &ipencap)) {
-		int err = ip6_tnl_encap_setup(nt, &ipencap);
-
-		if (err < 0)
-			return ERR_PTR(err);
-	}
-
 	ip6gre_netlink_parms(data, p_p);
 
-	t = ip6gre_tunnel_locate(net, p_p, 0);
-
-	if (t) {
-		if (t->dev != dev)
+	if (!nt->parms.collect_md) {
+		t = ip6gre_tunnel_find(net, p_p, dev->type);
+		if (t && t->dev != dev)
 			return ERR_PTR(-EEXIST);
-	} else {
-		t = nt;
 	}
 
-	if (ip6gre_tunnel_unregistering(t))
+	if (ip6gre_tunnel_unregistering(nt))
 		return ERR_PTR(-ENODEV);
 
-	return t;
+	if (ip6gre_netlink_encap_parms(data, &ipencap)) {
+		int err = ip6_tnl_encap_setup(nt, &ipencap);
+
+		if (err < 0)
+			return ERR_PTR(err);
+	}
+
+	return nt;
 }
 
 static int ip6gre_changelink(struct net_device *dev, struct nlattr *tb[],

base-commit: c88fd6989aea9237a60a4859139a265bfb7ddc0b


