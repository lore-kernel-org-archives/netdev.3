Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671142;
	b=0As42/aKoCoEGVertWxME7KU1R5zcwIr6F175JVexDTVwgqxnRa2CEfKTlLHapGwHin9
	 F88Mw2PgcP7RuxaBZGGfv5n2OjRxpeDyDFgChHZ+7jLmwbFfU1iCJUHG1F3dJce7BiBPh
	 eZ8yZSE4y/hxjrOgEJVOFV6DYPhQNaQCk//KYslI5UbsFvlJCfxmLT1af6sZVyamM7/UV
	 ubmSePIDVm3ZO2IJRm92OmETAM94klf0EkS2hgEf0yLIucVxcsqXyk++sURh0+9S1gLto
	 EiH26jM48vTQSgITd/qwdQdpS5VwLR5mq2RoYzBaT0JHYS54N5fqrkVP1Taj9ioZ8OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671142;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=9ESlXKsYqubuEcnbT5ehTIabgxo+rsipXRoTVCUbPFM=;
	b=vhVDOvBxYOU8tBb0kxaqfccnf9a7vTGhHZwoPo9CIF6/S9AA19GF60FncoTCW85NjSAP
	 el+E2rc3KUBZZmLwJvY7dUwz6fBp+cRjSsT2kz/HEMtrG8EqeGCbSZ8YU2FRlSp1sJKgz
	 1qq4g5me0LZ31SI+dUC2cc8IaP6OTWTixJZ/DYZ2u/G6N7oW4Ao/qsJAmwbfRqOmYLHcC
	 0SUccgOKLUEJv7U9VpixeUp/FBX7wtu8lDFlUc9S5FmnZFRppEESDbk/eSVc4tlMf9UaR
	 0bNQpR7WTVh+v7/MpkAwf0Y5st5rBe5mZxVOo1nK8DuchQr31cKieB6GjxsANHSU+dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=fGmNIcZ0;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34837606A319;
	Thu, 22 Oct 2026 12:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34837606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=fGmNIcZ0
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69MCBpUI2876145, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1792671111; bh=9ESlXKsYqubuEcnbT5ehTIabgxo+rsipXRoTVCUbPFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fGmNIcZ077XGNLsKVRECLPISFgWdPPwewGBlLWbYA5lcVgKKdBHgvYgg0NkYGcy8l
	 KddHX1+IKE+bX3E0hXxKCOsEeakuEpPztRX/rtvy37dQIMB8vDi6SDcM9qIt0WkP1Z
	 U1Ra4qGTKs7bvyDjft1HYBoYHwVDdflsJQCaxUBN9Pit9z7UFRzsV3fdpGKGZHn3e2
	 Kqc9ojsfjvj6I2P7+8yVDsuMZX+JZ/reBhpDbn/3fJ23Kfk463TWpJZ1PlhkZFodrK
	 uMjqNYR6659gwnBanKEfJSpHD5bP2MuaobTvZSzMvHiuawQ2C8qI6EUlaCYnYINpzm
	 +3SmJa5qcP82g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69MCBpUI2876145
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Oct 2026 20:11:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 20:11:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Thu, 22 Oct 2026 20:11:51 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, nic_swsd <nic_swsd@realtek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "bjorn@mork.no" <bjorn@mork.no>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "mail@birger-koblitz.de" <mail@birger-koblitz.de>
Subject: RE: [PATCH net-next v7 10/10] r8152: enable UPS for RTL8157 and
 RTL8159 QFN68
Thread-Topic: [PATCH net-next v7 10/10] r8152: enable UPS for RTL8157 and
 RTL8159 QFN68
Thread-Index: AQHdW7SvE2omqpJKSk+ew+lE/ivmXbcGr00AgALK34A=
Date: Thu, 22 Oct 2026 12:11:51 +0000
Message-ID: <d7adc461849b43bf91eb94e7834d5b9c@realtek.com>
References: <20261014081904.6491-11-nic_swsd@realtek.com>
 <20261021005214.1255071-1-kuba@kernel.org>
In-Reply-To: <20261021005214.1255071-1-kuba@kernel.org>
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

On Wednesday, October 21, 2026 8:52 AM, Kicinski wrote:=20
> This is an AI-generated review of your patch. The human sending this emai=
l has
> considered the AI review valid, or at least plausible.
> ---
> r8152: enable UPS for RTL8157 and RTL8159 QFN68
>=20
> This patch adds r8157_ups_en() and calls it from rtl8157_runtime_enable()=
, so
> UPS is now switched on and off during runtime suspend and resume for
> RTL_VER_16 and RTL_VER_17_QFN68. It also adds per-speed EEE flags and
> 5G/10G speed encodings to r8156_ups_flags(), and skips the lite_mode
> encoding for those chips.
>=20
> > diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c index
> > 95f510da376de..7a1b34db1d88b 100644
> > --- a/drivers/net/usb/r8152.c
> > +++ b/drivers/net/usb/r8152.c
>=20
> [ ... ]
>=20
> > @@ -4484,6 +4522,49 @@ static void r8156_ups_en(struct r8152 *tp, bool
> enable)
> >       }
> >  }
> >
> > +static void r8157_ups_en(struct r8152 *tp, bool enable) {
> > +     if (enable) {
> > +             r8156_ups_flags(tp);
> > +
> > +             ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
> > +                               UPS_EN | USP_PREWAKE |
> PHASE2_EN);
>=20
> [Severity: Medium]
> This is a pre-existing issue, but this patch adds more callers of the
> ocp_byte_w0w1() read/modify/write path, and that path depends on
> get_registers():
>=20
> drivers/net/usb/r8152.c:get_registers() {
>     ...
>         if (ret < 0)
>                 memset(data, 0xff, size);
>         else
>                 memcpy(data, tmp, size);
>     ...
> }
>=20
> usb_control_msg() accepts short IN transfers. Could a malicious device re=
ply
> with fewer than size bytes and leave stale kmalloc() data in the part of =
tmp it
> never wrote?
>=20
> ocp_byte_w0w1() then writes that byte back with only the masked bits
> changed:
>=20
>         ocp_data =3D ocp_read_byte(tp, type, index);
>         ocp_data =3D (ocp_data & ~clear) | set;
>         ocp_write_byte(tp, type, index, ocp_data);
>=20
> That would let the device read back up to 8 bits of stale heap data per
> read/modify/write. This does not happen with init_on_alloc. Every
> read/modify/write in the driver has the same pattern, and this patch does=
 not
> change get_registers().
>=20
> > +
> > +             ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_MISC_2,
> > +                               UPS_FORCE_PWR_DOWN);
> > +     } else {
> > +             ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
> > +                               UPS_EN | USP_PREWAKE);
> > +
> > +             ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_MISC_2,
> > +                               UPS_FORCE_PWR_DOWN);
> > +
> > +             if (ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0) &
> > + PCUT_STATUS) {

Agree. But I think this issue is out of scope.

>=20
> [Severity: Low]
> This isn't a bug introduced by this patch, but ocp_read_word() ignores th=
e
> return value of generic_ocp_read() and uses its local tmp anyway:
>=20
> drivers/net/usb/r8152.c:ocp_read_word() {
>         __le32 tmp;
>     ...
>         generic_ocp_read(tp, index, sizeof(tmp), &tmp, type | byen);
>=20
>         data =3D __le32_to_cpu(tmp);
>     ...
> }
>=20
> If RTL8152_INACCESSIBLE is already set, generic_ocp_read() returns -ENODE=
V
> without writing the buffer. The same happens if kmalloc() fails in get_re=
gisters().
> Would the PCUT_STATUS check here, and the BACKUP_RESTRORE poll below,
> then test an uninitialized stack value?
>=20
> When the device is inaccessible, the writes that follow do nothing, so th=
e most
> likely visible effect is a KMSAN report. Every ocp_read_* caller is affec=
ted.
>=20
> > +                     u32 ocp_data;
> > +                     int ret;
> > +
> > +                     ret =3D read_poll_timeout(ocp_read_word, ocp_data=
,
> > +                                             ocp_data &
> BACKUP_RESTRORE, 200,
> > +                                             20000, false, tp,
> MCU_TYPE_USB,
> > +                                             USB_GPHY_CTRL);
> > +                     if (ret) {
> > +                             rtl_set_inaccessible(tp);
> > +                             dev_err(&tp->intf->dev,
> > +                                     "backup-restore timed out\n");
> > +                             return;
> > +                     }
>=20

I will add test_bit(tp->flag, RTL8152_INACCESSIBLE) to prevent the garbage =
value from being used.

> [Severity: Medium]
> Can this leave the interface unusable after a runtime resume, with nothin=
g to
> recover it?
>=20
> With this patch, runtime suspend on RTL_VER_16 and RTL_VER_17_QFN68
> enables UPS power cut by default. That means any runtime resume that find=
s
> PCUT_STATUS set will run this wait:
>=20
> rtl8152_runtime_resume()
>   tp->rtl_ops.autosuspend_en(tp, false)
>     rtl8157_runtime_enable(tp, false)
>       r8157_ups_en(tp, false)
>         read_poll_timeout() times out
>         rtl_set_inaccessible(tp)
>=20
> r8157_ups_en() returns void, so rtl8157_runtime_enable() carries on, and
> r8157_u2p3en() and r8153b_u1u2en() quietly do nothing.
> rtl8152_runtime_resume() then runs napi_disable()/napi_enable(),
> rtl8152_get_speed() and usb_submit_urb(), and returns 0.
>=20
> rtl8152_resume() has a reset fallback, but it is skipped for runtime
> resume:
>=20
>         if (!runtime_resume && test_bit(RTL8152_INACCESSIBLE, &tp->flags)=
)
>                 usb_reset_device(tp->udev);
>=20
> Once the flag is set, r8152_control_msg() also returns early:
>=20
>         if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return -ENODEV;
>=20
> This happens before it gets to the usb_queue_reset_device() logic, so lat=
er
> register accesses cannot start a recovery either.
>=20
> The netdev stays registered and up while every hardware access is skipped=
. That
> lasts until a replug, a system suspend/resume, or an unrelated reset. Bef=
ore this
> patch, rtl8157_runtime_enable() had no such wait.
>=20
> The commit message mentions this and defers recovery to a follow-up serie=
s.
> Since this path is on by default for these chips, should this patch at le=
ast queue a
> USB reset here (for example with
> usb_queue_reset_device(tp->intf)) or pass the error back?

Agreed that the latch is not recoverable from runtime resume. I kept it con=
sistent
with the existing r8159_wait_backup_restore() timeout in r8159_init(), whic=
h also
latches without a reset. Queuing a reset from here without a retry budget c=
ould
loop through reset, probe, runtime suspend, resume, and timeout again.

>=20
> > +
> > +                     /* clear USB fw_ver_reg */
> > +                     ocp_write_byte(tp, MCU_TYPE_USB,
> USB_FW_USB_VER,
> > + 0);
> > +
> > +                     tp->rtl_ops.hw_phy_cfg(tp);
>=20
> [Severity: Low]
> This isn't a bug introduced by this patch, but r8157_hw_phy_cfg() can ret=
urn
> early after it has already turned EEE and ALDPS off:
>=20
> drivers/net/usb/r8152.c:r8157_hw_phy_cfg() {
>     ...
>         r8153_aldps_en(tp, false);
>         rtl_eee_enable(tp, false);
>     ...
>         if (rtl_phy_patch_request(tp, true, true))
>                 return;
>     ...
> }
>=20
> If the PHY patch handshake times out (for example -ETIME when PATCH_READY
> never appears), the code skips re-enabling EEE and ALDPS and skips
> set_bit(PHY_RESET). By then r8153_eee_en() has already cleared
> tp->ups_info.eee.
>=20
> hw_phy_cfg returns void, so r8157_ups_en() goes straight on to
> rtl8152_set_speed() and runtime resume reports success. Does EEE and ALDP=
S
> then stay off until the PHY is reconfigured? Would the next UPS suspend a=
lso
> leave out the new per-speed EEE flags in r8156_ups_flags()?

Agreed that the failure leaves EEE and ALDPS off, but this isn't new. The s=
ame
early return after rtl_phy_patch_request() has been in r8156_hw_phy_cfg() a=
nd
r8156b_hw_phy_cfg() since RTL8157 support was added, and it is shared by
the hw_phy_work, r8153b_ups_en() and r8156_ups_en() callers. r8157_ups_en()
follows the same pattern as the existing UPS paths. Fixing it means changin=
g
hw_phy_cfg to return a status, or restoring the state on the early-return p=
ath,
for every chip, so I'd keep it out of this patch

>=20
> The hw_phy_work path and r8153b_ups_en()/r8156_ups_en() share the same
> early return. This patch adds one more caller.
>=20
> > +
> > +                     rtl8152_set_speed(tp, tp->autoneg, tp->speed,
> > +                                       tp->duplex, tp->advertising);
> > +             }
> > +     }
> > +}
>=20
> [ ... ]

Best Regards,
Chih Kai
