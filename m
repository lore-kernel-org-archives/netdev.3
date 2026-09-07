Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2703F1C5F1B
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 01:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788745999; cv=none; b=kokuWZ703VHq35MVTLejQxQt3YkRwHcb6UmlFpBQVy2mu+L0Q9mdwG3x5vMjrxMJo4DS5U6YPtUSmqel/KG6Qu791Ib0LYXw1kwFOZr4Rw0HkKVZOkHlvzERXzoSP3WmrHY/bEuIZ1IPzulQMgo72Xqte3Advtv/84MP9tnl7ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788745999; c=relaxed/simple;
	bh=liCIhkBU97zqem2ZWRr2T2EGaH68ZnZJEUYfQd9MIyY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=WcCv/Y/izwl8NjBZ23lS5wwmxCSbDcQfmYsYxJzlcI4QCvh8+gfftYQ9t5/OxHMxlxlK63WZ0Z1Cr9bAx6uqgc3JpREeqkmFkHUq/BgmtAxjVCWd32//9kZUeqEm6pKj+U6ctAKhew3fWHg5IGB0m8I2IQa93BKLPOWLBeYYI4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:tivesync7t1788745975t0ed254fe
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.66.61])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 8870838383209846061
To: <netdev-bot+sashiko@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<jacob.e.keller@intel.com>,
	<horms@kernel.org>,
	<kees@kernel.org>,
	<aleksandr.loktionov@intel.com>,
	<weirongguang@kylinos.cn>,
	<zhaochenguang@kylinos.cn>,
	<u.kleine-koenig@baylibre.com>
References: <95D34449BA183C54+20260901070238.78509-1-jiawenwu@trustnetic.com> <178850546547.4131868.7297006717950754856@kernel.org>
In-Reply-To: <178850546547.4131868.7297006717950754856@kernel.org>
Subject: RE: [RESEND PATCH net-next] net: wangxun: refactor NCSI and WOL capability checks
Date: Mon, 7 Sep 2026 09:52:53 +0800
Message-ID: <008101dd3e6b$98e6fac0$cab4f040$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIr6vaWKDBWCW1V34E+tRZ8+n0iqAHkPg/WthXdpRA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NDu8aKWRFc7D3wCZeriPOOhXurdF5CWtpTfPzqAj4vxNc4Z3no1OL/6A
	3LIhsVjZvJkYAYx/aQpSohtEAJSyim5m0mHy36jiCdpCr4kw+XbZF3Yh5PCMc9FltB/CR9k
	0139LocKAD4Fw8Sg0/VoMGw7FytiByF7ywsJqfkuTk2BtQ70v+kxXaZ+Id2yjHh6JGDE/sD
	Qp0hyFv7Rk1EnzRZuexoLYknKIDC9uyYVMAHlX2a/jVZfNqrYaFgidd1YJv4CfvIHhjRzQ8
	ArHBWeIWH35rM3i0SfR1o9yrH6ZDQfQe0ElatuN95EGPRYPpw8jHjbNzuz2xlWRyXLBDwYk
	a/J3zeLuRABY/q3LJoMNIs9PaPznIK1edOdFzWy9HfUhItqwgGSCu55c9dtXotsNq6+EZTE
	o379+y3T7fVXKTcNja+q0+atyFTOTxMiikLf3v9svqMvfeSYgOS35UbDRqW5luSzDE4m01n
	1u4t81zYytqyBJeH7hfT0NZ5xnfozXp7veBAEDKijjEaQWkDsWvmSDrWkWVDA9Vrd2Pkkch
	jtGMW7ON/dKTiV2pv0ZKBQGzKSglB+NK6T0XPSaB5LXhDQzRf4KjIravfGWV5tc9WPCn5qH
	EgPdhJbKj1rh/vzVc0tfN1MG4zSlUPatwngQqsyMw+ehlsR5anoXdB2ikOIH0ceclLjBoe9
	Z/P7fS26d7OtAikvCZPKFwLDxz/9FGOErnYSiuokpxSoBiTaKnpD2tgWVpGdf/pQ3+2JiFv
	n81db+6yWqYkDTku4bUiuTOpkSnY3ay1EaOSjX0Pa1gTI7hhtofktfgW3+x2HogE0YL49Xh
	/l2R5eFyQ9G74eVijPZPgM7qRrljNpUA2vyPjX+YRxXCGazaJzDFeP+7Z5R+OcEuLVzrHRM
	xY+Xi4d3CQtINVwEwuOl8NpJqVIOoM6cblbiLx9QrLWmzHusR6hLaacRdkOXtY5KCtO1CxG
	NRDwxyRoUnUiR8VRk3PSDL5LpZXuObGsfo0ZreNSEbkJb5y75L3BIordngtHsOlfW3bV1xZ
	Dc5xku+NtXELHegmPt7R7UfqnaaXK9oPJ1jcDKcdWlWiM5mkreptM2p98P86Fv+QKoYnHKZ
	Zf8Ppa/ILwg
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c =
b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> > index 122c4952d203f..f0046dcb54962 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> > @@ -1313,8 +1313,7 @@ void wx_disable_rx(struct wx *wx)
> >  		rxctrl &=3D ~WX_RDB_PB_CTL_RXEN;
> >  		wr32(wx, WX_RDB_PB_CTL, rxctrl);
> >
> > -		if (!(((wx->subsystem_device_id & WX_NCSI_MASK) =3D=3D =
WX_NCSI_SUP) ||
> > -		      ((wx->subsystem_device_id & WX_WOL_MASK) =3D=3D =
WX_WOL_SUP))) {
> > +		if (!(wx->ncsi_enabled || wx->wol_hw_supported)) {
> >  			/* disable mac receiver */
> >  			wr32m(wx, WX_MAC_RX_CFG,
> >  			      WX_MAC_RX_CFG_RE, 0);
>=20
> [Severity: Medium]
> wx_disable_rx() is shared libwx code, so ngbe reaches this too.  Is =
the new
> condition still equivalent for ngbe?
>=20
> ngbe_init_type_code() sets ncsi_enabled with an extra OCP term:
>=20
> drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:
> 	type_mask =3D (u16)(wx->subsystem_device_id & NGBE_OEM_MASK);
> 	ncsi_mask =3D wx->subsystem_device_id & WX_NCSI_MASK;
> 	...
> 	wx->ncsi_enabled =3D (ncsi_mask =3D=3D WX_NCSI_SUP ||
> 			   type_mask =3D=3D NGBE_SUBID_OCP_CARD) ? 1 : 0;
>=20
> NGBE_OEM_MASK is 0x00FF and NGBE_SUBID_OCP_CARD is 0x0040, while
> WX_NCSI_MASK is 0x8000 and WX_WOL_MASK is 0x4000, so the OCP term is
> independent of the two bits the old expression tested.
>=20
> For an ngbe adapter with (subsystem_device_id & 0x00FF) =3D=3D 0x0040 =
and bits
> 15 and 14 clear, the pre-patch expression evaluated false and the =
driver
> cleared WX_MAC_RX_CFG_RE; after this patch ncsi_enabled is true and =
the
> write is skipped, so WX_RDB_PB_CTL_RXEN is cleared but the MAC =
receiver
> stays enabled.  That affects the ngbe down/reset paths that call
> wx_disable_rx(): ngbe_disable_device()->wx_disable_rx(),
> ngbe_reset_hw()->wx_stop_adapter()->wx_disable_rx(), and
> wx_configure_rx()->wx_disable_rx().  wx_enable_rx() still sets
> WX_MAC_RX_CFG_RE, so on those SKUs the enable would no longer have a
> matching disable.
>=20
> Also, at the baseline wx->ncsi_enabled had no readers anywhere in the
> wangxun tree, so this patch gives it its first reader inside code ngbe =
uses,
> without the patch touching ngbe.
>=20
> Is the OCP term intended to apply to wx_disable_rx() as well?  If not, =
would
> a separate strict capability field (for example ncsi_hw_supported) =
used by
> wx_disable_rx() keep the behaviour unchanged?
>=20
> The commit message says:
>=20
>     There is a clean refactoring that replaces inline bitwise checks =
with
>     precomputed boolean fields. The hardware capability of NCSI and =
WOL is
>     obtained from the sub-system ID and do not change.
>=20
> Given the ngbe OCP term, is "do not change" accurate for all wangxun
> devices, and could the message spell out the ngbe behaviour change?

The behavior change is intentional, the old inline check was incorrect =
for
ngbe OCP cards, and the refactoring fixes it.

I'll update the commit message to mention that. And I think the V2 patch
should submit to the net tree.

>=20
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c =
b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > index eb91c4f28ecd4..8c508aa3ce62e 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
>=20
> [ ... ]
>=20
> > @@ -336,6 +335,8 @@ static void txgbe_down_suspend(struct wx *wx)
> >   **/
> >  static void txgbe_init_type_code(struct wx *wx)
> >  {
> > +	u16 ncsi_mask =3D wx->subsystem_device_id & WX_NCSI_MASK;
> > +	u16 wol_mask =3D wx->subsystem_device_id & WX_WOL_MASK;
> >  	u8 device_type =3D wx->subsystem_device_id & 0xF0;
> >
> >  	switch (wx->device_id) {
>=20
> [ ... ]
>=20
> > @@ -381,6 +382,9 @@ static void txgbe_init_type_code(struct wx *wx)
> >  		wx->media_type =3D wx_media_unknown;
> >  		break;
> >  	}
> > +
> > +	wx->wol_hw_supported =3D ((wol_mask) =3D=3D WX_WOL_SUP);
> > +	wx->ncsi_enabled =3D ((ncsi_mask) =3D=3D WX_NCSI_SUP);
> >  }
>=20
> [Severity: Low]
> This isn't a bug, but the inner parentheses around the plain locals =
wol_mask
> and ncsi_mask in txgbe_init_type_code() are redundant:
>=20
> 	wx->wol_hw_supported =3D (wol_mask =3D=3D WX_WOL_SUP);
> 	wx->ncsi_enabled =3D (ncsi_mask =3D=3D WX_NCSI_SUP);
>=20
> The two single-use locals are also declared at the top of
> txgbe_init_type_code() but only consumed after both switch statements.
> Would assigning the booleans directly from wx->subsystem_device_id at =
the
> point of use, as ngbe_init_type_code() does inline, drop both locals?

Okay, I'll drop them.

>=20
> --
> Sashiko AI review =C2=B7 =
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/95D34449BA183C54%2B20=
260901070238.78509-1-
> jiawenwu%40trustnetic.com
>=20

