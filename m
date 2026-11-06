Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.186.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976985;
	b=4FI1YHZf8BxbPZFq+ciVAUuaCx71Pu7+Hxv/hAy9tAbac78DE2uttGNdptgt6rnj1JGr
	 rSQSWBy2CfZao+CG7ki/GIrwGI/zMLqzIMZtWBXpcnhzVmVnnZaCtFumcVovAIG2AP3Bd
	 YnIJpJlf2m47NAYrv2RtzzazV8H6VaiYCfR7p+tboNqiKEPpq7AMW4KapGIppjdb2eNV4
	 mDoylk6PZRPrXCNpsrYh+6qe9s1YO5gqTaO/BYm2OmtjZEQSofRNgIqmd9Xf9WZabZpdv
	 Knvg+jVFTqQ6RSJePPNztzMyY4h1JS6aJ5Bqwpf8+kNpnH1LXIk/O5i91UZS4IsavCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976985;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=+qhaCrwliDwC1pgd77VySR9dmkVHbEdp/Ts+yA1gIFo=;
	b=uQ4DPBfx7cxicFX+1zhZWZ/VVrfIZFvTrjXvwMqm1UV9/ZgX/O5ep5YOycjwV+cyvwli
	 P9FiYpV3iHuq+bQAa3vAaT5OdYyBdSQPxe8epyvX+z5xWKMgVUypK8rsBI9DeFXwSDw7e
	 Ij22EgnWTmjwVWt38hMAqbxX9PzXQHHnfr7kLq4627L1Vx4lwm3NvfEtlSuopJ6/4d12q
	 UYtzKcEd/FwPthOcJOiJlECuC3DBF8Tn0IsRQ9Ib6Ywh7W+F+GSa7MNlEKaiXKdlHpqJP
	 bRxNUntbMFfCXyEHgauNtao3zN6yWOcFlXX2u/JQz13tsWOoqKb2ZCXahx7bsLQ/qJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=iWMQr9GA;
	arc=none smtp.remote-ip=66.163.186.147
Received: from sonic302-21.consmr.mail.ne1.yahoo.com (sonic302-21.consmr.mail.ne1.yahoo.com [66.163.186.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14070606A32C
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 14:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14070606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=iWMQr9GA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793976979; bh=+qhaCrwliDwC1pgd77VySR9dmkVHbEdp/Ts+yA1gIFo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=iWMQr9GA2bWDEyszKHvHZUP+6eYF6qqw8btEsd/PbE8KEAfb1lbiF/EaNBeUisa2w4ZAZOds3erxoS2tHeC2HVNCDw/npfqFO8CK0MKee/N3F9tzPqiFgKaUQrvWPDGP2jtID3MswgeAzW80Y7hw8/4lEKWqUXpSg07sOTkM+Z9XFivFUvsqA+solQ2MLRI5grvVI2B9xtITm54RbMl6gynvVSlBmOQfQpls+fNcZs9jCSzEXFLO8WgIw7/aV5dxevmpFmM87bc38tQD4BFkmIVbEG5/i2/hT5hZopDy3gyDs/F4d+PgM1udeF3NCYREnXWD1qY1KkJyAiMD26pvDw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793976979; bh=5BJQJ4XzwPrg5WbwewW8X9YaMG6eH/apg0eqLh8erU5=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IolMDpzEdQLgnAf0RiyiRszu/Ug1lT9YtLDeCbK5SrN7hd/+/BdAVLlR4bJ/xCv82nhI+uFbWjCSppdokbTINbYShd7AB+e9fnixqc4v+qv5hA6YDlqVGtR/8FhW8ml8jDNcKBLvN4w+BLvqXAlTfiHkRetdMec6UkRO5p3wSS2G26K5I6BKbl7HSSQgq8Lp4kUmDt3zswQBjX37jZozFiTeS/wfRk3xOVxzmDdrERmoPEnp2/6hjO1xSP7kxMOlai+yKFjGWFcYmxflg2+f5s4Alb4ES1p3GaOJ+SLGUlAq6fBci1fIewG/xiY4RSHCWJRzaR56KV4no1EOFuEKcg==
X-YMail-OSG: gh4CKfMVM1lg5Yxi0viY0Z63XMSImSEDv9lS7LJdqnJf1fjfmwZOahJ4DsihRMT
 7DXiVZlRDP1YtRsMdFjoBniGq2.Vge77V95g1Quhgkxw7z38ra8OTi8DJQh1VDJZj7ANJ7t7qbpg
 BBXlgl_d0WGRBB5OHXUa0Ld_deOXvp6NEEH0yharc3PiqEIYAWVEwWakQ5SG3IY7E6o_vz3PUh3b
 qv575oQVTkf7Ray.za8.PYgkGBqNJCAhSXBDATmjidNiJhdFCoyo7H2pMLquoKOBVB_eJufnc5W5
 zPuqFsG2sD4PGMVTXGCeaBduhTRTkj2m3CRjNwmRyGexF4wB9RXLx.j2G8uHLnx3tLKzbzduh6yD
 hEhOQFxDX1rrqrXv0uPnKOwt_pVV29Ql35.7OvxKlTRy1lcYP1hhYYuenIK2r0MyOEeMfoABBGFo
 X5w516z7kIPi1TzvZx9DTLyuw5q2fA2Di0zCpbX8Oe9z3lHUF2jp4WrC_nM.ba3CqN08l8JQIb1G
 Gd7SdbojtCHzIpwqCXuKtfbGmPIQs6miXypFsaSkSWXdgUzr3M9Axd8SitnAoq8Lw.r9u6qxVbdb
 xiET3gB9B0AbeHeDWXkbR3GxvFyeY.YrB9T2_E7Jo8u7tc1cybu7y5TwRHsw5bOdvxGezsn7mZd9
 reara11lb9Ihr8OPv4JlThAqcLjBV.kVHGvCgGULufhR9xFfOCp63MS9UM.vuQQIYCwSACVg4myP
 LTTz6AmmTwVbrDAvb9QV958lJEyCtIm_AocIl_.eZkaMzAQ2Ea3z.Da_KflXJyatl39rK2Oep5bj
 v2knM4EfRnbxxdM6drwKSZemZjgh.zqDzpnZW2tfj42o8Rdo5uBFARdLhm67BoK6wTb_o8NRtxfw
 8H.KUTtUZuhfOMvF5_JlGrx22dOarPiGpG3NtuHbmZcyS_HDrrR8hbHDRPDTm9BHT0ykYaDNjkva
 O4Qk10Aid9RC2AOQ_cZA4IxVAqU9PII0Xq7gpYRYdichpQ_Ul_zh8n4SBOskxpeFFTH6I6rmSCjK
 G2rAY8wsdAFqEMUU08.X00AfTu11B9hZuAufoW26Ma_xZd0Oy7ROQPRMrTntg0ttJUAy2Oogcjht
 p6p3ZZtVhl2NLAhmOwNmRY5pgD_n3uMA29V31LoiCTt25iiPm.PNTmTHYkv2qCJO7CumVtdWYwc7
 ablsp3NrBabeAbBkbu.Yg.v.FIy8LGBQ_MqYL_aM5lt6UWB.XGaDz1PKusj1Y3kcLANK9BHadd5v
 yPkU15vkVCqtbWOf_M8aIYzDosSpJGWnROf4ExaVexEHtrfNbvNdKpLBf1eTpZZe3oWjAGeOkVyN
 zM2ltrcFx7zpFodFXIAM2z3XhG8UrSDwlMwzWuGF_DPNiujKcGxFFEbUpNtRJka.JKU2FxFszjjl
 4APVVLtNDUyRFVwGFFYrZmy65egKAE5kQBnQV3ckvjxwmfJ7fWRpN8i1_hnHXYKvAaNDa0R49dv4
 lLaRXF2CNH5hzz3HjH1Tt_MnW3.QMuwZhfK9koWyxJpDUKpcumU3oLdcnrMTGGHOkeOxXUKqgGZM
 SzhLIF0KSfQla3IW9QyQasSJsj4teW9dNRWdgPhREshw0vDX5LigAeHGGIbYkxZUNeaMkl7kiu6e
 FGaT2B8XvalaI1NUdsN8b7TQlO6P9kzWU4pB1mZTgBs2k_lR3AoV1vpMGktXquwHLi5O80tbP7sG
 PdI1qxicZlx1YE6iHnbqZPkajJeIzVh3WCCTQCTUWTOvkcamlSgHG1of86_MCGiQI1.GJvSj11Aw
 puTlmtldjZgk61nx9U9QJXoeXYSV3PnOSoAXU.NQrNxYbqUlZJChWb9uSjgZXdowh3s7w4M4CVM1
 YXhlHmMdG4E1vtP.HCjSMD2.8S.wkZa6nIgI2xpuXmCF_xSPO0tVo_i1wfkNE4Xw2OtPY8PxmpEj
 5Nj2R23.gOD.Bhj7kKvDh.78cR4Ed9RK1.LAaLuwUdXAIwyHhEgTyCF8UzVTS6A1Vhnbrw1p32dC
 QXjYpYAGpgQBhk_VK4oYpGu1WeV560z7ZEWlV5itOdOLHM3Ce0FtttD8RyJXnal5NXQlf6HYfLAr
 JMua5.Sz3B7vD8DHSARljlc5zgeaDpsI7jyWgMmVBL_HLXGXHxKanK0oOu_YabHtqB9SHr4H7KbJ
 UaMKmqIw_m3L8fluLBiyp.6xJ.9H0O2qc1R161vtqMdUh3DyRSa_9pTWqv9_oqwIn.DgQIfoTZF2
 XQIFrB43tOuKEXm.kYO4Zr_8s.1x7NrTPX3Gid8WHq5x0V2YmknkFpawSQajJXWi07dHAHamlJ6w
 quGl_lWSWKZZoUiTEOeGmL0o57j1mSbQUL_fJV4U-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 149729c8-3739-4b05-b583-901f740e0a81
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 6 Nov 2026 14:56:19 +0000
Received: by hermes--production-bf1-6d6877594b-qr7mx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c04cf56ddc9dd2d32ad52364d9316795;
          Fri, 06 Nov 2026 14:56:16 +0000 (UTC)
Message-ID: <b9778e4c-fe81-4305-b764-8ebf4ff8add6@yahoo.com>
Date: Fri, 6 Nov 2026 15:56:10 +0100
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
Subject: Re: [PATCH net-next v7 08/10] net: dsa: realtek: rtl8365mb: re-latch
 the family D SerDes
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <3ecac0ea-830b-47a0-931a-67fea637f0c3@yahoo.com>
 <au3hdMxLSilNxhnK@analog.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <au3hdMxLSilNxhnK@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Subject: Re: [PATCH net-next v7 08/10] net: dsa: realtek: rtl8365mb: re-latch the family D SerDes

On Fri, Nov 06, 2026 at 03:28:30PM +0100, Alvin Šipraga wrote:
> I don't understand this at all, should it be obvious what you mean by
> "edge" and "latch" here? I would assume you are talking about interrupts
> but it's not clear.

Sorry, the wording was unclear, and no interrupts are involved. "Edge"
is the SDS_MISC mode field changing from DISABLE to HSGMII, and "latch"
is the SerDes receiver locking onto the incoming signal. It locks on
that change, not on the value, and only if the far end is already
sending.

> Is the shortcoming/issue you are addressing one of DSA when a SerDes is
> used in the CPU link? Or is it rather some hardware oddity?

As far as I can tell, a hardware oddity. If the change happens before
the far-end MAC is up, the receiver does not lock and nothing retries.
Both ends then report 2.5Gbps/Full while no frames pass.

> Can we use interrupts instead of polling?

I do not know. I have no datasheet, and the vendor API I have does not
expose an interrupt for the SerDes state.

> I'm basically wondering here if this is not something that DSA or
> phylink could help with?

pcs_config() and pcs_link_up() run seconds before the far-end MAC
starts, and phylink never calls rtl8365mb_pcs_get_state() for this
port: mb->pcs.poll only arms polling for in-band links, and the CPU
port is a fixed link. The only event I found that tells the driver the
far end is starting is the CPU conduit coming up, reported through
->conduit_state_change().

> You've added some scheduled work in this patch but you do not make
> that apparent in the commit message here.

Right, the commit message does not say it. The work repeats the
DISABLE -> HSGMII change every 10 s until the link-status bit shows
that the receiver locked.

Kind regards,
Mieczyslaw
