Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F6377EBF;
	Fri, 21 Aug 2026 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787283097; cv=none; b=DC3PYDWjyg//9M/VwezL5qqGYDBu7nsCeYecEDibFAI7sTuT2AgR/GhRqe2QmhplJB/letOBCliHtlmrFQU/mX8BrpnWaJUCEyQDIBmI1VyrvmCd/ijaP9lQ04xp5Tex+oGkwNcbg7/RDBW7x2HXztk9AQIBAr74DlSfS5u8zkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787283097; c=relaxed/simple;
	bh=GXJt+9UdtbcYT/zDhCy1Mm+epI4fc0BJ0eKQ+OOIHJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BJ4H03aertXIEknGTDBscFUBiKgDl23kT43G7J9V7RxkNrZsbbqL5MHu7OkxuFlvIJRxhaPTMhQWjpKDGDl+bC9Uy8Mv1JAmTg/SRjUdvX96Q0kb2kAzIcU79isu5gseNpsfEEKWgyQqxU81QNiQjQ0fr+esq4WIa7ONoXrhBRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=i/hl08fr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="i/hl08fr"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67L3Utg764042081, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1787283055; bh=GNlh7by+9guBGj95F1gmmaKzDnVGQjXiCKKwVX3pDg4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=i/hl08frR0aJGlnmVUR/Q5nl+qqYdbgckBUFGvVps/1pCVY+k04ZgbZyuaxK61VQm
	 iHsYQIQTpSiXzhWmM2lvGmNU0+aEwdX87JZtOrxJ6KxJc1uKFa0l8sA5ctPcxVUBL8
	 tI8e8AjJ7bXTlsFhHVYKXsbbwjfp3iv2/zNmLc/b/QEX5mxd/rbONHx1YvLY1gpHiA
	 eo1RPqOXpwoQXDkWj+1Lnf5QHaMarDSzC92sB7Wj7iAZFX0160G6pT9coJ4wtnpHpP
	 6w5rvjV8LTI3pI2BuXCekrb7RmpPFODvfGOtHqbEE2w8PN7CzKdHkg6piipkRtriXa
	 VlLvDMiOWhwhA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67L3Utg764042081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 11:30:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 21 Aug 2026 11:30:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::126f:59ad:658:674d%10]) with mapi id
 15.02.2562.043; Fri, 21 Aug 2026 11:30:54 +0800
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
Thread-Index: AQHdKJWLKGP+ZBeYREKLgq7izd79A7aXDceAgAEg2oCAD7Y78A==
Date: Fri, 21 Aug 2026 03:30:54 +0000
Message-ID: <e5b2cc1bfc5448a6a4c14806b7e976ad@realtek.com>
References: <20260810065741.4019-1-nic_swsd@realtek.com>
 <918676ef-efcc-4524-a779-62eb2c3eb608@lunn.ch>
 <c2cabf10d22145bbb6a527e702b14b6d@realtek.com>
In-Reply-To: <c2cabf10d22145bbb6a527e702b14b6d@realtek.com>
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

> On Mon, Aug 11, 2026 at 02:03 AM +0800, Andrew Lunn wrote:
> > On Mon, Aug 10, 2026 at 02:57:41PM +0800, Chih Kai Hsu wrote:
> > > During system suspend, memory allocation with GFP_KERNEL can block
> > > waiting for I/O to complete. If that I/O depends on a device that is
> > > itself suspended, a deadlock results.
> > >
> > > Introduce RTL8152_SYSTEM_SUSPEND flag to track when the driver is
> > > operating in the system suspend/resume context. Set the flag at the
> > > start of rtl8152_system_suspend() and clear it at the end of
> > > rtl8152_system_resume(), following the same pattern used by
> > > SELECTIVE_SUSPEND for runtime suspend.
> > >
> > > In get_registers() and set_registers(), select GFP_NOIO when the
> > > flag is set so that the kmalloc and kmemdup calls in those paths do
> > > not trigger I/O reclaim.
> >
> > Do you have a reproducer for this? Or is it theoretical?
> >
>=20
> It is theoretical.
>=20
> > > @@ -8693,6 +8700,9 @@ static int rtl8152_system_resume(struct r8152
> *tp)
> > >               usb_submit_urb(tp->intr_urb, GFP_NOIO);
> > >       }
> > >
> > > +     clear_bit(RTL8152_SYSTEM_SUSPEND, &tp->flags);
> > > +     smp_mb__after_atomic();
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -8758,6 +8768,9 @@ static int rtl8152_system_suspend(struct r8152
> > > *tp)  {
> > >       struct net_device *netdev =3D tp->netdev;
> > >
> > > +     set_bit(RTL8152_SYSTEM_SUSPEND, &tp->flags);
> > > +     smp_mb__after_atomic();
> > > +
> > >       netif_device_detach(netdev);
> > >
> > >       if (netif_running(netdev) && test_bit(WORK_ENABLE,
> > > &tp->flags)) {
> >
> > It seems odd to me that every driver needs to track if it is in
> > suspend/resume or not. Doesn't the struct device tell you? Is there no =
global
> state somewhere?
>=20
> I found
> https://elixir.bootlin.com/linux/v7.2-rc6/source/drivers/base/power/main.=
c#L
> 2343
> in the Linux source code.
>=20
> pm_restrict_gfp_mask() is called before dpm_suspend(state). It removes
> __GFP_IO and __GFP_FS from the global gfp_t gfp_allowed_mask. Therefore, =
I
> think the driver can use GFP_KERNEL safely. Is this correct? Could you pl=
ease
> provide any advice?
>=20
>=20
> >
> >        Andrew
>=20
> Best,
> Chih-Kai

Hi Andrew,

Just a gentle ping on this patch.
Based on my previous observation, should the driver use GFP_NOIO explicitly=
?

Thank you for your time.

Best,
Chih-Kai
