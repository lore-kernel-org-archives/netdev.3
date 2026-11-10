Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794305088;
	b=bVYDBbVIcc5RLEljfx6EQRqRnB5tm75OoyhsrCw/sFlp1OAXlY26aQlURHAHJ109zCGB
	 LOjfnebuFdWPRqAS0MN4SUcenZdykVfJpit2z6M3zvqImNKz2QVgFt0qysNROfVAR0Bmh
	 kr8cOO/YrSbSTe63t0dQbBkwWaqTyF9fH+fQ2M4bLwDZVCrFhzmieNozLEsbEMco9TDHI
	 Kpw11RIZKgWS6/HwdmUo0aq4FtwCxi/PBry6K3ScLCcd1nDGRQCji4JnrtHL+NQUOMnmC
	 o98NuC2fMTihQd3PnAxt8zvlTmRur1wfwa0wXZAAtRZjUXrmTyMO3fshUBxix8+nAFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=c8SH9EDnCkmjUHGPR0P2Z3gz/VtKXf2f2iywxNQfoIM=;
	b=Ha8lMweTnfXI5wOCdC5FUICR59wAQxAu1/pk1iHLpqQTGbMsispditrroL+uZg/eJhEo
	 6+5EIquFk+BrerfXL4t2atMfXPsAwUaqtiEwPtgA6dULSYunsrSv3nQgCeEwCyop3sFil
	 I++QwtSeNLbBWmMjS28LllymOjdMAa/7aZUyRYC45n+7Tj9Qu2RcAh/rMgzCmASBefEEv
	 Sd69W0fHdMuhSdVIBcUP8SOJFJ+d3K6y1/6Bn1aF38AECu+hq1BjkZU2l6viMtuWw/RbT
	 ncczggGogOFkVkgFpYMEeAG1KJwXGAfKzNMiKPJ64jwt5O5GpJHEVpEul968N45m/TQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OcSkI3ou;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A77606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9A77606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OcSkI3ou
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6f8a519e215so1541670eaf.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:04:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794305087; cv=none;
        d=google.com; s=arc-20260327;
        b=M9ujdK7sEWjEIzjrvpkYGDsAoSH2C7q5szSWTZ/OVxskruJ1YVfPm5/SfgrU1FAK8V
         rfLFaw8ZYkYO5t+idESWzC6zkIn5UtpMtRkbBS90r5otv1Ww09qvxhoUfzDadGKVwTKZ
         ulmk0hnmQAyvkG/Yq9mJpyXuWmFqaj2PiHf9lolU4gLzLMU+t0uz7auhpNsSSeTMXWmr
         pYq/7Ex8qi0Nk+cBw1PErv1TU1qwAcgoDk3g5TSJmyOQHQMAp64GhyWtShrlSE/pMMRP
         mTd3z9wEASWki5mub2Sd9xzYruGBnVN0QF9kSzvaVsBR2a2LkwgeaWqSiqNj29fUmNQR
         iR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=c8SH9EDnCkmjUHGPR0P2Z3gz/VtKXf2f2iywxNQfoIM=;
        fh=WiKAiu6Fwk7L1MMDhQTbC+yyXkOtj3APl9DI/nkI0kc=;
        b=JkhvyqfuUei68DllUr56Qv6wr4KWvIDKcUYT/6xkRclQtgXJL2rKYE7/844nbtH2nE
         y8qIbO5ONkshGHcc/ugrsnIg+1FcU0J9J/XzDVFgrWAC6hXOOKbAeFcXSwqyaOiZp8fY
         hXZK1fPXpwY3Ss8Kvs+k9Hq/xIxLpafA1ZGB6/4oU8yFPjcaqL/fhLjIQKMZ2MUysnK8
         Yc4fa2uZH2rFfr249qIHYdeeO0MeUnn2YtvyzSsWf+tvZXNKzAI5hEvx65xCQNYjXUZi
         WjKzs21ZhA47qOXTTw0E2XE7bJg9yQ+gcHY9yHKR3hF7mLZCsJo+tZ/GxfWR6zSQpztw
         XDnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794305087; x=1794909887; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c8SH9EDnCkmjUHGPR0P2Z3gz/VtKXf2f2iywxNQfoIM=;
        b=OcSkI3ouRW9vs2LVKGDINf3yMFDOmmg31mz72m3rL8PkscnCWSry26doTrToWEx5Qf
         gSyD/P15uxrBzs7tQxF6aiYUxQaqMniPE42cAZzKntQFlisY9gXNto0j2mLA/uEgTIEr
         Ekhk9TD0X7fdJ35AYJA+k2/d8jJkt6tIjfg4T8UKXLc64qrvFYSyocIyWG+PpqXUP51b
         jSAK8GvC0TbcAOgT8AafDEn/49BPkIcXMnqJ5hi1gnop2IXZ6U0e+We28buIwv6e5vRr
         Pp+13VPfJ14rB9SjSFDBfY57KDwNYTyW4uuLyLsxy15BxKm5C0FI7W2NwrH4X1aPM4BU
         vnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794305087; x=1794909887;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c8SH9EDnCkmjUHGPR0P2Z3gz/VtKXf2f2iywxNQfoIM=;
        b=RHFMDa+JCoG6Zhdb7usL3p0jMHkB5VDy3QW8AW5iElj3xcgxH4PlYnczCYR4zES54b
         i2NpLnbxEQvHSFz9P60h5O6mzgpjCcbMIBi49AJ+/PHmf4mp/zMYcPSlhGLkun2w32HV
         JIiqYbXvFe1ZcLz383S+JoyN5dtXC/AVbQHgzhgFZ/rRfEqVIwMbG2AkDF2Xyiu0saOF
         hxm6TGm9r51dkiW5oOxhT40OzJ7qd95SkDu9naZ7z2TTNpRlxyaKirgK1oXFXyzkYSGT
         i4T30B18didleYO5hBvjdATldSxmEsVAkj6FpyNYWHKND5TWupxJK9SEGFqJZGHX76L5
         +eiQ==
X-Forwarded-Encrypted: i=1; AL+hErHF4bpCRrHTjFAn55uZI78EowOiSZWrdTVPM/F0fKV2dT+f/xRWdGaP86SLXLn9g9FboB+1eKE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9F9pB6UFmCap6ZHKZzhdkUs8cvU9+bD2RTUUB0KRrlFgM32G6j
	Hp8DQ4tqBTfCfuCTYY4J2jmimeBPqm6daMJOHITwKa3Zjjlnu1dOo/VEY7OLoEQ6HJXQcO+8gMl
	VHSAtHvkD7chVNXhDAXnqgm47gt+zuqFNupytBIhRxA==
X-Gm-Gg: AYBFou2wPyrh1XJj8kEzGk7gHtKkTz0v5lr1W4jO7bZYUzk32YVIqx1yq2fpJwnaykY
	qSx2FKYypWT8jRu8pIKOFwoKmotfaQhGkke6oh8V5a4YM8vdYEgCijTcQgy5O1vCMtQNXGTiYU/
	PCD7w89ExuBdG+3RNIGciRCU4C4YTKokCBoQ5pD2lcf2XzVWYwcu+KMHiDaBlyOQSu0lqsOWlyL
	acClSSfOd46QFixFnabEqgL8aAzOXRoPvOVtPfRKdWf+Ko6+5kF4k871MXGkbv/dTtaQwgdjdBd
	RIRBB63IElnrPY0s9OmbyBFgrwIu/8m2+i3kqQ+TVdcZCHIIIoSF6tnh/uLKbJ6lg7lnNFzPC1b
	Vdf1BoYUKa/dwm0N0MapYhMcJ8K+/mVrNGrD5zAkvwB8njxT2bp2ovvI7CcdnzsUhnb4zrSXI5Q
	Zp732TJCZ+V4dfmjPB0hHvdMOvdZejCofdcYR8I4TuYaaJ7KvwNO2k/FjsCaUAgCZlj3Tr1dFZ
X-Received: by 2002:a05:6820:c0d4:20b0:6f7:e193:8326 with SMTP id
 006d021491bc7-718a70211bcmr533260eaf.32.1794305086687; Tue, 10 Nov 2026
 02:04:46 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260925112850.189302-1-danividanivi@gmail.com>
 <179068206160.434549.1717741783856466607@kernel.org> <02c36d47-ad50-4f2c-88cc-6c91f62bba00@intel.com>
In-Reply-To: <02c36d47-ad50-4f2c-88cc-6c91f62bba00@intel.com>
From: =?UTF-8?Q?Daniel_Via=C3=B1o?= <danividanivi@gmail.com>
Date: Tue, 10 Nov 2026 11:04:35 +0100
X-Gm-Features: AclHuK8llmPJAPoIuNJK-9z_1ADOqNSF_GH_KJ9E3vYufuFCOTh_YkEnA-aSzHQ
Message-ID: <CAD6rab8LEfZcQgcZLmeiDzd-PUi56h=9aBEsuOS2qnoyZEsdxA@mail.gmail.com>
Subject: Re: [PATCH net] igc: Disable PCIe L1.2 substate on I225-LMvP and
 I226-LMvP devices
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Cc: netdev-bot+sashiko@kernel.org, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"

On 09/11/2026 12:45, Ruinskiy, Dima wrote:
> I think this patch might better be split into several patches.
>
> 1. Adding the missing IGC_DEV_ID_I226_LMVP to igc_is_device_id_i226().
> This was probably an accidental omission.

Agreed, I'll send this as a separate patch. Note that it also changes
the TSN code paths in igc_tsn.c for I226-LMvP (they will now get the
i226 behaviour), so it would be good if you could confirm that this
is correct for 0x5503.

> 2. Addressing the locked vs. non-locked call to pci_disable_link_state
> (the possible deadlock noted by Sashiko) - this should be looked into a
> bit more, I don't know off the top of my head what race is / isn't
> possible.

I believe the deadlock is real and already present for I226.
pcie_do_recovery() runtime-resumes the affected devices through
pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL), i.e. with
pci_bus_sem held for read. If igc is runtime-suspended at that point,
igc_runtime_resume() -> __igc_resume() -> pci_disable_link_state()
takes pci_bus_sem for read a second time, which can deadlock if a
writer queues in between.

The L1.2 disable done in probe is sticky (link->aspm_disable) and the
PCI core honours it when restoring state on resume, so I plan to drop
the call from __igc_resume().

> 3. The actual problem with L1.2 substate this patch aims to solve. I
> checked with the HW team and there are two conclusions - (a) it is
> strange that L1.2 is enabled somehow for I225_LMVP - this is not
> expected.

You are right, and I was wrong about the mechanism. On my setup (HP
Thunderbolt Dock G4, I225-LMvP rev 03 behind a Goshen Ridge
downstream port) the NIC only advertises L1.1:

  L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+
            ASPM_L1.2- ASPM_L1.1+ L1_PM_Substates+

and the upstream port has no L1 PM Substates capability at all, so
L1.2 can never be enabled on this link. I will drop the I225-LMvP
part and investigate the dock errors separately with AER enabled.

> (b) generally it is probably best and simplest to remove any
> device ID checks and simply disable L1.2 across the board in this
> driver.

I can add a third patch doing that if you prefer. Otherwise I'd leave
it to you, since I have no I226 hardware to test it on.

Thanks,
Daniel

pw-bot: cr
