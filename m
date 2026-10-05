Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE7227E074;
	Mon,  5 Oct 2026 01:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791162599; cv=none; b=kVYjI9l6MQr0CWUT1alexpWpMaZ7WDDDvuuTSnquRFANlFOLqGPDMpn4m00+PPtyfR2owJm848o8JIkoBMKc/5lUJImTBLmUJIr6VCnvlW3kO6Nkhq40Yiy6fVVmint5mP0B6IFOEogPx2TbBj6S8AiDzE1oAWtLazL3YcK2oRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791162599; c=relaxed/simple;
	bh=kUAlBVmp3Xfj14LuKSTZwYZq1Hirs9fzPRNQ3nsJ9Wo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uKVAlETUKU5eOp+H7rrl8Mi2MZlgLlnDHY73UjieCY6aeEvHQNscG1GEZnIDbBR9kjREtbNyrh7CkKIDfn1K1qhDalYsnhUc9J0gZGZ0ioHxZgG//acCxw0PbaYWKOg8aWJQactVwoHvkTKIG+6hvvkE3WjmKIqdWpBRDqZphwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tfrvl7Jh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tfrvl7Jh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99901F00893;
	Mon,  5 Oct 2026 01:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791162597;
	bh=pyjt3R1kDuaBwqy0eNkSERMkV2VeL+/U1SVPczRgaTk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Tfrvl7JhDPkqzFVhx7uDZC5T/XrhCCOgnsuPqMe/JajPtEoDSQclRfKsMkJByQQZy
	 S/kYTfSGKkkeGUnFzw/C57enIlEiaYIXceYx1mABOsH+/f+V3wMp49aKJyzGUq1+uD
	 WKRNlVasOScfjVcoyYUNpYg6gwsR7Vb0Itd+Afly3Gnq8H6uU0tf95R1eYo/f33oAp
	 2q9GURP6xNGzPEw2hbjDAoXit9WXGd6f7xQxJLgWWmeAxfc2yNiVsGaZlCuOLHoCJq
	 ximD03ZKWGk3Ezy0DLRN3ckzYVfDfHiduYy94oAtoT4pFt+rRX4qn0+mODpWg8h/t7
	 2Wjm6mI2YbeiA==
Subject:
 Re: [PATCH net-next v11 04/13] dpll: add basic SiTime SiT9531x support
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 01:09:56 +0000
Message-ID: <179116259637.434549.13673583471206119318@kernel.org>
In-Reply-To: <20260930233714.87679-5-arouhi@sitime.com>
References: <20260930233714.87679-5-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In drivers/dpll/sit9531x/core.c, the page selector (physical
  0xFF) is the only cached register: sit9531x_volatile_reg() returns…

--

dpll: add basic SiTime SiT9531x support

This adds the first I2C driver for the SiTime SiT9531x clock generator.
It sets up a paged regmap with the page selector at offset 0xFF, so the
register accessors address a register by page and offset. Probe reads
the crystal rate, takes the optional reset GPIO and identifies the
variant from page 0 offset 0x02.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> new file mode 100644
> index 0000000000000..c7c14442df922
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -0,0 +1,320 @@

[ ... ]

> +/*
> + * Everything the device holds can change without the driver writing it,
> + * so nothing here is cacheable except the page selector.  Caching that
> + * one spares a read of it before every access: the range code selects
> + * the page through a read-modify-write, and with no cache that read goes
> + * to the bus each time.
> + *
> + * The cached value is only as good as the last transfer, though.  A
> + * transfer that fails can leave the part on another page than the cache
> + * records, so every accessor drops the entry on an error and the next
> + * access reads the selector again.
> + */
> +static bool sit9531x_volatile_reg(struct device *dev __maybe_unused,
> +				  unsigned int reg)
> +{
> +	return reg != SIT9531X_PAGE_SEL;
> +}

[ ... ]

> +static void sit9531x_page_cache_drop(struct sit9531x_dev *sitdev)
> +{
> +	regcache_drop_region(sitdev->regmap, SIT9531X_PAGE_SEL,
> +			     SIT9531X_PAGE_SEL);
> +}

[ ... ]

> +	rc = regmap_read(sitdev->regmap, vreg, &tmp);
> +	if (rc) {
> +		sit9531x_page_cache_drop(sitdev);
> +		dev_err(sitdev->dev,
> +			"Failed to read page 0x%02x reg 0x%02x: %d\n",
> +			SIT9531X_REG_PAGE(reg), SIT9531X_REG_OFFSET(reg), rc);

[Severity: Medium]
Does dropping the cache entry on error keep the cached page selector in
sync with the chip? The comment above sit9531x_volatile_reg() says it
does, but some paths seem to be missed.

_regmap_select_page() sets the selector with
_regmap_update_bits(..., force=false). When the cached value already
matches the target page, no selector write reaches the bus. With a stale
cache entry, the access goes to whatever page the chip is really on, and
the I2C transfer still succeeds.

The first case is an adapter that only supports SMBus byte data. There,
regmap_get_i2c_bus() picks regmap_smbus_byte, so map->reg_write is
_regmap_bus_reg_write and defer_caching is false. _regmap_write() then
updates the cache before the transfer:

drivers/base/regmap/regmap.c:_regmap_write() {
    ...
	if (!map->cache_bypass && !map->defer_caching) {
		ret = regcache_write(map, reg, val);
    ...
	ret = map->reg_write(context, reg, val);
    ...
}

_regmap_bus_reg_write() does not invalidate the entry when the transfer
fails. A failed selector write therefore leaves the cache at page N while
the chip stays on page P.

sit9531x_page_cache_drop() only runs after regmap_read(), regmap_write()
or regmap_update_bits() has returned and released map->lock. Other
regmap users, such as the regmap debugfs registers file, can see the
stale entry in that window.

If the failed selector write happens inside a debugfs read, nothing
drops the entry at all. Can the next sit9531x_write_u8() to page N then
land on page P without any error?

Adapters with full I2C support use the raw path. They look safe, because
_regmap_raw_write_impl() drops the cache under the lock when a write
fails. Later patches in the series also put the driver's own runtime
accessors under multiop_lock. So only regmap users outside the driver,
such as debugfs, can reach that window.

The second case is a selector change with no I2C error at all. Examples
are RESETB driven by board logic or a BMC, a brown-out, or an NVM reload.
The chip comes back on page 0 while the cache still holds the old page.

A later patch in the series drops the entry on resume. Nothing covers a
reset the driver cannot see, though. After one, could writes meant for
the PLL pages 0x0A-0x0D go to page 0 instead?

Would it be simpler to make SIT9531X_PAGE_SEL volatile as well?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930233714.87679-1-arouhi%40sitime.com
