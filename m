Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7491241A922
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528384; cv=pass; b=iTnB3/owCQWtHQZb2Up+z+FhkWRwSt8RpQGM0wGINkltXdKGC8l3mFSyvSha0yHIMv2e3hZ3RJ5gb4RTVrcmAcFzyI6/5tSULH1yVrM+NIxdW/hzrqZkiV+7p/t86+RaVvvwUNX8/8tGwCpDduVSCBLbyPFIenVWGSh+X/2812I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528384; c=relaxed/simple;
	bh=GviiAXQCeKyVlLjv4Qvp0vGh9kOh+vs0j3supeWSa4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=deonBQNZ6ahUIUpR6HBZWxCxCLcreWd/GnYJCk3QdIuLm7qAh36duFHyM6/QbTzlEUZcOpyUL2HNDqL9MZQoOIl3pOs1RQAidleFRob8UVRhUw3MpiFZAbL15wCCwRUIEdoEYzhvO5ZPS0aXt0aqjFw6dedkT90Gs5m2Dk+Y4R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRXx+asg; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRXx+asg"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8234e9ea616so15218497b3.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 02:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786528381; cv=none;
        d=google.com; s=arc-20260327;
        b=Ohnicrbs3ADrjSxLgbtf57RECzcC8C8G++3eVEo4oqMAqqE5tLG9UwXelY8HkrTCCU
         QxXgVfRNLjtMG9FQaS2UZIgu4PSVPNzCWQS7YO4QA2OqUUBtrBV3Q+JCrVw4B2n6wUFR
         tZfSi7GlkjFnZRTLgFNVzQD/VQqT/BIzIrP6yWCW639NfoQZ4Os97x61/deJzwG3hNEU
         P9MaWowIQN8/KZedHGFAIOpi6aI6nLaEzBDejgWKOFFHQlG/WnNMy2+Zbe9PIdoRHEYn
         Xl+ZUaA5w9uvT4o/OWsV9wjqZ7/3XAKSpD7alAtpm5wJeHCdmrGiQ2j4OM+7I91WhsJN
         oqHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hy3XuxXVi5+yvTsl+oaKWxSxrgq/fUyV8v4xP5CPFSE=;
        fh=yNA/ZmquAYauC6N7NYRV3HyT5pQdGYX2MHXLuH7+RRw=;
        b=QDwQCUHaR7bPZT7HaTSKM+iAuwQOdrYVThMeTrXublVTM3u3Mzr1JE3aBv67M2lWE6
         vVLAcbI+Xz+nw1b5svb5MnqenHooXuCyexxRkXNSYMotd7vmvK+Fy4cE+RXIUKeYkqiY
         M3CrWj90qy1oGNkpKxV3nH7EK79ybkK9NuEI9bNuZOGQpJoWuGddFsOzGFHiICYkCBus
         vWNavVh7oSZ++/K+SagH+GUmo4TFBO+TFYCOlB6kY+KNYHH+WVD0u8F4iq1iD53mv+zS
         ZyUEz91p7UFDByCYsgRLaMPyoA+XZklJqucAO6NRUoH+JhZ0njLP4cYSiXpDxEepp9OK
         0G3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786528381; x=1787133181; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hy3XuxXVi5+yvTsl+oaKWxSxrgq/fUyV8v4xP5CPFSE=;
        b=ZRXx+asgMdHD6A626DIBODyvCyddgg9D/z2h8QZIPPwMkjFLZGdwf0tPc3Nb452LcC
         lu3yryQLj7CJpAFZn064iQk5ZFcYsfrh+uwzxR6cbi05bHvTDqPigd6Yw4bqSVmUusdJ
         yfRf0XQpdby6rYjaIQ16nas2DlKVrPsZVp8ObrkL/bvUFrBtnvDxb4hcF8mQBBE2LYyU
         Ik6l/EBpnixyrqXimTIro58UQHnd5dENStcQoFh5qyHbKyo0cESMjQARrjps7cpF59gt
         JotaB8Cy2yzvRAqwOkIjbUTnx1PMsOrquKFVOhtyjDicWtt+WPklnViad9f4mG1wy53W
         O9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786528381; x=1787133181;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hy3XuxXVi5+yvTsl+oaKWxSxrgq/fUyV8v4xP5CPFSE=;
        b=AZin56SFggX3JDHKcgNHZJdg7Tk+zZnUiF/29jzApHjX+VUG1To0ydWOZTMlSLgRNY
         7ZMGgjFEfDjZP+IxQROJzQKtw6L0NF3HV/8c/S9nI5JFNXyyd14cV5X3M1xpbbGLbpzh
         6Imu41VABNAlUCm7Ef4eotOhpkG+SPtJYAd6Kwj1D93diPI1tXeQbwiUA01Q9LqBlohI
         i4CW1AisHozklRGpa4kM+1BS8AmMgSY7/59fjsBmbSSwN/I81vfUGaGOD9Quo/udViC7
         Bazi1FfQTMWeaw8rRqDZbMzik4nLhYXa5IBfbjrODP/sd9F+8cz7q+KumoPU2VaKQyMF
         HNbg==
X-Forwarded-Encrypted: i=1; AHgh+Rrje/BzA1nmBqfMWn2WmU5pxQlphYOXkO1rVsVzkA6TONDy4ivIFhPbOE7HIjvY6+OUgrkdFb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFK4h088b5ZxIVTTyvXcFr/yOP1VnKoiSqA9BmLrWb5BSrlfJb
	MvgOF1GsJklS0N2FerEYnp+WQ/h2ZKZDOZrndT5Y08TFR0UzxozFE+CIeA+HLdPYNwN6EM8uKei
	uWmH5IwjeEgNS+TaincH/69A3ZhdJuk4=
X-Gm-Gg: AR+sD106wfR2DhWz6l7qeP4ro3k0tiTYyTbrEMM+MQssCYpQor6fdC+WYXveXon2gOa
	wB0gnEPKVihJCQKVgjf7b9D2wRvzI5tXcs+okx6m18SHKupzLEige1/Z3isPTINSlc7NVOcu/AN
	bsh1VpRplVdiG85rKL5/i7/6d+7wJCf+rUGEIUxeA23zkmd63FbkV5iBD+GfmVBORlvvn1RJ9aV
	iIVffXe5k+Z44yO+kFatmq6ZctHc3yq2ceYVuG4Bt6+R/DsS+vBX1pNp6sBoK/WHA087BhznITD
	cjTX3CnNEGDobeoQ976PSBmgJKZchqHvIuor9nqEjlUjTj7PeixfCTbXGw1a+/nZyOhCqPHiEBa
	50KRvUA8MCgEM2P0zRoXbQQSZalya68LpG/LBCoYUGezOGKEm4SnOSH15mIY2l9VX4NYeKpXmSh
	Lsh4M+O/jmZ4vqsdEEgJ0=
X-Received: by 2002:a05:690c:6887:b0:80e:c332:1796 with SMTP id
 00721157ae682-83043d27ce3mr44086167b3.10.1786528381210; Wed, 12 Aug 2026
 02:53:01 -0700 (PDT)
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
 <CAOiHx=mv9Ygywqbi9pR_K4vvu6tJtxdj9zObp_QB80wwV2zmCw@mail.gmail.com> <CAAsRjRnhN67bbyUQpo3iHNMiOK-7vUQFP1CaBrEydNc3jBAtsA@mail.gmail.com>
In-Reply-To: <CAAsRjRnhN67bbyUQpo3iHNMiOK-7vUQFP1CaBrEydNc3jBAtsA@mail.gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 12 Aug 2026 11:52:49 +0200
X-Gm-Features: AUfX_my22duhYvJiDEKujukDrGzjmafFAd8FfaWKzCOYTzNn5NUlqEP3VbqYAk4
Message-ID: <CAOiHx=kDG_wDjUzcDAYB8yPF=DLMJkzh=QSseBB_p_M4pfa-wQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: dsa: let drivers offload 8021q uppers on
 standalone ports
To: Semih Baskan <strst.gs@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, florian.fainelli@broadcom.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:21=E2=80=AFAM Semih Baskan <strst.gs@gmail.com> =
wrote:
>
> Hi Jonas,
>
> On Wed, Aug 12, 2026 at 10:24 AM Jonas Gorski <jonas.gorski@gmail.com> wr=
ote:
> > > One observation for the "is there another bit" question: on my
> > > BCM53011 the running value of VLAN_CTRL5 is 0x10. That is bit 4, whic=
h
> > > the driver never writes and has no name for. I do not know what it
> > > does, and it may simply be the bootloader default, but it is a bit in
> > > exactly the register you are asking about.
> >
> > Assuming you mean VLAN_CTRL2, this bit is described for BCM5325 as
> > "When set to 1, GMRP,GVRP are checked by the
> > VLAN's forward map" with a default of 0.
>
> I did mean VLAN_CTRL5; both registers happen to read 0x10 here.
> Broadcom's published MDK definitions for BCM53010 [1] name both bits:
>
> VLAN_CTRL5 bit 4 is EGRESS_DIR_FRM_BYPASS_TRUNK_EN, a bypass for
> trunking redirection of egress directed frames, unrelated to the miss
> path. The same file gives DROP_VTABLE_MISS the exact text you quoted
> for the newer chips (drop when set, forward to IMP when clear), and no
> other option.
>
> For VLAN_CTRL2, bit 4 is documented as reserved on this chip; the
> GMRP/GVRP forward map check you quote from BCM5325 moved to bit 5
> (EN_GMRP_GVRP_V_FWDMAP), which reads 0 here. So the set bit is a
> reserved default, not the retained BCM5325 function. The remaining
> VLAN_CTRL2 fields are GMRP/GVRP untag handling and a v_fwdmap bypass
> for the management port, so nothing in it changes ingress
> classification.

I copied the wrong line, bit 4 on BCM5325 is en_GMRP_GVRP_v_tagging /
"When set to 1, GMRP,GVRP frames are tagged
according to VLAN rule". Bit 5 is also the fwd map (I guess somewhere
I did a 0-index / 1-index swap in my head), so no changes there.

> The same file also names what b53 calls VC0_VID_CHK_EN and
> VC0_VID_HASH_VID: one two bit field, VLAN_LEARN_MODE (00 SVL, 11 IVL,
> 01 and 10 illegal settings). It selects how the ARL is hashed, not
> how ingress frames are classified, which explains why clearing those
> bits changed nothing in my measurement. (My intermediate test state
> cleared only bit 6, which per this description is an illegal encoding;
> the legal all clear SVL state behaved identically, so the conclusion
> stands.) And the VID to PVID rewrite bits in VLAN_CTRL0 are documented
> to act only on frames with VID 0, so on this chip they cannot reclassify
> real tagged traffic; that rules out the last candidate for a tag-blind
> mode here.

I think the register description might be wrong here, because changing
the VID to PVID for untagged packets is the default / expected
behavior.

The datasheet for switches I do have say it replaces it if the VID is not 0=
:

"1=3D
=E2=80=A2 For a single-tag frame with VID not =3D 0, change
the VID to PVID.
=E2=80=A2 For a double-tag frame with outer VID not =3D 0,
change outer VID to PVID.
0 =3D No change for 1Q/ISP tag if VID is not 0."


> > One thing you could try is to mark all ports as WAN ports. The
> > WAN_PORT_SEL register (page 0, offset 0x26, 16 bit) has a bitmask for
> > wan ports.
>
> I tried it today, and first read the register as is: WAN_PORT_SEL
> reads 0x0000 on my BCM53011, three consistent reads. The kernel
> driver never writes it on this generation (it uses offset 0x26 only
> on BCM5325, as the protected port register there), so it has been
> 0x0000 through every measurement I have reported in this thread.
>
> My earlier statement that BPDUs ingressing switch port 0 reach the CPU
> was a counter attribution error. That probe read a +7 delta on the wan
> netdev counter with no capture running (that image had no tcpdump),
> while the BPDU source was a live bridge port on another router, a device
> that also chatters IPv6 multicast. Today, with captures bracketing every
> counter, BPDU class frames are delivered on none of the ports I probed:
> crafted ones on lan2, on lan3 bridged and standalone, and on port 0,
> plus real kernel STP hellos on port 0 itself, all zero, while the same
> frames with a benign multicast destination deliver 10 of 10 to the CPU
> on every port tried. So there is no WAN/LAN asymmetry and no special
> port 0: with WAN_SELECT empty, everything trap classed aims at IMP0
> exactly as the GMNGCFG text says, and IMP0 is down. Your description of
> the port-5-only breakage was right, and it is worse than I previously
> reported: STP delivery is dead on the WAN port too, not just the LAN
> ports.
>
> Then the experiment you suggested, on the live system, volatile write
> with a timed revert armed: WAN_PORT_SEL set to 0x000c, marking the
> two ports that had my test endpoints (lan2/port 2, lan3/port 3),
> leaving the management port alone.
>
> - No trap rescue appears: BPDUs into a WAN-marked port still deliver
>   nothing, so the marking does not retarget the trap path at IMP1 on
>   this topology.
> - Isolation is exactly as the description implies: unicast between
>   the two WAN-marked ports through the same vlan-unaware bridge went
>   from 7/7 to 0/7, and even plain multicast to CPU delivery on the
>   marked ports went from 10/10 to zero, consistent with "forwarded to
>   the CPU port only" resolving to the dead IMP0 here.
> - My management connection through a port I had not marked also
>   dropped, and came back only when the timed revert fired. The
>   effect is broader than the marked ports.
>
> > So it may also isolate them from each other. Also out of curiosity,
> > can you wan port talk with non-wan talks in a bridge? Because the
> > description implies it should not.
>
> The pair I could measure says no: the two WAN-marked ports in the same
> bridge stopped talking to each other entirely, and on this port 5
> topology they stopped talking to the CPU too. The BCM53010 text also
> says port 5 can be selected as a WAN port only when IMP1 is disabled, so
> the CPU port itself cannot be WAN marked on a topology like mine.

The description of GLOBAL_CONFIG / GC_FRM_MGMT_PORT_M says that
"11=3DEnable Dual-IMP ports(both IMP0 and IMP1)   All traffic to CPU
from LAN ports will be forwarded to IMP0; and All traffic from WAN
ports will be forwarded to IMP1."

so I had the faint hope that making all ports WAN ports makes it trap
to IMP1/5 instead of IMP0/8.

But if it doesn't, and additionally isolates them, then this obviously
won't work, and enabling port 8 as CPU port really is the only option.

Thank you for the quick confirmation.

Best regards,
Jonas
