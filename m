Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3459E3BD63C
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715252; cv=none; b=JKjHdL7s7cawUi6ercp7j54TQVqnpqBW+pwHxqHBeGLOVg/1+j+/U72ot0y/KuYlWZQ9IgcSF96vpVaApoQuGInNm+SWxKwlWfcrDlzic7vYhLV9Uq00YPXq10HHLLcpUhkvSBgvEVEsECA0+OpEFehZOWBIHwN7abwoGTWzBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715252; c=relaxed/simple;
	bh=Jt15uicWggtMSBlcqHuCe/J/+1zTBYlTpej9DpQs2ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNpNPjeZcR8wg0cjc+wsJtNrdgdrKE4SJrqP7OGGjwpKUXqcqkKODXKLECs4tjeJDACxraTZ4Ez6FhOMWH1IOtBJCgHwAdxr/8zwCoQxa4LjUwW4Ria8j8AfT09Q2x4tXpBB5PVdnAJh5lZVnNC7MAFhJcFcwV1oQ9L289M13Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=KP4NEzcj; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=CROonuJP; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="KP4NEzcj";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="CROonuJP"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=KP4NEzcjzJUg2WefImS7Es/Eze/GH7EKvH3jZXJ5IfzcJIh/yRI2xocN+v0inziv0pmiDJp3FggQTr8Kw/p7oEyxhKApFfmoUJLR/TCGEE5uA2IGgK3cMIGYiU4EczDsxyki0rElZ1wi1IflNFFce8+TB5mw1hcGyOpc1EJD7LWU/Sd/971xpIlm/lWOQotTgxVn8Plvw/uYTZV9vEHfcbStheuO80xa6RoAsaZNThD4v1IbO9ntEqZv9xvUvoNQ2bjb8VbriYOrDMFdipJGh4r4c9+IanHzK06SZPBFDuPC41S2AewMgK7ZNGG/DPcsBdxcGTnkmmkjKg2qzEhYNQ==; s=purelymail3; d=tinyisr.com; v=1; bh=Jt15uicWggtMSBlcqHuCe/J/+1zTBYlTpej9DpQs2ck=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=CROonuJPzYyIP/z6Iv5Nk+AKEXLEljbGKRksBDkr3qCmcVSX6tMAcvGVMh+fR7EHDw25shuzCP7cnAErEgaRwQgYgHOJXhBAeo8jhoS1lyvZ1RThzvvWE5HavLoCyGwAN2FeN+YDphmBmL7Vax6DSvcwHBTBstdw2DGg3ncSOcMCO/zThNTv1ur3PMj02tzkfiPPz5mUAyvEfszOVpeOh71H5+kXzv0PSqcHx6Ol93Ug/X4kQCui/2D5jVc1BtGHEOtcDTjbLI85YdkZEXnnljek1kYMVdAJMfNmp4KlOSzB31McV5bsCa8A4VQEMhWrpTWkVKYRi5FgtHaBNb3ceg==; s=purelymail3; d=purelymail.com; v=1; bh=Jt15uicWggtMSBlcqHuCe/J/+1zTBYlTpej9DpQs2ck=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1438868657;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 06 Sep 2026 17:20:40 +0000 (UTC)
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
Subject: [PATCH net-next v1 1/6] net: dsa: mt7628: rework vlan block allocator
Date: Sun,  6 Sep 2026 20:16:20 +0300
Message-ID: <20260906171625.533915-2-joey@tinyisr.com>
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

Rework the VLAN hardware entry allocator to allow reserving entries for
tag_8021q bridge/isolation use. This is prerequisite work for VLAN
filtering support.

6 VLAN table entries are reserved for tag_8021q use and the rest are
left for the upcoming VLAN filtering support. No functional change
intended.

The active property is removed from VLAN entries in favor of vid =3D=3D 0,
since tag_8021q VIDs cannot be 0.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
 drivers/net/dsa/mt7628.c | 160 +++++++++++++++++++++++++--------------
 1 file changed, 104 insertions(+), 56 deletions(-)

diff --git a/drivers/net/dsa/mt7628.c b/drivers/net/dsa/mt7628.c
index fb63f6f644b9..990556cc2f65 100644
--- a/drivers/net/dsa/mt7628.c
+++ b/drivers/net/dsa/mt7628.c
@@ -138,6 +138,7 @@
 #define MT7628_ESW_PORTS_CPU BIT(6)
 #define MT7628_ESW_PORTS_ALL GENMASK(6, 0)
=20
+#define MT7628_ESW_NUM_USER_PORTS 5
 #define MT7628_ESW_NUM_PORTS 7
 #define MT7628_NUM_VLANS 16
=20
@@ -151,8 +152,14 @@ static const struct regmap_config mt7628_esw_regmap_cf=
g =3D {
 =09.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
 };
=20
+enum {
+=09MT7628_VLAN_TYPE_AWARE,
+=09MT7628_VLAN_TYPE_UNAWARE,
+=09MT7628_VLAN_TYPE_NUM,
+};
+
 struct mt7628_vlan {
-=09bool active;
+=09unsigned int type;
 =09u8 members;
 =09u8 untag;
 =09u16 vid;
@@ -383,6 +390,82 @@ static void mt7628_esw_set_vub(struct mt7628_esw *esw,=
 unsigned int vlan,
 =09=09=09   MT7628_ESW_VUB_PREP(vlan, vub));
 }
=20
+static struct mt7628_vlan *mt7628_find_vlan_block(struct dsa_switch *ds,
+=09=09=09=09=09=09  u16 vid, unsigned int type)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+=09struct mt7628_vlan *vlan;
+=09int i;
+
+=09for (i =3D 0; i < MT7628_NUM_VLANS; i++) {
+=09=09vlan =3D &esw->vlans[i];
+=09=09if (vlan->vid =3D=3D vid && vlan->type =3D=3D type)
+=09=09=09return vlan;
+=09}
+=09return NULL;
+}
+
+static struct mt7628_vlan *mt7628_alloc_vlan_block(struct dsa_switch *ds,
+=09=09=09=09=09=09   u16 vid, unsigned int type)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+=09struct mt7628_vlan *vlan;
+=09int i;
+
+=09for (i =3D 0; i < MT7628_NUM_VLANS; i++) {
+=09=09vlan =3D &esw->vlans[i];
+=09=09if (vlan->vid)
+=09=09=09continue;
+=09=09if (vlan->type !=3D type)
+=09=09=09continue;
+=09=09vlan->vid =3D vid;
+=09=09return vlan;
+=09}
+
+=09return NULL;
+}
+
+static int mt7628_port_join_vlan_block(struct dsa_switch *ds, int port, u1=
6 vid,
+=09=09=09=09       unsigned int type, u16 flags)
+{
+=09struct mt7628_vlan *vlan =3D mt7628_find_vlan_block(ds, vid, type);
+=09struct mt7628_esw *esw =3D ds->priv;
+
+=09if (!vlan)
+=09=09vlan =3D mt7628_alloc_vlan_block(ds, vid, type);
+
+=09if (!vlan)
+=09=09return -ENOSPC;
+
+=09vlan->members |=3D BIT(port);
+=09if (flags & BRIDGE_VLAN_INFO_PVID)
+=09=09esw->tag_8021q_pvid[port] =3D vid;
+=09if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
+=09=09vlan->untag |=3D BIT(port);
+=09return 0;
+}
+
+static int mt7628_port_leave_vlan_block(struct dsa_switch *ds, int port,
+=09=09=09=09=09u16 vid, unsigned int type)
+{
+=09struct mt7628_vlan *vlan =3D mt7628_find_vlan_block(ds, vid, type);
+=09struct mt7628_esw *esw =3D ds->priv;
+
+=09if (!vlan)
+=09=09return -ENOENT;
+
+=09if (esw->tag_8021q_pvid[port] =3D=3D vid)
+=09=09esw->tag_8021q_pvid[port] =3D 0;
+=09vlan->members &=3D ~BIT(port);
+=09vlan->untag &=3D ~BIT(port);
+=09/*
+=09 * Free the vlan if we're the last member of it.
+=09 */
+=09if (!vlan->members)
+=09=09vlan->vid =3D 0;
+=09return 0;
+}
+
 static void mt7628_vlan_sync(struct dsa_switch *ds)
 {
 =09struct mt7628_esw *esw =3D ds->priv;
@@ -425,6 +508,17 @@ static int mt7628_setup(struct dsa_switch *ds)
 =09if (ret)
 =09=09return ret;
=20
+=09/*
+=09 * Dedicate the first num_user_ports + 1 VLAN slots for tag_8021q.
+=09 * Since bridges are only offloaded when they have at least one member
+=09 * port, the worst case entry requirement is 1 per port. The extra slot
+=09 * is needed because when changing the configuration, tag_8021q adds a
+=09 * new VLAN before removing the old one. The rest of the VLAN slots can
+=09 * be used for filtering.
+=09 */
+=09for (int i =3D 0; i < MT7628_ESW_NUM_USER_PORTS + 1; i++)
+=09=09esw->vlans[i].type =3D MT7628_VLAN_TYPE_UNAWARE;
+
 =09rtnl_lock();
 =09ret =3D dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));
 =09rtnl_unlock();
@@ -479,67 +573,21 @@ static void mt7628_phylink_get_caps(struct dsa_switch=
 *ds, int port,
 static int mt7628_dsa_8021q_vlan_add(struct dsa_switch *ds, int port,
 =09=09=09=09     u16 vid, u16 flags)
 {
-=09struct mt7628_esw *esw =3D ds->priv;
-=09struct mt7628_vlan *vlan =3D NULL;
-=09int i;
-
-=09for (i =3D 0; i < MT7628_NUM_VLANS; i++) {
-=09=09struct mt7628_vlan *check_vlan =3D &esw->vlans[i];
-
-=09=09if (!check_vlan->active && !vlan)
-=09=09=09vlan =3D check_vlan;
-
-=09=09if (check_vlan->active && check_vlan->vid =3D=3D vid) {
-=09=09=09vlan =3D check_vlan;
-=09=09=09break;
-=09=09}
-=09}
-
-=09if (!vlan)
-=09=09return -ENOSPC;
-
-=09vlan->vid =3D vid;
-=09vlan->active =3D true;
-=09vlan->members |=3D BIT(port);
-
-=09if (flags & BRIDGE_VLAN_INFO_PVID)
-=09=09esw->tag_8021q_pvid[port] =3D vid;
-
-=09if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
-=09=09vlan->untag |=3D BIT(port);
-
+=09int ret =3D
+=09    mt7628_port_join_vlan_block(ds, port, vid, MT7628_VLAN_TYPE_UNAWARE=
,
+=09=09=09=09=09flags);
+=09if (ret)
+=09=09return ret;
 =09mt7628_vlan_sync(ds);
 =09return 0;
 }
=20
 static int mt7628_dsa_8021q_vlan_del(struct dsa_switch *ds, int port, u16 =
vid)
 {
-=09struct mt7628_esw *esw =3D ds->priv;
-=09struct mt7628_vlan *vlan =3D NULL;
-=09int i;
-
-=09for (i =3D 0; i < MT7628_NUM_VLANS; i++) {
-=09=09struct mt7628_vlan *check_vlan =3D &esw->vlans[i];
-
-=09=09if (!check_vlan->active || check_vlan->vid !=3D vid)
-=09=09=09continue;
-=09=09vlan =3D check_vlan;
-=09=09break;
-=09}
-=09if (!vlan)
-=09=09return -ENOENT;
-
-=09if (esw->tag_8021q_pvid[port] =3D=3D vid)
-=09=09esw->tag_8021q_pvid[port] =3D 0;
-
-=09vlan->members &=3D ~BIT(port);
-=09vlan->untag &=3D ~BIT(port);
-
-=09if (!vlan->members) {
-=09=09vlan->active =3D false;
-=09=09vlan->vid =3D 0;
-=09}
-
+=09int ret =3D mt7628_port_leave_vlan_block(ds, port, vid,
+=09=09=09=09=09       MT7628_VLAN_TYPE_UNAWARE);
+=09if (ret)
+=09=09return ret;
 =09mt7628_vlan_sync(ds);
 =09return 0;
 }
--=20
2.55.0

