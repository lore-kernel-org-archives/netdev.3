Received: from sonic312-24.consmr.mail.ne1.yahoo.com (sonic312-24.consmr.mail.ne1.yahoo.com [66.163.191.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC11395ACC
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661711; cv=none; b=BzwKQjqAxkz0eNTlUH19ThMtyiyn9NiviaGBMvAf6u+1TdVqtpe4FLRBQcEAi0F25v4qxVaWKWYE3yTbbqwnfIbmrpa7idVOBYE7QYOXc75csC2w0rtYRpe52hJgObxD0S+CAhwq5DyCPpEGBnJvlcuv3ngx4vGQYL45+nePGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661711; c=relaxed/simple;
	bh=+JB7XipNzNz0wtFVDnLNPGI3XOSve9ZpgoYDsQHWHUQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=KgFG1bYkRxe40s5HfBI8suyvqBXklW9s0BHTwqVJV0wYOG8DBdAyvMQ6GSTeHL0eo7dv6nSejYxF/ZLQ6Zi/ADvkreVK96c7a5Vif0GysPsbLMHXVXxpT12WPLh9t6WhA99z6o/PegXQXW9SoNUCA3dVffRqJu9wyECTTs4KNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ibMbDbX4; arc=none smtp.client-ip=66.163.191.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ibMbDbX4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661709; bh=mdzHawn+hXQOM+WR+wXD1MUKW+eXjZjdraUQsrIoH/U=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=ibMbDbX4v96MMK1CuK79DpocdP04inIGlsdFJmUQwzG0EnuHwd3k+usgWCMwUq96b9L4cAioQwWaTSYa0O22G0Dd+SOoFoxTekay2QnDkGwUS24xCkwzAGtKrcbUFIUZb57x8lssIWgB/13bwXXxxbdpRWwY1vf/FvS3q1mo3sOENXTO+R4TytNE/4jUIg3Z97tXuPlZnnQPPZFh362cS84DzJ3fti2DyO/TfN4TVRp73BgaZYqAyiCUhtQ3TGLIhyTcuRZvm9iN6YftADbBPZYYkI7RffwRZpGczk9ANeNpjWhXwMeMy9nH4ZeR1IoORhjzQ0vSZ/tsPzzZ0s3meQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661709; bh=AzZGQw0cerJ2Leotw1vG4INBwRdBQSXGnNr22L8Zp+S=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=Fkxob4RS6ZvSk2Ld9A/T5dye4qYgiEjwZXT5zs+Njs87f2749lckiCFw7EDa1U5L4AtMcNK3GyhIktJu6YUeZ+riEDzyfyZ2Dlc/+S16woof6Ysg7uXkKICsqOUn1ndxkeX7tRZOtiDjvzxHUwqsNseQlZn4Hgf2BnD/2TK0pfMjxDk7FXa1C8gQYnurm8fV2XKClZ73JwBJuzfQxSt+kr9PtWSkmr2MXka3fp7ZBZhhVBqRBhsp7LqyD41iX/EYMQnkJygijs4Ix9khsoQq9Y6NDIGOiZsf4MEzhF9S4d7FDtbYRX3xPPIKTWXIVyp5+JR0ix7O8eGiQk4ycjOXdA==
X-YMail-OSG: BHDcElwVM1mDIQEqJvTZ_L234VmFNe.lWTkKqQ2H8YqxITdNFVUx8sPTsGuyVYL
 6A4uvlgoQlBA3GhimN6nf2Uivuj_0n4xLqVNAC.LHviZTl5sGVMfT_GYB1E_jzCizHQmJ1n0naAp
 zOlsEiJ4QUrqsVrNl1WXdpKfCZ1UlpQZ4hPLFYLoGxNX7GDQcqWdA.BcRAwWHZ.2VxmTw0m31MCo
 GhldtiBLMeT1wMlDxA1HpCXZMqH98Gg0IDc9db2tzAIoktVwGOnL3tv53U.7vL_2fH8RcNauSXRR
 arXvlOuNcfhq18RmMmA74DmejpNe_e2nxmzkYIcAZVt3RU9K213b3F5aKXeU4egLyEiMILEB5OJN
 1ZDVC09uqlVvwSwXJAmFH_34HWXjQSbpjjSTx8WgfibdC8tvvWocaBak9emWjigj.cBEVMYpz37n
 eLme8oWQlVPCQdEvVE7nDwbesqjXczZpU09vXbHcFgurfcgXZUnZ9fYIuxflprUDm0l6zQsrNyy3
 SGUdd0GtYZBZ7LRS41g0hzPnuwDmvWuk6BT6gs4shbCb2fQORqiGIj55dsScdvkBu7I0WuBS_B2S
 b5OWwyxG27YUrEuc0Hf4mOklzJ0evYziJUoy.RNr8s0N7utpw86Y7df7DrwcEH0xztUxrD6aZ0LJ
 nTjGB3ueU45Yd.oxfOYGAVUvc4O3XGakki5GyjLQdNM7hYz_FaU4Vmk0VdrOgVK4Ss6951vI_Cpp
 r5jJtGlAh9F7SC5i15.l8SdygkEKU4TlCLaYvzh_YMkzaUoR735N20kfinFvjB1fPkhZh.qxmKCd
 DyjV2uKrnIZ7c81i24X9ZSeFAmaqS.hM39VEWZw52ywMgACfXKhMhRaHMP2ciAp9LJ2awXSuw7ix
 YOQfX5uyMNeB54NPUBuUN9USu5T.OWp08t3TlegGSAqGTkcBRVNc5NdghXJQPWngfLZiOEgwzlPk
 SHRhXPhbbxbemqnP95f.zK0bAtByED6OO4LT7ZLGMnYbP.T3oaVGgNYUwAKuLXpOv6a1VMx.O775
 ISDviUD202zJnh7TK2ADCF7Bn4D9pTIQd6EIlAGT5vj8muGuK_lVQ2jLCmJ9Z9nG.gi2sULy9pfO
 ReIGZRJ3j40BsZg.0RqVe5uQFPCOrSyRxETU336No1bYefhSTThrRuknLqXF1YRPnY4deAzLLuKg
 kTfXCJnFCebnyA.0swWFzPRJFIcUNf2DGocXw9RQa8fpbKUEGBqCXyAag90h.Vfm23CpdT8AqfKR
 pRTxmT6Y6wOn1qvWDXlLMjAACxzXrkX_isKMOWEvzb60VkgxH81m3hXG14r4RrV5R.9cLD44e1dD
 uvtkS.EbvlsAly3t4ad6Nt40TeI7zmp_YEk1vmJIz.2Fkr6x34H4QyvzB8w9NHJUujZ6Gu3Rkir7
 np0jIl6gI7JCZA9y_f4MTEK7LyQNFFYJJSeK0YGrbUDad4hv73P2QN8MSNWW6Nb9X.2QKS9wozfa
 Pp5CnxPUXo2nEH6fj6VDC3IkeE68XcqqKg1XppkdaPQnGPxZbXPkWEfC39iyRKobxAyJZ750Pzgs
 9qrSMB1X6ghsjYz1.KcCRGfiX0CRuWoHvQsziwz4y5G0ybd.qft56285P0RDeQ3INP.eni8JzLqq
 y_ZPjiE2cHRAWtcY2dG4PK9LvAwyvHFlrrEL6e1zgLsu_bXyHgEWLQ4ySrFnW6Mn1T4JBW7XGp4z
 rqf9egfExs0czcITCAL.klKYCiNXNh6sFwZrOeZ_RgSzF4M.YP2_fLuk6H.yhlLYYBqtPQyGKJ8b
 0OTenijXSp4IhdHEvAzl3rYuhlWjBDJYeeO7vLaHeHh5IFP5rgGtdN_DYeyxYuGP7zXhYbIZQ88w
 XU2UnmRsBRI0v5aUO132ZmvJ8KID2H_Zhoge0AFGxwkLId1G1NHwFsFsbV12TQBLt2bYiLn15NYz
 jWiciCitTmTgnVKRgiKDyzVSNnxwoFh_.sNfCo9b4_s_cZ8GAKWP1ocbwtJYgfC36Bem6GdqeLzD
 4uR1Gv2w_lhdVESOcTnsq6el3O5UBNYnlambBsbzfpyQp1lHYubbIFYMSCp_RCW5ppSdQfXW56wZ
 2I8tEGM5ZmsN1k0_HPkeWepNfxl0F9iHy4TUwzv_x0A25k8zDQq2C9kYt_9WbxFI.4cQsQ6ihqvj
 6tIoxE3vxwVHATSMeDeBzWhUd96Qk52bIpYjFDXPuGksLhtvB.KG94lEEeuixxEciQiNIVgTPwfc
 ZVZrOJ5gbbJiGjAtJJ4cWGf3uH.jmVEaBOnseMdOinVIzfQ1zaaUb.66hok0a1LKCB568iWydnqs
 BibX_rhv1u2XNnQmztxTbJNIFRBf2P2dvvbvaYP0-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: db21b006-e687-4f9a-bf24-171c5034c38f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Sat, 10 Oct 2026 19:48:29 +0000
Received: by hermes--production-ir2-5dd9bf4598-lsjm6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2e1f61bd0a4759a889456ca9d87e0635;
          Sat, 10 Oct 2026 19:38:12 +0000 (UTC)
Message-ID: <e3f96c51-f454-4544-881e-80a02f9ae9f8@yahoo.com>
Date: Sat, 10 Oct 2026 21:38:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 1/9] dt-bindings: net: dsa: realtek: add
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

The RTL8367S-VB (chip ID 0x6642) is supported by the rtl8365mb driver.
Like the other models in the family, it is identified by its chip ID
register, so it does not need a compatible string of its own. List it
under realtek,rtl8365mb.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
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

