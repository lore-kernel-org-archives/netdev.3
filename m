Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D862286A4
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 22:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790460975; cv=none; b=FmIKls4Tf7lTs1hqz5R0gGNulmIuovQ3nDX+De+i+Y1yMpFo6I9oVIEkkAwr2eq910BaaKAjLnLjXAtrRsjIxWkLrQv1rKkj7elENNJpceWOf2Hp2yGIMwxEpERxivdqfBeG+9fHPkrA8sa/4sRGNHlmHWbrk6rcepyHhujxJ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790460975; c=relaxed/simple;
	bh=l4F1iCPNvpV7YWm7A05IEYTZjn6frDgqUqUuXXw7Eo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFF+m9aKuWRZAZwtjyzq0XpAYDLekxZwLsVgzggPpvdGiVDgh9HodJdie6gjdmkh/rXG8UC1JAi18dGqfT+V51OoLwxuW7QtNJZZiJswbPv3SZztSRvlTB5oXRZekbMlvEMtojC26PaxXePdcSqRMMhaAx4uAUPPgOm/9NX5jOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0GIFEoq; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0GIFEoq"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2ddaa08c890so8082025ad.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 15:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790460973; x=1791065773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yvBDzP7iH8igAWtS7cfpM5+LqaiMyhgIYKWZiTNeG5o=;
        b=o0GIFEoqzFNBLedB8tdRuYwmJdD5Kqa/7kMl78WfoCB1Yu89rRPD1ktZom7F2/qy3D
         rwAMvKkY/lVwQpG1z/xS+SGaFjMC+TOceLB8ATP0os26YT2xb/W50JY3QdFc8j54+pq1
         2jDQzdd1YKRJXAZwaMO62VHnBvtk4U6j3MqMqtrgA+y+YdipOWZA81U5w3jZalCszdzu
         zGRCkh0hGVeJP+Q/M0fdRiNM87lICa67ufzCv6s0v8R6SRYHWyFaeLWtCuOf26fCGZhd
         B0o3cIwUL/+VVWdb4Fd1vmnmbzAlOMNR8xFI0QCqchmx12y9OXEB9GgRrXgvztqtomUh
         rL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790460973; x=1791065773;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yvBDzP7iH8igAWtS7cfpM5+LqaiMyhgIYKWZiTNeG5o=;
        b=Ge/2aLY2AJ4Lz8K0cbQESTs7h//x3qCejdFYcW6U/wA050pG9C81SHHwkDi0g3MWVz
         YJKCDOdhGwv9RhO4VJeEdRwAEigyg4yhHdtX5leP/oop8WGwsPv/qhsUHJi368o5z/H+
         rkkTEDZ7cirMYGOTYwnDnsCBYAH4+uj1I8xuHLH0+hEs+H89ABAMi/buT008RN+2GOJ1
         gbT96Utr4ZxjgMBp4Xq/fqtPnuPeZs0/3WzRPyL4HOYhSY4MVFDmNrlm2YfWBnE8+c8f
         vWm8iXBnsTsriF4VzRCm5mTEd3EhULr/yMhuN8GJ3IPMT/evCWmPasb/cmvW6zRwGqsJ
         wzmQ==
X-Gm-Message-State: AFq9FYKmLW95kdzTVvW7XzHFdlNp1Pnl/mURns+JjyZB/Y0rw5fd0spY
	F/VZDyPJNMUmJbd3Tj9gXNwgSSkFIRYhntb/WYETJsjdQaAkQ7OPgADw
X-Gm-Gg: AYBFou3NI0OyYj3XOSEswVJGwSLY5rHhogHid9YoyeoQw6eDXxJZLUPlt4hey/gvPlb
	PC0XwpJ1J3Ocb8PG1WqUzQswu6T72/4L/YbTdXVW7cUuEG0OKtsrZDxNt8k6br2Onng2QezJcPP
	eC2N3wfSjepaB98TdBRMeTEgzXAc2l77NDI16vXMahnr9HRQ2p9WrB7TjG1i0C8eE/JvgAeySku
	ACg8xFKZq/lvNrDhDEv+pThxeCbzEjKRFlYTun7Qq0HZq1sqKxMA2oqUQuG8myrq3yeH1mRvmMc
	Uc4C/wQV4lkSX69sfO3fJ5Hk6xjOMccJtWNog7xTEbsAXfGPjvedjRc640Xg8/RtT2TmgvNr0i6
	wPXJXjUTDhF5kZ48cm01h4Mk2s+mrDxQHW+Xb8q6EdkXelCGWhHZ1K9qeeJlNk6e3DM6xBmCu9E
	Htr0Va1ae9Bya+YGIfkb+qD0KrZW6OG3aNd53GzOQRM7qaaFVHHeVKeZaQyOyPWgsjsHlX4CNdC
	JL9z9xZ/q36fQq7QiXqSgbesmQR8uowUsx+kZPVAcYytE/63kzWyAR4CybTpoyQ6kP4f9jp6RNe
	lRMvR+++pV3u3Arhb5igwlQ2mFRK4RQH
X-Received: by 2002:a17:90b:2ecb:b0:3a0:f036:5a13 with SMTP id 98e67ed59e1d1-3a0f0366a44mr1324253a91.30.1790460973456;
        Sat, 26 Sep 2026 15:16:13 -0700 (PDT)
Received: from ?IPV6:fd11:4514:2:0:2564:38af:d688:9415? ([2001:da8:100f:116::667])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976cacbesm17611090a91.13.2026.09.26.15.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 15:16:11 -0700 (PDT)
Message-ID: <8675d110-2681-4065-96ee-e088696f59fb@gmail.com>
Date: Sun, 27 Sep 2026 06:15:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: towards a generic PON framework
To: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: netdev@vger.kernel.org, pbs05 <xuziyougm@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <linux@armlinux.org.uk>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
 <WL64BmXtQq-YjPSMpmv81w@gmail.com>
 <b3348bd6-a248-4df5-8ee4-610cf0a33bee@gmail.com>
 <CADGChbMgws9wFCVzRPwMdYQ=E64_kAWtikK4v+1ca3hTeyrZUw@mail.gmail.com>
From: Gaoyang Wei <yhyxwgy@gmail.com>
In-Reply-To: <CADGChbMgws9wFCVzRPwMdYQ=E64_kAWtikK4v+1ca3hTeyrZUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matheus,

Thanks, this makes the reasoning much clearer.

 > with tests on en7523 and en751221 with some users, I saw them
 > attaching the OMCI network interface within a bridge, and in order
 > not to expose this interface again to a user, I implemented my OMCI
 > within the kernel

Was that OMCI interface exposed as ARPHRD_ETHER?

I ask because I do not think a packet-oriented OMCI net_device would
need Ethernet semantics at all.

For example, it could use ARPHRD_NONE, have no synthetic L2 header,
and use IFF_NOARP / IFF_POINTOPOINT.  In that case it should not be a
valid device to enslave to an Ethernet bridge in the first place.

net_device itself is not synonymous with Ethernet.  CAN is another
example of a packet-oriented protocol exposed through net_device with
different link-layer semantics.

If the previous OMCI interface used ARPHRD_ETHER, then I wonder whether
the ability to bridge it was a property of that implementation rather
than a fundamental problem with representing OMCI as a net_device.

This would still leave the separate question of whether the G.988
agent itself belongs in kernel or userspace.

 > with this I also had less overhead in the ethernet system, and faster
 > responses to OLT due to the new implementation.

This is also interesting.

Do you have any measurements for the CPU overhead and OMCI response
latency before and after moving the agent into the kernel?

It would help distinguish costs inherent to a userspace OMCI design
from costs specific to the previous implementation.

I still think it may be useful to treat OMCC transport and OMCI agent
placement as two separate design questions.

For example, a generic xPON layer might provide OMCC transport and
GEM/T-CONT operations while allowing either:

   1. an in-kernel OMCI implementation, or
   2. a userspace OMCI implementation through a packet interface.

That would avoid requiring every driver to make the same choice before
we know whether that choice is actually hardware-independent.

 > I am also aware of some Realtek SoCs having slightly different OMCI in
 > which my subsystems need to be adjusted to see this data, something
 > that fails in my current implementation

I think this is particularly useful evidence for keeping the generic
boundary small.

If Realtek requires different OMCI handling, that seems to strengthen
the case for separating common OMCC transport and PON hardware
operations from the policy of where the G.988 implementation lives.

 > The optical subsystem in which I implemented it already uses several
 > subsystems already present in Linux, so temperatures, bias and optical
 > power are already used within hwmon, for calibration I already use
 > nvmem to obtain the data and start LDDLA.

This is very close to what I had in mind.

Using hwmon for telemetry and NVMEM for calibration seems much cleaner
than exposing those through a PON-specific userspace ABI.

The remaining part I would like to understand better is the generic API
between the PON MAC and the fixed optical frontend, especially for:

   - LOS;
   - TX enable;
   - burst enable / rearm;
   - protocol and rate selection;
   - wavelength selection where applicable.

I think this is also where Benjamin's earlier BOSA/SFP discussion is
directly relevant, and I would like to hear what the PHY/phylink/SFP
maintainers think before suggesting a concrete API.

 > a good part of the subsystem depends on values coming from the
 > userspace, that's why we wrote a generic netlink and sysfs for
 > userspace communication

That also makes sense.

For ONU identity in particular, I still think it is worth separating
hardware description from provisioning policy.

Some values may come from NVMEM, some may be derived from other device
identity, and some may be supplied by userspace.  I am therefore not
sure that values such as an OMCI vendor ID should become part of the DT
ABI unless they really describe immutable hardware properties.

I will spend some time reading through the implementation you posted.

At this point I think we have two useful implementation models:

   - kernel PON MAC + userspace G.988;
   - kernel PON MAC + in-kernel G.988.

That is a good basis for identifying which parts are genuinely generic
and which parts should remain implementation choices.

Thanks,
Gaoyang
