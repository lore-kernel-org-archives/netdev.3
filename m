Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C074A6CD3;
	Wed, 14 Oct 2026 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967135; cv=none; b=lqRkjvttsA4oviWpJZpAiNNUioUxe9nrhIqOfXmrn9jVhKUwJ2k2jXOdps+w3zb9nccpkA89/ORmYzb7lPs34XDKw7UrD69uJ8jsiqM0YeFnIKTD89QdOBCSP+9L33QHIriWSVou02/bD2PDX+oj5aufKdMiqShc+1y6L/g5dzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967135; c=relaxed/simple;
	bh=ngJFCKHqbgCLyG9vhboqwQUYeRLMtMl0aG5g/OQVWlc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y6s/Lw6j5yvs6WqnwzT4z5J6ASMpuOYsZnh2yam8KNHfUtyv6pxC+8SbE52LYYU+YoEi3/VVnzC/q6utWFNPGrmZ5cDB2xQicYPqpek8Gu1zucB/N8Bu2kvk02WOVt1UPKxl5R/TUPC8kUcOP+v6+lrK4ZpOYnMjU0cmwC+i7ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mq2Xp10g; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mq2Xp10g"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DB82B4E41206;
	Wed, 14 Oct 2026 08:38:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9323D60368;
	Wed, 14 Oct 2026 08:38:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4D675103286A7;
	Wed, 14 Oct 2026 10:38:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791967128; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ngJFCKHqbgCLyG9vhboqwQUYeRLMtMl0aG5g/OQVWlc=;
	b=mq2Xp10guRPwOdzd5i29FPKBO3X5MoRrIDnynu+OM/FCaB5zvzCaTUpQoKiQNkWiJBd1P4
	RcIpGp8oUqiBVqGBcBchPS8i8MsOXMOju1szusJtZev+cdUICiyy1pMMwlD4aHLI9/yWVB
	12lNzP6dgKerzIA9QGtkL4HgipGMFlZIc7aeZOdLyZHqqfYDMk8Vr2w3+iNzvySIGpPexz
	z73yYP6RfNokqHlpefpHcIX/X5aLu+ceWfhnv0vWpEsXGbWeXoqb+uMUH0HU4mzObgcoIX
	hLZGbyZoZbB9Oc13tOMNwnmWYFBkgUxWv8kpUkc0QThocKv1ia7Fk3Df69msIA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <robh@kernel.org>,  <krzk+dt@kernel.org>,  <conor+dt@kernel.org>,
  <srini@kernel.org>,  <nicolas.ferre@microchip.com>,
  <alexandre.belloni@bootlin.com>,  <claudiu.beznea@tuxon.dev>,
  <linux@armlinux.org.uk>,  <richardcochran@gmail.com>,
  <linusw@kernel.org>,  <arnd@arndb.de>,  <aaro.koskinen@iki.fi>,
  <gregkh@linuxfoundation.org>,  <mathieu.dubois-briand@bootlin.com>,
  <michael@walle.cc>,  <linux-mtd@lists.infradead.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-arm-kernel@lists.infradead.org>,  <netdev@vger.kernel.org>
Subject: Re: [PATCH v8 4/8] mtd: spi-nor: sfdp: expose the SFDP as a
 read-only NVMEM device
In-Reply-To: <093672d183a06dc2f37366b2f9ff144316850863.1790847519.git.manikandan.m@microchip.com>
	(Manikandan Muralidharan's message of "Wed, 14 Oct 2026 12:10:08
	+0530")
References: <cover.1790847519.git.manikandan.m@microchip.com>
	<093672d183a06dc2f37366b2f9ff144316850863.1790847519.git.manikandan.m@microchip.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 14 Oct 2026 10:38:42 +0200
Message-ID: <87ld80znfx.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 14/10/2026 at 12:10:08 +0530, Manikandan Muralidharan <manikandan.m@microchip.com> wrote:

> The SPI NOR core already reads the SFDP tables during enumeration and
> caches them in nor->sfdp->dwords (see spi_nor_parse_sfdp()). Re-expose
> that cached data as a read-only NVMEM device, in on-flash byte order,
> rooted at the flash's SFDP child node (compatible "jedec,sfdp").
>
> This lets NVMEM cells reference any SFDP data: a fixed-layout for
> parameters at a known offset, or an nvmem-layout parser for vendor data
> whose location must be discovered at runtime. The device is only registered
> when an "sfdp" node is present in the device tree.
>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
