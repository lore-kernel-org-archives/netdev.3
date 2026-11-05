Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.187.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865362;
	b=vjFQ+Xyfh3tskg7Lv3d0GRzOTfNhXGdEI9q+7D7R3PhFA8f4n3Nl4yeHd4XA4+lavzKK
	 of/+/WQMzLRJ+g3AZyRUNZQnSIH7YEk8ypdirGknF9/AdWOehhzBvlxhHwkM3cTr7WKwB
	 2THR4uSrV3YekiVhpxQrtKu958roHYMqPsJzi9SaMqu32eCSgfqd/QHdncJlS0fRBO55u
	 ulIMe5wsRBTz2xF/oHVHzfz9dq2QvERECXv4LPrNSMJaQXktZLuZXR9KZsufpPShtHLyd
	 omgCQMmRapL3wEVWLjE6VcwoRgc8vatqB2cWZNm5OT30t9hIP+5rEpYB8YcLsb+yGfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865362;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=THkYLDB/2O+ui5t+rY9Tn3ksO+ZdfuSEdwuYNK1P9pY=;
	b=es3wzxP7bBpl6AvQ+0fpawXA61SANbjtfpJ4eni2YIjX5lg2d4cN/ol8vB0rw3XBOe4u
	 wNmpE7K4Mrf+OuN7vz0ED4aJajFhgGsAZ3/8287SOXHqd0xELYhAIxR3Ehv02JSJYrdQn
	 1I31h8BgZE9P1DO1aX06FIbdLXRs/9VX1KiTozRRZGxT159OMgWQybiZMB4JNGLPMBCDB
	 7yVazCeRJyVPza8Tazoq7q8MbtexpWdRR5e3VhJcjrMLNKzFN9Vi6izBRRZOVl8Ac4klG
	 IZmenT0Lssf+e85QSiMqLbPL4CzmVb+1GwRBjeIEFygvYdm6+M6iWTCcFjLmtv68SBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b="j/WcpRHP";
	arc=none smtp.remote-ip=66.163.187.148
Received: from sonic316-22.consmr.mail.ne1.yahoo.com (sonic316-22.consmr.mail.ne1.yahoo.com [66.163.187.148])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A18606A32F
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 07:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55A18606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=j/WcpRHP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793865360; bh=THkYLDB/2O+ui5t+rY9Tn3ksO+ZdfuSEdwuYNK1P9pY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=j/WcpRHPrABQXPdGQifU2iMrUwzoh5rTNrcbTYgtQWkUFJQV4I62JD+TCXLQ+O/WjZA89jrvxbUMfA/V2BZVzO/HuuCvMAzbKuiqzEop+2hN/0EIAWTHQGI14kK9jPwqw0dShcZpoRXVEbpOJucmrj+iLznQ/DGKasHkAV4o0g+BgN0HP56wEeoOPdSdJJk6qmBaxt5MMLn7dQkG6cma/bE6plY0S3X5s8A+oxtNfUGhLnpF3We4FW9Uk9umv/oUpHs/vImA0y9AaIYnfHVu56DWHbuEu1j36kR51eoergX6sEd7pSGjf0FqL19MQVui3s5xO6lsPdWVR1GvOIv94Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793865360; bh=0ux6bTrmB3RPE9gIqFTSfHffLX99f+iHI0QjXurItEH=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IxFU2ebP3wqzpzQL350ZjzhL/cLv47EOJxM7WSR4axbvz4IU5TkVvRfeZfSU6zr1sGVHjKp0K0QTHpSjGzp6uCnKJaq2oKGeAIIHGw13dI7imPG27K1Ce7H5yB/vxYuTmObjTYrPyiQUEXsOisrXrmIO217vl4ftRRSvdQyYBOTH+6Qw3IAbEXR2VrZFWRIH2LjOy6H7BramkYwWa7WJJHhy2cP9uCXW6TQSuU4LFlmTYxZIA7hxxGbKjOSCYvpcleZCrgL4BAXQ8kxXrO1XCdsxYSGckxQ/EPw48ZPZdoj1nSg7DhgK0gSfwrfFM6Yg99CeBJCq63EX/ytdYplvRQ==
X-YMail-OSG: L6nwUXIVM1lTP6KM6DLV4Hq1IfWhSJ1T1yk_fYnoucJgTzFe50ewSRYwXHU049A
 PFTj1Ieq44xEsmBz5aBVRlu23lpKH5SeEbme4AcRrSOstFCwddJ.4ykHpTrLmJ3.Hy3_txAHckz.
 LmzWjaa4HKIUtQdWCRIqTXb6wnX295Be103ceb2pq7hfft0S7qjVwSQ7Chwj6bIpCEqo6hHEOGZn
 MKlJYWvxfkAumbGcgzxh7CmMIWRkay97GZLf_CVoyrVTKtWmadEgETsa.DU.bYnsd6Gbupu.mMye
 qZJ6d6TWt0SdMECdEYtolaO4Ph0XkO2j4Ae9RL7jTjQkS_uGLJ0Y0yXFcHGcLRctty.XLyDRqoH3
 f9v3MfO_emtErjuPuaqrG0gVdlU3SvFfCJo4HPDymB0yJAubt24NMSpWYh1Zp5pKm5uu9PRSxDQ9
 Nup9HLmiv2nwYjO4My7tpHswt.ACQS4x.74PUDlsVYWFMcQPkuo4UKCWdeGCg9NWVTUKe3OJzvsY
 80eWv3iAPzCHHRvXWorV_l99R4XOkS.9giodojYcRSaGwIdvfMq6b2B6ABKwiYevAcUdAPyrrGZj
 AvwomP9qNyKJxHCrDmI.kgBM7dnGTY.HwP68YKK7nKyvH5T6.8QVDezyw9QqM.g3P7lGfj66pekY
 AuZzXSN0m6KfeGUdlY4meGaGH9Z7xC_NX8GtxTzB9Yfz3yJE5lsYJVlo.i13zhoDOeA99GjHSqCn
 getlfyx9eoeAVl3yZUZerz4Ev2MsS4HWrbAeiSil6SOl_C6tszOEBB00Fq57hsXo.AzRXESciXkz
 QrM0Rny6McDUSP4du3jpqLRNJqM_GJ3a.g_xU6Y84ykelphoeDa568g27o.iz3wxAnTUuM6ySSsM
 bjP.fK8isC5Yf__w4A5lOYoF.it.CT00BChbYor84eC8rg2KEN8Ggk82WCmATexYEMKEhwm2H_1m
 Tmj0tYKxApdtA4jbWLmIuRlOnmJ3nVELYfZQ14XyCb_LyU3T5QUxqscW3BNoWXuuwyzIFxRXStPv
 ychk7whqwha93QfkMCIgIipPHb6L_.YvE6eNp6gR8rRIKmSm2E2f4eRgT_q8kckFconKHTyAoc7Y
 LTA_QGsupLDBcGhhvCAMoRattDNWxuQpbE.KpSLyrCsm8jnsw7pD865O3IfpvcrhmVBcfE6jkhTg
 dfUsMoQcOcZ6uQPDaMakTCv2tPiFNnLA496_cIwYkMOgY2PCo3aTWK6SqTNRkHQyfteROzs2yOLt
 1XTBkz87G7XiZ6.wDhVt2Q0AhOIaGOxJ1SKX3liDu.RKPlW8ykrIx7MVDzQO_s_rAwF8iBbwPkNR
 LIMYuGN4AZWsL.ENdy9ilU2I7UQu1f_qC0flwQk2w81p5w9dY1iqRoT58wtdx1BO9OKGw0SprNem
 SUQvGRNnbwQRBzgunPB0IAZXVjZ1gAII8Ehy4hIr1dVevSN7_C4VdxmKou6raNHOD3KK3bLeHfvv
 RLK00QxpZ7LKZrGFzXXAy95mJ2TbzIWFhf6apGNB3lAkZ6xe_KjSY7SvIXqSMelB7O3J70oE3oHR
 4T3nyvvvSXGKMvkYCdBrjE84xnj.ZWw005UkZRpfEDARnGkzEv3zAQfdPGKlssED2PJFbE90dAL.
 CdOgYTNXi7KgX77kvLNnfAveyp25ZYZnbMdLNBtOjWMKZjcZEMutoUqxRH7z03fCdbb9LQE0gfUS
 LyuZxeFCl7.4NqJGkWgqZCHVgWkgj4d89APflWHQFbkmWhsYY44et2wbF_jfUXRFKTc3GzUNwCNo
 KjFi5ZP_eIppFxYgPJ.QN1oLAIltMzLcdjfMbxqcvDU9jAZvEk9dbCj8TcXC1DKr32YJrV63trD2
 rlXospx.qZiQDYPMRTjca8mIP7LRmS_J3i1TmQJfpVghJM3kuNIg64Y7eRRY970yj8qSYHEMmALu
 W3IYsMKSxHBf0y21KkC25PCFek4elXkT9Wnk1SuEYgcmF1SV6uQk8wNW70KDbxlAWtgN88570w6K
 pGBX5sgNgI3FQNUuVj.UabUp_vMToivAxOdvEfj5sJB0MhtFZohjCCy3BFT8RLSej_X9yZn3LD2L
 CF1VeKXawk1cqXWtXj0ouWAARu2i8aQlAdaDLi2iJTN53bDlS3LxU0lZTvRFOiLCoFG8cbMbwc4P
 f2GvZryLgRtTybO0TQgOZITT6FJTy0SqACYb3qLkAodLXA3XMmy7_04RlMpDy0uoRn3aMb9J42Og
 jjvY1VCNBddNKPvZVziaSJ7.gMC77qXK.zBPWNBCDI17YvGxHCSnEOd3wmvPN80qUdnXyI9CLFtn
 1N187hInnvA--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: fc9aa044-175e-4b69-ac1b-a54a3e718188
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2026 07:56:00 +0000
Received: by hermes--production-ir2-5dd9bf4598-zlkml (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b8e093b6a054ea83b64fa4d9bb0fe8c7;
          Thu, 05 Nov 2026 07:55:56 +0000 (UTC)
Message-ID: <82c96971-be5b-4c11-b20f-c4b074181515@yahoo.com>
Date: Thu, 5 Nov 2026 08:56:04 +0100
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
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <auskP2mSY4sCRa6x@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Wed, Nov 04, 2026 at 01:39:59PM +0100, Alvin Šipraga wrote:
 > On Mon, Nov 02, 2026 at 03:39:47PM +0100, Mieczyslaw Nalewaj wrote:
 > > On family D, RGMII on extension interface 1 needs two things that the
 > > other families do not: the EXT1 RGMII TX clock delay field in
 > > EXT_TXC_DLY (0x13f9, bits [5:3]) must be cleared, and the pin mux in
 > > the top-level configuration register must be set up.
 > >
 > > The vendor RGMII setup for EXT1 clears the RGMII field of EXT_TXC_DLY
 > > (0x13f9, bits [5:3]) in addition to programming TXDELAY in RGMXF.
 > > Do the same. The init jam table writes 0x0090 to this register, which
 > > leaves the field at 2, so without the clear an extra TX delay would be
 > > applied on top of tx-internal-delay-ps. Clearing it makes
 > > tx-internal-delay-ps the only source of TX delay.
 >
 > Should we not just clear it with the jam table then? It would save some
 > code here, which is just undoing what the jam table did anyway. Or am I
 > missing something? If you deviate from the vendor driver's jam table
 > then a comment inline or in its own commit could be appropriate. But
 > either way it seems it would save some code here?

The jam table rtl8365mb_init_jam_8365mb_vc is shared between family C
and D. Changing the 0x13f9 entry from 0x0090 to 0x0080 would also
change family C behaviour, which I cannot test. Duplicating the whole
table for a single word seemed worse than two lines of code. Also, the
vendor code clears this field only when configuring RGMII on EXT1, not
on every init, so doing it in ext_config_rgmii() matches that.

If you would still prefer a separate table for D, family_info->jam_table
already allows it and I can do that in v10.

 > > If the internal MAC4 block occupies extension 1, do not advertise RGMII
 > > for port 7 in phylink_get_caps(), so the configuration is refused 
before
 > > any EXT1 register is touched. [...]
 > >
 > > [...]
 > > +    if (extint->supported_interfaces & 
RTL8365MB_PHY_INTERFACE_MODE_RGMII) {
 > > +        /* On family D the EXT1 pins are shared with MAC4 (UTP 
port 4).
 > > +         * If MAC4 owns them, RGMII on this port cannot work.
 > > +         */
 > > +        if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D &&
 > > +            extint->id == 1) {
 > > +            ret = regmap_read(priv->map, RTL8365MB_D_REG_TOP_CON0, 
&data);
 > > [...]
 >
 > I am a little confused about everything that's going on here, but it's
 > probably just me. Could you perhaps explain the two scenarios and the
 > order in which you expect things to happen? I'm sort of wondering when
 > this warning might be emitted. Part of me also wonders if you can't
 > avoid doing a regmap_read() here in phylink_get_caps.

On family D the EXT1 pins are shared between MAC7 (the port described
in the DT) and the internal MAC4 (UTP port 4). TOP_CON0 bit 12 tells
which of them owns the pins. This comes from the vendor RTL8367D API,
which refuses RGMII on port 7 when UTP port 4 uses the RGMII interface.
The driver never writes bit 12 and I do not know what sets its value
at reset (strap, EEPROM or bootloader); I do not have a board where
it is set, so I could not test that case. That is why get_caps() reads
the bit instead of assuming a value.

1) Bit 12 set (MAC4 owns EXT1):
    - get_caps() does not advertise RGMII for port 7,
    - phylink refuses an RGMII phy-mode for that port,
    - ext_config_rgmii() is never reached, so no EXT1 register is
      touched,
    - the warning is printed from get_caps() when phylink is created
      for the port.

2) Bit 12 clear (MAC4 does not own EXT1):
    - get_caps() advertises RGMII,
    - ext_config_rgmii() clears the EXT1 TX delay field, binds the pins
      to MAC7 (MAC7_SEL_EXT1 in TOP_CON0) and disables SerDes 1, all
      before RGMII is selected, so the shared pins are never driven by
      RGMII and SerDes 1 at the same time.

You are right that the regmap_read() in get_caps() is not nice. It also
means the warning is printed whenever get_caps() runs for that port,
even if the DT does not use RGMII there.

Since the driver never modifies the bit, reading it once in
rtl8365mb_setup() should be sufficient. I could store it in
struct rtl8365mb (e.g. bool ext1_owned_by_mac4) and have get_caps()
only test that flag, so it no longer touches the regmap. The warning
could then be moved to setup and printed only when the DT actually
requests RGMII on port 7. Would you like me to do that in v10?

Kind regards,
Mieczyslaw
