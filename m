Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.184.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504738;
	b=tMWbvgclhop0tpAq7cNvrH6dtfci2iX0gHeet5KzSn+wC9k9ttl09+ehr+44i/D/OnMJ
	 fdyqUnAL2YhL6GmwrMHJMeCsUyOOpoiblevuAfDbSGKJ7+SAtCpJgRCKuGOXA4Yfhfqkp
	 Pfo52EO9v1BF0HuvBIBaDQlkLFwZ3Mt0Qp/LsZLWHcmRKIk5UruxgCaeE1DB9P18WS0Jm
	 M7YX+VKAxNIjzU6UbnnbIOJvD1LDZJbxobE8pl0JFZHAu+rK0g6EtPVA4/vxg+7UOMlDw
	 2Hbol//XT36gV2MNxkHLzWIvpZwc4PyZG1DyKFlURKVXpEuwHro+Z8UPDCXIs+A2uvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504738;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=HO43C3iEXRa6J85xNlHDELJDyLp/RMlGT8/nfr+lOp0=;
	b=bhgaUD38eF1cOgQxCxYXt+Dn87et2CWgpWB6pVNQkuWKUKQ9LipP35GJZy2D0aXQoxkj
	 GiQHZ9iFnorSXDaAMqSLntDzz98X8RMSJtLIapacZHlSzhh0jh/NMAcjFVoOVksKTUBgU
	 vigNBLBf8WLB6jTMp3dQhTFVljsaA12L8z5wby44BOj7n0N/JtKQXS74Dzwsu75h/1A4V
	 +kyfpUWdI4bc+XdRJfVkF4XstFlMTjGnMs7jebH13kh0hH2ag6rm0dyEvzUxvFkJ6aV8m
	 R70abgNzUtoiLqXwXeBx9Sr1oMz/TAdV163OoQWHhUgBooa9degf4uXvusLxX2RAjIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=p5HSnhIf;
	arc=none smtp.remote-ip=66.163.184.201
Received: from sonic301-32.consmr.mail.ne1.yahoo.com (sonic301-32.consmr.mail.ne1.yahoo.com [66.163.184.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62142606A331
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62142606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=p5HSnhIf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794504736; bh=HO43C3iEXRa6J85xNlHDELJDyLp/RMlGT8/nfr+lOp0=; h=Date:Subject:From:To:References:In-Reply-To:Content-Type:From:Subject:Reply-To:Content-Type; b=p5HSnhIf1TxMXdIBtR1Rl2Z350xk9bLuF0xFnl4dkPIdEXQD9KwZqKw3sJy+eogRjx9MQLn2FIxBDujr9pmi5eb8YA28vMZCEO7CQ0NXBWENOUe/F++mX/rZNDKonXBtjHMlNbYgsHK/FoqpBEcI1OtDwcWgyv/6lOiimMMG2RoZ6NC1Tmmpi1oUYqOtH3tbURPwAFlemJq58/i4zj0Y/k3vVR7nOYQL+TBg+JSvnkwYNWck1FBQ5R8LfhfD8K1P/ICLWRAcL5GQcJmi+INubVqDPepCspyKAXlPgyXHHCf86lvNmqvropp+fbi0xmevgXh6NQCOHXAYPwZTFWaztA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794504736; bh=OH1XO96dPHxKSQKiBxavipParGWiUFA5xtNuWgPXKBk=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=gBAOwDv35scsb68wlb4hFKSn5wTGoKZ7k0JPY1AaJzKQiipPLj5qORlfLTsa4TRDGBrVGrtzk/cdacz4oprxfXpb9NhVKi/C4pfI/dFaLTr8DjOri0PZbL8rDfbqifvNg/9U68gWeT2/4xyYC2nP3LlAh2o1dplotkgU0L5wAO7uDRAs58JGyQ6pKI91lpfTVSJcYUVa1TrEnRlDYURVpjmKSJ3mZZbKB4vb/wxJehdrESV8kRiJ7qfohjsvKWEEnZ5N2KLyzHI2MjMajEMrEMqODzFBpVg/QX4tNHQgXI2feyZOmKyy0qZXaiO42SMc6/wD7BBqx0WimgbziBU4Sg==
X-YMail-OSG: XkeUTMcVM1mMy6nYdUzXcqLNzcIiyHtp7YA1p4AYltV9okoMOIsVdtuSWUCHI7C
 PvKe.7urM6S88l2G27HGYMbopclTi.nzLAqujI5bWTGLpy8XI9xWmvnub3iNmybZx05G0ql5Kd2Y
 BHKFmhnflrPI8FViL9aV5jRQ67xurZpiF.xpORkHwxu_R7siJyMqCHvvY2oF5lQRWjr7rY02Qcyb
 Yfpq1RQr.vj7wW6qmxJj5jRA5CB4w8lYHvB6G_LNFPWzjMa4L6YcCNg_6BBbQKV3YU8uw3mzdLD2
 UjTpAXRFQH.IoB96AWRzNaWyvwVhrUvSzVDbUj.eTckRrwcHH66IjHhiwvSzJkfZwtoXBeSVNYS2
 .VtbMKoNPj92_GmRWorPpbWRDTja.8ICHHFyKAfMuhVUmau7jmwXYqg0VoMq98cXd.mOXqaEsv0B
 EC78Xg_c6lhOxh0qohXlps0JgXLTBZpQrCvuNKB9tFlFbmbiMvnwQBPamiHY96Ms7Nz1R3im5qv8
 RFM6a1RA5or7.nrUyO4Ctke0cFD7iuiJmn_uzgUcseUDpYfPKTHIakjYP1VJFNWqN3iBCK5LcjzR
 _.2vVIgYLnJ2PT45pUZhq87L97uKI4eSxxJdfyfkp0pND2HUNrWyvhugma2CKhYYBXKcnpOJDdQQ
 4U5dpywrfHErhn96e9_xJ6Fl8Q4qij3fNN6tQEKV0Grj0N5s5pSefaIQZA9kq7fByc70RA.1m0FY
 LfkhnVtAIovbgfz7vpIMCmXaUbyKvQ2Wlx3LtDdBi2f_FAe7fhDIB_yOZV5mWzroNzVLjMesinBK
 ieGeQFi_HrMoLpjqEIxEG4NhQZZvpE2yUSbx8O8VLxvwMSbjyxP8Wlv_4stMK9fSGDnK8SvVUXpU
 YxFYnQzyhuzamw1haM9fHGZlNUZjYdfkOb_hn1Qbe00nqajSjSA3rDPsrM6SmSvA1QonH4G4DUMs
 OmEXCjZkoUhAvoX_Qaw2R_cmy9CmQ5xhKNi6qQlZSyXN4DRefaNLHcfujnu5QJa50tBJ1QmYu9ge
 jAajNgcotNd5d0FShLjERJnE903S7Jnb6RgfsnDaT3WryKO3Tg2.kHnxaJrZUSHbhmaqjjKI4ZTG
 _q61qZAISrm2eksIBLAzw9hFFYjuJsMCdv.sutttdstrJNGa0NBJv5gt2KdnjLL3MchC64y.6qBU
 6_Dx06rRcJjANHGX5AdFS_f6HsByhBI.77V_KlfGhpK4fTs..UI11grmp2mh8ShZENPHNtpikrS1
 hi2PkgLZyabEifI94gh4cKyAQzHWRx5BaO_nFxn8gd_Cwn5RHCdsCj.I_iJNXTvuoElRxUVYVhdI
 WkL_ci16iaD39tDki4qze5jfAGBFhrYKRs23y9_DunpLUMalsXMOXggxsqzsuHgl4Coaxygsg.QM
 yWU56IL7ayWuhIwir0BGvtmDI5JFZDh2bHtPLF7rNY2c6cX0wKUBhjEWlKYLAE3Bf3SPGmQQnGBT
 nkrtZ3wIAseZWiwiyqXofoB_y.csFlo34Zk0uGqtnbhC7.GAICrLCmGkcibh3W7cYyZawHMv5VkS
 .AKZxyosBP9i6tGYoJhpQJVBt0_QE2kb4m9.SFPmFQShrD03kTTtpxu70LFxZGdQRkgssHr77NKH
 1PGICmyr07_Rsb7pDbvNbsC74srkiGAj.8SJEtYKiOl0eLwehXQQMFX1ILeIeq47hid2GkGQ8Jaj
 0iNaR29UAhjbl.JGmn59l7Ou8IxmlN3DOOWE2kcF1RexrgrZTUW3S0owEnCD6XRImLjZHPBFlkt3
 5LDqIE6hs.CuWRgeSpDn2tB5OVoAco.YYT2VrkU6EiBBJtkSSjj.MIsqktk.ApvYdf6QO7BcSdCt
 nEzYq.Oer4a1bqr_P6n1KmqtOOowNtluSwNI31PSIplFjU81kaZLjZnY55MAXzhzbSZq9FtPDOFe
 fjap8IAAQXs1JzCaUhZ67DifnHsGhd.OYuqzoH44w1VCfPd.PhDX_IrKWXsOTwfQAbxSx.YfKIZe
 HVmHnCjP8ok0j9SEk8fKuYvwgtH19lvnT_.1x0flOenm27DpDMCw0OIWvZBBzQUtZFwHXWxonD27
 dyrdGD50e.jgULa5_hsgFo2Tdrsjmxi6U8F4.ekAfOcbjNs2Zh3x3FWlzQMSABHW3jwykPcpy1E5
 TZ83gHd8bqQPi0b_JXj_YX2PI5NgxCNLh_GbGqtgsQZ_9mzrpa0sMFopmKa0W9yz3fg6._bkv1L5
 j9am4N1SnYmVi0ERqA7sf.myYALFS6HFYaoefdx1fggmFRxA4Q18y2Gyt0GF6BNNSgaBT1Br275e
 4FqiHTx4Vl6UH4wfPcxGDJQELDw22KhBj0JY2J3I-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 7e8c6fca-ff98-470c-b0d4-82df8d9bfe58
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Nov 2026 17:32:16 +0000
Received: by hermes--production-ir2-5dd9bf4598-p4sz7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 42224e00bccff5c6a214a8b243e0d427;
          Thu, 12 Nov 2026 17:32:10 +0000 (UTC)
Message-ID: <dfe71fcb-8458-47c2-92ac-2875d5c34944@yahoo.com>
Date: Thu, 12 Nov 2026 18:32:08 +0100
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
Subject: [PATCH net-next v10 01/12] dt-bindings: net: dsa: realtek: add
 RTL8367S-VB
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

