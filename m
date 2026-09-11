Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E340E25785C;
	Fri, 11 Sep 2026 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170670; cv=none; b=dW7le9W7twKlYWipKN+TdGku/jmsFiZ+ynYyiAlfHDOIwPRuwuGoKEmOW0l0GP5SyZelyt6pmipYxgPjnL/XTWeojx89aw+ev8rd2mWSj07kwjoZx8CkIZQ2SqCVnbpMvJ12GdmFPqx/e3O8NcoUMDqnXrP6ktX6iN1Rhg9Bwn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170670; c=relaxed/simple;
	bh=IUS5WJQdiAEBj/LdHCq0xjx/QN5LEhqbjB79Wd7bzXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWO7LqOVgJjiznsbmnUsv92+CQx3vqhhzRkShP2ZC9yPCPM42gM2Yy8rmZq25Yaati/uDyQFq9QoWcRy7HR10WpjdaV8GapUBNsIgMwzbm8u+C+/PO+KO9D2uO1EsA6I7nj46gaN84I99BLO8K3FbeJbNQwcycnjmoJpCSV6USA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuQZ5HCc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuQZ5HCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D09D1F000FF;
	Fri, 11 Sep 2026 23:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789170666;
	bh=UKt+O3M6EwxS0tzT2K5pDYKz3LjffUs1mG8JgxdATIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SuQZ5HCc8RNNNnDcSIYIBI1erXi3nD3QKgUAargDJ9ke+rjD6WaAzRQ4oxZRoAJaV
	 PGiIKqTNoqQ/PuaQX6DS4AS05G2vTgZ3dEbXYz8GifCv1jODnBsQZaTzV2cTdzTvoF
	 yUDkyCA21tdnIzUo6sri3UnRO2Jc8EzKJEDrbK8EO8sQDFK/f4pp3bXs5NCazZXgvI
	 xmY6z3Lg60ClR37lm+SovjMNXv1r/3n12CX4wov9n0s1+m5ImWmMBZBCGyf48nPMjJ
	 AzKhQbJMHf5qtkwKPvpO41LTog9+yOEVzAu9fDa6xn7mSmxffL/ngqP5ITUKPoBFHH
	 YHK+lQYApzllA==
Date: Fri, 11 Sep 2026 16:51:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v13 2/2] ptp: ocp: add TAP CPLD firmware upload
 for ADVA TimeCard X1
Message-ID: <20260911165105.4235aa04@kernel.org>
In-Reply-To: <20260908122328.52641-3-maimon.sagi@gmail.com>
References: <20260908122328.52641-1-maimon.sagi@gmail.com>
	<20260908122328.52641-3-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Sep 2026 15:23:28 +0300 Sagi Maimon wrote:
> The Lattice MachXO3 CPLD on the ADVA TimeCard X1 is programmed over I2C
> using in-system programming (ISP).  Build on the TMC bus arbitration
> added previously and expose the update path through the kernel
> firmware-upload subsystem.
> 
> The framework acquires the bus, erases the configuration flash, programs
> the image page-by-page and activates it with the MachXO3 REFRESH
> command.  The upload node is registered per card as adva-cpld.N, using
> the same index as the owning ocpN device, so a host with more than one
> X1 board gets one node each:
> 
>   /sys/class/firmware/adva-cpld.N/
> 
> The whole prepare/write/poll_complete/cleanup sequence runs under
> cpld_lock and the i2c adapter lock, so an EEPROM read blocks for as long
> as programming takes; the alternative is reading the TMC bus instead.
> The upload is unregistered first on detach, which cancels and flushes an
> in-flight programming cycle while the I2C controller is still up.
> 
> Select FW_LOADER and FW_UPLOAD, as the documented update path does not
> exist without them.

Why add another FW flashing interface when the device already supports
devlink flash? You can use component names to disambiguate which FW we
are targeting.
