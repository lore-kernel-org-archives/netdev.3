Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5025D1AF4E9
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790529762; cv=none; b=iJ4h+L4Hh9jtL3D2kxiK7JJ0p+a4hWKL0mN8M/pmXf8vYhMidQ2TX8b5MZblhc8PGMmf3aGZHOo8jpJVUquvp+RAStkS/oC2PQxJXlIhpFB2+SZMkKsrXqgRbiZoYyrVzglwpwZodBhpSxwDUkNrZrFSPzgujL9dKkw1NQYIvzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790529762; c=relaxed/simple;
	bh=+nZgInulGvSld16Isnb5omWJGNLmp3Y6y1xxRXp1cuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AITYrCr1UuWdiIwtLoWW1DiBBZIhEWQMCrMBNd/TZnk+Ns2Pqc15v5b0VqKZZyDeqq3KeGH7NpkehH5FVcT5zPTvIJjWbfAocxm9AQ8H+9u7IFlVtqZ4hq50GEWK6+SWtNCVO4X0DdxxhjMfqiuTsTB4+j/sQJskNKyhE2uphsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPf94iJL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPf94iJL"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so10526055ad.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 10:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790529760; x=1791134560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SwURCWPGV3uuYhcDQ7nn/bnypMHZAnWQESUJF6EbNVw=;
        b=ZPf94iJLX+397we3ZzDI/Pt4heDKvczGjuJxJXupz8xVSoVA1/tqEtXFooV1ZgWCgq
         k5WNMKhsM+uuWj1WXKBE7hUWwqiG1rmMThA1waXJ8NWZFrYmCPtuHAwWzY8mQNRulMDv
         6QXxrkeovwb7PQJDYUO9fmBGYbzDNblsXzrg84dq/7dsft+Y+o6weOrP1pEkDIKdi1Ep
         izDHd+hYlhZX+ZC4AcUuf+bX7IPP79G/tUyu6DYPvu/RicQNb98bOmVFT0IMXiStJ4Da
         et+lYduhWu7S+XB6BvUChbiJ2chYr9i2lluuXkqMVbp7xMMUi7PtAIn1CyZlxAR0rCTt
         i3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790529760; x=1791134560;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SwURCWPGV3uuYhcDQ7nn/bnypMHZAnWQESUJF6EbNVw=;
        b=zxosIUVVcR6t1+tJlIf5Dp8iszcCCDxT4faHoEzOVnrfKCFUqgWVM18u6D0QxBKBvR
         y1Fzu2s3O1dMuUEOWEC7GtzzNgFV3aa/Rdq1Oh/HyaQXbInc4Rz/R1eTIq8zqgUxgNOW
         2LaDaT+SNreVHWvwZ1DDRiR5wa3hCwDkvNbtLGcPQHvSZ5yFZhxP+Gp975B6oV5u+5fn
         umgCTED7kjak2pktHu7fvJ88kMbyfloINoR/kff/EqFvdC+A9T+742Se4cixYNwnFZSN
         k7psempyPEb6p0O8RKUCcM2kdWPWMnnOjicvWAQ4u8GQpeivITjSSD3QfruSIwqKBkHB
         fu6w==
X-Gm-Message-State: AFq9FYJgEVDbU7ycWt1n9kFp1V+4IF9LPdQvEL0t7t99uKUVwEe/3wDM
	jFZzD0Er74e82EUy87O+96+8ligNltMThvN5a9+ZwFtqTPCyJiKraJIj
X-Gm-Gg: AYBFou0N1/2MmuK8Oil01O7ozAU73a28wACcAtTuUX52wFiMa5glP50Wh5RkwwnHKjQ
	wLwzW/+xLnwEUoeXtqvFdpwMRGsYscqY2+5PIYtteDdhvYI7O5tMVfR2ngXsFcVlezCOeyzGaOc
	jZ2+bh4QhnJqDrslPxfi48qDAJiCoADc5dc1tRg6vlmLY6oUB2am68wtFKi9XQuK16zSFMquSSU
	QFLo/oGlVytQFHYOitlY017ewDlu9qu37AOQp2dDthplDzt0Ay5t2dYPhF+NFQ299+YBNIrkvbN
	Un442Ld5sxsTcZuJupiCxcDz+mOnELG85abTZ5neRbxLeUs9wrt+0GNOIb5fWIR8I11S5cmLbrQ
	jmBHe4unCMkpM5w4jYxgveLqjpHsLaHtNpZu3V4Qv6Cr08xfJT6x1hvkZo8sSOW23FtQOLtlS3e
	aWqa9OyLXPJwciW4QFIwrwojtiZY9vw2cObD/h66I+HOzGofXFTOxjnvJ42fC/nWpJ+PA2onW8H
	dAhD8CZCtjHV/XiNRAQCtLP20Aewiix0+PfgTUz5lvGc8PQVM8unQx5T7SzmcYWwGWd3q1WmpHU
	x5izI43MeAe6raOdl2ByKszwas5OvumF4eKphHSiqTk=
X-Received: by 2002:a17:903:26cb:b0:2df:34c0:7302 with SMTP id d9443c01a7336-2df7e3a01c3mr56804635ad.39.1790529760390;
        Sun, 27 Sep 2026 10:22:40 -0700 (PDT)
Received: from ?IPV6:fd11:4514:2:0:b85f:853e:2051:3f90? ([2001:da8:100f:116::667])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dfa60bfb1csm16863045ad.48.2026.09.27.10.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 10:22:39 -0700 (PDT)
Message-ID: <92d9c8a9-ef43-45ce-a599-2c00d0a2fa61@gmail.com>
Date: Mon, 28 Sep 2026 01:22:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: towards a generic PON framework
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, pbs05 <xuziyougm@gmail.com>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <linux@armlinux.org.uk>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
 <b0d1908c-a6f6-4c28-bb4f-b00644acacfc@lunn.ch>
From: Gaoyang Wei <yhyxwgy@gmail.com>
In-Reply-To: <b0d1908c-a6f6-4c28-bb4f-b00644acacfc@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

Thanks, the hostapd/wpa_supplicant analogy is useful.

 > But having a dedicated net_device seems wrong to me. However what
 > you mentioned made me think of hostapd and wpa_supplicant. Can that
 > sort of model be used? It does not require an additional interface
 > by the side of the wifi interface.

Yes, I think that is worth considering.

One reason I initially found a packet net_device attractive was that
OMCI itself is a packet-oriented protocol, and an ARPHRD_NONE device
would give userspace a natural AF_PACKET interface without pretending
that OMCI is Ethernet.

But I agree that this does not necessarily mean it has to be modeled
as a separate network interface.

A model closer to nl80211 could instead keep the Ethernet service
datapath as the normal net_device and expose OMCI transport through
the xPON control interface, for example using Generic Netlink messages
associated with a PON device:

         userspace OMCI daemon
                  |
           Generic Netlink
                  |
              net/xpon
                  |
               PON MAC

with no separate omci0 device.

There is one property of the packet-interface model which I think is
important to preserve somehow, though: observability.

With a packet interface, raw OMCI traffic has a natural capture point.
It can be captured with the normal packet tooling and inspected with
Wireshark.  There are already OMCI dissectors available, for example:

   https://github.com/0liv1er/omci-wireshark-dissector

This is particularly useful for PON interoperability work.

Although G.988 defines the standard OMCI model, deployed PON networks
are not as uniform at the management-model level as the 802.11 analogy
might suggest.  Operators and vendors commonly add private MEs,
profiles, or behavioral quirks.

One concrete example is China Telecom's GPON profile.  It defines a
private "LOID authentication" ME, class 65530 (0xfffa), carrying the
operator ID, LOID, password, and authentication status.  Its behavior
also differs from an ordinary MIB object; for example it is excluded
from MIB Upload.

Cases like this make packet-level inspection very useful when an ONU
works with one OLT but fails with another.  Being able to capture the
actual OMCI exchange and feed it directly into protocol-analysis tools
can make the difference between finding an interoperability problem
quickly and debugging it indirectly through daemon logs.

So I think this also reinforces the distinction between two separate
questions:

   1. whether the G.988 agent should live in kernel or userspace;
   2. how raw OMCI PDUs should cross the kernel/userspace boundary.

Generic Netlink may well be the cleaner control abstraction, but I
would like to understand what the Linux-native equivalent of that
packet observation/debugging point should be if we do not use a
management net_device.

Do you have a particular part of the hostapd/nl80211 model in mind
for the management PDU transport itself, for example something
analogous to management frame registration/TX/RX?

And if Generic Netlink is the preferred transport, is there an
existing mechanism you would recommend for exposing the raw management
PDU stream to packet-capture/debugging tools without creating a
separate net_device?

Thanks,
Gaoyang
