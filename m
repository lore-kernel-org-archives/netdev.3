Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794122420;
	b=H01yhTarZTb8CO04cAaL19rM5Bb2iK3/TUxpBIkbLlwEWOvZ/d5kSFHnRWYgPgxMVJlk
	 5gWej5AMWQeAwAi7rvxDl5Pc4cSnEDchYfcNaP0ySikvh5YPQFssuczVoZJdo5hbzy67p
	 cdLwb6VHsKDM9VETko4RydgvChN2WvTDgBjaJQdcCNdwAkP2N9oNacdWb5JB4afI+pmrB
	 RxZO5LYgPx0/3lU3EgQ+eD136R0xOPfSVw2ooz+nhjPRg/RDQiz2xeCrhilH5FVB24k9H
	 agfQ/XRZNTDzMNeyLFn6iIdhkP6Ejp+m0+rXYPMNHS6954FUJPShQM5Te5qMRdbKJTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794122420;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:X-Mailer:References:
	 In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=oK11WFoEYcxKkv5gOP1n+/n0b5JmGN4huhLMKQpylEw=;
	b=FCD7vqPXgSOO/RaZQOyU9Fzi1qifOw8TRShJXhj9613ZYRs3HmGDVeDtjmx4tVqLeXbz
	 R7RAGCFWG+1cMUK3R9UPA7Cf6q0YKb6YdyosaxAVmLrmSiYX805lrBfVumA+KQvs6dXD/
	 ZAhbuWm9UuI5t686mJoIhHglD0bDzaIbmvv1+9HFncxoAgORPB7l+SvZH8438LvW313Te
	 2WH/IMUp0fh9zoTXpTmKPnoFGmvKft8HJU3G0zCx/uLYlNsNg50a9rMuoyjnqtZjF3XiR
	 xz/+Fnk6TdvnvxcpV/+ZgeBBd8YSzm9L0mLHA0VgL4eM/oGnDa+UtF1IAXv4hlRrFSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=VFDZBFhx;
	arc=none smtp.remote-ip=54.254.200.92
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E26606A31C;
	Sun,  8 Nov 2026 07:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39E26606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=VFDZBFhx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1794122369;
	bh=oK11WFoEYcxKkv5gOP1n+/n0b5JmGN4huhLMKQpylEw=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=VFDZBFhxBpsg4a8fgdFMmvshrrlVoQAcFWvoM4UJ0p+D0GaPsEAQ93TE9XBOEk3Lb
	 gnnQ90p9Ga3WWHEBbs+CvWJh5UjTEcxe2UosH218ChliKGWWOMmpNsR24LIg/5T1Uz
	 rDIGG5iSq1yKuUIFDeyUsr4RUf3nVnV3+9RA83OM=
X-QQ-mid: esmtpgz15t1794122363t4cfaa196
X-QQ-Originating-IP: 70UR/8/Qz3+J8nvl4pXEMghTUj9NoHrmNfQe2/YfDAM=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 08 Nov 2026 15:19:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17965104858753304052
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
 boundary=a02f21ac2a7151b86497f96503bce060f3b96109e2e2f1aeb6516b655868;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sun, 08 Nov 2026 07:19:19 +0000
Message-Id: <DMPNAPNEGQ5I.XYUIB7Y8HDCA@linux.spacemit.com>
Subject: Re: [PATCH net] net: spacemit: Hold RTNL lock in emac_resume() and
 emac_suspend()
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Andrew Lunn" <andrew@lunn.ch>, "Ali Tariq" <alitariq45892@gmail.com>
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
X-Mailer: aerc 0.21.0-reader-ipc4
References: <20261105123441.2524171-1-alitariq45892@gmail.com>
 <DMO13SWAGZAN.NYISGLGI7Y5A@linux.spacemit.com>
 <c55c5878-d9c1-4863-bc55-99d334ba2ede@gmail.com>
 <12a95b3a-9c8b-4a2d-9b81-12b3839e64a9@lunn.ch>
In-Reply-To: <12a95b3a-9c8b-4a2d-9b81-12b3839e64a9@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MME7GB1W8aIneB/PcnuM8U0HR8lqg7GEcSYyh9QnR9iBnl8iEvUaLDs4
	6y0C5UuGxSfDnqzxzpUILr176+VdxBTwR1CSnzMDOC+Qh64bELgxp/Hkyp8noy9Of25x46I
	/FnKlE/K/Rv97xcdgLt8WOdpfz7R+SNdoWYkSobFnDgYXdBpBp9BuSteBFDD84LanRBk5yh
	Ci7jACHXSjtxnv/aS2WA8zuGNRSseo75nNLqeuTuZmg5qBuFSR/Dx9aJrngEuMf8thqPwXc
	EgbGXUUQ4uvkfglsErxUet2fT06GQMb0gkzzQLJWyYxuXZwMQy9Ikms3sCuoeOkhyvd5LJ3
	vJrmCD7t6MTpycaEGJDh7ENFsLoa8SLK/+P2VbNLLLzGqOLsiUnfnExMVuJ0XQHBACXY0DO
	r09q5vimGa+iWbPEWeS5/IFEkzkYJl6ZnFHo0VP32ZXEuQJaiksiu1ZpaZwOuk/lDQfmGBj
	tMdKZMa9oASYqrd9h3QEe64zXx1qJndo9TQlD571lEdVKeEzFjKvoXbOaWf32t+FFVy1SBJ
	6jvmOJQjuiFj1UvEZZXvIROxmSK1LikxQNMXJYE3lpnuEMAU5WlRAB3dWS5VvHgXU1P5D9a
	nNmC/JfvFz+lEVgcCtZLOJvwyAgudId9Gkr4W1W/HfwHtVxPQhk4zOsI6AJZcz5TMleTwTn
	i/X4E+fdA0J9T6YDttqRhOgcTHZJk9MTBR7+dAwegXF/fV1t12vT0XNYbnLNuMYGkvxawVO
	4+GY4W2pdZ3X+fcMLzZ4C/W/ls/OqICi4t3fMBjSrbxgqeYBxrKusKgaPqwPO8odPZvsdiz
	NdS02qsMFbCHKtfvsGXdMV/QuOYtbfn8iCJ5xx6eaIR9Jzd4xGm7iFSZQBtubStlAmRiyC7
	3jEF4G6meoq1M9Y4lsS1FQKT2dBOG9SdMUgWxkLLVesRTELpbHSb9Mrj3o3MZOW1+ybznnj
	d0HpuSi8tJRU/67lqDuHmXQ345vrxITw/t40GAc3+NEYV7j2WO7TqZUOr1wZ4KRYsKXoijm
	pr0ietjlLZP164/EV3cCLyj/S3IGn8RRTqcvHSb+rR8LNhkvQ5n79PzcuxYL6i/kZeisyKb
	uG6rS3XrpBy+4PN+1E6IfDjNXH2tz3XnTyxTTTfRjHu
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

--a02f21ac2a7151b86497f96503bce060f3b96109e2e2f1aeb6516b655868
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Nov 7, 2026 at 5:32 PM GMT, Andrew Lunn wrote:
> On Fri, Nov 06, 2026 at 03:44:50PM +0500, Ali Tariq wrote:
>>=20
>>=20
>> On 11/6/26 2:43 PM, Troy Mitchell wrote:
>> > On Thu,  5 Nov 2026 17:34:37 +0500, Ali Tariq wrote:
>> > > @@ -2056,7 +2059,9 @@ static int emac_suspend(struct device *dev)
>> > >   		return 0;
>> > >   	}
>> > > +	rtnl_lock();
>> > >   	emac_stop(ndev);
>> > > +	rtnl_unlock();
>> > >   	clk_disable_unprepare(priv->bus_clk);
>> > >   	netif_device_detach(ndev);
>> > This can deadlock. emac_stop() -> emac_down() calls
>> > cancel_work_sync(&priv->tx_timeout_task) with RTNL now held, while
>> > emac_tx_timeout_task() starts with rtnl_lock().
>> >=20
>>=20
>> Thanks Troy, that makes sense.
>>=20
>> For the deadlock, I think the correct function to call is rtnl_trylock()
>> inside the emac_tx_timeout_task(), which would return if the lock is alr=
eady
>> held and will hold the lock if it is not.
>
> rtnl_trylock() is generally a workaround needed for badly written
> code. Please try to avoid it.
Agreed. If the reset is done in place, the work does not need RTNL at all,
so .ndo_stop can keep cancel_work_sync() as is.


--=20
Troy Mitchell


--a02f21ac2a7151b86497f96503bce060f3b96109e2e2f1aeb6516b655868
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCavAidyEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC9B0gEA1znr4tPpsYVC
nAv98ga0dRZipfyxeRX03GPDfyO2H9kA/0MZoMdmj9AE80+OsoJRT6mWefpeM6Si
aoXyFnKOqZsD
=cK0u
-----END PGP SIGNATURE-----

--a02f21ac2a7151b86497f96503bce060f3b96109e2e2f1aeb6516b655868--
