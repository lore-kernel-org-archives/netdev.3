Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2DD3655CE
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519512; cv=pass; b=pNNSPAMDqJq6jKiSC+iu2S4HsuhIfdwD0InPl/e3SiHUOUuJcx8EIFOJ01uGC98kDfu9RnpVkKmVErYcZqlYfl9xC0P7lLngekfV4NCvXO9HFsbZNa2g4wRXNTFIbftrfHj3Kcsy1pswYEQ1Jhipzfvevs3P+bkZkgLWgn4tEZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519512; c=relaxed/simple;
	bh=u2flEmWcQ3i7kb6+5w47OpUAJboKIFbiZuuf8yBUkAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDcCQ/sZ+4lR2u7SeEbTxbv82tTuuFgdloNq7IObA8vSFLhiJc3GfBNzpF2JpNf1Sr0zEP42tNU6pCrO2vFarbPe0g8Rlsu5ISCaJmfNYUtOZie2bTERpG2KaJmotNiw7DFiUwC26JW7k9wkIJlozUaDEBRN7wFPYH8/RagJbuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njHPyzt0; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njHPyzt0"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-80cebd41372so9168787b3.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 00:25:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786519510; cv=none;
        d=google.com; s=arc-20260327;
        b=fGQR3XfTxcrd8V0v1z7c8SWIBlbIDUO7CSGiqRy4lZgRqw/2HEyprvbmTCJgnGKE5b
         kU6YikddXw24RBpp8UkLrhXmKe83fCKmGNKaxlxyLF4U/n+VYofmj6apurAlQhCjXpYC
         CsN6gUsQpXmFby1HTaTJPrEGWH3IDEadZq3IS7faeEge2+m/SSuQUrm1Sfn4L4+jhWbD
         5Fd8VUCy+fkeZkS1uhhTwbRbOM9QaGeAR8TZdDVZM+DUkqmWUnI7RUFCQnsQtg0VBeL7
         4wlCyJzz7OFtnLxMUL7t4/+W7jMbzOA3klB5L0mHaJsPrnhK/1eADtEX3dEI04vHX8g1
         UADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u2flEmWcQ3i7kb6+5w47OpUAJboKIFbiZuuf8yBUkAs=;
        fh=VGixOhch9ZRqjqzbHEqWEdWHB8IC5bQzVotdf8PDsn0=;
        b=fiIkq/ZDeMVcGyBTt6/ehzJmorUR0Mf6nVVEnLHUX1xRhgWau9r4KV9oA25IsgKN5s
         CduKbOCCflZydfzwt582sIjlaphtBM4vuu0Iwm6hrSbq/CHP0saRkYlmm2xwhScfT6DL
         NYpw6WloQjirTIcVT4ZInYl9og41TZ4JBS86aRTnEaZHlMVu3A4I2rB4VqECZLcYfUvw
         eWzH/m12w4elWrNwmwL50RRvwPlwXJupe7fnxL0KpP8+dICYuq/WTyanMi6xRXU35o3n
         xf4UtH35jVXJ20chO5kmNsD3EK76duk/mkhtL+TNCiXhEr2S4SGSCSiLe9ijubl1W8Ll
         KOCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786519510; x=1787124310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u2flEmWcQ3i7kb6+5w47OpUAJboKIFbiZuuf8yBUkAs=;
        b=njHPyzt0feuGC6z1pGuFl8ZEdoe9PvODOuME1KDrxjPPCITbYPWtE+j0u28bl3BMEE
         Z1/iUgXnG81gEivuSY9Pyp5zKlz3XWCUfQhj1S/KFRPZDa1E2Ni9fk5Q2kr2lPXTisc6
         DNQCVDw0PmxmOiXOOEHXbZBUmyIaT5JDc9y1qbBbQBW35eCQ2AFJ97C1l3sdVwn6rZv9
         awHRPPORaF6mGFhOx/YsUHb0934CVm334WHRJf2AZZSbg5O2UnqLOeHPA2APL518UAQ0
         rv3q7q6eMNapJUfA1dNa/E91zafi7cfTVysfiX5b7vkzbwhD7Upx4E3AsXNYAG32qfUy
         VXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786519510; x=1787124310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u2flEmWcQ3i7kb6+5w47OpUAJboKIFbiZuuf8yBUkAs=;
        b=mrdrCGlLZA7L8S7/bkObPfp+1nxjoA7hJTqJ0B/6Zrufd2tA+m4aVc90y2JE5f0eSh
         S0Ic9FcC/VcDEy5nNDbwPob9LyGsdEs+IAAxxZg5AM7Yfyq8RwzEw5r9mQJaUJr959zJ
         MDgDkmsJZTfQ8lZ6Y/snhiqSPQ9ygqRSltojy5yj7LYoNqH/UXo4Kh5GX/Jx0ZOsnUrm
         b0pANjVzIpbbctGf2AUqQgbpKvDiygKoROPGjRdY2LCEHH67S1rgxGl7EaRJMyXZfXy+
         0SVMarmAbKpb5icE5vboXmlgv594XFEhulilnidA1XZUVEOS/1MPEH6yPz9lqHwiLP8C
         Gb8Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro9jDvit2EUgKHccETXAa6qFKjZSWjAT61B+n5d2hSz1q4wZnOdnVi+4Ht36JxCNld6A5Fn58g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8uTupDRh57zGNtMa8YdH3v/G+Yfsj8FUVr82AWFYyRgJH26E1
	qbomcJB/Xxnc1UUL3HDpjLZf9i6JG9zFKyUScfpIrqDoOhh33OPD/60iPIPCCsebaXHRiHhAU7z
	eYzxX+9zp31QHQJHqQGbjncKZZ5J+Q54=
X-Gm-Gg: AR+sD13/j121nCNnzOvZ6dfABjUYqk2KvB7UniThvXlq+Uu31RKT83sO9bN1bMli4xK
	O8K001g3UMcJqB466Nvvwy2f6r2fFR8XVLz3/vNcatsQhXqEsuvbLl4EqfrGxC3B+PPKu00MtZg
	MfbDOLD/C4Osyajb6Z7pTPGXDWneng+2XvPeKQsHtQP2FkmbSjPNPJ/a1hoJBaYUuT0e+tk41Jn
	DuHZRIgDYB0ujSN7CRacH0Nw4n8FvSvf90Z7H8139vu2LLVsAwN4fgyrzVLVShbHpMcj1eJp1El
	mKErAPnmPd6Af25dTM860WJC1i4fALZWfQofbSqONw3GDSY/9i1uIqcxNO9baMQZW7dxOz9ODLl
	Mo87GxO90Qmq8iaTFblWlkMD+3spSJ56l5WYBWhRLXrVD79MjlLO1GMGX+4d428mSWUnwbq7Vg3
	aUYJLxxHbO
X-Received: by 2002:a05:690c:47c6:b0:80e:1ad2:afc3 with SMTP id
 00721157ae682-83108992147mr14379377b3.15.1786519509662; Wed, 12 Aug 2026
 00:25:09 -0700 (PDT)
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
 <CAOiHx=n43MPXKxA7oxBjGh15pa4Uh5etxkPdrV+0GxACEnrRJA@mail.gmail.com>
 <20260811095828.xwb4nsmx74wtzjei@skbuf> <CAAsRjRn0LNMspFCbi_7QMQsNPBhMXeAZfcvrc40k-Y87F7jHmA@mail.gmail.com>
In-Reply-To: <CAAsRjRn0LNMspFCbi_7QMQsNPBhMXeAZfcvrc40k-Y87F7jHmA@mail.gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 12 Aug 2026 09:24:58 +0200
X-Gm-Features: AUfX_my9peAsxHMGyOnZ61_ODwyIKwAuq9Kn2lxwUSu-ZgxiZnJgrjLyQwCEaIc
Message-ID: <CAOiHx=mv9Ygywqbi9pR_K4vvu6tJtxdj9zObp_QB80wwV2zmCw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: dsa: let drivers offload 8021q uppers on
 standalone ports
To: Semih Baskan <strst.gs@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, florian.fainelli@broadcom.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 3:19=E2=80=AFPM Semih Baskan <strst.gs@gmail.com> w=
rote:
>
> Hi Vladimir,
>
> > Then I suppose the VC4_ING_VID_CHECK_MASK affects only what happens wit=
h
> > VLAN membership violations (i.e. VTABLE hit, but port not in VLAN). Thu=
s
> > it does not influence the VC5_DROP_VTABLE_MISS=3Dfalse case, correct?
>
> Correct, at least on bcm5301x, and this part is measured rather than
> read from documentation: with VC5_DROP_VTABLE_MISS clear, all three
> VC4_ING_VID_CHECK settings behave identically for a VTABLE miss (0 of
> 7 delivered in every combination, standalone RX probes from the
> measurements behind the cover letter). Whatever the check field
> controls happens independently of the miss path.
>
> One observation for the "is there another bit" question: on my
> BCM53011 the running value of VLAN_CTRL5 is 0x10. That is bit 4, which
> the driver never writes and has no name for. I do not know what it
> does, and it may simply be the bootloader default, but it is a bit in
> exactly the register you are asking about.

Assuming you mean VLAN_CTRL2, this bit is described for BCM5325 as
"When set to 1, GMRP,GVRP are checked by the
VLAN's forward map" with a default of 0.

Since other bits (sort of) match with their meanings, one could assume
it retained it, and now defaults to 1, but there is no guarantee for
that.

>
> > If customizing/unifying the behaviour on VTABLE misses is a dead end,
> > could we consider an alternative? Some switches support having the
> > VTABLE enabled, but ignore the 802.1Q header from incoming packets
> > (thus, all packets get classified to the port PVID). Is there any bit
> > which achieves this in b53? What do VC0_VID_CHK_EN and VC0_VLAN_EN do
> > exactly? Does B53_VLAN_CTRL2 maybe have some useful hidden bits?
>
> I cannot answer what the bits mean from documentation, but I can answer
> what they do on bcm5301x, measured just now with two external endpoints
> on two front ports of a vlan_filtering=3D0 bridge: neither of the two
> candidate bits gives that mode. With VC0_VID_CHK_EN cleared, and then
> with VC0_VID_HASH_VID cleared as well, tagged VID 100 frames still
> deliver 0 of 7 to the far port and 0 to the CPU, exactly as at the
> 0xe3 default, while untagged traffic keeps working in every state and
> the default restores cleanly. So on this chip the 802.1Q header keeps
> participating in classification as long as VC0_VLAN_EN is set, and
> clearing those two bits under it does not change that. Clearing
> VC0_VLAN_EN itself is
> the earlier thread: it works but costs the VID-keyed ARL. I have not
> probed VLAN_CTRL2 for undocumented bits; on my chip it reads 0x10.
>
> > How badly broken are the configurations with only port 5 as CPU port?
> > Is other management traffic like STP also not delivered correctly?
>
> It splits by the port's management class, measured on the RT-N18U
> earlier in the thread. BPDUs ingressing switch port 0 reach the CPU,
> because port 0 is WAN class and its traps go to IMP1, which is port 5.
> Management traps from the LAN class ports 1-4 go to IMP0, which is
> port 8, and are lost, because GMNGCFG has no "IMP1 only" encoding: the
> driver's OR of the field mask programs dual IMP mode and port 8 is
> down. So on the in-tree topology STP is broken on the four LAN ports
> and working on the one WAN port.

One thing you could try is to mark all ports as WAN ports. The
WAN_PORT_SEL register (page 0, offset 0x26, 16 bit) has a bitmask for
wan ports. It may allow delivery to IMP1, but the description of the
WAN port feature is also

"Select a port as a WAN port, then all that port=E2=80=99s traffic is
forwarded to the CPU port only. The non-
WAN port traffic from all other local ports does not flood to the WAN port.=
"

So it may also isolate them from each other. Also out of curiosity,
can you wan port talk with non-wan talks in a bridge? Because the
description implies it should not.

Best regards,
Jonas
