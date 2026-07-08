Received: from a9-26.smtp-out.amazonses.com (a9-26.smtp-out.amazonses.com [54.240.9.26])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D9236212F;
	Wed,  8 Jul 2026 01:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.9.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783472961; cv=none; b=DB/RUqK0aU/wk/x6fLDsXT3vjmdsadDZ0FI4B8Fa2bb03w9/gvKHqR447iaYEPhQJXwPKoVR5dgX8r/v5xjZAyie60bRSgmUObPayMzegHDm73ZBFeT30lFmMIgNZ8m8Sfh3uJ1IR2m1REISuMln2wZDDAud/UQgXD7zvT56XEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783472961; c=relaxed/simple;
	bh=9O8Ed3yXJNMb/sv2HUAs175+2Q5UmTYPlU/Kxl4JPdA=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=gcDALmm0ckYbxNll3gv8KAuM6oeZXiuP0D4eCzEb3VG6eiFVkndHVliRac/YAJb2mBzfZPCvPSeDUvG67oG7noboQSkhlXl3tXLKqc3JFxI6lB+ZqYfxcyO6nlCmNZKcYTrK5Jlsej+JPQ0UTW3TnjYtTHvx1sdGHZL/kzoZH8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=vIyDnLIw; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Zw3tBUZa; arc=none smtp.client-ip=54.240.9.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b="vIyDnLIw";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Zw3tBUZa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1783472958;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=9O8Ed3yXJNMb/sv2HUAs175+2Q5UmTYPlU/Kxl4JPdA=;
	b=vIyDnLIwHJPlhmzOHRRlnYiP0qrZLAocNF+LPTsVjnojxEB02bebTVW43U/C77O1
	m4ETN/WOex4+xIpqkubd+d3gVI1EX71d0f5yuMGxBZB8Yd5DiyCjIJ59ibBQ95XYyO0
	176dFzvd1IB7o22SmZis1J3XOvlNcwHGdkwOEg0o=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1783472958;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=9O8Ed3yXJNMb/sv2HUAs175+2Q5UmTYPlU/Kxl4JPdA=;
	b=Zw3tBUZaDDOTGbJTB28AC4DAuzMB813M6MIYsEYAwCo08+DWXrwGut2pylK+Wzim
	ZarpCW4oT+fwxBYDcD8ht+clceHpxOC7wmgmlufmD0oLo+1ZkleE5PbZkqr91tzFbMr
	H1V+Oh1UQvpvUom0ynzxks68HhwBsYjcFTR9rOPw=
In-Reply-To: <e4e1d392-2430-4403-91b1-5be59d6a9895@bootlin.com>
From: Johan Alvarado <contact@c127.dev>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, namiltd@yahoo.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] net: dsa: realtek: rtl8365mb: add
 SGMII support for RTL8367S
Message-ID: <0100019f3f45ab47-bab143e1-1dee-49f0-9b38-16fd0d84175e-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 8 Jul 2026 01:09:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.07.08-54.240.9.26

Hi Maxime,

On 7/3/26 09:29, Maxime Chevallier wrote:
> Ah nice conversion to phylink PCS :) I have a few comments below

Thanks for the review!

[...]

>> +	/* This driver does not implement SGMII=
 in-band autonegotiation yet, so
>> +	 * the link parameters are forced =
from rtl8365mb_pcs_link_up() instead.
>> +	 * rtl8365mb_pcs_inband_caps() =
reports this to phylink, which should
>> +	 * therefore never select an =
in-band-enabled negotiation mode.
>> +	 */
>> +	if (neg_mode =3D=3D =
PHYLINK_PCS_NEG_INBAND_ENABLED)
>> +		return -EOPNOTSUPP;
>
> As you implement the .pcs_inband_caps() method, phylink will pass you a =
valid
> mode, no need for that check :)

Indeed. I went through =
phylink_pcs_neg_mode() again and with
pcs_inband_caps() returning =
LINK_INBAND_DISABLE every path resolves to
an outband (or inband-disabled, =
for the 802.3z no-PHY case) negotiation
mode, so this is dead code. I will =
drop it in v5.

[...]

>> +		/* The SerDes has its own pause controls; =
program them from
>> +		 * the resolved pause modes, as the vendor driver =
does when
>> +		 * forcing the link on a SerDes external interface. This is
>> +		 * done here rather than in rtl8365mb_pcs_link_up() because
>> +		 * pcs_link_up() carries no pause information.
>> +		 */
>> +		if (rtl8365mb_interface_is_serdes(interface)) {
>> +			u32 val =3D 0;
>> +
>> +			if (tx_pause)
>> +				val |=3D RTL8365MB_SDS_MISC_SGMII_TXFC_MA=
SK;
>> +			if (rx_pause)
>> +				val |=3D RTL8365MB_SDS_MISC_SGMII_RXFC_MAS=
K;
>
> Do you know what this does in HW ? Is this so that the PCS lets the =
Pause frames through
> in either directions ?
>
> I suspect this is =
something that would be only used for inband advertising
> of pause settings (in such case, you don't even need that), but ofc I'm =
not sure :)
>
> You already configure the MAC pause settings, can you test =
that these bits actually do
> anything by exercising a bit flow control and=
 checking if these registers are used ?

I tested it on the hardware, and =
it turns out these bits are the
operative pause controls for the SerDes =
port: pause frames are only
ever emitted when SDS_MISC_SGMII_TXFC is set, =
and the MAC force-mode
pause bits alone have no observable effect on this =
port. They are not
tied to in-band advertisement either - they act with the=
 link fully
forced.

For context, there is no public documentation for =
these bits, but in
the vendor GPL code every write to them lives in
rtl8367c_setAsicPortForceLinkExt(), the forced-link path, where they
are programmed from the resolved tx/rx pause settings right alongside
the MAC force-mode pause bits - never from the nway/in-band paths.

Test setup: RTL8367S (Mercusys MR80X), CPU port 6 on HSGMII,
2500base-x fixed link to an IPQ5018. I enabled regmap debugfs writes
so I could flip the bits live, and forced congestion by L2-forwarding
~350 Mbit/s of SoC-generated UDP in through the CPU port and out of a
100M user port (~3.5x oversubscription, ~135 MB per run), watching the
CPU port's dot3OutPauseFrames MIB counter:

  everything cleared =
(baseline):                 0 pause frames
  MAC force pause only =
(DIGITAL_INTERFACE_FORCE
      TXPAUSE|RXPAUSE, reg 0x1311):              0=
 pause frames
  MAC force pause + SDS TXFC|RXFC:            2396 pause =
frames
  SDS TXFC|RXFC only (MAC pause cleared):     2362 pause frames
  SDS TXFC only:                              2934 pause frames
  SDS RXFC only:                                 0 pause frames

RXFC did not influence pause emission, so by symmetry it presumably
gates honouring received pause frames; I could not exercise that
direction because the SoC MAC on this board never transmits pause.

So the write has to stay - without it flow control simply does not
work on SGMII/HSGMII. I will expand the comment in v5 to say that
these are the functional pause enables for the SerDes, rather than
describing it as mirroring the vendor forced-link sequence.

Best regards,
Johan
