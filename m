Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD813134CF;
	Fri,  5 Jun 2026 06:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780640822; cv=none; b=rVX0EuNNLXhlpBC2rAi7A9KjPMTN3bc1mYT0uNmcHir12nxzgtHUTLbmSa5ezQpCta5p9JL+Yn0FdeOYQJiVxVNxV216m29zRqIZNx/83l2C1acN8ORzoFiLJ0DX7Cf6GsNa+IaRf94FfOoLiL82yR7ZehAtm7HVCx9WZjSzY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780640822; c=relaxed/simple;
	bh=dKIv6DTBccWXjxvvX592ngIa3cd0Qeyc4LUSi4OhCq0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jFllZdjnmjtwlwfFql6UjCprbJN65N27Yir/kTwjsSk7bGiIBpn834wxh3//pM+Pdf6yNuD//UsXF2Q0RP476SW3nnNRKrfCUzLcOdKaR+lO1+t0Gwf16lO+FKEruwvu0aXhoKFOALQ6tjkQiY8cBnfNEDc/Q/mToGmPNCiz9kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FwGKQj7q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FwGKQj7q"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6556QkiI61190600, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780640806; bh=rwYspt8d8zSBtuVwmCcOzpCCaan6aqBoJsQzOGWcItY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=FwGKQj7qi+jRCCIAdRY/ezjMf8mU6WaUpZ+xoyFkQgLQKB5Zvds4aTF/DnEud/ivd
	 IN3FFUTi/WYBXtqJ+Vbt8CHKT/J7/ySpr58qiuDgqoTsOkeDLxlDL+OAL98aEme29X
	 27u9UkS6/X956BdSbYCKLA+6XhZ5Mna7bD5gfSMGRGogxw8SGAOIHZU3vW4EdhIlTn
	 5/E85k2XMmc5t9MyT/tGFs5PFHej4Slfob8CrbOtRo1YMlFwQZKtKgbzsAumQxnZcc
	 6mx7hT2vmZEolrlQuM+GBCmhqYRDMef4wxrL2ayb9VciL32tGIcLa7QANlbIvLJKpT
	 CUKY1uYlYpu+g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6556QkiI61190600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jun 2026 14:26:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Jun 2026 14:26:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Fri, 5 Jun 2026 14:26:46 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	nic_swsd <nic_swsd@realtek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
Subject: RE: [PATCH net] r8152: handle the return value of usb_reset_device()
Thread-Topic: [PATCH net] r8152: handle the return value of usb_reset_device()
Thread-Index: AQHc9APC9XApZAQtH0mFd55w2OdfKbYt1DKAgAFpdUD//5TagIAAqFpA
Date: Fri, 5 Jun 2026 06:26:46 +0000
Message-ID: <19bdb89de51c46408b7e7d7cdeba8e4d@realtek.com>
References: <20260604092247.27158-450-nic_swsd@realtek.com>
 <c1ddf8f3-71f7-434c-ad10-64096b65fe51@lunn.ch>
 <ce2651bf86fc401b9e1e7cc29b5a6c22@realtek.com>
 <3e108daa-7913-4890-8331-9761a4654b1f@lunn.ch>
In-Reply-To: <3e108daa-7913-4890-8331-9761a4654b1f@lunn.ch>
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

On 05/06/26 12:04 pm, Andrew Lunn wrote:

> On Fri, Jun 05, 2026 at 02:42:34AM +0000, Chih Kai Hsu wrote:
> > On 04/06/26 8:54 pm, Andrew Lunn wrote:
> >
> > > On Thu, Jun 04, 2026 at 05:22:47PM +0800, Chih Kai Hsu wrote:
> > > > If usb_reset_device() returns a negative error code, stop the
> > > > process of probing.
> > > >
> > > > Fixes: 10c3271712f5 ("r8152: disable the ECM mode")
> > >
> > > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.h
> > > tml
> > >
> > > Does this bother people?
> > Yes, it does.
> > If the driver does not return early when receiving an error code from
> > usb_reset_device(), the subsequent execution will trigger a kernel call=
 trace.
>=20
> Please include a link to such a bug report, kernel call trace etc, to to =
show it
> bothers somebody. Do you have the hardware and can trigger this?

If the driver ignores the error from usb_reset_device(), I get the followin=
g call trace.

[ 2405.758846] Call Trace:
[ 2405.758853]  <TASK>
[ 2405.758872]  usb_probe_interface+0x15b/0x350
[ 2405.758895]  really_probe+0xdb/0x340
[ 2405.758910]  ? pm_runtime_barrier+0x55/0x90
[ 2405.758926]  __driver_probe_device+0x78/0x140
[ 2405.758940]  driver_probe_device+0x1f/0xa0
[ 2405.75895s3]  ? __pfx___driver_attach+0x10/0x10
[ 2405.758965]  __driver_attach+0xcb/0x1e0
[ 2405.758979]  bus_for_each_dev+0x82/0xd0
[ 2405.758992]  bus_add_driver+0x12f/0x210
[ 2405.759035]  ? __pfx_rtl8152_driver_init+0x10/0x10 [r8152]
[ 2405.759069]  driver_register+0x75/0xe0
[ 2405.759079]  usb_register_driver+0x99/0x150
[ 2405.759092]  ? usb_register_device_driver.cold+0x3a/0x40
[ 2405.759107]  do_one_initcall+0x58/0x300
[ 2405.759124]  do_init_module+0x84/0x280
[ 2405.759138]  init_module_from_file+0x8a/0xe0
[ 2405.759160]  idempotent_init_module+0x114/0x310
[ 2405.759178]  __x64_sys_finit_module+0x6d/0xd0
[ 2405.759190]  ? syscall_trace_enter+0x173/0x1f0
[ 2405.759205]  do_syscall_64+0x7e/0x250
[ 2405.759216]  ? syscall_exit_work+0xb0/0x1b0
[ 2405.759228]  ? do_syscall_64+0xb6/0x250
[ 2405.759239]  ? count_memcg_events+0x15d/0x230
[ 2405.759251]  ? handle_mm_fault+0x248/0x360
[ 2405.759264]  ? do_user_addr_fault+0x21a/0x690
[ 2405.759278]  ? irqentry_exit_to_user_mode+0x2c/0x1c0
[ 2405.759290]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 2405.759300] RIP: 0033:0x7f7fa09010cd
[ 2405.759335] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 03 4d 0f 00 f7 d8 64 89 01 48
[ 2405.759344] RSP: 002b:00007fff7deaa418 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[ 2405.759356] RAX: ffffffffffffffda RBX: 0000555bbeb58750 RCX: 00007f7fa09=
010cd
[ 2405.759362] RDX: 0000000000000000 RSI: 0000555bb09c65ee RDI: 00000000000=
00003
[ 2405.759368] RBP: 00007fff7deaa4d0 R08: 0000000000000000 R09: 00007fff7de=
aa460
[ 2405.759375] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00000
[ 2405.759380] R13: 0000555bbeb583c0 R14: 0000555bb09c65ee R15: 00000000000=
00000
[ 2405.759395]  </TASK>
[ 2405.759400] ---[ end trace 0000000000000000 ]---

>=20
>         Andrew

Best Regards,
Chih-Kai
