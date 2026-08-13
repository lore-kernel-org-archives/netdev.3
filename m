Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A640DB42
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786631663; cv=pass; b=Y9EVsJJHf0DamaZeIc6NwfmOMZ4YMWkPcj/XIxXKze7rxbbllic7fy4ZTSb7G4b0lXr40jUWrHmugsbK7793PNwmybvsjFTuZwBIBUO8ft2brmDIOPNv1rvzuts5Vt2m/nQltWtGGKIrpCcfbmXXzdvupDOm2JZhHx5PGyRT9YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786631663; c=relaxed/simple;
	bh=Za2d8rQCkTQzJPexEt6S0cAe1smEKeIqmteIY8J7q4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWkH67EeW9mgDj4D3Nsmiu7SwEYajZswdej9XepPaUyJ1Q2+M9HARA0KGuxe5Q1VQ1YahRfPFF+dVEzVDh0yqk14g/iw6y2D+PIFPo24z4+EHg+AgacEyRfFZfgomAA5hQ6kkq16XXhAHNlYlsc4gwNPQTr/GRbt+BhjB0iJpEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foZsuLzG; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foZsuLzG"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4956242332dso111695e9.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 07:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786631660; cv=none;
        d=google.com; s=arc-20260327;
        b=nT0F7ck2D90B3Wva3BkFA/x99w6+fXEg29W5XuDC7nOWYLLHx+FOX+Xq/RNpZLQMDe
         4TLbmVd0pqI1bQu+gTIxHuALb1BdRq27g5xapEqlgnueQNVflT4hHUKgpvCpfHnpYv8H
         3YkgNm6NnKug+Lr7THs+9RLqpQoaw24dfB3PvklP6rkiUxyr9PyN+ala9hwtz4ESamP8
         vw2Wsjqvvn/F4FXWcSKdJ5hCq9cQm4SgQ1v1H2O+ohZmv1Dy7UCa04oDKQp34XTOFDyS
         BWeCyUQWQVcmqZVcXEj1eIrkYGDFQ+D4Cjl0kUA1Jc7D+DbwoqmCud1P8/fJuvDjhcwf
         znIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+XN26PyxSdx1a68OANv50TWHMye4w8jJSd4is9pX5AI=;
        fh=GJDOkJGMPhVedBW4znRBBLZnIkPYpiu96hIit20RvTE=;
        b=ihJYocCLSYZ4Z/0/speBG2N+M1yeM2K8ndv44PVhR8SGB2x8ZsR9sJdfP6Q392qC8u
         G+Kb/ZNoPnUIWI0w6/FvaqqjeFa8drySL84I9ur8+9e7akK7eFZdAE+ULoDTalzlM2Eq
         2IrbzwYMFd7J7UzEMBVHT3a//IhyqmOSgZCLjRcH5DPxgKIF5f/dUhknbRnOsl+90M3w
         9Bopss6lgcXt45EFBvHRVsWZmJPmQWMg9t9uUUziphb/0xivhFF9SFWnBkkfTUcqQ0Lt
         bWMYQ0f/cLMwG9mZHiQkWRRfbzHLlIF5gHAZLLaJWnxhptm4H+9L8CZ6MXKnt49seSVQ
         fjjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786631660; x=1787236460; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+XN26PyxSdx1a68OANv50TWHMye4w8jJSd4is9pX5AI=;
        b=foZsuLzGr5+QbVp5drShqo737HvxVMr4BABDuP8sXsCPTM7NKgq2DtMcqk3QmwzZIt
         n+sRN0iCEr1yp8B9F0t+RIj9dwzi98+ZQ5xbNxBK4uhGwgSwfnAfjo+MJ8bVpEyt0PKV
         dKEZsOYfirW9QXSqMDezchb+KFvoymfqCWUQaRz1xcirBHEpNc8jmeypE0V2htMD1HUF
         X9goyck0+5VikRiFbK79avjefjF3Rm8SS593UfUFR1OXEXiWh3ZLkMGB29fo9tkJc4D5
         K0R+91gosFVRluvrpg7iDUnszoSiC4U9uu6Pob/4J+wLKS3z4h3ETznrfeNyTHDndCet
         N7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786631660; x=1787236460;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+XN26PyxSdx1a68OANv50TWHMye4w8jJSd4is9pX5AI=;
        b=gakEh8NSdiJbEMDmdC0cZvpOnBZf2z4HyqDcvehMVwSG/lIW6DJtc4M5SPHXLrJuOA
         rtSHgUeCjae0NQKT9iDnUd2RharGSz2Y9K5YMaL3tKIgUokQmjMVdoCxcUzCE9yQCGwB
         4FLrcbbn5kJcgpb8hxguC6dzAx8pTGGkCj1XEjEfdl1RJnuWjQyxfGEbWIXIaqBbXSMN
         EfMA9QXyfCjl7Cw4C8lK6Vd/S1Rn6TQxkKcGD75wz4+hTxI75Ms9cWkWJA3oMRhe+v9Q
         wtiSV4RecP/bVkT1NFUzJyZHPXm/cHDfptFFC4xQrBTVkvGtJqcd6Xst6bjbJnu5fhEJ
         GKsA==
X-Gm-Message-State: AOJu0YwIX6Aj2j1FNk3vHyeiPzhLTdukjQ4Cgl7cY8My92q0yUJJd9Ad
	XxTlw/TeERTLWn7mllMbghlqyA/qmlowZyqU1LndkHlsuLyonf3LItdVq3lpCppxuZ0sUmD2wqq
	9Wx9NiXEacXUl2EgeupdbA2hxK6C+un4=
X-Gm-Gg: AR+sD12sIdQasvy9o7+ultVBOoxWolUkyXGsq6Why4RTPuOCpdGkETSEuh3C/iFpEdC
	rF0v9vea9rA0VDhaLCXyQh+XYwosaRR2fKEKH49Sf4Gq3WWoymt4uZ8sopPhKvQfu55tj1kbqjD
	SuJML/UI17D86lQ6sBvk8fxLkVoJ4AYvishTGa4SScRxSgJjtZmuJv+GwsHaOct7lSgCVrwbSJw
	OfD0irTRoARs5VOOa0pAS+Hl8qzR3sW0nIdnxQ84xAqc8TiiAQvT7RhdqfAS92YlnrZVVVgpSL7
	s0XAwVK44rZHw9ZqYNypwUmiWJSy9Z2BR92/WuwSN2aknfJvwQFKhyrN+qCCFujoghj7k7BR3Y4
	=
X-Received: by 2002:a05:600c:3b9f:b0:499:4d4d:822a with SMTP id
 5b1f17b1804b1-499821d77f5mr71381615e9.17.1786631659743; Thu, 13 Aug 2026
 07:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKx9m6PywVwkirvkAtz144c-yg71c2+OcNYOTM4Bjtd8dF2PaA@mail.gmail.com>
 <CAKx9m6OsGKGKGxPnjwy8U-bDyvXVEK-dVNmvP0ZqSL-t2Exsgg@mail.gmail.com>
 <anziUH_cC1LXoB1x@pie> <CAKx9m6OMQKufDpqGJewG1OyvZGBKGimSxxxGRDGWgFicSRoTGQ@mail.gmail.com>
In-Reply-To: <CAKx9m6OMQKufDpqGJewG1OyvZGBKGimSxxxGRDGWgFicSRoTGQ@mail.gmail.com>
From: Giuseppe Nespolino <g.nespolino@gmail.com>
Date: Thu, 13 Aug 2026 16:34:08 +0200
X-Gm-Features: AUfX_myULhKAzWIBTA4DYv5bRVfn5mOleoopu4YOkvbaRJTkKLQ9oD2jkfN7CzQ
Message-ID: <CAKx9m6Myf7St+czv3i82dK2fs2WyAcx+B6r_zT1tLPs97SH3tg@mail.gmail.com>
Subject: Re: dwmac-motorcomm: RX dies after long s2idle, only wrapper
 SYS_RESET recovers
To: Yao Zi <me@ziyao.cc>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

DISCLAIMER: most of what I write in this message comes from AI-driven
analysis, even though I manually tested the steps.

Follow-up, with the TX measurement I owed you, and a correction to
something I implied earlier.

TX first. The bug reproduced again today; I forced 20 raw Ethernet frames
out (AF_PACKET, EtherType 0x88b5, so no configuration change and no
dependency on a working RX):

  mmc_tx_framecount_gb   +20      frames really went out
  netdev tx_packets      +20
  tx-0 vector             +0
  rx-0 vector             +0

TX interrupts aren't delivered either, matching what you saw with OOB WOL
enabled. Register signature identical to the previous occurrence:
OOB_WOL_CTRL 0x1, MGMT_INT_CTRL0 0x11, MSI-X vector 0 unmasked, and all
512 RX descriptors written back with plausible lengths and OWN clear.

Now the correction: the failure is intermittent, and I had been assuming it
was deterministic for long suspends. With the pci_wake_from_d3() change
loaded I went through three long s2idle cycles and only the third broke:

  13h52m   lease 6s after resume    fine
  27min    lease 7s after resume    fine
  31min    no lease                 broken

The longest one was fine, so duration isn't a monotonic predictor either.
With n=3 I can't distinguish a partial effect of that change from plain
stochastic behaviour, so I'm claiming nothing for it - dropping it as a fix,
and happy to send it separately as a cleanup if you want it.

On the isolation I'd left open: motorcomm_init() on its own does not
recover the controller, not even followed by a full ip link down/up (tx-0
+0, rx-0 +0 throughout). The SYS_RESET is the necessary part.

But the reset alone isn't sufficient either, which answers the design
question I asked you, so you needn't. Right after the SYS_RESET:

  MGMT_INT_CTRL0   0x003f0000     mask field 0x3f, every source masked
  INT_MODERATION   0x00000000

reset + OOB_WOL_CTRL alone left interrupts dead; adding the
MGMT_INT_CTRL0 = 0 unmask and INT_MODERATION recovered it immediately
(tx-0 +16, rx-0 +220, DHCP completed). So the reset has to be followed by
the motorcomm_init() that resume already calls - it can neither replace it
nor be trimmed. What I can't separate is whether the OOB WOL clear or the
unmask is the load-bearing half, since the reset does both.

That makes the patch motorcomm_reset() plus the eFuse settle delay,
inserted before the existing motorcomm_init() call in motorcomm_resume().

Given the intermittency, waiting for natural occurrences is a poor way to
validate it. Instead I'll inject the fault deterministically: arm OOB WOL
by hand with the one writel, then suspend and resume, and check whether the
patched resume hook brings it back. On the current driver it stays dead, so
that gives a clean result per cycle instead of a coin flip. I'll keep
counting natural cycles in the background too.

Giuseppe
