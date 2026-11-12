Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509446;
	b=b5zvlnLfhVmRVbiwBgGKyO1VeL4WxeTkFePt8XPJW6oHklrFUKMaR9xo0onKNf1p73Go
	 nlpLgQwYdtEU05IItrnnfOBKeqocl4gjsHtZT4ypsVvXm+ohxZToRT0r+qXRf7aohW4WS
	 mbtqWCPErLTe8MJA8avRCZqnAf8tevle9zFfTicE4grN0JSNP/0xqiPPXp/Tk4Rr5DWXF
	 F3IOLDj1LsrWzvxPOQpqDW+mefqD/P7Wx9rEDlP6mfDXbCOApssSS92/Pcw4+F90RIW1T
	 eRjOAELpYka0aqn0L6GzSxawrOJZZowZClK51WpHKn3pu7WyBpRgbNB+BLeqBwe2/mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509446;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=/9hfYc8mGLWS0EBbgfoGxwJddGxq7EOCiuGNd9NQygA=;
	b=SZL2RWQmAlfYCz/slOAdRtfkNhKt2y1/Yuyp6VYqA/wVl58wzmz7I/CsbUN3wlbAeMdg
	 4VarGoONfcvSAYIq4v93NQ3kOtwrxyh4N69sKMn1kckDJ5d47895nmtYh4rRB5fa0N+et
	 INUu/Q+6jzdKsZS55mJJLOXDBCmhM7zNfw6h8SY2t0gPBEacnPvJ6pHQ+4F+KvPFjvM0E
	 1kNDotENYxHQg0j0kEL4aZsK4ku+LfgzQIpSs9c4x8U/MdnpLhw+txz/GI4fyoqDsCjnh
	 TFy9kQhNu5BUSkjWZ4dkOoQ0NSOMM6LzTPgt771AE48LP/vvIBl29pKZVvcyJrtiMCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AiFLb6Hi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A168606A32A
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AiFLb6Hi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AE71F000C6;
	Thu, 12 Nov 2026 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794509445;
	bh=/9hfYc8mGLWS0EBbgfoGxwJddGxq7EOCiuGNd9NQygA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=AiFLb6HiOeVM9TiK2CqMbEehe6eqjE7MPYFPcbl+Ty36JAnIDzrNHa2RC3MXUi2XP
	 tCN3WFYLddPMZUDrkoc1st/5jm2uJHnlNTbSulatcj+GuwZLH2p6mJuC+Wvr+jGJIL
	 zgkMB73hr+RfQwabUqpKaJR/UMYv7AbrovCUn3HBn2fuvC4HMwQsSxybaMVvK+4W4q
	 ri7wo/NUpiG+1OK60op8pyXNJxWQKQvUprMUVpvdHWCEIZpy7hEYPOPbZdf8yREGFg
	 mJCl0t8jXud2zvrZPaM3CimZZLjBz6aznpAIKoXz82hpHgByfL8ILafblBbiCwxIrL
	 RqKOfOZzp+EUw==
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfauth.ams.internal (Postfix) with ESMTP id 621E5198004A;
	Thu, 12 Nov 2026 13:50:43 -0500 (EST)
Received: from ams-imap-19 ([10.64.2.39])
  by ams-compute-01.internal (MEProxy); Thu, 12 Nov 2026 13:50:43 -0500
X-ME-Sender: <xms:gQr2apWpz7dWPYl91gVHictcciFMF6cbugT1ZlCydoMBs9DyclNfJg>
    <xme:gQr2akbmsTywyrgDHyYhz1K1zw89i8Tl_ojr-iOjx9J3_MNMn5U2CvqF7ieWSaf7r
    llfKa7-7ghrGiJdddMRsGxkSnOiRrQaAxowgpxPpdTra03-WOoCCuU>
X-ME-Proxy-Cause: dmFkZTEhKabvwGh6bQrC9XnvAw4ca375oIQt/YLxDq3lPzwt5Es3newiIf9z2bR2VSSMNc
    WAw95UfL/Okc0qrE+rG24RmDmeAJ8nekd0Us4XypIFheGq5I2XabLzKB0OqvC+x/Nqg0eV
    XnGY/oMrilfKAVmhbnl5RrQGf7tuMZvsXNuQEC6K9Od6t6V4YKMzsjWzE4dqOdxwcBrI+S
    62ED3BYaanA557Mgf90iP8tPMkvP/eXq1nbjprF8UHgJTHsY+JykAUamwIa2hW1AWmHgLE
    66BVy5dsxpGbIU2admUju9jWckn7AWiCTU5HqWnzUoxFx6H5MdvXJe1zgbMlG4L3t5AiN9
    8coPZUjEQd19zfgMmYFVV886ALKaNHthMo6C9TMfMq19WppEqIVcFtrwdQUTcChCaErvnn
    XMe6yfQ/47V8DoTcjMPCrxxIhJqWMSWKTTibEIzed3z40fUZkEsqG0inRohk4L9q8+R19+
    Q29klFtWdV+WYQhmpvUcKoFUJ3irq+WboETjQov1Zr5x8xVhWILss1oGcNf+7pJffH99oz
    79gibwYm+9ZIuMdmgvgwi/fqGgOca4lye+WwLc3f2nGS+ATs0tq9HURtqZ4W1hSdZbzAfY
    UZG9N5Ec5R2mYZrOjSGq4UPvlRb9DEUfXxvcUFJZJgWrMEqUzjRspkvPe/tg
X-ME-Proxy: <xmx:gwr2aso53GuqUgMZuvncI51HYpUJnhVl2d71Rpthi8d4vp_UsaUngQ>
    <xmx:gwr2aso00a-b4J0Uit9mb_tuHMmvbJn2kjyoGZ1cR8vxtYstAERR0Q>
    <xmx:gwr2an2E989e4__TCzXxuGEGxicEg6keLr1Z5vHfKnlVX5wWyTM8IQ>
    <xmx:gwr2aiG1X1cSzbN3VJIlHpPCd1dS-5hSPEeNHrnBRSXXWRST9a_GHA>
    <xmx:gwr2aqEVq0vcYdD6vo8I21X_TDLq_rf4eX3aVLj6vSdk63CZXwP8b8sV>
Feedback-ID: ia3204a8f:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id E49BD2F8005A; Thu, 12 Nov 2026 13:50:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: APqG7cBtEf9F
Date: Thu, 12 Nov 2026 19:50:20 +0100
From: "Imre Kaloz" <kaloz@kernel.org>
To: "Elad Nachman" <enachman@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Oleksandr Mazur" <oleksandr.mazur@plvision.eu>
Message-Id: <a09fdc30-cd05-416a-8ca4-9787340fb6c3@app.fastmail.com>
In-Reply-To: 
 <PH3PPFA2D0C836CFB7D296376875E16ECC8DB702@PH3PPFA2D0C836C.namprd18.prod.outlook.com>
References: <20261111101521.9878-1-kaloz@kernel.org>
 <BL1PPFB0715B38BE2E57548F95CCBDFCAF7DB712@BL1PPFB0715B38B.namprd18.prod.outlook.com>
 <02e94b70-d446-4518-8f7a-c0f710e3b572@app.fastmail.com>
 <PH3PPFA2D0C836CFB7D296376875E16ECC8DB702@PH3PPFA2D0C836C.namprd18.prod.outlook.com>
Subject: Re: [EXTERNAL] [PATCH net] net: marvell: prestera: disable port before
 changing its MAC mode
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Elad,

On Thu, Nov 12, 2026, at 09:22, Elad Nachman wrote:

>> > From my experience, if you take the port down, it takes time for th=
e firmware
>> > state machine to act accordingly, so you need some significant dela=
y here
>> > (1-3 seconds) before you write the new configuration.
>>=20
>> Thanks Elad. I found this bringing up the SFP+ ports on a Delta TN48M
>> (98DX3265) with firmware 4.1.0. With an S-RJ01 module in sfp-52,
>> the port came up in 30 of 30 boots with this patch, about 2.1 s after
>> link up, and in 21 of 30 without it. The disable write waits for the
>> firmware=E2=80=99s acknowledgement, and I saw no failures without a d=
elay.
>>=20
>> Is the delay needed on particular firmware versions or devices? This
>> path runs under rtnl when an SFP module changes the mode, so I would
>> rather not sleep for seconds there. If the firmware reports when the
>> port is really down, I can wait for that instead, with a bounded
>> timeout.
>=20
> Your best shot is monitoring what *prestera_hw_port_phy_mode_get*=20
> <https://elixir.bootlin.com/linux/v7.3.1/C/ident/prestera_hw_port_phy_=
mode_get>()=20
> returns as mdix status.

Thanks. I looked at prestera_hw_port_phy_mode_get(): it only maps the
firmware's mdix byte to ETH_TP_MDI/MDI_X/AUTO, anything else becoming
ETH_TP_MDI_INVALID, and the driver never calls it for SFP ports (the
sfp-52 port goes through phylink and the MAC mode attribute only).

Two things the code cannot tell me: which mdix value does the firmware
report while the port is admin down (INVALID?), and does that attribute
carry anything for an SFP port in SGMII mode with a copper module, where
the PHY sits in the module?


Thanks,
Imre
