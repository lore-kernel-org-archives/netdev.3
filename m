Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7606305662
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785739922; cv=none; b=NsocsF04r5G8HsepMoTkxfbtwgZD15p4oGmsfRXiesGctzIYYhV/nKh0E8Da9737uk5EGNFvpLZvZBNlpKwCNp9+7F3vrKmIUieOkbiv+MSusiudaMf8y8rFydS8q43uD+T59tbOvvgVgSBYlW4aE785gW+54kwb88WGgrgkKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785739922; c=relaxed/simple;
	bh=EAHW5pPFzgIgGV0kJ7gY4NqFSH5cYtlM7VTmL2y/W2s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eMP0mR0OxOlxA9Nt8KcgFagW4QroapAPA6Jr771/r29jJ0vPzPsdIDNhwPd/aVHAzb54fvKF0Xq5Cs8I+pCJVfxU0lZghYUIPjEDspXEECrllCV5JxCfxrfSzbcOAUG/ZVzSrzfEyEHbHxipKiMU81ns2I+MD+GthqexTFe7EgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpsz19t1785739857t71ce3514
X-QQ-Originating-IP: R+9mc1hBE4LlDdnxqDWrpEtnDrNqxZ3iNope8Q99NKc=
Received: from smtpclient.apple ( [122.235.139.83])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Aug 2026 14:50:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16887319841127991852
EX-QQ-RecipientCnt: 10
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next 5/5] net: wangxun: add ndo_get_stats64 support
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <amyfgDYpSwj1cyQf@gmail.com>
Date: Mon, 3 Aug 2026 14:50:45 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E750E47C-BECC-49FC-9B47-8B942C1A2D5E@net-swift.com>
References: <20260731074958.19333-1-mengyuanlou@net-swift.com>
 <20260731074958.19333-6-mengyuanlou@net-swift.com>
 <amxh3Ef6FnHNnZQ5@gmail.com>
 <3F8CB138-3F3C-42A2-986E-36E33B0B4F3A@net-swift.com>
 <amyfgDYpSwj1cyQf@gmail.com>
To: Breno Leitao <leitao@debian.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MTDLVpTOglk4b0NwE/TYXhXSRPKjcvpNguVzW9HJ+3Ny9GOjl+MjHqTn
	lQBajG+1VuNVGn7k0J3VYPkg0xJqudZQVTYntpbPcyHbZ3hBCxpPKJvOcp0XjA14fF9682O
	Wu2JbhxE7R0Hb/ydnt2RBgIq4iM/S0ciypqLQ6BNn0qX2Cz/67SiE0inaYBHr+8t+P/XCDz
	7acAaRQ1G6tJGh+gueaEhx4Tt1+R4LtpGwxGraoZgadq7RKmMTd2zDJfzcLQDfM3PHiCKH9
	3rt8taODbpWyq9ozvLBPaSYTSfti6t6xFpd+jAUma7JGoTqC1huX4p63wSPOrzaDmOKu6Cm
	GwvnZfKSrSPSR3y9+cnJ9U/a/7KzXb6PMDvNA68mojiMAaVQ9KeKMioLfmO1ybz1qzBEjJt
	byvX7qiR0NpBH1N/0rhBr/sWIFtnGx95aw58k9+SayuAVRt57GbaoaLd4miuUpE+hvTbCKY
	K6mcydmSSorkZxPAjhFbJgCKUxRo6Bj0U6trA9D44t6W9s2+XQoSXOpMzIQCvh5Tyu9fAgH
	AtH7rDvBW+EceDoudTSuXkBBLMxxtqrlpy5i9o3t6aNfbrX4spqZDyNOgzlW7VEn/hOP5eB
	U1IcgktNfu7q3UobLE7I/9rRIyHueCKJnlWsSOOpORhgbrSDI8vLzY06JVEhWfqRH53fK99
	rErSuCV7payQRVgbJmUNqrOkzzNdlq5XGeWdtRwJpqbrLWE1jMaJstbLG3HsQJXSMMFbtWd
	GePQ3Hf8muwBhzFLvMiRCsx65QHZr+TDZIqMeAF/KktXYSDx2KSyH3bYOgj5xt/A/PYj77G
	zxczvCVKbdDUQpLkvxuSBCtxpKIF+NGzylt6Mx0moLYd7rmrS4z6uIK+03XH7+6mqtrNsSV
	yOVQzP+jkEqXlV1BG9Gt5s0Tu6BxgJy4ffNAd874uv0xGuhOStzNDkXqqCez2sm4f4OXmIM
	7bzOzwhAAV7v0JFipsZUfq6Iz+qhvzGTfFR2+ezk9KXxXzVdIQaC6mEYG9I60B8ok9jh1Rl
	Zcsyfj8DbI8z4to9fxbHUkVlsCB6lJ/YUN9ktvQJ5DNZntQu4i2lAlM9UCC3GBQ7JOKuuF2
	q4Yi+LtFCbEgNUBkL78iX4x5GdHPGAK6PAqMAcP3otov0kLEfwJ13s=
X-QQ-XMRINFO: MSVp+SPm3vtS5BuHeOwZxcAyuZQE6F3n+w==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B47=E6=9C=8831=E6=97=A5 21:14=EF=BC=8CBreno Leitao =
<leitao@debian.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Jul 31, 2026 at 05:41:33PM +0800, mengyuanlou@net-swift.com =
wrote:
>>=20
>>=20
>>> 2026=E5=B9=B47=E6=9C=8831=E6=97=A5 16:52=EF=BC=8CBreno Leitao =
<leitao@debian.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Fri, Jul 31, 2026 at 03:49:58PM +0800, Mengyuan Lou wrote:
>>>> Expose network statistics for Wangxun VF drivers by registering the
>>>> callback.
>>>>=20
>>>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>>>> ---
>>>> drivers/net/ethernet/wangxun/libwx/wx_lib.c         | 2 ++
>>>> drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c   | 1 +
>>>> drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c | 1 +
>>>> 3 files changed, 4 insertions(+)
>>>>=20
>>>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c =
b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
>>>> index ae20733c703d..a4ca01c18c6a 100644
>>>> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
>>>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
>>>> @@ -3092,6 +3092,8 @@ void wx_get_stats64(struct net_device =
*netdev,
>>>> }
>>>>=20
>>>> rcu_read_unlock();
>>>> + if (wx->pdev->is_virtfn)
>>>> + return;
>>>=20
>>> Why you don't want to populate the other entries?
>>=20
>> The hardware does not provide the err counts on the vf.
>=20
> Right, but hwstats fields will be zero, right?
>=20
> Does this early return buys us anything?
>=20

You're right. I write the code based on the hardware concept, in fact, =
this is really unnecessary.

