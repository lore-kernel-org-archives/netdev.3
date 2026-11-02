Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.191.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630189;
	b=MFvVjQ0R2FBeqOgijwa3qUtNrumnHPlTApeYnsRqSD/VkPljLgXOsN/PLzBgdfjm4I1X
	 xzKuRzb1QA19SujOZgLUNEW4GD74ZSrZza7XFDyIdZ36R2IJFHERJ7eZ0uJXVPI7KdNRh
	 q1B1W9AMelVnzXd83GaUhrKRrIoO2nGGka7/oSVr6Fzw0Jxjm5Pp64OLwK58OfKOX/N/A
	 NYHxGomhVpDsudrCeejTWgUda6cZ73tgaaR+xC/nBVYt+ZEudRDUP/wKy7IIPSkk503Lv
	 TXBUXPT6eNG+93XQNJHZ2oxgv9QU9AcLL6PoRq9rw7dZjSrO9JdkpsikxGv6guOWKRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630189;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=HO43C3iEXRa6J85xNlHDELJDyLp/RMlGT8/nfr+lOp0=;
	b=k3cK3G3yHO6G4YRALpB9A6sBrWo/0Tn4FX1pi8LrqjKsQvKg6/UlfVUdLgU1ZU89hn+G
	 +y8XsHWTVAtH8pDv2MeM7nuwpNIyovjm3+ZW+XUnkxgJYQBtK2h2OVDB+BkxJYyyxBirV
	 lfv6YnJ6bHDJiVnVtFOZJ5THCkdqe1VrMMjmiyXZcKXIOXATs0gwlqHBXpqemaB1JS/ey
	 ZAL+tnoX9YwZYpZ3kul9fymvWFkdChMn0eIJzc2uuVb/dmXIYGRX3lNpnPIWQuNs7qY9v
	 YeVKdCAvu8AsAuIcFU+CEg36xmApy8EWtM2MskytJoOuiQQAQVpfR8ThnU+aaHTYUDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=ry3IINMX;
	arc=none smtp.remote-ip=66.163.191.147
Received: from sonic304-21.consmr.mail.ne1.yahoo.com (sonic304-21.consmr.mail.ne1.yahoo.com [66.163.191.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC999606A32F
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC999606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=ry3IINMX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630187; bh=HO43C3iEXRa6J85xNlHDELJDyLp/RMlGT8/nfr+lOp0=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=ry3IINMXxmNR2JyG7PBIm2xHfDdkwQxDz1Vdg8CeSMzMT/ibSt9QTQKJq8dBsmdsa+5XG9CZ63hDQvI6TzvecKzNhBG0P2fVlDV64K3uaBqdJ9peu56n+UlOb07x4ul02NP456ExwAXLzMIKaEi5OS8IR4rKT6X/yjwJGGh71gJjKr5aDlsWGF+JR1NoVCA+mTFdddJDCZJoaoMIOaqDjuxMiGmlxbneAOWlBrikJrAmC4P2Rrr97K39BonZ8xkwaTQ+2vMKQh7IVFpll+AE4RQWnoy7aA/0YLTlaebrr42KuFZMOgF8iAkLxkYPN0/SbBxTij2sjbtejtsAriEtkw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630187; bh=BjwOm3KD6Jp3QhRETD7sjkx7zIpwTFyWJ027lRb54o+=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=eU/iqPyh853PVHvlkqLC4ohIKkvvFbEjqbduiNUQwIgm0h74pPUpWJbewDCSUHLh0EMMRjMdtyvBdrT3sr+ZyBd1EiSVjwyyaK3P2EFzlrgDUYrJ2kzf5dkbtYeFVvtwdTJN6KrBtceIr0JPsx2+BeSstVRqOQn78BqNlTcx+1sP81tvrkI9bAXm9ewP4lRft7MkLNh+kUy+C0JKGlMtdiy2lSyBzHkmhTULkswYIpnVlON0f4laWdjh7Ivkviomv8CsUwi7r3BipzOEV+f7WX/oa9gEIA7cM2/Nu4N5XtpC3aAXUC23e1SwbGcGvshpq7X0a6cZA3GNm0v77sMKkw==
X-YMail-OSG: d2qmvpAVM1keIGt_PHTpaNeDqgjtDr0AytCoOX9UVravvY.YQFwHqZf70qZjsA3
 J.NKDs1eHMTOhd0CBcZ7x2AH9BsoFqrvV4N2t7ls80MuSHzg2KP6JK4g3vyhE3qwSg89vPw1Fxac
 M2RIKxAP4fdHxsYCKLUYmSlt_ZgZAvu1geNYQB94MRkbQE_qYfpsQvnH4SDoYcbC_zjpYmVAvfGI
 waCZ_sNE72tzbvnjpCozeUhxBBGtwn.0U6cZh0x7tFO3ITAbD5AcuBIJT8jxACx25b4cSXRJUVZM
 Sj6qdB.Xh0I1ChJtNR7qNMe3bwN4iqoQ4sgYUo8Q8isFNox.M7PSrfiH34APBytJa9z9QBzltWp7
 bu6RPflFmYHy1wrbkglDbeIbPy2S8l0MjPiAxOBQnvgQ8BWDEtuGdBzn9oeVZiLY3vuqD7waXj4x
 h8izfeb7sFNXyANS1qAxS594GPXiujdNQ8Tdgwc1VeJdvDJQaN065.3tFEJ2w0MTFh8AEj2CszCf
 9JLcn7IXHwVYQYREFQn.7rjU.Aqg2K9LhSCURxthghM48Zw9FbRA.U8iWL9sNTg1RYhEg0C4XBlF
 A2Uen6s4a2Y3YLfQlRgRn_SlnMWr7LiMWisBNNVvuRIeom1fz1QIYFUzWJvCa6SDhKh0Cu5HLPE3
 1PlLZch5DLcaf9TTvCzpO8ueHZhGR1bmA4MYu.IFAgTm6jFTIUA4rGBgBfaOs80VI8yc2zRlulan
 ljxsgwXkwFlnMC1SxCgCmBKw24t9nNj7c1MOujRRvEKvvmj61OZJp66b0.DbW56YZs1kmXz4kkW.
 PFMJHanC0DuW8.1k20nnTDlreKjTLFkjYV2GYAxCSoQ5LalZ.msYzUkNIiJvJgNaRba4PvzgaPR.
 3d7C8la6xTw8hXdJe6fFHq6QENdEciugCbCvd9Bv70ZgsRZIkO3PKf6WEGWQutF5QCSa0TTVlwZm
 V3TuAPffyQL0MnpPEKWlhQjDry0ERgwS0aOGmpGcr3duQrkgN1AC_3C.c6_k1J85W2ywSpu4eZ94
 tjWl3cg3.yJERMBxQPt7_b9faPY6VnnQ_zeqF1jKi54Cy7eKlx9jARke1TaSesHqx_2BLxIWhD4S
 vZfCghG__10ikq.4VfD7xVtyOOYks8lRBjKs4aRo5itwb9v2RjHLLSsUJbmWoA1z.p.BltMi.f4y
 16pBk1IwGD5k9UyZL6Et8nxQuQFw2fFRDAW1Zd6bgIwlJuXVOYgrtGy6Q12MmG_AZO2QS7p7wlPz
 zrqJkkpraENivG1yjP0qffzJOmY9JDVnH5_bOzMPN_POe7OtOdtLxcV5nW_GL2WYo1GnJ3Pk7o8P
 3G3XQFtmNziGmiL0YLHXZZ02yDMNnyEUMeRSxpFhhKtFqH3GPUq1hbzasiWt2XbVhaFsSY1B_vRr
 iMms4478XsGIwEPYfeBC5OrQQovQTpr0zKxPxUptD.ltGBHy5om1F2ZROLxQX5aXt7IDkbakPFca
 pRUn4vG4p0R9K5clP_ziEKF.oIYHYMhYyIrfIPl_mHlJKz6QB83xSh_94gMMzfphlCrTZ1L4wb9D
 dt99jZIpnMq1mV3kkaFXIf08IKPko4BPs.nEilR1qJnMctzguI9zarA3pobi.lX8Hb_LlDoVooBd
 YirHAAmavCeK8jSVEs6N2itwlcQ7XB7v6J4orw.qp6t3BKSVopxRSDlW15la3zzexkNiQaCvKYSF
 9cZDlgo9.MQiTQIJyNpyzf6xRqYZ0mr6.wBUiw9tAna9hmPDPGBU7voUYWBnTop_bCDgHX2n3rUu
 SS2Uc9Y1ayA6cy9OQtQignd.AlOu9jV_zfgw6hLaD9QydniPZxMnLtSEQlZ5m77lS7HaG3Qg1A3x
 6RVHj0sk7avSAWZS.y1v8Vi.tPxYIgzjdZJzRR0XgOhNYxsb5AoHiBZ5pWweZGpbIPf3BdPnpAbG
 5BXTc0ImqTEt.nJFva3V8SmJtERDQaB2N53ZgIX7ETKq_H8AIhyfeCmfu_SsJSVLwee05slFAjb5
 lketuq0pBI9snF0msUgn.TqI6bgX_ZVzLl9qWZTaxvMuLld01FYtpieTPm0Og2P7_wjkrANy0j7b
 phuzYO_33F3vHlBpYAPSUUprM8mJ72slrpBmfu3ZI8klSHz1MneC9UGL4hcwBTav1O8IGxO1zP0y
 sLPd_el7d1Qew5wf9oYXnrMbyJ5CZed39_2p9I2sCwXcL1M9Bd9vdwL8AlcSeFtb4suFfIR7vUmh
 bj0i_zNwQQrlVv4Ti2D1aFZzQ15p035FA761Vp4uP1JV7DQFjKh377wdZMTqg81HUHs8n_jLPVwK
 69dAI6Q3QzrFqHmcHgeQvU1AWTBKYIQakqJ8N6Is-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 19855212-b725-44b5-b295-0d4cb403237a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 2 Nov 2026 14:36:27 +0000
Received: by hermes--production-ir2-5dd9bf4598-bgsl4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 09c28c63ade149ff97a4e5c1da845f5a;
          Mon, 02 Nov 2026 14:36:24 +0000 (UTC)
Message-ID: <d2e80c06-4fbe-4e59-9e41-d8ff697d8e20@yahoo.com>
Date: Mon, 2 Nov 2026 15:36:21 +0100
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
Subject: [PATCH net-next v7 01/10] dt-bindings: net: dsa: realtek: add
 RTL8367S-VB
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

