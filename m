Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792656541;
	b=3t0NPHNTkOOJ+dsiAkR3h9s7NuSUOQtXay2wB0pMrh8h3a7zA5lwa7KbprddXBsbJLAJ
	 TN+M108uEm5GJGWs109hi9LgJzM7dEknrgfFcyGImVfeHdK/HBPNE6XXXqxdvsju/xQ2q
	 lOTWJXum/KqhWn+aoy3h0u1Q6WOrkjI99G2OwCfbh/3GCqInr7bf9w8sna1f+pAJKlLaN
	 2XNpYFVFfaXKL5QutQioICUYBdYnNat2n0Q3zOl9oXDMa7MnnEFGewjggqy9Ov1TDwdRT
	 dWoEuqPt221+qHwSAg+iu4Xv3rm7L2/jOHpbcD7NyWs2hxY+CAZVCXEol1ueCxbV1VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792656541;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=SrQOB/R3SLUbovIU/JTFQuMZaTtCp4c2h+ziHO4QK18=;
	b=Aqy0kfYwlNU+lywRIj+L33WHI649PFZolXUYZYW4rzMH+81M1SMzPMSXeK3smVZzB2Eo
	 dPLmo04cSX5THBYrrbP2YOkj+oA+ulFS1SuYMGqx7oRGqBfW/NHjTMFzqXu7vciJnHWQ1
	 cv8nGG0OGs83vovUrbEf+P1UYEpRsYTLVYSSR/OUzs5qMIbY3FcBq+s31Yy9WKW4URIz3
	 16f+qnwOvesa72JnfQgRMTQ1Ns/jLdaSRhY+d0KApDQ5GKzvhtrDUgJfvaXo6J9xObR/W
	 EBRli6Qh8J/WXiVed8sza6zla+F28AwIyuDTAjwb04XdTARsbUnx4kKG0CjLUw2mnIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=JtocyhfD;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01888606A319;
	Thu, 22 Oct 2026 08:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01888606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=JtocyhfD
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69M88W080738026, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1792656512; bh=SrQOB/R3SLUbovIU/JTFQuMZaTtCp4c2h+ziHO4QK18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=JtocyhfDotR85/5iXRd5H5dOm2ab6Mhc1Lx64bJAsv9prot2YhTM8Ev1JP73I2Sxc
	 yPbcywXvE/9FS9btjXDNWN0Hucfxf8EvvDyoAWyhdjO8lKB9rfS+bxckt65laKl0DS
	 6XTctr1kyMD4jt6jGZRihXN+W2w0MxDxS0Njpt6dreLSFASVpbYtlJY730iI7Y5w5a
	 Ll93n9jIY/yuMHqi6ubSwSW3cgx0V1+0v0OZpDUbbMnN4vPmoJauHbpSdz9y82JpE7
	 +wHyZIG1UsGOQANwLUIOO4+b2ZFZ3wRd8zzryRxCVikrlPbOiCeiCUDiZK5i0X6ZYb
	 VYrKi5Oq0vsKg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69M88W080738026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Oct 2026 16:08:32 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 16:08:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 16:08:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Thu, 22 Oct 2026 16:08:26 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, nic_swsd <nic_swsd@realtek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "bjorn@mork.no" <bjorn@mork.no>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "mail@birger-koblitz.de" <mail@birger-koblitz.de>
Subject: RE: [PATCH net-next v7 05/10] r8152: fix up and down register
 settings for RTL8156/8156B/8157/8159
Thread-Topic: [PATCH net-next v7 05/10] r8152: fix up and down register
 settings for RTL8156/8156B/8157/8159
Thread-Index: AQHdW7Sw+V1oQp1ZvEmSf7eTjx4JUbcGr0sAgAKOofA=
Date: Thu, 22 Oct 2026 08:08:26 +0000
Message-ID: <0595476b3b8f4aefa6f9eb990b17c7d0@realtek.com>
References: <20261014081904.6491-6-nic_swsd@realtek.com>
 <20261021005212.1254979-1-kuba@kernel.org>
In-Reply-To: <20261021005212.1254979-1-kuba@kernel.org>
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
l has
> considered the AI review valid, or at least plausible.
> ---
> r8152: fix up and down register settings for RTL8156/8156B/8157/8159
>=20
> This commit corrects several up/down and OOB register settings for the
> RTL8156, RTL8156B, RTL8157 and RTL8159 chips, following the earlier
> per-generation split of the up/down callbacks. It changes the PLA_RCR1,
> USB_SPEED_OPTION, Clear_SDR, PLA_BDC_CR/PLA_OOB_CTRL and OOB
> PLA_RMS/PLA_MTPS settings, and drops PLA_MCU_SPDWN_EN handling from
> rtl8157_up()/rtl8157_down().
>=20
> > diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c index
> > b245b63fb6aaf..045460a35f383 100644
> > --- a/drivers/net/usb/r8152.c
> > +++ b/drivers/net/usb/r8152.c
>=20
> [ ... ]
>=20
> > @@ -6938,8 +6937,18 @@ static void r8156_enter_oob(struct r8152 *tp)
> >       rtl_disable(tp);
> >       rtl_reset_bmu(tp);
> >
> > -     ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, 1522);
> > -     ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, MTPS_DEFAULT);
> > +     switch (tp->version) {
> > +     case RTL_VER_16:
> > +     case RTL_VER_17_QFN68:
> > +     case RTL_VER_17_QFN100:
>=20
> [Severity: Medium]
> This patch has three Fixes: tags:
>=20
>   Fixes: 195aae321c82 ("r8152: support new chips")
>   Fixes: fd3c7d080df5 ("r8152: Add support for the RTL8157 hardware")
>   Fixes: ad2a55b63b41 ("r8152: Add support for the RTL8159 chip")
>=20
> Will it apply and build on the trees those tags point to?
>=20
> RTL_VER_17_QFN68 and RTL_VER_17_QFN100 come from an earlier patch in
> this series, "r8152: split RTL_VER_17 into QFN68 and QFN100 package
> variants".
> Before that patch the enum only has RTL_VER_17.
>=20
> rtl8157_up() and rtl8157_down() also only exist after "r8152: split
> rtl8156_enable/up/down into per-generation functions", which is described=
 as
> no functional change. Before that patch there is one shared
> rtl8156_up() with tp->version >=3D RTL_VER_16 and tp->version < RTL_VER_1=
6
> checks.
>=20
> So a stable backport would either conflict or need both non-fix patches a=
s
> prerequisites. One of them is the package detection change, which makes a=
n
> unrecognised PLA_PKG_DET value fall back to RTL_VER_UNKNOWN.
>=20
> Could these fixes go to net separately, written against the pre-refactor =
code? Or
> could the commit message at least name the prerequisites?

I will reorder the series so the fixes come first, written against the pre-=
refactor code,=20
with the refactor rebased on top.

>=20
> > +             ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, 1526);
> > +             ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, 10 * 1024 /
> 64);
> > +             break;
>=20
> [ ... ]
>=20
> > @@ -6997,6 +7008,11 @@ static void rtl8157_up(struct r8152 *tp)
> >       }
> >
> >       r8153_aldps_en(tp, true);
> > +
> > +     /* Enable Clear_SDR */
> > +     ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xd378, BIT(7));
> > +     /* Clear SDR bit */
> > +     ocp_word_clr_bits(tp, MCU_TYPE_USB, 0xcd06, BIT(15));
> >  }
>=20
> [Severity: High]
> The commit message says:
>=20
>   - RTL8156B (VER_13/15) need Clear_SDR enabled on up, which nothing
>     ever did for them.
>=20
> Is the RTL8156B part missing from this patch? These are the only Clear_SD=
R
> writes the patch adds. rtl8157_up() is only used for RTL_VER_16,
> RTL_VER_17_QFN68 and RTL_VER_17_QFN100.
>=20
> In rtl_ops_init(), RTL_VER_13 and RTL_VER_15 are bound to rtl8156_up():
>=20
>         case RTL_VER_12:
>         case RTL_VER_13:
>                 tp->support_2500full    =3D 1;
>                 fallthrough;
>         case RTL_VER_15:
>                 ...
>                 ops->up                 =3D rtl8156_up;
>=20
> This patch does not change rtl8156_up(), and it still writes no Clear_SDR
> register:
>=20
>         r8156_exit_oob(tp);
>=20
>         ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
> PLA_MCU_SPDWN_EN);
>=20
>         ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
>                           RG_PWRDN_EN | ALL_SPEED_OFF);
>=20
>         ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH,
> 0x00600400);
>         ...
>         r8153_aldps_en(tp, true);
>         r8153_u2p3en(tp, true);
>=20
> So every open or resume on an RTL8156B goes through ops->up ->
> rtl8156_up() without the Clear_SDR enable. The later patches in the serie=
s don't
> add it to rtl8156_up() either.
>=20
> Should rtl8156_up() get the RTL8156B Clear_SDR writes under an
> RTL_VER_13/RTL_VER_15 check, or should this bullet come out of the commit
> message? The 0xd378/0xcd06 writes used for RTL8157/8159 can't be assumed
> to apply to RTL8156B.

I accidentally dropped the corresponding code; I will add it back.

Best Regards,
Chih-Kai
