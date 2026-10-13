Received: from sonic317-34.consmr.mail.ne1.yahoo.com (sonic317-34.consmr.mail.ne1.yahoo.com [66.163.184.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3513AEB4E
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881125; cv=none; b=MRVf9wbuNPhs/+IfbTY0V9VXiNvFkwSlPFmbLwYT+D6hoEZZgiuXKgTNmNRlelPdXYptjEGjlFo5DIapgs63JG4HG0nCtLdUGiYvO1qcAct6kw7X3axpeATc2LF1hHkivXsePrGqf1dUAF9wPmaIjjD1Kb4l3PuKAc9wMHmZDLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881125; c=relaxed/simple;
	bh=awSpI6hIJrnVnUjXgQT1aG7QWgJ4dGv1wHAUMVpETi4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=j6pDSYCliBIzROZH0WMV6cCGrhtRqBTyirTmSS/55EAX5VUgrKIC0T1PQPx6s6U0AVWY6e4JLLJ27iPrVyARh/tNBzTUXk/0ryYaLolZHBmcSuJBe/4R1rplgHssv8RqY8c7fOz287B3P7FxWzVA69EdIR4OzrpFIKZgEeeGee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=iwwNIa0G; arc=none smtp.client-ip=66.163.184.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iwwNIa0G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791881117; bh=pCVmf2SaMrsM95S2UNcQOt3pW/c2ienbnWSiPYwUt6Y=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=iwwNIa0GIBfXVF7bQ4ZdkzTow9Asc8SMwCin4kLiiEYt9IS9BJH+wKh5QZx6V8g9G19cyLsBnwYO2rn5aphxHCppHov+4Xsn0jzt/tRuTRxAurgN4e5sxPpZliq7J4ul79uzG5SXcwjukywEu6Vt+NWm2VkPTshrxAo3jEKvRU3Qb0OsmH/noMO7hS/0rJQiA+jSOrVurDzMda4ZzPHZIY5+hmUwTJE9Uaj2x8z/HTLl35oYskkjPwDwsKen3XuO9raVt8Bt2czGxSMsBfSy4g8DJEWXqLbBQeklwEhfNvXPLKGCMCFChhs6W4BIbPG4WzWqrq2B50UB42eVcZ1USQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791881117; bh=VosfZHIKwC1Dhjxo/1l9C7tQcfZ8A9sqRCxMxdCWqEg=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=oQphzyVfvxIiIm+25MSXEf6aIwLEYRNzN492/7OjK1nSWKIJ9JRfU7V0N1FGLy6cg6bPnAr9C+ws+mgtlKWyiwsjEHrTAibkV3JxodnFoFuKkYncNpk7i0s3dQeVOoDT7rkjqjGJ2NTGEUh9FtxKH5hfn1m37u9dBvL8PCXFsX/TpsKuBpRyUiqY+boay1cZ2A+9JTDUo9eYKS9SnvDU0wwvBreH+zz5svu05LPm1Y1WuOCzV1Bzk0+qjaN1UKi6D9D0EA1TStAoY8wmiIgOO2shJla3ktWXJr0MzzFG9B02ttuSwSeg6Ps50z29EhVk3Uw9lwDGoBH5O6ucBiz6zA==
X-YMail-OSG: GLJtZK0VM1lwEW3eGtYMDZFWT4wq0Z1BoC91xcbIaflMIZPASaG14AutXDZ_DxZ
 CPhYHgZKejDPzSOYsTy6x4eQQR6oCwPyM3xXeKoZ9edwOqN4137FF7vCSLJiOTFofj2rDwzWwavg
 lmbFHUx6PcbctfZdE0PV4LKCoHWvZq18XnCAQgLa.dwGU.oA8.XM2FziXvbaWeihd8nR98nmAgX5
 TAzo_fuwmRx3mG4DYfJPMM5z9nOWPtlogHA68kJrJEqbKWMIff3K48gTddQ5P_ugicRMtjRm6jb1
 Rm0Wx1wROUIogVQDquVeSYTa.BvFqPghPcf_OX8ZGkCsUo0aYAQ.p4fgd1sGrKPkiOgBNX_it8Ql
 aQysN7faEpKkNzVd_i1lOm.hwq1.2Oyzw71mYj5p.R6yfuTQDlwjOqdu6f0xLlYZxa7o.zRM00tF
 A9GSSv1.wl7VQEc2sMn6V9p3Xhc9JekSL8EhJGVvz7LrP0A8HFwU6ecOS_j9qzb8Ot87qrf4HKms
 A28JmGQXuRXLNJrflL6c8hRbu33JPpoE8AsNNGrV_S230EVX5jz3AYVLjKMuYGzlGl1DS7cooo.0
 0prKjqYTZ8yTrDH.rlEqJTbkNsCXeJBGi5hFxpdEI6I7gmsngkSOCls9o7Vcqe9eUvYqPWSr0ngO
 HTXv6QEo1Vl.QTWPVX00HjgfFj6Af7pbVUZ.qsrRdVnr0Z9STB98OQ2DV_rvShbUKBqMApY3oLuu
 rcKoujm72jjbQennXXfFOrZrAYEBf.EEbEuCwBuyapdD1l94OFufVbPTTyWYoTeaPgjspGjrxk80
 4EqVNqj0lVM5BQCM0rCJlednaf5GvOocyrIQP.Pmi8VBFZUnj2.QXzbIt482ONRQpwnh1mO1eT99
 W1D_3yzYQJ4B_8tNfuD6qWi6y3E6Jkr3WEh63HbsS26IeXeu63u3Weg4_k6E985uBm5ZIYiQf9e4
 aBnHCBRFFILz053oJ.VRKWTYJLoBHr8eA_lm7vW4tJFnSrUM.FzPDPtpyMCQOLgXYfsp0rXxgYrs
 Mw4.S4DeMXeze87CAPupRkAzLvN9nncSlhpaFzunY7jw05mruKBwTNRS6PUbNqAdeZAfq6G8W4V3
 _oDsauqQp6VPkeoQ7My1GHS_oyEW4_dLM7lvkzQxVn8m8tiT.GRyiax_tcpI1qTvPqzRMa6GFmm3
 OFccKv1mJ2eMDH7GVy_mVJT4LKZjmzgswxa7W0vumTjWK_3orRnzprfS9Hu2afYYFKe8BRtHk_4y
 81Tm5YbHYOC_bQtDdUfVTse4MnyIGvK8WsIaUblGSHgn9WUpcIwUlkQ9XmJ.MQKjqbpJrWKUctUT
 13.tTI2kGup7jIY2CAhtYNKqiz98NuM2j0UgInQlyHeVa_qb.uO5JJbh6Li4oNpdiM5biS1Qy3vU
 3XHwD4bWKLyNdiHoaYvj4qf.PYjvwPfMZtX8NZDKbExsF0UKnM1KLp9Njv5XST2f_pOxuPe0dpIN
 SrDKkRJSEKts6Is2stLDj1vYJWFCbaELI1XQZ7zvj14Yyxm.jKapFFtRyqGpnLMQMeOl01WgO_tS
 L_HbkcermJO8Z8JOZ8JQ0P3mJTfj2_QRIwPHzon0E7od_HCoClPfNhklv5.92DB.cDBPi4FaFYR_
 lw1e.eI7ylunjpWGjFX9..cI67AYOPRtErmqiN1N3QSQA04e25vgqb8XwGW1YX66zJYtZ47aCV7K
 BV49VeRLobWNCl7sWTWgpgoS.uT9q4Fm_g1Y6j1Irdh7ZcT4rhYo8BXTcm_ti1xXNBReWhHa4Lzp
 q0EaHX2FyMfI53MQ73.JgPIeqI7nOP8aw4siXIdrwmpHnWQzBS_u5yuDLIDMLrBM0lMRzxA1RqF1
 umTl111RPsR2njP9inSNd9rvT0kVbuKmf1mGuaPcEUHpoSf48XC73etoe9unEpXEejhF8haxoGk0
 _a.t4OBgAhcTOeEvlq_XJ2RhddiOEIq72QWX8Fpt1lQlk7kq6hHFXR23bHvYme8TMCu0bKCsVwaZ
 ezTJUQMv6NEk9ff6XVy5sX5QFu1irRG4p5l6jN.skuAX5Pr_AZmC0IqchyeX395RAknbxUU1w6J.
 4xGte_whcB3MEzQsolky6xLNXgHHA77HLZhUVswd9KPRLSlKsk.isZlzrNp5cXbc2yNzCJhUMnZx
 rSf9SWiTnEHhg7DFI1SVNXPXTeY2h6xVGLhLtn.ZbfFebdIJcfWW708wGgkBKTeguruxpuRJHHtO
 auEGtYE17p0lCoWPh_OyqjkFWLg5mIUri5W2JlEEbQuR9V93wO5uc1v2Qcdx2teu2kaSnPzW6dN8
 MPcv2zSoNUXykISs-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: ab3c2235-17b7-4ce3-86a6-9ecbadd9b9d5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Oct 2026 08:45:17 +0000
Received: by hermes--production-ir2-5dd9bf4598-bgsl4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0ed9346cf34dc560b2507d574367c26f;
          Tue, 13 Oct 2026 08:45:14 +0000 (UTC)
Message-ID: <ecb73c8a-0bd7-4c82-8fa7-048aae4e335e@yahoo.com>
Date: Tue, 13 Oct 2026 10:45:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v5 9/9] net: dsa: realtek: rtl8365mb: add support for
 RTL8367S-VB
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b45a3350-44a3-45ad-89cc-452c25edbd7d.ref@yahoo.com>
 <aa5fa12c-e43e-4e5e-9f77-c6eaf477abc4@yahoo.com>
Content-Language: pl
In-Reply-To: <aa5fa12c-e43e-4e5e-9f77-c6eaf477abc4@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

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
 drivers/net/dsa/realtek/rtl8365mb_main.c | 31 +++++++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 238a3fa..352b15b 100644
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
@@ -119,9 +125,10 @@
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
@@ -885,6 +892,19 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
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
@@ -3879,7 +3899,10 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 
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

