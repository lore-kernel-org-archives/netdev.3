Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C463BBFAD;
	Fri,  7 Aug 2026 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122702; cv=none; b=Pl0GidO4nAgZ5ysa9uFR/LTji7fU/rRsYutFhP01KaNILLU00fwqw37lpLTR4SsziQ1PnKYcHD6fwDM9leA54cE9z34T+NUuqI9cR2NjmDZ1PdCpRG29KhSUpuHYZg04abeURts3dpKbTnOxugZlDIklU7a+FKhccknQ1rYf2wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122702; c=relaxed/simple;
	bh=D2op0H8rscdQaXbyRzduW5xgqeAtuc4LL7rF+Bqp2mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a97g0UZV/9WEZBQkupXVOSwSfLJmnHjVVqffJ3OIZDY/IrpMlQXKSNjHlqfd0VVPOmL7BTbkoNCkBuizRc1FX1WhEQ6T3XsBiI12jaajtaV/H/dWS1In8CihhzmGpEgetNmbqUdTzU7IbcDs2Bss3xvytLGfzSA5EoGVyKXpetE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=E+PiW7Hj; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="E+PiW7Hj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786122674; x=1786727474;
	i=markus.stockhausen@gmx.de;
	bh=EezFUe8vNFwbR0Nogujwd/VzqfsRn3uE7GyHT/UT0rY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E+PiW7Hjji98l2M9/PglLGR9RmxAK3saI5ro4CMl4NzzAIuA7pbenL9kWI1cIDVy
	 JB58z0GLCqLP9aPHGvjF4z6nKpMjLKZYNt0ddvwOORJ1/9XAkp/laef/tDactu6s/
	 4/Fq4Re+gc9ZTIEv6INHSnD4ANK0XUWbmTReTkylyjceK66ECzFAaYWgLtMo+Rrco
	 ivkjRp3SCH2tx7a7Cpm9o47jfbM8qVgKtuL1nFaIbX+BIsUBYrnkJt6jB7/AAUM4F
	 KK06Q9dMubt/5GEUEQ70QXsxkfqokgRLUrWNNlSHDc1eJu+G12UGQHDE6ovPaApue
	 McZkvn1mWBsQKxheRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRMs-1wTCnu0lRc-00VgQ0; Fri, 07
 Aug 2026 19:11:14 +0200
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
Subject: [PATCH net-next v13 09/11] net: mdio: realtek-rtl9300: Add support for RTL838x
Date: Fri,  7 Aug 2026 19:10:56 +0200
Message-ID: <20260807171058.522833-10-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807171058.522833-1-markus.stockhausen@gmx.de>
References: <20260807171058.522833-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f8RvHKAj0TBPAxzDspcgv+eLNx234aMmuFPoug48Mj36Xh072x8
 Tg/e6jDCccUYLVRvMPMWYsut6RtNUE8gUi68u1iIvWnmTII9lEmqf+5Mkhjzwc0E6f9qHCt
 i1ixmZHk83g31JenEFNivXHH/ed6BhUEOlICne/VFqKrQM65CSJlNCzTLVFeoQ9d2P1Nbx6
 qB0cBmmovM6JBWjTrb6nQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LHImfWKSgpk=;A6uFIeTOtK+ATC9MB0V4Zsj+okC
 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
 v9JdiW3KsQaMLsUS/QY=

The MDIO driver has been prepared for multiple device support. Add all
required bits for the RTL838x (aka maple) series. This is straightforward
but some things are worth mentioning.

- The device has a lot in common with the RTL930x series. It has 28 ports,
  4096 (Realtek) pages and 4 MMIO registers. With this a lot of the
  existing RTL9300 defines could be reused. But to avoid confusion and
  for better readability duplicate the defines with a proper prefix.
- The MDIO engine has no fail bit. Thus the mask is set to zero.
- There is only one SMI bus for 1G PHYs. No bus_map_base register exists.
- The setup_controller() function needs no C45 setup but must activate
  the PHY access.

As per the SDK the PHYs on a RTl83xx bus are mainly C22 driven. The
polling unit works in C22 mode and the devicetree usually does not
make use of the ethernet-phy-ieee802.3-c45 flag. Nevertheless there are
some PHY MMD registers (e.g. EEE) that might be of interest for the
future development of the hardware. Until that is really needed keep
the C45 read/write helpers out of the driver.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 80 +++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 22b1c4e05354..6e37a3f52b5e 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -125,6 +125,28 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
=20
+#define RTL8380_NUM_BUSES			1
+#define RTL8380_NUM_PAGES			4096
+#define RTL8380_NUM_PORTS			28
+#define RTL8380_SMI_GLB_CTRL			0xa100
+#define   RTL8380_SMI_PHY_PATCH_DONE		BIT(15)
+#define RTL8380_SMI_ACCESS_PHY_CTRL_0		0xa1b8
+#define RTL8380_SMI_ACCESS_PHY_CTRL_1		0xa1bc
+#define   RTL8380_PHY_CTRL_REG_ADDR		GENMASK(24, 20)
+#define   RTL8380_PHY_CTRL_PARK_PAGE		GENMASK(19, 15)
+#define   RTL8380_PHY_CTRL_MAIN_PAGE		GENMASK(14, 3)
+#define   RTL8380_PHY_CTRL_WRITE		BIT(2)
+#define   RTL8380_PHY_CTRL_READ			0
+#define   RTL8380_PHY_CTRL_TYPE_C45		BIT(1)
+#define   RTL8380_PHY_CTRL_TYPE_C22		0
+#define   RTL8380_PHY_CTRL_FAIL			0 /* no fail indicator */
+#define RTL8380_SMI_ACCESS_PHY_CTRL_2		0xa1c0
+#define   RTL8380_PHY_CTRL_INDATA		GENMASK(31, 16)
+#define   RTL8380_PHY_CTRL_DATA			GENMASK(15, 0)
+#define RTL8380_SMI_ACCESS_PHY_CTRL_3		0xa1c4
+#define RTL8380_SMI_POLL_CTRL			0xa17c
+#define RTL8380_SMI_PORT0_5_ADDR_CTRL		0xa1c8
+
 #define RTL9300_NUM_BUSES			4
 #define RTL9300_NUM_PAGES			4096
 #define RTL9300_NUM_PORTS			28
@@ -352,6 +374,34 @@ static int otto_emdio_write_cmd(struct mii_bus *bus, =
u32 cmd,
 	return otto_emdio_run_cmd(bus, cmd | priv->info->cmd_write, cmd_data);
 }
=20
+static int otto_emdio_8380_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_PARK_PAGE, 0x1f) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8380_PHY_CTRL_TYPE_C22, &cmd_data,
+				   RTL8380_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8380_write_c22(struct mii_bus *bus, int port, int r=
egnum, u16 value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_PARK_PAGE, 0x1f) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, value),
+		.port_mask_low	=3D BIT(port),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8380_PHY_CTRL_TYPE_C22, &cmd_data);
+}
+
 static int otto_emdio_9300_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
@@ -572,6 +622,15 @@ static int otto_emdio_setup_topology(struct otto_emdi=
o_priv *priv)
 	return 0;
 }
=20
+static int otto_emdio_8380_setup_controller(struct otto_emdio_priv *priv)
+{
+	/*
+	 * PHY_PATCH_DONE enables PHY control via SoC. This is required for PHY =
access, including
+	 * patching and must be set before the PHYs are probed.
+	 */
+	return regmap_set_bits(priv->regmap, RTL8380_SMI_GLB_CTRL, RTL8380_SMI_P=
HY_PATCH_DONE);
+}
+
 static int otto_emdio_9300_setup_controller(struct otto_emdio_priv *priv)
 {
 	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
@@ -868,6 +927,26 @@ static int otto_emdio_probe(struct platform_device *p=
dev)
 	return 0;
 }
=20
+static const struct otto_emdio_info otto_emdio_8380_info =3D {
+	.addr_map_base =3D RTL8380_SMI_PORT0_5_ADDR_CTRL,
+	.cmd_fail =3D RTL8380_PHY_CTRL_FAIL,
+	.cmd_read =3D RTL8380_PHY_CTRL_READ,
+	.cmd_write =3D RTL8380_PHY_CTRL_WRITE,
+	.cmd_regs =3D {
+		.c22_data =3D RTL8380_SMI_ACCESS_PHY_CTRL_1,
+		.c45_data =3D RTL8380_SMI_ACCESS_PHY_CTRL_3,
+		.io_data =3D RTL8380_SMI_ACCESS_PHY_CTRL_2,
+		.port_mask_low =3D RTL8380_SMI_ACCESS_PHY_CTRL_0,
+	},
+	.num_buses =3D RTL8380_NUM_BUSES,
+	.num_pages =3D RTL8380_NUM_PAGES,
+	.num_ports =3D RTL8380_NUM_PORTS,
+	.poll_ctrl =3D RTL8380_SMI_POLL_CTRL,
+	.setup_controller =3D otto_emdio_8380_setup_controller,
+	.read_c22 =3D otto_emdio_8380_read_c22,
+	.write_c22 =3D otto_emdio_8380_write_c22,
+};
+
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
 	.addr_map_base =3D RTL9300_SMI_PORT0_5_ADDR_CTRL,
 	.bus_map_base =3D RTL9300_SMI_PORT0_15_POLLING_SEL,
@@ -918,6 +997,7 @@ static const struct otto_emdio_info otto_emdio_9310_in=
fo =3D {
 };
=20
 static const struct of_device_id otto_emdio_ids[] =3D {
+	{ .compatible =3D "realtek,rtl8380-mdio", .data =3D &otto_emdio_8380_inf=
o },
 	{ .compatible =3D "realtek,rtl9301-mdio", .data =3D &otto_emdio_9300_inf=
o },
 	{ .compatible =3D "realtek,rtl9311-mdio", .data =3D &otto_emdio_9310_inf=
o },
 	{}
=2D-=20
2.55.0

