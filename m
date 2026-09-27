Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82DC1FECCD
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 04:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790483963; cv=none; b=ZLoRp6AcQWFkHj+KmsggHpVtNC3Uhi/RkgLdGM8STEasJusuBVm3YD7qVz90U6E+ns2k45qEtxiGBTWKRl2pp3QuNYAatkCmhSOgboxwY1c6jPw2aim7a4iDSs+DQWmSMZ29Cs4lcMRfL2ssN/0DsF1w4Rcyivlc1Zy0cfqekq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790483963; c=relaxed/simple;
	bh=xlXqf9mFwau+XTipTZRs2bCnLkjGFbtLMLw2N1WOIDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7m4cK1J4TKgZZpvCPnQjgwp8VoyR4HIA9WtsRrKpY1Ft7x+KcxkccNwFcS0dwwJpsQoSebHrOG2g3XMYqJRxSihXIqCcikjo9b3tL7AMNsHpl3h6RRVzeWbo98JykbHh653Q9qy/5MZmeReQmpUVdlwimHcKWaNQxsQVG5H5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm/omoky; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm/omoky"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0bcdf41a3so975869a91.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 21:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790483962; x=1791088762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Hf0wTaBh2QEX0XfXSvE3ph//O6snTklhTATtDlCcoQ=;
        b=hm/omokyDBkAq2bTcHZI3bKbaUK3qV0pR2+slwh7Es+2cTT8NKHebjj/u8mVwx0oOI
         2VUHU24Y3L2pISc9ajSTdTBFEgsFjF4BWtXCmd4VrBA28WZL0u3TkejY2hkrOGblpNLH
         NJczxnB0P3Pmx1U4fSU6khFQ7CEm4RjHkIUpzTMDWrqU9J7Jb4ZMyKnVFkUWBFzivL3n
         jtTWGFZdpQpMySM2squDtcaw0gYKU38CxBo3+4t28pvSS/COyhoR5dh0uu/wxPT1Aptq
         NELRprtYR85/OK+ZE3HakYX+Rx/UHG9vU0KKFw/nO8QALgdvVHeAE24UEfJmdgyUiodw
         jO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790483962; x=1791088762;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Hf0wTaBh2QEX0XfXSvE3ph//O6snTklhTATtDlCcoQ=;
        b=RkyGWUUh33PeCxFt+XI0azIo2FMtpu/lM4CRLtJA/d6AixtYw+nWlcrITXFw9NvuFc
         8PY3FiuDvRfttgztBbFWJYPoEC7PUSXdbSP/UYaoOhG8SM+jA+56X93JyAUqBf6Yg5EP
         9b2k8g17VaMMHB6S7sSOoEQLbPnXKATWYW8q4/RG6n28p9gqIoxZ2InZfQ7/rpfkL6gF
         1Gasy+X6sgRrpjIftUH2Qr30kmMwjDKvSqW2bZ8GPiqWAnQ5GAgAGkUDva1PIpi3w/Tx
         45f950+3CfuQiOkTkaqpGSDtV224F8/zzYclAp+gqvBuXw1JJMYX3WVynnSgXgd0M13j
         xGYA==
X-Gm-Message-State: AFq9FYIwQnS0tQBniQbN/xyQT+f2Zc/HJoWw5un1Zk/kGd95KCidJref
	FRhq1mhI3KATcLUU0jp9e3WPdGoALHlvfBplNgjcLIzXR5qxhi43D0gl
X-Gm-Gg: AYBFou0BC7d5RDHACOtWxb9I1DY/TsNx03lDkJucLsWXbjlLRmKhdZDm3lPOr/hptU/
	SlVq48y6E3dV1CqLegG0VZD93C4mAf0jy8LbvCx9NIUriToMGeY5WsC+WFDpQtDIUSZwgk5WxLy
	hjAwciNz377M7/KB5R8yPBzJwY0pQRFN+/TPP+5/eSGZ1oWCcgRlnEmo7eOIGx5kfCLWxSdWEii
	TrgyCsthBjA6lXtCa4Tcwjtyhevk2K4QJM5E/bB+UcZGxsURbyRfW0O1UbSaKkNdYx/zntSiNdj
	H9gs9+dOCbeAuv4h6Hp1FuJQcPsD8283+wh0O7L1DXk7ysLj3kXz2OcPaow6blEoIQavZNlFiDJ
	csXyrBTV5YpmgfgRcCo5wa6EN7qrrwj4IjcjWEUK5kPC4qgkgwi5XrEOljsPMNi2CjgCCEk3l8N
	KlWQlppN9T2wPFUcI3CPaCLmfzRZPXMNeJattJNtgj0SwSHSZeEwloJGmSS5uKKRwmt8DiXjdRk
	TYkPVV0YcmhPms5fZsLmdwxaGMTKq2iBesK35RdmCeSNQ/KYjaYutBV6OEaG2nuusgttNX7NfFv
	1IMo0cmDlLgDBI5um0hO1929cxspzaoSprCgxznTmPM=
X-Received: by 2002:a17:90b:1f90:b0:39e:6c69:f47b with SMTP id 98e67ed59e1d1-3a098d4085dmr8580008a91.58.1790483961913;
        Sat, 26 Sep 2026 21:39:21 -0700 (PDT)
Received: from ?IPV6:fd11:4514:2:0:2564:38af:d688:9415? ([2001:da8:100f:116::667])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976cacbesm19092194a91.13.2026.09.26.21.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 21:39:21 -0700 (PDT)
Message-ID: <f3f5b31e-e434-452b-a77d-72ea740a5753@gmail.com>
Date: Sun, 27 Sep 2026 12:38:56 +0800
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
 <CADGChbMgws9wFCVzRPwMdYQ=E64_kAWtikK4v+1ca3hTeyrZUw@mail.gmail.com>
 <8675d110-2681-4065-96ee-e088696f59fb@gmail.com>
 <tyVeMFhOR4aOm-Y3BnbglQ@gmail.com>
From: Gaoyang Wei <yhyxwgy@gmail.com>
In-Reply-To: <tyVeMFhOR4aOm-Y3BnbglQ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matheus,

Thanks, the measurements are useful.

I think there are two details I would like to clarify before drawing
conclusions from them.

 > I exposed it by poling in ioctl in the dirtiest way possible, by
 > generic netlink and for sysfs.

This sounds different from the packet-oriented net_device design I was
asking about.

My earlier question was specifically about the OMCI interface which
users were able to attach to a bridge: was that interface registered
as ARPHRD_ETHER?

If so, I think the bridge problem is probably orthogonal to whether
OMCI is represented by a net_device.  An ARPHRD_NONE OMCI device with
no Ethernet header should not be bridgeable in the first place.

 > with a similar port of the Airoha SDK I had CPU usage of around
 > 2~15% ...
 >
 > With OMCI in the kernel, the CPU overhead dropped to around
 > 0.8~2.0% ...

Could you describe how these numbers were measured?

In particular, it would be useful to know:

   - which SoC and CPU frequency were used;
   - whether the userspace version used polling, Generic Netlink, or a
     packet socket in the measured configuration;
   - what the MIB size / message rate was;
   - whether the memory numbers are process RSS, total system memory,
     or kernel allocations;
   - whether both implementations used the same MIB representation.

I ask because a polling ioctl/sysfs implementation would have very
different overhead from an AF_PACKET-based OMCI transport, so I do not
think we can yet attribute the measured difference to the
kernel/userspace boundary itself.

The Realtek case you described is also useful.  If the OMCI payload is
the same and only the data source and hardware delivery path differ,
that sounds like a good candidate for a small transport/backend
abstraction rather than putting those vendor differences into the
generic OMCI model.

On the optical side, your explanation also helps.  Keeping telemetry
in hwmon, calibration in NVMEM, and leaving wavelength/frequency
selection to the PHY where the PHY already owns it sounds like a
reasonable boundary to me.

Thanks,
Gaoyang
