Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.185.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892456;
	b=ed5Ap+3QO4FTEeF24ghL89WTthYJ93H0/yjZJxBxUK7+EHOi7yIvoXjc/M2eL9rATMzT
	 Q/S384Or2xaPI4O8mo0lMzy2vQqq/3YrHlMzWzyOvpr+mTM3Xf6x8Oj/hxLUdIZgwIMP4
	 6AnwBt0jRnsQti0nsXcJlXSNwy7zplefOKqcIxUo8bqVuVk9rSdePfxKQ7m3pvoS5yRQT
	 17WX7rafNbc7KQJAJVxsqRcqq3IDK2HPrnZHqY3kiF0JnESah3AkysbB1c4hCnUlpQVVW
	 hsHrR3LLxp6Scy3rlpX5smXKCISEjIggLe75Z7ChXebw+/E4itgz5/0tsYwkNRz/yBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892456;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=F25zbrRYQ8DfmWFmcox/lBxkdydxYVArfXbr72jFMJ4=;
	b=yBIql13LRMdhw8HTQVa23PFGJHJGY3lxLgQ6YrU4fU3tDp/+VsQIR25SEwyTbPys/QQ8
	 OB5Gnyhsre9rrG0zKvQX0YT4rzi5y7niCvMiyJcd3n5+BvWDJEbp2g1aqv0gTSfEHgJKc
	 UmG8XJPGXXUOgFvNnAMgU5T7baofYplZlnuNA8QqSPA7OqTieFi7JvPgrRSu9zh1wjsXo
	 DSawa8yliQUbIZIX0xEhPlphq7I88ZLEHYcpMXzzSxz+V8J30y/qqcVad171zjASKSCjO
	 /r6GyfWWRj4ZvKYhb05Z9Zhm+uHhWPfrFBPw2Ral9GUFl7zDa0jF95IAXwE46K3l9wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=OiqEvvIA;
	arc=none smtp.remote-ip=66.163.185.31
Received: from sonic313-56.consmr.mail.ne1.yahoo.com (sonic313-56.consmr.mail.ne1.yahoo.com [66.163.185.31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC24D606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 15:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC24D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=OiqEvvIA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793892449; bh=F25zbrRYQ8DfmWFmcox/lBxkdydxYVArfXbr72jFMJ4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=OiqEvvIArU2s9y6QL9DhQomS2gtFi2lHpPe/LVO+Lf49ABGfA4ewXnxJMq3nSD2AmNvxYEQ6RpLzMtKvhSO5WHhorEx14J6jUpEfD5k6qzEXY0RHQ7aUKcGUqqYMYB1O0HCajWLYsbrXBHtoF8sA60UaFD8sv0EX+KYE6qMqwjBV2DQV8Rh2SnT3X1sv4ff0m3kH0TjZs74E9zGgg6LJ9hkSI1MJ3ADjjRwZDQKMoJ5G13Odd80IWcSHQnpkESYqZZ2kgm7ehrEzLE8OxJXx2SjKH8AF+WIwwtJanOBtKPb8pcPg8zJm0rbic0cktY2nbKXMvMQKd+EIM1g4CB8kIQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793892449; bh=02Paj9COAmDq8/NNdJC7OcDWLUscjr45yBqO6zmH0fw=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=oRIy52rYouS80bmELgWwePTdT3gGo0g6rvuRFQmdcs5/a2SzuZ64bIVPZ2S9pS6iwEBoBByFuOtBFwRd8D6LtJRJx0w5JPFNw5cHhTWN0+OsVZviaNK2TuQdjFxt+gHJc3CLEUQmT+2/SBnLepibyhfdBBo2naQcW6jBwPTAuklYdf07AAQXNeqSOQBnl9wgacZoy0U+hvtSCEic2802oABgh1cYgieErxxzO5CRC6GMZETZoizEGXQh1rC0TAD/gUrywHorGo7Ns3z2DHN5hMSVnxaRfnL8atnA+BlCEpNSAkYJ3hpL3Y/DqunwKD1NpeRrKdULzVmppY7rEwz3Tw==
X-YMail-OSG: E.t3OUgVM1nzEL1C2tUlut1A0RXjkMqTqqDYPZdyoZBDdMc_V5DrWjn3vMb0_Fz
 itRasVl6n6xADHS7PHTrR7NuVnLQLqF4wV0rVOiTLMZ7huPDaHsoCvsfgNKG7R6Y6EMAshs6Ki3v
 ccQsFyt4Xwu2ZEjRQ4WEp26HIudD8h6W3mzH48mNDgTImNqqJlmbC2Opf_B2bjIDTR90z6cudua9
 3ckHbhbtx3Y32bZD0Pr1XGhSgsIKZCmDOp4C.MA4M6uzG5cIJV9irmt1bsJsGCijTed590StpHzn
 eqUFQYQK2JV2X_PKstUpV3BR9DMt9yE72uZzB0hlyAHI4NRYTBm9le4g0EoOtNiN4v7_zHaXTxmV
 2WyWxGAXWBqFj1VYKPCQHKxQfNeSqFrQztu3miI.9jtF5kH6l5b2kl2LntWIaD.aS89oPDTWbRU2
 cIbKbXIJk.yvZ8V5vuC2zlma5ilO7k4qOp8xeszqzPFLklQeAA_OsU1oiJ_0NymshyN3SERdwjbR
 hyc1yB0WsXkFLctnjePgxQYyhv27pg6wTQgEt8slWED2ChpgYyQnNYJ__rEZ6u9CXhmxatV167Tw
 pu3u.UH6LU8P0hyPTMTOnPu33aNid3fA_0AwmFM.CsgEzAPLd8k.RSE.xau8EntWEDIs06nS1gdr
 38KLk7lp10YVo3AB0r_USPROf6KphEjzk03p6nhdi5VmTMo8rTdJ4LvEc8hZxVvJO.uxgspAsxDu
 DWmDbcsSltFAgBY83tXfHGvRhQkIRYzDqrEbrR1J0p4OVod5Q.PuPxbKWRtAhEeYt3bVy1Lsg4gj
 6EZKjPQ8O3QRCSpx.__tkwHntVsmJ2JzTWtdvlE6xGOTwoy9xPnPKQfzjOtS8zBBbEsi4yP6dlYm
 C67iHUy7_U3_vHfMpRn6ZkpSDL_koRxfJKM_Y_KrvXoRWBGgr_S64KOlNX4M2dISNBH0Cdmc_NXk
 lXay_ahj2J04AdBWXtACoj_BAOi01BjYTeNK7SFqe7Ew7fhvbI3hCejs4K6UIbsWTgZk8knkm9XL
 P7gAtV6LgQdapvqRA8SL2knNN19HLDJtuPKJl5X3aGgeHUcmsNM3DM1w86Eoew2jzq3IuHFvBDtv
 MKISsbSNpzTPlQKw15AW5zQONYvQyg_QuaVUqyUyJB3z.XpUGtpLL0DQMtr0agELyaEw5d9D_tne
 zeFzbRsn1r2BxF1dZacs.ZreEDteuCm47A.heoBYxeAuzGxs1i58aHGgcShm2BSX_fZQzP.2DOIu
 SRJyZnsjXER0P0fa1ITzBKNrtVZ3cnwz0EdU0HQOKcMApv2mBgCZH1SISJfhR_VxqRV_KXGx_04L
 HAcq9l6Sfqu4vII_nT.qw3Y38DDDG7MbyxipiRSHHr8Iv2.CyC5b4Yp3HQ0Uwr0hGr2YtlKDjsrO
 _xvOnBsPsTn2oHd6jC_AJFhdXRKhWMrfalX2gP0AxYGYIyVEuZyDtY92uk7NQ72v7RlACmki2EDo
 U1oRfOS5MEnW94Mp4V4Yr0bl5.TmVlOflyMVvOupoZGn5axeDIWK8R8Q3JkyDzg_zmU4jSxPhFj8
 NM6DYMEljAXdQXHxztPQuePFz5SCY7WRxvO8R6EMcbT.gNigUD_he5JbmJ0ZTNxk4nLH.LtzGat_
 SAkCGOY8XR5mITEb1QgmT4cu11PQmbQNhF6VGvnOYqXWma_bKhsSJrJaOHWp_.MZQk7eWAwAX3c1
 etcxruNcFdgbnDji7wJtZk22vRW8uA4ERzT1HrYMlvHg4Lht_wwWImAs_gugUqJl0v0jRsZ8_6Vv
 EveBg9XGWRD_osH3gploItTaUjFcRUh8rbNi.DX5X_ckf4U8y3Pxo9HJKf6ic39qvjftxjbWs4HN
 DSP7MMHdrTTG1Uj8Fuph5gCqQiCX4JkEAv0X9WZT1W7PMrbgAeJDAA3FjRT6wusiuRyZHi1m3Ef2
 _ix1FoyTqeKPeV0oa7nxMy9X6Ug8D95sAN6fk44B09fC8Cc2M1M.dwRmeWy8jiABNKItcjmfJGCr
 3a6Ep10jsHIeTVWRWR.f0eg7zLop7WgQotpREjzGNW_N6z5dDPRBua94xxEDXXF8tdRz9mTwSMaa
 4TnemkmaQBViR.6U4cm.En6u3WShbHvPELltZhIhZ5GyuC8FbO97skXoSQ0HLZBkUgA1WRUoqUPz
 uOz8CZyQbVHIC0IRv75lozP8JExLeuVUMv6BPZ0NltgseLtt3ddkjlVsqOpd88QJDUhdPgs3nlHo
 .uh8jF_Z9cR0uEiutMhpYj3Hw7E1n.wULP3PzLfFSJA_frxrLTR64u6PjhRm.kFYaDpilKv0fE6f
 SoercykQgo4gj0kujDSgRmEjMwkTCxouT6FnXrwA-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: e0425162-394e-4926-9578-e60353190b5f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2026 15:27:29 +0000
Received: by hermes--production-ir2-5dd9bf4598-z289g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8174fcee853681a34dc83a7ff3f9c0ff;
          Thu, 05 Nov 2026 15:27:25 +0000 (UTC)
Message-ID: <e66204e5-ac33-4a35-8d36-6f37372da97f@yahoo.com>
Date: Thu, 5 Nov 2026 16:27:22 +0100
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
Subject: Re: [PATCH net-next v7 04/10] net: dsa: realtek: rtl8365mb: set RGMII
 mode for family D
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <2befac48-25eb-4c1b-9632-2f3237d68a3d@yahoo.com>
 <auskP2mSY4sCRa6x@analog.com>
 <82c96971-be5b-4c11-b20f-c4b074181515@yahoo.com>
 <aux1v3R-efbWF2GD@analog.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <aux1v3R-efbWF2GD@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Thu, Nov 05, 2026 at 01:39:53PM +0100, Alvin Šipraga wrote:
> During your work on the D family, did you find that the vendor driver
> is programming the same values?
>
> One thing I'm wondering is: for the other C family chips, is some extra
> RGMII TX delay being silently added by the jam table we already have?
> [...]

I did not diff the vendor family D init table against the family C one,
so I cannot say they are identical. I only know this register: our table
writes 0x0090 to 0x13f9, which leaves the EXT1 RGMII TX delay field at
2, and the vendor RGMII setup for EXT1 on family D clears that field. I
do not know what the field does on family C.

> Anyway, if the jam table the vendor driver uses is indeed the same for
> both families, maybe it's best to keep it explicit like you have
> done.

OK, I will keep it as it is.

> Do you have a datasheet I can look at? I couldn't find one.

No, I do not have one either. Everything about family D comes from the
vendor RTL8367D API.

> I'm also a bit confused by what it means for MAC4 to "own" EXT1. Are we
> talking about physical pin muxing [...] or is this internal muxing? And
> since you say MAC4 is a UTP port, I don't understand how it can also be
> associated with EXT1 [...].

I cannot answer that. "Owns" was my shorthand for the bit. All I have is
this check in the vendor RGMII setup for port 7:

    /* Configure RGMII/MII mux to port 7 if UTP_PORT4 is not RGMII mode */
    if ((retVal = rtl8367d_getAsicRegBit(RTL8367D_REG_TOP_CON0,
            RTL8367D_MAC4_SEL_EXT1_OFFSET, &mux)) != RT_ERR_OK)
        return retVal;

I did not verify anything beyond it, so I do not know whether this is a
physical or an internal mux.

> Since MAC7_SEL_EXT1 is writable, I would guess that so is
> MAC4_SEL_EXT1. Could we not instead keep it configurable, and do some
> bookkeeping in the driver to see who has requested these pins? [...]

The vendor code only reads MAC4_SEL_EXT1 in this path, and I have not
verified that writing it is safe or what it does to UTP port 4. The
driver has no code path that selects MAC4 for EXT1, so port 7 would be
the only requester.

I can implement the bookkeeping in v9, but I would need to know how you
want the MAC4 side handled. Alternatively, I can read the bit once in
rtl8365mb_setup() and refuse RGMII on port 7 when it is set.

Kind regards,
Mieczyslaw
