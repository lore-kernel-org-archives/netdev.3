Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.188.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977901;
	b=hXP+ZCx162HuduFO7uvb9gR7d5T2sbTbpeDdwfN/FiS9aSSSrjZXNsvM7kjNOLbm3HwB
	 MsR1M5b4YBVu9DnuXLQDxQ2BY5fBik4N4nH1VMA/iVab5nS2HdofXqtI7Jg1x0JjBA0Oe
	 jImnTzSLyaM4vbCh2oI8fiz3zH1Z6TYT3CaM/oAWqZfckvDRbiJPDJ29SSBo0dBNrU5Uf
	 xVJd7MqnV5B8VdYBFH9uLs2HekZ72Ye0Caz4Lwd8SLbOOGpgk04NId2hiuunqljUSK6/I
	 si6NVgT9V7BOZpX3RxPHeQZd+e6KopGi4Qzhobk2qMjwUevUEeDVYJfQB1dio+jXlSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977901;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=TXAcGnKpsDQx8DyYkjpTouKAGEXbn14eD7tWMq/9JLE=;
	b=4iJvWAsCYuKLyXoNDMfNyE/pC5yvPgdApmKWaDCv7k3sK0jz2anylUT56ANJMz0F4oP5
	 FGVYGhScsQkW3582tC9AMmIMD9VIzWJLTU4eeJY/4k9qgweRNuL0F7xVORXRXKzJafDmW
	 MCo9fdBLVK6P+d3RYCuUV6hjxKi9JdG3SUKLs/9gC+1CL+fzuJQbsP8UK/3MB6KG/KPDS
	 OZH+TXTWO6eO2QUJN+j9OiTJSvKeZE0Waq/9nqIZkyePdoYVBX6kg+7ycMsIESrnakDqU
	 NIxHrvPetzoPJJ1C1/bUkWrYPNpd0S4md1SBZKmtn5jWF4TeP1/I6wthfH/0VsjJh8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=VggESys0;
	arc=none smtp.remote-ip=66.163.188.205
Received: from sonic311-24.consmr.mail.ne1.yahoo.com (sonic311-24.consmr.mail.ne1.yahoo.com [66.163.188.205])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E60E606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 15:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E60E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=VggESys0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793977899; bh=TXAcGnKpsDQx8DyYkjpTouKAGEXbn14eD7tWMq/9JLE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VggESys065CD8iH9OPcckoqIKNhhQdiDBILgxh3R05dQ+9cbPzYNWj2g3sHqkyMhYCROplk/Nln2hvstRjknfnVyYNNgqQQhIr1l16OZUhqcKSFDG2j6HaPrmu3RwY96U3pwpeegzwMTMbmITmlumOwEd0suw7hY6mfNZQ2FDk0Wypd1a7rysNxhbZsHORRerX7chUopVjzSFaazvpXOYLm8MYmWG4Y25T8uCrrWIxceqMTFYcHRQEJm9fviBpQDaNQWcx8z+QSVJX8P+YuEBEanUBCS5h/bqFhRKmvvq121FpRI2PlJ0V3vZhHYP9M4Qs1a55JC4EeLWgjj0fmkeg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793977899; bh=R3zWO1RIHRsIg5ElKzoojtBQt6NenekyU0JA5dM9L4q=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=og2dpduyDRW39LZz14Unm1cJB6TyApq4a1bG5FcrgDtSmnN+0DxFNQ8WllI+hRGSIw32qrmg0A0arIRkygliCHWoYFRNMbLyqjCWzPpYEpXMyqwRx7rGeNC2f/Lniz+BaciK5UMAtgAO9JAZgHDPdWYQ62egpQaNW7WmGj/Gh+64KevVToVU9gxKevvnzOBQM2hevs5R6u6NyPVfn2kw3LL69of9WrDPOwOhi74MMbcZel3H1tGAEN+xeLOZWp/cvCJxvoiAGjI2gmuT2Bab7bqmiBSJfED0XURGjbE/lmrS7KvS+2e0W6DSq3eGQsTh1Hb3fX6OlfUlgC03zKZdRw==
X-YMail-OSG: BBpfnCwVM1kFR1TCLgtUYr57pivtM8Xq.2s9s0en6tF6ZsRhPtBAmcP9Rj4j1Hw
 HA.IsRrDxQvE2CZBOknhhPy8nHTYOqyxEQ80JD5r8vTkqnf51sE9e4QEqL1DzmTNS.2hkL6pbdkP
 5_qyN8mMxtASfC_m8EXPfZpTas1oVsi23jEpwJXgeEzWeh0M_jC0Z9w1P93IBl6aosKCElNptW9a
 GHYFng7ndqI.GmweuJbwnHDgtz.WMUZ5tvih48dfMo0znTcjr.FQqBqp.eIVih9pxNm9zuzQx7lv
 8EJiQW8xQ7tPal2Qeek0u.ZT.mRqi0XXs38ZcSv0BvcQLS1FI9_mxNU8Iq3JxJFTYJ2GZ0rRaMCN
 YDZ_PSuAJKZ1BvahP.zSQDNaaHgpCcv51KDb6U94qbqtK0MSVREXanCZajsYiKF5BX9AHCedsmTA
 a2tR4hNjLbY3a6v0F69cnGxb3iLq8reersb5Z5m8DoE6B0Feujbd.8.5QsI0unTKnBPbSrJe2JJA
 s2GI0iKrUJ0d.ts0BnvWOl4rayABSh.5uq9x7k77ylJFgokf5br6cPSE_ArIsBB1wyo6.40HowgM
 aR5MttHvT_jXuaobnOOQekYMr2h0jtOme6HDqz5ZLFAeWatZF_dRuD8OAOUfyPlsq_4TPXSaPhdB
 Q.f5JjuNJdCkpL4dH3OdRCckipepX9aTcuAfI1OQe6Wf10EMA1QIS6jSct7eIbMH66r24nIC9o_m
 hNjCWyKn.Eyno6wFqg80NOlkHwP67_jReVyvndgBY8GNcwU7IdkxPzOo5kNOaTooDYEFERKRZzRg
 Ni3KTM8f6CorZ0pbvyoBYmJHy6dK.R4qm69YzdZvZduToOO38n3Z05K6OAZDw.kIi1g0iFMQrp._
 l.XMg_hVXDuGvr3ZVMBnuUvOKMulJZw8AGt5RS8cIcnoGV5Ig9jvO6OhmAlYNeK3I86j8s7oExH8
 sQxWhzyYBevaZPUtQB7HlWQki_mgjUds2f3jnieWbUhJVyVqqB7ZWho3xISCzg5eMYoDdYv4K58O
 f8U5Svqfesp.j2pwVyexKTyQndpEpuzCm8sh._cv03tk2H0gaS6VejRoG_SWZRfqseR5rpRSaRJq
 6Ry3jvFXiN7WEofAPitAGhAErfhpQ1moAwlND.GyUKxjRKFvFzMztlBIiV0PG2751sOJGpxSd67U
 E2q0_UuPoFDt2HsxtyiXwa.uxvnfDZXpir0IAczjrfhVYftH10GpHX8rgpA.Xezi10.dJ57n_94o
 WRjz5i8zPq00b4oWA0wfPE.UiPgOp5J4pRqkkrFhsQfoIqitPkxHDMONa_knVfQ2cno6reQz.pv2
 hC1R5zvQthktFKIMWrx174FWj20_plkm91HKg_Xf2uR0VkVQVjZuswAb0YVOSxlxA0yAyLMW9EjQ
 4fCQjwqhWGxbawf2CpysJNIw8hKPHWwI8TM6caTANJ0jyi.gFxwoGOtC91q32Nu_ZZ7au8OEVLFO
 A_vBA.bexiG2IlTnCOsBh5lpoe5IsFYF_dJhtixfv_YYU_LxbPmmESa5JVjDE.tEX6XG0kg9BQ4s
 1vqsB_ea_m7SUrxYH12gdgIUhnuU4lxm_F6pNe7BrvLwLCyYFHINMQ6AeZnEyifV.n79EyUx4b49
 9txSnrQ19ynsswGLsYmwVrodxmynNjv6ZlhmbuCwmGBwMpcDjRBseR1GOMTEUs_rMOWDqyZHgPpO
 AkYkT0d1EEE6hQcH94Vnan60TwSUyqZ.8GmdXB60CnquRYRvfhdOZ5QJuQG7gUIZE908l.gu0lgF
 RShFs.MWE0HdwNEb3UHpEw9vR.Scy1Q.CEoeGtbebHETC66QvES2fF73c8obNi9Nv_EU45_KooQd
 SjV4yApQmIwCj53yDM8REpExsULiuTwgY.S.HlLcPia1wNUmaK1IJ_oUum36qT0QiLWbolsDRWn2
 BZVG9ypzjhpg95XE5Y0PesJG9EW_.AOxNkQhzRUcolIeUZdQ9O68U4FxbcbrULw0tswljQpTFx_w
 Ain58p76XSyrFa4a3l5miJuW.OE9mRPlEOtjNbsbZVMqlPepna.LmfsD3Qg2qniFW3GBwB0AbdeP
 vNXre5NRFm6q_KV3mEjWvoyvY7mx5gnCN5_kunfM72JFR0FfTWSyu2Vs6QfZKozZdMMobZFavsbi
 LTfYB6KYgF4xWrsTyTtu1d1cqf7oKDhcKW8V.PW9ucNcjXsSybZ39_B.0dTiqElPeuKhyq8_8eSl
 yPVAbtwcakX1dHSu9GdsKyAZlfzWEjA6VJXbbBp7huUFwXSovqNjUW9q7qvUJOU9UE1JlDdQ40jj
 qcm48FsRxpAcG9uQDC1ojTZKVbPszTA9iaxr0TBpQ
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: b71e134e-055b-4efb-b6dd-594515e82661
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 6 Nov 2026 15:11:39 +0000
Received: by hermes--production-bf1-6d6877594b-c5dh2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7a76f43bb33c6f70ed2123d4c92ea4ef;
          Fri, 06 Nov 2026 15:11:38 +0000 (UTC)
Message-ID: <12c620e8-b55c-4c83-a015-d788c8ced0cc@yahoo.com>
Date: Fri, 6 Nov 2026 16:11:33 +0100
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
> Bookkeeping is overkill. Let's just not support MAC4 as anything other
> than UTP. If someone wants to add that support later, then it would make
> sense to add bookkeeping.

One more thing, since it affects how much I can verify. I do not have
RTL8367S-VB hardware or a test setup of my own, as I wrote to Luiz
earlier:

https://lore.kernel.org/netdev/9124a33c-55b5-4c7a-b8a7-25d0bd4e6936@yahoo.com/

> I cannot exercise FDB, VLAN filtering, STP or flooding controls myself.
> All testing so far was done by other users who run this code on their
> devices, and I depend on their reports.

This is why I could not read the reset default of MAC4_SEL_EXT1. For v9
I intend to make only the changes needed to address the open review
comments, and I will not extend the series beyond that. Further
verification of the shared code paths against the family D layout needs
someone with the hardware and a proper test setup.

Kind regards,
Mieczyslaw
