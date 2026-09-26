Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57182EEE69;
	Sat, 26 Sep 2026 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790390084; cv=none; b=KLeUF0JP0USl7YelRGeqNxo/Jrp6ndnFcRa7cg+s+sXnEsynrL1ecazUOz5duFSAPLp9V0jVlmepVWERe28fo218dl4p9x7lIJxcDxYBwbjzsgq4hcFQSwzaaXoxNcG/cuTT9QwK0NO7+0SLGg1v/78BwNCaUKwe1BJFa6pOvKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790390084; c=relaxed/simple;
	bh=kPrslaKs7J76Ht6EgOaToO1kRT7dA4shyNwvXVA38Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rR9rONQLJXYBXNKaQNxcwtVd7iw8aPzfI6qD35pcxbJcqDAi3AQdylznb9VgaPogIiV+BtUiO29OEC3R1HAc3C1huObjafr91Fv5woW5W44/EwLmrI+mvZ8c5D6MY+OtBEdoPA7iuep06L6r4Qj4phgVpYF0L4//na+VME6IUvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx2a/1Dp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx2a/1Dp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F261F00893;
	Sat, 26 Sep 2026 02:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790390082;
	bh=TrmUNAIogKRuTOo/lPLenrabqEw90HJDpO+NJL1cgzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mx2a/1DpQTKaFYno5ZlLccON7y/9vRXnvAnNzdkK4VK6mZUHQZjY1VZqCTG+h4QxA
	 XhpKqys57I8MxSIoTjvwWTv+Y6eKO30I8puJQ7AH1GX55urFAqgz3UwxIK+bDgIR8Y
	 86HsjfpF4ZEOAxPk6L0I5putX5HQ7/88/4qSUiPQo6jfKHDRN2sU6RDdsN4EyriDqp
	 vGkwv2JlU9wqFTFQbm4Z601E6HO8ERRU7RjalRi7cQPyAxSB9rVprhegJ109O1hhjm
	 Tl62gqn/p0Saq1j/RU+cFECfyl1rNzTBCin8nnyYfot3WHaXB7Ipq55vQpX9Qq8rLF
	 MqpFNqRWyr9dw==
From: Jakub Kicinski <kuba@kernel.org>
To: arouhi@sitime.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	ivecera@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cjubran@nvidia.com,
	pabeni@redhat.com,
	Oleg.Zadorozhnyi@devoxsoftware.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	dev@kael-k.io,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 03/14] dpll: add basic SiTime SiT9531x support
Date: Fri, 25 Sep 2026 19:34:41 -0700
Message-ID: <20260926023441.1567546-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201108.42676-4-arouhi@sitime.com>
References: <20260921201108.42676-4-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dpll: add basic SiTime SiT9531x support

This commit adds a basic I2C driver for the SiTime SiT9531x clock
generators. It uses a paged regmap range configuration and adds register
access helpers. Probe gets the xtal rate, takes the optional reset GPIO and
identifies the variant from page 0 offset 0x02.

> diff --git a/drivers/dpll/sit9531x/Kconfig b/drivers/dpll/sit9531x/Kconfig
> new file mode 100644
> index 0000000000000..c306d1dd1c58a
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config SIT9531X_DPLL
> +	tristate "SiTime SiT9531x DPLL driver"
> +	depends on I2C && NET
> +	select REGMAP_I2C

[Severity: Low]
At this commit, can SIT9531X_DPLL build anything unless some other driver
selects DPLL?

The only way kbuild enters drivers/dpll/ is through drivers/Makefile:

    obj-$(CONFIG_DPLL)		+= dpll/

DPLL is a hidden bool that has no prompt. If SIT9531X_DPLL is the only DPLL
user in a config, the line

    obj-$(CONFIG_SIT9531X_DPLL)	+= sit9531x/

is never evaluated, and no sit9531x object or module gets built.

A later commit in the series, "dpll: sit9531x: register DPLL devices and
pins", adds select DPLL, and the v10 notes say the move is deliberate. So
this only affects build coverage and bisection at this intermediate commit.

[ ... ]

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> new file mode 100644
> index 0000000000000..cf1cda87fa52c
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/core.c

[ ... ]

> +/*
> + * Everything the device holds can change without the driver writing it,
> + * so nothing here is cacheable -- except the page selector, which only
> + * this driver moves.  Caching that one spares a read of it before every
> + * access: the range code selects the page through a read-modify-write,
> + * and with no cache that read goes to the bus each time.
> + */
> +static bool sit9531x_volatile_reg(struct device *dev __maybe_unused,
> +				  unsigned int reg)
> +{
> +	return reg != SIT9531X_PAGE_SEL;
> +}

[ ... ]

> +const struct regmap_config sit9531x_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
> +	.max_register	= SIT9531X_RANGE_OFFSET +
> +			  (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,
> +	.ranges		= &sit9531x_regmap_range,
> +	.num_ranges	= 1,
> +	.volatile_reg	= sit9531x_volatile_reg,
> +	.cache_type	= REGCACHE_MAPLE,
> +};

[Severity: Medium]
Can the cached page selector get out of sync with the chip, and then stay
that way?

_regmap_select_page() changes pages with _regmap_update_bits() on
selector_reg. Since 0xFF is non-volatile, the old value comes from the
cache, and the write is skipped when that cached value already matches:

drivers/base/regmap/regmap.c:_regmap_update_bits() {
    ...
		ret = _regmap_read(map, reg, &orig);
    ...
		if (force_write || (tmp != orig) || map->force_write_field) {
			ret = _regmap_write(map, reg, tmp);
    ...
}

On adapters that only support SMBus byte data, devm_regmap_init_i2c() uses
the regmap_smbus_byte bus. On that bus, _regmap_write() updates the cache
before it does the bus write:

drivers/base/regmap/regmap.c:_regmap_write() {
    ...
		ret = regcache_write(map, reg, val);
    ...
	ret = map->reg_write(context, reg, val);
    ...
}

Suppose i2c_smbus_write_byte_data() fails for the selector write. The error
comes back, but the cached value is not dropped. The raw write path in
_regmap_raw_write_impl() does drop it with map->cache_ops->drop(). The chip
then stays on page A while the cache says page B.

Would the next access to page B skip the selector write? It would then
read or write the same offset on page A without returning an error. That
could be another PLL's page (0x0A-0x0D/0x1A-0x1D) or one of the
output/system pages.

On error, sit9531x_read_u8() and sit9531x_write_u8() only log and return
rc. Nothing in the series calls regcache_drop_region(),
regcache_mark_dirty() or regcache_cache_bypass(). The sit9531x_resume()
added later only re-queues the poll worker.

Would a selector reset on the chip side also go uncorrected, for example
power loss across suspend or an internal reload?

Before v10 the selector was volatile, so a stale value was fixed on the
next access. The missing drop on the SMBus path is in regmap core, but
caching the selector here is what exposes it. The zl3073x driver uses a
similar pattern.

The comment says the selector is something "only this driver moves". Does
that still hold once a transfer fails or the chip resets?

> +/*
> + * sit9531x_read_u8 - read an 8-bit register
> + * @reg:	register in SIT9531X_REG(page, offset) form
> + * @val:	output value
> + */
> +int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,
> +		     u8 *val)
> +{
> +	unsigned int tmp;
> +	int rc;
> +
> +	reg = (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +
> +	      SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;
> +
> +	rc = regmap_read(sitdev->regmap, reg, &tmp);
> +	if (rc)
> +		dev_err(sitdev->dev, "Failed to read reg 0x%04x: %d\n",
> +			reg, rc);

[Severity: Low]
This isn't a bug, but is this message meant to print the regmap virtual
address rather than the SIT9531X_REG(page, offset) value the caller passed
in?

reg has already been rewritten at this point. Since SIT9531X_RANGE_OFFSET
equals SIT9531X_PAGE_SIZE, the printed value is exactly one page above the
regs.h encoding.

For example, a failed VARIANT_ID read, SIT9531X_REG(0x00, 0x02) = 0x0002,
is logged as "reg 0x0102", which looks like page 1, offset 0x02.

Would it make sense to keep the original value for the message? The same
applies to "Failed to write reg" in sit9531x_write_u8() below.

> +	else
> +		*val = (u8)tmp;
> +
> +	return rc;
> +}
> +
> +/*
> + * sit9531x_write_u8 - write an 8-bit register
> + * @reg:	register in SIT9531X_REG(page, offset) form
> + * @val:	value to write
> + */
> +int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg,
> +		      u8 val)
> +{
> +	int rc;
> +
> +	reg = (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +
> +	      SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;
> +
> +	rc = regmap_write(sitdev->regmap, reg, val);
> +	if (rc)
> +		dev_err(sitdev->dev, "Failed to write reg 0x%04x: %d\n",
> +			reg, rc);

[ ... ]
