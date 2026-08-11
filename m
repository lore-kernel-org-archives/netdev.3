Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587512BCF4C;
	Tue, 11 Aug 2026 05:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786425952; cv=none; b=g5pMzw35fYCgv/mDoK4Dp7EYnwRH1x4w7YlQmf/1ViiQ8csWC+QsyelVmLjWufbMaXaR1J1otXeTJbcA00nyyF8RWE0BqdUSW9SOf7XO3QQyOqf/jNzB6NV24v9iO/lqizxXXMggi70no5lQOVzVPianGszjgdwuSR4kL0Zjlbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786425952; c=relaxed/simple;
	bh=i6k178/8k8gnhn9dZNmEZDvLGarWRJZZAMg/aQ4dSd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DTziWqmGhc2J87aM4G3HO1ILf32X83SLE1fzeVp23q7Wsy24bbFdUWH3xWsnCXAU7IpzOX/wIQUcFc3fem/ylsG9knjpjMD8KoDT4+tz0nJuiRRlqgWwONQzx2bzg/U8HBisAw9iSkatCX9D8p2PT4BxK8ZJqm6enEiuffz6JUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jILUpWTd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jILUpWTd"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67B5PBK002320262, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1786425911; bh=e4OHn5wYNdQPBtBbzrVxtw4DOfGlrfLBSqTQpqYY1To=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jILUpWTdG1+cb0IDtD8DzBcfbgcKRV0u+XivAuYjHbFzsi+wGEKFxHaOYLjngNMjk
	 vcHCYC5nJX+O1dckwKr6XsXAHAg8Ab0WN1HbsbkBULw4gYERvVDiyMJYdSItKbiQ8Y
	 5nFgxUMjRJVD9i5ammEd7DQk5bRIN+Je7VtksL74pcHM9Ec+M+7wC4t22MapHCrwdT
	 bYSnUM55LAsEMI9aPwcrz4JSql9W7/wb4Q2+ihE04e6NzeerohbpA5s/SvBacGM+3J
	 PlRlv2QEpFp3Jd5slfauHRfTB+vn5CjC1G5Huae2qmfGsPRWJyXisL5nSY8+29aOtS
	 ARjDWRhDpN+ww==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67B5PBK002320262
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Aug 2026 13:25:11 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 11 Aug 2026 13:25:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 11 Aug 2026 13:25:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::126f:59ad:658:674d%10]) with mapi id
 15.02.2562.043; Tue, 11 Aug 2026 13:25:10 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	nic_swsd <nic_swsd@realtek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"bjorn@mork.no" <bjorn@mork.no>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next] r8152: use GFP_NOIO during system suspend
Thread-Topic: [PATCH net-next] r8152: use GFP_NOIO during system suspend
Thread-Index: AQHdKJWLKGP+ZBeYREKLgq7izd79A7aXDceAgAEg2oA=
Date: Tue, 11 Aug 2026 05:25:10 +0000
Message-ID: <c2cabf10d22145bbb6a527e702b14b6d@realtek.com>
References: <20260810065741.4019-1-nic_swsd@realtek.com>
 <918676ef-efcc-4524-a779-62eb2c3eb608@lunn.ch>
In-Reply-To: <918676ef-efcc-4524-a779-62eb2c3eb608@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Aug 11, 2026 at 02:03 AM +0800, Andrew Lunn wrote:
> On Mon, Aug 10, 2026 at 02:57:41PM +0800, Chih Kai Hsu wrote:
> > During system suspend, memory allocation with GFP_KERNEL can block
> > waiting for I/O to complete. If that I/O depends on a device that is
> > itself suspended, a deadlock results.
> >
> > Introduce RTL8152_SYSTEM_SUSPEND flag to track when the driver is
> > operating in the system suspend/resume context. Set the flag at the
> > start of rtl8152_system_suspend() and clear it at the end of
> > rtl8152_system_resume(), following the same pattern used by
> > SELECTIVE_SUSPEND for runtime suspend.
> >
> > In get_registers() and set_registers(), select GFP_NOIO when the flag
> > is set so that the kmalloc and kmemdup calls in those paths do not
> > trigger I/O reclaim.
>=20
> Do you have a reproducer for this? Or is it theoretical?
>=20

It is theoretical.

> > @@ -8693,6 +8700,9 @@ static int rtl8152_system_resume(struct r8152 *tp=
)
> >               usb_submit_urb(tp->intr_urb, GFP_NOIO);
> >       }
> >
> > +     clear_bit(RTL8152_SYSTEM_SUSPEND, &tp->flags);
> > +     smp_mb__after_atomic();
> > +
> >       return 0;
> >  }
> >
> > @@ -8758,6 +8768,9 @@ static int rtl8152_system_suspend(struct r8152
> > *tp)  {
> >       struct net_device *netdev =3D tp->netdev;
> >
> > +     set_bit(RTL8152_SYSTEM_SUSPEND, &tp->flags);
> > +     smp_mb__after_atomic();
> > +
> >       netif_device_detach(netdev);
> >
> >       if (netif_running(netdev) && test_bit(WORK_ENABLE, &tp->flags))
> > {
>=20
> It seems odd to me that every driver needs to track if it is in suspend/r=
esume
> or not. Doesn't the struct device tell you? Is there no global state some=
where?

I found https://elixir.bootlin.com/linux/v7.2-rc6/source/drivers/base/power=
/main.c#L2343=20
in the Linux source code.

pm_restrict_gfp_mask() is called before dpm_suspend(state). It removes __GF=
P_IO
and __GFP_FS from the global gfp_t gfp_allowed_mask. Therefore, I think the=
 driver
can use GFP_KERNEL safely. Is this correct? Could you please provide any ad=
vice?


>=20
>        Andrew

Best,
Chih-Kai
