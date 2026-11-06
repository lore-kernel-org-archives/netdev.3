Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.194.254.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975252;
	b=4yYN68ImXchXV+43inExYI6E9+OQi/L2hbyGZ47M4xminESsrwQlGkjK6ffRcCVnPl43
	 wZqWdO2pXf//7+3VfDBRQSuAw6YyogmvIMQHMCUCvAKnEgKaNskZ0FLabwYNsy3MDdub9
	 62uxKnzs56u8/5fvDyOEqtwhNbQdABj0GhdIVpMsobH9otkuudP/ss0HjiJLvFO343xnD
	 YLBNuZ6jLT5DWCOnGU68EP7+OVuaLFpcafFDD9LfasTKQke/b3l12MlcnLhssn+rlHiig
	 gbCadEuatwH0Y6kxS2uPavv+Lza064VuoiHeZAef48L+lR+mwEO0Ku9aiYPdBJf5neA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975252;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=ies+2HW5mTG1O2fNxFjPMdL4QQNBslFCepJ6zX5a7fw=;
	b=tAiypicsX1qJh22QjNig0uLZgjsbrEX/tOcw8vGTM5VcOh1IL+Gqx1MTIJM0phD1VCch
	 VYlzqqnix5vjyg2Dd8hzgD4zXmg/CWRInihug7xgBIF/a97B0QS4tw8VghdIQn9BpVqmq
	 E3Id/o5cSTcRSqwyj0eWdfsd6z1W8dL9Wfk001D0pOJ7KjYvDMIsXI1XFQ6zQVaKXpoiw
	 kNVyBBoXO/1dC6FFAD66C0PUrCSoDk5vDzH24U0axY/KToN/IXDgBxhoNhyDsza0ny28W
	 /6Ddfa0IglMqhs30c4Tsu0+K/Pc8gi1C23lQUaP5PCLgZkNh3J8GXu/plBf+lQKkByg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=eU6Zz58d;
	arc=none smtp.remote-ip=18.194.254.142
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4CE606A32C;
	Fri,  6 Nov 2026 14:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C4CE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=eU6Zz58d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1793975188;
	bh=ies+2HW5mTG1O2fNxFjPMdL4QQNBslFCepJ6zX5a7fw=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=eU6Zz58dH00WEa6FL+zeebtmEJrNcxY/Krp8P3Wzqp4360LcsJf4xZiMXr3tceCcE
	 svAAp2N4byiBKqkFw0QiZKn4HbKLZ74oS4ptwE3NEh3wBkw9nTiaqPw+8ZHFeLI9oo
	 Uanj8YI3WS8/LwOB8uWsKhcxD1s/yj9EzjDvwjZg=
X-QQ-mid: esmtpsz20t1793975182tbd35ad97
X-QQ-Originating-IP: TXe3qKmdAqKHaOhVsQVWL6itOrYqiQ+KBF3bprKbVQA=
Received: from = ( [58.254.68.27])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Nov 2026 22:26:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11997525554458896140
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
 boundary=dccf64d274bd60cba0fa2d9ae238bd5d3708f6eae0880e28d195f102ba69;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 06 Nov 2026 14:26:19 +0000
Message-Id: <DMO74K2MG3D7.15UUOU1O66K6N@linux.spacemit.com>
Cc: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>, "Vadim Fedorenko"
 <vadim.fedorenko@linux.dev>, <netdev@vger.kernel.org>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Yixun Lan" <dlan@kernel.org>, "Vivian Wang"
 <wangruikang@iscas.ac.cn>, "Chukun Pan" <amadeus@jmu.edu.cn>, "Siddharth
 Vadapalli" <s-vadapalli@ti.com>, "Tomas Hlavacek" <tmshlvck@gmail.com>,
 "Muhammad Bilal" <meatuni001@gmail.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: spacemit: Hold RTNL lock in emac_resume() and
 emac_suspend()
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Ali Tariq" <alitariq45892@gmail.com>
In-Reply-To: <c55c5878-d9c1-4863-bc55-99d334ba2ede@gmail.com>
References: <20261105123441.2524171-1-alitariq45892@gmail.com>
 <DMO13SWAGZAN.NYISGLGI7Y5A@linux.spacemit.com>
 <c55c5878-d9c1-4863-bc55-99d334ba2ede@gmail.com>
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MgHozbPPr2uXgP1SLKJNKX0MU8mJtRMwKsqd8FFPf/CApPbZk5H0RdWV
	2IuTYIIQVfzRXjR59LdWeKfGLpM7lGSvOJiXxqsT0L5A12z0BINeq8nr+PgZH78hDygz9jS
	F7dvONFH4P+gorhye0ML7cCFUlMhurd0NX1f/VD3OjE5IPViUZdbrFp5tIyBpym8XD+j0oX
	40Z1FvYJu1EkdwoQDesdQ4E2g9NQGIFWec3Tw6wz7MRkaYgf8cCWQiRInZd4LfC8bGKVKmV
	L7H8fGm3fHsjPR2oxDDa5LPKOfgXnP4c4IgR05Xu6VtbwpUi3ry5FyyT2oIcn0giRMlWZu1
	Qx0eC0bwJ/idAm0zgLrBCrA+q/ZI+xklVpQJ09/QfebNOgd+JOL83zD0Ely7y2ZEDzje+s7
	8w0iYmk19VKgKr1LBtqrlUnlklU/+fK517B+paFsR7OPmnD4rLKpt+ZlEZwRiL6e8zL8Zps
	hqcGhvziGJpyHYSkXkpD0UVGuk1N5sfwc2O0XIC84L3eHHmPdx7FZHUT8nNDyTa8leujFzm
	le1wnXT6WAm9jdsrRHv359l2wRzgK8cA972fDKpbEBka6H0n37XjDt2D5cFV4xbDo8HGGew
	Oli85Otpd0aRaH/rNs7xPBZQ5/ebfeUA7VWsyapuKSfc4XW+DOanf2ELshdJNurI3o4ZObg
	nNZeRzfgAzISi313CFbhRXDvpcpP8umB9b9mCl3ebN7qDX+BUf7cbaFAI3VZsYNynDvetDt
	ZlX9+lJySR6PwQ7XPHBYP1nuK0WnMnhLvukB7blwUhyLX/B/v4tZ8Pq8oSewhNnRhyDHUg5
	1h+8F3NxtZs8QPyWiVRcaJERYG2i7YYpD8ZDGSgJt4ecnkFM/XKazxgCeIfoX/lyWQCVYJY
	NL1n3oxDWcsFu64cC0OIsHQonk9fFxU8qYno89C55tY46CToE3UHS317zaS72rb3Pvi90+0
	BgyumNGf4/DzseVq0Y9c1ZWIJJczll6zAQl9yWqkruf5AlTNBaTjmNhxMVE/CSBKNf7wpwk
	am+u023+iw6pCIuq4sDQJh9hPJ4Y9yc4vuX5M/ofFjBtv5qVfJzeGOw4kRiR2iax+YNFUsg
	AGI3kH5fjr/IAfOH5s3uqgfczHy4AbA9SfPR1EDojgR3mOb5r8cPbs933KhRx4CsA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

--dccf64d274bd60cba0fa2d9ae238bd5d3708f6eae0880e28d195f102ba69
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri, 6 Nov 2026 15:44:50 +0500, Ali Tariq wrote:
> For the deadlock, I think the correct function to call is
> rtnl_trylock() inside the emac_tx_timeout_task(), which would return
> if the lock is already held and will hold the lock if it is not.
>
> What are your thoughts on this? Does a v2 changing rtnl_lock() to
> rtnl_trylock() inside emac_tx_timeout_task() make sense?
rtnl_trylock() there is fine, it fixes the suspend case.

Looking at it, I found an existing bug though: once the work holds RTNL
it deadlocks on itself, on every TX timeout:

  emac_tx_timeout_task()
    dev_close()
      emac_stop()
        emac_down()
          cancel_work_sync(&priv->tx_timeout_task)  <- waits for itself

rtnl_trylock() does not help with that. Please fix it in a separate
patch ahead of this one, e.g. by resetting in place instead of going
through dev_close()/dev_open(). Feel free to add:
Reported-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

--=20
Troy Mitchell

--dccf64d274bd60cba0fa2d9ae238bd5d3708f6eae0880e28d195f102ba69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCau3jiyEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC9EhwD/bCyatTRIBS+r
zpKFQzPzJykRoAVi4Rh6mDltoPZYzRkBALYRVcX6Wn1PJuX0hMwEF/A7ErpRIC/z
5Ba+Vr8flvEC
=Qi5F
-----END PGP SIGNATURE-----

--dccf64d274bd60cba0fa2d9ae238bd5d3708f6eae0880e28d195f102ba69--
