Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.19.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958318;
	b=wtFm9MTQU319ySOxolNEDLWvPwZSg5PaH3CH1HC6SpjUwl5uf3NGGhbt0sBpp3oI07qo
	 XttXT1mHQAvziahZ/mh9KW/odA9F+nv8e2vtWO3gHS64EoRAFkha0zEb2MPdhOKUXN6Ks
	 mZDxSesMqG3hWQSBxGYkcj/WI5FSOMlA+9bbdP+S9zT1f/gwumOj1+fqmJ3E1iVPYr1e2
	 NtOemaPPKYl6brWyNfC5wEfTQRFjX+G83Ni8y6H18LkcUdS9Wat0BZuXpfMZH0Ndmv+3n
	 I1XUXKJtQXHaSwN/vhA1/rqojNq75UXPakaeyMOlDn7DgJ945N4wfGLC7taH59q99rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958318;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=9/DtOlqcnZlR+V7YT17eJeJ5DWSpW+gyRGTq+hXLQi4=;
	b=eRnCU/aP7+FH9kpQcLgPHkB7my6NuGqTIfuKGCgHD3e81RhK4Oj0ZXdKR7/p5tdI3zkA
	 kNXF4sHLcTgBuI4tc5CfPGW7ZOMGnRyI4yzfWvXiqcuQ3MkKtve1zD2dFGLmoutXZ9SIr
	 f9Gqqu0KQ6jEYGNDi2bEKYgn0DMbE1x3konnYXCWsNWD1/ru6RNW7h/nej3aGc8HlvrWp
	 GQqdo6qwrOPQr4TH8Tc/68SV04gyVGs6dr9UxRksFrkQ4/lmJvGBZE8s5Qm/35TVzaG1M
	 CpX1jyadvkeZol517l0qHJVHfEECoROLUvEse2LzHFG5MMGrBIEzDUKUjx+0L0BnqGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=KfyeBrmR;
	arc=none smtp.remote-ip=54.207.19.206
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2FB606A339;
	Fri,  6 Nov 2026 09:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED2FB606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=KfyeBrmR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1793958203;
	bh=9/DtOlqcnZlR+V7YT17eJeJ5DWSpW+gyRGTq+hXLQi4=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=KfyeBrmRxZC795BGZXcsb8GC8Xj4QqIV53wl1G+HcWaXH8fT4JR/bKrKAiaoDTHer
	 qA6M4gFQFq8C5JniU6h30Cbw85wbTL9efCZx2Jpf/upGxFH8NmBJE0k4UECB3y7d46
	 9kf4o/epgJ4egOOEx84801WS4bphWTBz8EwnujRk=
X-QQ-mid: zesmtpgz5t1793958197tde09d153
X-QQ-Originating-IP: SSnJYTmBN3BhoxreIb1kPVMxIhg0JADN7bMGfACzEgM=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Nov 2026 17:43:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12871150989678230177
EX-QQ-RecipientCnt: 19
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
 boundary=f1f8309b4664d3b53368ed8288ac3d7ae208ce6bdd6cde5c5354fa748c09;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 06 Nov 2026 09:43:13 +0000
Message-Id: <DMO13SWAGZAN.NYISGLGI7Y5A@linux.spacemit.com>
Cc: "Vadim Fedorenko" <vadim.fedorenko@linux.dev>, <netdev@vger.kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Yixun Lan"
 <dlan@kernel.org>, "Troy Mitchell" <troy.mitchell@linux.spacemit.com>,
 "Vivian Wang" <wangruikang@iscas.ac.cn>, "Chukun Pan" <amadeus@jmu.edu.cn>,
 "Siddharth Vadapalli" <s-vadapalli@ti.com>, "Tomas Hlavacek"
 <tmshlvck@gmail.com>, "Muhammad Bilal" <meatuni001@gmail.com>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: spacemit: Hold RTNL lock in emac_resume() and
 emac_suspend()
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Ali Tariq" <alitariq45892@gmail.com>
In-Reply-To: <20261105123441.2524171-1-alitariq45892@gmail.com>
References: <20261105123441.2524171-1-alitariq45892@gmail.com>
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MzZqz+taJMIt9SZKFNWImxRRAgVc+h7Ws1Z+YWOGTgzf/gAmB7h2Z+vC
	7ya7owyEkVzrUS6OerFYKnbgmxjXklHiwTTHb3dQf4RCHpnfLKK/QQQ+DstHiyqVyXTXYCT
	O7YyApiICUDpsFseMG8riEC06BCOdRPNHJT02dp2SoL/GPycejYAkMGqkEQxL5VTxKBqShf
	V3TZfLBYx73ToV5BdVG/0RS4yrNVZ34KTH00OQ4pgtZSN6B2CQBKjFXq9Xr/Jf6W/KxwqMH
	XGOe45P8P4l0505rUuFFS/G90MZZElpKrY57J0rpLR1e/BUv+5dodRv2NyjjUt/lTWAjLty
	qDwB6p/xKfuIWDLbpgt5MWrOXIYoW+wsf9yFk60f/4IZ4q4zCwUrQkRFM6VJbxkSkT8AvNY
	28JhO+5YJtR4oTQK8D+HtUJMpcWYQFvyvtdO4GvkKgs5JsTKse3o84eJpvhlRecjauUstpU
	F1EKgFkBfC6F3b618T1hOfxNVscAbiN6pA8CUs4LONEdMYr3jn/hcFE1R+tfPyEfyYIHVej
	WoejMGkDWnKc1d6QMb6S/7Z9YUZNCAndXbSVaq6gXYzstvfb5+SQSfFFqZJdONKc8BRZkbU
	UWJ9gKe6bOT7o7XbxGHWOtfIBXqYZiXzUmV/y5J05UIHHj1ZvMDRSlzX4x4NzI9suSzKEFn
	bk+ixysM3xUbgf9sSQAV3ZxWhZUKGYXRgqj+S9PmvohJlr47mUojyf5zOz5Z1k2T/u5Y1hp
	8CZJq66eGxxbIXxpVXLle6t/RJPI5F4lKmq93wNGMRg2hkiswADVn6e6gOLcC2ECygsVc/J
	Gv5yn8gez+SXvzwJmRIr33eTmoq//CTclwJaktkD9ShwaPea6MG0cnQGug6ZHkqbUhH2PY0
	QwmkB0DYS776Fi3sL6dryr7Gsjg7koh5Dljxz27WSEH5MWPydnsiy2KAvIyj+hqFePgdmEk
	sTpNstbhLE1UN/weZYoqghVQokVyqEWXL/xtwi66naaG3isWoVTOs9I8hM4KNSYLVTDZLX2
	ymjMQONZKAvKsa+6g9fEvpZoL8sMZhjZf24ogIogUs2xReCa7oBgco8oh6N6sg2YIj1RAek
	OBV5U/hBQY1
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

--f1f8309b4664d3b53368ed8288ac3d7ae208ce6bdd6cde5c5354fa748c09
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu,  5 Nov 2026 17:34:37 +0500, Ali Tariq wrote:
> @@ -2056,7 +2059,9 @@ static int emac_suspend(struct device *dev)
>  		return 0;
>  	}
> =20
> +	rtnl_lock();
>  	emac_stop(ndev);
> +	rtnl_unlock();
> =20
>  	clk_disable_unprepare(priv->bus_clk);
>  	netif_device_detach(ndev);
This can deadlock. emac_stop() -> emac_down() calls
cancel_work_sync(&priv->tx_timeout_task) with RTNL now held, while
emac_tx_timeout_task() starts with rtnl_lock().=20

--=20
Troy Mitchell

--f1f8309b4664d3b53368ed8288ac3d7ae208ce6bdd6cde5c5354fa748c09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCau2hMSEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC8JlQEAndRU8NMombSV
ki0R8/v7iIuQ+4g0XE3owkq22upYmUgA/1pcBD9aP0bGv/WS5y8ksJFFjURLLOBw
QJMXWHSubnoE
=s+my
-----END PGP SIGNATURE-----

--f1f8309b4664d3b53368ed8288ac3d7ae208ce6bdd6cde5c5354fa748c09--
