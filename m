Received: from sonic308-56.consmr.mail.ne1.yahoo.com (sonic308-56.consmr.mail.ne1.yahoo.com [66.163.187.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1562C4C8FFC
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645606; cv=none; b=PrNe/EozT7Z/vV9hBZXXHc5ykUhDu1HMCWsni0Ubk0n0bZWmW6nNCjCs5egUx8fBWV29NUPkhuqdhIjFnmGw4C5znE57RnDiTEczl0h5zSgVC9bzqEq89l31LZDwpONfHfUabWO/g+E9sQzS/e/KWRVv72FcGKzmxR7E9RNp1g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645606; c=relaxed/simple;
	bh=sxPEZAgULP/ZbDDZHcgy7lGNIOLyCv/xC8hcOqlXE1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+UhCLJWWZzIO+yGHKhmdbEfkZ/bLmLH5GGNTVOce1QWcrrQK29hI1+NjRq7Bctp8dTZudBpF9eH72Yy5uK37EFz4xb6fSt4e+sNmWOI7rVxJfUBon7264DHidEN6VCotlI2+w1di+gWn5meCbvI5ijTauQ1IZskvi1xmeOGrZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Ilpwzq1j; arc=none smtp.client-ip=66.163.187.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ilpwzq1j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1784645604; bh=23f1LUlLIsBqlqVdkm224TE1FNMMxefPjlISWseoXaY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Ilpwzq1jwXqkmAp6EpzOlGhXpvaR8GbOyinoN/nG5AJdIUQz+msSlMhnzb1HUX6uoz/T44UWVczspuELw1/mR/1/taOA1+sKmZJ140gwYpTAm5S1E6FTDi/gAhfkfK3lSkLNE7jCdxoTQN3sTQqRtC/Elxq0QG0oO+FUlTADVTTF5wvy/b8msgtmIRrqh1UWo4UeBh/KCZ6Hyh3ZxfTLL38o0KK6DlK4Q5HeEiOUZ7oyEkzL6t2cYK1V2of3RTD5NgEUACGT4Cxblo9g69FBnEWItpqBR/APFH72u+q1LggNC0BP2pAdDNnN5RcfpNkuodSjNBfv5on214mf+oXGbg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1784645604; bh=kU8fVf5oIjnUYNe6s012b4YFvNXgCmVAaDKxQVdnrII=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=LyNSfVMlfAWV+iwsj4DaANSOef9Z76yWY2afIcTttl3Tlq1N6+uWvcOnrFG9cP0u76r9J9jA1aJ9dyllYTRCdk9VkFQ8qySjYcSwlPIvq7olfolhkyh+98RMniLHoyN8FGnCNn6idFC3ESdaWBFhw7C8hCBhGDD+lxC1Mcn/7NLImKY8pnwI24wtgHlzX5YIu6haLe4VlW85zswbuARRuDv7TjfWswWV1HJsmdEtVCkevi+dnbOzVnegfjLh28ATQnhGsV1VcekBAqi5+jp3qeuBcGGdnJB3/sTEJeR2O6wknvSNF8Yo6BIVyREApevuXVBjBp68+oq+O3kucyN0aA==
X-YMail-OSG: lrtqDI4VM1nSPKyARjKF9lhTYJD8QRpFynQe.1AXW4KNp6YgN5AHktPdjdUlI6z
 9nuyK3uAEBzfKCyRYYPjAlhpNYiZK30BkL2mdOkMynzIHIym8OI32WH9CT9JQPa5MLP5irEi9bbW
 4dY60HHPQWNc4cs23PBAoMf4wpPon2loSaDNUYHeYIQxy.v9ybg.Rcb0BZXWWN6KDeVY_lcSSLG.
 CLXqsuAnU.9smOVc_O4UOT_zNEroq2LuHlqq1xTXcRV2b2bWxT6sJ4Z7U1e5F0g0HeqM8xby0y94
 Ah45FfK6kT8eKqh7LpIWVBW2AMQ312NCBC_erdE48RhVJZXFZGCzceDC4zEgr4Ix0zVG.uAmTHBw
 k0HQMcfePPPNde2bDp6xhjJwv3kvOP4p2JnTZ3K3.04eKTdzCRYnkxxN2dfDRhhyE02oVeSg0wo9
 uG81MdQ3nhVhK4HDk9ZMfg6jJ2_rWakAhe2zPF2y3d7SmBMcZLJuKynn_yCRLAKcRQxPfA8IfXDa
 hRW5wNWFTczrArUaYIq6kZcOsq.XvVJFJNinVbwcICNoLKcnFRCU5aHeS2kJoOdtw.IfXs1XMvyQ
 cmg1cTzkeiAjE87rcjuMEmnjEdPvg6GG6OuUaIsikSF043x3cn0CxVSJV5N1HpRvIYOgctaCu69u
 q8BT7YYRstmJdUQAVyV3Gid7jXGXt3La6sYvjpaE6JxC0ZE16NCMhfHNyYRSQrqg4PtFJQaGjiD3
 7ZhsFfEOLTqICBFDe9_mVDtfkrVIeb4v9Rs1ppb9fIGs8TW77KWe5GloppEwJWtIKYSW.HxhKkhS
 SrKDRuT_1VqkX3lFuLzFciTs6GowJAhi7pFqEAsVv6gr9aD9umiSoFHh5JM5HMo2dhyGS8POu5oB
 1XuHEf3zdAXgoqR03asxywwh0KKYIBgPgLpuap_FyH7GFp03DDppiC9_lBFChCJTBKhsvKMGbhwO
 LHolq3e9XxKhU2PoMymwQJXWefYDJYQH6KcwEIfLNWvuhoeRQjv2XOTNkCfztfOnzhwcPKvKNa3O
 GwSV40YqiDfqRdH9uXM6kHidGBDKDZR5DOfegNSABxo5cPkWOTCjmCgFTkjfvWksPFX31MYBRyyM
 odSm_5OdA5hHwa63Xosgovm1au6hXU0kpP0wCUkFpIbs8.bailVz2sMVpcBFkzEloQgC2WWTJQPb
 g73JwvS2tnN_wtR5KA2sYFGvg0X4vqFcdaKmjYuapFCfUq9Kj1XeI9PdDb65Ie3CHWwWGpIc4ZvF
 BJ627yIZ9ioCAIgdp_Ee1ARd8AEjNvzpJlM7me.JtBVkcpz1zkE11W7r7Zep2bzWVo8gOACueSKH
 NvVVerxzRd3UrQmmE1csxEeIKCBSrnGiBQMt_ZD04LUg9UtN.dK8tHvzIj3VBVh.T7o1kdiE5cOf
 FhNKQCJMJAuMMyrWDpbbwd6HzukS5qO1FOk3oGHeW7kL4.U5.kw3yDa9A0btfAyuff3L4SHRGSPR
 30UHB92_qgeOGabSQpjRprmAY9Hq5vRU8mfEJcX7bj1Px6wp5zS3TfnFt2D1BZXCnItqRtTZI8zQ
 OpJ6msaT2ZoVtdI7TrERUqY0I0phgKYec42XOT9PEKs77jlUOJdcpKhlh.s04KB84zectE0wYtZ2
 NDuS88zsZxGAYDJI_R4H3fbtkzCf8Thk0_gq4H.19IoZwuq4C2iC7DLVyVnBwQ5FUIHCN5LGGoFB
 EbPCxcZyHRqgGvRQLJuWdHFL49zRGF28AeXrIf33SESDF60Bg37HQkC2D0nAqdXsPMF_aMO_Mdoj
 IZ7D0Qg1mI3yIHSauyeQAxxHU1w1P5hymfRF4I.yNGnBzH16nrHPO.L4Gk1WZagRa2ynhQ9dJgX3
 8IMPkzFdGMZoC4B7L6uofbr0gBO.qxdrlHQJo4e_D7A061khj4ExO2iRNCqR7yZpkN0_hA8mqt7t
 Qbl2YOpDuStbCfm8uBeok72WiQhkOszU9b.jxdLpaSE7Wp_xznkUWRo9tWyS9qnocWq0OFeBH358
 sxAFOAUG6at5BXgWnO5.Nl8c6GJBAKUo41Unp6SAepVhguphdPtQVFao_wg2vadDru.1ClCbGIdj
 TkcfZkHILCEoW3RHr9N7KwZqiXEx9nKcyxxP7g5pdZ6MvEKf3UxipJ9D9ZbVXImoZ_l0G3qlXT4x
 J1Dxc3W5M3_89YjJnkSZd_ay1OQ3Wj7Gr6u.ugFK4tRX7NhBLfhAmhTe_9_rcVmWHv7E95ClWU.5
 caiODxNZn5KR7JRO5b8Wt3WkpZiopzgCrLiRURDFpFkOlc7AUuTZyeVHl_od7iHKZ2iAfv_PaNqe
 llZ2mkuOHkslZv0bGtZbsxLz79ZZQL_565dGtkPFC3Hu0GQay
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: e02f08e6-1b2c-4f38-934c-b416ca568bc8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Jul 2026 14:53:24 +0000
Received: by hermes--production-ir2-7b48fcd765-nq4q8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8e6bbaf75eaee7b5af0548489affa373;
          Tue, 21 Jul 2026 14:32:42 +0000 (UTC)
Message-ID: <c92de3f6-d6f3-4cd9-bc52-e0f11847d758@yahoo.com>
Date: Tue, 21 Jul 2026 16:32:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/2] net: dsa: realtek: rtl8365mb: add HSGMII
 support for RTL8367S
To: contact@c127.dev, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260711-rtl8367s-sgmii-v6-0-88f7944ddca7@c127.dev>
 <20260711-rtl8367s-sgmii-v6-2-88f7944ddca7@c127.dev>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260711-rtl8367s-sgmii-v6-2-88f7944ddca7@c127.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26180 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/12/2026 6:31 AM, Johan Alvarado via B4 Relay wrote:
> From: Johan Alvarado <contact@c127.dev>
> 
> In addition to SGMII, the RTL8367S SerDes also supports HSGMII, which
> carries 2.5 Gbps with the same signaling as SGMII at 2.5x clock rate.
> The chip info table already declares HSGMII as a supported interface
> mode for external interface 1.
> 
> Extend the SerDes PCS to handle HSGMII, which phylink represents as
> 2500base-x:
> 
>  - Select the HSGMII SerDes tuning parameters and external interface
>    mode, and mux the SerDes to MAC8 in HSGMII mode, from pcs_config()
>    according to the interface. The parameters are again lifted from the
>    GPL-licensed Realtek rtl8367c vendor driver, and again only cover
>    the tuning variant for a non-zero chip option, so the mode is gated
>    on the option probed at setup.
> 

[...]

Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
