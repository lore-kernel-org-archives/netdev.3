Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF244199E89
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 04:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125408; cv=pass; b=AP5cvSEmpD8T2YKvGwR00ZJvEY0kKUy2we+SPeX5iVKHXX/2qzoSpfB5UuWQ0ZAgKfYGv18FY7J94xmCYMg1KNPo1c9Kias0VmWrOCzhJsb0zG6aKtLmqS5sOH9NnGMMXeL7jJQ7ZNvxIw1+3EDBbVdclSUPnrX77hPHTX+kuK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125408; c=relaxed/simple;
	bh=P+x8kRtOLy4oSQMU2h0DRz2Z99Ee7PlxjSH6SaCd3ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdWDyKEk/BcdGKcU9ODEY2Swj3tS2cBJi0rK7IJbcqO0vyx8B2abGECy72jEra7YaIn2WkhMzObOct65oCzpH6XnbSMDn58FkdQcThPRjl79S8dhHy7YSMTHUe3B+QKEvIXibIzjMnGCrf4HpA/LzWYw1zr899GjJYyXfGhxd0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=t+JTU6AY; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="t+JTU6AY"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9179bfa9e9cso96554666d6.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 21:36:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792125405; cv=none;
        d=google.com; s=arc-20260327;
        b=RgoW4lpce5DUrlqUToXleEqQzGHZMC0c0fRGSrvPQeHPPDECpGYOk9lyUO0V+56cSP
         VPLoIEGlLxQ62H7FMAj0UZt89bbgzENAelD5+3w6h1jPsvnT6LMtzTBH9bjvK2Yir8ck
         SpHr5lMsttwvv1E+Z/nnLvRDsM9AHazeWsD58hNBDzgy/EEOE+ILlAoDkcdhOkwlt6LP
         1lCbeeZFvdXvn4m/PUlGFfyRV6hvkZsVFmDOGqtrJSqBCoXVhV+F4cQg53YHW5fmEsUW
         txg2PGvlwwXSbmGter0m8y0915C4KtlxJD9z7e0RLaDqsxKT0rPxUwfj4LYJ7ubcWzTR
         vAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gHxN4BYf/potofF65wZfHFE1Jsf+16i1RZHL7zoXIPg=;
        fh=bTSh5dLIsHXsM7p485GwdY+tfS7wLTHOY3LrgHmeWO0=;
        b=NI3/Goh1ubHiqUrdUY7+YhmWSJxv+0ix9KkOxD+VU+arvzWEHyfPV+kBCYGTEtnLpX
         rnlPuwVqGrvMBjjyfc8wsnPqj9Y/bTsokIxwGSbl+KmqH1X7dRxW4M2RQy7CzHNA+fM8
         ATDAInUdClNsmBpbC182+ot0nmrayb+pjbmwb48+bqcjgF2c8V4amDZ5/WOUVnQVjr4e
         xJ6r6Nqo1GqNQXJv/trHaxu6p0LW81z6RJfz6ZcdU0wnLLEWfhldkCHa9eyZUc3gGAkq
         88rXQnfralCVlwij62eE1HYNtY8N/HhP6tl1atsWPRpD9DsQW8kcOb0Inm0yfu0x2fQW
         SXWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1792125405; x=1792730205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gHxN4BYf/potofF65wZfHFE1Jsf+16i1RZHL7zoXIPg=;
        b=t+JTU6AY2h27bMwst4bespXPSm1j/ly4lDhaNgTVJuHhFYo8PegkQuCoGjUXfSOEN5
         lg3XJK9eRW2KD9FKHQQ5VTpXvu7o4DvpsYjGUn52c/vmSQr6u82SGe3S+JR5SjIuZy2H
         ualSQnpFR6AYSvuAxjDPuER3Yl6uv24REEIr5dgmU6M6g1nULegw+ZLSdWeXW3Hz67lc
         x1rbdpgJiWAlNnFHk2Asea6anZjHTSbB/RX2gLhbbCILrzpRSrzf6AKBdgs4eakCYSeg
         vIzvUES2y69h0mhzmb1WhdLNcJx4IN5Z4sVct0Qt/HOh9kodCKxUiUP8nwC6VYn4Ium+
         cuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125405; x=1792730205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gHxN4BYf/potofF65wZfHFE1Jsf+16i1RZHL7zoXIPg=;
        b=LxTmLIX8SwUOnj7uj3tk02ZWX7N9or80QXExR2NDj0TmEfHAiWhH4R4L1SUVlJv2Gz
         vn+B/ORYLbL9tO1K5D6nBJUnQybMW0TXnDqiH4GAhj/500br6/hGoSXV8HKEew1ywWdb
         7G+8H67bHHD4ICDLN63ACiSk4VzKfap5m3vQ1yRdrKiKEklWAK7u46vtzUGMkvvsq1sl
         4jxwJhBrZdvP0II61pBc8rB3K0ehNRbyRbQ5Li+gbwW+y+wBznVY68Xf/pDXErPFKeSS
         aUgMHV49ZN59P9yN6VFe6W+rgFBh0R9vy2YuUhz9Mv7oFVR5U2G5W1bj6nZ5zwoM7Oce
         OHmg==
X-Forwarded-Encrypted: i=1; AKwUvBzulPFOSWDuET1oPPV7kpVOs3oTiTkZmB0REBlZCfO5YQu8vmI5dyE6laYbWBqBYANFdCUZEVw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJPwsxFB1WOYdZY+iDPmc2nZ+gkfj18jwKStoJynlPhlON6dfo
	k0BS9lVCzjBHJA2q+B22v8uV+asedRK77OyH8LFXbb0WgCM/4xgEzRuUUvw3z3hfUPF4a2VmzXM
	WGibHTrMYIb5VwLoYyp0XFCxL9AvdbHGfp9qYRgsR
X-Gm-Gg: AYBFou1nJYaE8zi4Hw/OIBn8DIdgQA2sIgGcCxz+0lptlozSfJOf3hCqWfJo/SOcAe5
	1nboZhmZaZLamXVRhvPsNxNGCXFB+dMglbWUfeE8jwMvwpX/PkTXkQ53DBmjDHdAOiq+kx7AVWC
	QTZTMwoAfMV8asFwo4IWnPiP6UR0QcqXHjzKFLfZ+DvjimPOji4sVNwhJXvjUPqa2yOsgwTvlXx
	/HnVqtsK2frvvWM/5WSmTZ6Y1k7Wb0H6rQQZJUsOI9RwI+PtjMvELaUHL3SW8f+16MsmHyvUXBD
	S4RPMAXEqKi9Vg+uGuOB9fBieInLq0PbV5sZSAEw4urDltvcgSR3Ov35DXPlHOhOLLfy/ES4QeU
	+TuQk2iulWbpMGOn4imoZsh/fkEMzVKlbhvoUi2+5vxMPxn+A3hIlXw==
X-Received: by 2002:a05:6214:300a:b0:912:517b:40f8 with SMTP id
 6a1803df08f44-91b55580735mr359965686d6.42.1792125405570; Thu, 15 Oct 2026
 21:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009143506.2507607-1-jjc@jclark.com> <20261009143506.2507607-5-jjc@jclark.com>
 <DM1WEUIF8V8V.2OZWRB5G232T4@bootlin.com> <CANz3_EamUFhoQJ54g9pxdrxGK9EYxu_KeqRTdAdxWzV15k4_9w@mail.gmail.com>
 <DM5J6J74NCTY.1IDZXHZM276JS@bootlin.com>
In-Reply-To: <DM5J6J74NCTY.1IDZXHZM276JS@bootlin.com>
From: James Clark <jjc@jclark.com>
Date: Fri, 16 Oct 2026 11:36:33 +0700
X-Gm-Features: AclHuK_ZD4gUu1IbX_yR4EZ6Uk1KbcugUxaSvPnFQkiKQfTclPy8-cgdfudXXBY
Message-ID: <CANz3_EZ7SZau+xL8CaaNAHMvMia+_t1oVGiA-aksPCDUWkadHg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] net: macb: implement timestamped MDIO writes
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Nicolai Buchwitz <nb@tipi-net.de>, Russell King <linux@armlinux.org.uk>, 
	Conor Dooley <conor.dooley@microchip.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Brian Masney <bmasney+clk@redhat.com>, 
	Stephen Boyd <sboyd@kernel.org>, Jerome Brunet <jbrunet+clk@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 10:52=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boot=
lin.com> wrote:
>
> I'm not convinced by the idea of a flag only allowed to RP1. Our caps
> are usually to restrict what IP revisions can do; here we're talking
> about a driver implementation detail.

I take your point. I will drop that idea.

But I wonder if it makes sense to have a cap that says that the delay
is exactly 63.5 periods as it is on RP1. Without this, it would assume
the MDC is free-running and so would use bounds of 63.5 to 64.5 MDC
periods as on unimac.

> Sashiko is technically correct. But then the bug is not in your MDIO
> delay computation, it is in the PCLK/divisor/suspend code. You should
> be capable of determining the current divisor rate without reading the
> NCFGR register.

OK. In v2 I'll record the MDC rate where macb_mdc_clk_div() chooses
the divisor and use that instead of reading NCFGR.

> >> > +     if (sts) {
> >> > +             delay_ns =3D macb_mdio_sts_delay(bp);
> >> > +             local_irq_save(flags);
> >> > +             ptp_read_system_prets(sts);
> >> > +             /* macb_writel() is relaxed; order it after the timest=
amp. */
> >> > +             mb();
> >> > +     }
> >> > +     macb_writel(bp, MAN, cmd);
> >> > +     if (sts) {
> >> > +             /* Flush the posted write before taking the upper boun=
d. */
> >> > +             macb_readl(bp, NSR);
> >>
> >> An unconditional readl for flushing the posted write won't do it.
> >> MACB is over PCI only on very few platforms. I guess the straightforwa=
rd
> >> solution is a POSTED_WRITES flag that is then read from here.
> >
> > This is only under sts.  Assuming write_sts becomes RP1 only, then it
> > is only over PCIe. I am not sure if I have understood what you are
> > getting at here.
>
> On any platform but RP1, such a readl() is useless. My remark was that
> the readl()-for-posted-writes must be made conditional, and I don't
> think we should make the whole of write_sts conditional.

I may be missing something, but I don't think the read-back is
specific to PCIe. device-io.rst says that on many platforms and buses
writes through ioremap() are posted, so the CPU doesn't wait for the
write to reach the device, and it gives a dummy read as the way to
wait for it that works on all platforms. On arm64 the mapping is
Device-nGnRE, where the E means an intermediate point in the fabric
may acknowledge the write before it reaches the MAC. The unimac patch
in this series does the same read-back, on an on-chip controller.

James
