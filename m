Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AA03BE15F
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715258; cv=none; b=BnrJxlcgo8znKHhWjqgndFJ3Rbh06ktc4GVsOF35Gw13XmZ48VZOInPqXp0V0YWPQ8IXpkTHXvaJEPG6giHHChL8C6RJ2vglLaFCP0wN/cFvNUiANThNUKojteD3mVrxrBvPIHxRR/gyJvE2viRurzg1GZcGvtSzdoqHrNpw32A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715258; c=relaxed/simple;
	bh=GJoMmBn9Oi9io7Yol7ATtJgGPgDeuXlfq96smDlYEwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBwrT4okwZVq1XPiN8PG0Qu/cUt/JJyjRm4kc6iHuLCPr7g0wy5F7fYF7+Gaw0363UsyNz31E7yhqi/gBAWJS0bw6z8W8psM0rPpZ4ck9dptNJgZ0OuGeqQ89UJWMcKW1MM9ifp4N+k6VSM5/y1N4Yo5SYX1eQe9rlNisXTihLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=K5BNNm4M; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=ZH0rRjrH; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="K5BNNm4M";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="ZH0rRjrH"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=K5BNNm4MJUCjxlBcAIAzwI6OnkTmEglz73SOgXmR0NU5YG4voFbtgcfSlJZlDYs/1QRjouBLTsuffFxOIIefaaaQbx7uGchYJDwLsRW+w59eu5y7+he2Oyl9A53vd+1sN+7jxzPfyeVj6n5TdOI9oD6H5czDMi60952jbT4XIVlYWgtiHuq55gQ+dm2werbLJTr+WjGBi6SRLOhbybIiv+qjf8z4wTwBeeKG4rQawdUvZ3AWUy2eXbFjE7nkRs1cYmSlOfiFqbrOoaGCsddeozinLmhe1SWEiAHlflChhlb8pTXppfpp0AijxJMnKNJM5jHTc2Ztvgreb8984ldTRA==; s=purelymail3; d=tinyisr.com; v=1; bh=GJoMmBn9Oi9io7Yol7ATtJgGPgDeuXlfq96smDlYEwA=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=ZH0rRjrHj7sNrWjCklcnYOVLcVCoRObIDk/MKYons6VHI2u6DziJInwpjwUMb/U3mMJv1uQDXjsKdIZAxb+tdM7QtN95mM202132ONKPD3zShifFkgAk8H9YEddvSVnwjWrwd0sBuqh0e06MLpiylKEPXPX7m0qLf6K6D6SdkLZHKypkXXJrX6mKDCmlK0LWGeNXZIz7LPy4XPP0IxP1d97ErVtmU3ic2AxOfmNnw9BXyRypPMIsrx7TzpOT0qpxCPKFg0mhaeIZgB45JmavkHHstRAkA8S9hqhY9GgcXHjYQ/xP5E7EF4m8vQsEmwQhk2J8Fd5h4+YeKExoG6I+zg==; s=purelymail3; d=purelymail.com; v=1; bh=GJoMmBn9Oi9io7Yol7ATtJgGPgDeuXlfq96smDlYEwA=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1438868657;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 06 Sep 2026 17:20:49 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH net-next v1 5/6] net: dsa: tag: mt7628: add VLAN awareness support
Date: Sun,  6 Sep 2026 20:16:24 +0300
Message-ID: <20260906171625.533915-6-joey@tinyisr.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906171625.533915-1-joey@tinyisr.com>
References: <20260906171625.533915-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Support VLAN-aware bridges in the MT7628 tagger.

VLAN-aware bridge traffic already contains the VLAN tag used for
forwarding, so modify the TPID to contain the destination port mask
instead of adding a new tag.

On receive, strip the MT7628 tag, use the VID to find the source port if
the switch reports port 0 on VLAN-aware traffic, then restore the VLAN
tag as a hardware-accelerated VLAN tag.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
 net/dsa/tag_mt7628.c | 62 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 12 deletions(-)

diff --git a/net/dsa/tag_mt7628.c b/net/dsa/tag_mt7628.c
index fab9d4f04b7a..7c71e8b08648 100644
--- a/net/dsa/tag_mt7628.c
+++ b/net/dsa/tag_mt7628.c
@@ -6,6 +6,7 @@
=20
 #include <linux/etherdevice.h>
 #include <linux/dsa/8021q.h>
+#include <linux/if_vlan.h>
 #include <net/dsa.h>
=20
 #include "tag.h"
@@ -15,13 +16,16 @@
  * On TX the lower 6 bits encode the destination port bitmask.
  * On RX the lower 3 bits encode the source port number.
  *
- * The switch hardware will not modify the TPID of an incoming packet if i=
t is
- * already VLAN tagged. To work around this the switch is configured to al=
ways
- * append a tag_8021q standalone VLAN tag for each port. That means we can
- * safely strip the outer VLAN tag after parsing it.
+ * The switch can only use VLANs for forwarding control. VLAN-unaware brid=
ges
+ * are simulated using tag_8021q and double tagging, while VLAN-aware brid=
ges
+ * use the VLANs configured by the bridge directly.
  *
- * A VLAN tag is constructed on egress to target the standalone or bridge
- * VLAN and destination port.
+ * On egress, the tagger either adds a new MT7628 tag that contains the
+ * standalone or bridge tag_8021q VLAN and destination port mask, or modif=
ies
+ * an existing VLAN tag to contain the destination port mask.
+ *
+ * On ingress, the VLAN tag is restored after stripping the MT7628 tag, if=
 it
+ * is not a tag_8021q VLAN.
  */
=20
 #define MT7628_TAG_NAME "mt7628"
@@ -34,10 +38,25 @@ static struct sk_buff *mt7628_tag_xmit(struct sk_buff *=
skb,
 =09=09=09=09       struct net_device *dev)
 {
 =09struct dsa_port *dp;
+=09u16 xmit_tpid;
 =09u16 xmit_vlan;
 =09__be16 *tag;
=20
+=09xmit_tpid =3D
+=09    ETH_P_8021Q | FIELD_PREP(MT7628_TAG_TX_PORT,
+=09=09=09=09     dsa_xmit_port_mask(skb, dev));
 =09dp =3D dsa_user_to_port(dev);
+=09if (skb->offload_fwd_mark &&
+=09    br_vlan_enabled(dsa_port_bridge_dev_get(dp))) {
+=09=09/*
+=09=09 * On VLAN aware ports only modify the TPID to contain the
+=09=09 * MT7628 egress port metadata, instead of adding a new vlan tag
+=09=09 */
+=09=09tag =3D dsa_etype_header_pos_tx(skb);
+=09=09tag[0] =3D htons(xmit_tpid);
+=09=09return skb;
+=09}
+
 =09xmit_vlan =3D skb->offload_fwd_mark ?
 =09    dsa_tag_8021q_bridge_vid(dsa_port_bridge_num_get(dp)) :
 =09    dsa_tag_8021q_standalone_vid(dp);
@@ -47,9 +66,7 @@ static struct sk_buff *mt7628_tag_xmit(struct sk_buff *sk=
b,
=20
 =09tag =3D dsa_etype_header_pos_tx(skb);
=20
-=09tag[0] =3D htons(ETH_P_8021Q |
-=09=09       FIELD_PREP(MT7628_TAG_TX_PORT,
-=09=09=09=09  dsa_xmit_port_mask(skb, dev)));
+=09tag[0] =3D htons(xmit_tpid);
 =09tag[1] =3D htons(xmit_vlan);
=20
 =09return skb;
@@ -58,7 +75,10 @@ static struct sk_buff *mt7628_tag_xmit(struct sk_buff *s=
kb,
 static struct sk_buff *mt7628_tag_rcv(struct sk_buff *skb,
 =09=09=09=09      struct net_device *dev)
 {
+=09unsigned int source_port;
+=09bool is_dsa_8021q;
 =09__be16 *phdr;
+=09u16 tci, vid;
=20
 =09if (unlikely(!pskb_may_pull(skb, MT7628_TAG_LEN))) {
 =09=09kfree_skb(skb);
@@ -66,9 +86,23 @@ static struct sk_buff *mt7628_tag_rcv(struct sk_buff *sk=
b,
 =09}
=20
 =09phdr =3D dsa_etype_header_pos_rx(skb);
-=09skb->dev =3D
-=09    dsa_conduit_find_user(dev, 0,
-=09=09=09=09  FIELD_GET(MT7628_TAG_RX_PORT, ntohs(*phdr)));
+=09source_port =3D FIELD_GET(MT7628_TAG_RX_PORT, ntohs(*phdr));
+=09tci =3D ntohs(phdr[1]);
+=09vid =3D tci & VLAN_VID_MASK;
+=09is_dsa_8021q =3D vid_is_dsa_8021q(vid);
+
+=09/*
+=09 * The source port info is only encoded in the TPID field for packets
+=09 * where the VLAN tag is inserted by the PVID mechanism. With VLAN
+=09 * filtering enabled, VLAN-tagged ingress packets appear as if they're
+=09 * originating on port 0. Use the VID to identify the bridge port in
+=09 * this case.
+=09 */
+=09if (source_port =3D=3D 0 && !is_dsa_8021q)
+=09=09skb->dev =3D dsa_find_designated_bridge_port_by_vid(dev, vid);
+=09else
+=09=09skb->dev =3D dsa_conduit_find_user(dev, 0, source_port);
+
 =09if (!skb->dev) {
 =09=09kfree_skb(skb);
 =09=09return NULL;
@@ -77,6 +111,10 @@ static struct sk_buff *mt7628_tag_rcv(struct sk_buff *s=
kb,
 =09skb_pull_rcsum(skb, MT7628_TAG_LEN);
 =09dsa_strip_etype_header(skb, MT7628_TAG_LEN);
 =09dsa_default_offload_fwd_mark(skb);
+
+=09if (!is_dsa_8021q)
+=09=09__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), tci);
+
 =09return skb;
 }
=20
--=20
2.55.0

