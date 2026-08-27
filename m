Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6743630B2;
	Thu, 27 Aug 2026 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787861804; cv=none; b=SPKZ/UE3juwQUeo9lwQ+cAYENPnxF1kdFPBJQhd47+D2V+czqhs4GhkAjXpwoWDGL4mZecW6IQqEjW2mWSrRDI5vQm6EQyNXeMjpjWCuEjrIOtBE0TUXNWxaY1LudvRoexPbgRJlOGTUlYv7rPtraUXESy49C+Xshl1SxEkhvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787861804; c=relaxed/simple;
	bh=kwbJKyZrRfhMTDlljypAkqi60NYLc6Rz1UeTmU4FN6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LfrM3+i1RMk9EGwSvTd30tsIBrnjhSy3sqOY0EC59vkbH09ublcOEvHl7M7MLqscSYGXbQF+Odmy87l09dBWFrDG837ws6p7obMYOw9YaV2pFVu+s58JoTzWYb1QKCEa5vTc5ZLUV1UrbXEIVXTvAJKMvcBEOT+fxP3ZB2jITlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EdMfxSPy; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EdMfxSPy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5CA5F4E413E0;
	Thu, 27 Aug 2026 20:16:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2DBCE5FFF4;
	Thu, 27 Aug 2026 20:16:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3387511C78023;
	Thu, 27 Aug 2026 22:16:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787861793; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=l8Lb9EpS1n5E/7Txoa3cXFqqHf8Sd+dWZbPtUZWn3Zk=;
	b=EdMfxSPyWxbI2AQWv3TYspGuKbE84V7XGBlgs3TP6Gp5cHlGZwkz94opAB5K1gudbg8NnK
	9dyR03jjpXLWmWJpLrRaSa1KAO7m483P6YKubAz4cS6xAA6sjTlqZG9ca6j82bA1fgyUmW
	vWZajRlLOLp8CUvXaHZn54riA//zny5AmGjVtsE6X+lkplivrmYBys6ZbtsBO0xL5DF6J6
	07Rw8e1Qv9uU81Ep211hQ7f/XDroBsXgkMingHwLwCyzxHnjdn3zJZc4AHNhBGFdOtEh1u
	n2INjTbMbOWQy+eQCiGEc6RHh27+RV6w/UefQcF7wb29q6B/1sYkeL872VnHIg==
Message-ID: <5ad6cfc0-94df-4528-b2af-8a190c1eee7a@bootlin.com>
Date: Thu, 27 Aug 2026 22:16:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/6] net: stmmac: More selftest related fixes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Minda Chen <minda.chen@starfivetech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jan Petrous <jan.petrous@oss.nxp.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Jose.Abreu@synopsys.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
 <20260827105312.34f58822@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260827105312.34f58822@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On 8/27/26 19:53, Jakub Kicinski wrote:
> On Wed, 26 Aug 2026 16:04:52 +0200 Maxime Chevallier wrote:
>> This series addresses some (but not all) issues found while running the
>> ethtool selftest on various stmmac platforms. As a reminder, ethtool
>> selftest are run with 'ethtool -t ethX', and for stmmac the goal is to test
>> hardware features and bugs from the IP integration in the platform.
> 
> LGTM, please double check if any of the Clashiko complaints are
> worthwhile, and if so - follow up:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826140500.616466-2-maxime.chevallier@bootlin.com

Thanks, the things raised by AI reviews are correct, and I indeed am working
on addressing that. That's follow-up material indeed.

The main thing AI points points about the UC filter is "but won't we hit UC
promisc sooner ?" and the answer is yes absolutely, but it's the right thing
to do.

I've got some information from Synopsys on a way to discover the US filter
list, and the followup is on its way to get proper unicast filtering on
dwmac4, stay tuned :)

Maxime
