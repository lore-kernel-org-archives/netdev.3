Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8952F8E93
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790571012; cv=none; b=m4jL0Gh3tYeNXhg9sVIJPjgEaA66xLF1JKIv+mH0TM7vLlUNVgae/33SgQiGzyq8L6hF6aATmOGbG0lrmReDtr1glNB4W3Ces1kbQXTnojYoEo6K4u4/e0nDNOC9cIByCQgkTfkYCmqQ+7RXApsagvdLfiuPC59IUkAd1vzpUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790571012; c=relaxed/simple;
	bh=iIoekgFab81OFiXTGiIRoZtMuVVe9MzTU716fSB8Tvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JYb2va3pBI7fLE6DTLZL5qLT7Ftmi5rzA1rc3MT261MXyOuY072lTWq9mtXkzs5zJs++A382vrZEkdWPenIMGyOKdDZT4Hs1MEoIzx34uHJreGmJbpHapIuGDNDcxndXkW85+07edMfOWz+um+xeKvrv3N1nHZ1IbRYkOuXT/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=q-lab.dev; spf=pass smtp.mailfrom=q-lab.dev; dkim=pass (2048-bit key) header.d=q-lab.dev header.i=@q-lab.dev header.b=ePDXhUSY; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=nOh8GLBb; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=q-lab.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=q-lab.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=q-lab.dev header.i=@q-lab.dev header.b="ePDXhUSY";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="nOh8GLBb"
DKIM-Signature: a=rsa-sha256; b=ePDXhUSY5lc5Uq5xX+SKH6zMZp6Sm9y9xcyymaaGJ8mFECNvIFgzqWPHKz+uBz0KDrpJ0A2Ish9U0h3jQRPsRmihbVMg6ghxrlqVBegdoeYIBl7ml9cdWDujEQQi1a544QWmrtCEogFr3kzaLkFDvAqmJKzyAuroA5u02G7kdXt6FB+EV9N9OokpXuyaZnThjElhwk+4x/MGM8KLVxCA0ymAb4a/KSpqm6pavbtPPW5rHt1hGOF3oFu7Gn0D2ASaLWPN/6dKh02MWG1TMavxlWJNtQmrT8hiJkPChXwvktsOhdfOL0DUWPwx+jbXXS5G7UmmDuuMg6HbNQN+jWZqXg==; s=purelymail3; d=q-lab.dev; v=1; bh=iIoekgFab81OFiXTGiIRoZtMuVVe9MzTU716fSB8Tvk=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=nOh8GLBbymmOZtBv9lrOCw9yOGJR3TNfCH4yIaxhFoUQXwgsMIALjdd6cj58enxbRg9R4ti1etsN7JJe3h9rwBGzca0RPCgyf0SHGWOBojDCY8qvzzRE/Wf9s66pcSQHO/Y/z+5T8AHRKV4ToVqiEt/xKhPBPZzSLyfcDXTNUW4s0kQ2diu27FMNv48+qZL+Xb+pv5F1izk6/K4gKlRWMZxbEUkVNsNRwLNR1dj27xOy6G8k7Pg+cD3FiaXrfeaq18zG5bl3i4ZCSJOMPMER3eYKtggxvOZiG1wFzBKaBDBqsgdSJGYl3GXXlP3sqfNC5FzQjlLs8Zp4X/2ht0cvNA==; s=purelymail3; d=purelymail.com; v=1; bh=iIoekgFab81OFiXTGiIRoZtMuVVe9MzTU716fSB8Tvk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 284201:25281:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 877452934;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 28 Sep 2026 04:50:08 +0000 (UTC)
From: Quentin Freimanis <quentin@q-lab.dev>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: sparx5: start the domain 0 TOD counter on non-PTP lan969x variants
Date: Sun, 27 Sep 2026 21:47:33 -0700
Message-ID: <20260928044955.29647-1-quentin@q-lab.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Currently the base non-PTP capable lan969x variants don't forward any
ethernet frames. Testing showed that starting the domain 0 TOD counter
gets them working again.

Fix by moving the TOD counter start code into a helper and calling it in
sparx5_ptp_init(). Non-PTP capable lan969x parts now start the domain 0
counter, and PTP-capable parts start all three, as they used to. A similar
workaround that starts all three and registers the PHC clocks is
implemented in the vendor BSP 6.18 kernel [1].

[1] https://github.com/microchip-ung/linux/tree/bsp-6.18-2026

Fixes: 207966787b71 ("net: sparx5: add feature support")
Signed-off-by: Quentin Freimanis <quentin@q-lab.dev>
---
If anyone with access to documentation more detailed than the
register map knows WHY this clock needs to be running, I'd like to add
that to the commit message.

 .../ethernet/microchip/sparx5/sparx5_ptp.c    | 72 +++++++++++++------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/n=
et/ethernet/microchip/sparx5/sparx5_ptp.c
index 5953e04ef14e..b436684ddae6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
@@ -573,6 +573,42 @@ static int sparx5_ptp_adjtime(struct ptp_clock_info *p=
tp, s64 delta)
 =09return 0;
 }
=20
+static int sparx5_ptp_tod_start(struct sparx5 *sparx5, u8 phc_mask)
+{
+=09u64 tod_adj =3D sparx5_ptp_get_nominal_value(sparx5);
+=09int i;
+
+=09if (phc_mask > GENMASK(SPARX5_PHC_COUNT - 1, 0))
+=09=09return -EINVAL;
+
+=09/* Disable master counters */
+=09spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0), sparx5, PTP_PTP_DOM_CFG);
+
+=09/* Configure the nominal TOD increment per clock cycle */
+=09spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(phc_mask),
+=09=09 PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
+=09=09 sparx5, PTP_PTP_DOM_CFG);
+
+=09for (i =3D 0; i < SPARX5_PHC_COUNT; ++i) {
+=09=09if (!(phc_mask & BIT(i)))
+=09=09=09continue;
+
+=09=09spx5_wr((u32)tod_adj & 0xFFFFFFFF, sparx5,
+=09=09=09PTP_CLK_PER_CFG(i, 0));
+=09=09spx5_wr((u32)(tod_adj >> 32), sparx5,
+=09=09=09PTP_CLK_PER_CFG(i, 1));
+=09}
+
+=09spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(0),
+=09=09 PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
+=09=09 sparx5, PTP_PTP_DOM_CFG);
+
+=09/* Enable master counters */
+=09spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(phc_mask), sparx5, PTP_PTP_DOM_CFG)=
;
+
+=09return 0;
+}
+
 static struct ptp_clock_info sparx5_ptp_clock_info =3D {
 =09.owner=09=09=3D THIS_MODULE,
 =09.name=09=09=3D "sparx5 ptp",
@@ -605,7 +641,6 @@ static int sparx5_ptp_phc_init(struct sparx5 *sparx5,
=20
 int sparx5_ptp_init(struct sparx5 *sparx5)
 {
-=09u64 tod_adj =3D sparx5_ptp_get_nominal_value(sparx5);
 =09const struct sparx5_ops *ops =3D sparx5->data->ops;
 =09struct sparx5_port *port;
 =09int err, i;
@@ -622,8 +657,17 @@ int sparx5_ptp_init(struct sparx5 *sparx5)
 =09=09sparx5->ptp =3D 1;
 =09}
=20
-=09if (!sparx5->ptp)
+=09if (!sparx5->ptp) {
+=09=09if (!is_sparx5(sparx5)) {
+=09=09=09/* the base, non-ptp-capable lan969x variants need the first tod =
counter
+=09=09=09 * running to forward frames.
+=09=09=09 */
+=09=09=09err =3D sparx5_ptp_tod_start(sparx5, BIT(0));
+=09=09=09if (err)
+=09=09=09=09return err;
+=09=09}
 =09=09return 0;
+=09}
=20
 =09for (i =3D 0; i < SPARX5_PHC_COUNT; ++i) {
 =09=09err =3D sparx5_ptp_phc_init(sparx5, i, &sparx5_ptp_clock_info);
@@ -635,27 +679,9 @@ int sparx5_ptp_init(struct sparx5 *sparx5)
 =09spin_lock_init(&sparx5->ptp_ts_id_lock);
 =09mutex_init(&sparx5->ptp_lock);
=20
-=09/* Disable master counters */
-=09spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0), sparx5, PTP_PTP_DOM_CFG);
-
-=09/* Configure the nominal TOD increment per clock cycle */
-=09spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(0x7),
-=09=09 PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
-=09=09 sparx5, PTP_PTP_DOM_CFG);
-
-=09for (i =3D 0; i < SPARX5_PHC_COUNT; ++i) {
-=09=09spx5_wr((u32)tod_adj & 0xFFFFFFFF, sparx5,
-=09=09=09PTP_CLK_PER_CFG(i, 0));
-=09=09spx5_wr((u32)(tod_adj >> 32), sparx5,
-=09=09=09PTP_CLK_PER_CFG(i, 1));
-=09}
-
-=09spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(0),
-=09=09 PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
-=09=09 sparx5, PTP_PTP_DOM_CFG);
-
-=09/* Enable master counters */
-=09spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0x7), sparx5, PTP_PTP_DOM_CFG);
+=09err =3D sparx5_ptp_tod_start(sparx5, GENMASK(SPARX5_PHC_COUNT - 1, 0));
+=09if (err)
+=09=09return err;
=20
 =09for (i =3D 0; i < sparx5->data->consts->n_ports; i++) {
 =09=09port =3D sparx5->ports[i];
--=20
2.55.0

