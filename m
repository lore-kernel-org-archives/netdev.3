Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.188.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794125168;
	b=fmtiELyZ46n5PiOUEazHX8YjSCLIYBdiRdpvnaZYLZUj1xVnUAMXFzwHUNHVxtG+1Km8
	 815dV/UjtqWuDdQjmP/iChHy92gU0AVAPaVa3ZXzFZHlZBo37Vi1llkLobGsJcWxU1noC
	 Nd5Ortecg4TKtBv61s4H7hciA7wu7RiubDYDhvsFzpxfMPN5qwQS6/KpcYgCi5suAMFJR
	 Rtz3aZ0LEsCgBtzbW2nWGDknqKii3cPsCK5m7SgaePlpMR5tu1/7v3S8i33AFprRvKXoW
	 D9I5LN03GwjHHtWyn1zYWFn6v3/COf389HRZqpY6MsINbHtN9QVoxcvObBjzxgkOP+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794125168;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=HO43C3iEXRa6J85xNlHDELJDyLp/RMlGT8/nfr+lOp0=;
	b=cWTN6j0oeVfKSlenYBcX+LSuiryzj45AuHbF0NMlaPz6W3tje2kNtgFxSffFu3YPQ9zg
	 Bz5CFdw+6mHXEupjaBz5nW1nkQV4RYFL7YlWXzwwcKWsOrxNWG8ITa2tgePxhuDHcsLQb
	 nXtvvOv70rfwdjoKD45NSv0DOABQh937tvnlEmdQV6AlO2zyCRANvNq9fCcWXnxOudul3
	 rUdEnSGGYmVc2fT1qFgZDY2yO/HAKy7wl04smsyMXW6Qsx62pKPeFXpvPf0iqfGifEm9P
	 zcFI6ohHEP+iDln5KuaqTPLEnF4HPleK+MmhCujv3xGZNJcZdGCRRNil6yFGZP9hAWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b="Wo5vD/vj";
	arc=none smtp.remote-ip=66.163.188.204
Received: from sonic311-23.consmr.mail.ne1.yahoo.com (sonic311-23.consmr.mail.ne1.yahoo.com [66.163.188.204])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B69606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 08:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30B69606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Wo5vD/vj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125166; bh=HO43C3iEXRa6J85xNlHDELJDyLp/RMlGT8/nfr+lOp0=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=Wo5vD/vjo34om4TEyAxIPo6gkmeG0P8GrvFUdLinlIZ6Kj1xZj0cnh7i85q/ALSTOvG0liFb9aGb0w8RJNgFeh91GIztdAm197BRP2oi8deMg7H7UoYG2QViqGT3sN8n1HFka6vCCfsUpXrfJTVIIg6taFIBzvReWweVQw+48ydhu1CuyLYS1bT/7N8v50feX1XCD7xunEhrTDYzrXPFLV21uu8Xgv9isp14fdol+GIaIMLXV4AE353tcJZ6HYIt0BO0a3pr3vKVF9u/XP00r9hvpQ6dcu3iqo3MoSkGtypQoKeB/o+Hx2uWYqFK430ZmKNavwKyYtngkoAAXv3Mjg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125166; bh=ptHfWzptigbxv4OQDUd10j0hmGqXLEoJ1CH5iBQVB4T=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=XgYZLD8hmK2Ai20qWk8rJJPvxgXk8pwriS2LTQ5fVoaA7mIGnZXuBI0YZpsMwMpefvVwBdfJA/1TztY8DJHZvdVTiX3KsE02nc+095T2zuDuCw2YQKGx1tfJCTrrTSfwok9a+k8xyTlV0dfL0X7ATIV2RTHin2kIhqlqaLKUlf6bHTE9Idoqhjp/pYYZGs0j5rIeq8F46Y8bJoEQN4sCBu5H+k85LA5sCwRiXPUEM3PT43WwOaiCVEyFpvIanVY/CPmWuRP/YdTYZVM/RWxM7W+5ASZJVDXZuzakgiiH1GhGhrs5qFj50Uof2ekdDNDIF0nSaWMUkzh/Ts97UYEVcg==
X-YMail-OSG: y3dA3ykVM1lX7.McCK8A3PMzUwlfey2WoEhEVD0Mmmx1KmEkWpydmIDdIdUgdOY
 _UeAh5GbH2KOXXi_oU_e4W8Pugx5Lv9YWqZX0k91uMdgLN5Ubr0MK4TPzQi5_zKLeifAKUg1HAC1
 MmCqWgt6NWqcLErZiE2yUat4c3kSG7_ZZVCUtPV1EidtychiqWO38ZBtABl4VOXpw_egwBGLL85o
 L_YBx68pmBNFSxv_CAXs0FqT566G7D.o78OynTJkY6HuBEPbuMjsRMb9oV81Wq.6HKm_kTSmaTig
 YWlDFeMFeT1qKVQ2D7JIfEOmW8Otlpv7kJ39jgeISuPO.IFSkbqkjC6cnJVlA51yc2ujf1qUzVsx
 C8WMC27_B8F_Fw.ttO2D81nJbvbE03vGtoBsRXYJLB1uuT8EzwRb1h9BPfd5zi4Qv5sSled81Xt0
 igZ5Bh8R.NSGAI2OCPoy3a5YKcN061zR0Xw66k2nwfBJsVqz9eTDIfqKELdZ.0Vv0EWUzGFAsO9l
 wQSMsqlWxFhaL9KhF0pRWxSanNQFQGS2fCNY198nq9w090CLRllFLCGoAzixLlaXVPYLTVcTQTra
 UgKwdF9KQVGZWxYaULCFBD27ISYu6xn6JsrbWlHS_uzmgpPWf9wdC5YpHvrHtkaUjDVbfQwmyqg_
 FTOxDpl91PJPzE2tiiXzF7ppN19N3tEj5msAjWy6jz12rHuN.cuc1lk_sE_9DLXDgjeWQsRKiNOV
 qOYYne8tyAZCGu4teCkj4FwEnnkIecLFLPc4pjkaBbNn9gk1GJEit2smOOBcAbnJlrbZHvpxQdtN
 tesBobc6nDZ8JauhPKHck6t_xWY04ZDTOBYlNEcOr2X949TfxuOrcdkyQrIEdkjh0ZJnktDk_Uw3
 9pDmgiRNgCfI4clv__NDpnMZUjnR39a0Aghjiz4pPbh0TikVk_4lYxJPkiBEviKmloYCyUq18HF0
 pG3G.J4352iepTQt2rix4RPDmo87.zH4p._c6OIPG92Xzhpo9uOP1LrNgdxWxDUwYcmGTQi7cEOn
 370Dj5D87ullTfHv6VoQiyWVP2RYNEnFXTYho4YSYJo_iI_MnBrF..Fcr0pNQcC_HCJU1mssThNv
 PfbZGxB60B9.4.SvmzE15WEI2GdZVwp2tRjl3eznIT.SIcIa1zOUkp7FKHO6_JchGM4mu9W18Txe
 m4gQHAqxAXRCTMWrs7QUZUqHmDIvsCRQl7s7TbE80sl.dLvJ2Hn7p696WHpXAtMzYbDTHc4drKy9
 tdcMPr4s6mlE7w_OjzOseWsHc9eQNtlJL60_C8uOdiPqVjn8G.GG7xklfuFZB8EIn8zFRnEFN2.m
 7Fsb63vFuZsLAi8hP8cq1LLto3cSMZQlGiqaVgcn6NKENSHtpmRQ_ZO1hEmDSyGKkF4ax3ozYgM8
 1xWamosrSTzopH82Lfk9FmLXJyMCoZnkbwqYKqLHkTGBPWliEa3JEIli2F0iCbeh0IIfj0AcdGV4
 qVZeeSpsMF8Ko5GRAU3kB2GJqv.pRxPJ0jy8gA6ayyuu8V5zdCirNAk6fuM4NH7BWZeoho.YoDkA
 hClZo.eFL13A6M8_36VrL4khiezfHu.vcQy.UdEnLyIl9IT80rtd.5ltwZqZkoLKG.O3mYB5cjDq
 745VXmtCxnhpE9hIsW.jCS6U9nvvI7zFTDQcKoCxs6qZrZ9podyNdSdnwrALkU9RmnRS4pA90OR7
 V3dusQFynvegfGVBjxBmoaYe3dSlqHk1vwcZVlB_tst3Hldo9awW37Y2NqyBOIaSCYxEAlNBWA5K
 D6BvzR57l3s6SmMyFBdZ85S15uocpkXvOJZ3l3c0peg6F5OBvfNVs8u3RTaLC7H5Bql_5di4VKdb
 rrTD1VVsmH8bg8Y.jSmk1Y.GWu9wkS1S237q.fCeCkGsQzC5l27sjclEW3BdfP8JhkjipB2YKlAz
 uc5h1r63JOdEfUdLGQZ9xLOXze4ia1bTc5QiGQAZ2To2.RHUSNefhMLhRAFRavl1BanIef7PvGTT
 JvJu7mS.9JJVAglVY7f29JJfzW7xPsy13cYWVBSRwq5olVDdg_cpq7cCLx4PHKIM20CbVnujcVL9
 LUXUim01e2L3cxKjn7RvEsL3tA5wJ2cm.ilU2YXuLQMMEk2iGvER6ZQVguLA1316pFY1bQDrc5.f
 O17TFZx9q5T5hRPOqr8_ZlUOERzr1SO8Gtjex8fbRZuXMTMFdonmaB99sAYNqDMpKcKFHiFQPSsi
 WZ8t2ISl7s1Rf2HcKHbmKkGhAcbZp0W1U6L4g8wkY1oz29_yQhZ3E4TFWrn6hKopo_60qWo0y1p5
 hIUkfWIrzH_UyEMoYe51XHEUPnxqE7hD7eyA-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: dcfa1c7f-4933-4f58-bcc2-02d9caf322a6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Sun, 8 Nov 2026 08:06:06 +0000
Received: by hermes--production-bf1-6d6877594b-4bzzg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 53d5697aebe4574972d1a7c4df420924;
          Sun, 08 Nov 2026 08:06:01 +0000 (UTC)
Message-ID: <01207d80-8797-4d8a-8828-e7f3ecedaea9@yahoo.com>
Date: Sun, 8 Nov 2026 09:05:55 +0100
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
Subject: [PATCH net-next v9 01/11] dt-bindings: net: dsa: realtek: add
 RTL8367S-VB
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alvin.sipraga@analog.com, gusfmora@gmail.com, kuncy7@gmail.com,
 fabianotassotti@gmail.com, gabonpivovich@gmail.com, contact@c127.dev
References: <9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com>
Content-Language: pl
In-Reply-To: <9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com>
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

