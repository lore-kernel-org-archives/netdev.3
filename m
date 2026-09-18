Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B873644DE;
	Fri, 18 Sep 2026 03:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789703934; cv=none; b=T1tZbRozSV1cRIbeep3SmeQX4Agy+o3Zjqtpi2hyjrPMS/DROd90h5i0+qedCNqwrGXTCs04c/EC1IsHyUOm+9NUmePeDIGFe8YXxBfVdljJqnHlar9qbxFyf8Ee2DRxecj0eHC6HFJvs5r/DQX4M5+fW3gKRQhZjwNIWMUndyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789703934; c=relaxed/simple;
	bh=pkNHXt5gdQSHxwxTqenzPOdTbJOI7BzP6Y7cUui9JRk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fZarMVvbZf1/Kvz6bAv+hfP5x3N2Uv2Olz3p+pj6NuOi/V4lQnKeLbxoNUjnBFWNf4rDeOzRsrtTnniQkONg+G+/5SISKkNmDXdJnffd3vuAQ38XunxH2PogU21VFIQVvCJYSdoR3uBBw0edtZOCFuH8XxS9ZSP2FCyjPb6UyVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpsz20t1789703772t7637d381
X-QQ-Originating-IP: 2w5xdtdlO4Bev8ojz+MFY/d6nb+kMkzlVODl9mwoWCA=
Received: from smtpclient.apple ( [125.118.25.28])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Sep 2026 11:56:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3536635797696143373
EX-QQ-RecipientCnt: 14
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net 2/2] net: ngbe: clear DRV_LOAD bit when ngbe_open()
 fails
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20260917090050.1927999-3-zhangyunfei1@kylinos.cn>
Date: Fri, 18 Sep 2026 11:55:59 +0800
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
Message-Id: <9D109671-17F9-4BA3-8814-534E238FA0E2@net-swift.com>
References: <20260917090050.1927999-1-zhangyunfei1@kylinos.cn>
 <20260917090050.1927999-3-zhangyunfei1@kylinos.cn>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MWVuLC+RRZkhTjy/+VTTMVohWNz8gnLeSJe3xkP9nKrLgXFGLvY7fRBj
	koUoN8pjr7/5NGmQjWXVSs8XR3oKlP9zBJTBxPQCnzBJXV6l/iQiCYtPRmnH01ktG4bw3L4
	EHzl+2HmVntckinWE0stzDy1NT/ksVajvx/0q6GYYf2xNoP4874uQFW02UkN4fryn5Egh/X
	U01DO3c7h3vpjX+ADDsui5g8pBaywyIrkw78uXPBeW+20cpfZNMv1bclJkt8/GIVJtjRNM7
	sLBUWw68BzEoEHqXZ4aHiVTSFkNV9fUal13YS550MIwLitLU/2wPVqnLmCL6u0p1oeay+Ll
	/k3yy0gNG4+eDoDzFTteXCwQ7lulTQVhK8NBpA7Otu9KH/Wre1LQLrMbBApoTL7uIiG+CKZ
	0qaXA7nZIvk0RLcrEIh8PT70j2xIkDKwRlh24I6EBWWY7tmYIExdWoeXqUMikhJ3LLqZOKz
	JtVvwRewa1up3bKAiAh6sZ6tJCOci9wyIidbBX42tsUFhBixJvjuInN6efVB/eNRjIYK3zx
	T3kUb2v2wLKJ/AvwNl2I7L1hbV5FcOJ2WjGpEmEtG3RhICZ/NHJPvRfGnUKvHMR9apSqlXI
	LjLwV4iYVDZq70uvaiK1cX5pIBCEP9pFf2mhNz5n3iPgW1xudY6IbDHZl0ZN0bXax6fByBY
	h/ZZ2e7pqhwVWZhyMxkdP0qMIWIv8ETOzku5DpOidSebc7RUk+FyWU57dE1qFYfea+zod1I
	aUfOK30wNBlC5CCsJhj3eq/LfumePlmjRkGNuM7J4lrwRi7bHMPJcBNEcSnlXwQjuQcPQvD
	I6w5jN4Dd98s3fYalTEtaq2vUqdhBseVvE4ndyUtMCfSi5MpP+mLVoXXtdxlD/jat9hOnRa
	cA/HZK1gsuDcB0tgIh8OyoMwlIwzVz6fWXkhir+VL77fxWIGl0/1QfADAuyDjD7iYrd/i1x
	B2GpMH+7C7a98PwEAmqr7GL42tNluzBdLL+A87SbwYkgCYRbUhhPWjTJFLFiSg675DiMkFI
	Gar6fKbx2+Mf6c2LmnrTkFVJ3Ha0l+sTZTtmDdgS4ftsxpSsTbRvAIYycmw3sGgxaXWz7BI
	+7M8dcRtKW3
X-QQ-XMRINFO: Mp0Kj//9VHAx235w5pKcATsBnINcSeXWMQ==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B49=E6=9C=8817=E6=97=A5 17:00=EF=BC=8CZhang Yunfei =
<zhangyunfei1@kylinos.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> ngbe_open() sets the WX_CFG_PORT_CTL_DRV_LOAD bit via
> wx_control_hw(wx, true) to tell the management firmware that the
> host driver has taken over the port (NCSI/OOB firmware stops using
> its management channel). Every error path of ngbe_open() returns
> without clearing it, leaving rings, IRQs and the PHY torn down
> while the firmware still believes the host owns the port, an
> inconsistent driver-firmware handshake state that persists until
> the next successful ifup.
>=20
> Roll the bit back on all open error paths, matching ngbe_close()
> and ngbe_dev_shutdown(), which already clear it.
>=20
> Fixes: e7956139a6cf ("net: ngbe: Add irqs request flow")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>

Reviewed-by: Mengyuan Lou <mengyuanlou@net-swift.com>

> ---
> drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c =
b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 6d8289e2532d..88f00b72a512 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -494,7 +494,7 @@ static int ngbe_open(struct net_device *netdev)
>=20
> err =3D wx_setup_resources(wx);
> if (err)
> - return err;
> + goto err_control_hw;
>=20
> wx_configure(wx);
>=20
> @@ -526,6 +526,8 @@ static int ngbe_open(struct net_device *netdev)
> err_free_resources:
> wx_free_isb_resources(wx);
> wx_free_resources(wx);
> +err_control_hw:
> + wx_control_hw(wx, false);
> return err;
> }
>=20
> --=20
> 2.25.1
>=20
>=20

