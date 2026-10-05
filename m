Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AB2386C25;
	Mon,  5 Oct 2026 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233528; cv=none; b=AxaQOSgjIlvj6SSVFsmItcGHT9dwl+ypkxy57qxWUbF/A05fVgnpswNm6AjUlPJ0NBqahXkW7qLtxkN0GyztZpisKT2gIlGHIQlzMGm9K6qJOqeHmRKuVHoDO39vEYeee6/8I1vso1EuplwamOCtvSrsd4ni602Zn9AO0jBXw3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233528; c=relaxed/simple;
	bh=6lSC1deBS9CmK9ITNozzL3oll30sYGZ1mhTvQlGabBc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjjEyxZP9yq1MVqTb/CRoA7oC0hk0Gmupz0OK6i7ooZszP6gLo6+HotE9fhvgG+YT9f/oIU11u8aTkUL95yXdl1U45AWdTtSf8ArVemR9qo9Vdc8r1+D9ZTsR+0vEWzp2QI+N1ZCoqie5Wx1HQncaZDAD+yAMUTciVlHueBZPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UquTpF9x; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UquTpF9x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791233515; x=1791492715;
	bh=0Pd0CZzl+xGpCpQOKEPKPjcs7dVAk5+m4WJhcOweMo0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UquTpF9xwAW599AH6fdzA9k7Oy+3SWarP9EO58bG1vE1Ug700EjkfWM4CyJlFl7zT
	 4n+5+2phYmiYTgq0YEUvr59LzajtJCg8GTIHlthRz1Sd8VEXWhYFA9ekbyfbP0PIog
	 lNsMym3MqS1cJwWQlvr+N1Js0OHJqb0VEk5hlwB4GphV8gLeHlQj0H7EFH+v+R8RCV
	 Oa5/23q9wS0yph/mN9DlLwMwPNHILKYg5o/bnLtmCrIjoCr65qdNN2oamQbiP0PNHm
	 /2szmc/bgx6oY2j5glsYlTcy7lJ8cNDBcIPg7s+RT5eV0ttkS0aoCQe3mF4jVd+Zv6
	 Bab68eaSTqW0Q==
Date: Mon, 05 Oct 2026 20:51:52 +0000
To: David Heidelberg <david@ixit.cz>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
From: Kristian Brox <isyourbrainfoss@proton.me>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Kristian Brox <isyourbrainfoss@proton.me>
Subject: [PATCH v5 2/4] nfc: st-nci: add raw NCI path for ST21NFCD
Message-ID: <20261005-fp5-st21nfcd-v5-v5-2-7be15a86c61c@proton.me>
In-Reply-To: <20261005-fp5-st21nfcd-v5-v5-0-7be15a86c61c@proton.me>
References: <20261005-fp5-st21nfcd-v5-v5-0-7be15a86c61c@proton.me>
Feedback-ID: 203906395:user:proton
X-Pm-Message-ID: d45c38fb936f9e92dbad2d433f8053c8a33b290d
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
- consume proprietary RF NTF 0xf02 (GID 0xf, OID 0x02)

Set the raw_nci flag before nci_register_device so ndlc_send does
not push an NDLC PCB into a 0-headroom skb. Enable optional vdd-io
(VPS_IO) and SYS_CLK before driving reset.

Reset is active-low. Existing boards describe it as GPIO_ACTIVE_HIGH
and the driver treats gpiod_set_value(reset, 1) as chip-running.
Keep that path so old DTS is unchanged. If the GPIO is active-low,
pulse logical 1 then 0 (assert, then deassert).

Existing st21nfcb / st21nfcc boards keep the NDLC path and do not
need those properties.

Tested on Fairphone 5: adapter powers up and reads an NTAG 215.

Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
---
 drivers/nfc/st-nci/core.c   | 22 ++++++++++++
 drivers/nfc/st-nci/i2c.c    | 82 +++++++++++++++++++++++++++++++++++++++++=
+---
 drivers/nfc/st-nci/ndlc.c   | 27 +++++++++++----
 drivers/nfc/st-nci/ndlc.h   |  5 ++-
 drivers/nfc/st-nci/se.c     |  3 ++
 drivers/nfc/st-nci/spi.c    |  2 +-
 drivers/nfc/st-nci/st-nci.h |  2 ++
 7 files changed, 129 insertions(+), 14 deletions(-)

diff --git a/drivers/nfc/st-nci/core.c b/drivers/nfc/st-nci/core.c
index a367136d4..d7802434a 100644
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
@@ -84,12 +89,29 @@ static int st_nci_prop_rsp_packet(struct nci_dev *ndev,
 =09return 0;
 }
=20
+/*
+ * ST21NFCD emits proprietary NCI NTFs (GID 0xf, OID 0x02) on CORE_RESET
+ * and during each RF poll loop. The payload is an RF trace; tags are
+ * still reported with the standard RF_INTF_ACTIVATED_NTF. Consume the
+ * packet so nci_ntf_packet does not log "unsupported ntf opcode 0xf02".
+ */
+static int st_nci_prop_rf_ntf_packet(struct nci_dev *ndev,
+=09=09=09=09     struct sk_buff *skb)
+{
+=09return 0;
+}
+
 static const struct nci_driver_ops st_nci_prop_ops[] =3D {
 =09{
 =09=09.opcode =3D nci_opcode_pack(NCI_GID_PROPRIETARY,
 =09=09=09=09=09  ST_NCI_CORE_PROP),
 =09=09.rsp =3D st_nci_prop_rsp_packet,
 =09},
+=09{
+=09=09.opcode =3D nci_opcode_pack(NCI_GID_PROPRIETARY,
+=09=09=09=09=09  ST_NCI_PROP_RF_NTF),
+=09=09.ntf =3D st_nci_prop_rf_ntf_packet,
+=09},
 };
=20
 static const struct nci_ops st_nci_ops =3D {
diff --git a/drivers/nfc/st-nci/i2c.c b/drivers/nfc/st-nci/i2c.c
index 152c20b6b..2ec029f31 100644
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
@@ -44,9 +55,20 @@ static int st_nci_i2c_enable(void *phy_id)
 {
 =09struct st_nci_i2c_phy *phy =3D phy_id;
=20
-=09gpiod_set_value(phy->gpiod_reset, 0);
-=09usleep_range(10000, 15000);
-=09gpiod_set_value(phy->gpiod_reset, 1);
+=09/*
+=09 * Existing DTS uses GPIO_ACTIVE_HIGH and treats logical 1 as
+=09 * chip-running. GPIO_ACTIVE_LOW: logical 1 asserts reset
+=09 * (physical LOW).
+=09 */
+=09if (gpiod_is_active_low(phy->gpiod_reset)) {
+=09=09gpiod_set_value(phy->gpiod_reset, 1);
+=09=09usleep_range(10000, 15000);
+=09=09gpiod_set_value(phy->gpiod_reset, 0);
+=09} else {
+=09=09gpiod_set_value(phy->gpiod_reset, 0);
+=09=09usleep_range(10000, 15000);
+=09=09gpiod_set_value(phy->gpiod_reset, 1);
+=09}
 =09usleep_range(80000, 85000);
=20
 =09if (phy->ndlc->powered =3D=3D 0 && phy->irq_active =3D=3D 0) {
@@ -111,6 +133,42 @@ static int st_nci_i2c_read(struct st_nci_i2c_phy *phy,
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
@@ -211,6 +269,8 @@ static int st_nci_i2c_probe(struct i2c_client *client)
 =09=09return -ENOMEM;
=20
 =09phy->i2c_dev =3D client;
+=09phy->raw_nci =3D (uintptr_t)device_get_match_data(dev) =3D=3D
+=09=09=09ST_NCI_I2C_PROTO_RAW_NCI;
=20
 =09i2c_set_clientdata(client, phy);
=20
@@ -218,6 +278,14 @@ static int st_nci_i2c_probe(struct i2c_client *client)
 =09if (r)
 =09=09dev_dbg(dev, "Unable to add GPIO mapping table\n");
=20
+=09r =3D devm_regulator_get_enable_optional(dev, "vdd-io");
+=09if (r && r !=3D -ENODEV)
+=09=09return dev_err_probe(dev, r, "failed to enable vdd-io\n");
+
+=09r =3D PTR_ERR_OR_ZERO(devm_clk_get_optional_enabled(dev, NULL));
+=09if (r)
+=09=09return dev_err_probe(dev, r, "failed to enable clock\n");
+
 =09/* Get RESET GPIO */
 =09phy->gpiod_reset =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 =09if (IS_ERR(phy->gpiod_reset)) {
@@ -231,8 +299,10 @@ static int st_nci_i2c_probe(struct i2c_client *client)
 =09=09=09=09device_property_read_bool(dev, "uicc-present");
=20
 =09r =3D ndlc_probe(phy, &i2c_phy_ops, &client->dev,
-=09=09=09ST_NCI_FRAME_HEADROOM, ST_NCI_FRAME_TAILROOM,
-=09=09=09&phy->ndlc, &phy->se_status);
+=09=09=09phy->raw_nci ? ST_NCI_RAW_FRAME_HEADROOM :
+=09=09=09=09       ST_NCI_FRAME_HEADROOM,
+=09=09=09ST_NCI_FRAME_TAILROOM,
+=09=09=09&phy->ndlc, &phy->se_status, phy->raw_nci);
 =09if (r < 0) {
 =09=09nfc_err(&client->dev, "Unable to register ndlc layer\n");
 =09=09return r;
@@ -273,6 +343,8 @@ static const struct of_device_id of_st_nci_i2c_match[] =
=3D {
 =09{ .compatible =3D "st,st21nfcb-i2c" },
 =09{ .compatible =3D "st,st21nfcb_i2c" },
 =09{ .compatible =3D "st,st21nfcc-i2c" },
+=09{ .compatible =3D "st,st21nfcd",
+=09  .data =3D (void *)ST_NCI_I2C_PROTO_RAW_NCI },
 =09{ }
 };
 MODULE_DEVICE_TABLE(of, of_st_nci_i2c_match);
diff --git a/drivers/nfc/st-nci/ndlc.c b/drivers/nfc/st-nci/ndlc.c
index be4808859..13026c4fa 100644
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
@@ -251,7 +262,8 @@ static void ndlc_t2_timeout(struct timer_list *t)
=20
 int ndlc_probe(void *phy_id, const struct nfc_phy_ops *phy_ops,
 =09       struct device *dev, int phy_headroom, int phy_tailroom,
-=09       struct llt_ndlc **ndlc_id, struct st_nci_se_status *se_status)
+=09       struct llt_ndlc **ndlc_id, struct st_nci_se_status *se_status,
+=09       bool raw_nci)
 {
 =09struct llt_ndlc *ndlc;
=20
@@ -263,6 +275,7 @@ int ndlc_probe(void *phy_id, const struct nfc_phy_ops *=
phy_ops,
 =09ndlc->phy_id =3D phy_id;
 =09ndlc->dev =3D dev;
 =09ndlc->powered =3D 0;
+=09ndlc->raw_nci =3D raw_nci;
=20
 =09*ndlc_id =3D ndlc;
=20
diff --git a/drivers/nfc/st-nci/ndlc.h b/drivers/nfc/st-nci/ndlc.h
index c24ce9b0d..0b12e12e4 100644
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
@@ -47,6 +49,7 @@ int ndlc_send(struct llt_ndlc *ndlc, struct sk_buff *skb)=
;
 void ndlc_recv(struct llt_ndlc *ndlc, struct sk_buff *skb);
 int ndlc_probe(void *phy_id, const struct nfc_phy_ops *phy_ops,
 =09       struct device *dev, int phy_headroom, int phy_tailroom,
-=09       struct llt_ndlc **ndlc_id, struct st_nci_se_status *se_status);
+=09       struct llt_ndlc **ndlc_id, struct st_nci_se_status *se_status,
+=09       bool raw_nci);
 void ndlc_remove(struct llt_ndlc *ndlc);
 #endif /* __LOCAL_NDLC_H__ */
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
diff --git a/drivers/nfc/st-nci/spi.c b/drivers/nfc/st-nci/spi.c
index 7948c7e0c..1ce80a85b 100644
--- a/drivers/nfc/st-nci/spi.c
+++ b/drivers/nfc/st-nci/spi.c
@@ -246,7 +246,7 @@ static int st_nci_spi_probe(struct spi_device *dev)
=20
 =09r =3D ndlc_probe(phy, &spi_phy_ops, &dev->dev,
 =09=09=09ST_NCI_FRAME_HEADROOM, ST_NCI_FRAME_TAILROOM,
-=09=09=09&phy->ndlc, &phy->se_status);
+=09=09=09&phy->ndlc, &phy->se_status, false);
 =09if (r < 0) {
 =09=09nfc_err(&dev->dev, "Unable to register ndlc layer\n");
 =09=09return r;
diff --git a/drivers/nfc/st-nci/st-nci.h b/drivers/nfc/st-nci/st-nci.h
index 5286071e5..aa8782c95 100644
--- a/drivers/nfc/st-nci/st-nci.h
+++ b/drivers/nfc/st-nci/st-nci.h
@@ -15,6 +15,8 @@
=20
 #define ST_NCI_CORE_PROP                0x01
 #define ST_NCI_SET_NFC_MODE             0x02
+/* ST21NFCD proprietary RF activity / poll-trace notification (GID 0xf) */
+#define ST_NCI_PROP_RF_NTF=09=090x02
=20
 /*
  * ref ISO7816-3 chap 8.1. the initial character TS is followed by a

--=20
2.55.0


