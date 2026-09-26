Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277FD3750CC
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444773; cv=none; b=fZyYebtgy0k4iNPQSi3S9lfn+KtkZP1SMQyRAYw9WRoKTMqCQG0OGWMky5ztyST0uMOyDXlY3wirF79lkqXiDZ+hZRBh8MaBLqtrqtw6bDaNYDnlfaSNLpWCZAk4RjIEC+MzyYlc8JHN7Oyvwqzh9Np15R/Ih9YKti5YrtMHxIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444773; c=relaxed/simple;
	bh=oO1iHcTAH7ACNmM77giltxwnfU1nsSZpxxQDiZ/ueD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WbNdAOjmOCc+/INKfgWSYcERF6AzViwQ4bI6STvmg4gYL8OYGd5OlOK/YNmhCSP5Ekx5MYUwfS0nUfxVOktMOpa6j6bbjXfQ7ih44DL2zku9xTVo2gb/KsPjEynj82E6YxB7hvbLFgMsajJPxtcIz0+XBrMxZbtVCDwNqryx0fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEYWj9+O; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEYWj9+O"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccda24afso980432a91.3
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790444770; x=1791049570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X7j/Xs0yd7MI1p56J+Mr6f7Gqbz4/prJloJrxSXAAGg=;
        b=CEYWj9+OcNYYl+9rm3WwO4XsufuiMWHqCoGqDoreyJkIFYU1TNLDVL+12cqeLsyDeh
         3yKFdmuETmP6WCJvCWQbPpnsFCVsFnWqRqpYY1YTyPZ0BP14UAbtjVXHZtmK9VE80CIA
         k0cPKBE9TELYqrIf/M5/3OZvUXCJyrNPlvibBuvvBHGPVaxrl0WLpIH2rYCScNBCth1Z
         ZdlGhH6ZOFgsNOyQiSCLsO5T0w/3Q/ufQhLXeM/JzkVEJfQ1Wk9W3O97Q3idNhHlj8eU
         XADumkYnuVfBl88AI7evexrZKCtprMz6BSSdyRRg45f6r5+H/ftgVzjX651YDzP5m/sw
         3I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790444770; x=1791049570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X7j/Xs0yd7MI1p56J+Mr6f7Gqbz4/prJloJrxSXAAGg=;
        b=ToAqVHqGHZJe6eMxGWgTZSEmdj5T7wxvbfur4VugoHP8vZ1SeDda/XxN4f6AyomZyk
         HBDRYOflLsUzbPEjvXHVx/G6KXqFx9gj/WRt+cwnWjjhJcKmLMDSjqwO9z10wQxwXRRO
         BaytAIlMjSG3sBkC77g86wUvQbV8U77kc3gsBv8sGJJxAugJBN3K68StWCeAanu3GfKW
         vjTXbpjBEScoGt6RdOkezIjDYoJP5CgU/POGaGibwkM3jmYCUxdnkosouylEr3ggv6PG
         LufgeEzNLaU/RY8PYrrCQUbB7ZbzCIRdCX3fZ87bFah2SahQpq3bFtg10Yn8wHN0o+Gb
         BD3g==
X-Gm-Message-State: AFq9FYIV7xsJENBbtfYgYvRjlAEmylaftSuSMLKbz3S1OsROcUEmTMFI
	fUCF+rjaR2BP8HVNaGm+lh11sWvCsY58ZjinjoAgSXbvSWYIR62WOKxf9pOnfwK/fKm4eA==
X-Gm-Gg: AYBFou3ev6s32jXbkgrmbcHkIPhqU+y3Bipj4FcLgqD6pgnC9fbtMm8QHxaShyNyZJT
	E902SUXm+wBVESyrevFKmw0jX3+MGGDPbCosWI7fsOVvmkT2EL3a16coWwC9ixE9vsL8bq7VRNA
	kk2xEaQlscGS+G/rnklPmTYTaInPkdUzn4kL+Enc+Ttq9ls3wfDbO3Uau5ewzwduKbKezYLubOG
	El4ZC6bJc54ho5ukdSb609P5svQa/XF2zkOuAO5nslUdAXDOsUtJ2BHEa6EWE4SxA/qOe0KyN3u
	RihZVHK3IxeSy60tEGHLmL/RGaHJs9DRuXFjY7zTNvJaXUYs1N5rBre/wW/d91nWwsg0K+unom8
	xMHGVbJYayJ5V2mM2gjTk9Tmg7r4DvvE63iNupj0q6PHlrMCOIP/RNB0cDaBW17U3wNjxbJJFj/
	NlNBMbYUhc7FtbOgkg7EVcnm9lP5MN5+7oQzdMiP7O0JgH/NPt9+TE5/lQ2RQOxpVXxUhktQoMI
	PmSK8Ds+zzSfwUqy5fDNYljYIHYQnAFi9TWrOpiCUaBqds98UGTcaeEEWE3K86E3uQ2/CWE1UDZ
	nAgyUm8Ai6A1MEOrG94VacJPuCNvojgHjFi7Mw==
X-Received: by 2002:a17:90b:390d:b0:3a0:c717:2db with SMTP id 98e67ed59e1d1-3a0c7170934mr3325060a91.27.1790444770171;
        Sat, 26 Sep 2026 10:46:10 -0700 (PDT)
Received: from DESKTOP-4R531G0 ([223.105.83.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec711sm17261233a91.6.2026.09.26.10.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:46:09 -0700 (PDT)
From: Gaoyang Wei <yhyxwgy@gmail.com>
To: netdev@vger.kernel.org
Cc: pbs05 <xuziyougm@gmail.com>,
	Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>
Subject: [RFC] net: towards a generic PON framework
Date: Sun, 27 Sep 2026 01:46:01 +0800
Message-ID: <20260926174601.1675-1-yhyxwgy@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Several efforts now support, or are working towards supporting,
Passive Optical Network (PON) hardware on Linux and OpenWrt.  I would
like to ask for feedback on where the kernel/userspace and
generic/vendor-specific boundaries should be before any implementation
hardens its own userspace API.

This RFC is about the ONU/ONT (subscriber) side only.  It is not an
attempt to design an OLT subsystem.

Background
==========

PON devices which provide Ethernet user services commonly expose an
Ethernet datapath to Linux, but the hardware below that interface has
concepts which do not map directly to ordinary Ethernet networking:

  - ONU activation and line state;
  - PLOAM or MPCP;
  - ONU-ID and Alloc-ID;
  - T-CONTs and GEM ports for ITU-T PON;
  - LLIDs for EPON;
  - encryption/key state;
  - an OMCI or OAM management channel;
  - a burst-mode optical frontend.

Vendor BSPs commonly expose these through private ioctls, private
procfs/sysfs attributes, vendor-specific libraries, and userspace
daemons.

There are now multiple open implementations or implementation efforts,
so this seems like a useful point to discuss which concepts, if any,
should become common Linux abstractions.

Current implementations and related work
========================================

One implementation currently targets Airoha AN7581/AN7583:

  https://github.com/pbs05/openwrt-pon-drivers
  https://github.com/pbs05/openwrt-pon-userspace
  https://github.com/pbs05/ponwrt

It separates the Ethernet datapath from the management plane.  The
kernel handles the PON MAC, line activation/PLOAM, hardware GEM/T-CONT
state, and the hardware datapath, while the G.988 OMCI implementation
and service provisioning are in userspace.

Raw OMCI PDUs are exposed through a dedicated net_device without a
synthetic Ethernet header and are received and transmitted by
userspace with AF_PACKET.

pbs05, the author of that implementation, has reviewed the description
of its current architecture in this RFC.

There is also ongoing EcoNet/Airoha work for older PON hardware,
including an xPON MAC/PHY implementation and OMCI work in the OpenWrt
Airoha target:

  https://github.com/openwrt/openwrt/pull/20104

Benjamin Larsson previously raised the closely related question of the
API between an xPON MAC and a fixed laser driver/BOSA or an SFP module
[1].

These efforts do not necessarily make the same architectural choices.
That is one reason I would like to discuss the common boundary before
turning any one implementation into a generic kernel API.

Goals and non-goals
===================

My current preference is for any generic PON layer to be deliberately
small and to reuse existing Linux subsystems wherever possible.

In particular, this RFC is not proposing to:

  - implement the G.988 managed-entity model in the kernel;
  - standardize timing-critical XGTC, FEC, burst timing, or DBA logic;
  - replace bridge, VLAN, TC, ethtool, hwmon, thermal, PHY, or SFP
    infrastructure with PON-specific equivalents;
  - require different PON MACs to implement activation in the same way;
  - define an OLT-side architecture.

The question is instead whether Linux needs a small common model for
PON-specific line state and bearer resources, and how that model should
interact with existing networking and optical subsystems.

Possible layering
=================

A possible split looks like this:

                         userspace

                 +----------------------+
                 | OMCI / OAM software  |
                 +----------+-----------+
                            |
                     management PDUs
                            |
  ================================================================
                            |
                          kernel
                            |
                 +----------+----------+
                 |                     |
           PON-specific            Ethernet
           control plane           datapath
                 |                     |
          vendor PON driver        net_device
                 |                     |
           MAC / PCS / PMA     bridge / VLAN / TC
                 |
          optical frontend
             /         \
           SFP       fixed BOSA/laser driver

Where the user-facing service is Ethernet, its datapath should remain
an ordinary net_device.  Linux should not need to understand XGTC
framing, burst timing, or FEC in order to forward Ethernet packets.

Hardware which implements those functions should continue to do so,
with the vendor driver programming the corresponding hardware state.

A PON-specific kernel interface, if one is needed, would then expose
only concepts which cannot reasonably be represented by an existing
Linux subsystem.

Potential generic concepts
==========================

For ITU-T PON, possible common concepts include:

  - PON protocol/mode;
  - line/activation state;
  - ONU identity;
  - Alloc-ID / T-CONT resources;
  - GEM ports;
  - management-channel association;
  - security/key-slot state where software must program the MAC.

For EPON, the equivalent model would include LLIDs and MPCP state.

I do not think all protocol state necessarily needs to become generic
kernel code.  For example, one PON MAC may require software to
participate in PLOAM processing while another may implement most of
the same state machine in hardware or firmware.

A generic layer could therefore expose common state and resources
without requiring every driver to implement activation in the same
way.

OMCI and management packet transport
====================================

For ITU-T PON, I would prefer to keep the G.988 managed-entity model,
MIB handling, and service provisioning logic in userspace.

OMCI is a packet-oriented management protocol.  The AN7581/AN7583
implementation mentioned above exposes raw OMCI PDUs through a
dedicated net_device, without an artificial Ethernet header, and uses
AF_PACKET in userspace.

This has some useful properties:

  - the kernel does not need to understand G.988 managed entities;
  - operator/vendor-specific MEs do not become part of a kernel ABI;
  - packet capture and protocol analysis are straightforward;
  - retransmission, MIB handling, and service graph resolution remain
    outside the hardware driver.

I am not claiming that a net_device is necessarily the correct
upstream ABI.  I would particularly appreciate feedback on whether a
packet-oriented network interface is appropriate, or whether another
existing interface, Generic Netlink, or a character device would be a
better fit.

EPON OAM is a different protocol and need not share OMCI semantics or
userspace code.  The question is only whether management protocols of
this kind should use a common packet-oriented transport model where
the hardware requires host processing.

Reuse of existing subsystems
============================

I would like to avoid putting functionality into a PON layer when
Linux already has an appropriate abstraction.

For example:

  Ethernet service traffic  -> net_device
  VLAN/bridging             -> bridge / 8021q
  packet classification     -> TC where possible
  Ethernet statistics       -> ethtool
  pluggable optics          -> SFP infrastructure
  fixed-front-end telemetry -> hwmon
  thermal policy            -> thermal subsystem, where applicable
  factory calibration       -> NVMEM where appropriate

In particular, temperature, supply voltage, laser bias, and RX/TX
optical power from a fixed optical frontend should not require
PON-specific ioctls merely because the sensor is part of an ONU.

A fixed BOSA/laser driver still needs a way to communicate
link-relevant events such as LOS, TX enable, and burst-enable state to
the PON MAC.  How this should interact with the existing PHY, phylink,
and SFP infrastructure is one of the questions I would like to
discuss.

Datapath provisioning
=====================

Another open question is where service classification ends and PON
bearer configuration begins.

An OMCI userspace implementation may resolve managed entities into a
service relation similar to:

        VLAN / priority
               |
               v
            GEM port
               |
               v
            T-CONT

The GEM port and T-CONT are PON-specific bearer resources, and many
implementations represent them in hardware.

The VLAN and packet classification are not PON-specific.

It therefore seems undesirable to create a new generic PON packet
classifier if TC, bridge, and VLAN offload can express that part of
the configuration.

What remains unclear is the cleanest way for an existing Linux
classification rule to select or reference a PON bearer, especially
on hardware where that mapping is offloaded into the same DMA/QDMA
engine as the Ethernet datapath.

Questions
=========

I would particularly appreciate feedback on the following points:

1. Does Linux need a struct pon_device or equivalent at all, or can
   the required concepts be represented by existing networking
   objects?

2. If there is a generic PON object model, how much should it expose?
   Are T-CONT, GEM, and LLID appropriate generic objects, or are they
   too close to individual protocols or hardware implementations?

3. Should OMCI management PDUs be represented by a packet-oriented
   interface?  If so, is a dedicated net_device appropriate?

4. Should PLOAM/MPCP activation remain driver-specific, with only
   common line state exposed by a generic layer?

5. What should the interface between a PON MAC and fixed optical
   frontends look like, and how much should be shared with SFP,
   phylink, PHY, hwmon, and thermal infrastructure?

6. How should classification into GEM/LLID bearers interact with TC
   and existing hardware-offload APIs?

7. How much should the ITU-T PON family and IEEE EPON family share in
   one object model?  It would be useful to avoid both
   protocol-specific private APIs and an abstraction so generic that
   it no longer represents the hardware usefully.

8. Which configuration belongs in a networking control API
   (rtnetlink, Generic Netlink, etc.), and which state should only be
   observable through existing kernel subsystems?

Next steps
==========

I am intentionally not proposing a UAPI or struct definitions in this
mail.

There is working code which can be used as a reference implementation,
but I would prefer to get agreement on the subsystem boundary before
turning one vendor implementation into an API which other PON drivers
would later have to follow.

If the overall direction makes sense, the next step could be a small
RFC patch series containing only the minimum generic model together
with one real hardware consumer, rather than attempting to upstream a
complete PON stack at once.

I would also be very interested in hearing from developers working on
non-Airoha PON hardware.  A second independent hardware family would
be particularly useful for determining whether any proposed
abstraction is genuinely generic rather than an Airoha interface with
generic names.

References
==========

[1] Benjamin Larsson, "[RFC] Question regarding api between xpon mac
    and laser driver/BOSA"

    https://lore.kernel.org/r/1c774b8f-3e4d-447c-9a93-be554811cbf0@genexis.eu/

Thanks,
Gaoyang Wei
