Received: from sonic310-25.consmr.mail.ne1.yahoo.com (sonic310-25.consmr.mail.ne1.yahoo.com [66.163.186.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6E3BE647
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791521750; cv=none; b=svHFSAl0BHalMXQbf05IOyhorA53j7CIMJfeZB4hMdHQvnijyvpHB7BMh1tX2JgPMJCAr7e5JVHeXNlEoY/+AGyuUSEVcN+oDVCFDjnQU7HyFAp9xp2IBvFUkyWsOAuoMApmcNfdpyqsOmILtk60iiiWCLKc5qWiXCEmzELrRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791521750; c=relaxed/simple;
	bh=0yBeeJwIUgXKipszSVlZlxU59rWlgzL3tH/q6hHa+Js=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Ne4GRxdotIcXDyNMkB/p7pVOeyNkmGFmIBWHw3HaggU+Cv+1gxWacnl6NHEaA9QRt/HuBIyxtzcEQ2eAQD4hyq1kI9B1Nno8akf2dI3k4iYy0WC468E571+FQ1zeKu8Ksrqm4oizRhZ0pyYx0gQUCa7t5UJiNhTDIwn740VFeZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BfxqvGz9; arc=none smtp.client-ip=66.163.186.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BfxqvGz9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791521748; bh=i/tb82rGNDSqM7lyf7uiX/jOmb8jPP86M3hO58k9O9Y=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=BfxqvGz9ivNfeEz/927P5BDh5djVm5OVo9u8kpN9X5PgOGld5vV4KLMPAKlC7Jq9OQjQcJkTfWd7jNAwIqPWvmUdSY4u9/wtfFmFJ+SaeXJiGyRYqimtDEiD3FPmqisaIJQfvVLYl2MTJqFdG3uYbp3Z1x95gAgDFOaRzJH86cAISiax12MAap35JDHTfHnt64ift56zsrmw3Nh7ibhYOWgeEzpQwIk0nLnOgvqCtq4wqod6HJsm/OyJlBzxuqW94QVz9Snijc5AgeFyuoPsUH/3FVH51TxRgilkEQnmDHl3OQzIS/rAyJdyuMFvO/5wyhi3Wfh0qJkoTlZA7aU1Hg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791521748; bh=6AA2CIBqxCPYCVqmjoo49XtZUTUFRDAe4FQSS2hrsvJ=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=A5jzLT+U7Aqt4lbu97X12udMfQu8ZF69gq5YcAeNTo05HVvoo3wQY+EQkX6ZNzL9he5Pm/+ieVv/7tItkS0YsRpMfza3zRlQUU1Vi2Z1QAV4MR7ZKsLPq+k/roFBGtX0hK/DlE+6J0kWvNpLaI2qCEDCsJ2INZX+9DbfDK51S4zlQsbS9KMKawYSVoO+Dv+Oc/2bCC7t14UaumYgiz5jhJ324R+Oh9HYZMqHI1/zpkJafSK+QKtprDu9ZaJpK8xfWMAsMiVAszr6iqVsQ6S2YVFtGoV7GCK65+rfRWHYHm8AmVfQQpvkoIkzPaSaoG2EtKy/0qutrIgSzHIfboK3tQ==
X-YMail-OSG: h3OhSfYVM1mx_G7XnXMSuzAVhXWLrr9Tudl_vaKJnr290qYGEXK97zYGdo9NEFQ
 V7BVGGMSG.kpJ7Ej6v4IL7HJXityD7aOqg7pZsQrv0YBdrGzpwybzo269oO0N_OaDRF71U0YjKz4
 iElYUeAqWaYjTWr.Ha3CgGMRQtZaaqAT6Ep7cyFN5eHYWOZzMXVfxj_mjfkS.XOJL5BmGB7t3lM9
 2Y1eQH_Vma5SYKKyZadXyJPkwQHcZSVwlQBehn2opmwtrdat00QT3lERqIU3z0rIwsSnSKUcxC3b
 XjKApARsZrRIf2qgyUpNRdbzJsG5fnVzot98VoNtBCF9PKtudotd9RqAKUcVYyPmseS4lkmi0Wwo
 XBSZcP7WIBWwzMmADcmc8Xh4tJeQQkYHOMmp2X3foS4w4vZnUePMMxYo6bok5b1TXKeZSPvb0YG6
 dLwNmY0jH5pOM_Q2.FJwl4WVqb.w5zCN55EzunG7vQyQy5JdZy4Af47GppofuyRSXoE_qqaixOTp
 UBg8NDuiKniy5tZIg8tRC0nJnlWwSUOCTT2XQPEyWhHIXG3cdc0PA91qF6gNmirJ.xiu8TjFjKRO
 tNclLexEBCzolgc95Fca3a9kFFr8DBPIlvprVOas84nHUIWVGNlU8u6VRX5lmAvG.BvshiG7kZn2
 rh8liQ.2he4hHnJ.oAAySiDEaJcAKQHOLHL6Ihfw4jb7zAdIHdDTMoV2QUNd.GvEx0G8DQxSP_yN
 nUAeGnO6KNKuoQWMDidDwYKnuwEwG_p2gXLCvXELPeYwRdAH9fmRGhgwe4C.FI1ZtrtO2.OcuzC7
 5GHk3QWrp72yo3amTMyfwd3WbTq.VI5QNy1.RU3EtrMCTfG_SSBGVNsVxNpnLY1kXMWLs4KKiStN
 37Y28J4ZiSyd01y3zcZz71kbI1.Bi2XIonfVFGy9Ssf80ntHv_tXQUcIdAOBmhhii3gCHJr38.Kn
 jlYNnJy3OSOsbPXjZMJtk7rPzX3OuSxDh_.FmmBGNmz3dHMvhGsjMqywdKc1irvGYnC.ChoIGUfp
 FhUC8tVcUTNMxQ.iTNJT1kI2v5UojBkXV0hDOYNWRaG8OrKE.f2AwGpiDmj5SYv2cUCQd.C4AWO0
 tYUWUcJWWOm5DRKNTPJVAA5rbCNLb8DKZWGp211dMd7JY9wVJwzPWqxivvvv5GFLgMwMIbadMtd8
 L.12q6QNCXQDEkxZ9vIrlCDK0ZbkFYKjZzML_7VekiqabMa2tpY7c2emkpniP9VFtRQOMVqJs.KA
 qUT84ngcbanTkTo24uYYTpbv9jGpujC8ZMg5KQMzLTo9QsaauCV5nkjDIwF8lzBJCHtL7MIQu5RU
 i7htgJKP8WYTp6dEgtERUIcMc0aqqhtCIx6FnTlg.9O1cH21f0Pui.DlxCuGCGFjGqE4D6.NybVU
 F78O5frDTERUpZtRti511S0I8BCZU2UhrTIi3C3uFgSLNCgJRSF7V18xzte6Gxh7oKqMnvNTVylh
 ABmcPogIKTQwTHrXnmBa0lN94R59ZtY0HyUUfo0Gbj7_6EX0Jl8OZL3K8XTp4zbhiG2BWYXCGsDP
 AqTmp56eTODzOjjvNttjP8lWXLg.DRaYypVRHf379V0rMulmj2AcBOyn4kb0dmuo4JUK2kC_j07n
 FvlbzqUXRftHwLBoWErXOiYMlK9g0k_Q.7n37Xu097du1.fd3lBFBov_VB0LVNh4Nw7UY5YbHVbk
 eWbtPIe5RbcXvw4LywETEDC4twSMC6pSLKLB7NYJ27ttXV2eSw38s0Lnl.mjjlLslqMHAlrSlW_P
 HpJZ1N6aU7uX4Ba9o9wElXvGa_nO8H7zwT3Obsgnp.GjZSzuR28kkGjCq3oELyOAQq9M239nGfhZ
 gt2JVQwg6qfHQ4onqaMGWDjs6w9iifhMeGpnwk2G2BAT9y.3EWkGZhEDRisytp9RutUj70nIpgeo
 kHgVVJuKW2HFSbZKMTi.8MYPcHBABwQj4Wb.5jTc_NziafpB4nKiV0.Hub_a3cj_6P_U6ApCF0q6
 TmXe_1sRypNV5xSQTexqXYLJAmVtDCU6M5ryHCg1DOb1m.V2SnTv6tI3CFL0wC4VpuNTLVfum7Xr
 j2ZruvDZnw5RrxUg.Y7yGIhV_rWiw.0WTWPqCwfw2pVtO6zUdCw7Xdq_PEBHXG_.MoAq8UkHZ4H9
 1fT8FpDA1K3E.sZrLQB1.1HeJ7XeNI07omXqz37_GoqZGY1w0Ncb2Ecm1UgkpIK1Re0eC49AHaBr
 5Imowki3ASWR692yyA3e4iYaBpfoiWrnbugsiBNkjqy_H8a_5hfagnQuanx_OsEELyJhNGmOKVrv
 uz4nWpei2FMMth_0q17ukjKNdElc66EURpUEh4Q--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: b40cd7d7-c70f-4773-a887-629899bff1ad
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 9 Oct 2026 04:55:48 +0000
Received: by hermes--production-ir2-5dd9bf4598-c45bs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ec3230367bbdd06100b3863d4997f914;
          Fri, 09 Oct 2026 04:55:44 +0000 (UTC)
Message-ID: <522f75c1-28fc-4163-88e2-63c36502c60e@yahoo.com>
Date: Fri, 9 Oct 2026 06:55:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 3/8] net: dsa: realtek: rtl8365mb: get pvid for
 family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <28382f3f-03c1-4606-9b11-86f118abeafe@yahoo.com>
Content-Language: pl
In-Reply-To: <28382f3f-03c1-4606-9b11-86f118abeafe@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Family C silicon requires reading the port's default PVID mask by
executing an indirect lookup via the shared VLAN member configuration
(MC) table index path. Since family D lacks a working hardware
implementation of this MC allocation table, attempting to parse it
returns junk. Fix this by bypassing the old MC loop entirely on family
D and reading the 12-bit PVID mask value straight from the dedicated
per-port hardware control register base.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 25 ++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
index 8d49ffa..7add1fb 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
@@ -48,6 +48,7 @@
 
 #include "rtl8365mb_vlan.h"
 #include "rtl8365mb_table.h"
+#include "rtl8365mb.h"
 #include <linux/if_bridge.h>
 #include <linux/lockdep.h>
 #include <linux/regmap.h>
@@ -113,6 +114,11 @@
 #define   RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_MASK(_p) \
 		(0x1F << RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_OFFSET(_p))
 
+#define RTL8365MB_D_VLAN_PVID_CTRL_BASE			0x0700
+#define RTL8365MB_D_VLAN_PVID_CTRL_REG(port) \
+	(RTL8365MB_D_VLAN_PVID_CTRL_BASE + (port))
+#define RTL8365MB_D_VLAN_PVID_CTRL_MASK			GENMASK(11, 0)
+
 /* Frame type filtering registers */
 #define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_BASE	0x07aa
 #define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_REG(port) \
@@ -679,11 +685,22 @@ int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port, u16 *pvid)
 	u8 vlanmc_idx;
 	int ret;
 
-	ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &vlanmc_idx, &vlanmc);
-	if (ret)
-		return ret;
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D) {
+		u32 data;
+
+		ret = regmap_read(priv->map, RTL8365MB_D_VLAN_PVID_CTRL_REG(port), &data);
+		if (ret)
+			return ret;
+
+		*pvid = data & RTL8365MB_D_VLAN_PVID_CTRL_MASK;
+	} else {
+		ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &vlanmc_idx, &vlanmc);
+		if (ret)
+			return ret;
+
+		*pvid = vlanmc.evid;
+	}
 
-	*pvid = vlanmc.evid;
 	return 0;
 }
 
-- 
2.53.0

