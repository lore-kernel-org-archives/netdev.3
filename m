Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E61853C3C3;
	Fri, 16 Oct 2026 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792173128; cv=none; b=H/6XLfnY8WqZe21r1v8SJqjrvShJ5LjM3kB3me6FRMyrj2oFvYZ3WEmIsFPHYQs9QEwyNbpwCyYlJeVJYwBQ7QeYweK5FVuxkpWGaMKQ0Z9U/LtKQFKGTQRAUpkPMwcDLHiScoE+V0AEMlpDlleM6Qon17TLwnu+/u+kw5rNF9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792173128; c=relaxed/simple;
	bh=tK1YN+Fh9b0lBn+/8UqG5ACOJVrDCkyGt9HbCHrESWE=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:Mime-Version:
	 References:In-Reply-To; b=ehxSYpIGSgfJuwdEVPhCyYASYVXciTmAF/xtEnxlbYX6em1c824Dm/dF1NayvOdJ92yB2z0lMSopBCoOCebJ14vXXR6QTMMjHc7idaTY3wcbLqpWJWbxq9WMC10adUkfLOJqmjuCdAyAx6rtvfDsqPrMgDkU1Iwv219nPdi3Wf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KPS6iVjZ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KPS6iVjZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 31F7E4E41267;
	Fri, 16 Oct 2026 17:52:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 00D646075D;
	Fri, 16 Oct 2026 17:52:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A24A10328113;
	Fri, 16 Oct 2026 19:51:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792173122; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=U9uSiGt4uJkpjhdkUKra6Rle/jxiKYirZB4avFehm+o=;
	b=KPS6iVjZz4167uZNYN5hEgFbcURIHVTZsiNjOiovhmKiuh4937JMNWxPkzyf1C7sXjhIrm
	Pn5nG4tDTMkJIwQ/uoFUJR4TG0lJez9KpKBXStRi5HxvUoDOZysm/mDE8RPjXwFGWJ2oAR
	cSlDCC/wOajsTHL3xUQtrz4z/yW9RVxryQeAvNG7d7lRVYlLBEINJkne0Om49ofbYR/Fio
	bl2adZSBA2Dohjwm96Km5+//ysMSX7grnafIwGODfLXZUxyMN51Q6rsHaUPavJRYiGu/jg
	wAijSgsFOEPu1Ek3HFtkKVEYgvmZx3v64bcZRCWMw628X2cmub6hiY7jx47Lnw==
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 19:51:54 +0200
Message-Id: <DM6GCIT1KQXJ.2174FA0BOBXSG@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261009143506.2507607-1-jjc@jclark.com>
 <20261009143506.2507607-5-jjc@jclark.com>
 <DM1WEUIF8V8V.2OZWRB5G232T4@bootlin.com>
 <CANz3_EamUFhoQJ54g9pxdrxGK9EYxu_KeqRTdAdxWzV15k4_9w@mail.gmail.com>
 <DM5J6J74NCTY.1IDZXHZM276JS@bootlin.com>
 <CANz3_EZ7SZau+xL8CaaNAHMvMia+_t1oVGiA-aksPCDUWkadHg@mail.gmail.com>
In-Reply-To: <CANz3_EZ7SZau+xL8CaaNAHMvMia+_t1oVGiA-aksPCDUWkadHg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Oct 16, 2026 at 6:36 AM CEST, James Clark wrote:
> On Thu, Oct 15, 2026 at 10:52=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bo=
otlin.com> wrote:
>> >> > +     if (sts) {
>> >> > +             delay_ns =3D macb_mdio_sts_delay(bp);
>> >> > +             local_irq_save(flags);
>> >> > +             ptp_read_system_prets(sts);
>> >> > +             /* macb_writel() is relaxed; order it after the times=
tamp. */
>> >> > +             mb();
>> >> > +     }
>> >> > +     macb_writel(bp, MAN, cmd);
>> >> > +     if (sts) {
>> >> > +             /* Flush the posted write before taking the upper bou=
nd. */
>> >> > +             macb_readl(bp, NSR);
>> >>
>> >> An unconditional readl for flushing the posted write won't do it.
>> >> MACB is over PCI only on very few platforms. I guess the straightforw=
ard
>> >> solution is a POSTED_WRITES flag that is then read from here.
>> >
>> > This is only under sts.  Assuming write_sts becomes RP1 only, then it
>> > is only over PCIe. I am not sure if I have understood what you are
>> > getting at here.
>>
>> On any platform but RP1, such a readl() is useless. My remark was that
>> the readl()-for-posted-writes must be made conditional, and I don't
>> think we should make the whole of write_sts conditional.
>
> I may be missing something, but I don't think the read-back is
> specific to PCIe. device-io.rst says that on many platforms and buses
> writes through ioremap() are posted, so the CPU doesn't wait for the
> write to reach the device, and it gives a dummy read as the way to
> wait for it that works on all platforms. On arm64 the mapping is
> Device-nGnRE, where the E means an intermediate point in the fabric
> may acknowledge the write before it reaches the MAC. The unimac patch
> in this series does the same read-back, on an on-chip controller.

Well today I learnt about 'Early Write Acknowledgement' on ARM, which
indeed is the default on ARM64 ioremap() mappings. I've only ever seen
readl() to flush posted writes on PCI busses, never on platform
devices. Thanks!

https://support.arm.com/documentation/102376/0200/Device-memory/Sub-types-o=
f-Device

But then I'm curious: what timing would we prefer? Here adding a readl
means we measure an upper bound. If we dropped it, we would lose that
upper bound but we might get a more accurate measurement (by guessing
that if the request is in the write buffer of the interconnect, it will
soon reach the peripheral). After all a MMIO register read is pretty
slow and might be in the range of an MDC period.

Could that explain why you landed on 63.5 MDC periods delay instead of a
round 64 periods? Could that be compensation for the overhead MMIO
register read?

Just guessing here; no strong opinions.

Another random idea: could we grab a non-posted mapping using
ioremap_np() and then only use that for your usecase? An LLM tells me
only dwc3 acquires both mappings. They use the NP one for the xHCI
registers on some platforms. So we'd be the first to grab both and use
one for a specific register to get non-posted behavior; this is
probably a sign this idea is a bad one.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

