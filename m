Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F71318BA8
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784326363; cv=none; b=LiOZcohlTn9WqJf5Ey1cHnwj4xiTrwqol5WCu7HCPUoVccfhU0Nmy9bkJ3CTaP0hefB5RTyjJztuNlBdlwMGdkpSw1QFqaGRXAJBi6L79+DgnjuFbWDQDfP3L2L8WXigHlEqePBsXYftK6yGJnNItR1Ww6sPv839tJO13ZW7UJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784326363; c=relaxed/simple;
	bh=Vxd9lBQS9NcZ8RRMoPqkyto/i9tav/FHlcyyNZioVv0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hx44CHXzqLHYohCzUzB65zcLfh90Bp85Q2admOk8Av6uECjSep3aFcYxyxsx7epPSf4OX/m66PZuIrL+uWe7eZsCmaSd7XYEUfbClqoq1qjE5kTXCgoUsG23PKaVD2UWhs01mK3Xpl8U8AEVgO9MXKUG5rAkufESRR6otlRlN44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=c127.dev; dkim=pass (2048-bit key) header.d=c127.dev header.i=@c127.dev header.b=n7vKbX7w; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=TBviCoZ+; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=c127.dev header.i=@c127.dev header.b="n7vKbX7w";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="TBviCoZ+"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=n7vKbX7wsKVJ0B5v0jzBRrRlI+7ej3bR+Gk1Kr7yIeA6SyWCPe6du+46YZSim3rKeMEIriUlpvtRbZsYECJeBAXwJLo5ASwMw69vE8JlLuZsRXqK+livcvXC04gVcHs2l7cbZlP/1DXR2AtWxFrBVzXbEs7lrVGWoBLCJ0GX92Yx5QnipyOnIn2lCE4TREiy1pAjshyyKtHN8lSF0vCzAoWXpo8kKBsad4GRgjXKlNZUmfBLg3Vs22KOlrs6f/DA9j/b7c3zE8/9y8B7PbNJ9RUWRC+MXMKu9spkYyPAvKVkXogsRfru61Y+X3TKKb0P+EEDVj/VYHDP0ZP+80iBhw==; s=purelymail2; d=c127.dev; v=1; bh=Vxd9lBQS9NcZ8RRMoPqkyto/i9tav/FHlcyyNZioVv0=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=TBviCoZ+QIugwCe4WVL5HD05+yaW2fcJm24D06OYvEgjpHbMhYiOdWUAiQ0cwvK0L85j7J86fizeSpwEPBKyEYEWeMT9XdZHY3oBcObJjn2aJpqve4OMLKXx3EgJPxUGu3wGYpf0qhsBM1Ra1KItZSacAFpqGjVIzRJc4hjBqGJQqKMrQOwZaWgbupxTaYjP51HopIJcX5JfswE5mdx7KDCuOG6f27RKBLFl4oI5A9lvVKJxpVGZbyPaCHxQjQ7ZjaHoVnjnNkh+sXSHZ4+m+DqCp+Sal/pV17+2uXyyp3fsoOlyLhYvAAMb381Wf0z2WJhI+nUCWDTBKGWRD+olDA==; s=purelymail2; d=purelymail.com; v=1; bh=Vxd9lBQS9NcZ8RRMoPqkyto/i9tav/FHlcyyNZioVv0=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 1017243:43747:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 309829302;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 17 Jul 2026 22:12:14 +0000 (UTC)
Date: Fri, 17 Jul 2026 17:12:13 -0500
Message-ID: <db8f9fb11e7e250eab9c98eafab1ba3e@c127.dev>
From: Johan Alvarado <contact@c127.dev>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com, kuncy7@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/2] net: dsa: realtek: rtl8365mb: add SGMII support for RTL8367S
In-Reply-To: <e252cb3c-bfb2-4d62-aec7-e04b9aafe223@yahoo.com>
References: <20260711-rtl8367s-sgmii-v6-0-88f7944ddca7@c127.dev> <20260711-rtl8367s-sgmii-v6-1-88f7944ddca7@c127.dev> <e252cb3c-bfb2-4d62-aec7-e04b9aafe223@yahoo.com> <20260717125155.18915-1-kuncy7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Mieczyslaw,

On 7/16/2026 8:40 AM, Mieczyslaw Nalewaj wrote:

[...]

> For verification on real hardware:
>
> The SGMII/HSGMII link on RTL8367S (and compatible RTL8365MB-VC) can be
> intermittently unstable after cold boot, manifesting as egress stalls,
> CRC errors or complete packet loss on the SerDes-attached CPU port.
> This has been observed as a non-deterministic failure depending on the
> PLL lock state at power-on.

Where has this been observed? The RTL8365MB-VC cannot be affected:
it has no SGMII/HSGMII-capable external interface at all - its
external interfaces are MII/TMII/RMII/RGMII only, which is what the
driver's chip info table reflects.

The only cold boot observations reported against this series are
Stanis=C5=82aw's, and his results elsewhere in this thread now cover
exactly the two changes proposed here: a test image carrying both
the ~98 ms delay and the 0x060C-0x060F writes still came up with
the trunk degraded after a multi-hour power-off. What did recover
it, immediately and without a reboot, was a full re-probe of the
switch - the GPIO hardware reset plus the complete chip init -
while everything that resets only the SerDes left the bad state
in place. Whatever his unit is sensitive to after a long
power-off, it is not addressed by either proposed change, and it
lives in the full init sequence rather than in
rtl8365mb_pcs_config().

> Reverse-engineering of the vendor DW8051 firmware blob (Sgmii_Init[])
> shows that the vendor driver performs two critical steps after the
> SerDes data-path reset (BMCR DPRST_PHASE2) which were missing from the
> Linux driver:
>
> 1. A ~98 ms delay to let the SerDes PLL fully lock before any further
>    register access. The vendor firmware uses a timer interrupt to count
>    this delay; without it the analog front-end may still be settling.

The Sgmii_Init[] image shipped in the vendor's published U-Boot
sources for my board (1233 bytes, loaded into the 8051 through the
register window at 0xE000) does contain a one-shot startup wait
counted by the timer 0 interrupt: the ISR increments 16-bit tick
counters in the 8051's XDATA RAM, and the main flow busy-waits
until one of them reaches 98 (0x62), then latches a flag so the
wait never runs again.

But it sits on the other side of the data-path reset from where
your patch places it. The first thing the image does once the wait
expires is call the routine that performs the SerDes bring-up: the
un-reset (0x7106 to SerDes register 3 through the indirect access
registers), then the BMCR writes 0x1401 and 0x1403 - the same
data-path reset sequence Luiz described during the v2 review, which
pcs_config() already implements. Nothing in the image waits after
the BMCR writes. The wait is the firmware pacing its own startup
before it first touches the SerDes, which makes sense for an
autonomous microcontroller that the loader releases in the middle
of the bring-up; it is not a post-reset PLL lock delay.

> 2. Writing a "Local Jam Table" calibration vector to internal ASIC
>    registers 0x060C-0x060F (values 0x83, 0xAA, 0x7E, 0x80). These
>    registers configure the SerDes analog equalizer and DC-offset and
>    are not exposed through the normal SDS_INDACS window. Omitting them
>    leaves the analog front-end in an uncalibrated state.

Nothing in the image supports this:

- No instruction in the image addresses 0x060C-0x060F, by any
  addressing form: immediate DPTR load, split DPH/DPL load, or the
  register-pair arguments the image passes to its write helpers.

- The only XDATA accesses in that neighborhood are the image's own
  tick counters and flags at 0x0624-0x062C - the ones its timer ISR
  increments. That is plain 8051 work RAM, not switch registers.

- The byte sequence 0x83 0xAA 0x7E 0x80 occurs nowhere in the image
  as data, in either order. 0xAA and 0x7E appear only as immediate
  operands of register loads, and 0x83/0x80 only as bytes of the
  instruction stream. A reading of the byte stream that slips out
  of alignment with instruction boundaries could produce exactly
  such a list.

- In the switch register space - which is what your proposed
  regmap_write()s would actually hit - the vendor register headers
  name 0x060C-0x060F as the ACL rule template 3 control registers.
  The patch as posted would clobber an ACL template with values
  that mean nothing there, and would not touch the SerDes.

For the record, on my RTL8367S hardware running exactly this code,
the HSGMII trunk has been up for over a week carrying several
hundred gigabytes with zero CRC/FCS/symbol errors on every port,
and cold boots throughout the development of this series never
produced the instability described above.

So I don't think either change is supportable: the sleep is placed
where the firmware has none, the register writes target unrelated
ACL registers, and both have now been tested together on the
affected unit without improvement. For the same reasons I don't
expect a re-run of the cold-soak test with only these two changes
to tell us anything: the writes cannot reach the SerDes, and the
delay exists in the firmware only as a one-shot wait before the
data-path reset the driver already performs. Stanis=C5=82aw's unit
reproduces the bad state reliably, which makes it a good bench for
instrumenting the early init path; that investigation is follow-up
material rather than part of this series.

Best regards,
Johan
