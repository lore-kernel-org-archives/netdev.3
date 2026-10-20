Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465782;
	b=48oaASsl/+Bc4qlZfEJGh8mniyLvLM7XqgFxT+Nnoqcg2cbz5GOfuHnvdhMTmgKReWhH
	 7WtILAwrNJH/cG20MJZzjgPLy8Z0wu+F9dvcd+FmsNyKAS8WdQ1ZsKf1fQTc/PZKZVASc
	 Btzm0PFR48NeYa19Uz/PG4SesZQ5i+X0hVSjPaVSfG3nnxLeUUHB5U+wy/yV9mDuxVxy6
	 QdoMprsInsPrt61ny9mewHIc4t3mat2YfkwFhbtEIANwUm3S6rcOX/b+Ur/vNyNt07V12
	 tFNaEkuVIh96UEgEcOPNrl0hFxR8JTvm7UFqP30z2D8HlKLGwiZxFLHRE2qK2P0QScQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465782;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pSsfZH/67Vix+etTbU2mm68hM404RBAzMT3mtugbqvw=;
	b=WUT63o97LW6GfomnkqTGQ7mJNxnh/bEfu/pjgX5eKbmzHHRZFluKpvNliFNdswhybVfC
	 oT+D2++CJFXISf4XcS8O978EhHaFJIt2SljvF6nLIrW9EIqAeFGyugTK91tHJRWzCPj2O
	 1+RAJGGlp4N9kaHWg8UAhJSfIDue8HfRB+ptk5q6fiHXMO+GgMIDxYBXOCDeUaxh6AtNu
	 SWIxG4YrlSAHT7gNAOs+F3BhGRZS98kgxAcjx5b3oRvtCqGvih8HP1VaS/Kc135B1llIB
	 BNc8bYJCyTwxAiX3DQX19I6L5jx9gYb5yrMCbzoBmmd+3UCIsktZu8xRS5Ub8yGl6ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gHldU58j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA40E60A263F;
	Tue, 20 Oct 2026 03:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gHldU58j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EF61F000CA;
	Tue, 20 Oct 2026 03:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792465781;
	bh=pSsfZH/67Vix+etTbU2mm68hM404RBAzMT3mtugbqvw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gHldU58jDw34NUt1A5amUehuODtpwB3ovBHIefKGwDYLkFsOKGv6HiYRiAmMTwDk3
	 coOUui0+6bRGL8lQqbZAVrlLx5nSg9n2GkCo5QNuzxqyTKzmJwUeRDFkuq94jXpPdG
	 U/0sOZyccKc2myEDxf0ZLWSlVAzWp+URrImaZzR6j5jn8pdKe0l+NJ9LygUalF6PML
	 5tsaFhratMbYzWpMh4f9+VjSGUXpp8p9u8zYOSgLqmIvAhA+QoFZOCstZ4N53S/Ups
	 eLIIbwBpC2R5/fpS4W+gD7Fbx6h1t7sygRLCvOYJlaczBgfjAefS88S1GlkoBAHKbD
	 RDEHtXdnDzm7Q==
Subject:
 Re: [PATCH net-next v14 03/12] dpll: add basic SiTime SiT9531x support
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 03:09:40 +0000
Message-ID: <179246578013.3135.1593003347944416304@kernel.org>
In-Reply-To: <20261016005823.13690-4-arouhi@sitime.com>
References: <20261016005823.13690-4-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The binding
  (Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml)…
- [Medium] The page-selector cache recovery does not cover every case.
- [Low] In sit9531x_dev_probe(), the XIN/XO reference is enabled with
  devm_clk_get_optional_enabled() (line 227) before the reset GPIO is…

--

dpll: add basic SiTime SiT9531x support

This adds an I2C driver for the SiTime SiT9531x clock generator. It has a
paged regmap configuration and page:offset register accessors. Probe reads
the XO rate, releases the optional reset line and identifies the variant
from page 0 offset 0x02.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> new file mode 100644
> index 0000000000000..20ccf024077bc
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

> +int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,
> +		     u8 *val)
> +{

[ ... ]

> +	rc = regmap_read(sitdev->regmap, vreg, &tmp);
> +	if (rc) {
> +		sit9531x_page_cache_drop(sitdev);

[Severity: Medium]
Does this recovery still work when something other than these accessors
uses the map?

The selector is the only cached register, so _regmap_select_page() skips
the selector write when the cached page already matches. _regmap_write()
also updates the cache before the bus write and does not roll it back on
failure:

drivers/base/regmap/regmap.c:_regmap_write() {
    ...
	if (!map->cache_bypass && !map->defer_caching) {
		ret = regcache_write(map, reg, val);
    ...
	ret = map->reg_write(context, reg, val);
    ...
}

So a failed selector write leaves the cache at page P while the chip
stays on page Q.

sit9531x_page_cache_drop() only runs after regmap_read() has released
map->lock, and regcache_drop_region() then takes the lock again. Could
another map user take map->lock in that window, trust the stale page P,
and access page Q?

Map users that bypass sit9531x_read_u8(), sit9531x_write_u8() and
sit9531x_update_pll_u8() never drop the entry. For example,
regmap_read_debugfs() calls regmap_read() directly and only prints 'X'
on error:

drivers/base/regmap/regmap-debugfs.c:regmap_read_debugfs() {
    ...
			ret = regmap_read(map, i, &val);
			if (ret == 0)
				snprintf(buf + buf_pos, count - buf_pos,
					 "%.*x", map->debugfs_val_len, val);
			else
				memset(buf + buf_pos, 'X',
				       map->debugfs_val_len);
    ...
}

Suppose a selector write fails while the debugfs registers file is being
dumped, and the dump stops before the next page switch. Would the
driver's next access to page P then skip the selector write and silently
read or write the same offset on page Q?

The comment above sit9531x_volatile_reg() says "every accessor drops the
entry on an error". That seems to hold only while the driver's accessors
are the only users of the map.

[ ... ]

> +static int sit9531x_dev_probe(struct sit9531x_dev *sitdev)
> +{

[ ... ]

> +	xtal_clk = devm_clk_get_optional_enabled(sitdev->dev, "xtal");
> +	if (IS_ERR(xtal_clk))
> +		return dev_err_probe(sitdev->dev, PTR_ERR(xtal_clk),
> +				     "Failed to get xtal clock\n");

[Severity: Low]
The XO is enabled here, before the steps that can defer or fail. These
include devm_gpiod_get_optional() for the reset line, which returns
-EPROBE_DEFER if RESETB sits on a GPIO expander that has not probed yet,
and the variant ID read and match.

On those paths devres calls clk_disable_unprepare() on the xtal clock.
If the XO is a gateable clock that the bootloader left running, with a
CCF enable_count of 0 before probe, does this gate the reference of a
chip that is already running from efuse or a pre-probe blob?

The PLLs would then lose lock, and the outputs would glitch or stop on
every deferral cycle until probe succeeds.

Could the resources that can defer be looked up before the clock is
enabled and reset is deasserted? For example, the reset GPIO could be
requested with GPIOD_ASIS.

[ ... ]

> +	sitdev->reset_gpio = devm_gpiod_get_optional(sitdev->dev, "reset",
> +						     GPIOD_OUT_LOW);
> +	if (IS_ERR(sitdev->reset_gpio))
> +		return dev_err_probe(sitdev->dev, PTR_ERR(sitdev->reset_gpio),
> +				     "Failed to request reset gpio\n");
> +	if (sitdev->reset_gpio)
> +		fsleep(10000);	/* internal boot after release */
> +
> +	rc = sit9531x_read_variant_id(sitdev, &variant_id);
> +	if (rc)
> +		return rc;

[Severity: Medium]
The binding in sitime,sit95316.yaml documents vdd-supply, vddin-supply,
vdds-supply and the vddo*-supply rails, and its example wires several of
them. The driver never gets or enables any regulator, and that is still
true at the end of the series.

If one of these rails is a switchable regulator that is off at boot,
sit9531x_dev_probe() releases reset and reads the variant ID over I2C
from an unpowered part. Wouldn't probe then fail?

A rail might instead be left on by the bootloader or regulator-boot-on,
without being always-on and with no other consumer. Nothing holds a
reference to it, so regulator_late_cleanup() would switch it off:

drivers/regulator/core.c:regulator_late_cleanup() {
    ...
	if (rdev->use_count)
		goto unlock;
    ...
		ret = _regulator_do_disable(rdev);
    ...
}

Would that cut power to the running clock generator? It would lose the
efuse or pre-probe configuration that the driver avoids resetting for,
and downstream consumers would lose their reference clocks.

Should probe get and enable the documented supplies before releasing
reset?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016005823.13690-1-arouhi%40sitime.com
