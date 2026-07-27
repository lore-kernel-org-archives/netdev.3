Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EA53BED23;
	Mon, 27 Jul 2026 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179777; cv=none; b=DNSwDjxvFWijdspGLqMpn+tBbysERz4nMZ98uYpEvQ/QRSvXHiNkxfLtBja2h7cSjF0817gic2Bt1NjStGsUuEbzMcIg5JpYTWydXhw4xccdjs2lk04i7PrmFZt2S7CcJR7JO5H+PZnOunOV1O+CGBf+1mE3vUxBcHh5AQ9sZc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179777; c=relaxed/simple;
	bh=SOoQOamBRiq1TiAY5k7j011xhQt0o58rOrYFdwz28m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiE1Wp1QIcdohjZhDmqejcwxSWjaD5wIuAdH7ZJ4U5X/1+qKY49iyB0XfjGur+MXjAT7Pg5da6bObm9oEAiu3Bs8aV8El7w1cOnDHYVrVc1EdMAZCFOfgWOTMVKw8VJBBjT0cvAlu4svjDVyKmErZm0b6obOzerz8TN8GUBWf7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=P5uC7PSJ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="P5uC7PSJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785179773; x=1785784573;
	i=markus.stockhausen@gmx.de;
	bh=eYeKa62LRgmGo593WRN5oQvyttIFy9oHey3SIrOsfU8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=P5uC7PSJ5jxqbAoWTrao3ztgjW4KH3Vd5B42NvBnh3iExDQy6YfnE3w27tgRUUyV
	 WY9qyapIKl6Q7WVtBWaIzF5UJc1cQuQ6WkKEZW91QfXzQbNNiQs0E5zowOHTtqcOZ
	 Q8G7mfaAE2osOsqe1E+hf5NI4HcIvddH2LYQAZtnkRMQEC+ekGqnrwUpwZgy09HGs
	 9pXCFaG2/s9J2JaIKT7PLubO3tJySFFsxsmSoYlNS0qFYbGgLf0cJTcluff3NMrV8
	 Ka2Gv51OIXYv0eHobyL71yZq4R+ZjVdyvrYFiYzWjbUwjXU2J3q7aFsedh9bU3pep
	 IR/fzuBDG8V5h1BA+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4b1o-1wmm791skI-00DFrt; Mon, 27
 Jul 2026 21:16:13 +0200
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
Date: Mon, 27 Jul 2026 21:15:54 +0200
Message-ID: <20260727191559.19617-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727191559.19617-1-markus.stockhausen@gmx.de>
References: <20260727191559.19617-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D0X1xBcSi2T+JoNidR8/BzrmGsfsYzxbCuC6Vx7nNwFf7rrTIhp
 HaG/kIE6TsTqK5/TdHuzBWBD+vBSdqr+K3CLwQmgNu5ITLyZsW+U0xivbCTAKw/Ebs4Dtpi
 lpvOuKDRMtTb/tfZnYV/DKl06cqt5fZtX5jNVnoPP2E2RczaI04KT2EevaAqhnjn1jIzGSn
 n3GQ3N39bq/zO0EWDbiQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tCX4L/uyPQE=;SciYVtwJ3nogDGIwNBm4L+8Dr6H
 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

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

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 56 +++++++++++++++++++------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 3dee5bff4134..9529f877248b 100644
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
+	err =3D devm_add_action_or_reset(dev, otto_emdio_cleanup_bus, priv);
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
+	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
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
+			dev_err_probe(dev, err, "failed to setup MDIO controller\n");
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

