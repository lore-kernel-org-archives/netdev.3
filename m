Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13281419FB0
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612377; cv=pass; b=u0eLYMgNzWEDuOSw0F1AFgiM5EeGPAVBNH8mhSwxe2VHwRMCeyx7byVAL2wrnXhBG2XKH8o6bzi9J7sae7BEj+/tjW9sXFE1eFCnp0mtwgpBG8rUVXoOjHDA3mQDxVfmOH5NAUfbrZAgUQ6uueJxDuXXGKwDlIxi0JwmUINHIM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612377; c=relaxed/simple;
	bh=GBtva2KZ1EyGMmXIRIw5pO3GpGklAbEAlIXaFJyVrMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WcX+WoBDEarxTxdgeo+zYrml6rd4xj6xfYsNdYXyLr99L1JvTMVpd6uoMic9Lmogb8vV1E1b0t+vrcI8m0kZTqAutm0RM8AXg+DwBdeBPSTECzCWhOt/x31JhOQo0yYIElL7yjA3ZT6OpG/KI9o8L2WYNkhoZeX+OLIkfp5dqPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+bNT3+l; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+bNT3+l"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47fecbbafdaso112072f8f.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:12:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786612373; cv=none;
        d=google.com; s=arc-20260327;
        b=XTzxArmrfhoDz7jG5QnAz8PPxC9v8IMmYsNn9zbhvdjxD5DS0Fx3t2R/WRep6Y2E3B
         8wGp2Yzc1el5l5cF2JpqhB0HiqG64WGwF+dZfQWV6lfk9mSzBVz1PeWCZyNwegZU/GO2
         kk109rUeFB98zCIU6VR7fB5oGb6HPHeRPEwcNkrVSe/zg94FOWbBbmjODHZFv2mcC+H4
         MiJGZR53JELdteP+A/pf11YVGCHxXtyeiWhLxqWiEKswkQt51XcXhaTe16/wuajsVqhn
         r70qDg/5FX3HkEJ87y6HBxL4aEB6eujh19QQsLVpbdxntSn4GKLCqCuaxEP/CeGFvCug
         P6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=p/WbrLiaNyBWvzKpKOd5lXk8NAlx0TBK+gmzvpDzKLY=;
        fh=GJDOkJGMPhVedBW4znRBBLZnIkPYpiu96hIit20RvTE=;
        b=cWPF9GFPCXSXkGb3BZvwJAgNDESRhAAWX08W27yTsMdOun8T8Ry7XXkiX943AruEnV
         cOkQ/KnUDPNAvziZcPIvsATSNgbIVu5kj7E9PuiAABC265/5iNs0QvuCx3sEwDWa93/q
         UvWgi4ilee0AS4TXiq+WqusFryIGuBQsNtf9dRUIGO3hYWVtQJHb7NpLNW1Tand5Hb2C
         wuOvl2PBBMjgijIYT9QLkAB7PaUa9UTXCYnv3fNBQBwQ91AvvNTEZA2eK64tGx0I0ZGQ
         CaIl/AjCVwx3j0j5UOsdlbdHfW1E53m78QWIuy9nHzc9h/etpGmE3waxZ+jYC2wX2H59
         sGIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786612373; x=1787217173; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p/WbrLiaNyBWvzKpKOd5lXk8NAlx0TBK+gmzvpDzKLY=;
        b=h+bNT3+lfZ9N3OY3qosJSPA1UgbZZLwOPk2X870dAnHSFb9PVwbAi+6iFz9cei8xhL
         LJnv5JDXj1qOP+S6Vkzi6xwVjINqnTGESJRtnk5H/h+siRjuQB50e04XrUNpFiSzOwDm
         48q8HZgxGHpeHN7C7Fl/qINjwLVDTrMgFvORI1d5yaqIMzzSB7uk6vK/MsAG2/Pn/3RL
         LObusvaISYAG0i329i6nTHrWrgxLLF9YtML7+79ZsPCNsp9lYe0QDyZaoCFlJ+ZGDmLL
         tlFmNQ7EWRd8UkfCHstWq9wc7NHaNfUjvtbaDPOKoNu4uaqXTDdNMfNaHh31/pU/wQa1
         eMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786612373; x=1787217173;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p/WbrLiaNyBWvzKpKOd5lXk8NAlx0TBK+gmzvpDzKLY=;
        b=DBUZmVEr+08H3OsDWJKTiMDrKE73j0gguycbcUCwkA8Tl7nE4XkO+kJ+mLMv/xH/7P
         Sw97RfQoa2u4gFBM6SdbRGHrZs2wRXXTxiHtr02BSBh3jvryFkHb1djnpf8CiX20oB1J
         pcC2bqhEcPZ/LhidM1/72QFB6xP+eMcYI8B8ZFjd47Zk0qZIe+/iwF2a6h23ujnYgPV6
         2l7qXRDkEOY9BtoZKXJl9jS/YpICx2oKtP4S6Li116nv1weoRvVn5PrkCkPZRdqHJqpg
         KIeA9e+RwiaQTXZMuGtnkSMgYEk9nTMj423KP6NVqIgB7pOnP/2InTPRp2QpQnaJiXnM
         bzfQ==
X-Gm-Message-State: AOJu0YyCQDMidSORkl9Rata1tpSViJ2Twe4jIzEBlw9d6uuZyD48ObQ+
	1VCSAFwIR9TwPKGiFX6q9Eu9xu3szOEXHBamhGJPf+kxEywdRYfBJbH+OMqyCc4VUEfMsL6qUFK
	hB5Cu/PM2gQvUNDk69urYtb4P0yVh7fFgubnSYus=
X-Gm-Gg: AR+sD10BMxrsLnAQWJQHedQqUGQj7m3OtgrX6Tcz7Wuu7C++2s0p4RHn3UE5vXFiwHn
	iB+kEDKFZqJOjzx8GWZtPy9lc3qXmhTqmfOd51i66MiTTPOU04E6LDG8DT5O9Nh9YQgkV671v9U
	Xvmw+O6S/QfmRDVTfMXiqJ94f0c08ItSE4d3ySAvkiKBCETIWZ7/EDlSUkj7CmElJ2VuKbOYAyL
	PxPZYdTi21T4myNo6foe86pb+oJ38ULKip4hQlLSbnjz/rjVUJ3Nq2wv8XnQdEHw/CbNxcR9xB3
	l08/vUaXKL/1NEU9v/mIS3uKjsUtU/VxibEr2YCcL3VJBEz/kVQoJLR4tKqLRs3Eg6nsvXWf4qA
	=
X-Received: by 2002:a05:6000:480d:b0:481:568e:11b5 with SMTP id
 ffacd0b85a97d-48159ecb17bmr6596968f8f.5.1786612372845; Thu, 13 Aug 2026
 02:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKx9m6PywVwkirvkAtz144c-yg71c2+OcNYOTM4Bjtd8dF2PaA@mail.gmail.com>
 <CAKx9m6OsGKGKGxPnjwy8U-bDyvXVEK-dVNmvP0ZqSL-t2Exsgg@mail.gmail.com> <anziUH_cC1LXoB1x@pie>
In-Reply-To: <anziUH_cC1LXoB1x@pie>
From: Giuseppe Nespolino <g.nespolino@gmail.com>
Date: Thu, 13 Aug 2026 11:12:40 +0200
X-Gm-Features: AUfX_mx0O-jb3RCcHolqov3qrcfvsfX8jcJqB73P4a-FwEOTfnURvJls-xivSug
Message-ID: <CAKx9m6OMQKufDpqGJewG1OyvZGBKGimSxxxGRDGWgFicSRoTGQ@mail.gmail.com>
Subject: Re: dwmac-motorcomm: RX dies after long s2idle, only wrapper
 SYS_RESET recovers
To: Yao Zi <me@ziyao.cc>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 12, 2026 at 09:14:56PM +0000, Yao Zi wrote:
> This is quite unexpected. I found enabling OOB_WOL_CTRL blocks DMA
> interrupts because it's the default state after resetting, without
> clearing it, the MAC is non-operational.

That fits what I see, and it explains the asymmetry: the write only takes
effect in the window right after a reset. On an already-armed engine,
writing the DIS bit back does nothing, which is exactly what I measured.

> Have you tested the idea? We always call pci_wake_from_d3(pdev, true) but
> from your description, broken RX only happens after s2idle is active for
> some time, right?

Right, and it's a fair objection; the wake is armed on every suspend, so
it can't be what distinguishes a 30s cycle from an 18min one. I built and
loaded that change here but haven't been through a long suspend with it
yet, so I have no result either way yet.

> From my own testing, with OOB WOL enabled, both DMA TX and RX interrupts
> aren't delivered. So TX behavior when RX is broken might indicate what
> has happened.

I can't answer that from what I captured: between my two snapshots no
frames were transmitted (mmc_tx_framecount_gb stayed at 98), so the frozen
tx-0 vector count proves nothing. Worth noting that TX packets do leave
the interface while RX is broken, but that is expected even with TX
interrupts dead, since stmmac cleans the ring from the coalescing hrtimer.

I've instrumented for it. Next occurrence I'll force TX traffic and report
the tx-0 vector delta.

> Anyway, please try figuring out state of the DIS bit when the problem
> occurs before sending the patch, which would be a strong reason to
> perform a reset in the resume hook.

Already captured, from the last natural occurrence (s2idle 14:43 -> 15:01,
18 minutes, on AC):

  OOB_WOL_CTRL (BAR0+0x1010) while broken:  0x00000001
  OOB_WOL_CTRL healthy baseline:            0x00000001

Identical, and motorcomm_init() had already run at resume and written that
same value. So there is no software-visible state left to correct: the
register claims DIS is set while interrupts are not being delivered, and
nothing short of the reset recovers it.

I'll send the reset-in-resume patch. One design question bef
you want motorcomm_reset() followed by the eFuse settle delay and
motorcomm_init(), i.e. the probe sequence minus the MAC addr
would you rather keep resume lighter than that?

One disclosure, per Documentation/process/generated-content.rst: this
investigation was done with an AI coding assistant. It drove the
register-level diagnosis and the experiment design; the measurements are
all from this machine and I ran and verified them myself.

Thanks,
Giuseppe
