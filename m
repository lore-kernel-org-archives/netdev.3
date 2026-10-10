Received: from sonic310-24.consmr.mail.ne1.yahoo.com (sonic310-24.consmr.mail.ne1.yahoo.com [66.163.186.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948F93CC315
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661507; cv=none; b=PadlYJbFu2NRY9pstB2IAAwU81tibXQrEqtcJsEczI49hr9UnrtMfXVBUCuDx99RJH7sAXrD3O8O2zwY5pCMYHQEFvGWV5iR0OPQFkBMFOLNwJdCXhp22xfLnDfdsSflqwmAtD3WwPqoXEfSmMgb4vGJfAPwjZ/6/T55GOSWBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661507; c=relaxed/simple;
	bh=o4sj9TMlaQemOT0I/UuZE81Gd5fmF8J4vK6aDbcbc3c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=aa95yGF0XliJ4dqZftZctXTC3Q/+VfH+rJesnMzp1qPqYWH8lD5jVTVHG3j4aUFfgggjy/pSDl+QI6TpcENX03e+EiEciWmr2/nRWrdzwlsHd2TJESsRHqdn1OSjhlUncQHc1isvKGTZcNdHnxqEZCbgiolMegSI8HoLEs4IZ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=CfrE+yAF; arc=none smtp.client-ip=66.163.186.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CfrE+yAF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661497; bh=A1iomQdYyd+5MMtNNZ94Yi3jTdT30m7TFYDS68ug5i0=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=CfrE+yAF9wt2taYlJjIP3s5SLUBv0oZrvMSN2ORXuwfS/vRQs/t0TFxCQBqbQ6TMhq+zOAG8DIJ8smMkTunQS+ddi5GKHadw5C6da0DQb2BWr6wIlbijx3CaS1utBtoD156AqJ1LnNVI2fHWOH5YIclUV7o48+Bm4zGiAC1xWiZ0/TyqBhF3xJgM7Q/0roYyAk1KyMYqGAq/S758B/j7PLUR6X5wsic2WbAe6X9Fu1Yegh6DFm0JfOaB3cs8jbW1mC+pqUVsqCqFSPHSU4SJx9RUTsaIB6LBpxOwN+DbPIthMF6wc1ASB3S3h5L3BiDLKLizi4/a/GSzWhPqPtVwaQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661497; bh=oj3nEhr834JYy8e5t9x/2Guma05c4jdkGrv/3LvS4QC=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=QoP9Kfh0XVqSDRw6EA87bQG5lm5Tq594SgedHg18RMb9s3JY5gX8q4fgYk2i8zFzPDXPKxECS9Dd7XJTZEnUfBbu0sExarJxuj++e7fuyCV7cpixBya0tRnLUl33nT43KIDAdE3GBVW4VKQxYAQTEMOfKsh8Iq691XppuIF21mG2qZUTA0PqnD191GWWnl+NJ4w9eQhLHtNhHZJ2X5P6v9a7MksitK12t7HjdLGnamzY+BJ4MeVpP4rs3i5F3NYU4+EUARU6E4lharKS63eGdRHJY/4lzmicd7HsJIfKYYIePAD213SqbqkQcveFgAJOsAloJdUsLuzS/abxM7nKGw==
X-YMail-OSG: pSxV5NgVM1ljPNwVMa1ufBFutHdINucWTbyABk3XmY0_m3NJlX7gpNPZOndOEu9
 8pAjSdI6XyiTRiEq3PtzwFjvZfeizO8lRRhj35r4zlqWsVf_kF3bMGSOueypzr0ORjIUQHe.T9kg
 e3_K9J.11Wk1Fhfp3rajIZ1IqgFtD67R2YflNwP_7nH8M3MJAUKXwR90o8mn4WFZNO2XkRVx0.Yh
 QPqNUuq5F9RFKQZGLRGesA_nMJtOuqip_oZ3tRvw4f8LK8A11Pmn4VaegdeudMPhRHWDgGEhxgr.
 bYRFFrMWaSE7qq.70lUxOyPtHBySY2_CNIkXpFxKY.CrHYk74j5AseaUcBG7J7wmW_kyFiPEN1_.
 iDcoaGVjvr7w0FU21faIG4k9eAgr2w.9gcx8JTOlddurfADYS1dRa8RvKQ6PzZp0Y1jl8tgphw0v
 7dsIKOhbe8gwlJPsYHnjL3.RM3LHXyfyTgR_cP.Mht0uusQz7Ep10zquHM6yNQNRQpbkm_kJPFo9
 x5YfCL4k8fk6q43.aGx6Airx7jSDn75EsOs7BmNfRWnw7FrjGFLsH13j2MenuJHBKo6duzYI4uXW
 1RAN3dq9B5KKWngfZGmYHE8.gGOVtoeuAgJzvO422vixn9LRaZqBJiNiIicwlKkS8L_0bDZBljGd
 87JBroWUaHtsGDSWz1kUInLx.LOW6kdjDFvdoDwr02QZPI7TCSwwiX3dQx8PEuoAdIMxRUARmVrg
 H1NmhNBo80U6K9Pmp98G5BAgNOzLzbKT_yXUNcbHnk3IwAAbEBcqcwPQEgRLL0tpztIfo9khz00z
 g1WWIfyx5qaWrAbxvSmJFHo5zgRnGr47osZcFTaxbPtik9l01J.KNTF7zVaxHp.Kk9S5cSF48sks
 Zl5TpBxKerG.fut_AP_J_rRJ1cXexQ0Xn.SZUxrVVgDyA6wSaeW1YgWe7r3_CKF.fIPqkYVcUPDC
 CR5eFq7jYs70VlS5XacPiCyo8bJ8RFzIBB1yHqX.bMSbdzp_OwKhNjv5DNe.NuVpSdps06q9TiLf
 CVt9Vkp7lhkAdVdzXH3ubgc3y7SEq5ONI6QaSR2tYjM8MVGNY4fMOkqr5.L1EiemZRvOu8MArDQX
 reT.mIFvPznZpSk8pHTtCzxnW.hS_ENBjXI3xodThsahwN5xbY_hce9uMLelCSLZVhDxzGk7X6qT
 0OKDk8ewDnWE1U_tWhU3zsWhXdqfI4ng9_71g3yFivcmNHw5YtCrreodsci8FLGlAvMMePrCn2WX
 XM6SGtj_YbfkVgfbjaZyglZorWgmMAbqj.C9fq4ZoYjsJSxuODORJnnYA8mn.4Hkm_N_uE.ZiOOz
 xLZwg4EoXbg1j1TNlu6SCgia0m3FVN32qwyzjdwhMdfLWBZK.hMtBB_Z.7q1KsZ5Bme6FHNw2vKP
 7AfDjfxtkPUuV._HirhH6qsyIc9aJw.1NBBmSkyFd2x4gIhEWRm6e1xMy5HJSXBbWKLtgYB9FceP
 C.w8c38eQpVEZsxpG3JMdLx__mya3I2jNMW3jEEwx9SJVPhQByRygh.7WsaUsK438TOHjThE6PG5
 jUJy2fGJj4bhBZ6IZtd22vatQ65zHsJNoFDuegYI72io5tsFvvHUj7EfxZwUuZM.P1ugQUVuqrZm
 TN5wYhqS_aXZiHJNFc9mtntjiP2I2NP6b.YBS2Zc90apeTZd68Vhlqvwbbk3KKlvM1juknvF52WG
 Dz7bD8m9fU_fbqivHlFygBtP_JIbNaO_2DJRmDmx..6X.U5D_3cC9oJjp9oLQHH52FbzbhAErLHe
 BNneoFqN3XzWQ_iAvN9wNOrfozU1foi.RmX8zzwr8XMEatk9BSDX_PSWyjaa3pUVQBltVliRH46L
 wjjT7AsnVEO0yCbtmdHbegBP7XGYXglt5NOdURyJnHzXF0_zoEV58eXRoSHozD5uF9yeElt7asS_
 J0zEMCeR0XLtkAsO_ra9W0l0mO6TGBi35onOfzlpMH4kWPd1xcmnwtX6TnigIdUv85.NCc3PyfnY
 YX7HOzBNlHGbTIPiTj1uYe9Cuo1gPx5h36Y3m50T8C2PQUH2xT1CyhR.SlwWOSAZLCze3ixQAzQG
 rLQgVLtita.HQbTeoB0GYHXrzq3VKcHtQJjSo1Sj1CimHLjjKDIC4pSynjjfsoDAtyKPCVTAz6t0
 AO9s.VXaNXo_2kqmRkMSxgrvWEWnraGUs49zepu62iDRIPt4bw_EyKIzsB1ePNI09yn7SbXApgpS
 3edf.FsMnywcKjgMCqGjZeHOi9MSqV69dOsFFMTNsi6varEKdPo0eNOgNaLqrbgNtgT9XqVVp8wU
 zQBXs2Red4zgqMU91LhlrCeHsszEndFrL4XI7a_LO1jTDTBGGSKY-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: b52615f1-a628-4ef0-abe0-b8aea0ed1d9f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sat, 10 Oct 2026 19:44:57 +0000
Received: by hermes--production-ir2-5dd9bf4598-lsjm6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5f53752bd3862099eb73f04915345000;
          Sat, 10 Oct 2026 19:44:54 +0000 (UTC)
Message-ID: <8d3a9cc7-17cb-46b5-ac78-c7b4055989a7@yahoo.com>
Date: Sat, 10 Oct 2026 21:44:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 9/9] net: dsa: realtek: rtl8365mb: add support for
 RTL8367S-VB
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e84d76ee-03df-49b0-8c9a-b289dfae8728@yahoo.com>
Content-Language: pl
In-Reply-To: <e84d76ee-03df-49b0-8c9a-b289dfae8728@yahoo.com>
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
to an IPQ5018) with bridge VLAN filtering and per-port PVIDs.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 31 +++++++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 5d80409..c604560 100644
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
@@ -874,6 +881,19 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
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
@@ -3787,7 +3807,10 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 
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

