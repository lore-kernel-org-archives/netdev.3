Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.190.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749007;
	b=HkSfvuKeyg7ov0OEspYvWiFyCg03Rlp5OekxNwjIeGlNs84K3PIxBJQBh2opLoWU46Nz
	 3oMfYFGM/96FnDt9z8Fga9I4kmMM2wpc8qy6yGjEJ74kn8rLIdJGOoGJSvJmft8akMUuR
	 F1yY0W5V6dIaRlb7MyEei0stg+HWl/lgiyK2nH9Bt2dDQmNl2c14P0A5IKCYunOcxBDG0
	 kV/n1sdE0bbnlT/QS16e/Uq2ON7UIKdVtc+6oUIACJnNp8y0mZVrZw11gLXJ4Gop3K/YQ
	 wStHlHm4/kQVTof6YQiwRIc3HLBV58LzaHCMjIpN182urhToafv7BNrHPCN8p8orzcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749007;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=BAoLtm1ybD24fMTzIkHI69eKd9ry6dpssW93hrBxPU0=;
	b=wbNVC6wccyQez9cqpuAmlBD/70CG8/Vj1GUrGr50E5Ohp8gI3RMdagZ28QQETLZkM/PJ
	 fMjNVfNPWwSpDQFbiDY69z4HmtnS5k7jNaQ32Tv9oHWxo67cJzrr+vDsL4aTXqH7XK7af
	 sSQ/6Jk2RAJS3naKQDreR0qt56qHHH/KlzndvMcPdyPLgnTrHcfuj0vD+vFOfYL/PsjzR
	 AMY97IhXN17dpDT26yp9oNIAnoTTeJbIXR9lOMr2IOKWiM2ocwJhsBSSYkDt29UMYxUlZ
	 jttjasNIVdHGSDp6QLIquy63UHjSpGAO9OX8MrPwaqRK6tsSxCKyobN6Tg5xPXEx0QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=qoTqUZmC;
	arc=none smtp.remote-ip=66.163.190.147
Received: from sonic315-21.consmr.mail.ne1.yahoo.com (sonic315-21.consmr.mail.ne1.yahoo.com [66.163.190.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1499F606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1499F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=qoTqUZmC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793749006; bh=BAoLtm1ybD24fMTzIkHI69eKd9ry6dpssW93hrBxPU0=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=qoTqUZmCBGmlvuc5cOidpAWUgfiU3ks+LGdo2hvUOJ8pDLAi5y8D9Gr9pvNCQA8x7K2Uy8GZLBcCv5SBckMKA4vuerMMqXj1ieQRQZ1Bkc7Nca2QJ/Nw2N5EEO2ggU8qko9dxO8Ww6GNPtWYMSeifGwcamqT4nImwweJM4GczMuBF0YyVG5UBvCDyVYaoLFUSKol0+QqA1M4hVuLrk774l2TmAa88Lnrb0eVYcgV771YBODZhBi6Csss0no6JZh66bPdC65r28hPYZbpsi3js/q8aCPpxyxSbUKgKvYgC/KZUVM20t9bwE/udaUlXYOIB90XpI7wnoq5pqNBTQ5TZw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793749006; bh=Ly64UU/LJQNdnBQ3HPT9Jzw3+dlQe53Cex+shtYtYzn=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=QLmGBgFAUvhODb72SB5NmKKBPfp49qfekkzkHxBjmr0jBNT/gq6B7NxgJuPfd5hsGVSeABcO3QEUoex8YerHIGJ7YU+K7RAaWpCdKBHNJS6qtGo83lBWEL6F30a6ybrjd+YC2tnPuS+S8uC+b1jUkhblRnk/eoPpKwRRrLhROysSt+rAIsOlgQ0R7yn1bNR/m/xjdzrY+1dBTDGa72VD78XwfPEMYUcxm+lbAHNvuBhcqfmojHmlw+Idhsip1II16LZNU3nrrvLlDYQ7q/lH/zLyfh8zBDRTSV0FbFFLy4q+9NFGhjQQDF7LsTSByQPVpm/wg3WgFunRpspfwFG4dg==
X-YMail-OSG: R4y40rsVM1nYh44o2aLDEHwThZ8vuigi1_avblJqOz.Xts.p.Adm.o0IsrV8Y9o
 fPbWp0ErlYqvh5t1tbmltgaUUiRlvDkx1Ee3XJkdyTP2QmgTRvNDMnjOjSx_O0uJ4XSodJnvQwov
 3KngPj9aJY71.WbP_3RMp6Rd0NcTafCNGLKO8V1KcZu23F06nz1UxSTZ0f0_0wIX1j.7oEsCjvRJ
 L.u9tXpgrDLavhN2cw58gx_qcr5.Lb7YTigvM7DiXUngfSrWa80KMyPI5DZRZPPuElfUDMP7LsVc
 oKQrhc6zfDLrdoxaMz15EIG9Gfz8nXn4zwGmLOg5rtp.9.yFdZFhOyQTFAJSwu.ZPVZ3zgr_d_uO
 8S_jF5wJDZMAI732_ve2FyFcR0Fedh8yaLttyspZY0Nh33sI3PY4YJEbTyWTw0qt5PDDcPR6g5Ks
 cuUzTbswMiTGm3vDNzSiMv24faTwmZmo.2kRESqleTRu1a80oy0BeGzat2KQVks4Qq7NbBfTJNLp
 NN8.itFPKPMEwWPz3yX.IUHSDAhHGs4lexe7kx.LUJsv4BBX7iuHXmSRkck3YD3_vKYkW0igciqs
 GaUqv5DFCSTKAU1ZNJNaLIQnoZrHwE_NGnNC3Bur_Y4L4wnt_IlcYHak9RpCZiFQA3E.bE8CUtW9
 ET9jL3w3jH4URGfjOAij22MMDuldke9hbq4KpxnQrTFZyTg0pvW2dGZ1ul1MpbN2GxUy_RORETkP
 2pCXsct3LU6ucr6zHA0jHS7AOjLI4RN706X.tFADKBUlrtJ5AEpYLIODsDgConuPaWhIWt2Gp1Pr
 hQk2PGSFdH9dEfW28yndN.M4PNuaIUWLc983qVzqwOySPQLfW1gl6sHRdsq.jw6zFfeIOgNnefw4
 OsOcMduT4sgFJ8T7ftXCYyC4.ZwHjxdv9Hb86Iz6PpzfPk4JXLyiKWRWgUStTCXcnrPkIdY38w.2
 _EMKq.znqy05UWSd3yg21BusicexSa.i.yZhN0NbLfonMFfiYhVqirLj.hidqrxs9UMdA1EKZ90S
 raPQwaQfUPzh0423xHoO2RrLX08odbPeTFG9lLtHP7ER4n9qxGBHmhMhCtGo6pNu1eD4iUbp4nAu
 jKDr41oTtfTIQG7itifgwP2LV8tObEPJBzlRCcqMGvCrqUXDJnBs5YYTtgYHmPTAlXrHos8wgMf9
 POxX49fdklNYoCzFWAn7u10ET1luh3WtA.WYdFKpve6OfILAaJUrUvmGamUFWjSMHDg6_rhfMDre
 .2ENo9EyIc1IqfBk00HuOcj1UuJQ5Om0NpBOaSzVFqEE9GMfiasetsOekPqFm7Oxguj8M3o6IjF3
 ptxNkMKJxH5OelLrw_g2qsGaFTqO0kdLMijIPUjKHRgApI71.k69OcHWrv0iHP92P6i9vHuIh2Id
 f6SQs52LomIz9NX93Iq_2SrDAEev7Rx1tSylnK_TqXS_aVFWryiiYKoC8I8l2ifKqRTYs81_YnHa
 TCnbKIEUCBkp728IXL.p9mjiMfXY1iaqmA4_j9.H44ZUm8a_iIbyJN102oTonygOL1QCOQEp7gRn
 qf1CTiJM269.cO.z1Uz8aPijfddOPGd6JEcUJkNHlhqjSa_.de4D.R_qbWQJzrKCc5WJVJEpyx5y
 Vjls2EkLVrZaYix3LiE0Z_SztLClVi9rMgeaWA5vUA4.5cAZKHQ6l0J3lSJP0RmaEguTgzyY8Ibd
 94cLehXwfexY.tegJsN_fUq5dypDfgUl40D_hBpPafJ8UXafC1wc1anUQ7gkCeMeoc6g3_h7fQy1
 W1zaMwQdjC2ucqEDNThcgR9.0imdd5Hhl1Z1vHKwRQQeVXzdil1XzlFU3oGlfUhvUiXSOiT.xqNh
 WdHbZamPcPbg897B4YRJoPjO28tfwbBKNs7f3T4kaENQovaMTBGDrFwpgfn9DyMZqt3yiIlow6NN
 iiOHtXw8mU1Y_Wt9MvMfapLhto4sKT_rYRLQGjx7Wjgw5TzTwcKcRIU.SRmF1W0GwrZzebcD.DhI
 X9dzj_m9jBrb3lu9_WbGkLgJ2KOEYBOVYg4X_ksxwqhqHahoGPB6FAfl1OnJV2LxBdIXmKyFjhEe
 JQGg_qw66SUtiDL05kRLMec14sWXFa2oJmSCwCkQTMogp3jeU1InjroEyYopviTLxLzqdISKwBpO
 j2rrRKfknHe2Mx04WIGf0Wk0ti3ml7BpMPwmBWftTPSyNAuFUFdvDznm_bzW4BNeCwhFONeYf0z3
 F3QpoO20xKOLaBbsfAnzRc4G79ZgvilMp9Gz.95RPmr.NYPkhe9OzsQI.5WVVodp0WBkDe9vOsag
 FSFZXHpFZssGVsXj1cP5lOKQHZiTmDGdmZlrCZslDhVqSdgSj6kk-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 2338dc7a-5d9c-4a12-9724-eb135cc786ef
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Nov 2026 23:36:46 +0000
Received: by hermes--production-ir2-5dd9bf4598-nbdmm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dc436cfb0dfc2f8775595c442fab7f2f;
          Tue, 03 Nov 2026 23:36:43 +0000 (UTC)
Message-ID: <5f0dd56f-b6e0-4341-853d-6ac69632350a@yahoo.com>
Date: Wed, 4 Nov 2026 00:36:40 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v8 10/11] net: dsa: realtek: rtl8365mb: make L2/LUT
 access work on family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <08611959-c555-46d9-8e7e-20b85d0c4056@yahoo.com>
Content-Language: pl
In-Reply-To: <08611959-c555-46d9-8e7e-20b85d0c4056@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26871 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

The L2 lookup table on family D switches (e.g. RTL8367S-VB) differs
from family C in ways that make the current FDB/MDB code misbehave:

 - An L2 entry is 5 words instead of 6, with a different field layout
   in words 3 and 4 (port, age, static and multicast member bits).
 - There is no EFID and no per-bridge FDB isolation. The register at
   0x0A32, used as the per-port EFID register on family C, is the LUT
   aging timer on family D, so writing an EFID there corrupts it.
 - In the table access interface, the SPA field is 3 bits wide and the
   address register is 12 bits wide, with no address extension bit.
 - Only ports 0..7 are present in the LUT and there is no
   FLUSH_PORT_EXT register.

Teach the table and L2 code about these differences, selecting the
layout at runtime with rtl8365mb_is_d(). Family C behavior is
unchanged.

Specifically:

 - rtl8365mb_table: use the family D port mask and address width, and
   read the hit address from status bits [11:0].
 - rtl8365mb_l2: add family D unicast/multicast entry (de)serializers
   and dispatch to them from the rtl8365mb_l2_*() helpers, pass the
   proper entry size to the table layer, reject ports above 7, report
   SVL (FID) entries with VID 0. Use age 6 for static unicast entries
   as the vendor code does, and look an entry up before deleting it so
   that a missing entry is not allocated by the delete.
 - rtl8365mb_main: make port_set_efid() a no-op on family D, add a LUT
   init step that clears IPMC_HASH and BCAM_DISABLE and programs the
   aging timer, and do not advertise fdb_isolation or
   max_num_bridges. Traffic between bridges is then isolated by the
   port isolation masks only.

Register layouts were taken from the family D register description;
the code itself is an independent implementation.

No chip uses family D before the last patch of the series, so this code
is unreachable until then.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_l2.c    | 164 ++++++++++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_main.c  |  46 +++++-
 drivers/net/dsa/realtek/rtl8365mb_table.c |  46 ++++--
 drivers/net/dsa/realtek/rtl8365mb_table.h |   2 +
 4 files changed, 232 insertions(+), 26 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_l2.c b/drivers/net/dsa/realtek/rtl8365mb_l2.c
index 01cf2d5..365b5c0 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_l2.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_l2.c
@@ -8,9 +8,11 @@
 
 #include "rtl8365mb_l2.h"
 #include "rtl8365mb_table.h"
+#include "rtl8365mb.h"
 #include <linux/regmap.h>
 
 #define RTL8365MB_L2_ENTRY_SIZE			6
+#define RTL8365MB_D_L2_ENTRY_SIZE		5
 
 #define RTL8365MB_L2_UC_D3_VID_MSK		GENMASK(11, 0)
 #define RTL8365MB_L2_UC_D3_IVL_MSK		GENMASK(13, 13)
@@ -46,6 +48,21 @@
 #define RTL8365MB_L2_MC_D5_MBR_HI2_MSK		GENMASK(7, 7)
 #define   RTL8365MB_L2_MC_MBR_HI2_MSK		GENMASK(10, 10)
 
+/* Family D unicast (auto-learn / static) entry */
+#define RTL8365MB_D_L2_UC_D3_VID_MSK		GENMASK(11, 0)
+#define RTL8365MB_D_L2_UC_D3_IVL_MSK		BIT(13)
+#define RTL8365MB_D_L2_UC_D3_PORT_LO_MSK	GENMASK(15, 14)
+#define RTL8365MB_D_L2_UC_D4_PORT_HI_MSK	BIT(0)
+#define RTL8365MB_D_L2_UC_D4_AGE_MSK		GENMASK(3, 1)
+#define RTL8365MB_D_L2_UC_D4_STATIC_MSK		BIT(6)
+
+/* Family D multicast entry */
+#define RTL8365MB_D_L2_MC_D3_VID_MSK		GENMASK(11, 0)
+#define RTL8365MB_D_L2_MC_D3_IVL_MSK		BIT(13)
+#define RTL8365MB_D_L2_MC_D3_MBR_LO_MSK		GENMASK(15, 14)
+#define RTL8365MB_D_L2_MC_D4_MBR_HI_MSK		GENMASK(5, 0)
+#define RTL8365MB_D_L2_MC_D4_STATIC_MSK		BIT(6)
+
 /* Port flush command registers - writing a 1 to the port's MASK bit will
  * initiate the flush procedure. Completion is signalled when the corresponding
  * BUSY bit is 0.
@@ -241,28 +258,107 @@ static void rtl8365mb_c_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc,
 	data[5] |= FIELD_PREP(RTL8365MB_L2_MC_D5_MBR_HI2_MSK, val);
 }
 
+static size_t rtl8365mb_l2_entry_size(struct realtek_priv *priv)
+{
+	return rtl8365mb_is_d(priv) ? RTL8365MB_D_L2_ENTRY_SIZE :
+				      RTL8365MB_L2_ENTRY_SIZE;
+}
+
+static void rtl8365mb_d_l2_data_to_uc(const u16 *data,
+				      struct rtl8365mb_l2_uc *uc)
+{
+	u16 id = FIELD_GET(RTL8365MB_D_L2_UC_D3_VID_MSK, data[3]);
+
+	rtl8365mb_l2_data_to_mac(data, uc->key.mac_addr);
+	uc->key.ivl = FIELD_GET(RTL8365MB_D_L2_UC_D3_IVL_MSK, data[3]);
+	/* D has one shared VID/FID field, selected by IVL */
+	uc->key.vid = uc->key.ivl ? id : 0;
+	uc->key.fid = uc->key.ivl ? 0 : id;
+	uc->key.efid = 0;
+	uc->port = FIELD_GET(RTL8365MB_D_L2_UC_D3_PORT_LO_MSK, data[3]) |
+		   (FIELD_GET(RTL8365MB_D_L2_UC_D4_PORT_HI_MSK, data[4]) << 2);
+	uc->age = FIELD_GET(RTL8365MB_D_L2_UC_D4_AGE_MSK, data[4]);
+	uc->is_static = FIELD_GET(RTL8365MB_D_L2_UC_D4_STATIC_MSK, data[4]);
+}
+
+static void rtl8365mb_d_l2_uc_to_data(const struct rtl8365mb_l2_uc *uc,
+				      u16 *data)
+{
+	u16 id = uc->key.ivl ? uc->key.vid : uc->key.fid;
+
+	memset(data, 0, RTL8365MB_D_L2_ENTRY_SIZE * 2);
+	rtl8365mb_l2_mac_to_data(uc->key.mac_addr, data);
+	data[3] = FIELD_PREP(RTL8365MB_D_L2_UC_D3_VID_MSK, id) |
+		  FIELD_PREP(RTL8365MB_D_L2_UC_D3_IVL_MSK, uc->key.ivl) |
+		  FIELD_PREP(RTL8365MB_D_L2_UC_D3_PORT_LO_MSK, uc->port & 0x3);
+	data[4] = FIELD_PREP(RTL8365MB_D_L2_UC_D4_PORT_HI_MSK,
+			     (uc->port >> 2) & 0x1) |
+		  FIELD_PREP(RTL8365MB_D_L2_UC_D4_AGE_MSK, uc->age) |
+		  FIELD_PREP(RTL8365MB_D_L2_UC_D4_STATIC_MSK, uc->is_static);
+}
+
+static void rtl8365mb_d_l2_data_to_mc(const u16 *data,
+				      struct rtl8365mb_l2_mc *mc)
+{
+	rtl8365mb_l2_data_to_mac(data, mc->key.mac_addr);
+	mc->key.vid = FIELD_GET(RTL8365MB_D_L2_MC_D3_VID_MSK, data[3]);
+	mc->key.ivl = FIELD_GET(RTL8365MB_D_L2_MC_D3_IVL_MSK, data[3]);
+	mc->member = FIELD_GET(RTL8365MB_D_L2_MC_D3_MBR_LO_MSK, data[3]) |
+		     (FIELD_GET(RTL8365MB_D_L2_MC_D4_MBR_HI_MSK, data[4]) << 2);
+	mc->is_static = FIELD_GET(RTL8365MB_D_L2_MC_D4_STATIC_MSK, data[4]);
+	mc->igmpidx = 0;
+	mc->priority = 0;
+	mc->fwd_pri = 0;
+	mc->igmp_asic = 0;
+}
+
+static void rtl8365mb_d_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc,
+				      u16 *data)
+{
+	memset(data, 0, RTL8365MB_D_L2_ENTRY_SIZE * 2);
+	rtl8365mb_l2_mac_to_data(mc->key.mac_addr, data);
+	data[3] = FIELD_PREP(RTL8365MB_D_L2_MC_D3_VID_MSK, mc->key.vid) |
+		  FIELD_PREP(RTL8365MB_D_L2_MC_D3_IVL_MSK, mc->key.ivl) |
+		  FIELD_PREP(RTL8365MB_D_L2_MC_D3_MBR_LO_MSK, mc->member & 0x3);
+	data[4] = FIELD_PREP(RTL8365MB_D_L2_MC_D4_MBR_HI_MSK,
+			     (mc->member >> 2) & 0x3f) |
+		  FIELD_PREP(RTL8365MB_D_L2_MC_D4_STATIC_MSK, mc->is_static);
+}
+
 static void rtl8365mb_l2_data_to_uc(struct realtek_priv *priv, const u16 *data,
 				    struct rtl8365mb_l2_uc *uc)
 {
-	rtl8365mb_c_l2_data_to_uc(data, uc);
+	if (rtl8365mb_is_d(priv))
+		rtl8365mb_d_l2_data_to_uc(data, uc);
+	else
+		rtl8365mb_c_l2_data_to_uc(data, uc);
 }
 
 static void rtl8365mb_l2_uc_to_data(struct realtek_priv *priv,
 				    const struct rtl8365mb_l2_uc *uc, u16 *data)
 {
-	rtl8365mb_c_l2_uc_to_data(uc, data);
+	if (rtl8365mb_is_d(priv))
+		rtl8365mb_d_l2_uc_to_data(uc, data);
+	else
+		rtl8365mb_c_l2_uc_to_data(uc, data);
 }
 
 static void rtl8365mb_l2_data_to_mc(struct realtek_priv *priv, const u16 *data,
 				    struct rtl8365mb_l2_mc *mc)
 {
-	rtl8365mb_c_l2_data_to_mc(data, mc);
+	if (rtl8365mb_is_d(priv))
+		rtl8365mb_d_l2_data_to_mc(data, mc);
+	else
+		rtl8365mb_c_l2_data_to_mc(data, mc);
 }
 
 static void rtl8365mb_l2_mc_to_data(struct realtek_priv *priv,
 				    const struct rtl8365mb_l2_mc *mc, u16 *data)
 {
-	rtl8365mb_c_l2_mc_to_data(mc, data);
+	if (rtl8365mb_is_d(priv))
+		rtl8365mb_d_l2_mc_to_data(mc, data);
+	else
+		rtl8365mb_c_l2_mc_to_data(mc, data);
 }
 
 /*
@@ -293,10 +389,13 @@ int rtl8365mb_l2_get_next_uc(struct realtek_priv *priv, u16 *addr, int port,
 	struct rtl8365mb_l2_uc uc;
 	int ret;
 
+	if (rtl8365mb_is_d(priv) && port > RTL8365MB_D_L2_MAX_PORT)
+		return -EINVAL;
+
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_READ, addr,
 				    RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_UC_PORT,
-				    port, data, RTL8365MB_L2_ENTRY_SIZE);
+				    port, data, rtl8365mb_l2_entry_size(priv));
 	if (ret)
 		return ret;
 
@@ -318,6 +417,9 @@ int rtl8365mb_l2_add_uc(struct realtek_priv *priv, int port,
 	u16 addr;
 	int ret;
 
+	if (rtl8365mb_is_d(priv) && port > RTL8365MB_D_L2_MAX_PORT)
+		return -EINVAL;
+
 	memcpy(uc.key.mac_addr, mac_addr, ETH_ALEN);
 	uc.key.efid = efid;
 	uc.key.fid = 0;
@@ -331,15 +433,18 @@ int rtl8365mb_l2_add_uc(struct realtek_priv *priv, int port,
 	 * OS's back. As a trade-off, these will show up as permanent to users.
 	 */
 	uc.is_static = true;
-	/* age greater than 0 adds/updates entries */
-	uc.age = 1;
+	/* age greater than 0 adds/updates entries. D has no EFID, so efid
+	 * is not serialized (bridges are isolated by the port isolation
+	 * masks only). Vendor code writes age 6 for D.
+	 */
+	uc.age = rtl8365mb_is_d(priv) ? 6 : 1;
 	rtl8365mb_l2_uc_to_data(priv, &uc, data);
 
 	/* add the new entry or update an existing one */
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_WRITE, &addr,
 				    0, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, rtl8365mb_l2_entry_size(priv));
 
 	/* Assume the missing new entry as the table is full */
 	if (ret == -ENOENT)
@@ -367,6 +472,27 @@ int rtl8365mb_l2_del_uc(struct realtek_priv *priv, int port,
 	uc.age = 0;
 	rtl8365mb_l2_uc_to_data(priv, &uc, data);
 
+	if (rtl8365mb_is_d(priv)) {
+		/* Do not blind-write: look the entry up first (as the vendor
+		 * code does) so a missing entry is not (re)allocated. The
+		 * lookup and the write are separate table queries, so this
+		 * is not atomic; it relies on FDB operations being
+		 * serialized by the caller.
+		 */
+		ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
+					    RTL8365MB_TABLE_OP_READ, &addr,
+					    RTL8365MB_TABLE_L2_METHOD_MAC, 0,
+					    data,
+					    rtl8365mb_l2_entry_size(priv));
+		if (ret == -ENOENT)
+			return 0;
+		if (ret)
+			return ret;
+
+		/* rebuild the write payload: the read overwrote data[] */
+		rtl8365mb_l2_uc_to_data(priv, &uc, data);
+	}
+
 	/* it looks like the switch will always add/update the entry,
 	 * even when age is 0 or uc.key did not match an existing entry,
 	 * just to immediately drop it because age is zero. You can still
@@ -375,7 +501,7 @@ int rtl8365mb_l2_del_uc(struct realtek_priv *priv, int port,
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_WRITE, &addr,
 				    0, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, rtl8365mb_l2_entry_size(priv));
 
 	if (ret == -ENOENT) {
 		dev_dbg(priv->dev, "%s: %pM vid=%d efid=%d missing\n",
@@ -395,6 +521,9 @@ int rtl8365mb_l2_flush(struct realtek_priv *priv, int port, u16 vid)
 	u32 val, mask;
 	int ret;
 
+	if (rtl8365mb_is_d(priv) && port > RTL8365MB_D_L2_MAX_PORT)
+		return -EINVAL;
+
 	mutex_lock(&priv->map_lock);
 
 	/* Configure flushing mode; only flush dynamic entries */
@@ -462,6 +591,9 @@ int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
 	u16 addr;
 	int ret;
 
+	if (rtl8365mb_is_d(priv) && port > RTL8365MB_D_L2_MAX_PORT)
+		return -EINVAL;
+
 	memcpy(mc.key.mac_addr, mac_addr, ETH_ALEN);
 	mc.key.vid = vid;
 	mc.key.ivl = true;
@@ -476,7 +608,7 @@ int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_READ, &addr,
 				    RTL8365MB_TABLE_L2_METHOD_MAC, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, rtl8365mb_l2_entry_size(priv));
 	if (!ret) {
 		/* There is already an entry... */
 		rtl8365mb_l2_data_to_mc(priv, data, &mc);
@@ -515,7 +647,7 @@ int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_WRITE, &addr,
 				    0, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, rtl8365mb_l2_entry_size(priv));
 
 	/* Assume the missing new entry as the table is full */
 	if (ret == -ENOENT)
@@ -533,6 +665,12 @@ int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
 	u16 addr;
 	int ret;
 
+	/* Family D has no LUT members above port 7, so there is nothing
+	 * to remove for such a port.
+	 */
+	if (rtl8365mb_is_d(priv) && port > RTL8365MB_D_L2_MAX_PORT)
+		return 0;
+
 	memcpy(mc.key.mac_addr, mac_addr, ETH_ALEN);
 	mc.key.vid = vid;
 	mc.key.ivl = true;
@@ -542,7 +680,7 @@ int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_READ, &addr,
 				    RTL8365MB_TABLE_L2_METHOD_MAC, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, rtl8365mb_l2_entry_size(priv));
 	if (ret == -ENOENT) {
 		dev_dbg(priv->dev, "%s: %pM vid=%d missing\n",
 			__func__, mac_addr, vid);
@@ -578,6 +716,6 @@ int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_WRITE, &addr,
 				    0, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, rtl8365mb_l2_entry_size(priv));
 	return ret;
 }
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index ba2a0ff..6e52344 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -460,6 +460,14 @@
 #define RTL8365MB_LUT_PORT_LEARN_LIMIT_REG(_physport) \
 		(RTL8365MB_LUT_PORT_LEARN_LIMIT_BASE + (_physport))
 
+/* Family D LUT configuration */
+#define RTL8365MB_D_LUT_CFG_REG			0x0A30
+#define   RTL8365MB_D_LUT_CFG_BCAM_DISABLE_MASK	BIT(6)
+#define   RTL8365MB_D_LUT_CFG_IPMC_HASH_MASK	BIT(4)
+/* On family C this address is the per-port EFID register! */
+#define RTL8365MB_D_LUT_CFG2_REG		0x0A32
+#define   RTL8365MB_D_LUT_AGING_DEFAULT		3000
+
 /* Port isolation (forwarding mask) registers */
 #define RTL8365MB_PORT_ISOLATION_REG_BASE		0x08A2
 #define RTL8365MB_PORT_ISOLATION_REG(_physport) \
@@ -2877,6 +2885,10 @@ static int rtl8365mb_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 static int rtl8365mb_port_set_efid(struct realtek_priv *priv, int port,
 				   u32 efid)
 {
+	/* Family D has no EFID; see RTL8365MB_D_LUT_CFG2_REG. */
+	if (rtl8365mb_is_d(priv))
+		return 0;
+
 	return regmap_update_bits(priv->map, RTL8365MB_PORT_EFID_REG(port),
 				  RTL8365MB_PORT_EFID_MASK(port),
 				  efid << RTL8365MB_PORT_EFID_OFFSET(port));
@@ -3613,6 +3625,23 @@ static int rtl8365mb_change_tag_protocol(struct dsa_switch *ds,
 	return rtl8365mb_cpu_config(priv);
 }
 
+static int rtl8365mb_d_lut_init(struct realtek_priv *priv)
+{
+	int ret;
+
+	/* After the jam table: lookup multicast by MAC (not DIP) and keep
+	 * the CAM enabled.
+	 */
+	ret = regmap_update_bits(priv->map, RTL8365MB_D_LUT_CFG_REG,
+				 RTL8365MB_D_LUT_CFG_IPMC_HASH_MASK |
+				 RTL8365MB_D_LUT_CFG_BCAM_DISABLE_MASK, 0);
+	if (ret)
+		return ret;
+
+	return regmap_write(priv->map, RTL8365MB_D_LUT_CFG2_REG,
+			    RTL8365MB_D_LUT_AGING_DEFAULT);
+}
+
 static int rtl8365mb_switch_init(struct realtek_priv *priv)
 {
 	struct rtl8365mb *mb = priv->chip_data;
@@ -3702,6 +3731,15 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		goto out_error;
 	}
 
+	if (rtl8365mb_is_d(priv)) {
+		ret = rtl8365mb_d_lut_init(priv);
+		if (ret) {
+			dev_err(priv->dev, "failed to init LUT: %pe\n",
+				ERR_PTR(ret));
+			goto out_error;
+		}
+	}
+
 	if (mb->sds_supported) {
 		ret = rtl8365mb_sds_raise_rate_limits(priv);
 		if (ret) {
@@ -3827,9 +3865,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		goto out_teardown_irq;
 
 	ds->assisted_learning_on_cpu_port = true;
-	ds->fdb_isolation = true;
-	/* The EFID is 3 bits, but EFID 0 is reserved for standalone ports */
-	ds->max_num_bridges = FIELD_MAX(RTL8365MB_EFID_MASK);
+	if (!rtl8365mb_is_d(priv)) {
+		ds->fdb_isolation = true;
+		/* The EFID is 3 bits, but EFID 0 is reserved for standalone */
+		ds->max_num_bridges = FIELD_MAX(RTL8365MB_EFID_MASK);
+	}
 
 	ds->configure_vlan_while_not_filtering = true;
 
diff --git a/drivers/net/dsa/realtek/rtl8365mb_table.c b/drivers/net/dsa/realtek/rtl8365mb_table.c
index f3c8749..1b75d22 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_table.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_table.c
@@ -5,6 +5,7 @@
  */
 
 #include "rtl8365mb_table.h"
+#include "rtl8365mb.h"
 #include <linux/regmap.h>
 
 /* Table access control register */
@@ -16,10 +17,13 @@
 /* Should be one of rtl8365mb_table_l2_method enum members */
 #define   RTL8365MB_TABLE_CTRL_METHOD_MASK	GENMASK(6, 4)
 #define   RTL8365MB_TABLE_CTRL_PORT_MASK	GENMASK(11, 8)
+/* Family D: SPA is 3 bits */
+#define   RTL8365MB_D_TABLE_CTRL_PORT_MASK	GENMASK(10, 8)
 
 /* Table access address register */
 #define RTL8365MB_TABLE_ACCESS_ADDR_REG		0x0501
 #define   RTL8365MB_TABLE_ADDR_MASK		GENMASK(12, 0)
+#define   RTL8365MB_D_TABLE_ADDR_MASK		GENMASK(11, 0)
 
 /* Table status register */
 #define RTL8365MB_TABLE_STATUS_REG			0x0502
@@ -29,6 +33,8 @@
 #define   RTL8365MB_TABLE_STATUS_HIT_STATUS_MASK	GENMASK(12, 12)
 #define   RTL8365MB_TABLE_STATUS_BUSY_FLAG_MASK		GENMASK(13, 13)
 #define   RTL8365MB_TABLE_STATUS_ADDRESS_EXT_MASK	GENMASK(14, 14)
+/* Family D: the address is bits [11:0], there is no EXT bit */
+#define   RTL8365MB_D_TABLE_STATUS_ADDRESS_MASK		GENMASK(11, 0)
 
 /* Table read/write registers */
 #define RTL8365MB_TABLE_WRITE_BASE			0x0510
@@ -59,6 +65,7 @@ int rtl8365mb_table_query(struct realtek_priv *priv,
 {
 	bool addr_as_input = true;
 	bool write_data = false;
+	bool is_d = rtl8365mb_is_d(priv);
 	int ret = 0;
 	u32 cmd;
 	u32 val;
@@ -91,7 +98,15 @@ int rtl8365mb_table_query(struct realtek_priv *priv,
 		case RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_MC:
 			break;
 		case RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_UC_PORT:
-			cmd |= FIELD_PREP(RTL8365MB_TABLE_CTRL_PORT_MASK, port);
+			if (is_d) {
+				if (port > RTL8365MB_D_L2_MAX_PORT)
+					return -EINVAL;
+				cmd |= FIELD_PREP(RTL8365MB_D_TABLE_CTRL_PORT_MASK,
+						  port);
+			} else {
+				cmd |= FIELD_PREP(RTL8365MB_TABLE_CTRL_PORT_MASK,
+						  port);
+			}
 			break;
 		default:
 			return -EINVAL;
@@ -146,8 +161,9 @@ int rtl8365mb_table_query(struct realtek_priv *priv,
 	if (addr_as_input) {
 		ret = regmap_write(priv->map_nolock,
 				   RTL8365MB_TABLE_ACCESS_ADDR_REG,
-				   FIELD_PREP(RTL8365MB_TABLE_ADDR_MASK,
-					      *addr));
+				   is_d ?
+				   FIELD_PREP(RTL8365MB_D_TABLE_ADDR_MASK, *addr) :
+				   FIELD_PREP(RTL8365MB_TABLE_ADDR_MASK, *addr));
 		if (ret)
 			goto out;
 	}
@@ -177,13 +193,23 @@ int rtl8365mb_table_query(struct realtek_priv *priv,
 		}
 
 		/* If so, extract the address */
-		*addr = 0;
-		*addr |= FIELD_GET(RTL8365MB_TABLE_STATUS_ADDRESS_MASK, val);
-		*addr |= FIELD_GET(RTL8365MB_TABLE_STATUS_ADDRESS_EXT_MASK, val)
-			 << 11;
-		/* only set if it is a L3 address */
-		*addr |= FIELD_GET(RTL8365MB_TABLE_STATUS_ADDR_TYPE_MASK, val)
-			 << 12;
+		if (is_d) {
+			/* Bit 11 is "TYPE" in the register map, but the entry
+			 * index (2048 hash + 64 CAM) needs 12 bits; the vendor
+			 * code reads [11:0] as well.
+			 */
+			*addr = FIELD_GET(RTL8365MB_D_TABLE_STATUS_ADDRESS_MASK,
+					  val);
+		} else {
+			*addr = 0;
+			*addr |= FIELD_GET(RTL8365MB_TABLE_STATUS_ADDRESS_MASK,
+					   val);
+			*addr |= FIELD_GET(RTL8365MB_TABLE_STATUS_ADDRESS_EXT_MASK,
+					   val) << 11;
+			/* only set if it is a L3 address */
+			*addr |= FIELD_GET(RTL8365MB_TABLE_STATUS_ADDR_TYPE_MASK,
+					   val) << 12;
+		}
 	}
 
 	/* Finally, get the table entry if we were reading */
diff --git a/drivers/net/dsa/realtek/rtl8365mb_table.h b/drivers/net/dsa/realtek/rtl8365mb_table.h
index 41280eb..2ecba80 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_table.h
+++ b/drivers/net/dsa/realtek/rtl8365mb_table.h
@@ -13,6 +13,8 @@
 #include "realtek.h"
 
 #define RTL8365MB_TABLE_ENTRY_MAX_SIZE			10
+/* Family D has only ports 0..7 in the LUT */
+#define RTL8365MB_D_L2_MAX_PORT				7
 
 /*
  * enum rtl8365mb_table - available switch tables
-- 
2.53.0

