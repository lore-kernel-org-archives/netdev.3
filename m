Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4619039792B;
	Mon, 24 Aug 2026 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787557363; cv=none; b=mC9HOQunqAGmvaOhmSI3IVtXb4v0RXE9MAjZ5Uxjspqq6SoeJ78wcngiIGxI5iBOFvlszC9DlcirtAnt5Nez5wpyOpjc6IXJvT67KZEs700azozx+UQLByxw//t6jj/FoVJxeyEwZoiyMAVSjqv7cD2lQPFQ0IQLDC+wt6jP36w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787557363; c=relaxed/simple;
	bh=Z+X/hhDy9Y0whh2gzoO7bMbTL0RuEHKE/A0jYGNe2Lo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AsnkBjFLsaTw1vU4mhBJ5PA6qcfvvzsQzweMVRNFyu+1Vq27bzx2732aHReb36DZPl/TYQrDYulAEwI5+EVyNMY+N3RXm4q1uGwTlvnwun2OFaLznSpTsIabgPHKUfS+LyZfg0zwh2iOd43dfJaofrukByXKTxHKFd9lfjsISms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=swpOLgHx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="swpOLgHx"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67O7fd1oB2612751, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1787557300; bh=YCbcSV2j0rINLE4MrDJN50POmMEuhXzFHqL+aoOm5vw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=swpOLgHxYmMYeikmBVCr9Sx5FZGsOCE7D6og5EWWO3zsDLcs1X+lzG3f+H7GO2Qy/
	 gJGc+TcIajFBXgsNc2l+miSoSN7Qz8oewGf9LyWd9V+PNPn8KY5VX2guu6LCqHCint
	 1QGdIw/NEsWGMpQkOlMqQxi3veTN47V0oUQUkScKciqiXoBI5FQ2MTH5NRsa+g7Zec
	 Kj632p0M6y0H3FCiEel+xXyA/pdhII86SSLIKWd5OSZ8uOB6ApuxrhsV3Gyekoyeke
	 tx5+CMN0OAdG6CSn/mdUJY+teIaEqjX2OJWIZ+AsB4j1g/12Le3bMBZ6HLPOjdbxO/
	 3btwsLlizbROQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67O7fd1oB2612751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Aug 2026 15:41:40 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 24 Aug 2026 15:41:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 24 Aug 2026 15:41:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::126f:59ad:658:674d%10]) with mapi id
 15.02.2562.043; Mon, 24 Aug 2026 15:41:38 +0800
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
Thread-Index: AQHdKJWLKGP+ZBeYREKLgq7izd79A7aXDceAgAEg2oCAD7Y78IAAG2gAgATdJEA=
Date: Mon, 24 Aug 2026 07:41:38 +0000
Message-ID: <6289e14719cd4cc3812d8185218c80b2@realtek.com>
References: <20260810065741.4019-1-nic_swsd@realtek.com>
 <918676ef-efcc-4524-a779-62eb2c3eb608@lunn.ch>
 <c2cabf10d22145bbb6a527e702b14b6d@realtek.com>
 <e5b2cc1bfc5448a6a4c14806b7e976ad@realtek.com>
 <29c03f4b-95d1-48c3-b8e0-f57ba2ffbaa9@lunn.ch>
In-Reply-To: <29c03f4b-95d1-48c3-b8e0-f57ba2ffbaa9@lunn.ch>
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

On Fri, Aug 21, 2026 at 08:51 PM +0800, Andrew wrote:
> On Fri, Aug 21, 2026 at 03:30:54AM +0000, Chih Kai Hsu wrote:
> > > On Mon, Aug 11, 2026 at 02:03 AM +0800, Andrew Lunn wrote:
> > > > On Mon, Aug 10, 2026 at 02:57:41PM +0800, Chih Kai Hsu wrote:
> > > > > During system suspend, memory allocation with GFP_KERNEL can
> > > > > block waiting for I/O to complete. If that I/O depends on a
> > > > > device that is itself suspended, a deadlock results.
> > > > >
> > > > > Introduce RTL8152_SYSTEM_SUSPEND flag to track when the driver
> > > > > is operating in the system suspend/resume context. Set the flag
> > > > > at the start of rtl8152_system_suspend() and clear it at the end
> > > > > of rtl8152_system_resume(), following the same pattern used by
> > > > > SELECTIVE_SUSPEND for runtime suspend.
> > > > >
> > > > > In get_registers() and set_registers(), select GFP_NOIO when the
> > > > > flag is set so that the kmalloc and kmemdup calls in those paths
> > > > > do not trigger I/O reclaim.
> > > >
> > > > Do you have a reproducer for this? Or is it theoretical?
> > > >
> > >
> > > It is theoretical.
> > >
> > > > > @@ -8693,6 +8700,9 @@ static int rtl8152_system_resume(struct
> > > > > r8152
> > > *tp)
> > > > >               usb_submit_urb(tp->intr_urb, GFP_NOIO);
> > > > >       }
> > > > >
> > > > > +     clear_bit(RTL8152_SYSTEM_SUSPEND, &tp->flags);
> > > > > +     smp_mb__after_atomic();
> > > > > +
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > @@ -8758,6 +8768,9 @@ static int rtl8152_system_suspend(struct
> > > > > r8152
> > > > > *tp)  {
> > > > >       struct net_device *netdev =3D tp->netdev;
> > > > >
> > > > > +     set_bit(RTL8152_SYSTEM_SUSPEND, &tp->flags);
> > > > > +     smp_mb__after_atomic();
> > > > > +
> > > > >       netif_device_detach(netdev);
> > > > >
> > > > >       if (netif_running(netdev) && test_bit(WORK_ENABLE,
> > > > > &tp->flags)) {
> > > >
> > > > It seems odd to me that every driver needs to track if it is in
> > > > suspend/resume or not. Doesn't the struct device tell you? Is
> > > > there no global
> > > state somewhere?

The function hibernate_quiet_exec() used by the driver at drivers/nvdimm/co=
re.c
calls dpm_suspend() directly, so the driver cannot use functions such as pm=
_suspend_in_progress()
or system_entering_hibernation() to determine whether it is in the suspend/=
hibernate path now.

The ax88179 driver at drivers/net/usb/ax88179_178a.c uses a private variabl=
e, in_pm, which is
set when entering the suspend callback. After that, the driver uses ax88179=
_in_pm() to determine
whether the driver is in the suspend/hibernate path now. Therefore, using a=
 per-driver flag
makes sense.

> > >
> > > I found
> > > https://elixir.bootlin.com/linux/v7.2-rc6/source/drivers/base/power/
> > > main.c#L
> > > 2343
> > > in the Linux source code.
> > >
> > > pm_restrict_gfp_mask() is called before dpm_suspend(state). It
> > > removes __GFP_IO and __GFP_FS from the global gfp_t
> > > gfp_allowed_mask. Therefore, I think the driver can use GFP_KERNEL
> > > safely. Is this correct? Could you please provide any advice?
> > >
> > >

For the same reason, hibernate_quiet_exec() calls dpm_suspend() directly,
so pm_restrict_gfp_mask() is never called. The driver should use GFP_NOIO i=
n
this case.

> > > >
> > > >        Andrew
> > >
> > > Best,
> > > Chih-Kai
> >
> > Hi Andrew,
> >
> > Just a gentle ping on this patch.
> > Based on my previous observation, should the driver use GFP_NOIO
> explicitly?
>=20
> Please try to answer the question yourself. There are lots of drivers out=
 there.
> What do they do? What does the suspend/resume documentation say?
>=20
>         Andrew

Best Regards,
Chih-Kai
