Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F17627057D
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023556; cv=pass; b=Umt7K4Yt4/c6OBhfHVbMGD/XD1bLYoWZQ8k5FmaNJDtjtzoB6yDpDGBpnKmGRJvPtNqkw9pQW0Gm63CmTIMUqd9NulUsY83hSDlWtnm4lbL/TseLV2f4hXZyTShYgSXBwlKXnmATHzti7CjhrlCs9ajcbK0PZssVX08FXtbjLSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023556; c=relaxed/simple;
	bh=i5kxKOIYarToQVV1Zz+t6qLk0Rks9qNpc4ZTDiDrfFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0YWdjKzl1oHFYzv409jQ84ZjXQOWHzm25ppqWviJt7ALbjZfTCxg+dCe8O0cIGkVJp647WgVw0vbD42NXQf3JwWtfAYNy/WwFpB9IhVvxna741ajnhgj/eBSleQtccYmZ03NHzZZJ8SdQTlUIsSHgGQC4syguDfNibX+T5HlQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RC74orbh; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RC74orbh"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cab973140bso30673095ad.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 06:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786023552; cv=none;
        d=google.com; s=arc-20260327;
        b=nICf+LauE/wsDBKrsZ5IB17e1U3cJ8A4Mc//6VZcia+nDRaFnEyBfeEsZXs5tj6Yz3
         WwyiABTV+ZK+2y2Kqg1R9qOt9Oj2G7MqR+By8Cf11Is6ZAsmwSBNlM7wWkfezD5++kjE
         hOXzd/P/7Y70D/IWOaT/8NBY1IxlL/lTx5UI/dFRyTe/OG58nwij6hrSW2fFpvDxfx4u
         a4+TidaGIXCDwXRJcIfF/fw4z8i3aQ47kOTDEbdcs8YX+jLWpXE11m0fUJZBDspNctil
         7b0D88EQrrQQGoloMF0Ue2rweVEWDJeWJZPDZFWsYHNP79i7h8tZJowUk6DptiYhgZSr
         2GAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WvS7EK4N94LTj7JpiUX2vYAWQIjDe8wIy5jRHQDxGxQ=;
        fh=5zUeqTIE+zkp69d+cuGGxL5aRX7PtYH1LnmglcE4r0Y=;
        b=n8n0ByuKSBsU749wPwdilQd9GfkS83C+jk40oSQOMduRy6a/v13vXClS/pHZWTdHHf
         8rPofscc9I/HyrAiYvmN1y4h1p0+0urA52Hljic+PgkRv+aGornQoWvsEKwLK2vzdrrz
         NT4dL/rVSoQ469EBN2kh6aS1MOibEn4t+KMh4syJZi4BsdbgD7YTR8VAV6X5Fh1zFFKR
         q0turiAn/o7NR/nBD2fj1SjIs/7vKK481uAI/jbIINvOm55cchND2b5WjiUFvHGIoUI7
         A9Gt+pNkFEHKddjSaVaRpQcArBkqds/xkuOtNhCiPwXEUxA8dD+IsnU5jB6elSF+XSIU
         GAqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786023552; x=1786628352; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WvS7EK4N94LTj7JpiUX2vYAWQIjDe8wIy5jRHQDxGxQ=;
        b=RC74orbhlSgxRgytVmJJsEGdKaIDWIGBYhi02AETFRLTSCU8FTQqW7+sdqaCIfCVvZ
         C3cLPSbsVRnwChqWhwPjHZJeJKKrLq6Xc6ayGkLy6wqNMtF62JSD7q6CSia46F9sT0Nb
         j4iURJH2RxXxbgfCX8Lv4EITTR40EVXg3e30CYUhcTIcChgrcrdB4sd/EXcCQqXU45I1
         kbpBjsqt9xfh9K7t0oG/GYjDELIZJrzYivIhSTk8SNK6n4iscoYG3nUyNzzu7jykCSSU
         MUnP3yMEEBdiR5KkuiEUu6MZK/2IFLt5/FrW96RHqsvCQmJ1I4oXaOdk8gMSl93eWyvg
         bAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786023552; x=1786628352;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WvS7EK4N94LTj7JpiUX2vYAWQIjDe8wIy5jRHQDxGxQ=;
        b=pKra71Qb+qSpJqAFmvNXF0MrrMvoAfI95Hl181TLyLc7u6iLBcRMe0k6PbEHRvCZMa
         RdsRC4TpVK0SvsDYtaMYa2a94cD4tTYEPC61J2QDQE09qAgONsDgKMIjnvMK/vinrVRH
         rpQvW4nbHTLEwseXtC1lpd+TdRBjEaDCctMkxfCQmTyeY/6jqrqz6Anp+XNrL3fDZGNM
         EE23ymVeSJdTRVvD88hKs9SHPdlwniX6zdiJdiGlLEnzf+Ab3wpqXjJvTFOxvJNml/xC
         nZm3BbCBPwNeuMX7Q4FiVxJTo7ZrgW90oRYA+PWCyLtbbxFlEsXasBnLIrtNEWQ5t4Xf
         BRpw==
X-Forwarded-Encrypted: i=1; AHgh+RpKW+ljrvXr4/SUaO2iJFsrYv2sxkdHD2bEpF30NCx1LF8hg3zsIF96ZsKkmGv/OCk1M0yZ61o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHB9Kx1J3EXlOGHN7/EvXcgBcad1xMH7x0mGt5XwtilWN3f+1D
	wmVlRq4EsI0UYAqj9v9n6J8YIrZ1NGLxdrNR/XqpeZ/RlS6GWTCtdFykpAyv+vl3c+IL7TMgH3V
	/v5s9Pl9WDjmdiHIEi5aNf2S9L5r23liWDOUAJqDYIg==
X-Gm-Gg: AR+sD12uL2OEKjllMDOiIR+RcpcG077x3fVCMlado8Mh0L1R0XjpTeDfgV9lNqdhFrS
	G8Z7CiK64JFHuYOPvlJxzGd6VYXj8vTAXD8qejnaKNLYNDP9WrK3r+aJT8La7uCE01DBV1BgD7D
	xsoU7ST9CxmLU1MWn2X0j8k/UpSdcKbXXGe7MoQYS24ZxU+/Ae9iikIhZV6jKVqXBT5UsCuVQbq
	tcAYEN3H/nE35NxoTR/ZeBSLv8T1GqP31POX95SCI+2frMXlGKGFFD6NdDmU/o8rrMOYHIIiRww
	Hue49X9xYYyJyQ+k3KWvLRJRwF5sN9aFZrZxdW5jZ3MzPA==
X-Received: by 2002:a17:902:d98b:b0:2ca:20b1:3e0a with SMTP id
 d9443c01a7336-2d0ca7af30fmr192225135ad.3.1786023552218; Thu, 06 Aug 2026
 06:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806073119.387-1-strst.gs@gmail.com> <20260806073119.387-2-strst.gs@gmail.com>
 <20260806111523.gjlhjfmb526f2y4g@skbuf> <CAAsRjRnhdPJOCE5BwU7zUTJ0mtSYCOA3xLcF5ejZQT8OFjYiYQ@mail.gmail.com>
 <20260806124313.see74vgu4dlqqse7@skbuf>
In-Reply-To: <20260806124313.see74vgu4dlqqse7@skbuf>
From: Semih Baskan <strst.gs@gmail.com>
Date: Thu, 6 Aug 2026 16:39:00 +0300
X-Gm-Features: AUfX_mxRvuER1vd3qvmc9Yh97lS0ixZkBTXVuWwkA_Y6u_hextEWJbzxTLKYbGY
Message-ID: <CAAsRjR=RyiraYdLkOcHEagGKXK5+4zwQbT-Zq-1DwVkPiKUNpg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: dsa: let drivers offload 8021q uppers on
 standalone ports
To: Vladimir Oltean <olteanv@gmail.com>
Cc: florian.fainelli@broadcom.com, jonas.gorski@gmail.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

> But it doesn't, at least not in a sane way. If it still only accepts
> those VLANs that have been added to filters by higher layers, it's not
> VLAN-unaware. If a solution is not found to the problem, the driver must
> reject operation as VLAN-unaware.

You are right that the port is not VLAN-unaware. It cannot be: the VID
lookup on this silicon cannot be turned off without the ARL loss from
the other subthread. My mistake in the previous mail was arguing around
that instead of saying it.

Let me first correct a history error I made, because the accurate
version actually simplifies the discussion.

> I fail to see how commit 06cfb2df7eb0 ("net: dsa: don't advertise
> 'rx-vlan-filter' when not needed") could have caused a regression in
> VLAN-unaware bridging on your b53 switch.

Correct, it could not, and my sentence attributing transparent bridging
to the same change was wrong. b53 has had dev->vlan_enabled = true at
switch allocation since before v5.15, and b53_vlan_filtering() has
never turned the table off. So arbitrary-VID transparency was already
impossible in v5.14, the last working kernel of the bug report. There
was no coincidence and no bridging regression: what worked in v5.14
and stopped in v5.15 is exactly one pipeline, the standalone 8021q
upper. In v5.14 the feature bit was advertised unconditionally, the
VIDs were delivered, and .port_vlan_add programmed them into the
always-on table. 06cfb2df7eb0 stopped the delivery and f089652b6b16
stopped the programming. The series restores that v5.14 pipeline for
drivers that opt in, and nothing else. That is why the Fixes tag
points where it points.

> ..which you just said earlier that they don't work either way?!

You are right, that sentence conflated two things. Forcing
vlan_filtering=1 globally would not hurt tagged transparency, which is
dead either way. What it changes is what works today: untagged
forwarding becomes subject to bridge VLAN semantics the user never
configured, the reported vlan_filtering state of every bridge on the
switch flips under the user, and b53 switches its ingress mode to
VC4_ING_VID_VIO_DROP plus VC5_DROP_VTABLE_MISS chip-wide.

> The only distinction I'm seeing is that in hellcreek, VLAN-unaware mode
> works, and in your b53 model it doesn't.

Yes, and I think the three reasons you listed in 06cfb2df7eb0's commit
message describe the difference better than my commit message did.
hellcreek is case 3: its hardware can be VLAN-unaware, but standalone
separation depends on unique VLANs, so its flag also forces the
vlan_filtering state, and that forcing is correct there. b53 after
v5.14 is case 1, "the standalone ports would otherwise drop
VLAN-tagged traffic", with one difference: in case 1 the VLAN
awareness that causes the dropping is held on by a VLAN-aware bridge
elsewhere on the switch, while on b53 it is held on by the silicon
itself, permanently. The new flag registers exactly that: a driver
whose ports always satisfy case 1's condition, with no bridge
required. It deliberately does not force the vlan_filtering state the
way needs_standalone_vlan_filtering does, because that forcing solves
hellcreek's separation problem, which b53 does not have.

> You need to skip dsa_user_manage_vlan_filtering() because you want to
> keep VLAN filters you need while lying to higher layers that you don't
> need them.

I would describe it as the opposite. 'rx-vlan-filter: on' is the true
statement about this hardware: it filters, always, and cannot do
otherwise. What lies to higher layers is the current mainline
behaviour, which reports the port as not filtering and then drops
every unsubscribed VID in silicon. The flag makes the feature bit
match the silicon; the skip then only stops the core from toggling a
bit that describes an invariant property.

> With vlan_filtering/NETIF_F_HW_VLAN_CTAG_FILTER set to 0, no one *has*
> to reoffload the VLAN filters, because the hardware shouldn't need them.

Agreed, in the software model no one has to. The measurement was not an
argument that the software model is wrong; it shows what breaks
mechanically if the flag advertises the feature permanently but the
core still clears it on toggles. It is internal consistency of this
approach, not a requirement I claim the model imposes.

Which leaves the real question, what to do with hardware like this.
I see three options.

1. Reject VLAN-unaware operation, as you suggest. Honest, but on b53 it
   refuses the default configuration of every deployed OpenWrt board on
   this platform, where the LAN bridge is vlan_filtering=0. That turns
   a working untagged setup into a broken one on a kernel update.

2. Force VLAN awareness, the hellcreek way. No new core code, but it
   flips the reported vlan_filtering state under the user, changes
   untagged handling switch-wide, and enables the drop modes above on
   every port. Whether that cost is acceptable for this user base is
   really a question for Jonas and Florian.

3. This series: report the filtering that the silicon actually does,
   restore the v5.14 delivery pipeline behind an opt-in, and change
   nothing else. Untagged setups keep working unchanged, VLAN-unaware
   bridges keep their (already partial) behaviour unchanged, and the
   one regression users actually reported is fixed in a way that can
   go to stable.

I implemented 3 because it is the only one where no deployed
configuration changes behaviour. If the consensus is that 1 or 2 is
the right model for b53 despite the fallout, I will help make and test
that on the hardware I have, but I do not think it can be the net fix
for the regression.

Best regards,
Semih
