Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.190.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261984;
	b=eVC0355k7h1sjeZ+uwIoq8kq7YP86ymilXPXR/Fiq5WTXRqT7mNBQqg+pyG+OoMYL2jV
	 4MI0yFtyiQj4ujJJ4JiC3a9IVkIvfaYCkg+WBsRPArtYYhUb1aVXZPPzmUf4AX/p+okY2
	 9w1WLCQbbuIs/GmYyezFp+O+X3fggFd2rmOYcpLRpyywrB+NM06Ev4SRDKizhc5LjUQS8
	 SDE7YNx76o+c8u5CvRY0Ig/68FOL3dmIGaFZi4emFR8Lo5XpwtOH6ZE5jymvgUPifwBsw
	 GnbjakQRU60nuT5D+72VawpPzoIWW/NJPGKfIRHHFYBZr0mTzPEBbFCS+T5fZ25JkLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261984;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=LXdslhn4QFOhXiE4/3m7pT0ytL36hZW2Gbm9O6IkB2U=;
	b=oYJlZFv4+Td05FaRstbAD5iDpSnLRQ4lBgsmCp8iDeNo9Rkj5VYz+CNOlHiY7B0EjA/l
	 ta+H5zO4bKhJ/tsSlQPhzEtaHymGeM5zzubQsJhaH8tKnv0hEItZ42JZQEqp7kzDV9Edb
	 4zcHGH+dpwQeB/mWWpKC0OyeQLv0XnFTVEbC5QPUE8rl09+hoEBeHyIbaQYsQCLSDOgTy
	 yGDH3YdWBaKIBn814262IB94vPYlrICEoy6Wg/1Oljs86cRbqbdk6VdVC/RkXn8gmGnDD
	 M1zgaUMH32J1h2FN/inKy9QuDH6EiYuY09tOL9ufLRp4wqBaYbFZZ5u1EulqQMTu9aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=DYMytSYK;
	arc=none smtp.remote-ip=66.163.190.147
Received: from sonic315-21.consmr.mail.ne1.yahoo.com (sonic315-21.consmr.mail.ne1.yahoo.com [66.163.190.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08384606A32A
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 22:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08384606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=DYMytSYK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794261983; bh=LXdslhn4QFOhXiE4/3m7pT0ytL36hZW2Gbm9O6IkB2U=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=DYMytSYK3AwByEXZ4ZLoYE4wFsAKjciyP+vSKcA65h4l6xkLbLtJJHpfqj97rIG7fN73ep+zEY7eZ90zh9YV7morXl4TToX1oS1UosIc3SDsykAjyioIDKR+qhERIb7Eg07Ctf7rCxo4EzYvHiyPG0DM0yQrXjio8S7iNzfxUO8eH5wFmXbm5T33IQYeUjUd5ekLCXJjnGkeAeAU3jORgvmiWMND9CVB3S//N3wLM2xCe8xX9hII0JznantqFH4mSTGaICsERT9u/60wnizb1DG0CxaMPnn/CendAHU58Rays4hod6Hhg9S3bSvj4f4zUmvHEGBDlK3Q+U5LxnE88A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794261983; bh=KaOp+Il++hyuwkT6/Vmv2fNNwBliSJJPIUzvrFnxIo3=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=TCUq6+b5bNS7VVrLKb8+dAuk/BvKDxdoMad/YbDGKgcS3MwqHrTlZyFouktv18n4MR/nWzCMzrK4dzhaVdlcCtchn6su9r4CoUf7ZWUg9tK95/LK5XpE/1DxNfus67iuys9+PRcnWc0cv2bR4jIPo0ubmyLyo/IqfUwQMjdEUCmTHT+zj9lGxvj2kyyZEO0asc02kbzp7+0cuNAgPHX8p6u75N8EMg9fyXc3O+LjFF+HgiHVBc/LdYI8fX52jeJh3Uq3DyUQlhhfeEgINIdqlebfmdZVRbTb942o7eIOoeU6lj4Nn7Sq+SVRpI9xutlHGDnI5hv84FH2z/JcjdZByw==
X-YMail-OSG: mU_d6JcVM1na2kursYcZv.ZgUwJtq.y.BP7YO7QUPF0EOePXec9ANKXuWeVxgRO
 Wekst1SNltPuRcLut7brl7pO7oGSc3DDn3DC0UR7bRNshUBmMgXmiQtO4WgSINqfxVIljAlya.YB
 QsKRkuoTesNNleti.UdaTvKk6wDAvN6ajF_B39M3jpEWsmrj0VOiA9YASBfcPw2jnLL4l2MdRM2V
 0hRxJX8o.G_sIjk0VUcqVZU6_0tfNb8nAane05gLgRfczTWonFbWdgrN_V2LsOIL1OA8C_Aj0swy
 rRLTtHWI6qdJwe2JvnmRFa.wRktubI4Vn5V9xS3vUinLN9Ah7kpUKL7706Lj8r3X56NRuCdsNhti
 G.E_UAntTkaHIDKyddcPT9VNeZa5_yrjvTSKPXZT2YvJIV.M7gfhk9y3ONNR_ywbs5W0_03ZFeFf
 E_EmOd8U31pNj2Ms9Fd0TJlQp8NtqXe.Ms4.gSfZhMFJFOuQRB3m9HCPxuMDvuWwTHlm22sjGcXy
 TjGorrVcLF2GQa2mEpYiL_CvluSQ7YKMZJVwyvoTs862Lp1S45bWSB1rJIbx8P3VRufhZsRfbWvW
 ZNuj9qDidf6lSZJkPhTGKVCzHuFK52ck7H6Rn886M8S9Jm7YIu5RXYIS88uiuZ9ixORY.ski6vhL
 3x8xq1HJGAknzMEk0brWd_gFHAq_p1hHRVSIwe5hxeYpX1Ze4nrEiWyA5DuGoiw_nzLFSCWPYC8.
 pZJMkNssvnsonGMsf25BV.sA_a_E6X9blrdkbdmp.HanYjdBgW9VezDMcbavwkWo.5qqsCz6RKuS
 PEJTJSkENwjgSMDYR_ZPM5s6685g5vKvULMdKP2yNaHPNt4cgBRM6PfPxdM0_aKyVVqAYRCGtMXe
 stY.raLXqMXYrDwuR9NHloHOh68IpMONz3XEH42f3KvtdE0fgL4KsuH.EvwPadk8IGDCMr0o.Ado
 yGE9yVt9n6Fk2vR78EP38OU.UzHr4aFqSK7y42me41YDZkREy4nT69ccLlJYDcpVRXAlKXEzTyMY
 Hyal2zoQXP9.xQ_6iyJf51q1Qgr.rcq67jeDGUllrhRo7U9T3SnMZhowBdYTTkgLy.xpeQbXSyFV
 JGtlmXGSjgtaw7tnG7fV786G_JMds1MrjfmlsFDTFnGxWGRj3J0M5YiMUXcviM.tAOUzeHIU8wNH
 8Uzi742vIDn6TPibbEmWypZIlNvYjGGaiS7UkZn6PeiWADuMm3YkmtEO2jEJ2RnBm__QZHA7wcil
 0qlQEP3BCfbtG9vUMGkzwi0V4o7AryQakwp85tkXzcKcPnY4mOyLBCOO5aIAjmZlHTHAarcEBcfx
 TCCWmIJ_z0xNOvbQqOEL0K8k33JrQWxeF91cimB6rerVaXa23tzHe2h7IxBAPM.hi24WpOQqGRdI
 2Dztj.3cS7wH3FEKrkdc.JaeOCwt5ntmvqNfeLLxw2Myb8tdSvLUxT6sT.tkXA97UxhFqy6e6O.c
 W3LoRmt0PnIZgbCgaMpE41sukwexny71nwD4dZA0vwZP3y.hwVDiFNDWjCtonJ7Rf8cIhdYy1KLe
 Qho7NyMmC6YcnEk5VljmulnIB43VlOczRkc75s8aEW5iruxPA4Z7kTmeluF9cN5JFiYfppz4rMIP
 .fTLXS.qkhfLNRPnsEPmHHln4aDl8.hfUtR.xdBoa32BmbFViF3S7wumtz6YzmvTXO9BS0R7b0H2
 zVeoZIt2ohq8JyFL5sPR1iJUuU39nKmHCTujWrBgneIx5CkyL0OTerL1RGvNzPdJ95NYr7IcK4rp
 rSWnsUkPSNDqHS2U9D.YjzMMxHAq0Pf8.6xf.h.9xwDH2NAn4eL5CHGWdj7Q8i3EskMtl3M5pkDP
 Ks6IploLiIuHlO1DIeNk9xCXnQRp00EZY_b_vT6GvlaPs_h7GL9LJ3no7K1vwvTxcaGNSedw08lr
 1urq3dkj1MMONkF5CChUxR03Lvxri3sBF2eYhVtaPAvyL8tqEk9Dp4EgRQPXuE.ZloObqtCVR5tu
 I3s8Gld.acuU3rMP6oaZ1dypTUgTM91pT0gt7h0026LaOrEC_Jhn6x5vxn.iFmoqCnyxv0WtqxK4
 IjRGIWPyBhBuoMEwFWulKJyZH7Aw3jIb3Ydvt9pRlNNQ_wDwC83eRhtBBZLYuzpvf.sFPQAfIEHn
 OFmiNcoRUXYj2d5KQuauYrJ18xl0VDS3ixY5ZZ5tslSzr0LgfynK7SCZbd9FpHPmq6gaG1G871gn
 jf2XCAdWByuhpxZi9BGbB7C5NmhbXGGwNLjUd7o_cHGWuPbqAqEZHi68i.h71apEfOxyPchnJqoQ
 59T_1_rkGilygk4ZyL6P3BDh6XVBtoBgd_x9biIJrddEIx4JbL_I-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: fad1860a-1754-460a-b3ba-7b3aa4e0ec41
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 9 Nov 2026 22:06:23 +0000
Received: by hermes--production-ir2-5dd9bf4598-98szj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cdecb7d7b98a1d01b52c305e1afc5ec8;
          Mon, 09 Nov 2026 22:06:20 +0000 (UTC)
Message-ID: <3d61128d-bcd2-4f31-8ba0-e35b488b5205@yahoo.com>
Date: Mon, 9 Nov 2026 23:06:17 +0100
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
Subject: Re: [PATCH net-next v7 05/10] net: dsa: realtek: rtl8365mb: set and
 get vlan 4k for family D
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <1ccb6acc-0809-4abe-8443-576f6727a6d5@yahoo.com>
 <ausoMS5PcpEFz02i@analog.com>
 <CAJq09z7djw7MAbjc8jZuNsj12JhNCUOsGj-Ve73XwRjjHHO=JQ@mail.gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <CAJq09z7djw7MAbjc8jZuNsj12JhNCUOsGj-Ve73XwRjjHHO=JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Mon, Nov 9, 2026 at 2:31 AM, Luiz Angelo Daros de Luca wrote:
> This is how I'm structuring it now, though it might migrate to
> function pointers later. A family check inside a shared function only
> makes sense for very localized differences. Since family A is shaping
> up well and family B sits conceptually between A and C, `is_d` doesn't
> scale well for future variants.

We are completely on the same page here. In the upcoming v10 patchset,
I have already migrated to function pointers to handle these 
family-specific differences cleanly.

I introduced a dedicated `struct rtl8365mb_family_info` which has made it possible to reduce the use of `switch` statements:


struct rtl8365mb_family_info {
	enum rtl8365mb_family family;
	unsigned int num_ports;
	const struct rtl8365mb_jam_tbl_entry *jam_table;
	size_t jam_size;
	int (*ext_config_forcemode)(struct realtek_priv *priv, int port,
				    bool link, int speed, int duplex,
				    bool tx_pause, bool rx_pause);
	int (*vlan_4k_read)(struct realtek_priv *priv, u16 vid,
			    struct rtl8365mb_vlan4k *vlan4k);
	int (*vlan_4k_write)(struct realtek_priv *priv,
			     const struct rtl8365mb_vlan4k *vlan4k);
	size_t l2_entry_size;
	void (*l2_data_to_uc)(const u16 *data, struct rtl8365mb_l2_uc *uc);
	void (*l2_uc_to_data)(const struct rtl8365mb_l2_uc *uc, u16 *data);
	void (*l2_data_to_mc)(const u16 *data, struct rtl8365mb_l2_mc *mc);
	void (*l2_mc_to_data)(const struct rtl8365mb_l2_mc *mc, u16 *data);
};

static const struct rtl8365mb_family_info rtl8365mb_family_c = {
	.family = RTL8365MB_FAMILY_C,
	.num_ports = RTL8365MB_C_MAX_NUM_PORTS,
	.jam_table = rtl8365mb_init_jam_8365mb_vc,
	.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
	.ext_config_forcemode = rtl8365mb_c_ext_config_forcemode,
	.vlan_4k_read = rtl8365mb_c_vlan_4k_read,
	.vlan_4k_write = rtl8365mb_c_vlan_4k_write,
	.l2_entry_size = RTL8365MB_C_L2_ENTRY_SIZE,
	.l2_data_to_uc = rtl8365mb_c_l2_data_to_uc,
	.l2_uc_to_data = rtl8365mb_c_l2_uc_to_data,
	.l2_data_to_mc = rtl8365mb_c_l2_data_to_mc,
	.l2_mc_to_data = rtl8365mb_c_l2_mc_to_data,
};

static const struct rtl8365mb_family_info rtl8365mb_family_d = {
	.family = RTL8365MB_FAMILY_D,
	.num_ports = RTL8365MB_D_MAX_NUM_PORTS,
	.jam_table = rtl8365mb_init_jam_8365mb_vc,
	.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
	.ext_config_forcemode = rtl8365mb_d_ext_config_forcemode,
	.vlan_4k_read = rtl8365mb_d_vlan_4k_read,
	.vlan_4k_write = rtl8365mb_d_vlan_4k_write,
	.l2_entry_size = RTL8365MB_D_L2_ENTRY_SIZE,
	.l2_data_to_uc = rtl8365mb_d_l2_data_to_uc,
	.l2_uc_to_data = rtl8365mb_d_l2_uc_to_data,
	.l2_data_to_mc = rtl8365mb_d_l2_data_to_mc,
	.l2_mc_to_data = rtl8365mb_d_l2_mc_to_data,
};


This infrastructure should make it very straightforward to hook up 
your upcoming Family A support without duplicating logic or bloating 
the shared functions.

Best regards,
Mieczyslaw
