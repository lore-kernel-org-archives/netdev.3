Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674556;
	b=WZHuPLb74/F4hvDfZEuy5CsOWqPQRBo1PdYeneNmT7gwk3mi+fNLquT/PKuGWnJQfNK/
	 FqzEYc3oJpStug2yTAnfBhq3M37fpcA8nF/0l0OFxEbs7LVLtw6StRWb2B3UWTVH4/LYU
	 /Oj/BtVlucRQF9mIIvHp6shab8wzOOgQRQqzcfzdevqH84QFieyd+t9/Ys0IxD/LBVHA4
	 Ah4lRXuy9gaKdkpPmyuBdjDhuqxTK/Qvf0R/cvXkmUR4rov5MmKoPHhRCchBDLSbSeuX8
	 qYJLo1kpxXNtjMtOvkeZrQfakISS0SmewsRTsAvMhUlYmODgmvofQxS9lzLcNuhlmFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674556;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=WeRbh/wN0/oqV/y3B6lUalfWMI187ISQqMh5if+ga/E=;
	b=l8oL+YIue1Ar1ThXRxdTLccYYSWkpdcLUm15M8WE4X5l4tq4FsfqPs2M7i7hfKwhTDKm
	 KljPH5Nf/ENVBw7KEPh6XPr+TZkrzW512BOgg5uZYcVafLA/5mPiwFHUUQKF7SOrulDSW
	 gjHlrA1eMHzKzaED3+p+d9w2hmtlOH60yGXz7doOxlpd0glA3QAmaEAuviBrxsx6i/Xvc
	 qgmfAqS0278xJou32a6RtPl1NUtDQU+RNNzDSbFr7LSLBxSlaZQ7fQcD9aqLamywf38YJ
	 tGgXKkDj9KTo5xWeh8xT/ShA7w+4rlrQlaTFqVqWGi8yrYsavldEA2DQ7ZmI+tSoLlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=B4f7CQTx;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98CE606A31E;
	Thu, 22 Oct 2026 13:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E98CE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=B4f7CQTx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=We
	Rbh/wN0/oqV/y3B6lUalfWMI187ISQqMh5if+ga/E=; b=B4f7CQTx5dydLOhn9M
	SL2hK+yNiAAr7DxEGR2HXY6TqCVoqItYnNXLfQGywqsZwriQGlosG2KAC27ha/7Q
	pWApG9JhpZsYANrTHniHkF9JlNZKo+r3xRa6O4vuMhsY0VlSVroKcBiqR/bdB4Fy
	mft0tj9Cjtl6R0+lOMlmj63Fc=
Received: from u2.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnb3XQCtpqMEjsBw--.50219S2;
	Thu, 22 Oct 2026 21:08:34 +0800 (CST)
From: taozj888@163.com
To: theo.lebrun@bootlin.com
Cc: andrew+netdev@lunn.ch,
	conor.dooley@microchip.com,
	linux-kernel@vger.kernel.org,
	maintainer@kernel.org,
	netdev@vger.kernel.org,
	taozj888@163.com
Subject: Reply to Theo's questions
Date: Thu, 22 Oct 2026 13:08:24 +0000
Message-Id: <20261022130824.589241-1-taozj888@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DLKVCOXTNGVZ.3CC6KFXDIFJ3X@bootlin.com>
References: <DLKVCOXTNGVZ.3CC6KFXDIFJ3X@bootlin.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:_____wDnb3XQCtpqMEjsBw--.50219S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr4DWrW5WryrCr17Xw47Arb_yoWrAFy8p3
	y5Gr1jvr1kJr1fKws7Cay2v3WrXr95GF43Wr15GryIka45XFnIgrW7t3yYqFy8u348Wa40
	vr4UZasak3yqgaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUSfO5UUUUU=
X-CM-SenderInfo: hwdr6yqyyyqiywtou0bp/xtbC+RQJ0GraCtQOvgAA3q

=0D
Hi Theo:=0D
=0D
=0D
Sorry for having missed important things. =0D
I would like to append some explanations here.=0D
Please see my answer inline.=0D
=0D
=0D
Thanks,=0D
Zijin Tao=0D
=0D
=0D
At 2026-10-14 01:55:03, "Th=C3=A9o Lebrun" <theo.lebrun@bootlin.com> wrote:=
=0D
>Hello Zijin,=0D
>=0D
> - I'll stop replying inline because you seem to be having issues with=0D
>   your mailer. Please fix it to ease the discussion.=0D
>=0D
>   See here how your email looks:=0D
>   https://lore.kernel.org/netdev/63731290.3f0c.1a1198fe993.Coremail.taozj=
888@163.com/=0D
>=0D
> - Your V4 commit message says "Fixes: 89e5785fc8a6" but that is wrong=0D
>   with the current patch, it shold use 4df95131ea80. I don't=0D
>   understand why you are talking about the changelog at the same time,=0D
>   this is unrelated.=0D
>=0D
=0D
=0D
Yes, I made a mistake in V4 commit message with an oversight, it should use=
 4df95131ea80, so=0D
I just revised it to 4df95131ea80 in the V5 patch, and I will use it in pos=
sible later patches.=0D
=0D
=0D
=0D
=0D
> - You skipped over explaining why your dropped the start_xmit diff.=0D
>=0D
>I'll have to stop reviewing if you skip over parts of the messages.=0D
>I gave you a TLDR and you skipped over the first bulletpoint.=0D
>=0D
=0D
=0D
Sorry, I forgot to make an explanation here, maybe due to an omission.=0D
Now I would like to amend it:=0D
Actually when I started to rate limit the error messages in the data path, =
I saw =0D
the netdev_err message print in both the gem_rx_refill and at91ether_start_=
xmit,=0D
and I knew they are also in the data path.=0D
But for the following reasons I just omitted adding rate limits for them:=0D
1. For the netdev_err in the gem_rx_refill, there is a "unlikely(!skb)" to =
check if=0D
the skb is NULL which is a rare case,  so I think it's not so needed to add=
 a =0D
rate limit here;=0D
2. For the netdev_err in the at91ether_start_xmit, I think it belongs to an=
other vendor=0D
which I am not familiar with, and I didn't know how popular it was used, ev=
en I was not authorized to =0D
change it with my will also.=0D
=0D
=0D
If you think it's better or needed to add a rate limit for them, I would li=
ke to do it in later possible=0D
patches. =0D
Would you please give your opinion here?=0D
=0D
=0D
=0D
=0D
>Thanks,=0D
>=0D
>--=0D
>Th=C3=A9o Lebrun, Bootlin=0D
>Embedded Linux and Kernel engineering=0D
>https://bootlin.com=0D
>=0D
>text:=0D
>Mime-Version: 1.0=0D
>Content-Transfer-Encoding: quoted-printable=0D
>Content-Type: text/plain; charset=3DUTF-8=0D
>Date: Thu, 08 Oct 2026 14:59:55 +0200=0D
>Message-Id: <DLZH4LPJ36YW.1CP7RL0J77DHN@bootlin.com>=0D
>Subject: Re: [PATCH net v4] net: macb: rate limit netdev error info print =
in=0D
> the data path=0D
>Cc: <stable@vger.kernel.org>, "Conor Dooley" <conor.dooley@microchip.com>,=
=0D
> "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"=0D
> <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub=0D
> Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Jeff=0D
> Garzik" <jeff@garzik.org>, "Haavard Skinnemoen" <hskinnemoen@atmel.com>,=
=0D
> "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, "open list"=0D
> <linux-kernel@vger.kernel.org>=0D
>To: "taozj888" <taozj888@163.com>=0D
>From: =3D?utf-8?q?Th=C3=A9o_Lebrun?=3D <theo.lebrun@bootlin.com>=0D
>X-Mailer: aerc 0.22.0-0-gc2f86b7abde3=0D
>References: <20261007053211.572073-1-taozj888@163.com>=0D
> <DLYI3O7PFN94.V7VH3HSLKEMD@bootlin.com>=0D
> <63731290.3f0c.1a1198fe993.Coremail.taozj888@163.com>=0D
>In-Reply-To: <63731290.3f0c.1a1198fe993.Coremail.taozj888@163.com>=0D
>X-TUID: tHkCkOndXaQQ=0D
>=0D
>Hello Zijin,=0D
>=0D
> - I'll stop replying inline because you seem to be having issues with=0D
>   your mailer. Please fix it to ease the discussion.=0D
>=0D
>   See here how your email looks:=0D
>   https://lore.kernel.org/netdev/63731290.3f0c.1a1198fe993.Coremail.taozj=
888@163.com/=0D
>=0D
> - Your V4 commit message says "Fixes: 89e5785fc8a6" but that is wrong=0D
>   with the current patch, it shold use 4df95131ea80. I don't=0D
>   understand why you are talking about the changelog at the same time,=0D
>   this is unrelated.=0D
>=0D
> - You skipped over explaining why your dropped the start_xmit diff.=0D
>=0D
>I'll have to stop reviewing if you skip over parts of the messages.=0D
>I gave you a TLDR and you skipped over the first bulletpoint.=0D
>=0D
>Thanks,=0D
>=0D
>--=0D
>Th=C3=A9o Lebrun, Bootlin=0D
>Embedded Linux and Kernel engineering=0D
>https://bootlin.com=0D

