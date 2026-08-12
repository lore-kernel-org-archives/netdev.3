Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DB030FF30
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518888; cv=pass; b=QSFeiZfspiTze+YebWRmV2GBmdDtPrYMVQ6KjSlpbbROBmQ3ObEGif13s3jhQ303YgzvqQvgOjYtlptGTeQsUGOasSlyidvC4j0N+xLjgE7PZNkv5aMI0j9P5XOWhbJg9TZCrTOQtwnKV/aSp1oEDqOKxSg6Wm5roBNetvFRmf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518888; c=relaxed/simple;
	bh=8yIj+fU7+ebkWnB6DCGIy4Z4tYQnuuHz5Pa/zndnl7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKliTqrTceBV2u5q99NOcfSIXGn2/KJn+q558dbDU5FTuNsy6ekobkFtJQ4OvLUif28ks7O3JiRrAAbuLdMT56M9hEKmrKSQkmt7ASnZpBFhC4R6VPSrUItoFKp2rEpH7oZuaBivHnjogLKzi+1jx2KejSY+U2hFcPrSeOIkysc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZqPG8E7; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZqPG8E7"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-821106b5b64so13437257b3.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 00:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786518886; cv=none;
        d=google.com; s=arc-20260327;
        b=Zb76OXbZHhBuJCQ51yXYMvHl9luJxpdQRSlHNUVOXmindvpaPovtrLv4HGvfEcDsVI
         H+ozIPQXHrV7xyXCN9QxCIDIFKiO0wmZ829cW5adCLyuZIxIh5Jk0kWWVJV4I2EJtXnp
         wfwhow7nSaBAVP+seS0qRSZcSJMdBS6jHOCbMsAqLXwzcqq9cc/7aAL7yXex36DwEG4t
         oL32tgWcUoR5iX/I6xzcoV7NYxQMEY+eGyDSXLGxYTMPaETYOWBGaove7ubz2XeEh5C5
         W/Ci1DHE/j8vd8edAhmWXBfWWfwcSz0up1SeLvye1dswAVpZyinrOyKkr32pZQcWbcTP
         n3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0oS2Anx9qjnNSCRt8nxzAUNRaQN4Cbf1YalJsErNRHE=;
        fh=zW2i5opk8fNTcL4SRRXM+x4ukbh9kJCkrY/uXhJb4R0=;
        b=faDJxXM+P/6D6O1h5TNChd5p9FORYu9gdUHdJPtPu9eSt1sf6P2X2h6XnBA2ifWN1N
         mmJSSMMB1kO7Tvz+DXfEL7R7JWICirEYW/9ai9j6KB9ZeH2U/Nr6lfb4rZBIZEv3GNnA
         VOpS3Z981rSH37ORpvige3CXnivfUKYLHGJfX5ETN4SWKD8KJkyv5f6Mj58Y+N2cEQbn
         0eKFmd7+rXQiAt8gG6akqKR1ZVlBvU5+T8qX3VvUonQLe93gTXC/Pnk4IV/M90S70CFw
         q0zDY323rjMQO6MdAcejEuc7ElOk7KWVkip5FMDvN/a74KF6FneKPjS/at3ob2IHZY4H
         4isw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786518886; x=1787123686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0oS2Anx9qjnNSCRt8nxzAUNRaQN4Cbf1YalJsErNRHE=;
        b=fZqPG8E7jHPOgqkFXYKClEOHoxoLOTv68HXKEr7y6uY8VngWSf5Nl0Fn0m1y6Iif68
         3yuPKIQQwUWfq9/d5rok4ZhhnFTknk1aiIYE3z5bOCiLnF7Msrs7ewITfJhf3/FWydBn
         LmUWVLvddiDaFpKcJ9wTPVSIUNj80/0QAx/AtiW+kr34Co7sw0pT2qHbwXtzzDEYYGgs
         nazIhDxaM8QpT6c7mD9GW+9xMI+T4iryphbSrJiz3yA2lum2SVfpeU5Uruh3AWf9Ikbk
         jG+25ToN0k5qbL2fi7SAQ8zUkf4wFYyrUiPrDre15hsfX5B+fMFAT3x/iWAGs6/J+2CH
         SdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786518886; x=1787123686;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0oS2Anx9qjnNSCRt8nxzAUNRaQN4Cbf1YalJsErNRHE=;
        b=SoqBX2T3qKxVab/5m7wPM0Gkt+yfIyF3SGLyO+WsGL0YGi4+O8XWkGT7qGiEE5liCV
         lPVR40DvJhXrQI+OXaUKdk7/7gGs/NHO38vo75VubghTIKvmrWy4crWUGIqIdMtM1jqI
         Roy+XCkfCQn7P5jIsOxFtgDeZPrA4wlZT1P+lW+s71WrjDkwls9l1WQfnNrBq6uFlbiY
         uPv1X7+y/99m8rSAt6VOb1uA61pNG793bWpwDokg8UyZKnyXo0OOjtaBA4B0i0zZ2nFg
         bQNEnqh+Xw6KrZhJ4rgIMf19PSTNBy3qedQ/4XnAu27Y2EAlxlD4kmbePi+BGTxZRZNb
         yqUA==
X-Forwarded-Encrypted: i=1; AHgh+RrHajmQvyknfxDxfPAJwAC4XfL/RD8wRC/pJVplnSzc1EMSCkI7k4jsSXyKSGbfhyy2pgNrFIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHDumuyooQMmnyE5BSQbV+t7mHZ6atEFkMua7xKZ9dZRA2RDE5
	Hb1GJolc+auMYYoxfAW4iUSHkDtbZJ04TE/nfdSeBu7zXTMJAZLiHbulBPOvR0X2x5rgcUI0el2
	T7OVgYDQ6TC6ZojGrjq0fIk2ZbeM5cP4=
X-Gm-Gg: AR+sD113LS1kysBXgmSB9z6D/LTvw+ZTj+SaaU2RbarKDp7ZRChpNJ7uB8nFk6heTxN
	11fMngPD9EKtkVboV/DKAcAab3I9OPpXuDiNRkXd6/PQKGuIQUZssysu249mIR4Nbt+g+myIg/G
	BaEhbBmRq9ruEQXMfjNhQZpEOYYHjsQD3snP0kHz18T3uVirOVu/Gif9INq3vXVaVywLxIK08z0
	7X4nwcr8TYtPJ1rf05cn/F5W2MN/DhsrMCPmCe7/+rqEidWA/vwE+MaOmC9Ix8H4RpSQb/Bl0cG
	SBoHmJrb6D7gk1Ac7cx8WCZSwOmb6InTlRSk4r1OHBJyIcn/62klUsKRfJNK8JpIFNE4agqmmYG
	hAHNjAM562P/EHPyy6fvCHJFTnJtetm2WDvrsDbrjce3L0KCsgF/7nldNHwO9QsL1OW+fvC+8MX
	zgoRStIzQa
X-Received: by 2002:a05:690c:12:b0:826:dc54:403 with SMTP id
 00721157ae682-8313f3b07eamr11594657b3.3.1786518886380; Wed, 12 Aug 2026
 00:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806073119.387-1-strst.gs@gmail.com> <20260806073119.387-2-strst.gs@gmail.com>
 <20260806111523.gjlhjfmb526f2y4g@skbuf> <CAAsRjRnhdPJOCE5BwU7zUTJ0mtSYCOA3xLcF5ejZQT8OFjYiYQ@mail.gmail.com>
 <20260806124313.see74vgu4dlqqse7@skbuf> <CAAsRjR=RyiraYdLkOcHEagGKXK5+4zwQbT-Zq-1DwVkPiKUNpg@mail.gmail.com>
 <20260810120821.lykofvogbrn2y2ps@skbuf> <CAAsRjRn7qFWy4UBL8tWGQ9pBo5q3du4e=tU9gSKkSSd7K3RaDA@mail.gmail.com>
 <CAOiHx=n43MPXKxA7oxBjGh15pa4Uh5etxkPdrV+0GxACEnrRJA@mail.gmail.com> <20260811095828.xwb4nsmx74wtzjei@skbuf>
In-Reply-To: <20260811095828.xwb4nsmx74wtzjei@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 12 Aug 2026 09:14:35 +0200
X-Gm-Features: AUfX_mzkfvOyuiOuclLCeZGZtgA04JfyKl1YYwamAXb2JdJLoC205bVdq3bmDHo
Message-ID: <CAOiHx==tV_3qJppUJWoFtj6CNzUt=S4kAmGt_SsarsRruOEw7Q@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: dsa: let drivers offload 8021q uppers on
 standalone ports
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Semih Baskan <strst.gs@gmail.com>, florian.fainelli@broadcom.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 11:58=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com=
> wrote:
>
> On Tue, Aug 11, 2026 at 09:44:37AM +0200, Jonas Gorski wrote:
> > VLAN-unaware bridging does work on BCM5325 and BCM5365. The driver was
> > originally written for this family (before upstream submission).
> >
> > There is a register bit that controls what happens when a VLAN-tagged
> > frame is received for which no (valid) VLAN table entry exists.
> > Default is drop.
> >
> > On BCM5325/5365, setting this bit makes the switch *forward* the frame
> > regardless. This is why it works on those switches even with
> > VLAN-aware mode enabled in hardware.
> >
> > On later generations, the bit's function changed to "redirect to CPU".
> > Stand-alone ports still work there, but VLAN-unaware bridging does
> > not. Everything goes to CPU, and the tag driver marks it erroneously
> > as offloaded.
>
> You need to be more specific, because I don't have a good grasp of the
> various vc0/vc1/vc4/vc5 bits and specifically how they interact.

I don't know that in detail either, and have to find some of this out
by experimenting.

>
> I *think* you are talking about bit VC5_DROP_VTABLE_MISS having
> different behaviours when clear, because that's the only reasonable
> interpretation of the code consistent with your explanation. Are we sure
> there is no other bit which influences "if we don't drop VTABLE misses,
> then what?"?

If there is, I haven't found it. The register description sounds like
there isn't:

On BCM5325/65, this bit is described as

"This bit applies to ingress frames tagged with a VID not
found in the VLAN table. If the DA is not found in the ARL
table, this bit controls the what happens to the frame.
0 =3D Ingress frame with VLAN table miss is flooded to all
ports.
1 =3D Ingress frame with VLAN table miss is dropped."

On newer chips, this bit is described as

"Frames with an invalid VID do not have a
corresponding entry in the VLAN table.
1 =3D Ingress frames with invalid VID are dropped.
0 =3D Ingress frames with invalid VID are forwarded to
the IMP port."

> Then I suppose the VC4_ING_VID_CHECK_MASK affects only what happens with
> VLAN membership violations (i.e. VTABLE hit, but port not in VLAN). Thus
> it does not influence the VC5_DROP_VTABLE_MISS=3Dfalse case, correct?

Right. that's correct.

>
> If customizing/unifying the behaviour on VTABLE misses is a dead end,
> could we consider an alternative? Some switches support having the
> VTABLE enabled, but ignore the 802.1Q header from incoming packets
> (thus, all packets get classified to the port PVID). Is there any bit
> which achieves this in b53? What do VC0_VID_CHK_EN and VC0_VLAN_EN do
> exactly? Does B53_VLAN_CTRL2 maybe have some useful hidden bits?

Not to my knowledge. There is a bit to enable replacing the VID in
VLAN tagged packets with the PVID (in VLAN Control 0), but presumably
this would also rewrite the header.

>
> > But I didn't notice this until recently. Partially also because there
> > is no kernel test for VLAN tagged forwarding on a vlan-unaware bridge,
> > only for standalone ports. Everything saying OK with a vlan-unaware
> > bridge made me think everything works as expected.
>
> Good point. tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
> should definitely have a test for this condition.
>
> > > The port-to-port part has been the same on everything measured. What
> > > depends on the silicon is only whether the CPU gets a copy of the mis=
s
> > > frame. Three chips have data across these two threads:
> > >
> > >   - BCM53011 (bcm5301x, my RT-N18U): measured for the CPU direction.
> > >     Every ingress-check setting (NO_ING_VID_CHK, VIO_FWD, VIO_TO_IMP,
> > >     plus clearing the VC0 miss-drop bit) delivers 0 of 7; the frame d=
ies
> > >     at member-set resolution, not at admission. Whether a miss frame
> > >     reaches the CPU at all depends on the IMP routing from the other
> > >     subthread: with port 8 as IMP it does (indiscriminately), with th=
e
> > >     in-tree port 5 topology it never does for LAN-class ports.
> >
> > Only port 5 is an invalid configuration, so no wonder it breaks. The
> > only valid configurations are port 8 or port 8 + 5, but not port 5
> > only.
> >
> > >   - BCM63268 and BCM53115: Jonas measured exactly this case there.
> > >     Standalone RX works even on a table miss, so the CPU copy exists,
> > >     but forwarding between ports does not. That is the case you are
> > >     asking about, on two other generations of this silicon.
> >
> > Note that BCM53115 also supports a dual IMP / CPU setup, and has the
> > same limitations, so this isn't something new to BCM5301x. The only
> > difference is that on BCM5301x the switch is embedded and has ports 5
> > and 8 (and 7) hardwired to internal MACs, which led to the incorrect
> > usage of (only) port 5 as CPU.
>
> How badly broken are the configurations with only port 5 as CPU port?
> Is other management traffic like STP also not delivered correctly?

Yes. Anything that is supposed to be forwarded to IMP only is sent out
via the main IMP / port 8, and since port 8 is disabled, it is just
dropped. This presumably applies to all local multicast traffic.

Anything that is flooded is fine, since the floodmasks have port 5 set.

Best regards,
Jonas
