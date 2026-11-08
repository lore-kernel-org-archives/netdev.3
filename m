Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.187.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794125636;
	b=lNhRsh2dueRY1RCsSGcn8TIfrzHBWVRcbzyi+ZkFfRhc/0R+KiZWBGYhjwQokBER3pxZ
	 MZ5ZnWi/7DBctINxOwFzSNloiFwHrExBG06T2g5rQ2eICZFPg5rycMdjNwCGxdBFe1u2x
	 8ZCpUybQouPs7+vyjSOTUyTG6IlPqevBCyw6qo1aBl1m69gj/QvpMsS27oqMhZluYYqmA
	 vdhslx0Yw1SX6o9rEtM+HwGcWdem4bn9kAKs2Vg5A1335IwLRM1U9D0fYuJlO11cWplC4
	 Fw9Um3IiCCHX5P0ROPU/6Hg8RYZd3SyX6GSh8FoWvcSAsjlJ7Tm8eywoUgkDQjTVivw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794125636;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=Fg38636S5s+gUmMDytA1d3Jjsr5fjGwZajqVQWhzGz4=;
	b=lk8/WxMILRJu6uNkRUmKdcMw+hftVoEHDNyueJT1wPY73UhTleSgbBf1flp7RxqxmIbb
	 RbQXRwrNkqr8y4XIzDl7xdgI0l8Bqd68YMISKgKLlZTJ2wTSaDdcI5g5ya/83oOWBY41N
	 QpyHoWgNFvMos2QyezfZPLoVd8AF3MwHm1NiLKqQwEp8/qWkMtxHbKvCxDMMzGiOTGDNI
	 07GYvJ6/2ftz4imtRYA8K9B0pF7PpkxwjL1gyxkN+lf3tH4yjiGnLf+GGfc8y0u2y6jE4
	 63DRupMvkRQPjyXK02vWqoz/rM8SDuDERLwd5Ln99wUA76Bo8oUqwtBTrpZnvW4C6nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=HdnIoJ7S;
	arc=none smtp.remote-ip=66.163.187.31
Received: from sonic308-56.consmr.mail.ne1.yahoo.com (sonic308-56.consmr.mail.ne1.yahoo.com [66.163.187.31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5372B606A320
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 08:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5372B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=HdnIoJ7S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125634; bh=Fg38636S5s+gUmMDytA1d3Jjsr5fjGwZajqVQWhzGz4=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=HdnIoJ7SB5oetVz+XJaVXcKZyb63QgAxZHEdol89T5UdrjTROxLT4m91sRYQbI80sLGR/2zsECGZ9gHhKcFwoPf6S/+PGbJ/k3yPhOK50leypKJqA6qLFYduRHDq8TddKd/sBZS/7sOTFytZ1sDrTo5ii9liBeMCu5htcDhZ5KnQE3HSfkE/zyqEvuf0i7ZicROaMsMPk3b9hn38tXZDfWdrSJtp0PQLGycBeJjlMC+2Tg78fQr9dVqUOtf6sQQYAcDdzgC5EcOuwBu9VGEVdVONACyMfbWGeE21dBqOGjCM4ehluGrLWFJhcOZ5AWlWZcICnx9jVMyf5Y6rgqjF8A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125634; bh=bsKI9RQn8SxfWGOTuyVS4YnL2a2ct+uUEhRi3KIke/t=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=oG1YiS0iLpLGrro3H7MM0jGwRbeBj/hHk+rFWVKuM6OpCYQzaUhYCkyAiI8Xxd3mwBQbzGJlY55Sxt0kr79CGmGXB0bCe+AAhix0n/E1qbtcabqbgHPLhJCtNBu2z66ITKO5SoOMOGnZmWBLrvWkzGBlY95Uf61GRk0Icx7VPyc0C6dWaReLTShc09YoWMEX84WT1SzoecS34jGYGdjI4lkmfAowEQmFWPQVWJAwvxLjFQ94ziytmL/DBbi3ls8bIdh2AzCivDww6re5db0ONqtmufOqyt4BVihat2KcKKY91cJ1Vb7Q7HQKBZQT6mfRathu4MIdnApp0EV0ssEz2Q==
X-YMail-OSG: yYa4NREVM1laNUwJ4_c1NPrQh6w..avXsSmmmXiCsZ7AuptusyY_i.k_kiTj6wt
 XRMkV4jYtFEElgLI4oM7bAUvi2S2bcMzKUsIJ58GtGbxp.4nATjDzNpU0x9z2J8s3EX7zWLzZNQ4
 ly2QyX9KtCXpLYmkJlJLymJzH28h4n493lZ5NFsiOZGfRe6wVIH14b6UjSPTKH51osltD3.7t6fd
 AEMrMzjDxAhcu.3Ipw7VdvSnqkZNhO.7DxkLo2LsuveYGHnl_04wUAgtT6bdZViVCUkripMgnUI8
 rFEuooQvZOaioy99Su1uAZH.fBh_pbyxkP2GvQI6Yd9iDxzYb3FbkBNCu4jgnOWlSgT1luNqdele
 S.mSG9CVjJ6wcRPZTkl5yt9e0i.9NPKJ3IUGjMi1hGCzJO4SLiKLFvzjiQKytfDj90IR6HP5E20h
 O_jdpgaSWgTpyYfmwazBqkedlp1WtcJrpVIcmOp8VeocJn1xob_IaEr5fwS7qQQdRaN6TrT9Ylq1
 quhV_zEjVTyg.hrFBJNw3q7jfcfp4O_oEyr7kUsXfmeROpbcgkm6aq6MsV4AGizOHQ3ch8e8d21q
 VEMmfvKoUEfk8Sk.nUKN_K6UPnNUBvoZbSwfeO39hgVHL.myuEUN5kMTM9fkCFnnfPrU7El7Dqxo
 XSLAiaIRfizyKxgRscRjrC8PutlJEIeV88VV9slGEY3d.2A6E6FuW0qTQ29bewSLzSjOyVFgLfhV
 qKOQZaZ8mBkUQrGd9kNUU1Nn7a3gVyTSdsKtmZR8ifczCHgK5R7NCx8L3jHjVrvq22sbuoC2vISA
 usUp_CYstZGkOvWcBk0CucsBf69GgHC4ni8t67QPSqrWAnJm95bR368zl7jzcXlr8.fB3LI_xj91
 d4Nvpmc5WkP4FqjQg3AXI_Jg0rYZwf4cEzVENzrY1AEDzv5ywM.B1iiFo7cpU96QV0ejcf2bNRY.
 67IlZWQEkiGXOepeElQ5Uy3sqkKQe4XAm_lmwegcscA_24jNTSEdzr1ZCqEHx227CmvU4gc2ePMZ
 eGK14512DxYpCoefzpFitTrL6IgTkGf.J2J_aK7S9TtNHZ0hyPzfKdk_hGWuo22QnBmbZNBlFwNC
 LggNaeoxN9uGCle_zfOmpvNgdAsXow8FKYTgkZ01kL1LbHsxn9OmIebgoYuBPqwdolZa9Bz..lL_
 WhbyszZI8qKsbY9GVQI1B3vyM6GscjvqAvo0N7imPN6ghRPizoec7lUNtV3Lyo1eKZ3nsMVg5yjW
 dRHH4QgPLoCkozBt7pRRSBMosRcZkSqvFxm.xjasPPI7km_5FAHJCt1cJaYBOf5rf.s3IrZXi27Q
 jimmOURKaGvnY.zVrvwbQU2AtWN2pK.kazOYDoEvywjC1mwG6mVzU18xky1wKcRtExb9fdJI0.f0
 zy89sauSvAar9gSLjS_RRfSUOx948MKJXEbBZ9giSYQAOqh2LAPssZM63d2kYW3IE38XIxmxZjiu
 0PQ7eAKxUZz3Lj5H.Fg5gZJ6iCFi.0S96eGwhXKxDJ4S7AG423UzfEODOW5I1Mq3U5BkjzvkfQTs
 O5PZdTEFLEFPXW5R5RjhdCgQA9dEi3560CN2Slbv0.9Cn1WP5udhzLkEg6887LqNB7sndx4evVX9
 vCRCOzClBpTAvvmSbp_E3y6u7FltyCMw0hlka93.4Q6wMcQi1SCUJ3Z.lW_QEdH6WgshjEV.rsfg
 qbSTN_fGsDZ1hzKZ2ha_ub7KIGk.ZM83o49iFFlWyzRo5H7WAnGDg3J9x33TI28NH9ljY6NTrBbd
 D7eSR_J4fYlfnS16YPQPuKIjf7267aqZss8_27SQZIU6WvY0.i6zrsuaRJvWNBJIKoZVenspXXfw
 9pf0fwOh.vhsY8svgrhyTcRhkbcYNmyUQUQgjhF_wSZILguA5f1OC59b6RM1lpJVojFnbnmolbfL
 .Ib1GyAhO4kLEgPH6OEpH81lsYIoXLtMRjCG3zlkifVJ4GBgZ26GVRJrkezFEhFctnt42A4UwOdJ
 BteNLa2dZuXDNRHfx9tASE6JQhx1I5Jic1mNLyECUVd7eqmy5661pNmfSVFTCVJS5fIl0i.8oZMj
 .nwProDTyisl6JGqco0ObDW_WFnsx4Hd755KI7f4iOcPsgMZvNAmmeMLUub6a.pp.p.0OpDSXQv6
 W7ONlJnH_sOh_b7SKIOk9sqlYWkX61Z.K7hHvsJzAd.2OQavB0CAtTbTmjzcJpJzNG13_EDP0Xm0
 ED_0.nMPaIwy0mxA1odVPITjVhkuZRI.jXfGsh.20aX3dzRswgOa49kYjmQEu6noAXsZMDv85wr9
 hzLgy45ONBkjJG63yGHFghPMKyveGQ.abfbj0RvPXTXNkFJ4-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 48c80e71-e99b-4084-9c67-3bcb86a13346
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Sun, 8 Nov 2026 08:13:54 +0000
Received: by hermes--production-ir2-5dd9bf4598-nf4w7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 344d931a8a018704ec5f061fd5aabccf;
          Sun, 08 Nov 2026 08:13:50 +0000 (UTC)
Message-ID: <5df20e9a-2ef8-465e-9b10-ab520c493944@yahoo.com>
Date: Sun, 8 Nov 2026 09:13:47 +0100
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
Subject: [PATCH net-next v9 10/11] net: dsa: realtek: rtl8365mb: make L2/LUT
 access work on family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alvin.sipraga@analog.com, gusfmora@gmail.com, kuncy7@gmail.com,
 fabianotassotti@gmail.com, gabonpivovich@gmail.com, contact@c127.dev
References: <9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com>
Content-Language: pl
In-Reply-To: <9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

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
 - A VLAN-unaware bridge reaches the driver with VID 0, where the chip
   learns in SVL (IVL=0, FID=0). An entry programmed by DSA with IVL set
   gets a different key than the learned one for the same MAC, so both
   coexist and the learned one keeps winning.

Teach the table and L2 code about these differences. The L2 entry
layout is selected through struct rtl8365mb_family_info, the other
differences with rtl8365mb_is_d(). Family C behavior is unchanged.

Specifically:

 - rtl8365mb_table: use the family D port mask and address width, and
   read the hit address from status bits [11:0].
 - rtl8365mb_l2: add family D unicast/multicast entry (de)serializers,
   to be selected through struct rtl8365mb_family_info. The IVL bit is
   set only for a non-zero VID, so VID 0 produces the SVL key (IVL=0,
   FID=0) and static unicast and multicast entries match the learned
   ones in a VLAN-unaware bridge. Entries read back with IVL=0 are
   reported with VID 0. Use age 6 for static unicast entries as the
   vendor code does, and look an entry up before deleting it so that a
   missing entry is not allocated by the delete.
 - rtl8365mb_main: make port_set_efid() a no-op on family D, add a LUT
   init step that clears IPMC_HASH and BCAM_DISABLE and programs the
   aging timer, and do not advertise fdb_isolation. Without EFID the
   bridges cannot be told apart in the LUT, so offload only one bridge
   (max_num_bridges = 1). Further bridges fall back to software
   forwarding, and traffic between them is isolated by the port
   isolation masks only.

Entries of standalone ports, which DSA also programs with VID 0, use
the same SVL key and so share FID 0 with a VLAN-unaware bridge. Family
D has no EFID, so there is no isolation between them in the LUT.

Register layouts were taken from the family D register description;
the code itself is an independent implementation.

Tested by Gustavo Foletto Mora on a TP-Link EX511 v2 (RTL8367S-VB, CPU
port 6 over 1G SGMII to an IPQ5018). With a VLAN-aware bridge: per-VID
FDB readback, static entries replacing learned ones and being deleted
again, the same MAC as a static entry on two VIDs, MDB entries, VLAN
add/delete churn, and moving a port to a second bridge (handled in
software). With a VLAN-unaware bridge: a static entry replaces the
learned one and traffic follows it, and the MAC relearns on the
original port after the delete; traffic to the bridge MAC no longer
floods to the WAN port; MDB entries limit the flood to the group
members and the flood returns after the delete. MACs of foreign ports
(a veth standing in for a Wi-Fi station) become entries on the CPU port
through assisted learning. Real Wi-Fi stations, RGMII and 2500base-x
were not covered by this test.

No chip uses family D before the last patch of the series, so this code
is unreachable until then.

Reported-by: Gustavo Foletto Mora <gusfmora@gmail.com>
Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
Tested-by: Stanislaw Pal <kuncy7@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/realtek.h         |   4 +-
 drivers/net/dsa/realtek/rtl8365mb_l2.c    | 121 +++++++++++++++++++++-
 drivers/net/dsa/realtek/rtl8365mb_l2.h    |   6 ++
 drivers/net/dsa/realtek/rtl8365mb_main.c  |  54 +++++++++-
 drivers/net/dsa/realtek/rtl8365mb_table.c |  44 ++++++--
 drivers/net/dsa/realtek/rtl83xx.c         |   5 +-
 6 files changed, 217 insertions(+), 17 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 1c0ca6d..578490f 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -71,7 +71,9 @@ struct realtek_priv {
 	 * create/update it. l2_(add|del)_uc uses a single table op and,
 	 * internally, it might not need this lock. However, altering FDB
 	 * may still collide, as well as l2_flush, with fdb_dump iterating
-	 * over FDB.
+	 * over FDB. On the RTL8367S-VB (family D), l2_del_uc also looks the
+	 * entry up before writing it, as two separate table queries, so it
+	 * does depend on this lock.
 	 */
 	struct mutex		l2_lock;
 	struct mii_bus		*user_mii_bus;
diff --git a/drivers/net/dsa/realtek/rtl8365mb_l2.c b/drivers/net/dsa/realtek/rtl8365mb_l2.c
index cd5b333..146075f 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_l2.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_l2.c
@@ -45,6 +45,21 @@
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
@@ -240,6 +255,76 @@ void rtl8365mb_c_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc,
 	data[5] |= FIELD_PREP(RTL8365MB_L2_MC_D5_MBR_HI2_MSK, val);
 }
 
+void rtl8365mb_d_l2_data_to_uc(const u16 *data,
+			       struct rtl8365mb_l2_uc *uc)
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
+void rtl8365mb_d_l2_uc_to_data(const struct rtl8365mb_l2_uc *uc,
+			       u16 *data)
+{
+	/* A VLAN-unaware bridge reaches us with VID 0. The chip learns such
+	 * traffic in SVL (IVL=0, FID=0), so use the same key here, otherwise
+	 * the static entry never matches the learned one. Only a real VID
+	 * selects IVL.
+	 */
+	bool ivl = uc->key.ivl && uc->key.vid;
+	u16 id = ivl ? uc->key.vid : uc->key.fid;
+
+	memset(data, 0, RTL8365MB_D_L2_ENTRY_SIZE * 2);
+	rtl8365mb_l2_mac_to_data(uc->key.mac_addr, data);
+	data[3] = FIELD_PREP(RTL8365MB_D_L2_UC_D3_VID_MSK, id) |
+		  FIELD_PREP(RTL8365MB_D_L2_UC_D3_IVL_MSK, ivl) |
+		  FIELD_PREP(RTL8365MB_D_L2_UC_D3_PORT_LO_MSK, uc->port & 0x3);
+	data[4] = FIELD_PREP(RTL8365MB_D_L2_UC_D4_PORT_HI_MSK,
+			     (uc->port >> 2) & 0x1) |
+		  FIELD_PREP(RTL8365MB_D_L2_UC_D4_AGE_MSK, uc->age) |
+		  FIELD_PREP(RTL8365MB_D_L2_UC_D4_STATIC_MSK, uc->is_static);
+}
+
+void rtl8365mb_d_l2_data_to_mc(const u16 *data,
+			       struct rtl8365mb_l2_mc *mc)
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
+void rtl8365mb_d_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc,
+			       u16 *data)
+{
+	/* Same as for unicast: VID 0 means a VLAN-unaware bridge, use SVL. */
+	bool ivl = mc->key.ivl && mc->key.vid;
+
+	memset(data, 0, RTL8365MB_D_L2_ENTRY_SIZE * 2);
+	rtl8365mb_l2_mac_to_data(mc->key.mac_addr, data);
+	data[3] = FIELD_PREP(RTL8365MB_D_L2_MC_D3_VID_MSK, mc->key.vid) |
+		  FIELD_PREP(RTL8365MB_D_L2_MC_D3_IVL_MSK, ivl) |
+		  FIELD_PREP(RTL8365MB_D_L2_MC_D3_MBR_LO_MSK, mc->member & 0x3);
+	data[4] = FIELD_PREP(RTL8365MB_D_L2_MC_D4_MBR_HI_MSK,
+			     (mc->member >> 2) & 0x3f) |
+		  FIELD_PREP(RTL8365MB_D_L2_MC_D4_STATIC_MSK, mc->is_static);
+}
+
 /*
  * rtl8365mb_l2_get_next_uc() - get the next Unicast L2 entry
  * @priv: realtek_priv pointer
@@ -310,8 +395,11 @@ int rtl8365mb_l2_add_uc(struct realtek_priv *priv, int port,
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
 	fi = rtl8365mb_get_family_info(priv);
 	fi->l2_uc_to_data(&uc, data);
 
@@ -349,6 +437,35 @@ int rtl8365mb_l2_del_uc(struct realtek_priv *priv, int port,
 	fi = rtl8365mb_get_family_info(priv);
 	fi->l2_uc_to_data(&uc, data);
 
+	if (rtl8365mb_is_d(priv)) {
+		struct rtl8365mb_l2_uc found = { 0 };
+
+		/* Do not blind-write: look the entry up first (as the vendor
+		 * code does) so a missing entry is not (re)allocated. The
+		 * lookup and the write are separate table queries, so this
+		 * is not atomic; it relies on FDB operations being
+		 * serialized by the caller.
+		 */
+		ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
+					    RTL8365MB_TABLE_OP_READ, &addr,
+					    RTL8365MB_TABLE_L2_METHOD_MAC, 0,
+					    data, fi->l2_entry_size);
+		if (ret == -ENOENT)
+			return 0;
+		if (ret)
+			return ret;
+
+		/* The key has no EFID on family D, so the entry found may
+		 * belong to another port or bridge: leave it alone.
+		 */
+		fi->l2_data_to_uc(data, &found);
+		if (found.port != port)
+			return 0;
+
+		/* rebuild the write payload: the read overwrote data[] */
+		fi->l2_uc_to_data(&uc, data);
+	}
+
 	/* it looks like the switch will always add/update the entry,
 	 * even when age is 0 or uc.key did not match an existing entry,
 	 * just to immediately drop it because age is zero. You can still
diff --git a/drivers/net/dsa/realtek/rtl8365mb_l2.h b/drivers/net/dsa/realtek/rtl8365mb_l2.h
index a9f9ae4..5bb4e32 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_l2.h
+++ b/drivers/net/dsa/realtek/rtl8365mb_l2.h
@@ -13,6 +13,7 @@
 #include "realtek.h"
 
 #define RTL8365MB_C_L2_ENTRY_SIZE		6
+#define RTL8365MB_D_L2_ENTRY_SIZE		5
 /* Highest L2 entry size of any supported chip, used for sizing */
 #define RTL8365MB_L2_ENTRY_SIZE			RTL8365MB_C_L2_ENTRY_SIZE
 
@@ -24,6 +25,11 @@ void rtl8365mb_c_l2_uc_to_data(const struct rtl8365mb_l2_uc *uc, u16 *data);
 void rtl8365mb_c_l2_data_to_mc(const u16 *data, struct rtl8365mb_l2_mc *mc);
 void rtl8365mb_c_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc, u16 *data);
 
+void rtl8365mb_d_l2_data_to_uc(const u16 *data, struct rtl8365mb_l2_uc *uc);
+void rtl8365mb_d_l2_uc_to_data(const struct rtl8365mb_l2_uc *uc, u16 *data);
+void rtl8365mb_d_l2_data_to_mc(const u16 *data, struct rtl8365mb_l2_mc *mc);
+void rtl8365mb_d_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc, u16 *data);
+
 int rtl8365mb_l2_get_next_uc(struct realtek_priv *priv, u16 *addr, int port,
 			     struct realtek_fdb_entry *entry);
 int rtl8365mb_l2_add_uc(struct realtek_priv *priv, int port,
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index e9aac7e..c2b83b7 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -460,6 +460,17 @@
 #define RTL8365MB_LUT_PORT_LEARN_LIMIT_REG(_physport) \
 		(RTL8365MB_LUT_PORT_LEARN_LIMIT_BASE + (_physport))
 
+/* Family D LUT configuration */
+#define RTL8365MB_D_LUT_CFG_REG			0x0A30
+#define   RTL8365MB_D_LUT_CFG_BCAM_DISABLE_MASK	BIT(6)
+#define   RTL8365MB_D_LUT_CFG_IPMC_HASH_MASK	BIT(4)
+/* On family C this address is the per-port EFID register! */
+#define RTL8365MB_D_LUT_CFG2_REG		0x0A32
+/* Written as a whole register: the field layout and the unit of this value
+ * are not documented.
+ */
+#define   RTL8365MB_D_LUT_AGING_DEFAULT		3000
+
 /* Port isolation (forwarding mask) registers */
 #define RTL8365MB_PORT_ISOLATION_REG_BASE		0x08A2
 #define RTL8365MB_PORT_ISOLATION_REG(_physport) \
@@ -2892,6 +2903,10 @@ static int rtl8365mb_port_pre_bridge_flags(struct dsa_switch *ds, int port,
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
@@ -3628,6 +3643,23 @@ static int rtl8365mb_change_tag_protocol(struct dsa_switch *ds,
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
@@ -3717,6 +3749,15 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
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
@@ -3842,9 +3883,16 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		goto out_teardown_irq;
 
 	ds->assisted_learning_on_cpu_port = true;
-	ds->fdb_isolation = true;
-	/* The EFID is 3 bits, but EFID 0 is reserved for standalone ports */
-	ds->max_num_bridges = FIELD_MAX(RTL8365MB_EFID_MASK);
+	if (!rtl8365mb_is_d(priv)) {
+		ds->fdb_isolation = true;
+		/* The EFID is 3 bits, but EFID 0 is reserved for standalone */
+		ds->max_num_bridges = FIELD_MAX(RTL8365MB_EFID_MASK);
+	} else {
+		/* No EFID, so bridges cannot be told apart in the LUT: offload
+		 * only one, others fall back to software forwarding.
+		 */
+		ds->max_num_bridges = 1;
+	}
 
 	ds->configure_vlan_while_not_filtering = true;
 
diff --git a/drivers/net/dsa/realtek/rtl8365mb_table.c b/drivers/net/dsa/realtek/rtl8365mb_table.c
index f3c8749..6b1323f 100644
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
@@ -91,7 +98,13 @@ int rtl8365mb_table_query(struct realtek_priv *priv,
 		case RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_MC:
 			break;
 		case RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_UC_PORT:
-			cmd |= FIELD_PREP(RTL8365MB_TABLE_CTRL_PORT_MASK, port);
+			if (is_d) {
+				cmd |= FIELD_PREP(RTL8365MB_D_TABLE_CTRL_PORT_MASK,
+						  port);
+			} else {
+				cmd |= FIELD_PREP(RTL8365MB_TABLE_CTRL_PORT_MASK,
+						  port);
+			}
 			break;
 		default:
 			return -EINVAL;
@@ -146,8 +159,9 @@ int rtl8365mb_table_query(struct realtek_priv *priv,
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
@@ -177,13 +191,23 @@ int rtl8365mb_table_query(struct realtek_priv *priv,
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
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index ad42c05..cfe7d42 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -602,7 +602,8 @@ int rtl83xx_port_fdb_add(struct dsa_switch *ds, int port,
 
 	/* Bridge ports use bridge.num as EFID, while standalone ports use
 	 * EFID 0. FDB entries for the CPU port follow the bridge EFID due
-	 * to assisted learning.
+	 * to assisted learning. Chips without an EFID in their L2 table
+	 * (RTL8367S-VB) ignore it in l2_add_uc().
 	 */
 	efid = db.type == DSA_DB_BRIDGE ? db.bridge.num : 0;
 
@@ -654,6 +655,8 @@ int rtl83xx_port_fdb_del(struct dsa_switch *ds, int port,
 	/*
 	 * DSA_DB_BRIDGE ports use bridge number [1..N] as EFID, while
 	 * DSA_DB_PORT use the default EFID (0), not used by any bridge.
+	 * Chips without an EFID in their L2 table (RTL8367S-VB) ignore it in
+	 * l2_del_uc().
 	 */
 	efid = db.type == DSA_DB_BRIDGE ? db.bridge.num : 0;
 
-- 
2.53.0

