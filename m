Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D94534DB74;
	Thu,  3 Sep 2026 02:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404289; cv=none; b=Cdp5FfL/3CWBSe5K4+fS/+J1n+olx91QtkDnash0jjJdBXReouSFLSz42pvnkG/bv504G1kxvy3dlK4VJVJ4FbJ4DZoL6AYGFfI8bYAJz//qsdCrDw5+04GI2lP/ULP0rtuPmYd+Al5zfGci6v5+QB+T+tUSchH8YCo+XKfV8zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404289; c=relaxed/simple;
	bh=WVJzMFypksULhssCBhs+u3lWuxrgnqMSYBaJhRScTpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WdJJ3rn0c7frThU2h4wdbQnxx2eqiXe4mCixq6xKlsfJRUqRAO2KzxVhuC7r8zTPi0Kf/tyeVS2QfKgSfPnaowKNfCpS+YxGZ9GJhudLfRALqcSPIFkgIpbTkQ4bka9XPyWwD/0gBjII6B/0wHx8+Q73xI7BQjs2JlRlVMr2DZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=s7g1vGJ9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="s7g1vGJ9"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6832vR8X13154057, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788404248; bh=j4Ybtv+0wCie/NnJLjyNOJMcX16jWSGU5FLxfTcsCGA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=s7g1vGJ9vta8SQePoPy3SpT1BQm+XNnQ/Wqv5kYTH92r4YBgj7FVMj0kqlVppbLhk
	 VjYI9pbAn7rbBLC2AR2saSMsq1IqcKl58NbZsDydUsN0jhPwPZCUkcKq6UtofTpAAj
	 c5U59JWCLn8XmGtJ7ZwSYFWLlJbToMfCCAxldqPsy9wXrD9N+Vce2iBPby334w+Ar+
	 puCSDaAq4pFTkdr8pDgoxCGM9IrfXIWvvc6on3Dg0znHl+ShxyvRubRb2s56jWPPJB
	 wV9GX+wBZs+gkFRS6vKgeF/JuxWsqNKwGqQnAMyu/h8aBZ3eXLAcLR0dAEawAtqDaA
	 dRqG7E5C9CFwg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6832vR8X13154057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Sep 2026 10:57:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 3 Sep 2026 10:57:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 3 Sep 2026 10:57:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::126f:59ad:658:674d%10]) with mapi id
 15.02.2562.043; Thu, 3 Sep 2026 10:57:27 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	nic_swsd <nic_swsd@realtek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"bjorn@mork.no" <bjorn@mork.no>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
Subject: RE: [PATCH net-next 1/8] r8152: refactor r8156_init
Thread-Topic: [PATCH net-next 1/8] r8152: refactor r8156_init
Thread-Index: AQHdOrpfAmeZLX/T10mr2kg/ADpLUba6uKkAgAFwccA=
Date: Thu, 3 Sep 2026 02:57:26 +0000
Message-ID: <ee890ce30dad440c9789f4aadab29724@realtek.com>
References: <20260902090632.41844-1-nic_swsd@realtek.com>
 <20260902090632.41844-2-nic_swsd@realtek.com>
 <9a90f05a-ce9e-4f90-9a0d-19242f57f225@lunn.ch>
In-Reply-To: <9a90f05a-ce9e-4f90-9a0d-19242f57f225@lunn.ch>
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

On Wed, Sep 2, 2026 08:54 PM +0800, Andrew wrote:
>=20
> > -static int r8159_wait_backup_restore(struct r8152 *tp)
> > +static void r8156_init(struct r8152 *tp)
> >  {
> > -     u32 ocp_data;
> > +     u16 data;
> > +     int i;
> >
> > -     ocp_data =3D ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
> > -     if (!(ocp_data & PCUT_STATUS))
> > -             return 0;
> > +     if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> > +             return;
> >
> > -     return poll_timeout_us(ocp_data =3D ocp_read_word(tp,
> MCU_TYPE_USB, USB_GPHY_CTRL),
> > -                            ocp_data & BACKUP_RESTRORE, 200,
> 20000, false);
> > +     ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP,
> EN_ALL_SPEED);
> > +
> > +     ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, 0);
> > +
> > +     ocp_word_set_bits(tp, MCU_TYPE_USB, USB_ECM_OPTION,
> > + BYPASS_MAC_RESET);
> > +
> > +     r8153b_u1u2en(tp, false);
> > +
> > +     for (i =3D 0; i < 500; i++) {
> > +             if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
> > +                 AUTOLOAD_DONE)
> > +                     break;
> > +
> > +             msleep(20);
> > +             if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> > +                     return;
> > +     }
>=20
> Please use one of the macros from iopoll.h. And return ETIMEDOUT on error=
.
>=20
>         Andrew

Ok, I will do it in the next version.

Thank you,
Chih-Kai
