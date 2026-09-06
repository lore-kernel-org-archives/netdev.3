Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F33BD65D
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715252; cv=none; b=cdUzyo647LkI10NKxzoFBtIJNb/cBxLyQkwdhColumTZYGcQZ2CDGUXNqqkHQpfLUiRjteGwsLxUXV3eYBhMHHfmtbgwphUZ+F4JdKF3YogNqGXsyvU3cCGYJl6WmZj5IiRlE33K02P/3dZ6xHauwwsbkQuTHlp/ViMG9yF/KMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715252; c=relaxed/simple;
	bh=UbWacXeVF5BHCHSULh20JI9X2WdBrzrx6zK1yP8r73I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYsTET+/uCWEzlXKnpm44Y91LCdYEo0LAYsaSAONVL5RsqMJhePHWbHXE9DKC/3cGH/N69RQLSjRBDx06vsFzeozeaSyiFkmm/Ir1DXn8qNEVQnY3ZaVW4lZqaqSo4ZdlzUkPxbZMuIydP+aQgB439Mfdk676g/Xi4sRSaaoYco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=U5iDoGcB; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=UTybvwXL; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="U5iDoGcB";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="UTybvwXL"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=U5iDoGcBh2IxeJggGSfJj3h2S+MS0SJvMR01PQnPLviTPpHCYMxiHRGyJht3hcLTZ6WFVqI0o/QDkho/C1pWfSFkGIfgNJho9Ag7GpbJuIR66b0S07K5yUcY5XCfP89Na29wnkKixqc3GTGgHQWPlV+NDchjVDvlzveRadDLXaXjgc5WxaF0Qb8L7obozasC4v1MEMTlpd/pa+6dFeggbpFBPFysYCV+6tzI5hDkZLI6YUV8VfqqLhdRmekArkO+/oVnXr43Pb7jYg1N22wvmTtBhlsFbVFnF7zDrpJRDJaXCQBcmJAbEzMZWFufRUgdKNHFcj+5EjOsgBs24ywNSg==; s=purelymail3; d=tinyisr.com; v=1; bh=UbWacXeVF5BHCHSULh20JI9X2WdBrzrx6zK1yP8r73I=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=UTybvwXLy+J+auwGEEPYSpx5F51/s4B9Sb3GEBRbPpx30s32vrFs9Vasf1ohyLgJmv1zBC7QW6ND7v1+zjrQzVpkyjKj0F0QIJrUnM/gH9oE0nuBnyHjCMCfkFbBvuTYcmFA1FeBTnyRemNZLdvo1uMwLlVfQwkD5oUOToiX+4xnH5QHS3kY8H3ZtM5qPF2+FmJqvJg6mByKkajd2wAkp8RFlxufjSaKSghgG+j71IPZ8l8rNpKuU66rPomiCvPtARczjkgXQZiXn0YG31cGan8OKSLiTj+vNlHgbhBGQyTuE72y5ET/lGyj3lyZIs9KXIa7bDoV5XWljzmSDVKgew==; s=purelymail3; d=purelymail.com; v=1; bh=UbWacXeVF5BHCHSULh20JI9X2WdBrzrx6zK1yP8r73I=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1438868657;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 06 Sep 2026 17:20:46 +0000 (UTC)
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
Subject: [PATCH net-next v1 4/6] net: dsa: mt7628: add VLAN filtering support
Date: Sun,  6 Sep 2026 20:16:23 +0300
Message-ID: <20260906171625.533915-5-joey@tinyisr.com>
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

Add support for VLAN filtering to the MT7628's built-in switch.

The only way to control forwarding on this switch is through VLANs.
Bridges and VLANs are represented by the same hardware, programmed
differently.

VLAN membership for tag_8021q and user-requested VLANs is stored in
software, but membership is only programmed for one type of VLAN, based
on port VLAN filtering state. If VLAN filtering is enabled on a port, it
is programmed only into "VLAN_AWARE" VLANs and double-tag is disabled.
Otherwise it is programmed into "VLAN_UNAWARE" VLANs and double-tag is
enabled to simulate VLAN-unaware bridge behaviour.

The primary limitation is that a VID must not be common between separate
bridges, as that would allow forwarding between bridge ports of separate
bridges. This means we can't use tag_8021q VIDs or VLANs used on other
bridges. This is checked in mt7628_port_vlan_add.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
 drivers/net/dsa/mt7628.c | 122 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 114 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/mt7628.c b/drivers/net/dsa/mt7628.c
index 7eabfad3e114..629dbf968a17 100644
--- a/drivers/net/dsa/mt7628.c
+++ b/drivers/net/dsa/mt7628.c
@@ -174,9 +174,10 @@ struct mt7628_esw {
 =09struct reset_control *rst_esw;
 =09struct regmap *regmap;
 =09struct dsa_switch *ds;
-=09u16 tag_8021q_pvid[MT7628_ESW_NUM_PORTS];
+=09u16 pvid[MT7628_VLAN_TYPE_NUM][MT7628_ESW_NUM_PORTS];
 =09struct mt7628_vlan vlans[MT7628_NUM_VLANS];
 =09struct device *dev;
+=09u8 vlan_filtering;
 };
=20
 static int mt7628_mii_read(struct mii_bus *bus, int port, int regnum)
@@ -442,10 +443,16 @@ static int mt7628_port_join_vlan_block(struct dsa_swi=
tch *ds, int port, u16 vid,
 =09=09return -ENOSPC;
=20
 =09vlan->members |=3D BIT(port);
+
 =09if (flags & BRIDGE_VLAN_INFO_PVID)
-=09=09esw->tag_8021q_pvid[port] =3D vid;
+=09=09esw->pvid[type][port] =3D vid;
+=09else if (esw->pvid[type][port] =3D=3D vid)
+=09=09esw->pvid[type][port] =3D 0;
+
 =09if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
 =09=09vlan->untag |=3D BIT(port);
+=09else
+=09=09vlan->untag &=3D ~BIT(port);
 =09return 0;
 }
=20
@@ -458,8 +465,8 @@ static int mt7628_port_leave_vlan_block(struct dsa_swit=
ch *ds, int port,
 =09if (!vlan)
 =09=09return -ENOENT;
=20
-=09if (esw->tag_8021q_pvid[port] =3D=3D vid)
-=09=09esw->tag_8021q_pvid[port] =3D 0;
+=09if (esw->pvid[type][port] =3D=3D vid)
+=09=09esw->pvid[type][port] =3D 0;
 =09vlan->members &=3D ~BIT(port);
 =09vlan->untag &=3D ~BIT(port);
 =09/*
@@ -473,18 +480,42 @@ static int mt7628_port_leave_vlan_block(struct dsa_sw=
itch *ds, int port,
 static void mt7628_vlan_sync(struct dsa_switch *ds)
 {
 =09struct mt7628_esw *esw =3D ds->priv;
+=09struct dsa_port *dp;
 =09int i;
=20
 =09for (i =3D 0; i < MT7628_NUM_VLANS; i++) {
 =09=09struct mt7628_vlan *vlan =3D &esw->vlans[i];
+=09=09u8 member_mask;
+
+=09=09if (vlan->type =3D=3D MT7628_VLAN_TYPE_AWARE)
+=09=09=09member_mask =3D esw->vlan_filtering;
+=09=09else
+=09=09=09member_mask =3D ~esw->vlan_filtering;
+=09=09member_mask |=3D MT7628_ESW_PORTS_CPU;
+=09=09/*
+=09=09 * Put VLAN filtering ports only into VLAN aware VLANs and
+=09=09 * non VLAN filtering ports into VLAN unaware VLANs.
+=09=09 *
+=09=09 * CPU may not be removed from any VLAN, as VLAN filtering
+=09=09 * applies only to user ports.
+=09=09 */
=20
-=09=09mt7628_esw_set_vmsc(esw, i, vlan->members);
 =09=09mt7628_esw_set_vlan_id(esw, i, vlan->vid);
-=09=09mt7628_esw_set_vub(esw, i, vlan->untag);
+=09=09mt7628_esw_set_vmsc(esw, i, vlan->members & member_mask);
+=09=09mt7628_esw_set_vub(esw, i, vlan->untag & member_mask);
+
 =09}
=20
-=09for (i =3D 0; i < ds->num_ports; i++)
-=09=09mt7628_esw_set_pvid(esw, i, esw->tag_8021q_pvid[i]);
+=09dsa_switch_for_each_user_port(dp, ds) {
+=09=09unsigned int type =3D BIT(dp->index) & esw->vlan_filtering ?
+=09=09    MT7628_VLAN_TYPE_AWARE : MT7628_VLAN_TYPE_UNAWARE;
+=09=09mt7628_esw_set_pvid(esw, dp->index, esw->pvid[type][dp->index]);
+=09}
+=09regmap_update_bits(esw->regmap, MT7628_ESW_REG_SGC2,
+=09=09=09   MT7628_ESW_SGC2_DOUBLE_TAG_EN,
+=09=09=09   FIELD_PREP(MT7628_ESW_SGC2_DOUBLE_TAG_EN,
+=09=09=09=09      MT7628_ESW_PORTS_NOCPU &
+=09=09=09=09      ~esw->vlan_filtering));
 }
=20
 static int mt7628_setup(struct dsa_switch *ds)
@@ -598,6 +629,78 @@ static int mt7628_dsa_8021q_vlan_del(struct dsa_switch=
 *ds, int port, u16 vid)
 =09return 0;
 }
=20
+static int mt7628_port_vlan_filtering(struct dsa_switch *ds, int port,
+=09=09=09=09      bool vlan_filtering,
+=09=09=09=09      struct netlink_ext_ack *extack)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+
+=09if (vlan_filtering)
+=09=09esw->vlan_filtering |=3D BIT(port);
+=09else
+=09=09esw->vlan_filtering &=3D ~BIT(port);
+=09mt7628_vlan_sync(ds);
+=09return 0;
+}
+
+static int mt7628_port_vlan_add(struct dsa_switch *ds, int port,
+=09=09=09=09const struct switchdev_obj_port_vlan *vlan,
+=09=09=09=09struct netlink_ext_ack *extack)
+{
+=09struct mt7628_vlan *vlan_block;
+=09struct dsa_port *other_dp;
+=09struct dsa_port *dp;
+=09int ret;
+
+=09if (vid_is_dsa_8021q(vlan->vid)) {
+=09=09NL_SET_ERR_MSG_MOD(extack,
+=09=09=09=09   "Range 3072-4095 reserved for dsa_8021q operation");
+=09=09return -EBUSY;
+=09}
+
+=09vlan_block =3D
+=09    mt7628_find_vlan_block(ds, vlan->vid, MT7628_VLAN_TYPE_AWARE);
+=09dp =3D dsa_to_port(ds, port);
+=09/*
+=09 * CPU port can be added to any VLANs, but user ports need to ensure,
+=09 * that if the VLAN already exists it's not used by a bridge we're not
+=09 * a member of, because VLANs are the only form of forwarding control
+=09 * we have on this switch.
+=09 */
+=09if (vlan_block && !dsa_port_is_cpu(dp)) {
+=09=09dsa_switch_for_each_user_port(other_dp, ds) {
+=09=09=09if (other_dp =3D=3D dp)
+=09=09=09=09continue;
+=09=09=09if (other_dp->bridge =3D=3D dp->bridge)
+=09=09=09=09continue;
+=09=09=09if (!(vlan_block->members & BIT(other_dp->index)))
+=09=09=09=09continue;
+=09=09=09NL_SET_ERR_MSG_MOD(extack,
+=09=09=09=09=09   "VLAN ID used on another bridge");
+=09=09=09return -EBUSY;
+=09=09}
+=09}
+=09ret =3D
+=09    mt7628_port_join_vlan_block(ds, port, vlan->vid,
+=09=09=09=09=09MT7628_VLAN_TYPE_AWARE, vlan->flags);
+=09if (ret)
+=09=09return ret;
+
+=09mt7628_vlan_sync(ds);
+=09return 0;
+}
+
+static int mt7628_port_vlan_del(struct dsa_switch *ds, int port,
+=09=09=09=09const struct switchdev_obj_port_vlan *vlan)
+{
+=09int ret =3D mt7628_port_leave_vlan_block(ds, port, vlan->vid,
+=09=09=09=09=09       MT7628_VLAN_TYPE_AWARE);
+=09if (ret)
+=09=09return ret;
+=09mt7628_vlan_sync(ds);
+=09return 0;
+}
+
 static void mt7628_teardown(struct dsa_switch *ds)
 {
 =09rtnl_lock();
@@ -651,6 +754,9 @@ static const struct dsa_switch_ops mt7628_switch_ops =
=3D {
 =09.port_bridge_join =3D dsa_tag_8021q_bridge_join,
 =09.port_bridge_leave =3D dsa_tag_8021q_bridge_leave,
 =09.port_stp_state_set =3D mt7628_stp_state_set,
+=09.port_vlan_filtering =3D mt7628_port_vlan_filtering,
+=09.port_vlan_add =3D mt7628_port_vlan_add,
+=09.port_vlan_del =3D mt7628_port_vlan_del,
 };
=20
 static int mt7628_probe(struct platform_device *pdev)
--=20
2.55.0

