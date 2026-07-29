Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BC8411A1E;
	Wed, 29 Jul 2026 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340977; cv=none; b=eI9vxRHY2OG8LUpJCnPyZ7yon5VBm1QOIoxc4nFlJ0g1pCeSIvOcQhK2SqEzT//gmexUqgv7x64KhIBpVA66Ze7oxxzDcztOSabQjwKMzNu2BFXYRyw6G+LwVDaTJlvd1nBdBtLT5188/JT5AwKhVLP6KHG59YmJbqb2XVmIqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340977; c=relaxed/simple;
	bh=lQZ3tbxFRo+6KDmiF/tEezIyejlCO0DxT4wMLXmkI2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2BT1jXM7CrnUllaKgb4ZBpLGLNi7ZyEYKgiLGISHPqZGZDp27pMNtQWFLZE/VxXvw9Y/cSXwyNGp92Qz6anrLw7FV1NRCVMbj9wL9GUctE92BoAq2qYy9jgbHhw1PZ+sPxVjoi/2Ib0Z9QLH1g196qDWKlq78Evk0yRPDrUxvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=JglXLIm+; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="JglXLIm+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785340967; x=1785945767;
	i=markus.stockhausen@gmx.de;
	bh=rNam4VsD8lmcdGcg4u/0Mep1O4sA//zx7gIpxn3Orzk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JglXLIm+sJzGj/o3KK5wMlRjNddUjN5gXH5skqGo0REoe8mODPbCe8rkBysp/4dZ
	 s+BQmMSUZi8RxYvUWbOKUHIAnC3K5yhClvUFiTVuYKs9E+V4c6XGsIlfd14yN9yjF
	 05PZWuL+Jr4qsLQmY44enNVhfD3JAp9qO7YJHlWE0iCy+9OUqeZ+BIvwye4dSAjZ3
	 RfTAXAfWp1YAI/tgx57U1EJm5FZvxAoKvSONp9FQCeM6LJOy3vQxm114p2EeMQUzG
	 oZct4W7HBxEsgcwd4pgR2TuXr4Y59CgooT61JCpdYQm6/XsBvCy88ieTfJ/RcANfB
	 ifzQTUxkit5nobfjhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9kM-1wjaxe38we-005lJ1; Wed, 29
 Jul 2026 18:02:46 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v8 4/9] net: mdio: realtek-rtl9300: extend controller structure lifetime
Date: Wed, 29 Jul 2026 18:02:22 +0200
Message-ID: <20260729160227.155613-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729160227.155613-1-markus.stockhausen@gmx.de>
References: <20260729160227.155613-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pn2RPV6Q26Lu2nQJPG0lDiFr2Tj1nnvjzoJ+x1XPx0KSlPK//oM
 4mRoXO9KBoDAzIJLuJXU4l2RnBvGKLPF8F2sSRyRe5qMb/2V5VcuHwiLqv3jL43DQLC325Q
 kgwnkBxzdheb6thhjAj4GE6Yh/UyI5Tjq4KmnJqBtJHVo7SZ2TmzcJ2BFyhshpl40rrvinu
 mx43tgQiB7763GPfLhQ8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MLY0EPYjDgw=;Qwf7UN9dlTME+mwZlfosCIhZ1zm
 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
 p8BSlST7BN2FUT3gxokGX2pLw==

Currently, the driver allocates the otto_emdio_priv structure using
devm_kzalloc(), tightly coupling its lifetime to the platform device.
Additionally the driver registers up to four MDIO buses. During unbind
or removal the devm teardown process might free the controller private
data before the MDIO buses are fully unregistered. This can lead to a
use-after-free if the MDIO subsystem accesses bus-specific operations
(which rely on controller->priv) during the teardown phase.

Fix this by decoupling the lifetime of the private data from the
platform device and directly tying it to the registered MDIO buses:

- Switch from devm() to normal functions in controller probing and
  introduce a kref counter.
- For each successfully initialized bus, increment the kref counter and
  register a devm action to decrement it on cleanup.
- Free the controller->priv data after the final reference has been
  removed.

For the new logic to work properly the controller from now on relies
on at least one attached bus. If no bus is given probing fails as
the controller has no real justification for existence.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 56 +++++++++++++++++++------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 73ac5fdcd267..3b99978a2511 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -116,6 +116,7 @@
 #include <linux/bitmap.h>
 #include <linux/bits.h>
 #include <linux/find.h>
+#include <linux/kref.h>
 #include <linux/mdio.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mutex.h>
@@ -198,6 +199,7 @@ struct otto_emdio_cmd_regs {
=20
 struct otto_emdio_priv {
 	const struct otto_emdio_info *info;
+	struct kref kref;
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
@@ -582,6 +584,21 @@ static int otto_emdio_9310_setup_controller(struct ot=
to_emdio_priv *priv)
 	return 0;
 }
=20
+static void otto_emdio_cleanup_controller(struct kref *kref)
+{
+	struct otto_emdio_priv *priv =3D container_of(kref, struct otto_emdio_pr=
iv, kref);
+
+	mutex_destroy(&priv->lock);
+	kfree(priv);
+}
+
+static void otto_emdio_cleanup_bus(void *data)
+{
+	struct otto_emdio_priv *priv =3D data;
+
+	kref_put(&priv->kref, otto_emdio_cleanup_controller);
+}
+
 static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_pri=
v *priv,
 				 struct fwnode_handle *node)
 {
@@ -617,6 +634,11 @@ static int otto_emdio_probe_one(struct device *dev, s=
truct otto_emdio_priv *priv
=20
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d", dev_name(dev), mdio_bus);
=20
+	kref_get(&priv->kref);
+	err =3D devm_add_action_or_reset(&bus->dev, otto_emdio_cleanup_bus, priv=
);
+	if (err)
+		return dev_err_probe(dev, err, "cannot register cleanup action\n");
+
 	err =3D devm_of_mdiobus_register(dev, bus, to_of_node(node));
 	if (err)
 		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
@@ -731,44 +753,54 @@ static int otto_emdio_probe(struct platform_device *=
pdev)
 {
 	struct device *dev =3D &pdev->dev;
 	struct otto_emdio_priv *priv;
+	int buses_registered =3D 0;
 	int err;
=20
-	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	priv =3D kzalloc_obj(*priv, GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
=20
-	err =3D devm_mutex_init(dev, &priv->lock);
-	if (err)
-		return err;
+	kref_init(&priv->kref);
+	mutex_init(&priv->lock);
=20
 	priv->info =3D device_get_match_data(dev);
 	priv->regmap =3D syscon_node_to_regmap(dev->parent->of_node);
-	if (IS_ERR(priv->regmap))
-		return PTR_ERR(priv->regmap);
+	if (IS_ERR(priv->regmap)) {
+		err =3D PTR_ERR(priv->regmap);
+		goto err_out;
+	}
=20
 	platform_set_drvdata(pdev, priv);
=20
 	err =3D otto_emdio_map_ports(dev);
 	if (err)
-		return err;
+		goto err_out;
=20
 	err =3D otto_emdio_setup_topology(priv);
 	if (err)
-		return err;
+		goto err_out;
=20
 	if (priv->info->setup_controller) {
 		err =3D priv->info->setup_controller(priv);
-		if (err)
-			return dev_err_probe(dev, err, "failed to setup MDIO bus controller\n"=
);
+		if (err) {
+			dev_err_probe(dev, err, "failed to setup MDIO bus controller\n");
+			goto err_out;
+		}
 	}
=20
 	device_for_each_child_node_scoped(dev, child) {
 		err =3D otto_emdio_probe_one(dev, priv, child);
 		if (err)
-			return err;
+			goto err_out;
+		buses_registered++;
 	}
=20
-	return 0;
+	if (!buses_registered)
+		err =3D dev_err_probe(dev, -ENODEV, "no MDIO buses registered\n");
+err_out:
+	kref_put(&priv->kref, otto_emdio_cleanup_controller);
+
+	return err;
 }
=20
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
=2D-=20
2.55.0

