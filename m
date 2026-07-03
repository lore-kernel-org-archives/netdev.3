Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1906737E2F9
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073444; cv=none; b=ccNe2PIyblIzUgMy/A5SLjvZLaTbuzwJ80ACfBKaHMJY799BFfP32FVjZ/waJi+MNHXaTBme/a5tKrI2AG+6BwpytD804oM2rSWgnk180vpuR62YmCMy5Z+4BlRjosimc0IQc7BDTEp9TvzX36tlReBTfibeDOKd/9Xl9ii9lHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073444; c=relaxed/simple;
	bh=KUxpJqYYa0VhNofPWE55WEfT0pzSsC+tc3Iw1yJfJ80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cgalOGqzCGKPhRoVCRyHsEU5fu9btq6lQjbp01IAqDV4LJ2ppOONGVd5unruShzenVimrxwT11TAtEbCfnxbCFyOvirK5wbivl/uYrkGRzXnlrFtzNwlPYO8alJ+kE1lpTpyXmTogq5xcEd0ppTTt0kC4F+4X8k4+HLuq08IBoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HKxugvqm; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HKxugvqm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 30A8BC79ABE;
	Fri,  3 Jul 2026 10:10:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 50ABA60300;
	Fri,  3 Jul 2026 10:10:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EAB20104C8399;
	Fri,  3 Jul 2026 12:10:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783073438; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KUxpJqYYa0VhNofPWE55WEfT0pzSsC+tc3Iw1yJfJ80=;
	b=HKxugvqmlXpYp00MdUMi8LdjB/ut+8I3zFW6xoA9fpxouy34H7l4QeEH1BXYeBOE7FxOE9
	NjQNxmrt6ulvJwxDl30gHKLWJVYbXabaScEloreVGrP+rikqz0/W84cCWMSgkEV6pEPH35
	YSkiOVtvZQmbC5WBMXXMIgbrS71E0PZqMzeP+NCrWcFcX93tadIRVjAQ8A9tfIXM1jxKaI
	SuX6hqE52+3qO6W2bu5QjqYnXPsI0GwvUwtlbNS6AaqWB2b7Uy3ZgKjnQYUoT9jbq9quM1
	lf/0rDB21QVeASXPQ/PTNk8FNmD5by4w2OLHa48KLXakvZE970v99pA5YSpuJg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Manikandan.M@microchip.com,  krzk@kernel.org,  pratyush@kernel.org,
  mwalle@kernel.org,  takahiro.kuwano@infineon.com,  richard@nod.at,
  vigneshr@ti.com,  krzk+dt@kernel.org,  conor+dt@kernel.org,
  srini@kernel.org,  Nicolas.Ferre@microchip.com,
  alexandre.belloni@bootlin.com,  claudiu.beznea@tuxon.dev,
  linux@armlinux.org.uk,  richardcochran@gmail.com,  linusw@kernel.org,
  arnd@arndb.de,  michael@walle.cc,  linux-mtd@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/7] dt-bindings: mtd: jedec,spi-nor: allow the SFDP
 to be exposed via NVMEM
In-Reply-To: <20260702163723.GA227454-robh@kernel.org> (Rob Herring's message
	of "Thu, 2 Jul 2026 11:37:23 -0500")
References: <20260630092406.150587-1-manikandan.m@microchip.com>
	<20260630092406.150587-2-manikandan.m@microchip.com>
	<20260702-utopian-termite-of-perfection-f1f3ec@quoll>
	<860213fd-6a4b-42d4-a8f7-7308e070f09e@microchip.com>
	<20260702163723.GA227454-robh@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 03 Jul 2026 12:10:32 +0200
Message-ID: <8733y0penb.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 02/07/2026 at 11:37:23 -05, Rob Herring <robh@kernel.org> wrote:

> On Thu, Jul 02, 2026 at 06:55:15AM +0000, Manikandan.M@microchip.com wrot=
e:
>> Hi Krzysztof,
>>=20
>> On 7/2/26 11:46 AM, Krzysztof Kozlowski wrote:
>> > EXTERNAL EMAIL: Do not click links or open attachments unless you know=
 the content is safe
>> >=20
>> > On Tue, Jun 30, 2026 at 02:54:00PM +0530, Manikandan Muralidharan wrot=
e:
>> >> Add an optional "sfdp" child node (compatible "jedec,sfdp") that
>> >> describes the SFDP as a read-only NVMEM provider via nvmem.yaml, so i=
ts
>> >=20
>> > What is SFDP?
>> >=20
>> SFDP is the Serial Flash Discoverable Parameters -- a JEDEC-standardised
>> (JESD216) read-only parameter table present in most SPI NOR flashes, the=
=20
>> table contents provide basic information about the flash. There are=20
>> standard tables which are specified by the JEDEC standard and there are=
=20
>> vendor tables.
>
> Is SFDP present or not discoverable? Or we have a table of discoverable=20
> parameters that itself is not discoverable.

SFDP is almost always there. I don't think there are any non SFDP chips
manufactured today (?). The thing is, even if we don't need to define it
in DT, we might need to point to it in order to extract eg. a unique ID
or a MAC address through the NVMEM interface.

SFDP is split into several sub-tables, the first one is mandatory, but
then there are optional tables which can be discovered dynamically.

Thanks,
Miqu=C3=A8l
