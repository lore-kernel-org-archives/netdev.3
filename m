Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53B83DB970
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919539; cv=none; b=M3t5t9VktdHnAK3+w/+Uo5AnZz0Dfg8jdvc4GMrSv/9VEhoBVz2FUMFgAv8nH2fkP4UnOAPMSig5zsGGKt5IjPDhD8VKbYb4SNqtOLXEwHfEsbd1YSlzm87Xtw36LUtAFQbwolyh502IreZiQFDGqGD/Ved5MRgsZYrxuqV0ud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919539; c=relaxed/simple;
	bh=X+EPNZekBjk8O1UjBxp8N7NkgDROdMdxVHHN14iCnxM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kgA4z4PFpT0JIORgBnjoFe8IlJ16hC4tAhQweiKDdZx3yFwMA+njX8E0wVbzTwoQ93EycYwApYHb33qdA1pHDV3UIPLE3i2Z3cW7COBGIlT99jDBpY8KwZoh9+qn1aOrOlHRBDdioZBUUaRpdLORWjWMsjHAnbLiAr/ZIE0WCQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=DE5dfAnE; arc=none smtp.client-ip=79.135.106.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="DE5dfAnE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785919527; x=1786178727;
	bh=jN1Wweg9m57RdYA8/4iPhPsS6+UBcGU8bXI9upTImIg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DE5dfAnEan8kgNJghmR+mngefUD6TzRZWnl+iaAWA4s7ZiTC1h26BXuzVDLmC5nPG
	 oE7qEy4/Cpjtv9yEbhSAuQyLE0MxSD8qty7NAfXWkf6tRLes6Ac/1ScxmhjOiSM+Zf
	 SLgwKJ9y2dsLM4Ih3RFP+4Ve9F/MPKnh8zhibCiG79bwxYjo6h37ouZM4lirvnl2Aw
	 m++K3KI9/HbNQiQAUSxZGxQ6cbDzHLxcBJLYbpI3L40sCpT1a/HDhSDpkNmqLCgxVE
	 F/H1Ms+Xxe9xoGi3rYjZbjgSXuiCBdgsSYIwWkxIn90USp+/Wdkf/cpP1ELRDviv2f
	 2vBaBjk8SUbPw==
Date: Wed, 05 Aug 2026 08:45:21 +0000
To: netdev@vger.kernel.org
From: Asim Viladi Oglu Manizada <manizada@pm.me>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v2] net: tun: bound receive headroom
Message-ID: <20260805084504.953162-1-manizada@pm.me>
Feedback-ID: 37265593:user:proton
X-Pm-Message-ID: 703b1233bf6f2517170602458907001583e7d07a
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

tun_get_user() uses tun->align both as skb headroom and when choosing how
much packet data to keep linear. OVS can propagate an oversized headroom
request from another port to TUN or TAP.

When align is larger than the usable space in a one-page skb head,
SKB_MAX_HEAD(align) underflows and the result becomes negative when stored
in good_linear. That value later wraps when assigned to the size_t linear
variable, and tun_alloc_skb() can place skb->data outside the allocated
head.

Bound the headroom stored by TUN to the one-page skb-head budget and the
largest non-sentinel 16-bit skb header offset. Leave one linear byte for
raw TUN and a complete Ethernet header for TAP, including NET_IP_ALIGN.

Also pull the raw-TUN protocol byte and the TAP Ethernet header before
accessing them, so these checks remain safe for nonlinear skbs supplied by
other allocation paths.

Fixes: eaea34b23c46 ("net/tun: implement ndo_set_rx_headroom")
Cc: stable@vger.kernel.org
Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
---
v2:
- bound tun->align instead of clamping good_linear to zero
- derive the bound from the one-page head, 16-bit offset, and TUN/TAP
  linear-header requirements
- pull the raw-TUN protocol byte before reading it
- make the TAP Ethernet-header pull unconditional
v1: https://lore.kernel.org/netdev/20260721014117.2234892-1-manizada@pm.me/

 drivers/net/tun.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index fed9dfdfcc3b..efd2e7d75c9a 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1107,11 +1107,16 @@ static netdev_features_t tun_net_fix_features(struc=
t net_device *dev,
 static void tun_set_headroom(struct net_device *dev, int new_hr)
 {
 =09struct tun_struct *tun =3D netdev_priv(dev);
+=09size_t max_headroom;
=20
-=09if (new_hr < NET_SKB_PAD)
-=09=09new_hr =3D NET_SKB_PAD;
+=09max_headroom =3D min_t(size_t, SKB_MAX_HEAD(0), U16_MAX - 1);
=20
-=09tun->align =3D new_hr;
+=09if ((tun->flags & TUN_TYPE_MASK) =3D=3D IFF_TAP)
+=09=09max_headroom -=3D ETH_HLEN + NET_IP_ALIGN;
+=09else
+=09=09max_headroom -=3D 1;
+
+=09tun->align =3D clamp_t(int, new_hr, NET_SKB_PAD, max_headroom);
 }
=20
 static void
@@ -1822,7 +1827,13 @@ static ssize_t tun_get_user(struct tun_struct *tun, =
struct tun_file *tfile,
 =09switch (tun->flags & TUN_TYPE_MASK) {
 =09case IFF_TUN:
 =09=09if (tun->flags & IFF_NO_PI) {
-=09=09=09u8 ip_version =3D skb->len ? (skb->data[0] >> 4) : 0;
+=09=09=09u8 ip_version;
+
+=09=09=09if (skb->len && !pskb_may_pull(skb, 1)) {
+=09=09=09=09err =3D -ENOMEM;
+=09=09=09=09goto drop;
+=09=09=09}
+=09=09=09ip_version =3D skb->len ? (skb->data[0] >> 4) : 0;
=20
 =09=09=09switch (ip_version) {
 =09=09=09case 4:
@@ -1842,7 +1853,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, s=
truct tun_file *tfile,
 =09=09skb->dev =3D tun->dev;
 =09=09break;
 =09case IFF_TAP:
-=09=09if (frags && !pskb_may_pull(skb, ETH_HLEN)) {
+=09=09if (!pskb_may_pull(skb, ETH_HLEN)) {
 =09=09=09err =3D -ENOMEM;
 =09=09=09drop_reason =3D SKB_DROP_REASON_HDR_TRUNC;
 =09=09=09goto drop;
--=20
2.53.0

