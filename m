Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7AD42188F
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554790; cv=none; b=acHhhNIOYw6+0B+0EIXrXR8oef4FnVCTxKgDQOz7cFtzF85M2v9V5r7I3Oz6/rdttE16KxMJ1TEuS4IcEUQ3lLsndJFMpK5X6qEuoV4H6LQgX39C8TPLeOFa44eEaKf+4hp0zdZR9p/ApHneuXfYNPms4fOpDQczL4VD+SKvRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554790; c=relaxed/simple;
	bh=hEfQm+fNIIIRf5G5yrPlpKCXyKnl5+VCOUdK6KCQ6M0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Juyv6NJvH68g2jhnEk6fI9V0ad3jRjrwFI80LDu8DB/6o4ylts+Ad/O/BhPrKklqsMKDl67uY+NfOxuUSapEhMCYs/Fmaw5Y6hYfq8KaWNIpIyST25fngaKDDCe1WudgmXWsQh56irJO9fxuliutYFLpjUhpLQV6XTuXvOH8aeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RI3vLrea; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RI3vLrea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBE91F00A3F
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 13:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784554787;
	bh=hEfQm+fNIIIRf5G5yrPlpKCXyKnl5+VCOUdK6KCQ6M0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=RI3vLreahJGAhgtlatHkOscyo71Y2LCTFvhRAwMLIIk1XNm/x5FMR9Dwsagw98QSb
	 7sV4l7YWuKlvsv/ADHoTvX6VbzeQy6aOsrGF+2mCSEnlw2dUHVuMB9qL8wvcU1c3qU
	 vemxw9+dHy1Jym9R4FaAjcU/STnSceY7lDpjKtSxt9mcg6mx/zw4CRIYYc0FFL3xqh
	 l5YU/gZw5z8l4D8NW5lYQ5SNul06GkJW2Ykuk2hWd2bX9EC5fPpbbmmswww7MRg5or
	 7zprAf5p7duqoarODjDXjTJAmWjBbPaeUCPXfSYZJaOk1PPoTQOBOmXIw1ZvBXcv5V
	 wtzDBgTWkgpbw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c923b8c2aso97129951fa.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 06:39:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrSbGkgpSgKDfr1ccZyJKJ75mvzMNgOEFOI9o/AhSf+WtnZBM2T9i8r3W/727S28t0U7VxHhpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Wby79NHFlMl7+rCSwFcW0Wt1X4dp2ijecBg/agfTFHkMbwQu
	LLwBt7lSUcOtKB4XkYa801IJSI95Ojbynlr5WrL/ff1zTMi+8psw+CehKyeQxQ8Ii7g5a4Hdc1C
	0HE5WE3y7nJPY5ac1SkbObI40c/NjN7db1zTxf0JE4w==
X-Received: by 2002:a2e:be29:0:b0:39c:a06f:12ba with SMTP id
 38308e7fff4ca-39eb294c61dmr29234131fa.40.1784554785347; Mon, 20 Jul 2026
 06:39:45 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 15:39:44 +0200
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 15:39:44 +0200
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <e4f9b266-8d9e-48fe-99c0-58b61e02c9bd@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-3-2dee93f42c54@oss.qualcomm.com>
 <e4f9b266-8d9e-48fe-99c0-58b61e02c9bd@arm.com>
Date: Mon, 20 Jul 2026 15:39:44 +0200
X-Gmail-Original-Message-ID: <CAMRc=MefqCMgVv-o5hWoRwS2iXPQNs5nH2qHiz55+ew162LfSA@mail.gmail.com>
X-Gm-Features: AUfX_mzO2mZAcAjFU14cJl1wZGPQmD5GzWNsNbZLHTzrF2PNrvf-Va6RwZ7OmuY
Message-ID: <CAMRc=MefqCMgVv-o5hWoRwS2iXPQNs5nH2qHiz55+ew162LfSA@mail.gmail.com>
Subject: Re: [PATCH 3/8] iommu/fsl: use platform_device_set_fwnode()
To: Robin Murphy <robin.murphy@arm.com>
Cc: brgl@kernel.org, driver-core@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Srinivas Kandagatla <srini@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jul 2026 14:58:27 +0200, Robin Murphy <robin.murphy@arm.com> said:
> On 20/07/2026 10:24 am, Bartosz Golaszewski wrote:
>> Prefer the higher-level platform_device_set_fwnode() over the
>> OF-specific platform_device_set_of_node() for dynamically allocated
>> platform devices.
>
> This is very much non-portable code specific to OF-only platforms, but
> if the intention is to remove platform_device_set_of_node() again
> already, then FWIW,
>

Providing platform_device_set_of_node() and using it was done to make the
transision to expanding reference counting to all firmware nodes possible.
I don't think we'll remove it just yet as it doesn't make sense to convert
the code under drivers/of/ to using the fwnode variant.

> Acked-by: Robin Murphy <robin.murphy@arm.com>
>
> (Although I'm slightly puzzled by the cover letter - AFAICS in -next,
> platform_device_set_of_node() is itself very much a user of
> platform_device_set_fwnode(), however in terms of symbol exports,
> perhaps the former could now just be a static inline wrapper?)
>

Sure that can be done independently later.

Bart
