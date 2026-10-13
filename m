Received: from sonic314-22.consmr.mail.ne1.yahoo.com (sonic314-22.consmr.mail.ne1.yahoo.com [66.163.189.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E5F21ABBB
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881348; cv=none; b=k+qlDX1Isf9ouL+DviqE1lixU1BvVh4ArJgXVB8bPUwN0N8yvrWusouTTiQPIim9gYzZlopSTbhN56Y5GLoVWfSZ4Jz5EQQL756eXn9RhFRG1CzO8fOrrnEwzC184RzZeIbrNze9Ikd+NpHYgR2BXrWAKTt0IO07OGgYeE96oEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881348; c=relaxed/simple;
	bh=DZpciyiHrnfZi/U6tegj4iEP8brHE8DE89jDeeiGZ9w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=q9Llc+H3EkJe3ozj8DOTX16wSiKLQUIxhFq2fy0x8VuZnnbe8vGUh3oA8qEllULlcJ4eiqbAYSzCEFj5TMQy3B4dmDd8IHIsKRRBdiThAF+UYhHTEtvDeajieT6BiMZBLhJWcfit8IIumC4XDz0F2mHM5ihR43oHuOpbDn0N0Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=J71dol3S; arc=none smtp.client-ip=66.163.189.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="J71dol3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791881340; bh=gsRorfpiRWfdlb5OcQgolk/n/Hz6due+H0Gle/vIg0g=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=J71dol3SK9fhXuq9D1RDrowY8a3UMeinyW2u/19NxIC1dv2J9ohb1/gTMzZtnYWyH2YmieFqu53jJmyK/gVScVCBtOKpsKgzAiXFJc32aCGjDlX83ZqH4UGhye3LySQ8zYQbGCeepI71KvCo28GTo/R5rxqmlJh/Uw6DAEaPlrEJUz+i5O2VWjj8vJTo5usIWgYU541kMteq9oLBKEEhOG1A8uIQcvNdZIS2d7HnsvBq+tWO2t+jKgf/VCyC9uR5XoZ3TrzgMkjEjS5xTsyPVWzYkXCPeg/liF4Res173MOdvCGGpznJRhFZsLI3iF7jeNt9tyVWppq5SY5N12fBcA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791881340; bh=CHycTCv7e2wcMBrVbF07OxGS5gm4UIzyt+5tZt2vOfF=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=dbYRLkzRzXzDavVNCwqtV2g2Gv3g+rkBI2xW7jw9WWtElF4n/s2k/GDhmRCyP/1p68jhVA2d4AzNNLQyGGBpVFdMbE5yVKTuw2i1M9tlVMhiPqay36Wh3109p/M+cDthKOd6DH1gJJzGF/7RYTINi9QfpZFtVInYAA269mTKyTi+hdlxJAvikFJXuZknuNRBkUbO981ENIZCdHLeVWVkTQLgLYAzaf+kor3T8QsORc7R76Z3rbQEVSOtVSALbLTmVOeRyvTHJC8jIQxnYIs6bykRWc4erOoAF+IWOo0GQvgDTOXuUMdNxKwBgc7h74ZS8OItbzWu4j6cwQLpAOqh5Q==
X-YMail-OSG: 0sK_xYQVM1kv3hfuFOKXQpJaqEGv2N6FgszCSw4XuYSa79DwsK7GHwi3Ar3ulsl
 jmgIQq4JCaSTlRrdP7JYP00M5lm.XDj4VSdpYtWgqi0jk3C6XfrssGF28ye0yQ4YTVqMpzMkcTD4
 1tx9mlynwxF290C.K4eIZMKXe7L4HnAA.pWDRVcRVTSszfUPeca91x6TkTF0F8ZG5peQyilBO_Nc
 v2tFbNn6gP5UtSS1I8U7GV9yT9Wejm72iJRykX7.T2E9a7oEJ8pnfV4Yh15NHKcGs5yONfDcGjMB
 ypuUr9qUWDiuFmpSEGJi5hA2SlrhShwGA6U5Gpytd7Haf_HRXEDvZzVPBk8nzbjeTB7E0G3QYs07
 WcbFUAsSyQR_uEvLWjkD0ogbeJ5uCrpVefIASzh5BoHgR3rY7a7PTmy6cuswhor18.KUPSaLt6H6
 MMd3IoaepSRqAZ2HrAAeSFS4QXB7Oocu8Fkdpj8Q.EAlYnsowS1d2OnFiBJkEIzRSivs83PI6Rv9
 GrAHfewcvv8x8ttlh_9PFkhM2r0bzcXrJ6zFW.cUOXQHjZKOBIy07lPtzODaUqGNW5OfC1ujUre_
 esV15ZvGOmtUYpFYoBUwv_p0cvVP42oNi96Nw7DRtkfroOIkF0vRO_7NY3RzyYPfK56XYdX1c1.w
 XMTnmXunpmYsGqlUzTFQTE51.YZbBEsTyXCVyzMgrQYUx401EyuTfp5NU2RKOYNaAB5Pz9Kp9Qwu
 s0sSWzqPDN6bR0Qz.CkTqn.2I7fyy0lDqDuMWqHPGHzK7dR.WpOnWYgzXhroiKVQU1hr0AgYbMTk
 ZrhWA6uf4E7vXK6APpoxQBotKJnv9TqI_EJlw2mVFg9P91NSQ7oeoA98mLW_jl6V2wVQi06DrGn9
 MXBMpNOhuq5WhFb.7V7wycJkFKFZ1n1qMfY3pw16Z6Ry15HT6cI9JWdfCrJtv_FWA5Xz.wLDPkkY
 VHBl4DAfzhCd.ZofDCk0f2zkgZLoVVS01KV2QTa59ENzk4MUwyZ0H_T4hEPbrEX6ZnGD9gh3Vpg6
 T._0rUvQMda.A_MCipcdJEhIa2ZgFnobRLjz6ss7Rjc9lub0utdNmtLKyyy8QVEkjSVTDmLqbEpw
 5KtZhkYDOvNV2.c.xtFMIeOhUIkWLCRbKyXCV5.hyqMvr4VKWlnWB4yhJLusX8cDTj5H_IWDn0L4
 UQDs7AnDBZBMWrCzCxLQtO_GZ8UBYdudnuA3EkjD6r7s6x_Wy6QpyHlS05HsRTw247GK5at8mHKQ
 4PRu.3ys4dG6pDd428QrDalTwUMYV0rLw8LoTxm4yyolJeYTOmqfAoEKn8sWnb6SOiPOFUVbtKbc
 NfqM46x02zfylv8A.9iiHVsCQCx.z8zeG32LihzqT0R5Iw_sZKunT8PJs4HFwgCZhbfVO.DSjMYC
 Oi7M1.OdFtwcXFP0PncVfx0Eg3JgpURkeEYwpyRdONQAL9JxIINhrlbrdz5N1PgNNOtIhUbvQc9h
 YvmUffSCf1b5V.Ai3V7JIUsdJr3mqdRJ1jF8auHp9vf3abH.S.THOy66sFPaHGmaMOncsq1bO9q4
 kNKKitU.Wtt26Ik3WO94IP1uTD4ntWp4YtQXHxp8N9A_ethZ2t3PJWcimS642B7VyMdlmcp08spo
 FX8o_O9GYhEYKN6T8yr7TRR0g2DvqltySQGzzSChWQNex8ZNlnmBzR2uTTPsqzenL7aomq75bquY
 XaURcJVpq7t20H7wlOmlHAZNZX12Me.9t1RyAyIR406xgohpPod7IF3AJ_WIZia00_bIaa.jSm67
 N.mB2BYyaGrCZrxdYQOWvd0ESV7ITI1lncVTlc6fAyKmS0qIzGt.Scf4edpWIq611DIck2bdQwt7
 mbdi0xBwxpEANA6XTdwyfXj6ASnsgf0Sz4tLUsiiBOpNROhLMdDgk.Tk_UhT6fh6QlOXCuapDlLl
 3kYJYNT7OoVrhSvcXF7ixKPIh6cUxVOTjMpsYxtkYrBlrjF5nGSUit2KMwv2ViwK0U1SStb8gmTL
 f1ZgPXDIUtdFckR0bsm9RADvZquMnVGRXN4uE7MFCLseJGzizp4f2KdXpen_0JGDgA1HRlJaRE72
 9uUSNKklaAzWPrM9E1KQ6pI4n2I5P9Y_zZPl3TLhvUZTXbAV74v3GcSUDapgdZoFAFC916_mXSA7
 VccSTky3Ks3HQi4GGbu6x.VGvAyJ1TEIVDE6y4l6fhJmqzjqK9jYY7rGxI83vBFPkEgPR9OrI9q5
 EkKDU8X.jcy4HgUHSP0Ky1f4dOpeiHklXdTcqu_vhcy8FpPuESwZXbQFey0Tuwd8xnupmmwLxcW4
 cJyh8Wmthjg--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: c2131895-e9a4-4e5e-94a5-a577eab6f2ce
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Oct 2026 08:49:00 +0000
Received: by hermes--production-ir2-5dd9bf4598-vvk7z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 75af436376dbd15d975c5a6fcb10b01f;
          Tue, 13 Oct 2026 08:38:43 +0000 (UTC)
Message-ID: <ff1fc912-eb33-43b7-a9af-d8c97a049c4f@yahoo.com>
Date: Tue, 13 Oct 2026 10:38:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v5 1/9] dt-bindings: net: dsa: realtek: add
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

The RTL8367S-VB (chip ID 0x6642) is supported by the rtl8365mb driver
with the changes that follow in this series. It is identified by its
chip ID register, so it does not need a compatible string of its own.
List it under realtek,rtl8365mb.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
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

