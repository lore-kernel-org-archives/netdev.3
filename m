Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECAD2BE034
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497729; cv=none; b=PhklGENqjitOOyZ0dFC9u4pCydTHIdQil5EAYLqk52ahHEcu9L2WK+nQFSWqbWxSYvv60yiPVcv8YXjfsWUeT8fkOnA+YmRyrgrlhDzWmdWTFYUgwww3RKUAeQ9dbfRaQy4qq8F9eBcX4WbiKCsgbqzs4CQa6DW3dipdA6YFW18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497729; c=relaxed/simple;
	bh=gYlhmSf4tROSUDcRrSPz3ee6KFj8d65GsOhOxvWSRDU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BfIjHubLIJqosR6FGW5cj1FzyEW4dc9/C6JJCNYOSXbFIWEf9/TRIADKlu5tn5K39DNIRqO8h6L/PKFLofDUvdYtxuGbF60haJuOMa0FqUeBY+iMVOVKG7S0ZmYfd/KmtUXuatkIeprU+e2djfiysXtPeQeq5FtQFH89Ka/Thhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=jqrA8Muy; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="jqrA8Muy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1786497719; x=1786756919;
	bh=OT5ODuDh76ExRBcS6W+voYYu/MlAm4v68AtFiiHdSrM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jqrA8MuyEw+5vpS6Nr7OPNcpEGwh+6Uw1oRtUr09GOQ+yO/nc7TILeJ+o7G/GEw/K
	 BR3/PKBvpjsNxfmY6zV/EXvG6mH35/SAELUPSifo07KffG37iFXdwVsXdXC0pWa8dM
	 TPB3Jci7ObANB4w6uViODt8D/jOjNzk7oVVU55eCUHgwDXYZF5OR1n4IgJH6Fnp5fj
	 XDM7QNtNqCbXw+iusBN3eYhn5b6rTZzfiO3CJ/4zLimoYNyoMRT9egvOi92LPo9Hji
	 QywBMAk/1dyKi13ePq9iob4g+ptGi2g4ZxSGDG8vuGQuAspJnXgUNmNJl7PUPAH334
	 cGgLaSoA8ipZA==
Date: Wed, 12 Aug 2026 01:21:53 +0000
To: netdev@vger.kernel.org
From: Asim Viladi Oglu Manizada <manizada@pm.me>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v3] net: tun: bound receive headroom
Message-ID: <20260812012139.2134643-1-manizada@pm.me>
Feedback-ID: 37265593:user:proton
X-Pm-Message-ID: 1651772f322ce46d836dd22561d97ded9db0e281
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
v3:
- simplify the raw-TUN pull check and reject short packets with -EINVAL
v2: https://lore.kernel.org/netdev/20260805084504.953162-1-manizada@pm.me/
- bound tun->align instead of clamping good_linear to zero
- derive the bound from the one-page head, 16-bit offset, and TUN/TAP
  linear-header requirements
- pull the raw-TUN protocol byte before reading it
- make the TAP Ethernet-header pull unconditional
v1: https://lore.kernel.org/netdev/20260721014117.2234892-1-manizada@pm.me/

 drivers/net/tun.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index fed9dfdfcc3b..5bbe3123979e 100644
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
+=09=09=09if (!pskb_may_pull(skb, 1)) {
+=09=09=09=09err =3D -EINVAL;
+=09=09=09=09goto drop;
+=09=09=09}
+=09=09=09ip_version =3D skb->data[0] >> 4;
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


