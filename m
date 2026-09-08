Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8CB53ED05;
	Tue,  8 Sep 2026 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871512; cv=none; b=azwJUyaVL/V5oxa58AWka86wA0Smwc7c94l/Smpa1aA/nJYlzW16z4JaHX1AOsCt1lhBo+qNyHzrSrz1DOolPs9v5zL2v01vkpW8WpLY9sHqA0sOxQQE0gBzcKDl83u1S1gB6CKkjY25o+W5a6WQ8GZulYWElJAp7kgRyQ6m+kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871512; c=relaxed/simple;
	bh=gTJ9TAWLbdvyZj/BP6wl6ZmdUcvj9W+KiE4Oma8ekRE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dQT0LBCdKUn26J9A6Q8j+RtCeAA/aIrozH361MTu7yiVWab2Uu1DZchRwHfap4KUWMEd8qiDBlnSkHlgCLM8fkzDsYk4q+8HbvJim+lIlT24iR/j7dr7hJuRk5D6eF9gdgL5RdHMKXq06XEKRts/7vYR6P0okjnK8pT7XsXli5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG1ICh2O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG1ICh2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CD51F00A3A;
	Tue,  8 Sep 2026 12:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871511;
	bh=LQVytSftYxd09iH3+y3+/WJxm3kNzisXB5swAaixbwQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HG1ICh2ONyaaajhlyubCViOgbkMcYGox7trdugIb0+rP9q3UME3eWwbvbGNgTORja
	 9dHaA9uAfHgI3apnKoCqBWLwQYUGxJDMIPLyIqae3XPpqQLHEbc5FasW+oT55HMVW9
	 zN4hTxa3rlHZEV7h7hq6Bgth4Owd0VBwa7THo+uYuoEVV3p9WNLIihvieyrAJd9sfJ
	 R2yR/Tt3MsRevIKcPmeDOeFcPI7+kXYHUKK6X6NuIclYwhrFI4wInB2641V4glPz4b
	 sq61lhAaOWl9PBUO7kF5MiSnaQcDSSqtuw7c9Yvz36zYxiO2qjC3SqSfg9EvOXsv6C
	 mjB9jtLoHM8NA==
Subject: Re: [PATCH net-next v8 03/15] dpll: add basic SiTime SiT9531x support
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 08 Sep 2026 12:45:10 +0000
Message-ID: <178887151007.219967.1063342347409203849@kernel.org>
In-Reply-To: <20260902214030.20955-4-arouhi@sitime.com>
References: <20260902214030.20955-4-arouhi@sitime.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] Orphan kernel-doc-style block for `sit9531x_input_get_regs()` in
  drivers/dpll/sit9531x/core.c (lines 147-155) documents a function that…
- [Low] The Kconfig help for SIT9531X_DPLL advertises DPLL device
  registration, DPLL pin exposure and Generic Netlink configuration, and…

--

dpll: add basic SiTime SiT9531x support

This adds the initial SiTime SiT9531x I2C clock generator driver: a paged
regmap configuration for the 32x256 register space selected through offset
0xFF, page/offset register access helpers, and a probe that fetches the
xtal rate, takes the optional reset line and identifies the chip variant.

Two small observations below, both cosmetic.

> diff --git a/drivers/dpll/sit9531x/Kconfig b/drivers/dpll/sit9531x/Kconfig
> new file mode 100644
> index 000000000000..47aea8674327
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
This isn't a bug, but the help text describes behaviour that only arrives
later in the series.  At this commit sit9531x_dev_probe() stops after
identifying the variant:

	dev_info(sitdev->dev, "%s detected, %u inputs, %u outputs\n",
		 sitdev->info->name, sitdev->info->num_inputs,
		 sitdev->info->num_outputs);

	return 0;

There is no dpll_device_register() or dpll_pin_register() call yet, and
select DPLL has no consumer, so enabling CONFIG_SIT9531X_DPLL at this point
in the series binds the I2C node without exposing any DPLL object.

The later patches in this series do add the DPLL device and pin
registration, so the help text matches the final state of the series;
should the Kconfig entry land with the patch that implements it instead?

[ ... ]

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> new file mode 100644
> index 000000000000..f355b08aebca
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/core.c

[ ... ]

> +/*
> + * sit9531x_input_get_regs - get force mask and state register addresses
> + * @index:	logical input index
> + * @force_reg:	output force mask register address
> + * @state_reg:	output state register address
> + *
> + * Selects the correct Page 0x02 register pair based on the pair's
> + * signal mode and the lane (P/N) the index refers to.
> + */
> +
> +static int sit9531x_read_variant_id(struct sit9531x_dev *sitdev, u8 *id)
> +{
> +	return sit9531x_read_u8(sitdev, SIT9531X_REG_VARIANT_ID, id);
> +}

[Severity: Low]
This isn't a bug, but the comment block for sit9531x_input_get_regs()
describes a function that does not exist in this patch, and it sits
directly above the unrelated sit9531x_read_variant_id().  A reader here
would attribute the Page 0x02 register-pair semantics to the variant-ID
helper.

The function it documents is added later in the series, by "dpll:
sit9531x: implement input pin state on a DPLL", where it appears right
under this same comment.  Could the comment move to that patch?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902214030.20955-1-arouhi%40sitime.com
