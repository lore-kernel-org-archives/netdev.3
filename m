Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799803DAACA
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259385; cv=none; b=s6OqDkreqgskPoKuW8WKEtAPrxMx7DIAs+CIr9aYJswRGX4Vf6iJ17C48ZwkIXrXxikmI4maBIZTveBaSxOzHj/I/xOXoe/D7Gx3pMPdnXtX//Tlb3uv3Ll3rkD0OS69Evnsqu7mWGqXNQQ/xiH8j3wmxaJjrLJ6KZh+YYLBEKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259385; c=relaxed/simple;
	bh=XnXWwXuVRfBNc42Aw8+v/kKQaXxXXJkksLSzgJcWuK4=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aIHbJdAiGaSWsGbO6SSEAmvRfalCJlt/Lqato1nLq/8X9kIsZKgzpR5tCVeiNcyxx0jGbIfBDobPtyB//fdANtMPnoMq6sEYfHoUWPQHNmEOE77hmFHeHTtvlUDveRbAt8dXjKWt/W68uVRippolrSavyos3zwnU7R/USwD0H7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eERE2+MP; arc=none smtp.client-ip=109.224.244.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eERE2+MP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=wcmevsiipjdnlleewr5p6h2pyq.protonmail; t=1787259376; x=1787518576;
	bh=kMjLAYW+zARf+rgZNABlOlscGbUg88r+sAn3Q8XieO4=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eERE2+MPFJekUILapkLt4IAQp+mRxw8rtGmdQdCmuyziByqkEiSAO7jeG9uJgsYcH
	 jVmykYnWfeogvIMIj22kPIVDINg/GUsrFV37zu0IRaEGuGTLBu2D/kt/8G3wiCNx4T
	 X5oy1nu5WHbNS0dRwqcGfg1R3nE0R+oTF2viFvU9QwyM7mdlgL5nm/75xVSwQehfSi
	 nT/g/lC1PoKQjh7YN/fCBFu5x29k3Iza6I9WQO9UtjPzqr7Wd6X3Nd12dyKREIaXFt
	 wfr/Niq5Y/Xhq5UX0TqrbgJeEaKL+4Q7QiwCseUz3HxnzjEe91lNwYpkACZZAwhMRp
	 9cFy/AlExqbCw==
Date: Thu, 20 Aug 2026 20:56:10 +0000
From: Kristian Brox <isyourbrainfoss@proton.me>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Kristian Brox <isyourbrainfoss@proton.me>
Subject: [PATCH v3 2/3] nfc: st-nci: add raw NCI path for ST21NFCD
Message-ID: <20260820-fp5-st21nfcd-v3-v3-2-5ee0a7f44d04@proton.me>
In-Reply-To: <20260820-fp5-st21nfcd-v3-v3-0-5ee0a7f44d04@proton.me>
References: <20260820-fp5-st21nfcd-v3-v3-0-5ee0a7f44d04@proton.me>
Feedback-ID: 203906395:user:proton
X-Pm-Message-ID: cd9a2f6d5d39c7684d229939cc1e4a91ae2087bc
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
 drivers/nfc/st-nci/core.c |  5 +++
 drivers/nfc/st-nci/i2c.c  | 87 ++++++++++++++++++++++++++++++++++++++++---=
----
 drivers/nfc/st-nci/ndlc.c | 23 +++++++++----
 drivers/nfc/st-nci/ndlc.h |  2 ++
 drivers/nfc/st-nci/se.c   |  3 ++
 5 files changed, 102 insertions(+), 18 deletions(-)

diff --git a/drivers/nfc/st-nci/core.c b/drivers/nfc/st-nci/core.c
index a367136d4..2356f16b8 100644
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
index 152c20b6b..cfddb7ffe 100644
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
@@ -257,23 +318,25 @@ static void st_nci_i2c_remove(struct i2c_client *clie=
nt)
 }
=20
 static const struct i2c_device_id st_nci_i2c_id_table[] =3D {
-=09{ .name =3D ST_NCI_DRIVER_NAME },
-=09{ }
+=09{ ST_NCI_DRIVER_NAME },
+=09{}
 };
 MODULE_DEVICE_TABLE(i2c, st_nci_i2c_id_table);
=20
-static const struct acpi_device_id st_nci_i2c_acpi_match[] =3D {
-=09{ .id =3D "SMO2101" },
-=09{ .id =3D "SMO2102" },
-=09{ }
+static const struct acpi_device_id st_nci_i2c_acpi_match[] __maybe_unused =
=3D {
+=09{"SMO2101"},
+=09{"SMO2102"},
+=09{}
 };
 MODULE_DEVICE_TABLE(acpi, st_nci_i2c_acpi_match);
=20
-static const struct of_device_id of_st_nci_i2c_match[] =3D {
-=09{ .compatible =3D "st,st21nfcb-i2c" },
-=09{ .compatible =3D "st,st21nfcb_i2c" },
-=09{ .compatible =3D "st,st21nfcc-i2c" },
-=09{ }
+static const struct of_device_id of_st_nci_i2c_match[] __maybe_unused =3D =
{
+=09{ .compatible =3D "st,st21nfcb-i2c", },
+=09{ .compatible =3D "st,st21nfcb_i2c", },
+=09{ .compatible =3D "st,st21nfcc-i2c", },
+=09{ .compatible =3D "st,st21nfcd",
+=09  .data =3D (void *)ST_NCI_I2C_PROTO_RAW_NCI },
+=09{}
 };
 MODULE_DEVICE_TABLE(of, of_st_nci_i2c_match);
=20
diff --git a/drivers/nfc/st-nci/ndlc.c b/drivers/nfc/st-nci/ndlc.c
index be4808859..b3192460c 100644
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
index c24ce9b0d..5c1f8baf0 100644
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
index 607ec768e..44cc102bc 100644
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

--=20
2.55.0


