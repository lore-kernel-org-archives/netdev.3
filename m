Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CD826ED40;
	Thu, 20 Aug 2026 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245930; cv=none; b=YmjtW5KgEhjIhEwZgbuGaAAfirwVlGIWPuQnDMdfO/nRoz0dqsYmuCZ1hSMFvolF6ZOvZY71BpKgS8Gq/ZEWRK6GJlbmWtkkWkBDvP+epI6SR2rlnIR4NY6JPgbuNOYBtb58Z7GDmMWzrC3TRbJkytdqgC3HoeraWZH/QA1j60Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245930; c=relaxed/simple;
	bh=LkZZNqKPnYARoGVFVcNqRhq3Tp7eGeR90UOoNntC8sE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=MFu8rd5omF3gAJ19M4H09xi/fN1CssN7a5ihTb/oL9hrYEm+QRJxx0feZGJg/rmTnTRPryvVm947zKlsN2hMzOomC7dRhib26ktiuUFBgF/UnoOCG73uoBkcGS67lsUs9HpOLu75oOUpe1le8VQB57uoayiI778JPX27zhDIul8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W6fvLtZt; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W6fvLtZt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 246864E41303;
	Thu, 20 Aug 2026 17:12:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E4B5C5FF59;
	Thu, 20 Aug 2026 17:12:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A83211C76580;
	Thu, 20 Aug 2026 19:12:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787245925; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ozXl83cbmDNf9OqSLisvtpdql9QbhkyjaRTlwJtmaHg=;
	b=W6fvLtZt71Tosi+utMV4s79KOcDO8x33uYMd+yGZ8CUtH3GPYHSyOQ87140K3AZaWdnwjp
	ktLzFgqPButobwClf1lniijo3zcjhQ5RwRSTZX3mgAnw6f89MsKOYuexq6sp2WWtzbOuey
	sdhvSosEH18V3uZRbrRw1vOIWv7i2Qf1ryidZXqP+rNAN+gwzooYe2tKEdzIr/GA7YL25U
	IQO7N/3ENVYtrBdh1dKKm6jTqne9AKvjuSVxQvC04BuEepZPPYya9BKVqSmujgexynfBx3
	81jVyShDlyoV8tvbh3JKRiJdSKiEjFYtHL4rL+cv658HXFys+aXpvWi3jKbAqA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 19:12:02 +0200
Message-Id: <DKTXSY8PDCPK.2GPXEF18NPNAB@bootlin.com>
Subject: Re: [PATCH net] net: macb: Move macb_{alloc,free}_tieoff() out of
 CONFIG_OF block
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Nicolai Buchwitz" <nb@tipi-net.de>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Nathan Chancellor" <nathan@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260818-macb-fix-no-of-build-v1-1-f2a009616384@kernel.org>
 <DKT4CBU8YB5G.2W0766H2NU6Y8@bootlin.com> <20260819185446.GA12505@ax162>
In-Reply-To: <20260819185446.GA12505@ax162>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Aug 19, 2026 at 8:54 PM CEST, Nathan Chancellor wrote:
> On Wed, Aug 19, 2026 at 08:06:48PM +0200, Th=C3=A9o Lebrun wrote:
>> On Wed Aug 19, 2026 at 3:14 AM CEST, Nathan Chancellor wrote:
>> > Commit 5262eab9462a ("net: macb: allocate tieoff descriptor once acros=
s
>> > device lifetime") moved macb_alloc_tieoff() and macb_free_tieoff() int=
o
>> > a CONFIG_OF block, breaking the build when it is disabled:
>>=20
>> That commit message is somewhat off: the commit created the two
>> functions, it didn't move them around. But indeed I was wrong in the
>
> Oh correct, I misread macb_init_tieoff() as macb_alloc_tieoff() so
> considered it a "move" but "placed" would definitely be more accurate.
>
>> location where I created them (argh I hate #if/ifdef blocks, especially
>> long ones).
>
> Yeah, I had to grep for the pairs because this one was so big.
>
>> Can reproduce using my host toolchain easily:
>>=20
>>    =E2=9F=A9 unset ARCH CROSS_COMPILE
>>    =E2=9F=A9 make mrproper
>>    =E2=9F=A9 make defconfig
>>    =E2=9F=A9 ./scripts/config -e COMMON_CLK -e MACB
>>    =E2=9F=A9 make olddefconfig
>>    =E2=9F=A9 make drivers/net/ethernet/cadence/
>>    =E2=9F=A9 echo $?
>>    2
>
> Yup, same exact reproducer I used.
>
>> Here is an alternative fix proposal: let's drop the #ifdef. It will
>> avoid any future error. Almost all drivers have no #ifdef as such:
>>=20
>> =E2=9F=A9 git grep -l MODULE_DEVICE_TABLE drivers/ | wc -l
>> 7458
>> =E2=9F=A9 git grep -l MODULE_DEVICE_TABLE drivers/ | xargs git grep -l C=
ONFIG_OF | wc -l
>> 391
>>=20
>> Yes, I know this means the match table land in the module in !OF case.
>> Almost everyone on the ML I've seen seem to consider that it's trivial.
>> Apparently it's even useful because some ACPI can match on compatible,
>> somehow.
>>=20
>> Opinions?
>
> I am always in favor of dropping #ifdefs to make it easier to avoid
> compile issues like this. If that is the route we want to go, please
> feel free to send a patch for it (or I can if you prefer).

Done. Just sent now and noticed I forgot CCing you, sorry!
https://lore.kernel.org/netdev/20260820-macb-fix-x86-v1-1-b2e7c902104e@boot=
lin.com/

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

