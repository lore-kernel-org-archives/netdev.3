Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE0403AF1
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526493; cv=pass; b=Hg2BJH4V/9CAC8M/+YI6GHSejUgVbh9Cmj5K60sxN5eBPfjXAsAmdo5i8jpgW1fITdyMW+49B1KpaJpfNpBTHDUVWLZy6JeCbvrX66Yd6ChDl2VivttWkcw0aSFIp7H10/WEkdTtf1lW3h//2DHec5mgx78lDVPcuCuuYV+PxZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526493; c=relaxed/simple;
	bh=2oIhm6WF8L0FuwpPhcJCHVK5WBudfKssYycxIb9YGlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIdJqEQSu/gnk/QmZPpVCr+M+B9tQBXshCYXDWPu73OqufHeyAfXV3rDfq/KAQSMriz/t2TayzeMWUWEzzezpQH+cBfDV8VKa0pYGTxwaeZ36R5h1sn/nUXPtkZ6QxEs67P19vAcnPm4WYyhWpxicbVAy9aTXz4rxI1GeFIa3Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkjzgvkU; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkjzgvkU"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caced6038eso9601695ad.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 02:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786526491; cv=none;
        d=google.com; s=arc-20260327;
        b=VUIA76zQoDCVtXf6bOgQeA9iFPh/2PhaTIlAy58mwZr7dokCLk514W8I+w5iXjXn58
         A0zu1p1EIrn6N0kjj39LwoBvZgX0jsSdU8jHZeydjswdooCpWhLuJxVkgRySZh9Lv6tL
         tbCtJ2D590qMgpVo3LweR+tSpBnEez2vwfCzBuzEeIO6g0bhiBzMAcG3bx+hgwWB4EgV
         jSeHMjiV33T6RCe2YQfSBIEBwZ87SUkevajr0JZ8ZMJmtcHYUxj5aZwuZCJ6+i1/DEkv
         EuInbod36C/eVoTNMe6wmuXbI7xZOyFrd9SP0SFGc19IMpzNFEoUoFNPjMp0herpv2yz
         O4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UDn01biNljQV/OfAD6ZOsBjPardPGrf7UIjtijtohOk=;
        fh=ok0iBQoF4P7TvRaX1L8uKVp3QGOZh4jvSIKqRJWqUxk=;
        b=KAooFSxYtf8t0uWRCfBF5pJYx9jnEZF23wgPLMOu/PntOw0W+kNBRH6KW7xhiLjgeF
         9g8A72BA62dY0NuTUFE5qViXj91Z4otsYCR2ZRBfbAP208+hMZLrIppZjQ9cSnZHvpxp
         wwDBHWWzUgGhIFOEyYXDqWEFUpr+BIIHcrms6WTb1B70rW5sTBgSbzaQu3yEGHmGHntZ
         2Glz9T8X/sAuFpaAVbW2YloEWFgimIv6wqWBgj4GyqaiFykH7d+Spg86n3qCcQLHclxc
         Twu/kkola1H/rCQo7+3fhjiF+acMdgEuAR3jmaEgBbu+tGgVgrIwTO6SIGSY6NU0rkX3
         4oIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786526491; x=1787131291; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UDn01biNljQV/OfAD6ZOsBjPardPGrf7UIjtijtohOk=;
        b=GkjzgvkUF1baY6qvdmHJWd1FykHmAEnIscEC7Y3tEwkkezKG7Ys8uSih8L03iYpacg
         5o0wws2zoAhzFhDuFD/O+hF9+qtJdnjZEzAFAR6x1OQZDuX2tFKs6DTLIDMBilXI4Zny
         U9b96qxJkyjVjsMt1kNNvY/pjkEAkjJfLtauRZdY9Zlsx0YArbjd+RShoQ4Lem9DBj01
         7irSAKiBQU3+Khu7tIrDDuRteR15ZIWWkJQAJGPfn3YQMQtxR9DemZnIKiwLxyxlWonO
         prWa6+pw6V4O7gyAj9bfNGROPpHe58xv+61t/r6iVdtcRaLnBC0CsfP/OTYE4a3XnkLf
         crZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786526491; x=1787131291;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UDn01biNljQV/OfAD6ZOsBjPardPGrf7UIjtijtohOk=;
        b=EmVbB+qq8JWEcG9R/YFNNwkb/hKSbGiOdPZrMjfOpJmSAqLzsaNWKo4QZ0wfuXiGq6
         p8KcCUBN2joUzNZqdfCBoxidyAY+ktMRcjxw/5+aOiQKCrCOemzk9NM8kjn8lHnZgSFv
         aytwqGTDhdow3ycjLgY/hURMnduVOC+JD3VkW284W8bcWahfn7dbze3iUmHhmr5w/DXe
         Tx1KHr540o2qospV6zkhA/DDxuEhqPPULbmareef3tNnKfEZbuRnBxYhRvJdiNyJNwK8
         9rNE8jnyow2CAFmOkde+nmTe8qWYHyExPJFTJTqIFpeXByEz6TIryTSiNUiHVtEeTUN1
         sLSA==
X-Forwarded-Encrypted: i=1; AHgh+Ro7aUeTCJIIfYxZA2jEIeTZqSjyIkvCWqbAyeDF6AGqX7zQV8bKAKlyyjGTA8txg3CcjmVrh5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHB/XYpY311obBZaDkVXzn4w9FXKUcLs+BmNbtD7A8ZrC0gRDG
	WlgDKgDci9yIMEC6xaOo6mYRU18Zz2uF/lF24dzwkFgM5+a/xIDzm9Keoo/9wgFiCH2KKsXMd/u
	mQd4RTIi6g4C5T6UufOHzl0vq6FLgpn4=
X-Gm-Gg: AR+sD12M20p3naYt2XFkINr0JlzBcawQpDe8NQ+BKsJFY9MqhvC4ZffWFwxvZysznfH
	vEmSPzuX/+ybkixFpADjrdBdZ5nkuARV2HQeDDGqnh205C1U2Euf236iWEWzZGmUxqo4xV6yQbV
	rlNWnFmdcCBz3OOYm9Uk3CrRWwTlEO9iUqp28U5W7QqTJPQcOs/8d/BcoW84UdoMcWU649Ca5n4
	1AmwCfZsEH8Yx05vMYPBcFVfupM7zMO97ByqxhcXqkyZlu5QNuzA4FUR4Zg/UL0tez978pFAPie
	gnn8IMzw5rHL/aMEoGbZs4JS5gb327ImtuLVQl+NH8GJ9A==
X-Received: by 2002:a17:903:2c50:b0:2cf:6e5d:23e9 with SMTP id
 d9443c01a7336-2d32daab6e2mr80351195ad.14.1786526490864; Wed, 12 Aug 2026
 02:21:30 -0700 (PDT)
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
 <CAOiHx=mv9Ygywqbi9pR_K4vvu6tJtxdj9zObp_QB80wwV2zmCw@mail.gmail.com>
In-Reply-To: <CAOiHx=mv9Ygywqbi9pR_K4vvu6tJtxdj9zObp_QB80wwV2zmCw@mail.gmail.com>
From: Semih Baskan <strst.gs@gmail.com>
Date: Wed, 12 Aug 2026 12:21:20 +0300
X-Gm-Features: AUfX_mzcxMjuOBzh9Z4mJdDRFC6XNY29NB8sc3DyaVLPvaSy8Jc84uY41KoYLzE
Message-ID: <CAAsRjRnhN67bbyUQpo3iHNMiOK-7vUQFP1CaBrEydNc3jBAtsA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: dsa: let drivers offload 8021q uppers on
 standalone ports
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, florian.fainelli@broadcom.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonas,

On Wed, Aug 12, 2026 at 10:24 AM Jonas Gorski <jonas.gorski@gmail.com> wrote:
> > One observation for the "is there another bit" question: on my
> > BCM53011 the running value of VLAN_CTRL5 is 0x10. That is bit 4, which
> > the driver never writes and has no name for. I do not know what it
> > does, and it may simply be the bootloader default, but it is a bit in
> > exactly the register you are asking about.
>
> Assuming you mean VLAN_CTRL2, this bit is described for BCM5325 as
> "When set to 1, GMRP,GVRP are checked by the
> VLAN's forward map" with a default of 0.

I did mean VLAN_CTRL5; both registers happen to read 0x10 here.
Broadcom's published MDK definitions for BCM53010 [1] name both bits:

VLAN_CTRL5 bit 4 is EGRESS_DIR_FRM_BYPASS_TRUNK_EN, a bypass for
trunking redirection of egress directed frames, unrelated to the miss
path. The same file gives DROP_VTABLE_MISS the exact text you quoted
for the newer chips (drop when set, forward to IMP when clear), and no
other option.

For VLAN_CTRL2, bit 4 is documented as reserved on this chip; the
GMRP/GVRP forward map check you quote from BCM5325 moved to bit 5
(EN_GMRP_GVRP_V_FWDMAP), which reads 0 here. So the set bit is a
reserved default, not the retained BCM5325 function. The remaining
VLAN_CTRL2 fields are GMRP/GVRP untag handling and a v_fwdmap bypass
for the management port, so nothing in it changes ingress
classification.

The same file also names what b53 calls VC0_VID_CHK_EN and
VC0_VID_HASH_VID: one two bit field, VLAN_LEARN_MODE (00 SVL, 11 IVL,
01 and 10 illegal settings). It selects how the ARL is hashed, not
how ingress frames are classified, which explains why clearing those
bits changed nothing in my measurement. (My intermediate test state
cleared only bit 6, which per this description is an illegal encoding;
the legal all clear SVL state behaved identically, so the conclusion
stands.) And the VID to PVID rewrite bits in VLAN_CTRL0 are documented
to act only on frames with VID 0, so on this chip they cannot reclassify
real tagged traffic; that rules out the last candidate for a tag-blind
mode here.

> One thing you could try is to mark all ports as WAN ports. The
> WAN_PORT_SEL register (page 0, offset 0x26, 16 bit) has a bitmask for
> wan ports.

I tried it today, and first read the register as is: WAN_PORT_SEL
reads 0x0000 on my BCM53011, three consistent reads. The kernel
driver never writes it on this generation (it uses offset 0x26 only
on BCM5325, as the protected port register there), so it has been
0x0000 through every measurement I have reported in this thread.

My earlier statement that BPDUs ingressing switch port 0 reach the CPU
was a counter attribution error. That probe read a +7 delta on the wan
netdev counter with no capture running (that image had no tcpdump),
while the BPDU source was a live bridge port on another router, a device
that also chatters IPv6 multicast. Today, with captures bracketing every
counter, BPDU class frames are delivered on none of the ports I probed:
crafted ones on lan2, on lan3 bridged and standalone, and on port 0,
plus real kernel STP hellos on port 0 itself, all zero, while the same
frames with a benign multicast destination deliver 10 of 10 to the CPU
on every port tried. So there is no WAN/LAN asymmetry and no special
port 0: with WAN_SELECT empty, everything trap classed aims at IMP0
exactly as the GMNGCFG text says, and IMP0 is down. Your description of
the port-5-only breakage was right, and it is worse than I previously
reported: STP delivery is dead on the WAN port too, not just the LAN
ports.

Then the experiment you suggested, on the live system, volatile write
with a timed revert armed: WAN_PORT_SEL set to 0x000c, marking the
two ports that had my test endpoints (lan2/port 2, lan3/port 3),
leaving the management port alone.

- No trap rescue appears: BPDUs into a WAN-marked port still deliver
  nothing, so the marking does not retarget the trap path at IMP1 on
  this topology.
- Isolation is exactly as the description implies: unicast between
  the two WAN-marked ports through the same vlan-unaware bridge went
  from 7/7 to 0/7, and even plain multicast to CPU delivery on the
  marked ports went from 10/10 to zero, consistent with "forwarded to
  the CPU port only" resolving to the dead IMP0 here.
- My management connection through a port I had not marked also
  dropped, and came back only when the timed revert fired. The
  effect is broader than the marked ports.

> So it may also isolate them from each other. Also out of curiosity,
> can you wan port talk with non-wan talks in a bridge? Because the
> description implies it should not.

The pair I could measure says no: the two WAN-marked ports in the same
bridge stopped talking to each other entirely, and on this port 5
topology they stopped talking to the CPU too. The BCM53010 text also
says port 5 can be selected as a WAN port only when IMP1 is disabled, so
the CPU port itself cannot be WAN marked on a topology like mine.

[1] https://github.com/Broadcom/OpenMDK/blob/master/cdk/PKG/chip/bcm53010/bcm53010_a0_defs.h

Best regards,
Semih
