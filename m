Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785B13F54B4
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778159801; cv=none; b=IGzE67xRAADvfkvhOoCRgG5wLrMUhkbQy/nPI/Ue5+4UofbW9M7QXjh3ZFQkuOrNhsmEdllEbiikVZ4v/zPkYhClkc24L95JWhNc2YsqXw/eHy+jeg/eJ9esW3V3alVaB0x7XN5na4OiI7KZHLJPTeMn281q5HtyWeC0SLCh0Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778159801; c=relaxed/simple;
	bh=e2NO9S2CUv0l/kJNqVzdSn/oCiFZneGT+/6/s5hgRZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/vJQVVH4Q/Na9TBnxAAmu63E7dZiAQ8jE1WGRyFKUcziAlfg3xve7vjMP5nOeIYCS+wevIJgxuSAhMbYSkJ+CMxnoqUmPKQGB06Wk/T1fWpIoJTzVkPOOkxb8p1h3Thy1pQW7RRrsFzRYySf7+4yDiDzK9d0AEw0XTDE2FouYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LR3/57vo; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LR3/57vo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E5BD64E42C2E;
	Thu,  7 May 2026 13:16:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A976160495;
	Thu,  7 May 2026 13:16:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8CAC9108193CD;
	Thu,  7 May 2026 15:16:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778159797; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=XODxyG0t34liTUxM6lR0h9aJjLL9z8JcMy1OM1KkZ8M=;
	b=LR3/57vo3wtfAcr5IQ61vpLoU4u/Tr0bWWTZEBy2a0gmvY9PSTfClfGLTLXYlXJY/L9z/S
	sfD5EImCF/jCxOvEYKFXkLP4UsEJg8ijSQMCOH4ZxIZiE4xCiyF2A42soz5S9KPkxq+fdo
	gn4gH6Pv9lrKk+ABxBmTnHWDZdRcseRea1RvavSqZh+tUYwrPYCgQPaEr/4GzphrKtN7H5
	0vlap56tEL0lSiRKnHmcKQrFhd/HKdNSJEDbzLq1YXLZAgRi7eoBKYk26xprMudzXdmjzH
	UyD9JDMaiORq5GMtyGYcI9So3T5aHBnOfeXHGyBQtO6dtbJowT0a3UaYwpbnTg==
Message-ID: <a43833c5-797e-4487-87c5-a489e12e730b@bootlin.com>
Date: Thu, 7 May 2026 15:16:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] stmmac: Random DMA reset failure on RK3399 since
 v6.18
To: Jensen Huang <jensenhuang@friendlyarm.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 regressions@lists.linux.dev, netdev@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <CAMpZ1qEwNOqR-KQD4kEqd93aB-TpHnG6WdQc2tXUF0aXMmw_SA@mail.gmail.com>
 <198e2ce4-07e1-46c0-818d-1eb18645aca0@leemhuis.info>
 <CAMpZ1qGEOiPj7cApnWJnojSyEpDmXfco=No5n1VfyTCoNyCyFQ@mail.gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <CAMpZ1qGEOiPj7cApnWJnojSyEpDmXfco=No5n1VfyTCoNyCyFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 07/05/2026 14:49, Jensen Huang wrote:
> On Tue, May 5, 2026 at 4:26 PM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>> [Jumping in here, as there are no replies yet]
>>
>> BTW, Russel, just in case you missed this: looks like this regressions
>> caused by a change of yours.

I think Russell is dealing with unpleasant personal stuff, let's see if we
can figure this out while he's away.

>>
>> On 4/29/26 14:53, Jensen Huang wrote:
>>>
>>> I'm reporting a regression on RK3399 (stmmac) observed in v6.18.24.
>>> When a network cable is connected during boot, the DMA reset
>>> occasionally fails with the error message: "Failed to reset the dma".
>>>
>>> This appears to be a timing issue related to the EEE RX clock-stop
>>> logic. Based on my investigation with the RTL8211E PHY, I monitored
>>> the PHY register PS1R (MMD device 3, address 0x01) and observed a
>>> value of 0x0f40. This indicates that the PHY is in LPI mode and the RX
>>> clock may have already stopped.

From what I get, your current hypthesis is that it takes a while for that
clock to stabilize and therefore we're accessing the DMA registers too soon ?

Can you confirm that with the addition of a small delay ?

>>>
>>> While commit dd557266cf5f ("net: stmmac: block PHY RXC clock-stop")
>>
>> Just wondering: have you tried if mainline (e.g. 7.1-rc1) is still
>> affected? This is something that is always a good advisable (some people
>> would call it required). In this case even more, as it since a while
>> contains a fix for the change you mentioned, that wasn't backported:
>> c171e679ee66d7 ("net: stmmac: Disable EEE RX clock stop when VLAN is
>> enabled"). But this is not my area of expertise (and in different area
>> of the code), so that fix might be unrelated to your issue.
> 
> Thanks for the pointer.
> As you suggested, I have tested the mainline and confirmed that the
> issue is not present in v7.1-rc2, nor as early as v6.19-rc1. However,
> I verified that the issue persists in the latest stable v6.18.26.
> I performed a git bisect and the result pointed exactly to the commit
> you mentioned: c171e679ee66d7 ("net: stmmac: Disable EEE RX clock stop
> when VLAN is enabled").

Do you mean that c171e679ee66d7 ("net: stmmac: Disable EEE RX clock stop
when VLAN is enabled") introduces the bug on 6.18.26 ?

do you have the possibility of bisecting to verify when exactly the issue
was solved between v6.18 and v6.19 ?

Maxime


