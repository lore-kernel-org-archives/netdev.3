Received: from a10-132.smtp-out.amazonses.com (a10-132.smtp-out.amazonses.com [54.240.10.132])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8CD221FB6;
	Mon, 22 Jun 2026 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.10.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150811; cv=none; b=Q39z1K6TruDOE5MZqR3jukr6Sk7MoI4CnDzFZFPz0Q4B5V5GOIj0SfhMsYlhuZURY7+4Xv/xqZ9r+KaL2l0lYLoY/OzUYQIT7HunPaDiNE948901hs4bjO477rl3JkcOdDwVoFZjiiW5DtPRuqErP4BuseCIq/2aziqOBabwRFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150811; c=relaxed/simple;
	bh=q0erdvXJ/SvDcWyTPwCHeC1TObRF5J4+xgcG7pWtgPw=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=uSKI4Ii3FtUMdxb96TD6aIc5tUGtqhVUiD12hTo3IOVC+hC7uwjX74p03RoqOZ9ZUQKnbbZR3Qk+EOLx8dxKBhj9MUCMXbo3pEzba6AgCtkJhzXQjNg9VIHLcuYgcmke1X0fY9TCJ1F1PFTT9VZniI1POpqxSJxBKi3FMMnzlCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=rnwijDLv; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=pd80Oacw; arc=none smtp.client-ip=54.240.10.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b="rnwijDLv";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="pd80Oacw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1782150808;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=q0erdvXJ/SvDcWyTPwCHeC1TObRF5J4+xgcG7pWtgPw=;
	b=rnwijDLvCZNPra8SpDtuqxZK8Z6B+CL0AqvHYKOwwgSvXkkgVpEwO9aZ5laIB165
	OiOLp4ABHl6mEB+kg/Tpw++iTAqRTnLlRAv26FMGkD6iGpZSY1XfpCmzcTYn7jJKEAE
	+W+lgN4f9Q6mRANQEAPM6AX39d7W3u/pjNersnsU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1782150808;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=q0erdvXJ/SvDcWyTPwCHeC1TObRF5J4+xgcG7pWtgPw=;
	b=pd80OacweoLqeeuGsJBHUBKI72srhnD3EwOtz7R+we/inBBL/r9XiFjR+0hZDj0p
	1S6R4ys5eFLitwAEIi+3JXJNLERFDgz7+P+Em+JSX5Sd9qmIhRug6KNIBPtQ5HDydGS
	kaOBUZCrgw0Bwa2tWQR7+0dX1P1aG/AMCruA20uU=
In-Reply-To:
 <CAJq09z4cVBuRUMyCt8NopNePmjbcj=ycvq95gSXgh581kk4zDw@mail.gmail.com>
From: Johan Alvarado <contact@c127.dev>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linusw@kernel.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux@armlinux.org.uk, maxime.chevallier@bootlin.com, 
	namiltd@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] net: dsa: realtek: rtl8365mb: add
 SGMII support for RTL8367S
Message-ID: <0100019ef0774191-97f957d1-76b2-427b-8a7a-24ae055f3ce0-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 17:53:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.06.22-54.240.10.132

Hi Luiz,

Sorry for the slow reply =E2=80=94 I wanted to test the changes =
on hardware
before answering rather than reply blind. I'm also adding the =
list
back to CC, since this is review of an on-list patch and the
discussion is useful for the archive; hope that's OK.

Thanks for the very thorough review. Almost everything is addressed in
v4, which I'll post once net-next reopens. Replies inline.

> You might want to omit any specific model as there are multiple
> possible supported models that have SGMII. Just use "only the RGMII
> and SGMII interface...". Determining which device supports what is a
> job for chip_info.

Done =E2=80=94 the NOTE comment no longer names a =
model, it just lists the
implemented interfaces.

> > +#define   =
RTL8365MB_SDS_INDACS_CMD_INDEX_MASK  0x0007
>
> Isn't this MASK larger? I =
was expecting 0x003F.
>
> Please use GENMASK/BIT whenever possible. It =
makes it clearer when
> there are holes or overlaps in the reg.
> Once a register macro is added with a bunch of bits described, I think
> it is better to describe all bits we can, even if not in use in this
> driver. Realtek normally maps bits sequentially and, with GENMASK/BIT,
> it is visually easier to spot errors.

The CMD index field is gone in v4:=
 I dropped the always-zero SerDes
index argument, so that mask was removed =
with it.

On GENMASK/BIT and documenting all bits: agreed in principle, but=
 the
driver currently uses raw hex masks almost everywhere (~75 raw _MASK
defines vs ~22 BIT/GENMASK), so converting only the new SDS defines
would make the file more inconsistent rather than less. Options as I
see them: (1) convert just the new defines, (2) keep raw hex to match
the surrounding style, or (3) a separate file-wide cleanup patch on
top of this series. I'd lean towards 3, keeping this series focused on
the feature and doing the style modernization as its own patch, but
I'm happy to do 1 if you'd rather the new code lead by example. Same
question for documenting currently-unused bits. Which would you prefer?

> > +#define RTL8365MB_SDS_INDACS_ADR_REG           0x6601
>
> This reg is formed by two parts but, in this case, it might be
> pedantic to add the descriptions as well.
> PAGE_MASK    0x7E0
> REGAD_MASK    0x1F

Noted. Since the addresses are passed as whole values=
 and the page/reg
split isn't used in the driver, I've left it as a single =
address for
now, but I can add the sub-field masks if you'd prefer them =
documented.

> > +#define   RTL8365MB_SDS_BMCR_DPRST_PHASE1      0x1401
> > +#define   RTL8365MB_SDS_BMCR_DPRST_PHASE2      0x1403
>
> I do not like magic numbers. You could do the BMCR_ANENABLE |
> BMCR_ISOLATE in the macro or code instead of just keeping it in a
> comment. It would give more semantics to the code.

Done =E2=80=94 the phase values are now built from the standard bits:

  #define RTL8365MB_SDS_BMCR_DPRST_PHASE1 (BMCR_ANENABLE | BMCR_ISOLATE | =
0x1)
  #define RTL8365MB_SDS_BMCR_DPRST_PHASE2 (BMCR_ANENABLE | =
BMCR_ISOLATE | 0x3)

> > +static const struct rtl8365mb_jam_tbl_entry =
rtl8365mb_sds_jam_sgmii[] =3D {
>
> I guess you got this from vendor's =
redData. However, that sequence is
> for the case when =
RTL8365MB_CHIP_OPTION_REG(0x13C1) =3D=3D 0. In my tests,
> rtl8367s returns 1 for that reg, which would select the redDataSB
> variant in the vendor's code. Did you test both or check register
> 0x13C1 [...] HSGMII also has a similar test in vendor's code.

Good catch. I checked 0x13C1 on the MR80X (with the magic
unlock/relock via 0x13C0): it reads option =3D 1, so the committed
tables are already the SB/HB variants. For SGMII the only difference
between redData and redDataSB is reg 0x482 (0x21A2 for option 0 vs
0x2420 for option 1), and my table has 0x2420; the HSGMII table
matches redDataHB likewise. I captured the full vendor write sequence
on hardware by chainloading a patched U-Boot, so both tables are
confirmed against the live silicon.

v4 reads 0x13C1 at runtime and returns=
 -EOPNOTSUPP for the option-0
variant rather than driving the SerDes with =
values I cannot verify on
available hardware.

> > +       if (extint->id !=
=3D 1)
> > +               return -EOPNOTSUPP;
>
> The model RTL8370MB is =
also a member of RTL8367C [...] Can't you just
> check extint =
supported_interfaces? [...] This type of hardcoded
> assumption just makes =
the job harder.

In v4 this hardcoded check is gone. With the phylink_pcs =
conversion
(see below), the SerDes is gated through supported_interfaces in
get_caps() and mac_select_pcs(), so whether a port uses the SerDes is
driven by chip_info rather than a hardcoded id.

> > +       ret =3D =
regmap_update_bits(priv->map, RTL8365MB_BYPASS_LINE_RATE_REG,
> > +                                BIT(extint->id), 0);
>
> BYPASS_LINE_RATE is actually indexed by port number starting at 5
> [...] Describe [it] with a parametric macro, receiving the port number
> and returning the BIT(5-port) as mask [...] For RTL8367R [...] it uses
> bit 0 for int 1 and bit 1 for int 0 or 2.

Done =E2=80=94 it's now a =
parametric macro:

  #define RTL8365MB_BYPASS_LINE_RATE_MASK(_port)  =
BIT((_port) - 5)

with a comment noting port 5 is the base and that other =
families (e.g.
the RTL8367R's (id + 1) % 2) index it differently, so this =
mapping
only holds for the RTL8367C-style parts the driver supports. One =
small
thing: your mail had BIT(5 - port), which inverts it (port 6 would be
BIT(-1)); I used BIT(port - 5) so port 5 maps to bit 0 =E2=80=94 let me =
know if
you meant something different.

> > +       usleep_range(10, 50);
>
> An arbitrary wait is not ideal but Mieczyslaw already suggested a
> better solution.

Done =E2=80=94 the usleep is gone. Writes are =
fire-and-forget and reads poll
the self-clearing BUSY bit with =
regmap_read_poll_timeout(), matching
the vendor's getAsicSdsReg. I =
instrumented it on the MR80X: the BUSY
bit is never even observed set (the =
access completes within the
register transaction over MDIO), so no sleep is=
 needed.

> > +       ret =3D regmap_update_bits(
> > +               =
priv->map, RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(extint->id),
> > +               [...]
>
> Sometimes it is just easier to use a temp =
variable instead of fighting
> with the 80-col limit.

Done, the mode value goes into a temporary now.

> The lack of test devices=
 is holding me back from making further
> improvements. [...] I think that,=
 with some limitations, the rtl8365mb
> driver [...] could support the full=
 range from RTL8370/RTL8367 up to
> RTL8367D.

Makes sense, and I tried to =
keep v4 from baking in RTL8367S-specific
assumptions where I could (the =
SerDes gating and the bypass macro
above). I can only test on the MR80X =
(RTL8367S) myself, so I've kept
the scope to what I can verify, but I'm =
happy to keep the code friendly
to that wider range.

One more thing from the wider discussion: following Maxime's review I
converted the whole SerDes path to a phylink_pcs in v4, so the SerDes
handling now lives in pcs_config()/pcs_get_state()/pcs_link_up() rather
than the ext/sds split in mac_link_up/down you saw in v3. pcs_get_state()
now reads the real SerDes link status (reg 0x3d) instead of reporting
the forced value.

Thanks again =E2=80=94 this review made the series =
substantially better.

Best regards,
Johan
