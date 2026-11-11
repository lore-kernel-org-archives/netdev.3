Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794423738;
	b=JvDL37iGj2H7NvLkU/DfFzRy5Trl8rLuQaDQkKsMG3KU0GGjLQteuTXP1PqK4n4fSTJ6
	 sECaASHVyz9fhBV5Cd+Sesllu0xolQHcrnoDpKJXmblcCw1CB5NDDsFnHzyg4lIIwMNAl
	 TP17poNUl2r+rlS9r7BBSm9q+Qtid95Dqg9fXt35AhcxBHPAiCcRyfWz/3t9+dxtphuJC
	 tPLrIzGqU1CBDPXCFoF75HLKx/9fXG/n+nLPuMB2BzhrjiP7w7ZLjARmxjlbOBrkSij7n
	 JyZkbbUFr+oUvcDqBlkX1TEq6EF+kPSUEfl16PHZWIElll+wdk+6jTJyvSzGcfMDhdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=f8ILvoh/vi1rbgZZAsfd9aGfdfYOK1aDvQwo2LOCRgs=;
	b=gCodu7ski5rW3rujZPY0THz8SBI4T8BPfJsxxfBTA8Bea+Jw7xSJ31lKYoAzuUhGy7yg
	 mMn4jTsFrrOuoCRktgs2/W2rMUzbnYdlmuqCgNC+As54Cx8ST4htproaMfRZwU3QQlUfU
	 +FLYh5n5kWq3voCrgjg0CUMKzd3T7pM2ZjNSB3ZJ36G4xkrT8w/TCbbRGm2LiMUAOsTWs
	 MG7TIsnmrZ6G1hdtLSIAzUZoIiK9yputLNkXy/sgtttMLaM/PcKZ6gi88qHF+ir3CGpmX
	 pWCszEbsoyaO6fIXqM2atKpw+JrNP/bTHg5EYhwby7sf4FCG2kT9E+m8ChY6xPzXm+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zcOK6Y3b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE2260A260B
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 19:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAE2260A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zcOK6Y3b
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6798af41644so2945859d50.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:02:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794423737; cv=none;
        d=google.com; s=arc-20260327;
        b=AigsR928A72IGTsG4816wZ3FY8A/bUYB9Rtbi4AwZFjPzOyL9DnH1BBIP7C/WStKkm
         OBIfGnLL2gRLibLmt2uF8aPJio4jDOGbBz219zHgUaWxZCsCfh2s90osilKz/B4EMe2n
         qsW9j4TDU0nk4rHUsvpuJOITmwfDZOOB6T/I+I0ej8cZYB5K5sODaiD6s+XBWouVE3yn
         K9FtwPGJQM/4aDgsHVmM1mGFw5LzLL9ZKxcaJqKPODOEEG7t7Iww8hK6EsSDPxt3JJ7B
         Uc9Wc6P9dg4VuSrGnS7ABKhRgAB6m/1tBRy2BdUxiq9KAx9GP+XOmi/jAjNDP6FTEXdY
         6vHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f8ILvoh/vi1rbgZZAsfd9aGfdfYOK1aDvQwo2LOCRgs=;
        fh=7STGLeZ94DbYNkuW7JceI+GIwy+9MPVIdAscecdWs3U=;
        b=gEmABHkLtB/xGKUIlTk4j4PzDTaZjMa4504/0PjbvkxM4LOZceI/GMiZHxVDJANWIt
         hzeyp2gixTyniTkjxh7PuDZIsDs4E2Q2i34155ZrDWHtfGMr6dP9tUgNn2uqMS7VuOhL
         T/MMbipLBKJxn5OAJwjZjCHVBu0lf4fx/wzG4SHRXIFErDkBsCtYh+FaKQJn6e97E3rn
         wpEhdk8gHB1gIDgBJCbpyVwmIabeUlMeazv7uTV6bXP+xb1ZZ0aDzMCh2lr7ut+Vd2lf
         G4B5PC6tlxoIwpom2xhJDtSEKLpXss3YcCI7eumIgiIGWsA2BfJ5keM2Ekkchl0VGx3o
         Fj6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794423737; x=1795028537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f8ILvoh/vi1rbgZZAsfd9aGfdfYOK1aDvQwo2LOCRgs=;
        b=zcOK6Y3b9syADQIM0Sqg9Eq3EmlE/T0d7QK3T7p7GsfxvZ5FEDkiDmEDVuzNMmgNE4
         UsQizn3jDLPiUjXFlbBcF+ONsk1i6RIUs47IeRL0wBRMJEenDu02D5U8hujsAiMmH5gu
         JBfds7Iw8T+5C2yrnokQsPouCEqIpbytzVCqbMM+i+PWKbYJ8c6m8/0tswkXo59G9g6Z
         hI6XvLGdR9oaVsFiGju2l5dmXiTKwdNLmAxPSaHnea56UlZuW0QR/hCkldXQLGxYC5C9
         NHoMVzQ/1q87PZfklFhLguDN+Xg2bOzCuVWgjdwZm2HOimbIJsZ7wdVE85MErVuzlxgV
         7LxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794423737; x=1795028537;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f8ILvoh/vi1rbgZZAsfd9aGfdfYOK1aDvQwo2LOCRgs=;
        b=K88lCdlXGUossmZHQPfhZdTgTpa0gukkSeiRy8s3wdAjP59auSYhfGyHcyg/0yO3Ct
         X8W0hNR+UY+PLFi4AU9BpDyQnNVKXqjmk0sUrlfoeCcUV2TJ4K9jkSy5yPwDDfHWAhVw
         oCe4GM4Hialb7WsHRxsnK2xqsfzoiYXSi09rqquR1xC+Ne4HgAfNt1f28dOztLaXO9cc
         Kb4XrlGMYyTGcyP8ckikSnomRTFBwoIf5up8TaU3wJFMLeVJCeltehHm6d/nVnoRVwbn
         QXZHIL0ERkz2tFzaOUnaqCVtVsPp5+c8V4WByvdz5NUJqRlPfu7tCfVnv6cBshHMt/GR
         ORJQ==
X-Forwarded-Encrypted: i=1; AL+hErG1UdtykWp0ghZRSTBgDvFcxAoJ1tAmM00WXb+QEre5Fxft+Yp+hOz6IAwl4Ns+xFiflZOQJhg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9v2kQsafUJunsDlR3e7AWGAwtoCEZ6r8qG6+746BGqw/0KdJXm
	F8kTeAr4ci+SR2Mb7hOhCHrK2NqWpIbqsgE5v7rbqkEleU6dbYeS4WWm0ULd+3saw/nfBXlP0C+
	bLcEE2eBX+PIxtumzf54Nl9YfeNCyb5o=
X-Gm-Gg: AYBFou2kNvWHDWJqU4W6lYBbAPPgmJorDAfMGQCyUk6Wyi4eCVsCr6iRO2+t0B+Z2f7
	SzX12AceJMiz/S7x5Z4rqa4oZ952+bVT8PSrV+JHmAK0/WA6m/gZUZSfn7VYS9XV63iGuMdNVHQ
	ulRlybh9P4jx7Y5ZaMvcFMOFnRA7j8+OlTTmpO/bFtNBUCR5n4HHSK2sZTaedlMDx4JmRbT9tPz
	JnZt+A/oFnZuZdWdyPwaungDQ6N9lsbDUyj7tLaJIwZpSUBelCmcfMzYJmdNBr+d1NXrrZf/7Fr
	OcdMW4qqEeMqtO0akZ0XNkXYBK/BlwuQmwZ3qNhukWc+6GAqRG7g8ghcjgpYq0Qy4v19JiYtTc8
	2uwVpqQeup4XfMmkLbnXJLAfnBAif1qpKpJ1ZfdPZC+QDBDdPd9eyRn+XzC6Nj4/adZ65pXjWMu
	dowIj7JWf/C7rPuIoQVQb8+5XoN4LgQfau9I1BCiZEYFy19V0EISd5QMRvLN85HIijADDAmPN8I
	sjT0XZmi1hMO8usL+bydEDRElngESeNImAqlmzB
X-Received: by 2002:a05:690e:144b:b0:67c:6e1b:84cd with SMTP id
 956f58d0204a3-67c6e1c0b42mr1329959d50.74.1794423736621; Wed, 11 Nov 2026
 11:02:16 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-b53-bpdu-mirror-v1-1-f9f32e9d25db@telaak.dev>
 <CAOiHx=kTUBtFVgFhNqGhP135CdUmK8imCE_+pdk7qsdZKMqByQ@mail.gmail.com> <52c38c53-7806-48c7-a0a4-9e1aa40cc55e@broadcom.com>
In-Reply-To: <52c38c53-7806-48c7-a0a4-9e1aa40cc55e@broadcom.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 11 Nov 2026 20:02:05 +0100
X-Gm-Features: AclHuK-aiQpJhTmoeaJ2yOCbm38LSRZiZYmsE5_eZRJ5b-IE4UzI5KOzWB-Qxl4
Message-ID: <CAOiHx==VFEgLf5Zs+VGYdhdsznSwTz-8Hp_aAF6UuGnKT-4=fA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: b53: mirror BPDUs to CPU port 5 when
 port 8 is not a CPU port
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Joseph Telaak <joseph@telaak.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 6:22=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 11/11/26 02:11, Jonas Gorski wrote:
> > Hi,
> >
> > On Wed, Nov 11, 2026 at 7:31=E2=80=AFAM Joseph Telaak <joseph@telaak.de=
v> wrote:
> >>
> >> A BCM531x5 can be connected to the host through its IMP port (8) or
> >> through port 5. With port 5 as the CPU port, b53_brcm_hdr_setup() puts
> >> the switch in dual-IMP mode, in which frames trapped for the CPU, BPDU=
s
> >> among them, go to port 8 when they come from a LAN port. b53 sets up n=
o
> >> WAN ports, so that is every user port. On boards that use only port 5
> >> and leave port 8 unconnected, BPDUs are lost: STP never sees its peers=
,
> >> and a loop between two user ports takes the host off the network.
> >>
> >> Mirror frames sent to the bridge group address from the user ports to
> >> port 5 instead. The multiport address registers cannot do this, since
> >> the RoboSwitch data sheets resolve reserved multicast before them, and
> >> marking the user ports as WAN ports stopped forwarding between them
> >> when tried. Other frames trapped for the CPU still go to port 8, as th=
e
> >> mirror matches a single destination address. The switch has one mirror=
,
> >> so tc mirroring is refused on these boards.
> >>
> >> This was observed on a BCM53125 board in real use, when both user port=
s
> >> were cabled into the same LAN. Tested on that board with a host sendin=
g
> >> BPDUs into a user port: before, none reached the CPU and the bridge
> >> stayed its own root; after, all of them did, the bridge took the sende=
r
> >> as root, and forwarding between the user ports kept working. No
> >> selftests were run.
> >
> > So on your board only port 5 is wired up, and port 8 is unpopulated
> > and no way to make it work?
> >
> > Be aware that more than BPDUs are broken by this, as anything trapped
> > to CPU is not working. This also affects traffic on ports outside of
> > the bridge, other trapped packets in the 01:80:c2:00:00:0* range, or
> > IGMP/MLD snooped packets (or any other L2 protocol snooping).
> >
> >>
> >> Signed-off-by: Joseph Telaak <joseph@telaak.dev>
> >> ---
> >> Sent to net-next rather than net because it takes the mirror away from
> >> tc on these boards. I can resend to net with Fixes: 8fab459e69ab ("net=
:
> >> dsa: b53: Enable Broadcom tags for 531x5/539x families") if you prefer=
.
> >>
> >> Only checked on a BCM53125. BCM5301x boards with port 5 as the only CP=
U
> >> port may have the same problem, but I could not confirm it.
> >
> > They do, though there it's "easy" to fix by switching to port 8 in the
> > device tree, since all three ports are AFAIK always hardwired in the
> > SoC.
>
> Yes, I have a series of patches doing that, because using port 5 is just
> not working for everything.
>
> >
> >> ---
> >>   drivers/net/dsa/b53/b53_common.c | 24 ++++++++++++++++++++++++
> >>   drivers/net/dsa/b53/b53_priv.h   |  1 +
> >>   2 files changed, 25 insertions(+)
> >>
> >> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b5=
3_common.c
> >> index a2a5754c413c..6b33775c7598 100644
> >> --- a/drivers/net/dsa/b53/b53_common.c
> >> +++ b/drivers/net/dsa/b53/b53_common.c
> >> @@ -797,6 +797,24 @@ void b53_brcm_hdr_setup(struct dsa_switch *ds, in=
t port)
> >>                  hdr_ctl |=3D GC_FRM_MGMT_PORT_M;
> >>          b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, hdr_ctl);
> >>
> >> +       /* With port 5 as the CPU port, a BCM531x5 runs in dual-IMP mo=
de and
> >> +        * traps BPDUs from LAN ports to port 8. When port 8 is not a =
CPU
> >> +        * port, mirror them to port 5 instead. This takes the switch'=
s only
> >> +        * mirror, so tc mirroring is refused.
> >> +        */
> >> +       if (tag_en && port =3D=3D 5 && is531x5(dev) &&
> >> +           !dsa_is_cpu_port(ds, B53_CPU_PORT)) {
> >
> > So this should be extended to all dual IMP capable chips, because they
> > are all equally affected.
> >
> >> +               b53_write48(dev, B53_MGMT_PAGE, B53_IG_MIR_MAC,
> >> +                           ether_addr_to_u64(eth_stp_addr));
> >> +               b53_write16(dev, B53_MGMT_PAGE, B53_IG_MIR_CTL,
> >> +                           (MIRROR_DA << MIRROR_FILTER_SHIFT) |
> >> +                           (dsa_user_ports(ds) & MIRROR_MASK));
> >> +               b53_write16(dev, B53_MGMT_PAGE, B53_EG_MIR_CTL, 0);
> >> +               b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL,
> >> +                           MIRROR_EN | port);
> >
> > Have you tried a catch-all port 8 egress to port 5 mirror? If that
> > happens to work, it should catch any trapped traffic. May not work
> > while the port is disabled in software though.
>
> We could also try to use the CFP to perform a full redirection to port 8.

CFP isn't supported in all bcm531x5 chip variants. E.g BCM53115M and
BCM53125 do, wile BCM53115S and BCM53125S don't. And likely the
presumably lower cost S variants will be found most (at least the
board I use for testing has one).

So we could at most use it as an alternative path where supported to
free up mirroring. Checking if we have CFP can be done via the Bonding
Pad Status Register.

Best regards,
Jonas
