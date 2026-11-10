Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.6.129.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309745;
	b=KcMnnc74iZ0hdr6pFMn9KfvD9egdWPJDwwO9MImp+G6jprYm0YyAb/w6QvVG7TuNKzTd
	 1n4prtSSNN1tCh1oT+3uu1GNLzaQctKXQAklMPT6hUFkCRFB38J7EqB7XEnOvkpaUsytG
	 SXJ38eNQaStlf6e7CCt4pzVTd6d+wRH6A73OEjw4y/habVPvFSXYkCsLPyZcno9ScfIo5
	 4wiMdjc7VzU2L2P0Rv6Z3kTRk92y+Sbkh9GAL05FXEDMFa4TCHW+U/cL9AtPHMDpWgCdZ
	 dUdwqNu71GiQ/SiRofhU2k4A+mMGaDRyauplTopgZ3ZJddL9kZhNHqBHFr/BP8JUfRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309745;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=FuwOPUuAsPN6nYjdxNUZVqBsEvn8M+a5PZC7B+W1aLg=;
	b=yTE7HPZA/3czQg0ewi4y35d9uGh2KdLdOqrbhriPQWv7OY2v3rIc3FxwjCsZSHtatMxJ
	 cPAvMFfp9Kd4Qc9OnGtkbw/HQJNtkI5qEVdd6ZXokNvGAoCkZr8nINvnmzLLEwI6ybZbt
	 UDZ0p3UTRY7Euv43tZOPFgaVWI/dtfYh7DzCT3WxMgpnzz6Tr/B4KFb2vZnBaSH2A2Vf6
	 TwzZWT8X8BeeqLMmJ5ASf1zXylytikqxpN+vBrFmU9tYD5ov2dZa2odCKI2VI1azK/9T3
	 BlZBa/GWx1hu1vGym47sjWxvbGplRKpQ75nwCdvZmZhBIvo6g0EGJ9GwfQtM8nALoxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=t0h4ss8N;
	arc=none smtp.remote-ip=74.6.129.123
Received: from sonic309-13.consmr.mail.bf2.yahoo.com (sonic309-13.consmr.mail.bf2.yahoo.com [74.6.129.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9C606A330
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90A9C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=t0h4ss8N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794309743; bh=FuwOPUuAsPN6nYjdxNUZVqBsEvn8M+a5PZC7B+W1aLg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=t0h4ss8NMqrDYuS80oU7Ob++Lq8NFQQEEvcc7VmI1Bs37LnfOTC75Qp2wIzBGlJWuMyjP4bBWL4IhROK163wBqXf9rNtvzeCpesTMWchFOgfbY6JMDj/sJsSibJ01xO2I2OK6f+G/w2BgsfROqXBVWrjdIZrQuH0GjQz2+yeCwlXmqsxiJSW+jmqJ1hRebPg7E67rAJicwtJgpJQFEBRgQ4/MCfqAsLnGatpYsrCf42hkpNFkcqP8XefT166g4c81SmJtSY1L7wUbrolnfQrJewyqFk3PLS9p9Be3FCiIpc6c7GVzEeJXvIKwrN5llTS8bl3IUIp4755GbupnIJyaw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794309743; bh=usjoDbwLExODVz9IhcWqYcmh6Qb22BW3mJMHuuVdJ00=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gpUQdQ1Dq8a//H/NCbhtdqWf3iEK19WFrDOmHDs3wgPl2Mjdox29f2lNHfBHCSgaV4f5YsEGBXRjuW30/vmoj+7szJR+0llJJ31fOhYJHZRPrYoGGJ6u7uxB2oQS4pFHUn2PIqzXXRxcpvSbaqE08h6E6+NvFj+lkAbR0qBRt/sQgAzJPQ2RbOdo7JcjvF4PiaMLmC/mqF9IaEhYgr14DA1Mgwi3Ri/UOfaNK02FtuFNQlH+4d4PMTVox6CACsfwjeIAjgwH3y5kh7m+8WKDOwVkScb9FyKPPIx6O8dysfloxK0GJWcElAL12r00Oj5z5LfNfX+i+cNk2xy59uoB7A==
X-YMail-OSG: _g.YofYVM1l0ZDabStvlNGVla81ne_7Dg5UQSvbl5R_IiXvWiFSKxFN_MmX7I37
 xx8GbNcbUKQ4s8jZjLEwmBsrsbOZWQLXGlaOn4tNeIXogskzLo6oil0yYTTH6frJUUEAoNFg9B1g
 3H_gbCFekfChXXzkrP9Sp6JlSF.GGO5kEgBfvQNh5bIJzd0Y4QPcDvveH9gdnWVb9NZR2jaHPnbM
 UwrdO.sEbMIthv1oPC2No.qHRjtc7CRVRSbOP.91L0jUbvVvcZuC9eBiTAeO.dkqFrG8lCl18frg
 QrlwO1f1GWlRNT_uK_7u.qMM1hh2RybyCe4OJWQ883LqL1NAHTxSt.agcN5AQJ3M9h0jgeLRvYUk
 h5AxfduKmcSuQ3ZEJjb3aSmMkZHHHwH41K62vEsJYwTMCsz.aRyQlZF03bc7PzKLDjv27A3iQreW
 .fGrrtWL4h6xi_fATsj37tKUMO1W06T4LqQPZU02wiACKTMQBPeAu9qY.ZVXSlLXMP9KQ6dpUy_i
 HY9YeMMSlgWHF.Gh3KQ7MaNK9UyJ8dG7s.D9ZvYkB.aDS8Eh2NK6OBfhkkT.9QFgukZtmfKGmZa0
 2SRSdae0uj.HJtVZ.RCfcuL6H5eAJmIUPSQHOxcRHosnbhSLDLhbUc_Cht76CPh1eQVIdqPwsbXh
 jT8layWkpnfZvmwNk9pQ7yUxz22D.u.3PGGPcc5SzsSYcI24bdH8xOqTI69imUK79qqHqlowWdVv
 iqovHy1lYlPBJ_0zj5sy8Ke5d6oF1gWfOn4tcxTf7uVI.Te5f5H2kIZ0Aq4hXiSLdzISXiXQve0C
 3qlzdMYkxAybiWr5qWQrriL8npZguqX8FtV3JJQMmM6AlDgJE8hgtMf3VMG3Cmp4tQYDNwRQUUlP
 SMCbDIcpF50SMQVmRGZkPZv.ulT5zanPlqS8Zxk93KSc8P0Ng4PtcoVFXMRmRCyUfk87On.vYjwI
 i.qYF47KJimQzsWugN.baGbUm.KGPhg1LUvY6Pgil_ea5g_BYyk6k3AyidPGTs5wBDdRWkA59xH3
 RsFaeeojO5NNe4kBe12uQGbXzsj_x.FZVl7R0t66CV7unh6w0l50592IVzozh.gaUBuV66FFG5_L
 Z3mcJkObTKPyVkE.RuPmfp2wtey.sxt_FpglZ6FmffYSvTCzWnRCsIxNYhQQLLp1HaBe7wGFG5HE
 OQ_B.PRJ2VERwgowSDNfNoIAaU6n6ULzKvMgYVOj4.AY_RtESAbtE.jSlnRG5X_fca4LkoiBOCTr
 d7aZM6aZ1QZzMP_zBT9woOPwb74uy_NgCn1FBl3tY4jG4PaX.M2cNfdBim7Ger8z1xKVJluj8GrO
 ZBFfE06frMc3H_RCkuQB1NnQwIk5thBvNF53VAOJCx0qXwm5fpPhW7EpDPQGJQBX.EHJGhs_xukC
 iB6tOrn64o_B1kvEi5GfDUhtMk8TNkSqYrTAiHHuSm6rBgXLyqEJ1hZxlLabs4DtYnGeaS3Z9oYV
 xonYdPS1mNlshH4IpSMDPaG7hCIvHyukrICrBQ_iikRQ6dE73FIEOjb0g27cCbJGC55DijnTEF2S
 XpUGZIKHKBSOqY3IGkgfgp6KJ6ZusGDxJJza.qhzmwk9DCXR7bBgPZFZ_ibwTlgK2pwfhfz_7Ilv
 uAXFbkBXGlRed6FjWgj6Ovj3mbZwXYJtfyJYOryiLgIWH34X1hLmLMlVvtHdKyf_klkhgT6eSkS.
 K3zvGwA.z0mQ.I5YWpekFboQ_2T1NSaERLr7ThKOYm7c9TfItmnmfloVdkm__PfLzm0N9Le58udn
 0nF0uOhAsCF0uBfHV7BvLA2xm4M_35PUWTVTa47ir1rnZ5gQujnKn.PDs0uNNnU1RWBX0pHBzOXJ
 r8xJn1nhA40_fvB2AiK1Wfs4SX8aSTlcfYq6_DlJV0TNP7cWQgXmTGPNtodRdNdq3SNF9ZMmnoEW
 bdmD58.kicq0mwmSGr0KBa3zvHe9SAPXtrhcmjyeu0gI.siQmGoLPlcrUx35mdzm5YSY.DEMkUyO
 a_oIbNLtuD9EHdlKX5Eosorjm9_2DszZYPyNTKIZibf_UCthRda2qAhHOe_leupwtIiv1wfvuBD_
 Qx5w6TCQaNxf6l35dJnQitTHUVpQH0KZVnQVGu5XMHh1hebv2OyNpwtKn61c7zxuO22RZWVmXl.5
 6Lj_p3.CjELrO4iiylwYAX8ckxyj5YqNvDg9IqOWQlSFxEQGhSXTpJPAmoX1xNKlbrCNUQBNRlLK
 WX.ePd6nz_WWSFe84Crgvj2JmdgSePvjK.xPJ78gY_._vN5Nzpls6QQzFpyvMH9X7FBkE2PPNQo8
 YQbkoaRnhNJ4XxFU_w81H
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: b433a540-4a35-4972-8725-f21bac015d19
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Tue, 10 Nov 2026 11:22:23 +0000
Received: by hermes--production-ir2-5dd9bf4598-vvk7z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 894a0ccb8401fc70252225115e8d60ba;
          Tue, 10 Nov 2026 11:22:17 +0000 (UTC)
Message-ID: <e8aad7cf-b39c-4341-9fc7-f7102e0ff680@yahoo.com>
Date: Tue, 10 Nov 2026 12:22:27 +0100
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
Subject: Re: [PATCH net-next v9 08/11] net: dsa: realtek: rtl8365mb: re-latch
 the family D SerDes
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>,
 Johan Alvarado <contact@c127.dev>
Cc: gabonpivovich@gmail.com, linusw@kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, gusfmora@gmail.com, kuncy7@gmail.com,
 fabianotassotti@gmail.com
References: <9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com>
 <39e46930-0d24-46d6-8861-5dd309bb7640@yahoo.com>
 <1e8da5e3-0d1c-4ce6-bb3c-4b9b7a5789a6@c127.dev>
 <f84cfedb-b551-4316-8d2b-4d6e06fc151b@yahoo.com>
 <b68807e4-1470-4f4b-8975-e8a70dffd011@c127.dev> <avLkYrPN97sU7HKH@analog.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <avLkYrPN97sU7HKH@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Tue, Nov 10, 2026 at 10:33:30AM +0100, Alvin Šipraga wrote:
 > Thanks for looking into this Johan.
 >
 > I guess if this can be fixed on the SoC side (which Oleg can hopefully
 > check on family D), then we can drop this patch from the series
 > altogether. Correct?
 >
 > Kind regards,
 > Alvin

Hi Alvin, Johan,

Yes, that is correct. Thanks for the detailed analysis. Based on these 
findings, I will drop this patch from the upcoming v10 version of the 
series.


Best regards,
Mieczyslaw

