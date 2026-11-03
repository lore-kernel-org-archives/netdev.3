Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.187.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748492;
	b=Fbw+BODYpeybJJA/AmRW/pVdMAmQgqHJ/62YOjPA1BqfeedOLOjIqfQBPKE2cCf148bW
	 o81Pwnt5agOtnhTQiHZybDA6kwUClCacL6ANpD8mw5oTSq7OThgg+5BAQoF6ApJ7WqtY/
	 SOREfaPFC+UeconHKz74QseXfbzsUHBAdAAhz7ZgWAPLBzs5/zf/dnaS6D5ezjY1VMjmK
	 fJYNtfAaCIhk56e5/c/a44b61LViQE3UzBdFTZ8eh7oRqTC6161i5azPROcQSqaXmNkxk
	 nDyh76fRP/xoB5tgcBPbuk1RmjYJPfY02LvoHfaF0EL8sIenhws6cx1USVsOcD9w8Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748492;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=HO43C3iEXRa6J85xNlHDELJDyLp/RMlGT8/nfr+lOp0=;
	b=aW4gQ50q3Di8yEROcHrWG3IPP+v1YrpytLiUgHwPiZY2J7nP5uPOXkrdmQZ0WNe7Niki
	 X4l+jlUddt646ALkzZUQS76Gyug3YpQEbOgIQDa8nJHCGJ6KFFqruH1hS6U7eYuHtxf+u
	 uh7l2YmUWIC37YmjtLrJvc/dGXZEdLR63pkEIrTcAIFZqWFD7+lNZD3EUi8CTPCsKotQY
	 Wl30yf2duTJu2iPyviTbMGpD1emLMHive2IdtvvJwVpp11rqOsVPo7lQAEQS7FbxdV7+b
	 Jm6EltdTNi5Fo7P7QIylwiHcSyBwwy4ASKzqHZ6sOIHM+zVyeXjPMFi/qb+WIfevhIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b="EKl/5Aph";
	arc=none smtp.remote-ip=66.163.187.33
Received: from sonic308-10.consmr.mail.ne1.yahoo.com (sonic308-10.consmr.mail.ne1.yahoo.com [66.163.187.33])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F94A606A32C
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F94A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=EKl/5Aph
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748490; bh=HO43C3iEXRa6J85xNlHDELJDyLp/RMlGT8/nfr+lOp0=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=EKl/5AphJgUoStZD7NjZTqfmysDLzuRmfVioKhD5VKLc9yytYqoiy/eEBuyrn109jfLwAADcZWKkmYon/X9q4voHBrC1RoHv4iZnN7oWp4LnzFWiru8XnDTF2mDi2gztdzMRpnxgvtZ1ArFWzPgHPOHcMbDUkxfVBxXUs5+MNpKsd8QXLIINnRNromBDrGHg6SgHGyyNO1o7eqkpIZKNLR03obKoacFefQZvOSlcsxUSjDyTBPR7VDxl8V2/EFW/4bAtTpuWYAEksASB4gz4ZNs1Q3pK6RoGeIWc8AjvVA5sXxMzHgYEkL3w552ITT7LOCZHMnA4bgYRLou66ZHFDQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748490; bh=+qy4s2w6hUnZXywkd8MbvsDy05RP0C8PJSYWGrxizK5=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=ASvvOTH9acdxyeYJC2LqTwMTAEtmHHxpm8T7Kt24skHpU85voCneKAglqzT3LY4L1fLY7UcZyEVxkBHgBdVO+72gLjyyYBpv7W2ddTdxTiEcUFLGfFWdd5oNrghMX8Spoz4T8iMcmCZCUXYMsLoKfMWFyfrIBDP8BgWGyOP8kGHsg/cKQuJ24qz93WrqqlwbHvY6CocVMTISq4ZeeWonAEY95eT1pwRzQ3C6WFPSJrfCkSZsgf2+RoDxeDGrpPyJnmDtZnvWTeZQf8b6l7xhdWBoRUaOKTgr7YWsrtd3vcyPSgEg9dh2aiOgTQgY4BOY+1snWA8p/Bsx+/bJZ33Mrg==
X-YMail-OSG: lKJZupoVM1lsywQP.c_sGI9ZgJ1WuxgQPsiCf2NaR4uMeYScBBM.qJHPDrwDHLO
 v.zSqEuKIvVJNF7NxRlNrv3JGm8zgCIUcqTire0i6z1.Kso_.Z0zcsmzE2RHqVcyOuNYjE6xPBgL
 UU7kRhFkZWDeYHU8Su6LLuNIvNiq_yTEiiLzj8kdUvsj0xF.xhJJhOwK7ly16qVX7NQqY2Pv4MIn
 JGcr3mRf3lsS8NQu2.FF2FITPZPz6Vnl00jikS13ksaev7t4M2299WvNWg4d1ZcPMCMqFYzY28hH
 2lyuTFPnJtKJ9X8iYy6em7XmSK8fjZAdlcAm9f3z4uKXGSNKyxkjulK6qx9ExNRpOhPxyRGlU0vc
 4U0H1L4AkoX2Axg2NVxKv6D7darZQjQbfcBiiUQK69FmTuDi2Iymk4cqaKjP1R6_wRiiPnsdYxfE
 w8.2YBuFDH5fYOkAvrwETR_cZ1cUvSyAkhefil_3laSSmXVCDDu_4UfOBC34QAs_.Zjc2ZVvEbqf
 WomH.u2gLOSHpDAiijPPC8i4uHTNA.C1zsbKsn4nUS9__9Ngbc8g8S8y6VKa9aQnkrEEwBxBmzMB
 BLYdAWf_lpGqrDm7wKRNVi0z6iFZGE4K2mA8yJrL8OxQu7tGEWxZoLDedi3wSy74V0bjgBTGOhOr
 NSXSTs1JqusA3cvaQQTM81RkIA90H2uQJmNpsQApxmY.0G7hXlxokYcS9g30wWdTDVDlQZlqtmwb
 pWT9VI7sUKFnoY_2tzMURGMCHXSW355ddY.pVy8ScDaV0QxTg4XL5YGsjWfjETpIn2LKoKq31Q1f
 1u.oHtpfqm_Av1eCjT2ZTqVetDWFcxWQiYdhnl.BZq345M9VBsh5dW0CoDEQEqbyC6ydsM_nq9I3
 X3wViRzj8.s5q0H7Tz.WnlzF_aNV8qM_g44.89dbx30T8LcqBjYTJZPgw_Fj4pAJ7wTw0soxws2K
 dNAvb__pFYV_3RK3dJ9XMSmCrfpGmhsdgDOn6whXcYN5p.2KoTEmEYha8lWsTgc1.H.0mQydS9ik
 Re8lr4rf6VgrzKbhJDKkXWS7d7t28qtWDuFc.taZVLH3fWIMZuVP6eg4w7AMF8sN3zLK3Etwm.uk
 QA2iCMqR6Q04FjIjftVsrXOIINeNXvUX41dyf_AhnStByIHqe1xTWQ4BK9sxII5zbrRcSm239YBg
 dPFWul.YmTrWIcmVwo0zBnpKfSfsevTxHma2dGiPgwg8qlUscnXY0zzwGSiMe3lnrv.CJhvUYiVP
 _YZCiZKMV.Whh1goPaUCWz7Z2cqKZSxlrZRQILqK5n.08JDv4SM2T9k2sOAkdpgbnkqvJkHBbKCQ
 Ot90_U9uZyokR_9rpspEHAdp8_Hodwvm9KbAE_xAT303ICoNICChqDJvV0M0FHXGA4G3UZe.k_nl
 sIDshg.154V1FwUOUek18hMxedCMk_LoceS5Gx70rpDxJnMxNxf7C.qRvTjaR4QTr.mSoi2qcV1F
 vubnezJaIKSW9UtobW7_3OKgfQ.ymPB5N3EvdLJ_fY3XasbsHXhcCOhLfNm4j_4vApXHl.Z2S5LE
 RiLaZIFw8CHAuWck3XWaswZXHMSiP5AqAs_.f9oXReHyDyyTuRntmOMTIVuBSAW55Y7i53NzuC6Y
 kyyVgRecUee1UVbLk7eYGjGpi1dmUOKEzMW5iX0fjftWAB9VktvYncDjGLTBREIUU8ysLh_7ncHV
 y8q494lxAJU37Osm.T38hmpn3uF8pW1h_3.qHSPGFTeTFCl101TQBYM8cq4Z_bYzamm0.v_uZRkX
 Hy9GdpVWW_UwOihJFz7ZiCY6eU5kv9tBDFpIDDV0Sd94fXOLrUDtQ3iHLShyxOyfdeRuFGFC5Khs
 MjQtUtAaguR.LDHCuk69N9m1epWTh2KrjcSSBYkIoE2OqF1Wzc9bKjQ.1wzWt_l2dgYlI539wAlk
 3mgu8iL6gzHIzfDVPTOiOa.psiGKzLrQ7XqQF_3K1.FiC9ZHji0DRAfv56qlk8vjDeIGRhH_vPcm
 mr_5Hj3FiydqVe4DaW3ZLa_CWdJMal9F.cnZR3xWtam04X6f7CvC5LZ3EE9KHU9rwQW9qgSnLnRU
 IvrvymEQjeJfywfZwyjnZh5rMMtZ8Iezf49pbf8t1k1yfWHaIcjUk4_uh3RMCpu_SB4tqTmy70IA
 9m3.PwdOEx8WbbcLAy.3BQrdPCLQ0cBjVessK90ufra1W8Ildl0kYrxQ1JnRe7gN_LJoTdhTTa35
 KA8gCFGEvWH0WYyyE49T3DgWPi.B0qZxqLnQADtnwwYhCrVpuNjptEqynmovawP8Ui1qQ32EmQKa
 tQN6aMzKiFIGCWU7NEVG8ydmfuAnUKj3OPQNsq0xU
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 1f8a667e-5a75-4afb-a28c-53bc75856f07
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Nov 2026 23:28:10 +0000
Received: by hermes--production-ir2-5dd9bf4598-2n7g4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 36fbe348855afa899716e2c93e3eda3b;
          Tue, 03 Nov 2026 23:28:05 +0000 (UTC)
Message-ID: <c6c1e41c-6a27-4354-8454-37ad70b44dff@yahoo.com>
Date: Wed, 4 Nov 2026 00:28:02 +0100
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
Subject: [PATCH net-next v8 01/11] dt-bindings: net: dsa: realtek: add
 RTL8367S-VB
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

The RTL8367S-VB (chip ID 0x6642) is supported by the rtl8365mb driver
with the changes that follow in this series. It is identified by its
chip ID register, so it does not need a compatible string of its own.
List it under realtek,rtl8365mb.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 Documentation/devicetree/bindings/net/dsa/realtek.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index 473facd..ca775f6 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -43,7 +43,7 @@ properties:
       realtek,rtl8365mb:
         Use with models RTL8363NB, RTL8363NB-VB, RTL8363SC, RTL8363SC-VB,
         RTL8364NB, RTL8364NB-VB, RTL8365MB, RTL8366SC, RTL8367RB-VB, RTL8367S,
-        RTL8367SB, RTL8370MB, RTL8310SR
+        RTL8367S-VB, RTL8367SB, RTL8370MB, RTL8310SR
       realtek,rtl8366rb:
         Use with models RTL8366RB, RTL8366S
 
-- 
2.53.0

