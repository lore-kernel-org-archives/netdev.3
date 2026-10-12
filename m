Received: from sonic314-21.consmr.mail.ne1.yahoo.com (sonic314-21.consmr.mail.ne1.yahoo.com [66.163.189.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CDAF9C0
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 00:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791763786; cv=none; b=FSOojwUCQapKv/WR7AYTw5+JOO8MbbupKat66kVlUkdnq0f1pDBwgIey8Mc022C7G623wT4aUdq3HgCEeqH+Y3bOS+w9pUsdUqxjosWUn/5xaz5m7IURo9TjBKkMRD0HCWOEyZgoCrkZKzl3frmB0ZA5pd56xV/q10HoS+kmBpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791763786; c=relaxed/simple;
	bh=/Qjn/6T8LLdbjt1WNvE4aafgNBVcYdJyoOb5FG7cf98=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=GSdP3oVD8gTmdvqTsaHl0YFbudEoLZp12Pk3E1BTRAcyikAeqzo2aCFMlBWEk3V8x0Pnu5MhCVwkEO082NZpbWXXxm4Otkx0WjGsrK7Sa3gtQvuGl+HKGjoiftA0IURmlAZ4DSTM4tK5XzSSoWwfxWuS/96/rykU++mTWKII4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=eIV251BC; arc=none smtp.client-ip=66.163.189.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eIV251BC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791763777; bh=Q0cXqf+y4N+Rngf89jSGhBvasWYdyhb6jvGRherLnuw=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=eIV251BCMY+3PvDq7xF0TFJaJIqaqGtnO7buEFlyLp50sW9O18WQrisxZnqvnr9iwSlhlxZxVqSOaWn68Il1Un0N68EYGtcYdOuPJaogIDgmoHZgL9f4hGbFEjhC4gG+fCCJrqetuMM8rI8jmQ/2c4B//rA2TeNGL1FbdB51mu5go1jcpdoGv31/3fOQrpv5IwAWdheuhb/RY+m/4EYQ1hAtrHm92c7bH29cLbrNWr71hR9fCNU9VHF9g1F3nh8I3Q/+SiEboY8zLwGA1Z60CjPCU+ioqqoiUnRvUFjDylM0xFI9CSEZfeRn0xQNq1FzpfJaIDE+EHg69CmdgnHamg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791763777; bh=nix/6E2trQedkLO5dSPsDDnmRO6eAT9vse0872nD+QP=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=HndDbJS/KVejgvyG7Fk8mVbC83DapElckb9JU7AHTVJslhZdw6w/vln5Flj0oCuB9MnPvU0rLAh2/iW+GkI3rE0EeU/A+kiPo3+hHcI5OSIRSxGCEpGimFt7qSAgay6wXYKAD0Rrlj0KALaoKVdQ/CxAOe+yqbArHiRx7XQBzPUIg3NLBPDAp/GXKIFLD1m7CU3pp/cQO2Zny562My4RTWi82Okrf6tq+SqwUVq5OVAb1fOF39nGP8KssCALxO1xnTC+YvvGyOrRG6qjX5Ykc4b3eHhcAN4HyWz7BvXovn5lNZ6txrlvkVEK8/i5T7LRJ9/tXZYOWGdk07lK6i02xw==
X-YMail-OSG: w8wJIPYVM1kBzBBrO9hTLCYZlpN_IOhs1.u9cOHyPU8ur7TeRyyFfKOQLKCBbfK
 qrRBwEGj192Te2V9wOelkBHJ9UuaVHQGcEQyepjRwdfwOWrkqFdHZY8mdjgcHOf6XDE_7yVE0MLN
 R.ynm95p7VcD7VEwWFWbBROYkkKGPQDOpxRqrOYX8KksD4Zgaodjwe3eO0C_TOf3zJ8R228uUZTt
 NBNY_fiqg5WSHA58FAV9dQxiWSkOJGYM2ZTrcTAWXux6VpV6mwaAGvNeA1Gogo5C_haqUBwd874S
 T3tU4MsRiI2oaU3l.IRdDHIO6DsWSUEZP1fn9fc36SEQhDgKXGXefw81cqMQr_2MmtoYhYY45rmS
 H6YYxQvasj20APazhOaPlTvDmGKOGGQSbyHfcAakLNzRltkQ5ky9Vn6hS16dgO2f9Vs7m9W51HDG
 obGjLAnJEa3UsPyYw66MPLOe8O.62sSHNKyxQB3ZXthRA9hMwCb9dNNFZXSy.jmdd5QwlJwlqf41
 B5ZLjUosL0s1ZHzjhNzj1ljDkXozlzCZJa2Q3EGUFatrSSrJPjNI1069mQBeAC027hAXG9TDiNfD
 alc54OZ2CeIxP5HeIvuP03fPzBUkWYMcVzKxAo2iGaDWWXYhhApAyWATyWU4yygAvKeDFNpK9_gj
 o2qGGWZCMsIA6sxSaGkzlAClbSDb2GLKmOL.69yVYC3rc4SU3Da3c11SdI0kN9mDI2r7onGu86T9
 qo1ihvMxTavQnY0OPwl6K56kUIEoq8KppqPOMJDf3vhdqXG3HAd0ztJ0IfsEml9hdbDE2NatJU5s
 M5lDSSnSsXemXqBJc4Qc.aRfNG6j85SDZbQSMV2tOvs9FELS5SV96pN5jtfDNaDX6D5HdImP2we.
 cNoNGCB4yGjHGlQLZ9ZUmTIgmwm9tXsWAfmrMGFYJAstKQfshCiTMwZnRtBttrLd7PyBQYskf68w
 i0dldQolxz.gKxCfyPs_iy45alGiQpQmaLP2JQ.BVGYGqHG.mEn_v7zqr0NCE0yWGlFia__AiX4v
 8wSXs2E4diur31VZD5lIFNCHm5atBczi.0yD2GtTbtCRInBrs_COvpNMke8RDMxfd3SkHrdXk6AT
 cy5swsVWcBUYX6RGipyW7Ha04dyQsVBhL_oH3b5ccqoBC5yn7kpCS_altwsjjh.1QB7ewggMPocB
 lN0pFdVo2cIa9xDupijIayU7EhCVOg_R0KaZ.C_OtQcl7.7.woZQJvrGd_4r.0V7_O6sJuqltpal
 GJlc1t8WRGnEcTtXlBe2dZhQDjNFFngwhOLzqFxxrvcwTCxRXsmbsI39kI_5WKuzDTxIapNoYiSy
 X0dmCfy4ahu_4NW45llUqlWRVkpLZ9eL4MKiVKyPy6W_JGCkQW4kc3XmSD1gY5qBgSklUB0KHChG
 j5urRPoEfbOdFNOx_6nt3LmxYtMynvvYqwg4IsymIxSMve7pEQAHwRiNF6NxOO.C3uMwvSbMZr2P
 LzFxOrQq2774uP22RaiFT54PpKQSlcDQVFp7yvowY9sQnK0._R4hv9gYGDLPGaQIcCLceV6OR2bf
 xm.TAcYHxzJOIveo_Vg1nVRLC_hNPszUGI.4jqHmME3vrRy9J7aPsruIy0ANUuNlE1MWRdZUsTmt
 UcMXspFzz_OyUMVo8NZ1UDg2ZCpg72nlXs4lD._00maW0vWIguAgMn.wN9s2.L_9mqG1Y66.LdzB
 qEKYIFTyDo.3ry7lerGMh5qXp3aCOqBCecLA2NHH3FpeVz9t4WrmnkcS.sauEu2tqX5i153tLu_x
 mkSEJsbMbrYyX5uenjqfIUHA7FlLeDljzCErZCUFlXITW71_lRVl0vWr3YsvG5hVI.uP4dnPFdm6
 EUERdLXGLWJw4cmaxQC1jChARd9mCNOAPElAAgGoxLAz8gvSAGeALEBfQcxqYgWjXzHKBJ9jgvzq
 NkB5xLd.U0_u0mLhyQVmkN7y5ud_McX.TTa2F.vDF4qeKzb.o_HUwzFW76YAJSNRB67QPPB6kWgY
 rpA8DZaJOUj7jfuZLbkdQGHYz0OttWi0KoNRNiw4wmoc4alXZ6F_QLAQIktMjb_84YJrlNFihBsC
 9O0RUION5oyihzde5wiqpN5nwl2W59JpGZpp64_4hIL4JXMCeBKklpUZE5CeIEapPiq5r_rtWpZu
 zPvOctOgrj2v_WqdcHiObHkubxTCBMfUjRi_hIuw.GEnNj9Xb4WgPUO5Ltv4pfaGV.1SiucwqeBJ
 Hy1zvEuXr7NUEHd4lzdF0vS_nXs1NitovXnxukV1rm88936j2OJ3yu_.M0.o7ld7ZgYSuaoLYbKJ
 UQGnp2LXXr8gxtzcKWrwl98Cdo6g7i3v9Fh8PnDq5
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: c55fee97-cb87-49cf-b27c-48717573a4d2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2026 00:09:37 +0000
Received: by hermes--production-bf1-6d6877594b-r7rdv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0a00dde850d02ecf4bad5c92594483d0;
          Mon, 12 Oct 2026 00:09:33 +0000 (UTC)
Message-ID: <5dbd1b29-72d0-454d-83e1-19f7232a0ee0@yahoo.com>
Date: Mon, 12 Oct 2026 02:09:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v4 1/9] dt-bindings: net: dsa: realtek: add
 RTL8367S-V
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com>
Content-Language: pl
In-Reply-To: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

The RTL8367S-VB (chip ID 0x6642) is supported by the rtl8365mb driver
with the changes that follow in this series. It is identified by its
chip ID register, so it does not need a compatible string of its own.
List it under realtek,rtl8365mb.

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

