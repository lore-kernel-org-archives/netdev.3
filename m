Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.191.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505272;
	b=MS7zOWPscfv1jEQFw5HrJRFKUs7F2XL7f3w58Qg+NpbtSbXitTCr1Fg3/++FH9F+H8gY
	 PnmlVrvXxLgkZAtgdCjkYWVWy7BK0BCGC8dsG7rG8eqUUp6gJ8DSZgFbA9Q7uvoVY9X9L
	 iN0lY+BTPpqajr1botxbVnAFYymfOS9BBBL+a7aunRiZGxbUKvkXPHIS8ZU/vQdasvvuF
	 T8F60SUHvN540KwDc9OrKgua6kWzpb5Mu7GyHShFb2EdbSMj3ReDrhWp0ly+PXBqLheJE
	 f15tKD7DgB3tTUhyFr3CL4+Az1w9sg8QHZRSUoz9tfWitFOqK5mnUV3Qb+bJ5RBPqUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505272;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=+H+2LCbcewGODBQFjram/ZEkir8eAtD0/dC/SP51xRM=;
	b=hlVwmGe2RHtA4Kwg11gWhKsWLhstwyrgaBCzklZUghO3iB2WU3vdrTMmEQpxUWBsp1bG
	 jhIzQzdzRNtsfnq/jfsUmpMqks6GeiemQO+1VC0fxMsUNDzPnDnKRxiGuSWp8qYHwg9fF
	 XQnmY8wLBn0y+f8H38WKsyBa9/SQbtQpVAokcWJHwLfk9ygULp0xV1IHtk7EqxkGXcb6j
	 STdZ7BKqU+7+NeE2KfTWUs0fsaLfoLti6pmyAPi6ZOa0cb3SdAsDO9Ha8OmpVvIjaGsG2
	 xS2eYHXsWCbEg6AbCbxJvrVb/QatwdiuRSot39Ji19fvd3ltUTYP6opUYI51v01EA9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Jaoed6+P;
	arc=none smtp.remote-ip=66.163.191.205
Received: from sonic312-24.consmr.mail.ne1.yahoo.com (sonic312-24.consmr.mail.ne1.yahoo.com [66.163.191.205])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5408D606A238
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5408D606A238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Jaoed6+P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794505270; bh=+H+2LCbcewGODBQFjram/ZEkir8eAtD0/dC/SP51xRM=; h=Date:Subject:From:To:References:In-Reply-To:Content-Type:From:Subject:Reply-To:Content-Type; b=Jaoed6+PnJMbcZ1G8BD6nDX4RHwxfNP6dseBS5zS3aZ1ehAlr2iPdmixxo9SdYK2pW6zIPwZT9R9kxA6C0XOWuGeqYDi+Z5uiNxfmd70l1RMBpRVrkYbPEZquIa7c4Nj3NuWxJRLafflyB1BUczKPryQjEOkrpZuvQBeNCP5d9xUQVBNiAVp4dAWRaXq5qj8LE1axLQwh0vpZs66MvVut+Y4szRPCdaJNxV9PdZ8S9FpZGiAhTTugCs3flU1erfxF1soV8e1NiTfRGvrF/AQbNYgYhQ8/tycWXrzoLswQRVpqgp0YgUVrNugdl78vqMghg2Jx7uy1rsHNbE4YT0xQA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794505270; bh=wvjf/2C3Rj9GgwXaghXKeiQNat+lZi1yZZGo/DfFbZZ=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=ioYgC2/JDgq9cETURu288WRj9xH2m8kIHlSk+iQZxNoeJSA4k3GFXHfs2mb+s4wbqu44UjsBWn9w5Lsgw2EM54Viam60mZSt6ZDsXSJoVEBFeBXRkcpa2K3n7SjkmyeQS5SaewYjRRALME+SqmmTLy8+Xyoex2+6RUdgsOVgcruVXoq5Wc5pf6QEVc6F/OjBDWTRwG6RDVSyZyDr0BuZTdxRQqe25+WBse7OFwtH7wDI8mGMZnDw5v86vFwFS96vKP0+CeLgTBpqefLMyFozBNyXrvj8YsPG6zrktkgwpCDK0hxv6dRFiTUc52aS8Q8vExMaFFEInaZVtKAZI7aHTw==
X-YMail-OSG: i2bEcjEVM1l.iDKEVpzocEgtegjBgXgfxeE0p7fYOa6ValId64Hnsy8G3MWRUvr
 AmsO1exwlgtq5G0rm1LHRBpgzCJcfhDIrzXAMfGpcKz66.dSlnZl1lXcnhPQu3c0wfHSQdFRzATK
 .mkb22qbPJQe8FRHa_Ogkw4Dlhh3pYaE8zQwhjZOCL6noefDSgO8qJFdiptdSDafI6LoHkHkdSvb
 L7NZVrWPJ7vqZBERx_mGcCENdaeCtzI9a7rOm2YdZcJkDEm7.z9EQVddTTo9_l1nCL6_kD9pWVus
 xUptPlAgNz6qCHQQOdqDc1pbPxcyeid7cX7YzlWnnsNCji82JWalCJ_1nKHGuu1M3yYRG3iQMj7O
 dQAAwbANDi_wdbXMbZeHzoaCKi.LzBYBLNLqt8xAwR0tiYc8CInmrabYFdfZAgLeVizeqwX7QFjM
 qcnsn9zHhMIUQrCVTFcQGvqYdaoZweC0qzYu0J0QTs48fDel3lmVOMWHH9cJBrVLvhxWoTnOZ0hE
 v_0Go6THIqP.Z4naNSb1LWT6Ee9dXV1gG69M_LUsQ5DBY5eM0z2ZWlq7mCObGBya_bUR3NVaNsQt
 3s.eQA0vISz0Zw1u5NpDpga_jzlTyBecE_7HoV19ANP3AnBBVD.TbWz6lVriAMHBKaV_sb4VHE6Q
 HBKzv4juI80s38vIF90qPx5AwsOfIOlJ4x6KGbhBmfCVKjIn.p68OYjPO6WUChEtCBosuidgdvwQ
 wCigoQR2ClH7uqQjhkH2yi7aoLYiquvW5iWBlSZC7MMOpfP0rqbrTjzehI0HvGNP6A43D7hH.eny
 62a.wxV0TiVZBN_ecNTZ4eFSfnWdPzvD_Dqx.Uga7wmNxcqyHWMFVMubyHP8zdA1maAKRWwXw43S
 SzM9BwY10wrlH8OJIyTxE9JfmONlaZSOsVjutiGteNiQKSZ2Jgpw6XVYZkf.OVw.A3ybP3QHJipj
 hktjwxqj6GEDGN0S5uzR4DgwQy71DGvkAdGk96YW7c9uq_7ziTyVRNRBC5L43KnvEOCSYMMLVh.w
 69uVl6i3.JHV_KhWZiEsf9a1_z4GTSx6QjsH_Q_QibcegcbLnI7SOBj92160d_YefMhdlZuzP3Ld
 p8wE3NKB_J8Md3JHw.nNuzJZI4Dl69ehiutO0rgje3xaQGfd3WbIk6hIEoL6NUpxwp2z_tiJKfrN
 CGv.Cqw3KzzGY7F1uo7tobw3VWh43heTdo9CelILFRwSR81qX0duJK2DoAFIEHAebH7RKvlZP.AF
 3Q68phHrn4WoD8VUYOn16FFf0F7e9iWSrCo9LQpyoAJLOS1OCH3Q7fqWIaYyMppVzDrYp2UY4jG4
 d6GQH_DkknoxySMFIJ4qfsjGxAERbXB0DOCxizEZsC3igZ9kmzpfCjvYAdbbaCnz1lvUJuX1MS57
 2Jm7kkdcO2QANRauPXmMG0o7XfbLoy16GOl1HU_tKorzddndUrubfzeLCOR9cv0CpLViZ4CDt7Zn
 fiNbr7zT_.M6jDtD3u.AU1e_lK8fUyYMxU5aacucOGTM6Ho4e2faVzNH5OZyjJyDbWiHGRkt19o_
 x9I4mhxmPorV2ijQgL8ZhnVsqwXea1qfK8rRmYQnuZAxpgn6a3LB8fmzVP1OdIvHJZYDjQ6ElUZI
 cOpTvwi0d0QDa3y6tpXdO6l0DNPqpR9pBRIy5F8v82TsitLCGgr4oIvV45hTh0rXq3fAH7vauIog
 g9PT0CaFBihnvd5HFIYoW56pq9lRyFnRe6djxf6IIiwvccPb5ehzuFb0c1_RDhhq6ylOIYX.uW5Z
 Ie8_FrGYBn12xVOsBUTUUEN9U_vyJ_XKYVMHITuzUnRWt3DmSIVUEl38gzGTL.GZFo7DPYMCxPsr
 QjY3ptzSmtu7B1znIN619FZa7drsRzCgjTjS9DB_i_4kFGmqVRk.1YMKvMRJERiSnwCq3GllT56N
 ng_QbqCKd22uSMlwr1.shP17iJZ7U.6at3raNb2LaFb16HALhvFzmgG0lfxa9U8VdcsM8hGYXkV1
 qY6C7xOMHdHwXa_S5SKrhTteQs0JKIjak3DOykagavPM1LSL3.xk6dJOu56OfGTQMtLY.NKbdlrM
 m_lHSyEnW0GMTFQOa58ch5f4Txq30rSHo64q4gqoaradCemxaUjZk.04bscFgBI0pr.QpbCU9Ue2
 RqekWQb3ajqrSn_YS.HbFdLCFwczn4redKX4QpoqJzWbmTs.p52w3b8wy7B.MOSmgPCoUsxFa1Oh
 yC_obdgTk1WHd_Lhm9.VF_dw.ESHsgzyLaA7_0zycosmtIgHWyFMGXUUpOQLcfiMuKBQFrBOwxkj
 bWh4VmUEFD2HCX204DeBN_b767U1PU6D6ss5.63CsXbTvYhUlDVZ4
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: a7064612-427d-45e6-96b4-d21b10c857bd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Nov 2026 17:41:10 +0000
Received: by hermes--production-ir2-5dd9bf4598-bgsl4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 73d71d1c0e3ae6dda4d544624c8d77ba;
          Thu, 12 Nov 2026 17:41:06 +0000 (UTC)
Message-ID: <ddc3b324-fe93-4c1d-a4da-558c0d6e88f1@yahoo.com>
Date: Thu, 12 Nov 2026 18:41:04 +0100
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
Subject: [PATCH net-next v10 11/12] net: dsa: realtek: rtl8365mb: make L2/LUT
 access work on family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alvin.sipraga@analog.com, gusfmora@gmail.com, kuncy7@gmail.com,
 fabianotassotti@gmail.com, gabonpivovich@gmail.com, contact@c127.dev
References: <d9da17af-f49e-4878-a8dd-59a8919e6930@yahoo.com>
Content-Language: pl
In-Reply-To: <d9da17af-f49e-4878-a8dd-59a8919e6930@yahoo.com>
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
   is selected through struct rtl8365mb_family_info. The IVL bit is set
   only for a non-zero VID, so VID 0 produces the SVL key (IVL=0, FID=0)
   and static unicast and multicast entries match the learned ones in a
   VLAN-unaware bridge. Entries read back with IVL=0 are reported with
   VID 0. Use age 6 for static unicast entries as the vendor code does.
   Look an entry up before deleting it, so that a missing entry is not
   allocated by the delete; as the key has no EFID, an entry found on
   another port or one that is not static is left alone.
 - rtl8365mb_main: make port_set_efid() a no-op on family D, add a LUT
   init step that clears IPMC_HASH and BCAM_DISABLE and writes 3000 to
   the aging timer register, as dal_rtl8367d_l2_init() does in the
   vendor RTL8367D API (the unit is not documented), and do not
   advertise fdb_isolation. Without EFID the bridges cannot be told
   apart in the LUT, so offload only one bridge (max_num_bridges = 1).
   Further bridges fall back to software forwarding, and traffic
   between them is isolated by the port isolation masks only.

Without EFID, FID 0 is shared by every port that is not in a VLAN-aware
bridge: standalone ports, ports of bridges left to software and the
offloaded VLAN-unaware bridge. There is no isolation between them in the
LUT, only the port isolation masks. DSA does not program FDB/MDB
entries of standalone ports here, as fdb_isolation is not set, so those
ports get no host address filtering and their traffic goes to the CPU.
A MAC learned in FID 0 on a bridge port may therefore also be hit by
traffic from a standalone port, or from a software-bridged one, until
the entry ages out or is replaced. This was observed by Gustavo Foletto
Mora: with the hosts on standalone ports of the same switch, unicast to
a host was dropped once its MAC had been learned on the VLAN-unaware
bridge side. With learning off on the bridge ports it was forwarded, and
with a VLAN-aware bridge it did not happen.

Register layouts follow the vendor RTL8367D API; the code itself is an
independent implementation.

Tested by Gustavo Foletto Mora on a TP-Link EX511 v2 (RTL8367S-VB, CPU
port 6 over 1G SGMII to an IPQ5018). With a VLAN-aware bridge: per-VID
FDB readback, static entries replacing learned ones and being deleted
again on every port and VID, the same MAC as a static entry on two
VIDs, MDB entries, VLAN add/delete churn, and moving a port to a second
bridge (handled in software). With a VLAN-unaware bridge: a static entry
with VID 0 replaces the learned one and traffic follows it, a static
entry pointing at the ingress port drops the frames, the MAC relearns on
the original port after the delete; traffic to the bridge MAC no longer
floods to the WAN port; MDB entries limit the flood to the group
members and the flood returns after the delete. Unicast and multicast
forwarding were also checked with loopback cables between user ports
(known and unknown unicast, static entries on the wrong port, MDB, 20k
full-size pings without loss or port errors). MACs of foreign ports
(a veth standing in for a Wi-Fi station) become entries on the CPU port
through assisted learning. Real Wi-Fi stations, RGMII and 2500base-x
were not covered by this test. Leaving a dynamic or foreign-port entry
alone in l2_del_uc() was not exercised.

Nothing points to them until the family D info is added together with
the chip table entry in the last patch. Until then they are not static
and are declared in rtl8365mb_l2.h, so that the build does not warn
about unused functions.

Reported-by: Gustavo Foletto Mora <gusfmora@gmail.com>
Closes: https://github.com/openwrt/openwrt/pull/19644#issuecomment-6708118180
Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
Tested-by: Stanislaw Pal <kuncy7@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/realtek.h         |   4 +-
 drivers/net/dsa/realtek/rtl8365mb_l2.c    | 124 +++++++++++++++++++++-
 drivers/net/dsa/realtek/rtl8365mb_l2.h    |   6 ++
 drivers/net/dsa/realtek/rtl8365mb_main.c  |  55 +++++++++-
 drivers/net/dsa/realtek/rtl8365mb_table.c |  44 ++++++--
 drivers/net/dsa/realtek/rtl83xx.c         |   5 +-
 6 files changed, 221 insertions(+), 17 deletions(-)

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
index cd5b333..14acc84 100644
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
 
@@ -349,6 +437,38 @@ int rtl8365mb_l2_del_uc(struct realtek_priv *priv, int port,
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
+		 * belong to another port or bridge: leave it alone. DSA only
+		 * programs static entries, so leave a dynamic one alone too,
+		 * as the hardware may have relearned or aged it since the
+		 * lookup.
+		 */
+		fi->l2_data_to_uc(data, &found);
+		if (found.port != port || !found.is_static)
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
index 525588e..5d822ad 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -435,6 +435,18 @@
 #define RTL8365MB_LUT_PORT_LEARN_LIMIT_REG(_physport) \
 		(RTL8365MB_LUT_PORT_LEARN_LIMIT_BASE + (_physport))
 
+/* Family D LUT configuration */
+#define RTL8365MB_D_LUT_CFG_REG			0x0A30
+#define   RTL8365MB_D_LUT_CFG_BCAM_DISABLE_MASK	BIT(6)
+#define   RTL8365MB_D_LUT_CFG_IPMC_HASH_MASK	BIT(4)
+/* On family C this address is the per-port EFID register! */
+#define RTL8365MB_D_LUT_CFG2_REG		0x0A32
+/* Written as a whole register, as dal_rtl8367d_l2_init() does in the
+ * vendor API: the field layout and the unit of this value are not
+ * documented.
+ */
+#define   RTL8365MB_D_LUT_AGING_DEFAULT		3000
+
 /* Port isolation (forwarding mask) registers */
 #define RTL8365MB_PORT_ISOLATION_REG_BASE		0x08A2
 #define RTL8365MB_PORT_ISOLATION_REG(_physport) \
@@ -2650,6 +2662,10 @@ static int rtl8365mb_port_pre_bridge_flags(struct dsa_switch *ds, int port,
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
@@ -3386,6 +3402,23 @@ static int rtl8365mb_change_tag_protocol(struct dsa_switch *ds,
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
@@ -3475,6 +3508,15 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
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
@@ -3600,9 +3642,16 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
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

