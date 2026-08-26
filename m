Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD832E73E
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775692; cv=none; b=NeQNnvan6BqfaoXxM0SxStoPa1Dv4l5DCTK/PRemOIPp3HIkT2vLcmgBf2Vn+zhBBZqoV65ZInXjQRO5I6Q7HhbdN3VvwZRSV3U1hZdSFQ/eyZHcv3Ood9W5BmTmVJbBhhGDcP6L9b1nqEOG6I3AhIXPs5ES0e/vKyAREQaAI9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775692; c=relaxed/simple;
	bh=r50cs7cyEwPF22RQn0Qdv3qMxYb1QK0YLWkwntRynGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEB6F7ZZ7l66jdwnmY5EAZPEZ1/A+I8bTxM688aj6jOEULqidjTIqBvo/ZGKhRCK2dhWjqb1S5spvoPtAVtx8Fqqva+FgGCTnLSYFV/15HZU2ti3D+5GeMyzHnua9pFg2yjwvKYZdDoJ5hmSA4YKBB8Q2N0fIV21Oq/6R6vQ2sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mPQO1TWF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mPQO1TWF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7AC9E1A1855;
	Wed, 26 Aug 2026 20:21:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D138604EC;
	Wed, 26 Aug 2026 20:21:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77C4E11C78051;
	Wed, 26 Aug 2026 22:21:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787775681; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=WdpTyq69Boh4sfFI0ncdXQ0Jc3N1BIqYeosTDp1ugnc=;
	b=mPQO1TWFVonLXpi0pQFbfd2oAeWDjfgTtSna+jJbEtB0qfjCq9ygGB96uYAe4VqdPrgcJD
	LjbjxOCNREvLUNpsYzqKJco7ckDkuXEnqXUNDylTU157UtSlanTFKfXOAIqXWZqSCUMpEQ
	GJJd9XXSRPBFtQpK5QQOJ2VFIpzU8vGHwtF/iSUR8VBq2v+BbMr5218qozparMVyt3C09Z
	c5zk1jkJ9QEFJprtezFXGHM6z8zUQ9W1k4dKDgi/W+FeyycNDyYLehyv84IQjxY7qg2zo+
	qLrBiZ/KX7SNgVjjnR0EF+g0mjte0Gmp6cZMthWyt+4L4jDFgN8tobfJbVZJmw==
Message-ID: <94fa6385-45ff-43d9-bed7-4bbc8b12088a@bootlin.com>
Date: Wed, 26 Aug 2026 22:21:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/6] net: stmmac: selftests: Account for the UC filter
 list for filtering tests
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
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
 <20260826140500.616466-6-maxime.chevallier@bootlin.com>
 <0a27797f-f7de-4e56-81d5-72571846c3ec@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <0a27797f-f7de-4e56-81d5-72571846c3ec@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 8/26/26 20:25, Andrew Lunn wrote:
> On Wed, Aug 26, 2026 at 04:04:57PM +0200, Maxime Chevallier wrote:
>> On dwmac, one of the Unicast filter entries is used to store the local
>> HW addr. This means that we have to use promisc mode for any kind of
>> unicast filtering if we only have one slot in our unicast filter.
>>
>> The number of slots available depends on how the IP is integrated, and
>> we can't autodiscover how many of these slots we have available, so
>> the DT property snps,perfect-filter-entries can be used to specify how
>> many are available.
>>
>> Most IP variants default to 1 if this isn't specified, which is the case
>> for the amlogic variants (in this case, S905X3).
> 
> Do you have this hardware? Did you try increasing the DT property to
> find out how many slots it actually has?

I do have the HW, but I haven't tried figuring the actual number of slots,
there's the same issues on lots of devices actually.

The platform I'm using for that is the Banana Pi M5, not too expensive
(that is, if we compare that with other SBCs)

> Maybe a nice little project for a newbie which has some stmmac
> hardware. Write some code which adds MAC addresses and reads them back
> again. Determine at runtime how many slots there actually are.

Exactly, that thought also crossed my mind, that would be fairly easy to
implement and with a net benefit :)

> 
>> Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew

Thanks for reviewing all of this,

Maxime

