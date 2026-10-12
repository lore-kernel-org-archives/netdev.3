Received: from sonic311-25.consmr.mail.ne1.yahoo.com (sonic311-25.consmr.mail.ne1.yahoo.com [66.163.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252D3F9C0
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791764171; cv=none; b=YFo6DqMypgvCIYhmHx2AdxqlgMuXaPamaNQyp/JLRE4rH90+Rdhx4w6S4BS5nX4p44NpEUpih+xom35irWuHufwmj3rYA0N5u2+CIY9duct5kMvjaj5ygkbE5wuqjyCNhaHPg0MPDu0mxvgEbsAYQExxbXpZKq9BfgdL8F4Mgxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791764171; c=relaxed/simple;
	bh=PftRRC/I+2OATJ9SSXi+m0AkjJZaN1dGrwPODdJ9Zc0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=MsF8YsNmiCUlHQUqBHJsvTFuU02hBl2uuJJTK0wgGizc8IOktjgAmvTojywP7jfEKrvfCdWq2tLeCSmxuv68HtBDnlvvOGn9k01WXZ57yEYpXsaLV6hzDW3BG9tSsSv5VKaO/At4mmX1ZgR+6tk15BSrEdNm+AMp66n+BHIx5bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bnJD2oyT; arc=none smtp.client-ip=66.163.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bnJD2oyT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791764168; bh=6r47wd2OKY/SVkkbt0WI7B6uSrlczdjq6ZPCP0i1DlU=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=bnJD2oyT/wgeScCx3ZE+X4Vp+7fLtgrIBwOcuTOtPUvI2yf3oH/VMS922SWxRLX/oVg4tyLN/u8WS2w9nCe1XiUahQnTs2zAfqBzQyHPKtzghNlz6PZLyLcvB4sOVLJdpDe+yOwb+Mda+3KbzrkmdBpKGt6JTGGdtOISKdgYhb7NYdt79VnROro4PPlLp6a1C+8vFNZa7Eezh0PJGYwhxqE2xjZiRNs18lgg5//RWnOH9GU4qX8qsMlkUfuHqIWnjEQgYeuKf89KAJxNTxyJT4JDMQdTjfzCQtKsFnlbzN2sNwhMb354cLAQvtYlkGTo75gsI/OahMWjWYj1T8jgYA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791764168; bh=Cz5Mz/euLvD63b93SkrBNuw5SThrLUwaT9t24OyPpd7=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=bNanDIYqp/RlSe8Zw5V3jCkvPmxNJ+FezJlWjsu/ScJEsI/p5oJPFPRy5DWwQlvXwou1UrZRdCuChVNCbJqeox+ljaXbzG2t/Ff5bsCLDtSFHLvAh2C29Hm0IUd1LpBfiZ+nSB/fDKxP0W1X+V0AUD0oZ4tx7LVSj7qJ33CGhKV4jBI5M49+PtQcw0VSeoVEi1d2vesFs+90yZo+ut8uy03jr8KV3r+dwK9Qa3b/HG23UAuks20/AFxqVrrv1PhhZXoyXjYWlOPtetDEI2KLYaQhu96904w3brKwpW8NODcR8X7x+fIzBxb+Co3+Ua6dnWdgO9KyFhW/qXxQ71W2EA==
X-YMail-OSG: .Tb8YqIVM1nnn9_1iFG6wBg8PZRbmG8aYmwxhvUyLjsFddwkoGFPO_wDqaxopK5
 0eVhgw04mWtxh7JUvKFW2pukICWRpcWzwHm4ueYYGYm5srOz5f9r5_g2hjQKpKg2B4aupLVEV3NF
 y5ZcBH7do2zB7vVh_t56psztx0Gb9GQWDUoo9jmFPXqnwud8xbY7tc1LZCSmGhcxgG2TvqY_mqNP
 utMf8Gvpny9J44gr2qI2l4VrGoFvif7VQB.0l1SOqVbWip6iEYFYmxw7lCfO8mAGOxb8N1BPYpKq
 ur39hW1dRP4M8xuGunPnc6W6PqWRZcQeunOJBXXXNACvjhLVBkrtCDTZeL89bUCRINR3V0QXJ.Lo
 j3seqocGBCGtYvANuUKnWuHx3o3E20nz8MZldwET0tlC7261N55pTpksv1gBwD4NCoaM_C0Nl10u
 ZrS6d.EsSvV3ieMQf_Yt.zaPf1.aWuPVH7it.ht.hIcd0Ucybm4Agt8F9Opjh0nkOZ0HTjDYNg3u
 .bvvP1u9mtox78ZkLTLaGP178CWoQHQ8iQfw6UHSZfDeXlfy.DAgEMkU6bULxu0DgNK436__F9AF
 _kWwpy5fadrOmOQQZ9C1J0o80Dk80.XnAI6qWm2p7pYT.eeK.OehVYZy.u_vU2HXpLQTkAJqHUpa
 dqVz.G_2NVwWRQ3MdAXbLnldE755VXAtjYpAvEE.rKXNMJdEiLei8obUD2OpNErrFFyObqTHsvLg
 .W8DKVqOMjrOAvVulX7kbATya0cREf11u7S_RVdYrptLVsLsMC3dj3Rzrh85Y_oUk7aHZxYhRYpn
 gjpBL_AO8_.Lu3uX4Bh5F78EBuF_2xZ7sMF.5dsjqkwmgBIqdWUxqjM0KXfXCfvtjBO1JP6_y6xe
 ydm9QAyEHzFjVvtyRkA4cuYVogie1nb1U7kuSTJBIPS5jRc6.Pc_cZzt3sWs1.bhmFA4g7EXoWmf
 QW7GPM3jy_i6i9qmWX8nHdnpMQlvSuwjkxj0YSP4Vmni_2WhGNWEiokOgG5rG55.EylTH7jRYFmQ
 8HpALsCBGcIUHMStcoE.x8bgc.qEi1rK92g1ORdmT_v9td0ona2meg8XB.K2BsA3Zwg03HSS55rD
 vDSJsCWYbGiPDczChMP928gE.Z7fQdiR_6l8V42UAWHF.kFGJ8HzGeDqineL3i6z20Q3Ek2S0nnJ
 ZY6Sj9C6_nmllXG1JXMpQQTDeB.NO3VtvEXpBpsLAmoBhkVcy1XDcCqF46qUTx4l4b6DLCHciQpY
 24tjzPE88wnAlGfZpy.FDpogWi95TbP6.fA10ANeaXAof2E6gN_7iwjCY04O0TZyH85h8PMMZey5
 ZjImwzhiqqXJk46EC1CiFWVcUIJHG6Cl.6a5b4N.30lTg1gMD0Z6CDga_80l9gQVIYVvWs7fxpHn
 r2rRHdnohQlloZMqHnSiiNwO6mI8ik3AvtKljrbqdBK_t.LGfKa1rGHFABjAg_2RPktQ7cWAIpK0
 4daIr3MKf_PfpU5fY0pt_17hC5XutxNTv0pUmF8vbHxiEKGv9e3zOFFmCKRYMsYlFNAmBQ2GKp_E
 dCNTJ3h1KOQjab1rcu6koZDsNn2xa3EB3c5B7K9N5_l2tPp1WKo3kz4g7lHzI8YRgUD.gQP4GFxE
 6H7niBCxKPAd4lgApBPfhm_.t3INWlMX2LpfiRIT6ZHWypVHBDQK520Mh8D2O7siGv9DHpUqouLt
 1JQ7rSBeIkPSb9Rmvqoxs6Tx6mLljEp3iIJs4VMFTfm0ve37AmSiH_1keHM7mfxU5vNYslUxJ1X8
 2LJrZwZS7IokDk2z062neZaranloGVDZdCIkxw6U34PLo2CQfHvIsGR3W3EKcLp2CQ1p3z88Jf6z
 QJi8J7ZAtfcDxch8BWuyDB9uhIcPzmVbI3ogJpvqb3Hwuo.VTfwI0SVFWEn3Hu_.dVSnye5l03mq
 TX07Aa7VlB7MLme2DbvfTHJmJzitmrzRZivLFUQ1CTpn.wXeMypdL26HcVUs0IBEgi5JoXLZrJId
 YImIl17a0KpdRIQgYiB30oYVjIaB0u8TCC.ETpOxh2b_YuO8qjE3jVzQGWD0Qh_mOn3PbGWgr6XV
 RTcz7Azl9Emqeo_yVTJ8iuPZqkJhlZM1_Wls96OHO2eVda1LiMCySAK50xO.CSpFJperoGFiyZVo
 qiXTJ6B2ZorevCQsn7IzlAVH52l.h9qxiuZTUDwv5BlrrSyxRO34yzBTrkU_6AEbfD7j_2c8qTO9
 Dun0O998nViBcgx.O9AJn9k12Z4nDTVL81qKKhdlsA.4lRfqdN.k3sPw8OCmy60t0UargiYMvIcV
 _qUzNj3.2FoCflw2rzUtfcDOg.NDVKAuNQ5b5PiEFFYhvcG._mg--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: c102245a-b758-4265-89ff-dcc479c199a2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2026 00:16:08 +0000
Received: by hermes--production-ir2-5dd9bf4598-bbdwl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c40a054550bb126f9e2b8b3d89399e25;
          Mon, 12 Oct 2026 00:16:06 +0000 (UTC)
Message-ID: <ccaab57b-1bab-440d-a4ac-d3e467240695@yahoo.com>
Date: Mon, 12 Oct 2026 02:16:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v4 9/9] net: dsa: realtek: rtl8365mb: add support for
 RTL8367S-VB
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com>
Content-Language: pl
In-Reply-To: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Add the RTL8367S-VB (chip ID 0x6642, version 0x0010) to the chip table.
It is the first chip of family D, whose handling was added in the
preceding patches, so this is the patch that makes it reachable.

The SGMII/HSGMII SerDes of this chip sits on external interface 0
(port 6), and the MII/TMII/RMII/RGMII interface on external interface 1
(port 7), the other way round than on family C chips. The chip reuses the
existing initialization jam table.

The chip has 8 ports, not 11. Cap priv->num_ports at
RTL8365MB_D_MAX_NUM_PORTS for family D. This is a functional change: it
sets ds->num_ports, the IRQ domain size and the bound of every loop over
priv->num_ports.

The L2 learning limit is the same as on family C (2112 entries), as
given by the Realtek rtl8367 common API (rtl8367_common V1.4.2), so
RTL8365MB_LEARN_LIMIT_MAX needs no per-family handling; only its
comment is updated.

Tested on a TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII
to an IPQ5018) with bridge VLAN filtering and per-port PVIDs. RGMII and
SGMII modes have not yet been tested.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 31 +++++++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index bef95f9..72f308d 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -89,6 +89,12 @@
  * things will work out-of-the-box for other chips, and a careful review of the
  * vendor driver may be needed to expand support. The RTL8365MB-VC seems to be
  * one of the simpler chips.
+ *
+ * The RTL8367S-VB (chip ID 0x6642) is not part of the family listed above. It
+ * belongs to a newer generation, which this driver calls family D. Its
+ * registers differ in the VLAN table, the external interface speed and RGMII
+ * configuration and the SerDes, so the code paths specific to it are selected
+ * with rtl8365mb_get_family().
  */
 
 #include <linux/bitfield.h>
@@ -118,9 +124,10 @@
 #define RTL8365MB_NUM_PHYREGS		32
 #define RTL8365MB_PHYREGMAX		(RTL8365MB_NUM_PHYREGS - 1)
 #define RTL8365MB_MAX_NUM_PORTS		11
-/* Valid for the whole family except RTL8370B, which has 4160 entries.
- * RTL8370B is mentioned in vendor code but it might not even belong
- * to the same RTL8367C family.
+#define RTL8365MB_D_MAX_NUM_PORTS	8
+/* Valid for the whole RTL8367C family (and for family D, RTL8367S-VB)
+ * except RTL8370B, which has 4160 entries. RTL8370B is mentioned in
+ * vendor code but it might not even belong to the same RTL8367C family.
  */
 #define RTL8365MB_LEARN_LIMIT_MAX	2112
 #define RTL8365MB_MAX_NUM_EXTINTS	3
@@ -884,6 +891,19 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.jam_table = rtl8365mb_init_jam_8365mb_vc,
 		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
 	},
+	{
+		.name = "RTL8367S-VB",
+		.chip_id = 0x6642,
+		.chip_ver = 0x0010,
+		.family = RTL8365MB_FAMILY_D,
+		.extints = {
+			{ 6, 0, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
+			{ 7, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
+				PHY_INTF(RMII) | PHY_INTF(RGMII) },
+		},
+		.jam_table = rtl8365mb_init_jam_8365mb_vc,
+		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
+	},
 };
 
 enum rtl8365mb_stp_state {
@@ -3850,7 +3870,10 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 
 	dev_info(priv->dev, "found an %s switch\n", mb->chip_info->name);
 
-	priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
+		priv->num_ports = RTL8365MB_D_MAX_NUM_PORTS;
+	else
+		priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
 
 	ret = devm_mutex_init(priv->dev, &mb->sds_lock);
 	if (ret)
-- 
2.53.0

