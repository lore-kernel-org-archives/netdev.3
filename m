Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB70547064
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 00:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790467559; cv=none; b=FqMY3fgB7VVrB63+KOd6hVdh6IbC/meeA9FcDW+t/Nk1DvGOBn4OZz7yf2oHYiGVsm33rIJ2xR8JGlP6n0N2L3PHaG1BKAm2GSPlE4HsOl6/PR29jvJack5rP2bBsYoUl3+rXLG6ieVo0pE9+2PJ7ZNf7v0zxwr4H4uP3RpFP0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790467559; c=relaxed/simple;
	bh=HY826dZvlDafSAmJnu8Emmcu0uaPOPCZiR/8k0qM/AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/9o8cevlo1gVu70v7ZXVVJFxy5nH4IRlqRkpjxaKyTomdvrp6j+yuIhSG8zPztqyt8wNMMrBh2IYqTboGcyfGkBvrImOsHNIo8Wb5ZacrVKIt1KyD5JMM6bSAO8bYzN6I5xnba5BuHT5IcyonGxk/iD0UuJUyN4WYbBaob/0cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/l3IGgi; arc=none smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/l3IGgi"
Received: by mail-vs2-f38.google.com with SMTP id 71dfb90a1353d-5cddebe9b2cso760426e0c.1
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 17:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790467557; x=1791072357; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qkRCXQhv0Hnw4Etkjk3usHzodyvWdz99tiVp5tvgSSY=;
        b=l/l3IGgipmseb+ZoMh2tfsYk3JN8vlPYQa5VOAHUOjoUca2LxjoTVX0SRLqYVJV4Am
         9kZBCoicWDYezNdy68yTQw5oEB2zyDe87Bg/b/ki2/WYorUNRxZeRpvxc9J/pmeEaq1j
         Us+h9X51D+pWZwD5k1Gh7V3SoOo49HTuSJ7fcqzIJ2QRXPha7e3JUFGoXi2aFKczcfxK
         4PuEVe3zqJ8En5PavMBMDZqK81jUYEbmCJoP8lPlJcbK+rJZIEDJslPEA4PZAbcJORlp
         bKStVPeRDcI101mvLWpMsj+IfX1GgcZVrSjGUYcaqDYGpl3x3cf6z2GpJMuDzaEYjYTO
         FnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790467557; x=1791072357;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qkRCXQhv0Hnw4Etkjk3usHzodyvWdz99tiVp5tvgSSY=;
        b=u3z9mBzDROk+3qFob9xVJA1kzFlljYr+7IUE7HkvE8tf3DnyGU6CRaBahvpBA2kNt0
         3f+pJPsNS8fz/yekavq8Zaq9gY0TCGr4h/8fR82ZK3YwNNjGz96CuebwzBNGQD3HkLwb
         TA5oITVsixBZGlZwYA6moN7IukO2SKHIMF1FHKQsDHtdGnCMa/Nx5jH6fMIL3p7ySyfn
         61oSNv0ofhKL4tkiDleoH5BPvigRE6tVtShwpa+pqPy7U6nHQ0i49op70WSpsHan3XuR
         XylWdIqchX9VoxUJKLJgANkVDWLp5KQa9X5z037ajej/2/dOyceo9Um/W/QMu/NJ/wW0
         0yPQ==
X-Gm-Message-State: AFq9FYJnGtkpaH/MxsfHBFERp+HMFyhjCW96wqm35p/UgImqaP4qqhd/
	mY+s+qrAuKU7FmprfTu4R0NXhE37WjOfRXmpW9ZhrA2i6ZFufulfOIs=
X-Gm-Gg: AYBFou1NWfFYd2KUWP8PP/21EXvp6Ir/o15F/Y7cmN2QYHG+yRbEHiqrFQ+8p4veJPW
	82GADPtQ/o+AN2QeFHn/wKFQK4pftN6MIcsBiaorIHY1U9c0YU138qYYe80gZEFsKiC65kfZR81
	C6Y5J4KCAg3I5zwELKOioeot2oRQ3q65cMmpFJa+0chxYhx069FV0ccu8KgU2iKE3QKKMsid2ZK
	67SbVMDUA0livTIoYfclwqC9SGvNodxphL8MLP6DlLHH+svaBEpsM89boyOk6VZ4hhGjmW5mIfE
	5O7zTDJydIagkXeTScVMxYZlQ/yCIEU8s1ZHPfL9/KcQ33uDhduDKS/6jTgDOz/Iar5sdLpzyhv
	tzDW3k8yxKnPwreb6/8rwMnirHlm2RjIXBWAhqweu7oYAj8IKFMgvEbW5Q+nSCZcl1RYlBhKA0S
	PO2NnpmGPayNlMwhScIZ+QM3J1glkIsxKzsDiT85+AID9API85p9529LQT8tCjZwQ5PflZMz4uy
	/gJlfBKmUlN+O8EUv4KuxI5RYjKGX7TBdQ8D7Bjfd0IRWE=
X-Received: by 2002:a05:6122:4f9f:b0:5cf:13b4:913f with SMTP id 71dfb90a1353d-5cf13b4942dmr333780e0c.1.1790467556602;
        Sat, 26 Sep 2026 17:05:56 -0700 (PDT)
Received: from matheus-note.localnet ([2804:7f0:84b3:2201:fb27:8354:17d:2bcc])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cde5a70282sm3475657e0c.10.2026.09.26.17.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 17:05:56 -0700 (PDT)
From: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
To: Gaoyang Wei <yhyxwgy@gmail.com>
Cc: netdev@vger.kernel.org, pbs05 <xuziyougm@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC] net: towards a generic PON framework
Date: Sat, 26 Sep 2026 21:05:52 -0300
Message-ID: <tyVeMFhOR4aOm-Y3BnbglQ@gmail.com>
In-Reply-To: <8675d110-2681-4065-96ee-e088696f59fb@gmail.com>
References:
 <20260926174601.1675-1-yhyxwgy@gmail.com>
 <CADGChbMgws9wFCVzRPwMdYQ=E64_kAWtikK4v+1ca3hTeyrZUw@mail.gmail.com>
 <8675d110-2681-4065-96ee-e088696f59fb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

>  > with tests on en7523 and en751221 with some users, I saw them
>  > attaching the OMCI network interface within a bridge, and in order
>  > not to expose this interface again to a user, I implemented my OMCI
>  > within the kernel
> 
> Was that OMCI interface exposed as ARPHRD_ETHER?
> 
> I ask because I do not think a packet-oriented OMCI net_device would
> need Ethernet semantics at all.
> 
> For example, it could use ARPHRD_NONE, have no synthetic L2 header,
> and use IFF_NOARP / IFF_POINTOPOINT.  In that case it should not be a
> valid device to enslave to an Ethernet bridge in the first place.
> 
> net_device itself is not synonymous with Ethernet.  CAN is another
> example of a packet-oriented protocol exposed through net_device with
> different link-layer semantics.
> 
> If the previous OMCI interface used ARPHRD_ETHER, then I wonder whether
> the ability to bridge it was a property of that implementation rather
> than a fundamental problem with representing OMCI as a net_device.
> 
> This would still leave the separate question of whether the G.988
> agent itself belongs in kernel or userspace.

I exposed it by poling in ioctl in the dirtiest way possible, by generic netlink and for sysfs. In all cases, there was an unnecessary overload on the CPU, making it very slow for other tasks
 
>  > with this I also had less overhead in the ethernet system, and faster
>  > responses to OLT due to the new implementation.
> 
> This is also interesting.
> 
> Do you have any measurements for the CPU overhead and OMCI response
> latency before and after moving the agent into the kernel?
> 
> It would help distinguish costs inherent to a userspace OMCI design
> from costs specific to the previous implementation.
> 
> I still think it may be useful to treat OMCC transport and OMCI agent
> placement as two separate design questions.
> 
> For example, a generic xPON layer might provide OMCC transport and
> GEM/T-CONT operations while allowing either:
> 
>    1. an in-kernel OMCI implementation, or
>    2. a userspace OMCI implementation through a packet interface.
> 
> That would avoid requiring every driver to make the same choice before
> we know whether that choice is actually hardware-independent.

with a similar port of the Airoha SDK I had CPU usage of around 2~15% depending on the number of MIB objects in memory, in addition to memory usage of around 122~353Mb in userspace
With OMCI in the kernel, the CPU overhead dropped to around 0.8~2.0% from what I was able to measure, and around 68~258Mb of memory usage with the same MIBs as the userspace

userspace depends on packages arriving at fe+qdma and then userspace, the omci in kernel arrives at fe+qdma and goes directly to omci without going through any other subsystem. with userspace we have responses in around 0.8~1ms, in kernel space we have responses in around 0.5~0.8ms, this for MIB queries already in memory.

for hardware queries we had responses of 1~4ms in userspace and 1ms in kernel space.

on the GEM/T-CONT after the packets are synchronized between the OLT and ONU comes the configuration of the datapath itself, on the Airoha x(gs)PON the pse/fe takes care of the GEM and T-CONT parts, what I do now is decode these values and inform the origin for the xPON subsystem, otherwise it is taken care of by hardware, besides that in the userspace I had to expose several things that are not good are exposed in userspace and much of the work ends up being in kernel space, so That's why I combined the entire system in kernel space.

>  > I am also aware of some Realtek SoCs having slightly different OMCI in
>  > which my subsystems need to be adjusted to see this data, something
>  > that fails in my current implementation
> 
> I think this is particularly useful evidence for keeping the generic
> boundary small.
> 
> If Realtek requires different OMCI handling, that seems to strengthen
> the case for separating common OMCC transport and PON hardware
> operations from the policy of where the G.988 implementation lives.

Much of what was written works with the Realtek SoC, it has the same data as the OMCI export, but instead of passing it as a skbuff package it is treated in a separate way from their systems, but contains the same data as the OMCI package.
When I said that my implementation needs to be an adapter, I'm talking about the issue of the origin of the data and the processing of the data and the delivery of the data to the hardware.
Today, a large part of the system still originates from Airoha SDK, but a lot of things don't match what was done in their SDK.

>  > The optical subsystem in which I implemented it already uses several
>  > subsystems already present in Linux, so temperatures, bias and optical
>  > power are already used within hwmon, for calibration I already use
>  > nvmem to obtain the data and start LDDLA.
> 
> This is very close to what I had in mind.
> 
> Using hwmon for telemetry and NVMEM for calibration seems much cleaner
> than exposing those through a PON-specific userspace ABI.
> 
> The remaining part I would like to understand better is the generic API
> between the PON MAC and the fixed optical frontend, especially for:
> 
>    - LOS;
>    - TX enable;
>    - burst enable / rearm;
>    - protocol and rate selection;
>    - wavelength selection where applicable.
> 
> I think this is also where Benjamin's earlier BOSA/SFP discussion is
> directly relevant, and I would like to hear what the PHY/phylink/SFP
> maintainers think before suggesting a concrete API.

Benjamin idea was to expose the LDDLA subsystem within what we currently have in "sff,sfp"/"sff,sff", but to do so we have to adapt and expose several functions and emulated data for subsystems already present. but the problem that fell was Semtech's LDDLA, since it works for several vendors,
So I implemented a more generic subsystem where it exposes several functions that the LDDLA supports, so it can provide data to the MAC xPON systems such as frequency/type that the LDDLA supports (GPON, EPON, XSPON, XEPON, etc.), BOSA status, hwmon, tx enable, rearm.

From what I've seen in LDDLA Semtech and Airoha, what controls the frequency selector is the PHY and the loaded calibration, and it's not something that the optical subsystem should deal with for now in my view, this should only happen when the PHY doesn't control this part, something that I find difficult for any vendor to implement.

>  > a good part of the subsystem depends on values coming from the
>  > userspace, that's why we wrote a generic netlink and sysfs for
>  > userspace communication
> 
> That also makes sense.
> 
> For ONU identity in particular, I still think it is worth separating
> hardware description from provisioning policy.
> 
> Some values may come from NVMEM, some may be derived from other device
> identity, and some may be supplied by userspace.  I am therefore not
> sure that values such as an OMCI vendor ID should become part of the DT
> ABI unless they really describe immutable hardware properties.
> 
> I will spend some time reading through the implementation you posted.
> 
> At this point I think we have two useful implementation models:
> 
>    - kernel PON MAC + userspace G.988;
>    - kernel PON MAC + in-kernel G.988.
> 
> That is a good basis for identifying which parts are genuinely generic
> and which parts should remain implementation choices.

values can be exchanged by the userspace controller for user-supplied values, SN, MIBs, etc...

Normally these are values predefined by each device vendor, in this example of dts it was from a TP-Link device, where all or most of them use the initials "TPLG" plus part of the device's mac address for the GPON SN, there is little data that must be fixed, the rest must come from userspace.

Then comes the issue of "profiles" where each OLT has its behavior slightly different from the ITU standard, something that could be a matter of some MIB data or even the status of the response, which is why I have some "profiles" ready in the OMCI implementation and a "Fake" status option


