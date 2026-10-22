Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655748;
	b=VWfbc7plhsSllHPJd84rYIVdmVlSZdjGaCM1ojSPLqb6W/5Bs2QefSbeQIFs/2R7Loh+
	 7SYN4WbCVKNJWFE9x6nLtPHsA2F+XeYv+F8jbNUpfFUPDWnv0XN4E+Bt8aOTMrJ/LTR2t
	 +M7Jbofgf8zLH49vgon6lJlx4oqzLhobmf12mBE6JwQ95/4XOnqc54xmjetMBlzYaZADI
	 5/Sghqb6+R+VtVb/cwYkMhwNmKMNeeZesWVXDcBi5H0f/kxQ2FbN88Mnbs1tRi7keVQNx
	 7kL9U1CTgJ/UtfSX9DmD/a1jwP7+URndIy+xNONvKp4GFB0w5/KvcOLBhj/bRVYKaIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655748;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=35BMCJ0DRFod5zbqo3OEuERbzYqy1Qlg2uPnRX8li44=;
	b=Ci4xwIQen4EAz9+d1ZqFDqMyXuwoJI/B//DRHB3hXKNGGS48ttO9KgGzO1KPFrSjqUxO
	 HAircWH7z0PiXmBciPqKDsbXUqj9t+Auc/F4Wsfy21d/xqXgfLWwJn8l52qzn+7N4+Akl
	 Z3m7Gs/Jeuuwpn0wbmll+6nypwkZ37WiDw5czRVnkItvXc5WYwltm1UvKSDZk/c/XWHN6
	 /IAKcXW9uEuukc3S6QzOSUkE/XyDJ7Hp1f8LcG97Xwa2gBBPzJ76e4kYr5aD7iOejM84b
	 ousb87QHtImHKgdKNIJXsqP6bAlBjcukSNiROh84S6TuRtB9i3PXa1+05lH/gW/o4jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=N4oFcS1C;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27454606A31F;
	Thu, 22 Oct 2026 07:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27454606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=N4oFcS1C
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69M7t6imD732048, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1792655706; bh=35BMCJ0DRFod5zbqo3OEuERbzYqy1Qlg2uPnRX8li44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=N4oFcS1CF5gfWchTiC0aoXWQPLI2fUFOVPLHsH/bH6NHGhZgPWdMK4glWlJOZUzP0
	 /K/rmDZt3hp2vmTEAUmSoVBOE0beS5KiivGybQLqrLCUF7z/IQ3LgDkdh/SioxLH6h
	 Ybu1wDdePeBvj5WGqXa6aPLM59vSnbkwRqnmW7lr4htVLiJh/JSl32JOEdaMb3SyTJ
	 z6F5AiBPCoB0AY+8OyKSxBNBymbM/AdEqKnaNkl4qLkSYqBBQttsbz6fL3bGjrcZJj
	 dharW+AWE0qtXXK6bFNwZpJ/I/xhAW6nNSY8hrMm0Gs0B8PmAHFSl6Y8tmfei+qDRs
	 9SM8p2SznHsLQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69M7t6imD732048
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Oct 2026 15:55:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 15:55:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Thu, 22 Oct 2026 15:55:06 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, nic_swsd <nic_swsd@realtek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "bjorn@mork.no" <bjorn@mork.no>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "mail@birger-koblitz.de" <mail@birger-koblitz.de>
Subject: RE: [PATCH net-next v7 01/10] r8152: split r8156_init by generation
 and factor out wait_autoload_done
Thread-Topic: [PATCH net-next v7 01/10] r8152: split r8156_init by generation
 and factor out wait_autoload_done
Thread-Index: AQHdW7SuZCSqV7wlj0KG5+P2+y47LrcGr0gAgAKFWUA=
Date: Thu, 22 Oct 2026 07:55:05 +0000
Message-ID: <cdae2681774141ab836e4b77fb31c186@realtek.com>
References: <20261014081904.6491-2-nic_swsd@realtek.com>
 <20261021005210.1254886-1-kuba@kernel.org>
In-Reply-To: <20261021005210.1254886-1-kuba@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wednesday, October 21, 2026 8:52 AM, Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this emai=
l
> has considered the AI review valid, or at least plausible.
> ---
> r8152: split r8156_init by generation and factor out wait_autoload_done
>=20
> The patch splits r8156_init() into two functions. r8156_init() now covers
> RTL8156/RTL8156B, and the new r8157_init() covers RTL8157/RTL8159. It
> also moves the repeated PLA_BOOT_CTRL AUTOLOAD_DONE polling loop into
> a new
> wait_autoload_done() helper built on read_poll_timeout(), and converts th=
e
> r8153 init and ups_en paths to use it.
>=20
> > diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c index
> > af3d7dcb2f141..518a2b42c2200 100644
> > --- a/drivers/net/usb/r8152.c
> > +++ b/drivers/net/usb/r8152.c
> > @@ -4172,6 +4172,23 @@ static u16 r8153_phy_status(struct r8152 *tp,
> u16 desired)
> >       return data;
> >  }
> >
> > +static int wait_autoload_done(struct r8152 *tp) {
> > +     u16 ocp_data;
> > +     int ret;
> > +
> > +     ret =3D read_poll_timeout(ocp_read_word, ocp_data,
> > +                             test_bit(RTL8152_INACCESSIBLE,
> &tp->flags) ||
> > +                             (ocp_data & AUTOLOAD_DONE),
> > +                             20000, 10 * USEC_PER_SEC, false, tp,
> > +                             MCU_TYPE_PLA, PLA_BOOT_CTRL);
> > +
> > +     if (ret)
> > +             dev_err(&tp->intf->dev, "autoload done timeout\n");
> > +
> > +     return test_bit(RTL8152_INACCESSIBLE, &tp->flags) ? -ENODEV : 0;
> > +}
> > +
>=20
> [Severity: Medium]
> Can this end up reading uninitialized stack memory in ocp_read_word()?
>=20
> read_poll_timeout() runs op before it evaluates cond, on the first iterat=
ion,
> after every sleep, and once more after the timeout expires.
> So once RTL8152_INACCESSIBLE gets set, the helper still issues another
> ocp_read_word() on PLA_BOOT_CTRL before the test_bit() in the condition
> gets a chance to stop the loop.
>=20
> In that case generic_ocp_read() returns -ENODEV without writing to the lo=
cal
> tmp. ocp_read_word() ignores that return value and still does
> __le32_to_cpu(tmp), then hands the result back as ocp_data.
>=20
> The loops being replaced did not do this. r8153b_ups_en() and
> r8153c_ups_en() tested the flag before each read. The init functions test=
ed it
> right after msleep(20) and left the loop before the next read.
>=20
> The test_bit() short-circuit means the garbage is never acted on, but the=
 read
> itself is still undefined behaviour of the sort KMSAN is meant to catch, =
and it
> now happens whenever the device goes away while we are waiting for
> AUTOLOAD_DONE.
>=20
> A flag check before the poll would only cover the entry case, since the f=
lag can
> be set during the sleep. Would it be better to initialize tmp in ocp_read=
_word()
> and the other ocp_read_*() helpers, given that plenty of existing callers
> already read without checking the flag?
> Or is an open-coded loop that tests the flag first preferable here?

Before testing AUTOLOAD_DONE in PLA_BOOT_CTRL, the RTL8152_INACCESSIBLE fla=
g
was tested. Therefore, the garbage is never used to check AUTOLOAD_DONE.

KMSAN reports an uninitialized value only when it is used; the reads wouldn=
't trigger it.

>=20
> [ ... ]
>=20
> > @@ -7225,22 +7226,14 @@ static void r8152b_init(struct r8152 *tp)
> > static void r8153_init(struct r8152 *tp)  {
> >       u32 ocp_data;
> > -     int i;
> >
> >       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> >               return;
> >
> >       r8153_u1u2en(tp, false);
> >
> > -     for (i =3D 0; i < 500; i++) {
> > -             if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL)
> &
> > -                 AUTOLOAD_DONE)
> > -                     break;
> > -
> > -             msleep(20);
> > -             if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> > -                     break;
> > -     }
> > +     if (wait_autoload_done(tp))
> > +             return;
> >
> >       r8153_phy_status(tp, 0);
> >
> > @@ -7341,22 +7334,13 @@ static void r8153_init(struct r8152 *tp)
> >
> >  static void r8153b_init(struct r8152 *tp)  {
> > -     int i;
> > -
> >       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> >               return;
> >
> >       r8153b_u1u2en(tp, false);
> >
> > -     for (i =3D 0; i < 500; i++) {
> > -             if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL)
> &
> > -                 AUTOLOAD_DONE)
> > -                     break;
> > -
> > -             msleep(20);
> > -             if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> > -                     break;
> > -     }
> > +     if (wait_autoload_done(tp))
> > +             return;
> >
> >       r8153_phy_status(tp, 0);
> >
>=20
> [Severity: Medium]
> Is the commit message accurate for r8153_init() and r8153b_init()? It
> says:
>=20
>   a plain AUTOLOAD_DONE timeout is logged but otherwise treated as
>   success, same as every one of the loops it replaces, which only bailed
>   out early on RTL8152_INACCESSIBLE and otherwise fell through to the
>   rest of the init sequence.
>=20
> and:
>=20
>   No functional change intended.
>=20
> In these two functions the old loops did a break, not a return, when
> RTL8152_INACCESSIBLE was set:
>=20
>                 msleep(20);
>                 if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                         break;
>=20
> So init always ran to the end of the function. Only r8153c_init(), the ol=
d
> r8156_init() and the two *_ups_en() loops returned early.
>=20
> wait_autoload_done() returns -ENODEV whenever RTL8152_INACCESSIBLE is
> set, so both functions now return early instead.
>=20
> The commit message says the early return costs nothing because
> generic_ocp_read()/generic_ocp_write() short-circuit. However, the skippe=
d
> tail also does work that does not go through OCP accesses:
>=20
>   r8153_init():
>         usb_enable_lpm(tp->udev);
>         ...
>         tp->coalesce =3D COALESCE_SUPER;   (or COALESCE_HIGH /
> COALESCE_SLOW)
>=20
>   r8153b_init():
>         usb_enable_lpm(tp->udev);
>         ...
>         set_bit(GREEN_ETHERNET, &tp->flags);
>         ...
>         tp->coalesce =3D 15000;
>=20
> usb_enable_lpm() is a counted USB core call. It decrements
> udev->lpm_disable_count and does not check the driver's
> RTL8152_INACCESSIBLE flag.
>=20
> The polling interval also changes. The old loops used msleep(20), while
> read_poll_timeout() with a sleep_us of 20000 ends up in usleep_range(5001=
,
> 20000).
>=20
> These differences only show up on error paths. Still, could the commit me=
ssage
> describe the new early return in r8153_init() and r8153b_init()?
> Or should these two functions keep the old break-and-continue behaviour?

I should keep the original behavior, remove the early return in r8153_init(=
) and r8153b_init().

> --
> pw-bot: cr

Best Regards,
Chih Kai
