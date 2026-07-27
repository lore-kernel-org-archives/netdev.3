Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7D3FE347;
	Mon, 27 Jul 2026 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153967; cv=none; b=OyNZpsjccnij/wb266Vnj48XSRE5nKJV7clAeRR9O1aSnAMw3W/i3Tz94GfuiG/fqs4QZPhfDBbkh6/7kOfmNwNPUUianKwKC+KnQ5Io4JcD4CfX07poVCbSNrG5larUHMAdctT7AYSvUizIilETGcI7NWiyJiZmd/iPvuqoWYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153967; c=relaxed/simple;
	bh=jRobJtRFH5HCZ9TtwhoS6DRuDm2cmUrOz297VkRjW54=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=TRFfyRUHCxGPNOVng/3+0iT9VS3B2VFqwPu/N+QNnCXs3OrmiLSqqmNgZ3jBdpoju7S6eWJzAjWQHhQmBGkbeGwd16jhQXtFgE/LqwKURZiXvXFAm7g2kJGntR23hjiQmco8++Y60VU0wpUDNS4yAzrn+HDtuKCo8ULyZ2a66KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wxMAlDOa; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wxMAlDOa"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 884444E40F95;
	Mon, 27 Jul 2026 12:06:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2FD85601BE;
	Mon, 27 Jul 2026 12:06:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1472411C132DC;
	Mon, 27 Jul 2026 14:05:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785153957; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4f2HPMWV0g54PHZEpGGRxR3vpUvKT100LBPJF0lBZGo=;
	b=wxMAlDOag/1i9nycBn6eH8M6KCjDu2nCy4iWwNxR7vAsXzLYypfjhSVLp09RPEDP+Se8c6
	hlLCrZsZPtz127UObJbYcIl/WeLBhQTODT18C544prE7JyoEKXPdqxVPRRYig2HsNDzF00
	rVyaeXFtXaXrYGA2misSgx5ZN6byGT/7MtD5b+8F3tllgXdU2SHp611K3my/UnUMyMAdgH
	pGSeeYp/U0hPdZFUNgGFzO1zWSrhdHgxNs54Eg1YKsRpGD51WcxPaRm/dVEoAulr6ZfRyc
	jKTTahwyVyuIpcG1+nM1LBUBmqu83Qlxs7neUIyv5Hh70KDuF13n6O/nl8SAtQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 14:05:53 +0200
Message-Id: <DK9C9GO25PN0.2LNMTZAHHUNF8@bootlin.com>
Cc: <git@amd.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Karumanchi, Vineeth" <vineeth@amd.com>, "Vineeth Karumanchi"
 <vineeth.karumanchi@amd.com>, <conor.dooley@microchip.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 2/2] net: macb: configure ENST registers for
 all queues
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260724043257.2221030-1-vineeth.karumanchi@amd.com>
 <20260724043257.2221030-3-vineeth.karumanchi@amd.com>
 <DK701YU8OWST.2CDXDR5SUJYJQ@bootlin.com>
 <3924babc-9755-46ce-97b2-bd6dfce6f6c6@amd.com>
In-Reply-To: <3924babc-9755-46ce-97b2-bd6dfce6f6c6@amd.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Jul 27, 2026 at 7:32 AM CEST, Karumanchi, Vineeth wrote:
> On 7/24/2026 11:36 PM, Th=C3=A9o Lebrun wrote:
>> On Fri Jul 24, 2026 at 6:32 AM CEST, Vineeth Karumanchi wrote:
>>> The initial "tc" command was not overwriting the reset value of ENST
>>> registers if only a subset of queues were configured, leading to an
>>> invalid setup. To fix this, configure all queues unconditionally.
>>> Unconfigured queues are zero-initialized via kcalloc(), ensuring a
>>> complete and consistent configuration.
>> But if a subset of queues are configured, the remaining queues don't
>> have their ENST support enabled thanks to ENST_CONTROL and their ENST
>> per-queue register values aren't read? Or HW is broken and reads ENST
>> registers anyway? Or something else I misunderstood?
>>
>> What reset value of ENST regs you observed that caused you trouble?
>> That info could make it into the commit message.
> //
> Yes, this is a confirmed hardware issue. We raised it with Cadence, and=
=20
> they have
> acknowledged the problem. The reset value of the |enst_on_time_qX|=20
> registers is *0x0001FFFF*.

ACK. 0x1FFFF translates to the max value of on_time. Important also to
note that off_time reset value is 0x0 according to the manual. This
combination probably explains why queues feel free to emit whenever
they want.

> During ENST initialization, packet interleaving was observed when only a
> subset of the available queues was configured, while the remaining=20
> queues=E2=80=94whose
> corresponding |enst_on_time_qX| registers still contained non-zero=20
> values=E2=80=94were left disabled in |ENST_CONTROL|.
>
> For example, in a configuration where only two of the four queues are=20
> enabled,
> some packets from *Q0*=C2=A0getting transmitted during the *Q1* time slot=
,=20
> and vice versa.

This description isn't enough to fully show there is a bug.
 - You say "only two of the four queues are enabled" but did you mean
   "queue enabled" or "EnST is enabled on that queue"?
 - EnST enabled doesn't mean the timeslots don't overlap, this is one
   allowed config.

Maybe it's not a bug? What behavior would you expect when EnST is
enabled on some queues only? When should queues without EnST active
transmit their frames?

Please be exhaustive in your future commit message; thanks!

> Furthermore, once the hardware enters this state, it does not recover=20
> even after a
> complete ENST queue reconfiguration is performed.

---

As you contribute to EnST support, you might be interested in a bug I
just noticed in the enst_ns_to_hw_units() implementation. It doesn't do
rounding properly.

Eg ns=3D100 speed_mbps=3D100 =3D> 2 units of time but that is 2*80ns=3D160n=
s,
whereas one unit of time (80ns) would have been a better choice. This
example is the worst case scenario (the closer we are to 1 unit of
time, the worst the bug is).

---

PS: please note your email formatting is off because of hard wrapping.
It's well visible on lore. Email is still readable but less than optimal.

https://lore.kernel.org/netdev/3924babc-9755-46ce-97b2-bd6dfce6f6c6@amd.com=
/

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

