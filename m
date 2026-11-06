Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.184.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976993;
	b=XAsCVlVJEWbeXOpt0Qi/wD1/EK7gL+aVP49nC1wWjM3My1qTDcLbpLvyvJRlmyC+mgzR
	 5CwmHECxkBynM3Ua4ehv/T6LIVibszqw4y6Jq0JkmOZozcSL9Yy7WSZ2Ll5L44FTPn41f
	 MJX1ifWakZ+ok0fsxCeftIAUBrBKOP31ap/Lmz+wg5fNuDAHrJ6yqkdFvcWEbz5zhN2qu
	 W4eAusz1KxuOmIZcioSEqC8HAfn4FutjD7hGRAt7us9qVP2POhUccqNCO3eR54HAMvjxS
	 fcTuIXtit+wRfLiN8gJeIvkrsLP7NuWKIEglpqznCthecJ9s30vF/sRbqK7+m9roLQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976993;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=jmWRlBnAqOIjd3WBSitlZqB6vkVKfHc2pIRqt8YMYQo=;
	b=F8dwJzEPCn5tHTf/OPLRdTNCFCAf2fXCTeiUhg/HheYvSeVFzo4iSxu2yTevNjcgDX8A
	 yd0gptEbWcN82dF/JOaJ3WM/Rm+ElzKLLx6Sqc5JN1PJJYj6Y6o5TODiVfmy6sQTL1o5Y
	 +L5kJ9OWQPl6Z5PoAe/vKLRQ/c29k2KdEfH0yuj9XeqLiZrhLFJRhTw3/JrJ5NXBVG/1P
	 mPqWRPoS9mfS4BQOpMFMy9JNfcA4fWG4Gi3aPUUGVJ4OpBBdLt0GF2rPhwYHtp5Yr1aV2
	 v5UGMeCfcCyUoBXnjAEKIewfK8Nh/YsuZI2gokVDrUbU8gX3sIBzFPMuT7VQeUOHbbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b="DhVg/qvj";
	arc=none smtp.remote-ip=66.163.184.200
Received: from sonic301-31.consmr.mail.ne1.yahoo.com (sonic301-31.consmr.mail.ne1.yahoo.com [66.163.184.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBDA606A32E
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 14:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABBDA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=DhVg/qvj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793976986; bh=jmWRlBnAqOIjd3WBSitlZqB6vkVKfHc2pIRqt8YMYQo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=DhVg/qvjSCMJk8fT2KIxPUGsfFQtzmRz2ikF77GSTlmd+jKzOSaMrvCBsmqOtYv9CBwhtikZNsFqGefRJzomgFVvrae6XPK0y/RWPpCjnDzRKT2SPpg+t+eJZq66S2OO0IVTLUDxLjrdpH/hRxHdRHhTnXRWO0UqlwyzWktqsIDhkDD4PRHJZzhXuKmQ6z/+QUFgahr6xyGMUAE6Q8hqB1wDK4G05e54Qk3WdSy+0gAVgyn/19+MbZ3pGhta1+rZQl4ctg+WPbuq+4x00UYhtgz2CIgO2qbZwnwdYIUsGZFcmwtzS3sYCjVgP1TDfYz4y1Lt7N3R+pJ6jaXpaJ3+FA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793976986; bh=YGIKxgblT+cqE0c5V9AUKB5jFtEx5gnrcU1pKYKZ/VR=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=dPtX1ed+RMPotLW/JvOcd1DOXcBpbN7XhJL3fgbX8SkbeUjmgf8V3dYLksbtCnL+4DTVdJpP+U1ibohHDhptP69e/mgjGlsqin+wQtWCL6WnMgA1Axx3IWJWBqMnOT2jIlqEkTMkYKnge0sJaVDWbBrNMwXYRrKOstqw+ytNvY0RNS3sWXi0hgSg6khvRbJvx7k3NbIe9+AyJzRr+v0kdDUsANTYWV5jCQF/tShsRxsAeoi1/WFbtgAfQfWFZM7OBFWSGErxLWtP7wctPy7zS/3COapoWbAKyqyDcmyR837aJtn1Nq4m8YSTir8dOsnOitJWXnzFI6S3mn19yRhPbQ==
X-YMail-OSG: t5fjkM8VM1mN5dB3ODLAW7X92..wr.jwAONPb4kcmMqFdd6_GVNA7qU7WrB0FsR
 1m1N3UJQd8nJExtlnX5FujclGyTLzWm42eyEL03xO3NFb_GOaCXOcT81tKH0y9_W7APT6o1BF69r
 qbF.egUCWLs5oz6jUkV4XnScCYlKoDH_in.PDafaWG4PwSg8JdZSFvC0jGJvyWtNKtSawoUaLF1_
 FVJgWN5djAi0QQ54FDTR8eydERWDvKjtSwJ0RdhFMxT71YIAKjquxD_XDS0h7QN3Oxup0GBJQNpN
 3wSodCGh1hIMqhY1HesydupxpPntFgJ9DsnjaZVYNtyzyG8XAstd_eGMgz9CIMJI0xD0FUWCXfGn
 S9Wlf24rDD0pwSdh3wuBngsKieI0QSVkMiyUN9T.aiQLC2IiBghyp9p_3M57Tf57ELss2tbyAMSd
 o5WjYF4UlzKm6ZSznfJVmL43TuMRL.Ku5lDPjnSiNOyYoN1JIhDZ9Onb9Qb5ZSuy058pRcSpEpDV
 i8lBWA8oQeUc_wJ7yWdi24UIYWxSPjrc67d3iGi1HO_0hLOf7m6cQ0qQkcyzfmwEIJ7CPLBvjSFc
 aR2FwUEiZTgsaTC3ZV2JsirsNrJv346L8durSEhQgRbC_1ilnP5XPHsysw5f8Qm4N8ZEwb_5Zf8v
 b0FubkEGpG6dx_mIOySml9aBVplLI08bpxQm50ngVE1BGnYIDmiqhj7djAujCgHzJmokBbj5lokE
 U3fP6WRymugUxsHu2i5ZZWkX2oNktHeFBPD2MHPsuaO37fzvZ3WR77ykKYGsDD5pmVzWr9dswsml
 p.PgATxU4auvSl9AUoXIjUJgcT_BJ3a5QYgJLDdIGK4DeZtuEDxQQcbVKPl3GM8erO7h5CQCE7Y6
 taBU5mz7sFFOMtb04MYPteishjlaO7cGM6aEf7HUJumne.oNsqbSwZnhOXpP2sIPFcj1e4B3o9vE
 BMIvXCM.BwszeHpvExN0OIMXGdTInyqNE35r_9ij7mkTSQWQv85ZclWcy7gNPnrpIjILIlm9Zrii
 L7EU7ko0EjXYepm7XAgSxZ7bXAkVgBq5fvZB8UWo7oZAJrIV1Eq_uH0CIzgUN3HGzW7hz_dTrXpU
 vw6M2WDgXn.9cX_Zc87WMyZoSyQc6sOoKCu8srCgGU.Tfw6huwHpw1cy.jVEwuwxnIN7sCgn3C6c
 Nv8_tR0eUWrEl9HApsDlzoUOFM6nVG8QNc0.cMHiaHKetj9b3ZegcARtwnfix_4IF1Cp7WWrwp1U
 _NxlR8lTEoOMvg45iUJMC5bB7zHSB5ER34zEbzV4j6x.T3DzwS3Q7rMDmnw9lG03hMHqdudBrwWg
 bTvjD3xP8pgfsfkvZHweoP3Cs2jnMy7KB7qxJwGXSlby4MGSWXfAG6SAntGq2BUBs6RiYv8eMnvB
 TZbUkkx7C3ac3iFmXELdUVu1k_h.gEx4bHQv3k6HaDFzUriTj2mb.E6MTkdTEMbxVuVft2d31Spl
 Xmzh204DU7oSlq6pEt0VCbpM5V6L6XBBvH9MEtQwnjhun96iZG0wjwSZ5lYpiBpt89yN8UG.A6D8
 Yy74SDjcnSAeOyZTjhjL5hPyhgTasvzwuwtqsKNhLwrlQ583MAwiPPCxRCSh9XasHlMn6tJwrqf1
 8L6ze2P42LKZDYFODayhipGqUtExV7dwtQEdKX9HfRl0aOdbfFAOESuXdaYaC1aWK1FyXSQKanTF
 LioKRiVlQg7qyViNmz.cTYdEpAFhwfoH5w.oAb.aLr4X14A90x1HIozZjfmxcU1MVqvD_crlZJC2
 swtCvfbw1eTKfKxyRcW5ZJt07cLJ.9rMkqPpqsWHXxaduTFAclUH1kUGILH0bdy9EgNh4JvRye79
 surSyyqdhEfM0ytsELw8VLJ5HHPwOB2NHmJWNLb1_yiRsEZ2O7qPfwlQrqz.xeJW5g2smV0nEKmC
 G19f71GEK3GZozW6SGMCba2ctw5w9wjpoPlxlKmNpVcCBgdeCxh2toO0OkM1rw3ldMLXYtmY1Mf0
 BiijxQnUX1N0nJKmdbAMzbT8bbxIC94hGnDXr0SxcMDM.UucdF74URHbCkNq6RgzB3A5m4EQDL2k
 rnU5jpPgwSduJMYUMSyNeFyu377ZZ_n0kCIcVmLjyQFhcY7dXixNJ6w9KKyxSj0ZOEnfvSFUaZ61
 qq6cjubTZa8Z1Oi7s4GdZEbrCkyPDzGtD28BWccjUDsMvk0TQdwrl_AeX93YS8NRQRd39bqiWkdH
 UinNRJF.WQGW2ZD5VHhGx6yMKMZg3gX64HIgALM_TQsBT9kq8bo4xQTFoR31g_2EJYhmIEhTNDyy
 dD9MnX4eUhLp6b43jRoCVs8JTpzmX4op16HnN1wSB
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 537a043c-736e-45ad-bf76-38a1062e2f64
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Fri, 6 Nov 2026 14:56:26 +0000
Received: by hermes--production-bf1-6d6877594b-qr7mx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c04cf56ddc9dd2d32ad52364d9316795;
          Fri, 06 Nov 2026 14:56:23 +0000 (UTC)
Message-ID: <014d5582-8ce2-46dc-911b-397862492421@yahoo.com>
Date: Fri, 6 Nov 2026 15:56:18 +0100
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
 <e66204e5-ac33-4a35-8d36-6f37372da97f@yahoo.com>
 <au3WTtBo3qk4nQvf@analog.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <au3WTtBo3qk4nQvf@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Subject: Re: [PATCH net-next v7 04/10] net: dsa: realtek: rtl8365mb: set RGMII mode for family D

On Fri, Nov 06, 2026 at 02:50:46PM +0100, Alvin Šipraga wrote:
> If you look at dal_rtl8367d_port_phyComboPortMedia_set(), it actually
> writes MAC4_SEL_EXT1 = 1. So this is configurable.

Thanks for the pointer and for the diagram, that makes the mux clear.

> But for the sake of the Linux driver, we don't care about MAC4 being
> anything other than connected to the UTP (internal PHY), right?

Right, nothing in the driver selects MAC4 for EXT1.

> So maybe just check in the switch registers, when it comes out of reset,
> whether the default state of MAC4_SEL_EXT1 is 0. If yes then I think we
> can just ignore this problem altogether, advertise RGMII capability on
> port 7 (i.e. use EXT1), and be done with it.

I do not have the hardware, so I cannot read the reset default of
MAC4_SEL_EXT1 myself. Could someone with a board read bit 12 of
TOP_CON0 (0x1d70) right after reset and confirm it is 0? If it is,
the check is unnecessary and I will drop it.

Until that is confirmed I kept a single read of that bit, and RGMII is
not advertised on port 7 if MAC4 owns the pins. It costs one register
read, does not touch MAC4, and avoids driving the shared pins from two
blocks if the default turns out to be different. It is not bookkeeping:
nothing tracks who requested EXT1, and MAC4 on EXT1 stays unsupported.

> Bookkeeping is overkill. Let's just not support MAC4 as anything other
> than UTP.

Agreed.

Kind regards,
Mieczyslaw
