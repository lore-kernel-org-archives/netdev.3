Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0893BB12B
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715246; cv=none; b=uqZZvSiXN9pEceQsIE29hAiEzwHq9up36tXXdycE9GllNijsezgZ89H4nPaO81l3kOCy98edotvI8XjEi85e1iObscR8GoZjtYsuJd7q0T0RSTtsWZ2TrCX6SxvesnVIzD7JTYiEHSagiQnEagIW0W5/qxzi5MWeyKe96GRJNtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715246; c=relaxed/simple;
	bh=gkjK4b72qfluTvt5HrhEMAUHGLY0Xm9kXN8MvueOQKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyesBjZkOj44FwYZ+0X+0himItIYRWTegSQ/Tr5KOLShfFP3pBl08OAmmiTon+K5FuXCiuvFdxsrp2Xxd0WhM9j7cDPCjhb8c8eRJW88NMb+HsUxtgjbMqYWVdpoQTaKBHPr8K/oQe7VIO80ze1poyEHLqP08PzqrWMvtEkjVEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=iMKTdyRJ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=L5W9oly5; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="iMKTdyRJ";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="L5W9oly5"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=iMKTdyRJL39tXthmkaGGBy3R+4gbUn44jpiSeOzf0pozq/7ivwc0VNr3QGRKP22PVTmdMaCaxqRY2nViPHlYXncvEYFgABTgeRxPH0WMfAIoZXRR3lsVX9tkXWWDNHqDxOOgglXExApMkyF32ReFxGnsasTK3ELIsM9oFzqU1FQcCAUScFm/12vaui6lQV8IIAn68JxInyf7P+IeaiqM9LenuC0LcIw7l+jaiJdqTya5eMDrjwgK/uPwXP+8+dMNQdIT6+p9SzGLrJRWP1TCvK2MGdZO3fCOsP6tweJaZrA0es/LwGs9Fmlli54Mvt/pgOKINfYtmKCGJ4A4VnNMiw==; s=purelymail3; d=tinyisr.com; v=1; bh=gkjK4b72qfluTvt5HrhEMAUHGLY0Xm9kXN8MvueOQKg=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=L5W9oly5kJLowW4Uio1gkgO29R1fctUrMIF3fI7JWcJ4BISRUozN5rWAImGI9dcolj0fPZEWogueaY/EGhv9THwdjAXYg3XFVf/tXjqJ1aoAjISj0rp9eKXJYqrCG4x0Yh41VCIOrE7mqJk+nCaHkMDy3/q4QrZWoqtldaTuWtFq389sZ0XOLfOBJAs/z5BV+yoiPAB2om1L1GWlQC5MXk94rQt9mOs5UBaVxFWspb5BYSwG30bJG9Osloc3VOKuJVkdCFGeS+E6d5TPMqJwDbYac4Bq9SeauJGhOlEQQt+lE5mB+yhWEbwgoRZeK4Fa206YLPm+kmV3eEb8hEfF7w==; s=purelymail3; d=purelymail.com; v=1; bh=gkjK4b72qfluTvt5HrhEMAUHGLY0Xm9kXN8MvueOQKg=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1438868657;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 06 Sep 2026 17:20:42 +0000 (UTC)
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
Subject: [PATCH net-next v1 2/6] net: dsa: mt7628: add port bridge offload support
Date: Sun,  6 Sep 2026 20:16:21 +0300
Message-ID: <20260906171625.533915-3-joey@tinyisr.com>
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

Add STP support and hook up the generic tag_8021q bridge join and leave
functions to dsa_switch_ops to allow hardware-offloaded bridging.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
 drivers/net/dsa/mt7628.c | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/dsa/mt7628.c b/drivers/net/dsa/mt7628.c
index 990556cc2f65..7eabfad3e114 100644
--- a/drivers/net/dsa/mt7628.c
+++ b/drivers/net/dsa/mt7628.c
@@ -34,6 +34,7 @@
 #define MT7628_ESW_REG_VUB(vlan) (0x100 + 4 * ((vlan) / 4))
 #define MT7628_ESW_REG_SOCPC 0x8c
 #define MT7628_ESW_REG_POC0 0x90
+#define MT7628_ESW_REG_POC1 0x94
 #define MT7628_ESW_REG_POC2 0x98
 #define MT7628_ESW_REG_SGC 0x9c
 #define MT7628_ESW_REG_PCR0 0xc0
@@ -92,6 +93,9 @@
=20
 #define MT7628_ESW_POC0_PORT_DISABLE GENMASK(29, 23)
=20
+#define MT7628_ESW_POC1_PORT_BLOCKING_STATE GENMASK(22, 16)
+#define MT7628_ESW_POC1_PORT_DIS_LEARNING GENMASK(14, 8)
+
 #define MT7628_ESW_POC2_PER_VLAN_UNTAG_EN BIT(15)
=20
 #define MT7628_ESW_SGC_AGING_INTERVAL GENMASK(3, 0)
@@ -519,6 +523,8 @@ static int mt7628_setup(struct dsa_switch *ds)
 =09for (int i =3D 0; i < MT7628_ESW_NUM_USER_PORTS + 1; i++)
 =09=09esw->vlans[i].type =3D MT7628_VLAN_TYPE_UNAWARE;
=20
+=09ds->max_num_bridges =3D DSA_TAG_8021Q_MAX_NUM_BRIDGES;
+
 =09rtnl_lock();
 =09ret =3D dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));
 =09rtnl_unlock();
@@ -599,6 +605,40 @@ static void mt7628_teardown(struct dsa_switch *ds)
 =09rtnl_unlock();
 }
=20
+static void mt7628_stp_state_set(struct dsa_switch *ds, int port, u8 state=
)
+{
+=09struct mt7628_esw *esw =3D ds->priv;
+=09bool forward_disable;
+=09bool learn_disable;
+
+=09switch (state) {
+=09case BR_STATE_DISABLED:
+=09case BR_STATE_BLOCKING:
+=09case BR_STATE_LISTENING:
+=09=09forward_disable =3D true;
+=09=09learn_disable =3D true;
+=09=09break;
+=09case BR_STATE_LEARNING:
+=09=09forward_disable =3D true;
+=09=09learn_disable =3D false;
+=09=09break;
+=09case BR_STATE_FORWARDING:
+=09=09forward_disable =3D false;
+=09=09learn_disable =3D false;
+=09=09break;
+=09default:
+=09=09dev_err(ds->dev, "invalid STP state: %d\n", state);
+=09=09return;
+=09}
+
+=09regmap_assign_bits(esw->regmap, MT7628_ESW_REG_POC1,
+=09=09=09   FIELD_PREP(MT7628_ESW_POC1_PORT_DIS_LEARNING,
+=09=09=09=09      BIT(port)), learn_disable);
+=09regmap_assign_bits(esw->regmap, MT7628_ESW_REG_POC1,
+=09=09=09   FIELD_PREP(MT7628_ESW_POC1_PORT_BLOCKING_STATE,
+=09=09=09=09      BIT(port)), forward_disable);
+}
+
 static const struct dsa_switch_ops mt7628_switch_ops =3D {
 =09.get_tag_protocol =3D mt7628_get_tag_proto,
 =09.setup =3D mt7628_setup,
@@ -608,6 +648,9 @@ static const struct dsa_switch_ops mt7628_switch_ops =
=3D {
 =09.phylink_get_caps =3D mt7628_phylink_get_caps,
 =09.tag_8021q_vlan_add =3D mt7628_dsa_8021q_vlan_add,
 =09.tag_8021q_vlan_del =3D mt7628_dsa_8021q_vlan_del,
+=09.port_bridge_join =3D dsa_tag_8021q_bridge_join,
+=09.port_bridge_leave =3D dsa_tag_8021q_bridge_leave,
+=09.port_stp_state_set =3D mt7628_stp_state_set,
 };
=20
 static int mt7628_probe(struct platform_device *pdev)
--=20
2.55.0

