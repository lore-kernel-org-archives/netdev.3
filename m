Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668667;
	b=nRhOetoP/F7de52okLi7jKBK+ORueomHmEbKY7IX0r+j5xwwFNnvt2XFO5A1tXBwu3Pt
	 YSi1D93Ee5UbNdMMDf97zUqt3r6nmWB6r+gHrd2N5r2kUu39F9jOGkuqI2/aOnWiN4EEZ
	 zCxAAyI8W7vlyEQZ4MImsE3Gf2GJC8/wGrhNn3h83MruZdcrBYnCvAusl+Rz65w6ij/kn
	 imh53c4ayr/UlZ5hmP0B3yygpUz8Y2peduSIA6TsWLPI7mLHnhJFWCwa9jn2E1YIX03jH
	 ezEgeoO06Bwx7Uxign4IqZPkB5jFQT3NmnYBHiWTpXq8ootcRqL3/4sXotaibKvduCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668667;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=LPtOsPhf3qNQ+WDuZ7lQU3mMhCaKIt/W3KycpH260F0=;
	b=vApNgS8rlL1/xg58+1znsQQc1YyyJ/opbOiTMzMzZ6B1PLAua+m+I6zZOfisXmqSge5W
	 iP8cpejPxd3bDDsi/SdYbJN3Iai9gwg4qpzcIcUMj6CTKH09rb3qLLKuUfnfuJXgMm+YC
	 o3p9zEW9I94TGX2sF3uqQ+apfaX69ObGUDZiZjrmO+W2Y88qabCvdDl/ASK2BTPVw46xW
	 H4RS0cTs2oAci81d+zU1M8HBKuc2Q4hMMxd1/13+eKY4kdeBLsCKZjWkBT1WrSULOD/Bj
	 7EmJGKL6OsMkZFAAUF+EFCHqMOKGFGsJVIILM2j/mN9UMLv1pFbzJ5MOdpEGwI0yqJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=KjZLqQFO;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6652606A319;
	Thu, 22 Oct 2026 11:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6652606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=KjZLqQFO
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69MBUKvdC860903, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1792668620; bh=LPtOsPhf3qNQ+WDuZ7lQU3mMhCaKIt/W3KycpH260F0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KjZLqQFOZ6igvd4j/LD+GCBqXv8ksx0Ode2EwRUPaWnhthYA0ruv6iWFdce3E+zEK
	 FraR73SRtGNZ4HnmryLIZlp+7QgDrTUNqSlIwv81FhsCNOGu9apWqXjiSl6vzhXXiU
	 rC14ArKGShEe4o+qHlK66oQZaxNX+S7711nS5QLQXapiezMbK9/r9LZCudeYCapwQ0
	 fbzooMFxqt5s5eH/uwlQ13FilKykpILyIrv6yMoJtLqgeFMyVrfQzVB8MrudKx5mpH
	 D5/2tpiWmkMnYav86CJTyRC0xW0tRFWn4Ul2t6aw1xWM2s3xmgcMEakA107inKZDiI
	 2KqKpsyvz+t3g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69MBUKvdC860903
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Oct 2026 19:30:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 19:30:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Thu, 22 Oct 2026 19:30:19 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, nic_swsd <nic_swsd@realtek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "bjorn@mork.no" <bjorn@mork.no>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "mail@birger-koblitz.de" <mail@birger-koblitz.de>
Subject: RE: [PATCH net-next v7 08/10] r8152: add TGPHY register access for
 RTL8157 and RTL8159
Thread-Topic: [PATCH net-next v7 08/10] r8152: add TGPHY register access for
 RTL8157 and RTL8159
Thread-Index: AQHdW7Sx8HBQfKfQi0mxvAxbM5jHf7cGr0yAgAKXA8A=
Date: Thu, 22 Oct 2026 11:30:19 +0000
Message-ID: <7fca8dc9e982437898d725aad8601969@realtek.com>
References: <20261014081904.6491-9-nic_swsd@realtek.com>
 <20261021005213.1255035-1-kuba@kernel.org>
In-Reply-To: <20261021005213.1255035-1-kuba@kernel.org>
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
> r8152: add TGPHY register access for RTL8157 and RTL8159
>=20
> This adds a TGPHY command channel backend for PHY register access on
> RTL8157 and RTL8159. It is selected through new rtl_ops.phy_read and
> phy_write hooks. The helpers built on ocp_reg_read()/ocp_reg_write() now
> return int, and a subset of callers propagate the errors.
>=20
> > This patch propagates the status only where an errno would otherwise
> > be taken for register content or reported as
> > success: the pause parameters, rtl8152_set_speed(),
> > SIOCGMIIREG/SIOCSMIIREG, the PHY patch handshake and the PHY firmware
> > version checks.
> >
> > Not handled here, and left to a follow-up series: the remaining
> > callers, notably the hw_phy_cfg and init sequences,
> > r8153_phy_status(), r8152_mmd_read(), EEE handling and the MII library
> > callbacks, still ignore the status.
>=20
> [Severity: Medium]
> Is this description accurate? Some of the callers listed as still ignorin=
g the status
> do act on it in this diff.
>=20
> r8153_get_eee() returns an errno from each of its ocp_reg_read() calls:
>=20
>         ret =3D ocp_reg_read(tp, OCP_EEE_ABLE, &val);
>         if (ret < 0)
>                 goto out;
>=20
> r8153_phy_status() now leaves its poll on the first failed read:
>=20
>         if (ocp_reg_read(tp, OCP_PHY_STATUS, &data) < 0)
>                 break;
>=20
> rtl8152_get_link_ksettings() is not in either list. It now fails the whol=
e request
> when the OCP_10GBT_CTRL or OCP_10GBT_STAT read fails.
>=20
> rtl8153_in_nway(), r8156_mdio_force_mode(), r8156_eee_en() and
> rtl8152_fw_phy_fixup() also return early on a read failure now.
>=20
> Could the commit message be updated to cover these changes?

Sure, I will update the commit message.

>=20
> > diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c index
> > 558ccb4682c27..7c0de56266963 100644
> > --- a/drivers/net/usb/r8152.c
> > +++ b/drivers/net/usb/r8152.c
>=20
> [ ... ]
>=20
> > @@ -1664,16 +1675,33 @@ static void ocp_reg_write(struct r8152 *tp,
> > u16 addr, u16 data)
>=20
> [ ... ]
>=20
> > +static int r8152_mdio_read(struct r8152 *tp, u32 reg_addr) {
> > +     u16 data;
> > +     int ret;
> > +
> > +     ret =3D ocp_reg_read(tp, OCP_BASE_MII + reg_addr * 2, &data);
> > +
> > +     return ret < 0 ? ret : data;
> >  }
>=20
> [Severity: Medium]
> On RTL8157/RTL8159, can this pass -ETIMEDOUT to the generic MII library a=
s if
> it were a BMCR value? read_mii_word() is the mii_if_info.mdio_read callba=
ck,
> and it returns the result of r8152_mdio_read() unchanged.
>=20
> mii_nway_restart() in drivers/net/mii.c does:
>=20
>         bmcr =3D mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
>=20
>         if (bmcr & BMCR_ANENABLE) {
>                 bmcr |=3D BMCR_ANRESTART;
>                 mii->mdio_write(mii->dev, mii->phy_id, MII_BMCR, bmcr);
>                 r =3D 0;
>         }
>=20
> -ETIMEDOUT is 0xffffff92, which has BMCR_ANENABLE set. write_mii_word()
> only filters RTL8152_INACCESSIBLE, and a TGPHY timeout does not set that =
flag.
> So 0xff92 would be written to BMCR. That sets BMCR_RESET, BMCR_LOOPBACK,
> BMCR_PDOWN and BMCR_ISOLATE, and the call still returns 0.
>=20
> The path is:
>=20
> rtl8152_nway_reset()
>   mii_nway_restart()
>     read_mii_word()
>       r8152_mdio_read()
>         r8157_phy_read()
>           rtl_tgphy_access()
>             wait_tgphy_cmd_ready() returns -ETIMEDOUT
>=20
> rtl_ethtool_set_eee() also calls mii_nway_restart(). In addition,
> mii_ethtool_get_link_ksettings() would decode link modes from the errno.
>=20
> Before this patch, the only errno read_mii_word() could return was -ENODE=
V,
> and write_mii_word() filters that case.
>=20
> The commit message mentions this case, and the later patches in the serie=
s do
> not seem to address it. rtl_ops_init() switches RTL_VER_16/17 to
> r8157_phy_read() in this patch. Could read_mii_word()/write_mii_word()
> handle the errno before or in this patch?

The driver uses mii_nway_restart() and mii_ethtool_get_link_ksettings(), re=
turning 0
when tgphy timed out can prevent the two functions from using the -ETIMEDOU=
T as
a BMCR/BMSR value.

I will fix this in the next version.

>=20
> > @@ -1906,100 +1950,217 @@ static void ocp_byte_set_bits(struct r8152
> > *tp, u16 type, u16 index, u8 set)
>=20
> [ ... ]
>=20
> > +static int wait_tgphy_cmd_ready(struct r8152 *tp) {
> > +     u16 ocp_data;
> > +     int ret;
> > +
> > +     ret =3D read_poll_timeout(ocp_read_word, ocp_data,
> > +                             test_bit(RTL8152_INACCESSIBLE,
> &tp->flags) ||
> > +                             !(ocp_data & TGPHY_CMD_BUSY),
> > +                             2000, 20000, false, tp,
> > +                             MCU_TYPE_USB, USB_TGPHY_CMD);
> > +
> > +     if (ret)
> > +             dev_err(&tp->intf->dev, "TGPHY cmd busy timeout\n");
>=20
> [Severity: Medium]
> What happens if TGPHY_CMD_BUSY stays set while USB transfers still work?
> Each PHY access then waits up to 20ms here, or 40ms for a read. It also p=
rints
> another error that is not ratelimited. There is no recovery, and
> RTL8152_INACCESSIBLE is never set.
>=20
> Most callers ignore the status and keep going. r8157_hw_phy_cfg() makes w=
ell
> over a hundred PHY accesses, and the firmware loaders do one write per
> firmware word:
>=20
> rtl8152_fw_phy_nc_apply() {
>     ...
>         for (i =3D 0; i < num; i++)
>                 ocp_reg_write(tp, OCP_SRAM_DATA,
> __le16_to_cpu(data[i]));
>     ...
> }
>=20
> rtl8152_fw_phy_union_apply() has the same loop.
>=20
> All of this runs with tp->control held in the probe, resume, open and res=
et paths.
> Could this stall for seconds or minutes and flood the log?
> Would ratelimiting the message, or stopping the sequence after the first
> timeout, avoid that?

I prefer to ratelimit the message.

>=20
> > +
> > +     return test_bit(RTL8152_INACCESSIBLE, &tp->flags) ? -ENODEV :
> > +ret; }
> > +
> > +static int rtl_tgphy_access(struct r8152 *tp, u16 addr, u16 *data,
> > +bool write) {
> > +     u16 cmd =3D 0;
> > +     int ret;
> > +
> > +     ret =3D wait_tgphy_cmd_ready(tp);
> > +     if (ret < 0)
> > +             goto out;
> > +
> > +     if (write) {
> > +             cmd |=3D TGPHY_CMD_WR;
> > +             ocp_write_word(tp, MCU_TYPE_USB, USB_TGPHY_DATA,
> *data);
> > +     }
> > +
> > +     ocp_write_word(tp, MCU_TYPE_USB, USB_TGPHY_ADDR, addr);
> > +
> > +     cmd |=3D TGPHY_CMD_BUSY;
> > +     ocp_write_word(tp, MCU_TYPE_USB, USB_TGPHY_CMD, cmd);
>=20
> [Severity: Low]
> This is a minor point. The status of the USB_TGPHY_DATA, ADDR and CMD
> transfers is not checked here.
>=20
> A misdirected command does not seem possible. r8152_control_msg() calls
> rtl_set_inaccessible() when a control transfer fails, so a CMD write that=
 follows a
> failed ADDR write is never sent.
>=20
> rtl_tgphy_access() can still return 0 once after a failed transfer, eithe=
r for a write
> or when the final USB_TGPHY_DATA read fails. Would it be cleaner to retur=
n
> -ENODEV when RTL8152_INACCESSIBLE is set at the end of the transaction?

Agree. Returning -ENODEV when RTL8152_INACCESSIBLE is set is cleaner.

>=20
> > +
> > +     if (!write) {
> > +             ret =3D wait_tgphy_cmd_ready(tp);
> > +             if (ret < 0)
> > +                     goto out;
> > +
> > +             *data =3D ocp_read_word(tp, MCU_TYPE_USB,
> USB_TGPHY_DATA);
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch, but ocp_read_word() ignores th=
e
> return value of generic_ocp_read():
>=20
> ocp_read_word() {
>     ...
>         generic_ocp_read(tp, index, sizeof(tmp), &tmp, type | byen);
>=20
>         data =3D __le32_to_cpu(tmp);
>     ...
> }
>=20
> RTL8152_INACCESSIBLE could be set between the second
> wait_tgphy_cmd_ready() and this read, for example by
> rtl8152_disconnect()->rtl_set_unplug(). In that case generic_ocp_read() r=
eturns
> -ENODEV early, tmp stays uninitialized, and rtl_tgphy_access() returns 0.
> SIOCGMIIREG could then copy that stack data into
> data->val_out.

The driver didn't propagate the error of ocp_read*; I think I should follow=
 the
original behavior.

Propagating and handling the error of generic_ocp_read() is out of scope.

>=20
> dev_ioctl() requires CAP_NET_ADMIN for SIOCGMIIREG, so unprivileged users
> cannot reach this. r8152_phy_read() already has the same flaw.
>=20
> [ ... ]
>=20
> > @@ -4177,11 +4338,13 @@ static void r8153b_green_en(struct r8152 *tp,
> > bool enable)
> >
> >  static u16 r8153_phy_status(struct r8152 *tp, u16 desired)  {
> > -     u16 data;
> > +     u16 data =3D 0;
> >       int i;
> >
> >       for (i =3D 0; i < 500; i++) {
> > -             data =3D ocp_reg_read(tp, OCP_PHY_STATUS);
> > +             if (ocp_reg_read(tp, OCP_PHY_STATUS, &data) < 0)
> > +                     break;
> > +
>=20
> [Severity: Medium]
> On RTL8157/8159, one 20ms TGPHY busy timeout now ends this poll, which
> previously ran for up to 500 x 20ms. The function then returns 0 or a sta=
le
> masked value. Is that safe for callers that switch on the result?
>=20
> r8157_hw_phy_cfg() {
>     ...
>         data =3D r8153_phy_status(tp, 0);
>         switch (data) {
>         case PHY_STAT_EXT_INIT:
>                 rtl8152_apply_firmware(tp, true);
>                 ocp_reg_clr_bits(tp, 0xa466, BIT(0));
>                 ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
>                 break;
>         case PHY_STAT_LAN_ON:
>         case PHY_STAT_PWRDN:
>         default:
>                 rtl8152_apply_firmware(tp, false);
>                 break;
>         }
>     ...
> }
>=20
> A return of 0 falls into the default case. That calls rtl8152_apply_firmw=
are(tp,
> false) and skips the EXT_INIT release writes, even when the PHY really is=
 in
> PHY_STAT_EXT_INIT. r8159_hw_phy_cfg() and
> r8157_init() follow the same pattern.
>=20
> The later r8153_phy_status(tp, PHY_STAT_LAN_ON) call also stops after its=
 first
> failed read. The PFM, ALDPS and related settings are then programmed befo=
re
> the PHY reaches LAN_ON, and WARN_ON_ONCE() fires.
>=20
> Before this patch, the loop always ran to its full timeout on these chips=
.

r8153_phy_status() should skip the status check and keep polling when
ocp_read_word() failed instead of early break.

>=20
> [ ... ]
>=20
> > @@ -4598,25 +4762,29 @@ static int rtl_phy_patch_request(struct r8152
> *tp, bool request, bool wait)
> >       }
> >
> >       for (i =3D 0; wait && i < 5000; i++) {
> > -             u32 ocp_data;
> > -
> >               if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> >                       return -ENODEV;
> >
> >               usleep_range(1000, 2000);
> > -             ocp_data =3D ocp_reg_read(tp, OCP_PHY_PATCH_STAT);
> > -             if ((ocp_data & PATCH_READY) ^ check)
> > +             ret =3D ocp_reg_read(tp, OCP_PHY_PATCH_STAT, &ocp_data);
> > +             if (ret < 0)
> > +                     return ret;
> > +             else if ((ocp_data & PATCH_READY) ^ check)
> >                       break;
> >       }
> >
> > -     if (request && wait &&
> > -         !(ocp_reg_read(tp, OCP_PHY_PATCH_STAT) & PATCH_READY)) {
> > -             dev_err(&tp->intf->dev, "PHY patch request fail\n");
> > -             rtl_phy_patch_request(tp, false, false);
> > -             return -ETIME;
> > -     } else {
> > -             return 0;
> > +     if (request && wait) {
> > +             ret =3D ocp_reg_read(tp, OCP_PHY_PATCH_STAT, &ocp_data);
> > +             if (ret < 0) {
> > +                     return ret;
> > +             } else if (!(ocp_data & PATCH_READY)) {
> > +                     dev_err(&tp->intf->dev, "PHY patch request fail\n=
");
> > +                     rtl_phy_patch_request(tp, false, false);
> > +                     return -ETIME;
> > +             }
> >       }
>=20
> [Severity: Medium]
> When request is true, PATCH_REQUEST is already set in OCP_PHY_PATCH_CMD
> by the time these two new return ret paths run. Do they leave it asserted=
? The
> -ETIME path releases it with rtl_phy_patch_request(tp, false, false), but=
 the
> errno paths return without doing that.

Agree. Even if the ocp_read_word() failed, the driver should try to release=
 it with
rtl_phy_patch_request() instead of returning without doing that.

>=20
> Callers treat any non-zero return as "not acquired" and do not release:
>=20
> r8157_hw_phy_cfg() {
>     ...
>         if (rtl_phy_patch_request(tp, true, true))
>                 return;
>     ...
> }
>=20
> r8159_hw_phy_cfg() and rtl_ram_code_speed_up() do the same. A TGPHY
> timeout on the OCP_PHY_PATCH_STAT read would leave the PHY in patch
> request mode. r8157_hw_phy_cfg() would also skip the rest of its configur=
ation.
>=20
> [ ... ]
>=20
> > @@ -6629,7 +6815,10 @@ static int rtl8152_set_speed(struct r8152 *tp, u=
8
> autoneg, u32 speed, u8 duplex,
> >               }
> >
> >               if (tp->support_2500full || tp->support_5000full ||
> tp->support_10000full) {
> > -                     orig =3D ocp_reg_read(tp, OCP_10GBT_CTRL);
> > +                     ret =3D ocp_reg_read(tp, OCP_10GBT_CTRL, &orig);
> > +                     if (ret < 0)
> > +                             goto out;
> > +
> >                       new1 =3D orig &
> ~(MDIO_AN_10GBT_CTRL_ADV2_5G | MDIO_AN_10GBT_CTRL_ADV5G
> >                                       |
> MDIO_AN_10GBT_CTRL_ADV10G);
> >
>=20
> [Severity: Medium]
> The reads are checked now, but the writes in rtl8152_set_speed() still ar=
e not.
> The commit message names this function as one where an errno is no longer
> reported as success:
>=20
>         if (orig !=3D new1) {
>                 r8152_mdio_write(tp, MII_ADVERTISE, new1);
>                 tp->mii.advertising =3D new1;
>         }
>         ...
>         if (orig !=3D new1)
>                 r8152_mdio_write(tp, MII_CTRL1000, new1);
>         ...
>         if (orig !=3D new1)
>                 ocp_reg_write(tp, OCP_10GBT_CTRL, new1);
>=20
> If one of these writes times out on RTL8157/8159, tp->mii.advertising is =
still
> updated. The function returns 0 as long as the BMCR write succeeds.
> rtl8152_set_link_ksettings() then saves tp->advertising, tp->speed and
> tp->duplex as if they had been applied.

Agree. If the write failed, tp->mii.advertising should not be updated.

>=20
> The PHY patch handshake has the same gap. rtl_phy_patch_request() does no=
t
> check the result of the PATCH_REQUEST write:
>=20
>         if (request) {
>                 ocp_reg_set_bits(tp, OCP_PHY_PATCH_CMD,
> PATCH_REQUEST);
>                 check =3D 0;
>         } else {
>                 ocp_reg_clr_bits(tp, OCP_PHY_PATCH_CMD,
> PATCH_REQUEST);
>                 check =3D PATCH_READY;
>         }
>=20
> This has three effects:
>=20
> - With wait false, a failed request or release returns 0. The firmware
>   path uses this mode through rtl_pre_ram_code(..., !power_cut).
> - With request true, a failed write polls for more than 5 seconds and
>   then returns -ETIME instead of the real errno.
> - With request false and wait true, a failed release runs all 5000
>   iterations and still returns 0.
>=20
> rtl_pre_ram_code() also turns any error into -ETIME, and
> rtl8152_apply_firmware() ignores its return value.
>=20
> Should these write results be checked as well?

Yes. If the previous write failed, rtl_phy_patch_request() should return ea=
rly
and pass the errno.

>=20
> > @@ -6660,20 +6849,23 @@ static int rtl8152_set_speed(struct r8152 *tp,
> u8 autoneg, u32 speed, u8 duplex,
> >       if (test_and_clear_bit(PHY_RESET, &tp->flags))
> >               bmcr |=3D BMCR_RESET;
> >
> > -     r8152_mdio_write(tp, MII_BMCR, bmcr);
> > +     ret =3D r8152_mdio_write(tp, MII_BMCR, bmcr);
> > +     if (ret < 0)
> > +             goto out;
>=20
> [Severity: Medium]
> Is the pending PHY reset lost when this write fails? PHY_RESET is cleared=
 before
> the write. On RTL8157/8159, r8152_mdio_write() can now return -ETIMEDOUT
> before anything is sent to the hardware:
>=20
> rtl_tgphy_access() {
>         ...
>         ret =3D wait_tgphy_cmd_ready(tp);
>         if (ret < 0)
>                 goto out;
>         ...
> }
>=20
> This can happen if the preceding OCP_10GBT_CTRL write is still busy.
>=20
> r8157_hw_phy_cfg() and r8159_hw_phy_cfg() end with set_bit(PHY_RESET,
> &tp->flags) so that the next rtl8152_set_speed() resets the PHY. If this =
write fails,
> BMCR_RESET never reaches the PHY and the flag is not set again.
>=20
> Should PHY_RESET be restored on this error path?

Yes. If the write timed out, the driver should restore PHY_RESET. This give=
s the=20
device another chance to reset PHY.

>=20
> [ ... ]

Best Regards,
Chih-Kai
