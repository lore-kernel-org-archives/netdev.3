Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.184.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630686;
	b=FkGVjJvlfCVAlEKePuzlWLOOoWykNIWwNf4Y/DgSljNr672W0lpz+Jcr4/as37ayGd9h
	 +Wqm3Ntfwvzm1Pjeytv9Po22F+UpOyQoEbXSl2roe0vzeIs/6qWtnTYX7x+s1OjIAXA6b
	 Ede6FywupHx8bQp0J2ZlI3FiNS/YY13yMlTXGO2ZMhc5ccnpIyiphwM/vo09GMNCcXFq5
	 p6eReZLrvix0z2qGV4gOrdPj+16opwo3cKnJNIZFor1n+44ghELt/D40OKotJWInn5+AT
	 3m1i7onVSfI5vlW2cbTvgooh1K/mi1IDLx64uoiPu/dUYg7YCctpU280lRrNZmAmETg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630686;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=u0XaalBvIVFfrjHFIeL6hw7KxkE01i/dMOQug3Mavao=;
	b=JHbXhByk50UVZCm7C1VYkgdg15amlHYqe+9Z/lyn4IaRY05BX/x9w8wF2sgRuS6+UQB/
	 S3sOqzBFMhN4Wi7/TjmRLDWZEBdcpSOd8lIAobAnMYAojRgL1Ao6k/lJ40/J6sVvDeD4V
	 Q73+N3IaNOFgJ+Ul00pbecSm5+oJXFWSygpmJjAkXnJPsKc+11CNRMpFsm498jVEU1ca+
	 oRwyd142m7nXxgGXXfFmupLMZL724ARu+cUnW3E1Z5smawtP/YJJjqmf7a/P2MkST45hN
	 WFVXxHD6Uo16+BRRBWrhwWQLCU9xGeMqkQuQzjG9PMThybc2RpI7/SXXDUEcufVt3UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b="uQI5H/IJ";
	arc=none smtp.remote-ip=66.163.184.43
Received: from sonic317-32.consmr.mail.ne1.yahoo.com (sonic317-32.consmr.mail.ne1.yahoo.com [66.163.184.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00834606C3DD
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00834606C3DD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=uQI5H/IJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630684; bh=u0XaalBvIVFfrjHFIeL6hw7KxkE01i/dMOQug3Mavao=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=uQI5H/IJEHHHnnafh9WUiJ5cNhjpFHxRcU4tlxW66r/PLlZHangZO1fGZHAFHF/tDvsalgmpJBj+YXUBukBhOO3tM7GQlEmzMZPXznxD1WyyKv23oT60jakCWC3dMWMTXOgDwrZtK+/BxCPCjTJ9M1BJfhSPUEfHEgA++wLVEKuAsN7E6CACrpHqNpS/kMm5yPQsdZ7e4zO8wXR9JGJVUwEmaOkCIwXPOMdSl6nc7fKFP97WZ/ivC2jEPfeIVoI6Fmv8J3c6mhS7HS3jMXWSMXBaBCVKOOrAeBU/+7fQOa5UsNfMIGsFjJ/ySlCfcoY9HdcAzcdI/MN5UUFTwDSiPg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630684; bh=wEOYpHnv1wzWZe24nWtzS8c6KTl1/mb9N094oATEjpG=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=LHY/UQEPuuVDZHsQlrr0sFWGTKTyE4gEFm/PiPX40NdvKbwfIo6g1CcXUtLUo8nWnBkuyquPfUrX8CEbOuPzoeF36/0YSFIb2y5W0y44RnvYA69asHDWNhDmaLx+x0eQro+nRiLNeVtYjzAjRCcMfGH7wX42czFl9h75L9F/4FHPgkuyjDjrAXcBnuh13HPpL9Z3ely3Z6MJ7ND8Pse2bkPGBZCXZaYd8buVrWxInqL832FXLkJGpkeb3dTPB24NKWe12jmKtBPbhPgHDZwNXP57etGVbOIlNQMqKrNX89ui4oVCklEVNN9FLp8+6qT2DBfBGCQJ7bJ9nNTuJNd9vA==
X-YMail-OSG: F3gQx2UVM1m4Tmvh8pOkPu48wa5jgyp1DZAXdmoYtB1EwxTG3cRjT6IClxYMmDn
 uOC7YCU5JvPwf2bBlZxIcnV45qWDBd9QuLnrguDddsuPjBBAto3bIS3c4wPostyjBIAuQ0ZZtylC
 uopuzsGdEB5H9TEm514bDjHC49vutoHKmq4xe9lPf1xrjHfTO9C9XN2N5t.UdJ4C9G20.ePhAFDe
 c9W85zVD200i8sv4A.nIwXS1PlUjia7b8rMAEnvPdbhA.mxaMLnfzUlJ6Ab_bfxenNP6yPyAl5Z7
 Cejue.TEeHW4e_RkcuwwYrD3kkXdq9FcgW5MMn537g6ohLGyFe2JTEp8CcmqerIjo0o8HDzDlnKw
 BmXLykhqR0nEv8ths9SyGNwNoF4Vs4MHzyKHJIrrJ3eUjmKu0Xna8uQ3BKo2fwvQ14vHGPxdNRiV
 TAsnwvF.xugDONWGLdOaqqV1mNVT7z_Hl.D.WEQpFy0jzIYLUA6TWSd7izlGx.DW7UV53bg4Px1W
 yH.PuBZn5XwY5QHzG_QIUZL4eC.uL5MobEBtpzWwy04_siI0WnsA1qo4P3zQkBLvyl2sF3KH5wKE
 Yaq_Xq67zOM0lh3DPi.rxMoefCr7.A3xFJi_vfPisFpDPiSVnrCdCk3gC8ngEMS3okn91lTeDKw8
 rUtHhr06IH_dh8uMT4O3LOb._JWGZh6AOLTK8z4NXu7lqMZN3Fd46fHi7GobQkWF4frYOTsyXaRQ
 qQ7.JBATO9qa5pBFn3yj03EHj1i.hEsHnGv6W_JCF.B8X9stL1cnC0yL46k9rryVz3LCB54FhGC8
 .QHSW.FbyPM3dQz2WbhMsrLJGzFJ4T4XGAtVxtbR6M8n.9GLhpJ_t2mfepU3H5FeOgxrFZ_m3w5j
 aSG.GOhESffwolqI2QVVhpPiBbtnSMajL5QImDDbn8japErRdemVROTbcC0lgj5iy0qu1sCh3r9F
 bZDmH3sVneMQi97VN0WvVfab3bDIRE8V1IC.ulNx4WxNX7TBlz0tmc7WFjyTKA26BfmWifKDuIPg
 3PqUnUHltC._DIk3miSZ_eP7IY0M3ETr1P4JVqRAdiE3G7Niy3RN.1zw0mK_2J8CRonXUfTFb7tN
 9fxyFjYF4RnAtOYT4Ge2Lw3DlwAzxtNMtT6nCxcj3JN1lqtdQheFyVcT8geX8EBM5JCy2pbk19YQ
 hme7THKgTXP4f8zcHP2x_V79.Fh.O83qf58LBrbT4cFtSGWIBPZQqslEhiIkbzkLbNhYIoRYN9VC
 ibIXVGu54liBTosyQYpg5G_JhkuBK4K07d_DZfNh5uCKANf1iZ0ItLLVnT0U7nNeXdak6iOatHwD
 CjT8c8tUD0OGAe1YWC0K9.fpLVwUhFeQjjg3isQghKdXrdImwamdZrfyseyt1reczN4luu2f.VP4
 5lhyQgYJeezeTUs.dUMJZtVR3w7yM4dZeZOuwcI3yzedTUD1Z.RLiep_ceVa3n42QpPA58rtTnJ0
 IrtySFHFMs0PYJeoavTKF6Y7H5_Sok2SckWB9Oth3ZyzXeL79bSOaS_G5T4JNMmCfQJRmDTf.ybA
 KutpFVow_eY1ubLsPN_152CBfc9syupzVMk1kihfLdWZdKGQrp7R8H_wIiZ.IVDYrDVANKrtZ6b3
 2TIqbvKKHW5zjmc8rGGejA4BO9filrJ1R1LS5FPQO9CpOOopAWGb4wsWO6EDWsg_a4Y3JFeahLBM
 9lQ5m4uC74N0arXBPYleOTrWNMShLnv9Tk_U9NBvoOOPkAYe8AhXkdvLslpQ5tnyamSkQX_iXVrs
 pD9mNYgZBe.ytKE3fTGH64jcSxHnZXPpUGUNhQbGnXpcADkox3bHBJWaoD88ZWDogmvxJGFDDLEp
 8ioNy5mEdcpmR7N_gToK0OHX7RvYhtIxI0kHogaq43N8Fgm_WOhXvxQrQgLgiZ1EL_I6ffXlb3eL
 YT7Cs5cDPIHk2H7RMxL5x13uoBo.R8hhurbGLcQBPVIpGTNGrBbo7J7NP8CUXxRWF1kcF3epr7vt
 ypKZ3rUTdUlqYL870XmLFE5_huUr0e7bOBaqRlHLHFE9qJiqJj8qUmKGtYW8YZAnMxpXGakeu8oT
 Ql1iVqhQJ.g_17SN4l6qtapD7FRhZoSOMKBkbTjDfhlUszDI0CloZvZd6obRkCRBMzLH17HWjEbF
 SmUqhYgacU5G7wVCeJljkqYumqU5tQ8HqlifUPYKGJbzH3y3HyQM6H7RWfrl76ehamDBSjXSx3x5
 0YMw690d.b5m.eCXMmXj6G.UJNUt0BwG3vzs2NG9MPXLIeWi3TFXEHQp4_reF4N9eXcc8KA8T7qZ
 .vA6cL2YtpLjqC1n4GYwQ2ZcAt.JHrHDnPUc1NDW.TAK3uy4-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: a90f8425-df56-4470-9f55-f58a427dc66c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 2 Nov 2026 14:44:44 +0000
Received: by hermes--production-ir2-5dd9bf4598-jnk89 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 793d814d716a6f36d27938eaef22c14f;
          Mon, 02 Nov 2026 14:44:38 +0000 (UTC)
Message-ID: <88239c31-e161-4623-8dbb-db39f506af6f@yahoo.com>
Date: Mon, 2 Nov 2026 15:44:36 +0100
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
Subject: [PATCH net-next v7 09/10] net: dsa: realtek: rtl8365mb: make L2/LUT
 access work on family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
Content-Language: pl
In-Reply-To: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
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
layout at runtime with rtl8365mb_get_family(). Family C behaviour is
unchanged.

Specifically:

 - rtl8365mb_table: use the family D port mask and address width, and
   read the hit address from status bits [11:0].
 - rtl8365mb_l2: add family D unicast/multicast entry (de)serialisers
   behind *_any() wrappers, pass the proper entry size to the table
   layer, reject ports above 7, report SVL (FID) entries with VID 0.
   Use age 6 for static unicast entries as the vendor code does, and
   look an entry up before deleting it so that a missing entry is not
   allocated by the delete.
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
 drivers/net/dsa/realtek/rtl8365mb_l2.c    | 216 ++++++++++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_main.c  |  46 ++++-
 drivers/net/dsa/realtek/rtl8365mb_table.c |  46 ++++-
 3 files changed, 276 insertions(+), 32 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_l2.c b/drivers/net/dsa/realtek/rtl8365mb_l2.c
index 0494d8a..a7613e2 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_l2.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_l2.c
@@ -8,9 +8,12 @@
 
 #include "rtl8365mb_l2.h"
 #include "rtl8365mb_table.h"
+#include "rtl8365mb.h"
 #include <linux/regmap.h>
 
 #define RTL8365MB_L2_ENTRY_SIZE			6
+#define RTL8365MB_D_L2_ENTRY_SIZE		5
+#define RTL8365MB_D_L2_MAX_PORT			7
 
 #define RTL8365MB_L2_UC_D0_MAC5_MSK		GENMASK(7, 0)
 #define RTL8365MB_L2_UC_D0_MAC4_MSK		GENMASK(15, 8)
@@ -58,6 +61,21 @@
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
@@ -258,6 +276,130 @@ static void rtl8365mb_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc, u16 *data)
 	data[5] |= FIELD_PREP(RTL8365MB_L2_MC_D5_MBR_HI2_MSK, val);
 }
 
+static bool rtl8365mb_l2_is_d(struct realtek_priv *priv)
+{
+	return rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
+}
+
+static size_t rtl8365mb_l2_entry_size(struct realtek_priv *priv)
+{
+	return rtl8365mb_l2_is_d(priv) ? RTL8365MB_D_L2_ENTRY_SIZE :
+					 RTL8365MB_L2_ENTRY_SIZE;
+}
+
+static void rtl8365mb_l2_mac_to_data(const u8 *m, u16 *data)
+{
+	data[0] = (m[4] << 8) | m[5];
+	data[1] = (m[2] << 8) | m[3];
+	data[2] = (m[0] << 8) | m[1];
+}
+
+static void rtl8365mb_l2_data_to_mac(const u16 *data, u8 *m)
+{
+	m[5] = data[0] & 0xff;
+	m[4] = data[0] >> 8;
+	m[3] = data[1] & 0xff;
+	m[2] = data[1] >> 8;
+	m[1] = data[2] & 0xff;
+	m[0] = data[2] >> 8;
+}
+
+static void rtl8365mb_d_l2_data_to_uc(const u16 *data,
+				      struct rtl8365mb_l2_uc *uc)
+{
+	rtl8365mb_l2_data_to_mac(data, uc->key.mac_addr);
+	uc->key.vid = FIELD_GET(RTL8365MB_D_L2_UC_D3_VID_MSK, data[3]);
+	uc->key.ivl = FIELD_GET(RTL8365MB_D_L2_UC_D3_IVL_MSK, data[3]);
+	uc->key.fid = 0;
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
+	memset(data, 0, RTL8365MB_L2_ENTRY_SIZE * 2);
+	rtl8365mb_l2_mac_to_data(uc->key.mac_addr, data);
+	data[3] = FIELD_PREP(RTL8365MB_D_L2_UC_D3_VID_MSK, uc->key.vid) |
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
+	memset(data, 0, RTL8365MB_L2_ENTRY_SIZE * 2);
+	rtl8365mb_l2_mac_to_data(mc->key.mac_addr, data);
+	data[3] = FIELD_PREP(RTL8365MB_D_L2_MC_D3_VID_MSK, mc->key.vid) |
+		  FIELD_PREP(RTL8365MB_D_L2_MC_D3_IVL_MSK, mc->key.ivl) |
+		  FIELD_PREP(RTL8365MB_D_L2_MC_D3_MBR_LO_MSK, mc->member & 0x3);
+	data[4] = FIELD_PREP(RTL8365MB_D_L2_MC_D4_MBR_HI_MSK,
+			     (mc->member >> 2) & 0x3f) |
+		  FIELD_PREP(RTL8365MB_D_L2_MC_D4_STATIC_MSK, mc->is_static);
+}
+
+static void rtl8365mb_l2_data_to_uc_any(struct realtek_priv *priv,
+					const u16 *data,
+					struct rtl8365mb_l2_uc *uc)
+{
+	if (rtl8365mb_l2_is_d(priv))
+		rtl8365mb_d_l2_data_to_uc(data, uc);
+	else
+		rtl8365mb_l2_data_to_uc(data, uc);
+}
+
+static void rtl8365mb_l2_uc_to_data_any(struct realtek_priv *priv,
+					const struct rtl8365mb_l2_uc *uc,
+					u16 *data)
+{
+	if (rtl8365mb_l2_is_d(priv))
+		rtl8365mb_d_l2_uc_to_data(uc, data);
+	else
+		rtl8365mb_l2_uc_to_data(uc, data);
+}
+
+static void rtl8365mb_l2_data_to_mc_any(struct realtek_priv *priv,
+					const u16 *data,
+					struct rtl8365mb_l2_mc *mc)
+{
+	if (rtl8365mb_l2_is_d(priv))
+		rtl8365mb_d_l2_data_to_mc(data, mc);
+	else
+		rtl8365mb_l2_data_to_mc(data, mc);
+}
+
+static void rtl8365mb_l2_mc_to_data_any(struct realtek_priv *priv,
+					const struct rtl8365mb_l2_mc *mc,
+					u16 *data)
+{
+	if (rtl8365mb_l2_is_d(priv))
+		rtl8365mb_d_l2_mc_to_data(mc, data);
+	else
+		rtl8365mb_l2_mc_to_data(mc, data);
+}
+
 /*
  * rtl8365mb_l2_get_next_uc() - get the next Unicast L2 entry
  * @priv: realtek_priv pointer
@@ -286,17 +428,23 @@ int rtl8365mb_l2_get_next_uc(struct realtek_priv *priv, u16 *addr, int port,
 	struct rtl8365mb_l2_uc uc;
 	int ret;
 
+	if (rtl8365mb_l2_is_d(priv) && port > RTL8365MB_D_L2_MAX_PORT)
+		return -EINVAL;
+
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_READ, addr,
 				    RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_UC_PORT,
-				    port, data, RTL8365MB_L2_ENTRY_SIZE);
+				    port, data, rtl8365mb_l2_entry_size(priv));
 	if (ret)
 		return ret;
 
-	rtl8365mb_l2_data_to_uc(data, &uc);
+	rtl8365mb_l2_data_to_uc_any(priv, data, &uc);
 
 	ether_addr_copy(entry->mac_addr, uc.key.mac_addr);
-	entry->vid = uc.key.vid;
+	/* D has one shared VID/FID field; report SVL (FID) entries with
+	 * vid 0 as they have no VLAN to be shown under
+	 */
+	entry->vid = (rtl8365mb_l2_is_d(priv) && !uc.key.ivl) ? 0 : uc.key.vid;
 	entry->is_static = uc.is_static;
 
 	return 0;
@@ -311,6 +459,9 @@ int rtl8365mb_l2_add_uc(struct realtek_priv *priv, int port,
 	u16 addr;
 	int ret;
 
+	if (rtl8365mb_l2_is_d(priv) && port > RTL8365MB_D_L2_MAX_PORT)
+		return -EINVAL;
+
 	memcpy(uc.key.mac_addr, mac_addr, ETH_ALEN);
 	uc.key.efid = efid;
 	uc.key.fid = 0;
@@ -324,15 +475,18 @@ int rtl8365mb_l2_add_uc(struct realtek_priv *priv, int port,
 	 * OS's back. As a trade-off, these will show up as permanent to users.
 	 */
 	uc.is_static = true;
-	/* age greater than 0 adds/updates entries */
-	uc.age = 1;
-	rtl8365mb_l2_uc_to_data(&uc, data);
+	/* age greater than 0 adds/updates entries. D has no EFID, so efid is
+	 * not serialised (bridges are isolated by the port isolation masks only).
+	 * Vendor code writes age 6 for D.
+	 */
+	uc.age = rtl8365mb_l2_is_d(priv) ? 6 : 1;
+	rtl8365mb_l2_uc_to_data_any(priv, &uc, data);
 
 	/* add the new entry or update an existing one */
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_WRITE, &addr,
 				    0, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, rtl8365mb_l2_entry_size(priv));
 
 	/* Assume the missing new entry as the table is full */
 	if (ret == -ENOENT)
@@ -358,7 +512,25 @@ int rtl8365mb_l2_del_uc(struct realtek_priv *priv, int port,
 	uc.key.vid = vid;
 	/* age 0 deletes the entry */
 	uc.age = 0;
-	rtl8365mb_l2_uc_to_data(&uc, data);
+	rtl8365mb_l2_uc_to_data_any(priv, &uc, data);
+
+	if (rtl8365mb_l2_is_d(priv)) {
+		/* Do not blind-write: look the entry up first (as the vendor
+		 * code does) so a missing entry is not (re)allocated.
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
+		rtl8365mb_l2_uc_to_data_any(priv, &uc, data);
+	}
 
 	/* it looks like the switch will always add/update the entry,
 	 * even when age is 0 or uc.key did not match an existing entry,
@@ -368,7 +540,7 @@ int rtl8365mb_l2_del_uc(struct realtek_priv *priv, int port,
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_WRITE, &addr,
 				    0, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, rtl8365mb_l2_entry_size(priv));
 
 	if (ret == -ENOENT) {
 		dev_dbg(priv->dev, "%s: %pM vid=%d efid=%d missing\n",
@@ -388,6 +560,9 @@ int rtl8365mb_l2_flush(struct realtek_priv *priv, int port, u16 vid)
 	u32 val, mask;
 	int ret;
 
+	if (rtl8365mb_l2_is_d(priv) && port > RTL8365MB_D_L2_MAX_PORT)
+		return -EINVAL;
+
 	mutex_lock(&priv->map_lock);
 
 	/* Configure flushing mode; only flush dynamic entries */
@@ -455,6 +630,9 @@ int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
 	u16 addr;
 	int ret;
 
+	if (rtl8365mb_l2_is_d(priv) && port > RTL8365MB_D_L2_MAX_PORT)
+		return -EINVAL;
+
 	memcpy(mc.key.mac_addr, mac_addr, ETH_ALEN);
 	mc.key.vid = vid;
 	mc.key.ivl = true;
@@ -463,16 +641,16 @@ int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
 	 */
 	mc.member |= BIT(port);
 	mc.is_static = 1;
-	rtl8365mb_l2_mc_to_data(&mc, data);
+	rtl8365mb_l2_mc_to_data_any(priv, &mc, data);
 
 	/* First look for an existing entry (to get existing port members) */
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_READ, &addr,
 				    RTL8365MB_TABLE_L2_METHOD_MAC, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, rtl8365mb_l2_entry_size(priv));
 	if (!ret) {
 		/* There is already an entry... */
-		rtl8365mb_l2_data_to_mc(data, &mc);
+		rtl8365mb_l2_data_to_mc_any(priv, data, &mc);
 		dev_dbg(priv->dev,
 			"%s: found %pM addr=%d member=0x%x igmpidx=0x%x %s\n",
 			__func__, mac_addr, addr, mc.member, mc.igmpidx,
@@ -487,7 +665,7 @@ int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
 			mc.is_static = 1;
 		}
 
-		rtl8365mb_l2_mc_to_data(&mc, data);
+		rtl8365mb_l2_mc_to_data_any(priv, &mc, data);
 	} else if (ret == -ENOENT) {
 		/* New entry, no need to update data again as it already
 		 * includes the member.
@@ -508,7 +686,7 @@ int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_WRITE, &addr,
 				    0, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, rtl8365mb_l2_entry_size(priv));
 
 	/* Assume the missing new entry as the table is full */
 	if (ret == -ENOENT)
@@ -529,13 +707,13 @@ int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
 	memcpy(mc.key.mac_addr, mac_addr, ETH_ALEN);
 	mc.key.vid = vid;
 	mc.key.ivl = true;
-	rtl8365mb_l2_mc_to_data(&mc, data);
+	rtl8365mb_l2_mc_to_data_any(priv, &mc, data);
 
 	/* First look for an existing entry (to get existing port members) */
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_READ, &addr,
 				    RTL8365MB_TABLE_L2_METHOD_MAC, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, rtl8365mb_l2_entry_size(priv));
 	if (ret == -ENOENT) {
 		dev_dbg(priv->dev, "%s: %pM vid=%d missing\n",
 			__func__, mac_addr, vid);
@@ -547,7 +725,7 @@ int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
 		/* Return on any other error */
 		return ret;
 
-	rtl8365mb_l2_data_to_mc(data, &mc);
+	rtl8365mb_l2_data_to_mc_any(priv, data, &mc);
 	dev_dbg(priv->dev,
 		"%s: found %pM addr=%d member=0x%x igmpidx=0x%x %s\n",
 		__func__, mac_addr, addr, mc.member, mc.igmpidx,
@@ -565,12 +743,12 @@ int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
 		mc.fwd_pri = 0;
 		mc.igmp_asic = 0;
 	}
-	rtl8365mb_l2_mc_to_data(&mc, data);
+	rtl8365mb_l2_mc_to_data_any(priv, &mc, data);
 
 	/* update the existing entry. */
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_WRITE, &addr,
 				    0, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, rtl8365mb_l2_entry_size(priv));
 	return ret;
 }
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 4937ffc..1c5f139 100644
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
@@ -2879,6 +2887,10 @@ static int rtl8365mb_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 static int rtl8365mb_port_set_efid(struct realtek_priv *priv, int port,
 				   u32 efid)
 {
+	/* Family D has no EFID; see RTL8365MB_D_LUT_CFG2_REG. */
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
+		return 0;
+
 	return regmap_update_bits(priv->map, RTL8365MB_PORT_EFID_REG(port),
 				  RTL8365MB_PORT_EFID_MASK(port),
 				  efid << RTL8365MB_PORT_EFID_OFFSET(port));
@@ -3615,6 +3627,23 @@ static int rtl8365mb_change_tag_protocol(struct dsa_switch *ds,
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
@@ -3704,6 +3733,15 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		goto out_error;
 	}
 
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D) {
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
@@ -3829,9 +3867,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		goto out_teardown_irq;
 
 	ds->assisted_learning_on_cpu_port = true;
-	ds->fdb_isolation = true;
-	/* The EFID is 3 bits, but EFID 0 is reserved for standalone ports */
-	ds->max_num_bridges = FIELD_MAX(RTL8365MB_EFID_MASK);
+	if (rtl8365mb_get_family(priv) != RTL8365MB_FAMILY_D) {
+		ds->fdb_isolation = true;
+		/* The EFID is 3 bits, but EFID 0 is reserved for standalone */
+		ds->max_num_bridges = FIELD_MAX(RTL8365MB_EFID_MASK);
+	}
 
 	ds->configure_vlan_while_not_filtering = true;
 
diff --git a/drivers/net/dsa/realtek/rtl8365mb_table.c b/drivers/net/dsa/realtek/rtl8365mb_table.c
index f3c8749..74a6aa7 100644
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
+	bool is_d = rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
 	int ret = 0;
 	u32 cmd;
 	u32 val;
@@ -91,7 +98,15 @@ int rtl8365mb_table_query(struct realtek_priv *priv,
 		case RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_MC:
 			break;
 		case RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_UC_PORT:
-			cmd |= FIELD_PREP(RTL8365MB_TABLE_CTRL_PORT_MASK, port);
+			if (is_d) {
+				if (port > 7)
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
-- 
2.53.0

