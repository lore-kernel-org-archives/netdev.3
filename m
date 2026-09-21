Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E283A4A4848;
	Mon, 21 Sep 2026 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999261; cv=none; b=MiebInfShj2pKzXl3Xk5w/U0KbrQBrVUOP/pAhyXoY6LsvnDEYRtHcTsGT8Q4ILQMmjWufBMnb7Mixq486obbmcc+4bcFOGD9pT9HdsqfYwaPBqwVMLgmOUZSlIot72zWJ1f6sIB7uQ0TI/Sb7DZMfwHV+FC5t9HWi0wr7wITM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999261; c=relaxed/simple;
	bh=BjKTZbAvk8PZTX6NDEPBbU5QxCiJduqiAoJFAirt5G0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=DFNkc1bxZcZR3gnEox+S/6zzPGQtQFJF4l/0uNL29cXKBQhi7J8QdZyLonEuJ5BN7EyTWOh/sBVuO4NP5iJobhvTf0aaZatyx/IbTssJ7bQKqIH5EuFZwXfAod4Ktrn6v7mtH+b0W9qjtHAaLaCuAYy7w4TUSIrk7iDiQAwrcEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=lwzOx/o4; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="lwzOx/o4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1789999214;
	bh=BjKTZbAvk8PZTX6NDEPBbU5QxCiJduqiAoJFAirt5G0=;
	h=Mime-Version:Date:Message-Id:From:To:Subject;
	b=lwzOx/o4gvVpZRvqkofD7NRSobSfd8818rJqmlrJx/dzgjPVvUgjcsjNpeZllIxCR
	 E23oMhdTm/brnMFPlNXjnSPZ2RbYb9W+bDV2VV+L0XL5hbzca/uNfx1N9tw8AWit7i
	 ErGuQT60OP6jAVKBgn6XnDIJlEite//pqCSJ0XtI=
X-QQ-mid: esmtpsz11t1789999213tcee6ff1c
X-QQ-Originating-IP: e1USqraHe/XK8utXY0OK78zXThfLDLub5KhFAHGc3ZA=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Sep 2026 22:00:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5811935857291138792
EX-QQ-RecipientCnt: 15
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=8db083407c1172cd2c3ba6047b5480e3683357a2fb171ccebc9ea7e618e4;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 21 Sep 2026 22:00:08 +0800
Message-Id: <DLL1RG8HO5F4.3SW5317Y4S1F8@linux.spacemit.com>
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Muhammad Bilal" <meatuni001@gmail.com>, <andrew+netdev@lunn.ch>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <dlan@kernel.org>, <wangruikang@iscas.ac.cn>,
 <vadim.fedorenko@linux.dev>, <maxime.chevallier@bootlin.com>,
 <troy.mitchell@linux.spacemit.com>, <netdev@vger.kernel.org>,
 <linux-riscv@infradead.org>, <spacemit@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: spacemit: clear TX descriptor on fragment mapping
 failure
X-Mailer: aerc 0.21.0-reader-ipc2
References: <20260919191937.271202-1-meatuni001@gmail.com>
In-Reply-To: <20260919191937.271202-1-meatuni001@gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NMLz7BNYansuq7cBx9b01GSNSYrAlBj/Jj69MhypwF17CBPuklNDug9z
	1JO5hBk7YrdxiYOSnn3efUVnPQLhCB7Nb1Z1tKjvxqX908deYXSFrbmfRj8m1x0IIPMUQqc
	5nCvzQdXSLfWyDbJVt2BSlSz/u6r4HmWBdD7sB3FA07upKy/Fc2CZ0SGHWm2rd9+NrHaHSr
	f9ONHvl/wpQ+ZCHBNAxVkFFOuDl4RCLRyyo9uFyaPbjdryg9Mus7OBjZ4c0UkjxSHrPpt77
	EwLEm6m6DyVIb9fWXIDaigFNuaYY0q3K8b30AUUgBRxmVraLMR1Auk6Ur1pjN973LuJyBHq
	XpUTZfIyN8uasLW6/+OIUy9Z7/uYeR2EwwwfhU01tAX+EBypwjSdxCPvyrM8o//90KodSet
	yyCQB6p7qwabEENZ+sSjPLbLyWTEYm4Wb50n//YNuH1IrSKm5rbITrG3pmUHNcCR5BzQVNu
	EXrQkhQLdrqwROrWlgBPnlpPYK1bm344bqV9WY3gVWgB7h7VAnKhq3XUSi8FcrK3nq1z6dO
	JDukbLY6nZ9/vkO7zpH4DLD861fqAC8f0CVq/1gQCsqU9PezqTo4JLFpxXE8DKam6TEUv2o
	hbztu+rkTX++H7m1XGP3XzDnB1rgwr31PsJBFlyiCziC4aN4zjYRlERCiLNWjocCx4TBahc
	/66bYLCcVOY1oY+1yA+wqQ3uZT59oxe45pogLq7mUXYhIduvQ4Y1fzVGTaQfWlYqjwy10iu
	+CE+KvjW1DR+FF+VKivsDfd4dvGzTVKe7sIiGo++aFAxtm3pQYVGfLX3kW3BQGdfZMeqHHP
	mELuBewDppfcd4zkTcP5ETRx8hw9XI3A224NaQy41qm/UN9teQ8MrPTH3THUHLC8F+6ssVL
	nAeoKNMUG7+wd+sEHr7cVGA2AIZAYDBAKf3C5MdjlG1p5yVoi3MfWMEtAWHfJTQWVz9jedC
	lO4NzixRuv5OnNzUqz/0fC639E12YAfrnQgRzh1/LDHnWh7ffJ0thVi+13+BWeEPRY2Hv2q
	G10vPHm3kKtp5wDYy0Vgm5VkuI3f3LroWb6lf4gW21r+RIEr3i/MDN2Vo1X+z1czQ4EvHTd
	S7YxbYCS6na9SjHDdol12pnaULy/Evg+v46zuq3UT8cT1c1sUnx6KFICAbQVpnX9g==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

--8db083407c1172cd2c3ba6047b5480e3683357a2fb171ccebc9ea7e618e4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sun Sep 20, 2026 at 3:19 AM +08, Muhammad Bilal wrote:
> emac_tx_mem_map() writes TX_DESC_0_OWN into the ring descriptor for
> every slot beyond old_head as soon as that slot's memset()'d local
> copy is committed with "*tx_desc_addr =3D tx_desc", i.e. before the
> buffers for that slot have necessarily all been mapped successfully.
> If emac_tx_map_frag() then fails on a later fragment, the err_free_skb
> path calls emac_free_tx_buf() to unmap and drop the skb, but leaves
> the already-written descriptor memory untouched, and tx_ring->head is
> never advanced past old_head (the "tx_ring->head =3D head" store is
> skipped by the goto).
>
> So a slot between old_head and the rolled-back head can be left with
> TX_DESC_0_OWN set and buffer_addr_{1,2} pointing at DMA mappings that
> emac_free_tx_buf() just tore down, while software considers that slot
> free again. The next successful emac_tx_mem_map() call only rebuilds
> old_head itself; if the DMA engine auto-advances into the following
> descriptor once it finishes old_head's packet, it will fetch that
> stale, already-unmapped address.
>
> emac_tx_clean_desc() already treats emac_free_tx_buf() and clearing
> the descriptor as a pair when reclaiming completed descriptors; do
> the same in the mapping failure path.
>
> Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>


--=20
Troy Mitchell


--8db083407c1172cd2c3ba6047b5480e3683357a2fb171ccebc9ea7e618e4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIMEABYKACsWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCarE4aA0caUB0cm95LXku
b3JnAAoJEJgJ74D5MzQvPdQA/ioqCUd+mMep/heePmg5POSbHw82i4VRu6knBx0i
8jH8AQDj75L3k8wrRYCpPUky/Qvp1psGOvf7SoMGSkxnf3IVBQ==
=ZUei
-----END PGP SIGNATURE-----

--8db083407c1172cd2c3ba6047b5480e3683357a2fb171ccebc9ea7e618e4--
