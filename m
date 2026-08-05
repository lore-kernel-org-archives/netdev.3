Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B175A38D3FC
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941588; cv=none; b=mZY12YWll4x/b8gE+f2KNejy7Eo6dLFYHu6XmK0o74cZa0t2skAaX8MuS/FFOmhthnYRUlfyvULlAaqP33P8+JWojKgGuCm8/LL4B2xoWRyQvWYi7qAdZP1xv66jIczFRdIjW02ZQoN9/LjaHCi85covnVrHGfuunzmVQc78Bjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941588; c=relaxed/simple;
	bh=6Uk2CPQFOlQ4zxuCFjqqRVW6bVjH4SD7I00XnaNVdTA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=IzcZFj2U+4cJxSpLjp73BcLS3i1224PoBTLmm68+ZcVnpW50MgLr/2/rZszsCd0lw2GLyb2PJ7db55V5gcUJ7HOv1qQj5SAxfgle6AehweoHWjAr6DPBNYkmnisBRabro15CYLy24N/OnUGirZyJQemsrWtYhmCLkyaA66sfdI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZVsaM9pM; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZVsaM9pM"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3D6584E410F4;
	Wed,  5 Aug 2026 14:53:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E9B14602AB;
	Wed,  5 Aug 2026 14:53:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A0D3611C34CFC;
	Wed,  5 Aug 2026 16:52:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785941578; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/XDUnY34MjWDI0SvA9lizBS44ufpwp1f+wUO7qQlRjU=;
	b=ZVsaM9pM/ovBXL8X3CdjN8SUVmykIYJHxkuUOAKkFJf+nLGEAobig5e8Z1LOauGRYi9BIf
	vV9O4g5FqpzCostyirCjpQJ+vWTxlz0WZL26ZQaHv8F/miplU6be+R/GfrF/Po1T+3L+JU
	KzLofPhUc3UhP0aK5wz3qqvj0eaq4D7lgu1PBYH7gXjf6WQIDMT5WxvvQ443tCbQFMGYcp
	cusGOlLqD4oO3ikxAfQNHXuaSW/PEArog16FbU+7CgeB/DJcXu1Mr3qv1flCpLLRT/yPOK
	msp3EQVLo2uwprr4UElMSN/cGNH+bUhI6aM9gGDmpPorz/iJcpI1lTwLtN16Cg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 16:52:55 +0200
Message-Id: <DKH3G9J1MI8G.24Q6WY2SU93I9@bootlin.com>
To: "Polak, Leszek" <LPolak@arri.de>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH] net: macb: fix stale data returned by MDIO reads
Cc: "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <PA1PR03MB11059B8723E1C212E5801A52DC8D32@PA1PR03MB11059.eurprd03.prod.outlook.com> <DKH3AOWRPUDD.1IOVFERUUNC1J@bootlin.com>
In-Reply-To: <DKH3AOWRPUDD.1IOVFERUUNC1J@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Th=C3=A9o,

On Wed Aug 5, 2026 at 4:45 PM CEST, Th=C3=A9o Lebrun wrote:
> Hello Leszek,
>
> Your subject is missing the [PATCH net] prefix.
>
> On Wed Aug 5, 2026 at 2:01 PM CEST, Polak, Leszek wrote:
>> macb_mdio_wait_for_idle() samples NSR.IDLE with no delay after MAN has b=
een
>> written. readx_poll_timeout() expands to read_poll_timeout() with
>> sleep_before_read =3D false, so the very first NSR read is issued immedi=
ately
>> after the register write.
>>
>> The controller does not deassert NSR.IDLE until its MDIO state machine
>> actually begins the frame, which takes up to one MDC period. Neither
>> macb_mdc_clk_div() nor gem_mdc_clk_div() ever selects an MDC above 2.5 M=
Hz,
>> so one period is up to ~400 ns - on the order of a hundred pclk cycles, =
and
>> far longer than a back-to-back register access. The poll therefore obser=
ves
>> IDLE still set from the *previous* operation and returns success before =
the
>> operation just issued has started.
>
> You (or rather the LLM) say that with confidence. How do you know about
> this MDIO state machine implying some delay inbetween the MAN writel
> (which triggers a MDIO management frame) and the time at which NSR.IDLE
> starts becoming 0?
>
> The doc doesn't mention anything of the sort. It explicitely mentions
> NSR.IDLE as being there to signal for completion.
>
> Also it sounds like a massive bug, wouldn't others have discovered it
> before? Just checked and nothing out of the ordinary on EyeQ (first NSR
> is always 0x2 after writel to MAN). Patch at the end, which should
> trigger error logs on your system from what I understood. Please report
> back on that.
>
>> The caller then reads a MAN DATA field that still holds the result of
>> whatever completed before, so every read returns the data of the previou=
sly
>> accessed register. For clause 45 the race occurs three times per access:=
 the
>> address operation is still in flight when the read operation is written,=
 and
>> the final MACB_BFEXT(DATA, macb_readl(bp, MAN)) picks up a stale value.
>>
>> Observed on a Versal board with a Marvell 88Q1111 on GEM1, where reading=
 each
>> MMD register twice showed the first read returning the preceding registe=
r's
>> value:
>>
>>   31.8002: 0x0149 then 0x002b   (0x0149 is 31.8001)
>>   31.8004: 0x0b21 then 0x1401   (0x0b21 is 31.8003)
>>   31.8011: 0x400e then 0x6000   (0x400e is 31.8010)
>>   31.8010: 0x6000 then 0x400e   (0x6000 is 31.8011)
>
> I don't understand those logs? Can you provide the code that generated
> them and more context? You probably faced some terrible bugs if all
> MDIO reads returned the value from the previous read.
>
>> The lag persists across callers and across driver entry points, so it is=
 a
>> property of the controller path rather than of any PHY driver. It silent=
ly
>> corrupts every MMD read. Latch-high, clear-on-read registers are worse t=
han
>> corrupted: their content cannot be recovered by retrying, because the fi=
rst
>> read still reaches the PHY and clears the latch.
>>
>> Sleep before the first NSR sample so that an operation issued immediatel=
y
>> beforehand is guaranteed to be underway. The pre-operation bus-free chec=
k
>> pays the same delay, which is immaterial - a single MDIO frame takes ove=
r
>> 25 us at 2.5 MHz MDC, so this is well under the cost of the transfer its=
elf.
>>
>> Assisted-by: Claude:claude-opus-5
>> Signed-off-by: Polak, Leszek <LPolak@arri.de>
>
> If this bug gets confirmed it needs (1) to go into net and
> (2) have `Cc: stable...` and `Fixes: ...` trailers.
>
> Docs on (1) are
> Documentation/process/maintainer-netdev.rst
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> Docs on (2) are
> sources are in: Documentation/process/stable-kernel-rules.rst
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 20 ++++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -340,10 +340,26 @@ static void macb_get_hwaddr(struct macb *bp)
>> =20
>>  static int macb_mdio_wait_for_idle(struct macb *bp)
>>  {
>> +	/*
>> +	 * NSR.IDLE is not deasserted until the MDIO state machine begins the
>> +	 * frame, which takes up to one MDC period after MAN is written. MDC i=
s
>> +	 * never clocked above 2.5 MHz, so one period is at most ~400 ns; allo=
w
>> +	 * an order of magnitude of margin. read_poll_timeout() sleeps at leas=
t
>> +	 * (sleep_us >> 2) + 1 us, so the guaranteed minimum here is 6 us.
>> +	 */
>> +	const unsigned int start_delay_us =3D 20;
>>  	u32 val;
>> =20
>> -	return readx_poll_timeout(MACB_READ_NSR, bp, val, val & MACB_BIT(IDLE)=
,
>> -				  1, MACB_MDIO_TIMEOUT);
>> +	/*
>> +	 * Do not sample NSR.IDLE immediately. When this is called straight
>> +	 * after a MAN write, IDLE is still set from the previous operation,
>> +	 * so the poll would return at once and the caller would go on to read
>> +	 * a MAN DATA field that still holds the previous transaction's
>> +	 * result. Sleeping first guarantees the new operation has started and
>> +	 * IDLE has gone low before it is sampled.
>> +	 */
>> +	return read_poll_timeout(MACB_READ_NSR, val, val & MACB_BIT(IDLE),
>> +				 start_delay_us, MACB_MDIO_TIMEOUT, true, bp);
>>  }
>
> Your code is not just adding a 20=C2=B5s start delay, it changes all dela=
ys
> from 1=C2=B5s to 20=C2=B5s. I don't think we want that.
> Before: readl(NSR) -> usleep(1) ->  readl(NSR) -> usleep(1)  -> ...
> After:  usleep(20) -> readl(NSR) -> usleep(20) -> readl(NSR) -> ...
>
> Your introduced variable start_delay_us is not needed.
>
> There are way too many comment lines. Your LLM hasn't read enough kernel
> code! Rare comments, mostly terse. Commit messages can be relied upon.
>
> ---
>
> pr_err() should trigger on your system from what I understood.
> Can you confirm?
>
> [...]

Oops this test triggers on the pre-check macb_mdio_wait_for_idle() calls.
Instead this:



diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/etherne=
t/cadence/macb_main.c
index d58430fe9c41..98e0cafb0de1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -308,6 +308,20 @@ static int macb_mdio_wait_for_idle(struct macb *bp)
              1, MACB_MDIO_TIMEOUT);
 }

+static int macb_mdio_wait_for_idle_busy(struct macb *bp)
+{
+  u32 val;
+
+  val =3D macb_readl(bp, NSR);
+  if (val & MACB_BIT(IDLE)) {
+     pr_err("PHY IDLE after writel(MAN): NSR %#x MAN %#x\n",
+            val, macb_readl(bp, MAN));
+     fsleep(20);
+  }
+
+  return macb_mdio_wait_for_idle(bp);
+}
+
 static int macb_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)
 {
   struct macb *bp =3D bus->priv;
@@ -327,7 +341,7 @@ static int macb_mdio_read_c22(struct mii_bus *bus, int =
mii_id, int regnum)
               | MACB_BF(REGA, regnum)
               | MACB_BF(CODE, MACB_MAN_C22_CODE)));

-  status =3D macb_mdio_wait_for_idle(bp);
+  status =3D macb_mdio_wait_for_idle_busy(bp);
   if (status < 0)
      goto mdio_read_exit;

@@ -362,7 +376,7 @@ static int macb_mdio_read_c45(struct mii_bus *bus, int =
mii_id, int devad,
               | MACB_BF(DATA, regnum & 0xFFFF)
               | MACB_BF(CODE, MACB_MAN_C45_CODE)));

-  status =3D macb_mdio_wait_for_idle(bp);
+  status =3D macb_mdio_wait_for_idle_busy(bp);
   if (status < 0)
      goto mdio_read_exit;

@@ -372,7 +386,7 @@ static int macb_mdio_read_c45(struct mii_bus *bus, int =
mii_id, int devad,
               | MACB_BF(REGA, devad & 0x1F)
               | MACB_BF(CODE, MACB_MAN_C45_CODE)));

-  status =3D macb_mdio_wait_for_idle(bp);
+  status =3D macb_mdio_wait_for_idle_busy(bp);
   if (status < 0)
      goto mdio_read_exit;

@@ -405,7 +419,7 @@ static int macb_mdio_write_c22(struct mii_bus *bus, int=
 mii_id, int regnum,
               | MACB_BF(CODE, MACB_MAN_C22_CODE)
               | MACB_BF(DATA, value)));

-  status =3D macb_mdio_wait_for_idle(bp);
+  status =3D macb_mdio_wait_for_idle_busy(bp);
   if (status < 0)
      goto mdio_write_exit;

@@ -439,7 +453,7 @@ static int macb_mdio_write_c45(struct mii_bus *bus, int=
 mii_id,
               | MACB_BF(DATA, regnum & 0xFFFF)
               | MACB_BF(CODE, MACB_MAN_C45_CODE)));

-  status =3D macb_mdio_wait_for_idle(bp);
+  status =3D macb_mdio_wait_for_idle_busy(bp);
   if (status < 0)
      goto mdio_write_exit;

@@ -450,7 +464,7 @@ static int macb_mdio_write_c45(struct mii_bus *bus, int=
 mii_id,
               | MACB_BF(CODE, MACB_MAN_C45_CODE)
               | MACB_BF(DATA, value)));

-  status =3D macb_mdio_wait_for_idle(bp);
+  status =3D macb_mdio_wait_for_idle_busy(bp);
   if (status < 0)
      goto mdio_write_exit;




Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

