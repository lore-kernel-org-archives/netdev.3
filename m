Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.184.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810287;
	b=L2eGM64PzeBRCewxWF5gs78fImCzzt5sfO7qn9SKmpxIxDxCjEwRQkflPbKL/HNbvEvS
	 1Dn4f4Z0CwPt5wGv2UQdORaJjHYMvq+aTFDdDGbQFQf4MlRTJdBtbXN8Offofs2n/a7jE
	 XwUBo//96foDSFtSkL4zRtqIEDhvVa87hBGgb/7lvRR1lUko6sygqe2r48NgfHxeFl26p
	 U8v1Zn+X2KpmESHEyX/u4MxIUbUDRfCFdvANn/nxa1Vw62/n3fjp2gUI0OngVqgKqX7IG
	 vslCK94pZFlqbjcpAthxQubt0+D0+LIghkvaJY7KSmX57BZcaxReDc2rACHkQ5gHxfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810287;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=Mi4QQG7orWcvWwWmuqs+32uJLQtXwgeStaryQ/QSxVU=;
	b=JfJPGklznHV4W/zxx5blqgs4ln4PpokHfw13o8LMgaFk9/kpKlWHB8DUxfdSrMeHTYRo
	 mBXD5XM6wQtw+1AdIZ+KMflfuMVhTyVIEXrEetfuVIqjo36E61N65mnOj4lnpvU8an8bh
	 dIJIaorVmH/1k1NOCyyzp2nJyA38iifcGjwDDlafcH1pM/jGNrbbKcRO9/MX7N3MzWS71
	 CuJ2l0E1T3uwOx3KiSuVRMPFKHWjsxsOjjBzeZQFF3GEPb5BXlsjxzGc4cvZ6Emn52Vvs
	 w3ckvAK//auTdLvEz1HOZDADgX24Yz83ypNTy/obzFWr2sfjXFXuB7PZLrdEMfsHqGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=VX84LlP8;
	arc=none smtp.remote-ip=66.163.184.147
Received: from sonic309-21.consmr.mail.ne1.yahoo.com (sonic309-21.consmr.mail.ne1.yahoo.com [66.163.184.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C0606A330
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 16:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB5C0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=VX84LlP8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793810285; bh=Mi4QQG7orWcvWwWmuqs+32uJLQtXwgeStaryQ/QSxVU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VX84LlP8als/vYh9Udx5++GrEvqq4bigyezmG3uNKGbL/YiHprgNgbo5YHGhhrVxt5e7p1mcNBMIolVN6i01kxXLmb41k1K7LIij8c5dytCJVybd9966YD7XNfF829t9+VjSQIXBh93IAgluStq6jgSZHPLzvG8QfpORz1EVDUJqSXPeIKsI+BnFDb43M/QT1ZUJjwF9t7txmvLpCwNhrj9oyBTcionw5Cb24UNkepX/7IVnXfRo8UP4tco2A1u+M4b6veifQYdo+o5PI+jfQ2K8nK9kSbmjYgRG0De/6SSrEhN8XKF/F4t8z7Txa9Z/sgCNT5T+RJrKBYVRowyT1w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793810285; bh=qYUnvXaavcBuNyoOttd8goyw3vXj3Z/AR33XS5E2ZEW=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=cAtwcI/PKGwKtwUHYe3+S0patz/sQIRN/C1leqs0ax+84nusxeZ4QQUfpOvBt6LWiTT+YSJteRKTbzeffYQjo86CjseZ+GnJqLYiQCicqy0PoHETer4IiGaajyxQtyw14GZ6sUIuMRhVMssaMPRl7tTHIMYTeBkYRsY9WBXqb1ciHk/ruJxvjnwBZLRMbbH5e+/GAGVS9L3aThpsPB89ExmeMN12FDxdi3jCtGc5M/qsX6RXMmtDcf/B/sHuYG0+ndvCMt5DxdZqIebBQkgJoxRPngro9106ooscMPiXZ9ukkGZigqM/ioe/U6vmkN/bBxTv/wl3GBCPV1PU2TCODw==
X-YMail-OSG: MTi9xMIVM1niHtteKsbY9vXwYKCLiIarV9jqANVdKjs_qA4AuqduwiRwuGPOlJT
 4.9rG.zcNwIRhWklHRzAlww3mc5OdQq4RtvOOyQGv0jaJppT5nCCHFN8PecIDr5.YiCcu8Rx6ELe
 xw7tF.0FH9ovfSXD8SLo59nybGU6jjAtPXII0NCUdv4fErb2SxN1FoBqCAx1yzLB0v6ktaYdf4kY
 7Oyn_gzeAX.vnJJLCYiE_.0LFfm5f1PquzMdqWCobG2CmdViBsmrb4SiUX60hQAJz6eGnJyD3sXK
 V6iDeC2isxXpmEKgYWL9iIZl07LKUf3KuWdAYYEmZicCjBAqeHM42Kr7yZpaRNsFLmeMQnZJyots
 nS6Od_3IgxosRdSfvtdVIFpGkVpz9ohlBmDhe8fVJwlcxM9aH0WCmZNmd3OO.uwOexqru5gNOxdy
 XZ4InAipiLmK6GFw_gDs5wWR3JxX2IWuRWoXzIPtmsS2pzVNddvrVBegVlHdS37ggQH8IhW2Qvnr
 h13T1q2_9NRW4hVkDUhJ7kiOjDjvUG1MNh3TMAI1MCujBnbPpyAxhu_.n0uIOfTCAsCtwppJ1w3R
 WxSV.d0UTsVDvJWVX32DSQ8sYRV0Zp3Od2h03fxdPpIRx0zRxd2rtK.NZ_UV7C69vfCq6omXk6tR
 fwje0QrKm5rbKXSiLpLp1r76uI.8XFm8dFCw.efMuC9Jqm14_6AlmTHhPp8A.6ESkXHVP04ZkKEX
 p0RUbrQT72HDVztMD5h5NjQalh4U5O2zYkC9UzlyDnR_O8sbNfOopLjGyJLsvkMs7P5HkB.E9jpQ
 byaQO7_RMjqfGmZhwsiVxRQeLSqLPnNTYG92NDI_L9Y9TgaOjRFsSd5hINAsFlLDLmn8OViTRKx7
 4C9W3QD1WFO24M2uW_DzMAauaoiPsz1E.j0I.JnkgCQmHHA8hwD1myfS8hTDY5b5wEpEaXJ4V_zZ
 jvnMkHK6mgksYU73Y0_4bTrgy0leETMijirKoBJRuLs7MGnrK1n4Orfi.sIlK2EMn480pbF1y132
 PUivLfeY79quujE_naHfKTHAb4j7lcrzQb7Rljtn4aLJ_q65ssiXK6ljhCaeCTN3Xt1W.pVNaVSp
 DdBuqHQy7P.m3WsER9h8I92fvLrjApxmfmwiVstPkfMnkHhBGsYycU9bx3NtaKX6kXf4Mfkvu9EZ
 1AgCbsfh.fxVR54s1yHti_3.r5q5j3o4Ic0tTdVthDMgzJ3evtZdsiwREQKkJuttjsPXGVNxGznU
 owUnZPqJ_GRV4tfvTqH0U05N_NtSNmbKq7KbE.cOEqBKZiqhD6y1X5vCsRdaqlYCwfWgm_uQYqZm
 zjfXULs21f9G7ydCiK.Qlt3gtfnMKk782FswB398FhqB45XFO5iPiUDAaDS31AR9QPm_DE84y0oM
 FMGWJ6fK2C5WBBHvMEWKe9W.xnEZdFEGg29TSWUv9btLvNCnpzY30k.n2230bqwkKw7bTpLyjQ3u
 l7rIbbju9Oqr0PnvRvlpwo1DJVXf3stOmQ1Ee96_B8ioj0iEHq__IJO3rgtUpg1y8jUPDklLaoq0
 zurrAs6Ypiic6d4RrScoafT5ZSvUSpRXk5BVqMO7K9PEgeDPeYVtjR.8SHn4GhrdcQDbuToFbA2l
 avUumXdrg2dnpKyZY8Lp7kzi6KaR_7HegnP4.U0Ktv_htcrKx7aExohSsBJgj9KHP.nXbLuHNlVy
 kYLv0ihTOIlSpE36R7arvH4dUjMSSslOsivGoup1Su06H126dBv5nhd_HzYnaG0v6z_PG0tnCwni
 5A1l_9kkk_F1Zy.oO3vphuC7w2tE0PKPaZcljXrh7_p8mv.eiKv2HOgzhEjpxatdgKvSs_.cFIWI
 fGvbxsOJDDbuc76WtYRTfjZPitg6rX7CYgSc.s8HBI_0gf0EPRg8Qfw_cWU.OK__8xi6tAgiuvTS
 MsNSgM.v.AwbVNSkc6ng.wY6T1SCC4LjUv2XF.U8XwCK_pbA5tu2KI0yxYdT2.n8FPqiSEvU2L47
 xmJxtnsdFiz.H6JhAG7FX4vH92mPGTejFrqgGdvpl1aaw335JOGt64c_CEByE6tln1qDhI0z8PIo
 At6WKO8r1JhPwMsq00U81LHzaBaYE6Rc0_Myk2LmNAMMoTnncerwG2W1Ysx4KIWMBSUjmiSsB.2g
 gluS_jnOmxxuxTIhXzW_rVjZlsDbaAIx5sOF4TxbF6XpAx1S_PCAU.fjY04u0u6XkGeKputBbEDN
 J3x.NZwqatQxdcRGSyBmn1zzQ8V_fX0ke9tDQTOywdrEC41fC5idr1N.grm4NyEieW_ISN_zhlsY
 dC7etPmLxrWBCottlu6pauw5cnUswMky5.a6J9VSJfy26
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: a3f78b3c-27a1-451d-ab27-63e5d45760a6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Nov 2026 16:38:05 +0000
Received: by hermes--production-bf1-6d6877594b-7nfrx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fbf2f985ff2a2d8b5a63626ea4c49eb7;
          Wed, 04 Nov 2026 16:38:01 +0000 (UTC)
Message-ID: <0dcbc902-30c8-41f0-ab45-992c8fdefe13@yahoo.com>
Date: Wed, 4 Nov 2026 17:37:56 +0100
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
Subject: Re: [PATCH net-next v7 10/10] net: dsa: realtek: rtl8365mb: add
 support for RTL8367S-VB
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <c7f88f0e-b174-4715-b148-5f9a2648bc2f@yahoo.com>
 <auph2uJLrJ6Nj0dh@analog.com>
 <6c6155f0-0431-4ef9-8067-dbc104af710e@yahoo.com>
 <c353d13b-048d-43da-987c-3b83ae6e19e9@yahoo.com>
 <ausr461gzl1pxF29@analog.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <ausr461gzl1pxF29@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26871 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/4/2026 2:14 PM, Alvin Šipraga wrote:
> On Wed, Nov 04, 2026 at 10:40:11AM +0100, Mieczyslaw Nalewaj wrote:
>> There is one instance for family C and one for family D, and the chip
>> table entries only say:
>>
>>     .family_info = &rtl8365mb_family_d,
> Yes, sounds reasonable. Starts to resemble how mv88e6xxx does it.
Thanks. I'm glad we are aligned on the family_info approach. Since I already
have a working draft of this refactoring, I’ve pushed the current pre-v9 code
to GitHub for early visibility. If you'd like to see how the family_info
looks in practice while reviewing, you can check it out here: https://github.com/namiltd/rtl8367d/pull/11/commits

> It seemed to me that VLAN would also benefit from being split
> out somehow. I already tried to structure the VLAN/L2 APIs into somewhat
> high- and low-level implementations, the former being accessed by
> _main.c and the latter implemented in _{vlan,l2}.c. In the cases where
> the binary format/address the chip expects is different, it seems
> logical to then have different low-level implementations depending on
> family. There might be some code duplication, but to the extent that
> it's just incidental (e.g. 50% of the stuff is the same), it can still
> improve the maintainability of the code IMO.
> But if there's also extra steps in the sequence, then perhaps
> it's better to avoid an if (family D) { do this extra thing }, and
> instead implement a whole different operation with a little code
> duplication. It's a matter of taste though.

Agreed. I will look into splitting the low-level VLAN operations into distinct
family C and D functions inside rtl8365mb_vlan.c to avoid internal if/else
checks. A bit of duplication is definitely worth it for better maintainability.

> I would encourage you not to send a v9 straight away but to discuss some
> things on the list first. Otherwise it's easy to lose track of the
> conversation.

Understood. I will hold off on sending the official v9 patchset until we finish
discussing the remaining parts here on the list.

Kind regards,
Mieczyslaw
