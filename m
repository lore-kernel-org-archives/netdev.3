Received: from sonic317-33.consmr.mail.ne1.yahoo.com (sonic317-33.consmr.mail.ne1.yahoo.com [66.163.184.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BFB64A8C
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113140; cv=none; b=I891VJvrrF6yN+buifwlgAF7iUnfhs+ieKWQrX2IINXPJqYE9aRm+715UCLA7YOtwpW/ExTOTJa6/PDXMdM8xZB4aJmTYQNGJuW29GrsZZySY5RVXZRCBMVpaczrGMrL8eTCY8J2zdQujtqvSAcCFjvUrBPG0kve67qQyNkTEU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113140; c=relaxed/simple;
	bh=DZpciyiHrnfZi/U6tegj4iEP8brHE8DE89jDeeiGZ9w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ZjUKapYZbGuWGpCE60LNLFeEGIfagyt/YysTIOP8x86oMux+miOrYb+nCpntV0+lzxTZu5NSWFh2tx2D/YqlaB2v45Ke+LbDMyw8exi4gCOyRFINXsHIpqcw4yYUFKAfoZPfYrJr8Cpo2f2p7k2RaS1z70QwQSehBVopIwkxmTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Bj8eB/QU; arc=none smtp.client-ip=66.163.184.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Bj8eB/QU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792113132; bh=gsRorfpiRWfdlb5OcQgolk/n/Hz6due+H0Gle/vIg0g=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=Bj8eB/QUfhoiFDm6tdsjE+ZPkQwWEFZT6hmCOHWsl8bEeKtd9kKuBHzhwtGUmOVtMC9AoFaFNFDjt7ryRLJVJu2tIJ5cueUDM+YRB4Amsjx2bDNGmLkjH0luS+PP1g3MFLHb72X05+lp4V4D38phyutuP0x7tZW+V1aDl1m38O8oWnd3hIvMfVcsKPjMw0n7vqVw3H98cSQSpBf+MSvdLnKwC/LuMreBb11nznrPgh97AYyblO542EVAQvOGJ57S99D3CSOTqdK6JHMICbuj0cOPJdZ3/s6wXqpM5xq743/FiLoAydffffjq/t6jtsZ2XjtP8NAoF1PG7Srpi90DPQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792113132; bh=K35H1uzBDLq2bzDCkEjIWqUA+pi3Aq/vV1haFFvv5c3=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=jP3SABH90q3+bOzO7Vny0qHVFF0EB+ivBtrQFayQ51OTRkh7oIHPHws6U7oPS6fOaB1L1UOwlrVD+1qWBe+Q8B/OQYNAYv7r8cvpZnr75xZw8joTmgmW8kGqErM2Csw2yuC577IHmV9UvO23WLZmP+5puD13r104KWevq9hRqQ1wHMI7sSYnmtDNBRb0fOiFTWAXu0Cj/VhjTJR5yv/94rocWPKRE0L7qOMk2WOLpxa1GWPHXFegX+fzW+DuShWo2lnBh+MyE8IpRsqW+Bf3S43u0gvhsGNAx0f9uJPyY4sYQFIa7o2o6qRgayARhfpAT+rEoLljfBbaS8Oym6zlVw==
X-YMail-OSG: 9PX1dWQVM1kRA7IcAlvjApSC6uV82oV0skHZS83tahcXjOagmjczimTj1PqlBx9
 SzSS8E2feg1OghnCurbuT9H95zoHygOYZ9HKQm4OE.qXohd7eoMEilGsudueKCtc4Q1YLdWdxKJQ
 w8Rlehtk9m2yGllmmCucRASUt5QUh2o2e9Ookbl6AblIrF3QOecq14OGcYliGWy94gVijst9.a0E
 OXlWvniBobtuYcfoJlQG99FnQexkLLSaXflxowkzRWsZ0KDgVKIvVNUqRVYWYU.KSj0K2bDD70cU
 R4jDPH5e7j.nOTyD20CkTRiKuA0A1Rbtso_5PMjP_Y4tUq_P2ZGd6jMipxjTU8OVqkijF2vkgj0Z
 dEFa.DURoRqwlm_DwgdpuLhYTpq7R3kDF_Y4mWnqf7PEueEa1WI0ui4x_Vc0QjUF0xRrCv4Pupi4
 _DGEWvYNHEIH.l9bApdd5Q1Q0vsmMfhupX3OVDSIV3m4mvGVbIqcWUQUmmFx4Hf3vatXnLDhkZNn
 WAfttiWSfIeqlyuFOnoP8cXxm3h90IPFcHxs_EOzusiQtgVny8Ou5XpVLrAdL_bGJ3CW2KAKdJm8
 jAMNEfJd1edaffKRmhKuED1EHtZE7A2Jwr9EyMOrCiSl7QqvRR52jDNZZzJzBJvgVNHD3N7hySwN
 7vnHbFzx.sVeTmduVMORWrF20bub4GF27Uum72UFXu2Mef_IjV0NCX3Oz8k9trXPPPdFlWjAcg6W
 Y8op6pWecppqdb2bi3Pj_oVvhE.tl7eecqDpbzqxPC17Gdup0XPltguwrVoU.4FWkSSEiS6aWkMT
 HTwNYT4kGvfnR.lCzj6yuXAjRVZB40ndffKE7fuKEo3Yf8kzNGj3cipLh7iXG1_tOd8yUZM9w3y6
 E1XTYSAIDqL6RCOV13OM.XntJUZ9gG1J00gjyCEZsyqkUrFDZKQvvXZ4jQqK99vWX.S1DhRtp8Tk
 Yt8sLOQ95GeVBrfIcNR2eAS9gZYaJ9qEJ37.79IBByPA6K7_q2kk24G6FLFyXol1oA.nLgq1xXMs
 Iuk9tqmVpBVckzO3jueao1tliS66yKSwHbqKbSooV1YHNgYT1BwKPT7lGpOZxfOcxF79JY9aOaii
 x.yBiqeRsK4XcxnzNYe4Z0Ffk_1KdzSM.vz5lHl.NuKBKV75onrXC98SErtV.uEUDGMvW9cpMT3R
 tHlpeeod8Hgc9hqCSGmg8cGTPD84UggKq69BBLNdaIgg799xpd5UnzrJUNHIsQR._BLJ7YOm3DiU
 _z7STKEcGizwRDANeziI2TOOemc.T8kZHbenzRe245ufWUiu_ioUgOtW6lV6gf24DUxWN_Mb2LUB
 7GGlfj1bXh38xMGhXlfhmPKHcC9bJDEFs4fwPforzgdMQGui6vyXhDAn5BYIBBfCL4R0tJ4OZePJ
 UJXYefx9esCNccwqxHVzVslY72nXBSzISPRFvM6uOUOQjJtJBn5WX9qHYh1Yz0joKp7T_3Y4MZcR
 3SZVNtu28mqUWJxt.OD_Bt.eqIw8dK7JjrjrPID4a8oueXGmYIETWLgBiuEb_oOi6BhqpqWxE8NO
 Bj2yLvJQozdjN.6U4BoqAzKbfd7nyc2v_CJ.qdoEeRTBwqitqbG1EG4dMd2tpHRuYPi9Q5iIRiMa
 V_zZwLfc5LONP17wjyaEC0TJCFW8SVgDQsA2CKKTWFLqSpNixlFT8FCpw2cnnU6eZhUk1sxC2ITm
 BiaWadFuoDn5ZlbqBLw1EQEkbz2E4NbbLtmgIyf2Khlprm0zNjXtfWI3we4wHoIwl4DwSRXAg0oC
 p8f8hUg_uctlxWwdFp8wDVYoLods_7zRgp9OtV0.ViC8GtQhVbwuID8OquAESlNbU1_O6kve712m
 lRndNM4PUnCGCa4DVLp32_5hmarhIi2f1KtvRzyAtoZkRj3ohdb46x.cle3xn9mP5WzRqyiLR02g
 AR2HnTLHrfhzIGx6uVzDl7o3ju5E0UIL1FL9jq0BFZalzV6K9MGk0ullCBChLWIjiMV6D0CQxkj2
 prd9JQaUtSn3_WhWm7CPbh9DS6LK8UmQpyx_p9cCxB_lGFFKIICJHOFVHh2ZvLlXybGECz8q7xQb
 sTLZuEpd9pkJmLvB7DK6FTRV3pIFaudFmHxatJi92BOXbXo2K531ZZqmMwWc0Mbe81Sa7xVQ8xqc
 h_LtmSs3rdep9348uu4IgsjBAEc9e2BZOaSAJHgyxdk4sRGP4Y6oF8mVlL2u_Qfk.0WCcFDrd6VB
 hCUG50HC5M.n9b254dauf6B8a17IkKE0GEyc1KbJMSvRjH2nT398BaEGOvRvQJJdHOSUK0UD7Sts
 Dt1Tx4SqIH335fSzBCJDTAvaY3jKluDn3oX4-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: c00d73b6-18b2-4096-813c-398f9b2a0bc1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Oct 2026 01:12:12 +0000
Received: by hermes--production-ir2-5dd9bf4598-fvbwk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 29a607ffaeb72dc5bc81399c1e82b61e;
          Fri, 16 Oct 2026 01:01:51 +0000 (UTC)
Message-ID: <7bc13c51-6e93-4dd8-bf4d-b65d87fb36e1@yahoo.com>
Date: Fri, 16 Oct 2026 03:01:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v6 1/9] dt-bindings: net: dsa: realtek: add
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

