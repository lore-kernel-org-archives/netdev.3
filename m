Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DA42F8E94
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315396; cv=pass; b=u7GEDkFe7dxXV+1mxzwMcarAhcXpHy46U3Hbl5PGA2Q0hqwT4PcpCkGSCM0we8TIYiHiCYP1SZQIrzd0wH8Q2zbHoLxH1c1B5768woIAKVnBfRWIXRfA8X4KqCKXqmjSFLXZmtqv0bJhS4b5foFVT0WwHEyE4XQYTkUbmab6Kyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315396; c=relaxed/simple;
	bh=ap8rYUPr+Ud80xD6nROuYVOCOa5YMuyYE1yZNK885nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nx6NVefJwuqzcV8XliC7UdjUQUZRHEDWN402Wq2tRz0p7wAIft8VdDrwrutXCSCoGrvnVLxaLEYTghkICfdCC46wfrRfLE+/yxWb19oaAlWHMWgQCwtYCt8wKhqAxRQSYreiaTID9y4P9HbHnyMpC3RUOLICih49/GIXN59bWAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=py08HPjC; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="py08HPjC"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so1019848f8f.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 08:36:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782315393; cv=none;
        d=google.com; s=arc-20240605;
        b=K14sE5K0H2nfIU00yzM6ZLXiEnIBe7Kff529m0bUQkpeaGXnyZJqNufurhOS7reRY9
         KfxH4g6f8WiTKomMudZc/I6jv0aYCixnA+hYQddL9yGri+wWEqTvnIvzi1xjm5QzRikG
         nlISSSXexokF1l8x4MYb5zqGu3xRlQ6beOC7sztmcllu9n8NshLylRlcvUazvFT9lYbU
         Y7XGrEMzNVEvXzDqYDqH//O/16WghWTQkEpmAYvbZVgZFhT2SQ0yrta0V5v07woXgz/u
         VOQgABnS3LtFh0zHefIp5LEgBQ115MJI233vJFH2o6F9KqHitO7M26lcI4VnzDfVCDYZ
         MyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qwp/Vdma6g+Qdt4r9zbEPxAQlgWuv5rg5yo1N7l/l5U=;
        fh=7WSZMMcjkSP94lDJzpCPbCBM6kgfYB9I3myHKiCOtF8=;
        b=F/KlIPzhDQKIeErWjRH9dP+alXMDLsM13woWzy42+POxzKMsImuvJ5SK5GSVzefOwb
         yRrWxOdSW6Ma+iETo9RBCwL5zXFr4HDWN9hXTVU6MYZY7MgfQq0oaiHyBZZQzqwu0PId
         IvxeavgrSxDijitU4Z3hR2SBZp3v30YPmYUsIo/FxAdmUQAlGbluz5Sz1I1M75WLN/xs
         nOFMud5jPv7UqnAD32JsZYCjLo8f0nPonnzKEgdJhlDM/Dfga30daQt1IzsauT9tLSlu
         jOBrrwNxcQKLPYTAUKHb/+ackBEwKwJ0krGwcBULmkLwGU0xQL2cGWlwc0sTvb6NweGQ
         b0ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782315393; x=1782920193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwp/Vdma6g+Qdt4r9zbEPxAQlgWuv5rg5yo1N7l/l5U=;
        b=py08HPjCf9dm+ZtrfvSSIB1snDMJPW4Gd28SxVOJJII0XmygZqlakBFyzMNv2jEy7Y
         bRgESsFVBOnAqNDy8qmBOGtUxauVVnEAgPx3X3Fgk9ow8abQh84tVICLtWmqPfoIHcCl
         q3rgP959a1SZ6gRhY+WfrVReSy3D0C4HBPJsxUn1x3yEkbq8yd1BxUSiDr7RcESiiOrk
         R35cnkN3y2mG+wQWTinAsBlzWdpfa9hqW1SYHAUsFeGcLA54untK4oFljDPjFRHDdwkt
         RLlPaF5LNyqUzzWO+eqscvrw2C3mZPQKk5waQoZgQfdeb45b4kR1QJw1hLcRU5uueQx/
         4c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782315393; x=1782920193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qwp/Vdma6g+Qdt4r9zbEPxAQlgWuv5rg5yo1N7l/l5U=;
        b=AFab2zzThljmuKGtu6A3t4+Yxq82dJRqPl2ebmKpjgH9F5UuIb4D9Hrd4ag5UwYKWg
         OcFaaiBcGDIJ61Mt9kCRsce1SHnog46v5L65R4ePr7vgX77X/0IG+4lnwX7sLftR//1W
         c1aHa/dzuaOZLA3BG0yB48YB3TbuvppSGb8ipA7s0p+WM+sEJs9GMCwZ1iYVjiqNsL4T
         ekHcZFSRGf44vT1K9KTViM6B1XKiOp0gWO/3rCsSA3TmmZLe8USfXS3hlOe+3F+9SAb+
         LsJGwNKtYvDZuRLHuNj7WJkq0+Z/ss2lUMyctP8HHfD0Gpw+oQbdNnAuFT5qiJv3zBNR
         V4dQ==
X-Forwarded-Encrypted: i=1; AHgh+RrHoc6f3F2hMcI2LpcaczTh0wwt6kRy+gje9fIb3wQ426oYj5AAW7GHD6on0t3M4YVI9Juj2yM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ot6S8W3wwGBXD0nHpartO64zUJkD2/kzw75Ji8qxDfOERwo9
	qmD1GNm/oBBVXzSRZSYywK2p/Lvkz2pz3IQhl9htghv2ZTm77oxjJgt1Y4iBnpUjV5r8yr/GuRM
	nR0edlJ5wa/CjyIFfts33Y+Os3SA0TqE=
X-Gm-Gg: AfdE7ckh6mi3pHEcRNvGrb42NZBzm4DGWZFalMdXC+H4MvBV2iyOcrFlfrB6tdzcMtW
	1zaDyIsbH0r1MpuafI1gVDGmB/3yGADAICw+oOqPbMFPpnhkK1HVNULHhw6x+HPQZ1XtaBG+Q52
	s8fr/tHyVqcPjfokSeJCz3KLPCZ/L3bOuaahb96b89R/IHQQBV0R7FkJ3XKO86tRNCM0gxOMYT6
	owXzNGs6Pl9dVcxAp7SBh3o6IWolTu+/H8xsPFEmGH/R2eo8ltm9TYq++TPtQVatlg4FHUvInJM
	Im9XaXyVrDs+KCQHrL3JfCNawb+UrLYh4vyGz4L0ta4W5AclmbWXRA==
X-Received: by 2002:a05:6000:5c5:b0:464:b8d7:e5d8 with SMTP id
 ffacd0b85a97d-46ad90f5d19mr12501104f8f.14.1782315392769; Wed, 24 Jun 2026
 08:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f4a3e4ad-91e2-4844-a29b-81f70151228e@lunn.ch> <SN7PR11MB81099B4885C10E16D52A2EB9FFE52@SN7PR11MB8109.namprd11.prod.outlook.com>
 <06d8c98da24e80d148ede4e933bb621c5515a7a2.camel@gmail.com>
 <SN7PR11MB8109C173933D08F994FBB084FFE22@SN7PR11MB8109.namprd11.prod.outlook.com>
 <26971635-b13a-4ed3-b2cb-ce35da9b63d3@lunn.ch> <SN7PR11MB81096CF160930DB8FA278B3CFFE12@SN7PR11MB8109.namprd11.prod.outlook.com>
 <be5c474b-c969-49af-8235-825580ee945c@bootlin.com> <SN7PR11MB8109149608172808784CDCBEFFEF2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <5f22c491-b816-421e-a531-bf87a07fea70@lunn.ch> <08f1b0c2-2b09-4c30-b95a-02959d409a03@trager.us>
 <38359a70-ebc7-49c5-bae5-0d3d7bf82fac@lunn.ch>
In-Reply-To: <38359a70-ebc7-49c5-bae5-0d3d7bf82fac@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 24 Jun 2026 08:35:56 -0700
X-Gm-Features: AVVi8CdtR9IZgvFarq_A5iW9hrev6dYsKRqX_DoFAjauTvkrYand4DNPxxj8GmU
Message-ID: <CAKgT0Ufpp+AVrW4raMw=_PEWQdu+dkp+9xhrt1se2G7=CS83iA@mail.gmail.com>
Subject: Re: Ethtool : PRBS feature
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Trager <lee@trager.us>, "Das, Shubham" <shubham.das@intel.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz" <mkubecek@suse.cz>, 
	"D H, Siddaraju" <siddaraju.dh@intel.com>, 
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>, 
	"Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>, 
	"niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 7:30=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> >     To avoid race conditions, maybe some of these commands need combini=
ng.
> >     ethtool --phy-test eth1 tx-prbs prbs7 rx-prbs prbs7 bert start
> >
> >     The configuration is then atomic, with respect to the uAPI, so we
> >     don't get two users configuring it at the same time, ending up with=
 a
> >     messed up configuration.
> >
> > Testing consumes the link so you really don't want anything done to the=
 netdev
> > while testing is running. fbnic does the following.
> >
> > 1. Testing cannot start when the link is up
>
> That is not going to work in the generic case. Many MAC drivers don't
> bind to there PCS or PHY until open() is called. So there is no way to
> pass the uAPI calls onto the PCS or PHY if the interface is
> down. There are also some MACs which connect to multiple PCSs, and
> there can be multiple PHYs. So you need to somehow indicate which
> PCS/PHY should perform the PRBS. There was a discussion about loopback
> recently, which has the same issue, you can perform loopback testing
> in multiple places. So i expect the same concept will be used for
> this.

I would think something like this would still be usable. You would
just need to specify the phy address and possibly device address in
the case that you support doing such testing at multiple layers.
Basically it would be up to the driver to provide a way to connect the
request with the desired interface. I would imagine something similar
is the case for the loopback handling since there are so many layers
where you can hairpin things back to the port it came in on.

> > 2. Once testing starts the driver removes the netdev to prevent use. Th=
e netdev
> > is only added back when testing stops. The upstream solution will need
> > something that can keep the netdev but lock everything down while testi=
ng is
> > running.
>
> Probably IF_OPER_TESTING would be part of this. If the interface is in
> this state, you want many other things blocked. However, probably
> ksettings get/set need to work, so you can force the link into a
> specific mode.

I would imagine it depends on if you want to enforce ordering on this
or not. I would say the set would probably need to be blocked as you
wouldn't normally want to be changing the setting in the middle of a
test as it would cause the error stats to climb quickly.

> > 3. Once testing starts you cannot change the test, even on an individua=
l lane
> > basis. You must stop testing first.
> >
> >
> >     Traditionally, Unix does not offer a way to clear statistic counter=
s
> >     back to zero. So i'm not sure about clear-stats. We also need to th=
ink
> >     about hardware which does not support that. And there is locking
> >     issues, can the stats be cleared while a test is active?
> >
> > fbnic actually has separate registers for PRBS test results. Results do=
 need to
> > be clean between runs but I never created an explicit clear interface. =
Firmware
> > automatically reset the registers when a new test was started. This als=
o allows
> > results to be viewed after testing has stopped.
>
> We should really take 802.3 as the model, but i've not had time yet to
> read what it says about the statistics.

I think most of this is all called out in the IEEE 802.3-2022 spec
under section 45.2.1.169 - 45.2.1.174. Basically the ability and
controls live in the 1500 range, Tx error statistics in the 1600, and
Rx statistics in the 1700 range.

> > Reading results was a little tricky due to roll over between two 32bit
> > registers.
>
> 802.3 is make this even more interesting, since those registers are 16
> bits.

Yeah, normally to deal with something like that we would likely be
looking at having to maintain a fairly high read frequency. Although
in theory the error counts shouldn't be climbing that fast anyway. The
spec calls out that the registers are clear on read and held at ~0 in
the event of overflow which would be a failing case for any reasonable
test anyway.

> > When I spoke to hardware engineers at Meta they did not want a timeout.=
 Testing
> > often occurred over days, so they wanted to be able to start it and exp=
licitly
> > stop it. I'm not against a time out but I do think it should be optiona=
l.
> >
> > Since PRBS testing is handled by firmware one safety measure I added is=
 if
> > firmware lost contact with the host testing was automatically stopped a=
nd TX
> > FIR values were reset to factory. This ensured that the NIC won't get s=
tuck in
> > testing and on initialization the driver doesn't have to worry about te=
sting
> > state.
>
> That will work for firmware, but not when Linux is driving the
> hardware. I don't know if netlink will allow it, or if RTNL will get
> in the way etc, but it could be we actually don't want a start and
> stop commands at all, it is a blocking netlink call, and the test runs
> until the user space process closes the socket?

What we would probably need to do is look at testing as a state rather
than an operation. Basically the NIC would be put into the testing
state and as a result it would just be sitting there emitting whatever
test pattern it is supposed to emit, and validating it is receiving
the pattern it expects to receive.

The statistics could probably just be a subset of the PHY statistics
that could be collected separately. Actually now that I think about it
I wonder if we couldn't look at putting together the interface similar
to how we currently handle FEC where you have the --set-fec interface
to configure things and the --show-fec interface with the -I option to
show the current state and also dump the statistics.
