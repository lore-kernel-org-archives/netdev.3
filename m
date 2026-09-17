Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E18395ADC;
	Thu, 17 Sep 2026 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657320; cv=none; b=tlLRiDUPKxPTyCKR2PZHH0JdwcJ1GyDVqLXzMtEt0gRvqyZ8qXMdfYidQ2gfN3NBpXonkMWZMBawswByVwBNCZjvp9SPgsPZBefs6/YT0Y1vCjvi4Ar2JHZho5rUMebAA5RQKlxWqVejwQn97W+P7B97FMclxSrTkZZI+ogB3QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657320; c=relaxed/simple;
	bh=ix15bFL9Nbrzoh6TuLe5wL2dLS8gcMcX0ULpJUe8rVA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S4iu2A4nUolG9rJe+yyinn9nwGo3FW0Lal3i1BPLaKrtniZ7IVD0yRDAxbVlrg3xkDilQrwnMnefSZoiatCwpA3WOOsRH6N/99Ij1Um+tbONwUs7he/U5/kbHeonS4kEOlHCOeJnQOnTFw7XDC01YJ7ajWHkHSUYCTaj7IbAlJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6Q6XOiT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6Q6XOiT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F2B1F000FF;
	Thu, 17 Sep 2026 15:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657305;
	bh=N5ijipPKhI22toyPEQvQT9IaVzaFvP6ZSrzXiHMQeAo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C6Q6XOiT8D6e7ugQOHvD+InWhk1Zmw71Br3GJNU2EOwKU0/pkR1WBMvdvIWY80RI6
	 Zf2ja1kiSUSdL4edC7VabrNcChDoQA8lRKQkCX1z8qeXQH70ZNCPCb/AeolUzZL46a
	 cUp+csvnLak8pn05mW7n0ArDTtARSQoqsLRfV8VgV6Hn7SAqGhuq25xxz+C9qcGUDn
	 d1UYTmQNOPGNzw64k93vGGWRmgykW9vMEIxpnDKgMt14kaAY+vw7j0kuhSHnAhLuWx
	 RfNkKQH+yKBZrT/NbtwenXYSrTwHfc1X7VTtxo7e5tGLL59hj7mfcctaD29+c8pcrn
	 HkT5v35K+sing==
Subject: Re: [PATCH net-next v9 03/15] dpll: add basic SiTime SiT9531x support
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 pabeni@redhat.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 17 Sep 2026 15:01:43 +0000
Message-ID: <178965730379.22033.17893102954216395676@kernel.org>
In-Reply-To: <20260915000015.80480-4-arouhi@sitime.com>
References: <20260915000015.80480-4-arouhi@sitime.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] The user-visible Kconfig help for SIT9531X_DPLL states the driver
  "registers each on-chip PLL as a DPLL device and exposes input/output…

--

dpll: add basic SiTime SiT9531x support

Adds the first piece of a SiTime SiT9531x driver: an I2C driver with a
paged regmap configuration, page/offset register helpers, XO rate
lookup, an optional reset line and variant detection from the ID byte
at page 0 offset 0x02.  No DPLL objects are registered yet.

> diff --git a/drivers/dpll/sit9531x/Kconfig b/drivers/dpll/sit9531x/Kconfig
> new file mode 100644
> index 0000000000000..47aea8674327c
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config SIT9531X_DPLL
> +	tristate "SiTime SiT9531x DPLL driver"
> +	depends on I2C && NET
> +	select DPLL
> +	select REGMAP_I2C
> +	help
> +	  Driver for SiTime SiT9531x family clock generators
> +	  (SiT95317, SiT95316).
> +
> +	  This driver registers each on-chip PLL as a DPLL device
> +	  and exposes input/output clocks as DPLL pins, providing
> +	  runtime configuration via Generic Netlink.

[Severity: Low]
This isn't a bug, but the help text describes behaviour that does not
exist yet at this commit.  Nothing in this patch includes a DPLL header
or calls a dpll_*() function, and select DPLL pulls the DPLL core in for
a module that does not use it.

Would it be worth moving the "registers each on-chip PLL as a DPLL
device ... via Generic Netlink" paragraph and select DPLL to the patch
that actually performs the registration, so the visible config option
matches the code at every step of the series?

For the record, this resolves later in the series: the final tree adds
dpll.c and prop.c, sit9531x_dpll_device_register() calls
dpll_device_register(), and sit9531x_dev_probe() ends with
sit9531x_devm_dpll_init(), which makes the help text accurate again.

> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sit9531x.
> diff --git a/drivers/dpll/sit9531x/Makefile b/drivers/dpll/sit9531x/Makefile
> new file mode 100644
> index 0000000000000..a221fe55386a9
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_SIT9531X_DPLL) += sit9531x.o
> +sit9531x-y := core.o
> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> new file mode 100644
> index 0000000000000..b0920f76362a1
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -0,0 +1,272 @@

[ ... ]

> +	dev_info(sitdev->dev, "%s detected, %u inputs, %u outputs\n",
> +		 sitdev->info->name, sitdev->info->num_inputs,
> +		 sitdev->info->num_outputs);
> +
> +	return 0;
> +}

Related to the Kconfig comment above: sit9531x_dev_probe() returns right
after the dev_info(), so a device tree node describing dpll-types,
input-pins and output-pins binds successfully with no DPLL device and no
netlink interface, and without any message saying so.  Is a note in the
help text or the commit log about this intermediate state wanted?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915000015.80480-1-arouhi%40sitime.com
