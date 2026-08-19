Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A6394797;
	Wed, 19 Aug 2026 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787173789; cv=none; b=oldLdZ13s7sax6MIMHFU2A497PV1BBjQ6iqaEu4WP9Z4yTyrjdWysnvOfZ4ge6FdYfNj322Eokq3w82bedjs9ulgDzx8pHXPrw4bgqKOyhRR8dHuKVKLrz0dEbo6pQacVg7jIXlhu0V2+BPdqHlKBEClqSMsKMS+mEYppCULgnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787173789; c=relaxed/simple;
	bh=h3zcNPLEaBKBO93fy13iCPsS6G6XiJIy69eibHG/EcU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWSuXnBb3dx2IAQOer7L4njfLPvpg2/PfzfZ04SMTDKjdcIbprPLiZv3kDeETs4MZfy+fN+1+5A4IQ6LUg4Uo1PUEvMkf25004TWKO7lJYhH+PNacvvw7lw+UH48SOXTQwiPaIm2ZNyhe72KlM6Mr8+IvrflI2liDjyH3GqdF2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SOeLtPI2; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SOeLtPI2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=yo3uq5zk45cyzketajruivgbeq.protonmail; t=1787173778; x=1787432978;
	bh=nUlCHsR3dopvv/Vpb77xqsKIeVXUWaz/b2VTOANTcfY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SOeLtPI21o7TkAIVftuMFMAl0S88Za2HkCKza7w6c4tSIRZgUwtBOHsblIXTFCSEm
	 NoS4InIb46S18F1vKeiQXWafxHsjHygrQfFDoOOHUztC2TSYoMZSZqkMbc5/Nhf7B9
	 5Phbu27KBL1E+qyZTQn3z/hnsR0EXnIqSHw2XhoNtvydyPkdfxlnxDG2IaggvkVEW1
	 KZhI0QfqIVUkQGJcQ3zVGDn68Cles7vUdsbsZXBZem88XZ29jiXmn6kf/qTqGcN1H2
	 nNl7TVJ36342tzJx6IY7kuYcmwKtWtNsN10XZ+5NqrhWlC8oO7JcJVgizfInAqfL20
	 kHzRZekhU9VXQ==
Date: Wed, 19 Aug 2026 21:09:32 +0000
To: oe-linux-nfc@lists.linux.dev
From: Kristian Brox <isyourbrainfoss@proton.me>
Cc: david@ixit.cz, krzk+dt@kernel.org, devicetree@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com, luca.weiss@fairphone.com, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 2/3] nfc: st-nci: add raw NCI path for ST21NFCD
Message-ID: <20260819210906.2500789-3-isyourbrainfoss@proton.me>
In-Reply-To: <20260819210906.2500789-1-isyourbrainfoss@proton.me>
References: <20260818205940.1973944-1-isyourbrainfoss@proton.me> <20260819210906.2500789-1-isyourbrainfoss@proton.me>
Feedback-ID: 203906395:user:proton
X-Pm-Message-ID: a7941bbc00c42956d5692e4143bfe38a67ce0483
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ST21NFCD does not use NDLC. When the compatible is st,st21nfcd,
talk raw NCI:

- do not add or strip an NDLC PCB
- do not run the T1/T2 ACK timers
- I2C reads are a 3-byte NCI header plus payload
- skip proprietary SET_NFC_MODE and HCI SE discovery

Optionally enable clocks (SYS_CLK) and vdd-io (VPS_IO) when the
DT describes them. Existing st21nfcb / st21nfcc boards keep the
NDLC path and do not need those properties.

Tested on Fairphone 5: adapter powers up and reads an NTAG 215.

Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
---
diff --git a/drivers/nfc/st-nci/core.c b/drivers/nfc/st-nci/core.c
index a367136..2356f16 100644
--- a/drivers/nfc/st-nci/core.c
+++ b/drivers/nfc/st-nci/core.c
@@ -18,8 +18,13 @@
=20
 static int st_nci_init(struct nci_dev *ndev)
 {
+=09struct st_nci_info *info =3D nci_get_drvdata(ndev);
 =09struct nci_mode_set_cmd cmd;
=20
+=09/* ST21NFCD has no NDLC proprietary SET_NFC_MODE */
+=09if (info->ndlc->raw_nci)
+=09=09return 0;
+
 =09cmd.cmd_type =3D ST_NCI_SET_NFC_MODE;
 =09cmd.mode =3D 1;
=20
diff --git a/drivers/nfc/st-nci/i2c.c b/drivers/nfc/st-nci/i2c.c
index 416770a..cfddb7f 100644
--- a/drivers/nfc/st-nci/i2c.c
+++ b/drivers/nfc/st-nci/i2c.c
@@ -10,10 +10,13 @@
 #include <linux/i2c.h>
 #include <linux/gpio/consumer.h>
 #include <linux/acpi.h>
+#include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/nfc.h>
 #include <linux/of.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
=20
 #include "st-nci.h"
=20
@@ -22,10 +25,17 @@
 /* ndlc header */
 #define ST_NCI_FRAME_HEADROOM 1
 #define ST_NCI_FRAME_TAILROOM 0
+#define ST_NCI_RAW_FRAME_HEADROOM 0
=20
 #define ST_NCI_I2C_MIN_SIZE 4   /* PCB(1) + NCI Packet header(3) */
+#define ST_NCI_NCI_HDR_SIZE 3   /* raw NCI: MT/PBF/GID + OID + len */
 #define ST_NCI_I2C_MAX_SIZE 250 /* req 4.2.1 */
=20
+enum st_nci_i2c_proto {
+=09ST_NCI_I2C_PROTO_NDLC =3D 0,
+=09ST_NCI_I2C_PROTO_RAW_NCI,
+};
+
 #define ST_NCI_DRIVER_NAME "st_nci"
 #define ST_NCI_I2C_DRIVER_NAME "st_nci_i2c"
=20
@@ -34,6 +44,7 @@ struct st_nci_i2c_phy {
 =09struct llt_ndlc *ndlc;
=20
 =09bool irq_active;
+=09bool raw_nci;
=20
 =09struct gpio_desc *gpiod_reset;
=20
@@ -111,6 +122,42 @@ static int st_nci_i2c_read(struct st_nci_i2c_phy *phy,
 =09u8 buf[ST_NCI_I2C_MAX_SIZE];
 =09struct i2c_client *client =3D phy->i2c_dev;
=20
+=09if (phy->raw_nci) {
+=09=09r =3D i2c_master_recv(client, buf, ST_NCI_NCI_HDR_SIZE);
+=09=09if (r < 0) {
+=09=09=09usleep_range(1000, 4000);
+=09=09=09r =3D i2c_master_recv(client, buf, ST_NCI_NCI_HDR_SIZE);
+=09=09}
+=09=09if (r !=3D ST_NCI_NCI_HDR_SIZE)
+=09=09=09return -EREMOTEIO;
+
+=09=09len =3D buf[2];
+=09=09if (len > ST_NCI_I2C_MAX_SIZE) {
+=09=09=09nfc_err(&client->dev, "invalid frame len\n");
+=09=09=09return -EBADMSG;
+=09=09}
+
+=09=09*skb =3D alloc_skb(ST_NCI_NCI_HDR_SIZE + len, GFP_KERNEL);
+=09=09if (!*skb)
+=09=09=09return -ENOMEM;
+
+=09=09skb_put(*skb, ST_NCI_NCI_HDR_SIZE);
+=09=09memcpy((*skb)->data, buf, ST_NCI_NCI_HDR_SIZE);
+
+=09=09if (!len)
+=09=09=09return 0;
+
+=09=09r =3D i2c_master_recv(client, buf, len);
+=09=09if (r !=3D len) {
+=09=09=09kfree_skb(*skb);
+=09=09=09return -EREMOTEIO;
+=09=09}
+
+=09=09skb_put(*skb, len);
+=09=09memcpy((*skb)->data + ST_NCI_NCI_HDR_SIZE, buf, len);
+=09=09return 0;
+=09}
+
 =09r =3D i2c_master_recv(client, buf, ST_NCI_I2C_MIN_SIZE);
 =09if (r < 0) {  /* Retry, chip was in standby */
 =09=09usleep_range(1000, 4000);
@@ -211,6 +258,8 @@ static int st_nci_i2c_probe(struct i2c_client *client)
 =09=09return -ENOMEM;
=20
 =09phy->i2c_dev =3D client;
+=09phy->raw_nci =3D (uintptr_t)device_get_match_data(dev) =3D=3D
+=09=09=09ST_NCI_I2C_PROTO_RAW_NCI;
=20
 =09i2c_set_clientdata(client, phy);
=20
@@ -225,19 +274,31 @@ static int st_nci_i2c_probe(struct i2c_client *client=
)
 =09=09return -ENODEV;
 =09}
=20
+=09r =3D devm_regulator_get_enable_optional(dev, "vdd-io");
+=09if (r && r !=3D -ENODEV)
+=09=09return dev_err_probe(dev, r, "failed to enable vdd-io\n");
+
+=09r =3D PTR_ERR_OR_ZERO(devm_clk_get_optional_enabled(dev, NULL));
+=09if (r)
+=09=09return dev_err_probe(dev, r, "failed to enable clock\n");
+
 =09phy->se_status.is_ese_present =3D
 =09=09=09=09device_property_read_bool(dev, "ese-present");
 =09phy->se_status.is_uicc_present =3D
 =09=09=09=09device_property_read_bool(dev, "uicc-present");
=20
 =09r =3D ndlc_probe(phy, &i2c_phy_ops, &client->dev,
-=09=09=09ST_NCI_FRAME_HEADROOM, ST_NCI_FRAME_TAILROOM,
+=09=09=09phy->raw_nci ? ST_NCI_RAW_FRAME_HEADROOM :
+=09=09=09=09       ST_NCI_FRAME_HEADROOM,
+=09=09=09ST_NCI_FRAME_TAILROOM,
 =09=09=09&phy->ndlc, &phy->se_status);
 =09if (r < 0) {
 =09=09nfc_err(&client->dev, "Unable to register ndlc layer\n");
 =09=09return r;
 =09}
=20
+=09phy->ndlc->raw_nci =3D phy->raw_nci;
+
 =09phy->irq_active =3D true;
 =09r =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
 =09=09=09=09st_nci_irq_thread_fn,
@@ -273,6 +334,8 @@ static const struct of_device_id of_st_nci_i2c_match[] =
__maybe_unused =3D {
 =09{ .compatible =3D "st,st21nfcb-i2c", },
 =09{ .compatible =3D "st,st21nfcb_i2c", },
 =09{ .compatible =3D "st,st21nfcc-i2c", },
+=09{ .compatible =3D "st,st21nfcd",
+=09  .data =3D (void *)ST_NCI_I2C_PROTO_RAW_NCI },
 =09{}
 };
 MODULE_DEVICE_TABLE(of, of_st_nci_i2c_match);
diff --git a/drivers/nfc/st-nci/ndlc.c b/drivers/nfc/st-nci/ndlc.c
index be48088..b319246 100644
--- a/drivers/nfc/st-nci/ndlc.c
+++ b/drivers/nfc/st-nci/ndlc.c
@@ -62,8 +62,9 @@ void ndlc_close(struct llt_ndlc *ndlc)
 =09/* toggle reset pin */
 =09ndlc->ops->enable(ndlc->phy_id);
=20
-=09nci_prop_cmd(ndlc->ndev, ST_NCI_CORE_PROP,
-=09=09     sizeof(struct nci_mode_set_cmd), (__u8 *)&cmd);
+=09if (!ndlc->raw_nci)
+=09=09nci_prop_cmd(ndlc->ndev, ST_NCI_CORE_PROP,
+=09=09=09     sizeof(struct nci_mode_set_cmd), (__u8 *)&cmd);
=20
 =09ndlc->powered =3D 0;
 =09ndlc->ops->disable(ndlc->phy_id);
@@ -72,11 +73,13 @@ EXPORT_SYMBOL(ndlc_close);
=20
 int ndlc_send(struct llt_ndlc *ndlc, struct sk_buff *skb)
 {
-=09/* add ndlc header */
-=09u8 pcb =3D PCB_TYPE_DATAFRAME | PCB_DATAFRAME_RETRANSMIT_NO |
-=09=09PCB_FRAME_CRC_INFO_NOTPRESENT;
+=09if (!ndlc->raw_nci) {
+=09=09/* add ndlc header */
+=09=09u8 pcb =3D PCB_TYPE_DATAFRAME | PCB_DATAFRAME_RETRANSMIT_NO |
+=09=09=09PCB_FRAME_CRC_INFO_NOTPRESENT;
=20
-=09*(u8 *)skb_push(skb, 1) =3D pcb;
+=09=09*(u8 *)skb_push(skb, 1) =3D pcb;
+=09}
 =09skb_queue_tail(&ndlc->send_q, skb);
=20
 =09schedule_work(&ndlc->sm_work);
@@ -103,6 +106,10 @@ static void llt_ndlc_send_queue(struct llt_ndlc *ndlc)
 =09=09=09ndlc->hard_fault =3D r;
 =09=09=09break;
 =09=09}
+=09=09if (ndlc->raw_nci) {
+=09=09=09kfree_skb(skb);
+=09=09=09continue;
+=09=09}
 =09=09time_sent =3D jiffies;
 =09=09*(unsigned long *)skb->cb =3D time_sent;
=20
@@ -154,6 +161,10 @@ static void llt_ndlc_rcv_queue(struct llt_ndlc *ndlc)
 =09=09pr_debug("rcvQlen=3D%d\n", ndlc->rcv_q.qlen);
=20
 =09while ((skb =3D skb_dequeue(&ndlc->rcv_q)) !=3D NULL) {
+=09=09if (ndlc->raw_nci) {
+=09=09=09nci_recv_frame(ndlc->ndev, skb);
+=09=09=09continue;
+=09=09}
 =09=09pcb =3D skb->data[0];
 =09=09skb_pull(skb, 1);
 =09=09if ((pcb & PCB_TYPE_MASK) =3D=3D PCB_TYPE_SUPERVISOR) {
diff --git a/drivers/nfc/st-nci/ndlc.h b/drivers/nfc/st-nci/ndlc.h
index c24ce9b..5c1f8ba 100644
--- a/drivers/nfc/st-nci/ndlc.h
+++ b/drivers/nfc/st-nci/ndlc.h
@@ -39,6 +39,8 @@ struct llt_ndlc {
 =09 */
 =09int hard_fault;
 =09int powered;
+=09/* ST21NFCD: raw NCI on the wire, no NDLC PCB / ACK timers */
+=09bool raw_nci;
 };
=20
 int ndlc_open(struct llt_ndlc *ndlc);
diff --git a/drivers/nfc/st-nci/se.c b/drivers/nfc/st-nci/se.c
index 607ec76..44cc102 100644
--- a/drivers/nfc/st-nci/se.c
+++ b/drivers/nfc/st-nci/se.c
@@ -621,6 +621,9 @@ int st_nci_discover_se(struct nci_dev *ndev)
 =09int se_count =3D 0;
 =09struct st_nci_info *info =3D nci_get_drvdata(ndev);
=20
+=09if (info->ndlc->raw_nci)
+=09=09return 0;
+
 =09r =3D st_nci_hci_network_init(ndev);
 =09if (r !=3D 0)
 =09=09return r;

