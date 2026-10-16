Received: from sonic316-21.consmr.mail.ne1.yahoo.com (sonic316-21.consmr.mail.ne1.yahoo.com [66.163.187.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E831E83B
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112999; cv=none; b=RhrSrOG9+wpkJc1lhOY58UbEKYpNFbw11/L5zEDtZeWY4zPPmE2Cu2pUveMCUI8i1wVW49qmj4UejOB3/d8FP5xAz8Au7z/bSpf0m/B33iYS0VC2w9bapYdvufsjNbUzNvVrYmaLzbVClOHHnEj/Ah4SWFskvbYQGwNMLCIqGpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112999; c=relaxed/simple;
	bh=Xx6LliwcDhoiX6gLGyvwgG6t61NjsVI7HLg4e6ErVAc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=dx3QF0ZTQaVkPYEbbAFTCcv1DIUqp7WkopO+Wzr8xlp3Joa9z8x5SajGsbLmkD/hOnpcEJSHFQET8Vnc5D3GAYwq6trn79CK3iaEanU/Les5bT1mgzQlWQ9un/PXQYSjVokX4GB8+lQv05VBfaBRe/MCtFWeOdHANdyGWZLwPMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=H1dZgE8l; arc=none smtp.client-ip=66.163.187.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="H1dZgE8l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792112989; bh=S4jVjrZEmP/QJFeNygivn701U2bJIMm4L4XvJIxwUEc=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=H1dZgE8ltlZuP7WfFZRI2dBsW1CG6KYDev7F09z4cN1wV02owFXO5GyFWaF1KOEKI8LqfxVsGVAGK3Cgn/Mucv8wROT/l9vkqrgrqqfOYEYpQLnD5me7/EjsKRsM3Fy2Driv4hPcygli2ZYOR5N1+ohwWy8HCUqFrKlXB3EpDccwQOoRwMLkM4mmk+/6XscjACd8x9sV69zaXNiQo1bhMt3nMptd6dUttXgP3zNPyY27dgYeDC9GntrTKw80dOLLiII4+O101okSZnoyClDlRzvywcPQVJN8c+DGnePyBm8ewFIWILf5KYPAyejCamn308edSgHunEhXxOnnIgowDw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792112989; bh=adRqu0g5kaTeQci8B1AanvO0wGKJdqlyzI99rmglzCq=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=LuKhepw72ArJlueyGSWkzJSzsb6TZ/jHhfadB8c8SkqytqHIUhfNGIUKR12aK32gn18LH1vJC6kC4Yfu9DPvyMG09rAKf7n/MwDBRoIwFpFhiHZFXxERUMhq36qHgXjHGB9HRaCjaGWUuzQ3K044Cp1H6+cZFd41xB/F4JzcRHDI5gqdwl/WFqtXYmvnQnh7EzCs8MmkL41WgG/2Jr6dBPbx361H0FDmKIZgz6S51ISEvFtq4xtubANZ1ijglMY0tUJfH42UvQtItk/TrWswGAIe5em/queoJEsymuUPa3MQIyOjOkplOlJntUewSMiwD+DO6orbrZyOOpqXfZCV/g==
X-YMail-OSG: p_7XqYoVM1l6EDBi2TgvTn2hSYmy6QHClCb72wOSyV.D.CZadvMGdHpjn3YfE4_
 PevSsIMjLuHktqgN8nB59cSGJ0mu8dlZtLR4pXOboABhFi_ZTwHPA2ivEkJeDgkP2.EG32v8KCUm
 zaTzsXK0B0.R23pXAEc7Zy38FtowZuxraPVAQRnsoqxWMUHIlWuv962LqcwKF0.sAILOSeX2IvSB
 FpoNd6Ta2UMU8nB_RHtsD2G4AKHR7O_2zuJ_RA61Yh_wSggiSz4fnZXTPZWXUKDiheqSTsy5Ah8J
 Ie44Qt_.YzrJTID_dN4WYcUx1iUM_ogxF1TwUbMS3Lv29hbsAAba8CfrUS76kkKqMsC.bFCS0B6d
 UkpS7DfMFIvhmBkh1lxRYUp1hQB0U4phpsgU6JR7qb7kF_lzMVBDj36UHSomRjQ.s.d6XB0QuFej
 aLheIjzQ.ObdbhWnGa9aQLlcw2akFN6WuQUCzCTI.jLg132PFYUZNTybAOl2d0UH.Xhsb820S9mt
 o_YrPouufLQzhWRUprK1mnUA_CygC6Xdw.NrVq5K8Jt2fm51jh1Pi2O7GktcpT6uzxDykWGPNraY
 8n0ZbAMvL1HeRuWI0FtsdLfumY7Ep4ufTHjarKXMJKws50zWwQ9NMh82.bk3wNj1cinXeFJIL689
 2hVcH0Bls5JpUMfNuDvKIaHzpLBAm.nh4Vn1Wlu6w3fo97LjIyUMp6YVFBzX9380bwT3XPxFO1vw
 4vTWLGPAymewyejf1u0aQDxD_PaxDTVtkIbJpRvu05Px_VWoUzvAaxSofRzQ0ijDm3ldaOWCe4RB
 ITsvD.At1_qmhvxvM.O68oAeESqykzPc1IDif8FpuHlw1VFqU5ziGenF1JeRVF8zEJX8nNau2uK_
 2zaIP2gehCnM6BiqFrH6YsNQ1eYnR.KawJxL5AvEEAmYiPMR1H.LVEozlU.p8Eap.OX7veNAXc9c
 x3w1TS1Nnt0zzxgZs8ocHj4jSEm4yw.0fn3IfBJrlE0EjfXSWBj1VcuQQFcA.dA5pRgl7a41A4PJ
 zkVEyJpe9e2lMizwOZghEAll2XjhIGSfykvD3KFobzYLl1uw0.bzoFuuAhASsHaS8C3X_li5PPhE
 v4WPI.x5Q4pq6EGWiBt8vm7NcQWLTXSlfLKgGWEDnUN.603wzUa2b.QKfeQbVr_mCW1ywSo5OKkm
 55Z9xybrOEB88FYZkFbHRyXYhJpjGcLrZZcmGh6NYtvuQaAxhvTYdDY2kosNpk0V_0nIUHpG2xzG
 fHTjftNg3fyswPbKwOU7aSrDiYuj9mrOpzxqC34MzWFynyMEVYPhSlgLEaNU7DJfQ7ePWOAZZQ4.
 VtiugM6JIm2kCUaSeVHUCDi375292Vd0vvKnesVmByXvQlEAZc7g_cyPtSJC.l5lX1qMV_NT8Pec
 5ls9kgte1V3Dc5yq.38sAk5C6posa.NcR4apmK8OVou2zODblTyOvy.CFr8NCbz8ynJddXw9_W.I
 o8mSJ_ocKAYjV0bHctl0U.EKKV80VEnxFPflIn0Wt5XgIy7apxuoAjBewSkTPXxlBg9SJn97XorD
 UEq1gmRJvroDWn2aXubdAdAUJA02PAFrOulHCCqKHRdCmQ9H0AC.lb49oxpMB9PFQ2VwtsKb_9uG
 _n0Nqodv5wDIhXP48voyzmu5z00a69dvTYK1iP2wegoqC.ony2_4C6jes3CTAhZ.XOAXBftCJGvK
 4uhcQSk5rurNAWPcGZw17_Tor3iB03JSpIapZW4op9h4Crv_ds7GmmS0Vn3TjZ.yudUDpDs6yt3l
 150_94WqSm01wDLVjNuAZsiYwfJTmPm9xlcCQs4gQDX7tvG0_rEKLEhNPIWziUL9745ijWsJbfLx
 F78qb3jUyhfTZw_1XPjWcNSXwXhjtW1ywKION.s2gvmV5Hlk8ks7V0IV4oJXpN1h8npjxxAWwBws
 3mVKy8oAz19TTSxk0PqzL38vm2.3Ni4EhJ5UKcH3hx3CNUilZ1B9YoKZtpBfx2OUY8big4YrU2TZ
 X3qWtfGgtWN1vYz0C.H4QdzN.kUMearKbftQRKFcG.T822Lj4BPZ6ApNXfI0MudB0w9xboefIsEB
 chOo.LFWaq2EIZFjpb4zVt416o8.5dnTiDTRooO7f3qqbAfYTLIU0h6TwJIEX7DPKIv.oj8LiYMA
 Ojs5ue4FTsNQk4NaH2aTmJSb3iaQ7PgULAcJMAy3Zg0vbXwEKSnJLUd9Pm6cw_o4OGWvWdYltFjS
 DapE1kJbeB8InRumDGBGTgVmWM9uGG3YX5zH6B0I5vpq_wUgdcFO_rk3E9oYtEBNVJmWI5kGnl0Z
 dn6noWJdp.HAtKQTYsDKo1jre_rZlLLbeHz9qzLxR
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 74a8b79c-dd26-459a-97ad-2459acb7c52e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Oct 2026 01:09:49 +0000
Received: by hermes--production-ir2-5dd9bf4598-cdfcp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 57d8cca23d589e339ba0a93d0327d3e8;
          Fri, 16 Oct 2026 01:09:45 +0000 (UTC)
Message-ID: <3cb754f2-dc21-4de3-b245-b970719925fd@yahoo.com>
Date: Fri, 16 Oct 2026 03:09:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v6 9/9] net: dsa: realtek: rtl8365mb: add support for
 RTL8367S-VB
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com>
Content-Language: pl
In-Reply-To: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26740 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Add the RTL8367S-VB (chip ID 0x6642, version 0x0010) to the chip table.
It is the first chip of family D, whose handling was added in the
preceding patches, so this is the patch that makes it reachable.

The SGMII/HSGMII SerDes of this chip sits on port 6 and the
MII/TMII/RMII/RGMII interface on port 7, as on family C, but the external
interface indices are one lower (EXT0 and EXT1 instead of EXT1 and EXT2).
The chip reuses the existing initialization jam table.

The chip has 8 ports, not 11. Cap priv->num_ports at
RTL8365MB_D_MAX_NUM_PORTS for family D. This is a functional change: it
sets ds->num_ports, the IRQ domain size and the bound of every loop over
priv->num_ports.

The L2 learning limit is the same as on family C (2112 entries), as
given by the Realtek rtl8367 common API (rtl8367_common V1.4.2), so
RTL8365MB_LEARN_LIMIT_MAX needs no per-family handling; only its
comment is updated.

Tested on a TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII
to an IPQ5018) with bridge VLAN filtering and per-port PVIDs. SGMII has
also been seen working, but I no longer have the exact link partner and
speed it was tested with, so treat it as lightly tested. RGMII mode has
not yet been tested.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 32 +++++++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index a1155a7..dbf21a6 100644
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
@@ -120,9 +126,10 @@
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
@@ -887,6 +894,19 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
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
@@ -3943,7 +3963,11 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 
 	dev_info(priv->dev, "found an %s switch\n", mb->chip_info->name);
 
-	priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
+		priv->num_ports = RTL8365MB_D_MAX_NUM_PORTS;
+	else
+		priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
+
 	mb->priv = priv;
 
 	ret = devm_mutex_init(priv->dev, &mb->sds_lock);
-- 
2.53.0

