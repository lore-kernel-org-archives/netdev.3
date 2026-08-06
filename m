Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15C44CF59
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014429; cv=pass; b=Mh8lUfwz2sWU2NQa1qEBejtgCIoLxZtidp+H1hPC8UDU4i9g6uDGUFiezgotT1coKIenDBZSNn0xgbAKcJTNeDjGe+sGEFXnA2/NpPLsSalnkNiE2/b6UgaqUUrWZQcCcUuxJquUP9u+FuE/wX53PsWShLxf7kWD0VShldVTBrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014429; c=relaxed/simple;
	bh=spFKler5Mg70jaT8SCnqTQwErXgb255I96TarqyO1+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLCgPvxQJntoBSXBzyyBflyXu0pNtKU84qvRxnKlj5GuBRFJIFgT1UajDclb20R4UZ33dzmVZbDFksyTqYgAeI0dywTqxynKu31A9/XLjtsMdHub0fgrcDSTqLCOC9+89F1ax+Mv3Zea765iCh+9EsIKQgmPP/dLaSs4WoCEXWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYKWNSfW; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYKWNSfW"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso19190595ad.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 04:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786014424; cv=none;
        d=google.com; s=arc-20260327;
        b=d5vPBa+FBpfKNmnDFRqztfM8D5Exi+6bpqwafS/lpQAIkllEhORLLeyjF+ZQiASFYQ
         LP8qAqC6npH72OYDsmQ0P2wojr3ABvlxb2B6XENwv6kyUWVxQf8z4jC8Nv/sGFzXot59
         OfpvwpC2fcsAkUpXVADs18kMQ+BTfvUKaqUim+mP0BnCG5CX/knzpZitACIFJS1febML
         6Ad4/Cu/3skZ6OvMUHyRHe+7Is2bQCQvozdmYu5gPncUA9Y7dgPOU9OPx43g0gCoqMxx
         61x3O7/8jCsKXIvuDLzL0X9vfuD67ELDmnuG2ebY5yTQ08eTgojUJe42bFp4II00sHhv
         NqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ftwu/hrYif1ENLw0rPyb8peoVOUVmkdPfLMjuajP9PA=;
        fh=xyxUaLONNEShia1TmAg4xbrupABpPAdughhPFhCfeDI=;
        b=mGe92lglEq4QBUMt8aRBSGHM+gvt2kduL9JKAefcw1l2SB/OsZyLFd3PvA0Aj3LKLQ
         P83rXxiZbbC5JONGdiubtX8AjaVxFe4L/xFFXM8OL9OXn8m+zXgaWPdJG6xu2PCxI3x2
         jtvxtUcHWNWJGKe1kjdyppA7TQnyvSv1XDtPjbHt6SHLmrp09zXKgzN1sPUkMvIx9bAc
         FFkknFdaB8CGHwaGV8JriKNTWK8wloNCe2XUd0MzCYqayhfatC1YuulrUTOeWygVXdYE
         xQL1uvHeDbfJUP1yK1v3ojQ/o94DcMDrrbE7VSXK3GCg1+m3UdjR0zUBuzMgYQC3/i4V
         ytpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786014424; x=1786619224; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftwu/hrYif1ENLw0rPyb8peoVOUVmkdPfLMjuajP9PA=;
        b=BYKWNSfWF4/uv8Gie5w0+ZJGn1h1zSugY06SFo/eoXnA7sRc0abUO5s+mfoVtUVcyg
         lRWJ9HOVvxhYzmgjmdcepixOar/FaM+g7rP6K92fBhkfmxmuHW1DUZtmFcbxOSSqFWdC
         ydc4IDjXMeTpkWyTIHCU0d7BUVc6uwkjvIJFh2jyaR7cmWYqwp/c+IkZE5YvI0GRPxZI
         40DZVGdMZfeI2gAF4GXZIcjiu53psvKLpo+bxRZNi5PBpNSMm0bR2pho+gKh4hiwxeda
         TlTvnN+TnoVgl+1lCL/dZ8c7eh0HNwy/L9mLLziL2kmOMA1he0oTQmDHw78Gx1yRcUas
         9ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786014424; x=1786619224;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ftwu/hrYif1ENLw0rPyb8peoVOUVmkdPfLMjuajP9PA=;
        b=oU8J6tYMWpd+xs9Zh1UV8cLn9NgTxLnTJX0pq/hSkjo1lHAshADI/MAYPTPxRx/h/b
         pT5tXjfNvQaZetlc253iYXHqD53kWPYgsekzicJ/oOp7rKWK6ZbazCCyPvXe4t2s4QxT
         Uj2a80dPerYQuBrYsQrAErg7bojvRoiHX2tn42Y2INrDec3mVH+MzTpqL94RDhC6zuPa
         lhVztP456Wbv+opVXsao06ZyEAU3f1GQ3Lq98GRDuQ7o9n/CiHJuuhvJ1NrihlFR9/RL
         /KNawkQ7NsRv7OUnlum7yvh+AwII20UhGfTrXYjQSK7VKUo0uhVkqmdnQPi0agBPKxYV
         6KcA==
X-Forwarded-Encrypted: i=1; AHgh+RoXVR1YZuhw3AHCsL/5hrpxmTGoc+vguAmgHstZ1wd0UYz85mtU3pt0HVjl+qdTv8laY8Uba4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGM6cTa8ySeQh4Jbf+wxp6eQCHDZnwD8GzySmB6NtjKX6zsVbY
	eUL2lpbBSl4GYuGdRtaQvDN/T1cHgnMRpze63FVPNgU5ml/+LFQjPPMLN8VXFDk0lXuYHs3i3r5
	R18JFNDL5qSGpk6EZ50ecrmngU4tRehc=
X-Gm-Gg: AR+sD11tJ3hqTIAqeU5wQIhyy9pzniE1Ty3fd02xhITdfLlGpFYKdOgUw5dr2Q937Nk
	HgkYnEKSFrNBSYSw7TxXZsIhe9+7jUEIdrwkdu1ZsCSfxgtL/TGatOoKCZvAJwMANX5aBfg0BJ/
	hYtVVGqUUHcWwcwmxJEa7Re0uHrZiAjp/X9G4a/LOZtGwMBb4zmQrxf+fmsHVHaq8Y+gDZeLWnz
	GEM5fGZ/0j3d3gd3wmsqEPHQrb8sUB3jSSpOzTjO5G1oPajk/Lr8F3JeLvI1UPK2i7aKinzKyHK
	Vg42Q5YwYM/an8+MDlWr+uIcrJnTgMtKlPzp1mX4Ar9MaQ==
X-Received: by 2002:a05:6a20:728a:b0:3c3:76a8:c0f with SMTP id
 adf61e73a8af0-3cb85ded9b5mr14911350637.4.1786014423722; Thu, 06 Aug 2026
 04:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806073119.387-1-strst.gs@gmail.com> <CAOiHx==_5toBvQgvMckNiJoJi5k+i8yMehFZNpbyt_Bm5bemsg@mail.gmail.com>
In-Reply-To: <CAOiHx==_5toBvQgvMckNiJoJi5k+i8yMehFZNpbyt_Bm5bemsg@mail.gmail.com>
From: Semih Baskan <strst.gs@gmail.com>
Date: Thu, 6 Aug 2026 14:06:52 +0300
X-Gm-Features: AUfX_mzsc6RQFfLUfoU9J3Pd7m0UvUqY2icZAXewucwG9piST7l2-YEQNUZY5tc
Message-ID: <CAAsRjRkQXWzT=EdmXfeXX_zjUssBstk5yJMzcGi9PxVLe407wQ@mail.gmail.com>
Subject: Re: [PATCH net 0/2] net: dsa: b53: fix 8021q uppers on standalone ports
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jonas,

> If you are using port 5 as CPU port, can you try switching to port 8 / gmac2?

You are right. I tested it today on the RT-N18U and switching the CPU
port to port 8 makes tagged standalone RX work on an unpatched driver,
with nothing in the VLAN table. Details below.

User ports attach to port 5 (gmac0) here, as in every bcm5301x device
tree in-tree. I enabled port@8 (gmac2) as the only CPU port in the dts,
left the driver completely stock, and rebuilt:

  - the board comes up with the whole management path over gmac2, so
    the port 8 to gmac2 path works on BCM47081,
  - the tagged probe that always failed on port 5 delivers 7 of 7
    (outbound positive control 7 of 7, delivery attributed to eth2 by
    interface counters, eth0 stayed at 0),
  - the PPPoE session from the original report establishes.

I also instrumented b53_brcm_hdr_setup() to read back GLOBAL_CONFIG,
and the register documentation in OpenMDK explains the mechanism you
suspected. GMNGCFG.FRM_MNGP on bcm53010 [1]:

  00 = no IMP port
  01 = reserved
  10 = IMP0 only: all traffic to CPU from LAN and WAN ports goes to IMP0
  11 = dual IMP: LAN-port CPU traffic goes to IMP0, WAN-port traffic to
       IMP1, and "In polar, IMP0 is Port 8 and IMP1 is Port 5."

With CPU port 5 the driver ORs GC_FRM_MGMT_PORT_M, which is the field
mask, so the register reads back 0xc2: FRM_MNGP=11, dual IMP. In that
mode the tagged frames reach the CPU on neither IMP: I also tested an
intermediate build with port@8 enabled as a second CPU port while the
user ports stayed on port 5, which is what plain bcm-ns.dtsi describes
since it does not disable port@7/8, and delivery still failed with the
gmac2 counters at zero. With port 8 as the only CPU port the driver
programs 0x82: FRM_MNGP=10, IMP0 only, and delivery works. So your
no-clear observation is correct and the value it produces is worse
than a stale leftover: the port 5 branch cannot program anything
better, because there is no "IMP1 only" encoding, and LAN-class
management traps can never arrive on port 5 on this chip.

One smaller register note: BRCM_HDR_CTRL on bcm53010 does have per-port
bits (bit0 port 8, bit1 port 5, bit2 port 7) [1], so the Broadcom header
itself is valid on port 5. That is why tagging works there at all; the
port-8-only limitation is in the IMP routing, not the header.

A data point that fits the same picture: with CPU on port 5, BPDUs sent
into switch port 0 do reach the CPU. Port 0 is WAN-class in the chip's
management routing, so its traps go to IMP1, port 5. The trap
destination depends on the port class, which is probably why this
half-works and has been so confusing historically.

> ARLTBL_IVL_SVL_SELECT is only implemented on bcm5302x / bcm58xx /
> bcm53134 (and maybe some other newer switches), so no wonder it
> doesn't do anything for you

Thanks, noted. That makes the second measurement stronger rather than
weaker: on this chip there is no knob at all that preserves VID-keyed
ARL entries with the table disabled.

One property of the port 8 setup worth knowing before anyone reads it
as the fix: delivery is indiscriminate. After deleting the 8021q upper
I still see the tagged frames of that VID on the CPU with tcpdump.
Every unknown VID from the wire reaches the CPU, always, which is the
pre-5.15 behavior with its unfiltered nature included. The series
delivers only the VIDs that uppers subscribe, and stops delivering when
they go away.

So as I see it there are two valid fixes on different timescales.
Moving bcm5301x device trees to gmac2 fixes the trap path at the root,
but it changes the conduit for every board, needs per-board validation,
and cannot go to stable. The series fixes the deployed port 5 topology
selectively and is backportable. They do not conflict; the VLAN entries
are correct and harmless under either CPU port. I am happy to help test
a device tree migration on the RT-N18U if you want to pursue that
separately.

Also for completeness: a runtime test of your suggestion via conduit
reassignment is not possible, b53 does not implement
port_change_conduit, so I tested through the device tree.

[1] https://github.com/Broadcom/OpenMDK/blob/v2.11.0/cdk/PKG/chip/bcm53010/bcm53010_a0_defs.h

Best regards,
Semih
