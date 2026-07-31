Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF866361969;
	Fri, 31 Jul 2026 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478475; cv=none; b=II7GwAAHYfCLmWTcWNK1b0CfLfar95+2kS8iirr1E+cBC39lnZ4/VPeSf1tZVQPhMEcYfI021lq0oo+D+d7N3jESVKQTBYu4RvFRzX9cniP8hj9sI819QZO4nso/gm/MipMwMZVx1PpTxd4CLVetrnW8pdcGeAGYU2LrKwCWxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478475; c=relaxed/simple;
	bh=6bas22X0/84JXaAkX8BrDdyrwC7/ddkq3twu77N2xdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBgvvBjy/VP9e7Eu4ui8sw6wkyiBDWlvg4Y5Y2boJGdl5TZgdBm3lIC2Cf0Df8g4c20oLH3ea+Zrtq4n3moWQdpgGQ7X3I6e6yowjFF7Vz7UJPJAQTy17LYC2t5bYrE3XGnPe1eJo9c2MvMiyjAUMoletwFzg/ql/troZgBPhVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=mdwjSTCc; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="mdwjSTCc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785478455; x=1786083255;
	i=markus.stockhausen@gmx.de;
	bh=IIZaHc9ZmpI9pFGDNu7YmvQthm9HdHCmCNsE83bl+Ig=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mdwjSTCct+rN/gNQbcd/y0k5Lks4Y6BL2twoZqz+u7S0gKHljrETYqQ8DDumvega
	 WFa6YYnQEa9wd91BDRVN/Pww8zott1m6adLxW+7hbdLiufkmzZo2jPrtkajdsO/Gj
	 WSbF2V18rCegKVp8/15TWLDCj6McSqln0+fhXWV8gs/1fD87nsTgkJuyLOTEROg27
	 +hmzz/nV8LuR2oufUHoO6Hww/88CFmXOnN0LvBJUK8mG0DcSM3YhIzVaBHtcqLmsu
	 0y79JXtTwDRsPL057pS8+zKT5BnkSRCzHkBkrgeKk2Sdizq/KKJqxhHm6itpvIHby
	 MgNSf5CbvKci4x9b+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3HU-1wj1aw3fVg-00Dlin; Fri, 31
 Jul 2026 08:14:14 +0200
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
Subject: [PATCH net-next v10 04/10] net: mdio: realtek-rtl9300: extend controller structure lifetime
Date: Fri, 31 Jul 2026 08:13:54 +0200
Message-ID: <20260731061400.78301-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731061400.78301-1-markus.stockhausen@gmx.de>
References: <20260731061400.78301-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DM4AjKVhFOLJAXjFBYi6dxGHp1ygJOwSx/eS2AOQ1wP/6CqGyXZ
 2Irr9EHB2QoX/UxWP5a5JJm98TM6YtiGTnFvW5ZjYpv/8qF7E9+Vx4BB9xmLlFCPM1ods2o
 23rXa9bSVHUhAk7Qgacdl3j4EqUOQga3KlG4pPlnPMyjBoDTm8gokNtweXyBShXe3Uu4/kP
 PP4PZ6diYGU5VGjEbg3PA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Sr0xANguBR0=;+n+2OpdCk/RHbUIpKcqQcSI0rKi
 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
 50zGr3Ftktq5ItixfQvJXWXAQ==

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
index 73ac5fdcd267..7dcfb72ed818 100644
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
@@ -621,6 +638,11 @@ static int otto_emdio_probe_one(struct device *dev, s=
truct otto_emdio_priv *priv
 	if (err)
 		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
=20
+	kref_get(&priv->kref);
+	err =3D devm_add_action_or_reset(&bus->dev, otto_emdio_cleanup_bus, priv=
);
+	if (err)
+		return dev_err_probe(dev, err, "cannot register cleanup action\n");
+
 	return 0;
 }
=20
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

