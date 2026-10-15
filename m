Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804A545DB0;
	Thu, 15 Oct 2026 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079580; cv=none; b=uYmVeYPjpyg2O63PID2yoD4eA2sfXvBOne6fDZHRTyOZ3InDOuokoUl5rAEyTEm7jw+zKAB91n+sH35aqVAre6+PYHG81oK6vpS6ZtK5yjNx8G+MD+vc85yLcW86qsa6yUz8g1Yd2q/33xJxbXzCjKs63tZy4NcsHXGOKgh2oYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079580; c=relaxed/simple;
	bh=jLOQqkhHz4y1dBJ2dNUbTUBDf1VNKhVW0Ue9wi6gDz8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=fYiT4YamSIcsc2DTxA2vvWW9fV0rlaja649gBZNrmB/uOCV+A0ORLgQSArECEhl2iCOJE7yvAcNw+lf7wlS1fB2VZIFxqwMDePM13hPw8BYNlpwFEb0EVDwyq3gd3mhzjhSIqfmT6CUpbRTY7z0ijZo47g8OLWavEyLsWEWZYc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dDtEmuvc; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dDtEmuvc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 77D751A1241;
	Thu, 15 Oct 2026 15:52:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3E3286075C;
	Thu, 15 Oct 2026 15:52:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 705EF10328CEA;
	Thu, 15 Oct 2026 17:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792079555; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=C0a5W2OdDSxdUM2GZ1hLLLMJ6kCHR/FuggO9HUhU+74=;
	b=dDtEmuvcLA7/WwJZBvCPyuLjjPwtLHqN2YDhN/EW0EQQjj1GC9JMbgfx332rfW2FBG/aet
	NZZz1+IsCC7mTaknv5OKotkeHjE/LrxyzMhBiM/mk8Pm+nV0UOqKd26b6KoetgApnytouF
	dYSl40e9IePXzaaz79qo1GfJwKX4Y01/QqzvVx2UYcQULqfmIXjbez/sK45/Ot5RBZbz9C
	Xwg0j726a25eik1UyZZk2jgrkDJ4bIpxPX/vsphktNYRD3Nh/uirMvvRLzUf6uo0YOslNq
	sBzmsdBTWUT06SAgW8bCPZKOoTKjMgM/Xcab+97skveN/4ZNdt/JzKyl0hua/g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 17:52:28 +0200
Message-Id: <DM5J6J74NCTY.1IDZXHZM276JS@bootlin.com>
Subject: Re: [PATCH net-next 4/5] net: macb: implement timestamped MDIO
 writes
Cc: "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, "Richard Cochran"
 <richardcochran@gmail.com>, "Florian Fainelli"
 <florian.fainelli@broadcom.com>, "Doug Berger" <opendmb@gmail.com>,
 "Nicolai Buchwitz" <nb@tipi-net.de>, "Russell King"
 <linux@armlinux.org.uk>, "Conor Dooley" <conor.dooley@microchip.com>,
 "Broadcom internal kernel review list"
 <bcm-kernel-feedback-list@broadcom.com>, "Thomas Gleixner"
 <tglx@kernel.org>, "Miroslav Lichvar" <mlichvar@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>, "Brian Masney"
 <bmasney+clk@redhat.com>, "Stephen Boyd" <sboyd@kernel.org>, "Jerome
 Brunet" <jbrunet+clk@baylibre.com>
To: "James Clark" <jjc@jclark.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261009143506.2507607-1-jjc@jclark.com>
 <20261009143506.2507607-5-jjc@jclark.com>
 <DM1WEUIF8V8V.2OZWRB5G232T4@bootlin.com>
 <CANz3_EamUFhoQJ54g9pxdrxGK9EYxu_KeqRTdAdxWzV15k4_9w@mail.gmail.com>
In-Reply-To: <CANz3_EamUFhoQJ54g9pxdrxGK9EYxu_KeqRTdAdxWzV15k4_9w@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello James,

+Cc clk maintainers, for a question at the end.

On Sun Oct 11, 2026 at 3:01 PM CEST, James Clark wrote:
> Thanks for looking at this! I am very new to this, so I really
> appreciate any guidance.

I know the MACB hardware and driver pretty well by now but I don't have
much PTP experience. :-)

> (For some reason your message didn't make it into Lore, although your
> followup did.)

I has appeared now, but the body contains a second copy which includes
the mail headers. I have no clue what happened.

> On Sun, Oct 11, 2026 at 4:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boo=
tlin.com> wrote:
>
>> I'm invoking my colleague @Maxime to get his opinion. What impacts the
>> MDIO write_c22 duration and how likely is it that this duration varies
>> (1) on the same MAC+PHY combo, (2) with a different PHY or (3) with a
>> different MACB revision?
>
> (3) is the one case where I think it could possibly vary.  But 63.5
> periods makes sense assuming the first bit starts at the moment the
> command is written and the PHY acts on it when it samples the last of
> 64 bits at the rising edge half-way through the last period. In 5/5
> there's a different situation: there UniMAC's MDC is free-running, so
> the frame can start up to a period after the command write, leading to
> a possible range of 63.5-64.5. So I don't think 63.5 is as arbitrary
> as it might at first seem.

After a few days ruminating on this topic it is much clearer now.
Thanks Andrew and you for the replies.

>> Sashiko makes an interesting point with PCLK that might change over
>> time, giving an example (which I've not checked) where it would be
>> derived from the CPU clk which might change with cpufreq.
>
> I tried a bunch of different approaches before landing on what I sent
> in v1, and ran Sashiko locally to review. And every approach had its
> problems. Sashiko is right here, but on the other hand the existing
> macb_mdc_clk_div() (it's only called at probe, open and resume) has
> the same problem.
>
> My plan for v2 was to limit this to RP1, as Sashiko suggested, with a
> MACB_CAPS_MDIO_WRITE_STS flag
> set in raspberrypi_rp1_config. This would solve the PCLK point since
> the PCLK is fixed in the RP1.

I'm not convinced by the idea of a flag only allowed to RP1. Our caps
are usually to restrict what IP revisions can do; here we're talking
about a driver implementation detail. Worst case they get bad PTP
accuracy, but it probably already isn't great if they use PHY PTP but
have their MDC clock vary with cpufreq.

>> If you share more details on your testing setup it would help for us to
>> reproduce on other hardware to gather more data points.
>
> I created a gist with the code I used (this is all agent-written)
>
> https://gist.github.com/jclark/372822d80ba27a9648d1aea939191b53
>
> Key point is that the measurement technique depends on there being a
> PHY with a PHC connected over MDIO, which is the case when write_sts
> is useful. I believe the RP1 is the only such case in the tree at the
> moment. If in the future there's another case, then it can be measured
> and added using the same technique.

I've not checked what is in tree. I care most about EyeQ platforms.
The EyeQ dev boards use a Marvell PHY which could benefit from the
feature if/when Marvell PHY PTP support lands in tree. I've tested it
briefly (more accurately, I tasked an LLM with running a few tests) and
something times out but I stopped there.

An RFC has been sent two years ago by rmk, and I guess it will be
iterated upon because there is interest!

https://lore.kernel.org/netdev/Z_mI94gkKkBslWmv@shell.armlinux.org.uk/

>> I'm wondering if we could do better than a hardcoded delay? For example
>> we could busy-wait for NSR.IDLE inside the prets/postts region, but
>> that implies at least 25=C2=B5s with IRQs disabled. Or we could do a few
>> measurements at init to sample our platform delay?
>
> On the RP1, IDLE is not the edge: IDLE comes at 65.0 periods. The only
> way we could measure the edge is by using the PHY as an external
> reference.

Saying "IDLE is not the edge" is a bit of an overstatement, we are
talking about 600ns (1.5 period @ 2.5MHz) here so IDLE is the edge plus
some amount of latency, which is to be expected. We are in the order of
magnitude of an MMIO read.

Is the 65.0 periods number you gave a minimum or an average?

Anyway from feedback on this series from Andrew, it seems this latency
is pretty deterministic and could be hardcoded (and shared across IP
revisions).

>> > +     unsigned long rate =3D READ_ONCE(bp->mdio_sts_rate);
>> > +     u32 config =3D macb_readl(bp, NCFGR);
>> > +     u32 divisor;
>> > +
>> > +     if (macb_is_gem(bp))
>> > +             divisor =3D gem_divisors[GEM_BFEXT(CLK, config)];
>> > +     else
>> > +             divisor =3D macb_divisors[MACB_BFEXT(CLK, config)];
>>
>> I'm a bit surprised to see you reading NCFGR.CLK and derive the current
>> divisor from that. The divisor is set by us in macb_mdc_clk_div(), with
>> only input being the PCLK rate.
>
> This was something a local Sashiko review found in an earlier version.
> The divider in hardware isn't always the one macb_mdc_clk_div() chose:
> after suspend with the interface down, macb_resume() doesn't reprogram
> NCFGR.

Sashiko is technically correct. But then the bug is not in your MDIO
delay computation, it is in the PCLK/divisor/suspend code. You should
be capable of determining the current divisor rate without reading the
NCFGR register.

> Incidentally, it is also what made the measurement technique work: the
> bounds follow a divider changed through /dev/mem.
>
>> > +     if (sts) {
>> > +             delay_ns =3D macb_mdio_sts_delay(bp);
>> > +             local_irq_save(flags);
>> > +             ptp_read_system_prets(sts);
>> > +             /* macb_writel() is relaxed; order it after the timestam=
p. */
>> > +             mb();
>> > +     }
>> > +     macb_writel(bp, MAN, cmd);
>> > +     if (sts) {
>> > +             /* Flush the posted write before taking the upper bound.=
 */
>> > +             macb_readl(bp, NSR);
>>
>> An unconditional readl for flushing the posted write won't do it.
>> MACB is over PCI only on very few platforms. I guess the straightforward
>> solution is a POSTED_WRITES flag that is then read from here.
>
> This is only under sts.  Assuming write_sts becomes RP1 only, then it
> is only over PCIe. I am not sure if I have understood what you are
> getting at here.

On any platform but RP1, such a readl() is useless. My remark was that
the readl()-for-posted-writes must be made conditional, and I don't
think we should make the whole of write_sts conditional.

Also, it would be a footgun to have a CAPS_WRITE_STS that also has an
underlying posted-write-readl() because we know only a PCI platform
uses the CAPS_WRITE_STS.

>
>> > +             /* Order the read-back before the system timestamp. */
>> > +             rmb();
>>
>> Why rmb() and not mb()?
>
> The rmb() here only has to order the NSR read before the post
> timestamp read, since by the same device rule that read can't complete
> before the MAN write has arrived.
>
>> > +     /* Record the pclk rate the MDC divider is chosen from, for
>> > +      * write_sts, which can't call clk_get_rate() under the MDIO bus
>> > +      * lock.
>> > +      */
>> > +     rate =3D clk_get_rate(bp->pclk);
>> > +     if (rate)
>> > +             WRITE_ONCE(bp->mdio_sts_rate, rate);
>>
>> Can you clarify here and in the commit message why clk_get_rate() is
>> unacceptable under the MDIO bus lock?
>>
>> Seeing your comment, my guess is an ABBA deadlock risk between
>> clk_prepare_lock and mii_bus->mdio_lock but please write it out.
>
> Your guess is right. I tried this earlier and a local Sashiko review
> found the problem:
>
> bcm_ptp_gettimex()
>   bcm_phy_write_exp_sts()
>     phy_lock_mdio_bus()
>     __mdiobus_write_sts()
>       macb_mdio_write_c22_sts()
>         macb_mdio_sts_delay()
>           clk_get_rate()
>             clk_prepare_lock()
>
> clk_summary_show()
>   clk_prepare_lock()
>   clk_summary_show_one()
>     clk_core_is_enabled()
>       en8811h_clk_is_enabled()
>         air_phy_buckpbus_reg_read()
>           phy_select_page()
>             phy_save_page()
>               phy_lock_mdio_bus()
>
> I will clarify this in the comment and commit message.

@clk maintainers: is this expected?

Recap: we must cache a clock rate in an netdev because we cannot call
clk_get_rate() in PHY ops because that risks an ABBA deadlock.

From that we get other bugs because then the cached rate is out of sync
from the real one.

It sounds like a common shortcoming that would be faced by many people?
Searching lore gives no result.

Thanks!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

