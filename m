Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211937;
	b=ztZDrCNyo1EIsOXQj/BqximKePfMlvhbfZrv+9V6qYOP7rix77wQ9JenI1Zi0K5AFeSK
	 eS72/hFL8VJkWHmE5+EqTM07hdy5YXAaln9KFGVteV3NP+NQwNnrYiGKvArp5IbC6TEFM
	 x3j9JGmskYZdAzSgJxVGX1vWmaqoatoFZc7Uu8/UfYRO2Tau3/LPOlqv9XnSmfNRVEaYr
	 qUrJ9YSlW5TKdmMD2eJyhhnlfRXZ1Ecjyq8PaYREzuE5VLCbBXxorFiFYEcrkDU0xUNVu
	 pl/xoFDaym7MKdyDhQHJv6qht5rZhuvqss45jAER2NCsnXEkU2wk3ntC5YAy9eC6X6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211937;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=rorBGLAsniE2vG3yATMjVG80a6o5W4YIh5/81HTrjZo=;
	b=Sci/h/WIrZsSFPOaG6HeN3/Jo3FiJUmyM4d4AaSiAbLmUap8/Tfl6dsxh4HCtpg/OC7X
	 /nwiRYfZ+BRDgFOcncLzKUMBrTSPoquPvEd5Z6eszZ3TMHBuFqrk/A/4sk5ySbX82QWEV
	 BGi3Xw8Vo2B+fF79/oGWB05AMIKlRFI/TgolF5TwHU+ucG6ISLTxJIrGASzkPpLHDePCD
	 vbtZw/AzRmbHqOXwm/lKAeXtqYElLPO2TaDWCxGT34RXhoZcyKE9dp+zkJUYgACvd6SAT
	 FKx7l9inaOC/6hAx1/OqdUr722W6cUYgMDPJtPoClv11b9gulM809L1aMdhm7k/d2mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=Clebw8yt;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F511606A321;
	Mon,  9 Nov 2026 08:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F511606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=Clebw8yt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1794211865;
	bh=rorBGLAsniE2vG3yATMjVG80a6o5W4YIh5/81HTrjZo=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=Clebw8ytDEyQdWO4tsGxY8B7ZQFBe3y3PKjzeCj9sHWQt/HWy/sno3CbDARrbC3Yf
	 aPAhqfH8M645I6bFVerOF4CwZK0n+QW7J+A+8AEIKKegC6GIX7nIeMdif630LIlE0P
	 P+3lcXtxf2STZNV5Fh9SVngeT4KOtywVNioLsKm4=
X-QQ-mid: zesmtpgz7t1794211858t8407dd36
X-QQ-Originating-IP: ttxQFy42B6HOpJChlAzs7cKsMszT5V8pJkxIGpqntUU=
Received: from = ( [58.254.68.27])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Nov 2026 16:10:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9920573175547933257
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
 boundary=451327d1c3297fa83e6d3c22c14fc23d5eeb61071de10435f2daa7ad48fb;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 09 Nov 2026 08:10:54 +0000
Message-Id: <DMQJ0R4QTE6R.2I492KA9N85CB@linux.spacemit.com>
Cc: "Vadim Fedorenko" <vadim.fedorenko@linux.dev>, <netdev@vger.kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Yixun Lan"
 <dlan@kernel.org>, "Chukun Pan" <amadeus@jmu.edu.cn>, "Siddharth Vadapalli"
 <s-vadapalli@ti.com>, "Tomas Hlavacek" <tmshlvck@gmail.com>, "Muhammad
 Bilal" <meatuni001@gmail.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: spacemit: Hold RTNL lock in emac_resume() and
 emac_suspend()
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Vivian Wang" <wangruikang@iscas.ac.cn>, "Ali Tariq"
 <alitariq45892@gmail.com>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>, "Andrew Lunn" <andrew@lunn.ch>
X-Mailer: aerc 0.21.0-reader-ipc4
References: <20261105123441.2524171-1-alitariq45892@gmail.com>
 <DMO13SWAGZAN.NYISGLGI7Y5A@linux.spacemit.com>
 <c55c5878-d9c1-4863-bc55-99d334ba2ede@gmail.com>
 <12a95b3a-9c8b-4a2d-9b81-12b3839e64a9@lunn.ch>
 <DMPNAPNEGQ5I.XYUIB7Y8HDCA@linux.spacemit.com>
 <ee3f414c-fffa-41e6-8bec-6af7ce676c4b@iscas.ac.cn>
In-Reply-To: <ee3f414c-fffa-41e6-8bec-6af7ce676c4b@iscas.ac.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NqA5U4hogVD1rNr39/l0nmxRGaWTgVLB9O3rrXhJ67gjH6FfZIRvrfzd
	zV1qpEyLncy4dj5z0miNXFo7TJsZenFpjuj0XIuSI0zy8aockZGh52HVtmxHfM/dZxnlKAO
	Fyp96VwkT32VjsCbBVOQZEhVxrDYxAVsboObzqEdNiqW6gZrWmEWPgsGvJIGSVzF+ObZFFH
	8OAVXOiWwlQGW/iMAnL5S6CirNPHJvU5Z1zor4yzzgDyXkW2mcW1/H8GEQYl6V5mxrgzFeb
	Tq7l19XAG3ODZaJ7voTdnyJnBG7Rf+3xduM/abTD9r5+wnMr4UjLx0/N5hXucu2oMRlrCyx
	Ey6H1Dkc1XktusU/W4Jb0s27aPdEj26QFPd1UPDbZXP1wQ116Nq6KjkWlvwNuOTQW1VWLUl
	NTC1tfM/aEKXdWqHrw2roXGd/+zigpHaeVIiFDSwkLNPpMchDulil9yZSUruNt3kJZxe1km
	jxAYlB95h4ezGqcmf7cjDcHADgAfUr022EbmPBkccBS4Fvh1GwoIH+PNFupWIqawWLzpIua
	LciU/iyftDBMo0TALkoWD10mHc/58HlzLmuagG+Kd7FcRT/hHsX2+8eFxyPujgO4NWxTymX
	K24TPMx3nSbFThiKmFoPpdPacm/GqUD9zBtznpiwVJ3uZixBTKeUGLRmVsa58n4B9AIsnOT
	lEiaoI19qLEz6+OyYwjTLd9ii3EoeKXbTJcJ3UTbmeHux8992hn7SG2tDCBOaz68W6SmhXL
	BuXyhjMCLiqEx3DaJ/OyQCxFSuwkfWIakLWBTF11dwZYuO+xlwlj5Xu2IeEE43gNvXdAy2E
	q2BLCDYtiBI7pTnb7fq2x1Ojsli9u8N+6XR91p6gPFCYv74RVRmviLuc/FSsO68+KN17Qdh
	7uzv+zBEox1J+aV7DCSqj0cZZzgSzzrX51FLdsEpsJVTACfmppPEzgKMCIVU+jfjQs7ti77
	3At3Hc0d3p0wIvYcMa3tC8Z1FR3UehqCAT2Zwj/6sSCrmsAcHIPbdDMtE+B2nLhsg8PN5lX
	BqYaeH85C3uEZbTSMsB1Q6SjqhI90IGq6+srQS0CrENVfbrZ+gqvKcRPcgUbW0QMHXhNj2N
	q1mNaXQL3kAGVAwSXKNF1zg3ctbZmvAgq6sGK27buKghCnTgPt5gfvzzkOe5jDCff1+a+/k
	bO3x
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

--451327d1c3297fa83e6d3c22c14fc23d5eeb61071de10435f2daa7ad48fb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Nov 9, 2026 at 7:59 AM GMT, Vivian Wang wrote:
> On 11/8/26 15:19, Troy Mitchell wrote:
>
>> On Sat Nov 7, 2026 at 5:32 PM GMT, Andrew Lunn wrote:
>>> On Fri, Nov 06, 2026 at 03:44:50PM +0500, Ali Tariq wrote:
>>>>
>>>> On 11/6/26 2:43 PM, Troy Mitchell wrote:
>>>>> On Thu,  5 Nov 2026 17:34:37 +0500, Ali Tariq wrote:
>>>>>> @@ -2056,7 +2059,9 @@ static int emac_suspend(struct device *dev)
>>>>>>   		return 0;
>>>>>>   	}
>>>>>> +	rtnl_lock();
>>>>>>   	emac_stop(ndev);
>>>>>> +	rtnl_unlock();
>>>>>>   	clk_disable_unprepare(priv->bus_clk);
>>>>>>   	netif_device_detach(ndev);
>>>>> This can deadlock. emac_stop() -> emac_down() calls
>>>>> cancel_work_sync(&priv->tx_timeout_task) with RTNL now held, while
>>>>> emac_tx_timeout_task() starts with rtnl_lock().
>>>>>
>>>> Thanks Troy, that makes sense.
>>>>
>>>> For the deadlock, I think the correct function to call is rtnl_trylock=
()
>>>> inside the emac_tx_timeout_task(), which would return if the lock is a=
lready
>>>> held and will hold the lock if it is not.
>>> rtnl_trylock() is generally a workaround needed for badly written
>>> code. Please try to avoid it.
>> Agreed. If the reset is done in place, the work does not need RTNL at al=
l,
>> so .ndo_stop can keep cancel_work_sync() as is.
>>
> Thanks for the diagnosis and suggestions.
>
> Although, maybe we could simply avoid cancel_work_sync() in emac_down()?
> emac_tx_timeout_task() checks for !netif_running and does nothing if
> already down so it should be safe. The task cancel_work_sync() in
> emac_remove() does cleanup on unbind so the task is not leaked.
>
> This seems to be the pattern in other drivers as well. What do you think?
That was my first thought too, but I'm not sure netif_running() is
enough here. emac_suspend() calls emac_stop() directly, so
netif_running() is still true and a pending work would stop the device
a second time. And since the netdev is devm-registered, emac_remove()
runs before unregister_netdev(), so the work could be requeued after
the cancel there.

So we'd still need to cancel it in suspend and remove, and at that
point resetting in place looks simpler to me. What do you think?


--=20
Troy Mitchell


--451327d1c3297fa83e6d3c22c14fc23d5eeb61071de10435f2daa7ad48fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCavGADiEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC+e2gD/YgsXO0i+wbp0
YbJpT9nglIg76qI/eZv+U64XzNFHF5YBAJh+8gKVh4eYAy2JDB7r0FgzWcGReBGG
GbVSaS7QWJkO
=YcRX
-----END PGP SIGNATURE-----

--451327d1c3297fa83e6d3c22c14fc23d5eeb61071de10435f2daa7ad48fb--
