Received: from sonic308-9.consmr.mail.ne1.yahoo.com (sonic308-9.consmr.mail.ne1.yahoo.com [66.163.187.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4B036E460
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306358; cv=none; b=HLsx5M8byC1bQlTHZDy1GJFPIbBlaRew+uoFZrrpJuwMVT5PrFf2YiLUbceJ6alNE1Yg5Cu5aNUY16ALXSLjthVavukEIXkuImA8aTRvQQJ5MfskkygtvD8LWH/KGlGHy4wWXCuI8Xc9Dr5mnMAA6vSlckhC6dCe1Uf1Zou16Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306358; c=relaxed/simple;
	bh=N0VwWNgjZy0nKc8IV1CYPC3YH6HB+OUZAGcyU3UMKhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faGv6oDhYy3jxp0cthoy/CmAqYllDNfKL7U1bV1tGWPKwA2DF7PFKoIT8XvxyImI99t/amovD36KNsydniJKKwSvNM8QupuFOWWBxvVHX9vrUwo4eMkgXw/bzc4FldmRfNegiZccMYC64WT3thkrUKK6ucGnrilwpfBww11Ikjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=KKthGCAK; arc=none smtp.client-ip=66.163.187.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KKthGCAK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1784306351; bh=cwGcTMGiq61hH9s2A9DOJFHP6CDdTNBniuBE9pnTs0s=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=KKthGCAKsUBZQxDQWK113D5oGMK8Av5O2jO1czrd4vOAEFqyss+FfIiGRpHM29kBeouC03IHbA2oxZ9FFV4VVfvcYpJYCdYaU2w7wCth8H4iOPSAG3wTc+NRm6+VGcNl+9SeWpWWXwpfzVvWO/AvXCAHpynw3YEO4jO+HqOd6h3BE/FPlr1AJJX6ckhYAhWRDkPlf0lYlNRUZ0svxtGg0Atm2X3oIUvO2RiRoyqgNX7ZuBCoi/JSH3sy3QWTMKWL3KdKkUrgwsqOm8IHs1VXu9wPjH8e8tnIVLaRBvA7YVxq1TZnrwTXgaqDKF25gAMx6XdpO2jzfaRweYbhOVzLkQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1784306351; bh=HAa5IRr8U1KnsFoSeLEqC59EJCQ0Q0szhhFE93jT5Sc=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=mSD278HaGDXnl/tcBVVeKprsklnMS1pj8Jtj8/fMjOgWuXb/IB3kIdiTOXe9rxFUkih3VoH//DEvBBiC9tTOrFTs4B2XuUuya4R6tzS+XTiDPXAl3N6MQv6LqaGlut71u57q8+6tZYhTLV+nS8yvZuS2OkdR0+/TQ/CJIn8us4WInr/jHOslv93opsSjifNAnPTXx2pVl6vKmBj5otbigMUc6T2umq1WIqCJ1eHNx7rCXGgnBRpQ1hPmLJRoUKMM22bCYte4LuKInSAuR9kUt96YSXk5jpEq1sffGuk5M3rJcS+Sg6pEnhPAe97HFvM5bzwNqB6i77C6ntgWXggOVg==
X-YMail-OSG: 95UYLzsVM1k9bJ7flZNuJoo9Ax2dJEds0iITHQgS8u9Q14C60kaKt_5uYP5hcVW
 rzfMknNbEEOPK2rxmIvE8HPO3okH_MueNFSzfKDb76krSyrOi0tEEUILAxDtf5ptNezc0e6ptkyX
 4T08a33BTzv5uz_vB6Qe2Kb_f_HPFtvv8R722v6giR9.GBUNKaqIuPb2vmo8Z2Bvx2Zxo_uiVP7U
 lbinOeBNWBhmzh7Rm0MiqF2w4cAOPmEGyrUNkQzrd05J2qdiUDxJ10NE42LhEv9r_OQo4QKvBgI4
 YbMEbKnqTLSQ3Ortih.AqBf6o249OBgkXNUWhiXIHM3q33Kn4ldzitf4uM0lAQS_M95BvkJ.drnm
 L9Uk6vji3DPTBmSShGux1G9mH4smgCh79p1RJX9RmNgQGQ1ufNVSXAB4Cp74fIaUHP43ldzP1hOt
 k8QuCCDrU0w9U8TFMfT8ji1wKa5L8zNpY5cgkt4yDlMcbyjrHO92oA2g7JaOwLA6P5ujIeA6jikO
 wP9jYjsOXWfqdcKq3_6106nnEjWoDVPJii9zs.FT._dBMUEtBBR9R3sA0KlnQmV7YdOhcszf2XAV
 hwEzxfPWTGWpFJh0AyxLTMJBuYfyxrNYsw8Rm1H5g3O7BoduHuvcyKOD4j9rHvOhHjOZLAh0_x0R
 hz3KXYQh2u8Pq_y.V_pbdyodVQApbuhzTv9OajyB1sLT11nUdeGbhrOiboos8Wr0_257.bQTYzY0
 driAt46ZJUbqs3OpjgUN_a7JF.Wqsv_CxmZxSAvf1TxI6N.tWI6SZ7WO8FHlzRNEGSaCDdSFmPmD
 POU.b3fs0WcbzYgkjO66rYgHok1.zQgbHGv3xYYOO35w_F74FfKpC_UA3OeseUB2D3Rh2F_5QmI3
 b877jdPzMza8GTVSbLLkYrS1Z_lZgRFhVbf1MN67tHtbPXzxcAOaAwr6Ki_5zYxq7YuMRpL2htwE
 oXQ.lY0fpqHljjNi8IjZzk6MUyjR_C8U1BgjMXtk_QOVsdrX6oEadiOQcTKXWFz58y4rZI9bv7fm
 HCjtWckOYrEYPyzWM8W5veNG.KjIzwTH6GlX7epQK3zSP6M3WaP_Yoi5PzOWELE6.o0NxRbRFNd3
 .ykFIaz7OnI5FzAU9cyUfOj3oI9XCZ_fzSI5O5Sd_4Zr9.3NMLBC6UmCYsJbk.3KrKLRrLumKKCZ
 ED.PgaoTE.AAowbY1lVQWrKFoHA8i6ynQl1zjzJeWiAGqYJPBmvGypVI0cN5K9KcAlalCqlv2M6k
 QaY3TWYnbjYKQVvTUL1GtUkjPjr6jUXR1GCiJlAX_.HCPizD0Y.rlMqJD5WJBzflBMGzytXNEeN7
 WYYIto.OH10z_w6A.VMNWEvoqc5lfzpGMf6wZbcYeai_LEvYisZvz5qiorE5VWc7wYnA8.zQoxlR
 eJC8h49UjUTPEl5Thy_IsO.NiAFTtlF.QdkmLh58vWbVrxuH1dmelIjPZgEwTZ3ZSqqNihKtvSOn
 5eMVcLXn3va2SydwiMwxDW4kRVxMBM8FBb82bxT8af.Pe_jEsEOcy19SVis_f2jnSpkQkNaQGXpa
 WrNRHZxDC17AUul74BiG4ri43.B7l2psLJ5WmdtmGVL4zCFsi0LgNg1tSHMcgJDmTg2SAbnsoca2
 wbuME7.UT4IWOsH55u96yHdKFkA.ZAA7ftpkNF4Of5zkhp_sx0sWS3oA9CbHaHs3o61Ye.C7ym.B
 vmmV2ZxZiKoAirnvJ1CQP37wrHjOTz..P45Is1DabjZETFvZHPZD79k4UhI5y63EVeid7MkjnWQS
 DIYcr6RHgZwHUTTB.g7eLmCqXhsqlHJtcUmM3RJqA.0QZGn168y6QWFg.E.ifU86jzqdfq.rVaDs
 iZZk.U7K_hHFiTNASA0ryX_FxU2Dg_Ey.k0E9eT0IpMzMnynLDUVXpVhpZdA9vq4fmHX39.0Rgoc
 4CaWF3PpWloA1TygVxdweNGhOL5CU.kTdHOyPZ4mg4thRW8d50MoA48Ifm3wcmZ2Nx4KHpVEYUR5
 Z03IfRZ2q1ZFntpn.ny.mERrUo4HwEqd1wICgcIYx9zXlR9_YVeqnCTbEzbcPkFYmHEYmashTtyg
 3nJx2Peog4FXhvQSQ0nHpBzdcL9gPDMAJmXul9A.tMSClga3CjIQhb9MW8mex6mvIvjKNQA9bvX.
 APS98R4Gbwb_UjaZBxG7ijc4NFmF_RhmKF8Hf1iru34HNIr18tpiWM1uNY5i_BVBhKzck1siuvsF
 V.rhCTNhr1EN5Nw4a.oAJfTKNfcF7XbLaxsRQDbcb68GePBwgHjBGaRI0tbuWeIPSt2zLW.VapTh
 tMSMuPHHjgcq7Ww--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: e1ee4498-727d-4dbf-899a-643e7a519c90
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 17 Jul 2026 16:39:11 +0000
Received: by hermes--production-ir2-7b48fcd765-2dqlz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 777a421667413e87978f9fe8af41bc8c;
          Fri, 17 Jul 2026 16:28:54 +0000 (UTC)
Message-ID: <1251f969-e6f9-4be3-9554-1fd4c69bf137@yahoo.com>
Date: Fri, 17 Jul 2026 18:28:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/2] net: dsa: realtek: rtl8365mb: add SGMII
 support for RTL8367S
To: Stanislaw <kuncy7@gmail.com>, Johan Alvarado <contact@c127.dev>
Cc: Linus Walleij <linusw@kernel.org>, Alvin Sipraga <alsi@bang-olufsen.dk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <e252cb3c-bfb2-4d62-aec7-e04b9aafe223@yahoo.com>
 <20260717125155.18915-1-kuncy7@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260717125155.18915-1-kuncy7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26136 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi Stanisław

On 7/17/2026 2:51 PM, Stanislaw wrote:
> Hi,
> 
> I have been testing this series on a second RTL8367S board: a TP-Link
> Archer AX55 v1, where the switch SerDes runs HSGMII (2500base-x) on
> external interface 1 to an IPQ5018 gmac1 (stmmac, fixed-link), on an
> OpenWrt 6.12 kernel. Some cold-boot results that may be relevant to the
> calibration discussion.
> 
> Test image carried, on top of the v6 series:
>  - the SDS indirect-access busy-wait fix, and
>  - the ~98 ms PLL-settle delay plus the 0x060C-0x060F "Local Jam
>    Table" analog calibration proposed in this thread.
> 

Please repeat the test only with the fix "the ~98 ms PLL-settle delay plus the 0x060C-0x060F Local Jam Table analog calibration". Only the result of these changes can tell us something.

Best regards,
Mieczysław


