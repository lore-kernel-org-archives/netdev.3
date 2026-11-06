Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958311;
	b=zmgJr/uUWBq1HGleCWSU1vkuA8GRWkc3wH1Y6QFIK8JlFofA05FbMr+EoWqNvvR+BYss
	 FJc0QWVbqZNOi45w5n+QgJDxfe7Hlo4Ca2becINchIl4E9GoH/Ujv/AxYUbudl4GuKrjy
	 UrXv9Trs7ZxrIdMxI4gUDi47EiOe8R4+WT/6Bc2iY0Am/KPnrmlitTqIlcdfx/Vz8i9H5
	 +7oABagV3eA6HAEQrr7MZ/gcpyGl6CdyuszF/UfGLcyuDM8modWGY81pVl1YSt+TOR3MQ
	 cskCSSc+Zd7KRH4VR5yr77NvCeI7MMoHyXKujUWa8T32QHG1wxL3jGkWlXDJe5MCvEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958311;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=blMJGbxMwm6av2/iDvDL9moahXaJKRpPkibjKFYQdkI=;
	b=UfP30RX/MfmGAsKUkECcUp40zOK/DxtuLGIGdVOGpXXPkE7M9fMoTwcay8f5AjpGU3tL
	 Ez2REEj5iRrlt5RU7D4bY6ZiV3Y6OWC7NG7vGmFHnAthHx8+zLGAiEDsSId4m4rZGOg/9
	 2nf0s8N4RhBSFSEHCYrMxI0oAuJcvb6OddKHoi0JyJG/72hiW/iSK/RdrMjk89034pGm4
	 ZPp+M8KevqAiGdeu8QpQ3RzvRuAHZuLu0a1glzZ7c7v7WScX7yrhhGJjXL80O2hsZRnwr
	 Td7yfVWRVrYJyBROdNPTM//LuslOwGTf6wIy89OdqjGLXUkUn7DJhAP82SXAPkZasBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=fguBcwZu;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0837606A333;
	Fri,  6 Nov 2026 09:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0837606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=fguBcwZu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1793958204;
	bh=blMJGbxMwm6av2/iDvDL9moahXaJKRpPkibjKFYQdkI=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=fguBcwZuma/+ZTYPeBCBS+YwpzOB/uE6cevPzKfZJUSFEbY6XwfJbNJbEXCJLmLY+
	 mKGW+Lhby4ramecbS+iIUioq+YKNeaTiFGSbivos/UzPTVy6f94sWZhaOo6KIY1DH/
	 xb4E+ZF9OB1eQVXts7u40vw1rCVnlq6hc4Z40rKY=
X-QQ-mid: esmtpgz15t1793958202t3e9cd9d6
X-QQ-Originating-IP: jIuZSmu909T2mXIbvXI+whezccbjBGBVhrC1Z/FFRxU=
Received: from = ( [58.254.68.27])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Nov 2026 17:43:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8979647044632498265
EX-QQ-RecipientCnt: 20
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=a74825bda5efc2129772b0dfb928ded8e9c9b2e043bd604a7be0814b50ab;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 06 Nov 2026 09:41:31 +0000
Message-Id: <DMO12HWY5N64.2IJ5XMUKM8WWR@linux.spacemit.com>
Cc: "Breno Leitao" <leitao@debian.org>, "Ali Tariq"
 <alitariq45892@gmail.com>, <netdev@vger.kernel.org>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Yixun Lan" <dlan@kernel.org>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>, "Vivian Wang"
 <wangruikang@iscas.ac.cn>, "Chukun Pan" <amadeus@jmu.edu.cn>, "Siddharth
 Vadapalli" <s-vadapalli@ti.com>, "Tomas Hlavacek" <tmshlvck@gmail.com>,
 "Muhammad Bilal" <meatuni001@gmail.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: spacemit: Hold RTNL lock in emac_resume() and
 emac_suspend()
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Vadim Fedorenko" <vadim.fedorenko@linux.dev>
In-Reply-To: <6c36ec6d-5bc8-4ac3-8ad0-79eac7873b67@linux.dev>
References: <20261105123441.2524171-1-alitariq45892@gmail.com>
 <auyG7hGJtMzV0Gbi@gmail.com>
 <6c36ec6d-5bc8-4ac3-8ad0-79eac7873b67@linux.dev>
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Nt9jTSMqbQyw7EzQ8rBzq4Z9Zp4Alencx3ESmXDi8+V3mLaZZKAMQxag
	eMH/LEvUPhGMVz7ZJLR824JShUJQPkUwqRJrIqVQR8I+1vO1nnybph8pvo/4ASeUSejXE9s
	Fmdyu1SlYhXey1BW+R8MtZTV7/MepWDoy/+A9mLyPstGL8fXZznbExmEe7WVV6+1Mq2pmdX
	ukmf6WfY/X9MtRoJWdOVnOWquAk/TPWndOik7BoV8QR5kzbYGK1P/sMgffHeN1giaUlByfs
	02qFY+770r7A91OYa6+i6wWHeTnhrNFp6N3xJEVTb67IekgpUAsdIHn6b3JGAF/80WVJw00
	OTtwMp13ToR+CSXODrzteBTBRSZ8USDlYEb3UCzrYN/b7amLZkudY3wy6DcniHPRIJZg7es
	s4B4jB5euwKb2KFCPGw6vFmcKRGnsapzAKw5A36UQQwk6ApnwnH75rwyXvA3KrmYQFcLUlc
	Ll8gRK7GZvfzrJZlXkqX1b5nkAfDuCU+wvaEMfOUSqO2IJ/Z2j3I9AQb0afLUrDwnKpviY5
	dDeWAstsXz1nLcrZz+oqDVC9kX08NjUtwvSWeOiokRZYFUXJRiBD8mMbm8Ah0MTAxq3jabs
	XFh6IgD/Kbedgm/oqfEQZODcAadSNlzMeRvhJ19T+aIRPJYprZUsLFmm3kFMgNWTNNP2Pku
	0lUlAV1Ti/Ee0dQuIpHd7Md5HvfFnj0m3tHcqSrxJwQ65jDTPlQGkBA+qG3F+OqL+kysm7i
	cHvxRnUO197e9QnSMFpzqAD/j9YUHB8UZ/zRDlB/0CecNnzlRghzXULKm/uk2gsel2HvtUI
	K1bItrZ03usGjV07KDUAbRuttFUnzgyyavWvkUHoSv0UwVzumMoqk0mWccv2SBJeA5GzBeh
	k58gg+4IdTIXdOsvjm7zxaQUSVIN0lTE7GAXvu9iaD1IkAUIrgyTCoC/SZx5iF+Gzc2eSaN
	vWGf9+uMDzvoiqhzwcNgO6LWC94e59IplSC0rOixxp3HbPg7JiEH2QV3oD3OF35/uKcMJ57
	JQ7CM05sUha82fzRAIKckKwM/G/8pvpEVaGVQePkn60bZKdeVabLFCkfspO5VsqWqZkICvN
	agVX6jrGf0WUHwL39XMBR7++mlRm4d0CY5RZRvb0nrW
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

--a74825bda5efc2129772b0dfb928ded8e9c9b2e043bd604a7be0814b50ab
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu, 5 Nov 2026 23:28:31 +0100, Vadim Fedorenko wrote:
> > This would work, but I am wondering if it would be possible to call
> > rtnl inside the _open function, when dealing with the PHY? in other
> > words, shrink the time rtnl is held.
>
> +1, especially in emac_open() rtnl is needed only in error path case

emac_open() and emac_stop() are also the driver's .ndo_open and
.ndo_stop, which the core already calls with RTNL held, see
Documentation/networking/netdevices.rst +214. Taking rtnl_lock()
inside them would deadlock on every open and close, so the lock has to
stay in the PM callbacks.

--=20
Troy Mitchell

--a74825bda5efc2129772b0dfb928ded8e9c9b2e043bd604a7be0814b50ab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCau2gyyEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC/sYgEArnzrvoEorz2G
Y2hnIBkthr/roqcA3mN1Myib4RGNrAgBALHeFO9LRWtQPHq465XKysk/b8m4tfA+
3Ot7ASy+eIcE
=2hA2
-----END PGP SIGNATURE-----

--a74825bda5efc2129772b0dfb928ded8e9c9b2e043bd604a7be0814b50ab--
