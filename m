Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C803ADB9A;
	Fri, 18 Sep 2026 03:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789703959; cv=none; b=I71MZ/jkSjo17bbImfzB4bnTVVA59GG5nWgRuzjMC0ih1XSqOrW/DdI6ifZx0FgEMk/m1s3anljKpOpMgCXd/szKjJnV9GqsyJlEWmiLVXSkfdhZ63yfGww/MRRA604IOQphavWNgair1uFbpcRGkPeUDOhtToMlnSJVcCC8CAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789703959; c=relaxed/simple;
	bh=2B8ZkTKvhPAi9c5C0WKfZ0hsj20J1k7WZPUYzZ++HUU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IqFSGKRi917Zy+rSIAogNvZ02BfWVXIx0ZLZxTqn6J0Ngi3J+dXUSM2uNbrT0io2IhHtPxihqca3Tg1+u13TnnC94g2sdXM4lwgjn7qOpmMlRzcrCTUh6t3zYbXLTbgh5JpY4F8NqrEVfRqEhepR+uo/h7bvVsZDd2XqE7CZxdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpsz20t1789703835tc56d9d2b
X-QQ-Originating-IP: zVpUxNE8gwQCwlWGHnuI88s6/ra1uXcLr9NeP0vFfCw=
Received: from smtpclient.apple ( [125.118.25.28])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Sep 2026 11:56:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2156956776955812050
EX-QQ-RecipientCnt: 14
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net 1/2] net: ngbe: propagate resume errors to the PM core
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20260917090050.1927999-2-zhangyunfei1@kylinos.cn>
Date: Fri, 18 Sep 2026 11:57:03 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 aleksandr.loktionov@intel.com,
 leitao@debian.org,
 weirongguang@kylinos.cn,
 u.kleine-koenig@baylibre.com,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CCA2A6CE-8E92-4517-930E-C36101ED0AA6@net-swift.com>
References: <20260917090050.1927999-1-zhangyunfei1@kylinos.cn>
 <20260917090050.1927999-2-zhangyunfei1@kylinos.cn>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Md6GZDcNObI8LAzjO24CSxtmVM14zHR00Zq1BSYjVJ3/JjFGXqQZWRO+
	MpAGBdBp7H9n9T75OVXb2y82bzBXmcEYF3hFCDcB2w15H7A0+kQvTq8oKIbuQTsMhyregkQ
	GYCVY+QOq/iD06138bc8AED9D0LRMj0PER/xXtTZlFnxKwB6w7pNORKu1t3xv00o6dLWAwC
	MF4PUJkiJyBFxk542Ukr50z1RYpTmbuvRm0X0FgFyGzRXzNw+BXtb09OAYjrKMrqACQVu5a
	qh+kmSKxMYL2G6Pebjk9fHZGlEYqTFA/MN2mwaE6TMWCO3p8erdIMLAxsZql22Nu9tlIDJr
	9tVnjTIKjA6v2fbWjd1xfeJ20AVMn061MtmQFWVkkj0G0QsCIA4mjPU4/FxissMA+ZxfrrW
	mF9lL/nyP4B+z/Tzq4xdWwpZRM/8rWRGqfIXc4eurlilsVqNZ90BQxhJUmLKaemb9IMT8zF
	iOcn8rIXqT9DKDs+DMnDGGI9FG5h2/RHk6yxk5yjG7oW9mTaAtoX7GeHmv54CATY8dAbrOs
	QPwb++wMcmrOm11ubCdIbaXDX2Ln8kdIYQZQux73GYz+sZAQTv/6YawIEPxVR1JUD9nh//U
	qdIDsEjE0lLlc6bDEAG8/fBCCdF05/YE69F7/z+EN3OqEVuLabgX37Be3aPdjHSzFGfbI0g
	9yd4SHocskNRmOJ8xIUeVcWb6TPqlTRe74qcWoTge7imqQtLH8034+iqR2M+3hl5dNqO8/g
	qrYSNRdjYoPUZq29YyPl8/lmbgHvDEPzvubCmu6K73GfV7SvNJIizRY6zKuTr4fu0TVZTNU
	MLRuYm+fdCg9ayeGzavLtyI2GCsheCaV84XcTYyG5nCv5OfwIDJoClZ5AKsESxtc3NzlUxx
	jjtebRp/PbsvcUtF7v/wuVRcVPg15uR55YookUs+y/FaxqDy8WDEiSi5HV6a45TUGe/yBoI
	FVRjZcwinEu4r96r/8JumF0YJ1t/dX0VpntknDEJJ6KcwhtNAodNv0mIp0P/v0H6uDgfnuj
	8kkzQeqL3atDe+8DSR9R5nNTZUxYJa1w6nwqG3n+i8OqjJvtfhIBqe0oZQZl5rlXC7hqPp9
	1h1HjDAQCH4TZ+32Q66tIhSFHiqreEVfOlWp2qSpXIG
X-QQ-XMRINFO: Nq+8W0+stu50+5i2nI8zuLxuRRLiG7/nGw==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B49=E6=9C=8817=E6=97=A5 17:00=EF=BC=8CZhang Yunfei =
<zhangyunfei1@kylinos.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> ngbe_resume() declares err as u32 and unconditionally returns 0, so
> failures of wx_init_interrupt_scheme() or ngbe_open() are silently
> swallowed. The device stays in netif_device_detach() state with a
> broken interrupt scheme, the PM core is told the resume succeeded,
> and the netdev never appears in the networking stack again: the
> reset task also bails out early on the missing
> netif_device_present() check, so the device cannot self-heal.
>=20
> Fix the type to int and return err, making the tail of the resume
> path consistent with the pci_enable_device_mem() failure path at
> the top, which already propagates its error. A failed resume then
> becomes visible to the PM core and the device can be re-probed.
>=20
> Fixes: 6963e463256e ("net: ngbe: add Wake on Lan support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>

Reviewed-by: Mengyuan Lou <mengyuanlou@net-swift.com>

> ---
> drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c =
b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 855dc963c610..6d8289e2532d 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -954,7 +954,7 @@ static int ngbe_resume(struct pci_dev *pdev)
> {
> struct net_device *netdev;
> struct wx *wx;
> - u32 err;
> + int err;
>=20
> wx =3D pci_get_drvdata(pdev);
> netdev =3D wx->netdev;
> @@ -977,7 +977,7 @@ static int ngbe_resume(struct pci_dev *pdev)
> netif_device_attach(netdev);
> rtnl_unlock();
>=20
> - return 0;
> + return err;
> }
>=20
> static struct pci_driver ngbe_driver =3D {
> --=20
> 2.25.1
>=20
>=20

